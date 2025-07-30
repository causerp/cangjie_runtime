/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.core

@FastNative
foreign func CJ_CORE_Float64ToHash(x: Float64): Int64

@FastNative
foreign func CJ_CORE_Float32ToHash(x: Float32): Int64

// print
@FastNative
foreign func CJ_CORE_PrintUTF8(c: CPointer<UInt8>, len: Int64, newLine: Bool, flush: Bool): Int64

@FastNative
foreign func CJ_CORE_ErrorPrintUTF8(c: CPointer<UInt8>, len: Int64, newLine: Bool, flush: Bool): Int64

@FastNative
foreign func CJ_CORE_PrintBool(b: Bool, newLine: Bool, flush: Bool): Unit

@FastNative
foreign func CJ_CORE_PrintChar(c: UInt32, newLine: Bool, flush: Bool): Unit

@FastNative
foreign func CJ_CORE_PrintFloat(f: Float64, newLine: Bool, flush: Bool): Unit

@FastNative
foreign func CJ_CORE_PrintSigned(i: Int64, newLine: Bool, flush: Bool): Unit

@FastNative
foreign func CJ_CORE_PrintUnsigned(i: UInt64, newLine: Bool, flush: Bool): Unit

@FastNative
foreign func CJ_CONSOLE_Readline(): CPointer<StructureString>

@FastNative
foreign func CJ_CONSOLE_ClearstdInerr(): Unit
// string
@FastNative
foreign func memcpy_s(dest: CPointer<UInt8>, destMax: UIntNative, src: CPointer<UInt8>, count: UIntNative): Int32

@FastNative
foreign func strlen(str: CPointer<UInt8>): UIntNative

@FastNative
foreign func CJ_CORE_StringMemcmp(str1: CPointer<UInt8>, str2: CPointer<UInt8>, n: UIntNative): Int64

@FastNative
foreign func CJ_CORE_StringSize(str: CPointer<UInt8>, len: Int64): Int64

@FastNative
foreign func CJ_CORE_Float64ToCPointer(num: Float64): CPointer<UInt8>

@FastNative
foreign func CJ_CORE_IndexOfChar(orgStr: CPointer<UInt8>, patC: UInt32, orgSize: Int64, start: Int64): Int64

@FastNative
foreign func CJ_CORE_LastIndexOfChar(orgStr: CPointer<UInt8>, patC: UInt32, orgSize: Int64, start: Int64): Int64

@FastNative
foreign func CJ_CORE_IndexOfString(orgStr: CPointer<UInt8>, subStr: CPointer<UInt8>, orgSize: Int64, subSize: Int64,
    start: Int64): Int64

@FastNative
foreign func CJ_CORE_LastIndexOfString(orgStr: CPointer<UInt8>, subStr: CPointer<UInt8>, orgSize: Int64, subSize: Int64,
    start: Int64): Int64

@FastNative
foreign func CJ_CORE_CountChar(orgStr: CPointer<UInt8>, patC: UInt32, orgSize: Int64): Int64

@FastNative
foreign func CJ_CORE_CountString(orgStr: CPointer<UInt8>, subStr: CPointer<UInt8>, orgSize: Int64, subSize: Int64): Int64

@FastNative
foreign func CJ_CORE_CountAndIndexString(orgStr: CPointer<UInt8>, subStr: CPointer<UInt8>, orgSize: Int64,
    subSize: Int64): CPointer<Int64>

@FastNative
foreign func CJ_CORE_CanUseSIMD(): Bool

@When[backend == "cjnative"]
@FastNative
foreign func CJ_MRT_GetCommandLineArgs(): CPointer<CPointer<UInt8>>

@C
struct StructureString {
    let buffer: CPointer<UInt8> = CPointer<UInt8>()
    let length: UIntNative = 0
}
