/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/**
 * @file The file declares several util functions.
 */
package std.net

import std.time.*
import std.io.*
import std.sync.*
import std.math.*

const OS_WINDOWS = "windows"
const OS_MACOS = "macOS"
const OS_OTHERS = "others"
const MAX_TIMEOUT_NS: Int64 = 0x7FFF_FFFF_FFFF_FFFF
let MAX_TIMEOUT_DURATION: Duration = Duration.nanosecond * MAX_TIMEOUT_NS
@When[os != "Windows" && os != "macOS"]
const OS = OS_OTHERS
@When[os == "macOS"]
const OS = OS_MACOS
@When[os == "Windows"]
const OS = OS_WINDOWS

extend Int64 {
    func clampIn(min!: Int64, max!: Int64): Int64 {
        if (this < min) {
            return min
        }
        if (this > max) {
            return max
        }
        return this
    }

    func toUInt32In(min!: UInt32, max!: UInt32 = UInt32.Max): UInt32 {
        let clamped = clampIn(min: Int64(min), max: Int64(max))
        UInt32(clamped)
    }
}

extend UInt64 {
    func atLeast(n: UInt64): UInt64 {
        if (this < n) {
            return n
        }
        return this
    }
}

func unwrapOption<T>(opt: ??T): ?T {
    return opt ?? None
}

func getOrFail<T>(e: () -> Exception): (?T) -> T {
    return {it: ?T => it ?? throw e()}
}

func formatError(errnum: Int32): String {
    unsafe {
        let result = CJ_SOCKET_GetErrMessage(errnum)
        if (result.isNull() || result.isEmpty()) {
            return "Unknown error: ${errnum}"
        }

        return try {
            result.toString()
        } finally {
            LibC.free(result)
        }
    }
}

func throwIfIPv4ZeroOnWindows(socketAddress: SocketAddress): Unit {
    if (OS == OS_WINDOWS) {
        let ipsa = (socketAddress as IPSocketAddress) ?? return;
        if (ipsa.address.isUnspecified()) {
            throw SocketException("Impossible to communicate with 0.0.0.0 on windows. Try to use concrete address.")
        }
    }
}

func zeroMemory(buffer: CPointer<UInt8>, size: Int64) {
    for (i in 0..size) {
        unsafe { buffer.write(i, 0) }
    }
}

func resolveHelper(address: String): IPAddress {
    let ips = IPAddress.resolve(address)
    if (ips.size > 0) {
        return ips[0]
    }
    throw SocketException("Failed to resolve address ${address}.")
}
