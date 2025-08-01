/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.process

import std.io.*

/**
 * ProcessOutputStream implement OutputStream & Resource interface
 *
 */
const SEEK_CUR: Int32 = 1 /* Seek from current position.  */

struct FileDescriptor {
    var _fileHandle: IntNative = INVALID_HANDLE

    init(fileHandle: IntNative) {
        this._fileHandle = fileHandle
    }
}

class ProcessInputStream <: InputStream {
    var inputStream: InputStream

    init(fileDescriptor: FileDescriptor) {
        inputStream = PipeInputStream(fileDescriptor)
    }

    public func read(buffer: Array<Byte>): Int64 {
        this.inputStream.read(buffer)
    }
}

class ProcessOutputStream <: OutputStream {
    var outputStream: OutputStream

    init(fileDescriptor: FileDescriptor) {
        outputStream = PipeOutputStream(fileDescriptor)
    }

    public func write(buffer: Array<Byte>): Unit {
        this.outputStream.write(buffer)
    }

    public func flush(): Unit {}
}

/**
 * PipeOutputStream implement OutputStream & Resource interface
 */
class PipeOutputStream <: OutputStream & Resource {
    var _fileDescriptor: FileDescriptor = FileDescriptor(INVALID_HANDLE)

    init(fileDescriptor: FileDescriptor) {
        this._fileDescriptor = fileDescriptor
    }

    public func write(buffer: Array<Byte>): Unit {
        if (!isHandleValid(_fileDescriptor._fileHandle)) {
            throw ProcessException("The stream not opened, can not be written.")
        }
        if (buffer.size == 0) {
            return
        }
        this.directWrite(buffer)
    }

    public func flush(): Unit {}

    public func isClosed(): Bool {
        return !isHandleValid(_fileDescriptor._fileHandle)
    }

    public func close(): Unit {
        if (isClosed()) {
            return
        }

        this.flush()

        /* Call the close() in the C Language */
        if (unsafe { CJ_OS_CloseFile(this._fileDescriptor._fileHandle) } < 0) {
            throw ProcessException("Failed to close stream.")
        }
        this._fileDescriptor._fileHandle = INVALID_HANDLE
    }

    /**
     * Write the array to the file and return the bytes successfully written into the file.
     *
     * @param buffer – The buffer will be written to the file
     *
     *
     * @throws ProcessException if system failed to write the file
     */
    private func directWrite(buffer: Array<Byte>): Unit {
        unsafe {
            let bufSize: Int64 = buffer.size
            var bufPtr: CPointerHandle<Byte> = acquireArrayRawData(buffer)
            let writeSuccess: Bool = CJ_OS_FileWrite(this._fileDescriptor._fileHandle, bufPtr.pointer,
                UIntNative(bufSize))
            releaseArrayRawData(bufPtr)
            if (!writeSuccess) {
                throw ProcessException("The stream write error.")
            }
        }
    }
}

/**
 * PipeInputStream implement InputStream & Resource interface
 */
class PipeInputStream <: InputStream & Resource {
    var _fileDescriptor: FileDescriptor = FileDescriptor(INVALID_HANDLE)

    init(fileDescriptor: FileDescriptor) {
        this._fileDescriptor = fileDescriptor
    }

    public func read(buffer: Array<Byte>): Int64 {
        if (!isHandleValid(_fileDescriptor._fileHandle)) {
            throw ProcessException("The stream not opened, can not to read.")
        }

        if (buffer.size == 0) {
            throw IllegalArgumentException("The buffer is empty.")
        }

        let readBytes: Int64 = directRead(buffer)
        if (readBytes < 0) {
            throw ProcessException("The stream read Error.")
        }
        return readBytes
    }

    public func isClosed(): Bool {
        return !isHandleValid(_fileDescriptor._fileHandle)
    }

    public func close(): Unit {
        if (isClosed()) {
            return
        }

        /* Call the close() in the C Language */
        if (unsafe { CJ_OS_CloseFile(this._fileDescriptor._fileHandle) } < 0) {
            throw ProcessException("Failed to close stream.")
        }
        this._fileDescriptor._fileHandle = INVALID_HANDLE
    }

    /**
     * Read from the file directly and write into buffer.
     *
     * @param buffer - Read to the buffer from the file
     *
     * @return Length successfully written into the array buffer
     */
    private func directRead(buffer: Array<Byte>): Int64 {
        unsafe {
            let bufPtr: CPointerHandle<Byte> = acquireArrayRawData(buffer)
            let readSize: Int64 = CJ_OS_FileRead(this._fileDescriptor._fileHandle, bufPtr.pointer,
                UIntNative(buffer.size))
            releaseArrayRawData(bufPtr)
            return readSize
        }
    }
}

class NullProcessStream <: IOStream & Resource {
    var _fileDescriptor: FileDescriptor = FileDescriptor(INVALID_HANDLE)

    init() {}

    public func read(_: Array<Byte>): Int64 {
        return -1
    }

    prop length: Int64 {
        get() {
            return 0
        }
    }

    public func write(_: Array<Byte>): Unit {
        throw ProcessException("Invaild outputStream.")
    }

    public func flush(): Unit {}

    public func isClosed(): Bool {
        return !isHandleValid(_fileDescriptor._fileHandle)
    }

    public func close(): Unit {}
}
