/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.overflow

let isNative64 = if (UInt64(!UIntNative(0)) == UInt64.Max) {
    true
} else if (UInt64(!UIntNative(0)) == UInt64(UInt32.Max)) {
    false
} else {
    throw Exception("Unrecognized IntNative")
}

public interface CheckedOp<T> {
    func checkedAdd(y: T): ?T
    func checkedSub(y: T): ?T
    func checkedMul(y: T): ?T
    func checkedDiv(y: T): ?T
    func checkedMod(y: T): ?T
    func checkedInc(): ?T
    func checkedDec(): ?T
    func checkedNeg(): ?T
    func checkedShl(y: UInt64): ?T
    func checkedShr(y: UInt64): ?T
}

public interface CheckedPow {
    func checkedPow(y: UInt64): ?Int64
}

func checkedShl(x: Int8, y: UInt64): Option<Int8> {
    if (y >= 8) {
        None
    } else {
        Some(x << y)
    }
}

func checkedShl(x: Int16, y: UInt64): Option<Int16> {
    if (y >= 16) {
        None
    } else {
        Some(x << y)
    }
}

func checkedShl(x: Int32, y: UInt64): Option<Int32> {
    if (y >= 32) {
        None
    } else {
        Some(x << y)
    }
}

func checkedShl(x: Int64, y: UInt64): Option<Int64> {
    if (y >= 64) {
        None
    } else {
        Some(x << y)
    }
}

func checkedShl(x: IntNative, y: UInt64): Option<IntNative> {
    if (isNative64) {
        if (y >= 64) {
            return None
        } else {
            return Some(x << y)
        }
    } else {
        if (y >= 32) {
            return None
        } else {
            return Some(x << y)
        }
    }
}

func checkedShl(x: UInt8, y: UInt64): Option<UInt8> {
    if (y >= 8) {
        None
    } else {
        Some(x << y)
    }
}

func checkedShl(x: UInt16, y: UInt64): Option<UInt16> {
    if (y >= 16) {
        None
    } else {
        Some(x << y)
    }
}

func checkedShl(x: UInt32, y: UInt64): Option<UInt32> {
    if (y >= 32) {
        None
    } else {
        Some(x << y)
    }
}

func checkedShl(x: UInt64, y: UInt64): Option<UInt64> {
    if (y >= 64) {
        None
    } else {
        Some(x << y)
    }
}

func checkedShl(x: UIntNative, y: UInt64): Option<UIntNative> {
    if (isNative64) {
        if (y >= 64) {
            return None
        } else {
            return Some(x << y)
        }
    } else {
        if (y >= 32) {
            return None
        } else {
            return Some(x << y)
        }
    }
}

func checkedShr(x: Int8, y: UInt64): Option<Int8> {
    if (y >= 8) {
        None
    } else {
        Some(x >> y)
    }
}

func checkedShr(x: Int16, y: UInt64): Option<Int16> {
    if (y >= 16) {
        None
    } else {
        Some(x >> y)
    }
}

func checkedShr(x: Int32, y: UInt64): Option<Int32> {
    if (y >= 32) {
        None
    } else {
        Some(x >> y)
    }
}

func checkedShr(x: Int64, y: UInt64): Option<Int64> {
    if (y >= 64) {
        None
    } else {
        Some(x >> y)
    }
}

func checkedShr(x: IntNative, y: UInt64): Option<IntNative> {
    if (isNative64) {
        if (y >= 64) {
            return None
        } else {
            return Some(x >> y)
        }
    } else {
        if (y >= 32) {
            return None
        } else {
            return Some(x >> y)
        }
    }
}

func checkedShr(x: UInt8, y: UInt64): Option<UInt8> {
    if (y >= 8) {
        None
    } else {
        Some(x >> y)
    }
}

func checkedShr(x: UInt16, y: UInt64): Option<UInt16> {
    if (y >= 16) {
        None
    } else {
        Some(x >> y)
    }
}

func checkedShr(x: UInt32, y: UInt64): Option<UInt32> {
    if (y >= 32) {
        None
    } else {
        Some(x >> y)
    }
}

func checkedShr(x: UInt64, y: UInt64): Option<UInt64> {
    if (y >= 64) {
        None
    } else {
        Some(x >> y)
    }
}

func checkedShr(x: UIntNative, y: UInt64): Option<UIntNative> {
    if (isNative64) {
        if (y >= 64) {
            return None
        } else {
            return Some(x >> y)
        }
    } else {
        if (y >= 32) {
            return None
        } else {
            return Some(x >> y)
        }
    }
}
