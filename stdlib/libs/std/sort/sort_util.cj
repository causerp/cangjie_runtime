/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.sort

import std.math.*

extend<T> Array<T> {
    @OverflowWrapping
    func reverseRange(begin: Int64, end: Int64): Unit {
        var i = begin
        var j = end
        while (i < j) {
            this.swap(i, j)
            i++
            j--
        }
    }

    @OverflowWrapping
    func moveEqualPrefixAfterDescendingRun(begin: Int64, equalNum: Int64, n: Int64, temp: TempArray<T>): Unit {
        if (equalNum == 1) {
            reverseRange(begin, begin + n)
            return
        }
        reverseRange(begin + equalNum, begin + equalNum + n - 1)
        if (equalNum == 2) {
            let t1 = this[begin]
            let t2 = this[begin + 1]
            if (n == 1) {
                this[begin] = this[begin + 2]
                this[begin + 1] = t1
                this[begin + 2] = t2
            } else if (n == 2) {
                this[begin] = this[begin + 2]
                this[begin + 1] = this[begin + 3]
                this[begin + 2] = t1
                this[begin + 3] = t2
            } else {
                this.copyTo(this, begin + 2, begin, n)
                this[begin + equalNum + n - 2] = t1
                this[begin + equalNum + n - 1] = t2
            }
            return
        }
        if (n == 1) {
            let t = this[begin + equalNum]
            this.copyTo(this, begin, begin + 1, equalNum)
            this[begin] = t
        } else if (n == 2) {
            let t1 = this[begin + equalNum]
            let t2 = this[begin + equalNum + 1]
            this.copyTo(this, begin, begin + 2, equalNum)
            this[begin] = t1
            this[begin + 1] = t2
        } else {
            if (n < equalNum) {
                let arr = temp.getArray(n)
                this.copyTo(arr, begin + equalNum, 0, n)
                this.copyTo(this, begin, begin + n, equalNum)
                arr.copyTo(this, 0, begin, n)
            } else {
                let arr = temp.getArray(equalNum)
                this.copyTo(arr, begin, 0, equalNum)
                this.copyTo(this, begin + equalNum, begin, n)
                arr.copyTo(this, 0, begin + n, equalNum)
            }
        }
    }

    @OverflowWrapping
    func insertPoint(from: Int64, to: Int64, point: T): Unit {
        let moveN = from - to
        match (moveN) {
            case 0 => ()
            case 1 => this[from] = this[from - 1]
            case 2 =>
                this[from] = this[from - 1]
                this[from - 1] = this[from - 2]
            case _ => this.copyTo(this, to, to + 1, moveN)
        }
        this[to] = point
    }
}

func recordMergedLeftRunAndKeepRightRun(
    startArr: Array<Int64>,
    lengthArr: Array<Int64>,
    index: Int64,
    rightStart: Int64,
    rightLength: Int64,
    mergedLeftLength: Int64
): Unit {
    lengthArr[index - 1] = mergedLeftLength
    startArr[index] = rightStart
    lengthArr[index] = rightLength
}

extend<T> Array<T> where T <: Comparable<T> {
    func compareSwap3(i1: Int64, i2: Int64, i3: Int64) {
        var a: T = this[i1]
        var b: T = this[i2]
        var c: T = this[i3]
        if (a > b) {
            var temp = a
            a = b
            b = temp
        }
        if (c < a) {
            this[i1] = c
            this[i2] = a
            this[i3] = b
        } else if (c < b) {
            this[i1] = a
            this[i2] = c
            this[i3] = b
        } else {
            this[i1] = a
            this[i2] = b
            this[i3] = c
        }
    }

    func insertionSort(begin: Int64, end: Int64): Unit {
        var i: Int64 = begin + 1
        while (i <= end) {
            var point = this[i]
            var j = i - 1
            while (j >= begin) {
                var temp = this[j]
                if (temp > point) {
                    this[j + 1] = temp
                } else {
                    break
                }
                j--
            }
            this[j + 1] = point
            i++
        }
    }

    // the value range of the parameter: 0 <= begin < end <= array.size - 1
    @OverflowWrapping
    func heapify(begin: Int64, end: Int64, root: Int64): Unit {
        var fi: Int64 = root
        var si = (fi << 1) + 1 // fi * 2 + 1
        while (begin + si <= end) {
            // si or (si + 1) is taken only once
            let s = if (begin + si + 1 <= end) {
                let s1 = this[begin + si]
                let s2 = this[begin + si + 1]
                if (s1 < s2) {
                    si++
                    s2
                } else {
                    s1
                }
            } else {
                this[begin + si]
            }
            let f = this[begin + fi]
            if (f < s) {
                this[begin + fi] = s
                this[begin + si] = f
            } else {
                return
            }
            fi = si
            si = (fi << 1) + 1
        }
    }

    // the value range of the parameter: 0 <= begin < end <= array.size - 1
    @OverflowWrapping
    func heapSort(begin: Int64, end: Int64): Unit {
        let len = end - begin + 1
        var i = (len >> 1) - 1

        // build max or min heap
        while (i >= 0) {
            this.heapify(begin, end, i)
            i--
        }
        i = end
        while (i > begin) {
            // swap top and bottom data
            this.swap(begin, i)
            // reset max or min heap
            this.heapify(begin, i - 1, 0)
            i--
        }
    }

    @OverflowWrapping
    func getEqualPrefixInfo(begin: Int64, end: Int64): (Int64, Int64, Bool) {
        var b: Int64 = begin
        var equalNum: Int64 = 1
        var isAscending: Bool = true

        if (this[b] < this[b + 1]) {
            isAscending = true
        } else if (this[b] > this[b + 1]) {
            isAscending = false
        } else {
            equalNum++
            b++
            while (b + 1 <= end) {
                if (this[b] < this[b + 1]) {
                    isAscending = true
                    break
                } else if (this[b] > this[b + 1]) {
                    isAscending = false
                    break
                } else {
                    equalNum++
                    b++
                }
            }
        }
        (b, equalNum, isAscending)
    }

    @OverflowWrapping
    func handleShortSequence(begin: Int64, end: Int64, equalNum: Int64, isAscending: Bool): Int64 {
        if (!isAscending) {
            let te = this[end]
            this.copyTo(this, begin, begin + 1, equalNum)
            this[begin] = te
        }
        return equalNum + 1
    }

    @OverflowWrapping
    func countAscendingRun(begin: Int64, end: Int64): Int64 {
        var b = begin
        var n: Int64 = 1
        while (b + 1 <= end && this[b] <= this[b + 1]) {
            n++
            b++
        }
        n
    }

    @OverflowWrapping
    func countDescendingRun(begin: Int64, end: Int64): Int64 {
        var b = begin
        var n: Int64 = 1
        while (b + 1 <= end && this[b] > this[b + 1]) {
            n++
            b++
        }
        n
    }

    // the value range of the parameter: 0 <= begin < end <= array.size - 1
    // end - begin >= 1
    @OverflowWrapping
    func getSequenceLength(begin: Int64, end: Int64, temp: TempArray<T>): Int64 {
        var (b, equalNum, isAscending) = getEqualPrefixInfo(begin, end)

        if (b >= end) {
            return equalNum
        } else if (end - b == 1) {
            return handleShortSequence(begin, end, equalNum, isAscending)
        }
        b++
        if (isAscending) {
            return equalNum + countAscendingRun(b, end)
        }

        let n = countDescendingRun(b, end)
        moveEqualPrefixAfterDescendingRun(begin, equalNum, n, temp)
        return equalNum + n
    }

    @OverflowWrapping
    func binaryInsertionSort(begin: Int64, end: Int64, n: Int64) {
        var i = begin + n
        while (i <= end) {
            let point = this[i]
            let l = this.binaryQueryGT(point, begin, i - begin)
            let moveN = i - l
            if (moveN == 0) {
                i++
                continue
            }
            insertPoint(i, l, point)
            i++
        }
    }

    // The queried position is just greater than and equal the previous value.
    @OverflowWrapping
    func binaryQueryGT(point: T, start: Int64, len: Int64): Int64 {
        var l = start
        var r = start + len
        while (l < r) {
            let m = l + ((r - l) >> 1)
            if (point < this[m]) {
                r = m
            } else {
                l = m + 1
            }
        }
        return l
    }

    // The queried position is just less than and equal the next value.
    @OverflowWrapping
    func binaryQueryLT(point: T, start: Int64, len: Int64): Int64 {
        var l = start
        var r = start + len
        while (l < r) {
            let m = l + ((r - l) >> 1)
            if (point <= this[m]) {
                r = m
            } else {
                l = m + 1
            }
        }
        return l
    }

    // The queried position is just greater than and equal the previous value.
    @OverflowWrapping
    func queryGT(point: T, start: Int64, len: Int64, r: Bool) {
        var gallopMax = len
        if (r) {
            let end = start + len - 1
            if (len > 64) {
                let gallopMid = Int64(sqrt(Float64(len)))
                if (point < this[end - gallopMid]) {
                    return this.binaryQueryGT(point, start, len - gallopMid)
                } else {
                    gallopMax = gallopMid
                }
            }
            var ofs = 1
            var lastOfs = 0
            while (ofs < gallopMax) {
                if (point < this[end - ofs]) {
                    lastOfs = ofs
                    ofs = (ofs << 1) + 1
                } else {
                    break
                }
            }
            if (ofs > gallopMax) {
                ofs = gallopMax
            }
            return this.binaryQueryGT(point, start + len - ofs, ofs - lastOfs)
        } else {
            if (len > 64) {
                let gallopMid = Int64(sqrt(Float64(len)))
                if (point < this[start + gallopMid]) {
                    gallopMax = gallopMid
                } else {
                    return this.binaryQueryGT(point, start + gallopMid, len - gallopMid)
                }
            }
            var ofs = 1
            var lastOfs = 0
            while (ofs < gallopMax) {
                if (point < this[start + ofs]) {
                    break
                } else {
                    lastOfs = ofs
                    ofs = (ofs << 1) + 1
                }
            }
            if (ofs > gallopMax) {
                ofs = gallopMax
            }
            return this.binaryQueryGT(point, start + lastOfs, ofs - lastOfs)
        }
    }

    // The queried position is just less than and equal the next value.
    @OverflowWrapping
    func queryLT(point: T, start: Int64, len: Int64, r: Bool) {
        var gallopMax = len
        if (r) {
            let end = start + len - 1
            if (len > 64) {
                let gallopMid = Int64(sqrt(Float64(len)))
                if (point > this[end - gallopMid]) {
                    gallopMax = gallopMid
                } else {
                    return this.binaryQueryLT(point, start, len - gallopMid)
                }
            }
            var ofs = 1
            var lastOfs = 0
            while (ofs < gallopMax) {
                if (point > this[end - ofs]) {
                    break
                } else {
                    lastOfs = ofs
                    ofs = (ofs << 1) + 1
                }
            }
            if (ofs > gallopMax) {
                ofs = gallopMax
            }
            return this.binaryQueryLT(point, start + len - ofs, ofs - lastOfs)
        } else {
            if (len > 64) {
                let gallopMid = Int64(sqrt(Float64(len)))
                if (point > this[start + gallopMid]) {
                    return this.binaryQueryLT(point, start + gallopMid, len - gallopMid)
                } else {
                    gallopMax = gallopMid
                }
            }
            var ofs = 1
            var lastOfs = 0
            while (ofs < gallopMax) {
                if (point > this[start + ofs]) {
                    lastOfs = ofs
                    ofs = (ofs << 1) + 1
                } else {
                    break
                }
            }
            if (ofs > gallopMax) {
                ofs = gallopMax
            }
            return this.binaryQueryLT(point, start + lastOfs, ofs - lastOfs)
        }
    }
}

extend<T> Array<T> {
    // the value range of the parameter: 0 <= i1 < i2 <= array.size - 1
    func compareSwap2(i1: Int64, i2: Int64, comparator: (T, T) -> Ordering) {
        let a: T = this[i1]
        let b: T = this[i2]
        match (comparator(a, b)) {
            case GT =>
                this[i1] = b
                this[i2] = a
            case _ => ()
        }
    }

    // the value range of the parameter: 0 <= i1 < i2 < i3 <= array.size - 1
    // Ordering.LT/EQ: a <= b <= c
    // Ordering.GT   : a >= b >= c
    func compareSwap3(i1: Int64, i2: Int64, i3: Int64, comparator: (T, T) -> Ordering) {
        var a: T = this[i1]
        var b: T = this[i2]
        var c: T = this[i3]
        if (comparator(a, b) == GT) {
            var temp = a
            a = b
            b = temp
        }
        if (comparator(c, a) == LT) {
            this[i1] = c
            this[i2] = a
            this[i3] = b
        } else if (comparator(c, b) == LT) {
            this[i1] = a
            this[i2] = c
            this[i3] = b
        } else {
            this[i1] = a
            this[i2] = b
            this[i3] = c
        }
    }

    @OverflowWrapping
    func getMinRunLength() {
        var n = this.size
        var r: Int64 = 0
        while (n >= 64) {
            r = r | (n & 1)
            n = n >> 1
        }
        return n + r
    }

    @OverflowWrapping
    func depth(): Int64 {
        var x: Int64 = this.size
        var res: Int64 = 0
        while (x >= 1) {
            res++
            x >>= 1
        }
        return res * 2
    }

    // the value range of the parameter: 0 <= begin < end <= array.size - 1
    @OverflowWrapping
    func insertionSort(begin: Int64, end: Int64, comparator: (T, T) -> Ordering): Unit {
        var i: Int64 = begin + 1
        while (i <= end) {
            var point = this[i]
            var j = i - 1
            while (j >= begin) {
                var temp = this[j]
                match (comparator(temp, point)) {
                    case GT => this[j + 1] = temp
                    case _ => break
                }
                j--
            }
            this[j + 1] = point
            i++
        }
    }

    @OverflowWrapping
    func getEqualPrefixInfoByComparator(
        begin: Int64,
        end: Int64,
        comparator: (T, T) -> Ordering
    ): (Int64, Int64, Bool) {
        var b: Int64 = begin
        var equalNum: Int64 = 1
        var isAscending: Bool = true

        match (comparator(this[b], this[b + 1])) {
            case LT => isAscending = true
            case GT => isAscending = false
            case EQ =>
                equalNum++
                b++
                while (b + 1 <= end) {
                    match (comparator(this[b], this[b + 1])) {
                        case LT =>
                            isAscending = true
                            break
                        case GT =>
                            isAscending = false
                            break
                        case EQ =>
                            equalNum++
                            b++
                    }
                }
        }
        (b, equalNum, isAscending)
    }

    @OverflowWrapping
    func handleShortSequenceByComparator(begin: Int64, end: Int64, equalNum: Int64, isAscending: Bool): Int64 {
        if (!isAscending) {
            let te = this[end]
            this.copyTo(this, begin, begin + 1, equalNum)
            this[begin] = te
        }
        return equalNum + 1
    }

    @OverflowWrapping
    func countAscendingRunByComparator(begin: Int64, end: Int64, comparator: (T, T) -> Ordering): Int64 {
        var b = begin
        var n: Int64 = 1
        while (b + 1 <= end) {
            match (comparator(this[b], this[b + 1])) {
                case GT => break
                case _ =>
                    n++
                    b++
            }
        }
        n
    }

    @OverflowWrapping
    func countDescendingRunByComparator(begin: Int64, end: Int64, comparator: (T, T) -> Ordering): Int64 {
        var b = begin
        var n: Int64 = 1
        while (b + 1 <= end) {
            match (comparator(this[b], this[b + 1])) {
                case GT =>
                    n++
                    b++
                case _ => break
            }
        }
        n
    }

    // the value range of the parameter: 0 <= begin < end <= array.size - 1
    // end - begin >= 1
    @OverflowWrapping
    func getSequenceLength(begin: Int64, end: Int64, temp: TempArray<T>, comparator: (T, T) -> Ordering): Int64 {
        var (b, equalNum, isAscending) = getEqualPrefixInfoByComparator(begin, end, comparator)
        if (b >= end) {
            return equalNum
        } else if (end - b == 1) {
            return handleShortSequenceByComparator(begin, end, equalNum, isAscending)
        }
        b++
        if (isAscending) {
            return equalNum + countAscendingRunByComparator(b, end, comparator)
        }

        let n = countDescendingRunByComparator(b, end, comparator)
        moveEqualPrefixAfterDescendingRun(begin, equalNum, n, temp)
        return equalNum + n
    }

    // the original relative positions of equal elements are not guaranteed.
    // the value range of the parameter: 0 <= begin < end <= array.size - 1
    @OverflowWrapping
    func binaryInsertionSort(begin: Int64, end: Int64, comparator: (T, T) -> Ordering, n: Int64) {
        var cursor = begin + n
        while (cursor <= end) {
            let probe = this[cursor]
            let insertAt = this.binaryQueryGT(probe, begin, cursor - begin, comparator)
            let shiftLen = cursor - insertAt
            if (shiftLen == 0) {
                cursor++
                continue
            }
            insertPoint(cursor, insertAt, probe)
            cursor++
        }
    }

    // the value range of the parameter: 0 <= begin < end <= array.size - 1
    @OverflowWrapping
    func heapify(begin: Int64, end: Int64, root: Int64, comparator: (T, T) -> Ordering): Unit {
        var fi: Int64 = root
        var si = (fi << 1) + 1 // fi * 2 + 1
        while (begin + si <= end) {
            // si or (si + 1) is taken only once
            let s = if (begin + si + 1 <= end) {
                let s1 = this[begin + si]
                let s2 = this[begin + si + 1]
                match (comparator(s1, s2)) {
                    case LT =>
                        si++
                        s2
                    case _ => s1
                }
            } else {
                this[begin + si]
            }
            let f = this[begin + fi]
            match (comparator(f, s)) {
                case LT =>
                    this[begin + fi] = s
                    this[begin + si] = f
                case _ => return
            }
            fi = si
            si = (fi << 1) + 1
        }
    }

    // the value range of the parameter: 0 <= begin < end <= array.size - 1
    @OverflowWrapping
    func heapSort(begin: Int64, end: Int64, comparator: (T, T) -> Ordering): Unit {
        let len = end - begin + 1
        var i = (len >> 1) - 1

        // build max or min heap
        while (i >= 0) {
            this.heapify(begin, end, i, comparator)
            i--
        }
        i = end
        while (i > begin) {
            // swap top and bottom data
            this.swap(begin, i)

            // reset max or min heap
            this.heapify(begin, i - 1, 0, comparator)
            i--
        }
    }

    // The queried position is just greater than and equal the previous value.
    @OverflowWrapping
    func binaryQueryGT(point: T, start: Int64, len: Int64, comparator: (T, T) -> Ordering): Int64 {
        var l = start
        var r = start + len
        while (l < r) {
            let m = l + ((r - l) >> 1)
            match (comparator(point, this[m])) {
                case LT => r = m
                case _ => l = m + 1
            }
        }
        return l
    }

    // The queried position is just less than and equal the next value.
    @OverflowWrapping
    func binaryQueryLT(point: T, start: Int64, len: Int64, comparator: (T, T) -> Ordering): Int64 {
        var l = start
        var r = start + len
        while (l < r) {
            let m = l + ((r - l) >> 1)
            match (comparator(point, this[m])) {
                case GT => l = m + 1
                case _ => r = m
            }
        }
        return l
    }

    // The queried position is just greater than and equal the previous value.
    @OverflowWrapping
    func queryGT(point: T, start: Int64, len: Int64, comparator: (T, T) -> Ordering, r: Bool) {
        var gallopMax = len
        if (r) {
            let end = start + len - 1
            if (len > 64) {
                let gallopMid = Int64(sqrt(Float64(len)))
                match (comparator(point, this[end - gallopMid])) {
                    case LT => return this.binaryQueryGT(point, start, len - gallopMid, comparator)
                    case _ => gallopMax = gallopMid
                }
            }
            var ofs = 1
            var lastOfs = 0
            while (ofs < gallopMax) {
                let t = this[end - ofs]
                match (comparator(point, t)) {
                    case LT =>
                        lastOfs = ofs
                        ofs = (ofs << 1) + 1
                    case _ => break
                }
            }
            if (ofs > gallopMax) {
                ofs = gallopMax
            }
            return this.binaryQueryGT(point, start + len - ofs, ofs - lastOfs, comparator)
        } else {
            if (len > 64) {
                let gallopMid = Int64(sqrt(Float64(len)))
                match (comparator(point, this[start + gallopMid])) {
                    case LT => gallopMax = gallopMid
                    case _ => return this.binaryQueryGT(point, start + gallopMid, len - gallopMid, comparator)
                }
            }
            var ofs = 1
            var lastOfs = 0
            while (ofs < gallopMax) {
                let t = this[start + ofs]
                match (comparator(point, t)) {
                    case LT => break
                    case _ =>
                        lastOfs = ofs
                        ofs = (ofs << 1) + 1
                }
            }
            if (ofs > gallopMax) {
                ofs = gallopMax
            }
            return this.binaryQueryGT(point, start + lastOfs, ofs - lastOfs, comparator)
        }
    }

    // The queried position is just less than and equal the next value.
    @OverflowWrapping
    func queryLT(point: T, start: Int64, len: Int64, comparator: (T, T) -> Ordering, r: Bool) {
        var gallopMax = len
        if (r) {
            let end = start + len - 1
            if (len > 64) {
                let gallopMid = Int64(sqrt(Float64(len)))
                match (comparator(point, this[end - gallopMid])) {
                    case GT => gallopMax = gallopMid
                    case _ => return this.binaryQueryLT(point, start, len - gallopMid, comparator)
                }
            }
            var ofs = 1
            var lastOfs = 0
            while (ofs < gallopMax) {
                let t = this[end - ofs]
                match (comparator(point, t)) {
                    case GT => break
                    case _ =>
                        lastOfs = ofs
                        ofs = (ofs << 1) + 1
                }
            }
            if (ofs > gallopMax) {
                ofs = gallopMax
            }
            return this.binaryQueryLT(point, start + len - ofs, ofs - lastOfs, comparator)
        } else {
            if (len > 64) {
                let gallopMid = Int64(sqrt(Float64(len)))
                match (comparator(point, this[start + gallopMid])) {
                    case GT => return this.binaryQueryLT(point, start + gallopMid, len - gallopMid, comparator)
                    case _ => gallopMax = gallopMid
                }
            }
            var ofs = 1
            var lastOfs = 0
            while (ofs < gallopMax) {
                let t = this[start + ofs]
                match (comparator(point, t)) {
                    case GT =>
                        lastOfs = ofs
                        ofs = (ofs << 1) + 1
                    case _ => break
                }
            }
            if (ofs > gallopMax) {
                ofs = gallopMax
            }
            return this.binaryQueryLT(point, start + lastOfs, ofs - lastOfs, comparator)
        }
    }
}
