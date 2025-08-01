/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.overflow

@Intrinsic
func throwingAdd<T>(x: T, y: T): T

@Intrinsic
func throwingSub<T>(x: T, y: T): T

@Intrinsic
func throwingMul<T>(x: T, y: T): T

@Intrinsic
func throwingDiv<T>(x: T, y: T): T

@Intrinsic
func throwingMod<T>(x: T, y: T): T

@Intrinsic
func throwingPow(x: Int64, y: UInt64): Int64

@Intrinsic
func throwingInc<T>(x: T): T

@Intrinsic
func throwingDec<T>(x: T): T

@Intrinsic
func throwingNeg<T>(x: T): T

public interface ThrowingOp<T> {

    /*
     * @throws OverflowException if the add operation overflows
     */
    func throwingAdd(y: T): T

    /*
     * @throws OverflowException if the subtraction operation overflows
     */
    func throwingSub(y: T): T

    /*
     * @throws OverflowException if the multiplication operation overflows
     */
    func throwingMul(y: T): T

    /*
     * @throws OverflowException if the division operation overflows
     */
    func throwingDiv(y: T): T

    /*
     * @throws OverflowException if the modulo operation overflows
     */
    func throwingMod(y: T): T

    /*
     * @throws OverflowException if the increase operation overflows
     */
    func throwingInc(): T

    /*
     * @throws OverflowException if the decrease operation overflows
     */
    func throwingDec(): T

    /*
     * @throws OverflowException if the negative operation overflows
     */
    func throwingNeg(): T

    /*
     * @throws OverflowException if The right operand is greater than or equal to the number of bits of the type of the left operand, or the right operand is negative.
     */
    func throwingShl(y: UInt64): T

    /*
     * @throws OverflowException if The right operand is greater than or equal to the number of bits of the type of the left operand, or the right operand is negative.
     */
    func throwingShr(y: UInt64): T
}

public interface ThrowingPow {
    func throwingPow(y: UInt64): Int64
}

extend Int8 <: ThrowingOp<Int8> {

    /*
     * @throws OverflowException if the add operation overflows
     */
    public func throwingAdd(y: Int8): Int8 {
        throwingAdd<Int8>(this, y)
    }

    /*
     * @throws OverflowException if the subtraction operation overflows
     */
    public func throwingSub(y: Int8): Int8 {
        throwingSub<Int8>(this, y)
    }

    /*
     * @throws OverflowException if the multiplication operation overflows
     */
    public func throwingMul(y: Int8): Int8 {
        throwingMul<Int8>(this, y)
    }

    /*
     * @throws OverflowException if the division operation overflows
     */
    public func throwingDiv(y: Int8): Int8 {
        throwingDiv<Int8>(this, y)
    }

    /*
     * @throws OverflowException if the modulo operation overflows
     */
    public func throwingMod(y: Int8): Int8 {
        throwingMod<Int8>(this, y)
    }

    /*
     * @throws OverflowException if the increase operation overflows
     */
    public func throwingInc(): Int8 {
        throwingInc<Int8>(this)
    }

    /*
     * @throws OverflowException if the decrease operation overflows
     */
    public func throwingDec(): Int8 {
        throwingDec<Int8>(this)
    }

    /*
     * @throws OverflowException if the negative operation overflows
     */
    public func throwingNeg(): Int8 {
        throwingNeg<Int8>(this)
    }

    public func throwingShl(y: UInt64): Int8 {
        if (y >= 8) {
            throw OvershiftException("The right operand must be less than the number of bits in the left operand.")
        }
        this << y
    }

    public func throwingShr(y: UInt64): Int8 {
        if (y >= 8) {
            throw OvershiftException("The right operand must be less than the number of bits in the left operand.")
        }
        this >> y
    }
}

extend Int16 <: ThrowingOp<Int16> {

    /*
     * @throws OverflowException if the add operation overflows
     */
    public func throwingAdd(y: Int16): Int16 {
        throwingAdd<Int16>(this, y)
    }

    /*
     * @throws OverflowException if the subtraction operation overflows
     */
    public func throwingSub(y: Int16): Int16 {
        throwingSub<Int16>(this, y)
    }

    /*
     * @throws OverflowException if the multiplication operation overflows
     */
    public func throwingMul(y: Int16): Int16 {
        throwingMul<Int16>(this, y)
    }

    /*
     * @throws OverflowException if the division operation overflows
     */
    public func throwingDiv(y: Int16): Int16 {
        throwingDiv<Int16>(this, y)
    }

    /*
     * @throws OverflowException if the modulo operation overflows
     */
    public func throwingMod(y: Int16): Int16 {
        throwingMod<Int16>(this, y)
    }

    /*
     * @throws OverflowException if the increase operation overflows
     */
    public func throwingInc(): Int16 {
        throwingInc<Int16>(this)
    }

    /*
     * @throws OverflowException if the decrease operation overflows
     */
    public func throwingDec(): Int16 {
        throwingDec<Int16>(this)
    }

    /*
     * @throws OverflowException if the negative operation overflows
     */
    public func throwingNeg(): Int16 {
        throwingNeg<Int16>(this)
    }

    public func throwingShl(y: UInt64): Int16 {
        if (y >= 16) {
            throw OvershiftException("The right operand must be less than the number of bits in the left operand.")
        } else {
            return this << y
        }
    }

    public func throwingShr(y: UInt64): Int16 {
        if (y >= 16) {
            throw OvershiftException("The right operand must be less than the number of bits in the left operand.")
        } else {
            return this >> y
        }
    }
}

extend Int32 <: ThrowingOp<Int32> {

    /*
     * @throws OverflowException if the add operation overflows
     */
    public func throwingAdd(y: Int32): Int32 {
        throwingAdd<Int32>(this, y)
    }

    /*
     * @throws OverflowException if the subtraction operation overflows
     */
    public func throwingSub(y: Int32): Int32 {
        throwingSub<Int32>(this, y)
    }

    /*
     * @throws OverflowException if the multiplication operation overflows
     */
    public func throwingMul(y: Int32): Int32 {
        throwingMul<Int32>(this, y)
    }

    /*
     * @throws OverflowException if the division operation overflows
     */
    public func throwingDiv(y: Int32): Int32 {
        throwingDiv<Int32>(this, y)
    }

    /*
     * @throws OverflowException if the modulo operation overflows
     */
    public func throwingMod(y: Int32): Int32 {
        throwingMod<Int32>(this, y)
    }

    /*
     * @throws OverflowException if the increase operation overflows
     */
    public func throwingInc(): Int32 {
        throwingInc<Int32>(this)
    }

    /*
     * @throws OverflowException if the decrease operation overflows
     */
    public func throwingDec(): Int32 {
        throwingDec<Int32>(this)
    }

    /*
     * @throws OverflowException if the negative operation overflows
     */
    public func throwingNeg(): Int32 {
        throwingNeg<Int32>(this)
    }

    public func throwingShl(y: UInt64): Int32 {
        if (y >= 32) {
            throw OvershiftException("The right operand must be less than the number of bits in the left operand.")
        } else {
            return this << y
        }
    }

    public func throwingShr(y: UInt64): Int32 {
        if (y >= 32) {
            throw OvershiftException("The right operand must be less than the number of bits in the left operand.")
        } else {
            return this >> y
        }
    }
}

extend Int64 <: ThrowingOp<Int64> & ThrowingPow {

    /*
     * @throws OverflowException if the add operation overflows
     */
    public func throwingAdd(y: Int64): Int64 {
        throwingAdd<Int64>(this, y)
    }

    /*
     * @throws OverflowException if the subtraction operation overflows
     */
    public func throwingSub(y: Int64): Int64 {
        throwingSub<Int64>(this, y)
    }

    /*
     * @throws OverflowException if the multiplication operation overflows
     */
    public func throwingMul(y: Int64): Int64 {
        throwingMul<Int64>(this, y)
    }

    /*
     * @throws OverflowException if the division operation overflows
     */
    public func throwingDiv(y: Int64): Int64 {
        throwingDiv<Int64>(this, y)
    }

    /*
     * @throws OverflowException if the modulo operation overflows
     */
    public func throwingMod(y: Int64): Int64 {
        throwingMod<Int64>(this, y)
    }

    /*
     * @throws OverflowException if the power operation overflows
     */
    public func throwingPow(y: UInt64): Int64 {
        throwingPow(this, y)
    }

    /*
     * @throws OverflowException if the increase operation overflows
     */
    public func throwingInc(): Int64 {
        throwingInc<Int64>(this)
    }

    /*
     * @throws OverflowException if the decrease operation overflows
     */
    public func throwingDec(): Int64 {
        throwingDec<Int64>(this)
    }

    /*
     * @throws OverflowException if the negative operation overflows
     */
    public func throwingNeg(): Int64 {
        throwingNeg<Int64>(this)
    }

    public func throwingShl(y: UInt64): Int64 {
        if (y >= 64) {
            throw OvershiftException("The right operand must be less than the number of bits in the left operand.")
        }
        this << y
    }

    public func throwingShr(y: UInt64): Int64 {
        if (y >= 64) {
            throw OvershiftException("The right operand must be less than the number of bits in the left operand.")
        }
        this >> y
    }
}

extend UInt8 <: ThrowingOp<UInt8> {

    /*
     * @throws OverflowException if the add operation overflows
     */
    public func throwingAdd(y: UInt8): UInt8 {
        throwingAdd<UInt8>(this, y)
    }

    /*
     * @throws OverflowException if the subtraction operation overflows
     */
    public func throwingSub(y: UInt8): UInt8 {
        throwingSub<UInt8>(this, y)
    }

    /*
     * @throws OverflowException if the multiplication operation overflows
     */
    public func throwingMul(y: UInt8): UInt8 {
        throwingMul<UInt8>(this, y)
    }

    /*
     * @throws OverflowException if the division operation overflows
     */
    public func throwingDiv(y: UInt8): UInt8 {
        throwingDiv<UInt8>(this, y)
    }

    /*
     * @throws OverflowException if the modulo operation overflows
     */
    public func throwingMod(y: UInt8): UInt8 {
        throwingMod<UInt8>(this, y)
    }

    /*
     * @throws OverflowException if the increase operation overflows
     */
    public func throwingInc(): UInt8 {
        throwingInc<UInt8>(this)
    }

    /*
     * @throws OverflowException if the decrease operation overflows
     */
    public func throwingDec(): UInt8 {
        throwingDec<UInt8>(this)
    }

    /*
     * @throws OverflowException if the negative operation overflows
     */
    public func throwingNeg(): UInt8 {
        throwingNeg<UInt8>(this)
    }

    public func throwingShl(y: UInt64): UInt8 {
        if (y >= 8) {
            throw OvershiftException("The right operand must be less than the number of bits in the left operand.")
        }
        this << y
    }

    public func throwingShr(y: UInt64): UInt8 {
        if (y >= 8) {
            throw OvershiftException("The right operand must be less than the number of bits in the left operand.")
        }
        this >> y
    }
}

extend UInt16 <: ThrowingOp<UInt16> {

    /*
     * @throws OverflowException if the add operation overflows
     */
    public func throwingAdd(y: UInt16): UInt16 {
        throwingAdd<UInt16>(this, y)
    }

    /*
     * @throws OverflowException if the subtraction operation overflows
     */
    public func throwingSub(y: UInt16): UInt16 {
        throwingSub<UInt16>(this, y)
    }

    /*
     * @throws OverflowException if the multiplication operation overflows
     */
    public func throwingMul(y: UInt16): UInt16 {
        throwingMul<UInt16>(this, y)
    }

    /*
     * @throws OverflowException if the division operation overflows
     */
    public func throwingDiv(y: UInt16): UInt16 {
        throwingDiv<UInt16>(this, y)
    }

    /*
     * @throws OverflowException if the modulo operation overflows
     */
    public func throwingMod(y: UInt16): UInt16 {
        throwingMod<UInt16>(this, y)
    }

    /*
     * @throws OverflowException if the increase operation overflows
     */
    public func throwingInc(): UInt16 {
        throwingInc<UInt16>(this)
    }

    /*
     * @throws OverflowException if the decrease operation overflows
     */
    public func throwingDec(): UInt16 {
        throwingDec<UInt16>(this)
    }

    /*
     * @throws OverflowException if the negative operation overflows
     */
    public func throwingNeg(): UInt16 {
        throwingNeg<UInt16>(this)
    }

    public func throwingShl(y: UInt64): UInt16 {
        if (y >= 16) {
            throw OvershiftException("The right operand must be less than the number of bits in the left operand.")
        }
        this << y
    }

    public func throwingShr(y: UInt64): UInt16 {
        if (y >= 16) {
            throw OvershiftException("The right operand must be less than the number of bits in the left operand.")
        }
        this >> y
    }
}

extend UInt32 <: ThrowingOp<UInt32> {

    /*
     * @throws OverflowException if the add operation overflows
     */
    public func throwingAdd(y: UInt32): UInt32 {
        throwingAdd<UInt32>(this, y)
    }

    /*
     * @throws OverflowException if the subtraction operation overflows
     */
    public func throwingSub(y: UInt32): UInt32 {
        throwingSub<UInt32>(this, y)
    }

    /*
     * @throws OverflowException if the multiplication operation overflows
     */
    public func throwingMul(y: UInt32): UInt32 {
        throwingMul<UInt32>(this, y)
    }

    /*
     * @throws OverflowException if the division operation overflows
     */
    public func throwingDiv(y: UInt32): UInt32 {
        throwingDiv<UInt32>(this, y)
    }

    /*
     * @throws OverflowException if the modulo operation overflows
     */
    public func throwingMod(y: UInt32): UInt32 {
        throwingMod<UInt32>(this, y)
    }

    /*
     * @throws OverflowException if the increase operation overflows
     */
    public func throwingInc(): UInt32 {
        throwingInc<UInt32>(this)
    }

    /*
     * @throws OverflowException if the decrease operation overflows
     */
    public func throwingDec(): UInt32 {
        throwingDec<UInt32>(this)
    }

    /*
     * @throws OverflowException if the negative operation overflows
     */
    public func throwingNeg(): UInt32 {
        throwingNeg<UInt32>(this)
    }

    public func throwingShl(y: UInt64): UInt32 {
        if (y >= 32) {
            throw OvershiftException("The right operand must be less than the number of bits in the left operand.")
        }
        this << y
    }

    public func throwingShr(y: UInt64): UInt32 {
        if (y >= 32) {
            throw OvershiftException("The right operand must be less than the number of bits in the left operand.")
        }
        this >> y
    }
}

extend UInt64 <: ThrowingOp<UInt64> {

    /*
     * @throws OverflowException if the add operation overflows
     */
    public func throwingAdd(y: UInt64): UInt64 {
        throwingAdd<UInt64>(this, y)
    }

    /*
     * @throws OverflowException if the subtraction operation overflows
     */
    public func throwingSub(y: UInt64): UInt64 {
        throwingSub<UInt64>(this, y)
    }

    /*
     * @throws OverflowException if the multiplication operation overflows
     */
    public func throwingMul(y: UInt64): UInt64 {
        throwingMul<UInt64>(this, y)
    }

    /*
     * @throws OverflowException if the division operation overflows
     */
    public func throwingDiv(y: UInt64): UInt64 {
        throwingDiv<UInt64>(this, y)
    }

    /*
     * @throws OverflowException if the modulo operation overflows
     */
    public func throwingMod(y: UInt64): UInt64 {
        throwingMod<UInt64>(this, y)
    }

    /*
     * @throws OverflowException if the increase operation overflows
     */
    public func throwingInc(): UInt64 {
        throwingInc<UInt64>(this)
    }

    /*
     * @throws OverflowException if the decrease operation overflows
     */
    public func throwingDec(): UInt64 {
        throwingDec<UInt64>(this)
    }

    /*
     * @throws OverflowException if the negative operation overflows
     */
    public func throwingNeg(): UInt64 {
        throwingNeg<UInt64>(this)
    }

    public func throwingShl(y: UInt64): UInt64 {
        if (y >= 64) {
            throw OvershiftException("The right operand must be less than the number of bits in the left operand.")
        }
        this << y
    }

    public func throwingShr(y: UInt64): UInt64 {
        if (y >= 64) {
            throw OvershiftException("The right operand must be less than the number of bits in the left operand.")
        }
        this >> y
    }
}

extend IntNative <: ThrowingOp<IntNative> {

    /*
     * @throws OverflowException if the add operation overflows
     */
    public func throwingAdd(y: IntNative): IntNative {
        throwingAdd<IntNative>(this, y)
    }

    /*
     * @throws OverflowException if the subtraction operation overflows
     */
    public func throwingSub(y: IntNative): IntNative {
        throwingSub<IntNative>(this, y)
    }

    /*
     * @throws OverflowException if the multiplication operation overflows
     */
    public func throwingMul(y: IntNative): IntNative {
        throwingMul<IntNative>(this, y)
    }

    /*
     * @throws OverflowException if the division operation overflows
     */
    public func throwingDiv(y: IntNative): IntNative {
        throwingDiv<IntNative>(this, y)
    }

    /*
     * @throws OverflowException if the modulo operation overflows
     */
    public func throwingMod(y: IntNative): IntNative {
        throwingMod<IntNative>(this, y)
    }

    /*
     * @throws OverflowException if the increase operation overflows
     */
    public func throwingInc(): IntNative {
        throwingInc<IntNative>(this)
    }

    /*
     * @throws OverflowException if the decrease operation overflows
     */
    public func throwingDec(): IntNative {
        throwingDec<IntNative>(this)
    }

    /*
     * @throws OverflowException if the negative operation overflows
     */
    public func throwingNeg(): IntNative {
        throwingNeg<IntNative>(this)
    }

    public func throwingShl(y: UInt64): IntNative {
        if ((isNative64 && y >= 64) || (!isNative64 && y >= 32)) {
            throw OvershiftException("The right operand must be less than the number of bits in the left operand.")
        }
        this << y
    }

    public func throwingShr(y: UInt64): IntNative {
        if ((isNative64 && y >= 64) || (!isNative64 && y >= 32)) {
            throw OvershiftException("The right operand must be less than the number of bits in the left operand.")
        }
        this >> y
    }
}

extend UIntNative <: ThrowingOp<UIntNative> {

    /*
     * @throws OverflowException if the add operation overflows
     */
    public func throwingAdd(y: UIntNative): UIntNative {
        throwingAdd<UIntNative>(this, y)
    }

    /*
     * @throws OverflowException if the subtraction operation overflows
     */
    public func throwingSub(y: UIntNative): UIntNative {
        throwingSub<UIntNative>(this, y)
    }

    /*
     * @throws OverflowException if the multiplication operation overflows
     */
    public func throwingMul(y: UIntNative): UIntNative {
        throwingMul<UIntNative>(this, y)
    }

    /*
     * @throws OverflowException if the division operation overflows
     */
    public func throwingDiv(y: UIntNative): UIntNative {
        throwingDiv<UIntNative>(this, y)
    }

    /*
     * @throws OverflowException if the modulo operation overflows
     */
    public func throwingMod(y: UIntNative): UIntNative {
        throwingMod<UIntNative>(this, y)
    }

    /*
     * @throws OverflowException if the increase operation overflows
     */
    public func throwingInc(): UIntNative {
        throwingInc<UIntNative>(this)
    }

    /*
     * @throws OverflowException if the decrease operation overflows
     */
    public func throwingDec(): UIntNative {
        throwingDec<UIntNative>(this)
    }

    /*
     * @throws OverflowException if the negative operation overflows
     */
    public func throwingNeg(): UIntNative {
        throwingNeg<UIntNative>(this)
    }

    public func throwingShl(y: UInt64): UIntNative {
        if ((isNative64 && y >= 64) || (!isNative64 && y >= 32)) {
            throw OvershiftException("The right operand must be less than the number of bits in the left operand.")
        }
        this << y
    }

    public func throwingShr(y: UInt64): UIntNative {
        if ((isNative64 && y >= 64) || (!isNative64 && y >= 32)) {
            throw OvershiftException("The right operand must be less than the number of bits in the left operand.")
        }
        this >> y
    }
}

public class OvershiftException <: Exception {
    public init() {
        super()
    }

    public init(message: String) {
        super(message)
    }

    protected override func getClassName(): String {
        return "OvershiftException"
    }
}

public class UndershiftException <: Exception {
    public init() {
        super()
    }

    public init(message: String) {
        super(message)
    }

    protected override func getClassName(): String {
        return "UndershiftException"
    }
}
