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

@Deprecated[message: "Use `public interface FloatingPoint<T>` instead."]
public interface MathExtension<T> {
    static func GetPI(): T
    static func GetE(): T
}

public interface MaxMinValue<T> {
    static func getMax(): T
    static func getMin(): T
}

public interface Number<T> {
    operator func +(rhs: T): T
    operator func -(rhs: T): T
    operator func *(rhs: T): T
    operator func /(rhs: T): T
    operator func -(): T
}

public interface Integer<T> <: Number<T> {
    static func isSigned(): Bool

    operator func %(rhs: T): T
    operator func &(rhs: T): T
    operator func |(rhs: T): T
    operator func ^(rhs: T): T
    operator func !(): T
    operator func >>(n: Int64): T
    operator func <<(n: Int64): T
}

public interface FloatingPoint<T> <: Number<T> {
    static func getPI(): T
    static func getE(): T
    static func getNaN(): T
    static func getInf(): T
    static func getMinDenormal(): T
    static func getMinNormal(): T

    func isInf(): Bool
    func isNaN(): Bool
    func isNormal(): Bool
}
