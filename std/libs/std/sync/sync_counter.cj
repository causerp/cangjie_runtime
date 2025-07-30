/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.sync

public class SyncCounter {
    // Since there is a `prop` to read this field, we should make it atomic.
    private var countValue: AtomicInt64
    private let syncList: SyncList

    /**
     * Construct a counter with an initial value.
     * @throw IllegalArgumentException, if `count` is negative.
     */
    public init(count: Int64) {
        if (count < 0) {
            throw IllegalArgumentException("Negative count.")
        }
        countValue = AtomicInt64(count)
        syncList = SyncList()
    }

    /**
     * Get the remaining count.
     */
    public prop count: Int64 {
        get() {
            return countValue.load()
        }
    }

    /**
     * Decrease the count.
     * If the count becomes zero, wake up all blocked threads.
     * If the count is equal or less than zero, it has no effects.
     */
    public func dec(): Unit {
        if (countValue.load() <= 0) {
            return
        }
        let oldValue = countValue.fetchSub(1)
        if (oldValue == 1) { // Case 1: The count becomes zero
            syncList.notifyAll()
        }
        // Case 2: Otherwise, there are still available counts; do nothing
    }

    /**
     * Wait until the count becomes zero or `timeout` passed.
     * If the count is zero, it will never be blocked.
     * All events before `dec()` happens-before events after `waitUntilZero()`.
     * NOTE: `timeout` should be `Duration.Max` by default,
     * however, the value `Duration.Max` is not supported currently.
     */
    public func waitUntilZero(timeout!: Duration = Duration.Max): Unit {
        syncList.waitIf({=> countValue.load() > 0}, timeout: timeout)
    }
}
