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
 * This is a library for math class.
 */

package std.math

/********************* utility functions *********************/
/**
 * Returns the absolute value of a floating-point number.
 * If the parameter is not a negative number, the parameter is returned.
 * If the argument is negative, the negative number of the argument is returned.
 * special cases that arise:
 * If the argument is NaN, the result is NaN.
 * If the argument is infinite, the result is positive infinity.
 *
 * @param x some value.
 * @return the absolute value of @p x.
 *
 * @since 0.17.4
 */
@Frozen
public func abs(x: Float64): Float64 {
    intrinsicFabs<Float64>(x)
}

/**
 * Returns the absolute value of a floating-point number.
 * If the parameter is not a negative number, the parameter is returned.
 * If the argument is negative, the negative number of the argument is returned.
 * special cases that arise:
 * If the argument is NaN, the result is NaN.
 * If the argument is infinite, the result is positive infinity.
 *
 * @param x some value.
 * @return the absolute value of @p x.
 *
 * @since 0.17.4
 */
@Frozen
public func abs(x: Float32): Float32 {
    intrinsicFabs<Float32>(x)
}

/**
 * Returns the absolute value of a floating-point number.
 * If the parameter is not a negative number, the parameter is returned.
 * If the argument is negative, the negative number of the argument is returned.
 * special cases that arise:
 * If the argument is NaN, the result is NaN.
 * If the argument is infinite, the result is positive infinity.
 *
 * @param x some value.
 * @return the absolute value of @p x.
 *
 * @since 0.17.4
 */
@Frozen
public func abs(x: Float16): Float16 {
    intrinsicFabs<Float16>(x)
}

/**
 * Returns the absolute value of a number.
 * If the parameter is not a negative number, the parameter is returned.
 * If the argument is negative, the negative number of the argument is returned.
 * special cases that arise:
 * An OverflowException will be thrown if the argument is MIN_VALUE.
 *
 * @param x some value.
 * @return the absolute value of @p x.
 *
 * @since 0.17.4
 *
 * @throws OverflowException if the argument `x` is the minimum value of Int64
 */
@Frozen
public func abs(x: Int64): Int64 {
    if (x == Int64.Min) {
        throw OverflowException("The absolute value of the minimum Int64 value is out of range.")
    }
    intrinsicAbs<Int64>(x)
}

/**
 * Returns the absolute value of a number.
 * If the parameter is not a negative number, the parameter is returned.
 * If the argument is negative, the negative number of the argument is returned.
 * special cases that arise:
 * An OverflowException will be thrown if the argument is MIN_VALUE.
 *
 * @param x some value.
 * @return the absolute value of @p x.
 *
 * @since 0.17.4
 *
 * @throws OverflowException if the argument `x` is the minimum value of Int32
 */
@Frozen
public func abs(x: Int32): Int32 {
    if (x == Int32.Min) {
        throw OverflowException("The absolute value of the minimum Int32 value is out of range.")
    }
    intrinsicAbs<Int32>(x)
}

/**
 * Returns the absolute value of a number.
 * If the parameter is not a negative number, the parameter is returned.
 * If the argument is negative, the negative number of the argument is returned.
 * special cases that arise:
 * An OverflowException will be thrown if the argument is MIN_VALUE.
 *
 * @param x some value.
 * @return the absolute value of @p x.
 *
 * @since 0.17.4
 *
 * @throws OverflowException if the argument `x` is the min value of Int16
 */
@Frozen
public func abs(x: Int16): Int16 {
    if (x == Int16.Min) {
        throw OverflowException("The absolute value of the minimum Int16 value is out of range.")
    }
    intrinsicAbs<Int16>(x)
}

/**
 * Returns the absolute value of a number.
 * If the parameter is not a negative number, the parameter is returned.
 * If the argument is negative, the negative number of the argument is returned.
 * special cases that arise:
 * An OverflowException will be thrown if the argument is MIN_VALUE.
 *
 * @param x some value.
 * @return the absolute value of @p x.
 *
 * @since 0.17.4
 *
 * @throws OverflowException if the argument `x` is the minimum value of Int8
 */
@Frozen
public func abs(x: Int8): Int8 {
    if (x == Int8.Min) {
        throw OverflowException("The absolute value of the minimum Int8 value is out of range.")
    }
    intrinsicAbs<Int8>(x)
}

/**
 * Returns the square root of the value.
 * The square root of a positive value is the positive number
 * of the square root of the size of the value.
 * special cases that arise:
 * If the parameter is negative, an invalid parameter exception is thrown.
 * If the argument is NaN, the result is NaN.
 * If the argument is positive infinity, the result is positive infinity.
 *
 * @param x some value.
 * @return the square root of @p x.
 *
 * @since 0.17.4
 *
 * @throws IllegalArgumentException if the argument `x` is negative
 */
@Frozen
public func sqrt(x: Float16): Float16 {
    if (x < 0.0) {
        throw IllegalArgumentException(
            "The input parameter must be greater than or equal to 0.0. Please enter a correct parameter.")
    }
    return intrinsicSqrt<Float16>(x)
}

/**
 * Returns the square root of the value.
 * The square root of a positive value is the positive number
 * of the square root of the size of the value.
 * special cases that arise:
 * If the parameter is negative, an invalid parameter exception is thrown.
 * If the argument is NaN, the result is NaN.
 * If the argument is positive infinity, the result is positive infinity.
 *
 * @param x some value.
 * @return the square root of @p x.
 *
 * @since 0.17.4
 *
 * @throws IllegalArgumentException if the argument `x` is negative
 */
@Frozen
public func sqrt(x: Float32): Float32 {
    if (x < 0.0) {
        throw IllegalArgumentException(
            "The input parameter must be greater than or equal to 0.0. Please enter a correct parameter.")
    }
    return intrinsicSqrt<Float32>(x)
}

/**
 * Returns the square root of the value.
 * The square root of a positive value is the positive number
 * of the square root of the size of the value.
 * special cases that arise:
 * If the parameter is negative, an invalid parameter exception is thrown.
 * If the argument is NaN, the result is NaN.
 * If the argument is positive infinite, the result is positive infinity.
 *
 * @param x some value.
 * @return the square root of @p x.
 *
 * @since 0.17.4
 *
 * @throws IllegalArgumentException if the argument `x` is negative
 */
@Frozen
public func sqrt(x: Float64): Float64 {
    if (x < 0.0) {
        throw IllegalArgumentException(
            "The input parameter must be greater than or equal to 0.0. Please enter a correct parameter.")
    }
    return intrinsicSqrt<Float64>(x)
}

/**
 * Returns Euler's number raised to the power of a value.
 * special cases that arise:
 * If the argument is NaN, the result is NaN.
 * If the parameter is negative, an invalid parameter exception is thrown.
 * If the argument is positive infinite, the result is positive infinity.
 * If the argument is negative infinity, then the result is zero
 *
 * @param x some value.
 * @return \f$ e^{x} \f$.
 *
 * @since 0.17.4
 */
@Frozen
public func exp(x: Float64): Float64 {
    return intrinsicExp<Float64>(x)
}

/**
 * Returns Euler's number raised to the power of a value.
 * special cases that arise:
 * If the argument is NaN, the result is NaN.
 * If the parameter is negative, an invalid parameter exception is thrown.
 * If the argument is positive infinite, the result is positive infinity.
 * If the argument is negative infinity, then the result is zero
 *
 * @param x some value.
 * @return \f$ e^{x} \f$.
 *
 * @since 0.17.4
 */
@Frozen
public func exp(x: Float32): Float32 {
    return intrinsicExp<Float32>(x)
}

/**
 * Returns Euler's number raised to the power of a value.
 * special cases that arise:
 * If the argument is NaN, the result is NaN.
 * If the parameter is negative, an invalid parameter exception is thrown.
 * If the argument is positive infinite, the result is positive infinity.
 * If the argument is negative infinity, then the result is zero
 *
 * @param x some value.
 * @return \f$ e^{x} \f$.
 *
 * @since 0.17.4
 */
@Frozen
public func exp(x: Float16): Float16 {
    return intrinsicExp<Float16>(x)
}

/**
 * Returns 2's number raised to the power of a value.
 * special cases that arise:
 * If the argument is NaN, the result is NaN.
 * If the parameter is negative, an invalid parameter exception is thrown.
 * If the argument is positive infinite, the result is positive infinity.
 * If the argument is negative infinity, then the result is zero
 *
 * @param x some value.
 * @return \f$ 2^{x} \f$.
 *
 * @since 0.17.4
 */
@Frozen
public func exp2(x: Float64): Float64 {
    return intrinsicExp2<Float64>(x)
}

/**
 * Returns 2's number raised to the power of a value.
 * special cases that arise:
 * If the argument is NaN, the result is NaN.
 * If the parameter is negative, an invalid parameter exception is thrown.
 * If the argument is positive infinite, the result is positive infinity.
 * If the argument is negative infinity, then the result is zero
 *
 * @param x some value.
 * @return \f$ 2^{x} \f$.
 *
 * @since 0.17.4
 */
@Frozen
public func exp2(x: Float32): Float32 {
    return intrinsicExp2<Float32>(x)
}

/**
 * Returns 2's number raised to the power of a value.
 * special cases that arise:
 * If the argument is NaN, the result is NaN.
 * If the parameter is negative, an invalid parameter exception is thrown.
 * If the argument is positive infinite, the result is positive infinity.
 * If the argument is negative infinity, then the result is zero
 *
 * @param x some value.
 * @return \f$ 2^{x} \f$.
 *
 * @since 0.17.4
 */
@Frozen
public func exp2(x: Float16): Float16 {
    return intrinsicExp2<Float16>(x)
}

/**
 * Returns the base 10 logarithm of a value.
 * special cases that arise:
 * If the parameter is NaN or less than zero, the result is NaN.
 * If the argument is positive infinity, the result is positive infinity.
 * If the argument is positive zero or negative zero, the result is negative infinity.
 * If the argument is equal to a 10*n integer, the result is n.
 *
 * @param x some value.
 * @return base 10 logarithm of @p x.
 *
 * @since 0.17.4
 *
 * @throws IllegalArgumentException if the argument `x` is not positive
 */
@Frozen
public func log10(x: Float64): Float64 {
    return intrinsicLog10<Float64>(x)
}

/**
 * Returns the base 10 logarithm of a value.
 * special cases that arise:
 * If the parameter is NaN or less than zero, the result is NaN.
 * If the argument is positive infinity, the result is positive infinity.
 * If the argument is positive zero or negative zero, the result is negative infinity.
 * If the argument is equal to a 10*n integer, the result is n.
 *
 * @param x some value.
 * @return base 10 logarithm of @p x.
 *
 * @since 0.17.4
 *
 * @throws IllegalArgumentException if the argument `x` is not positive
 */
@Frozen
public func log10(x: Float32): Float32 {
    return intrinsicLog10<Float32>(x)
}

/**
 * Returns the base 10 logarithm of a value.
 * special cases that arise:
 * If the parameter is NaN or less than zero, the result is NaN.
 * If the argument is positive infinity, the result is positive infinity.
 * If the argument is positive zero or negative zero, the result is negative infinity.
 * If the argument is equal to a 10*n integer, the result is n.
 *
 * @param x some value.
 * @return base 10 logarithm of @p x.
 *
 * @since 0.17.4
 *
 * @throws IllegalArgumentException if the argument `x` is not positive
 */
@Frozen
public func log10(x: Float16): Float16 {
    return intrinsicLog10<Float16>(x)
}

/**
 * Returns the base 2 logarithm of a value.
 * special cases that arise:
 * If the parameter is NaN or less than zero, the result is NaN.
 * If the argument is positive infinity, the result is positive infinity.
 * If the argument is positive zero or negative zero, the result is negative infinity.
 * If the argument is equal to a 2*n integer, the result is n.
 *
 * @param x some value.
 * @return base 2 logarithm of @p x.
 *
 * @since 0.17.4
 *
 * @throws IllegalArgumentException if the argument `x` is not positive
 */
@Frozen
public func log2(x: Float64): Float64 {
    return intrinsicLog2<Float64>(x)
}

/**
 * Returns the base 2 logarithm of a value.
 * special cases that arise:
 * If the parameter is NaN or less than zero, the result is NaN.
 * If the argument is positive infinity, the result is positive infinity.
 * If the argument is positive zero or negative zero, the result is negative infinity.
 * If the argument is equal to a 2*n integer, the result is n.
 *
 * @param x some value.
 * @return base 2 logarithm of @p x.
 *
 * @since 0.17.4
 *
 * @throws IllegalArgumentException if the argument `x` is not positive
 */
@Frozen
public func log2(x: Float32): Float32 {
    return intrinsicLog2<Float32>(x)
}

/**
 * Returns the base 2 logarithm of a value.
 * special cases that arise:
 * If the parameter is NaN or less than zero, the result is NaN.
 * If the argument is positive infinity, the result is positive infinity.
 * If the argument is positive zero or negative zero, the result is negative infinity.
 * If the argument is equal to a 2*n integer, the result is n.
 *
 * @param x some value.
 * @return base 2 logarithm of @p x.
 *
 * @since 0.17.4
 *
 * @throws IllegalArgumentException if the argument `x` is not positive
 */
@Frozen
public func log2(x: Float16): Float16 {
    return intrinsicLog2<Float16>(x)
}

/**
 * Return the natural logarithm of a value.
 * special cases that arise:
 * If the parameter is NaN or less than zero, the result is NaN.
 * If the argument is positive infinity, the result is positive infinity.
 * If the argument is positive zero or negative zero, the result is negative infinity.
 *
 * @param x some value.
 * @return \f$ \ln{x} \f$.
 *
 * @since 0.17.4
 *
 * @throws IllegalArgumentException if the argument `x` is not positive
 */
@Frozen
public func log(x: Float64): Float64 {
    return intrinsicLog<Float64>(x)
}

/**
 * Return the natural logarithm of a value.
 * special cases that arise:
 * If the parameter is NaN or less than zero, the result is NaN.
 * If the argument is positive infinity, the result is positive infinity.
 * If the argument is positive zero or negative zero, the result is negative infinity.
 *
 * @param x some value.
 * @return \f$ \ln{x} \f$.
 *
 * @since 0.17.4
 *
 * @throws IllegalArgumentException if the argument `x` is not positive
 */
@Frozen
public func log(x: Float32): Float32 {
    return intrinsicLog<Float32>(x)
}

/**
 * Return the natural logarithm of a value.
 * special cases that arise:
 * If the parameter is NaN or less than zero, the result is NaN.
 * If the argument is positive infinity, the result is positive infinity.
 * If the argument is positive zero or negative zero, the result is negative infinity.
 *
 * @param x some value.
 * @return \f$ \ln{x} \f$.
 *
 * @since 0.17.4
 *
 * @throws IllegalArgumentException if the argument `x` is not positive
 */
@Frozen
public func log(x: Float16): Float16 {
    return intrinsicLog<Float16>(x)
}

/**
 * Return the largest (closest to positive infinity) floating-point value that
 * less than or equal to the argument and is equal to a mathematical integer.
 *
 * @param x some value.
 * @return the largest (closest to positive infinity) floating-point value that
 * less than or equal to the argument and is equal to a mathematical integer.
 *
 * @since 0.17.4
 */
@Frozen
public func floor(x: Float64): Float64 {
    return intrinsicFloor<Float64>(x)
}

/**
 * Return the largest (closest to positive infinity) floating-point value that
 * less than or equal to the argument and is equal to a mathematical integer.
 *
 * @param x some value.
 * @return the largest (closest to positive infinity) floating-point value that
 * less than or equal to the argument and is equal to a mathematical integer.
 *
 * @since 0.17.4
 */
@Frozen
public func floor(x: Float32): Float32 {
    return intrinsicFloor<Float32>(x)
}

/**
 * Return the largest (closest to positive infinity) floating-point value that
 * less than or equal to the argument and is equal to a mathematical integer.
 *
 * @param x some value.
 * @return the largest (closest to positive infinity) floating-point value that
 * less than or equal to the argument and is equal to a mathematical integer.
 *
 * @since 0.17.4
 */
@Frozen
public func floor(x: Float16): Float16 {
    intrinsicFloor(x)
}

/**
 * Return the smallest (closest to negative infinity) floating-point value that
 * is greater than or equal to the argument and is equal to a mathematical integer.
 *
 * @param x some value.
 * @return the smallest (closest to negative infinity) floating-point value that
 * is greater than or equal to the argument and is equal to a mathematical integer.
 *
 * @since 0.17.4
 */
@Frozen
public func ceil(x: Float64): Float64 {
    return intrinsicCeil(x)
}

/**
 * Return the smallest (closest to negative infinity) floating-point value that
 * is greater than or equal to the argument and is equal to a mathematical integer.
 *
 * @param x some value.
 * @return the smallest (closest to negative infinity) floating-point value that
 * is greater than or equal to the argument and is equal to a mathematical integer.
 *
 * @since 0.17.4
 */
@Frozen
public func ceil(x: Float32): Float32 {
    return intrinsicCeil(x)
}

/**
 * Return the smallest (closest to negative infinity) floating-point value that
 * is greater than or equal to the argument and is equal to a mathematical integer.
 *
 * @param x some value.
 * @return the smallest (closest to negative infinity) floating-point value that
 * is greater than or equal to the argument and is equal to a mathematical integer.
 *
 * @since 0.17.4
 */
@Frozen
public func ceil(x: Float16): Float16 {
    return intrinsicCeil(x)
}

/**
 * Truncates the values after the decimal point.
 *
 * @param x some value.
 * @return the values after the decimal point is 0.
 *
 * @since 0.17.4
 */
@Frozen
public func trunc(x: Float64): Float64 {
    return intrinsicTrunc(x)
}

/**
 * Truncates the values after the decimal point.
 *
 * @param x some value.
 * @return the values after the decimal point is 0.
 *
 * @since 0.17.4
 */
@Frozen
public func trunc(x: Float32): Float32 {
    return intrinsicTrunc(x)
}

/**
 * Truncates the values after the decimal point.
 *
 * @param x some value.
 * @return the values after the decimal point is 0.
 *
 * @since 0.17.4
 */
@Frozen
public func trunc(x: Float16): Float16 {
    return intrinsicTrunc(x)
}

/********************* Trigonometric functions *********************/

/**
 * Returns the trigonometric sine of an angle.
 *
 * @param x an angle, in radians.
 * @return the sine of @p x.
 *
 * @since 0.17.4
 */
@Frozen
public func sin(x: Float64): Float64 {
    return intrinsicSin<Float64>(x)
}

/**
 * Returns the trigonometric sine of an angle.
 *
 * @param x an angle, in radians.
 * @return the sine of @p x.
 *
 * @since 0.17.4
 */
@Frozen
public func sin(x: Float32): Float32 {
    return intrinsicSin<Float32>(x)
}

/**
 * Returns the trigonometric sine of an angle.
 *
 * @param x an angle, in radians.
 * @return the sine of @p x.
 *
 * @since 0.17.4
 */
@Frozen
public func sin(x: Float16): Float16 {
    return intrinsicSin<Float16>(x)
}

/**
 * Returns the trigonometric cosine of an angle.
 *
 * @param x an angle, in radians.
 * @return the cosine of @p x.
 *
 * @since 0.17.4
 */
@Frozen
public func cos(x: Float64): Float64 {
    return intrinsicCos<Float64>(x)
}

/**
 * Returns the trigonometric cosine of an angle.
 *
 * @param x an angle, in radians.
 * @return the cosine of @p x.
 *
 * @since 0.17.4
 */
@Frozen
public func cos(x: Float32): Float32 {
    return intrinsicCos<Float32>(x)
}

/**
 * Returns the trigonometric cosine of an angle.
 *
 * @param x an angle, in radians.
 * @return the cosine of @p x.
 *
 * @since 0.17.4
 */
@Frozen
public func cos(x: Float16): Float16 {
    return intrinsicCos<Float16>(x)
}

/**
 * Returns the value of the first argument raised to the power of the second argument.
 * @param base the base.
 * @param exponent the exponent.
 * @return \f$ {base}^{exponent} \f$.
 *
 * @since 0.17.4
 */
@Frozen
public func pow(base: Float64, exponent: Float64): Float64 {
    return intrinsicPow<Float64>(base, exponent)
}

/**
 * Returns the value of the first argument raised to the power of the second argument.
 * @param base the base.
 * @param exponent the exponent.
 * @return \f$ {base}^{exponent} \f$.
 *
 * @since 0.17.4
 */
@Frozen
public func pow(base: Float32, exponent: Float32): Float32 {
    return intrinsicPow<Float32>(base, exponent)
}

/**
 * Returns the value of the first argument raised to the power of the second argument.
 * Note: Due to the lack of support from LLVM, Int64 calls cffi while Int32 can use intrinsicPowi.
 * @param base the base.
 * @param exponent the exponent.
 * @return \f$ {base}^{exponent} \f$.
 *
 * @since 0.17.4
 */
@Frozen
public func pow(base: Float64, exponent: Int64): Float64 {
    unsafe { return CJ_CORE_FastPowerDoubleInt64(base, exponent) }
}

/**
 * Returns the value of the first argument raised to the power of the second argument.
 * @param base the base.
 * @param exponent the exponent.
 * @return \f$ {base}^{exponent} \f$.
 *
 * @since 0.17.4
 */
@Frozen
public func pow(base: Float32, exponent: Int32): Float32 {
    return intrinsicPowi(base, exponent)
}
