/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/**
 * @file
 *
 * This is a library for BufferedInputStream class.
 */

package std.io

/**
 * A BufferedInputStream has a built-in buffer to cache the content of the InputStream.
 * BufferedInputStream is meant for cache the InputStream.
 */
public class BufferedInputStream<T> <: InputStream where T <: InputStream {
    var inputStream: T
    let inBuf: Array<Byte>
    var curPos: Int64 = 0
    var availLen: Int64 = 0

    /**
     * Constructor
     *
     * @params input - The InputStream
     */
    public init(input: T) {
        this(input, DEFAULT_BUFFER_CAPACITY)
    }

    /**
     * Constructor
     *
     * @params input - The InputStream
     * @params capacity - Capacity of the buit-in buffer
     *
     * @throws IllegalArgumentException - If `capacity` less than 0.
     */
    public init(input: T, capacity: Int64) {
        if (capacity <= 0) {
            throw IllegalArgumentException("Invalid capacity size: capacity = ${capacity}.")
        }
        inputStream = input
        inBuf = Array<Byte>(capacity, repeat: 0)
    }

    public init(input: T, buffer: Array<Byte>) {
        if (buffer.size == 0) {
            throw IllegalArgumentException("The buffer cannot be empty.")
        }
        inputStream = input
        inBuf = buffer
    }

    /**
     * Read the current InputSteam into the buffer.
     *
     * @params buffer - Will read from InputStream to the buffer.
     *
     * @return Size read into the buffer.
     * @throws IllegalArgumentException - If the `buffer` is empty.
     */
    public func read(buffer: Array<Byte>): Int64 {
        if (availLen == -1) {
            return 0
        }

        var len = buffer.size
        if (len == 0) {
            throw IllegalArgumentException("The buffer cannot be empty: `buffer.size() = 0`!")
        }

        var count = 0
        while (len > 0) {
            if (availLen == 0) {
                fillInBuf()
                if (availLen == -1) {
                    break
                }
            }

            let copyLen = if (availLen <= len) {
                availLen
            } else {
                len
            }

            inBuf.copyTo(buffer, curPos, count, copyLen)
            curPos += copyLen
            availLen -= copyLen
            count += copyLen
            len -= copyLen
        }

        count
    }

    public func readByte(): ?Byte {
        if (availLen == -1) {
            return None
        }

        if (availLen == 0) {
            fillInBuf()
            if (availLen == -1) {
                return None
            }
        }

        availLen--
        let readByte = inBuf[curPos]
        curPos++

        readByte
    }

    /**
     * Bind this.inputStream to the new InputStream.
     * Will not change the capacity.
     *
     * @params input - The new InputStream
     */
    public func reset(input: T): Unit {
        inputStream = input
        curPos = 0
        availLen = 0
    }

    func fillInBuf(): Unit {
        let readNum = inputStream.read(inBuf)
        if (readNum > 0) {
            curPos = 0
            availLen = readNum
        } else {
            availLen = -1
        }
    }
}

extend<T> BufferedInputStream<T> <: Resource where T <: Resource {
    /**
     * Close the current stream.
     */
    public func close(): Unit {
        inputStream.close()
    }

    /**
     * Returns whether the current flow is closed.
     *
     * @return true if the current stream has been closed, otherwise returns false.
     */
    public func isClosed(): Bool {
        inputStream.isClosed()
    }
}

extend<T> BufferedInputStream<T> <: Seekable where T <: Seekable {
    /**
     * Seek to an offset, in bytes, in a stream.
     *
     * @params sp - Start position of the offset and size of the offset.
     *
     * @return the number of bytes in the stream from the beginning of the data to the cursor position.
     */
    public func seek(sp: SeekPosition): Int64 {
        let pos = inputStream.seek(sp)
        curPos = 0
        availLen = 0

        pos
    }

    /**
     * @return the position of the current cursor in the stream.
     */
    public prop position: Int64 {
        get() {
            inputStream.seek(Current(0))
        }
    }

    /**
     * @return the number of data bytes from the current cursor position to the end of the file.
     */
    public prop remainLength: Int64 {
        get() {
            let oldPos = inputStream.seek(Current(0))
            let length = inputStream.seek(End(0))
            if (length != oldPos) {
                inputStream.seek(Begin(oldPos))
            }

            length - oldPos
        }
    }

    /**
     * @return the number of bytes from the file header to the file trailer.
     */
    public prop length: Int64 {
        get() {
            let oldPos = inputStream.seek(Current(0))
            let length = inputStream.seek(End(0))
            if (length != oldPos) {
                inputStream.seek(Begin(oldPos))
            }

            length
        }
    }
}
