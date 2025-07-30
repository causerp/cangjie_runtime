// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_LOADER_MANAGER_H
#define MRT_LOADER_MANAGER_H

#include <atomic>
#include <mutex>
#include <vector>

#include "Base/CString.h"
#include "ObjectModel/MClass.h"
#include "Loader/ILoader.h"

namespace MapleRuntime {
class LoaderManager {
public:
    LoaderManager() noexcept;
    ~LoaderManager() noexcept;
    void Init();
    void Fini();
    void AddPreLoadedImageMetaAddr(Uptr address);
    void RemovePreLoadedImageMetaAddr(Uptr address);
    void LoadPreLoadedImages();
    void GenerateMTableForStaticGI();

    void RegisterLoadFile(Uptr address) const;
    void UnregisterLoadFile(Uptr address) const;
    void LoadFile(Uptr address);
    void UnloadFile(Uptr address);
    void* LoadCJLibrary(const char* libName) const;
    int UnLoadLibrary(const char* libName) const;
    Uptr FindSymbol(const CString libName, const CString symbolName) const;
    bool LibInit(const char* libName) const;

    ILoader* GetLoader() const;
    static LoaderManager* GetInstance();
    bool GetInitStatus() const;
    static bool GetReleaseStatus() { return isReleased; }

    TypeInfo* FindTypeInfoFromLoadedFiles(const char* typeInfoName);
    TypeTemplate* FindTypeTemplateFromLoadedFiles(const char* typeTemplateName);
    void RecordTypeInfo(TypeInfo* ti);
    PackageInfo* GetPackageInfoByName(const char* packageName);
    PackageInfo* GetPackageInfoByPath(const char* path);
    void RemovePackageInfo(const char* path);
    bool FileHasLoaded(const char* path);
    bool FileHasMultiPackage(const char* path);
    void GetSubPackages(PackageInfo* packageInfo, std::vector<PackageInfo*> &subPackages);
    U32 GetNumOfInterface(TypeInfo* ti);
    TypeInfo* GetInterface(TypeInfo* ti, U32 idx);
    bool CheckPackageCompatibility(Uptr fileMetaAddr);
    void PreInitializePackage(Uptr address);

private:
#ifdef __OHOS__
    void RegisterLoadFunc();
#endif
    static bool isReleased;
    ILoader* loader;
    std::atomic<bool> initStatus;
    std::mutex loadedImgsMtx;
    std::vector<Uptr> preLoadedImages;
};
} // namespace MapleRuntime
#endif // MRT_LOADER_MANAGER_H
