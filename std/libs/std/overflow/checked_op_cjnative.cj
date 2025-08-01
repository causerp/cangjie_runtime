/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.overflow

@Intrinsic
func checkedAdd<T>(x: T, y: T): ?T

@Intrinsic
func checkedSub<T>(x: T, y: T): ?T

@Intrinsic
func checkedMul<T>(x: T, y: T): ?T

@Intrinsic
func checkedDiv<T>(x: T, y: T): ?T

@Intrinsic
func checkedMod<T>(x: T, y: T): ?T

@Intrinsic
func checkedPow(x: Int64, y: UInt64): ?Int64

@Intrinsic
func checkedInc<T>(x: T): ?T

@Intrinsic
func checkedDec<T>(x: T): ?T

@Intrinsic
func checkedNeg<T>(x: T): ?T

extend Int8 <: CheckedOp<Int8> {
    public func checkedAdd(y: Int8): ?Int8 {
        checkedAdd<Int8>(this, y)
    }
    public func checkedSub(y: Int8): ?Int8 {
        checkedSub<Int8>(this, y)
    }
    public func checkedMul(y: Int8): ?Int8 {
        checkedMul<Int8>(this, y)
    }
    public func checkedDiv(y: Int8): ?Int8 {
        checkedDiv<Int8>(this, y)
    }
    public func checkedMod(y: Int8): ?Int8 {
        checkedMod<Int8>(this, y)
    }
    public func checkedInc(): ?Int8 {
        checkedInc<Int8>(this)
    }
    public func checkedDec(): ?Int8 {
        checkedDec<Int8>(this)
    }
    public func checkedNeg(): ?Int8 {
        checkedNeg<Int8>(this)
    }

    public func checkedShl(y: UInt64): ?Int8 {
        checkedShl(this, y)
    }

    public func checkedShr(y: UInt64): ?Int8 {
        checkedShr(this, y)
    }
}

extend Int16 <: CheckedOp<Int16> {
    public func checkedAdd(y: Int16): ?Int16 {
        checkedAdd<Int16>(this, y)
    }
    public func checkedSub(y: Int16): ?Int16 {
        checkedSub<Int16>(this, y)
    }
    public func checkedMul(y: Int16): ?Int16 {
        checkedMul<Int16>(this, y)
    }
    public func checkedDiv(y: Int16): ?Int16 {
        checkedDiv<Int16>(this, y)
    }
    public func checkedMod(y: Int16): ?Int16 {
        checkedMod<Int16>(this, y)
    }
    public func checkedInc(): ?Int16 {
        checkedInc<Int16>(this)
    }
    public func checkedDec(): ?Int16 {
        checkedDec<Int16>(this)
    }
    public func checkedNeg(): ?Int16 {
        checkedNeg<Int16>(this)
    }

    public func checkedShl(y: UInt64): ?Int16 {
        checkedShl(this, y)
    }

    public func checkedShr(y: UInt64): ?Int16 {
        checkedShr(this, y)
    }
}

extend Int32 <: CheckedOp<Int32> {
    public func checkedAdd(y: Int32): ?Int32 {
        checkedAdd<Int32>(this, y)
    }
    public func checkedSub(y: Int32): ?Int32 {
        checkedSub<Int32>(this, y)
    }
    public func checkedMul(y: Int32): ?Int32 {
        checkedMul<Int32>(this, y)
    }
    public func checkedDiv(y: Int32): ?Int32 {
        checkedDiv<Int32>(this, y)
    }
    public func checkedMod(y: Int32): ?Int32 {
        checkedMod<Int32>(this, y)
    }
    public func checkedInc(): ?Int32 {
        checkedInc<Int32>(this)
    }
    public func checkedDec(): ?Int32 {
        checkedDec<Int32>(this)
    }
    public func checkedNeg(): ?Int32 {
        checkedNeg<Int32>(this)
    }

    public func checkedShl(y: UInt64): ?Int32 {
        checkedShl(this, y)
    }

    public func checkedShr(y: UInt64): ?Int32 {
        checkedShr(this, y)
    }
}

extend Int64 <: CheckedOp<Int64> & CheckedPow {
    public func checkedAdd(y: Int64): ?Int64 {
        checkedAdd<Int64>(this, y)
    }
    public func checkedSub(y: Int64): ?Int64 {
        checkedSub<Int64>(this, y)
    }
    public func checkedMul(y: Int64): ?Int64 {
        checkedMul<Int64>(this, y)
    }
    public func checkedDiv(y: Int64): ?Int64 {
        checkedDiv<Int64>(this, y)
    }
    public func checkedMod(y: Int64): ?Int64 {
        checkedMod<Int64>(this, y)
    }
    public func checkedPow(y: UInt64): ?Int64 { // cjlint-ignore !G.ITF.02
        checkedPow(this, y)
    }
    public func checkedInc(): ?Int64 {
        checkedInc<Int64>(this)
    }
    public func checkedDec(): ?Int64 {
        checkedDec<Int64>(this)
    }
    public func checkedNeg(): ?Int64 {
        checkedNeg<Int64>(this)
    }

    public func checkedShl(y: UInt64): ?Int64 {
        checkedShl(this, y)
    }

    public func checkedShr(y: UInt64): ?Int64 {
        checkedShr(this, y)
    }
}

extend UInt8 <: CheckedOp<UInt8> {
    public func checkedAdd(y: UInt8): ?UInt8 {
        checkedAdd<UInt8>(this, y)
    }
    public func checkedSub(y: UInt8): ?UInt8 {
        checkedSub<UInt8>(this, y)
    }
    public func checkedMul(y: UInt8): ?UInt8 {
        checkedMul<UInt8>(this, y)
    }
    public func checkedDiv(y: UInt8): ?UInt8 {
        checkedDiv<UInt8>(this, y)
    }
    public func checkedMod(y: UInt8): ?UInt8 {
        checkedMod<UInt8>(this, y)
    }
    public func checkedInc(): ?UInt8 {
        checkedInc<UInt8>(this)
    }
    public func checkedDec(): ?UInt8 {
        checkedDec<UInt8>(this)
    }
    public func checkedNeg(): ?UInt8 {
        checkedNeg<UInt8>(this)
    }

    public func checkedShl(y: UInt64): ?UInt8 {
        checkedShl(this, y)
    }

    public func checkedShr(y: UInt64): ?UInt8 {
        checkedShr(this, y)
    }
}

extend UInt16 <: CheckedOp<UInt16> {
    public func checkedAdd(y: UInt16): ?UInt16 {
        checkedAdd<UInt16>(this, y)
    }
    public func checkedSub(y: UInt16): ?UInt16 {
        checkedSub<UInt16>(this, y)
    }
    public func checkedMul(y: UInt16): ?UInt16 {
        checkedMul<UInt16>(this, y)
    }
    public func checkedDiv(y: UInt16): ?UInt16 {
        checkedDiv<UInt16>(this, y)
    }
    public func checkedMod(y: UInt16): ?UInt16 {
        checkedMod<UInt16>(this, y)
    }
    public func checkedInc(): ?UInt16 {
        checkedInc<UInt16>(this)
    }
    public func checkedDec(): ?UInt16 {
        checkedDec<UInt16>(this)
    }
    public func checkedNeg(): ?UInt16 {
        checkedNeg<UInt16>(this)
    }

    public func checkedShl(y: UInt64): ?UInt16 {
        checkedShl(this, y)
    }

    public func checkedShr(y: UInt64): ?UInt16 {
        checkedShr(this, y)
    }
}

extend UInt32 <: CheckedOp<UInt32> {
    public func checkedAdd(y: UInt32): ?UInt32 {
        checkedAdd<UInt32>(this, y)
    }
    public func checkedSub(y: UInt32): ?UInt32 {
        checkedSub<UInt32>(this, y)
    }
    public func checkedMul(y: UInt32): ?UInt32 {
        checkedMul<UInt32>(this, y)
    }
    public func checkedDiv(y: UInt32): ?UInt32 {
        checkedDiv<UInt32>(this, y)
    }
    public func checkedMod(y: UInt32): ?UInt32 {
        checkedMod<UInt32>(this, y)
    }
    public func checkedInc(): ?UInt32 {
        checkedInc<UInt32>(this)
    }
    public func checkedDec(): ?UInt32 {
        checkedDec<UInt32>(this)
    }
    public func checkedNeg(): ?UInt32 {
        checkedNeg<UInt32>(this)
    }

    public func checkedShl(y: UInt64): ?UInt32 {
        checkedShl(this, y)
    }

    public func checkedShr(y: UInt64): ?UInt32 {
        checkedShr(this, y)
    }
}

extend UInt64 <: CheckedOp<UInt64> {
    public func checkedAdd(y: UInt64): ?UInt64 {
        checkedAdd<UInt64>(this, y)
    }
    public func checkedSub(y: UInt64): ?UInt64 {
        checkedSub<UInt64>(this, y)
    }
    public func checkedMul(y: UInt64): ?UInt64 {
        checkedMul<UInt64>(this, y)
    }
    public func checkedDiv(y: UInt64): ?UInt64 {
        checkedDiv<UInt64>(this, y)
    }
    public func checkedMod(y: UInt64): ?UInt64 {
        checkedMod<UInt64>(this, y)
    }
    public func checkedInc(): ?UInt64 {
        checkedInc<UInt64>(this)
    }
    public func checkedDec(): ?UInt64 {
        checkedDec<UInt64>(this)
    }
    public func checkedNeg(): ?UInt64 {
        checkedNeg<UInt64>(this)
    }

    public func checkedShl(y: UInt64): ?UInt64 {
        checkedShl(this, y)
    }

    public func checkedShr(y: UInt64): ?UInt64 {
        checkedShr(this, y)
    }
}

extend IntNative <: CheckedOp<IntNative> {
    public func checkedAdd(y: IntNative): ?IntNative {
        checkedAdd<IntNative>(this, y)
    }
    public func checkedSub(y: IntNative): ?IntNative {
        checkedSub<IntNative>(this, y)
    }
    public func checkedMul(y: IntNative): ?IntNative {
        checkedMul<IntNative>(this, y)
    }
    public func checkedDiv(y: IntNative): ?IntNative {
        checkedDiv<IntNative>(this, y)
    }
    public func checkedMod(y: IntNative): ?IntNative {
        checkedMod<IntNative>(this, y)
    }
    public func checkedInc(): ?IntNative {
        checkedInc<IntNative>(this)
    }
    public func checkedDec(): ?IntNative {
        checkedDec<IntNative>(this)
    }
    public func checkedNeg(): ?IntNative {
        checkedNeg<IntNative>(this)
    }

    public func checkedShl(y: UInt64): ?IntNative {
        checkedShl(this, y)
    }

    public func checkedShr(y: UInt64): ?IntNative {
        checkedShr(this, y)
    }
}

extend UIntNative <: CheckedOp<UIntNative> {
    public func checkedAdd(y: UIntNative): ?UIntNative {
        checkedAdd<UIntNative>(this, y)
    }
    public func checkedSub(y: UIntNative): ?UIntNative {
        checkedSub<UIntNative>(this, y)
    }
    public func checkedMul(y: UIntNative): ?UIntNative {
        checkedMul<UIntNative>(this, y)
    }
    public func checkedDiv(y: UIntNative): ?UIntNative {
        checkedDiv<UIntNative>(this, y)
    }
    public func checkedMod(y: UIntNative): ?UIntNative {
        checkedMod<UIntNative>(this, y)
    }
    public func checkedInc(): ?UIntNative {
        checkedInc<UIntNative>(this)
    }
    public func checkedDec(): ?UIntNative {
        checkedDec<UIntNative>(this)
    }
    public func checkedNeg(): ?UIntNative {
        checkedNeg<UIntNative>(this)
    }

    public func checkedShl(y: UInt64): ?UIntNative {
        checkedShl(this, y)
    }

    public func checkedShr(y: UInt64): ?UIntNative {
        checkedShr(this, y)
    }
}
