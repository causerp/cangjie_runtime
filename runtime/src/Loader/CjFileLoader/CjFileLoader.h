// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_CJFILELOADER_H
#define MRT_CJFILELOADER_H
#include <functional>
#include <list>
#include <mutex>
#include <unordered_set>

#include "Base/HashUtils.h"
#include "Base/Types.h"
#include "ILoader.h"
#include "os/Loader.h"
#include "ObjectModel/ExtensionData.h"
#include "CjSemanticVersion/CjSemanticVersion.h"
#include "RuntimeConfig.h"
namespace MapleRuntime {
class CJFileLoader : public ILoader {
public:
    CJFileLoader()
    {
        binLoadApi.binLoad = &Os::Loader::LoadBinaryFile;
        binLoadApi.binUnload = &Os::Loader::UnloadBinaryFile;
        binLoadApi.getBinaryInfoFromAddress = &Os::Loader::GetBinaryInfoFromAddress;
        binLoadApi.findSymbol = &Os::Loader::FindSymbol;
    }
    ~CJFileLoader() override
    {
        binLoadApi.binLoad = nullptr;
        binLoadApi.binUnload = nullptr;
        binLoadApi.getBinaryInfoFromAddress = nullptr;
        binLoadApi.findSymbol = nullptr;
    }

    void Init() override {}
    void Fini() override;

    void RegisterLoadFile(Uptr address) override;
    void UnregisterLoadFile(Uptr address) override;
    void AddLoadedFiles(BaseFile* baseFile);
    void AddPackageInfos(BaseFile* baseFile);
    void RemoveLoadedFiles(BaseFile* baseFile);
    void ClearLoadedFiles();
    void GenerateMTableForStaticGI() override;
    void VisitBaseFile(const std::function<bool(BaseFile*)>& f) const override;
    bool LibInit(const char* libName) override;
    void* LoadCJLibrary(const char* libName) override;
    int UnloadLibrary(const char* libName) override;
    Uptr FindSymbol(const CString libName, const CString symName) const override;
    bool DoInitImage(BaseFile* baseFile) const;
    BaseFile* GetBaseFile(CString fileName) const override;
    auto GetBinaryInfoFromAddressFunc() const { return binLoadApi.getBinaryInfoFromAddress; }
    TypeInfo* FindTypeInfoFromLoadedFiles(const char* className) override;
    TypeTemplate* FindTypeTemplateFromLoadedFiles(const char* className) override;
    void RecordTypeInfo(TypeInfo* ti) override;
    PackageInfo* GetPackageInfo(const char* packageName) const override;
    PackageInfo* GetPackageInfoByPath(const char* path) override;
    void RemovePackageInfo(const char* path) override;
    bool FileHasLoaded(const char* path) override;
    bool FileHasMultiPackage(const char* path) override;
    void GetSubPackages(PackageInfo* packageInfo, std::vector<PackageInfo*> &subPackages) override;
    void VisitExtenionData(const std::function<bool(ExtensionData* ed)>& f, TypeTemplate* tt) const override;
    bool CheckPackageCompatibility(BaseFile* file) override;
    void TryThrowException(Uptr fileMetaAddr) override;
    BaseFile* GetBaseFileByMetaAddr(Uptr fileMetaAddr);
    BaseFile* CreateFileRefFromAddr(Uptr address) override;
    bool IsLazyStaticGI(U32 uuid) override;
    void EraseLazyStaticGI(U32 uuid) override;
    U32 GetNumOfInterface(TypeInfo* typeInfo) override;
    TypeInfo* GetInterface(TypeInfo* typeInfo, U32 idx) override;
#ifdef __OHOS__
    void RegisterLoadFunc(void* loadFunc) override;
#endif

protected:
    struct BinLoadApi binLoadApi;

private:
    void ParseEnumCtor(TypeInfo* ti);
    void RegisterTypeInfoCreatedByFE(BaseFile* baseFile);
    void RegisterOuterTypeExtensions(BaseFile* baseFile);
    int InitCJFile(const char* libName);
    struct LibNameToHandler {
        CString baseName;
        void* handler;
    };
    std::mutex libCjsoHandlersMutex;
    std::list<LibNameToHandler> cjLibHandlers;
    std::list<BaseFile*> loadedFiles;
    std::unordered_map<const char*, PackageInfo*, HashString, EqualString> packageInfos;
    std::unordered_map<const char*, TypeInfo*, HashString, EqualString> typeInfoCache;
    std::unordered_map<const char*, TypeTemplate*, HashString, EqualString> typeTemplateCache;
    std::unordered_map<PackageInfo*, std::vector<PackageInfo*>> subPackageMap;
    // fileName: packages
    std::unordered_map<const char*, std::vector<PackageInfo*>, HashString, EqualString> filePackageMap;
    // typeTemplate : extensionData1
    //              : ExtensionData2
    //              : ...
    std::unordered_multimap<TypeTemplate*, ExtensionData*> extensionDatas;
    // These mutexes are used for lazy initialization.
    std::unordered_set<U32> lazyInitStaticGIs;
    std::mutex lazyStaticGIMutex;
    std::vector<TypeInfo*> staticGIs;
    CjSemanticVersion compatibility;
};
} // namespace MapleRuntime
#endif // MRT_CJ_FILE_LOADER_H
