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
 * This file defines MonoTime related structs.
 */

package std.time

/**
 * MonoTime is a kind of clock to measure the elapsed time, Like a constantly running stopwatch, independent of any other clock time.
 *
 * MonoTimes created by 'now' are always no less than any previously measured MonoTime created in the same way, and are
 * commonly used in BenchMark or task queues on a first come first served basis.
 */
public struct MonoTime <: Hashable & Comparable<MonoTime> {
    /**
     * The d records the elapsed time since system start.
     */
    let d: Duration

    /**
     * Obtain the elapsed time from the start of the system to current.
     *
     * @return a MonoTime corresponding to current.
     */
    public static func now(): MonoTime {
        let (sec, ns) = monoNow()
        return MonoTime(Duration(sec, UInt32(ns)))
    }

    /**
     * Initialize a MonoTime with specified Duration.
     */
    private init(d: Duration) {
        this.d = d
    }

    /**
     * Override operator `+`, adds a Duration and returns a new MonoTime instance.
     *
     * @param r duration to add.
     * @return a MonoTime based on this MonoTime with the specified @r added.
     */
    public operator func +(r: Duration): MonoTime {
        if (r > Duration.Max - d || r < Duration.Zero - d) {
            throw ArithmeticException("The result exceeds the range of 'MonoTime'.")
        }
        return MonoTime(d + r)
    }

    /**
     * Override operator `-`, subtracts a Duration and returns a new MonoTime instance.
     *
     * @param r duration to subtract.
     * @return a MonoTime based on this MonoTime with the specified @r subtracted.
     */
    public operator func -(r: Duration): MonoTime {
        if (d - Duration.Max > r || d < r) {
            throw ArithmeticException("The result exceeds the range of 'MonoTime'.")
        }
        return MonoTime(d - r)
    }

    /**
     * Override operator `-`, subtracts a MonoTime and returns a Duration.
     *
     * @param r MonoTime to subtract.
     * @return a MonoTime based on this MonoTime with the specified @r subtracted.
     */
    public operator func -(r: MonoTime): Duration {
        return this.d - r.d
    }

    /**
     * Override operator `==`, compares whether this MonoTime is equal to another MonoTime.
     *
     * @param r another MonoTime to be compared to.
     * @return true if the elapsed time of this MonoTime is equal to that of @r, otherwise false.
     */
    public operator func ==(r: MonoTime): Bool {
        return this.d == r.d
    }

    /**
     * Override operator `!=`, compares whether this MonoTime is not equal to another MonoTime.
     *
     * @param r another MonoTime to be compared to.
     * @return true if the elapsed time of this MonoTime is not equal to that of @r, otherwise false.
     */
    public operator func !=(r: MonoTime): Bool {
        return this.d != r.d
    }

    /**
     * Override operator `>=`, compares whether this MonoTime is greater than or equal to another MonoTime.
     *
     * @param r another MonoTime to be compared to.
     * @return true if the elapsed time of this MonoTime is greater than or equal to that of @r, otherwise false.
     */
    public operator func >=(r: MonoTime): Bool {
        return this.d >= r.d
    }

    /**
     * Override operator `>`, compares whether this MonoTime is greater than another MonoTime.
     *
     * @param r another MonoTime to be compared to.
     * @return true if the elapsed time of this MonoTime is greater than that of @r, otherwise false.
     */
    public operator func >(r: MonoTime): Bool {
        return this.d > r.d
    }

    /**
     * Override operator `<=`, compares whether this MonoTime is less than or equal to another MonoTime.
     *
     * @param r another MonoTime to be compared to.
     * @return true if the elapsed time of this MonoTime is less than or equal to that of @r, otherwise false.
     */
    public operator func <=(r: MonoTime): Bool {
        return this.d <= r.d
    }

    /**
     * Override operator `<`, compares whether this MonoTime is less than or equal to another MonoTime.
     *
     * @param r another MonoTime to be compared to.
     * @return true if the elapsed time of this MonoTime is less than that of @r, otherwise false.
     */
    public operator func <(r: MonoTime): Bool {
        return this.d < r.d
    }

    /**
     * Compare the order between two instance of MonoTime.
     *
     * @param rhs instance of MonoTime compared with this.
     * @return a Ordering value indicating the relationship between two instance of MonoTime.
     */
    public func compare(rhs: MonoTime): Ordering {
        match {
            case this < rhs => Ordering.LT
            case this > rhs => Ordering.GT
            case _ => Ordering.EQ
        }
    }

    /**
     * Returns hash value of MonoTime instance
     *
     * @return the hash value of this MonoTime.
     */
    public func hashCode(): Int64 {
        return d.hashCode()
    }
}
