// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#include "Base/Log.h"
#include "ObjectManager.inline.h"
#include "ExceptionManager.inline.h"

namespace MapleRuntime {
ScopedAllocBuffer::~ScopedAllocBuffer()
{
    AllocBuffer* buffer = AllocBuffer::GetAllocBuffer();
    if (buffer != nullptr) {
        buffer->CommitRawPointerRegions();
    }
}

void* ParameterInfo::GetAnnotations(TypeInfo* arrayTi)
{
    ScopedAllocBuffer scopedAllocBuffer;
    CHECK_DETAIL(arrayTi != nullptr, "arrayTi is nullptr");
    U32 size = arrayTi->GetInstanceSize();
    MObject* obj = ObjectManager::NewObject(arrayTi, MRT_ALIGN(size + sizeof(TypeInfo*), sizeof(TypeInfo*)),
        AllocType::RAW_POINTER_OBJECT);
    if (obj == nullptr) {
        ExceptionManager::OutOfMemory();
        return nullptr;
    }
    if (annotationMethod == 0) {
        return obj;
    }
    ArgValue values;
    uintptr_t structRet[ARRAY_STRUCT_SIZE];
    values.AddReference(reinterpret_cast<BaseObject*>(structRet));
    uintptr_t threadData = MapleRuntime::MRT_GetThreadLocalData();
#if defined(__aarch64__)
    ApplyCangjieMethodStub(values.GetData(), reinterpret_cast<void*>(values.GetStackSize()),
                           reinterpret_cast<void*>(annotationMethod), reinterpret_cast<void*>(threadData), structRet);
#else
    ApplyCangjieMethodStub(values.GetData(), values.GetStackSize(), annotationMethod, threadData);
#endif

    Heap::GetBarrier().WriteStruct(obj, reinterpret_cast<Uptr>(obj) + sizeof(TypeInfo*),
        size, reinterpret_cast<Uptr>(structRet), size);
    return obj;
}

void ParameterInfo::SetName(const char* paraName)
{
    name.refOffset = reinterpret_cast<Uptr>(paraName) - reinterpret_cast<Uptr>(&name);
}

void* MethodInfo::MemoryAlloc(size_t cnt, size_t size)
{
    void* mem = calloc(cnt, size);
    PRINT_FATAL_IF(mem == nullptr, "MethodInfo::MemoryAlloc failed");
    return mem;
}

void MethodInfo::MemoryFree(void* ptr)
{
    if (ptr != nullptr) {
        free(ptr);
        ptr = nullptr;
    }
}

void* MethodInfo::GetEntryPoint()
{
    void* funcEntryPoint = reinterpret_cast<void*>(entryPoint);
    return funcEntryPoint;
}

void MethodInfo::SetMethodName(const char* methodName)
{
    name.refOffset = reinterpret_cast<Uptr>(methodName) - reinterpret_cast<Uptr>(&name);
}

void MethodInfo::SetActualParameterInfos(Uptr actualParaInfosAddr)
{
    actualParameterInfos.refOffset = actualParaInfosAddr - reinterpret_cast<Uptr>(&actualParameterInfos);
}

void MethodInfo::SetGenericParameterInfos(Uptr genericParamInfosAddr)
{
    genericParameterInfos.refOffset = genericParamInfosAddr - reinterpret_cast<Uptr>(&genericParameterInfos);
}

void* MethodInfo::GetAnnotations(TypeInfo* arrayTi)
{
    ScopedAllocBuffer scopedAllocBuffer;
    CHECK_DETAIL(arrayTi != nullptr, "arrayTi is nullptr");
    U32 size = arrayTi->GetInstanceSize();
    MObject* obj = ObjectManager::NewObject(arrayTi, MRT_ALIGN(size + sizeof(TypeInfo*), sizeof(TypeInfo*)),
        AllocType::RAW_POINTER_OBJECT);
    if (obj == nullptr) {
        ExceptionManager::OutOfMemory();
        return nullptr;
    }
    if (annotationMethod == 0) {
        return obj;
    }
    ArgValue values;
    uintptr_t structRet[ARRAY_STRUCT_SIZE];
    values.AddReference(reinterpret_cast<BaseObject*>(structRet));
    uintptr_t threadData = MapleRuntime::MRT_GetThreadLocalData();
#if defined(__aarch64__)
    ApplyCangjieMethodStub(values.GetData(), reinterpret_cast<void*>(values.GetStackSize()),
                           reinterpret_cast<void*>(annotationMethod), reinterpret_cast<void*>(threadData), structRet);
#else
    ApplyCangjieMethodStub(values.GetData(), values.GetStackSize(), annotationMethod, threadData);
#endif

    Heap::GetBarrier().WriteStruct(obj, reinterpret_cast<Uptr>(obj) + sizeof(TypeInfo*),
        size, reinterpret_cast<Uptr>(structRet), size);
    return obj;
}

// class CA<T> {}
// class A<T> {
//     public foo0(x: T) { 1 }
//     public foo0(x: CA<T>) { 1 }
// }
// The type of the generic parameter is determined when the CA instantiates
ParameterInfoRef MethodInfo::GetActualParameterInfo(U32 index, bool isFromTypeTemplate)
{
    if (index >= GetNumOfActualParameterInfos()) {
        return nullptr;
    }
    ParameterInfoRef pi = actualParameterInfos.GetDataRef() + index;
    if (declaringTi == nullptr || isFromTypeTemplate) {
        return pi;
    }
    TypeInfo* actualParameterType = pi->GetType();
    if (!actualParameterType->IsGeneric()) {
        return pi;
    }
    GenericTypeInfo* genericTi = reinterpret_cast<GenericTypeInfo*>(actualParameterType);
    TypeInfo* ti = GetActualTypeFromGenericType(genericTi, nullptr);
    if (ti != nullptr) {
        pi->SetGeneric();
        pi->SetType(ti);
    }
    return pi;
}

bool MethodInfo::HasSRet()
{
    return (static_cast<bool>(modifier & MODIFIER_HAS_SRET0) ||
            static_cast<bool>(modifier & MODIFIER_HAS_SRET1) ||
            static_cast<bool>(modifier & MODIFIER_HAS_SRET2) ||
            static_cast<bool>(modifier & MODIFIER_HAS_SRET3));
}

GenericTypeInfo* MethodInfo::GetGenericParameterInfo(U32 index)
{
    if (index >= GetNumOfGenericParameterInfos()) {
        return nullptr;
    }
    GenericParameterInfo* genericParameterInfo = genericParameterInfos.GetDataRef() + index;
    return genericParameterInfo->GetType();
}

bool MethodInfo::CheckGenericConstraint(GenericTypeInfo* genericTi, TypeInfo* ti, void* genericArgsArray)
{
    U32 genericConstraintCnt = genericTi->GetGenericConstraintNum();
    for (U32 idx = 0; idx < genericConstraintCnt; ++idx) {
        TypeInfo* genericConstraintTi = genericTi->GetGenericConstraint(idx);
        if (genericConstraintTi->IsGeneric()) {
            genericConstraintTi =
                GetActualTypeFromGenericType(reinterpret_cast<GenericTypeInfo*>(genericConstraintTi), genericArgsArray);
        }
        if (!ti->IsSubType(genericConstraintTi)) {
            return false;
        }
    }
    return true;
}

bool MethodInfo::CheckMethodActualArgs(void* genericArgsArray, void* actualArgsArray)
{
    // check Generic Constrains
    U16 genericArgCnt = GetNumOfGenericParameterInfos();
    for (U16 genericIdx = 0; genericIdx < genericArgCnt; ++genericIdx) {
        GenericTypeInfo* genericTi = GetGenericParameterInfo(genericIdx);
        TypeInfo* ti = GetActualTypeFromGenericType(genericTi, genericArgsArray);
        if (genericTi->GetGenericConstraintNum() > 0 && !CheckGenericConstraint(genericTi, ti, genericArgsArray)) {
            return false;
        }
    }

    CJArray* actualArgs = static_cast<CJArray*>(actualArgsArray);
    U64 actualArgCnt = actualArgs->rawPtr->len;
    if (actualArgCnt != GetNumOfActualParameterInfos()) {
        return false;
    }
    Uptr base = reinterpret_cast<Uptr>(&(actualArgs->rawPtr->data));
    for (U64 actualArgIdx = 0; actualArgIdx < actualArgCnt; ++actualArgIdx) {
        ObjRef argObj = *reinterpret_cast<ObjRef*>(base);
        ParameterInfo* actualParameterInfo = GetActualParameterInfo(actualArgIdx);
        TypeInfo* argType = actualParameterInfo->GetType();
        if (argType->IsGeneric()) {
            argType = GetActualTypeFromGenericType(reinterpret_cast<GenericTypeInfo*>(argType), genericArgsArray);
        }
        if (argType == nullptr) {
            return false;
        }
        base += sizeof(ObjRef);
        if (!argObj->GetTypeInfo()->IsSubType(argType)) {
            return false;
        }
    }
    return true;
}

TypeInfo* MethodInfo::GetActualTypeFromGenericTypeImpl(GenericTypeInfo* genericTi, void* genericArgs)
{
    TypeTemplate* tt = genericTi->GetSourceGeneric();
    U8 argsCnt = genericTi->GetGenericArgsNum();
    void* tmp = MemoryAlloc(argsCnt, sizeof(TypeInfo*));
    TypeInfo** args = static_cast<TypeInfo**>(tmp);
    for (U8 idx = 0; idx < argsCnt; ++idx) {
        TypeInfo* ti = reinterpret_cast<TypeInfo*>(genericTi->GetGenericArg(idx));
        if (ti->IsGeneric()) {
            TypeInfo* argTi = GetActualTypeFromGenericType(reinterpret_cast<GenericTypeInfo*>(ti), genericArgs);
            if (argTi == nullptr || argTi->IsGeneric()) {
                free(tmp);
                return nullptr;
            }
            args[idx] = argTi;
        } else {
            args[idx] = ti;
        }
    }
    TypeInfo* actualTi = TypeInfoManager::GetInstance()->GetOrCreateTypeInfo(tt, argsCnt, args);
    free(tmp);
    return actualTi;
}

TypeInfo* MethodInfo::GetReturnType()
{
    if (!returnType->IsGeneric()) {
        return returnType;
    }
    GenericTypeInfo* genericTi = reinterpret_cast<GenericTypeInfo*>(returnType);
    TypeInfo* actualTypeInfo = GetActualTypeFromGenericType(genericTi, nullptr);
    if (actualTypeInfo != nullptr) {
        return actualTypeInfo;
    }
    return returnType;
}

TypeInfo* MethodInfo::GetActualTypeFromGenericType(GenericTypeInfo* genericTi, void* genericArgs)
{
    if (genericTi->IsGeneric() && genericArgs != nullptr) {
        for (U32 idx = 0; idx < genericParametersCnt; ++idx) {
            GenericTypeInfo* genericParamType = GetGenericParameterInfo(idx);
            if (genericTi == genericParamType) {
                CJArray* genericArgsArray = static_cast<CJArray*>(genericArgs);
                Uptr base = reinterpret_cast<Uptr>(&(genericArgsArray->rawPtr->data));
                TypeInfo* ti = *reinterpret_cast<TypeInfo**>(base + idx * sizeof(TypeInfo*));
                return ti;
            }
        }
    }

    if (genericTi->IsGeneric() && genericArgs == nullptr) {
        if (declaringTi == nullptr) {
            return nullptr;
        }
        // genericTi is not generic parameter
        ReflectInfo* reflectInfo = declaringTi->GetReflectInfo();
        if (!declaringTi->IsGenericTypeInfo()) {
            return nullptr;
        }
        GenericTypeInfo* genericTypeInfo =
            reinterpret_cast<GenericTypeInfo*>(reflectInfo->GetDeclaringGenericTypeInfo());
        for (U8 idx = 0; idx < genericTypeInfo->GetGenericArgsNum(); ++idx) {
            GenericTypeInfo* genericArg = static_cast<GenericTypeInfo*>(genericTypeInfo->GetGenericArg(idx));
            if (genericArg == genericTi) {
                TypeInfo** typeArgs = declaringTi->GetTypeArgs();
                TypeInfo* ti = typeArgs[idx];
                return ti;
            }
        }
    }

    if (genericTi->IsGenericCustom()) {
        TypeInfo* ti = GetActualTypeFromGenericTypeImpl(genericTi, genericArgs);
        return ti;
    }
    return nullptr;
}

void MethodInfo::AddCJArg(ArgValue *argValues, TypeInfo *argType, ObjRef argObj)
{
    I8 type = argType->GetType();
    size_t offset = 8;
    switch (type) {
        case TypeKind::TYPE_KIND_NOTHING:
        case TypeKind::TYPE_KIND_UNIT: {
            argValues->AddInt64(0);
            break;
        }
        case TypeKind::TYPE_KIND_BOOL:
        case TypeKind::TYPE_KIND_RUNE:
        case TypeKind::TYPE_KIND_UINT8:
        case TypeKind::TYPE_KIND_UINT16:
        case TypeKind::TYPE_KIND_UINT32:
        case TypeKind::TYPE_KIND_UINT64:
        case TypeKind::TYPE_KIND_UINT_NATIVE:
        case TypeKind::TYPE_KIND_INT8:
        case TypeKind::TYPE_KIND_INT16:
        case TypeKind::TYPE_KIND_INT32:
        case TypeKind::TYPE_KIND_INT64:
        case TypeKind::TYPE_KIND_INT_NATIVE:
        case TypeKind::TYPE_KIND_CSTRING:
        case TypeKind::TYPE_KIND_CPOINTER:
        case TypeKind::TYPE_KIND_CFUNC: {
            argValues->AddInt64(argObj->Load<I64>(offset));
            break;
        }
        case TypeKind::TYPE_KIND_FLOAT16:
        case TypeKind::TYPE_KIND_FLOAT32:
        case TypeKind::TYPE_KIND_FLOAT64: {
            argValues->AddFloat64(argObj->Load<F64>(offset));
            break;
        }
        case TypeKind::TYPE_KIND_CLASS:
        case TypeKind::TYPE_KIND_WEAKREF_CLASS:
        case TypeKind::TYPE_KIND_INTERFACE:
        case TypeKind::TYPE_KIND_TEMP_ENUM:
        case TypeKind::TYPE_KIND_RAWARRAY:
        case TypeKind::TYPE_KIND_FUNC: {
            argValues->AddReference(argObj);
            break;
        }
        case TypeKind::TYPE_KIND_ENUM:
        case TypeKind::TYPE_KIND_TUPLE:
        case TypeKind::TYPE_KIND_STRUCT:
        case TypeKind::TYPE_KIND_VARRAY: {
            argValues->AddInt64(reinterpret_cast<Uptr>(reinterpret_cast<Uptr>(argObj) + sizeof(TypeInfo*)));
            break;
        }
        default:
            LOG(RTLOG_FATAL, "MethodInfo::AddCJArg no type matched");
    }
    return;
}

void MethodInfo::PrepareCJMethodActualArgs(ArgValue* argValues, void* actualArgsArray, void *genericArgsArray)
{
    CJRawArray* cjRawArray = static_cast<CJArray*>(actualArgsArray)->rawPtr;
    U64 actualArgCnt = cjRawArray->len;
    ObjRef rawArray = reinterpret_cast<ObjRef>(cjRawArray);
    RefField<false>* refField = reinterpret_cast<RefField<false>*>(&(cjRawArray->data));
    for (U64 actualArgIdx = 0; actualArgIdx < actualArgCnt; ++actualArgIdx) {
        ObjRef argObj = static_cast<ObjRef>(Heap::GetBarrier().ReadReference(rawArray, *refField));
        ParameterInfo* actualParameterInfo = GetActualParameterInfo(actualArgIdx);
        TypeInfo* argType = actualParameterInfo->GetType();
        refField++;
        if (argType->IsGeneric() || actualParameterInfo->IsGeneric()) {
            argValues->AddReference(argObj);
            continue;
        }
        if (argType->IsVArray()) {
            LOG(RTLOG_FATAL, "not support varray now!!!!\n");
        }
        AddCJArg(argValues, argType, argObj);
    }
}

void MethodInfo::PrepareCJMethodGenericArgs(ArgValue* argValues, void* genericArgsArray)
{
    CJArray* genericArgs = static_cast<CJArray*>(genericArgsArray);
    Uptr base = reinterpret_cast<Uptr>(&(genericArgs->rawPtr->data));
    U64 genericArgCnt = genericArgs->rawPtr->len;
    for (U64 idx = 0; idx < genericArgCnt; ++idx) {
        TypeInfo* ti = *reinterpret_cast<TypeInfo**>(base + idx * sizeof(TypeInfo*));
        argValues->AddInt64(reinterpret_cast<Uptr>(ti));
    }
}

void* MethodInfo::RetValueToAny(Value ret, void* sret, TypeInfo* retType)
{
    if (retType->IsRef()) {
        return ret.ref;
    } else if (retType->IsStruct() || retType->IsTuple()) {
        MSize typeSize = retType->GetInstanceSize();
        MSize size = MRT_ALIGN(typeSize + sizeof(TypeInfo*), sizeof(TypeInfo*));
        MObject* obj = ObjectManager::NewObject(retType, size, AllocType::RAW_POINTER_OBJECT);
        if (typeSize == 0) {
            return obj;
        }
        if (HasSRetNotGeneric()) {
            Heap::GetBarrier().WriteStruct(obj, reinterpret_cast<Uptr>(obj) + sizeof(TypeInfo*),
                                           typeSize, reinterpret_cast<Uptr>(sret), typeSize);
        } else {
            Heap::GetBarrier().WriteStruct(obj, reinterpret_cast<Uptr>(obj) + sizeof(TypeInfo*),
                                           typeSize, reinterpret_cast<Uptr>(ret.ref), typeSize);
        }
        return obj;
    } else if (retType->IsPrimitiveType()) {
        MSize size = MRT_ALIGN(retType->GetInstanceSize() + sizeof(TypeInfo*), sizeof(TypeInfo*));
        MObject* obj = ObjectManager::NewObject(retType, size, AllocType::RAW_POINTER_OBJECT);
        if (retType->IsUnit()) {
            return obj;
        }
        if (memcpy_s(reinterpret_cast<void*>(reinterpret_cast<Uptr>(obj) + sizeof(TypeInfo*)),
                     retType->GetInstanceSize(), &ret, retType->GetInstanceSize()) != EOK) {
            LOG(RTLOG_ERROR, "RetValueToAny memcpy_s fail");
        }
        return obj;
    } else if (retType->IsVArray()) {
        // VArray is only used to store value types,
        // so we can copy the memory directly
        MSize vArraySize = retType->GetFieldNum() * retType->GetComponentTypeInfo()->GetInstanceSize();
        MSize size = MRT_ALIGN(vArraySize + sizeof(TypeInfo*), sizeof(TypeInfo*));
        MObject* obj = ObjectManager::NewObject(retType, size, AllocType::RAW_POINTER_OBJECT);
        if (memcpy_s(reinterpret_cast<void*>(reinterpret_cast<Uptr>(obj) + sizeof(TypeInfo*)), vArraySize,
            reinterpret_cast<void*>(ret.ref), vArraySize) != EOK) {
            LOG(RTLOG_ERROR, "RetValueToAny memcpy_s fail");
        }
        return obj;
    } else {
        LOG(RTLOG_FATAL, "%s not to supported", retType->GetName());
    }
    return nullptr;
}

void MethodInfo::ApplyCJMethodImpl(ArgValue* argValues, void* &sret, Value &ret)
{
    uintptr_t threadData = MapleRuntime::MRT_GetThreadLocalData();
    if (returnType->IsFloat16() || returnType->IsFloat32()) {
        ret.f = ApplyCangjieMethodStubFloat32(argValues->GetData(), reinterpret_cast<void*>(argValues->GetStackSize()),
            GetEntryPoint(), reinterpret_cast<void*>(threadData));
    } else if (returnType->IsFloat64()) {
        ret.d = ApplyCangjieMethodStubFloat64(argValues->GetData(), reinterpret_cast<void*>(argValues->GetStackSize()),
            GetEntryPoint(), reinterpret_cast<void*>(threadData));
#if defined(__aarch64__)
    } else if (HasSRetWithGeneric()) {
        ret.l = reinterpret_cast<Uptr>(ApplyCangjieMethodStub(argValues->GetData(),
            reinterpret_cast<void*>(argValues->GetStackSize()), GetEntryPoint(),
            reinterpret_cast<void*>(threadData), &sret));
    } else {
        ret.l = reinterpret_cast<Uptr>(ApplyCangjieMethodStub(argValues->GetData(),
            reinterpret_cast<void*>(argValues->GetStackSize()), GetEntryPoint(),
            reinterpret_cast<void*>(threadData), sret));
    }
#else
    } else {
        ret.l = reinterpret_cast<Uptr>(ApplyCangjieMethodStub(argValues->GetData(), argValues->GetStackSize(),
            GetEntryPoint(), threadData));
    }
#endif
    if (ExceptionManager::HasPendingException()) {
        ExceptionManager::ThrowPendingException();
    }
    if (GetReturnType()->IsUnit()) {
        ret.ref = nullptr;
    }
}

void MethodInfo::PrepareSRet(ArgValue* argValues, void* &sret, TypeInfo* retType)
{
    U32 size = 0;
    if (retType->IsVArray()) {
        size = retType->GetFieldNum() * retType->GetComponentTypeInfo()->GetInstanceSize();
    } else {
        size = retType->GetInstanceSize();
    }
    if (HasSRetNotGeneric() || HasSRetWithKnowGenericStruct()) {
        sret = MemoryAlloc(1, size);
#if defined(__aarch64__)
#else
        argValues->AddReference(static_cast<BaseObject*>(sret));
#endif
        return;
    } else if (HasSRetWithGeneric()) {
        U32 objSize = MRT_ALIGN(size + sizeof(TypeInfo*), sizeof(TypeInfo*));
        sret = ObjectManager::NewObject(retType, objSize, AllocType::RAW_POINTER_OBJECT);
#if defined(__aarch64__)
#else
        argValues->AddInt64(reinterpret_cast<Uptr>(&sret));
#endif
        return;
    } else if (HasSRetWithUnknowGenericStruct()) {
        U32 objSize = MRT_ALIGN(size + sizeof(TypeInfo*), sizeof(TypeInfo*));
        sret = ObjectManager::NewObject(retType, objSize, AllocType::RAW_POINTER_OBJECT);
#if defined(__aarch64__)
#else
        argValues->AddInt64(reinterpret_cast<Uptr>(sret));
#endif
        return;
    }
    LOG(RTLOG_FATAL, "unreachable!!!");
}

void* MethodInfo::ApplyCJMethod(ObjRef instanceObj, void* genericArgs, void* actualArgs, TypeInfo* thisTypeInfo)
{
    ScopedAllocBuffer scopedAllocBuffer;
    ArgValue argValues;
    void* sret = nullptr;
    Value ret;
    ret.ref = nullptr;
    TypeInfo* retType = GetReturnType();
    if (HasSRet()) {
        if (retType->IsGeneric()) {
            retType = GetActualTypeFromGenericType(reinterpret_cast<GenericTypeInfo*>(retType), genericArgs);
        }
        PrepareSRet(&argValues, sret, retType);
    }
    if (instanceObj != nullptr) {
        argValues.AddReference(instanceObj);
    } else {
        TypeInfo* ti = declaringTi;
        if (IsInitializer() && ti->IsClass()) {
            U32 size = ti->GetInstanceSize();
            instanceObj = ObjectManager::NewObject(declaringTi,
                MRT_ALIGN(size + sizeof(TypeInfo*), sizeof(TypeInfo*)), AllocType::RAW_POINTER_OBJECT);
            argValues.AddReference(instanceObj);
        } else if (IsInitializer() && ti->IsStruct()) {
            instanceObj = reinterpret_cast<ObjRef>(MemoryAlloc(1, ti->GetInstanceSize()));
            argValues.AddInt64(reinterpret_cast<Uptr>(instanceObj));
            argValues.AddReference(nullptr); // add bp
        }
    }

    if (actualArgs != nullptr) {
        PrepareCJMethodActualArgs(&argValues, actualArgs, genericArgs);
    }
    if (genericArgs != nullptr) {
        PrepareCJMethodGenericArgs(&argValues, genericArgs);
    }

    if (IsStaticMethod()) {
        argValues.AddInt64(reinterpret_cast<I64>(declaringTi));
        argValues.AddInt64(reinterpret_cast<I64>(thisTypeInfo));
    } else {
        argValues.AddInt64(reinterpret_cast<I64>(declaringTi));
    }
    // The stack parameters are increased by 8 bytes each time,
    // guaranteed $rbp 16-byte alignment, keep stackIdx is even
    if (argValues.GetStackIdx() % 2 != 0) {
        argValues.AddReference(nullptr);
    }
    ApplyCJMethodImpl(&argValues, sret, ret);

    if (HasSRetWithGeneric()) {
        return sret;
    }
    if (HasSRetWithUnknowGenericStruct()) {
        return ret.ref;
    }
    if (IsInitializer() && declaringTi->IsClass()) {
        return instanceObj;
    } else if (IsInitializer() && declaringTi->IsStruct()) {
        ret.ref = instanceObj;
        void* any = RetValueToAny(ret, sret, declaringTi);
        MemoryFree(instanceObj);
        MemoryFree(sret);
        return any;
    }
    void* any = RetValueToAny(ret, sret, retType);
    MemoryFree(sret);
    return any;
}
} // namespace MapleRuntime
