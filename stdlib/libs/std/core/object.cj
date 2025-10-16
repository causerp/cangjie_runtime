/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.core

public interface Any {}

public open class Object <: Any {
    public const init() {}
}

/**
 * Check whether two Objects are referencing to the same memory block
 *
 * @return true means they are the same Object.
 *
 * @since 0.21.4
 */
public func refEq(a: Object, b: Object): Bool {
    return intrinsicRefEq(a, b)
}

// This function is only used by ArrayList type, and it is not intended to be documented in users' guide
@Intrinsic
public unsafe func zeroValue<T>(): T

@Intrinsic
func intrinsicRefEq(a: Object, b: Object): Bool

@When[backend == "cjnative"]
@Intrinsic
func intrinsicRefEqRawArray<T>(a: RawArray<T>, b: RawArray<T>): Bool
