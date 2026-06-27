/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.sort

import std.math.*

/*
 * Stable ascending sort
 *
 * @param data Array to be sorted.
 *
 * @since 0.27.3
 */
@Deprecated[message: "Use global function `public func sort<T>(data: Array<T>, stable!: Bool = false, descending!: Bool = false): Unit where T <: Comparable<T>` instead."]
public func stableSort<T>(data: Array<T>): Unit where T <: Comparable<T> {
    if (data.size < 2) {
        return
    }
    data.timSort()
}

/*
 * Stable sort
 *
 * @param data Array to be sorted.
 * @param comparator The comparator must establish a total order:
 *        - Antisymmetry: if compare(a, b) is LT, then compare(b, a) must be GT
 *        - Transitivity: if compare(a, b) is LT and compare(b, c) is LT, then compare(a, c) must be LT
 *        - Consistency: multiple invocations of compare(a, b) must return the same result
 *        Violating these requirements may result in undefined behavior.
 *
 * @since 0.27.3
 */
@Deprecated[message: "Use global function `public func sort<T>(data: Array<T>, by!: (T, T) -> Ordering, stable!: Bool = false, descending!: Bool = false): Unit` instead."]
public func stableSort<T>(data: Array<T>, comparator: (T, T) -> Ordering): Unit {
    if (data.size < 2) {
        return
    }
    data.timSort(comparator)
}

extend<T> Array<T> where T <: Comparable<T> {
    @OverflowWrapping
    private func shortSort(begin: Int64, end: Int64): Unit {
        let len = this.size
        if (len <= 8) {
            if (len <= 1) {
                return
            } else if (len == 2) {
                if (this[begin] > this[end]) {
                    var temp = this[begin]
                    this[begin] = this[end]
                    this[end] = temp
                }
            } else if (len == 3) {
                this.compareSwap3(begin, begin + 1, end)
            } else {
                insertionSort(begin, end)
            }
        } else {
            var temp = TempArray(len, this[begin])
            let n = getSequenceLength(begin, end, temp)
            if (n == len) {
                return
            }
            binaryInsertionSort(begin, end, n)
        }
    }

    @OverflowWrapping
    private func maybeMerge(
        startArr: Array<Int64>,
        lengthArr: Array<Int64>,
        endIndex: Int64,
        temp: TempArray<T>
    ): Int64 {
        var index: Int64 = endIndex
        while (index > 0) {
            var n: Int64 = index - 1
            let sn = startArr[n]
            let sn1 = startArr[n + 1]
            let ln = lengthArr[n]
            let ln1 = lengthArr[n + 1]
            if (n == 0) {
                if (ln <= ln1) {
                    this.merge(sn, ln, sn1, ln1, temp)
                    lengthArr[n] = ln + ln1
                    index--
                }
                break
            }
            let s = startArr[n - 1]
            let l = lengthArr[n - 1]
            if (l <= ln + ln1) {
                if (l < ln1) {
                    this.merge(s, l, sn, ln, temp)
                    recordMergedLeftRunAndKeepRightRun(startArr, lengthArr, n, sn1, ln1, l + ln)
                    index--
                } else {
                    this.merge(sn, ln, sn1, ln1, temp)
                    lengthArr[n] = ln + ln1
                    index--
                }
            } else if (ln <= ln1) {
                this.merge(sn, ln, sn1, ln1, temp)
                lengthArr[n] = ln + ln1
                index--
            } else {
                break
            }
        }
        return index
    }

    @OverflowWrapping
    private func mergeAll(
        startArr: Array<Int64>,
        lengthArr: Array<Int64>,
        endIndex: Int64,
        temp: TempArray<T>
    ): Unit {
        var index: Int64 = endIndex
        while (index > 0) {
            var n: Int64 = index - 1
            let sn = startArr[n]
            let sn1 = startArr[n + 1]
            let ln = lengthArr[n]
            let ln1 = lengthArr[n + 1]
            if (n == 0) {
                this.merge(sn, ln, sn1, ln1, temp)
                break
            }
            let s = startArr[n - 1]
            let l = lengthArr[n - 1]
            if (l < ln1) {
                this.merge(s, l, sn, ln, temp)
                recordMergedLeftRunAndKeepRightRun(startArr, lengthArr, n, sn1, ln1, l + ln)
                index--
            } else {
                this.merge(sn, ln, sn1, ln1, temp)
                lengthArr[n] = ln + ln1
                index--
            }
        }
    }

    @OverflowWrapping
    private func merge(
        start1: Int64,
        len1: Int64,
        start2: Int64,
        len2: Int64,
        temp: TempArray<T>
    ): Unit {
        var s1 = start1
        var l1 = len1
        var s2 = start2
        var l2 = len2
        var lt = this.queryLT(this[s1 + l1 - 1], s2, l2, true)
        l2 = lt - s2
        if (l2 == 0) {
            return
        }
        var gt = this.queryGT(this[s2], s1, l1, false)
        l1 = l1 - (gt - s1)
        s1 = gt
        if (l1 == 0) {
            return
        }
        if (l1 == 1) {
            let t0 = this[s1]
            this.copyTo(this, s2, s2 - 1, l2)
            this[s1 + l2] = t0
        } else if (l2 == 1) {
            let t0 = this[s2]
            this.copyTo(this, s1, s1 + 1, l1)
            this[s1] = t0
        } else if (l1 <= l2) {
            mergeFromLeft(s1, l1, s2, l2, temp)
        } else {
            mergeFromRight(s1, l1, s2, l2, temp)
        }
    }

    @OverflowWrapping
    private func mergeFromLeft(
        start1: Int64,
        len1: Int64,
        start2: Int64,
        len2: Int64,
        temp: TempArray<T>
    ) {
        let arr = temp.getArray(len1)
        this.copyTo(arr, start1, 0, len1)
        var ti = start1
        var s1 = 0
        var l1 = len1
        var s2 = start2
        var l2 = len2
        this[ti] = this[s2]
        ti++
        s2++
        l2--
        var c1 = 0
        var c2 = 0
        var continueBreak = false
        while (true) {
            c1 = 0
            c2 = 0
            continueBreak = false
            var t1 = arr[s1]
            var t2 = this[s2]
            while (true) {
                if (t1 > t2) {
                    this[ti] = t2
                    ti++
                    s2++
                    l2--
                    c2++
                    c1 = 0
                    if (l2 == 0) {
                        continueBreak = true
                        break
                    }
                    if (c2 > 4) {
                        break
                    }
                    t2 = this[s2]
                } else {
                    this[ti] = t1
                    ti++
                    s1++
                    l1--
                    c1++
                    c2 = 0
                    if (l1 == 1) {
                        continueBreak = true
                        break
                    }
                    if (c1 > 4) {
                        break
                    }
                    t1 = arr[s1]
                }
            }
            if (continueBreak) {
                break
            }
            continueBreak = false
            while (true) {
                var point = this[s2]
                c1 = arr.queryGT(point, s1, l1, false) - s1
                moveLeftBufferPrefix(this, arr, ti, s1, c1, point)
                ti = ti + c1 + 1
                s1 += c1
                l1 -= c1
                s2++
                l2--
                if (l1 == 1 || l2 == 0) {
                    continueBreak = true
                    break
                }
                point = arr[s1]
                c2 = this.queryLT(point, s2, l2, false) - s2
                moveRightRunPrefix(this, ti, s2, c2, point)
                ti = ti + c2 + 1
                s2 += c2
                l2 -= c2
                s1++
                l1--
                if (l2 == 0 || l1 == 1) {
                    continueBreak = true
                    break
                }
                if (c1 < 4 || c2 < 4) {
                    break
                }
            }
            if (continueBreak) {
                break
            }
        }
        finishMergeFromLeft(this, arr, ti, s1, l1, s2, l2)
    }

    @OverflowWrapping
    private func mergeFromRight(
        start1: Int64,
        len1: Int64,
        start2: Int64,
        len2: Int64,
        temp: TempArray<T>
    ) {
        let rightBuffer = temp.getArray(len2)
        this.copyTo(rightBuffer, start2, 0, len2)
        var rightTarget = start2 + len2 - 1
        var leftTail = start1 + len1 - 1
        var leftRest = len1
        var rightTail = len2 - 1
        var rightRest = len2
        this[rightTarget] = this[leftTail]
        rightTarget--
        leftTail--
        leftRest--
        var leftBatch = 0
        var rightBatch = 0
        var stopFromRight = false
        while (true) {
            leftBatch = 0
            rightBatch = 0
            stopFromRight = false
            var leftTailValue = this[leftTail]
            var rightTailValue = rightBuffer[rightTail]
            while (true) {
                if (leftTailValue > rightTailValue) {
                    this[rightTarget] = leftTailValue
                    rightTarget--
                    leftTail--
                    leftRest--
                    leftBatch++
                    rightBatch = 0
                    if (leftRest == 0) {
                        stopFromRight = true
                        break
                    }
                    if (leftBatch > 4) {
                        break
                    }

                    leftTailValue = this[leftTail]
                } else {
                    this[rightTarget] = rightTailValue
                    rightTarget--
                    rightTail--
                    rightRest--
                    rightBatch++
                    leftBatch = 0
                    if (rightRest == 1) {
                        stopFromRight = true
                        break
                    }
                    if (rightBatch > 4) {
                        break
                    }
                    rightTailValue = rightBuffer[rightTail]
                }
            }
            if (stopFromRight) {
                break
            }
            stopFromRight = false
            while (true) {
                var tailProbe = this[leftTail]
                let ltIndex = rightBuffer.queryLT(tailProbe, 0, rightRest, true)
                rightBatch = rightRest - ltIndex
                moveRightBufferSuffix(this, rightBuffer, rightTarget, rightTail, rightBatch, tailProbe)
                rightTarget = rightTarget - rightBatch - 1
                rightTail -= rightBatch
                rightRest -= rightBatch
                leftTail--
                leftRest--
                if (rightRest == 1 || leftRest == 0) {
                    stopFromRight = true
                    break
                }
                tailProbe = rightBuffer[rightTail]
                let gtIndex = this.queryGT(tailProbe, start1, leftRest, true)
                leftBatch = leftTail - gtIndex + 1
                moveLeftRunSuffix(this, rightTarget, leftTail, leftBatch, tailProbe)
                rightTarget = rightTarget - leftBatch - 1
                leftTail -= leftBatch
                leftRest -= leftBatch
                rightTail--
                rightRest--
                if (leftRest == 0 || rightRest == 1) {
                    stopFromRight = true
                    break
                }
                if (leftBatch < 4 || rightBatch < 4) {
                    break
                }
            }
            if (stopFromRight) {
                break
            }
        }
        finishMergeFromRight(this, start1, rightBuffer, rightTarget, leftRest, rightTail, rightRest)
    }

    @OverflowWrapping
    func timSort(): Unit {
        if (this.size <= 64) {
            shortSort(0, this.size - 1)
            return
        }

        // init temp data
        let mrl = this.getMinRunLength()
        var temp = TempArray(this.size, this[0])
        let stackLen = Int64(log2(Float64(this.size) / Float64(mrl) + 2.0)) + 1
        let startArr = Array<Int64>(stackLen, repeat: 0)
        let lengthArr = Array<Int64>(stackLen, repeat: 0)
        var endIndex = -1

        var begin: Int64 = 0
        while (begin < this.size) {
            let length = this.size - begin
            var seqLen = length
            if (length > 1) {
                seqLen = getSequenceLength(begin, this.size - 1, temp)
                if (seqLen < mrl) {
                    if (length < mrl) {
                        binaryInsertionSort(begin, begin + length - 1, seqLen)
                        seqLen = length
                    } else {
                        binaryInsertionSort(begin, begin + mrl - 1, seqLen)
                        seqLen = mrl
                    }
                }
            }
            endIndex++
            startArr[endIndex] = begin
            lengthArr[endIndex] = seqLen
            begin = begin + seqLen
            endIndex = this.maybeMerge(startArr, lengthArr, endIndex, temp)
        }
        this.mergeAll(startArr, lengthArr, endIndex, temp)
    }
}

extend<T> Array<T> {
    // the value range of the parameter: 0 <= begin < end <= array.size - 1
    @OverflowWrapping
    private func shortSort(begin: Int64, end: Int64, compareBy: (T, T) -> Ordering): Unit {
        let len = this.size
        if (len <= 8) {
            if (len <= 1) {
                return
            } else if (len == 2) {
                this.compareSwap2(begin, end, compareBy)
            } else if (len == 3) {
                this.compareSwap3(begin, begin + 1, end, compareBy)
            } else {
                insertionSort(begin, end, compareBy)
            }
        } else {
            var cmpTemp = TempArray(len, this[begin])
            let cmpSlot = getSequenceLength(begin, end, cmpTemp, compareBy)
            if (cmpSlot == len) {
                return
            }
            binaryInsertionSort(begin, end, compareBy, cmpSlot)
        }
    }

    @OverflowWrapping
    private func maybeMerge(
        cmpRunStartArr: Array<Int64>,
        cmpRunLengthArr: Array<Int64>,
        cmpStackTop: Int64,
        cmpTemp: TempArray<T>,
        compareBy: (T, T) -> Ordering
    ): Int64 {
        var cmpIndex: Int64 = cmpStackTop
        while (cmpIndex > 0) {
            var cmpSlot: Int64 = cmpIndex - 1
            let cmpCurrStart = cmpRunStartArr[cmpSlot]
            let cmpNextStart = cmpRunStartArr[cmpSlot + 1]
            let cmpCurrLen = cmpRunLengthArr[cmpSlot]
            let cmpNextLen = cmpRunLengthArr[cmpSlot + 1]
            if (cmpSlot == 0) {
                if (cmpCurrLen <= cmpNextLen) {
                    this.merge(cmpCurrStart, cmpCurrLen, cmpNextStart, cmpNextLen, cmpTemp, compareBy)
                    cmpRunLengthArr[cmpSlot] = cmpCurrLen + cmpNextLen
                    cmpIndex--
                }
                break
            }
            let cmpPrevStart = cmpRunStartArr[cmpSlot - 1]
            let cmpPrevLen = cmpRunLengthArr[cmpSlot - 1]
            if (cmpPrevLen <= cmpCurrLen + cmpNextLen) {
                if (cmpPrevLen < cmpNextLen) {
                    this.merge(cmpPrevStart, cmpPrevLen, cmpCurrStart, cmpCurrLen, cmpTemp, compareBy)
                    recordMergedLeftRunAndKeepRightRun(cmpRunStartArr, cmpRunLengthArr, cmpSlot, cmpNextStart, cmpNextLen, cmpPrevLen + cmpCurrLen)
                    cmpIndex--
                } else {
                    this.merge(cmpCurrStart, cmpCurrLen, cmpNextStart, cmpNextLen, cmpTemp, compareBy)
                    cmpRunLengthArr[cmpSlot] = cmpCurrLen + cmpNextLen
                    cmpIndex--
                }
            } else if (cmpCurrLen <= cmpNextLen) {
                this.merge(cmpCurrStart, cmpCurrLen, cmpNextStart, cmpNextLen, cmpTemp, compareBy)
                cmpRunLengthArr[cmpSlot] = cmpCurrLen + cmpNextLen
                cmpIndex--
            } else {
                break
            }
        }
        return cmpIndex
    }

    @OverflowWrapping
    private func mergeAll(
        cmpRunStartArr: Array<Int64>,
        cmpRunLengthArr: Array<Int64>,
        cmpStackTop: Int64,
        cmpTemp: TempArray<T>,
        compareBy: (T, T) -> Ordering
    ): Unit {
        var cmpIndex: Int64 = cmpStackTop
        while (cmpIndex > 0) {
            var cmpSlot: Int64 = cmpIndex - 1
            let cmpCurrStart = cmpRunStartArr[cmpSlot]
            let cmpNextStart = cmpRunStartArr[cmpSlot + 1]
            let cmpCurrLen = cmpRunLengthArr[cmpSlot]
            let cmpNextLen = cmpRunLengthArr[cmpSlot + 1]
            if (cmpSlot == 0) {
                this.merge(cmpCurrStart, cmpCurrLen, cmpNextStart, cmpNextLen, cmpTemp, compareBy)
                break
            }
            let cmpPrevStart = cmpRunStartArr[cmpSlot - 1]
            let cmpPrevLen = cmpRunLengthArr[cmpSlot - 1]
            if (cmpPrevLen < cmpNextLen) {
                this.merge(cmpPrevStart, cmpPrevLen, cmpCurrStart, cmpCurrLen, cmpTemp, compareBy)
                recordMergedLeftRunAndKeepRightRun(cmpRunStartArr, cmpRunLengthArr, cmpSlot, cmpNextStart, cmpNextLen, cmpPrevLen + cmpCurrLen)
                cmpIndex--
            } else {
                this.merge(cmpCurrStart, cmpCurrLen, cmpNextStart, cmpNextLen, cmpTemp, compareBy)
                cmpRunLengthArr[cmpSlot] = cmpCurrLen + cmpNextLen
                cmpIndex--
            }
        }
    }

    @OverflowWrapping
    private func merge(
        start1: Int64,
        len1: Int64,
        start2: Int64,
        len2: Int64,
        cmpTemp: TempArray<T>,
        compareBy: (T, T) -> Ordering
    ): Unit {
        var leftCursor = start1
        var leftRemain = len1
        var rightCursor = start2
        var rightRemain = len2
        var lessThan = this.queryLT(this[leftCursor + leftRemain - 1], rightCursor, rightRemain, compareBy, true)
        rightRemain = lessThan - rightCursor
        if (rightRemain == 0) {
            return
        }
        var greaterThan = this.queryGT(this[rightCursor], leftCursor, leftRemain, compareBy, false)
        leftRemain = leftRemain - (greaterThan - leftCursor)
        leftCursor = greaterThan
        if (leftRemain == 0) {
            return
        }
        if (leftRemain == 1) {
            let savedValue = this[leftCursor]
            this.copyTo(this, rightCursor, rightCursor - 1, rightRemain)
            this[leftCursor + rightRemain] = savedValue
        } else if (rightRemain == 1) {
            let savedValue = this[rightCursor]
            this.copyTo(this, leftCursor, leftCursor + 1, leftRemain)
            this[leftCursor] = savedValue
        } else if (leftRemain <= rightRemain) {
            mergeFromLeft(leftCursor, leftRemain, rightCursor, rightRemain, cmpTemp, compareBy)
        } else {
            mergeFromRight(leftCursor, leftRemain, rightCursor, rightRemain, cmpTemp, compareBy)
        }
    }

    @OverflowWrapping
    private func mergeFromLeft(
        start1: Int64,
        len1: Int64,
        start2: Int64,
        len2: Int64,
        cmpTemp: TempArray<T>,
        compareBy: (T, T) -> Ordering
    ) {
        let cmpBuffer = cmpTemp.getArray(len1)
        this.copyTo(cmpBuffer, start1, 0, len1)
        var targetIndex = start1
        var leftCursor = 0
        var leftRemain = len1
        var rightCursor = start2
        var rightRemain = len2
        this[targetIndex] = this[rightCursor]
        targetIndex++
        rightCursor++
        rightRemain--
        var leftCount = 0
        var rightCount = 0
        var shouldStop = false
        while (true) {
            leftCount = 0
            rightCount = 0
            shouldStop = false
            var leftValue = cmpBuffer[leftCursor]
            var rightValue = this[rightCursor]
            while (true) {
                match (compareBy(leftValue, rightValue)) {
                    case GT =>
                        this[targetIndex] = rightValue
                        targetIndex++
                        rightCursor++
                        rightRemain--
                        rightCount++
                        leftCount = 0
                        if (rightRemain == 0) {
                            shouldStop = true
                            break
                        }
                        if (rightCount > 4) {
                            break
                        }

                        rightValue = this[rightCursor]
                    case _ =>
                        this[targetIndex] = leftValue
                        targetIndex++
                        leftCursor++
                        leftRemain--
                        leftCount++
                        rightCount = 0
                        if (leftRemain == 1) {
                            shouldStop = true
                            break
                        }
                        if (leftCount > 4) {
                            break
                        }

                        leftValue = cmpBuffer[leftCursor]
                }
            }
            if (shouldStop) {
                break
            }
            shouldStop = false
            while (true) {
                var probe = this[rightCursor]
                leftCount = cmpBuffer.queryGT(probe, leftCursor, leftRemain, compareBy, false) - leftCursor
                moveLeftBufferPrefix(this, cmpBuffer, targetIndex, leftCursor, leftCount, probe)
                targetIndex = targetIndex + leftCount + 1
                leftCursor += leftCount
                leftRemain -= leftCount
                rightCursor++
                rightRemain--
                if (leftRemain == 1 || rightRemain == 0) {
                    shouldStop = true
                    break
                }
                probe = cmpBuffer[leftCursor]
                rightCount = this.queryLT(probe, rightCursor, rightRemain, compareBy, false) - rightCursor
                moveRightRunPrefix(this, targetIndex, rightCursor, rightCount, probe)
                targetIndex = targetIndex + rightCount + 1
                rightCursor += rightCount
                rightRemain -= rightCount
                leftCursor++
                leftRemain--
                if (rightRemain == 0 || leftRemain == 1) {
                    shouldStop = true
                    break
                }
                if (leftCount < 4 || rightCount < 4) {
                    break
                }
            }
            if (shouldStop) {
                break
            }
        }
        finishMergeFromLeft(this, cmpBuffer, targetIndex, leftCursor, leftRemain, rightCursor, rightRemain)
    }

    @OverflowWrapping
    private func mergeFromRight(
        start1: Int64,
        len1: Int64,
        start2: Int64,
        len2: Int64,
        cmpTemp: TempArray<T>,
        compareBy: (T, T) -> Ordering
    ) {
        let rightCmpBuffer = cmpTemp.getArray(len2)
        this.copyTo(rightCmpBuffer, start2, 0, len2)
        var cmpRightTarget = start2 + len2 - 1
        var cmpLeftTail = start1 + len1 - 1
        var cmpLeftRest = len1
        var cmpRightTail = len2 - 1
        var cmpRightRest = len2
        this[cmpRightTarget] = this[cmpLeftTail]
        cmpRightTarget--
        cmpLeftTail--
        cmpLeftRest--
        var cmpLeftBatch = 0
        var cmpRightBatch = 0
        var cmpStopFromRight = false
        while (true) {
            cmpLeftBatch = 0
            cmpRightBatch = 0
            cmpStopFromRight = false
            var cmpLeftTailValue = this[cmpLeftTail]
            var cmpRightTailValue = rightCmpBuffer[cmpRightTail]
            while (true) {
                match (compareBy(cmpLeftTailValue, cmpRightTailValue)) {
                    case GT =>
                        this[cmpRightTarget] = cmpLeftTailValue
                        cmpRightTarget--
                        cmpLeftTail--
                        cmpLeftRest--
                        cmpLeftBatch++
                        cmpRightBatch = 0
                        if (cmpLeftRest == 0) {
                            cmpStopFromRight = true
                            break
                        }
                        if (cmpLeftBatch > 4) {
                            break
                        }

                        cmpLeftTailValue = this[cmpLeftTail]
                    case _ =>
                        this[cmpRightTarget] = cmpRightTailValue
                        cmpRightTarget--
                        cmpRightTail--
                        cmpRightRest--
                        cmpRightBatch++
                        cmpLeftBatch = 0
                        if (cmpRightRest == 1) {
                            cmpStopFromRight = true
                            break
                        }
                        if (cmpRightBatch > 4) {
                            break
                        }
                        cmpRightTailValue = rightCmpBuffer[cmpRightTail]
                }
            }
            if (cmpStopFromRight) {
                break
            }
            cmpStopFromRight = false
            while (true) {
                var cmpTailProbe = this[cmpLeftTail]
                let cmpLtIndex = rightCmpBuffer.queryLT(cmpTailProbe, 0, cmpRightRest, compareBy, true)
                cmpRightBatch = cmpRightRest - cmpLtIndex
                moveRightBufferSuffix(this, rightCmpBuffer, cmpRightTarget, cmpRightTail, cmpRightBatch, cmpTailProbe)
                cmpRightTarget = cmpRightTarget - cmpRightBatch - 1
                cmpRightTail -= cmpRightBatch
                cmpRightRest -= cmpRightBatch
                cmpLeftTail--
                cmpLeftRest--
                if (cmpRightRest == 1 || cmpLeftRest == 0) {
                    cmpStopFromRight = true
                    break
                }
                cmpTailProbe = rightCmpBuffer[cmpRightTail]
                let cmpGtIndex = this.queryGT(cmpTailProbe, start1, cmpLeftRest, compareBy, true)
                cmpLeftBatch = cmpLeftTail - cmpGtIndex + 1
                moveLeftRunSuffix(this, cmpRightTarget, cmpLeftTail, cmpLeftBatch, cmpTailProbe)
                cmpRightTarget = cmpRightTarget - cmpLeftBatch - 1
                cmpLeftTail -= cmpLeftBatch
                cmpLeftRest -= cmpLeftBatch
                cmpRightTail--
                cmpRightRest--
                if (cmpLeftRest == 0 || cmpRightRest == 1) {
                    cmpStopFromRight = true
                    break
                }
                if (cmpLeftBatch < 4 || cmpRightBatch < 4) {
                    break
                }
            }
            if (cmpStopFromRight) {
                break
            }
        }
        finishMergeFromRight(this, start1, rightCmpBuffer, cmpRightTarget, cmpLeftRest, cmpRightTail, cmpRightRest)
    }

    @OverflowWrapping
    func timSort(compareBy: (T, T) -> Ordering): Unit {
        if (this.size <= 64) {
            shortSort(0, this.size - 1, compareBy)
            return
        }

        // init cmpTemp data
        let cmpMinRunLength = this.getMinRunLength()
        var cmpTemp = TempArray(this.size, this[0])
        let cmpRunStackLen = Int64(log2(Float64(this.size) / Float64(cmpMinRunLength) + 2.0)) + 1
        let cmpRunStartArr = Array<Int64>(cmpRunStackLen, repeat: 0)
        let cmpRunLengthArr = Array<Int64>(cmpRunStackLen, repeat: 0)
        var cmpStackTop = -1

        var begin: Int64 = 0
        while (begin < this.size) {
            let length = this.size - begin
            var seqLen = length
            if (length > 1) {
                seqLen = getSequenceLength(begin, this.size - 1, cmpTemp, compareBy)
                if (seqLen < cmpMinRunLength) {
                    if (length < cmpMinRunLength) {
                        binaryInsertionSort(begin, begin + length - 1, compareBy, seqLen)
                        seqLen = length
                    } else {
                        binaryInsertionSort(begin, begin + cmpMinRunLength - 1, compareBy, seqLen)
                        seqLen = cmpMinRunLength
                    }
                }
            }
            cmpStackTop++
            cmpRunStartArr[cmpStackTop] = begin
            cmpRunLengthArr[cmpStackTop] = seqLen
            begin = begin + seqLen
            cmpStackTop = this.maybeMerge(cmpRunStartArr, cmpRunLengthArr, cmpStackTop, cmpTemp, compareBy)
        }
        this.mergeAll(cmpRunStartArr, cmpRunLengthArr, cmpStackTop, cmpTemp, compareBy)
    }
}

class TempArray<T> {
    private var data: Array<T>
    private let zero: T
    private let max: Int64

    init(runSize: Int64, z: T) {
        this.data = Array<T>()
        this.max = runSize >> 1
        this.zero = z
    }

    @OverflowWrapping
    func getArray(runSize: Int64): Array<T> {
        if (data.size >= runSize) {
            return this.data
        }
        var grownSize = data.size * 2
        if (grownSize < runSize) {
            grownSize = runSize
        }
        if (grownSize > this.max) {
            grownSize = this.max
        }
        this.data = Array<T>(grownSize, repeat: this.zero)
        return this.data
    }
}

// Package-level merge helpers shared by both Array<T> extend blocks.
// Extracted as free functions to avoid cross-extend-block private method visibility limits.

@OverflowWrapping
private func moveLeftBufferPrefix<T>(dest: Array<T>, arr: Array<T>, target: Int64, leftCursor: Int64, count: Int64,
    point: T): Unit {
    match (count) {
        case 0 => dest[target] = point
        case 1 =>
            dest[target] = arr[leftCursor]
            dest[target + 1] = point
        case 2 =>
            dest[target] = arr[leftCursor]
            dest[target + 1] = arr[leftCursor + 1]
            dest[target + 2] = point
        case _ =>
            arr.copyTo(dest, leftCursor, target, count)
            dest[target + count] = point
    }
}

@OverflowWrapping
private func moveRightRunPrefix<T>(dest: Array<T>, target: Int64, rightCursor: Int64, count: Int64, point: T): Unit {
    match (count) {
        case 0 => dest[target] = point
        case 1 =>
            dest[target] = dest[rightCursor]
            dest[target + 1] = point
        case 2 =>
            dest[target] = dest[rightCursor]
            dest[target + 1] = dest[rightCursor + 1]
            dest[target + 2] = point
        case _ =>
            dest.copyTo(dest, rightCursor, target, count)
            dest[target + count] = point
    }
}

@OverflowWrapping
private func finishMergeFromLeft<T>(dest: Array<T>, arr: Array<T>, target: Int64, leftCursor: Int64, leftRest: Int64,
    rightCursor: Int64, rightRest: Int64): Unit {
    if (rightRest == 0) {
        arr.copyTo(dest, leftCursor, target, leftRest)
    }
    if (leftRest == 1) {
        dest.copyTo(dest, rightCursor, target, rightRest)
        dest[target + rightRest] = arr[leftCursor]
    }
}

@OverflowWrapping
private func moveRightBufferSuffix<T>(dest: Array<T>, rightBuffer: Array<T>, target: Int64, rightTail: Int64,
    count: Int64, point: T): Unit {
    match (count) {
        case 0 => dest[target] = point
        case 1 =>
            dest[target] = rightBuffer[rightTail]
            dest[target - 1] = point
        case 2 =>
            dest[target] = rightBuffer[rightTail]
            dest[target - 1] = rightBuffer[rightTail - 1]
            dest[target - 2] = point
        case _ =>
            rightBuffer.copyTo(dest, rightTail - count + 1, target - count + 1, count)
            dest[target - count] = point
    }
}

@OverflowWrapping
private func moveLeftRunSuffix<T>(dest: Array<T>, target: Int64, leftTail: Int64, count: Int64, point: T): Unit {
    match (count) {
        case 0 => dest[target] = point
        case 1 =>
            dest[target] = dest[leftTail]
            dest[target - 1] = point
        case 2 =>
            dest[target] = dest[leftTail]
            dest[target - 1] = dest[leftTail - 1]
            dest[target - 2] = point
        case _ =>
            dest.copyTo(dest, leftTail - count + 1, target - count + 1, count)
            dest[target - count] = point
    }
}

@OverflowWrapping
private func finishMergeFromRight<T>(dest: Array<T>, start1: Int64, rightBuffer: Array<T>, target: Int64,
    leftRest: Int64, rightTail: Int64, rightRest: Int64): Unit {
    if (leftRest == 0) {
        rightBuffer.copyTo(dest, 0, target - rightRest + 1, rightRest)
    }
    if (rightRest == 1) {
        dest.copyTo(dest, start1, start1 + 1, leftRest)
        dest[start1] = rightBuffer[rightTail]
    }
}
