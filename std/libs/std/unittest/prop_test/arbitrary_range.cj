/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest.prop_test

public interface ArbitraryRange<T> where T <: Arbitrary<T> & Comparable<T> {
    static func min(): T
    static func max(): T
    static func arbitraryRange(random: RandomSource, min: T, max: T): Generator<T>
}

extend Int64 <: ArbitraryRange<Int64> {
    public static func min(): Int64 { Int64.Min }
    public static func max(): Int64 { Int64.Max }
    public static func arbitraryRange(random: RandomSource, min: Int64, max: Int64): Generator<Int64> {
        if (max < min) {  throw IllegalArgumentException("[${min}, ${max}] is an empty interval") }
        Generators.generate(min, max) {l: Int64, r: Int64 => random.suggestInt64(l, r)}
    }
}

extend UInt64 <: ArbitraryRange<UInt64> {
    public static func min(): UInt64 { UInt64.Min }
    public static func max(): UInt64 { UInt64.Max }
    public static func arbitraryRange(random: RandomSource, min: UInt64, max: UInt64): Generator<UInt64> {
        if (max < min) { throw IllegalArgumentException("[${min}, ${max}] is an empty interval") }
        Generators.generate(min, max) {l: UInt64, r: UInt64 => random.suggestUInt64(l, r)}
    }
}

extend Int32 <: ArbitraryRange<Int32> {
    public static func min(): Int32 { Int32.Min }
    public static func max(): Int32 { Int32.Max }
    public static func arbitraryRange(random: RandomSource, min: Int32, max: Int32): Generator<Int32> {
        if (max < min) { throw IllegalArgumentException("[${min}, ${max}] is an empty interval") }
        Generators.generate(min, max) {l: Int32, r: Int32 => random.suggestInt32(l, r)}
    }
}

extend UInt32 <: ArbitraryRange<UInt32> {
    public static func min(): UInt32 { UInt32.Min }
    public static func max(): UInt32 { UInt32.Max }
    public static func arbitraryRange(random: RandomSource, min: UInt32, max: UInt32): Generator<UInt32> {
        if (max < min) { throw IllegalArgumentException("[${min}, ${max}] is an empty interval") }
        Generators.generate(min, max) { l: UInt32, r: UInt32 => random.suggestUInt32(l, r) }
    }
}

extend Int16 <: ArbitraryRange<Int16> {
    public static func min(): Int16 { Int16.Min }
    public static func max(): Int16 { Int16.Max }
    public static func arbitraryRange(random: RandomSource, min: Int16, max: Int16): Generator<Int16> {
        if (max < min) { throw IllegalArgumentException("[${min}, ${max}] is an empty interval") }
        Generators.generate(min, max) { l: Int16, r: Int16 => random.suggestInt16(l, r) }
    }
}

extend UInt16 <: ArbitraryRange<UInt16> {
    public static func min(): UInt16 { UInt16.Min }
    public static func max(): UInt16 { UInt16.Max }
    public static func arbitraryRange(random: RandomSource, min: UInt16, max: UInt16): Generator<UInt16> {
        if (max < min) { throw IllegalArgumentException("[${min}, ${max}] is an empty interval") }
        Generators.generate(min, max) { l: UInt16, r: UInt16 => random.suggestUInt16(l, r) }
    }
}

extend Int8 <: ArbitraryRange<Int8> {
    public static func min(): Int8 { Int8.Min }
    public static func max(): Int8 { Int8.Max }
    public static func arbitraryRange(random: RandomSource, min: Int8, max: Int8): Generator<Int8> {
        if (max < min) { throw IllegalArgumentException("[${min}, ${max}] is an empty interval") }
        Generators.generate(min, max) { l: Int8, r: Int8 => random.suggestInt8(l, r) }
    }
}

extend UInt8 <: ArbitraryRange<UInt8> {
    public static func min(): UInt8 { UInt8.Min }
    public static func max(): UInt8 { UInt8.Max }
    public static func arbitraryRange(random: RandomSource, min: UInt8, max: UInt8): Generator<UInt8> {
        if (max < min) { throw IllegalArgumentException("[${min}, ${max}] is an empty interval") }
        Generators.generate(min, max) { l: UInt8, r: UInt8 => random.suggestUInt8(l, r) }
    }
}

extend IntNative <: ArbitraryRange<IntNative> {
    public static func min(): IntNative { IntNative.Min }
    public static func max(): IntNative { IntNative.Max }
    public static func arbitraryRange(random: RandomSource, min: IntNative, max: IntNative): Generator<IntNative> {
        if (max < min) { throw IllegalArgumentException("[${min}, ${max}] is an empty interval") }
        Generators.generate(min, max) {l: IntNative, r: IntNative => random.suggestIntNative(l, r) }
    }
}

extend UIntNative <: ArbitraryRange<UIntNative> {
    public static func min(): UIntNative { UIntNative.Min }
    public static func max(): UIntNative { UIntNative.Max }
    public static func arbitraryRange(random: RandomSource, min: UIntNative, max: UIntNative): Generator<UIntNative> {
        if (max < min) { throw IllegalArgumentException("[${min}, ${max}] is an empty interval") }
        Generators.generate(min, max) {l: UIntNative, r: UIntNative => random.suggestUIntNative(l, r) }
    }
}

extend Float64 <: ArbitraryRange<Float64> {
    public static func min(): Float64 { -Float64.Inf }
    public static func max(): Float64 { Float64.Inf }
    public static func arbitraryRange(random: RandomSource, min: Float64, max: Float64): Generator<Float64> {
        if (min.isNaN() || max.isNaN()) { throw IllegalArgumentException("cannot pass NaN is a border value") }
        if (max < min) { throw IllegalArgumentException("[${min}, ${max}] is an empty interval") }
        Generators.generate(min, max) { l: Float64, r: Float64 => random.suggestFloat64(l, r) }
    }
}

extend Float32 <: ArbitraryRange<Float32> {
    public static func min(): Float32 { -Float32.Inf }
    public static func max(): Float32 { Float32.Inf }
    public static func arbitraryRange(random: RandomSource, min: Float32, max: Float32): Generator<Float32> {
        if (min.isNaN() || max.isNaN()) { throw IllegalArgumentException("cannot pass NaN is a border value") }
        if (max < min) { throw IllegalArgumentException("[${min}, ${max}] is an empty interval") }
        Generators.generate(min, max) { l: Float32, r: Float32 => random.suggestFloat32(l, r) }
    }
}

extend Float16 <: ArbitraryRange<Float16> {
    public static func min(): Float16 { -Float16.Inf }
    public static func max(): Float16 { Float16.Inf }
    public static func arbitraryRange(random: RandomSource, min: Float16, max: Float16): Generator<Float16> {
        if (min.isNaN() || max.isNaN()) { throw IllegalArgumentException("cannot pass NaN is a border value") }
        if (max < min) { throw IllegalArgumentException("[${min}, ${max}] is an empty interval") }
        Generators.generate(min, max) { l: Float16, r: Float16 => random.suggestFloat16(l, r) }
    }
}
