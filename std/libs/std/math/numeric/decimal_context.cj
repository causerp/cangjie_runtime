/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.math.numeric

/**
 * Three strategies to handle overflows when converting BigDecimal to integer:
 * - Throwing: Throwing Overflow exception;
 * - Wrapping: Wrapping around at the numeric bounds of the type;
 * - Saturating: Saturating at the numeric bounds of the type
 */
public enum OverflowStrategy <: Equatable<OverflowStrategy> & ToString {
    | Saturating
    | Throwing
    | Wrapping

    public operator func ==(that: OverflowStrategy): Bool {
        return match ((this, that)) {
            case (Saturating, Saturating) => true
            case (Throwing, Throwing) => true
            case (Wrapping, Wrapping) => true
            case _ => false
        }
    }

    public func toString(): String {
        return match (this) {
            case Saturating => "Saturating"
            case Throwing => "Throwing"
            case Wrapping => "Wrapping"
        }
    }
}
