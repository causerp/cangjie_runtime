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

struct ColorChunk {
    ColorChunk(let color: Color, let width!: Int64 = 1) {}
}

type DiffBuilderResult = (ArrayList<Rune>, ArrayList<Rune>, ArrayList<ColorChunk>, Option<ArrayList<Rune>>)

// It implements Needleman-Wunsch algorithm
class OneLineDiffBuilder {
    private init() {}

    private static let missPenalty: Float64 = 1.0
    private static let gapPenalty: Float64 = 1.0
    private static let skewPenalty: Float64 = 0.5

    // Criteria below is to show detailed diff
    private static let minSize = 4
    private static let minSimilarity = 0.5 // minimal similirity of whole strings
    private static let prefixSuffixFactor = 0.25 // which part of the string is considered as a prefix/suffix
    private static let minPrefixSuffixSimilarity = 0.75

    private static func recordMarkedChar(
        markedChars: ArrayList<Edit<Rune>>,
        dg: Float64, dn: Float64, rt: Float64,
        indices: (Int64, Int64, Int64),
        left: Array<Rune>, right: Array<Rune>
    ): (Int64, Int64, Int64) {
        var (i, j, k) = indices
        if (dg <= [dn, rt].min()) {
            if (left[i - 1] != right[j - 1]) {
                markedChars.add(Modify(left[i - 1], right[j - 1]))
            } else {
                markedChars.add(Keep(left[i - 1]))
            }
            k++
            i--
            j--
        } else if (dn < rt) {
            markedChars.add(Remove(left[i - 1]))
            k++
            i--
        } else {
            markedChars.add(Insert(right[j - 1]))
            k++
            j--
        }
        (i, j, k)
    }

    private static func computeDiff(
        sampledLeft: SampledAssertValue,
        sampledRight: SampledAssertValue
    ): ArrayList<Edit<Rune>> {
        let left: Array<Rune> = sampledLeft.sampledStr.toRuneArray()
        let right: Array<Rune> = sampledRight.sampledStr.toRuneArray()
        let ia = left.size
        let ib = right.size
        let result: ArrayList<Edit<Rune>> = ArrayList()
        let cost = Array<Array<Float64>>(ia + 1) { ix => Array<Float64>(ib + 1) { ix => 0.0 } }

        cost[0][0] = 0.0
        for (i in 1..ia + 1) {
            cost[i][0] = cost[i - 1][0] + skewPenalty
        }
        for (i in 1..ib + 1) {
            cost[0][i] = cost[0][i - 1] + skewPenalty
        }
        for (i in 1..ia + 1) {
            for (j in 1..ib + 1) {
                let dn = cost[i - 1][j] + (if (j == ib) {
                    skewPenalty
                } else {
                    gapPenalty
                })
                let rt = cost[i][j - 1] + (if (i == ia) {
                    skewPenalty
                } else {
                    gapPenalty
                })
                let dg = cost[i - 1][j - 1] + (if (left[i - 1] == right[j - 1]) {
                    -1.0
                } else {
                    missPenalty
                })
                cost[i][j] = [dn, rt, dg].min()
            }
        }

        var i = ia
        var j = ib
        var k = 0
        while (i > 0 || j > 0) {
            var dn = 9.99e99
            var rt = 9.99e99
            var dg = 9.99e99
            if (i > 0) {
                dn = cost[i - 1][j] + (if (j == ib) {
                    skewPenalty
                } else {
                    gapPenalty
                })
            }
            if (j > 0) {
                rt = cost[i][j - 1] + (if (j == ia) {
                    skewPenalty
                } else {
                    gapPenalty
                })
            }
            if (i > 0 && j > 0) {
                dg = cost[i - 1][j - 1] + (if (left[i - 1] == right[j - 1]) {
                    -1.0
                } else {
                    missPenalty
                })
            }
            (i, j, k) = recordMarkedChar(result, dg, dn, rt, (i, j, k), left, right)
        }
        for (i in 0..k / 2) {
            (result[k - 1 - i], result[i]) = (result[i], result[k - 1 - i])
        }
        result
    }

    private static func fillOutputByMarkedChars(
        diff: ArrayList<Edit<Rune>>,
        aout: ArrayList<Rune>,
        bout: ArrayList<Rune>,
        colors: ArrayList<ColorChunk>
    ): Int64 {
        var removalsOrInsertionsToTrim = 0

        func addAligned(a: Rune, b: Rune, color: Color) {
            let width: Int64 = max(a.width(), b.width())
            aout.addRightPadded(a, width)
            bout.addRightPadded(b, width)
            colors.add(ColorChunk(color, width: width))
        }

        for (i in 0..diff.size) {
            match (diff[i]) {
                case Modify(c1, c2) =>
                    addAligned(c1, c2, YELLOW)
                    removalsOrInsertionsToTrim = 0
                case Remove(c) =>
                    addAligned(c, r'·', RED)
                    if (i >= 150) {
                        removalsOrInsertionsToTrim++
                    } else {
                        removalsOrInsertionsToTrim = 0
                    }
                case Insert(c) =>
                    addAligned(r'·', c, GREEN)
                    if (i >= 150) {
                        removalsOrInsertionsToTrim++
                    } else {
                        removalsOrInsertionsToTrim = 0
                    }
                case Keep(c) =>
                    addAligned(c, c, DEFAULT_COLOR)
                    removalsOrInsertionsToTrim = 0
            }
        }
        return removalsOrInsertionsToTrim
    }

    private static func isSuffixPrefixSimilar(prefixSuffixSize: Int64, diffSize: Int64) {
        return prefixSuffixSize > Int64(Float64(diffSize) * prefixSuffixFactor * minPrefixSuffixSimilarity)
    }

    private static func isPrefixSimilar(diff: ArrayList<Edit<Rune>>) {
        let rightBorder = Int64(Float64(diff.size) * prefixSuffixFactor)
        return isSuffixPrefixSimilar(diff[..rightBorder].filterKeep().size, diff.size)
    }

    private static func isSuffixSimilar(diff: ArrayList<Edit<Rune>>) {
        let diffSize = Float64(diff.size)
        let leftBorder = Int64(diffSize - diffSize * prefixSuffixFactor)
        return isSuffixPrefixSimilar(diff[leftBorder..].filterKeep().size, diff.size)
    }

    private static func areStringsSimilar(diff: ArrayList<Edit<Rune>>) {
        return diff.filterKeep().size > Int64(Float64(diff.size) * minSimilarity)
    }

    private static func buildWithoutDiff(
        left: ArrayList<Rune>, right: ArrayList<Rune>
    ): DiffBuilderResult {
        return (
            left, right,
            Array(max(left.size, right.size), repeat: ColorChunk(Color.YELLOW)) |> collectArrayList,
            Option<ArrayList<Rune>>.None
        )
    }

    static func build(
        left: String, right: String
    ): DiffBuilderResult {
        if (max(left.size, right.size) < minSize) {
            return buildWithoutDiff(ArrayList(left.toRuneArray()), ArrayList(right.toRuneArray()))
        }

        var (sampledLeft, sampledRight) = sampleStrings(left, right)
        let diff = computeDiff(sampledLeft, sampledRight)

        // If two strings don't satisfy similarity creteria, then don't show detailed diff
        if (!areStringsSimilar(diff) && !isPrefixSimilar(diff) && !isSuffixSimilar(diff)) {
            let leftSampledStr = ArrayList(sampledLeft.sampledStr.toRuneArray())
            let rightSampledStr = ArrayList(sampledRight.sampledStr.toRuneArray())
            sampledLeft.addPrefixAndSuffix(leftSampledStr)
            sampledRight.addPrefixAndSuffix(rightSampledStr)
            return buildWithoutDiff(leftSampledStr, rightSampledStr)
        }

        var aout: ArrayList<Rune> = ArrayList()
        var bout: ArrayList<Rune> = ArrayList()
        var colors: ArrayList<ColorChunk> = ArrayList()

        // If one value matches to another with some misses and the length of strings is more than 150,
        // we should additionally allign the endings of strings by trimming non-proper insertions of removals
        // appeared because of the different length of sampled strings

        let removalsOrInsertionsToTrim = fillOutputByMarkedChars(diff, aout, bout, colors)

        // Do additional allignment at endings
        if (removalsOrInsertionsToTrim > 0) {
            aout = aout[..aout.size - removalsOrInsertionsToTrim]
            bout = bout[..bout.size - removalsOrInsertionsToTrim]
            colors = colors[..colors.size - removalsOrInsertionsToTrim]
        }

        let aSuffixPrefixlen = sampledLeft.addPrefixAndSuffix(aout)
        let bSuffixPrefixlen = sampledRight.addPrefixAndSuffix(bout)
        let textualDiff = ArrayList<Rune>()

        for (i in 0..aSuffixPrefixlen[0]) {
            textualDiff.add(r' ')
        }

        for (colorChunk in colors) {
            match (colorChunk.color) {
                case RED => textualDiff.addRightPadded(r'-', colorChunk.width)
                case GREEN => textualDiff.addRightPadded(r'+', colorChunk.width)
                case YELLOW => textualDiff.addRightPadded(r'!', colorChunk.width)
                case _ => textualDiff.addRightPadded(r'=', colorChunk.width, paddingWith: r'=')
            }
        }

        allignColorsByPrefixAndSuffix(aSuffixPrefixlen, bSuffixPrefixlen, colors)

        return (aout, bout, colors, textualDiff)
    }

    private static func allignColorsByPrefixAndSuffix(
        aPrefixSuffixLen: (Int64, Int64),
        bPrefixSuffixLen: (Int64, Int64),
        colors: ArrayList<ColorChunk>
    ) {
        let (aPrefixLen, aSuffixLen) = aPrefixSuffixLen
        let (bPrefixLen, bSuffixLen) = bPrefixSuffixLen

        for (_ in 0..max(aSuffixLen, bSuffixLen)) {
            colors.add(ColorChunk(DEFAULT_COLOR))
        }

        for (_ in 0..max(aPrefixLen, bPrefixLen)) {
            colors.add(ColorChunk(DEFAULT_COLOR), at: 0)
        }
    }

    static func commonPrefix(left: String, right: String): (byteLen: Int64, runeLen: Int64) {
        let leftRunes = left.runes()
        let rightRunes = right.runes()
        var bytes = 0
        var chars = 0
        while (true) {
            let leftChar = leftRunes.next() ?? break
            let rightChar = rightRunes.next() ?? break
            if (leftChar == rightChar) {
                chars++
                bytes += leftChar.toString().size
            } else {
                break
            }
        }
        return (bytes, chars)
    }

    private static func sampleStrings(left: String, right: String): (SampledAssertValue, SampledAssertValue) {
        if (left.size > 150 || right.size > 150) {
            let (bytePrefix, commonPrefixLen) = commonPrefix(left, right)
            match (bytePrefix) {
                case n where n > 25 => return (SampledAssertValue(left[(n - 5)..min(left.size, n + 140)],
                        endingOmitted: left.size > n + 140, beginningOmittedCharsAmount: commonPrefixLen - 5),
                    SampledAssertValue(right[(n - 5)..min(right.size, n + 140)], endingOmitted: right.size > n + 140,
                        beginningOmittedCharsAmount: commonPrefixLen - 5))
                case _ => return (SampledAssertValue(left[..min(left.size, 150)], endingOmitted: left.size > 150),
                    SampledAssertValue(right[..min(right.size, 150)], endingOmitted: right.size > 150))
            }
        } else {
            return (SampledAssertValue(left), SampledAssertValue(right))
        }
    }
}

extend PrettyPrinter {
    func printOneLineDiff(
        left: String,
        right: String,
        leftPrefix!: String = "",
        rightPrefix!: String = "",
        leftSuffix!: String = "",
        rightSuffix!: String = ""
    ): PrettyPrinter {
        let (aout, bout, colors, textualDiff) = OneLineDiffBuilder.build(left, right)
        let alignSpace = max(leftPrefix.size, rightPrefix.size)

        appendRightAligned(leftPrefix, UInt64(alignSpace))
        coloredWithBuffer(aout, colors)
        appendLine(leftSuffix)

        appendRightAligned(rightPrefix, UInt64(alignSpace))
        coloredWithBuffer(bout, colors)
        appendLine(rightSuffix)

        if (let Some(diff) <- textualDiff) {
            appendRightAligned("", UInt64(alignSpace))
            coloredWithBuffer(diff, colors)
            newLine()
        }

        this
    }

    private func coloredWithBuffer<T>(chunks: ArrayList<T>, colors: ArrayList<ColorChunk>) where T <: ToString {
        var buffer = ""
        var currentColor = Option<Color>.None

        func appendWithColor() {
            if (buffer.isEmpty()) {
                return
            }
            if (let Some(color) <- currentColor) {
                colored(color, buffer)
            } else {
                append(buffer)
            }
        }

        var currentWidth = 0
        var colorIdx = 0

        for (i in 0..chunks.size) {
            if (currentWidth >= colors[colorIdx].width) {
                colorIdx++
                currentWidth = 0
            }
            let color = colors[colorIdx].color
            let chunk = chunks[i].toString()
            let chunkWidth = chunk.width()

            if (currentColor == color) {
                buffer += chunk
                currentWidth += chunkWidth
                continue
            }

            appendWithColor()
            currentColor = color
            buffer = chunk
            currentWidth = chunkWidth
        }
        appendWithColor()
    }
}

extend<T> Array<T> where T <: Comparable<T> {
    func min() {
        var result = this[0]
        for (e in this) {
            if (e < result) {
                result = e
            }
        }
        result
    }
}

extend ArrayList<Edit<Rune>> {
    func filterKeep(): ArrayList<Edit<Rune>> {
        return this |> filter<Edit<Rune>> { e =>
            match (e) {
                case Keep(c) => true
                case _ => false
            }
        } |> collectArrayList
    }
}

extend ArrayList<Rune> {
    func addRightPadded(r: Rune, width: Int64, paddingWith!: Rune = r' '): Unit {
        let rWidth = r.width()
        this.add(r)
        if (width > rWidth) {
            for (_ in 0..(width - rWidth)) {
                this.add(paddingWith)
            }
        }
    }
}
