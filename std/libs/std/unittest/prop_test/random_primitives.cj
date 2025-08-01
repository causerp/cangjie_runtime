/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest.prop_test

import std.random.Random
import std.math.*

interface FromFloat64<T> {
    static func fromFloat64(f: Float64): T
}

extend Int16 <: FromFloat64<Int16> {
    public static func fromFloat64(f: Float64): Int16 {
        if (f > Float64(Int16.Max)) {
            return Int16.Max
        }
        if (f < Float64(Int16.Min)) {
            return Int16.Min
        }

        return Int16(f)
    }
}

extend Int32 <: FromFloat64<Int32> {
    public static func fromFloat64(f: Float64): Int32 {
        if (f > Float64(Int32.Max)) {
            return Int32.Max
        }
        if (f < Float64(Int32.Min)) {
            return Int32.Min
        }

        return Int32(f)
    }
}

extend Int64 <: FromFloat64<Int64> {
    public static func fromFloat64(f: Float64): Int64 {
        if (f > Float64(Int64.Max)) {
            return Int64.Max
        }
        if (f < Float64(Int64.Min)) {
            return Int64.Min
        }

        return Int64(f)
    }
}

extend IntNative <: FromFloat64<IntNative> {
    public static func fromFloat64(f: Float64): IntNative {
        if (f > Float64(IntNative.Max)) {
            return IntNative.Max
        }
        if (f < Float64(IntNative.Min)) {
            return IntNative.Min
        }

        return IntNative(f)
    }
}

extend UInt16 <: FromFloat64<UInt16> {
    public static func fromFloat64(f_: Float64): UInt16 {
        let f = abs(f_)
        if (f > Float64(UInt16.Max)) {
            UInt16.Max
        }

        return UInt16(f)
    }
}

extend UInt32 <: FromFloat64<UInt32> {
    public static func fromFloat64(f_: Float64): UInt32 {
        let f = abs(f_)
        if (f > Float64(UInt32.Max)) {
            UInt32.Max
        }

        return UInt32(f)
    }
}

extend UInt64 <: FromFloat64<UInt64> {
    public static func fromFloat64(f_: Float64): UInt64 {
        let f = abs(f_)
        if (f > Float64(UInt64.Max)) {
            UInt64.Max
        }

        return UInt64(f)
    }
}

extend UIntNative <: FromFloat64<UIntNative> {
    public static func fromFloat64(f_: Float64): UIntNative {
        let f = abs(f_)
        if (f > Float64(UIntNative.Max)) {
            UIntNative.Max
        }

        return UIntNative(f)
    }
}

func nextImaginableInteger<T>(random: Random, sigma: Float64): T where T <: FromFloat64<T> {
    let nextFloat = random.nextGaussianFloat64(mean: 0.0, sigma: sigma)

    return T.fromFloat64(nextFloat)
}

func generateBool(random: Random): Bool {
    return random.nextBool()
}

private let int8Table = WeightTable<(Random) -> Int8>(
    (4, { _: Random => 0 }),
    (4, { _: Random => 1 }),
    (4, { _: Random => -1 }),
    (4, { _: Random => Int8.Max }),
    (4, { _: Random => Int8.Min }),
    (80, { random: Random => random.nextInt8() } )
)
private let int16Table = WeightTable<(Random) -> Int16>(
    (4, { _: Random => Int16(0) }),
    (3, { _: Random => Int16(1) }),
    (3, { _: Random => Int16(-1) }),
    (4, { _: Random => Int16.Max }),
    (4, { _: Random => Int16.Min }),
    (24, { random: Random => nextImaginableInteger<Int16>(random, 1000.0) } ),
    (58, { random: Random => random.nextInt16() } )
)
private let int32Table = WeightTable<(Random) -> Int32>(
    (3, { _: Random => Int32(0) }),
    (2, { _: Random => Int32(1) }),
    (2, { _: Random => Int32(-1) }),
    (3, { _: Random => Int32.Max }),
    (3, { _: Random => Int32.Min }),
    (16, { random: Random => nextImaginableInteger<Int32>(random, 100.0) } ),
    (16, { random: Random => nextImaginableInteger<Int32>(random, 10000.0) } ),
    (55, { random: Random => random.nextInt32() } )
)
private let int64Table = WeightTable<(Random) -> Int64>(
    (3, { _: Random => Int64(0) }),
    (2, { _: Random => Int64(1) }),
    (2, { _: Random => Int64(-1) }),
    (3, { _: Random => Int64.Max }),
    (3, { _: Random => Int64.Min }),
    (10, { random: Random => nextImaginableInteger<Int64>(random, 100.0) } ),
    (11, { random: Random => nextImaginableInteger<Int64>(random, 1000.0) } ),
    (11, { random: Random => nextImaginableInteger<Int64>(random, 100000.0) } ),
    (55, { random: Random => random.nextInt64() } )
)
private let uint8Table = WeightTable<(Random) -> UInt8>(
    (7, { _: Random => UInt8(0) }),
    (6, { _: Random => UInt8(1) }),
    (7, { _: Random => UInt8.Max }),
    (80, { random: Random =>  random.nextUInt8() } )
)
private let uint16Table = WeightTable<(Random) -> UInt16>(
    (4, { _: Random => UInt16(0) }),
    (2, { _: Random => UInt16(1) }),
    (4, { _: Random => UInt16.Max }),
    (30, { random: Random =>  nextImaginableInteger<UInt16>(random, 1000.0) } ),
    (60, { random: Random =>  random.nextUInt16() } )
)
private let uint32Table = WeightTable<(Random) -> UInt32>(
    (3, { _: Random => UInt32(0) }),
    (2, { _: Random => UInt32(1) }),
    (3, { _: Random => UInt32.Max }),
    (16, { random: Random => nextImaginableInteger<UInt32>(random, 100.0) } ),
    (16, { random: Random => nextImaginableInteger<UInt32>(random, 10000.0) } ),
    (60, { random: Random => random.nextUInt32() } )
)
private let uint64Table = WeightTable<(Random) -> UInt64>(
    (3, { _: Random => UInt64(0) }),
    (2, { _: Random => UInt64(1) }),
    (3, { _: Random => UInt64.Max }),
    (10, { random: Random => nextImaginableInteger<UInt64>(random, 100.0) } ),
    (11, { random: Random => nextImaginableInteger<UInt64>(random, 1000.0) } ),
    (11, { random: Random => nextImaginableInteger<UInt64>(random, 100000.0) } ),
    (60, { random: Random => random.nextUInt64() } )
)

/* Generate next equidistant float with normal distribution of length of integer part
 * and normal distribution of denominator of fractional part.
 *
 * Such value represent rational number that can be easily imagine or visualized
 * by person, these numbers are more common in everyday life.
 */
func nextImaginableFloat64(random: Random): Float64 {
    let INTEGER_STRETCHING = 3.0
    var nextGaussian = random.nextGaussianFloat64(mean: 0.0, sigma: INTEGER_STRETCHING)
    let pow = floor(abs(nextGaussian))

    let max = 10.0 ** pow
    let integerPart = trunc((random.nextFloat64() - 0.5) * max)

    let DENOMINATOR_STRETCHING = 50.0
    nextGaussian = random.nextGaussianFloat64(mean: 0.0, sigma: DENOMINATOR_STRETCHING)
    var fractionalPart = 1.0 / ceil(abs(nextGaussian) + Float64.MinNormal)

    let sign = if (random.nextBool()) { 1.0 } else { -1.0 }

    return sign * (integerPart + fractionalPart)
}

private func nextDenseFloat16(random: Random): Float16 {
    // random 10 bit number (random mantissa)
    let inRange = random.nextUInt16() >> (16 - 10)
    let rangeMax = 1 << 10

    // equidistant in 1..2
    // range 1..2 represent values with exp=0
    let randomInRange = (Float16(inRange) / Float16(rangeMax)) + 1.0

    // random exponent in range [-15..15]
    let nextPower = Float64(Int64(random.nextUInt64() % 31) - Int64(15))

    var res = randomInRange * Float16(2.0 ** nextPower)

    if (random.nextBool()) {
        res *= Float16(-1)
    }

    return res
}

private let float16Table = WeightTable<(Random) -> Float16>(
    (4, { _: Random => Float16.Min }),
    (4, { _: Random => Float16.Max }),
    (4, { _: Random => Float16.NaN }),
    (4, { _: Random => Float16.MinDenormal }),
    (4, { _: Random => Float16.MinNormal }),
    (4, { _: Random => Float16.Inf }),
    (4, { _: Random => Float16.Inf }),
    (4, { _: Random => Float16(0) }),
    (4, { _: Random => Float16(0) }),
    (40, nextDenseFloat16),
    (24, { random: Random => Float16(nextImaginableFloat64(random)) })
)

private func nextDenseFloat32(random: Random): Float32 {
    // random 23 bit number (random mantissa)
    let inRange = random.nextUInt16() >> (32 - 23)
    let rangeMax = 1 << 23

    // equidistant in 1..2
    // range 1..2 represent values with exp=0
    let randomInRange = (Float32(inRange) / Float32(rangeMax)) + 1.0

    // random exponent in range [-2^(8 - 1) -1..2^(8 - 1) -1]
    let nextPower = Float64(Int64(random.nextUInt64() % 255) - Int64(127))

    var res = randomInRange * Float32(2.0 ** nextPower)

    if (random.nextBool()) {
        res *= Float32(-1.0)
    }

    return res
}

private let float32Table = WeightTable<(Random) -> Float32>(
    (3, { _: Random => Float32.Min }),
    (3, { _: Random => Float32.Max }),
    (3, { _: Random => Float32.NaN }),
    (3, { _: Random => Float32.MinDenormal }),
    (3, { _: Random => Float32.MinNormal }),
    (3, { _: Random => Float32.Inf }),
    (3, { _: Random => -Float32.Inf }),
    (3, { _: Random => Float32(0) }),
    (3, { _: Random => -Float32(0) }),
    (40, nextDenseFloat32),
    (33, { random: Random => Float32(nextImaginableFloat64(random)) })
)

// generate random float number with dense distribution
private func nextDenseFloat64(random: Random): Float64 {
    // random 52 bit number (random mantissa)
    let inRange = random.nextUInt16() >> (64 - 52)
    let rangeMax = 1 << 52

    // equidistant in 1..2
    // range 1..2 represent values with exp=0
    let randomInRange = (Float64(inRange) / Float64(rangeMax)) + 1.0

    // random exponent in range [-2^(11 - 1) -1..2^(11 - 1) -1]
    let nextPower = Float64(Int64(random.nextUInt64() % 2047) - Int64(1023))

    var res = randomInRange * Float64(2.0 ** nextPower)

    if (random.nextBool()) {
        res *= -1.0
    }

    return res
}

private let float64Table = WeightTable<(Random) -> Float64>(
    (3, { _: Random => Float64.Min }),
    (3, { _: Random => Float64.Max }),
    (3, { _: Random => Float64.NaN }),
    (3, { _: Random => Float64.MinDenormal }),
    (3, { _: Random => Float64.MinNormal }),
    (3, { _: Random => Float64.Inf }),
    (3, { _: Random => -Float64.Inf }),
    (3, { _: Random => Float64(0) }),
    (3, { _: Random => -Float64(0) }),
    (40, nextDenseFloat64),
    (33, nextImaginableFloat64)
)

private func nextFloat16(random: Random, l: Float16, r: Float16): Float16 {
    if (l.isNaN() || r.isNaN()) {
        throw IllegalArgumentException("cannot pass nan as border value")
    }
    if (r < l) {
        throw IllegalArgumentException("[${l}, ${r}] is an empty interval")
    }
    if (l == Float16.Inf) {
        return l
    }
    if (r == -Float16.Inf) {
        return r
    }
    if (l == -Float16.Inf) {
        return nextFloat16(random, Float16.Min, r)
    }
    if (r == Float16.Inf) {
        return nextFloat16(random, l, Float16.Max)
    }
    var x = random.nextFloat16()
    return max(l, min(l - l * x + r * x, r))
}

private func nextFloat32(random: Random, l: Float32, r: Float32): Float32 {
    if (l.isNaN() || r.isNaN()) {
        throw IllegalArgumentException("cannot pass nan as border value")
    }
    if (r < l) {
        throw IllegalArgumentException("[${l}, ${r}] is an empty interval")
    }
    if (l == Float32.Inf) {
        return l
    }
    if (r == -Float32.Inf) {
        return r
    }
    if (l == -Float32.Inf) {
        return nextFloat32(random, Float32.Min, r)
    }
    if (r == Float32.Inf) {
        return nextFloat32(random, l, Float32.Max)
    }
    var x = random.nextFloat32()
    return max(l, min(l - l * x + r * x, r))
}

private func nextFloat64(random: Random, l: Float64, r: Float64): Float64 {
    if (l.isNaN() || r.isNaN()) {
        throw IllegalArgumentException("cannot pass nan as border value")
    }
    if (r < l) {
        throw IllegalArgumentException("[${l}, ${r}] is an empty interval")
    }
    if (l == Float64.Inf) {
        return l
    }
    if (r == -Float64.Inf) {
        return r
    }
    if (l == -Float64.Inf) {
        return nextFloat64(random, Float64.Min, r)
    }
    if (r == Float64.Inf) {
        return nextFloat64(random, l, Float64.Max)
    }
    var x = random.nextFloat64()
    return max(l, min(l - l * x + r * x, r))
}

private let float16TableRange = WeightTable<(Random, Float16, Float16) -> Float16>(
    (4, { _: Random, _: Float16, _: Float16 => Float16.Min }),
    (4, { _: Random, _: Float16, _: Float16 => Float16.Max }),
    (4, { _: Random, _: Float16, _: Float16 => Float16.MinDenormal }),
    (4, { _: Random, _: Float16, _: Float16 => Float16.MinNormal }),
    (4, { _: Random, l: Float16, _: Float16 => l }),
    (4, { _: Random, _: Float16, r: Float16 => r }),
    (4, { _: Random, _: Float16, _: Float16 => Float16(0) }),
    (4, { _: Random, _: Float16, _: Float16 => Float16(0) }),
    (20, { random: Random, _: Float16, _: Float16 => nextDenseFloat16(random) }),
    (24, { random: Random, _: Float16, _: Float16 => Float16(nextImaginableFloat64(random)) }),
    (20, nextFloat16)
)
private let float32TableRange = WeightTable<(Random, Float32, Float32) -> Float32>(
    (3, { _: Random, _: Float32, _: Float32 => Float32.Min }),
    (3, { _: Random, _: Float32, _: Float32 => Float32.Max }),
    (3, { _: Random, _: Float32, _: Float32 => Float32.MinDenormal }),
    (3, { _: Random, _: Float32, _: Float32 => Float32.MinNormal }),
    (3, { _: Random, l: Float32, _: Float32 => l }),
    (3, { _: Random, _: Float32, r: Float32 => r }),
    (3, { _: Random, _: Float32, _: Float32 => Float32(0) }),
    (3, { _: Random, _: Float32, _: Float32 => Float32(0) }),
    (20, { random: Random, _: Float32, _: Float32 => nextDenseFloat32(random) }),
    (33, { random: Random, _: Float32, _: Float32 => Float32(nextImaginableFloat64(random)) }),
    (20, nextFloat32)
)
private let float64TableRange = WeightTable<(Random, Float64, Float64) -> Float64>(
    (3, { _: Random, _: Float64, _: Float64 => Float64.Min }),
    (3, { _: Random, _: Float64, _: Float64 => Float64.Max }),
    (3, { _: Random, _: Float64, _: Float64 => Float64.MinDenormal }),
    (3, { _: Random, _: Float64, _: Float64 => Float64.MinNormal }),
    (3, { _: Random, l: Float64, _: Float64 => l }),
    (3, { _: Random, _: Float64, r: Float64 => r }),
    (3, { _: Random, _: Float64, _: Float64 => Float64(0) }),
    (3, { _: Random, _: Float64, _: Float64 => Float64(0) }),
    (20, { random: Random, _: Float64, _: Float64 => nextDenseFloat64(random) }),
    (33, { random: Random, _: Float64, _: Float64 => nextImaginableFloat64(random) }),
    (20, nextFloat64)
)
private let int8TableRange = WeightTable<(Random, Int8, Int8) -> Int8>(
    (4, { _: Random, _: Int8, _: Int8 => Int8(0) }),
    (4, { _: Random, _: Int8, _: Int8 => Int8(1) }),
    (4, { _: Random, _: Int8, _: Int8 => Int8(-1) }),
    (4, { _: Random, l: Int8, _: Int8 => l }),
    (4, { _: Random, _: Int8, r: Int8 => r }),
    (80, { random: Random, _: Int8, _: Int8 => random.nextInt8() })
)
private let int16TableRange = WeightTable<(Random, Int16, Int16) -> Int16>(
    (4, { _: Random, _: Int16, _: Int16 => Int16(0) }),
    (3, { _: Random, _: Int16, _: Int16 => Int16(1) }),
    (3, { _: Random, _: Int16, _: Int16 => Int16(-1) }),
    (4, { _: Random, l: Int16, _: Int16 => l }),
    (4, { _: Random, _: Int16, r: Int16 => r }),
    (24, { random: Random, _: Int16, _: Int16 => nextImaginableInteger<Int16>(random, 1000.0) }),
    (58, { random: Random, _: Int16, _: Int16 => random.nextInt16() })
)
private let int32TableRange = WeightTable<(Random, Int32, Int32) -> Int32>(
    (3, { _: Random, _: Int32, _: Int32 => Int32(0) }),
    (2, { _: Random, _: Int32, _: Int32 => Int32(1) }),
    (2, { _: Random, _: Int32, _: Int32 => Int32(-1) }),
    (3, { _: Random, l: Int32, _: Int32 => l }),
    (3, { _: Random, _: Int32, r: Int32 => r }),
    (16, { random: Random, _: Int32, _: Int32 => nextImaginableInteger<Int32>(random, 100.0) }),
    (16, { random: Random, _: Int32, _: Int32 => nextImaginableInteger<Int32>(random, 10000.0) }),
    (55, { random: Random, _: Int32, _: Int32 => random.nextInt32() })
)
private let int64TableRange = WeightTable<(Random, Int64, Int64) -> Int64>(
    (3, { _: Random, _: Int64, _: Int64 => Int64(0) }),
    (2, { _: Random, _: Int64, _: Int64 => Int64(1) }),
    (2, { _: Random, _: Int64, _: Int64 => Int64(-1) }),
    (3, { _: Random, l: Int64, _: Int64 => l }),
    (3, { _: Random, _: Int64, r: Int64 => r }),
    (10, { random: Random, _: Int64, _: Int64 => nextImaginableInteger<Int64>(random, 100.0) }),
    (11, { random: Random, _: Int64, _: Int64 => nextImaginableInteger<Int64>(random, 1000.0) }),
    (11, { random: Random, _: Int64, _: Int64 => nextImaginableInteger<Int64>(random, 100000.0) }),
    (55, { random: Random, _: Int64, _: Int64 => random.nextInt64() })
)
private let intNativeTableRange = WeightTable<(Random, IntNative, IntNative) -> IntNative>(
    (3, { _: Random, _: IntNative, _: IntNative => IntNative(0) }),
    (2, { _: Random, _: IntNative, _: IntNative => IntNative(1) }),
    (2, { _: Random, _: IntNative, _: IntNative => IntNative(-1) }),
    (3, { _: Random, l: IntNative, _: IntNative => l }),
    (3, { _: Random, _: IntNative, r: IntNative => r }),
    (10, { random: Random, _: IntNative, _: IntNative => nextImaginableInteger<IntNative>(random, 100.0) }),
    (11, { random: Random, _: IntNative, _: IntNative => nextImaginableInteger<IntNative>(random, 1000.0) }),
    (11, { random: Random, _: IntNative, _: IntNative => nextImaginableInteger<IntNative>(random, 100000.0) }),
    (55, { random: Random, _: IntNative, _: IntNative => random.nextIntNative() })
)
private let uint8TableRange = WeightTable<(Random, UInt8, UInt8) -> UInt8>(
    (7, { _: Random, l: UInt8, _: UInt8 => l }),
    (6, { _: Random, _: UInt8, _: UInt8 => UInt8(1) }),
    (7, { _: Random, _: UInt8, r: UInt8 => r }),
    (80, { random: Random, _: UInt8, _: UInt8 => random.nextUInt8() })
)
private let uint16TableRange = WeightTable<(Random, UInt16, UInt16) -> UInt16>(
    (4, { _: Random, l: UInt16, _: UInt16 => l }),
    (2, { _: Random, _: UInt16, _: UInt16 => UInt16(1) }),
    (4, { _: Random, _: UInt16, r: UInt16 => r }),
    (30, { random: Random, _: UInt16, _: UInt16 => nextImaginableInteger<UInt16>(random, 1000.0) }),
    (60, { random: Random, _: UInt16, _: UInt16 => random.nextUInt16() })
)
private let uint32TableRange = WeightTable<(Random, UInt32, UInt32) -> UInt32>(
    (3, { _: Random, l: UInt32, _: UInt32 => l }),
    (2, { _: Random, _: UInt32, _: UInt32 => UInt32(1) }),
    (3, { _: Random, _: UInt32, r: UInt32 => r }),
    (16, { random: Random, _: UInt32, _: UInt32 => nextImaginableInteger<UInt32>(random, 100.0) }),
    (16, { random: Random, _: UInt32, _: UInt32 => nextImaginableInteger<UInt32>(random, 10000.0) }),
    (60, { random: Random, _: UInt32, _: UInt32 => random.nextUInt32() })
)
private let uint64TableRange = WeightTable<(Random, UInt64, UInt64) -> UInt64>(
    (3, { _: Random, l: UInt64, _: UInt64 => l }),
    (2, { _: Random, _: UInt64, _: UInt64 => UInt64(1) }),
    (3, { _: Random, _: UInt64, r: UInt64 => r }),
    (10, { random: Random, _: UInt64, _: UInt64 => nextImaginableInteger<UInt64>(random, 100.0) }),
    (11, { random: Random, _: UInt64, _: UInt64 => nextImaginableInteger<UInt64>(random, 1000.0) }),
    (11, { random: Random, _: UInt64, _: UInt64 => nextImaginableInteger<UInt64>(random, 100000.0) }),
    (60, { random: Random, _: UInt64, _: UInt64 => random.nextUInt64() })
)
private let uintNativeTableRange = WeightTable<(Random, UIntNative, UIntNative) -> UIntNative>(
    (7, { _: Random, l: UIntNative, _: UIntNative => l }),
    (6, { _: Random, _: UIntNative, _: UIntNative => UIntNative(1) }),
    (7, { _: Random, _: UIntNative, r: UIntNative => r }),
    (10, { random: Random, _: UIntNative, _: UIntNative => nextImaginableInteger<UIntNative>(random, 100.0) }),
    (11, { random: Random, _: UIntNative, _: UIntNative => nextImaginableInteger<UIntNative>(random, 1000.0) }),
    (11, { random: Random, _: UIntNative, _: UIntNative => nextImaginableInteger<UIntNative>(random, 100000.0) }),
    (60, { random: Random, _: UIntNative, _: UIntNative => random.nextUIntNative() })
)

extend Random <: RandomSource {
    public func suggestBool(): Bool {
        generateBool(this)
    }
    private func suggestBiasedPrimitive<T>(fromTable: WeightTable<(Random) -> T>) {
        this.pickWeighted(fromTable)(this)
    }
    public func suggestInt8(): Int8 {
        suggestBiasedPrimitive(int8Table)
    }
    public func suggestInt16(): Int16 {
        suggestBiasedPrimitive(int16Table)
    }
    public func suggestInt32(): Int32 {
        suggestBiasedPrimitive(int32Table)
    }
    public func suggestInt64(): Int64 {
        suggestBiasedPrimitive(int64Table)
    }

    @OverflowWrapping
    public func suggestIntNative(): IntNative {
        IntNative(suggestInt64())
    }
    public func suggestUInt8(): UInt8 {
        suggestBiasedPrimitive(uint8Table)
    }
    public func suggestUInt16(): UInt16 {
        suggestBiasedPrimitive(uint16Table)
    }
    public func suggestUInt32(): UInt32 {
        suggestBiasedPrimitive(uint32Table)
    }
    public func suggestUInt64(): UInt64 {
        suggestBiasedPrimitive(uint64Table)
    }

    @OverflowWrapping
    public func suggestUIntNative(): UIntNative {
        UIntNative(suggestUInt64())
    }
    public func suggestFloat16(): Float16 {
        suggestBiasedPrimitive(float16Table)
    }
    public func suggestFloat32(): Float32 {
        suggestBiasedPrimitive(float32Table)
    }
    public func suggestFloat64(): Float64 {
        suggestBiasedPrimitive(float64Table)
    }
    public func suggestRune(): Rune {
        randomBiasedRune(this)
    }

    @OverflowWrapping
    public func nextIntNative(): IntNative {
        IntNative(this.nextInt64())
    }

    @OverflowWrapping
    public func nextUIntNative(): UIntNative {
        UIntNative(this.nextUInt64())
    }
    private func suggestBiasedPrimitive<T>(fromTable: WeightTable<(Random, T, T) -> T>, l: T, r: T) {
        this.pickWeighted(fromTable)(this, l, r)
    }
    public func suggestInt64(l: Int64, r: Int64): Int64 {
        remap(l, r, suggestBiasedPrimitive(int64TableRange, l, r))
    }
    public func suggestUInt64(l: UInt64, r: UInt64): UInt64 {
        remap(l, r, suggestBiasedPrimitive(uint64TableRange, l, r))
    }
    public func suggestInt32(l: Int32, r: Int32): Int32 {
        remap(l, r, suggestBiasedPrimitive(int32TableRange, l, r))
    }
    public func suggestUInt32(l: UInt32, r: UInt32): UInt32 {
        remap(l, r, suggestBiasedPrimitive(uint32TableRange, l, r))
    }
    public func suggestInt16(l: Int16, r: Int16): Int16 {
        remap(l, r, suggestBiasedPrimitive(int16TableRange, l, r))
    }
    public func suggestUInt16(l: UInt16, r: UInt16): UInt16 {
        remap(l, r, suggestBiasedPrimitive(uint16TableRange, l, r))
    }
    public func suggestInt8(l: Int8, r: Int8): Int8 {
        remap(l, r, suggestBiasedPrimitive(int8TableRange, l, r))
    }
    public func suggestUInt8(l: UInt8, r: UInt8): UInt8 {
        remap(l, r, suggestBiasedPrimitive(uint8TableRange, l, r))
    }
    public func suggestIntNative(l: IntNative, r: IntNative): IntNative {
        remap(l, r, suggestBiasedPrimitive(intNativeTableRange, l, r))
    }
    public func suggestUIntNative(l: UIntNative, r: UIntNative): UIntNative {
        remap(l, r, suggestBiasedPrimitive(uintNativeTableRange, l, r))
    }
    public func suggestFloat64(l: Float64, r: Float64): Float64 {
        remap(l, r, suggestBiasedPrimitive(float64TableRange, l, r))
    }
    public func suggestFloat32(l: Float32, r: Float32): Float32 {
        remap(l, r, suggestBiasedPrimitive(float32TableRange, l, r))
    }
    public func suggestFloat16(l: Float16, r: Float16): Float16 {
        remap(l, r, suggestBiasedPrimitive(float16TableRange, l, r))
    }
}
