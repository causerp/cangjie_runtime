// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_EXTENSION_DATA_H
#define MRT_EXTENSION_DATA_H

#include "Common/TypeDef.h"
#include "MClass.h"

namespace MapleRuntime {
union OuterTiUnion {
    using OuterTiFunc = TypeInfo* (*)(TypeInfo* childTi);
    TypeInfo* outerTypeInfo;
    OuterTiFunc outerTiFunc;
};

class ATTR_PACKED(4) ExtensionData {
public:
    bool TargetIsTypeInfo() { return argNum == 0; }
    void* GetTargetType() const
    {
        if (argNum == 0) {
            return ti;
        }
        return tt;
    }
    TypeInfo* GetInterfaceTypeInfo(U32 argsNum = 0U, TypeInfo** args = nullptr) const;
    FuncPtr GetWhereCondFn() const { return whereCondFn; }
    FuncPtr* GetFuncTable() const { return funcTable; }
    void UpdateFuncTable(U16 ftSize, FuncPtr* newFt) { funcTableSize  = ftSize; funcTable = newFt; }
    U16 GetFuncTableSize() const { return funcTableSize; }
    bool IsDirect() const { return flag & 0b10000000; }
    bool IsFuncTableUpdated() const
    {
        return __atomic_load_n(&flag, __ATOMIC_ACQUIRE) &
               0b00000110; // "bit-1&2 is 11" means updated already
    }
    bool TryLockFuncTable()
    {
        U8 expectedFlag = flag & 0b11111001;
        return __atomic_compare_exchange_n(&flag, &expectedFlag,
                                           flag | 0b00000100,    // "bit-1&2 is 10" means funcTable is locked
                                           false, __ATOMIC_RELEASE, __ATOMIC_ACQUIRE);
    }
    void SetFuncTableUpdated()
    {
        __atomic_store_n(
            &flag, flag | 0b00000110,    // "bit-1&2 is 11" means updated already
            __ATOMIC_RELEASE);
    }

    bool HasOuterTiFastPath() const { return (flag & 0b1) != 0; } // "bit-0 is 1" means codegen has computed the outer ti.
    TypeInfo* GetOuterTi(TypeInfo* childTi, U64 index) const
    {
        CHECK(index < funcTableSize);
        if (!HasOuterTiFastPath()) {
            return nullptr;
        }
        bool isConcrete = (childTi->GetTypeArgNum() == 0);
        OuterTiUnion* outerTiUnionStart = reinterpret_cast<OuterTiUnion*>(
            reinterpret_cast<uint8_t*>(funcTable) + sizeof(FuncPtr) * funcTableSize);
        return isConcrete ? outerTiUnionStart[index].outerTypeInfo : outerTiUnionStart[index].outerTiFunc == nullptr ?
            nullptr : outerTiUnionStart[index].outerTiFunc(childTi);
    }

private:
    U32 argNum;
    U8 isInterfaceTypeInfo;
    // optimization: use 1 byte to speed up the search of mtable.
    // bit-0: codegen has computed the outer ti as the fast path.
    // bit-1&2: funcTable updated, bit-7: direct supertype.
    U8 flag;
    U16 funcTableSize;
    union {
        TypeTemplate* tt;
        TypeInfo* ti;
    };
    union {
        FuncPtr interfaceFn;
        TypeInfo* interfaceTypeInfo;
    };
    FuncPtr whereCondFn;
    FuncPtr* funcTable;
    // The OuterTiUnion array is behind funcTable in memory, the offset depends on funcTableSize.
};
} // namespace MapleRuntime
#endif // MRT_EXTENSION_DATA_H
