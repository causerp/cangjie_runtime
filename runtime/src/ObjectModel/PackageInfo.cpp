// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#include "PackageInfo.h" // module internal header
#include "MClass.inline.h"

namespace MapleRuntime {
TypeInfo* PackageInfo::GetTypeInfo(const char* name)
{
    PackageInfo* self = this;
    while (self != nullptr) {
        for (U32 idx = 0; idx < self->GetNumOfTypeInfos(); ++idx) {
            Uptr baseAddr = self->GetBaseAddr();
            TypeInfo** base = reinterpret_cast<TypeInfo**>(baseAddr);
            TypeInfo* ti = *(base + idx);
            if (strcmp(name, ti->GetName()) == 0) {
                return ti;
            }
        }
        self = self->GetRelatedPackageInfo();
    }
    return nullptr;
}

TypeTemplate* PackageInfo::GetTypeTemplate(const char* name)
{
    PackageInfo* self = this;
    while (self != nullptr) {
        Uptr baseAddr = self->GetBaseAddr();
        baseAddr += self->GetNumOfTypeInfos() * sizeof(TypeInfo*);
        TypeTemplate** base = reinterpret_cast<TypeTemplate**>(baseAddr);
        for (U32 idx = 0; idx < self->GetNumOfTypeTemplates(); ++idx) {
            TypeTemplate* tt = *(base + idx);
            if (tt == nullptr) { continue; }
            if (strcmp(name, tt->GetName()) == 0) {
                return tt;
            }
        }
        self = self->GetRelatedPackageInfo();
    }
    return nullptr;
}

TypeInfo* PackageInfo::GetTypeInfo(U32 index)
{
    Uptr baseAddr = GetBaseAddr();
    TypeInfo** ti = reinterpret_cast<TypeInfo**>(baseAddr);
    return *(ti + index);
}

MethodInfo* PackageInfo::GetGlobalMethodInfo(U32 index)
{
    Uptr baseAddr = GetBaseAddr();
    baseAddr += GetNumOfTypeInfos() * sizeof(TypeInfo*);
    baseAddr += GetNumOfTypeTemplates() * sizeof(TypeTemplate*);
    baseAddr += index * sizeof(DataRefOffset64<MethodInfo>);
    return reinterpret_cast<DataRefOffset64<MethodInfo>*>(baseAddr)->GetDataRef();
}

StaticFieldInfo* PackageInfo::GetGlobalFieldInfo(U32 index)
{
    Uptr baseAddr = GetBaseAddr();
    baseAddr += GetNumOfTypeInfos() * sizeof(TypeInfo*);
    baseAddr += GetNumOfTypeTemplates() * sizeof(TypeTemplate*);
    baseAddr += GetNumOfGlobalMethodInfos() * sizeof(DataRefOffset64<MethodInfo>);
    baseAddr += index * sizeof(DataRefOffset64<StaticFieldInfo>);
    return reinterpret_cast<DataRefOffset64<StaticFieldInfo>*>(baseAddr)->GetDataRef();
}
} // namespace MapleRuntime
