/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.core

/**
 * Countable interface
 */
public interface Countable<T> {
    /** Returns the sum of two instances of type T. */
    func next(right: Int64): T
    /** Returns the Int64 type of the instance. */
    func position(): Int64
}

extend IntNative <: Countable<IntNative> {
    @OverflowWrapping
    public func position(): Int64 {
        Int64(this)
    }

    @OverflowWrapping
    public func next(right: Int64): IntNative {
        this + IntNative(right)
    }
}

extend Int64 <: Countable<Int64> {
    public func position(): Int64 {
        Int64(this)
    }

    @OverflowWrapping
    public func next(right: Int64): Int64 {
        this + right
    }
}

extend Int32 <: Countable<Int32> {
    public func position(): Int64 {
        Int64(this)
    }

    @OverflowWrapping
    public func next(right: Int64): Int32 {
        this + Int32(right)
    }
}

extend Int16 <: Countable<Int16> {
    public func position(): Int64 {
        Int64(this)
    }

    @OverflowWrapping
    public func next(right: Int64): Int16 {
        this + Int16(right)
    }
}

extend Int8 <: Countable<Int8> {
    public func position(): Int64 {
        Int64(this)
    }

    @OverflowWrapping
    public func next(right: Int64): Int8 {
        this + Int8(right)
    }
}

extend UIntNative <: Countable<UIntNative> {
    @OverflowWrapping
    public func position(): Int64 {
        Int64(this)
    }

    @OverflowWrapping
    public func next(right: Int64): UIntNative {
        if (right < 0) {
            return this - UIntNative(-right)
        }
        this + UIntNative(right)
    }
}

extend UInt64 <: Countable<UInt64> {
    @OverflowWrapping
    public func position(): Int64 {
        Int64(this)
    }

    @OverflowWrapping
    public func next(right: Int64): UInt64 {
        if (right < 0) {
            return this - UInt64(-right)
        }
        this + UInt64(right)
    }
}

extend UInt32 <: Countable<UInt32> {
    public func position(): Int64 {
        Int64(this)
    }

    @OverflowWrapping
    public func next(right: Int64): UInt32 {
        if (right < 0) {
            return this - UInt32(-right)
        }
        this + UInt32(right)
    }
}

extend UInt16 <: Countable<UInt16> {
    public func position(): Int64 {
        Int64(this)
    }

    @OverflowWrapping
    public func next(right: Int64): UInt16 {
        if (right < 0) {
            return this - UInt16(-right)
        }
        this + UInt16(right)
    }
}

extend UInt8 <: Countable<UInt8> {
    public func position(): Int64 {
        Int64(this)
    }

    @OverflowWrapping
    public func next(right: Int64): UInt8 {
        if (right < 0) {
            return this - UInt8(-right)
        }
        this + UInt8(right)
    }
}

extend Rune <: Countable<Rune> {
    public func position(): Int64 {
        Int64(UInt32(this))
    }

    @OverflowWrapping
    public func next(right: Int64): Rune {
        return Rune(UInt32(Int64(UInt32(this)) + right))
    }
}
