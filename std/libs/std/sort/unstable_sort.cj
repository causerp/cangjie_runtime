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
 * @param comparator The sorted comparison strategy.
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
                var tb: T = pivot
                while (b < e) {
                    tb = this[b]
                    if (tb != pivot) {
                        b++
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
    private func getPartition(begin: Int64, end: Int64, comparator: (T, T) -> Ordering): (Int64, Int64) {
        let len: Int64 = end - begin + 1
        let mid: Int64 = (len >> 1) + begin
        if (len >= 64) {
            let off: Int64 = len >> 2
            this.compareSwap3(begin, begin + off, mid, comparator)
            this.compareSwap3(mid, mid + off, end, comparator)
        }
        this.compareSwap3(begin, mid, end, comparator)
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
            match (comparator(tb, pivot)) {
                case LT => b++
                case EQ =>
                    pointNum++
                    first = b
                    b++
                    break
                case GT =>
                    var continueBreak = false
                    while (b < e) {
                        let te = this[e]
                        match (comparator(pivot, te)) {
                            case LT => e--
                            case EQ =>
                                pointNum++
                                this[b] = te
                                this[e] = tb
                                e--
                                first = b
                                b++
                                continueBreak = true
                                break
                            case GT =>
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
                match (comparator(tb, pivot)) {
                    case LT => b++
                    case EQ =>
                        pointNum++
                        b++
                    case GT => break
                }
            }
            var te: T = pivot
            while (b < e) {
                te = this[e]
                match (comparator(pivot, te)) {
                    case LT => e--
                    case EQ =>
                        pointNum++
                        break
                    case GT => break
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

        match (comparator(this[b], pivot)) {
            case GT => ()
            case _ => b++
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
                    match (comparator(pivot, te)) {
                        case EQ => e--
                        case _ => break
                    }
                }
                var tb: T = pivot
                while (b < e) {
                    tb = this[b]
                    match (comparator(tb, pivot)) {
                        case EQ => break
                        case _ => b++
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
            match (comparator(this[b], pivot)) {
                case EQ => b--
                case _ => ()
            }
            return (b, hi + 1)
        }
    }

    // the value range of the parameter: 0 <= begin < end <= array.size - 1
    @OverflowWrapping
    func introSort(begin: Int64, end: Int64, depth: Int64, comparator: (T, T) -> Ordering): Unit {
        var b: Int64 = begin
        var e: Int64 = end
        var d: Int64 = depth
        while (b < e) {
            let len = e - b + 1
            if (len <= 16) {
                if (len == 1) {
                    return
                } else if (len == 2) {
                    this.compareSwap2(b, e, comparator)
                } else if (len == 3) {
                    this.compareSwap3(b, b + 1, e, comparator)
                } else {
                    this.insertionSort(b, e, comparator)
                }
                return
            }
            if (d == 0) {
                this.heapSort(b, e, comparator)
                return
            }
            d--
            let (lo, hi) = this.getPartition(b, e, comparator)

            // Let the smaller side do recursion
            // Let the bigger side do loop
            if (lo - b < e - hi) {
                this.introSort(b, lo, d, comparator)
                b = hi
            } else {
                this.introSort(hi, e, d, comparator)
                e = lo
            }
        }
    }
}
