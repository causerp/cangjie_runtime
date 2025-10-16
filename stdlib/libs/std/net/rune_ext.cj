/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.net

import std.overflow.*

extend Byte {
    func toDigit(radix: UInt32): ?UInt32 {
        var digit = UInt32(this).wrappingSub(UInt32(b'0'))
        if (radix > 10) {
            if (digit < 10) {
                return digit
            }
            digit = (UInt32(this) | 0b10_0000).wrappingSub(UInt32(b'a')).saturatingAdd(10)
        }
        if (digit < radix) {
            return digit
        }
        None
    }
}
