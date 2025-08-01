/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.ast

public interface ToBytes {
    func toBytes(): Array<UInt8>
}

func castUInt32ToBytes(v: UInt32): Array<UInt8> {
    var b: Array<UInt8> = Array<UInt8>(4, repeat: 0)
    /* NOTE: little-endian */
    var n = v
    for (i in 0..4) {
        b[i] = UInt8(n)
        n = (n >> 8)
    }
    return b
}

func castInt32ToBytes(v: Int32): Array<UInt8> {
    return castUInt32ToBytes(UInt32(v))
}

func castUInt16ToBytes(v: UInt16): Array<UInt8> {
    var b: Array<UInt8> = castUInt32ToBytes(UInt32(v))
    return b[0..2]
}

@OverflowWrapping
func castUInt32ToBytes(arr: Array<UInt8>, start: Int64, v: UInt32) {
    /* NOTE: little-endian */
    var n = v
    for (i in start..start + 4) {
        arr[i] = UInt8(n)
        n = (n >> 8)
    }
    return start + 4
}

func castInt32ToBytes(arr: Array<UInt8>, start: Int64, v: Int32) {
    return castUInt32ToBytes(arr, start, UInt32(v))
}

@OverflowWrapping
func castUInt16ToBytes(arr: Array<UInt8>, start: Int64, v: UInt16) {
    /* NOTE: little-endian */
    var n = v
    for (i in start..start + 2) {
        arr[i] = UInt8(n)
        n = (n >> 8)
    }
    return start + 2
}

func castStringToBytes(arr: Array<UInt8>, start1: Int64, s: String) {
    let len: Int64 = s.size
    var start = start1
    /* Add length of String. */
    start = castUInt32ToBytes(arr, start, UInt32(len))
    /* String to Bytes. */
    for (data in s) {
        arr[start] = data
        start++
    }
    return start
}

func concatBytes(l: Array<UInt8>, r: Array<UInt8>): Array<UInt8> {
    if (l.size == 0) {
        return r
    }
    if (r.size == 0) {
        return l
    }
    var b: Array<UInt8> = Array<UInt8>(l.size + r.size, repeat: 0)
    var i: Int64 = 0
    for (v in l) {
        b[i] = v
        i = i + 1
    }
    for (v in r) {
        b[i] = v
        i = i + 1
    }
    return b
}

func castStringToBytes(s: String): Array<UInt8> {
    let len: Int64 = s.size
    var b: Array<UInt8> = Array<UInt8>(len + 4, repeat: 0)
    var idx = 0
    /* Add length of String. */
    let bsl: Array<UInt8> = castUInt32ToBytes(UInt32(len))
    for (data in bsl) {
        b[idx] = data
        idx++
    }
    /* String to Bytes. */
    for (data in s) {
        b[idx] = data
        idx++
    }
    return b
}
