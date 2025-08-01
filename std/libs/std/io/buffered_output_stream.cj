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
 * This is a library for BufferedOutputStream class.
 */

package std.io

/**
 * A BufferedOutputStream has a built-in buffer to cache the content of the OutputStream.
 * BufferedOutputStream is meant for cache the OutputStream.
 */
public class BufferedOutputStream<T> <: OutputStream where T <: OutputStream {
    var outputStream: T
    var outBuf: Array<Byte>
    var curPos: Int64

    /**
     * Constructor
     *
     *
     * @params output - The OutputStream
     */
    public init(output: T) {
        this(output, DEFAULT_BUFFER_CAPACITY)
    }

    public init(output: T, buffer: Array<Byte>) {
        if (buffer.size == 0) {
            throw IllegalArgumentException("The buffer cannot be empty.")
        }

        outputStream = output
        outBuf = buffer
        curPos = 0
    }

    /**
     * Constructor
     *
     * @params output - The OutputStream
     * @params capacity - Capacity of the buit-in buffer
     *
     * @throws IllegalArgumentException - If `capacity` less than 0.
     */
    public init(output: T, capacity: Int64) {
        if (capacity <= 0) {
            throw IllegalArgumentException("Invalid capacity size: capacity = ${capacity}.")
        }

        outputStream = output
        outBuf = Array<Byte>(capacity, repeat: 0)
        curPos = 0
    }

    /**
     * Write from buffer to the OutputStream.
     *
     * @params buffer - Will write to the OutputStream from the buffer.
     */
    public func write(buffer: Array<Byte>): Unit {
        let len = buffer.size
        if (len == 0) {
            return
        }

        let outBufSize = outBuf.size
        if (len >= outBufSize) {
            flushOutBuf()
            outputStream.write(buffer)
            return
        }

        if (len > outBufSize - curPos) {
            flushOutBuf()
        }
        buffer.copyTo(outBuf, 0, curPos, len)
        curPos += len
    }

    /**
     * Write a Byte to the OutputStream.
     *
     * @params v - The byte write to the OutputStream.
     */
    public func writeByte(v: Byte): Unit {
        let outBufSize = outBuf.size
        if (curPos == outBufSize) {
            flushOutBuf()
        }
        outBuf[curPos] = v
        curPos++
    }

    func flushOutBuf(): Unit {
        if (curPos > 0) {
            outputStream.write(outBuf.slice(0, curPos))
            curPos = 0
        }
    }

    /**
     * Flush the OutputStream.
     */
    public func flush(): Unit {
        flushOutBuf()
        outputStream.flush()
    }

    /**
     * Flush and bind this.outputSteam to the new OutputStream.
     * Will not change the capacity.
     *
     * @params output - The OutputStream
     */
    public func reset(output: T): Unit {
        flush()
        outputStream = output
        curPos = 0
    }
}

extend<T> BufferedOutputStream<T> <: Resource where T <: Resource {
    /**
     * Close the current stream.
     */
    public func close(): Unit {
        if (!isClosed()) {
            flush()
            outputStream.close()
        }
    }

    /**
     * Returns whether the current flow is closed.
     *
     * @return true if the current stream has been closed, otherwise returns false.
     */
    public func isClosed(): Bool {
        outputStream.isClosed()
    }
}

extend<T> BufferedOutputStream<T> <: Seekable where T <: Seekable {
    /**
     * Seek to an offset, in bytes, in a stream.
     *
     * @params sp - Start position of the offset and size of the offset.
     *
     * @return the number of bytes in the stream from the beginning of the data to the cursor position.
     */
    public func seek(sp: SeekPosition): Int64 {
        this.flush()
        outputStream.seek(sp)
    }

    /**
     * @return the position of the current cursor in the stream.
     */
    public prop position: Int64 {
        get() {
            outputStream.seek(Current(0))
        }
    }

    /**
     * @return the number of data bytes from the current cursor position to the end of the file.
     */
    public prop remainLength: Int64 {
        get() {
            let oldPos = outputStream.seek(Current(0))
            let length = outputStream.seek(End(0))
            if (length != oldPos) {
                outputStream.seek(Begin(oldPos))
            }

            length - oldPos
        }
    }

    /**
     * @return the number of bytes from the file header to the file trailer.
     */
    public prop length: Int64 {
        get() {
            let oldPos = outputStream.seek(Current(0))
            let length = outputStream.seek(End(0))
            if (length != oldPos) {
                outputStream.seek(Begin(oldPos))
            }

            length
        }
    }
}
