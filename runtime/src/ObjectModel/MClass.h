// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_MCLASS_H
#define MRT_MCLASS_H

#include <functional>
#include <mutex>
#include <unordered_map>

#include "Base/AtomicSpinLock.h"
#include "Common/TypeDef.h"
#include "MethodInfo.h"
#include "FieldInfo.h"
#include "Flags.h"
#include "PackageInfo.h"

namespace MapleRuntime {
class ExtensionData;
constexpr U8 BITS_FOR_REF = 1;
constexpr U8 REF_BIT_MASK = 1;
constexpr U64 SIGN_BIT_64 = (U64)1 << 63;
constexpr U16 INVALID_INHERIT_NUM = (1 << 15) - 1;

union MTableBitmap {
    using LargeBitmap = std::pair<U32, U8[]>;
    U64 shortBitmap;
    LargeBitmap* largeBitmap;
    U64 tag;

    void ForEachBit(const std::function<void(ExtensionData*)>& visitor, ExtensionData** vExtensionPtr)
    {
        bool isSmallBitmap = tag & SIGN_BIT_64;
        if (isSmallBitmap) {
            U64 bitInfo = shortBitmap & (~SIGN_BIT_64);
            while (LIKELY(bitInfo != 0)) {
                if (bitInfo & 0x1) {
                    visitor(*vExtensionPtr);
                }
                bitInfo >>= 1;
                ++vExtensionPtr;
            }
        } else {
            U8* bitmaps = largeBitmap->second;
            for (U32 i = 0; i < largeBitmap->first; ++i) {
                U8 bitInfo = bitmaps[i];
                while (LIKELY(bitInfo != 0)) {
                    if (bitInfo & 0x1) {
                        visitor(*vExtensionPtr);
                    }
                    bitInfo >>= 1;
                    ++vExtensionPtr;
                }
            }
        }
    }
};

struct MTableDesc {
    std::unordered_map<U32, FuncPtr*> mTable;
    MTableBitmap mTableBitmap;
    std::recursive_mutex mTableMutex;
    bool pending = false;
    explicit MTableDesc(U64 bitmap_) { mTableBitmap.tag = bitmap_; }
    MTableDesc() = delete;
};

typedef TypeInfo* (*GenericFunc)(TypeInfo**);
struct ShortGCTib {
    U64 bitmap; // lower 63 bits are valid, each bit indicates 8-byte width, 1:ref, 0:no-ref

    void ForEachBitmapWord(MAddress fieldAddr, const RefFieldVisitor& visitor) const
    {
        U64 gcInfo = bitmap & (~SIGN_BIT_64);
        while (LIKELY(gcInfo != 0)) {
            if (gcInfo & REF_BIT_MASK) {
                visitor(*reinterpret_cast<RefField<>*>(fieldAddr));
            }
            gcInfo >>= BITS_FOR_REF;
            fieldAddr += sizeof(RefField<>);
        }
    }
    void ForEachBitmapWordInRange(MAddress baseAddr, const RefFieldVisitor& visitor, MAddress rangeStart,
                                  MAddress rangeEnd) const
    {
        U64 gcInfo = bitmap & (~SIGN_BIT_64);
        U32 startPos = (rangeStart - baseAddr) / sizeof(RefField<>);
        gcInfo >>= startPos;

        MAddress fieldAddr = rangeStart;
        while (LIKELY(gcInfo != 0)) {
            if (fieldAddr >= rangeEnd) {
                return;
            }
            if (gcInfo & REF_BIT_MASK) {
                visitor(*reinterpret_cast<RefField<>*>(fieldAddr));
            }
            gcInfo >>= BITS_FOR_REF;
            fieldAddr += sizeof(RefField<>);
        }
    }
};

struct StdGCTib {
    static constexpr U32 BITS_PER_BYTE = 8;
    static constexpr U32 REFS_PER_BIT_WORD = ((sizeof(U8) * BITS_PER_BYTE) / BITS_FOR_REF);
    // Number of bitmap words.
    U32 nBitmapWords;

    // An array of bitmap words. Length is `nBitmapWords`.
    U8 bitmapWords[];

    void VisitRefField(U8& bitmapWord, MAddress& fieldAddr, const RefFieldVisitor& visitor) const
    {
        U8 wordBits = bitmapWord & REF_BIT_MASK;
        if (wordBits != 0) {
            visitor(*reinterpret_cast<RefField<>*>(fieldAddr));
        }
        // go next ref word.
        bitmapWord >>= BITS_FOR_REF;
        fieldAddr += sizeof(RefField<>);
    }
    void VisitAllField(U8 &bitmapWord, MAddress &fieldAddr, const RefFieldVisitor &visitor) const
    {
        visitor(*reinterpret_cast<RefField<> *>(fieldAddr));
 
        // go next ref word.
        bitmapWord >>= BITS_FOR_REF;
        fieldAddr += sizeof(RefField<>);
    }
    void ForEachBitmapWord(MAddress contentAddr, const RefFieldVisitor& visitor) const
    {
        const U8* bitmaps = bitmapWords;

        // start address of fields.
        MAddress baseAddr = contentAddr;
        // for each bitmap word.
        for (U32 i = 0; i < nBitmapWords; ++i) {
            U8 bitmapWord = bitmaps[i];
            MAddress fieldAddr = baseAddr;

            // for each bit in bitmap.
            while (LIKELY(bitmapWord != 0)) {
                VisitRefField(bitmapWord, fieldAddr, visitor);
            }
            // go next bitmap word.
            baseAddr += (sizeof(RefField<>) * REFS_PER_BIT_WORD);
        }
    }
    void ForEachBitmapWordInRange(MAddress contentAddr, const RefFieldVisitor& visitor, MAddress rangeStart,
                                  MAddress rangeEnd) const
    {
        const U8* bitmaps = bitmapWords;
        size_t mapWordSize = (sizeof(RefField<>) * REFS_PER_BIT_WORD);
        U32 startIndex = (rangeStart - contentAddr) / mapWordSize;
        // start address of fields.
        MAddress baseAddr = startIndex * mapWordSize + contentAddr;
        // for each bitmap word.
        for (U32 i = startIndex; i < nBitmapWords; ++i) {
            U8 bitmapWord = bitmaps[i];
            MAddress fieldAddr = baseAddr;
            // Make sure each fieldAddr visited is no less then rangeStart addr
            if (i == startIndex && bitmapWord != 0) {
                bitmapWord >>= ((rangeStart - baseAddr) / sizeof(RefField<>));
                fieldAddr = rangeStart;
            }
            // for each bit in bitmap.
            while (LIKELY(bitmapWord != 0)) {
                if (fieldAddr >= rangeEnd) {
                    return;
                }
                VisitRefField(bitmapWord, fieldAddr, visitor);
            }

            // go next bitmap word.
            baseAddr += (sizeof(RefField<>) * REFS_PER_BIT_WORD);
        }
    }
};

union GCTib {
    U64 tag;           // 1: bitmap, 0: gctib
    ShortGCTib bitmap; // each bit indicates 8-byte width, 1:ref, 0:no-ref
    StdGCTib* gctib;   // valid only when highest bit is 0.

    bool IsGCTibWord() const
    {
        return static_cast<bool>(tag & SIGN_BIT_64); // 63: Use 64-bit sign bit as flag.
    }

    void ForEachBitmapWord(MAddress contentAddr, const RefFieldVisitor& visitor) const
    {
        if (IsGCTibWord()) {
            bitmap.ForEachBitmapWord(contentAddr, visitor);
        } else {
            gctib->ForEachBitmapWord(contentAddr, visitor);
        }
    }

    void ForEachBitmapWordInRange(MAddress contentAddr, const RefFieldVisitor& visitor, MAddress rangeStart,
                                  MAddress rangeEnd) const
    {
        rangeStart = ((rangeStart + 7) & (~7)); // 7: upper aligned to 8
        if (rangeStart >= rangeEnd) {
            return;
        }
        if (IsGCTibWord()) {
            bitmap.ForEachBitmapWordInRange(contentAddr, visitor, rangeStart, rangeEnd);
        } else {
            gctib->ForEachBitmapWordInRange(contentAddr, visitor, rangeStart, rangeEnd);
        }
    }
};

struct FieldNames {
    I64 fieldNameOffset[0];
};

class ReflectInfo {
public:
    inline U32 GetModifier() const { return modifier; }
    char* GetFieldName(U32 idx) const;
    FieldNames* GetFieldNames() { return fieldNamesOffset.GetDataRef(); }
    void SetFieldNames(FieldNames* fieldNames);
    void SetInstanceMethodInfo(U32 idx, MethodInfo* methodInfo);
    void SetStaticMethodInfo(U32 idx, MethodInfo* methodInfo);

    inline U32 GetNumOfInstanceFieldInfos() const { return instanceFieldInfoCnt; }
    inline U32 GetNumOfStaticFieldInfos() const { return staticFieldInfoCnt; }
    inline U32 GetNumOfInstanceMethodInfos() const { return instanceMethodCnt; }
    inline U32 GetNumOfStaticMethodInfos() const { return staticMethodCnt; }

    InstanceFieldInfo* GetInstanceFieldInfo(U32 index);
    StaticFieldInfo* GetStaticFieldInfo(U32 index);
    MethodInfo* GetInstanceMethodInfo(U32 index) const;
    MethodInfo* GetStaticMethodInfo(U32 index);
    void* GetDeclaringGenericTypeInfo() { return genericTypeInfo; }

    void SetDeclaringGenericTypeInfo(GenericTypeInfo* ti) { genericTypeInfo = ti; }

    void* GetAnnotations(TypeInfo* arrayTi);
private:
    Uptr GetBaseAddr() const { return reinterpret_cast<Uptr>(base); }
    DataRefOffset64<FieldNames> fieldNamesOffset;
    U32 modifier;
    U16 instanceFieldInfoCnt;
    U16 staticFieldInfoCnt;
    U32 instanceMethodCnt;
    U32 staticMethodCnt;
    Uptr annotationMethod;
    void* genericTypeInfo;
    Uptr base[0];
};

class EnumCtorInfo {
public:
    const char* GetName() { return name.GetDataRef(); }
    FuncPtr* GetCtorFn() const { return enumCtorFn; }
    TypeInfo* GetTypeInfo() const { return typeInfo; }

    void SetName(const char* pName);
    void SetTypeInfo(TypeInfo* ti) { typeInfo = ti; }
private:
    DataRefOffset64<char> name;
    union {
        FuncPtr* enumCtorFn;
        TypeInfo* typeInfo;
    };
};

class EnumInfo {
public:
    inline U32 GetModifier() const { return modifier; }
    inline U32 GetNumOfEnumCtor() const { return enumCtorInfoCnt; }
    inline U32 GetNumOfInstanceMethodInfos() const { return instanceMethodCnt; }
    inline U32 GetNumOfStaticMethodInfos() const { return staticMethodCnt; }
    inline EnumCtorInfo* GetEnumCtor(U32 idx) const;
    inline TypeInfo* GetCtorTypeInfo(U32 idx) const;
    void* GetAnnotations(TypeInfo* arrayTi);
    MethodInfo* GetInstanceMethodInfo(U32 index) const;
    MethodInfo* GetStaticMethodInfo(U32 index);

    void SetEnumCtors(void* ctors);
    void SetCtorInfoNum(U32 num) { enumCtorInfoCnt = num; }
    void SetParsed() { modifier |= MODIFIER_ENUM_PARSED; }
    bool IsParsed() const { return (modifier & MODIFIER_ENUM_PARSED) != 0; }
private:
    Uptr GetBaseAddr() const { return reinterpret_cast<Uptr>(base); }
    DataRefOffset64<EnumCtorInfo> enumCtorInfos;
    U32 modifier;
    U32 enumCtorInfoCnt;
    U32 instanceMethodCnt;
    U32 staticMethodCnt;
    Uptr annotationMethod;
    Uptr base[0];
};

// 4 : alignment of TypeTemplate.
class ATTR_PACKED(4) TypeTemplate {
public:
    inline bool IsRawArray() const;
    inline bool IsVArray() const;
    inline bool IsArrayType() const;
    inline bool IsWeakRefType() const;
    inline bool IsObjectType() const;
    inline bool IsPrimitiveType() const;
    inline bool IsInterface() const;
    inline bool IsClass() const;
    inline bool IsStruct() const;
    inline bool IsNothing() const;
    inline bool IsTuple() const;
    inline bool IsEnum() const;
    inline bool IsTempEnum() const;
    inline bool IsCString() const;
    inline bool IsCPointer() const;
    inline bool IsCFunc() const;
    inline bool IsFunc() const;
    inline bool IsRef() const;
    inline bool HasRefField() const;
    inline bool HasFinalizer() const;
    inline const char* GetName() const;
    inline I8 GetType() const { return type; }
    inline I8 GetFlag() const { return flag; }
    inline U16 GetFieldNum() const { return fieldNum; }
    inline U16 GetTypeArgNum() const { return typeArgsNum; }
    inline U16 GetValidInheritNum() const { return validInheritNum; }
    inline ExtensionData** GetvExtensionDataStart() const { return vExtensionDataStart; }
    inline U16 GetUUID() const { return uuid.load(); }
    inline void SetUUID(U16 id);
    inline EnumInfo* GetEnumInfo();
    inline bool ReflectInfoIsNull() const;
    bool ReflectIsEnable() const;

    CString GetTypeInfoName(U32 argSize, TypeInfo* args[]);
    ReflectInfo* GetReflectInfo() const { return reflectInfo; }
    TypeInfo* GetFieldTypeInfo(U16 fieldIdx, U32 argSize, TypeInfo* args[]);
    TypeInfo* GetSuperTypeInfo(U32 argSize, TypeInfo* args[]);
    FuncRef GetFinalizeMethod() const { return finalizerMethod; }
    static void* ExecuteGenericFunc(void* genericFunc, U32 argSize, TypeInfo* args[]);
private:
    GenericFunc GetFieldGenericFunc(U16 idx) const { return fieldFns[idx]; }
    GenericFunc GetSuperGenericFunc() const { return superFn; }
    TypeTemplate() = delete;
    ~TypeTemplate() = delete;
    const char* name;
    I8 type;
    I8 flag; // hasRefField, hasFinalize, monitor, waitQueue，use 0-3 bit
    U16 fieldNum;
    U16 typeArgsNum;
    // The member does not exist in the IR, use the alignment bits to record the UUID in runtime.
    std::atomic<U16> uuid;
    const GenericFunc* fieldFns;
    const GenericFunc superFn;
    FuncRef finalizerMethod;
    union {
        ReflectInfo* reflectInfo;
        EnumInfo* enumInfo;
    };
    ExtensionData **vExtensionDataStart;
    U16 validInheritNum;
};

// Class is a generalization of type information
class ATTR_PACKED(4) TypeInfo {
    friend class TypeInfoManager;
public:
    // property/field query
    inline GCTib GetGCTib() const;
    inline MSize GetInstanceSize() const;     // for instance class, in Bytes
    inline MSize GetComponentSize() const;    // for array class, in Bytes

    // Type category query
    inline bool IsObjectType() const;
    inline bool IsRawArray() const;
    inline bool IsVArray() const;
    inline bool IsWeakRefType() const;
    inline bool IsArrayType() const;
    inline bool IsStructType() const;
    inline bool IsPrimitiveType() const;
    inline bool IsVaildType() const;
    inline bool IsInterface() const;
    inline bool IsClass() const;
    inline bool IsSyncClass() const;
    inline bool IsStruct() const;
    inline bool IsNothing() const;
    inline bool IsUnit() const;
    inline bool IsTuple() const;
    inline bool IsEnum() const;
    inline bool IsTempEnum() const;
    inline bool IsCString() const;
    inline bool IsCPointer() const;
    inline bool IsFunc() const;
    inline bool IsFloat16() const;
    inline bool IsFloat32() const;
    inline bool IsFloat64() const;
    inline bool IsCFunc() const;
    inline bool IsRef() const;
    inline bool IsGenericTypeInfo() const; // mark generic instantiation TypeInfo
    inline bool IsGeneric() const; // mark a type of GenericTypeInfo, for reflect
    inline bool IsReflectUnsupportedType() const;
    inline bool HasRefField() const;
    inline bool HasFinalizer() const;
    inline I8 GetFlags() const;
    inline I8 GetType() const;
    inline U16 GetAlign() const;
    inline U16 GetFieldNum() const;
    inline U32* GetFieldOffsets() const;
    inline U16 GetValidInheritNum() const;
    inline bool IsInheritNumValid() { return validInheritNum != INVALID_INHERIT_NUM; }

    inline TypeInfo* GetFieldType(U16 idx) const;
    inline TypeInfo* GetComponentTypeInfo() const;
    inline U16 GetTypeArgNum() const { return typeArgsNum; }
    inline U32 GetFieldOffsets(U16 idx) const { return fieldOffsets[idx]; }
    inline TypeInfo* GetFieldTypeInfo(U16 idx) const { return fields[idx]; }
    inline TypeInfo** GetTypeArgs() const { return typeArgs; }
    inline TypeTemplate* GetSourceGeneric() const { return sourceGeneric; }
    inline ExtensionData** GetvExtensionDataStart() const { return vExtensionDataStart; }

    inline bool IsFutureClass() const;
    inline bool IsMonitorClass() const;
    inline bool IsMutexClass() const;
    inline bool IsWaitQueueClass() const;
    inline bool IsBoxClass();
    U32 GetModifier();
    bool ReflectIsEnable() const;
    bool ReflectInfoIsNull() const;
    ReflectInfo* GetReflectInfo();

    inline const char* GetName() const;
    FuncRef GetFinalizeMethod() const;

    // for reflection
    U32 GetNumOfInstanceMethodInfos();
    MethodInfo* GetInstanceMethodInfo(U32 index);

    U32 GetNumOfStaticMethodInfos();
    MethodInfo* GetStaticMethodInfo(U32 index);

    U32 GetNumOfInstanceFieldInfos();
    InstanceFieldInfo* GetInstanceFieldInfo(U32 index);

    U32 GetNumOfStaticFieldInfos();
    StaticFieldInfo* GetStaticFieldInfo(U32 index);

    PackageInfo* GetPackageInfo();
    void* GetAnnotations(TypeInfo* arrayTi);
    inline EnumInfo* GetEnumInfo();
    // for generic
    void SetName(const char* name) { this->typeInfoName = name; }
    void SetType(I8 kindType) { this->type = kindType; }
    void SetFlag(I8 f) { this->flag = f; }
    void SetFieldNum(U16 num) { this->fieldNum = num; }
    void SetTypeArgNum(I8 num) { this->typeArgsNum = num; }
    void SetUUID(U32 id) { this->uuid = id; }
    void SetMTableDesc(MTableDesc* desc);
    void SetGenericArgs(TypeInfo** args) { this->typeArgs = args; }
    void SetFieldAddr(TypeInfo** types) { this->fields = types; }
    void SetFieldType(U16 idx, TypeInfo* fieldType) { this->fields[idx] = fieldType; }
    void SetSuperTypeInfo(TypeInfo* super) { this->superTypeInfo = super; }
    void SetOffsets(U32* offsets) { this->fieldOffsets = offsets; }
    void SetSourceGeneric(TypeTemplate* tt) { this->sourceGeneric = tt; }
    void SetAlign(U8 alignment) { this->align = alignment; }
    void SetInstanceSize(U32 size) { this->instanceSize = size; }
    void SetGCTib(GCTib gctib);
    void SetComponentTypeInfo(TypeInfo* ti) { this->componentTypeInfo = ti; }
    void SetValidInheritNum(U16 num) { this->validInheritNum = num | (1 << 15); }
    bool IsSubType(TypeInfo* superTypeInfo);
    void SetFlagHasRefField();
    void SetReflectInfo(ReflectInfo* info) { this->reflectInfo = info; }
    void SetvExtensionDataStart(ExtensionData **ptr) { this->vExtensionDataStart = ptr; }
    void SetEnumInfo(EnumInfo* ei) { this->enumInfo = ei; }
    MTableDesc* GetMTableDesc() const { return mTableDesc; }
    void AddMTable(TypeInfo* ti, FuncPtr* funcTable);
    FuncPtr* GetMTable(TypeInfo* itf);
    U32 GetUUID();
    inline U32 GetClassSize() const;
    inline TypeInfo* GetSuperTypeInfo() const;                     // it can be null
    struct RAIISpinLock {
        RAIISpinLock(AtomicSpinLock& pLock) : lock(pLock) { lock.Lock(); }
        ~RAIISpinLock() { lock.Unlock(); }
        AtomicSpinLock& lock;
    };
    void TryInitMTable();
    void TryInitMTableNoLock();
    void GetInterfaces(std::vector<TypeInfo*> &itfs);
private:
    TypeInfo() = delete;
    ~TypeInfo() = delete;

    void TraverseInnerExtensionDefs(const std::function<void(TypeInfo*)> getInterface = nullptr);
    void TraverseOuterExtensionDefs(std::function<void(TypeInfo*)> getInterface = nullptr);
    // 0: functable, 1: is_sub_type
    std::pair<FuncPtr*, bool> FindMTable(U32 itfUUID);

    inline bool IsMTableDescUnInitialized() { return validInheritNum >> 15 == 1; }
    // This function must be called before mTableDesc is overwritten.
    inline U64 GetResolveBitmapFromMTableDesc()
    {
        return reinterpret_cast<uintptr_t>(mTableDesc);
    }

    const char* typeInfoName;
    I8 type;
    U8 flag; // hasRefField, hasFinalize, monitor, waitQueue，use 0-3 bit
    U16 fieldNum;
    union {
        MSize instanceSize;
        MSize componentSize;
    };
    GCTib gctib;
    U32 uuid;
    U8 align;
    I8 typeArgsNum;
    // During initialization, it indicates the number of valid classes in the virtual table. During running, it is
    // updated to calculate the start position of the interface extensiondef search.
    // INVALID_INHERIT_NUM: invalid value.
    U16 validInheritNum;
    U32* fieldOffsets;
    union {
        TypeTemplate* sourceGeneric;
        FuncRef finalizerMethod;
    };
    TypeInfo **typeArgs;
    TypeInfo **fields;
    union {
        TypeInfo* superTypeInfo;
        TypeInfo* componentTypeInfo;
    };
    ExtensionData **vExtensionDataStart;
    MTableDesc* mTableDesc;
    union {
        ReflectInfo* reflectInfo;
        EnumInfo* enumInfo;
    };
};

class GenericTypeInfo {
public:
    const char* GetName() const { return name; }
    inline const char* GetSourceGenericName();
    U8 GetGenericArgsNum() { return genericArgsNum; }
    U32 GetGenericConstraintNum() { return genericConstraintNum; }
    TypeInfo* GetGenericConstraint(U32 idx) { return genericConstraints[idx]; }
    void* GetGenericArg(U8 idx) { return genericArgs[idx]; }
    bool IsGenericCustom() { return type == TypeKind::TYPE_KIND_GENERIC_CUSTOM; }
    bool IsGeneric() { return type == TypeKind::TYPE_KIND_GENERIC_TI; }
    TypeTemplate* GetSourceGeneric() { return tt; }
private:
    const char* name;
    I8 type;
    U8 genericArgsNum;
    U16 __attribute__((unused)) slot;
    U32 genericConstraintNum;
    union {
        TypeInfo** genericArgs;
        TypeInfo** genericConstraints;
    };
    TypeTemplate* tt;
};
} // namespace MapleRuntime
#endif // MRT_MCLASS_H
