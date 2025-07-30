/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.math.numeric

import std.convert.*

extend Decimal <: Parsable<Decimal> {
    public static func parse(value: String): Decimal {
        return Decimal(value)
    }

    public static func tryParse(value: String): ?Decimal {
        try {
            parse(value)
        } catch (e: Exception) {
            return None
        }
    }
}

extend Decimal <: Formattable {
    public func format(fmt: String): String {
        return this.toFloat64().format(fmt)
    }
}
