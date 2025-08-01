/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.sync

/**
 * Class that encapsulates single reentrant mutex and single condition instance (a.k.a. wait queue) associated with this mutex.
 */
@Deprecated[message: "Use `public interface Condition` instead."]
public class Monitor <: ReentrantMutex {
    public init() {
        var isNull = unsafe { monitorInit(this) }
        if (isNull) {
            throw IllegalSynchronizationStateException("Initialization failed.")
        }
    }

    init(mutex: Mutex) {
        super(mutex)
        let isNull = unsafe { monitorInit(this) }
        if (isNull) {
            throw IllegalSynchronizationStateException("Initialization failed.")
        }
    }

    /**
     * @brief Block until paired `notify` is invoked or `timeout` nanoseconds passed.
     * @return `true` if event was signalled by other thread;
     * @return `false` on timeout, otherwise.
     * @throws IllegalSynchronizationStateException if current thread does not hold this mutex
     * @throws IllegalArgumentException if `timeout <= Duration.Zero`
     */
    public func wait(timeout!: Duration = Duration.Max): Bool {
        checkMutexStatus()
        if (timeout <= Duration.Zero) {
            throw IllegalArgumentException("Timeout cannot be less than or equal to `Duration.Zero`.")
        }
        let timeoutNanos = if (timeout > MAX_TIMEOUT_DURATION) {
            MAX_TIMEOUT_NS
        } else {
            timeout.toNanoseconds()
        }
        return unsafe { monitorWait(this, timeoutNanos) }
    }

    /**
     * @brief Wake up a single thread waiting on this mutex (no particular admission policy implied).
     * @throws IllegalSynchronizationStateException if current thread does not hold this mutex
     */
    public func notify(): Unit {
        checkMutexStatus()
        unsafe { monitorNotify(this) }
    }

    /**
     * @brief Wake up all threads waiting on this mutex (no particular admission policy implied).
     * @throws IllegalSynchronizationStateException if current thread does not hold this mutex
     */
    public func notifyAll(): Unit {
        checkMutexStatus()
        unsafe { monitorNotifyAll(this) }
    }
}

/**
 * @brief Record represents unique identifier of an existing wait queue associated with given mutex.
 * Passing invalid ConditionID to the MultiConditionMonitor results into ISSE.
 */
@Deprecated[message: "Use `public interface Condition` instead."]
public struct ConditionID {
    init(m: MultiConditionMonitor, wqPtr: WaitQueue) {
        monitor = m
        waitQueue = wqPtr
    }

    let monitor: MultiConditionMonitor
    let waitQueue: WaitQueue
}

class WaitQueue {
    init() {
        var isNull = unsafe { waitQueueInit(this) }
        if (isNull) {
            throw IllegalSynchronizationStateException("Initialization failed.")
        }
    }
}
/**
 * @brief Class that encapsulates single reentrant mutex and a set of dynamically created condition instances associated with this mutex.
 */
@Deprecated[message: "Use `public class Mutex` instead."]
public class MultiConditionMonitor <: ReentrantMutex {
    public init() {}

    /**
     * @return A new ConditionID associated with this mutex. May be used to implement "single mutex -- multiple wait queues" concurrent primitives.
     * @throws IllegalSynchronizationStateException if current thread does not hold this mutex.
     */
    public func newCondition(): ConditionID {
        checkMutexStatus()
        let waitQueue = WaitQueue()
        return ConditionID(this, waitQueue)
    }

    /**
     * @brief Block until paired `notify` is invoked or `timeout` nanoseconds passed
     * @return `true` if specified condition was signalled by other thread;
     * @return `false` if timeouted.
     * @throws IllegalSynchronizationStateException if current thread does not hold this mutex
     * @throws IllegalSynchronizationStateException if `id` isn't provided by `newCondition` of this MultiConditionMonitor instance
     * @throws IllegalArgumentException if `timeout <= Duration.Zero`
     */
    public func wait(condID: ConditionID, timeout!: Duration = Duration.Max): Bool {
        if (!refEq(this, condID.monitor)) {
            throw IllegalSynchronizationStateException("Invalid condition.")
        }
        checkMutexStatus()
        if (timeout <= Duration.Zero) {
            throw IllegalArgumentException("Timeout cannot be less than or equal to `Duration.Zero`.")
        }
        let timeoutNanos = if (timeout > MAX_TIMEOUT_DURATION) {
            MAX_TIMEOUT_NS
        } else {
            timeout.toNanoseconds()
        }
        return unsafe { multiConditionMonitorWait(this, condID.waitQueue, timeoutNanos) }
    }

    /**
     * @brief Wake up a single thread waiting on this mutex (no particular admission policy implied)
     * @throws IllegalSynchronizationStateException if current thread does not hold this mutex
     * @throws IllegalSynchronizationStateException if `id` was not provided by `newCondition` of this MultiConditionMonitor instance
     */
    public func notify(condID: ConditionID): Unit {
        if (!refEq(this, condID.monitor)) {
            throw IllegalSynchronizationStateException("Invalid condition.")
        }
        checkMutexStatus()
        unsafe {
            multiConditionMonitorNotify(this, condID.waitQueue)
        }
    }

    /**
     * @brief Wake up all threads waiting on this mutex (no particular admission policy implied)
     * @throws IllegalSynchronizationStateException if current thread does not hold this mutex
     * @throws IllegalSynchronizationStateException if `id` was not provided by `newCondition` of this MultiConditionMonitor instance
     */
    public func notifyAll(condID: ConditionID): Unit {
        if (!refEq(this, condID.monitor)) {
            throw IllegalSynchronizationStateException("Invalid condition.")
        }
        checkMutexStatus()
        unsafe {
            multiConditionMonitorNotifyAll(this, condID.waitQueue)
        }
    }
}
