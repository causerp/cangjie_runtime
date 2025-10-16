/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.sync

/* Mutex-related intrinsics*/
@Intrinsic
func mutexInit(mutex: Mutex): Bool

@Intrinsic
func mutexLock(mutex: Mutex): Unit

@Intrinsic
func mutexTryLock(mutex: Mutex): Bool

@Intrinsic
func mutexCheckStatus(mutex: Mutex): Bool

@Intrinsic
func mutexUnlock(mutex: Mutex): Unit

/* Monitor-related intrinsics*/
@Intrinsic
func monitorWait(monitor: Monitor, timeout: Int64): Bool

@Intrinsic
func monitorNotify(monitor: Monitor): Unit

@Intrinsic
func monitorNotifyAll(monitor: Monitor): Unit

/* MultiConditionMonitor-related intrinsics*/
@Intrinsic
func multiConditionMonitorWait(multiConditionMonitor: MultiConditionMonitor, obj: Object, timeout: Int64): Bool

@Intrinsic
func multiConditionMonitorNotify(multiConditionMonitor: MultiConditionMonitor, obj: Object): Unit

@Intrinsic
func multiConditionMonitorNotifyAll(multiConditionMonitor: MultiConditionMonitor, obj: Object): Unit

/* Waitqueue-related intrinsics*/
@Intrinsic
func waitQueueInit(obj: WaitQueue): Bool

/* Monitor-related intrinsics*/
@Intrinsic
func monitorInit(obj: Monitor): Bool
