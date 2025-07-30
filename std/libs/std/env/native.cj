/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.env

foreign {
    @FastNative
    func CJ_OS_GetCurrentPid(): Int32

    @FastNative
    func CJ_OS_GetProcessInfoByPid(pid: Int32): CPointer<ProcessInfo>

    @FastNative
    func CJ_OS_FreeProcessInfo(processInfo_cp: CPointer<ProcessInfo>): Unit

    @FastNative
    func exit(status: Int32): Unit

    @FastNative
    func CJ_BUFFER_Int64ToCPointer(num: Int64, buf: CPointer<UInt8>, destMax: Int64): Int64

    @FastNative
    func CJ_BUFFER_UInt64ToCPointer(num: UInt64, buf: CPointer<UInt8>, destMax: Int64): Int64

    @FastNative
    func CJ_BUFFER_Float64ToCPointer(num: Float64, buf: CPointer<UInt8>, bufferSize: Int64): Int64

    @FastNative
    func CJ_CONSOLE_Readline(): CPointer<StructureString>

    @FastNative
    func CJ_CONSOLE_ClearstdInerr(): Unit

    @FastNative
    func memcpy_s(dest: CPointer<UInt8>, destMax: UIntNative, src: CPointer<UInt8>, count: UIntNative): Int32

    @FastNative
    func memset_s(dest: CPointer<Byte>, destMax: UIntNative, c: Int32, count: UIntNative): Int32

    func CJ_CONSOLE_Write(fd: Int32, c: CPointer<UInt8>, len: Int64, newLine: Bool): Unit
}

@When[os == "Windows"]
foreign {
    @FastNative
    func CJ_OS_GetEnvVal(envName: CString): CString

    @FastNative
    func CJ_OS_SetEnvEntry(envEntry: CString): Int32

    @FastNative
    func CJ_OS_GetStdHandle(fd: IntNative): IntNative

    @FastNative
    func CJ_OS_CloseFile(fd: IntNative): Int64 // -1: failed, (>= 0): success

    @FastNative
    func CJ_OS_FileRead(fd: IntNative, buffer: CPointer<Byte>, maxLen: UIntNative): Int64 // -1: failed, 0: end, (>0): the size of buffer be read

    @FastNative
    func CJ_OS_FileWrite(fd: IntNative, buffer: CPointer<Byte>, maxLen: UIntNative): Bool // -1: failed, (>=0): the size of buffer be written
}

@When[os != "Windows"]
foreign {
    @FastNative
    func getenv(name: CString): CString

    @FastNative
    func setenv(name: CString, value: CString, overwrite: Int32): Int32

    @FastNative
    func unsetenv(name: CString): Int32

    @FastNative
    func CJ_OS_CloseFile(fd: IntNative): Int64 // -1: failed, (>= 0): success

    @FastNative
    func CJ_OS_FileRead(fd: IntNative, buffer: CPointer<Byte>, maxLen: UIntNative): Int64 // -1: failed, 0: end, (>0): the size of buffer be read

    @FastNative
    func CJ_OS_FileWrite(fd: IntNative, buffer: CPointer<Byte>, maxLen: UIntNative): Bool // -1: failed, (>=0): the size of buffer be written
}

@FastNative
foreign func CJ_OS_HomeDir(): CString

@When[backend == "cjnative"]
foreign func FiniCJRuntime(): Int64

@C
struct ProcessInfo {
    let command: CString = CString(CPointer())
    let commandLine: CPointer<CString> = CPointer<CString>()
    let arguments: CPointer<CString> = CPointer<CString>()
    let workingDirectory: CString = CString(CPointer())
    let environment: CPointer<CString> = CPointer<CString>()
}

@C
struct StructureString {
    let buffer: CPointer<UInt8> = CPointer<UInt8>()
    let length: UIntNative = 0
}
