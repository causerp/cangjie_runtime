/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest.diff

import std.convert.Formattable
import std.math.ceil
import std.unittest.common.PrettyPrinter

interface AssertPrintableFloat<F> where F <: AnyFloat & Formattable & ToString & Equatable<F> {
    /*
     * To print the shortest form of float number, we use r'g' specifier which also removes all trailing zeros,
     * there is no way to configure this behaviour specifically,
     * but we need to keep the fractional part even it's empty to highlight that it's a floating-point number,
     * so for empty fractional part, we add ".0" explicitly.
     */
    static func addTrailingPointZeroIfNeeded(floatStr: String) {
        if (!floatStr.contains(".") && !floatStr.contains("e")) {
            floatStr + ".0"
        } else {
            floatStr
        }
    }

    static func pprint(left: F, right: F, delta: F, pp: PrettyPrinter, leftPrefix: String, rightPrefix: String,
        level: Int64): PrettyPrinter {
        if (level == 1) {
            pp.pprintNotEqual(leftPrefix, rightPrefix).newLine()
        }

        var sigDigits = 6
        let isLeftSpecialValue = left.isNaN() || left.isInf()
        let isRightSpecialValue = right.isNaN() || right.isInf()

        if (isLeftSpecialValue || isRightSpecialValue) {
            let leftStr = if (isLeftSpecialValue) { left.toString() } else {
                addTrailingPointZeroIfNeeded(left.format(".${sigDigits}g"))
            }
            let rightStr = if (isRightSpecialValue) { right.toString() } else {
                addTrailingPointZeroIfNeeded(right.format(".${sigDigits}g"))
            }
            return pp.pprintFloatDiff(leftStr, rightStr, Option<String>.None, leftPrefix, rightPrefix)
        }

        var leftStr = left.format(".${sigDigits}g")
        var rightStr = right.format(".${sigDigits}g")
        var deltaStr = delta.format(".${sigDigits}g")

        while (leftStr == rightStr && deltaStr != "." && sigDigits <= 50) {
            sigDigits = Int64(ceil(Float64(sigDigits) * 3.0 / 2.0))
            leftStr = left.format(".${sigDigits}g")
            rightStr = right.format(".${sigDigits}g")
            deltaStr = delta.format(".${sigDigits}g")
        }

        return pp.pprintFloatDiff(
            addTrailingPointZeroIfNeeded(leftStr),
            addTrailingPointZeroIfNeeded(rightStr),
            addTrailingPointZeroIfNeeded(deltaStr),
            leftPrefix,
            rightPrefix)
    }
}

extend<T> Array<T> where T <: Comparable<T> {
    func max() {
        var result = this[0]
        for (e in this) {
            if (e > result) {
                result = e
            }
        }
        result
    }
}

extend PrettyPrinter {
    func pprintFloatDiff(leftStr: String, rightStr: String, deltaStrOpt: Option<String>, leftPrefix: String,
        rightPrefix: String): PrettyPrinter {
        let leftRightSize = UInt64([leftPrefix.size, rightPrefix.size, 4].max()) + 1
        let deltaStr = deltaStrOpt ?? return appendRightAligned(leftPrefix, leftRightSize)
            .append(": ")
            .colored(RED, leftStr)
            .newLine()
            .appendRightAligned(rightPrefix, leftRightSize)
            .append(": ")
            .colored(RED, rightStr)
            .newLine()

        let (commonPrefixLen, _) = OneLineDiffBuilder.commonPrefix(leftStr, rightStr)
        let size = max(leftRightSize, UInt64("delta".size) + 1)

        return appendRightAligned(leftPrefix, size)
            .append(": ")
            .append(leftStr[..commonPrefixLen])
            .colored(RED, leftStr[commonPrefixLen..])
            .newLine()
            .appendRightAligned(rightPrefix, size)
            .append(": ")
            .append(rightStr[..commonPrefixLen])
            .colored(RED, rightStr[commonPrefixLen..])
            .newLine()
            .appendRightAligned("delta", size)
            .append(": ")
            .colored(YELLOW, deltaStr)
            .newLine()
    }
}

// Below are temporary hacks to workaround a compiler issue
// related to produced wrong symbols for floats (further, linker failed)
// in case of extending them by `AssertPrintableFloat` directly

interface AnyFloat {
    func isNaN(): Bool
    func isInf(): Bool
}

extend Float16 <: AnyFloat {}

extend Float32 <: AnyFloat {}

extend Float64 <: AnyFloat {}

extend Float16 <: AssertPrintable<Float16> {
    public prop hasNestedDiff: Bool {
        get() { false }
    }
    public func pprintForAssertion(pp: PrettyPrinter, right: Float16, leftPrefix: String, rightPrefix: String,
        level: Int64): PrettyPrinter {
        return AssertPrintableFloat<Float16>.pprint(this, right, this - right, pp, leftPrefix, rightPrefix, level)
    }
}

extend Float32 <: AssertPrintable<Float32> {
    public prop hasNestedDiff: Bool {
        get() { false }
    }
    public func pprintForAssertion(pp: PrettyPrinter, right: Float32, leftPrefix: String, rightPrefix: String,
        level: Int64): PrettyPrinter {
        return AssertPrintableFloat<Float32>.pprint(this, right, this - right, pp, leftPrefix, rightPrefix, level)
    }
}

extend Float64 <: AssertPrintable<Float64> {
    public prop hasNestedDiff: Bool {
        get() { false }
    }
    public func pprintForAssertion(pp: PrettyPrinter, right: Float64, leftPrefix: String, rightPrefix: String,
        level: Int64): PrettyPrinter {
        return AssertPrintableFloat<Float64>.pprint(this, right, this - right, pp, leftPrefix, rightPrefix, level)
    }
}
