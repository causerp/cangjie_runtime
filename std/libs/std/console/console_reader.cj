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
 * This is a class for consoleReader.
 */

package std.console

import std.io.InputStream
import std.sync.*

@C
struct StructureString {
    let buffer: CPointer<UInt8> = CPointer<UInt8>()
    let length: UIntNative = 0
}

@FastNative
foreign func CJ_CONSOLE_Readline(): CPointer<StructureString>

@FastNative
foreign func CJ_CONSOLE_ClearstdInerr(): Unit

@FastNative
foreign func memcpy_s(dest: CPointer<UInt8>, destMax: UIntNative, src: CPointer<UInt8>, count: UIntNative): Int32

@FastNative
foreign func memset_s(dest: CPointer<Byte>, destMax: UIntNative, c: Int32, count: UIntNative): Int32

const defaultCapacity: Int64 = 32

/**
 * This class Provides the ability to read data from console
 */
@Deprecated[message: "This class migrate to the std.env."]
public class ConsoleReader <: InputStream {
    private static let mutex: ReentrantMutex = ReentrantMutex()
    private var buffer: Array<Byte> = Array<Byte>(defaultCapacity, repeat: 0) /* stdin read buffer */
    private var endIndex: Int64 = 0
    private var startIndex: Int64 = 0
    init() {}

    /**
     * Read one char
     * @throws IllegalMemoryException if there are some system errors.
     */
    @OverflowWrapping
    public func read(): ?Rune {
        synchronized(mutex) {
            if (endIndex == startIndex) {
                if (!readFromConsole()) {
                    return Option<Rune>.None
                }
            }
            let (rune, size): (Rune, Int64) = Rune.fromUtf8(buffer, startIndex)
            startIndex += size
            return rune
        }
    }

    /** Read one line */
    public func readln(): ?String {
        if (let Some(ln) <- readUntil({c => c == r'\n'})) {
            // not including CR character
            if (ln.endsWith("\r\n")) {
                return ln[..ln.size - 2]
            } else if (ln.endsWith('\n')) {
                return ln[..ln.size - 1]
            }
            return ln
        }
        return None
    }

    /** Read all line */
    public func readToEnd(): ?String {
        return readUntil({_ => return false})
    }

    /**
     * Reads until some contents is encountered, or the end of the stream is reached.
     * ch is included in the result
     */
    public func readUntil(ch: Rune): ?String {
        return readUntil({it => it == ch})
    }

    /**
     * Reads until predicate is encountered, or the end of the stream is reached.
     * ch is included in the result
     */
    public func readUntil(predicate: (Rune) -> Bool): ?String {
        let result: StringBuilder = StringBuilder()
        synchronized(mutex) {
            while (true) {
                if (startIndex >= endIndex && !readFromConsole()) {
                    break
                }
                let byteOffset = findFirstOf(predicate)
                if (byteOffset >= 0) {
                    unsafe { result.appendFromUtf8Unchecked(buffer[startIndex..byteOffset]) }
                    startIndex = byteOffset
                    break
                }
                unsafe { result.appendFromUtf8Unchecked(buffer[startIndex..endIndex]) }

                startIndex = this.endIndex
            }
        }

        if (result.size == 0) {
            return Option<String>.None
        } else {
            return Some(result.toString())
        }
    }

    /*
     * write Array<Byte> from stdIn to arr and return the length
     */
    public func read(arr: Array<Byte>): Int64 {
        let arraySize = arr.size
        synchronized(mutex) {
            while (arraySize > endIndex - startIndex) {
                if (!readFromConsole()) {
                    buffer.copyTo(arr, startIndex, 0, endIndex - startIndex)
                    let ret = endIndex - startIndex
                    startIndex = 0
                    endIndex = 0
                    return ret
                }
            }
            buffer.copyTo(arr, startIndex, 0, arraySize)
            startIndex += arraySize
        }
        return arraySize
    }

    private func readFromConsole(): Bool {
        let line: CPointer<StructureString> = unsafe { CJ_CONSOLE_Readline() }
        if (line.isNull()) {
            unsafe { CJ_CONSOLE_ClearstdInerr() }
            return false
        }

        unsafe {
            let ss = line.read()
            try {
                this.append(ss)
            } finally {
                LibC.free(ss.buffer)
                LibC.free(line)
            }
        }

        return true
    }

    /*
     * @returns utf8 position
     */
    private func findFirstOf(predicate: (Rune) -> Bool): Int64 {
        var byteOffset = startIndex
        while (byteOffset < endIndex) {
            var (char, len): (Rune, Int64) = Rune.fromUtf8(buffer, byteOffset)
            byteOffset += len
            if (predicate(char)) {
                return byteOffset
            }
        }
        return -1
    }

    @OverflowWrapping
    unsafe func append(str: StructureString): Unit {
        var itemLen = Int64(str.length)
        this.reserve(itemLen)
        if (itemLen >= 32) {
            let itemP: CPointerHandle<UInt8> = acquireArrayRawData(this.buffer)
            let rc = memcpy_s(itemP.pointer + this.endIndex, UIntNative(buffer.size - this.endIndex), str.buffer,
                UIntNative(itemLen))
            releaseArrayRawData(itemP)
            if (rc != 0) {
                // never reaches here
                throw IllegalMemoryException("The memcpy_s failed with error code: ${rc}")
            }
        } else {
            var i: Int64 = 0
            while (i < itemLen) {
                var c = str.buffer.read(i)
                this.buffer[i + this.endIndex] = c
                i++
            }
        }
        this.endIndex += itemLen
    }

    @OverflowThrowing
    private func reserve(additional: Int64): Unit {
        if (this.buffer.size - this.endIndex >= additional) {
            // if have enough space, do nothing
            return
        } else if (this.buffer.size - (this.endIndex - this.startIndex) >= additional) {
            // if move data to head can make space, move data to head
            this.buffer.copyTo(this.buffer, startIndex, 0, this.endIndex - startIndex)
            this.endIndex -= startIndex
            this.startIndex = 0
            return
        }
        // else malloc new space
        this.grow(this.buffer.size + additional)
    }

    @OverflowWrapping
    private func grow(minCapacity: Int64): Unit {
        let oldCapacity = this.buffer.size
        var newCapacity = oldCapacity + (oldCapacity >> 1)
        if (newCapacity < minCapacity) {
            newCapacity = minCapacity
        }
        var itemData = Array<UInt8>(newCapacity, repeat: 0)
        this.buffer.copyTo(itemData, this.startIndex, 0, this.endIndex - this.startIndex)
        this.buffer = itemData
        this.endIndex = this.endIndex - this.startIndex
        this.startIndex = 0
    }
}
