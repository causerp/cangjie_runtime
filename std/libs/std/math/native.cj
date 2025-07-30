/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.math

@FastNative
foreign func CJ_CORE_FastPowerDoubleInt64(x: Float64, y: Int64): Float64

/**
 * libc functions wrapper functions.
 * these wrappers are mainly used to avoid name 'pollution' to the current namespace.
 * for now, native functions can only reside in top level, thus can not be put into a namespace construct
 */
@FastNative
foreign func CJ_MATH_Tan(x: Float64): Float64

@FastNative
foreign func CJ_MATH_Tanf(x: Float32): Float32

@FastNative
foreign func CJ_MATH_Asin(x: Float64): Float64

@FastNative
foreign func CJ_MATH_Asinf(x: Float32): Float32

@FastNative
foreign func CJ_MATH_Acos(x: Float64): Float64

@FastNative
foreign func CJ_MATH_Acosf(x: Float32): Float32

@FastNative
foreign func CJ_MATH_Atan(x: Float64): Float64

@FastNative
foreign func CJ_MATH_Atanf(x: Float32): Float32

@FastNative
foreign func CJ_MATH_Atan2(y: Float64, x: Float64): Float64

@FastNative
foreign func CJ_MATH_Atan2f(y: Float32, x: Float32): Float32

@FastNative
foreign func CJ_MATH_Sinh(x: Float64): Float64

@FastNative
foreign func CJ_MATH_Sinhf(x: Float32): Float32

@FastNative
foreign func CJ_MATH_Cosh(x: Float64): Float64

@FastNative
foreign func CJ_MATH_Coshf(x: Float32): Float32

@FastNative
foreign func CJ_MATH_Tanh(x: Float64): Float64

@FastNative
foreign func CJ_MATH_Tanhf(x: Float32): Float32

@FastNative
foreign func CJ_MATH_Asinh(x: Float64): Float64

@FastNative
foreign func CJ_MATH_Asinhf(x: Float32): Float32

@FastNative
foreign func CJ_MATH_Acosh(x: Float64): Float64

@FastNative
foreign func CJ_MATH_Acoshf(x: Float32): Float32

@FastNative
foreign func CJ_MATH_Atanh(x: Float64): Float64

@FastNative
foreign func CJ_MATH_Atanhf(x: Float32): Float32

@FastNative
foreign func CJ_MATH_Cbrt(x: Float64): Float64

@FastNative
foreign func CJ_MATH_Cbrtf(x: Float32): Float32

@FastNative
foreign func CJ_MATH_Tgamma(x: Float64): Float64

@FastNative
foreign func CJ_MATH_Tgammaf(x: Float32): Float32

@FastNative
foreign func CJ_MATH_Erf(x: Float64): Float64

@FastNative
foreign func CJ_MATH_Erff(x: Float32): Float32

@FastNative
foreign func CJ_MATH_Fmod(x: Float64, y: Float64): Float64

@FastNative
foreign func CJ_MATH_Fmodf(x: Float32, y: Float32): Float32
