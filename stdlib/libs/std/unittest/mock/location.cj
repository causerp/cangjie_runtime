/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest.mock

import std.collection.enumerate
import std.fs.Path

abstract class Location {
    public func getEntries(): Array<TraceEntry>
}

let UNKNOWN_LOCATION = LocationImpl([])
let UNKNOWN_LOCATION_STRING = "<unknown location>"

class SimpleLocation <: Location {
    SimpleLocation(
        let filePath: String,
        let lineNumber: Int64
    ) {}

    public func getEntries(): Array<TraceEntry> {
        return [TraceEntry(filePath, lineNumber)]
    }
}

struct TraceEntry {
    TraceEntry(
        let filePath: String,
        let lineNumber: Int64
    ) {}
}

class LocationImpl <: Location {
    LocationImpl(private let entries: Array<TraceEntry>) {}

    public func getEntries() {
        entries
    }
}

let MOCKED_CLASS_NAME_FRAGMENT = "$Mocked"

func locationFromTrace(): Location {
    let stackTrace = Exception().getStackTrace()
    for ((index, element) in stackTrace |> enumerate) {
        if (element.methodName.contains(MOCKED_CLASS_NAME_FRAGMENT)) {
            let relevantElement = if (element.lineNumber == 0) {
                stackTrace.get(index + 1) ?? return UNKNOWN_LOCATION
            } else {
                element
            }
            return LocationImpl(relevantElement.toEntry())
        }
    }
    return UNKNOWN_LOCATION
}

extend Location {
    func forceLineNumber(lineNum: Int64): Location {
        let filePath = getEntries().get(0)?.filePath ?? return UNKNOWN_LOCATION
        return SimpleLocation(filePath, lineNum)
    }

    func fileNameAndLine(): String {
        let firstEntry = getEntries().get(0) ?? return UNKNOWN_LOCATION_STRING
        // Path.fileName sometimes fails because StackTraceElement.fileName can be empty (presumably only on Mac)
        let fileName = try {
            Path(firstEntry.filePath).fileName
        } catch (e: Exception) {
            return UNKNOWN_LOCATION_STRING
        }
        return if (fileName.isEmpty()) {
            UNKNOWN_LOCATION_STRING
        } else {
            "${fileName}:${firstEntry.lineNumber}"
        }
    }
}

extend StackTraceElement {
    func toEntry(): TraceEntry {
        return TraceEntry(fileName, lineNumber)
    }
}
