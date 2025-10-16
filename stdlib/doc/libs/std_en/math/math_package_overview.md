# std.math

## Function Overview

The math package provides common mathematical operations, constant definitions, floating-point number handling, and other functionalities.

It includes the following capabilities:

1. Scientific constants and type constant definitions
2. Floating-point number judgment and normalization
3. Common bitwise operations
4. General mathematical functions such as absolute value, trigonometric functions, exponential and logarithmic calculations
5. Greatest common divisor and least common multiple

## API List

### Functions

| Function Name | Description |
| ------------ | ----------- |
| [abs(Float16)](./math_package_api/math_package_funcs.md#func-absfloat16) | Calculates the absolute value of a half-precision floating-point number. |
| [abs(Float32)](./math_package_api/math_package_funcs.md#func-absfloat32) | Calculates the absolute value of a single-precision floating-point number. |
| [abs(Float64)](./math_package_api/math_package_funcs.md#func-absfloat64) | Calculates the absolute value of a double-precision floating-point number. |
| [abs(Int16)](./math_package_api/math_package_funcs.md#func-absint16) | Calculates the absolute value of a 16-bit signed integer. |
| [abs(Int32)](./math_package_api/math_package_funcs.md#func-absint32) | Calculates the absolute value of a 32-bit signed integer. |
| [abs(Int64)](./math_package_api/math_package_funcs.md#func-absint64) | Calculates the absolute value of a 64-bit signed integer. |
| [abs(Int8)](./math_package_api/math_package_funcs.md#func-absint8) | Calculates the absolute value of an 8-bit signed integer. |
| [acos(Float16)](./math_package_api/math_package_funcs.md#func-acosfloat16) | Calculates the arccosine of a half-precision floating-point number in radians. |
| [acos(Float32)](./math_package_api/math_package_funcs.md#func-acosfloat32) | Calculates the arccosine of a single-precision floating-point number in radians. |
| [acos(Float64)](./math_package_api/math_package_funcs.md#func-acosfloat64) | Calculates the arccosine of a double-precision floating-point number in radians. |
| [acosh(Float16)](./math_package_api/math_package_funcs.md#func-acoshfloat16) | Calculates the inverse hyperbolic cosine of a half-precision floating-point number. |
| [acosh(Float32)](./math_package_api/math_package_funcs.md#func-acoshfloat32) | Calculates the inverse hyperbolic cosine of a single-precision floating-point number. |
| [acosh(Float64)](./math_package_api/math_package_funcs.md#func-acoshfloat64) | Calculates the inverse hyperbolic cosine of a double-precision floating-point number. |
| [asin(Float16)](./math_package_api/math_package_funcs.md#func-asinfloat16) | Calculates the arcsine of a half-precision floating-point number in radians. |
| [asin(Float32)](./math_package_api/math_package_funcs.md#func-asinfloat32) | Calculates the arcsine of a single-precision floating-point number in radians. |
| [asin(Float64)](./math_package_api/math_package_funcs.md#func-asinfloat64) | Calculates the arcsine of a double-precision floating-point number in radians. |
| [asinh(Float16)](./math_package_api/math_package_funcs.md#func-asinhfloat16) | Calculates the inverse hyperbolic sine of a half-precision floating-point number. |
| [asinh(Float32)](./math_package_api/math_package_funcs.md#func-asinhfloat32) | Calculates the inverse hyperbolic sine of a single-precision floating-point number. |
| [asinh(Float64)](./math_package_api/math_package_funcs.md#func-asinhfloat64) | Calculates the inverse hyperbolic sine of a double-precision floating-point number. |
| [atan(Float16)](./math_package_api/math_package_funcs.md#func-atanfloat16) | Calculates the arctangent of a half-precision floating-point number in radians. |
| [atan(Float32)](./math_package_api/math_package_funcs.md#func-atanfloat32) | Calculates the arctangent of a single-precision floating-point number in radians. |
| [atan(Float64)](./math_package_api/math_package_funcs.md#func-atanfloat64) | Calculates the arctangent of a double-precision floating-point number in radians. |
| [atan2(Float16, Float16)](./math_package_api/math_package_funcs.md#func-atan2float16-float16) | Calculates the arctangent of two half-precision floating-point numbers in radians. |
| [atan2(Float32, Float32)](./math_package_api/math_package_funcs.md#func-atan2float32-float32) | Calculates the arctangent of two single-precision floating-point numbers in radians. |
| [atan2(Float64, Float64)](./math_package_api/math_package_funcs.md#func-atan2float64-float64) | Calculates the arctangent of two double-precision floating-point numbers in radians. |
| [atanh(Float16)](./math_package_api/math_package_funcs.md#func-atanhfloat16) | Calculates the inverse hyperbolic tangent of a half-precision floating-point number. |
| [atanh(Float32)](./math_package_api/math_package_funcs.md#func-atanhfloat32) | Calculates the inverse hyperbolic tangent of a single-precision floating-point number. |
| [atanh(Float64)](./math_package_api/math_package_funcs.md#func-atanhfloat64) | Calculates the inverse hyperbolic tangent of a double-precision floating-point number. |
| [cbrt(Float16)](./math_package_api/math_package_funcs.md#func-cbrtfloat16) | Calculates the cube root of a half-precision floating-point number. |
| [cbrt(Float32)](./math_package_api/math_package_funcs.md#func-cbrtfloat32) | Calculates the cube root of a single-precision floating-point number. |
| [cbrt(Float64)](./math_package_api/math_package_funcs.md#func-cbrtfloat64) | Calculates the cube root of a double-precision floating-point number. |
| [ceil(Float16)](./math_package_api/math_package_funcs.md#func-ceilfloat16) | Rounds a half-precision floating-point number up to the nearest integer. |
| [ceil(Float32)](./math_package_api/math_package_funcs.md#func-ceilfloat32) | Rounds a single-precision floating-point number up to the nearest integer. |
| [ceil(Float64)](./math_package_api/math_package_funcs.md#func-ceilfloat64) | Rounds a double-precision floating-point number up to the nearest integer. |
| [checkedAbs(Int16)](./math_package_api/math_package_funcs.md#func-checkedabsint16) | Checks and calculates the absolute value of a 16-bit signed integer. Returns `None` if the input is the minimum value of a 16-bit signed integer; otherwise returns `Some(abs(x))`. |
| [checkedAbs(Int32)](./math_package_api/math_package_funcs.md#func-checkedabsint32) | Checks and calculates the absolute value of a 32-bit signed integer. Returns `None` if the input is the minimum value of a 32-bit signed integer; otherwise returns `Some(abs(x))`. |
| [checkedAbs(Int64)](./math_package_api/math_package_funcs.md#func-checkedabsint64) | Checks and calculates the absolute value of a 64-bit signed integer. Returns `None` if the input is the minimum value of a 64-bit signed integer; otherwise returns `Some(abs(x))`. |
| [checkedAbs(Int8)](./math_package_api/math_package_funcs.md#func-checkedabsint8) | Checks and calculates the absolute value of an 8-bit signed integer. Returns `None` if the input is the minimum value of an 8-bit signed integer; otherwise returns `Some(abs(x))`. |
| [clamp(Float16, Float16, Float16)](./math_package_api/math_package_funcs.md#func-clampfloat16-float16-float16) | Clamps a floating-point number within a specified range. Returns the number if it's within the range, the minimum value if below, the maximum value if above, or `NaN` if the input is `NaN`. |
| [clamp(Float32, Float32, Float32)](./math_package_api/math_package_funcs.md#func-clampfloat32-float32-float32) | Clamps a floating-point number within a specified range. Returns the number if it's within the range, the minimum value if below, the maximum value if above, or `NaN` if the input is `NaN`. |
| [clamp(Float64, Float64, Float64)](./math_package_api/math_package_funcs.md#func-clampfloat64-float64-float64) | Clamps a floating-point number within a specified range. Returns the number if it's within the range, the minimum value if below, the maximum value if above, or `NaN` if the input is `NaN`. |
| [cos(Float16)](./math_package_api/math_package_funcs.md#func-cosfloat16) | Calculates the cosine of a half-precision floating-point number (input in radians). |
| [cos(Float32)](./math_package_api/math_package_funcs.md#func-cosfloat32) | Calculates the cosine of a single-precision floating-point number (input in radians). |
| [cos(Float64)](./math_package_api/math_package_funcs.md#func-cosfloat64) | Calculates the cosine of a double-precision floating-point number (input in radians). |
| [cosh(Float16)](./math_package_api/math_package_funcs.md#func-coshfloat16) | Calculates the hyperbolic cosine of a half-precision floating-point number. |
| [cosh(Float32)](./math_package_api/math_package_funcs.md#func-coshfloat32) | Calculates the hyperbolic cosine of a single-precision floating-point number. |
| [cosh(Float64)](./math_package_api/math_package_funcs.md#func-coshfloat64) | Calculates the hyperbolic cosine of a double-precision floating-point number. |
| [countOne(Int16) <sup>(deprecated)</sup>](./math_package_api/math_package_funcs.md#func-countoneint16-deprecated) | Counts the number of 1 bits in the binary representation of a 16-bit integer. |
| [countOne(Int32) <sup>(deprecated)</sup>](./math_package_api/math_package_funcs.md#func-countoneint32-deprecated) | Counts the number of 1 bits in the binary representation of a 32-bit integer. |
| [countOne(Int64) <sup>(deprecated)</sup>](./math_package_api/math_package_funcs.md#func-countoneint64-deprecated) | Counts the number of 1 bits in the binary representation of a 64-bit integer. |
| [countOne(Int8) <sup>(deprecated)</sup>](./math_package_api/math_package_funcs.md#func-countoneint8-deprecated) | Counts the number of 1 bits in the binary representation of an 8-bit integer. |
| [countOne(UInt16) <sup>(deprecated)</sup>](./math_package_api/math_package_funcs.md#func-countoneuint16-deprecated) | Counts the number of 1 bits in the binary representation of a 16-bit unsigned integer. |
| [countOne(UInt32) <sup>(deprecated)</sup>](./math_package_api/math_package_funcs.md#func-countoneuint32-deprecated) | Counts the number of 1 bits in the binary representation of a 32-bit unsigned integer. |
| [countOne(UInt64) <sup>(deprecated)</sup>](./math_package_api/math_package_funcs.md#func-countoneuint64-deprecated) | Counts the number of 1 bits in the binary representation of a 64-bit unsigned integer. |
| [countOne(UInt8) <sup>(deprecated)</sup>](./math_package_api/math_package_funcs.md#func-countoneuint8-deprecated) | Counts the number of 1 bits in the binary representation of an 8-bit unsigned integer. |
| [countOnes(Int16)](./math_package_api/math_package_funcs.md#func-countonesint16) | Counts the number of 1 bits in the binary representation of a 16-bit integer. |
| [countOnes(Int32)](./math_package_api/math_package_funcs.md#func-countonesint32) | Counts the number of 1 bits in the binary representation of a 32-bit integer. |
| [countOnes(Int64)](./math_package_api/math_package_funcs.md#func-countonesint64) | Counts the number of 1 bits in the binary representation of a 64-bit integer. |
| [countOnes(Int8)](./math_package_api/math_package_funcs.md#func-countonesint8) | Counts the number of 1 bits in the binary representation of an 8-bit integer. |
| [countOnes(UInt16)](./math_package_api/math_package_funcs.md#func-countonesuint16) | Counts the number of 1 bits in the binary representation of a 16-bit unsigned integer. |
| [countOnes(UInt32)](./math_package_api/math_package_funcs.md#func-countonesuint32) | Counts the number of 1 bits in the binary representation of a 32-bit unsigned integer. |
| [countOnes(UInt64)](./math_package_api/math_package_funcs.md#func-countonesuint64) | Counts the number of 1 bits in the binary representation of a 64-bit unsigned integer. |
| [countOnes(UInt8)](./math_package_api/math_package_funcs.md#func-countonesuint8) | Counts the number of 1 bits in the binary representation of an 8-bit unsigned integer. |
| [erf(Float16)](./math_package_api/math_package_funcs.md#func-erffloat16) | Calculates the error function value of a half-precision floating-point number. |
| [erf(Float32)](./math_package_api/math_package_funcs.md#func-erffloat32) | Calculates the error function value of a single-precision floating-point number. |
| [erf(Float64)](./math_package_api/math_package_funcs.md#func-erffloat64) | Calculates the error function value of a double-precision floating-point number. |
| [exp(Float16)](./math_package_api/math_package_funcs.md#func-expfloat16) | Calculates e raised to the power of `x`. |
| [exp(Float32)](./math_package_api/math_package_funcs.md#func-expfloat32) | Calculates e raised to the power of `x`. |
| [exp(Float64)](./math_package_api/math_package_funcs.md#func-expfloat64) | Calculates e raised to the power of `x`. |
| [exp2(Float16)](./math_package_api/math_package_funcs.md#func-expfloat16) | Calculates 2 raised to the power of `x`. |
| [exp2(Float32)](./math_package_api/math_package_funcs.md#func-expfloat32) | Calculates 2 raised to the power of `x`. |
| [exp2(Float64)](./math_package_api/math_package_funcs.md#func-expfloat64) | Calculates 2 raised to the power of `x`. |
| [floor(Float16)](./math_package_api/math_package_funcs.md#func-floorfloat16) | Rounds a floating-point number down to the nearest integer. |
| [floor(Float32)](./math_package_api/math_package_funcs.md#func-floorfloat32) | Rounds a floating-point number down to the nearest integer. |
| [floor(Float64)](./math_package_api/math_package_funcs.md#func-floorfloat64) | Rounds a floating-point number down to the nearest integer. |
| [fmod(Float16, Float16)](./math_package_api/math_package_funcs.md#func-fmodfloat16-float16) | Calculates the remainder of dividing two half-precision floating-point numbers. |
| [fmod(Float32, Float32)](./math_package_api/math_package_funcs.md#func-fmodfloat32-float32) | Calculates the remainder of dividing two single-precision floating-point numbers. |
| [fmod(Float64, Float64)](./math_package_api/math_package_funcs.md#func-fmodfloat64-float64) | Calculates the remainder of dividing two double-precision floating-point numbers. |
| [gamma(Float16)](./math_package_api/math_package_funcs.md#func-gammafloat16) | Calculates the Gamma function value of a floating-point number. |
| [gamma(Float32)](./math_package_api/math_package_funcs.md#func-gammafloat32) | Calculates the Gamma function value of a floating-point number. |
| [gamma(Float64)](./math_package_api/math_package_funcs.md#func-gammafloat64) | Calculates the Gamma function value of a floating-point number. |
| [gcd(Int16, Int16)](./math_package_api/math_package_funcs.md#func-gcdint16-int16) | Calculates the greatest common divisor of two 16-bit signed integers. |
| [
| [rotate(UInt32, Int8)](./math_package_api/math_package_funcs.md#func-rotateuint32-int8) | Computes the result of bitwise rotation for an integer. |
| [rotate(UInt64, Int8)](./math_package_api/math_package_funcs.md#func-rotateuint64-int8) | Computes the result of bitwise rotation for an integer. |
| [rotate(UInt8, Int8)](./math_package_api/math_package_funcs.md#func-rotateuint8-int8) | Computes the result of bitwise rotation for an integer. |
| [round(Float16)](./math_package_api/math_package_funcs.md#func-roundfloat16) | This function computes the rounded value of a floating-point number using IEEE-754 round-to-nearest rules. |
| [round(Float32)](./math_package_api/math_package_funcs.md#func-roundfloat32) | This function computes the rounded value of a floating-point number using IEEE-754 round-to-nearest rules. |
| [round(Float64)](./math_package_api/math_package_funcs.md#func-roundfloat64) | This function computes the rounded value of a floating-point number using IEEE-754 round-to-nearest rules. |
| [sin(Float16)](./math_package_api/math_package_funcs.md#func-sinfloat16) | Computes the sine function value for a half-precision floating-point number (input in radians). |
| [sin(FFloat32)](./math_package_api/math_package_funcs.md#func-sinfloat32) | Computes the sine function value for a single-precision floating-point number (input in radians). |
| [sin(Float64)](./math_package_api/math_package_funcs.md#func-sinfloat64) | Computes the sine function value for a double-precision floating-point number (input in radians). |
| [sinh(Float16)](./math_package_api/math_package_funcs.md#func-sinhfloat16) | Computes the hyperbolic sine function value for a half-precision floating-point number. |
| [sinh(Float32)](./math_package_api/math_package_funcs.md#func-sinhfloat32) | Computes the hyperbolic sine function value for a single-precision floating-point number. |
| [sinh(Float64)](./math_package_api/math_package_funcs.md#func-sinhfloat64) | Computes the hyperbolic sine function value for a double-precision floating-point number. |
| [sqrt(Float16)](./math_package_api/math_package_funcs.md#func-sqrtfloat16) | Computes the arithmetic square root of a floating-point number. |
| [sqrt(Float32)](./math_package_api/math_package_funcs.md#func-sqrtfloat32) | Computes the arithmetic square root of a floating-point number. |
| [sqrt(Float64)](./math_package_api/math_package_funcs.md#func-sqrtfloat64) | Computes the arithmetic square root of a floating-point number. |
| [tan(Float16)](./math_package_api/math_package_funcs.md#func-tanfloat16) | Computes the tangent function value for a half-precision floating-point number (input in radians). |
| [tan(Float32)](./math_package_api/math_package_funcs.md#func-tanfloat32) | Computes the tangent function value for a single-precision floating-point number (input in radians). |
| [tan(Float64)](./math_package_api/math_package_funcs.md#func-tanfloat64) | Computes the tangent function value for a double-precision floating-point number (input in radians). |
| [tanh(Float16)](./math_package_api/math_package_funcs.md#func-tanhfloat16) | Computes the hyperbolic tangent function value for a half-precision floating-point number. |
| [tanh(Float32)](./math_package_api/math_package_funcs.md#func-tanhfloat32) | Computes the hyperbolic tangent function value for a single-precision floating-point number. |
| [tanh(Float64)](./math_package_api/math_package_funcs.md#func-tanhfloat64) | Computes the hyperbolic tangent function value for a double-precision floating-point number. |
| [trailingZeros(Int16)](./math_package_api/math_package_funcs.md#func-trailingzerosint16) | Counts the number of consecutive least significant bits set to 0 in the binary representation of a 16-bit signed integer. Returns 0 if the least significant bit is not 0. |
| [trailingZeros(Int32)](./math_package_api/math_package_funcs.md#func-trailingzerosint32) | Counts the number of consecutive least significant bits set to 0 in the binary representation of a 32-bit signed integer. Returns 0 if the least significant bit is not 0. |
| [trailingZeros(Int64)](./math_package_api/math_package_funcs.md#func-trailingzerosint64) | Counts the number of consecutive least significant bits set to 0 in the binary representation of a 64-bit signed integer. Returns 0 if the least significant bit is not 0. |
| [trailingZeros(Int8)](./math_package_api/math_package_funcs.md#func-trailingzerosint8) | Counts the number of consecutive least significant bits set to 0 in the binary representation of an 8-bit signed integer. Returns 0 if the least significant bit is not 0. |
| [trailingZeros(UInt16)](./math_package_api/math_package_funcs.md#func-trailingzerosuint16) | Counts the number of consecutive least significant bits set to 0 in the binary representation of a 16-bit unsigned integer. Returns 0 if the least significant bit is not 0. |
| [trailingZeros(UInt32)](./math_package_api/math_package_funcs.md#func-trailingzerosuint32) | Counts the number of consecutive least significant bits set to 0 in the binary representation of a 32-bit unsigned integer. Returns 0 if the least significant bit is not 0. |
| [trailingZeros(UInt64)](./math_package_api/math_package_funcs.md#func-trailingzerosuint64) | Counts the number of consecutive least significant bits set to 0 in the binary representation of a 64-bit unsigned integer. Returns 0 if the least significant bit is not 0. |
| [trailingZeros(UInt8)](./math_package_api/math_package_funcs.md#func-trailingzerosuint8) | Counts the number of consecutive least significant bits set to 0 in the binary representation of an 8-bit unsigned integer. Returns 0 if the least significant bit is not 0. |
| [trunc(Float16)](./math_package_api/math_package_funcs.md#func-truncfloat16) | Computes the truncated integer value of a floating-point number. |
| [trunc(Float32)](./math_package_api/math_package_funcs.md#func-truncfloat32) | Computes the truncated integer value of a floating-point number. |
| [trunc(Float64)](./math_package_api/math_package_funcs.md#func-truncfloat64) | Computes the truncated integer value of a floating-point number. |

### Interfaces

| Interface | Functionality |
| ------------ | ------------ |
| [FloatingPoint\<T>](./math_package_api/math_package_interfaces.md#interface-floatingpointt)| Provides methods related to floating-point numbers. |
| [Integer\<T>](./math_package_api/math_package_interfaces.md#interface-integert)| Provides methods related to integer types. |
| [MathExtension <sup>(deprecated)</sup>](./math_package_api/math_package_interfaces.md#interface-mathextensiont-deprecated)| Auxiliary interface for exporting properties (PI and E constants for floating-point numbers). |
| [MaxMinValue\<T>](./math_package_api/math_package_interfaces.md#interface-maxminvaluet)| Provides methods to obtain maximum and minimum values. |
| [Number\<T>](./math_package_api/math_package_interfaces.md#interface-numbert)| Provides methods related to numeric types. |

### Enums

| Enum | Functionality |
| --------------------------------- | ---------------------------------- |
| [RoundingMode](./math_package_api/math_package_enums.md#enum-roundingmode) | Enumeration class for rounding modes, including 6 rounding rules. In addition to the 5 IEEE 754 standard rounding modes, it provides the commonly used "round half up" rule. |