// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_SAFEPOINT_PAGE_MANAGER_H
#define MRT_SAFEPOINT_PAGE_MANAGER_H

#include <sys/mman.h>

#include "Base/Globals.h"
#include "Base/SysCall.h"
#include "securec.h"

namespace MapleRuntime {
class SafepointPageManager {
public:
    SafepointPageManager() {}

    void Init()
    {
        readablePage = reinterpret_cast<uint8_t*>(
            mmap(nullptr, MapleRuntime::MRT_PAGE_SIZE, PROT_READ, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0));
        unreadablePage = reinterpret_cast<uint8_t*>(
            mmap(nullptr, MapleRuntime::MRT_PAGE_SIZE, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0));
        unreadablePageForRawData = reinterpret_cast<uint8_t*>(
            mmap(nullptr, MapleRuntime::MRT_PAGE_SIZE, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0));
        CHECK_DETAIL(
            (readablePage != MAP_FAILED && unreadablePage != MAP_FAILED && unreadablePageForRawData != MAP_FAILED),
            "allocate safepoint page failed!");
    }

    ~SafepointPageManager()
    {
        CHECK_E(UNLIKELY(munmap(readablePage, MapleRuntime::MRT_PAGE_SIZE) != EOK),
                "munmap failed in SafepointPageManager readablePage destruction, errno: %d", errno);
        CHECK_E(UNLIKELY(munmap(unreadablePage, MapleRuntime::MRT_PAGE_SIZE) != EOK),
                "munmap failed in SafepointPageManager unreadablePage destruction, errno: %d", errno);
        CHECK_E(UNLIKELY(munmap(unreadablePageForRawData, MapleRuntime::MRT_PAGE_SIZE) != EOK),
                "munmap failed in SafepointPageManager unreadablePageForRawData destruction, errno: %d", errno);
    }

    uint8_t* GetSafepointReadablePage() const { return readablePage; }

    uint8_t* GetSafepointUnreadablePage() const { return unreadablePage; }

    // refactor this code: move to where it is used.
    uint8_t* GetUnreadablePage() const { return unreadablePageForRawData; }

private:
    uint8_t* readablePage = nullptr;
    uint8_t* unreadablePage = nullptr;
    uint8_t* unreadablePageForRawData = nullptr;
};
} // namespace MapleRuntime
#endif // MRT_SAFEPOINT_PAGE_MANAGER_H
