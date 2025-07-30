// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#include <ctime>
#include "basetime.h"

#ifdef __cplusplus
extern "C" {
#endif

/* Number of nanoseconds equal to 1 second */
const unsigned long long SECOND_TO_NANO_NUMBER = 1000000000;
#define CPU_SHIFTS_STEP (32)

/* Obtains the current time in nanoseconds. */
unsigned long long CurrentNanotimeGet(void)
{
    struct timespec time;
    clock_gettime(CLOCK_MONOTONIC, &time);
    return (time.tv_sec * SECOND_TO_NANO_NUMBER + time.tv_nsec);
}

/* Obtain the current time, expressed in nanoseconds */
#if (MRT_HARDWARE_PLATFORM == MRT_ARM)
unsigned long long CurrentCPUTicks(void)
{
    unsigned long long ticks = 0;
    asm volatile("mrs %0, cntvct_el0" : "=r"(ticks));
    return ticks;
}
#elif  (MRT_HARDWARE_PLATFORM == MRT_X86 || MRT_HARDWARE_PLATFORM == MRT_WINDOWS_X86)
unsigned long long CurrentCPUTicks(void)
{
    unsigned long long retHigh;
    unsigned long long retLow;
    asm volatile("rdtsc" : "=d" (retHigh), "=a" (retLow));
    return ((retHigh << CPU_SHIFTS_STEP) | (retLow));
}
#endif

#ifdef __cplusplus
}
#endif