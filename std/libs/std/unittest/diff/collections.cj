/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest.diff

import std.collection.*
import std.unittest.common.*

interface AssertPrintableCollection<C> <: AssertPrintable<C> where C <: AssertPrintableCollection<C> {
    prop size: Int64
    prop hasNestedDiff: Bool {
        get() { true }
    }

    func pprint(right: C, pp: PrettyPrinter, leftPrefix: String, rightPrefix: String, level: Int64): PrettyPrinter

    func pprintDifferentSizes(pp: PrettyPrinter, right: C, leftPrefix: String, rightPrefix: String) {
        if (this.size != right.size) {
            pp.append("Different sizes: ")
            pp
                .colored(YELLOW, toStringOrPlaceholder(this.size))
                .append("(${leftPrefix}) != ")
                .colored(YELLOW, toStringOrPlaceholder(right.size))
                .append("(${rightPrefix})")
                .newLine()
        }
    }

    func pprintForAssertion(
        pp: PrettyPrinter, right: C, leftPrefix: String, rightPrefix: String, level: Int64
    ): PrettyPrinter {
        if (level == 1) {
            pp.newLine()
            pp.indent {
                pprintDifferentSizes(pp, right, leftPrefix, rightPrefix)
                pprint(right, pp, leftPrefix, rightPrefix, level)
            }
        } else {
            pprintDifferentSizes(pp, right, leftPrefix, rightPrefix)
            pprint(right, pp, leftPrefix, rightPrefix, level)
        }
        return pp
    }
}

interface AssertPrintableOrderedCollection<C, E> <: AssertPrintableCollection<C> where C <: AssertPrintableOrderedCollection<C,
    E>, E <: Equatable<E> {
    func iterator(): Iterator<E>
    func computeFurtherDiffElements(leftIt: Iterator<E>, rightIt: Iterator<E>): Int64 {
        var furtherDifferentElements = 0
        while (true) {
            if ((leftIt.next() ?? break) != (rightIt.next() ?? break)) {
                furtherDifferentElements++
            }
        }
        return furtherDifferentElements
    }
    func pprint(right: C, pp: PrettyPrinter, leftPrefix: String, rightPrefix: String, level: Int64): PrettyPrinter {
        let leftIt = this.iterator()
        let rightIt = right.iterator()
        let diffText = PrettyText()
        var diffSize = 0

        for (i in 0..min(this.size, right.size)) {
            if (diffSize == 20) {
                diffText.appendLine(
                    "...further ${computeFurtherDiffElements(leftIt, rightIt)} different elements are omitted")
                break
            }
            let leftEl = leftIt.next() ?? throw Exception()
            let rightEl = rightIt.next() ?? throw Exception()

            if (!(leftEl != rightEl)) {
                continue
            }

            diffSize++

            diffText
                .append("[${i}]:")
                .pprintElementDiff(leftEl, rightEl, "${leftPrefix}", "${rightPrefix}", "[${i}]", level + 1)
        }

        if (!diffText.isEmpty()) {
            pp.appendLine("Different elements (left - ${leftPrefix}, right - ${rightPrefix}):").indent {
                pp.append(diffText)
            }
        }

        return pp
    }
}

extend<T> Array<T> <: AssertPrintableOrderedCollection<Array<T>, T> where T <: Equatable<T> {}

extend<T> ArrayList<T> <: AssertPrintableOrderedCollection<ArrayList<T>, T> where T <: Equatable<T> {}

extend<T> LinkedList<T> <: AssertPrintableOrderedCollection<LinkedList<T>, T> where T <: Equatable<T> {}

extend<T> HashSet<T> <: AssertPrintableCollection<HashSet<T>> where T <: Equatable<T> {
    public func pprint(right: HashSet<T>, pp: PrettyPrinter, leftPrefix: String, rightPrefix: String, _: Int64): PrettyPrinter {
        let lefties = ArrayList<T>()
        let righties = ArrayList<T>()

        for (k in this) {
            if (!right.contains(k)) {
                lefties.add(k)
            }
        }

        for (k in right) {
            if (!this.contains(k)) {
                righties.add(k)
            }
        }

        if (!righties.isEmpty()) {
            pp.pprintKeysDiff("elements", leftPrefix, righties, 20, 100)
        }

        if (!lefties.isEmpty()) {
            pp.pprintKeysDiff("elements", rightPrefix, lefties, 20, 100)
        }

        return pp
    }
}

// AssertPrintableMap couldn't be used directly in extend for maps due to CHIR-related bug in the compiler
// (in this case CHIR reports "chir checker error")
interface AssertPrintableMap<C, K, V> where C <: Map<K, V>, K <: Equatable<K> & Hashable, V <: Equatable<V> {
    static func prepareKey(k: K) {
        runIfToStringOrPlaceholder(k) { kStr =>
            let kStrTrimmed = if (kStr.size > 21 || kStr.contains("\n")) {
                kStr[0..20].replace("\n", " ") + "..."
            } else { kStr }
            match (k) {
                case _: String => quoteString(kStrTrimmed)
                case _ => kStrTrimmed
            }
        }
    }

    static func pprint(left: C, right: C, pp: PrettyPrinter, leftPrefix: String, rightPrefix: String, level: Int64): PrettyPrinter {
        let lefties = ArrayList<K>()
        let righties = ArrayList<K>()
        let diffText = PrettyText()
        var diffSize = 0
        var furtherDifferentElements = 0

        for ((k, v) in left.iterator()) {
            match (right.get(k)) {
                case None => lefties.add(k)
                case Some(vv) where v != vv =>
                    if (diffSize >= 20) {
                        furtherDifferentElements++
                        continue
                    }

                    diffText.pprintKey(toStringQuotedOrPlaceholder(k))
                    diffText.pprintElementDiff(
                        v, vv, "${leftPrefix}", "${rightPrefix}", "[${prepareKey(k)}]", level + 1)
                    diffSize++
                case _ => ()
            }
        }

        for ((k, v) in right.iterator()) {
            if (left.get(k) == Option<V>.None) {
                righties.add(k)
            }
        }

        if (!righties.isEmpty()) {
            pp.pprintKeysDiff("keys", leftPrefix, righties, 20, 100)
        }

        if (!lefties.isEmpty()) {
            pp.pprintKeysDiff("keys", rightPrefix, lefties, 20, 100)
        }

        if (!diffText.isEmpty()) {
            if (furtherDifferentElements != 0) {
                diffText.appendLine("...further ${furtherDifferentElements} different elements are omitted")
            }
            pp.appendLine("Different values (left - ${leftPrefix}, right - ${rightPrefix}):").indent {
                pp.append(diffText)
            }
        }

        return pp
    }
}

extend<K, V> HashMap<K, V> <: AssertPrintableCollection<HashMap<K, V>> where K <: Equatable<K> & Hashable,
    V <: Equatable<V> {
    public func pprint(right: HashMap<K, V>, pp: PrettyPrinter, leftPrefix: String, rightPrefix: String, level: Int64): PrettyPrinter {
        AssertPrintableMap<HashMap<K, V>, K, V>.pprint(this, right, pp, leftPrefix, rightPrefix, level)
    }
}

extend<K, V> TreeMap<K, V> <: AssertPrintableCollection<TreeMap<K, V>> where K <: Equatable<K> & Hashable,
    V <: Equatable<V> {
    public func pprint(right: TreeMap<K, V>, pp: PrettyPrinter, leftPrefix: String, rightPrefix: String, level: Int64): PrettyPrinter {
        AssertPrintableMap<TreeMap<K, V>, K, V>.pprint(this, right, pp, leftPrefix, rightPrefix, level)
    }
}

extend PrettyPrinter {
    func pprintKey(key: String) {
        if (key.contains("\n")) {
            appendLine("[")
            indent {
                append(key)
            }
            newLine().append("]:")
        } else {
            append("[${key}]:")
        }
    }

    func pprintTrimmedValue(value: String): PrettyPrinter {
        if (value.size > 21) {
            colored(YELLOW, value[0..20]).append("...")
        } else {
            colored(YELLOW, value)
        }
    }

    func pprintElementDiff<T>(leftValue: T, rightValue: T, leftPrefix: String, rightPrefix: String, index: String,
        level: Int64): PrettyPrinter where T <: Equatable<T> {
        let leftStr = toStringOrPlaceholder(leftValue)
        let rightStr = toStringOrPlaceholder(rightValue)

        if (level > 5) {
            return append(" ").pprintTrimmedValue(leftStr).append(" != ").pprintTrimmedValue(rightStr).newLine()
        }

        let isShortString = leftValue is String && rightValue is String &&
            max(leftStr.size, rightStr.size) <= 5

        // The same code below should be extracted to local func, but for now it cannot be done due to bug in CJVM
        let leftPrintable = leftValue as AssertPrintable<T> ??
            return append(" ").pprintNotEqual(leftStr, rightStr, needToQuote: isShortString).newLine()
        let rightPrintable = rightValue as AssertPrintable<T> ??
            return append(" ").pprintNotEqual(leftStr, rightStr, needToQuote: isShortString).newLine()

        if (isShortString) {
            return append(" ").pprintNotEqual(leftStr, rightStr, needToQuote: isShortString).newLine()
        }

        let indexedLeftPrefix = if (leftPrintable.hasNestedDiff) { leftPrefix + index } else { leftPrefix }
        let indexedRightPrefix = if (rightPrintable.hasNestedDiff) { rightPrefix + index } else { rightPrefix }

        return newLine().indent {
            leftPrintable.pprintForAssertion(this, rightValue, indexedLeftPrefix, indexedRightPrefix, level)
        }
    }

    /*
     * Format the given value as String: if it implements ToString, call toString(), if it does not, return "<value not printable>"
     */
    func pprintKeysDiff<T>(
        keyKind: String, collectionWithMissedKeys: String,
        keys: ArrayList<T>, maxSize: Int64, maxOneLineSize: Int64
    ): PrettyPrinter {
        var totalSize = 0
        let strKeys = ArrayList<String>()
        let keysPrinter = PrettyText()

        for ((i, k) in keys |> enumerate) {
            if (i > maxSize - 1) {
                break
            }
            let kStr = toStringQuotedOrPlaceholder(k)
            strKeys.add(kStr)
            totalSize += kStr.size
        }

        for ((i, kStr) in strKeys |> enumerate) {
            keysPrinter.append(kStr)

            if (keys.size > maxSize || i < strKeys.size - 1) {
                if (totalSize > maxOneLineSize) {
                    keysPrinter.appendLine(",")
                } else {
                    keysPrinter.append(", ")
                }
            }
        }

        if (keys.size > maxSize) {
            let omittedMessage = "...further ${keys.size - maxSize} different ${keyKind} are omitted"
            if (totalSize > maxOneLineSize) {
                keysPrinter.appendLine(omittedMessage)
            } else {
                keysPrinter.append(omittedMessage)
            }
        }

        append("Missed ${keyKind} in ${collectionWithMissedKeys}: ")

        if (totalSize > maxOneLineSize) {
            appendLine("[")
            indent {
                append(keysPrinter)
            }
            appendLine("]")
        } else {
            appendLine("[${keysPrinter}]")
        }
    }
}

private func runIfToStringOrPlaceholder<T>(value: T, fn: (String) -> String): String {
    return match (value) {
        case vToStr: ToString => fn(vToStr.toString())
        case _ => NOT_PRINTABLE_PLACEHOLDER
    }
}
