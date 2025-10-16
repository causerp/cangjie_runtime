/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest.diff

import std.collection.ArrayList
import std.unittest.common.*

struct SampledAssertValue {
    let sampledStr: String
    let endingOmitted: Bool
    let beginningOmittedCharsAmount: Int64

    init(sampledStr: String, endingOmitted!: Bool = false, beginningOmittedCharsAmount!: Int64 = 0) {
        this.sampledStr = sampledStr
        this.endingOmitted = endingOmitted
        this.beginningOmittedCharsAmount = beginningOmittedCharsAmount
    }

    func addPrefixAndSuffix(out: ArrayList<Rune>): (Int64, Int64) {
        var prefixLen = 0
        var suffixLen = 0

        if (beginningOmittedCharsAmount != 0) {
            let prefix = getOmittedPrefix().toRuneArray()
            for (i in 1..prefix.size + 1) {
                out.add(prefix[prefix.size - i], at: 0)
            }
            prefixLen = prefix.size
        }

        if (endingOmitted) {
            out.add(r'.')
            out.add(r'.')
            out.add(r'.')
            suffixLen = 3
        }

        return (prefixLen, suffixLen)
    }

    private func getOmittedPrefix(): String {
        if (beginningOmittedCharsAmount != 0) {
            "(${beginningOmittedCharsAmount.toString()} characters omitted...)"
        } else { "" }
    }
}

enum Edit<T> {
    | Insert(T)
    | Remove(T)
    | Keep(T)
    | Modify(T, T)
}

extend PrettyPrinter {
    func pprintNotEqual(left: String, right: String, needToQuote!: Bool = false): PrettyPrinter {
        if (needToQuote) { append("\"").colored(YELLOW, left).append("\"") } else { colored(YELLOW, left) }
        append(" != ")
        if (needToQuote) { append("\"").colored(YELLOW, right).append("\"") } else { colored(YELLOW, right) }
    }

    func pprintLeftRight(left: Any, right: Any, leftPrefix: String, rightPrefix: String) {
        pprintNotEqual(leftPrefix, rightPrefix).newLine()
        indent {
            appendRightAligned("left", 5).appendLine(": ${toStringOrPlaceholder(left)}")
            appendRightAligned("right", 5).append(": ${toStringOrPlaceholder(right)}")
        }
    }

    func pprintForAssertionOrSimple<T>(left: T, right: T, leftPrefix: String, rightPrefix: String, level: Int64) {
        match (left) {
            case l: AssertPrintable<T> =>
                match (right) {
                    case r: AssertPrintable<T> => l.pprintForAssertion(this, right, leftPrefix, rightPrefix, level)
                    case _ => pprintLeftRight(left, right, leftPrefix, rightPrefix)
                }
            case _ => pprintLeftRight(left, right, leftPrefix, rightPrefix)
        }
    }
}
