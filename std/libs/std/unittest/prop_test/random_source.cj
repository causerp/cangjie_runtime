/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest.prop_test

public interface RandomSource {
    func nextBool(): Bool {
        (nextUInt8() & 1) == 1
    }

    @OverflowWrapping
    func nextInt8(): Int8 {
        Int8(nextUInt8())
    }

    @OverflowWrapping
    func nextInt16(): Int16 {
        Int16(nextUInt16())
    }

    @OverflowWrapping
    func nextInt32(): Int32 {
        Int32(nextUInt32())
    }

    @OverflowWrapping
    func nextInt64(): Int64 {
        Int64(nextUInt64())
    }

    func nextInt8(max: Int8): Int8 {
        if (max < 0) {
            throw IllegalArgumentException("max must be positive")
        }
        let i = nextInt8()
        match {
            case i == Int8.Min => max - 1
            case i < 0 => -i % max
            case _ => i % max
        }
    }
    func nextInt16(max: Int16): Int16 {
        if (max < 0) {
            throw IllegalArgumentException("max must be positive")
        }
        let i = nextInt16()
        match {
            case i == Int16.Min => max - 1
            case i < 0 => -i % max
            case _ => i % max
        }
    }
    func nextInt32(max: Int32): Int32 {
        if (max < 0) {
            throw IllegalArgumentException("max must be positive")
        }
        let i = nextInt32()
        match {
            case i == Int32.Min => max - 1
            case i < 0 => -i % max
            case _ => i % max
        }
    }
    func nextInt64(max: Int64): Int64 {
        if (max < 0) {
            throw IllegalArgumentException("max must be positive")
        }
        let i = nextInt64()
        match {
            case i == Int64.Min => max - 1
            case i < 0 => -i % max
            case _ => i % max
        }
    }

    func nextUInt8(): UInt8
    func nextUInt16(): UInt16
    func nextUInt32(): UInt32
    func nextUInt64(): UInt64

    func nextUInt8(max: UInt8): UInt8 {
        nextUInt8() % max
    }
    func nextUInt16(max: UInt16): UInt16 {
        nextUInt16() % max
    }
    func nextUInt32(max: UInt32): UInt32 {
        nextUInt32() % max
    }
    func nextUInt64(max: UInt64): UInt64 {
        nextUInt64() % max
    }

    func nextFloat16(): Float16
    func nextFloat32(): Float32
    func nextFloat64(): Float64

    func nextGaussianFloat64(mean!: Float64, sigma!: Float64): Float64

    @OverflowWrapping
    func nextIntNative(): IntNative {
        IntNative(this.nextInt64())
    }

    @OverflowWrapping
    func nextUIntNative(): UIntNative {
        UIntNative(this.nextUInt64())
    }

    func suggestUInt8(): UInt8 // { nextUInt8() }
    func suggestUInt16(): UInt16 // { nextUInt16() }
    func suggestUInt32(): UInt32 // { nextUInt32() }
    func suggestUInt64(): UInt64 // { nextUInt64() }

    @OverflowWrapping
    func suggestUIntNative(): UIntNative { UIntNative(suggestUInt64()) }
    func suggestInt8(): Int8 // { nextInt8() }
    func suggestInt16(): Int16 // { nextInt16() }
    func suggestInt32(): Int32 // { nextInt32() }
    func suggestInt64(): Int64 // { nextInt64() }
    @OverflowWrapping
    func suggestIntNative(): IntNative { IntNative(suggestInt64()) }
    func suggestFloat16(): Float16 // { nextFloat16() }
    func suggestFloat32(): Float32 // { nextFloat32() }
    func suggestFloat64(): Float64 // { nextFloat64() }
    func suggestBool(): Bool { suggestUInt8() == 0 }

    func suggestRune(): Rune { randomSuggestedRune(this) }

    func suggestInt64(l: Int64, r: Int64): Int64 { remap(l, r, suggestInt64()) }
    func suggestUInt64(l: UInt64, r: UInt64): UInt64 { remap(l, r, suggestUInt64()) }
    func suggestInt32(l: Int32, r: Int32): Int32 { remap(l, r, suggestInt32()) }
    func suggestUInt32(l: UInt32, r: UInt32): UInt32 { remap(l, r, suggestUInt32()) }
    func suggestInt16(l: Int16, r: Int16): Int16 { remap(l, r, suggestInt16()) }
    func suggestUInt16(l: UInt16, r: UInt16): UInt16 { remap(l, r, suggestUInt16()) }
    func suggestInt8(l: Int8, r: Int8): Int8 { remap(l, r, suggestInt8()) }
    func suggestUInt8(l: UInt8, r: UInt8): UInt8 { remap(l, r, suggestUInt8()) }
    func suggestIntNative(l: IntNative, r: IntNative): IntNative { remap(l, r, suggestIntNative()) }
    func suggestUIntNative(l: UIntNative, r: UIntNative): UIntNative { remap(l, r, suggestUIntNative()) }
    func suggestFloat64(l: Float64, r: Float64): Float64 { remap(l, r, suggestFloat64()) }
    func suggestFloat32(l: Float32, r: Float32): Float32 { remap(l, r, suggestFloat32()) }
    func suggestFloat16(l: Float16, r: Float16): Float16 { remap(l, r, suggestFloat16()) }
}
