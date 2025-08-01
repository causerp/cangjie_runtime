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
 * This is a library for StringReader.
 */

package std.io

const HIGH_1_UInt8: UInt8 = 0b10000000 // 0x80

/**
 * This class Provides the ability to read data from an input stream and convert it to characters or strings.
 */
public class StringReader<T> where T <: InputStream {
    let inputBIS: BufferedInputStream<T>

    public init(input: T) {
        inputBIS = BufferedInputStream(input)
    }

    /**
     * @throws ContentFormatException if the format of the read data is incorrect.
     */
    @Frozen
    public func read(): ?Rune {
        if (isFinished()) {
            return None
        }
        let byte0 = inputBIS.inBuf[inputBIS.curPos]
        if (byte0 < HIGH_1_UInt8) {
            updateInBufInfo(1)
            return Rune(byte0)
        }
        let (char, num): (Rune, Int64) = readCharFromInbuf()
        updateInBufInfo(num)
        return char
    }

    public func runes(): Iterator<Rune> {
        return RunesIterator(this)
    }

    private func readlnFromBuf(bas: ByteBuffer, haveCR_: Bool): (Bool, Bool) {
        var count = 0
        var done = false
        var haveCR = haveCR_
        while (count < inputBIS.availLen) {
            let char = inputBIS.inBuf[inputBIS.curPos + count]
            count++
            match (char) {
                case '\r' =>
                    if (haveCR) {
                        count--
                        done = true
                        break
                    }
                    haveCR = true
                case '\n' =>
                    done = true
                    break
                case _ =>
                    if (haveCR) {
                        count--
                        done = true
                        break
                    }
            }
        }
        bas.write(inputBIS.inBuf[inputBIS.curPos..inputBIS.curPos + count])
        updateInBufInfo(count)
        (done, haveCR)
    }

    /**
     * @throws ContentFormatException if the format of the read data is incorrect.
     */
    @Frozen
    public func readln(): Option<String> {
        if (isFinished()) {
            return Option<String>.None
        }
        let bas = ByteBuffer()
        var haveCR = false
        var done = false
        while (!done && !isFinished()) {
            (done, haveCR) = readlnFromBuf(bas, haveCR)
        }
        var bytes = bas.bytes()
        var pos = bytes.size
        while (pos > 0 && (bytes[pos - 1] == 0x0Au8 || bytes[pos - 1] == 0x0Du8)) {
            pos--
        }
        bytes = bytes[0..pos]
        try {
            return String.fromUtf8(bytes)
        } catch (e: IllegalArgumentException) {
            throw ContentFormatException("${e.message}")
        }
    }

    public func lines(): Iterator<String> {
        return LinesIterator(this)
    }
    /**
     * @throws ContentFormatException if the format of the read data is incorrect.
     */
    @Frozen
    public func readToEnd(): String {
        var bas: ByteBuffer = ByteBuffer()
        let buf = Array<Byte>(4096, repeat: 0)
        while (!isFinished()) {
            let len = inputBIS.read(buf)
            bas.write(buf[0..len])
        }
        let content = bas.bytes()
        try {
            return String.fromUtf8(content)
        } catch (e: IllegalArgumentException) {
            throw ContentFormatException("${e.message}")
        }
    }

    /**
     * @throws ContentFormatException if the format of the read data is incorrect.
     */
    public func readUntil(v: Rune): Option<String> {
        return readUntil({c: Rune => return c == v})
    }

    /**
     * @throws ContentFormatException if the format of the read data is incorrect.
     */
    public func readUntil(predicate: (Rune) -> Bool): Option<String> {
        if (isFinished()) {
            return Option<String>.None
        }
        return Option<String>.Some(readUntilToString(predicate))
    }

    private func isFinished(): Bool {
        if (inputBIS.availLen <= 0) {
            inputBIS.fillInBuf()
        }
        return inputBIS.availLen == -1
    }

    private func updateInBufInfo(readNum: Int64): Unit {
        inputBIS.curPos += readNum
        inputBIS.availLen -= readNum
    }

    /**
     * @throws ContentFormatException if the format of the read data is incorrect.
     */
    private func readCharFromInbuf(): (Rune, Int64) {
        try {
            if (inputBIS.availLen < 4) {
                let size = Rune.utf8Size(inputBIS.inBuf, inputBIS.curPos)
                ensureAvailable(size)
            }
            Rune.fromUtf8(inputBIS.inBuf, inputBIS.curPos)
        } catch (e: IllegalArgumentException) {
            throw ContentFormatException("${e.message}")
        }
    }

    private func ensureAvailable(required: Int64): Unit {
        while (required > inputBIS.availLen) {
            inputBIS.inBuf.copyTo(inputBIS.inBuf, inputBIS.curPos, 0, inputBIS.availLen)
            var readNum = inputBIS
                .inputStream
                .read(inputBIS.inBuf.slice(inputBIS.availLen, inputBIS.inBuf.size - inputBIS.availLen))
            if (readNum < 0) {
                throw ContentFormatException("Input stread finished in the middle of a UTF-8 sequence")
            }
            inputBIS.curPos = 0
            inputBIS.availLen += readNum
        }
    }

    /**
     * @throws ContentFormatException if the format of the read data is incorrect.
     */
    private func readUntilToString(predicate: (Rune) -> Bool, isIncludeChar!: Bool = true): String {
        var bas: ByteBuffer = ByteBuffer()
        while (!isFinished()) {
            let (char, num): (Rune, Int64) = readCharFromInbuf()
            let utf8Array: Array<Byte> = inputBIS.inBuf.slice(inputBIS.curPos, num)
            updateInBufInfo(num)
            if (predicate(char)) {
                if (isIncludeChar) {
                    bas.write(utf8Array)
                }
                break
            }
            bas.write(utf8Array)
        }
        return String.fromUtf8(bas.bytes())
    }
}

extend<T> StringReader<T> <: Resource where T <: Resource {
    /**
     * Close the current stream.
     */
    public func close(): Unit {
        inputBIS.close()
    }

    /**
     * Returns whether the current flow is closed.
     *
     * @return true if the current stream has been closed, otherwise returns false.
     */
    public func isClosed(): Bool {
        inputBIS.isClosed()
    }
}

extend<T> StringReader<T> <: Seekable where T <: Seekable {
    /**
     * Seek to an offset, in bytes, in a stream.
     *
     * @params sp - Start position of the offset and size of the offset.
     *
     * @return the number of bytes in the stream from the beginning of the data to the cursor position.
     */
    public func seek(sp: SeekPosition): Int64 {
        inputBIS.seek(sp)
    }

    /**
     * Gets the current read position of StringReader .
     *
     * This property calls the `seek()` function each time it is accessed, moving the cursor to a specific location.
     * The position is adjusted by setting the offset to the negative value of the current available bytes (`inputBIS.availLen` which not be read yet),
     * ensuring that read operations continue from the appropriate position.
     *
     * Note: This property only performs operations when accessed, adjusting the cursor and returning the current position.
     *
     * @return The current read position of the input stream (of type `Int64`), representing the offset of the cursor
     *         from the beginning of the stream.
     */
    public prop position: Int64 {
        get() {
            // Move the cursor back by the length of unread data in the buffer (inputBIS.availLen).
            // This ensures that subsequent reads start at the correct position in the stream.            
            seek(Current(-inputBIS.availLen))
        }
    }
}

class RunesIterator<T> <: Iterator<Rune> where T <: InputStream {
    RunesIterator(let data: StringReader<T>) {}

    /**
     * @throws ContentFormatException if the format of the read data is incorrect.
     */
    public func next(): Option<Rune> {
        return data.read()
    }
}

class LinesIterator<T> <: Iterator<String> where T <: InputStream {
    LinesIterator(let data: StringReader<T>) {}

    /**
     * @throws ContentFormatException if the format of the read data is incorrect.
     */
    public func next(): Option<String> {
        return data.readln()
    }
}
