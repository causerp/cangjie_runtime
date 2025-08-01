/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.overflow

@Intrinsic
func wrappingAdd<T>(x: T, y: T): T

@Intrinsic
func wrappingSub<T>(x: T, y: T): T

@Intrinsic
func wrappingMul<T>(x: T, y: T): T

@Intrinsic
func wrappingDiv<T>(x: T, y: T): T

@Intrinsic
func wrappingMod<T>(x: T, y: T): T

@Intrinsic
func wrappingPow(x: Int64, y: UInt64): Int64

@Intrinsic
func wrappingInc<T>(x: T): T

@Intrinsic
func wrappingDec<T>(x: T): T

@Intrinsic
func wrappingNeg<T>(x: T): T

public interface WrappingOp<T> {
    func wrappingAdd(y: T): T
    func wrappingSub(y: T): T
    func wrappingMul(y: T): T
    func wrappingDiv(y: T): T
    func wrappingMod(y: T): T
    func wrappingInc(): T
    func wrappingDec(): T
    func wrappingNeg(): T
    func wrappingShl(y: UInt64): T
    func wrappingShr(y: UInt64): T
}

public interface WrappingPow {
    func wrappingPow(y: UInt64): Int64
}

extend Int8 <: WrappingOp<Int8> {
    public func wrappingAdd(y: Int8): Int8 {
        wrappingAdd<Int8>(this, y)
    }
    public func wrappingSub(y: Int8): Int8 {
        wrappingSub<Int8>(this, y)
    }
    public func wrappingMul(y: Int8): Int8 {
        wrappingMul<Int8>(this, y)
    }
    public func wrappingDiv(y: Int8): Int8 {
        wrappingDiv<Int8>(this, y)
    }
    public func wrappingMod(y: Int8): Int8 {
        wrappingMod<Int8>(this, y)
    }
    public func wrappingInc(): Int8 {
        wrappingInc<Int8>(this)
    }
    public func wrappingDec(): Int8 {
        wrappingDec<Int8>(this)
    }
    public func wrappingNeg(): Int8 {
        wrappingNeg<Int8>(this)
    }

    @Frozen
    public func wrappingShl(y: UInt64): Int8 {
        if (y >= 8) {
            return this << (y & 0b111)
        } else {
            return this << y
        }
    }

    public func wrappingShr(y: UInt64): Int8 {
        if (y >= 8) {
            return this >> (y & 0b111)
        } else {
            return this >> y
        }
    }
}

extend Int16 <: WrappingOp<Int16> {
    public func wrappingAdd(y: Int16): Int16 {
        wrappingAdd<Int16>(this, y)
    }
    public func wrappingSub(y: Int16): Int16 {
        wrappingSub<Int16>(this, y)
    }
    public func wrappingMul(y: Int16): Int16 {
        wrappingMul<Int16>(this, y)
    }
    public func wrappingDiv(y: Int16): Int16 {
        wrappingDiv<Int16>(this, y)
    }
    public func wrappingMod(y: Int16): Int16 {
        wrappingMod<Int16>(this, y)
    }
    public func wrappingInc(): Int16 {
        wrappingInc<Int16>(this)
    }
    public func wrappingDec(): Int16 {
        wrappingDec<Int16>(this)
    }
    public func wrappingNeg(): Int16 {
        wrappingNeg<Int16>(this)
    }

    @Frozen
    public func wrappingShl(y: UInt64): Int16 {
        if (y >= 16) {
            return this << (y & 0b1111)
        } else {
            return this << y
        }
    }

    public func wrappingShr(y: UInt64): Int16 {
        if (y >= 16) {
            return this >> (y & 0b1111)
        } else {
            return this >> y
        }
    }
}

extend Int32 <: WrappingOp<Int32> {
    public func wrappingAdd(y: Int32): Int32 {
        wrappingAdd<Int32>(this, y)
    }
    public func wrappingSub(y: Int32): Int32 {
        wrappingSub<Int32>(this, y)
    }
    public func wrappingMul(y: Int32): Int32 {
        wrappingMul<Int32>(this, y)
    }
    public func wrappingDiv(y: Int32): Int32 {
        wrappingDiv<Int32>(this, y)
    }
    public func wrappingMod(y: Int32): Int32 {
        wrappingMod<Int32>(this, y)
    }
    public func wrappingInc(): Int32 {
        wrappingInc<Int32>(this)
    }
    public func wrappingDec(): Int32 {
        wrappingDec<Int32>(this)
    }
    public func wrappingNeg(): Int32 {
        wrappingNeg<Int32>(this)
    }

    @Frozen
    public func wrappingShl(y: UInt64): Int32 {
        if (y >= 32) {
            return this << (y & 0b11111)
        } else {
            return this << y
        }
    }

    public func wrappingShr(y: UInt64): Int32 {
        if (y >= 32) {
            return this >> (y & 0b11111)
        } else {
            return this >> y
        }
    }
}

extend Int64 <: WrappingOp<Int64> & WrappingPow {
    public func wrappingAdd(y: Int64): Int64 {
        wrappingAdd<Int64>(this, y)
    }
    public func wrappingSub(y: Int64): Int64 {
        wrappingSub<Int64>(this, y)
    }
    public func wrappingMul(y: Int64): Int64 {
        wrappingMul<Int64>(this, y)
    }
    public func wrappingDiv(y: Int64): Int64 {
        wrappingDiv<Int64>(this, y)
    }
    public func wrappingMod(y: Int64): Int64 {
        wrappingMod<Int64>(this, y)
    }
    public func wrappingPow(y: UInt64): Int64 {
        wrappingPow(this, y)
    }
    public func wrappingInc(): Int64 {
        wrappingInc<Int64>(this)
    }
    public func wrappingDec(): Int64 {
        wrappingDec<Int64>(this)
    }
    public func wrappingNeg(): Int64 {
        wrappingNeg<Int64>(this)
    }

    @Frozen
    public func wrappingShl(y: UInt64): Int64 {
        if (y >= 64) {
            return this << (y & 0b111111)
        } else {
            return this << y
        }
    }

    public func wrappingShr(y: UInt64): Int64 {
        if (y >= 64) {
            return this >> (y & 0b111111)
        } else {
            return this >> y
        }
    }
}

extend UInt8 <: WrappingOp<UInt8> {
    public func wrappingAdd(y: UInt8): UInt8 {
        wrappingAdd<UInt8>(this, y)
    }
    public func wrappingSub(y: UInt8): UInt8 {
        wrappingSub<UInt8>(this, y)
    }
    public func wrappingMul(y: UInt8): UInt8 {
        wrappingMul<UInt8>(this, y)
    }
    public func wrappingDiv(y: UInt8): UInt8 {
        wrappingDiv<UInt8>(this, y)
    }
    public func wrappingMod(y: UInt8): UInt8 {
        wrappingMod<UInt8>(this, y)
    }
    public func wrappingInc(): UInt8 {
        wrappingInc<UInt8>(this)
    }
    public func wrappingDec(): UInt8 {
        wrappingDec<UInt8>(this)
    }
    public func wrappingNeg(): UInt8 {
        wrappingNeg<UInt8>(this)
    }

    @Frozen
    public func wrappingShl(y: UInt64): UInt8 {
        if (y >= 8) {
            return this << (y & 0b111)
        } else {
            return this << y
        }
    }

    public func wrappingShr(y: UInt64): UInt8 {
        if (y >= 8) {
            return this >> (y & 0b111)
        } else {
            return this >> y
        }
    }
}

extend UInt16 <: WrappingOp<UInt16> {
    public func wrappingAdd(y: UInt16): UInt16 {
        wrappingAdd<UInt16>(this, y)
    }
    public func wrappingSub(y: UInt16): UInt16 {
        wrappingSub<UInt16>(this, y)
    }
    public func wrappingMul(y: UInt16): UInt16 {
        wrappingMul<UInt16>(this, y)
    }
    public func wrappingDiv(y: UInt16): UInt16 {
        wrappingDiv<UInt16>(this, y)
    }
    public func wrappingMod(y: UInt16): UInt16 {
        wrappingMod<UInt16>(this, y)
    }
    public func wrappingInc(): UInt16 {
        wrappingInc<UInt16>(this)
    }
    public func wrappingDec(): UInt16 {
        wrappingDec<UInt16>(this)
    }
    public func wrappingNeg(): UInt16 {
        wrappingNeg<UInt16>(this)
    }

    @Frozen
    public func wrappingShl(y: UInt64): UInt16 {
        if (y >= 16) {
            return this << (y & 0b1111)
        } else {
            return this << y
        }
    }

    public func wrappingShr(y: UInt64): UInt16 {
        if (y >= 16) {
            return this >> (y & 0b1111)
        } else {
            return this >> y
        }
    }
}

extend UInt32 <: WrappingOp<UInt32> {
    public func wrappingAdd(y: UInt32): UInt32 {
        wrappingAdd<UInt32>(this, y)
    }
    public func wrappingSub(y: UInt32): UInt32 {
        wrappingSub<UInt32>(this, y)
    }
    public func wrappingMul(y: UInt32): UInt32 {
        wrappingMul<UInt32>(this, y)
    }
    public func wrappingDiv(y: UInt32): UInt32 {
        wrappingDiv<UInt32>(this, y)
    }
    public func wrappingMod(y: UInt32): UInt32 {
        wrappingMod<UInt32>(this, y)
    }
    public func wrappingInc(): UInt32 {
        wrappingInc<UInt32>(this)
    }
    public func wrappingDec(): UInt32 {
        wrappingDec<UInt32>(this)
    }
    public func wrappingNeg(): UInt32 {
        wrappingNeg<UInt32>(this)
    }

    @Frozen
    public func wrappingShl(y: UInt64): UInt32 {
        if (y >= 32) {
            return this << (y & 0b11111)
        } else {
            return this << y
        }
    }

    public func wrappingShr(y: UInt64): UInt32 {
        if (y >= 32) {
            return this >> (y & 0b11111)
        } else {
            return this >> y
        }
    }
}

extend UInt64 <: WrappingOp<UInt64> {
    public func wrappingAdd(y: UInt64): UInt64 {
        wrappingAdd<UInt64>(this, y)
    }
    public func wrappingSub(y: UInt64): UInt64 {
        wrappingSub<UInt64>(this, y)
    }
    public func wrappingMul(y: UInt64): UInt64 {
        wrappingMul<UInt64>(this, y)
    }
    public func wrappingDiv(y: UInt64): UInt64 {
        wrappingDiv<UInt64>(this, y)
    }
    public func wrappingMod(y: UInt64): UInt64 {
        wrappingMod<UInt64>(this, y)
    }
    public func wrappingInc(): UInt64 {
        wrappingInc<UInt64>(this)
    }
    public func wrappingDec(): UInt64 {
        wrappingDec<UInt64>(this)
    }
    public func wrappingNeg(): UInt64 {
        wrappingNeg<UInt64>(this)
    }

    @Frozen
    public func wrappingShl(y: UInt64): UInt64 {
        if (y >= 64) {
            return this << (y & 0b111111)
        } else {
            return this << y
        }
    }

    public func wrappingShr(y: UInt64): UInt64 {
        if (y >= 64) {
            return this >> (y & 0b111111)
        } else {
            return this >> y
        }
    }
}

extend IntNative <: WrappingOp<IntNative> {
    public func wrappingAdd(y: IntNative): IntNative {
        wrappingAdd<IntNative>(this, y)
    }
    public func wrappingSub(y: IntNative): IntNative {
        wrappingSub<IntNative>(this, y)
    }
    public func wrappingMul(y: IntNative): IntNative {
        wrappingMul<IntNative>(this, y)
    }
    public func wrappingDiv(y: IntNative): IntNative {
        wrappingDiv<IntNative>(this, y)
    }
    public func wrappingMod(y: IntNative): IntNative {
        wrappingMod<IntNative>(this, y)
    }
    public func wrappingInc(): IntNative {
        wrappingInc<IntNative>(this)
    }
    public func wrappingDec(): IntNative {
        wrappingDec<IntNative>(this)
    }
    public func wrappingNeg(): IntNative {
        wrappingNeg<IntNative>(this)
    }

    @Frozen
    public func wrappingShl(y: UInt64): IntNative {
        if (isNative64) {
            if (y >= 64) {
                return this << (y & 0b111111)
            } else {
                return this << y
            }
        } else {
            if (y >= 32) {
                return this << (y & 0b11111)
            } else {
                return this << y
            }
        }
    }

    public func wrappingShr(y: UInt64): IntNative {
        if (isNative64) {
            if (y >= 64) {
                return this >> (y & 0b111111)
            } else {
                return this >> y
            }
        } else {
            if (y >= 32) {
                return this >> (y & 0b11111)
            } else {
                return this >> y
            }
        }
    }
}

extend UIntNative <: WrappingOp<UIntNative> {
    public func wrappingAdd(y: UIntNative): UIntNative {
        wrappingAdd<UIntNative>(this, y)
    }
    public func wrappingSub(y: UIntNative): UIntNative {
        wrappingSub<UIntNative>(this, y)
    }
    public func wrappingMul(y: UIntNative): UIntNative {
        wrappingMul<UIntNative>(this, y)
    }
    public func wrappingDiv(y: UIntNative): UIntNative {
        wrappingDiv<UIntNative>(this, y)
    }
    public func wrappingMod(y: UIntNative): UIntNative {
        wrappingMod<UIntNative>(this, y)
    }
    public func wrappingInc(): UIntNative {
        wrappingInc<UIntNative>(this)
    }
    public func wrappingDec(): UIntNative {
        wrappingDec<UIntNative>(this)
    }
    public func wrappingNeg(): UIntNative {
        wrappingNeg<UIntNative>(this)
    }

    @Frozen
    public func wrappingShl(y: UInt64): UIntNative {
        if (isNative64) {
            if (y >= 64) {
                return this << (y & 0b111111)
            } else {
                return this << y
            }
        } else {
            if (y >= 32) {
                return this << (y & 0b11111)
            } else {
                return this << y
            }
        }
    }

    public func wrappingShr(y: UInt64): UIntNative {
        if (isNative64) {
            if (y >= 64) {
                return this >> (y & 0b111111)
            } else {
                return this >> y
            }
        } else {
            if (y >= 32) {
                return this >> (y & 0b11111)
            } else {
                return this >> y
            }
        }
    }
}
