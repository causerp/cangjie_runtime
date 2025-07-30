/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest.mock

import std.collection.*
import std.unittest.common.PrettyPrintable

class LogSnapshot {
    LogSnapshot(
        let entries: Array<LogEntry>
    ) {}

    func invocations(): Array<Invocation> {
        entries |> map { entry: LogEntry => entry.invocation } |> collectArray
    }

    static let EMPTY = LogSnapshot([])
}

struct LogEntry {
    LogEntry(
        let invocation: Invocation,
        let origin: BehaviourSource
    ) {}

    func wasHandledBy(thatChain: StubChain): Bool {
        match (origin) {
            case Stub(thisChain) => refEq(thisChain, thatChain)
            case _ => false
        }
    }
}

enum BehaviourSource {
    | Stub(StubChain)
    | Default
    | Failure(PrettyException)
}

class MutableLog {
    private let entries = ArrayList<LogEntry>()
    private var lastClearIndex: Int64 = 0

    func newEntry(entry: LogEntry): Unit {
        entries.add(entry)
    }

    func clear(): Unit {
        lastClearIndex = entries.size
    }

    func snapshotSinceLastClear(scope: Set<UInt64>): LogSnapshot {
        validateLog()
        let snapshotEntries = ArrayList<LogEntry>()
        let untilIndex = entries.size

        for (i in lastClearIndex..untilIndex) {
            let entry = entries[i]
            if (scope.contains(entry.invocation.stubId.receiverId)) {
                snapshotEntries.add(entry)
            }
        }
        LogSnapshot(
            snapshotEntries.toArray()
        )
    }

    func fullLog(): LogSnapshot {
        validateLog()
        return LogSnapshot(entries.toArray())
    }

    func validateLog() {
        for (entry in entries) {
            match (entry.origin) {
                case Failure(originalException) =>
                    LogCorruptedReport().fail(originalException)
                case _ => ()
            }
        }
    }
}

class LogCorruptedReport <: FailureReport {
    func fail(originalMessage: PrettyPrintable): Nothing {
        let message = build {
            errorHeader("Invocation log contains errors")
            line {
                text("Probable reason: original exception was suppressed by")
                userCode("catch")
                text("block")
            }
            line("Original error:")
            indent {
                includeContent(originalMessage)
            }
        }
        throw MockFrameworkException(message)
    }
}
