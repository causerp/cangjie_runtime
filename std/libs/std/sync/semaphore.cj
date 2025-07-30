/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.sync

public class Semaphore {
    // Since there is a `prop` to read this field, we should make it atomic.
    private var countValue: AtomicInt64
    private let monitor: Monitor
    private let initValue: Int64

    /**
     * Construct a semephore with an initial value.
     * Throw IllegalArgumentException, if `count` is negative.
     */
    public init(count: Int64) {
        if (count < 0) {
            throw IllegalArgumentException("Negative count.")
        }
        initValue = count
        countValue = AtomicInt64(count)
        monitor = Monitor()
    }

    /**
     * Return the current available counts.
     */
    public prop count: Int64 {
        get() {
            return countValue.load()
        }
    }

    /**
     * Acquire `amount` from the semaphore.
     * If there is no sufficient available counts,
     * the current thread will be blocked until enough counts become available.
     * The acquisition is atomic, which means it will never acquire partial counts before blocked.
     * Throw IllegalArgumentException, if `amount` is negative or larger than the initial value.
     * The acquisition order is not guranteed under contention.
     */
    public func acquire(amount!: Int64 = 1): Unit {
        if (amount < 0 || amount > initValue) {
            throw IllegalArgumentException("Invalid amount to acquire.")
        }
        synchronized(monitor) {
            while (countValue.load() < amount) {
                monitor.wait()
            }
            countValue.fetchSub(amount)
        }
    }

    /**
     * Try to acquire `amount` from the semaphore.
     * If there is no sufficient available counts, return false;
     * otherwise, return true.
     * Throw IllegalArgumentException, if `amount` is negative or larger than the initial value.
     */
    public func tryAcquire(amount!: Int64 = 1): Bool {
        if (amount < 0 || amount > initValue) {
            throw IllegalArgumentException("Invalid amount to acquire.")
        }
        synchronized(monitor) {
            if (countValue.load() < amount) {
                return false
            } else {
                countValue.fetchSub(amount)
                return true
            }
        }
    }

    /**
     * Release `amount` to the semaphore.
     * Wake blocked threads if there are enough counts for them.
     * The number of accumulated counts will never exceed the initial value.
     * Throw IllegalArgumentException, if `amount` is negative or larger than the initial value.
     * All events before `release()` happens-before events after `acquire/tryAcquire()`.
     */
    public func release(amount!: Int64 = 1): Unit {
        if (amount < 0 || amount > initValue) {
            throw IllegalArgumentException("Invalid amount to acquire.")
        }
        synchronized(monitor) {
            let oldValue = countValue.load()
            let newValue = oldValue + amount
            // The new value to store cannot exceed the initial value.
            if (newValue > initValue) {
                countValue.store(initValue)
            } else {
                countValue.store(newValue)
            }
            monitor.notifyAll()
        }
    }
}
