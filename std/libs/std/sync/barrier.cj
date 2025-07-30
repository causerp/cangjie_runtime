/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.sync

public class Barrier {
    // We use `SyncCounter` to implement `Barrier`
    private let syncCounter: SyncCounter

    /**
     * Construct a barrier with an initial value.
     * @throw IllegalArgumentException, if `count` is negative.
     */
    public init(count: Int64) {
        syncCounter = SyncCounter(count)
    }

    /**
     * Decrease the count.
     * If the count becomes zero, wake up all blocked threads,
     * Otherwise, the current thread waits until the count becomes zero or `timeout` passed.
     * If the count is zero, it has no effects.
     * All events before `countDown()` happens-before events after `countDownAndWait()`.
     * NOTE: `timeout` should be `Duration.Max` by default,
     * however, the value `Duration.Max` is not supported currently.
     */
    public func wait(timeout!: Duration = Duration.Max): Unit {
        syncCounter.dec()
        syncCounter.waitUntilZero(timeout: timeout)
    }
}
