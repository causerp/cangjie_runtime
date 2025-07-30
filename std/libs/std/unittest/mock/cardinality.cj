/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest.mock

class Cardinality {
    Cardinality(
        let min!: Int64,
        let max!: ?Int64 = None
    ) {
        require(min >= 0) { "Minimum number of invocation must be a non-negative number, was: ${min}" }
        if (let Some(max) <- max) {
            require(max >= 0) { "Maximum number of invocation must be a non-negative number, was: ${max}" }
            require(max >= min) {
                "Maximum number of invocation should be greater or equal to minimum, was: min = ${min}, max = ${max}"
            }
        }
    }

    func check(timesInvoked: Int64): CardinalityCheck {
        if (timesInvoked < min) { return CardinalityCheck.Less }
        if (let Some(max) <- max) {
            if (timesInvoked > max) {
                return CardinalityCheck.More
            }
        }
        return CardinalityCheck.Ok
    }

    public static func once() { Cardinality(min: 1, max: 1) }
    public static func atLeastTimes(minTimes: Int64) { Cardinality(min: minTimes) }
    public static func atLeastOnce() { atLeastTimes(1) }
    public static func times(min!: Int64, max!: Int64) { Cardinality(min: min, max: max) }
    public static func times(timesExactly: Int64) { times(min: timesExactly, max: timesExactly) }
    public static func never() { times(min: 0, max: 0) }
}

enum CardinalityCheck {
    Less | Ok | More
}

func require(condition: Bool, message: () -> String) {
    if (!condition) {
        throw IllegalArgumentException(message())
    }
}
