/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.sync

import std.time.MonoTime

/**
 * Class that encapsulates single reentrant mutex and single condition instance (a.k.a. wait queue) associated with this mutex.
 */
public class ConditionMonitor <: Condition {
    private let mutex: Mutex

    public init() {
        this.mutex = Mutex()
        var isNull = unsafe { monitorInit(this) }
        if (isNull) {
            throw IllegalSynchronizationStateException("Initialization failed.")
        }
    }

    init(mutex: Mutex) {
        this.mutex = mutex
        let isNull = unsafe { monitorInit(this) }
        if (isNull) {
            throw IllegalSynchronizationStateException("Initialization failed.")
        }
    }

    /**
     * @brief Block until paired `notify` is invoked.
     * @throws IllegalSynchronizationStateException if current thread does not hold this mutex
     */
    public func wait(): Unit {
        this.wait(timeout: Duration.Max)
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
     * @brief Block until paired `notify` is invoked and the `predicate` return true, or the `predicate` always return ture.
     * @throws IllegalSynchronizationStateException if current thread does not hold this mutex
     */
    public func waitUntil(predicate: () -> Bool): Unit {
        checkMutexStatus()
        while (!predicate()) {
            this.wait()
        }
    }

    /**
     * @brief Block until paired `notify` is invoked and the `predicate` return true, or the `predicate` always return ture, or `timeout` passed.
     * @throws IllegalSynchronizationStateException if current thread does not hold this mutex
     */
    public func waitUntil(predicate: () -> Bool, timeout!: Duration): Bool {
        if (timeout <= Duration.Zero) {
            throw IllegalArgumentException("Timeout cannot be less than or equal to `Duration.Zero`.")
        }
        checkMutexStatus()

        let startTime = MonoTime.now()
        var spentTime = Duration.Zero
        while (!predicate()) {
            if (spentTime >= timeout) { // timeout
                return false
            }

            let success = wait(timeout: timeout - spentTime)
            if (!success) { // timeout
                return false
            }
            spentTime = MonoTime.now() - startTime
        }
        return true
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

    /**
     * @throws IllegalSynchronizationStateException if the current thread does not hold the lock.
     */
    func checkMutexStatus(): Unit {
        let status = mutexCheckStatus(this.mutex)
        if (!status) {
            throw IllegalSynchronizationStateException("Mutex is not locked by current thread.")
        }
    }
}