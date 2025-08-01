/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.overflow

@Intrinsic
func saturatingAdd<T>(x: T, y: T): T

@Intrinsic
func saturatingSub<T>(x: T, y: T): T

@Intrinsic
func saturatingMul<T>(x: T, y: T): T

@Intrinsic
func saturatingDiv<T>(x: T, y: T): T

@Intrinsic
func saturatingMod<T>(x: T, y: T): T

@Intrinsic
func saturatingPow(x: Int64, y: UInt64): Int64

@Intrinsic
func saturatingInc<T>(x: T): T

@Intrinsic
func saturatingNeg<T>(x: T): T

@Intrinsic
func saturatingDec<T>(x: T): T

public interface SaturatingOp<T> {
    func saturatingAdd(y: T): T

    func saturatingSub(y: T): T

    func saturatingMul(y: T): T

    func saturatingDiv(y: T): T

    func saturatingMod(y: T): T

    func saturatingInc(): T

    func saturatingDec(): T

    func saturatingNeg(): T

    func saturatingShl(y: UInt64): T
    func saturatingShr(y: UInt64): T
}

public interface SaturatingPow {
    func saturatingPow(y: UInt64): Int64
}

extend Int8 <: SaturatingOp<Int8> {
    public func saturatingAdd(y: Int8): Int8 {
        saturatingAdd<Int8>(this, y)
    }
    public func saturatingSub(y: Int8): Int8 {
        saturatingSub<Int8>(this, y)
    }
    public func saturatingMul(y: Int8): Int8 {
        saturatingMul<Int8>(this, y)
    }
    public func saturatingDiv(y: Int8): Int8 {
        saturatingDiv<Int8>(this, y)
    }
    public func saturatingMod(y: Int8): Int8 {
        saturatingMod<Int8>(this, y)
    }
    public func saturatingInc(): Int8 {
        saturatingInc<Int8>(this)
    }
    public func saturatingDec(): Int8 {
        saturatingDec<Int8>(this)
    }
    public func saturatingNeg(): Int8 {
        saturatingNeg<Int8>(this)
    }

    public func saturatingShl(y: UInt64): Int8 {
        if (y >= 8) {
            return this << 7
        }
        return this << y
    }

    public func saturatingShr(y: UInt64): Int8 {
        if (y >= 8) {
            return this >> 7
        }
        return this >> y
    }
}

extend Int16 <: SaturatingOp<Int16> {
    public func saturatingAdd(y: Int16): Int16 {
        saturatingAdd<Int16>(this, y)
    }
    public func saturatingSub(y: Int16): Int16 {
        saturatingSub<Int16>(this, y)
    }
    public func saturatingMul(y: Int16): Int16 {
        saturatingMul<Int16>(this, y)
    }
    public func saturatingDiv(y: Int16): Int16 {
        saturatingDiv<Int16>(this, y)
    }
    public func saturatingMod(y: Int16): Int16 {
        saturatingMod<Int16>(this, y)
    }
    public func saturatingInc(): Int16 {
        saturatingInc<Int16>(this)
    }
    public func saturatingDec(): Int16 {
        saturatingDec<Int16>(this)
    }
    public func saturatingNeg(): Int16 {
        saturatingNeg<Int16>(this)
    }

    public func saturatingShl(y: UInt64): Int16 {
        return if (y >= 16) {
            this << 15
        } else {
            this << y
        }
    }

    public func saturatingShr(y: UInt64): Int16 {
        return if (y >= 16) {
            this >> 15
        } else {
            this >> y
        }
    }
}

extend Int32 <: SaturatingOp<Int32> {
    public func saturatingAdd(y: Int32): Int32 {
        saturatingAdd<Int32>(this, y)
    }
    public func saturatingSub(y: Int32): Int32 {
        saturatingSub<Int32>(this, y)
    }
    public func saturatingMul(y: Int32): Int32 {
        saturatingMul<Int32>(this, y)
    }
    public func saturatingDiv(y: Int32): Int32 {
        saturatingDiv<Int32>(this, y)
    }
    public func saturatingMod(y: Int32): Int32 {
        saturatingMod<Int32>(this, y)
    }
    public func saturatingInc(): Int32 {
        saturatingInc<Int32>(this)
    }
    public func saturatingDec(): Int32 {
        saturatingDec<Int32>(this)
    }
    public func saturatingNeg(): Int32 {
        saturatingNeg<Int32>(this)
    }

    public func saturatingShl(y: UInt64): Int32 {
        return if (y >= 32) {
            this << 31
        } else {
            this << y
        }
    }

    public func saturatingShr(y: UInt64): Int32 {
        return if (y >= 32) {
            this >> 31
        } else {
            this >> y
        }
    }
}

extend Int64 <: SaturatingOp<Int64> & SaturatingPow {
    public func saturatingAdd(y: Int64): Int64 {
        saturatingAdd<Int64>(this, y)
    }
    public func saturatingSub(y: Int64): Int64 {
        saturatingSub<Int64>(this, y)
    }
    public func saturatingMul(y: Int64): Int64 {
        saturatingMul<Int64>(this, y)
    }
    public func saturatingDiv(y: Int64): Int64 {
        saturatingDiv<Int64>(this, y)
    }
    public func saturatingMod(y: Int64): Int64 {
        saturatingMod<Int64>(this, y)
    }
    public func saturatingPow(y: UInt64): Int64 {
        saturatingPow(this, y)
    }
    public func saturatingInc(): Int64 {
        saturatingInc<Int64>(this)
    }
    public func saturatingDec(): Int64 {
        saturatingDec<Int64>(this)
    }
    public func saturatingNeg(): Int64 {
        saturatingNeg<Int64>(this)
    }

    public func saturatingShl(y: UInt64): Int64 {
        return if (y >= 64) {
            this << 63
        } else {
            this << y
        }
    }

    public func saturatingShr(y: UInt64): Int64 {
        return if (y >= 64) {
            this >> 63
        } else {
            this >> y
        }
    }
}

extend UInt8 <: SaturatingOp<UInt8> {
    public func saturatingAdd(y: UInt8): UInt8 {
        saturatingAdd<UInt8>(this, y)
    }
    public func saturatingSub(y: UInt8): UInt8 {
        saturatingSub<UInt8>(this, y)
    }
    public func saturatingMul(y: UInt8): UInt8 {
        saturatingMul<UInt8>(this, y)
    }
    public func saturatingDiv(y: UInt8): UInt8 {
        saturatingDiv<UInt8>(this, y)
    }
    public func saturatingMod(y: UInt8): UInt8 {
        saturatingMod<UInt8>(this, y)
    }
    public func saturatingInc(): UInt8 {
        saturatingInc<UInt8>(this)
    }
    public func saturatingDec(): UInt8 {
        saturatingDec<UInt8>(this)
    }
    public func saturatingNeg(): UInt8 {
        saturatingNeg<UInt8>(this)
    }

    public func saturatingShl(y: UInt64): UInt8 {
        return if (y >= 8) {
            this << 7
        } else {
            this << y
        }
    }

    public func saturatingShr(y: UInt64): UInt8 {
        return if (y >= 8) {
            this >> 7
        } else {
            this >> y
        }
    }
}

extend UInt16 <: SaturatingOp<UInt16> {
    public func saturatingAdd(y: UInt16): UInt16 {
        saturatingAdd<UInt16>(this, y)
    }
    public func saturatingSub(y: UInt16): UInt16 {
        saturatingSub<UInt16>(this, y)
    }
    public func saturatingMul(y: UInt16): UInt16 {
        saturatingMul<UInt16>(this, y)
    }
    public func saturatingDiv(y: UInt16): UInt16 {
        saturatingDiv<UInt16>(this, y)
    }
    public func saturatingMod(y: UInt16): UInt16 {
        saturatingMod<UInt16>(this, y)
    }
    public func saturatingInc(): UInt16 {
        saturatingInc<UInt16>(this)
    }
    public func saturatingDec(): UInt16 {
        saturatingDec<UInt16>(this)
    }
    public func saturatingNeg(): UInt16 {
        saturatingNeg<UInt16>(this)
    }

    public func saturatingShl(y: UInt64): UInt16 {
        return if (y >= 16) {
            this << 15
        } else {
            this << y
        }
    }

    public func saturatingShr(y: UInt64): UInt16 {
        return if (y >= 16) {
            this >> 15
        } else {
            this >> y
        }
    }
}

extend UInt32 <: SaturatingOp<UInt32> {
    public func saturatingAdd(y: UInt32): UInt32 {
        saturatingAdd<UInt32>(this, y)
    }
    public func saturatingSub(y: UInt32): UInt32 {
        saturatingSub<UInt32>(this, y)
    }
    public func saturatingMul(y: UInt32): UInt32 {
        saturatingMul<UInt32>(this, y)
    }
    public func saturatingDiv(y: UInt32): UInt32 {
        saturatingDiv<UInt32>(this, y)
    }
    public func saturatingMod(y: UInt32): UInt32 {
        saturatingMod<UInt32>(this, y)
    }
    public func saturatingInc(): UInt32 {
        saturatingInc<UInt32>(this)
    }
    public func saturatingDec(): UInt32 {
        saturatingDec<UInt32>(this)
    }
    public func saturatingNeg(): UInt32 {
        saturatingNeg<UInt32>(this)
    }

    public func saturatingShl(y: UInt64): UInt32 {
        return if (y >= 32) {
            this << 31
        } else {
            this << y
        }
    }

    public func saturatingShr(y: UInt64): UInt32 {
        return if (y >= 32) {
            this >> 31
        } else {
            this >> y
        }
    }
}

extend UInt64 <: SaturatingOp<UInt64> {
    public func saturatingAdd(y: UInt64): UInt64 {
        saturatingAdd<UInt64>(this, y)
    }
    public func saturatingSub(y: UInt64): UInt64 {
        saturatingSub<UInt64>(this, y)
    }
    public func saturatingMul(y: UInt64): UInt64 {
        saturatingMul<UInt64>(this, y)
    }
    public func saturatingDiv(y: UInt64): UInt64 {
        saturatingDiv<UInt64>(this, y)
    }
    public func saturatingMod(y: UInt64): UInt64 {
        saturatingMod<UInt64>(this, y)
    }
    public func saturatingInc(): UInt64 {
        saturatingInc<UInt64>(this)
    }
    public func saturatingDec(): UInt64 {
        saturatingDec<UInt64>(this)
    }
    public func saturatingNeg(): UInt64 {
        saturatingNeg<UInt64>(this)
    }

    public func saturatingShl(y: UInt64): UInt64 {
        return if (y >= 64) {
            this << 63
        } else {
            this << y
        }
    }

    public func saturatingShr(y: UInt64): UInt64 {
        return if (y >= 64) {
            this >> 63
        } else {
            this >> y
        }
    }
}

extend IntNative <: SaturatingOp<IntNative> {
    public func saturatingAdd(y: IntNative): IntNative {
        saturatingAdd<IntNative>(this, y)
    }
    public func saturatingSub(y: IntNative): IntNative {
        saturatingSub<IntNative>(this, y)
    }
    public func saturatingMul(y: IntNative): IntNative {
        saturatingMul<IntNative>(this, y)
    }
    public func saturatingDiv(y: IntNative): IntNative {
        saturatingDiv<IntNative>(this, y)
    }
    public func saturatingMod(y: IntNative): IntNative {
        saturatingMod<IntNative>(this, y)
    }
    public func saturatingInc(): IntNative {
        saturatingInc<IntNative>(this)
    }
    public func saturatingDec(): IntNative {
        saturatingDec<IntNative>(this)
    }
    public func saturatingNeg(): IntNative {
        saturatingNeg<IntNative>(this)
    }

    public func saturatingShl(y: UInt64): IntNative {
        if (isNative64) {
            return if (y >= 64) {
                this << 63
            } else {
                this << y
            }
        }
        return if (y >= 32) {
            this << 31
        } else {
            this << y
        }
    }

    public func saturatingShr(y: UInt64): IntNative {
        if (isNative64) {
            return if (y >= 64) {
                this >> 63
            } else {
                this >> y
            }
        }
        return if (y >= 32) {
            this >> 31
        } else {
            this >> y
        }
    }
}

extend UIntNative <: SaturatingOp<UIntNative> {
    public func saturatingAdd(y: UIntNative): UIntNative {
        saturatingAdd<UIntNative>(this, y)
    }
    public func saturatingSub(y: UIntNative): UIntNative {
        saturatingSub<UIntNative>(this, y)
    }
    public func saturatingMul(y: UIntNative): UIntNative {
        saturatingMul<UIntNative>(this, y)
    }
    public func saturatingDiv(y: UIntNative): UIntNative {
        saturatingDiv<UIntNative>(this, y)
    }

    public func saturatingMod(y: UIntNative): UIntNative {
        saturatingMod<UIntNative>(this, y)
    }
    public func saturatingInc(): UIntNative {
        saturatingInc<UIntNative>(this)
    }
    public func saturatingDec(): UIntNative {
        saturatingDec<UIntNative>(this)
    }
    public func saturatingNeg(): UIntNative {
        saturatingNeg<UIntNative>(this)
    }

    public func saturatingShl(y: UInt64): UIntNative {
        if (isNative64) {
            return if (y >= 64) {
                this << 63
            } else {
                this << y
            }
        }
        return if (y >= 32) {
            this << 31
        } else {
            this << y
        }
    }

    public func saturatingShr(y: UInt64): UIntNative {
        if (isNative64) {
            return if (y >= 64) {
                this >> 63
            } else {
                this >> y
            }
        }
        return if (y >= 32) {
            this >> 31
        } else {
            this >> y
        }
    }
}
