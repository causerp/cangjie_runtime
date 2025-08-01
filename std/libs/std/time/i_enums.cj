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
 * This file defines IEnum related classes.
 */

package std.time


let SHORT_DAY_OF_WEEK_FORM = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
let LONG_DAY_OF_WEEK_FORM = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]

public enum DayOfWeek <: ToString & Equatable<DayOfWeek> {
    Sunday | Monday | Tuesday | Wednesday | Thursday | Friday | Saturday

    /**
     * Generates a instance of DayOfWeek according to a Int64 value.
     *
     * @param wday a number represents a DayOfWeek.
     * @return a Result if success to generate a DayOfWeek based on wday, otherwise Failure.
     *
     * @throws IllegalArgumentException if dayOfWeek is out of range [0, 6]
     *
     * @since 0.18.4
     */
    public static func of(dayOfWeek: Int64): DayOfWeek {
        return match (dayOfWeek) {
            case 0 => Sunday
            case 1 => Monday
            case 2 => Tuesday
            case 3 => Wednesday
            case 4 => Thursday
            case 5 => Friday
            case 6 => Saturday
            case _ => throw IllegalArgumentException("The input parameter ranges from 0 to 6")
        }
    }

    /**
     * Return Int64 value of the DayOfWeek instance.
     *
     * @return a number represents the DayOfWeek.
     *
     * @since 0.18.4
     */
    @Deprecated[message: "Use member function `public func toInteger(): Int64` instead."]
    public func value(): Int64 {
        toInteger()
    }

    public func toInteger(): Int64 {
        return match (this) {
            case Sunday => 0
            case Monday => 1
            case Tuesday => 2
            case Wednesday => 3
            case Thursday => 4
            case Friday => 5
            case Saturday => 6
        }
    }

    /**
     * Return a String that represents the DayOfWeek, for example, Friday.
     *
     * @return a DayOfWeek name.
     *
     * @since 0.18.4
     */
    public func toString(): String {
        return LONG_DAY_OF_WEEK_FORM[this.toInteger()]
    }

    /**
     * Override the == operator, determines whether this DayOfWeek equals another.
     *
     * @param r another DayOfWeek.
     * @return true if the DayOfWeek is equal to @p r, otherwise false.
     *
     * @since 0.18.4
     */
    public operator func ==(r: DayOfWeek): Bool {
        return this.toInteger() == r.toInteger()
    }

    /**
     * Override the != operator, determines whether this DayOfWeek is not equal to another.
     *
     * @param r another DayOfWeek.
     * @return true if the DayOfWeek is not equal to @p r, otherwise false.
     *
     * @since 0.18.4
     */
    public operator func !=(r: DayOfWeek): Bool {
        return this.toInteger() != r.toInteger()
    }

    public operator func +(n: Int64): DayOfWeek {
        return DayOfWeek.of((this.toInteger() + n % DAYS_PER_WEEK + DAYS_PER_WEEK) % DAYS_PER_WEEK)
    }

    public operator func -(n: Int64): DayOfWeek {
        return DayOfWeek.of((this.toInteger() - n % DAYS_PER_WEEK + DAYS_PER_WEEK) % DAYS_PER_WEEK)
    }
}

let SHORT_MONTH_FORM = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul",
                        "Aug", "Sep", "Oct", "Nov", "Dec"]
let LONG_MONTH_FORM = ["January", "February", "March", "April", "May", "June", "July",
                       "August", "September", "October", "November", "December"]

public enum Month <: ToString & Equatable<Month> {
    January | February | March | April | May | June
    | July | August | September | October | November | December

    /**
     * Generates a instance of Month according to a Int64 value.
     *
     * @param mon a number represents a Month.
     * @return a Result if success to generate a Month based on mon, otherwise Failure.
     *
     * @throws IllegalArgumentException if mon is out of range [1, 12]
     *
     * @since 0.18.4
     */
    public static func of(mon: Int64): Month {
        return match (mon) {
            case 1 => January
            case 2 => February
            case 3 => March
            case 4 => April
            case 5 => May
            case 6 => June
            case 7 => July
            case 8 => August
            case 9 => September
            case 10 => October
            case 11 => November
            case 12 => December
            case _ => throw IllegalArgumentException("The input parameter ranges from 1 to 12")
        }
    }

    /**
     * Return Int64 value of the Month instance.
     *
     * @return a nunber represents the Month.
     *
     * @since 0.18.4
     */
    @Deprecated[message: "Use member function `public func toInteger(): Int64` instead."]
    public func value(): Int64 {
        toInteger()
    }

    public func toInteger(): Int64 {
        return match (this) {
            case January => 1
            case February => 2
            case March => 3
            case April => 4
            case May => 5
            case June => 6
            case July => 7
            case August => 8
            case September => 9
            case October => 10
            case November => 11
            case December => 12
        }
    }

    /**
     * Return a String that represents the Month, for example, June.
     *
     * @return a month name.
     *
     * @since 0.18.4
     */
    public func toString(): String {
        return LONG_MONTH_FORM[this.toInteger() - 1]
    }

    /**
     * Override the + operator.
     *
     * @param n delta.
     * @return a new Month after adding @p n to this Month.
     * @since 0.18.4
     */
    public operator func +(n: Int64): Month {
        return Month.of((this.toInteger() - 1 + n % MONTHS_PER_YEAR + MONTHS_PER_YEAR) % MONTHS_PER_YEAR + 1)
    }

    /**
     * Override the - operator.
     *
     * @param n delta.
     * @return a new Month after subtracting @p n from this Month.
     * @since 0.18.4
     */
    public operator func -(n: Int64): Month {
        return Month.of((this.toInteger() - 1 - n % MONTHS_PER_YEAR + MONTHS_PER_YEAR) % MONTHS_PER_YEAR + 1)
    }

    /**
     * Override the == operator, determines whether this Month equals another.
     *
     * @param r another Month.
     * @return true if the Month is equal to @p r, otherwise false
     *
     * @since 0.18.4
     */
    public operator func ==(r: Month): Bool {
        return this.toInteger() == r.toInteger()
    }

    /**
     * Override the != operator, determines whether this Month is not equal to another.
     *
     * @param r another Month.
     * @return true if the Month is not equal to @p r, otherwise false.
     *
     * @since 0.18.4
     */
    public operator func !=(r: Month): Bool {
        return this.toInteger() != r.toInteger()
    }
}
