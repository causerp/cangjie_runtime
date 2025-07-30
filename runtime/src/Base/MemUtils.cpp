// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#include "Log.h"
#include "securec.h"

namespace MapleRuntime {
void MemorySet(uintptr_t dest, size_t size, int c, size_t count)
{
    uintptr_t destAddress = dest;
    while (size != 0) {
        size_t sizePerChunk = size > SECUREC_MEM_MAX_LEN ? SECUREC_MEM_MAX_LEN : size;
        size_t countPerChunk = count > SECUREC_MEM_MAX_LEN ? SECUREC_MEM_MAX_LEN : count;
        CHECK_E((memset_s(reinterpret_cast<void*>(destAddress), sizePerChunk, c, countPerChunk) != EOK),
                "memset_s fail");
        size -= sizePerChunk;
        count -= countPerChunk;
        destAddress += sizePerChunk;
    }
}

void MemoryCopy(uintptr_t dest, size_t size, const uintptr_t src, size_t count)
{
    uintptr_t destAddress = dest;
    uintptr_t srcAddress = src;
    while (size != 0) {
        size_t sizePerChunk = size > SECUREC_MEM_MAX_LEN ? SECUREC_MEM_MAX_LEN : size;
        size_t countPerChunk = count > SECUREC_MEM_MAX_LEN ? SECUREC_MEM_MAX_LEN : count;
        CHECK_E((memcpy_s(reinterpret_cast<void*>(destAddress), sizePerChunk, reinterpret_cast<void*>(srcAddress),
                          countPerChunk) != EOK),
                "memcpy_s fail");
        size -= sizePerChunk;
        count -= countPerChunk;
        destAddress += sizePerChunk;
        srcAddress += sizePerChunk;
    }
}

#if defined(ENABLE_BACKWARD_PTRAUTH_CFI) || defined(ENABLE_FORWARD_PTRAUTH_CFI)
#if defined(__OHOS__)
const uint64_t PAC_MASK = ((uint64_t)1 << 48) - 1;
#elif defined(__HOS__)
const uint64_t PAC_MASK = ((uint64_t)1 << 39) - 1;
#endif

__attribute__((always_inline)) uintptr_t PtrauthStripInstPointer(uintptr_t ptr)
{
    // simulate xpaci on device which lower than armv8.3a
    return ptr & PAC_MASK;
}
__attribute__((always_inline)) uintptr_t PtrauthAuthWithInstAkey(uintptr_t ptr, uintptr_t mod)
{
    asm volatile (
        "stp x16, x17, [sp, -0x10]\n"
        "mov x17, %[preg]\n"
        "mov x16, %[pmod]\n"
        "autia1716\n"
        "mov %[preg], x17\n"
        "ldp x16, x17, [sp, -0x10]"
        : [preg] "+r" (ptr) : [pmod] "r" (mod) :);
    return ptr;
}

__attribute__((always_inline)) uintptr_t PtrauthSignWithInstAkey(uintptr_t ptr, uintptr_t mod)
{
    asm volatile (
        "stp x16, x17, [sp, -0x10]\n"
        "mov x17, %[preg]\n"
        "mov x16, %[pmod]\n"
        "pacia1716\n"
        "mov %[preg], x17\n"
        "ldp x16, x17, [sp, -0x10]"
        : [preg] "+r" (ptr) : [pmod] "r" (mod) :);
    return ptr;
}
#endif

} // namespace MapleRuntime
