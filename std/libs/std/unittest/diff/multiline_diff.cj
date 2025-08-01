/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest.diff

import std.collection.*
import std.unittest.common.PrettyPrinter

/*
 * Conditional compilation shouldn't be used because the strings may come from Windows environment anyway,
 * e.g. by openning a file created on Windows initially
 */
extend String {
    func unifyLineBreaks(): String { replace("\r\n", "\n") }
}

private enum WeakEq {
    Eq | Neq | Similar

    func isSimilar(): Bool {
        match (this) {
            case Eq | Similar => true
            case Neq => false
        }
    }

    func isStrictEq(): Bool {
        match (this) {
            case Eq => true
            case Neq | Similar => false
        }
    }
}

// It implements Myers diff algorithm
class MultilineDiffBuilder {
    private static const MAX_EDIT_ITEMS = 50
    private static const SIMILARITY_COEF = 0.75
    private static const SIMILARITY_MAX_DISTANCE = 25

    static func splitAndTrim(str: String): (List<String>, Int64) {
        let lines = ArrayList.of(str.split("\n"))
        return if (lines.size > MAX_EDIT_ITEMS) {
            (lines[0..MAX_EDIT_ITEMS], lines.size - MAX_EDIT_ITEMS)
        } else {
            (lines, 0)
        }
    }

    private static func weakCmp(
        leftStr: String,
        rightStr: String
    ): WeakEq {
        if (leftStr == rightStr) {
            return WeakEq.Eq
        }

        var left = leftStr.toRuneArray()
        var right = rightStr.toRuneArray()

        if (left.size < right.size) {
            (left, right) = (right, left)
        }

        let thresh = min(Int64(Float64(right.size) * (1.0 - SIMILARITY_COEF)), SIMILARITY_MAX_DISTANCE)

        if (left.size - right.size > thresh) {
            return WeakEq.Neq
        }

        return compareByDist(left, right, thresh)
    }

    // It implements Wagner-Fischer algorithm with modification for limiting maximum distance
    private static func compareByDist(left: Array<Rune>, right: Array<Rune>, thresh: Int64): WeakEq {
        let dist = Array<Array<Int64>>(left.size + 1) {
            x => Array<Int64>(right.size + 1) {
                y => if (x == 0) { y } else if (y == 0) { x } else { thresh }
            }
        }

        for (y in 1..=right.size) {
            var minDist = Int64.Max
            for (x in max(1, y - thresh)..=min(y + thresh, left.size)) {
                dist[x][y] = [
                    dist[x - 1][y] + 1,
                    dist[x][y - 1] + 1,
                    dist[x - 1][y - 1] + if (left[x - 1] == right[y - 1]) { 0 } else { 1 }
                ].min()
                minDist = min(minDist, dist[x][y])
            }
            if (minDist > thresh) {
                return WeakEq.Neq
            }
        }

        if (dist[left.size][right.size] <= thresh) {
            return WeakEq.Similar
        } else {
            return WeakEq.Neq
        }
    }

    static func computeEditScript(left: List<String>, right: List<String>, useWeakCmp!: Bool): ArrayList<Edit<String>> {
        let strCmp = if (useWeakCmp) { weakCmp } else {
            { l: String, r: String => if (l == r) { WeakEq.Eq } else { WeakEq.Neq } }
        }

        //This marks the farthest-right point along each diagonal in the edit
        //graph, along with the history that got it there
        let frontier = HashMap<Int64, Frontier<String>>((1, Frontier(0, ArrayList())))

        func one(idx: Int64) {
            idx - 1
        }

        let aMax = left.size
        let bMax = right.size
        for (d in (0..aMax + bMax + 1)) {
            for (k in (-d..(d + 1) : 2)) {
                //This determines whether our next search point will be going down
                //in the edit graph, or to the right.
                //
                //The intuition for this is that we should go down if we're on the
                //left edge (k == -d) to make sure that the left edge is fully
                //explored.
                //
                //If we aren't on the top (k != d), then only go down if going down
                //would take us to territory that hasn't sufficiently been explored
                //yet.
                let goDown = (k == -d || (k != d && frontier[k - 1].x < frontier[k + 1].x))

                //Figure out the starting point of this iteration. The diagonal
                //offsets come from the geometry of the edit grid - if you're going
                //down, your diagonal is lower, and if you're going right, your
                //diagonal is higher.
                var oldX: Int64
                var x: Int64
                var history: ArrayList<Edit<String>>
                if (goDown) {
                    (oldX, history) = frontier[k + 1].deconstuct
                    x = oldX
                } else {
                    (oldX, history) = frontier[k - 1].deconstuct
                    x = oldX + 1
                }

                //We want to avoid modifying the old history, since some other step
                //may decide to use it.
                history = history.clone()
                var y = x - k

                //We start at the invalid point (0, 0) - we should only start building
                //up history when we move off of it.
                if (y >= 1 && y <= bMax && goDown) {
                    history.add(Insert(right[one(y)]))
                } else if ((x >= 1 && x <= aMax)) {
                    history.add(Remove(left[one(x)]))
                }

                //Chew up as many diagonal moves as we can - these correspond to common lines,
                //and they're considered "free" by the algorithm because we want to maximize
                //the number of these in the output.
                (x, y) = computeEditScriptMoveDiag(x, y, left, right, history, strCmp)

                if (x >= aMax && y >= bMax) {
                    //If we're here, then we've traversed through the bottom-left corner,
                    //and are done.
                    return history
                } else {
                    frontier[k] = Frontier(x, history)
                }
            }
        }
        throw Exception("Could not find edit script")
    }

    private static func computeEditScriptMoveDiag(
        xInit: Int64,
        yInit: Int64,
        left: List<String>,
        right: List<String>,
        history: ArrayList<Edit<String>>,
        strCmp: (String, String) -> WeakEq
    ): (Int64, Int64) {
        var x = xInit
        var y = yInit

        func one(idx: Int64) {
            idx - 1
        }

        while (x < left.size && y < right.size) {
            let eq = strCmp(left[one(x + 1)], right[one(y + 1)])
            if (!eq.isSimilar()) {
                break
            }
            x += 1
            y += 1
            if (!eq.isStrictEq()) {
                history.add(Modify(left[one(x)], right[one(y)]))
            } else {
                history.add(Keep(left[one(x)]))
            }
        }
        return (x, y)
    }
}

struct Frontier<T> {
    Frontier(let x: Int64, let history: ArrayList<Edit<T>>) {}

    prop deconstuct: (Int64, ArrayList<Edit<T>>) {
        get() { (x, history) }
    }
}

extend PrettyPrinter {
    func printMultilineDiff(left: String, right: String): PrettyPrinter {
        let leftUnified = left.unifyLineBreaks()
        let rightUnified = right.unifyLineBreaks()
        return indent {
            if (leftUnified == rightUnified) {
                let additionalInfo = if (leftUnified == left) {
                    " (left - unix-style, right - windows-style)"
                } else if (rightUnified == right) {
                    " (left - windows-style, right - unix-style)"
                } else {
                    " (mixed line ending style in both left and right)"
                }
                appendLine("Left and right values have only different line endings${additionalInfo}")
            } else {
                let (left, leftOmitted) = MultilineDiffBuilder.splitAndTrim(leftUnified)
                let (right, rightOmitted) = MultilineDiffBuilder.splitAndTrim(rightUnified)
                let omittedLines = max(leftOmitted, rightOmitted)
                let script = MultilineDiffBuilder.computeEditScript(left, right, useWeakCmp: false)
                printEditScript(script, doBlocksDiff: true)
                if (omittedLines > 0) {
                    colored(GRAY, "(...further ${omittedLines} lines are omitted)").newLine()
                }
            }
        }
    }

    private func printEqualLines(skipped: Int64, i: Int64, script: ArrayList<Edit<String>>) {
        match (skipped) {
            case 0 => ()
            case 1 =>
                // if we skipped 1 line, it's better to just print it
                // instead of "lines skipped" message
                if (let Keep(prevLine) <- script[i - 1]) {
                    append(" ").colored(GRAY, prevLine).newLine()
                }
            case _ =>
                colored(GRAY, "(...${skipped} equal lines skipped...)").newLine()
        }
    }

    private func printBlocksDiff(
        removeBlock: ArrayList<String>,
        insertBlock: ArrayList<String>
    ) {
        if (removeBlock.size > 0 && insertBlock.size > 0) {
            let script = MultilineDiffBuilder.computeEditScript(removeBlock, insertBlock, useWeakCmp: true)
            printEditScript(script, doBlocksDiff: false)
        } else if (removeBlock.size > 0) {
            for (line in removeBlock) {
                colored(RED, "-" + line).newLine()
            }
        } else if (insertBlock.size > 0) {
            for (line in insertBlock) {
                colored(GREEN, "+" + line).newLine()
            }
        }
    }

    private func printEditScript(script: ArrayList<Edit<String>>, doBlocksDiff!: Bool): Unit {
        var i = 0
        var skipped = 0
        var requireNext = false

        var removeBlock = ArrayList<String>()
        var insertBlock = ArrayList<String>()
        while (i < script.size) {
            match (script[i]) {
                case Keep(line) =>
                    if (doBlocksDiff && (removeBlock.size > 0 || insertBlock.size > 0)) {
                        printBlocksDiff(removeBlock, insertBlock)
                        removeBlock.clear()
                        insertBlock.clear()
                    }
                    match (script.get(i + 1)) {
                        case Some(Keep(_)) where !requireNext =>
                            skipped++
                            i++
                            continue
                        case _ =>
                            printEqualLines(skipped, i, script)
                            skipped = 0
                            append(" ").colored(GRAY, line).newLine()
                            requireNext = false
                    }
                case Remove(line) =>
                    if (doBlocksDiff) {
                        removeBlock.add(line)
                    } else {
                        colored(RED, "-" + line).newLine()
                    }
                    requireNext = true
                case Insert(line) =>
                    if (doBlocksDiff) {
                        insertBlock.add(line)
                    } else {
                        colored(GREEN, "+" + line).newLine()
                    }
                    requireNext = true
                case Modify(line1, line2) =>
                    printOneLineDiff(line1, line2, leftPrefix: "-", rightPrefix: "+")
            }
            i++
        }
        if (removeBlock.size > 0 || insertBlock.size > 0) {
            printBlocksDiff(removeBlock, insertBlock)
        }
    }
}
