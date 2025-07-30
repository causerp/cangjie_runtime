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
 * This file defines cjnative utils functions of time class.
 */

package std.time

/**
 * Implemented in runtime, it returns seconds, nanoseconds.
 *
 * @return a instance representing a native clock.
 *
 * @since 0.18.4
 */
@FastNative
foreign func CJ_TIME_Now(): NativeClock

@FastNative
foreign func CJ_TIME_MonotonicNow(): NativeClock

/**
 * Get current unix second, unix nanosecond and monotonic ticks.
 *
 * @return a tuple containing second, nanosecond, monotonic second.
 *
 * @since 0.18.4
 */
func systemNow(): (Int64, Int64) {
    let nc = unsafe { CJ_TIME_Now() }
    return (nc.sec, nc.nanosec)
}

func monoNow(): (Int64, Int64) {
    let nc = unsafe { CJ_TIME_MonotonicNow() }
    return (nc.sec, nc.nanosec)
}
