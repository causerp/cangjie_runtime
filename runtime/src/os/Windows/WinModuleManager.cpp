// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#include "WinModuleManager.h"

#include <array>
#include <cstddef>
#include <dbghelp.h>
#include <string>
#include <unordered_set>
#include <vector>
#include <windows.h>

namespace MapleRuntime {
RuntimeFunction* WinModule::GetRuntimeFunction(Uptr pc) const
{
    uint32_t start = 0;
    uint32_t end = funcTableCount - 1;
    uint32_t mid = 0;
    while (start <= end) {
        mid = (start + end) / 2; // 2: half of (start + end)
        if (IsInRuntimeFunc(mid, pc)) {
            return &(funcTable[mid]);
        } else if (pc - imageBaseStart > funcTable[mid].endAddress) {
            start = mid + 1;
        } else {
            end = mid - 1;
        }
    }
    return nullptr;
}

WinModule* WinModuleManager::GetWinModuleByPc(Uptr pc) const
{
    for (auto module : winModules) {
        if (module->IsInModule(pc)) {
            return module;
        }
    }
    return nullptr;
}

WinModule* WinModuleManager::GetWinModuleByName(CString name) const
{
    for (auto module : winModules) {
        if (module->GetModuleName() == name) {
            return module;
        }
    }
    return nullptr;
}

void WinModuleManager::Init() { ReadWinModuleAtInit(); }

void WinModuleManager::ReadWinModuleAtInit()
{
    // Use documented module enumeration APIs instead of depending on the
    // private PEB loader-list layout.
    ReadWinModuleAtRunning();
}

void WinModuleManager::ReadModuleInfo(HMODULE* moduleHandlers, int moduleHandlersCapacity)
{
    for (int i = 0; i < moduleHandlersCapacity; i++) {
        // Get image name
        char moduleFullName[MAX_PATH] = { 0 };
        DWORD nameLen = GetModuleFileNameA(moduleHandlers[i], moduleFullName, MAX_PATH);
        if (nameLen == 0 || nameLen == MAX_PATH) {
            // The module name is unavailable or truncated (a path of exactly MAX_PATH
            // characters cannot be stored): skip this module.
            continue;
        }
        char drive[_MAX_DRIVE] = { 0 };
        char dir[_MAX_DIR] = { 0 };
        char fname[_MAX_FNAME] = { 0 };
        char ext[_MAX_EXT] = { 0 };
        errno_t splitRet =
            _splitpath_s(moduleFullName, drive, _MAX_DRIVE, dir, _MAX_DIR, fname, _MAX_FNAME, ext, _MAX_EXT);
        if (splitRet != 0) {
            // The path could not be split: skip this module instead of reading
            // uninitialized buffers.
            continue;
        }
        std::string moduleName = std::string(fname) + std::string(ext);
        if (nativeLibNames.count(moduleName) != 0) {
            continue;
        }

        MODULEINFO module = {};
        // Get image address
        if (GetModuleInformation(GetCurrentProcess(), moduleHandlers[i], &module, sizeof(module)) == FALSE ||
            module.lpBaseOfDll == nullptr || module.SizeOfImage == 0) {
            continue;
        }
        Uptr imageBaseStart = reinterpret_cast<Uptr>(module.lpBaseOfDll);
        Uptr imageBaseEnd = reinterpret_cast<Uptr>(module.lpBaseOfDll) + module.SizeOfImage;

        ULONG funcTableSize = 0;
        RuntimeFunction* funcTable = reinterpret_cast<RuntimeFunction*>(
            ImageDirectoryEntryToData((PVOID)imageBaseStart, true, IMAGE_DIRECTORY_ENTRY_EXCEPTION, &funcTableSize));
        uint32_t funcTableCount = funcTableSize / sizeof(RuntimeFunction);

        WinModule* winModule =
            new (std::nothrow) WinModule(imageBaseStart, imageBaseEnd, funcTable, funcTableCount, moduleName.c_str());
        if (UNLIKELY(winModule == nullptr)) {
            LOG(RTLOG_FATAL, "new WinModule failed.");
        }
        auto result = winModules.emplace(winModule);
        if (!result.second) {
            delete winModule;
        }
    }
}

void WinModuleManager::ReadWinModuleAtRunning()
{
    // It is hard to predict how many modules there will be in loading, here we assume 50 modules at the beginning.
    constexpr int moduleHandlerCapacity = 50;
    std::array<HMODULE, moduleHandlerCapacity> moduleHandlers;
    DWORD neededModulesLength = 0;
    HANDLE curProcess = GetCurrentProcess();
    if (EnumProcessModules(curProcess, moduleHandlers.data(),
                           static_cast<DWORD>(moduleHandlers.size() * sizeof(HMODULE)), &neededModulesLength) == FALSE ||
        neededModulesLength == 0) {
        return;
    }
    int moduleNum = neededModulesLength / sizeof(HMODULE);
    if (moduleNum <= moduleHandlerCapacity) {
        ReadModuleInfo(moduleHandlers.data(), moduleNum);
        return;
    }
    // require capacity expansion.
    std::vector<HMODULE> expandedModuleHandlers(static_cast<size_t>(moduleNum));
    DWORD expandedModulesLength = 0;
    if (EnumProcessModules(curProcess, expandedModuleHandlers.data(),
                           static_cast<DWORD>(expandedModuleHandlers.size() * sizeof(HMODULE)),
                           &expandedModulesLength) == FALSE ||
        expandedModulesLength == 0) {
        return;
    }
    int expandedModuleNum = expandedModulesLength / sizeof(HMODULE);
    if (expandedModuleNum > moduleNum) {
        expandedModuleNum = moduleNum;
    }
    ReadModuleInfo(expandedModuleHandlers.data(), expandedModuleNum);
}

void WinModuleManager::Fini() const
{
    for (auto module : winModules) {
        delete module;
        module = nullptr;
    }
}

} // namespace MapleRuntime
