// Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
// This source file is part of the Cangjie project, licensed under Apache-2.0
// with Runtime Library Exception.
//
// See https://cangjie-lang.cn/pages/LICENSE for license information.


#ifndef MRT_SYNC_H
#define MRT_SYNC_H

#include <atomic>

#include "CjScheduler.h"
#include "Base/AtomicSpinLock.h"
#include "Common/BaseObject.h"
#include "sema.h"
#include "waitqueue.h"

namespace MapleRuntime {
#ifdef __cplusplus
extern "C" {
#endif
struct CJFuture {
    void* klass;
    long long int data[4]; // 4: occupied by _thread(1)/result(1)/executeFn(2)
    // Reader/writer functions of `completeFlag` (i.e., MCC_FutureIsComplete/FutureSetComplete)
    // are used as callbacks of runtime functions, they will be executed with atomicity.
    // So the variable is not an atomic type.
    std::atomic<bool> completeFlag;
    std::atomic<int> isWaitQueueInit;
    Waitqueue wq;
    AtomicSpinLock spinLock;

    static constexpr size_t SYNC_OBJECT_SIZE = 168; // the size of future object with typeinfo header
};

struct CJMutex {
    void* klass;
    // atomic int64_t whose size should comfort to `MRT_GetCurrentThreadID`
    std::atomic<int64_t> ownerThreadId;
    // `ownCount` is always accessed when the mutex is held, so it can be non-atomic.
    uint64_t ownCount;
    std::atomic<int64_t> state; // includes waiter couter, locked, starve, spin
    bool isSemaInit;
    Sema sema;
};

struct CJMonitor {
    void* klass;
    CJMutex* mutexPtr;
    bool isWaitQueueInit;
    Waitqueue wq;
};

struct CJWaitQueue {
    void* klass;
    bool isWaitQueueInit;
    Waitqueue wq;
};

struct CJMultiConditionMonitor {
    void* klass;
    CJMutex* mutexPtr;
};

void ReleaseNativeResource(BaseObject* obj);

void MCC_FutureInit(void* ptr);
bool MCC_FutureIsComplete(void* ptr);
void MRT_FutureWait(const void* ptr, int64_t timeout);
void MCC_FutureNotifyAll(const void* ptr);
int MCC_MutexInit(void* ptr);
void MCC_MutexLock(void* ptr);
void MCC_MutexLockSlowPath(void* ptr);
bool MCC_MutexTryLock(void* ptr);
bool MCC_MutexCheckStatus(const void* ptr);
void MCC_MutexUnlock(const void* ptr);
int MCC_WaitQueueForMonitorInit(void* ptr);
int MCC_WaitQueueInit(void* ptr);
bool MCC_MonitorWait(const void* ptr, int64_t timeout);
void MCC_MonitorNotify(const void* ptr);
void MCC_MonitorNotifyAll(const void* ptr);
bool MCC_MultiConditionMonitorWait(const void* ptr, void* waitQueuePtr, int64_t timeout);
void MCC_MultiConditionMonitorNotify(const void* ptr, const void* waitQueuePtr);
void MCC_MultiConditionMonitorNotifyAll(const void* ptr, const void* waitQueuePtr);
bool MCC_IsThreadObjectInited();
void* MRT_GetCurrentCJThreadObject();
void MCC_SetCurrentCJThreadObject(void* ptr);
void MRT_SetCJThreadName(void* handle, uint8_t* name, size_t len);
int64_t MRT_GetCJThreadId(void* handle);
void* MRT_GetCurrentCJThread();
#ifdef __cplusplus
};
#endif
} // namespace MapleRuntime

#endif // MRT_SYNC_H
