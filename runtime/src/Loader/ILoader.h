// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_ILOADER_H
#define MRT_ILOADER_H
#include <functional>

#include "Base/CString.h"
#include "Common/TypeDef.h"
#include "ObjectModel/ExtensionData.h"
#include "BinaryFile/BaseFile.h"

namespace MapleRuntime {
class ILoader {
public:
    virtual ~ILoader() = default;
    virtual void Init() = 0;
    virtual void Fini() = 0;
    virtual void RegisterLoadFile(Uptr address) = 0;
    virtual void UnregisterLoadFile(Uptr address) = 0;
    virtual void VisitBaseFile(const std::function<bool(BaseFile*)>& f) const = 0;
    virtual TypeInfo* FindTypeInfoFromLoadedFiles(const char* typeInfoName) = 0;
    virtual TypeTemplate* FindTypeTemplateFromLoadedFiles(const char* typeTemplateName) = 0;
    virtual void RecordTypeInfo(TypeInfo* ti) = 0;
    virtual PackageInfo* GetPackageInfo(const char* packageName) const = 0;
    virtual void RemovePackageInfo(const char* path) = 0;
    virtual PackageInfo* GetPackageInfoByPath(const char* path) = 0;
    virtual bool FileHasLoaded(const char* path) = 0;
    virtual bool FileHasMultiPackage(const char* path) = 0;
    virtual void GetSubPackages(PackageInfo* packageInfo, std::vector<PackageInfo*> &subPackages) = 0;
    virtual void GenerateMTableForStaticGI() = 0;

    virtual bool LibInit(const char*) = 0;
    virtual void* LoadCJLibrary(const char*) = 0;
    virtual int UnloadLibrary(const char*) = 0;
    virtual Uptr FindSymbol(const CString libName, const CString symName) const = 0;
    virtual BaseFile* GetBaseFile(CString fileName) const = 0;
    virtual void VisitExtenionData(const std::function<bool(ExtensionData* ed)>& f, TypeTemplate* tt) const = 0;
    virtual bool CheckPackageCompatibility(BaseFile* file) = 0;
    virtual void TryThrowException(Uptr fileMetaAddr) = 0;
    virtual BaseFile* CreateFileRefFromAddr(Uptr address) = 0;
    virtual bool IsLazyStaticGI(U32 uuid) = 0;
    virtual void EraseLazyStaticGI(U32 uuid) = 0;
    virtual U32 GetNumOfInterface(TypeInfo* typeInfo) = 0;
    virtual TypeInfo* GetInterface(TypeInfo* typeInfo, U32 idx) = 0;
#ifdef __OHOS__
    virtual void RegisterLoadFunc(void* loadFunc) = 0;
#endif
    static ILoader* CreateLoader();
};
} // namespace MapleRuntime
#endif // MRT_ILOADER_H
