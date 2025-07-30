// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#include "SysCall.h"

#include <cstdlib>
#include <unistd.h>
#if defined(_WIN64)
#include <processthreadsapi.h>
#elif defined(__APPLE__)
#include "sys/syscall.h"
#else
#include "linux/futex.h"
#include "sys/syscall.h"
#endif

namespace MapleRuntime {
#ifndef SYS_futex
#define SYS_futex __NR_futex
#endif

#if defined(__linux__) || defined(hongmeng)
// only support FUTEX_WAIT/FUTEX_WAKE
int Futex(const volatile int* uaddr, int op, int val)
{
    return syscall(SYS_futex, uaddr, op, val, nullptr, nullptr, 0);
}
#endif

pid_t GetTid()
{
#if defined(__BIONIC__)
    return gettid();
#elif defined(_WIN64)
    return GetCurrentThreadId();
#elif defined(__APPLE__)
    uint64_t tid;
    pthread_threadid_np(nullptr, &tid);
    return static_cast<pid_t>(tid);
#else
    return syscall(SYS_gettid);
#endif
}

int GetPid()
{
#if defined(__BIONIC__) || defined(__APPLE__)
    return getpid();
#elif defined(_WIN64)
    return GetCurrentProcessId();
#else
    return syscall(SYS_getpid);
#endif
}
} // namespace MapleRuntime
