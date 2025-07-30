/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.core

@ConstSafe
public struct Array<T> {
    let rawptr: RawArray<T>
    let start: Int64
    let len: Int64

    @Frozen
    func toRawArray() {
        if (len == 0) {
            return RawArray<T>()
        }
        let newRawPtr = RawArray<T>(len, repeat: unsafe { zeroValue<T>() })
        intrinsicBuiltInCopyTo<T>(this.rawptr, newRawPtr, this.start, 0, len)
        return newRawPtr
    }

    @Frozen
    public const init() {
        this.start = 0
        this.rawptr = RawArray<T>()
        this.len = 0
    }

    @Frozen
    public init(size: Int64, repeat!: T) {
        this.start = 0
        this.rawptr = RawArray<T>(size, repeat: repeat)
        this.len = size
    }

    @Frozen
    init(elements: Collection<T>) {
        this.start = 0
        this.rawptr = RawArray<T>(elements)
        this.len = arraySize(rawptr)
    }

    @Frozen
    public init(size: Int64, initElement: (Int64) -> T) {
        this.start = 0
        this.rawptr = RawArray<T>(size, initElement)
        this.len = size
    }

    @Frozen
    init(data: RawArray<T>, start: Int64, len: Int64) {
        this.rawptr = data
        this.start = start
        this.len = len
    }

    @Frozen
    public prop first: Option<T> {
        get() {
            if (this.len == 0) {
                return None
            }
            return this[0]
        }
    }

    @Frozen
    public prop last: Option<T> {
        get() {
            if (this.len == 0) {
                return None
            }
            return this[len - 1]
        }
    }

    /**
     * @return slice of this Array
     * @throws IndexOutOfBoundsException if `start` is negative, or `len` is negative,
     *         or `start + len` is greater than the size of array.
     */
    @Frozen
    public func slice(start: Int64, len: Int64): Array<T> {
        if (start < 0 || len < 0 || (start + len) > this.len) {
            throw IndexOutOfBoundsException("The size of Array is ${this.len}, start is ${start}, length is ${len}.")
        }
        return Array(this.rawptr, this.start + start, len)
    }

    @OverflowWrapping
    @Frozen
    public func get(index: Int64): Option<T> {
        if (UInt64(index) >= UInt64(this.len)) {
            return None<T>
        }
        return Some<T>(arrayGetUnchecked(this.rawptr, start + index))
    }

    /**
     * @throws IndexOutOfBoundsException if `index` is negative or
     *         greater than or equal to the size of array.
     */
    @Frozen
    @OverflowWrapping
    public operator func [](index: Int64): T {
        // Using type conversion to replace typical bounds checking,
        // if (index < 0 || index >= this.len), to a single comparison.
        // The negative value of index will be converted to a large positive number
        // when `index` and `this.len` are interpreted as UInt64 and will trigger the exception.
        if (UInt64(index) >= UInt64(this.len)) {
            throw IndexOutOfBoundsException("The length of the array is ${this.len}, but the index is ${index}.")
        }
        return arrayGetUnchecked(this.rawptr, start + index)
    }

    /**
     * @throws IndexOutOfBoundsException if `index` is negative or
     *         greater than or equal to the size of array.
     */
    @Frozen
    @OverflowWrapping
    public operator func [](index: Int64, value!: T): Unit {
        if (UInt64(index) >= UInt64(this.len)) {
            throw IndexOutOfBoundsException("The length of the array is ${this.len}, but the index is ${index}.")
        }
        return arraySetUnchecked(this.rawptr, start + index, value)
    }

    /**
     * @throws IllegalArgumentException if the `step` of `range` is not equal to 1.
     * @throws IndexOutOfBoundsException if the `range` is invalid for this array.
     */
    @Frozen
    public operator func [](range: Range<Int64>): Array<T> {
        return rangeSlice(range, this.len)
    }

    @Frozen
    public func fill(value: T): Unit {
        for (i in 0..this.len) {
            arraySetUnchecked(this.rawptr, this.start + i, value)
        }
    }

    /**
     * @throws IllegalArgumentException if the `step` of `range` is not equal to 1,
     *         or the size of `value` is not equal to the length of `range`.
     * @throws IndexOutOfBoundsException if `range` is invalid for this array.
     */
    @Frozen
    public operator func [](range: Range<Int64>, value!: Array<T>): Unit {
        if (range.step != 1) {
            throw IllegalArgumentException("Illegal step ${range.step}, step should be 1.")
        }

        let (start_, end_): (Int64, Int64) = normalize(range)
        if (!isLegal(start_, end_)) {
            throw IndexOutOfBoundsException(
                "The length of the array is ${this.len}, but the actual range is ${rangeToString(range)}.")
        }
        let rangeSize = end_ - start_
        if (rangeSize != value.size) {
            throw IllegalArgumentException(
                "The length of the value array is ${value.size}, which does not match the range length of ${rangeSize}."
            )
        }

        intrinsicBuiltInCopyTo<T>(value.rawptr, this.rawptr, value.start, this.start + start_, rangeSize)
    }

    /** Reverse array elements in place. */
    @Frozen
    @OverflowWrapping
    public func reverse(): Unit {
        var i: Int64 = start
        var j: Int64 = start + len - 1
        while (i < j) {
            let tmp: T = arrayGet(rawptr, i)
            arraySet(rawptr, i, arrayGet(rawptr, j))
            arraySet(rawptr, j, tmp)
            i = i + 1
            j = j - 1
        }
    }

    /**
     * Special processing is performed for 0 in the following cases:
     * When Range is 0..(excluding 0..=)(that is, start=0, hasStart=true, hasStop=false, isClosed=false)
     * If the array or buffer is empty, an empty array or buffer is returned.
     * When Range is 0..0(excluding 0..=0)(that is, start=0, hasStart=true, stop=0, hasStop=true, isClosed=false)
     * If the array or buffer is empty, an empty array or buffer is returned.
     * For other ranges, start and end out-of-bounds check is performed normally,
     * including the range that is actually empty.
     *
     * @param range
     * @param size Size of the collection
     *
     * @return Parameters of start*stop*step*offset.
     * @since 0.25.2
     *
     * @throws IllegalArgumentException if the `step` of `range` is not equal to 1.
     * @throws IndexOutOfBoundsException if the `range` is invalid for this array.
     */
    @Frozen
    private func rangeSlice(range: Range<Int64>, _: Int64): Array<T> {
        if (range.step != 1) {
            throw IllegalArgumentException("Illegal step ${range.step}, step should be 1.")
        }

        let (start_, end_): (Int64, Int64) = normalize(range)
        if (!isLegal(start_, end_)) {
            throw IndexOutOfBoundsException(
                "The length of the array is ${this.len}, but the actual range is ${rangeToString(range)}.")
        }
        return Array<T>(this.rawptr, this.start + start_, end_ - start_)
    }

    // The parameters represents a half-open range [start_, end_)
    @Frozen
    private const func isLegal(start_: Int64, end_: Int64): Bool {
        0 <= start_ && start_ <= end_ && end_ <= this.len
    }

    // normalize Range<Int64> to half-open range [start, end)
    @Frozen
    @OverflowWrapping
    private const func normalize(range: Range<Int64>): (Int64, Int64) {
        var start = if (range.hasStart) {
            range.start
        } else {
            0
        }
        var end = if (range.hasEnd) {
            range.end
        } else {
            this.len
        }
        if (range.isClosed && range.hasEnd) {
            end += if (range.step > 0) {
                1
            } else {
                -1
            }
        }
        return (start, end)
    }

    private const func rangeToString(range: Range<Int64>): String {
        let start = if (range.hasStart) {
            range.start
        } else {
            0
        }
        let end = if (range.hasEnd) {
            range.end
        } else {
            this.len
        }
        match ((range.step > 0, range.isClosed)) {
            case (true, true) => "[${start}, ${end}]"
            case (true, false) => "[${start}, ${end})"
            case (false, true) => "[${end}, ${start}]"
            case (false, false) => "(${end}, ${start}]"
        }
    }

    /** Dummy function, used for function overloading check. */
    @Frozen
    public func clone(): Array<T> {
        if (len == 0) {
            return Array<T>()
        }
        let newRawPtr = RawArray<T>(len, repeat: unsafe { zeroValue<T>() })
        intrinsicBuiltInCopyTo<T>(this.rawptr, newRawPtr, this.start, 0, len)
        return Array<T>(newRawPtr, 0, len)
    }

    /*
     * @throws IndexOutOfBoundsException if the `range` is invalid for this array.
     */
    @Frozen
    @OverflowWrapping
    public func clone(range: Range<Int64>): Array<T> {
        let (start_, end_): (Int64, Int64) = normalize(range)
        let step = range.step
        if ((step > 0 && !isLegal(start_, end_)) || (step < 0 && !isLegal(end_ + 1, start_ + 1))) {
            throw IndexOutOfBoundsException(
                "The length of the array is ${this.len}, but the actual range is ${rangeToString(range)}.")
        }

        let arr: Array<T> = this
        let offset: Int64 = if (step > 0) {
            -1
        } else {
            1
        }
        let newSize: Int64 = (end_ - start_ + step + offset) / step
        if (step == 1 && newSize != 0) {
            var newArr: Array<T> = Array<T>(newSize, repeat: unsafe { zeroValue<T>() })
            intrinsicBuiltInCopyTo<T>(this.rawptr, newArr.rawptr, this.start + start_, 0, newSize)
            return newArr
        }
        return Array<T>(newSize, {i: Int64 => arr[start_ + step * i]})
    }

    /*
     * @throws IllegalArgumentException if `copyLen` is negative.
     * @throws IndexOutOfBoundsException if `srcStart` or `dstStart` is negative, or `srcStart` is
     *         greater or equal to the size of this array, or `dstStart` is greater or equal to
     *         the size of `dst`, or `copyLen` is out of bounds.
     */
    @Frozen
    public func copyTo(dst: Array<T>, srcStart: Int64, dstStart: Int64, copyLen: Int64): Unit {
        if (copyLen == 0) {
            return
        }
        if (copyLen < 0) {
            throw IllegalArgumentException("Negative copy length.")
        }
        if (srcStart < 0 || dstStart < 0) {
            throw IndexOutOfBoundsException("Array negative index access.")
        }
        if (srcStart >= this.len) {
            throw IndexOutOfBoundsException("SrcStart is greater than or equal to the size of this array.")
        }
        if (dstStart >= dst.size) {
            throw IndexOutOfBoundsException("DstStart is greater than or equal to the size of the target array.")
        }
        if (copyLen > this.len - srcStart || copyLen > dst.size - dstStart) {
            throw IndexOutOfBoundsException("Copy length out of bounds.")
        }
        intrinsicBuiltInCopyTo<T>(this.rawptr, dst.rawptr, this.start + srcStart, dst.start + dstStart, copyLen)
    }

    @Frozen
    public func copyTo(dst: Array<T>): Unit {
        if (this.len == 0) {
            return
        }
        if (dst.size < this.len) {
            throw IllegalArgumentException("Dst size is less than the size of this array.")
        }
        intrinsicBuiltInCopyTo<T>(this.rawptr, dst.rawptr, this.start, dst.start, this.len)
    }

    /*
     * Returns a new Array concat this and that
     *
     * `other` will be copied to the new array
     *
     * returns a new array, size is `this.size + that.size`
     */
    @Frozen
    public func concat(other: Array<T>): Array<T> {
        if (this.len == 0) {
            return other.clone()
        }
        if (other.len == 0) {
            return this.clone()
        }
        let newSize = this.len + other.len
        let newArr = Array<T>(newSize, repeat: unsafe { zeroValue<T>() })

        intrinsicBuiltInCopyTo<T>(this.rawptr, newArr.rawptr, this.start, 0, this.len)
        intrinsicBuiltInCopyTo<T>(other.rawptr, newArr.rawptr, other.start, this.len, other.len)
        newArr
    }

    @Frozen
    @OverflowWrapping
    protected unsafe func getUnchecked(index: Int64): T {
        return arrayGetUnchecked(this.rawptr, start + index)
    }

    @Frozen
    @OverflowWrapping
    protected unsafe func setUnchecked(index: Int64, element: T): Unit {
        return arraySetUnchecked(this.rawptr, start + index, element)
    }

    @Frozen
    public func swap(index1: Int64, index2: Int64): Unit {
        if (index1 < 0 || len <= index1) {
            throw IllegalArgumentException("Index1 is less than 0 or not less than the size of this array.")
        }
        if (index2 < 0 || len <= index2) {
            throw IllegalArgumentException("Index2 is less than 0 or not less than the size of this array.")
        }
        if (index1 == index2) {
            return
        }
        let tmp = arrayGetUnchecked(this.rawptr, start + index1)
        arraySetUnchecked(this.rawptr, start + index1, arrayGetUnchecked(this.rawptr, start + index2))
        arraySetUnchecked(this.rawptr, start + index2, tmp)
    }

    @Frozen
    public func splitAt(mid: Int64): (Array<T>, Array<T>) {
        if (mid < 0 || this.len < mid) {
            throw IllegalArgumentException("Mid is less than 0 or not less than the size of this array.")
        }
        if (this.len == 0) {
            return (this, this)
        }
        let left = Array<T>(this.rawptr, this.start, this.start + mid)
        let right = Array<T>(this.rawptr, this.start + mid, this.len - mid)
        return (left, right)
    }

    @Frozen
    public func repeat(n: Int64): Array<T> {
        if (n <= 0) {
            throw IllegalArgumentException("N is less than or equal to 0.")
        }
        if (this.len == 0) {
            return this
        }
        let newLen = this.len * n
        let newRawPtr = RawArray<T>(newLen, repeat: unsafe { zeroValue<T>() })
        for (i in 0..n) {
            intrinsicBuiltInCopyTo<T>(this.rawptr, newRawPtr, this.start, this.len * i, this.len)
        }
        return Array<T>(newRawPtr, 0, newLen)
    }

    @Frozen
    public func map<R>(transform: (T) -> R): Array<R> {
        return Array<R>(this.len, {idx => transform(this[idx])})
    }
}

extend<T> Array<Array<T>> {
    @Frozen
    public func flatten(): Array<T> {
        var newLen = 0
        for (i in 0..this.len) {
            newLen += this[i].len
        }
        let newRawPtr = RawArray<T>(newLen, repeat: unsafe { zeroValue<T>() })

        var newIdx = 0
        for (i in 0..this.len) {
            intrinsicBuiltInCopyTo<T>(this[i].rawptr, newRawPtr, this[i].start, newIdx, this[i].len)
            newIdx += this[i].len
        }
        return Array<T>(newRawPtr, 0, newLen)
    }
}
