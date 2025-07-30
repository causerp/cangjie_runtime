// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_SYSCALL_H
#define MRT_SYSCALL_H
#include <ctime>
#if defined(_WIN64)
#include <pthread.h>
#elif defined(__APPLE__)
#include <pthread.h>
#include <unistd.h>
#else
#include <sys/prctl.h>
#include "linux/futex.h"
#endif

namespace MapleRuntime {
#if defined(__linux__) || defined(hongmeng)
int Futex(const volatile int* uaddr, int op, int val);
#endif

pid_t GetTid();

int GetPid();

#if defined(__linux__) || defined(hongmeng)
#ifndef PR_SET_VMA
#define PR_SET_VMA 0x53564d41
#define PR_SET_VMA_ANON_NAME 0
#endif

// prctl(PR_SET_VMA, PR_SET_VMA_ANON_NAME), can set name for anon VMA.
// Considering the purpose is for debuging, in windows we just simply remove it.
#define MRT_PRCTL(base_address, allocated_size, mmtag) \
    (void)prctl(PR_SET_VMA, PR_SET_VMA_ANON_NAME, base_address, allocated_size, mmtag)
#endif
} // namespace MapleRuntime
#endif // MRT_SYSCALL_H
