/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.random

import std.math.*

@FastNative
foreign func CJ_RANDOM_NanoNow(): Int64

@OverflowWrapping
func getSeed(): UInt64 {
    UInt64(unsafe { CJ_RANDOM_NanoNow() })
}

/**
 * Random class used for random manipulations.
 * @since 0.16.5
 */
public class Random {
    /* Period parameters */
    private static const N: Int64 = 0x138
    private static const M: Int64 = 0x9C
    private static const MATRIX: UInt64 = 0xB5026F5AA96619E9
    private static const UPPER_MASK: UInt64 = 0xffffffff80000000
    private static const LOWER_MASK: UInt64 = 0x7fffffff
    private static const MAX_MASK: UInt64 = 0xffffffffffffffff

    /* Tempering parameters */
    private static const TEMPERING_MASK_A: UInt64 = 0x5555555555555555
    private static const TEMPERING_MASK_B: UInt64 = 0x71D67FFFEDA60000
    private static const TEMPERING_MASK_C: UInt64 = 0xFFF7EEE000000000

    private static const magNum: (UInt64, UInt64) = (0x0, MATRIX)

    private var mt: Array<UInt64>
    private var mti: Int64
    private var nextGaussian: Option<Float64>
    private var _seed: UInt64

    /**
     * Create a new Random object.
     *
     * Default constructor.
     *
     * @since 0.16.5
     */
    public init() {
        this(getSeed())
    }

    /**
     * Create a new Random object.
     *
     * @param seed a seed of type UInt64.
     *
     * @since 0.16.5
     */
    public init(seed: UInt64) {
        this._seed = seed
        nextGaussian = Option<Float64>.None
        mt = Array<UInt64>(N, repeat: 0)
        mt[0] = this._seed
        initialMtArray(mt)
        mti = N
    }

    /**
     * Set the size of Seed.
     *
     * @param seed a seed of type UInt64.
     */
    public prop seed: UInt64 {
        get() {
            return this._seed
        }
    }

    /**
     * Get random of UInt64.
     *
     * @param bits bits of type UInt64.
     * @return Parameters of UInt64.
     *
     * @since 0.16.5
     *
     * @throws IllegalArgumentException if bits greater than 64.
     */
    @Deprecated["Use member function `public func nextBits(bits: UInt64): UInt64` instead."]
    public func next(bits: UInt64): UInt64 {
        if (bits > 64) {
            throw IllegalArgumentException("Bits must be less than or equal to 64.")
        }
        if (bits == 0) {
            throw IllegalArgumentException("Bits cannot be 0.")
        }
        var y: UInt64 = 0
        if (mti >= N) {
            var mt = mt
            var kk: Int64 = 0
            while (kk < N) {
                y = (mt[kk] & UPPER_MASK) | (mt[(kk + 1) % N] & LOWER_MASK)
                if (y % 2 == 0) {
                    mt[kk] = mt[(kk + M) % N] ^ (y >> 1) ^ magNum[0]
                } else {
                    mt[kk] = mt[(kk + M) % N] ^ (y >> 1) ^ magNum[1]
                }
                kk++
            }
            mti = 0
        }
        return returnNext(bits)
    }

    /**
     * Get random of UInt64.
     *
     * @param bits bits of type UInt64.
     * @return Parameters of UInt64.
     *
     * @throws IllegalArgumentException if bits greater than 64 or equal to 0.
     */
    public func nextBits(bits: UInt64): UInt64 {
        if (bits > 64) {
            throw IllegalArgumentException("Bits must be less than or equal to 64.")
        }
        if (bits == 0) {
            throw IllegalArgumentException("Bits cannot be 0.")
        }
        var y: UInt64 = 0
        if (mti >= N) {
            var mt = mt
            var kk: Int64 = 0
            while (kk < N) {
                y = (mt[kk] & UPPER_MASK) | (mt[(kk + 1) % N] & LOWER_MASK)
                if (y % 2 == 0) {
                    mt[kk] = mt[(kk + M) % N] ^ (y >> 1) ^ magNum[0]
                } else {
                    mt[kk] = mt[(kk + M) % N] ^ (y >> 1) ^ magNum[1]
                }
                kk++
            }
            mti = 0
        }
        return returnNext(bits)
    }

    /**
     * Get random of Bool.
     *
     * @return bool a random bool.
     *
     * @since 0.16.5
     */
    public func nextBool(): Bool {
        return nextBits(1) != 0
    }

    /**
     * Get random of UInt8.
     *
     * @return Parameters of UInt8.
     *
     * @since 0.16.5
     */
    @OverflowWrapping
    public func nextUInt8(): UInt8 {
        return UInt8(nextBits(8))
    }

    /**
     * Get random of UInt16.
     *
     * @return Parameters of UInt16.
     *
     * @since 0.16.5
     */
    @OverflowWrapping
    public func nextUInt16(): UInt16 {
        return UInt16(nextBits(16))
    }

    /**
     * Get random of UInt32.
     *
     * @return Parameters of UInt32.
     *
     * @since 0.16.5
     */
    @OverflowWrapping
    public func nextUInt32(): UInt32 {
        return UInt32(nextBits(32))
    }

    /**
     * Get random of UInt64.
     *
     * @return Parameters of UInt64.
     *
     * @since 0.16.5
     */
    public func nextUInt64(): UInt64 {
        return nextBits(64)
    }

    /**
     * Get random of Int8.
     *
     * @return Parameters of Int8.
     *
     * @since 0.16.5
     */
    @OverflowWrapping
    public func nextInt8(): Int8 {
        return Int8(nextBits(8))
    }

    /**
     * Get random of Int16.
     *
     * @return Parameters of Int16.
     *
     * @since 0.16.5
     */
    @OverflowWrapping
    public func nextInt16(): Int16 {
        return Int16(nextBits(16))
    }

    /**
     * Get random of Int32.
     *
     * @return Parameters of Int32.
     *
     * @since 0.16.5
     */
    @OverflowWrapping
    public func nextInt32(): Int32 {
        return Int32(nextBits(32))
    }

    /**
     * Get random of Int64.
     *
     * @return Parameters of Int64.
     *
     * @since 0.16.5
     */
    @OverflowWrapping
    public func nextInt64(): Int64 {
        return Int64(nextBits(64))
    }

    /**
     * Get random of UInt8.An exception is thrown when upper is less than or equal to 0.
     * upper is excluded from the results
     *
     * @param upper UInt8 type upper.
     * @return Parameters of UInt8.
     *
     * @since 0.16.5
     *
     * @throws IllegalArgumentException if upper is equal to zero.
     */
    public func nextUInt8(upper: UInt8): UInt8 {
        if (upper == 0) {
            throw IllegalArgumentException("Upper must be positive, got: ${upper}.")
        }
        return nextUInt8() % upper
    }

    /**
     * Get random of UInt16.An exception is thrown when upper is less than or equal to 0.
     * upper is excluded from the results
     *
     * @param upper UInt16 type upper.
     * @return Parameters of UInt16.
     *
     * @since 0.16.5
     *
     * @throws IllegalArgumentException if upper is equal to zero.
     */
    public func nextUInt16(upper: UInt16): UInt16 {
        if (upper == 0) {
            throw IllegalArgumentException("Upper must be positive, got: ${upper}.")
        }
        return nextUInt16() % upper
    }

    /**
     * Get random of UInt32.An exception is thrown when upper is less than or equal to 0.
     * upper is excluded from the results
     *
     * @param upper UInt32 type upper.
     * @return Parameters of UInt32.
     *
     * @since 0.16.5
     *
     * @throws IllegalArgumentException if upper is equal to zero.
     */
    public func nextUInt32(upper: UInt32): UInt32 {
        if (upper == 0) {
            throw IllegalArgumentException("Upper must be positive, got: ${upper}.")
        }
        return nextUInt32() % upper
    }

    /**
     * Get random of UInt64.An exception is thrown when upper is less than or equal to 0.
     * upper is excluded from the results
     *
     * @param upper UInt64 type upper.
     * @return Parameters of UInt64.
     *
     * @since 0.16.5
     *
     * @throws IllegalArgumentException if upper is equal to zero.
     */
    public func nextUInt64(upper: UInt64): UInt64 {
        if (upper == 0) {
            throw IllegalArgumentException("Upper must be positive, got: ${upper}.")
        }
        return nextUInt64() % upper
    }

    /**
     * Get random of Int8.An exception is thrown when upper is less than or equal to 0.
     * upper is excluded from the results
     *
     * @param upper Int8 type upper.
     * @return Parameters of Int8.
     *
     * @since 0.16.5
     *
     * @throws IllegalArgumentException if upper <= 0.
     */
    public func nextInt8(upper: Int8): Int8 {
        if (upper <= 0) {
            throw IllegalArgumentException("Upper must be positive, got: ${upper}.")
        }
        var next = nextInt8()
        while (next < 0) {
            next = nextInt8()
        }
        return next % upper
    }

    /**
     * Get random of Int16.An exception is thrown when upper is less than or equal to 0.
     * upper is excluded from the results
     *
     * @param upper Int16 type upper.
     * @return Parameters of Int16.
     *
     * @since 0.16.5
     *
     * @throws IllegalArgumentException if upper <= 0.
     */
    public func nextInt16(upper: Int16): Int16 {
        if (upper <= 0) {
            throw IllegalArgumentException("Upper must be positive, got: ${upper}.")
        }
        var next = nextInt16()
        while (next < 0) {
            next = nextInt16()
        }
        return next % upper
    }

    /**
     * Get random of Int32.An exception is thrown when upper is less than or equal to 0.
     * upper is excluded from the results
     *
     * @param upper Int32 type upper.
     * @return Parameters of Int32.
     *
     * @since 0.16.5
     *
     * @throws IllegalArgumentException if upper <= 0.
     */
    public func nextInt32(upper: Int32): Int32 {
        if (upper <= 0) {
            throw IllegalArgumentException("Upper must be positive, got: ${upper}.")
        }
        var next = nextInt32()
        while (next < 0) {
            next = nextInt32()
        }
        return next % upper
    }

    /**
     * Get random of Int64.An exception is thrown when upper is less than or equal to 0.
     * upper is excluded from the results
     *
     * @param upper Int64 type upper.
     * @return Parameters of Int64.
     *
     * @since 0.16.5
     *
     * @throws IllegalArgumentException if upper <= 0.
     */
    public func nextInt64(upper: Int64): Int64 {
        if (upper <= 0) {
            throw IllegalArgumentException("Upper must be positive, got: ${upper}.")
        }
        var next = nextInt64()
        while (next < 0) {
            next = nextInt64()
        }
        return next % upper
    }

    /**
     * Get random of UInt8s.
     *
     * @return Parameters of UInt8s[].
     *
     * @since 0.16.5
     */
    @Deprecated["Use member function `public func nextBytes(arr: Array<Byte>): Unit` instead."]
    public func nextUInt8s(array: Array<UInt8>): Array<UInt8> {
        for (i in 0..array.size) {
            array[i] = this.nextUInt8()
        }
        return array
    }

    /**
     * Fill the byte array with random bytes.
     */
    public func nextBytes(bytes: Array<Byte>): Unit {
        for (i in 0..bytes.size) {
            bytes[i] = this.nextUInt8()
        }
    }

    /**
     * Generate a byte array with random bytes.
     */
    public func nextBytes(length: Int32): Array<Byte> {
        if (length <= 0) {
            throw IllegalArgumentException("Length must be positive.")
        }
        return Array<Byte>(Int64(length), {_ => this.nextUInt8()})
    }

    /**
     * Get random of Float16.
     *
     * @return Parameters of Float16.
     *
     * @since 0.16.5
     */
    public func nextFloat16(): Float16 {
        return Float16(Float64(nextBits(11)) / Float64(1 << 11))
    }

    /**
     * Get random of Float32.
     *
     * @return Parameters of Float32.
     *
     * @since 0.16.5
     */
    public func nextFloat32(): Float32 {
        return Float32(Float64(nextBits(24)) / Float64(1 << 24))
    }

    /**
     * Get random of Float64.
     *
     * @return Parameters of Float64.
     *
     * @since 0.16.5
     */
    public func nextFloat64(): Float64 {
        return Float64(nextBits(53)) / Float64(1 << 53)
    }

    private func returnNext(bits: UInt64): UInt64 {
        var yy = mt[mti]
        mti++
        yy ^= (yy >> 29) & TEMPERING_MASK_A
        yy ^= (yy << 17) & TEMPERING_MASK_B
        yy ^= (yy << 37) & TEMPERING_MASK_C
        yy ^= (yy >> 43)
        return yy & (MAX_MASK >> (64 - bits))
    }

    /**
     * Obtaining Gaussian (normal) distribution random values.
     *
     * @param mean: mean value
     * @param sigma: standard deviation
     * @return Float16 random value
     *
     * @since 0.40.2
     */
    public func nextGaussianFloat16(mean!: Float16 = 0.0, sigma!: Float16 = 1.0): Float16 {
        return Float16(gaussian()) * sigma + mean
    }

    /**
     * Obtaining Gaussian (normal) distribution random values.
     *
     * @param mean: mean value
     * @param sigma: standard deviation
     * @return Float32 random value
     *
     * @since 0.40.2
     */
    public func nextGaussianFloat32(mean!: Float32 = 0.0, sigma!: Float32 = 1.0): Float32 {
        return Float32(gaussian()) * sigma + mean
    }

    /**
     * Obtaining Gaussian (normal) distribution random values.
     *
     * @param mean: mean value
     * @param sigma: standard deviation
     * @return Float64 random value
     *
     * @since 0.40.2
     */
    public func nextGaussianFloat64(mean!: Float64 = 0.0, sigma!: Float64 = 1.0): Float64 {
        return gaussian() * sigma + mean
    }

    /**
     * Box-Muller algorithm
     * R * cos(O) or R * sin(O), it's a pair of Gaussian random values.
     * when R = sqrt(-2 * ln(V1)) and  O = 2 * π * V2
     * V1 and V2 are two evenly distributed random values.
     */
    private func gaussian(): Float64 {
        match (nextGaussian) {
            case Some(v) =>
                nextGaussian = Option<Float64>.None
                return v
            case None =>
                let v1: Float64 = nextFloat64()
                let v2: Float64 = nextFloat64()
                let r = sqrt(-2.0 * log(v1))
                let st = 2.0 * Float64.getPI() * v2
                nextGaussian = Option<Float64>.Some(r * cos(st))
                return r * sin(st)
        }
    }
}

@OverflowWrapping
func initialMtArray(mt: Array<UInt64>): Array<UInt64> {
    var mti = 1 /* The value of the mt array index is cyclically assigned from 1. */
    while (mti < mt.size) {
        // 6364136223846793005 is a key number used in Mersenne Twister algorithm. 
        mt[mti] = (UInt64(6364136223846793005) * (mt[mti - 1] ^ (mt[mti - 1] >> 62)) + UInt64(mti))
        mti++
    }
    mt
}
