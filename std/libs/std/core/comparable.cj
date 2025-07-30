/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.core

@Intrinsic
func Int64Less(a: Int64, b: Int64): Bool

@Intrinsic
func Int64Greater(a: Int64, b: Int64): Bool

@Intrinsic
func Int64LessOrEqual(a: Int64, b: Int64): Bool

@Intrinsic
func Int64GreaterOrEqual(a: Int64, b: Int64): Bool

@Intrinsic
func Int64Equal(a: Int64, b: Int64): Bool

@Intrinsic
func Int64NotEqual(a: Int64, b: Int64): Bool

@Intrinsic
func Int32Less(a: Int32, b: Int32): Bool

@Intrinsic
func Int32Greater(a: Int32, b: Int32): Bool

@Intrinsic
func Int32LessOrEqual(a: Int32, b: Int32): Bool

@Intrinsic
func Int32GreaterOrEqual(a: Int32, b: Int32): Bool

@Intrinsic
func Int32Equal(a: Int32, b: Int32): Bool

@Intrinsic
func Int32NotEqual(a: Int32, b: Int32): Bool

@Intrinsic
func Int16Less(a: Int16, b: Int16): Bool

@Intrinsic
func Int16Greater(a: Int16, b: Int16): Bool

@Intrinsic
func Int16LessOrEqual(a: Int16, b: Int16): Bool

@Intrinsic
func Int16GreaterOrEqual(a: Int16, b: Int16): Bool

@Intrinsic
func Int16Equal(a: Int16, b: Int16): Bool

@Intrinsic
func Int16NotEqual(a: Int16, b: Int16): Bool

@Intrinsic
func Int8Less(a: Int8, b: Int8): Bool

@Intrinsic
func Int8Greater(a: Int8, b: Int8): Bool

@Intrinsic
func Int8LessOrEqual(a: Int8, b: Int8): Bool

@Intrinsic
func Int8GreaterOrEqual(a: Int8, b: Int8): Bool

@Intrinsic
func Int8Equal(a: Int8, b: Int8): Bool

@Intrinsic
func Int8NotEqual(a: Int8, b: Int8): Bool

@Intrinsic
func UInt64Less(a: UInt64, b: UInt64): Bool

@Intrinsic
func UInt64Greater(a: UInt64, b: UInt64): Bool

@Intrinsic
func UInt64LessOrEqual(a: UInt64, b: UInt64): Bool

@Intrinsic
func UInt64GreaterOrEqual(a: UInt64, b: UInt64): Bool

@Intrinsic
func UInt64Equal(a: UInt64, b: UInt64): Bool

@Intrinsic
func UInt64NotEqual(a: UInt64, b: UInt64): Bool

@Intrinsic
func UInt32Less(a: UInt32, b: UInt32): Bool

@Intrinsic
func UInt32Greater(a: UInt32, b: UInt32): Bool

@Intrinsic
func UInt32LessOrEqual(a: UInt32, b: UInt32): Bool

@Intrinsic
func UInt32GreaterOrEqual(a: UInt32, b: UInt32): Bool

@Intrinsic
func UInt32Equal(a: UInt32, b: UInt32): Bool

@Intrinsic
func UInt32NotEqual(a: UInt32, b: UInt32): Bool

@Intrinsic
func UInt16Less(a: UInt16, b: UInt16): Bool

@Intrinsic
func UInt16Greater(a: UInt16, b: UInt16): Bool

@Intrinsic
func UInt16LessOrEqual(a: UInt16, b: UInt16): Bool

@Intrinsic
func UInt16GreaterOrEqual(a: UInt16, b: UInt16): Bool

@Intrinsic
func UInt16Equal(a: UInt16, b: UInt16): Bool

@Intrinsic
func UInt16NotEqual(a: UInt16, b: UInt16): Bool

@Intrinsic
func UInt8Less(a: UInt8, b: UInt8): Bool

@Intrinsic
func UInt8Greater(a: UInt8, b: UInt8): Bool

@Intrinsic
func UInt8LessOrEqual(a: UInt8, b: UInt8): Bool

@Intrinsic
func UInt8GreaterOrEqual(a: UInt8, b: UInt8): Bool

@Intrinsic
func UInt8Equal(a: UInt8, b: UInt8): Bool

@Intrinsic
func UInt8NotEqual(a: UInt8, b: UInt8): Bool

@Intrinsic
func Float16Less(a: Float16, b: Float16): Bool

@Intrinsic
func Float16Greater(a: Float16, b: Float16): Bool

@Intrinsic
func Float16LessOrEqual(a: Float16, b: Float16): Bool

@Intrinsic
func Float16GreaterOrEqual(a: Float16, b: Float16): Bool

@Intrinsic
func Float16Equal(a: Float16, b: Float16): Bool

@Intrinsic
func Float16NotEqual(a: Float16, b: Float16): Bool

@Intrinsic
func Float32Less(a: Float32, b: Float32): Bool

@Intrinsic
func Float32Greater(a: Float32, b: Float32): Bool

@Intrinsic
func Float32LessOrEqual(a: Float32, b: Float32): Bool

@Intrinsic
func Float32GreaterOrEqual(a: Float32, b: Float32): Bool

@Intrinsic
func Float32Equal(a: Float32, b: Float32): Bool

@Intrinsic
func Float32NotEqual(a: Float32, b: Float32): Bool

@Intrinsic
func Float64Less(a: Float64, b: Float64): Bool

@Intrinsic
func Float64Greater(a: Float64, b: Float64): Bool

@Intrinsic
func Float64LessOrEqual(a: Float64, b: Float64): Bool

@Intrinsic
func Float64GreaterOrEqual(a: Float64, b: Float64): Bool

@Intrinsic
func Float64Equal(a: Float64, b: Float64): Bool

@Intrinsic
func Float64NotEqual(a: Float64, b: Float64): Bool

public enum Ordering {
    LT | GT | EQ
}

public interface Less<T> {
    operator func <(rhs: T): Bool
}

public interface Greater<T> {
    operator func >(rhs: T): Bool
}

public interface LessOrEqual<T> {
    operator func <=(rhs: T): Bool
}

public interface GreaterOrEqual<T> {
    operator func >=(rhs: T): Bool
}

public interface Comparable<T> <: Equatable<T> & Less<T> & Greater<T> & LessOrEqual<T> & GreaterOrEqual<T> {
    func compare(that: T): Ordering

    operator func ==(rhs: T): Bool {
        return match (this.compare(rhs)) {
            case EQ => true
            case _ => false
        }
    }

    operator func <(rhs: T): Bool {
        return match (this.compare(rhs)) {
            case LT => true
            case _ => false
        }
    }

    operator func >(rhs: T): Bool {
        return match (this.compare(rhs)) {
            case GT => true
            case _ => false
        }
    }

    operator func <=(rhs: T): Bool {
        return match (this.compare(rhs)) {
            case LT | EQ => true
            case _ => false
        }
    }

    operator func >=(rhs: T): Bool {
        return match (this.compare(rhs)) {
            case GT | EQ => true
            case _ => false
        }
    }
}

extend Ordering <: ToString {
    public func toString(): String {
        return match (this) {
            case GT => "Ordering.GT"
            case LT => "Ordering.LT"
            case EQ => "Ordering.EQ"
        }
    }
}

/**
 * The relationship between Orderings is: Ordering.LT < Ordering.EQ < Ordering.GT
 */
extend Ordering <: Comparable<Ordering> {
    public func compare(that: Ordering): Ordering {
        return match ((this, that)) {
            case (LT, LT) | (EQ, EQ) | (GT, GT) => EQ
            case (LT, EQ) | (LT, GT) | (EQ, GT) => LT
            case _ => GT
        }
    }
}

extend IntNative <: Comparable<IntNative> {
    public func compare(rhs: IntNative): Ordering {
        match {
            case this < rhs => Ordering.LT
            case this > rhs => Ordering.GT
            case _ => Ordering.EQ
        }
    }
}

extend Int64 <: Comparable<Int64> {
    public func compare(rhs: Int64): Ordering {
        match {
            case this < rhs => Ordering.LT
            case this > rhs => Ordering.GT
            case _ => Ordering.EQ
        }
    }

    @Frozen
    public operator func <(rhs: Int64): Bool {
        return Int64Less(this, rhs)
    }

    @Frozen
    public operator func >(rhs: Int64): Bool {
        return Int64Greater(this, rhs)
    }

    @Frozen
    public operator func <=(rhs: Int64): Bool {
        return Int64LessOrEqual(this, rhs)
    }

    @Frozen
    public operator func >=(rhs: Int64): Bool {
        return Int64GreaterOrEqual(this, rhs)
    }

    @Frozen
    public operator func ==(rhs: Int64): Bool {
        return Int64Equal(this, rhs)
    }

    @Frozen
    public operator func !=(rhs: Int64): Bool {
        return Int64NotEqual(this, rhs)
    }
}

extend Int32 <: Comparable<Int32> {
    public func compare(rhs: Int32): Ordering {
        match {
            case this < rhs => Ordering.LT
            case this > rhs => Ordering.GT
            case _ => Ordering.EQ
        }
    }

    @Frozen
    public operator func <(rhs: Int32): Bool {
        return Int32Less(this, rhs)
    }

    @Frozen
    public operator func >(rhs: Int32): Bool {
        return Int32Greater(this, rhs)
    }

    @Frozen
    public operator func <=(rhs: Int32): Bool {
        return Int32LessOrEqual(this, rhs)
    }

    @Frozen
    public operator func >=(rhs: Int32): Bool {
        return Int32GreaterOrEqual(this, rhs)
    }

    @Frozen
    public operator func ==(rhs: Int32): Bool {
        return Int32Equal(this, rhs)
    }

    @Frozen
    public operator func !=(rhs: Int32): Bool {
        return Int32NotEqual(this, rhs)
    }
}

extend Int16 <: Comparable<Int16> {
    public func compare(rhs: Int16): Ordering {
        match {
            case this < rhs => Ordering.LT
            case this > rhs => Ordering.GT
            case _ => Ordering.EQ
        }
    }

    @Frozen
    public operator func <(rhs: Int16): Bool {
        return Int16Less(this, rhs)
    }

    @Frozen
    public operator func >(rhs: Int16): Bool {
        return Int16Greater(this, rhs)
    }

    @Frozen
    public operator func <=(rhs: Int16): Bool {
        return Int16LessOrEqual(this, rhs)
    }

    @Frozen
    public operator func >=(rhs: Int16): Bool {
        return Int16GreaterOrEqual(this, rhs)
    }

    @Frozen
    public operator func ==(rhs: Int16): Bool {
        return Int16Equal(this, rhs)
    }

    @Frozen
    public operator func !=(rhs: Int16): Bool {
        return Int16NotEqual(this, rhs)
    }
}

extend Int8 <: Comparable<Int8> {
    public func compare(rhs: Int8): Ordering {
        match {
            case this < rhs => Ordering.LT
            case this > rhs => Ordering.GT
            case _ => Ordering.EQ
        }
    }

    @Frozen
    public operator func <(rhs: Int8): Bool {
        return Int8Less(this, rhs)
    }

    @Frozen
    public operator func >(rhs: Int8): Bool {
        return Int8Greater(this, rhs)
    }

    @Frozen
    public operator func <=(rhs: Int8): Bool {
        return Int8LessOrEqual(this, rhs)
    }

    @Frozen
    public operator func >=(rhs: Int8): Bool {
        return Int8GreaterOrEqual(this, rhs)
    }

    @Frozen
    public operator func ==(rhs: Int8): Bool {
        return Int8Equal(this, rhs)
    }

    @Frozen
    public operator func !=(rhs: Int8): Bool {
        return Int8NotEqual(this, rhs)
    }
}

extend UIntNative <: Comparable<UIntNative> {
    public func compare(rhs: UIntNative): Ordering {
        match {
            case this < rhs => Ordering.LT
            case this > rhs => Ordering.GT
            case _ => Ordering.EQ
        }
    }
}

extend UInt64 <: Comparable<UInt64> {
    public func compare(rhs: UInt64): Ordering {
        match {
            case this < rhs => Ordering.LT
            case this > rhs => Ordering.GT
            case _ => Ordering.EQ
        }
    }

    @Frozen
    public operator func <(rhs: UInt64): Bool {
        return UInt64Less(this, rhs)
    }

    @Frozen
    public operator func >(rhs: UInt64): Bool {
        return UInt64Greater(this, rhs)
    }

    @Frozen
    public operator func <=(rhs: UInt64): Bool {
        return UInt64LessOrEqual(this, rhs)
    }

    @Frozen
    public operator func >=(rhs: UInt64): Bool {
        return UInt64GreaterOrEqual(this, rhs)
    }

    @Frozen
    public operator func ==(rhs: UInt64): Bool {
        return UInt64Equal(this, rhs)
    }

    @Frozen
    public operator func !=(rhs: UInt64): Bool {
        return UInt64NotEqual(this, rhs)
    }
}

extend UInt32 <: Comparable<UInt32> {
    public func compare(rhs: UInt32): Ordering {
        match {
            case this < rhs => Ordering.LT
            case this > rhs => Ordering.GT
            case _ => Ordering.EQ
        }
    }

    @Frozen
    public operator func <(rhs: UInt32): Bool {
        return UInt32Less(this, rhs)
    }

    @Frozen
    public operator func >(rhs: UInt32): Bool {
        return UInt32Greater(this, rhs)
    }

    @Frozen
    public operator func <=(rhs: UInt32): Bool {
        return UInt32LessOrEqual(this, rhs)
    }

    @Frozen
    public operator func >=(rhs: UInt32): Bool {
        return UInt32GreaterOrEqual(this, rhs)
    }

    @Frozen
    public operator func ==(rhs: UInt32): Bool {
        return UInt32Equal(this, rhs)
    }

    @Frozen
    public operator func !=(rhs: UInt32): Bool {
        return UInt32NotEqual(this, rhs)
    }
}

extend UInt16 <: Comparable<UInt16> {
    public func compare(rhs: UInt16): Ordering {
        match {
            case this < rhs => Ordering.LT
            case this > rhs => Ordering.GT
            case _ => Ordering.EQ
        }
    }

    @Frozen
    public operator func <(rhs: UInt16): Bool {
        return UInt16Less(this, rhs)
    }

    @Frozen
    public operator func >(rhs: UInt16): Bool {
        return UInt16Greater(this, rhs)
    }

    @Frozen
    public operator func <=(rhs: UInt16): Bool {
        return UInt16LessOrEqual(this, rhs)
    }

    @Frozen
    public operator func >=(rhs: UInt16): Bool {
        return UInt16GreaterOrEqual(this, rhs)
    }

    @Frozen
    public operator func ==(rhs: UInt16): Bool {
        return UInt16Equal(this, rhs)
    }

    @Frozen
    public operator func !=(rhs: UInt16): Bool {
        return UInt16NotEqual(this, rhs)
    }
}

extend UInt8 <: Comparable<UInt8> {
    public func compare(rhs: UInt8): Ordering {
        match {
            case this < rhs => Ordering.LT
            case this > rhs => Ordering.GT
            case _ => Ordering.EQ
        }
    }

    @Frozen
    public operator func <(rhs: UInt8): Bool {
        return UInt8Less(this, rhs)
    }

    @Frozen
    public operator func >(rhs: UInt8): Bool {
        return UInt8Greater(this, rhs)
    }

    @Frozen
    public operator func <=(rhs: UInt8): Bool {
        return UInt8LessOrEqual(this, rhs)
    }

    @Frozen
    public operator func >=(rhs: UInt8): Bool {
        return UInt8GreaterOrEqual(this, rhs)
    }

    @Frozen
    public operator func ==(rhs: UInt8): Bool {
        return UInt8Equal(this, rhs)
    }

    @Frozen
    public operator func !=(rhs: UInt8): Bool {
        return UInt8NotEqual(this, rhs)
    }
}

extend Float16 <: Comparable<Float16> {
    public func compare(rhs: Float16): Ordering {
        match {
            case this < rhs => Ordering.LT
            case this > rhs => Ordering.GT
            case _ => Ordering.EQ
        }
    }

    @Frozen
    public operator func <(rhs: Float16): Bool {
        return Float16Less(this, rhs)
    }

    @Frozen
    public operator func >(rhs: Float16): Bool {
        return Float16Greater(this, rhs)
    }

    @Frozen
    public operator func <=(rhs: Float16): Bool {
        return Float16LessOrEqual(this, rhs)
    }

    @Frozen
    public operator func >=(rhs: Float16): Bool {
        return Float16GreaterOrEqual(this, rhs)
    }

    @Frozen
    public operator func ==(rhs: Float16): Bool {
        return Float16Equal(this, rhs)
    }

    @Frozen
    public operator func !=(rhs: Float16): Bool {
        return Float16NotEqual(this, rhs)
    }
}

extend Float32 <: Comparable<Float32> {
    public func compare(rhs: Float32): Ordering {
        match {
            case this < rhs => Ordering.LT
            case this > rhs => Ordering.GT
            case _ => Ordering.EQ
        }
    }

    @Frozen
    public operator func <(rhs: Float32): Bool {
        return Float32Less(this, rhs)
    }

    @Frozen
    public operator func >(rhs: Float32): Bool {
        return Float32Greater(this, rhs)
    }

    @Frozen
    public operator func <=(rhs: Float32): Bool {
        return Float32LessOrEqual(this, rhs)
    }

    @Frozen
    public operator func >=(rhs: Float32): Bool {
        return Float32GreaterOrEqual(this, rhs)
    }

    @Frozen
    public operator func ==(rhs: Float32): Bool {
        return Float32Equal(this, rhs)
    }

    @Frozen
    public operator func !=(rhs: Float32): Bool {
        return Float32NotEqual(this, rhs)
    }
}

extend Float64 <: Comparable<Float64> {
    public func compare(rhs: Float64): Ordering {
        match {
            case this < rhs => Ordering.LT
            case this > rhs => Ordering.GT
            case _ => Ordering.EQ
        }
    }

    @Frozen
    public operator func <(rhs: Float64): Bool {
        return Float64Less(this, rhs)
    }

    @Frozen
    public operator func >(rhs: Float64): Bool {
        return Float64Greater(this, rhs)
    }

    @Frozen
    public operator func <=(rhs: Float64): Bool {
        return Float64LessOrEqual(this, rhs)
    }

    @Frozen
    public operator func >=(rhs: Float64): Bool {
        return Float64GreaterOrEqual(this, rhs)
    }

    @Frozen
    public operator func ==(rhs: Float64): Bool {
        return Float64Equal(this, rhs)
    }

    @Frozen
    public operator func !=(rhs: Float64): Bool {
        return Float64NotEqual(this, rhs)
    }
}

@Frozen
public func max<T>(a: T, b: T, others: Array<T>): T where T <: Comparable<T> {
    var max = if (a > b) { a } else { b }
    if (others.size == 0) {
        return max
    }
    for (item in others) {
        if (max < item) {
            max = item
        }
    }
    return max
}

@Frozen
public func min<T>(a: T, b: T, others: Array<T>): T where T <: Comparable<T> {
    var min = if (a < b) { a } else { b }
    if (others.size == 0) {
        return min
    }
    for (item in others) {
        if (min > item) {
            min = item
        }
    }
    return min
}
