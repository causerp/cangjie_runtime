// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.

#ifndef MRT_CJTHREAD_THREADLOCAL_H
#define MRT_CJTHREAD_THREADLOCAL_H

#include "macro_def.h"

#ifdef __cplusplus
#if __cplusplus
extern "C" {
#endif
#endif

#ifdef TLS_COMMON_DYNAMIC

#define CJTHREAD_OFFSET 2
#define SCHEDULE_OFFSET 3
#define PREEMPT_FLAG_OFFSET 4
#define PROTECT_ADDR_OFFSET 5
#define PREEMPT_REQUEST_OFFSET 6

extern GetTlsHookFunc g_getTlsFunc;

MRT_INLINE static struct CJThread *CJThreadGet(void)
{
    uintptr_t *addr = g_getTlsFunc();
    return (struct CJThread*)(*(addr + CJTHREAD_OFFSET));
}

MRT_INLINE static void CJThreadSet(struct CJThread *cjthread)
{
    uintptr_t *addr = g_getTlsFunc();
    *(addr + CJTHREAD_OFFSET) = (uintptr_t)cjthread;
}

MRT_INLINE static struct Schedule *ScheduleGet(void)
{
    uintptr_t *addr = g_getTlsFunc();
    return (struct Schedule*)(*(addr + SCHEDULE_OFFSET));
}

MRT_INLINE static void ScheduleSet(struct Schedule *schedule)
{
    uintptr_t *addr = g_getTlsFunc();
    *(addr + SCHEDULE_OFFSET) = (uintptr_t)schedule;
}

MRT_INLINE static void **CJThreadAddr(void)
{
    uintptr_t *addr = g_getTlsFunc();
    return (void**)(addr + CJTHREAD_OFFSET);
}

MRT_INLINE static uintptr_t PreemptFlagGet(void)
{
    uintptr_t *addr = g_getTlsFunc();
    return *(addr + PREEMPT_FLAG_OFFSET);
}

MRT_INLINE static uintptr_t *PreemptFlagAddr(void)
{
    uintptr_t *addr = g_getTlsFunc();
    return addr + PREEMPT_FLAG_OFFSET;
}

MRT_INLINE static void PreemptFlagSet(uintptr_t value)
{
    uintptr_t *addr = g_getTlsFunc();
    *(addr + PREEMPT_FLAG_OFFSET) = value;
}

MRT_INLINE static uintptr_t *PreemptRequestAddr(void)
{
    uintptr_t *addr = g_getTlsFunc();
    return addr + PREEMPT_REQUEST_OFFSET;
}

MRT_INLINE static uintptr_t ProtectAddrGet(void)
{
    uintptr_t *addr = g_getTlsFunc();
    return *(addr + PROTECT_ADDR_OFFSET);
}

MRT_INLINE static void ProtectAddrSet(uintptr_t value)
{
    uintptr_t *addr = g_getTlsFunc();
    *(addr + PROTECT_ADDR_OFFSET) = value;
}
#else

extern __thread struct CJThread *g_cjthread;
extern __thread struct Schedule *g_schedule;
extern __thread uintptr_t g_preemptFlag;
extern __thread uintptr_t g_protectAddr;

/**
 * @brief Obtains the current scheduling framework.
 * @retval schedule pointer
 */
MRT_INLINE static struct Schedule *ScheduleGet(void)
{
    return g_schedule;
}

/**
 * @brief Set the current scheduling framework.
 */
MRT_INLINE static void ScheduleSet(struct Schedule *schedule)
{
    g_schedule = schedule;
}

/**
 * @brief Obtains the current cjthread.
 * @retval cjthread pointer
 */
MRT_INLINE static struct CJThread *CJThreadGet(void)
{
    return g_cjthread;
}

/**
 * @brief Set the specified cjthread as the current cjthread.
 */
MRT_INLINE static void CJThreadSet(struct CJThread *cjthread)
{
    g_cjthread = cjthread;
}

MRT_INLINE static void **CJThreadAddr(void)
{
    return (void **)&g_cjthread;
}

MRT_INLINE static uintptr_t PreemptFlagGet(void)
{
    return g_preemptFlag;
}

MRT_INLINE static uintptr_t *PreemptFlagAddr(void)
{
    return &g_preemptFlag;
}

MRT_INLINE static uintptr_t *PreemptRequestAddr(void)
{
    return NULL;
}

MRT_INLINE static void PreemptFlagSet(uintptr_t value)
{
    g_preemptFlag = value;
}

MRT_INLINE static uintptr_t ProtectAddrGet(void)
{
    return g_protectAddr;
}

MRT_INLINE static void ProtectAddrSet(uintptr_t value)
{
    g_protectAddr = value;
}

#endif

#ifdef __cplusplus
#if __cplusplus
}
#endif
#endif

#endif // MRT_CJTHREAD_THREADLOCAL_H
