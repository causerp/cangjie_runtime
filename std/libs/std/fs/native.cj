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
 * This file defines native functions.
 */

package std.fs

foreign {
    // Path
    func CJ_FS_NormalizePath(path: CString, realPath: CPointer<UInt8>): CPointer<FsError> // (<= 0): error, (> 0): real path size

    // FileInfo
    func CJ_FS_PathSize(path: CString): Int64 // -1: failed, (>= 0): file size
    func CJ_FS_GetCreationTime(path: CString): Int64 // -1: failed, (>= 0): time data
    func CJ_FS_GetLastAccessTime(path: CString): Int64 // -1: failed, (>= 0): time data
    func CJ_FS_GetLastModificationTime(path: CString): Int64 // -1: failed, (>= 0): time data

    func CJ_FS_IsReadOnly(path: CString): Int8 // -1: error, 0: false, 1: true

    func CJ_FS_CanRead(path: CString): Int8 // -1: error, 0: false, 1: true
    func CJ_FS_CanWrite(path: CString): Int8 // -1: error, 0: false, 1: true
    func CJ_FS_CanExecute(path: CString): Int8 // -1: error, 0: false, 1: true

    func CJ_FS_SetExecutable(path: CString, executable: Bool): Int8 // -2: Operation not permitted, -1: Other Errors, 0: false, 1: true
    func CJ_FS_SetReadable(path: CString, readable: Bool): Int8 // -2: Operation not permitted, -1: Other Errors, 0: false, 1: true
    func CJ_FS_SetWritable(path: CString, writable: Bool): Int8 // -2: Operation not permitted, -1: Other Errors, 0: false, 1: true

    // Directory
    func CJ_FS_DirGetNumber(path: CString): Int64 // -1: failed, (>= 0): file number in dir
    func CJ_FS_ISDirEmpty(path: CString): Int8 // -1: error, 0: false, 1: true
    func CJ_FS_DirGetData(path: CString, buffer: CPointer<Byte>, bufferLen: Int64): Int64 // -1: failed, (>= 0): data length of buffer
    func CJ_FS_DirCreate(path: CString): CPointer<FsError> // false: errCode < 0, true: errCode == 0
    func CJ_FS_DirCreateRecursive(path: CString): CPointer<FsError> // false: errCode < 0, true: errCode == 0
    func CJ_FS_CreateTempDir(path: CPointer<Byte>): Bool // false: Failed, true: Success
    func CJ_FS_CopyREF(srcPath: CString, destPath: CString): Int8 // -1: failed, 0: success
    func CJ_FS_CopyLink(srcPath: CString, destPath: CString): Int8 // -1: failed, 0: success

    // File
    func CJ_FS_OpenFile(path: CString, openMode: Int32): CPointer<FsInfo>
    func CJ_FS_Seek(fd: FileHandle, whence: Int32, offset: Int64): Int64 // -1: failed, (>= 0): distance from the start position
    func CJ_FS_CloseFile(fd: FileHandle): Int64 // -1: failed, (>= 0): success
    func CJ_FS_GetFileSize(fd: FileHandle): Int64 // -1: failed, (>= 0): file size
    func CJ_FS_FileRead(fd: FileHandle, buffer: CPointer<Byte>, maxLen: UIntNative): Int64 // -1: failed, 0: end, (>0): the size of buffer be read
    func CJ_FS_FileWrite(fd: FileHandle, buffer: CPointer<Byte>, maxLen: UIntNative): Bool // -1: failed, (>=0): the size of buffer be written
    func CJ_FS_Truncate(fd: FileHandle, length: Int64): CPointer<FsError>

    func CJ_FS_CreateTempFile(path: CPointer<Byte>): FileHandle

    // Util
    func CJ_FS_IsLink(path: CString): Int8 // -1: error, 0: false, 1: true
    func CJ_FS_IsFile(path: CString): Int8 // -1: error, 0: false, 1: true
    func CJ_FS_IsDir(path: CString): Int8 // -1: error, 0: false, 1: true

    func CJ_FS_IsFileORLinkToFile(path: CString): Int8 // -1: error, 0: false, 1: true
    func CJ_FS_IsDirORLinkToFDir(path: CString): Int8 // -1: error, 0: false, 1: true

    func CJ_FS_Exists(path: CString): Int8 //0: true
    func CJ_FS_Remove(path: CString, recursive: Bool): CPointer<FsError> // false: errCode < 0, true: errCode == 0
    func CJ_FS_Rename(sourcePath: CString, destinationPath: CString): CPointer<FsError> // false: errCode < 0, true: errCode == 0

    func CJ_FS_ErrnoGet(): Int32 // get errno
    func CJ_FS_FormatMessage(errnoValue: Int32): CString // get error message on windows
    func CJ_FS_ErrmesGet(errnoValue: Int32): CString // get message for the current errno

    func CJ_FS_Link(linkPath: CString, originPath: CString): CPointer<FsError>
    func CJ_FS_SymLink(linkPath: CString, originPath: CString): CPointer<FsError>
    func CJ_FS_ReadLink(path: CString): CPointer<FsError> // false errcode < 0, true: errcode == 0, errmsg is path
}

/**
 * If the c function succeeds, the rtnCode is zero and the msg is a null pointer.
 * If the c function fails, the rtnCode is less than zero and the msg is a cstring.
 */
@C
struct FsError {
    let rtnCode: Int64 = -1
    let msg: CString = CString(CPointer<UInt8>())
}

@C
struct FsInfo {
    let fd: FileHandle = InvalidHandle
    let msg: CString = CString(CPointer<UInt8>())
}
