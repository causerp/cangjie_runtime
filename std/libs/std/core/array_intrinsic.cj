/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.core

/**
 * RawArray intrinsic functions.
 */
@Intrinsic
func acquireRawData<T>(rawArr: RawArray<T>): CPointer<T> where T <: CType

@Intrinsic
func releaseRawData<T>(rawArr: RawArray<T>, ptr: CPointer<T>): Unit where T <: CType

@Intrinsic
func intrinsicBuiltInCopyTo<T>(src: RawArray<T>, dst: RawArray<T>, srcStart: Int64, dstStart: Int64, copyLen: Int64): Unit

@Intrinsic
func arrayGet<T>(rawArr: RawArray<T>, index: Int64): T

@Intrinsic
func arraySet<T>(rawArr: RawArray<T>, index: Int64, element: T): Unit

@Intrinsic
func arrayGetUnchecked<T>(rawArr: RawArray<T>, index: Int64): T

@Intrinsic
func arraySetUnchecked<T>(rawArr: RawArray<T>, index: Int64, element: T): Unit

@Intrinsic
func arraySize<T>(rawArr: RawArray<T>): Int64

@Intrinsic
func arrayClone<T>(rawArr: RawArray<T>): RawArray<T>
