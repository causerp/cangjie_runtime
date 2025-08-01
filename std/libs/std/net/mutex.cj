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
        let m = Monitor()
        let useCounter = AtomicInt64(0) // positive = read count, -1 - write

        this.readMutex = NonReentrantReadLock(m, useCounter)
        this.writeMutex = NonReentrantWriteLock(m, useCounter)
    }
}

struct NonReentrantReadLock <: IReentrantMutex {
    NonReentrantReadLock(
        private let m: Monitor,
        private let useCounter: AtomicInt64
    ) {}

    public override func lock(): Unit {
        if (!tryLock()) {
            lockSlowpath()
        }
    }

    private func lockSlowpath(): Unit {
        synchronized(m) {
            while (!tryLock()) {
                m.wait()
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
            synchronized(m) {
                m.notify()
            }
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

struct NonReentrantWriteLock <: IReentrantMutex {
    NonReentrantWriteLock(
        private let m: Monitor,
        private let useCounter: AtomicInt64
    ) {}

    init() {
        this(Monitor(), AtomicInt64(0))
    }

    public override func lock(): Unit {
        if (!tryLock()) {
            lockSlowpath()
        }
    }

    private func lockSlowpath(): Unit {
        synchronized(m) {
            while (!tryLock()) {
                m.wait()
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
            m.notify()
        }
    }

    private static const WRITER_MARK = -1
    private static func hasActiveCompetetors(count: Int64): Bool {
        count != 0
    }
}
