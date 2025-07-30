/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.sync

/**
 * @brief Base class for built-in reentrant mutual exclusion concurrency primitives.
 * ReentrantMutex and its subclasses instances can be passed as arguments to `synchronized` expression,
 * which is equivalent to the following transformation
 *        source code      |        semantics
 * ------------------------------------------------------
 *   synchronized(m) {     |  try { m.lock()
 *     foo()               |    foo()
 *   }                     |  } finally { m.unlock() }
 */
@Deprecated[message: "Use `public class Mutex` instead."]
public open class ReentrantMutex <: Lock {
    private let mutex: Mutex

    /* @throws IllegalSynchronizationStateException if the Mutex initialization is failed.*/
    public init() {
        this.mutex = Mutex()
    }

    init(mutex: Mutex) {
        this.mutex = mutex
    }

    /**
     * @brief Acquire the ownership of the lock, blocks if the lock is not available.
     * Support reentrant.
     */
    public open func lock(): Unit {
        mutex.lock()
    }

    /**
     * @brief Try to lock the mutex.
     * @return false if the lock is not available;
     * @return returns true, otherwise.
     */
    public open func tryLock(): Bool {
        return mutex.tryLock()
    }

    /**
     * @brief Unlock the mutex.
     * If there are other threads blocking on this lock, then wake up one of them.
     * @throws IllegalSynchronizationStateException if the current thread does not hold the lock
     */
    public open func unlock(): Unit {
        mutex.unlock()
    }

    func checkMutexStatus(): Unit {
        mutex.checkMutexStatus()
    }
}
