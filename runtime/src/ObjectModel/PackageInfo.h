// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_PACKAGEINFO_H
#define MRT_PACKAGEINFO_H

#include "Common/TypeDef.h"
#include "Common/Dataref.h"
#include "RefField.h"
#include "MethodInfo.h"
#include "FieldInfo.h"
#include "Base/Globals.h"

namespace MapleRuntime {
class TypeInfo;
class TypeTemplate;

// PackageInfo includes classes, global functions, global variable.
// global function layout likes MethodInfo.
// global variable layout likes StaticFieldInfo.
class PackageInfo {
public:
    bool IsVaild() { return isVaild == 1; }
    const char* GetPackageName() const { return packageName.GetDataRef(); }
    const char* GetModuleName() const { return moduleName.GetDataRef(); }
    const char* GetVersion() const { return version.GetDataRef(); }
    TypeInfo* GetTypeInfo(const char* name);
    TypeTemplate* GetTypeTemplate(const char* name);

    U32 GetNumOfTypeInfos() const { return typeInfoCnt; }
    U32 GetNumOfTypeTemplates() const { return typeTemplateCnt; }
    U32 GetNumOfGlobalMethodInfos() const { return globalMethodCnt; }
    U32 GetNumOfGlobalFieldInfos() const { return globalVariableCnt; }

    TypeInfo* GetTypeInfo(U32 index);
    MethodInfo* GetGlobalMethodInfo(U32 index);
    StaticFieldInfo* GetGlobalFieldInfo(U32 index);

    PackageInfo* GetRelatedPackageInfo() { return relatedPackageInfo; }

    size_t GetPackageSize()
    {
        U32 packageAlign = 16;
        size_t packageSize = sizeof(PackageInfo);
        packageSize += typeInfoCnt * sizeof(TypeInfo*);
        packageSize += typeTemplateCnt * sizeof(TypeTemplate*);
        packageSize += globalMethodCnt * sizeof(DataRefOffset64<MethodInfo>);
        packageSize += globalVariableCnt * sizeof(DataRefOffset64<InstanceFieldInfo>);
        return AlignUp<size_t>(packageSize, packageAlign);
    }
private:
    Uptr GetBaseAddr() { return reinterpret_cast<Uptr>(base); }
    PackageInfo* relatedPackageInfo;
    U32 typeInfoCnt;
    U32 typeTemplateCnt;
    U32 globalMethodCnt;
    U32 globalVariableCnt;
    U8 isVaild;
    U8 __attribute__((unused)) slot[7];
    DataRefOffset64<char> moduleName;
    DataRefOffset64<char> packageName;
    DataRefOffset64<char> version;
    void* __attribute__((unused)) slot0;
    void* __attribute__((unused)) slot1;
    Uptr base[0];
};
} // namespace MapleRuntime
#endif // MRT_PACKAGEINFO_H
