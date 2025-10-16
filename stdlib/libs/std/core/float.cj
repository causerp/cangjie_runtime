/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.core

// Provide the function that bitcast between two kinds of primitive types.
// It's implemented by Cangjie compiler and is backend-independent.
@Intrinsic
func bitCast<From, To>(val: From): To where From <: BitCastRange, To <: BitCastRange

extend Float64 {
    /**
     * @brief Convert from IEEE 754 binary value to Float64 value
     * @param bits, IEEE 754 binary representation of value
     * @return Float64 value
     *
     */
    public static func fromBits(bits: UInt64): Float64 {
        bitCast(bits)
    }
    /**
     * @brief Convert a Float64 value to an IEEE 754 binary representation
     *
     * @return UInt64 The value represented by the IEEE 754 binary bit representation
     *
     */
    public func toBits(): UInt64 {
        bitCast(this)
    }
}

extend Float32 {
    /**
     * @brief Convert from IEEE 754 binary value to Float32 value
     * @param bits, IEEE 754 binary representation of value
     * @return Float32 value
     *
     */
    public static func fromBits(bits: UInt32): Float32 {
        bitCast(bits)
    }
    /**
     * @brief Convert a Float32 value to an IEEE 754 binary representation
     *
     * @return UInt64 The value represented by the IEEE 754 binary bit representation
     *
     */
    public func toBits(): UInt32 {
        bitCast(this)
    }
}

extend Float16 {
    /**
     * @brief Convert from IEEE 754 binary value to Float16 value
     * @param bits, IEEE 754 binary representation of value
     * @return Float16 value
     *
     */
    public static func fromBits(bits: UInt16): Float16 {
        bitCast(bits)
    }
    /**
     * @brief Convert a Float16 value to an IEEE 754 binary representation
     *
     * @return UInt64 The value represented by the IEEE 754 binary bit representation
     *
     */
    public func toBits(): UInt16 {
        bitCast(this)
    }
}

// Indicates the types can be used in function bitCast.
interface BitCastRange {}

extend UInt64 <: BitCastRange {}

extend Float64 <: BitCastRange {}

extend UInt32 <: BitCastRange {}

extend Float32 <: BitCastRange {}

extend UInt16 <: BitCastRange {}

extend Float16 <: BitCastRange {}
