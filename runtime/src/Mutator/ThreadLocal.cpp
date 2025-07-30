// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#include "ThreadLocal.h"

#include "Allocator/AllocBuffer.h"
#include "Base/Globals.h"

namespace MapleRuntime {
#if defined(_WIN64)
MRT_EXPORT thread_local ThreadLocalData threadLocalData;
#elif !defined(__clang__) && defined(__aarch64__)
__asm__(".section .maplert_tls, \"waT\"");
MRT_EXPORT __attribute__((section(".maplert_tls#"))) thread_local ThreadLocalData threadLocalData;
#elif defined(__APPLE__)
MRT_EXPORT thread_local ThreadLocalData threadLocalData;
#else
// g++ generates "awT" and "%progbits" for __attribute((section)), which causes "changed section
// attributes" warning (or error) at assembling stage. "#" suffix (depends on target architecture)
// could comment out the attribute g++ generates to suppress the "changed section attributes" warning.
__asm__(".section .maplert_tls, \"waT\"");
MRT_EXPORT __attribute__((section(".maplert_tls"))) thread_local ThreadLocalData threadLocalData;
#endif
ThreadLocalData* ThreadLocal::GetThreadLocalData() { return &threadLocalData; }

extern "C" void MCC_CheckThreadLocalDataOffset()
{
    static_assert(offsetof(ThreadLocalData, buffer) == 0,
                  "need to modify the offset of this value in llvm-project and cjthread at the same time");
    static_assert(offsetof(ThreadLocalData, mutator) == sizeof(void*),
                  "need to modify the offset of this value in llvm-project and cjthread at the same time");
    static_assert(offsetof(ThreadLocalData, cjthread) == sizeof(void*) * 2,
                  "need to modify the offset of this value in llvm-project and cjthread at the same time");
    static_assert(offsetof(ThreadLocalData, schedule) == sizeof(void*) * 3,
                  "need to modify the offset of this value in llvm-project and cjthread at the same time");
    static_assert(offsetof(ThreadLocalData, preemptFlag) == sizeof(void*) * 4,
                  "need to modify the offset of this value in llvm-project and cjthread at the same time");
    static_assert(offsetof(ThreadLocalData, protectAddr) == sizeof(void*) * 5,
                  "need to modify the offset of this value in llvm-project and cjthread at the same time");
    static_assert(offsetof(ThreadLocalData, safepointState) == sizeof(void*) * 6,
                  "need to modify the offset of this value in llvm-project and cjthread at the same time");
    static_assert(offsetof(ThreadLocalData, tid) == sizeof(void*) * 7,
                  "need to modify the offset of this value in llvm-project and cjthread at the same time");
    static_assert(offsetof(ThreadLocalData, foreignCJThread) == sizeof(void*) * 8,
                  "need to modify the offset of this value in llvm-project and cjthread at the same time");
    static_assert(sizeof(ThreadLocalData) == sizeof(void*) * 11,
                  "need to modify the offset of this value in llvm-project and cjthread at the same time");
}

#ifdef __APPLE__
extern "C" MRT_EXPORT void MRT_CheckThreadLocalDataOffset();
__asm__(
    ".global _MRT_CheckThreadLocalDataOffset\n\t.set _MRT_CheckThreadLocalDataOffset, _MCC_CheckThreadLocalDataOffset");
extern "C" MRT_EXPORT void CJ_MCC_CheckThreadLocalDataOffset();
__asm__(
    ".global _CJ_MCC_CheckThreadLocalDataOffset\n\t.set _CJ_MCC_CheckThreadLocalDataOffset, "
    "_MCC_CheckThreadLocalDataOffset");
#else
extern "C" MRT_EXPORT void MRT_CheckThreadLocalDataOffset() __attribute__((alias("MCC_CheckThreadLocalDataOffset")));
extern "C" MRT_EXPORT void CJ_MCC_CheckThreadLocalDataOffset() __attribute__((alias("MCC_CheckThreadLocalDataOffset")));
#endif
} // namespace MapleRuntime
