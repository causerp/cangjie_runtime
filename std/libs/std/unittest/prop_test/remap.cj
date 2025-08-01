/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest.prop_test

@OverflowWrapping
func toInt(x: Float64): Int64 {
    var res = Int64(x.toBits())
    if (res < 0) { return Int64.Max ^ res }
    return res
}

@OverflowWrapping
func toInt(x: Float32): Int32 {
    var res = Int32(x.toBits())
    if (res < 0) { return Int32.Max ^ res }
    return res
}

@OverflowWrapping
func toInt(x: Float16): Int16 {
    var res = Int16(x.toBits())
    if (res < 0) { return Int16.Max ^ res }
    return res
}

@OverflowWrapping
func toFloat(x: Int64): Float64 {
    if (x < 0) {
        return Float64.fromBits(UInt64(Int64.Max ^ x))
    }
    return Float64.fromBits(UInt64(x))
}

@OverflowWrapping
func toFloat(x: Int32): Float32 {
    if (x < 0) {
        return Float32.fromBits(UInt32(Int32.Max ^ x))
    }
    return Float32.fromBits(UInt32(x))
}

@OverflowWrapping
func toFloat(x: Int16): Float16 {
    if (x < 0) {
        return Float16.fromBits(UInt16(Int16.Max ^ x))
    }
    return Float16.fromBits(UInt16(x))
}

@OverflowWrapping
func remap(l: Int64, r: Int64, x: Int64): Int64 {
    if (l == Int64.Min && r == Int64.Max) {
        return x
    }
    return l + Int64(UInt64(x - l) % UInt64(r - l + 1))
}

@OverflowWrapping
func remap(l: UInt64, r: UInt64, x: UInt64): UInt64 {
    if (l == UInt64.Min && r == UInt64.Max) {
        return x
    }
    return l + (x - l) % (r - l + 1)
}

@OverflowWrapping
func remap(l: Int32, r: Int32, x: Int32): Int32 {
    if (l == Int32.Min && r == Int32.Max) {
        return x
    }
    return l + Int32(UInt32(x - l) % UInt32(r - l + 1))
}

@OverflowWrapping
func remap(l: UInt32, r: UInt32, x: UInt32): UInt32 {
    if (l == UInt32.Min && r == UInt32.Max) {
        return x
    }
    return l + (x - l) % (r - l + 1)
}

@OverflowWrapping
func remap(l: Int16, r: Int16, x: Int16): Int16 {
    if (l == Int16.Min && r == Int16.Max) {
        return x
    }
    return l + Int16(UInt16(x - l) % UInt16(r - l + 1))
}

@OverflowWrapping
func remap(l: UInt16, r: UInt16, x: UInt16): UInt16 {
    if (l == UInt16.Min && r == UInt16.Max) {
        return x
    }
    return l + (x - l) % (r - l + 1)
}

@OverflowWrapping
func remap(l: Int8, r: Int8, x: Int8): Int8 {
    if (l == Int8.Min && r == Int8.Max) {
        return x
    }
    return l + Int8(UInt8(x - l) % UInt8(r - l + 1))
}

@OverflowWrapping
func remap(l: UInt8, r: UInt8, x: UInt8): UInt8 {
    if (l == UInt8.Min && r == UInt8.Max) {
        return x
    }
    return l + (x - l) % (r - l + 1)
}

@OverflowWrapping
func remap(l: IntNative, r: IntNative, x: IntNative): IntNative {
    if (l == IntNative.Min && r == IntNative.Max) {
        return x
    }
    return l + IntNative(UIntNative(x - l) % UIntNative(r - l + 1))
}

@OverflowWrapping
func remap(l: UIntNative, r: UIntNative, x: UIntNative): UIntNative {
    if (l == UIntNative.Min && r == UIntNative.Max) {
        return x
    }
    return l + (x - l) % (r - l + 1)
}

@OverflowWrapping
func remap(l: Float64, r: Float64, x: Float64): Float64 {
    if (r < l) {
        throw IllegalArgumentException("[${l}, ${r}] is an empty interval")
    }
    if (l.isNaN() || r.isNaN()) {
        throw IllegalArgumentException("cannot pass nan as border value")
    }
    var left = toInt(l)
    var right = toInt(r)
    if (left == 0) {
        left = -1
    }
    if (right == -1) {
        right = 0
    }
    return toFloat(remap(left, right, toInt(x)))
}

@OverflowWrapping
func remap(l: Float32, r: Float32, x: Float32): Float32 {
    if (r < l) {
        throw IllegalArgumentException("[${l}, ${r}] is an empty interval")
    }
    if (l.isNaN() || r.isNaN()) {
        throw IllegalArgumentException("cannot pass nan as border value")
    }
    var left = toInt(l)
    var right = toInt(r)
    if (left == 0) {
        left = -1
    }
    if (right == -1) {
        right = 0
    }
    return toFloat(remap(left, right, toInt(x)))
}

@OverflowWrapping
func remap(l: Float16, r: Float16, x: Float16): Float16 {
    if (r < l) {
        throw IllegalArgumentException("[${l}, ${r}] is an empty interval")
    }
    if (l.isNaN() || r.isNaN()) {
        throw IllegalArgumentException("cannot pass nan as border value")
    }
    var left = toInt(l)
    var right = toInt(r)
    if (left == 0) {
        left = -1
    }
    if (right == -1) {
        right = 0
    }
    return toFloat(remap(left, right, toInt(x)))
}
