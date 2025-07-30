/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/*
 * Gets the local time zone.
 * Load timezone which name is equal to the value of the TZ environment variable.
 * Get tzdata path from the value of the CJ_TZPATH environment variable.
 * If CJ_TZPATH is not set, use the data /etc/zoneinfo in ohos or /usr/share/zoneinfo in linux as the default path.
 * If the value of the TZ environment variable is empty or does not exist, load the local time zone from the system.
 */

package std.time

import std.convert.*
import std.collection.ArrayList

@FastNative
foreign func CJ_TIME_GetLocalTimeOffset(): Int64

@When[os != "Windows"]
@FastNative
foreign func CJ_TIME_GetRealPath(path: CString): CString

@When[os == "Windows"]
func initLocal(): TimeZone {
    var timeZ = unsafe { LibC.mallocCString("TZ") }
    let ctz = unsafe { CJ_TIME_GetEnvVariable(timeZ) }
    unsafe { LibC.free(timeZ) }
    if (!ctz.isNull() && !ctz.isEmpty()) {
        let env = unsafe { LibC.mallocCString(TZPATH) }
        let envPath = unsafe { CJ_TIME_GetEnvVariable(env) }
        unsafe { LibC.free(env) }
        if (!envPath.isNull() && !envPath.isEmpty()) {
            var id = ctz.toString()
            let envPathArray = envPath.toString().split(SEPARATOR, removeEmpty: true)
            try {
                id = id.replace("\\", "/")
                let local = TimeZone.loadFromPaths(id, envPathArray)
                return local
            } catch (_) {
                // go on
            }
        }
    }

    initLocalDefault()
}

@When[os != "Windows"]
func initLocal(): TimeZone {
    var timeZ = unsafe { LibC.mallocCString("TZ") }
    let ctz = unsafe { CJ_TIME_GetEnvVariable(timeZ) }
    unsafe { LibC.free(timeZ) }

    if (!ctz.isNull() && !ctz.isEmpty()) {
        // get timezone from system by id TZ
        let id = ctz.toString()
        var envPathArray = ArrayList<String>(TZIF_SOURCE)
        let env = unsafe { LibC.mallocCString(TZPATH) }
        let envPath = unsafe { CJ_TIME_GetEnvVariable(env) }
        unsafe { LibC.free(env) }
        if (!envPath.isNull() && !envPath.isEmpty()) {
            envPathArray.add(all: envPath.toString().split(SEPARATOR, removeEmpty: true), at: 0)
        }
        try {
            let local = TimeZone.loadFromPaths(id, unsafe { envPathArray.getRawArray()[0..envPathArray.size] })
            return local
        } catch (_) {
            // go on
        }
    }

    // if not set TZ or get TimeZone from TZ failed, get local time zone from system
    let clocalpath = unsafe { LibC.mallocCString(LOCALTIME_SRC) }
    let realpath = unsafe { CJ_TIME_GetRealPath(clocalpath) }
    unsafe { LibC.free(clocalpath) }
    if (!realpath.isNull()) {
        try {
            let path = realpath.toString()
            let name = getTimeZoneName(path)
            let tzdata = loadTZifData(path)
            return TimeZone.loadFromTZData(name, tzdata)
        } catch (_) {
        // go on
        } finally {
            unsafe { LibC.free(realpath) }
        }
    }
    initLocalDefault()
}

// get timezone which name is UTC+Offset
func initLocalDefault(): TimeZone {
    let offset = unsafe { CJ_TIME_GetLocalTimeOffset() }
    if (offset == 0) {
        return TimeZone.UTC
    }
    let duration = Duration.minute * offset
    let hour = duration.toHours()
    let minute = duration.abs().toMinutes() % 60
    let name = "UTC${hour.format("+.2")}:${minute.format(".2")}"
    return TimeZone(name, duration)
}

/**
 * Try to get timezone name by the path of tzdata
 * for unix like system
 *   prefix of ubuntu is: /usr/share/zoneinfo/
 *   prefix of ohos is : /system/etc/zoneinfo/
 *   prefix of macos is : /var/db/timezone/zoneinfo.default/ or others
 */
@When[os != "Windows"]
func getTimeZoneName(path: String): String {
    if (let Some(pos) <- path.lastIndexOf("zoneinfo")) {
        var substring = path[(pos + 8)..path.size] // 8 is the size of "zoneinfo"
        if (let Some(pos) <- substring.indexOf("/")) {
            return substring[pos + 1..]
        }
    }
    return "Local"
}
