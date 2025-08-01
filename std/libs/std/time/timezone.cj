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
 * This file defines TimeZone related classes.
 */

package std.time

import std.convert.*


@When[os == "Windows"]
const SEPARATOR = ";"
@When[os == "Windows"]
const SLASH_CHAR = "\\"

@When[os != "Windows"]
const SEPARATOR = ":"
@When[os != "Windows"]
const SLASH_CHAR = "/"

let TZIF_SOURCE: Array<String> = ["/usr/share/zoneinfo", "/system/etc/zoneinfo"]

const TZIF_SOUTCE_LINUX = "/usr/share/zoneinfo/"

const LOCALTIME_SRC: String = "/etc/localtime"

const TZPATH = "CJ_TZPATH"

const MAXPATHLEN = 4096

@FastNative
foreign func CJ_TIME_GetEnvVariable(id: CString): CString

enum RuleType {
    | JulianDay /* Jn = Julian day */
    | DayOfYear /* n = day of year */
    | MonthNthDayOfWeek /* Mm.n.d = month, week, day of week */
}

class ZoneRule {
    var rType: RuleType = JulianDay /* type of rule */
    var rDay: Int64 = 0 /* day number of rule */
    var rWeek: Int64 = 0 /* week number of rule */
    var rMon: Int64 = 0 /* month number of rule */
    var rTime: Int64 = 0 /* transition time of rule */

    func parse(footer: String): String {
        if (footer[0] == b'J') {
            let (jday, rest) = getNum(footer[1..])
            if (jday < 1 || jday > 365) {
                throw InvalidDataException("Failed to parse the timezone data.")
            }
            this.rType = JulianDay
            this.rDay = jday
            return rest
        } else if (footer[0] == b'M') {
            var (mon, week, day) = (0, 0, 0)
            var rest = footer
            (mon, rest) = getNum(rest[1..])
            // Months range from 1 to 12
            if (mon < 1 || mon > 12 || rest.size == 0 || rest[0] != b'.') {
                throw InvalidDataException("Failed to parse the timezone data.")
            }
            (week, rest) = getNum(rest[1..])
            // The range of weeks in a month is 1 to 5.
            if (week < 1 || week > 5 || rest.size == 0 || rest[0] != b'.') {
                throw InvalidDataException("Failed to parse the timezone data.")
            }
            (day, rest) = getNum(rest[1..])
            // The number of days in a week ranges from 0 to 6.
            if (day < 0 || day > 6) {
                throw InvalidDataException("Failed to parse the timezone data.")
            }
            this.rType = MonthNthDayOfWeek
            this.rDay = day
            this.rWeek = week
            this.rMon = mon
            return rest
        } else {
            let (day, rest) = getNum(footer)
            if (day < 0 || day > 365) {
                throw InvalidDataException("Failed to parse the timezone data.")
            }
            this.rType = DayOfYear
            this.rDay = day
            return rest
        }
    }
}

class LocalTime {
    /* time zone designation. */
    var des: String = ""

    /* time zone offset. */
    var offset: Int32 = 0

    /* Indicates whether local time should be considered Daylight Saving Time (DST). */
    var isDST: Bool = false

    init() {}

    init(des: String, offset: Int32, isDST: Bool) {
        this.des = des
        this.offset = offset
        this.isDST = isDST
    }
}

class TransTime {
    /* UNIX leap-time values, used as a transition time at which the rules for computing local time may change. */
    var trans: Int64 = Int64.Min

    /*
     * Specify the type of local time of the corresponding transition time.
     * This value serves as zero-based indices into the array of LocalTime.
     */
    var index: UInt8 = 0

    init() {}

    init(trans: Int64, index: UInt8) {
        this.trans = trans
        this.index = index
    }
}

/**
 * The class TimeZone implements the basic functions of the time zone.
 * The time zone data comes from the IANA time zone database file installed in the operating system.
 * The local time zone is determined by the environment variable TZ.
 * If the TZ does not exist, it is determined by the time zone stored in the /etc/localtime file.
 * Otherwise, the host is regarded as the UTC time zone.
 *
 * @since 0.19.3
 */
public class TimeZone <: ToString & Equatable<TimeZone> {
    public static let UTC: TimeZone = TimeZone("UTC", 0)
    public static let Local: TimeZone = initLocal()

    let zoneId: String
    let localTimes: Array<LocalTime>
    let transTimes: Array<TransTime>
    let footer: String /* TZif footer. */

    /* The cache of the last successful lookup, including the start, end, and corresponding zone. */
    var cache: Option<(Int64, Int64, LocalTime)> = None

    public prop id: String {
        get() {
            this.zoneId
        }
    }

    /**
     * Constructs a fixed TimeZone that always uses the given zone id and offset (seconds east of UTC).
     *
     * @param id zone id.
     * @param offset zone offset (seconds east of UTC).
     *
     * @since 0.19.3
     */
    init(id: String, offset: Int32) {
        this.zoneId = id
        this.localTimes = Array<LocalTime>(1, repeat: LocalTime(id, offset, false))
        this.transTimes = Array<TransTime>(1, repeat: TransTime())
        this.footer = ""
    }

    /**
     * Constructs a fixed TimeZone with given zone id and offset.
     *
     * @param id zone id.
     * @param offset zone offset.
     *
     * @throws IllegalArgumentException if TimeZone id is empty.
     * @since 0.19.3
     */
    public init(id: String, offset: Duration) {
        if (id.size == 0) {
            throw IllegalArgumentException("Invalid timezone id.")
        }
        let second = offset.toSeconds()
        if (second < MIN_OFFSET || second > MAX_OFFSET) {
            throw IllegalArgumentException("Invalid offset.")
        }
        this.zoneId = id
        this.localTimes = Array<LocalTime>(1, repeat: LocalTime(id, Int32(second), false))
        this.transTimes = Array<TransTime>(1, repeat: TransTime())
        this.footer = ""
    }

    /*
     * Constructs a TimeZone instance using the given arguments.
     *
     * @param localTimes an array of localTime.
     * @param transTimes an array of zone transition time.
     * @param id zone id.
     * @param footer extend zone id.
     *
     * @throws IllegalArgumentException if TimeZone id is empty.
     * @since 0.19.3
     */
    private init(localTimes: Array<LocalTime>, transTimes: Array<TransTime>, id: String, footer: String) {
        this.zoneId = id
        this.localTimes = localTimes
        this.transTimes = transTimes
        this.footer = footer
        this.cache = (Int64.Min, Int64.Max, localTimes[0])
    }

    /**
     * Loads a TimeZone with the given id.
     * If the id is "UTC", it returns TimeZone.UTC. If the id is "Local", it returns TimeZone.Local.
     * Otherwise, the id is considered the TimeZone id corresponding to the file in the IANA
     * If the CJ_TZPATH environment variable exists, obtain the path from the environment variable first.
     * time zone database, such as "Asia/Shanghai".
     *
     * @param id zone id.
     * @return the TimeZone if success, otherwise an Exception.
     *
     * @throws IllegalArgumentException if TimeZone id is illegal or empty.
     * @throws InvalidDataException if the timezone data cannot be found when a valid environment variable is set
     * @throws InvalidDataException if the TimeZone file fails to be parsed.
     * @throws IllegalMemoryException if failed to call loadTimeZone(cjvm).
     *
     * @since 0.19.3
     */
    public static func load(id: String): TimeZone {
        if (id.size == 0 || id.size > MAXPATHLEN) {
            throw IllegalArgumentException("Invalid timezone id.")
        }
        if (id == "UTC") {
            return UTC
        }
        if (id == "Local") {
            return Local
        }
        if (id.contains("..") || id.contains("\0") || id[0] == b'/' || id[0] == b'\\') {
            throw IllegalArgumentException("Invalid timezone id.")
        }
        var env = unsafe { LibC.mallocCString(TZPATH) }
        let envPath = unsafe { CJ_TIME_GetEnvVariable(env) }
        unsafe { LibC.free(env) }
        var envPathArray = envPath.toString().split(SEPARATOR, removeEmpty: true)
        if (envPathArray.size == 0) {
            return loadFromPaths(id, TZIF_SOURCE)
        }
        if (envPathArray.size == 0) {
            return loadFromPaths(id, TZIF_SOURCE)
        }
        return loadFromPaths(id, envPathArray)
    }

    /**
     * Obtains the TimeZone object based on the given root path and time zone id.
     * This function searches for the timezone data named <id> from the given root path in turn until it is found.

     * @param tzpaths Set of root paths for timezone datas.
     * @param id zone id.
     * @return the TimeZone if success, otherwise an Exception.
     *
     * @throws IllegalArgumentException if TimeZone id is empty.
     * @throws InvalidDataException if the timezone data cannot be found.
     * @throws InvalidDataException if the TimeZone file fails to be parsed.
     * @throws IllegalMemoryException if failed to call loadTimeZone(cjvm).
     *
     * @since 0.35.7
     */
    public static func loadFromPaths(id: String, tzpaths: Array<String>): TimeZone {
        if (id.size == 0 || id.size > MAXPATHLEN) {
            throw IllegalArgumentException("Invalid timezone id.")
        }
        if (id.contains("..") || id.contains("\0") || id[0] == b'/' || id[0] == b'\\') {
            throw IllegalArgumentException("Invalid timezone name.")
        }

        for (tzpath in tzpaths) {
            if (tzpath.size > MAXPATHLEN) {
                continue
            }

            var absPath = tzpath + SLASH_CHAR + id
            let pathLen: Int64 = absPath.size
            unsafe {
                let cPath: CPointerHandle<UInt8> = acquireArrayRawData(absPath.rawData())
                let fileSize = CJ_TIME_GetFileSize(cPath.pointer, pathLen)
                releaseArrayRawData(cPath)
                if (fileSize < 0) {
                    continue
                }
                return loadTimeZone(id, tzpath)
            }
        }
        throw InvalidDataException("No valid timezone file is found.")
    }

    /**
     * Loads a TimeZone with the given id initialized from the IANA Time LocalTime database format data.
     *
     * @param id zone id.
     * @param data IANA Time LocalTime database format data.
     * @return the TimeZone if success, otherwise an Exception.
     *
     * @throws IllegalArgumentException if id is empty.
     * @throws InvalidDataException if the TimeZone data fails to be parsed.
     * @throws IllegalMemoryException if failed to call runtimeNow(cjvm).
     * @since 0.19.3
     */
    public static func loadFromTZData(id: String, data: Array<UInt8>): TimeZone {
        if (id.size == 0) {
            throw IllegalArgumentException("Invalid timezone id.")
        }
        var (tzifLocalTimes, tzifTransTimes, tzifFooter) = parseTZinfoData(data)
        var result: TimeZone = TimeZone(tzifLocalTimes, tzifTransTimes, id, tzifFooter)
        var maxIndex: UInt8 = 0
        for (i in 0..tzifTransTimes.size) {
            if (tzifTransTimes[i].index > maxIndex) {
                maxIndex = tzifTransTimes[i].index
            }
        }
        if (Int64(maxIndex) >= tzifLocalTimes.size) {
            throw InvalidDataException("Failed to parse the timezone file.")
        }
        var temp = result.transTimes
        var (sec, _) = systemNow()
        for (i in 0..temp.size) {
            if (temp[i].trans <= sec && (i + 1 == temp.size || sec < temp[i + 1].trans)) {
                let start = temp[i].trans
                var end = Int64.Max
                if (i + 1 < temp.size) {
                    end = temp[i + 1].trans
                }
                let zone = result.localTimes[Int64(temp[i].index)]
                result.cache = (start, end, zone)
            }
        }
        return result
    }

    /**
     * Return a String that represents the time zone, actually time zone id.
     *
     * @return time zone id.
     *
     * @since 0.19.3
     */
    public func toString(): String {
        return this.zoneId
    }

    /**
     * Override the == operator, determines whether this TimeZone equals another TimeZone.
     *
     * @param r another TimeZone.
     * @return true if the TimeZone is equal to @p r, otherwise false.
     *
     * @since 0.38.2
     */
    public operator func ==(r: TimeZone): Bool {
        return refEq(this, r)
    }

    /**
     * Override the == operator, determines whether this TimeZone is not equal another TimeZone.
     *
     * @param r another TimeZone.
     * @return true if the TimeZone is not equal to @p r, otherwise false.
     *
     * @since 0.38.2
     */
    public operator func !=(r: TimeZone): Bool {
        return !(this == r)
    }

    /**
     * Return information about the time zone used by the UNIX time specified by @p epochSecond.
     *
     * @param epochSecond an instant in time expressed as seconds since January 1, 1970 00:00:00 UTC.
     * @return a tuple containing the name of the zone (such as "CET"), the offset in seconds east of UTC,
     * the start and end time when the time zone takes effect.
     *
     * @since 0.19.3
     */
    func lookup(epochSecond: Int64): (String, Int64, Int64, Int64) {
        match (cache) {
            case Some(v) =>
                let (start, end, zone) = v
                if (start <= epochSecond && epochSecond < end && (end != Int64.Max || footer == "")) {
                    return (zone.des, Int64(zone.offset), start, end)
                }
            case _ => ()
        }

        if (transTimes.size == 0 || epochSecond < transTimes[0].trans) {
            var zone = localTimes[inferZoneIndex()]
            var end = Int64.Max
            if (transTimes.size > 0) {
                end = transTimes[0].trans
            }
            return (zone.des, Int64(zone.offset), Int64.Min, end)
        }

        let (low, end) = binarySearch(epochSecond)
        var zone = localTimes[Int64(transTimes[low].index)]
        var name = zone.des
        var offset = zone.offset
        var start = transTimes[low].trans

        /* If no results are found from the known transition time, try TZif footer. */
        try {
            if (low == transTimes.size - 1 && footer != "") {
                return parseTZ(footer, end, epochSecond)
            }
        } catch (_) {
            return (name, Int64(offset), start, end)
        }
        return (name, Int64(offset), start, end)
    }

    /**
     * Search for the corresponding transTime based on epochSecond.
     *
     * @param epochSecond an instant in time expressed as seconds since January 1, 1970 00:00:00 UTC.
     * @return the index in transTimes and the corresponding transTime.
     *
     * @since 0.38.2
     */
    private func binarySearch(epochSecond: Int64): (Int64, Int64) {
        var end = Int64.Max
        var low = 0
        var high = transTimes.size
        while (high - low > 1) {
            var mid = (low + high) / 2
            var curTime = transTimes[mid].trans
            if (epochSecond < curTime) {
                end = curTime
                high = mid
            } else {
                low = mid
            }
        }
        return (low, end)
    }

    /**
     * Return the time zone index used before or without the first transition time.
     *
     * @return the index of the time zone to use for times before or without the first transition time.
     *
     * @since 0.19.3
     */
    func inferZoneIndex(): Int64 {
        /* If zone 0 is unused in transitions, it's the zone to use for early times. */
        var flag = false
        for (tran in transTimes) {
            if (tran.index == 0) {
                flag = true
                break
            }
        }
        if (!flag) {
            return 0
        }

        /*
         * Absent the above, if there are transition times and the first transition is to a daylight time,
         * find the standard type less than and closest to the zone of the first transition.
         */
        if (transTimes.size > 0 && localTimes[Int64(transTimes[0].index)].isDST) {
            var index = Int64(transTimes[0].index) - 1
            for (zoneIndex in index..=0 : -1) {
                if (!localTimes[zoneIndex].isDST) {
                    return zoneIndex
                }
            }
        }

        /* If no result yet, find the first standard type. */
        for (zoneIndex in 0..localTimes.size) {
            if (!localTimes[zoneIndex].isDST) {
                return zoneIndex
            }
        }

        /* If there is none, punt to zone zero. */
        return 0
    }

    /**
     * Return the offset of the time zone for a given name and unix time.
     * (The unix time is in the UTC time zone).
     *
     * @param name zone name
     * @param unix unix time in second.
     * @return the zone offset.
     *
     * @since 0.19.3
     */
    func lookupName(name: String, unix: Int64): Int64 {
        var offset = Int64.Min
        for (zone in localTimes) {
            if (zone.des == name) {
                if (offset == Int64.Min) {
                    offset = Int64(zone.offset)
                }
                let (des, off, _, _) = lookup(unix - Int64(zone.offset))
                if (des == zone.des) {
                    return off
                }
            }
        }

        if (offset != Int64.Min) {
            return offset
        }

        return MAX_OFFSET + 1
    }
}

/**
 * Given a POSIX section time zone string, the end unix time of the last time zone transition, and a time,
 * return values are similar to that of lookup.
 *
 * @param footer a POSIX section time zone string.
 * @param end the end of the last time zone transition expressed as seconds since 1970.1.1 00:00:00 UTC.
 * @param epochSecond a time expressed the same way as @p end.
 * @return values are similar to that of lookup.
 *
 * @since 0.19.3
 */
func parseTZ(footer: String, end: Int64, epochSecond: Int64): (String, Int64, Int64, Int64) {
    var stdName: String = ""
    var dstName: String = ""
    var stdOffset = 0
    var dstOffset = 0
    var rest = footer
    (stdName, rest) = parseTZName(rest)
    (stdOffset, rest) = parseTZOffset(rest)
    stdOffset = -stdOffset
    if (rest.size == 0) {
        return (stdName, stdOffset, end, Int64.Max)
    }

    (dstName, rest) = parseTZName(rest)
    if (rest.size == 0 || rest[0] == b',') {
        dstOffset = stdOffset + SECS_PER_HOUR
    } else {
        (dstOffset, rest) = parseTZOffset(rest)
        dstOffset = -dstOffset
    }

    if (rest.size == 0) {
        rest = ",M3.2.0,M11.1.0"
    }
    if (rest[0] != b',') {
        throw InvalidDataException("Failed to parse the timezone data.")
    }

    var startRule: ZoneRule = ZoneRule()
    var endRule: ZoneRule = ZoneRule()
    (startRule, rest) = parseTZRule(rest[1..])
    if (rest.size == 0 || rest[0] != b',') {
        throw InvalidDataException("Failed to parse the timezone data.")
    }
    (endRule, rest) = parseTZRule(rest[1..])
    if (rest.size > 0) {
        throw InvalidDataException("Failed to parse the timezone data.")
    }

    var (year, ysec) = toYearAndSecond(epochSecond + SECS_OF_UNIX_TO_AD1)

    /* Calculate the start unix second of current year. */
    let unixSec = daysSinceUnix(year) * SECS_PER_DAY
    if (year <= 0) {
        if (isLeapYear(year)) {
            return (stdName, stdOffset, unixSec, unixSec + SECS_OF_LEAP_YEAR)
        }
        return (stdName, stdOffset, unixSec, unixSec + SECS_OF_NORMAL_YEAR)
    }

    var startSec = transToSecOfYear(year, startRule, stdOffset)
    var endSec = transToSecOfYear(year, endRule, dstOffset)
    if (endSec < startSec) {
        (startSec, endSec) = swap(startSec, endSec)
        (stdName, dstName) = swap(stdName, dstName)
        (stdOffset, dstOffset) = swap(stdOffset, dstOffset)
    }

    if (Int64(ysec) < startSec) {
        return (stdName, stdOffset, unixSec, startSec + unixSec)
    } else if (Int64(ysec) >= endSec) {
        if (isLeapYear(year)) {
            return (stdName, stdOffset, endSec + unixSec, unixSec + SECS_OF_LEAP_YEAR)
        }
        return (stdName, stdOffset, endSec + unixSec, unixSec + SECS_OF_NORMAL_YEAR)
    } else {
        return (dstName, dstOffset, startSec + unixSec, endSec + unixSec)
    }
}

/**
 * Return the swapped value.
 */
func swap<T>(left: T, right: T): (T, T) {
    return (right, left)
}

/**
 * Return the time zone name at the start of the TZif footer string @p footer.
 *
 * @param footer TZif footer string.
 * @return the time zone name, the remainder of @p footer.
 *
 * @since 0.19.3
 */
func parseTZName(footer: String): (String, String) {
    // The size of the footer is determined to be greater than zero
    let strLen = footer.size
    if (footer[0] == b'<') {
        for (i in 0..strLen) {
            if (footer[i] == b'>') {
                return (footer[..(i + 1)], footer[(i + 1)..])
            }
        }
        throw InvalidDataException("Failed to parse the timezone data.")
    }
    for (i in 0..strLen) {
        let c = footer[i]
        if ((c >= b'0' && c <= b'9') || c == b',' || c == b'-' || c == b'+') {
            if (i <= 2) {
                throw InvalidDataException("Failed to parse the timezone data.")
            }
            return (footer[..i], footer[i..])
        }
    }
    if (strLen <= 2) {
        throw InvalidDataException("Failed to parse the timezone data.")
    }
    return (footer, "")
}

/**
 * Return the time zone offset at the start of the TZif footer string @p footer as a number of seconds.
 *
 * @param footer TZif footer string.
 * @return the time zone offset, the remainder of @p footer.
 *
 * @since 0.19.3
 */
func parseTZOffset(footer: String): (Int64, String) {
    if (footer.size == 0) {
        throw InvalidDataException("Failed to parse the timezone data.")
    }
    var hours = 0
    var mins = 0
    var secs = 0
    var neg = false
    var rest = footer
    if (footer[0] == b'+') {
        rest = footer[1..]
    } else if (footer[0] == b'-') {
        rest = footer[1..]
        neg = true
    }
    (hours, rest) = getNum(rest)
    if (hours < 0 || hours > 24) { // The number of hours of the day is within the range of 0-24.
        throw InvalidDataException("Failed to parse the timezone data.")
    }
    var off = hours * SECS_PER_HOUR
    if (rest.size == 0 || rest[0] != b':') {
        if (neg) {
            off = -off
        }
        return (off, rest)
    }

    (mins, rest) = getNum(rest[1..])
    if (mins < 0 || mins > 59) {
        throw InvalidDataException("Failed to parse the timezone data.")
    }
    off += mins * SECS_PER_MINUTE
    if (rest.size == 0 || rest[0] != b':') {
        if (neg) {
            off = -off
        }
        return (off, rest)
    }

    (secs, rest) = getNum(rest[1..])
    if (secs < 0 || secs > 59) {
        throw InvalidDataException("Failed to parse the timezone data.")
    }
    off += secs
    if (neg) {
        off = -off
    }
    return (off, rest)
}

/**
 * Parses a rule from a TZif footer string @p footer.
 *
 * @param footer TZif footer string.
 * @return the rule, and the remainder of the string.
 *
 * @since 0.19.3
 */
func parseTZRule(footer: String): (ZoneRule, String) {
    var rule = ZoneRule()
    if (footer.size == 0) {
        throw InvalidDataException("Failed to parse the timezone data.")
    }
    var restValue = rule.parse(footer)
    if (restValue.size == 0 || restValue[0] != b'/') {
        rule.rTime = 2 * SECS_PER_HOUR
        return (rule, restValue)
    }

    let (offset, rest) = parseTZOffset(restValue[1..])
    if (offset < 0) {
        throw InvalidDataException("Failed to parse the timezone data.")
    }
    rule.rTime = offset

    return (rule, rest)
}

/**
 * Parses a number from a TZif footer string @p footer.
 *
 * @param footer TZif footer string.
 * @return the number, the remainder of the string.
 *
 * @since 0.19.3
 */
func getNum(footer: String): (Int64, String) {
    let strLen = footer.size
    if (strLen == 0) {
        throw InvalidDataException("Failed to parse the timezone data")
    }
    var end = strLen
    for (i in 0..strLen) {
        let c = footer[i]
        if (c < b'0' || c > b'9') {
            if (i == 0) {
                throw InvalidDataException("Failed to parse the timezone data")
            }
            end = i
            break
        }
    }
    try {
        if (end == footer.size) {
            return (Int64.parse(footer), "")
        }
        return (Int64.parse(footer[..end]), footer[end..])
    } catch (_: IllegalArgumentException) {
        throw InvalidDataException("Failed to parse the timezone data")
    }
}

/**
 * Return the number of seconds since the start of the @p year that the @p rule takes effect.
 *
 * @param year year.
 * @param rule a zone rule.
 * @param off time zone offset.
 * @return the transtion time in seconds.
 *
 * @since 0.19.3
 */
func transToSecOfYear(year: Int64, rule: ZoneRule, off: Int64): Int64 {
    if (year <= 0) {
        throw InvalidDataException("Failed to parse the timezone data")
    }
    var sec: Int64
    match (rule.rType) {
        case JulianDay =>
            sec = (rule.rDay - 1) * SECS_PER_DAY
            if (isLeapYear(year) && rule.rDay >= 60) { // If the 60day of a leap year is crossed, the number of days must be increased by 1.
                sec += SECS_PER_DAY
            }
        case DayOfYear => sec = rule.rDay * SECS_PER_DAY
        case MonthNthDayOfWeek =>
            let mon = rule.rMon
            let week = rule.rWeek
            let day = rule.rDay

            var dayOfMonBefore = DAYS_BEFORE[rule.rMon - 1]
            if (isLeapYear(year) && mon > 2) { // If the 2th month of a leap year is crossed, the number of days must be increased by 1.
                dayOfMonBefore++
            }
            var dayOfYear = dayOfMonBefore

            // Use the Zeiller formula variant to calculate the day of the week the first day of the month.
            let firstDayOfMon = ((year - 1) + ((year - 1) / 4) - ((year - 1) / 100) + ((year - 1) / 400) +
                dayOfMonBefore + 1) % DAYS_PER_WEEK

            // Days in month from January to December
            var daysInMon = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
            if (isLeapYear(year)) {
                daysInMon[1] = 29 // The number of days in February is 29 in leap years.
            }
            var dayOfMon = 0
            if (firstDayOfMon == 0) {
                dayOfMon += DAYS_PER_WEEK * (week - 1) + day
            } else if (day < firstDayOfMon) {
                dayOfMon += DAYS_PER_WEEK * (week - 1) + day + (DAYS_PER_WEEK - firstDayOfMon)
            } else {
                dayOfMon += DAYS_PER_WEEK * (week - 1) + day - firstDayOfMon
            }
            if ((dayOfMon + 1) > daysInMon[mon - 1]) {
                dayOfMon -= DAYS_PER_WEEK
            }
            dayOfYear += dayOfMon
            sec = dayOfYear * SECS_PER_DAY
    }

    return sec + rule.rTime - off
}

public class InvalidDataException <: Exception {
    public init() {
        super()
    }

    public init(message: String) {
        super(message)
    }

    protected override func getClassName(): String {
        return "InvalidDataException"
    }
}
