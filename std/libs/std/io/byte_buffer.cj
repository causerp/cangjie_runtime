/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.io

@FastNative
foreign func CJ_CORE_IndexOfByte(orgStr: CPointer<UInt8>, orgSize: Int64, pat: UInt8): Int64

@FastNative
foreign func CJ_CORE_IndexOfString(
    orgStr: CPointer<UInt8>,
    subStr: CPointer<UInt8>,
    orgSize: Int64,
    subSize: Int64,
    start: Int64
): Int64

/**
 * A ByteBuffer obtains a Byte Array to operate the Byte as Stream.
 * ByteBuffer is meant for writing and reading byte streams.
 */
public class ByteBuffer <: IOStream & Seekable {
    var myData: Array<Byte>
    var start: Int64
    var _length: Int64

    private static const DEFAULT_CAPACITY: Int64 = 32

    /**
     * Creates a byte stream of the default capacity.
     */
    public init() {
        this(DEFAULT_CAPACITY)
    }

    /**
     * Constructors
     *
     * @params capacity - Capacity of the ByteBuffer.
     *
     * @throws IllegalArgumentException - If `capcacity` less than 0.
     */
    public init(capacity: Int64) {
        if (capacity < 0) {
            throw IllegalArgumentException("The capacity must be greater than or equal to 0: ${capacity}.")
        }
        this.myData = Array<Byte>(capacity, repeat: 0)
        this.start = 0
        this._length = 0
    }

    public init(source: Array<Byte>) {
        this.myData = source
        this.start = 0
        this._length = source.size
    }

    private init(bytes: Array<Byte>, start: Int64, length: Int64) {
        this.myData = bytes
        this.start = start
        this._length = length
    }

    /**
     * Returns the capacity of the ByteBuffer.
     */
    public prop capacity: Int64 {
        get() {
            return myData.size
        }
    }

    /**
     * Returns a copy of the ByteBuffer.
     */
    public func clone(): ByteBuffer {
        let itemDats = myData.clone()
        return ByteBuffer(itemDats, start, _length)
    }

    /**
     * Clears data from the ByteBuffer.
     */
    public func clear(): Unit {
        for (i in 0..(start + _length)) {
            myData[i] = 0
        }
        start = 0
        _length = 0
    }

    /**
     * Returns a reference to the original Array, any modification changes the original Array.
     */
    public func bytes(): Array<Byte> {
        return myData.slice(start, _length)
    }

    /**
     * Read the data to the buffer.
     *
     * @params buffer - Will read the data to the buffer.
     *
     * @returns Length of read data.
     * @throws IllegalArgumentException - If the buffer is empty.
     */
    public func read(buffer: Array<Byte>): Int64 {
        if (_length == 0) {
            return 0
        }
        let bufSize = buffer.size
        if (bufSize == 0) {
            throw IllegalArgumentException("The buffer is empty.")
        }
        let len = if (_length > bufSize) {
            bufSize
        } else {
            _length
        }
        myData.copyTo(buffer, start, 0, len)
        start += len
        _length -= len
        return len
    }

    /**
     * Read a byte from the buffer.
     *
     *
     * @returns read byte.
     * @throws IllegalArgumentException - If the buffer is empty.
     */
    public func readByte(): ?Byte {
        if (_length == 0) {
            return None
        }
        let byteValue = myData[start]
        start++
        _length--
        return byteValue
    }

    /**
     * Write data from the `buffer` to the ByteBuffer.
     *
     * @params buffer - The data buffer.
     */
    @OverflowWrapping
    public func write(buffer: Array<Byte>): Unit {
        let bufSize = buffer.size
        reserve(bufSize)
        if (_length >= 0) {
            buffer.copyTo(myData, 0, start + _length, bufSize)
            _length += bufSize
        } else {
            buffer.copyTo(myData, 0, start, bufSize)
            _length = bufSize
        }
    }

    /**
     * Write a byte to the ByteBuffer.
     *
     * @params v - The byte to write.
     */
    @OverflowWrapping
    public func writeByte(v: Byte): Unit {
        reserve(1)
        if (_length >= 0) {
            myData[start + _length] = v
            _length++
        } else {
            myData[start] = v
            _length = 1
        }
    }

    public func setLength(length: Int64): Unit {
        if (length < 0) {
            throw IllegalArgumentException("The length must be greater than or equal to 0.")
        }

        let size = myData.size

        if (length > size) {
            reserve(length - size)
        } else {
            myData[length..size].fill(0)
            if (start > length) {
                start = length
            }
        }

        _length = length - start
    }

    /**
     * Increases the capacity to ensure that it can hold at least the number of elements specified by the
     * `additional` argument.
     *
     * @params additional - The desired additional capacity.
     *
     * @throws IllegalArgumentException - If `additional` is less than 0.
     */
    public func reserve(addition: Int64): Unit {
        if (addition < 0) {
            throw IllegalArgumentException("The additional must be greater than or equal to 0.")
        }

        if (_length >= 0 && myData.size - start - _length >= addition) {
            return
        }

        if (_length < 0 && myData.size - start >= addition) {
            return
        }

        let growSize = if (_length >= 0) {
            checkGrowSize(myData.size, addition)
        } else {
            checkGrowSize(this.start, addition)
        }

        grow(growSize)
    }

    /**
     * Seek to an offset, in bytes, in a stream.
     * The specified location cannot be before the data header in the stream.
     * The specified location can be beyond the end of the file.
     *
     * @params sp - Start position of the offset and size of the offset.
     *
     * @return the number of bytes in the stream from the beginning of the data to the cursor position.
     *
     * @throws IOException - The specified position is before the data header in the stream.
     */
    public func seek(sp: SeekPosition): Int64 {
        let pos: Int64 = match (sp) {
            case Current(offset) => this.start + offset
            case Begin(offset) => offset
            case End(offset) => this.start + this._length + offset
        }

        if (pos < 0) {
            throw IOException("Can't move the position before the beginning of the stream.")
        }

        this._length += this.start - pos
        this.start = pos

        this.start
    }

    private func grow(minCapacity: Int64): Unit {
        let oldCapacity = myData.size
        var newCapacity = checkGrowSize(oldCapacity, (oldCapacity >> 1))
        if (newCapacity < minCapacity) {
            newCapacity = minCapacity
        }

        let itemData = Array<Byte>(newCapacity, repeat: 0)
        myData.copyTo(itemData, 0, 0, start + _length)
        myData = itemData
    }

    private func checkGrowSize(oldSize: Int64, addition: Int64): Int64 {
        try {
            return oldSize + addition
        } catch (_: OverflowException) {
            throw OverflowException(
                "The maximum value for capacity expansion cannot exceed the maximum value of Int64.")
        }
    }
}
