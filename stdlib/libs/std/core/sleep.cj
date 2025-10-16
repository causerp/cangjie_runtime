/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/**
 * @file
 *
 * This file defines the global function sleep.
 */
package std.core

const MAX_TIMEOUT_NS: Int64 = 0x7FFF_FFFF_FFFF_FFFF
let MAX_TIMEOUT_DURATION: Duration = Duration.nanosecond * MAX_TIMEOUT_NS

@Intrinsic
func intrinsicSleep(ns: Int64): Unit

/**
 * Sleep current thread for @p dur interval.
 * If @p dur is less than or equal to Duration.Zero, current thread will relinquish the run right.
 *
 * @param dur Sleeping duration.
 */
public func sleep(dur: Duration): Unit {
    let nanos = if (dur > MAX_TIMEOUT_DURATION) {
        MAX_TIMEOUT_NS
    } else if (dur < Duration.Zero) {
        0
    } else {
        dur.toNanoseconds()
    }
    intrinsicSleep(nanos)
}
