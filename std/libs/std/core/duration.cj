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
 * This file defines the functions related to 'Duration'.
 */

package std.core

const NS_PER_US: Int64 = 10 ** 3
const NS_PER_MS: Int64 = 10 ** 6
const NS_PER_SEC: Int64 = 10 ** 9
const MS_PER_SEC: Int64 = 10 ** 3
const US_PER_SEC: Int64 = 10 ** 6
const SECS_PER_MINUTE: Int64 = 60
const MAX_NANOSECOND: UInt32 = 999999999
const SECS_PER_HOUR: Int64 = 60 * 60
const SECS_PER_DAY: Int64 = 24 * 60 * 60
const MAX_INT64 = 0x7FFF_FFFF_FFFF_FFFF
const MIN_INT64 = -0x8000_0000_0000_0000
let MAX_NS_FLOAT64 = Float64(MAX_INT64) * Float64(NS_PER_SEC) + Float64(MAX_NANOSECOND)
let MIN_NS_FLOAT64 = Float64(MIN_INT64) * Float64(NS_PER_SEC)
const FLOAT64_0: Float64 = 0.0f64
const FLOAT64_1: Float64 = 1.0f64
const SECS_MAX: UInt64 = 0x8000_0000_0000_0000
const DUR_BASE: UInt32 = 0x3B9A_CA00 //10^9

/**
 * Duration is used to represent a time interval with a minimum precision of nanoseconds.
 * Duration can be expressed in the range of Duration.Min to Duration.Max.( [-2^63, 2^63-1) in seconds)
 * Duration provides some common related methods, including static member instances of some common time intervals,
 * calculation and comparison methods of time intervals, and the like.
 */
public struct Duration <: ToString & Hashable & Comparable<Duration> {
    protected let sec: Int64
    protected let ns: UInt32

    protected const init(sec: Int64, ns: UInt32) {
        this.sec = sec
        this.ns = ns
    }

    static func of(sec: Int64, ns: Int64): Duration {
        if (ns < 0) {
            if (sec == Int64.Min) {
                throw ArithmeticException("Out of range of representation of 'Duration'!")
            }
            return Duration(sec - 1, UInt32(ns + NS_PER_SEC))
        } else if (ns >= NS_PER_SEC) {
            if (sec == Int64.Max) {
                throw ArithmeticException("Out of range of representation of 'Duration'!")
            }
            return Duration(sec + 1, UInt32(ns - NS_PER_SEC))
        }
        return Duration(sec, UInt32(ns))
    }

    /*
     * Duration for 1 nanosecond.
     */
    public static const nanosecond: Duration = Duration(0, 1)

    /*
     * Duration for 1 microsecond.
     */
    public static const microsecond: Duration = Duration(0, 1000u32)

    /*
     * Duration for 1 millisecond.
     */
    public static const millisecond: Duration = Duration(0, 1000000u32)

    /*
     * Duration for 1 second.
     */
    public static const second: Duration = Duration(1, 0)

    /*
     * Duration for 1 minute.
     */
    public static const minute: Duration = Duration(SECS_PER_MINUTE, 0)

    /*
     * Duration for 1 hour.
     */
    public static const hour: Duration = Duration(SECS_PER_HOUR, 0)

    /*
     * Duration for 1 day.
     */
    public static const day: Duration = Duration(SECS_PER_DAY, 0)

    /*
     * Duration for 0 nanosecond.
     */
    public static const Zero: Duration = Duration(0, 0)

    /*
     * Duration for 2^63-1 seconds with 999,999,999 nanoseconds.
     */
    public static const Max: Duration = Duration(MAX_INT64, MAX_NANOSECOND)

    /*
     * Duration for -2^63 seconds.
     */
    public static const Min: Duration = Duration(MIN_INT64, 0)

    /**
     * Obtain the integer size of the current Duration instance in nanoseconds.
     *
     * @return Int64 - Integer size in nanoseconds, rounded up to the smaller absolute value.
     *
     * @throws ArithmeticException - if the duration in nanosecond exceeds the range of 'Int64'.
     */
    public func toNanoseconds(): Int64 {
        if (let Some(result) <- getResult(NS_PER_SEC)) {
            return result
        }
        throw ArithmeticException("The duration in nanosecond exceeds the range of 'Int64'.")
    }

    /**
     * Obtain the integer size of the current Duration instance in microseconds.
     *
     * @return Int64 - Integer size in microseconds, rounded up to the smaller absolute value.
     *
     * @throws ArithmeticException - if the duration in microsecond exceeds the range of 'Int64'.
     */
    public func toMicroseconds(): Int64 {
        if (let Some(result) <- getResult(US_PER_SEC)) {
            return result
        }
        throw ArithmeticException("The duration in microsecond exceeds the range of 'Int64'.")
    }

    /**
     * Obtain the integer size of the current Duration instance in milliseconds.
     *
     * @return Int64 - Integer size in milliseconds, rounded up to the smaller absolute value.
     *
     * @throws ArithmeticException - if the duration in millisecond exceeds the range of 'Int64'.
     */
    public func toMilliseconds(): Int64 {
        if (let Some(result) <- getResult(MS_PER_SEC)) {
            return result
        }
        throw ArithmeticException("The duration in millisecond exceeds the range of 'Int64'.")
    }

    /**
     * Obtain the integer size of the current Duration instance in seconds.
     *
     * @return Int64 - Integer size in seconds, rounded up to the smaller absolute value.
     */
    public func toSeconds(): Int64 {
        return getRealSecond()
    }

    /**
     * Obtain the integer size of the current Duration instance in minutes.
     *
     * @return Int64 - Integer size in minutes, rounded up to the smaller absolute value.
     */
    public func toMinutes(): Int64 {
        return getRealSecond() / SECS_PER_MINUTE
    }

    /**
     * Obtain the integer size of the current Duration instance in hours.
     *
     * @return Int64 - Integer size in hours, rounded up to the smaller absolute value.
     */
    public func toHours(): Int64 {
        return getRealSecond() / SECS_PER_HOUR
    }

    /**
     * Obtain the integer size of the current Duration instance in days.
     *
     * @return Int64 - Integer size in days, rounded up to the smaller absolute value.
     */
    public func toDays(): Int64 {
        return getRealSecond() / SECS_PER_DAY
    }

    private func getRealSecond(): Int64 {
        if (sec < 0 && ns > 0u32) {
            return sec + 1
        }
        return sec
    }
    /**
     * Obtain the string representation of the current Duration instance.
     *
     * @return String - The string representation of Duration
     *
     * The format is as follows: "1d2h3m4s5ms6us7ns".
     * If the value of a unit is 0, this item is omitted.
     * when the value of all units is 0, "0s" is returned.
     */
    public func toString(): String {
        return match {
            case this == Zero => "0s"
            case this == Min => "-106751991167300d15h30m8s"
            case this == Max => "106751991167300d15h30m7s999ms999us999ns"
            case _ =>
                var (secs, nanos) = toSameSign()
                let sb = if (secs < 0 || nanos < 0) {
                    (secs, nanos) = (-secs, -nanos)
                    StringBuilder(r'-')
                } else {
                    StringBuilder()
                }
                let days = secs / SECS_PER_DAY
                let hours = secs % SECS_PER_DAY / SECS_PER_HOUR
                let minutes = secs % SECS_PER_HOUR / SECS_PER_MINUTE
                let seconds = secs % SECS_PER_MINUTE
                sb.append(days, "d").append(hours, "h").append(minutes, "m").append(seconds, "s")
                let milliseconds = nanos / NS_PER_MS
                let microseconds = nanos % NS_PER_MS / NS_PER_US
                let nanoseconds = nanos % NS_PER_US
                sb.append(milliseconds, "ms").append(microseconds, "us").append(nanoseconds, "ns")
                return sb.toString()
        }
    }

    /**
     * Obtain the hash value of the current Duration instance.
     *
     * @return Int64 - Hash value of the current Duration instance.
     */
    public func hashCode(): Int64 {
        var dfh: DefaultHasher = DefaultHasher()
        dfh.write(this.sec)
        dfh.write(this.ns)
        dfh.finish()
    }

    /**
     * Obtain the duration instance for the absolute value of the interval of the current duration instance.
     *
     * @return Duration - The duration instance for the absolute value of the interval of the current instance.
     *
     * @throws ArithmeticException - If the absolute value is out of range for 'Duration'.
     */
    public func abs(): Duration {
        let (second, nanosecond) = toSameSign()
        if (second == Int64.Min) {
            throw ArithmeticException("Out of range of representation of 'Duration'!")
        }
        if (second < 0 || nanosecond < 0) {
            return Duration(-second, UInt32(-nanosecond))
        }
        return Duration(second, UInt32(nanosecond))
    }

    /**
     * Add with another duration.
     *
     * @param r - Another duration.
     * @return Duration - New duration instance after addition.
     *
     * @throws ArithmeticException - If the sum in nanoseconds is out of range for 'Duration'.
     *
     * @since 0.18.2
     */
    public operator func +(r: Duration): Duration {
        if ((r.sec | Int64(r.ns)) == 0) {
            return this
        }
        if (isSumOverflow(this.sec, r.sec)) {
            throw ArithmeticException("Out of range of representation of 'Duration'!")
        }
        return Duration.of(this.sec + r.sec, Int64(this.ns) + Int64(r.ns))
    }

    /**
     * Subtract another duration.
     *
     * @param r - Another duration.
     * @return Duration - New duration instance after subtraction.
     *
     * @throws ArithmeticException - If the subtracted Value in nanoseconds is out of range for 'Duration'.
     *
     * @since 0.18.2
     */
    public operator func -(r: Duration): Duration {
        if ((r.sec | Int64(r.ns)) == 0) {
            return this
        }
        if (checkSub(this.sec, r.sec)) {
            throw ArithmeticException("Out of range of representation of 'Duration'!")
        }
        return Duration.of(this.sec - r.sec, Int64(this.ns) - Int64(r.ns))
    }

    /**
     * Multiply by the specified 'Int64' value.
     *
     * @param r - The specified 'Int64' value to multiply.
     * @return Duration - New duration instance after multiplication.
     *
     * @throws ArithmeticException If the multiplied value in nanoseconds is out of range for 'Duration'.
     *
     * @since 0.18.2
     */
    public operator func *(r: Int64): Duration {
        if (this == Zero || r == 0) {
            return Zero
        } else if (r == -1 && this != Min) {
            let (secs, nanos) = toSameSign()
            return Duration.of(-secs, -nanos)
        } else if (r == 1) {
            return this
        } else if (this == Min || this == Max) {
            throw ArithmeticException("Out of range of representation of 'Duration'!")
        }
        let (secU64, nsU32, multiplier, sign) = toUnsignedNum(r)
        if (let Some(v) <- durMul(secU64, nsU32, multiplier, sign)) {
            return v
        }
        throw ArithmeticException("Out of range of representation of 'Duration'!")
    }

    /**
     * Multiply by the specified 'Float64' value.
     *
     * @param r - The specified 'Float64' value to multiply.
     * @return Duration - New duration instance after multiplication.
     *
     * @throws IllegalArgumentException - If the value of @p r is NaN(not a number).
     * @throws ArithmeticException - If the multiplied value in nanoseconds is out of range for 'Duration'.
     *
     * @since 0.18.2
     */
    public operator func *(r: Float64): Duration {
        if (this == Zero || r == FLOAT64_0) {
            return Zero
        } else if (r == FLOAT64_1) {
            return this
        } else if (r != r) {
            throw IllegalArgumentException("The value of operand cannot be Float64.NaN(not a number)!")
        }

        let result = this.toFloat64Nanoseconds() * r
        return getDurationByFloat64(result).getOrThrow(
            {=> ArithmeticException("Out of range of representation of 'Duration'!")})
    }

    func toFloat64Nanoseconds(): Float64 {
        return Float64(sec) * Float64(NS_PER_SEC) + Float64(ns)
    }

    private func getDurationByFloat64(ns_f64: Float64): Option<Duration> {
        return if (ns_f64 < MAX_NS_FLOAT64 && ns_f64 > MIN_NS_FLOAT64) {
            let second = Int64(ns_f64 / Float64(NS_PER_SEC))
            let nanos: Int64 = Int64(ns_f64 - Float64(second) * Float64(NS_PER_SEC))
            Duration.of(second, nanos)
        } else if (ns_f64 == MAX_NS_FLOAT64) {
            Duration.Max
        } else if (ns_f64 == MIN_NS_FLOAT64) {
            Duration.Min
        } else {
            None
        }
    }

    /**
     * Divide by the specified 'Int64' value.
     *
     * @param r - the specified 'Int64' value.
     * @return Duration - New instance after division.
     *
     * @throws IllegalArgumentException - If the value of @p r is 0.
     * @throws ArithmeticException - If the divided value in nanoseconds is out of range for 'Duration'.
     */
    public operator func /(r: Int64): Duration {
        if (r == 0) {
            throw IllegalArgumentException("The value of right operand cannot be 0!")
        } else if (r == 1) {
            return this
        }
        if (this == Min && r == -1) {
            throw ArithmeticException("Out of range of representation of 'Duration'!")
        }
        let (secU64, nsU32, divisor, sign) = toUnsignedNum(r)
        if (divisor <= 0xFFFF_FFFF) {
            let nanos = UInt64(nsU32)
            let (seconds, extraSec) = (secU64 / divisor, secU64 % divisor)
            var nanoseconds = nanos / divisor
            let extraNs = nanos % divisor
            nanoseconds += ((extraSec * UInt64(NS_PER_SEC) + extraNs) / divisor)
            if (sign) {
                return Duration.of(Int64(seconds), Int64(nanoseconds))
            }
            return Duration.of(-Int64(seconds), -Int64(nanoseconds))
        }
        let (seconds, nanoseconds) = durDiv(secU64, nsU32, divisor)
        if (sign) {
            return Duration(seconds, UInt32(nanoseconds))
        }
        return Duration.of(-seconds, -nanoseconds)
    }

    /**
     * Divide by the specified 'Float64' value.
     *
     * @param r - the specified 'Float64' value.
     * @return Duration - New instance after division.
     *
     * @throws IllegalArgumentException - If the value of @p r is 0 or NaN(not a number).
     * @throws ArithmeticException - If the divided value in nanoseconds is out of the range for 'Duration'.
     */
    public operator func /(r: Float64): Duration {
        if (this == Zero) {
            return Zero
        }
        if (r == FLOAT64_0) {
            throw IllegalArgumentException("The value of right operand cannot be 0.0!")
        } else if (r == FLOAT64_1) {
            return this
        } else if (r != r) {
            throw IllegalArgumentException("The value of right operand cannot be Float64.NaN(not a number)!")
        }
        let result = this.toFloat64Nanoseconds() / r
        return getDurationByFloat64(result).getOrThrow(
            {=> ArithmeticException("Out of range of representation of 'Duration'!")})
    }

    /**
     * Divide by another duration.
     *
     * @param r - Another duration.
     * @return Float64 - The divided 'Float64' value.
     *
     * @throws IllegalArgumentException - If @p r is Duration.Zero.
     */
    public operator func /(r: Duration): Float64 {
        if (r == Zero) {
            throw IllegalArgumentException("The value of right operand cannot be Duration.Zero!")
        }
        return this.toFloat64Nanoseconds() / r.toFloat64Nanoseconds()
    }

    /**
     * Report whether it is equal to another Duration.
     *
     * @param r another duration.
     * @return true if equal @p r, otherwise false.
     *
     * @since 0.18.2
     */
    public operator func ==(r: Duration): Bool {
        return this.sec == r.sec && this.ns == r.ns
    }

    /**
     * Report whether it is not equal to another Duration.
     *
     * @param r another duration.
     * @return true if not equal @p r, otherwise false.
     *
     * @since 0.18.2
     */
    public operator func !=(r: Duration): Bool {
        return !(this == r)
    }

    /**
     * Report whether it is greater than or equal to another Duration.
     *
     * @param r another duration.
     * @return true if greater than or equal to @p r, otherwise false.
     *
     * @since 0.18.2
     */
    public operator func >=(r: Duration): Bool {
        return if (this.sec == r.sec) {
            this.ns >= r.ns
        } else if (this.sec < r.sec) {
            false
        } else {
            true
        }
    }

    /**
     * Report whether it is greater than another Duration.
     *
     * @param r another duration.
     * @return true if greater than @p r, otherwise false.
     *
     * @since 0.18.2
     */
    public operator func >(r: Duration): Bool {
        return if (this.sec == r.sec) {
            this.ns > r.ns
        } else if (this.sec < r.sec) {
            false
        } else {
            true
        }
    }

    /**
     * Report whether it is less than or equal to another Duration.
     *
     * @param r another duration.
     * @return true if less than or equal to @p r, otherwise false.
     *
     * @since 0.18.2
     */
    public operator func <=(r: Duration): Bool {
        return !(this > r)
    }

    /**
     * Report whether it is less than another Duration.
     *
     * @param r another duration.
     * @return true if less than @p r, otherwise false.
     *
     * @since 0.18.2
     */
    public operator func <(r: Duration): Bool {
        return !(this >= r)
    }

    /**
     * Compare the relationship between the current duration instance and another duration instance.
     *
     * @param rhs - Another duration instance for comparison
     * @return Ordering - Indicating the relationship between two duration instances.
     */
    public func compare(rhs: Duration): Ordering {
        return match {
            case this < rhs => Ordering.LT
            case this > rhs => Ordering.GT
            case _ => Ordering.EQ
        }
    }

    @OverflowWrapping
    func toUnsignedNum(r: Int64): (UInt64, UInt32, UInt64, Bool) {
        var sign = r > 0
        let (secs, nanos) = toSameSign()
        let rOperand = if (sign) {
            UInt64(r)
        } else {
            UInt64(-r)
        }
        if (this > Zero) {
            return (UInt64(secs), UInt32(nanos), rOperand, sign)
        } else {
            return (UInt64(-secs), UInt32(-nanos), rOperand, !sign)
        }
    }

    private func getResult(div: Int64): ?Int64 {
        let (second, nanosecond) = toSameSign()
        if (second > 0 && second > (Int64.Max - nanosecond) / div) {
            return None
        } else if (second < 0 && second < (Int64.Min - nanosecond) / div) {
            return None
        }
        return second * div + nanosecond * div / NS_PER_SEC
    }

    private func toSameSign(): (Int64, Int64) {
        var second = this.sec
        var nanosecond = Int64(this.ns)
        if (second < 0 && nanosecond > 0) {
            second += 1
            nanosecond -= NS_PER_SEC
        }
        return (second, nanosecond)
    }
}

func durMul(secs: UInt64, nanos: UInt32, multiplier: UInt64, sign: Bool): ?Duration {
    let (count, nanoseconds) = u32MulU64(nanos, multiplier)
    var seconds: UInt64
    if (secs == 0u64) {
        seconds = count
    } else {
        match (tryU64Mul(secs, multiplier)) {
            case Some(v) => seconds = v
            case None => return None
        }
        match (tryU64Add(seconds, count)) {
            case Some(v) => seconds = v
            case None => return None
        }
        // sign: +, second < SECS_MAX
        // sign: -, second = SECS_MAX, nanoseconds = 0 || second <= SECS_MAX
        // seconds is not over than SECS_MAX
        if (seconds == SECS_MAX) {
            if (!sign && nanoseconds == 0) {
                return Duration.Min
            }
            return None
        }
    }
    if (sign) {
        return Duration(Int64(seconds), nanoseconds)
    }
    return Duration.of(-Int64(seconds), -Int64(nanoseconds))
}

func u32MulU64(thisInt: UInt32, thatInt: UInt64): (UInt64, UInt32) {
    let thatLow32: UInt32 = thatInt % DUR_BASE
    let thatHigh32: UInt64 = thatInt / UInt64(NS_PER_SEC)
    let res: UInt64 = UInt64(thisInt) * UInt64(thatLow32)
    let second: UInt64 = thisInt * thatHigh32 + (res / UInt64(NS_PER_SEC))
    let nanosecond: UInt32 = res % DUR_BASE
    return (second, nanosecond)
}

func tryU64Mul(left: UInt64, right: UInt64): ?UInt64 {
    if (left == 0u64) {
        return 0u64
    }
    if (right > SECS_MAX / left) {
        return None
    }
    return left * right
}

func tryU64Add(left: UInt64, right: UInt64): ?UInt64 {
    if (right > SECS_MAX - left) {
        return None
    }
    return left + right
}

// return true if overflow
func checkSub(left: Int64, right: Int64): Bool {
    return (right > 0 && left <= Int64.Min + right) || (right < 0 && left >= Int64.Max + right)
}

func toSecNsBase(num: UInt64): (UInt32, UInt32, UInt32) {
    let res0 = num % DUR_BASE
    let res1 = num / DUR_BASE % DUR_BASE
    let res2 = num / DUR_BASE / DUR_BASE
    return (UInt32(res2), res1, res0)
}

func durDiv(secs: UInt64, nanos: UInt32, divisor: UInt64): (Int64, Int64) {
    let (divisor2, divisor1, divisor0) = toSecNsBase(divisor)
    let (sec2, sec1, sec0) = toSecNsBase(secs)
    if (divisor2 == 0) {
        let times = DUR_BASE / (divisor1 + 1)
        var (ds1, ds0) = (divisor1, divisor0)
        let (dd4, dd3, dd2, dd1, dd0) = if (times == 1) {
            (UInt32(0), sec2, sec1, sec0, nanos)
        } else {
            (_, ds1, ds0) = u32TwoMul(divisor1, divisor0, times)
            u32DividendMul(sec2, sec1, sec0, nanos, times)
        }
        let dividend2 = UInt64(dd4) * DUR_BASE + UInt64(dd3)
        let res2 = divAndMod(dividend2, dd2, ds1, ds0)
        var (p2, p1, p0) = u32TwoMul(ds1, ds0, res2)
        var (c2, c1, c0) = (Int64(dd4) - Int64(p2), Int64(dd3) - Int64(p1), Int64(dd2) - Int64(p0))
        var (_, d1, d0) = getDifference(c2, c1, c0)
        let dividend1 = UInt64(d1) * DUR_BASE + UInt64(d0)
        let res1 = divAndMod(dividend1, dd1, ds1, ds0)
        (p2, p1, p0) = u32TwoMul(ds1, ds0, res1)
        (c2, c1, c0) = (Int64(d1) - Int64(p2), Int64(d0) - Int64(p1), Int64(dd1) - Int64(p0))
        (_, d1, d0) = getDifference(c2, c1, c0)
        let dividend0 = UInt64(d1) * DUR_BASE + UInt64(d0)
        let res0 = divAndMod(dividend0, dd0, ds1, ds0)
        return (Int64(res2) * NS_PER_SEC + Int64(res1), Int64(res0))
    } else {
        let times = DUR_BASE / UInt32(divisor2 + 1)
        let (dd4, dd3, dd2, dd1, dd0) = u32DividendMul(sec2, sec1, sec0, nanos, times)
        let (_, ds2, ds1, ds0) = u32ThreeMul(divisor2, divisor1, divisor0, times)
        let dividend2 = UInt64(dd4) * DUR_BASE + UInt64(dd3)
        var res1 = divAndMod(dividend2, dd2, ds2, ds1)
        var (p3, p2, p1, p0) = u32ThreeMul(ds2, ds1, ds0, res1)
        var (c3, c2, c1, c0) = (Int64(dd4) - Int64(p3), Int64(dd3) - Int64(p2), Int64(dd2) - Int64(p1), Int64(dd1) - Int64(p0))
        var (d3, d2, d1, d0) = getDifference(c3, c2, c1, c0)
        if (d3 < 0) {
            res1--
            (p3, p2, p1, p0) = u32ThreeMul(ds2, ds1, ds0, res1)
            (c3, c2, c1, c0) = (Int64(dd4) - Int64(p3), Int64(dd3) - Int64(p2), Int64(dd2) - Int64(p1), Int64(dd1) - Int64(p0))
            (d3, d2, d1, d0) = getDifference(c3, c2, c1, c0)
        }
        let dividend1 = UInt64(d2) * DUR_BASE + UInt64(d1)
        var res0 = divAndMod(dividend1, UInt32(d0), ds2, ds1)
        (p3, p2, p1, p0) = u32ThreeMul(ds2, ds1, ds0, res0)
        (c3, c2, c1, c0) = (Int64(d2) - Int64(p3), Int64(d1) - Int64(p2), Int64(d0) - Int64(p1), Int64(dd0) - Int64(p0))
        (d3, d2, d1, d0) = getDifference(c3, c2, c1, c0)
        if (d3 < 0) { res0-- }
        return (Int64(res1), Int64(res0))
    }
}

func getDifference(num3: Int64, num2: Int64, num1: Int64, num0: Int64): (Int64, Int64, Int64, Int64) {
    var (res3, res2, res1, res0) = (num3, num2, num1, num0)
    if (res0 < 0) {
        res1--
        res0 += NS_PER_SEC
    }
    if (res1 < 0) {
        res2--
        res1 += NS_PER_SEC
    }
    if (res2 < 0) {
        res3--
        res1 += NS_PER_SEC
    }
    return (res3, res2, res1, res0)
}

func getDifference(num2: Int64, num1: Int64, num0: Int64): (UInt32, UInt32, UInt32) {
    var (res2, res1, res0) = (num2, num1, num0)
    if (res0 < 0) {
        res1--
        res0 += NS_PER_SEC
    }
    if (res1 < 0) {
        res2--
        res1 += NS_PER_SEC
    }
    return (UInt32(res2), UInt32(res1), UInt32(res0))
}

func u32TwoMul(num1: UInt32, num0: UInt32, multiplier: UInt32): (UInt32, UInt32, UInt32) {
    var res0: UInt64 = UInt64(num0) * UInt64(multiplier)
    var res1: UInt64 = UInt64(num1) * UInt64(multiplier) + res0 / DUR_BASE
    var res2: UInt64 = res1 / DUR_BASE
    return (UInt32(res2), res1 % DUR_BASE, res0 % DUR_BASE)
}

func u32ThreeMul(num2: UInt32, num1: UInt32, num0: UInt32, multiplier: UInt32): (UInt32, UInt32, UInt32, UInt32) {
    var res0: UInt64 = UInt64(num0) * UInt64(multiplier)
    var res1: UInt64 = UInt64(num1) * UInt64(multiplier) + res0 / DUR_BASE
    var res2: UInt64 = UInt64(num2) * UInt64(multiplier) + res1 / DUR_BASE
    var res3: UInt64 = res2 / DUR_BASE
    return (UInt32(res3), res2 % DUR_BASE, res1 % DUR_BASE, res0 % DUR_BASE)
}

func u32DividendMul(num3: UInt32, num2: UInt32, num1: UInt32, num0: UInt32, times: UInt32): (UInt32, UInt32, UInt32, 
    UInt32, UInt32) {
    // the place is 10^9
    var res0: UInt64 = UInt64(num0) * UInt64(times)
    var res1: UInt64 = UInt64(num1) * UInt64(times) + res0 / DUR_BASE
    var res2: UInt64 = UInt64(num2) * UInt64(times) + res1 / DUR_BASE
    var res3: UInt64 = UInt64(num3) * UInt64(times) + res2 / DUR_BASE
    var res4: UInt64 = res3 / DUR_BASE
    return (UInt32(res4), res3 % DUR_BASE, res2 % DUR_BASE, res1 % DUR_BASE, res0 % DUR_BASE)
}

func divAndMod(dividend: UInt64, dividend2: UInt32, divisor2: UInt32, divisor1: UInt32): (UInt32) {
    var discuss = dividend / divisor2
    var remainder = dividend % divisor2
    if (discuss != UInt64(DUR_BASE) && discuss * divisor1 <= UInt64(remainder) * UInt64(DUR_BASE) + UInt64(dividend2)) {
        return (UInt32(discuss))
    }
    while (remainder < DUR_BASE) {
        if (discuss == UInt64(DUR_BASE) || discuss * divisor1 > UInt64(remainder) * UInt64(DUR_BASE) + UInt64(dividend2)) {
            discuss--
            remainder += divisor2
        }
    }
    return (UInt32(discuss))
}

extend Int64 {
    /**
     * Multiply by a duration Instance.
     *
     * @param r - a duration Instance.
     * @return Duration - New duration instance after multiplication.
     *
     * @throws ArithmeticException - If the multiplied value in nanoseconds is out of range for 'Duration'.
     */
    public operator func *(r: Duration): Duration {
        return r * this
    }
}

extend Int64 {
    operator func -(r: UInt32): Int64 {
        return this - Int64(r)
    }
}

extend UInt64 {
    operator func *(r: UInt32): UInt64 {
        return this * UInt64(r)
    }

    operator func /(r: UInt32): UInt64 {
        return this / UInt64(r)
    }

    operator func %(r: UInt32): UInt32 {
        return UInt32(this % UInt64(r))
    }
}

extend UInt32 {
    operator func *(r: UInt64): UInt64 {
        return UInt64(r) * this
    }
}

extend Float64 {
    /**
     * Multiply by a duration Instance.
     *
     * @param r - a duration Instance.
     * @return Duration - New duration instance after multiplication.
     *
     * @throws ArithmeticException - If the multiplied value in nanoseconds is out of range for 'Duration'.
     */
    public operator func *(r: Duration): Duration {
        return r * this
    }
}

extend StringBuilder {
    func append(num: Int64, unit: String): StringBuilder {
        if (num != 0) {
            this.append(num)
            this.append(unit)
        }
        return this
    }
}

func isSumOverflow(left: Int64, right: Int64): Bool {
    return (right > 0 && left > MAX_INT64 - right) || (right < 0 && left < MIN_INT64 - right)
}
