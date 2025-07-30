// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef COMMON_ALIAS_SYNC
#define COMMON_ALIAS_SYNC

MRT_EXPORT void CJ_MCC_FutureInit(void* ptr) __attribute__((alias("MCC_FutureInit")));
MRT_EXPORT bool CJ_MCC_FutureIsComplete(const void* ptr) __attribute__((alias("MCC_FutureIsComplete")));
MRT_EXPORT void CJ_MCC_FutureNotifyAll(void* ptr) __attribute__((alias("MCC_FutureNotifyAll")));
MRT_EXPORT int CJ_MCC_MutexInit(void* ptr) __attribute__((alias("MCC_MutexInit")));
MRT_EXPORT bool CJ_MCC_MutexCheckStatus(void* ptr) __attribute__((alias("MCC_MutexCheckStatus")));
MRT_EXPORT void CJ_MCC_MutexUnlock(const void* ptr) __attribute__((alias("MCC_MutexUnlock")));
MRT_EXPORT void CJ_MCC_MutexTryLock(const void* ptr, void* waitQueuePtr) __attribute__((alias("MCC_MutexTryLock")));
MRT_EXPORT int CJ_MCC_WaitQueueInit(void* ptr) __attribute__((alias("MCC_WaitQueueInit")));
MRT_EXPORT int CJ_MCC_WaitQueueForMonitorInit(void* ptr) __attribute__((alias("MCC_WaitQueueForMonitorInit")));
MRT_EXPORT void CJ_MCC_MonitorNotify(const void* ptr) __attribute__((alias("MCC_MonitorNotify")));
MRT_EXPORT void CJ_MCC_MonitorNotifyAll(const void* ptr) __attribute__((alias("MCC_MonitorNotifyAll")));
MRT_EXPORT void CJ_MCC_MultiConditionMonitorNotify(const void* ptr, void* waitQueuePtr)
    __attribute__((alias("MCC_MultiConditionMonitorNotify")));
MRT_EXPORT void CJ_MCC_MultiConditionMonitorNotifyAll(const void* ptr, void* waitQueuePtr)
    __attribute__((alias("MCC_MultiConditionMonitorNotifyAll")));
MRT_EXPORT bool CJ_MCC_IsThreadObjectInited() __attribute__((alias("MCC_IsThreadObjectInited")));
MRT_EXPORT void* CJ_MCC_GetCurrentCJThreadObject() __attribute__((alias("MRT_GetCurrentCJThreadObject")));
MRT_EXPORT void CJ_MCC_SetCurrentCJThreadObject(void* ptr) __attribute__((alias("MCC_SetCurrentCJThreadObject")));
MRT_EXPORT void CJ_MRT_SetCJThreadName(void* handle, uint8_t* name, size_t len)
    __attribute__((alias("MRT_SetCJThreadName")));
MRT_EXPORT int64_t CJ_MRT_GetCJThreadId(void* handle) __attribute__((alias("MRT_GetCJThreadId")));
MRT_EXPORT void* CJ_MRT_GetCurrentCJThread() __attribute__((alias("MRT_GetCurrentCJThread")));

#endif