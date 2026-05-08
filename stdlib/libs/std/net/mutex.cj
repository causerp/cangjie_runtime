/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.net

import std.sync.*

/**
 * Custom non-reentrant read-write mutex.
 *
 * The default RW-mutex implementation does a lot of work for tracking
 * reentrancy and check different cases. Unfortunately, it's relatively expensive so
 * we are introducing this implementation that does atomic-check first and does deleate to
 * the original implemnentation as a fallback (slowpath). So in the most common scenario for sockets
 * we don't have any real concurrency so it will never go that deep.
 * We sacrify features that we don't need in our current use-scenario to gain performance.
 */
struct NonReentrantReadWriteMutex {
    let readMutex: NonReentrantReadLock
    let writeMutex: NonReentrantWriteLock

    init() {
        let m = Mutex()
        let useCounter = AtomicInt64(0) // positive = read count, -1 - write

        let condition = synchronized(m) { m.condition() }
        this.readMutex = NonReentrantReadLock(m, useCounter, condition)
        this.writeMutex = NonReentrantWriteLock(m, useCounter, condition)
    }
}

struct NonReentrantReadLock <: Lock {
    NonReentrantReadLock(
        private let m: Mutex,
        private let useCounter: AtomicInt64,
        private let condition: Condition
    ) {
    }

    public override func lock(): Unit {
        if (!tryLock()) {
            lockSlowpath()
        }
    }

    private func lockSlowpath(): Unit {
        synchronized(m) {
            while (!tryLock()) {
                condition.wait()
            }
        }
    }

    public override func tryLock(): Bool {
        while (true) {
            let current = useCounter.load()
            if (hasActiveWriter(current)) {
                break
            }
            if (useCounter.compareAndSwap(current, current + 1)) {
                return true
            }
        }

        return false
    }

    public override func unlock(): Unit {
        if (decrementAndGet() == 0) {
            // we need to notify only when the last reader leaves its lock so that's why it's under the if-check
            notifyWriters()
        }
    }

    private func notifyWriters() {
        synchronized(m) {
            // if we are unlocking the read lock, it means that the other readers would't block at all
            // so there are no readers to notify
            // however, there can be writer candidates waiting for all active readers to leave the read lock
            // only one writer can work concurrently so it's safe to notify only a single one
            // that's why we don't need notifyAll here
            condition.notify()
        }
    }

    @OverflowWrapping
    private func decrementAndGet(): Int64 {
        var value: Int64 = 0

        do {
            let before = useCounter.load()
            if (before <= 0) {
                beforeCheckFailed()
            }
            let newValue = before - 1
            if (useCounter.compareAndSwap(before, newValue)) {
                value = newValue
                break
            }
        } while (true)

        return value
    }

    private static func beforeCheckFailed(): Nothing {
        throw IllegalStateException("Unbalanced lock-unlock invocations")
    }

    private static func hasActiveWriter(counter: Int64) {
        counter < 0
    }
}

struct NonReentrantWriteLock <: Lock {
    NonReentrantWriteLock(
        private let m: Mutex,
        private let useCounter: AtomicInt64,
        private let condition: Condition
    ) {
    }

    init() {
        this.m = Mutex()
        this.useCounter = AtomicInt64(0)
        this.condition = synchronized(m) { m.condition() }
    }

    public override func lock(): Unit {
        if (!tryLock()) {
            lockSlowpath()
        }
    }

    private func lockSlowpath(): Unit {
        synchronized(m) {
            while (!tryLock()) {
                condition.wait()
            }
        }
    }

    public override func tryLock(): Bool {
        while (true) {
            let current = useCounter.load()
            if (hasActiveCompetetors(current)) {
                break
            }

            if (useCounter.compareAndSwap(current, WRITER_MARK)) {
                return true
            }
            break
        }

        return false
    }

    public override func unlock(): Unit {
        useCounter.compareAndSwap(WRITER_MARK, 0)
        synchronized(m) {
            // note: there can be multiple read lock candidates, we need to notify them all
            condition.notifyAll()
        }
    }

    private static const WRITER_MARK = -1
    private static func hasActiveCompetetors(count: Int64): Bool {
        count != 0
    }
}
