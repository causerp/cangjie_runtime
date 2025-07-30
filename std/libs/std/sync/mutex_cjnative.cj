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
 * @brief Base class for built-in reentrant mutual exclusion concurrency primitives.
 * Instance of the Lock interface can be passed as arguments to `synchronized` expression,
 * which is equivalent to the following transformation
 *        source code      |        semantics
 * ------------------------------------------------------
 *   synchronized(m) {     |  try { m.lock()
 *     foo()               |    foo()
 *   }                     |  } finally { m.unlock() }
 */
public class Mutex <: UniqueLock {
    /*
     * @throws IllegalSynchronizationStateException if `ptr` is null
     */
    public init() {
        var isNull = mutexInit(this)
        if (isNull) {
            throw IllegalSynchronizationStateException("Mutex initialization failure.")
        }
    }

    /**
     * @brief Acquire the ownership of the lock, blocks if the lock is not available.
     * Support reentrant.
     */
    public func lock(): Unit {
        mutexLock(this)
    }

    /**
     * @brief Try to lock the mutex.
     * @return false if the lock is not available;
     * @return returns true, otherwise.
     */
    public func tryLock(): Bool {
        return mutexTryLock(this)
    }

    /**
     * @brief Unlock the mutex.
     * If there are other threads blocking on this lock, then wake up one of them.
     * @throws IllegalSynchronizationStateException if the current thread does not hold the lock.
     */
    public func unlock(): Unit {
        checkMutexStatus()
        mutexUnlock(this)
    }

    /**
     * @brief Generate a Condition instance for the mutex.
     * @throws IllegalSynchronizationStateException if the current thread does not hold the lock.
     */
    public func condition(): Condition {
        checkMutexStatus()
        return MutexCondition(this)
    }

    /**
     * @throws IllegalSynchronizationStateException if the current thread does not hold the lock.
     */
    func checkMutexStatus(): Unit {
        let status = mutexCheckStatus(this)
        if (!status) {
            throw IllegalSynchronizationStateException("Mutex is not locked by current thread.")
        }
    }
}

/**
 * Class that encapsulates single reentrant mutex and single condition instance (a.k.a. wait queue) associated with this mutex.
 */
class MutexCondition <: Condition {
    private let condition: Monitor

    init(mutex: Mutex) {
        condition = Monitor(mutex)
    }

    /**
     * @brief Block until paired `notify` is invoked.
     * @throws IllegalSynchronizationStateException if current thread does not hold this mutex
     */
    public func wait(): Unit {
        condition.checkMutexStatus()
        monitorWait(condition, MAX_TIMEOUT_NS)
    }

    /**
     * @brief Block until paired `notify` is invoked or `timeout` passed.
     * @return `true` if event was signalled by other thread;
     * @return `false` on timeout, otherwise.
     * @throws IllegalSynchronizationStateException if current thread does not hold this mutex
     * @throws IllegalArgumentException if `timeout <= Duration.Zero`
     */
    public func wait(timeout!: Duration): Bool {
        let timeoutNanos = getTimeoutNanos(timeout)
        condition.checkMutexStatus()
        return monitorWait(condition, timeoutNanos)
    }

    /**
     * @brief Block until paired `notify` is invoked and the `predicate` return true, or the `predicate` always return ture.
     * @throws IllegalSynchronizationStateException if current thread does not hold this mutex
     */
    public func waitUntil(predicate: () -> Bool): Unit {
        condition.checkMutexStatus()
        while (!predicate()) {
            monitorWait(condition, MAX_TIMEOUT_NS)
        }
    }

    /**
     * @brief Block until paired `notify` is invoked and the `predicate` return true, or the `predicate` always return ture, or `timeout` passed.
     * @throws IllegalSynchronizationStateException if current thread does not hold this mutex
     */
    public func waitUntil(predicate: () -> Bool, timeout!: Duration): Bool {
        let timeoutNanos = getTimeoutNanos(timeout)
        condition.checkMutexStatus()

        let startTime = MonoTime.now()
        var spentTime = 0
        while (!predicate()) {
            if (spentTime >= timeoutNanos) { // timeout
                return false
            }

            let success = monitorWait(condition, timeoutNanos - spentTime)
            if (!success) { // timeout
                return false
            }
            spentTime = (MonoTime.now() - startTime).toNanoseconds()
        }
        return true
    }

    /**
     * @brief Wake up a single thread waiting on this mutex (no particular admission policy implied).
     * @throws IllegalSynchronizationStateException if current thread does not hold this mutex
     */
    public func notify(): Unit {
        condition.checkMutexStatus()
        monitorNotify(condition)
    }

    /**
     * @brief Wake up all threads waiting on this mutex (no particular admission policy implied).
     * @throws IllegalSynchronizationStateException if current thread does not hold this mutex
     */
    public func notifyAll(): Unit {
        condition.checkMutexStatus()
        monitorNotifyAll(condition)
    }

    func getTimeoutNanos(timeout: Duration): Int64 {
        if (timeout <= Duration.Zero) {
            throw IllegalArgumentException("Timeout cannot be less than or equal to `Duration.Zero`.")
        }
        return match (timeout > MAX_TIMEOUT_DURATION) {
            case true => MAX_TIMEOUT_NS
            case false => timeout.toNanoseconds()
        }
    }
}
