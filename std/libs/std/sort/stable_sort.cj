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
 * @param comparator The sorted comparison strategy.
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
                    lengthArr[n - 1] = l + ln
                    startArr[n] = sn1
                    lengthArr[n] = ln1
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
                lengthArr[n - 1] = l + ln
                startArr[n] = sn1
                lengthArr[n] = ln1
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
                match (c1) {
                    case 0 => this[ti] = point
                    case 1 =>
                        this[ti] = arr[s1]
                        this[ti + 1] = point
                    case 2 =>
                        this[ti] = arr[s1]
                        this[ti + 1] = arr[s1 + 1]
                        this[ti + 2] = point
                    case _ =>
                        arr.copyTo(this, s1, ti, c1)
                        this[ti + c1] = point
                }
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
                match (c2) {
                    case 0 => this[ti] = point
                    case 1 =>
                        this[ti] = this[s2]
                        this[ti + 1] = point
                    case 2 =>
                        this[ti] = this[s2]
                        this[ti + 1] = this[s2 + 1]
                        this[ti + 2] = point
                    case _ =>
                        this.copyTo(this, s2, ti, c2)
                        this[ti + c2] = point
                }
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
        if (l2 == 0) {
            arr.copyTo(this, s1, ti, l1)
        }
        if (l1 == 1) {
            this.copyTo(this, s2, ti, l2)
            this[ti + l2] = arr[s1]
        }
    }

    @OverflowWrapping
    private func mergeFromRight(
        start1: Int64,
        len1: Int64,
        start2: Int64,
        len2: Int64,
        temp: TempArray<T>
    ) {
        let arr = temp.getArray(len2)
        this.copyTo(arr, start2, 0, len2)
        var ti = start2 + len2 - 1
        var s1 = start1 + len1 - 1
        var l1 = len1
        var s2 = len2 - 1
        var l2 = len2
        this[ti] = this[s1]
        ti--
        s1--
        l1--
        var c1 = 0
        var c2 = 0
        var continueBreak = false
        while (true) {
            c1 = 0
            c2 = 0
            continueBreak = false
            var t1 = this[s1]
            var t2 = arr[s2]
            while (true) {
                if (t1 > t2) {
                    this[ti] = t1
                    ti--
                    s1--
                    l1--
                    c1++
                    c2 = 0
                    if (l1 == 0) {
                        continueBreak = true
                        break
                    }
                    if (c1 > 4) {
                        break
                    }

                    t1 = this[s1]
                } else {
                    this[ti] = t2
                    ti--
                    s2--
                    l2--
                    c2++
                    c1 = 0
                    if (l2 == 1) {
                        continueBreak = true
                        break
                    }
                    if (c2 > 4) {
                        break
                    }
                    t2 = arr[s2]
                }
            }
            if (continueBreak) {
                break
            }
            continueBreak = false
            while (true) {
                var point = this[s1]
                let lt = arr.queryLT(point, 0, l2, true)
                c2 = l2 - lt
                match (c2) {
                    case 0 => this[ti] = point
                    case 1 =>
                        this[ti] = arr[s2]
                        this[ti - 1] = point
                    case 2 =>
                        this[ti] = arr[s2]
                        this[ti - 1] = arr[s2 - 1]
                        this[ti - 2] = point
                    case _ =>
                        arr.copyTo(this, lt, ti - c2 + 1, c2)
                        this[ti - c2] = point
                }
                ti = ti - c2 - 1
                s2 -= c2
                l2 -= c2
                s1--
                l1--
                if (l2 == 1 || l1 == 0) {
                    continueBreak = true
                    break
                }
                point = arr[s2]
                let gt = this.queryGT(point, start1, l1, true)
                c1 = s1 - gt + 1
                match (c1) {
                    case 0 => this[ti] = point
                    case 1 =>
                        this[ti] = this[s1]
                        this[ti - 1] = point
                    case 2 =>
                        this[ti] = this[s1]
                        this[ti - 1] = this[s1 - 1]
                        this[ti - 2] = point
                    case _ =>
                        this.copyTo(this, gt, ti - c1 + 1, c1)
                        this[ti - c1] = point
                }
                ti = ti - c1 - 1
                s1 -= c1
                l1 -= c1
                s2--
                l2--
                if (l1 == 0 || l2 == 1) {
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
        if (l1 == 0) {
            arr.copyTo(this, 0, ti - l2 + 1, l2)
        }
        if (l2 == 1) {
            this.copyTo(this, start1, start1 + 1, l1)
            this[start1] = arr[s2]
        }
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
    private func shortSort(begin: Int64, end: Int64, comparator: (T, T) -> Ordering): Unit {
        let len = this.size
        if (len <= 8) {
            if (len <= 1) {
                return
            } else if (len == 2) {
                this.compareSwap2(begin, end, comparator)
            } else if (len == 3) {
                this.compareSwap3(begin, begin + 1, end, comparator)
            } else {
                insertionSort(begin, end, comparator)
            }
        } else {
            var temp = TempArray(len, this[begin])
            let n = getSequenceLength(begin, end, temp, comparator)
            if (n == len) {
                return
            }
            binaryInsertionSort(begin, end, comparator, n)
        }
    }

    @OverflowWrapping
    private func maybeMerge(
        startArr: Array<Int64>,
        lengthArr: Array<Int64>,
        endIndex: Int64,
        temp: TempArray<T>,
        comparator: (T, T) -> Ordering
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
                    this.merge(sn, ln, sn1, ln1, temp, comparator)
                    lengthArr[n] = ln + ln1
                    index--
                }
                break
            }
            let s = startArr[n - 1]
            let l = lengthArr[n - 1]
            if (l <= ln + ln1) {
                if (l < ln1) {
                    this.merge(s, l, sn, ln, temp, comparator)
                    lengthArr[n - 1] = l + ln
                    startArr[n] = sn1
                    lengthArr[n] = ln1
                    index--
                } else {
                    this.merge(sn, ln, sn1, ln1, temp, comparator)
                    lengthArr[n] = ln + ln1
                    index--
                }
            } else if (ln <= ln1) {
                this.merge(sn, ln, sn1, ln1, temp, comparator)
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
        temp: TempArray<T>,
        comparator: (T, T) -> Ordering
    ): Unit {
        var index: Int64 = endIndex
        while (index > 0) {
            var n: Int64 = index - 1
            let sn = startArr[n]
            let sn1 = startArr[n + 1]
            let ln = lengthArr[n]
            let ln1 = lengthArr[n + 1]
            if (n == 0) {
                this.merge(sn, ln, sn1, ln1, temp, comparator)
                break
            }
            let s = startArr[n - 1]
            let l = lengthArr[n - 1]
            if (l < ln1) {
                this.merge(s, l, sn, ln, temp, comparator)
                lengthArr[n - 1] = l + ln
                startArr[n] = sn1
                lengthArr[n] = ln1
                index--
            } else {
                this.merge(sn, ln, sn1, ln1, temp, comparator)
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
        temp: TempArray<T>,
        comparator: (T, T) -> Ordering
    ): Unit {
        var s1 = start1
        var l1 = len1
        var s2 = start2
        var l2 = len2
        var lt = this.queryLT(this[s1 + l1 - 1], s2, l2, comparator, true)
        l2 = lt - s2
        if (l2 == 0) {
            return
        }
        var gt = this.queryGT(this[s2], s1, l1, comparator, false)
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
            mergeFromLeft(s1, l1, s2, l2, temp, comparator)
        } else {
            mergeFromRight(s1, l1, s2, l2, temp, comparator)
        }
    }

    @OverflowWrapping
    private func mergeFromLeft(
        start1: Int64,
        len1: Int64,
        start2: Int64,
        len2: Int64,
        temp: TempArray<T>,
        comparator: (T, T) -> Ordering
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
                match (comparator(t1, t2)) {
                    case GT =>
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
                    case _ =>
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
                c1 = arr.queryGT(point, s1, l1, comparator, false) - s1
                match (c1) {
                    case 0 => this[ti] = point
                    case 1 =>
                        this[ti] = arr[s1]
                        this[ti + 1] = point
                    case 2 =>
                        this[ti] = arr[s1]
                        this[ti + 1] = arr[s1 + 1]
                        this[ti + 2] = point
                    case _ =>
                        arr.copyTo(this, s1, ti, c1)
                        this[ti + c1] = point
                }
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
                c2 = this.queryLT(point, s2, l2, comparator, false) - s2
                match (c2) {
                    case 0 => this[ti] = point
                    case 1 =>
                        this[ti] = this[s2]
                        this[ti + 1] = point
                    case 2 =>
                        this[ti] = this[s2]
                        this[ti + 1] = this[s2 + 1]
                        this[ti + 2] = point
                    case _ =>
                        this.copyTo(this, s2, ti, c2)
                        this[ti + c2] = point
                }
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
        if (l2 == 0) {
            arr.copyTo(this, s1, ti, l1)
        }
        if (l1 == 1) {
            this.copyTo(this, s2, ti, l2)
            this[ti + l2] = arr[s1]
        }
    }

    @OverflowWrapping
    private func mergeFromRight(
        start1: Int64,
        len1: Int64,
        start2: Int64,
        len2: Int64,
        temp: TempArray<T>,
        comparator: (T, T) -> Ordering
    ) {
        let arr = temp.getArray(len2)
        this.copyTo(arr, start2, 0, len2)
        var ti = start2 + len2 - 1
        var s1 = start1 + len1 - 1
        var l1 = len1
        var s2 = len2 - 1
        var l2 = len2
        this[ti] = this[s1]
        ti--
        s1--
        l1--
        var c1 = 0
        var c2 = 0
        var continueBreak = false
        while (true) {
            c1 = 0
            c2 = 0
            continueBreak = false
            var t1 = this[s1]
            var t2 = arr[s2]
            while (true) {
                match (comparator(t1, t2)) {
                    case GT =>
                        this[ti] = t1
                        ti--
                        s1--
                        l1--
                        c1++
                        c2 = 0
                        if (l1 == 0) {
                            continueBreak = true
                            break
                        }
                        if (c1 > 4) {
                            break
                        }

                        t1 = this[s1]
                    case _ =>
                        this[ti] = t2
                        ti--
                        s2--
                        l2--
                        c2++
                        c1 = 0
                        if (l2 == 1) {
                            continueBreak = true
                            break
                        }
                        if (c2 > 4) {
                            break
                        }
                        t2 = arr[s2]
                }
            }
            if (continueBreak) {
                break
            }
            continueBreak = false
            while (true) {
                var point = this[s1]
                let lt = arr.queryLT(point, 0, l2, comparator, true)
                c2 = l2 - lt
                match (c2) {
                    case 0 => this[ti] = point
                    case 1 =>
                        this[ti] = arr[s2]
                        this[ti - 1] = point
                    case 2 =>
                        this[ti] = arr[s2]
                        this[ti - 1] = arr[s2 - 1]
                        this[ti - 2] = point
                    case _ =>
                        arr.copyTo(this, lt, ti - c2 + 1, c2)
                        this[ti - c2] = point
                }
                ti = ti - c2 - 1
                s2 -= c2
                l2 -= c2
                s1--
                l1--
                if (l2 == 1 || l1 == 0) {
                    continueBreak = true
                    break
                }
                point = arr[s2]
                let gt = this.queryGT(point, start1, l1, comparator, true)
                c1 = s1 - gt + 1
                match (c1) {
                    case 0 => this[ti] = point
                    case 1 =>
                        this[ti] = this[s1]
                        this[ti - 1] = point
                    case 2 =>
                        this[ti] = this[s1]
                        this[ti - 1] = this[s1 - 1]
                        this[ti - 2] = point
                    case _ =>
                        this.copyTo(this, gt, ti - c1 + 1, c1)
                        this[ti - c1] = point
                }
                ti = ti - c1 - 1
                s1 -= c1
                l1 -= c1
                s2--
                l2--
                if (l1 == 0 || l2 == 1) {
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
        if (l1 == 0) {
            arr.copyTo(this, 0, ti - l2 + 1, l2)
        }
        if (l2 == 1) {
            this.copyTo(this, start1, start1 + 1, l1)
            this[start1] = arr[s2]
        }
    }

    @OverflowWrapping
    func timSort(comparator: (T, T) -> Ordering): Unit {
        if (this.size <= 64) {
            shortSort(0, this.size - 1, comparator)
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
                seqLen = getSequenceLength(begin, this.size - 1, temp, comparator)
                if (seqLen < mrl) {
                    if (length < mrl) {
                        binaryInsertionSort(begin, begin + length - 1, comparator, seqLen)
                        seqLen = length
                    } else {
                        binaryInsertionSort(begin, begin + mrl - 1, comparator, seqLen)
                        seqLen = mrl
                    }
                }
            }
            endIndex++
            startArr[endIndex] = begin
            lengthArr[endIndex] = seqLen
            begin = begin + seqLen
            endIndex = this.maybeMerge(startArr, lengthArr, endIndex, temp, comparator)
        }
        this.mergeAll(startArr, lengthArr, endIndex, temp, comparator)
    }
}

class TempArray<T> {
    private var data: Array<T>
    private let zero: T
    private let max: Int64

    init(n: Int64, z: T) {
        this.data = Array<T>()
        this.max = n >> 1
        this.zero = z
    }

    @OverflowWrapping
    func getArray(n: Int64): Array<T> {
        if (data.size >= n) {
            return this.data
        }
        var newSize = data.size * 2
        if (newSize < n) {
            newSize = n
        }
        if (newSize > this.max) {
            newSize = this.max
        }
        this.data = Array<T>(newSize, repeat: this.zero)
        return this.data
    }
}
