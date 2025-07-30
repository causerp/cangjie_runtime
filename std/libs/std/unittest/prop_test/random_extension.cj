/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest.prop_test

import std.random.Random

/**
 * Some very basic extensions for Random
 */
extend Random {
    public func pick<T>(choices: Array<T>): T {
        choices[nextInt64(choices.size)]
    }
    public func pickWeighted<T>(choices: WeightTable<T>): T {
        choices[nextInt64(Int64(choices.total))]
    }
}

class WeightTable<T> {
    public let total: UInt64
    public WeightTable(let choices: Array<(UInt64, T)>) {
        var temp: UInt64 = 0
        for ((w, _) in choices) {
            temp += w
        }
        this.total = temp
    }
    public operator func [](index: Int64): T {
        var temp = UInt64(index)
        for ((n, g) in choices) {
            if (temp < n) {
                return g
            }

            temp -= n
        }
        return choices[choices.size - 1][1]
    }
}
