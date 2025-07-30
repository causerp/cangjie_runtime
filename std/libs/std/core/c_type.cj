/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.core

// All types which can be used in C FFI implicitly implement the interface,
// including Int8, UInt8, Int16, UInt16, Int32, UInt32, Int64, UInt64, IntNative, UIntNative,
// Float32, Float64, Bool, Unit, and all @C-modified structs.
sealed interface CType {}
