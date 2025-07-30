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
 * This is a library for console.
 */

package std.console

@FastNative
foreign func CJ_BUFFER_Int64ToCPointer(num: Int64, buf: CPointer<UInt8>, destMax: Int64): Int64

@FastNative
foreign func CJ_BUFFER_UInt64ToCPointer(num: UInt64, buf: CPointer<UInt8>, destMax: Int64): Int64

@FastNative
foreign func CJ_BUFFER_Float64ToCPointer(num: Float64, buf: CPointer<UInt8>, bufferSize: Int64): Int64

@Deprecated[message: "Use related global functions in the std.env instead."]
public class Console {
    init() {}
    private static let outConsole: ConsoleWriter = ConsoleWriter(Int32(1))
    private static let errConsole: ConsoleWriter = ConsoleWriter(Int32(2))
    private static let inConsole: ConsoleReader = ConsoleReader()
    public static prop stdIn: ConsoleReader {
        get() {
            inConsole
        }
    }
    public static prop stdOut: ConsoleWriter {
        get() {
            outConsole
        }
    }
    public static prop stdErr: ConsoleWriter {
        get() {
            errConsole
        }
    }
}
