/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest.diff

import std.unittest.common.PrettyPrinter

extend String <: AssertPrintable<String> {
    public prop hasNestedDiff: Bool {
        get() { false }
    }
    public func pprintForAssertion(pp: PrettyPrinter, right: String, leftPrefix: String, rightPrefix: String,
        level: Int64): PrettyPrinter {
        return pp.pprintStringDiff(this, right, leftPrefix, rightPrefix, level)
    }
}

extend PrettyPrinter {
    func pprintStringDiff(left: String, right: String, leftPrefix: String, rightPrefix: String, level: Int64) {
        if (left.contains("\n") || right.contains("\n")) {
            if (level == 1) {
                pprintNotEqual(leftPrefix, rightPrefix).appendLine(" (multiline difference below)")
            } else {
                appendLine("Multiline difference:")
            }
            printMultilineDiff(left, right)
        } else {
            let q = "\""
            if (level == 1) {
                pprintNotEqual(leftPrefix, rightPrefix).newLine()
                indent {
                    printOneLineDiff(left, right, leftPrefix: leftPrefix + ": ${q}", rightPrefix: rightPrefix + ": ${q}",
                        leftSuffix: q, rightSuffix: q)
                }
            } else {
                printOneLineDiff(left, right, leftPrefix: leftPrefix + ": ${q}", rightPrefix: rightPrefix + ": ${q}",
                    leftSuffix: q, rightSuffix: q)
            }
        }
        return this
    }
}
