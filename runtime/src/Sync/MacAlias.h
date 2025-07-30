// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MAC_ALIAS_SYNC
#define MAC_ALIAS_SYNC

MRT_EXPORT void CJ_MCC_FutureInit(void* ptr);
__asm__(".global _CJ_MCC_FutureInit\n\t.set _CJ_MCC_FutureInit, _MCC_FutureInit");
MRT_EXPORT bool CJ_MCC_FutureIsComplete(const void* ptr);
__asm__(".global _CJ_MCC_FutureIsComplete\n\t.set _CJ_MCC_FutureIsComplete, _MCC_FutureIsComplete");
MRT_EXPORT void CJ_MCC_FutureNotifyAll(void* ptr);
__asm__(".global _CJ_MCC_FutureNotifyAll\n\t.set _CJ_MCC_FutureNotifyAll, _MCC_FutureNotifyAll");
MRT_EXPORT int CJ_MCC_MutexInit(void* ptr);
__asm__(".global _CJ_MCC_MutexInit\n\t.set _CJ_MCC_MutexInit, _MCC_MutexInit");
MRT_EXPORT bool CJ_MCC_MutexCheckStatus(void* ptr);
__asm__(".global _CJ_MCC_MutexCheckStatus\n\t.set _CJ_MCC_MutexCheckStatus, _MCC_MutexCheckStatus");
MRT_EXPORT void CJ_MCC_MutexUnlock(const void* ptr);
__asm__(".global _CJ_MCC_MutexUnlock\n\t.set _CJ_MCC_MutexUnlock, _MCC_MutexUnlock");
MRT_EXPORT void CJ_MCC_MutexTryLock(const void* ptr, void* waitQueuePtr);
__asm__(".global _CJ_MCC_MutexTryLock\n\t.set _CJ_MCC_MutexTryLock, _MCC_MutexTryLock");
MRT_EXPORT int CJ_MCC_WaitQueueInit(void* ptr);
__asm__(".global _CJ_MCC_WaitQueueInit\n\t.set _CJ_MCC_WaitQueueInit, _MCC_WaitQueueInit");
MRT_EXPORT int CJ_MCC_WaitQueueForMonitorInit(void* ptr);
__asm__(
    ".global _CJ_MCC_WaitQueueForMonitorInit\n\t.set _CJ_MCC_WaitQueueForMonitorInit, _MCC_WaitQueueForMonitorInit");
MRT_EXPORT void CJ_MCC_MonitorNotify(const void* ptr);
__asm__(".global _CJ_MCC_MonitorNotify\n\t.set _CJ_MCC_MonitorNotify, _MCC_MonitorNotify");
MRT_EXPORT void CJ_MCC_MonitorNotifyAll(const void* ptr);
__asm__(".global _CJ_MCC_MonitorNotifyAll\n\t.set _CJ_MCC_MonitorNotifyAll, _MCC_MonitorNotifyAll");
MRT_EXPORT void CJ_MCC_MultiConditionMonitorNotify(const void* ptr, void* waitQueuePtr);
__asm__(
    ".global _CJ_MCC_MultiConditionMonitorNotify\n\t.set _CJ_MCC_MultiConditionMonitorNotify, "
    "_MCC_MultiConditionMonitorNotify");
MRT_EXPORT void CJ_MCC_MultiConditionMonitorNotifyAll(const void* ptr, void* waitQueuePtr);
__asm__(
    ".global _CJ_MCC_MultiConditionMonitorNotifyAll\n\t.set _CJ_MCC_MultiConditionMonitorNotifyAll, "
    "_MCC_MultiConditionMonitorNotifyAll");
MRT_EXPORT bool CJ_MRT_HasThreadObjectInited();
__asm__(".global _CJ_MCC_IsThreadObjectInited\n\t.set _CJ_MCC_IsThreadObjectInited, "
    "_MCC_IsThreadObjectInited");
MRT_EXPORT void* CJ_MCC_GetCurrentCJThreadObject();
__asm__(".global _CJ_MCC_GetCurrentCJThreadObject\n\t.set _CJ_MCC_GetCurrentCJThreadObject, "
    "_MRT_GetCurrentCJThreadObject");
MRT_EXPORT void CJ_MCC_SetCurrentCJThreadObject(void* ptr);
__asm__(".global _CJ_MCC_SetCurrentCJThreadObject\n\t.set _CJ_MCC_SetCurrentCJThreadObject, "
    "_MCC_SetCurrentCJThreadObject");
MRT_EXPORT void CJ_MRT_SetCJThreadName(void* handle, uint8_t* name, size_t len);
__asm__(".global _CJ_MRT_SetCJThreadName\n\t.set _CJ_MRT_SetCJThreadName, _MRT_SetCJThreadName");
MRT_EXPORT int64_t CJ_MRT_GetCJThreadId(void* handle);
__asm__(".global _CJ_MRT_GetCJThreadId\n\t.set _CJ_MRT_GetCJThreadId, _MRT_GetCJThreadId");
MRT_EXPORT void* CJ_MRT_GetCurrentCJThread();
__asm__(".global _CJ_MRT_GetCurrentCJThread\n\t.set _CJ_MRT_GetCurrentCJThread, _MRT_GetCurrentCJThread");

#endif