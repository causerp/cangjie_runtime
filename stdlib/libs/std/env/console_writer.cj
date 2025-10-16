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
 * This is a class for ConsoleWriter.
 */

package std.env

import std.io.OutputStream
import std.sync.*

foreign func CJ_CONSOLE_Flush(fd: Int32): Unit

public class ConsoleWriter <: OutputStream {
    private let mutex: Mutex = Mutex()

    /* Write buffer size is 512 bytes */
    private let bufferSize: Int64 = 512

    /* Write buffer */
    private let buffer: Array<UInt8> = Array<UInt8>(this.bufferSize, repeat: 0)

    private let fd: Int32

    /**
     * Init the ConsoleWriteStream, initialize the buffer.
     */
    init(fd: Int32) {
        this.fd = fd
    }

    public func flush(): Unit {
        synchronized(mutex) {
            unsafe { CJ_CONSOLE_Flush(this.fd) }
        }
    }

    public func write(buffer: Array<Byte>): Unit {
        synchronized(mutex) {
            directWrite(buffer, buffer.size)
        }
    }

    public func writeln(buffer: Array<Byte>): Unit {
        synchronized(mutex) {
            directWrite(buffer, buffer.size, newline: true)
        }
    }

    public func write(v: String): Unit {
        if (v.isEmpty()) {
            return
        }
        write(unsafe { v.rawData() })
    }

    public func write<T>(v: T): Unit where T <: ToString {
        write(v.toString())
    }

    public func write(v: Bool): Unit {
        write(if (v) {
            "true"
        } else {
            "false"
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
        writeInt64(v, newline: false)
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
        writeUInt64(v, newline: false)
    }

    public func write(v: Float16): Unit {
        write(Float64(v))
    }

    public func write(v: Float32): Unit {
        write(Float64(v))
    }

    public func write(v: Float64): Unit {
        writeFloat64(v, newline: false)
    }

    public func write(v: Rune): Unit {
        // up to 6 bytes in utf-8
        let itemBytes: Array<UInt8> = Array<UInt8>(6, repeat: 0)
        let len = Rune.intoUtf8Array(v, itemBytes, 0)
        write(itemBytes[..len])
    }

    public func writeln(v: String): Unit {
        writeln(unsafe { v.rawData() })
    }

    public func writeln<T>(v: T): Unit where T <: ToString {
        writeln(v.toString())
    }

    public func writeln(v: Bool): Unit {
        writeln(if (v) {
            "true"
        } else {
            "false"
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
        writeInt64(v, newline: true)
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
        writeUInt64(v, newline: true)
    }

    public func writeln(v: Float16): Unit {
        writeln(Float64(v))
    }

    public func writeln(v: Float32): Unit {
        writeln(Float64(v))
    }

    public func writeln(v: Float64): Unit {
        writeFloat64(v, newline: true)
    }

    public func writeln(v: Rune): Unit {
        let itemBytes: Array<UInt8> = Array<UInt8>(6, repeat: 0)
        let len = Rune.intoUtf8Array(v, itemBytes, 0)
        writeln(itemBytes[..len])
    }

    private func writeInt64(v: Int64, newline!: Bool = false): Unit {
        synchronized(mutex) {
            var writePos: Int64 = 0
            unsafe {
                let cp = acquireArrayRawData(this.buffer)
                writePos = CJ_BUFFER_Int64ToCPointer(v, cp.pointer, this.bufferSize)
                releaseArrayRawData(cp)
            }
            if (newline) {
                this.buffer[writePos] = b'\n'
                writePos++
            }
            directWrite(this.buffer, writePos)
        }
    }

    private func writeUInt64(v: UInt64, newline!: Bool = false): Unit {
        synchronized(mutex) {
            var writePos: Int64 = 0
            unsafe {
                let cp = acquireArrayRawData(this.buffer)
                writePos = CJ_BUFFER_UInt64ToCPointer(v, cp.pointer, this.bufferSize)
                releaseArrayRawData(cp)
            }

            if (newline) {
                this.buffer[writePos] = b'\n'
                writePos++
            }

            directWrite(this.buffer, writePos)
        }
    }

    private func writeFloat64(v: Float64, newline!: Bool = false): Unit {
        synchronized(mutex) {
            var writePos: Int64 = 0
            unsafe {
                let cp = acquireArrayRawData(this.buffer)
                writePos = CJ_BUFFER_Float64ToCPointer(v, cp.pointer, this.bufferSize)
                releaseArrayRawData(cp)
            }

            if (newline) {
                this.buffer[writePos] = b'\n'
                writePos++
            }

            directWrite(this.buffer, writePos)
        }
    }

    /**
     * Write buffer data into stdOut.
     *
     * @param arr write Array.
     * @param off The write data is placed into b from the index.
     * @param cnt write cnt bytes.
     *
     * @return Int64
     *
     * @since 0.24.1
     */
    private func directWrite(arr: Array<UInt8>, cnt: Int64, newline!: Bool = false): Int64 {
        unsafe {
            var pos: Int64 = 0
            var ptr = acquireArrayRawData(arr)

            while (cnt - pos >= Int64(Int32.Max)) {
                CJ_CONSOLE_Write(this.fd, ptr.pointer + pos, Int64(Int32.Max), false)
                pos += Int64(Int32.Max)
            }

            CJ_CONSOLE_Write(this.fd, ptr.pointer + pos, cnt - pos, newline)
            releaseArrayRawData(ptr)
        }
        return cnt
    }
}
