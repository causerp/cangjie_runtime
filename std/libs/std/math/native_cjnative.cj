/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.math

/**
 * Intrinsic Function.
 */

// Floating-point
@Intrinsic
func intrinsicSin<T>(x: T): T

@Intrinsic
func intrinsicCos<T>(x: T): T

@Intrinsic
func intrinsicExp<T>(x: T): T

@Intrinsic
func intrinsicExp2<T>(x: T): T

@Intrinsic
func intrinsicLog<T>(x: T): T

@Intrinsic
func intrinsicLog2<T>(x: T): T

@Intrinsic
func intrinsicLog10<T>(x: T): T

@Intrinsic
func intrinsicSqrt<T>(x: T): T

@Intrinsic
func intrinsicFloor<T>(x: T): T

@Intrinsic
func intrinsicCeil<T>(x: T): T

@Intrinsic
func intrinsicTrunc<T>(x: T): T

@Intrinsic
func intrinsicRound<T>(x: T): T

@Intrinsic
func intrinsicFabs<T>(x: T): T
// Integer
@Intrinsic
func intrinsicAbs<T>(x: T): T
// Pow
@Intrinsic
func intrinsicPow<T>(x: T, y: T): T

@Intrinsic
func intrinsicPowi(x: Float32, y: Int32): Float32
