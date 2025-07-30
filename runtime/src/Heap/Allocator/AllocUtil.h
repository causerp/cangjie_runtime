// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_ALLOC_UTILS_H
#define MRT_ALLOC_UTILS_H

#include <cstdint>
#include <cstdio>

namespace MapleRuntime {
constexpr uint32_t ALLOC_UTIL_PAGE_SIZE = 4096;
#define ALLOCUTIL_PAGE_RND_UP(x) \
    (((static_cast<uintptr_t>(x)) + ALLOC_UTIL_PAGE_SIZE - 1) & (~(ALLOC_UTIL_PAGE_SIZE - 1)))

#ifdef _WIN64
#define ALLOCUTIL_MEM_UNMAP(address, sizeInBytes) \
    if (!VirtualFree(reinterpret_cast<void*>(address), 0, MEM_RELEASE)) { \
        LOG(RTLOG_FATAL, "VirtualFree failed. Process terminating."); \
    }
#else
#define ALLOCUTIL_MEM_UNMAP(address, sizeInBytes) \
    if (munmap(reinterpret_cast<void*>(address), sizeInBytes) != EOK) { \
        LOG(RTLOG_FATAL, "munmap failed. Process terminating."); \
    }
#endif

template<typename T>
constexpr T AllocUtilRndDown(T x, size_t n)
{
    return (x & static_cast<size_t>(-n));
}

template<typename T>
constexpr T AllocUtilRndUp(T x, size_t n)
{
    return AllocUtilRndDown(x + n - 1, n);
}
} // namespace MapleRuntime

#endif // MRT_ALLOC_UTILS_H
