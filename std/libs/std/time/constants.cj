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
 * This file defines some time constants.
 */

package std.time

const MIN_INT64: Int64 = -0x8000000000000000
const MAX_INT64: Int64 = 0x7FFFFFFFFFFFFFFF
const MAX_YEAR: Int64 = 999999999
const MIN_YEAR: Int64 = -999999999
const MAX_NANOSECOND: Int64 = 999999999
const MONTHS_PER_YEAR: Int64 = 12
const DAYS_PER_WEEK: Int64 = 7
const DAYS_OF_NORMAL_YEAR: Int64 = 365
const DAYS_OF_LEAP_YEAR: Int64 = 366
const DAYS_PER_400YEARS: Int64 = DAYS_OF_NORMAL_YEAR * 400 + 97
const DAYS_PER_100YEARS: Int64 = DAYS_OF_NORMAL_YEAR * 100 + 24
const DAYS_PER_4YEARS: Int64 = DAYS_OF_NORMAL_YEAR * 4 + 1
const HOURS_PER_DAY: Int64 = 24
const MINUTES_PER_HOUR: Int64 = 60
const SECS_PER_MINUTE: Int64 = 60
const SECS_PER_HOUR: Int64 = SECS_PER_MINUTE * MINUTES_PER_HOUR
const SECS_PER_DAY: Int64 = HOURS_PER_DAY * SECS_PER_HOUR
const SECS_PER_WEEK: Int64 = DAYS_PER_WEEK * SECS_PER_DAY
const MS_PER_SEC: Int64 = 1000
const US_PER_MS: Int64 = 1000
const NS_PER_US: Int64 = 1000
const US_PER_SEC: Int64 = MS_PER_SEC * US_PER_MS
const NS_PER_MS: Int64 = US_PER_MS * NS_PER_US
const NS_PER_SEC: Int64 = MS_PER_SEC * US_PER_MS * NS_PER_US
const NS_PER_MINUTE: Int64 = SECS_PER_MINUTE * NS_PER_SEC
const NS_PER_HOUR: Int64 = SECS_PER_HOUR * NS_PER_SEC
const NS_PER_DAY: Int64 = HOURS_PER_DAY * NS_PER_HOUR
const SECS_OF_NORMAL_YEAR: Int64 = DAYS_OF_NORMAL_YEAR * SECS_PER_DAY
const SECS_OF_LEAP_YEAR: Int64 = DAYS_OF_LEAP_YEAR * SECS_PER_DAY
const HOUR_12_INTERVAL: Int64 = 12
const HOUR_12_START: Int64 = 12
const HOUR_12_END: Int64 = 12
const HOUR_24_START: Int64 = 0
const HOUR_24_NOON: Int64 = 12

/**
 * Year AD 1 is the start of Anno Domini (AD) calendar year system.
 */
const START_AD_YEAR: Int64 = 1

/**
 * Days from year AD 1 to unix zero year.
 */
const DAYS_OF_UNIX_TO_AD1: Int64 = 1969 * 365 + 1969 / 4 - 1969 / 100 + 1969 / 400

/**
 * Seconds from year AD 1 to unix zero year.
 */
const SECS_OF_UNIX_TO_AD1: Int64 = DAYS_OF_UNIX_TO_AD1 * SECS_PER_DAY

/**
 * Days from year AD 1 to max year.
 */
const DAYS_OF_MAX_TO_AD1: Int64 = (MAX_YEAR - 1) * 365 + (MAX_YEAR - 1) / 4 - (MAX_YEAR - 1) / 100 + (MAX_YEAR - 1) / 400 +
    365

/**
 * Seconds from year AD 1 to max year.
 */
const SECS_OF_MAX_TO_AD1: Int64 = DAYS_OF_MAX_TO_AD1 * SECS_PER_DAY

/**
 * Days from year AD 1 to min year.
 */
const DAYS_OF_MIN_TO_AD1: Int64 = -(DAYS_OF_MAX_TO_AD1 + 366)

/**
 * Seconds from year AD 1 to min year.
 */
const SECS_OF_MIN_TO_AD1: Int64 = DAYS_OF_MIN_TO_AD1 * SECS_PER_DAY

/**
 * Days from January to March in leap year.
 */
const DAYS_OF_JAN_TO_MARCH_LEAP: Int64 = 60

/**
 * 0,
 * 31,
 * 31 + 28,
 * 31 + 28 + 31,
 * 31 + 28 + 31 + 30,
 * 31 + 28 + 31 + 30 + 31,
 * 31 + 28 + 31 + 30 + 31 + 30,
 * 31 + 28 + 31 + 30 + 31 + 30 + 31,
 * 31 + 28 + 31 + 30 + 31 + 30 + 31 + 31,
 * 31 + 28 + 31 + 30 + 31 + 30 + 31 + 31 + 30,
 * 31 + 28 + 31 + 30 + 31 + 30 + 31 + 31 + 30 + 31,
 * 31 + 28 + 31 + 30 + 31 + 30 + 31 + 31 + 30 + 31 + 30,
 * 31 + 28 + 31 + 30 + 31 + 30 + 31 + 31 + 30 + 31 + 30 + 31,
 */
let DAYS_BEFORE: Array<Int64> = [0, 31, 59, 90, 120, 151, 181, 212, 243, 273, 304, 334, 365]
let DAYS_OF_MONTH: Array<Int64> = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
const MAX_OFFSET = 25 * 60 * 60 + 59 * 60 + 59
const MIN_OFFSET = -(24 * 60 * 60 + 59 * 60 + 59)
const YEAR_OUT_OF_RANGE: String = "The result of year is outside the range [-999,999,999, 999,999,999]."
const MAX_UTC_SECS = SECS_OF_MAX_TO_AD1 - MIN_OFFSET
const MIN_UTC_SECS = SECS_OF_MIN_TO_AD1 - MAX_OFFSET
