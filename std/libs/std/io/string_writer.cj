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
 * This is a library for StringWriter.
 */

package std.io

@FastNative
foreign func memcpy_s(dest: CPointer<UInt8>, destMax: UIntNative, src: CPointer<UInt8>, count: UIntNative): Int32

@FastNative
foreign func CJ_BUFFER_Int64ToCPointer(num: Int64, buf: CPointer<UInt8>, destMax: Int64): Int64

@FastNative
foreign func CJ_BUFFER_UInt64ToCPointer(num: UInt64, buf: CPointer<UInt8>, destMax: Int64): Int64

@FastNative
foreign func CJ_BUFFER_Float64ToCPointer(num: Float64, buf: CPointer<UInt8>, destMax: Int64): Int64

@FastNative
foreign func CJ_CORE_Float64ToCPointer(num: Float64): CPointer<UInt8>

@FastNative
foreign func strlen(str: CPointer<UInt8>): UIntNative

/**
 * This class provides the ability to convert some types to strings with specified string encoding format
 *  and endian configuration and write them to the output stream.
 */
public class StringWriter<T> where T <: OutputStream {
    var outputBOS: BufferedOutputStream<T>

    /**
     * @throws IllegalArgumentException if encoding is UTF16 or UTF32
     */
    public init(output: T) {
        outputBOS = BufferedOutputStream(output)
    }

    public func flush(): Unit {
        this.outputBOS.flush()
    }

    public func write(v: String): Unit {
        if (v.isEmpty()) {
            return
        }
        this.outputBOS.write(unsafe { v.rawData() })
    }

    public func write<T>(v: T): Unit where T <: ToString {
        write(v.toString())
    }

    public func write(v: Bool): Unit {
        this.outputBOS.write(if (v) {
            "true".toArray()
        } else {
            "false".toArray()
        })
    }

    public func write(v: Int8): Unit {
        write(Int64(v))
    }

    public func write(v: Int16): Unit {
        write(Int64(v))
    }

    public func write(v: Int32): Unit {
        write(Int64(v))
    }

    public func write(v: Int64): Unit {
        var cnt: Int64 = if (v >= 0 && v < 10) {
            1
        } else {
            21 // "${Int64.Min}".size + "\0".size = 20 + 1 = 21
        }
        ensureEnoughOutBuf(cnt)

        var res: Int64 = 0
        unsafe {
            let cp = acquireArrayRawData(outputBOS.outBuf)
            res = CJ_BUFFER_Int64ToCPointer(v, cp.pointer + outputBOS.curPos, cnt)
            releaseArrayRawData(cp)
        }

        if (res < 0) {
            throw IOException("Error writing digit ${v}!")
        }
        outputBOS.curPos += res
    }

    private func ensureEnoughOutBuf(dataSize: Int64): Unit {
        if (dataSize > (outputBOS.outBuf.size - outputBOS.curPos)) {
            outputBOS.flushOutBuf()
        }
    }

    public func write(v: UInt8): Unit {
        write(UInt64(v))
    }

    public func write(v: UInt16): Unit {
        write(UInt64(v))
    }

    public func write(v: UInt32): Unit {
        write(UInt64(v))
    }

    public func write(v: UInt64): Unit {
        var cnt: Int64 = if (v >= 0 && v < 10) {
            1
        } else {
            21 // "${Int64.Min}".size + "\0".size = 20 + 1 = 21
        }
        ensureEnoughOutBuf(cnt)
        var res: Int64 = 0
        unsafe {
            let cp = acquireArrayRawData(outputBOS.outBuf)
            res = CJ_BUFFER_UInt64ToCPointer(v, cp.pointer + outputBOS.curPos, cnt)
            releaseArrayRawData(cp)
        }
        if (res < 0) {
            throw IOException("Error writing digit ${v}!")
        }
        outputBOS.curPos += res
    }

    public func write(v: Float16): Unit {
        write(Float64(v))
    }

    public func write(v: Float32): Unit {
        write(Float64(v))
    }

    public func write(v: Float64): Unit {
        var res: Int64 = 0
        unsafe {
            let p: CPointer<UInt8> = CJ_CORE_Float64ToCPointer(v)
            if (p.isNull()) {
                throw IOException()
            }
            let cpSize = Int64(strlen(p)) + 1 // append r'\0' in the end
            LibC.free(p)
            ensureEnoughOutBuf(cpSize)

            let cp = acquireArrayRawData(this.outputBOS.outBuf)
            res = CJ_BUFFER_Float64ToCPointer(v, cp.pointer + this.outputBOS.curPos, cpSize)
            releaseArrayRawData(cp)
        }

        if (res < 0) {
            throw IOException("Error writing digit ${v}!")
        }

        this.outputBOS.curPos += res
    }

    public func write(v: Rune): Unit {
        ensureEnoughOutBuf(6) // up to 6 byte for one utf-8 rune
        var res: Int64 = Rune.intoUtf8Array(v, this.outputBOS.outBuf, this.outputBOS.curPos)
        this.outputBOS.curPos += res
    }

    public func writeln(): Unit {
        ensureEnoughOutBuf(1)
        this.outputBOS.outBuf[this.outputBOS.curPos] = b'\n'
        this.outputBOS.curPos += 1
    }

    public func writeln(v: String): Unit {
        write(v)
        writeln()
    }

    public func writeln<T>(v: T): Unit where T <: ToString {
        write(v.toString())
        writeln()
    }

    public func writeln(v: Bool): Unit {
        this.outputBOS.write(if (v) {
            "true\n".toArray()
        } else {
            "false\n".toArray()
        })
    }

    public func writeln(v: Int8): Unit {
        writeln(Int64(v))
    }

    public func writeln(v: Int16): Unit {
        writeln(Int64(v))
    }

    public func writeln(v: Int32): Unit {
        writeln(Int64(v))
    }

    public func writeln(v: Int64): Unit {
        write(v)
        writeln()
    }

    public func writeln(v: UInt8): Unit {
        writeln(UInt64(v))
    }

    public func writeln(v: UInt16): Unit {
        writeln(UInt64(v))
    }

    public func writeln(v: UInt32): Unit {
        writeln(UInt64(v))
    }

    public func writeln(v: UInt64): Unit {
        write(v)
        writeln()
    }

    public func writeln(v: Float16): Unit {
        writeln(Float64(v))
    }

    public func writeln(v: Float32): Unit {
        writeln(Float64(v))
    }

    public func writeln(v: Float64): Unit {
        write(v)
        writeln()
    }

    public func writeln(v: Rune): Unit {
        write(v)
        writeln()
    }
}

extend<T> StringWriter<T> <: Resource where T <: Resource {
    /**
     * Close the current stream.
     */
    public func close(): Unit {
        outputBOS.close()
    }

    /**
     * Returns whether the current flow is closed.
     *
     * @return true if the current stream has been closed, otherwise returns false.
     */
    public func isClosed(): Bool {
        outputBOS.isClosed()
    }
}

extend<T> StringWriter<T> <: Seekable where T <: Seekable {
    /**
     * Seek to an offset, in bytes, in a stream.
     *
     * @params sp - Start position of the offset and size of the offset.
     *
     * @return the number of bytes in the stream from the beginning of the data to the cursor position.
     */
    public func seek(sp: SeekPosition): Int64 {
        outputBOS.seek(sp)
    }
}
