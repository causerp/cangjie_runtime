// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

#ifdef __OHOS__
#include <dlfcn.h>
#endif

#include "LoaderManager.h"
#include "Loader/ILoader.h"
namespace MapleRuntime {
bool LoaderManager::isReleased;
LoaderManager* LoaderManager::GetInstance()
{
    static LoaderManager loaderManager;
    return &loaderManager;
}

LoaderManager::LoaderManager() noexcept
{
    isReleased = false;
    loader = ILoader::CreateLoader();
    loader->Init();
    initStatus.store(false, std::memory_order_relaxed);
}

LoaderManager::~LoaderManager() noexcept
{
    delete loader;
    loader = nullptr;
    isReleased = true;
}

ILoader* LoaderManager::GetLoader() const { return loader; }

TypeInfo* LoaderManager::FindTypeInfoFromLoadedFiles(const char* mangledName)
{
    return loader->FindTypeInfoFromLoadedFiles(mangledName);
}

TypeTemplate* LoaderManager::FindTypeTemplateFromLoadedFiles(const char* mangledName)
{
    return loader->FindTypeTemplateFromLoadedFiles(mangledName);
}

void LoaderManager::RecordTypeInfo(TypeInfo* ti)
{
    return loader->RecordTypeInfo(ti);
}

PackageInfo* LoaderManager::GetPackageInfoByName(const char* packageName)
{
    return loader->GetPackageInfo(packageName);
}

PackageInfo* LoaderManager::GetPackageInfoByPath(const char* path)
{
    return loader->GetPackageInfoByPath(path);
}

void LoaderManager::RemovePackageInfo(const char* path)
{
    return loader->RemovePackageInfo(path);
}

bool LoaderManager::FileHasLoaded(const char* path)
{
    return loader->FileHasLoaded(path);
}

bool LoaderManager::FileHasMultiPackage(const char* path)
{
    return loader->FileHasMultiPackage(path);
}

void LoaderManager::GetSubPackages(PackageInfo* packageInfo, std::vector<PackageInfo*> &subPackages)
{
    loader->GetSubPackages(packageInfo, subPackages);
}

U32 LoaderManager::GetNumOfInterface(TypeInfo* ti)
{
    return loader->GetNumOfInterface(ti);
}

TypeInfo* LoaderManager::GetInterface(TypeInfo* ti, U32 idx)
{
    return loader->GetInterface(ti, idx);
}

bool LoaderManager::GetInitStatus() const { return initStatus.load(std::memory_order_acquire); }

void LoaderManager::LoadFile(Uptr address)
{
    std::lock_guard<std::mutex> lck(loadedImgsMtx);
    CheckPackageCompatibility(address);
    // MRT_LibraryOnLoad can be invoked before runtime init
    if (GetInitStatus()) {
        RegisterLoadFile(address);
        GenerateMTableForStaticGI();
    } else {
        AddPreLoadedImageMetaAddr(address);
    }
}

void LoaderManager::UnloadFile(Uptr address)
{
    std::lock_guard<std::mutex> lck(loadedImgsMtx);
    // MRT_LibraryUnLoad can be invoked before runtime init
    if (GetInitStatus()) {
        UnregisterLoadFile(address);
    } else {
        RemovePreLoadedImageMetaAddr(address);
    }
}

void LoaderManager::Init()
{
    LoadPreLoadedImages();
#ifdef __OHOS__
    RegisterLoadFunc();
#endif
    initStatus.store(true, std::memory_order_relaxed);
}

void LoaderManager::Fini()
{
    loader->Fini();
    initStatus.store(false, std::memory_order_relaxed);
}

void* LoaderManager::LoadCJLibrary(const char* libName) const { return loader->LoadCJLibrary(libName); }

int LoaderManager::UnLoadLibrary(const char* libName) const { return loader->UnloadLibrary(libName); }

Uptr LoaderManager::FindSymbol(const CString libName, const CString symbolName) const
{
    return loader->FindSymbol(libName, symbolName);
}

bool LoaderManager::LibInit(const char* libName) const { return loader->LibInit(libName); }

void LoaderManager::LoadPreLoadedImages()
{
    std::lock_guard<std::mutex> lck(loadedImgsMtx);
    for (auto it = preLoadedImages.rbegin(); it != preLoadedImages.rend(); it++) {
        RegisterLoadFile(*it);
        GenerateMTableForStaticGI();
    }
    preLoadedImages.clear();
}

void LoaderManager::RegisterLoadFile(Uptr address) const { loader->RegisterLoadFile(address); }

void LoaderManager::UnregisterLoadFile(Uptr address) const { loader->UnregisterLoadFile(address); }

void LoaderManager::AddPreLoadedImageMetaAddr(Uptr address) { preLoadedImages.push_back(address); }

void LoaderManager::GenerateMTableForStaticGI() { loader->GenerateMTableForStaticGI(); }

void LoaderManager::RemovePreLoadedImageMetaAddr(Uptr address)
{
    for (auto it = preLoadedImages.begin(); it != preLoadedImages.end();) {
        if (*it == address) {
            it = preLoadedImages.erase(it);
        } else {
            ++it;
        }
    }
}

bool LoaderManager::CheckPackageCompatibility(Uptr address)
{
    return loader->CheckPackageCompatibility(loader->CreateFileRefFromAddr(address));
};

#ifdef __OHOS__
// Due to the namespace isolation mechanism of ohos, the runtime has no
// permission to directly open the dynamic library on the application side.
// The runtime opens the dynamic library on the application side by using
// the dynamic loading interface on the default namespace.
void LoaderManager::RegisterLoadFunc()
{
    struct CJEnvMethods {
        void (*initCJAppNS)(void* path) = nullptr;
        void (*initCJSDKNS)(void* path) = nullptr;
        void (*initCJSysNS)(void* path) = nullptr;
        void (*initCJChipSDKNS)(void* path) = nullptr;
        bool (*startRuntime)() = nullptr;
        bool (*startUIScheduler)() = nullptr;
        void* (*loadCJModule)(const char* dllName) = nullptr;
        void* (*loadLibrary)(uint32_t kind, const char* dllName) = nullptr;
        void* (*getSymbol)(void* handle, const char* symbol) = nullptr;
        void* (*loadCJLibrary)(const char* dllName) = nullptr;
        bool (*startDebugger)() = nullptr;
        void (*registerCJUncaughtExceptionHandler)(void* uncaughtExceptionInfo) = nullptr;
        void (*setSanitizerKindRuntimeVersion)(void* kind) = nullptr;
        bool (*checkLoadCJLibrary)() = nullptr;
        void (*registerArkVMInRuntime)(unsigned long long arkVM) = nullptr;
        void (*registerStackInfoCallbacks)(void* uFunc) = nullptr;
        void (*setAppVersion)(void* version) = nullptr;
        void (*dumpHeapSnapshot) (int fd) = nullptr;
        void (*forceFullGC) () = nullptr;
    };
    Dl_namespace dlns;
    dlns_get(nullptr, &dlns);
    if (strcmp(dlns.name, "cj_rom_sdk") != 0) {
        return;
    }
    using GenEnvFunc = CJEnvMethods*(*)();
    const char* cjEnvFile = "/system/lib64/platformsdk/libcj_environment.z.so";
    // "CJEnvMethods* CJEnvironment::CreateEnvMethods()" mangled in c++
    const char* createEnvFuncMangledName = "_ZN4OHOS13CJEnvironment16CreateEnvMethodsEv";
    void* handle = dlopen(cjEnvFile, RTLD_NOW);
    if (handle == nullptr) {
        LOG(RTLOG_ERROR, "LoaderManager::RegisterLoadFunc: dlopen %s fail\n", cjEnvFile);
        return;
    }

    void* getEnvFunc = dlsym(handle, createEnvFuncMangledName);
    if (getEnvFunc == nullptr) {
        LOG(RTLOG_ERROR, "LoaderManager::RegisterLoadFunc: dlsym func `CJEnvironment::CreateEnvMethods()` fail\n");
        dlclose(handle);
        return;
    }

    CJEnvMethods* envFuncs = ((GenEnvFunc)getEnvFunc)();
    if (envFuncs == nullptr) {
        LOG(RTLOG_ERROR, "LoaderManager::RegisterLoadFunc: envFuncs is nullptr\n");
        dlclose(handle);
        return;
    }
    void* loadCJLibraryFunc = (void*)envFuncs->loadCJLibrary;
    if (loadCJLibraryFunc == nullptr) {
        LOG(RTLOG_ERROR, "LoaderManager::RegisterLoadFunc: get loadCJLibraryFunc fail\n");
        dlclose(handle);
        return;
    }
    loader->RegisterLoadFunc(loadCJLibraryFunc);
    dlclose(handle);
}
#endif

void LoaderManager::PreInitializePackage(Uptr address) { loader->TryThrowException(address); };
} // namespace MapleRuntime
