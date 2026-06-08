/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.sort

/**
 * Unstable ascending sort
 *
 * @param data Array to be sorted.
 *
 * @since 0.27.3
 */
@Deprecated[message: "Use global function `public func sort<T>(data: Array<T>, stable!: Bool = false, descending!: Bool = false): Unit where T <: Comparable<T>` instead."]
public func unstableSort<T>(data: Array<T>): Unit where T <: Comparable<T> {
    if (data.size < 2) {
        return
    }
    data.introSort(0, data.size - 1, data.depth())
}

/**
 * Unstable sort
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
public func unstableSort<T>(data: Array<T>, comparator: (T, T) -> Ordering): Unit {
    if (data.size < 2) {
        return
    }
    data.introSort(0, data.size - 1, data.depth(), comparator)
}

extend<T> Array<T> where T <: Comparable<T> {
    @OverflowWrapping
    func introSort(begin: Int64, end: Int64, depth: Int64): Unit {
        var b: Int64 = begin
        var e: Int64 = end
        var d: Int64 = depth
        while (b < e) {
            let len = e - b + 1
            if (len <= 16) {
                if (len == 1) {
                    return
                } else if (len == 2) {
                    if (this[b] > this[e]) {
                        var temp = this[b]
                        this[b] = this[e]
                        this[e] = temp
                    }
                } else if (len == 3) {
                    this.compareSwap3(b, b + 1, e)
                } else {
                    this.insertionSort(b, e)
                }
                return
            }
            if (d == 0) {
                this.heapSort(b, e)
                return
            }
            d--

            let (lo, hi) = this.getPartition(b, e)

            // Let the smaller side do recursion
            // Let the bigger side do loop
            if (lo - b < e - hi) {
                this.introSort(b, lo, d)
                b = hi
            } else {
                this.introSort(hi, e, d)
                e = lo
            }
        }
    }

    @OverflowWrapping
    private func getPartition(begin: Int64, end: Int64): (Int64, Int64) {
        let len: Int64 = end - begin + 1
        let mid: Int64 = (len >> 1) + begin
        if (len >= 64) {
            let off: Int64 = len >> 2
            this.compareSwap3(begin, begin + off, mid)
            this.compareSwap3(mid, mid + off, end)
        }
        this.compareSwap3(begin, mid, end)
        let pivot: T = this[mid]

        // swap mid and end
        let temp = this[end]
        this[end] = pivot
        this[mid] = temp
        var pointNum = 0
        var b = begin
        var e = end - 1

        // query the first value equal to pivot
        var first: Int64 = b
        while (b < e) {
            let tb = this[b]
            if (tb < pivot) {
                b++
            } else if (tb == pivot) {
                pointNum++
                first = b
                b++
                break
            } else if (tb > pivot) {
                var continueBreak = false
                while (b < e) {
                    let te = this[e]
                    if (pivot < te) {
                        e--
                    } else if (pivot == te) {
                        pointNum++
                        this[b] = te
                        this[e] = tb
                        e--
                        first = b
                        b++
                        continueBreak = true
                        break
                    } else {
                        this[b] = te
                        this[e] = tb
                        b++
                        e--
                        break
                    }
                }
                if (continueBreak) {
                    break
                }
            }
        }

        // find partition pivot
        while (b < e) {
            var tb: T = pivot
            while (b < e) {
                tb = this[b]
                if (tb < pivot) {
                    b++
                } else if (tb == pivot) {
                    pointNum++
                    b++
                } else if (tb > pivot) {
                    break
                }
            }
            var te: T = pivot
            while (b < e) {
                te = this[e]
                if (te > pivot) {
                    e--
                } else if (te == pivot) {
                    pointNum++
                    break
                } else {
                    break
                }
            }
            if (b >= e) {
                break
            }
            this[b] = te
            this[e] = tb
            b++
            e--
        }

        if (this[b] <= pivot) {
            b++
        }
        this.swap(b, end)

        if (b - first >= pointNum * pointNum) {
            return (b - 1, b + 1)
        } else {
            // When the number of traversal times is less than the square of the number of pivot
            // merge a large number of values that are the same as pivot
            let hi = b
            b = first
            e = hi - 1
            while (b < e) {
                var te: T = pivot
                while (b < e) {
                    te = this[e]
                    if (te == pivot) {
                        e--
                    } else {
                        break
                    }
                }
                var leftPivotCandidate: T = pivot
                while (b < e) {
                    leftPivotCandidate = this[b]
                    if (leftPivotCandidate != pivot) {
                        b++
                    } else {
                        break
                    }
                }
                if (b >= e) {
                    break
                }
                this[b] = te
                this[e] = leftPivotCandidate
                b++
                e--
            }
            if (this[b] == pivot) {
                b--
            }
            return (b, hi + 1)
        }
    }
}

extend<T> Array<T> {
    // the value range of the parameter: 0 <= begin < end <= array.size - 1
    // end - begin >= 1
    @OverflowWrapping
    private func getPartition(begin: Int64, end: Int64, compareBy: (T, T) -> Ordering): (Int64, Int64) {
        let spanLen: Int64 = end - begin + 1
        let pivotIndex: Int64 = (spanLen >> 1) + begin
        if (spanLen >= 64) {
            let sampleOffset: Int64 = spanLen >> 2
            this.compareSwap3(begin, begin + sampleOffset, pivotIndex, compareBy)
            this.compareSwap3(pivotIndex, pivotIndex + sampleOffset, end, compareBy)
        }
        this.compareSwap3(begin, pivotIndex, end, compareBy)
        let pivotValue: T = this[pivotIndex]

        // swap pivotIndex and end
        let savedValue = this[end]
        this[end] = pivotValue
        this[pivotIndex] = savedValue
        var pivotEqualCount = 0
        var leftScan = begin
        var rightScan = end - 1

        // query the firstPivotEqual value equal to pivotValue
        var firstPivotEqual: Int64 = leftScan
        while (leftScan < rightScan) {
            let leftValue = this[leftScan]
            match (compareBy(leftValue, pivotValue)) {
                case LT => leftScan++
                case EQ =>
                    pivotEqualCount++
                    firstPivotEqual = leftScan
                    leftScan++
                    break
                case GT =>
                    var foundBoundary = false
                    while (leftScan < rightScan) {
                        let rightValue = this[rightScan]
                        match (compareBy(pivotValue, rightValue)) {
                            case LT => rightScan--
                            case EQ =>
                                pivotEqualCount++
                                this[leftScan] = rightValue
                                this[rightScan] = leftValue
                                rightScan--
                                firstPivotEqual = leftScan
                                leftScan++
                                foundBoundary = true
                                break
                            case GT =>
                                this[leftScan] = rightValue
                                this[rightScan] = leftValue
                                leftScan++
                                rightScan--
                                break
                        }
                    }
                    if (foundBoundary) {
                        break
                    }
            }
        }

        // find partition pivotValue
        while (leftScan < rightScan) {
            var leftValue: T = pivotValue
            while (leftScan < rightScan) {
                leftValue = this[leftScan]
                match (compareBy(leftValue, pivotValue)) {
                    case LT => leftScan++
                    case EQ =>
                        pivotEqualCount++
                        leftScan++
                    case GT => break
                }
            }
            var rightValue: T = pivotValue
            while (leftScan < rightScan) {
                rightValue = this[rightScan]
                match (compareBy(pivotValue, rightValue)) {
                    case LT => rightScan--
                    case EQ =>
                        pivotEqualCount++
                        break
                    case GT => break
                }
            }
            if (leftScan >= rightScan) {
                break
            }
            this[leftScan] = rightValue
            this[rightScan] = leftValue
            leftScan++
            rightScan--
        }

        match (compareBy(this[leftScan], pivotValue)) {
            case GT => ()
            case _ => leftScan++
        }
        this.swap(leftScan, end)
        if (leftScan - firstPivotEqual >= pivotEqualCount * pivotEqualCount) {
            return (leftScan - 1, leftScan + 1)
        } else {
            // When the number of traversal times is less than the square of the number of pivotValue
            // merge a large number of values that are the same as pivotValue
            let upperPivotBound = leftScan
            leftScan = firstPivotEqual
            rightScan = upperPivotBound - 1
            while (leftScan < rightScan) {
                var rightValue: T = pivotValue
                while (leftScan < rightScan) {
                    rightValue = this[rightScan]
                    match (compareBy(pivotValue, rightValue)) {
                        case EQ => rightScan--
                        case _ => break
                    }
                }
                var leftPivotCandidate: T = pivotValue
                while (leftScan < rightScan) {
                    leftPivotCandidate = this[leftScan]
                    match (compareBy(leftPivotCandidate, pivotValue)) {
                        case EQ => break
                        case _ => leftScan++
                    }
                }
                if (leftScan >= rightScan) {
                    break
                }
                this[leftScan] = rightValue
                this[rightScan] = leftPivotCandidate
                leftScan++
                rightScan--
            }
            match (compareBy(this[leftScan], pivotValue)) {
                case EQ => leftScan--
                case _ => ()
            }
            return (leftScan, upperPivotBound + 1)
        }
    }

    // the value range of the parameter: 0 <= begin < end <= array.size - 1
    @OverflowWrapping
    func introSort(begin: Int64, end: Int64, depth: Int64, compareBy: (T, T) -> Ordering): Unit {
        var leftScan: Int64 = begin
        var rightScan: Int64 = end
        var depthLeft: Int64 = depth
        while (leftScan < rightScan) {
            let spanLen = rightScan - leftScan + 1
            if (spanLen <= 16) {
                if (spanLen == 1) {
                    return
                } else if (spanLen == 2) {
                    this.compareSwap2(leftScan, rightScan, compareBy)
                } else if (spanLen == 3) {
                    this.compareSwap3(leftScan, leftScan + 1, rightScan, compareBy)
                } else {
                    this.insertionSort(leftScan, rightScan, compareBy)
                }
                return
            }
            if (depthLeft == 0) {
                this.heapSort(leftScan, rightScan, compareBy)
                return
            }
            depthLeft--
            let (lowerPivotBound, upperPivotBound) = this.getPartition(leftScan, rightScan, compareBy)

            // Let the smaller side do recursion
            // Let the bigger side do loop
            if (lowerPivotBound - leftScan < rightScan - upperPivotBound) {
                this.introSort(leftScan, lowerPivotBound, depthLeft, compareBy)
                leftScan = upperPivotBound
            } else {
                this.introSort(upperPivotBound, rightScan, depthLeft, compareBy)
                rightScan = lowerPivotBound
            }
        }
    }
}
