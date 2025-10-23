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
    public func getEntry(): Option<TraceEntry>
}

let UNKNOWN_LOCATION = LocationImpl.unknown()
let UNKNOWN_LOCATION_STRING = "<unknown location>"

struct TraceEntry {
    TraceEntry(
        let filePath: String,
        let lineNumber: Int64
    ) {}
}

class LocationImpl <: Location {
    private static let MOCKED_CLASS_NAME_FRAGMENT = "$Mocked"

    static func fromTrace(): Location {
        return LocationImpl(getRawStackTrace())
    }

    static func unknown(): Location {
        return LocationImpl()
    }

    private let rawStackTrace: Array<UInt64>
    private var entry: Option<TraceEntry>

    private init(rawStackTrace: Array<UInt64>) {
        this.rawStackTrace = rawStackTrace
        this.entry = Option<TraceEntry>.None
    }

    private init() {
        this.rawStackTrace = []
        this.entry = Option<TraceEntry>.None
    }

    public func getEntry(): Option<TraceEntry> {
        if (let Some(entry) <- this.entry) {
            return this.entry
        }
        if (this.rawStackTrace.isEmpty()) {
            return this.entry
        }
        if (let Some(stackTraceElement) <- _FRAMEWORK.getCachedStackTraceFrame(this.rawStackTrace)) {
            this.entry = stackTraceElement.toEntry()
            return this.entry
        }

        let frameSize = rawStackTrace.size / 3
        var mockRelatedFrame = Option<StackTraceElement>.None
        for (i in 0..frameSize) {
            let frame = decodeRawStackTrace(rawStackTrace, i) ?? continue
            if (let Some(previousFrame) <- mockRelatedFrame) {
                let relevantFrame = if (frame.lineNumber == 0) { previousFrame } else { frame }
                _FRAMEWORK.recordStackTraceFrame(rawStackTrace, i, relevantFrame)
                this.entry = relevantFrame.toEntry()
                return this.entry
            }
            if (frame.methodName.contains(MOCKED_CLASS_NAME_FRAGMENT)) {
                mockRelatedFrame = frame
            }
        }
        return Option<TraceEntry>.None
    }
}

extend Location {
    func fileNameAndLine(): String {
        let firstEntry = getEntry() ?? return UNKNOWN_LOCATION_STRING
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
