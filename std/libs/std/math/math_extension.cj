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

extend Float64 <: MathExtension<Float64> {
    @Deprecated[message: "Use `public func getPI()` instead."]
    public static func GetPI(): Float64 {
        return 3.141592653589793
    }

    @Deprecated[message: "Use `public func getE()` instead."]
    public static func GetE(): Float64 {
        return 2.718281828459045
    }
}

extend Float32 <: MathExtension<Float32> {
    @Deprecated[message: "Use `public func getPI()` instead."]
    public static func GetPI(): Float32 {
        return 3.1415927
    }

    @Deprecated[message: "Use `public func getE()` instead."]
    public static func GetE(): Float32 {
        return 2.7182817
    }
}

extend Float16 <: MathExtension<Float16> {
    @Deprecated[message: "Use `public func getPI()` instead."]
    public static func GetPI(): Float16 {
        return 3.140625
    }

    @Deprecated[message: "Use `public func getE()` instead."]
    public static func GetE(): Float16 {
        return 2.718750
    }
}

/******************************** extend MaxMinValue<T> *********************************/

extend Int8 <: MaxMinValue<Int8> {
    public static func getMax(): Int8 {
        Int8.Max
    }
    public static func getMin(): Int8 {
        Int8.Min
    }
}

extend Int16 <: MaxMinValue<Int16> {
    public static func getMax(): Int16 {
        Int16.Max
    }
    public static func getMin(): Int16 {
        Int16.Min
    }
}

extend Int32 <: MaxMinValue<Int32> {
    public static func getMax(): Int32 {
        Int32.Max
    }
    public static func getMin(): Int32 {
        Int32.Min
    }
}

extend Int64 <: MaxMinValue<Int64> {
    public static func getMax(): Int64 {
        Int64.Max
    }
    public static func getMin(): Int64 {
        Int64.Min
    }
}

extend IntNative <: MaxMinValue<IntNative> {
    public static func getMax(): IntNative {
        IntNative.Max
    }
    public static func getMin(): IntNative {
        IntNative.Min
    }
}

extend UInt8 <: MaxMinValue<UInt8> {
    public static func getMax(): UInt8 {
        UInt8.Max
    }
    public static func getMin(): UInt8 {
        UInt8.Min
    }
}

extend UInt16 <: MaxMinValue<UInt16> {
    public static func getMax(): UInt16 {
        UInt16.Max
    }
    public static func getMin(): UInt16 {
        UInt16.Min
    }
}

extend UInt32 <: MaxMinValue<UInt32> {
    public static func getMax(): UInt32 {
        UInt32.Max
    }
    public static func getMin(): UInt32 {
        UInt32.Min
    }
}

extend UInt64 <: MaxMinValue<UInt64> {
    public static func getMax(): UInt64 {
        UInt64.Max
    }
    public static func getMin(): UInt64 {
        UInt64.Min
    }
}

extend UIntNative <: MaxMinValue<UIntNative> {
    public static func getMax(): UIntNative {
        UIntNative.Max
    }
    public static func getMin(): UIntNative {
        UIntNative.Min
    }
}

extend Float16 <: MaxMinValue<Float16> {
    public static func getMax(): Float16 {
        Float16.Max
    }
    public static func getMin(): Float16 {
        Float16.Min
    }
}

extend Float32 <: MaxMinValue<Float32> {
    public static func getMax(): Float32 {
        Float32.Max
    }
    public static func getMin(): Float32 {
        Float32.Min
    }
}

extend Float64 <: MaxMinValue<Float64> {
    public static func getMax(): Float64 {
        Float64.Max
    }
    public static func getMin(): Float64 {
        Float64.Min
    }
}

/******************************** extend Number<T> *********************************/

extend Int8 <: Number<Int8> {}

extend Int16 <: Number<Int16> {}

extend Int32 <: Number<Int32> {}

extend Int64 <: Number<Int64> {}

extend IntNative <: Number<IntNative> {}

extend UInt8 <: Number<UInt8> {}

extend UInt16 <: Number<UInt16> {}

extend UInt32 <: Number<UInt32> {}

extend UInt64 <: Number<UInt64> {}

extend UIntNative <: Number<UIntNative> {}

extend Float16 <: Number<Float16> {}

extend Float32 <: Number<Float32> {}

extend Float64 <: Number<Float64> {}

/******************************* extend Integer<T> *********************************/

extend Int8 <: Integer<Int8> {
    public static func isSigned(): Bool {
        true
    }
}

extend Int16 <: Integer<Int16> {
    public static func isSigned(): Bool {
        true
    }
}

extend Int32 <: Integer<Int32> {
    public static func isSigned(): Bool {
        true
    }
}

extend Int64 <: Integer<Int64> {
    public static func isSigned(): Bool {
        true
    }
}

extend IntNative <: Integer<IntNative> {
    public static func isSigned(): Bool {
        true
    }
}

extend UInt8 <: Integer<UInt8> {
    public static func isSigned(): Bool {
        false
    }
}

extend UInt16 <: Integer<UInt16> {
    public static func isSigned(): Bool {
        false
    }
}

extend UInt32 <: Integer<UInt32> {
    public static func isSigned(): Bool {
        false
    }
}

extend UInt64 <: Integer<UInt64> {
    public static func isSigned(): Bool {
        false
    }
}

extend UIntNative <: Integer<UIntNative> {
    public static func isSigned(): Bool {
        false
    }
}

/******************************** extend FloatingPoint<T> *********************************/

extend Float16 <: FloatingPoint<Float16> {
    public static func getPI(): Float16 {
        3.140625
    }
    public static func getE(): Float16 {
        2.718750
    }
    public static func getNaN(): Float16 {
        Float16.NaN
    }
    public static func getInf(): Float16 {
        Float16.Inf
    }
    public static func getMinDenormal(): Float16 {
        Float16.MinDenormal
    }
    public static func getMinNormal(): Float16 {
        Float16.MinNormal
    }
}

extend Float32 <: FloatingPoint<Float32> {
    public static func getPI(): Float32 {
        3.1415927
    }
    public static func getE(): Float32 {
        2.7182817
    }
    public static func getNaN(): Float32 {
        Float32.NaN
    }
    public static func getInf(): Float32 {
        Float32.Inf
    }
    public static func getMinDenormal(): Float32 {
        Float32.MinDenormal
    }
    public static func getMinNormal(): Float32 {
        Float32.MinNormal
    }
}

extend Float64 <: FloatingPoint<Float64> {
    public static func getPI(): Float64 {
        3.141592653589793
    }
    public static func getE(): Float64 {
        2.718281828459045
    }
    public static func getNaN(): Float64 {
        Float64.NaN
    }
    public static func getInf(): Float64 {
        Float64.Inf
    }
    public static func getMinDenormal(): Float64 {
        Float64.MinDenormal
    }
    public static func getMinNormal(): Float64 {
        Float64.MinNormal
    }
}
