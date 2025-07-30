/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.sync

/**
 * @brief Base interface for reentrant mutual exclusion concurrency primitives.
 *
 * Instance of the Lock interface can be passed as arguments to `synchronized` expression,
 * which is equivalent to the following transformation
 *        source code      |        semantics
 * ------------------------------------------------------
 *   synchronized(l) {     |  try { l.lock()
 *     foo()               |    foo()
 *   }                     |  } finally { l.unlock() }
 */
public interface Lock {
    /**
     * @brief Acquire the ownership of the lock, blocks if the lock is not available.
     * Support reentrant.
     */
    func lock(): Unit

    /**
     * @brief Try to lock the mutex.
     * @return false if the lock is not available;
     * @return returns true, otherwise.
     */
    func tryLock(): Bool

    /**
     * @brief Unlock the mutex.
     * If there are other threads blocking on this lock, then wake up one of them.
     * @throws IllegalSynchronizationStateException if the current thread does not hold the lock.
     */
    func unlock(): Unit
}

public interface UniqueLock <: Lock {
    /**
     * @brief Generate a Condition instance for the mutex.
     * @throws IllegalSynchronizationStateException if the current thread does not hold the lock.
     */
    func condition(): Condition
}

/**
 * Condition (a.k.a. wait queue) associated with a mutex.
 */
public interface Condition {
    /**
     * @brief Block until paired `notify` is invoked.
     * @throws IllegalSynchronizationStateException if current thread does not hold this mutex
     */
    func wait(): Unit

    /**
     * @brief Block until paired `notify` is invoked or `timeout` passed.
     * @return `true` if event was signalled by other thread;
     * @return `false` on timeout, otherwise.
     * @throws IllegalSynchronizationStateException if current thread does not hold this mutex
     * @throws IllegalArgumentException if `timeout <= Duration.Zero`
     */
    func wait(timeout!: Duration): Bool

    /**
     * @brief Block until paired `notify` is invoked and the `predicate` return true, or the `predicate` always return ture.
     * @throws IllegalSynchronizationStateException if current thread does not hold this mutex
     */
    func waitUntil(predicate: () -> Bool): Unit

    /**
     * @brief Block until paired `notify` is invoked and the `predicate` return true, or the `predicate` always return ture, or `timeout` passed.
     * @throws IllegalSynchronizationStateException if current thread does not hold this mutex
     */
    func waitUntil(predicate: () -> Bool, timeout!: Duration): Bool

    /**
     * @brief Wake up a single thread waiting on this mutex (no particular admission policy implied).
     * @throws IllegalSynchronizationStateException if current thread does not hold this mutex
     */
    func notify(): Unit

    /**
     * @brief Wake up all threads waiting on this mutex (no particular admission policy implied).
     * @throws IllegalSynchronizationStateException if current thread does not hold this mutex
     */
    func notifyAll(): Unit
}
