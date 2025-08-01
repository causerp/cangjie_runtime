/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest

import std.collection.concurrent.NonBlockingQueue
import std.env.atExit
import std.sync.AtomicBool
import std.time.MonoTime
import std.unittest.common.PrettyText

private const UPDATE_FREQ_MS = 350
private const MIN_UPDATE_RELAX_MS = 100
private const ADJUST_TERMINAL_SIZE_FREQ_REDRAWS = 5

class ProgressReporter {
    private let reporter: UTProgressReporter
    private ProgressReporter() {
        this.reporter = match (getDefaultUTProgressReporter()) {
            case Some(r) => r
            case _ => throw Exception("Actual reporter does not exists! Should 'ProgressReporter' be created?")
        }
    }

    // Terminal size cache
    private var terminalHeight: ?UInt64 = None
    private var terminalWidth: ?UInt64 = None

    private var prevReportHeight = 0

    private let printer = TerminalPrettyPrinter.fromDefaultConfiguration()

    private var reporterJob: ?Future<Unit> = None

    private let isActive = AtomicBool(false)

    prop updateQueue: NonBlockingQueue<UTProgress> {
        get() {
            reporter.updateQueue
        }
    }

    /**
     * Start dynamic progress report for specified `reporter` until it will be stopped via `stopAndClear()` call.
     */
    func startReporting() {
        if (!isActive.compareAndSwap(false, true)) {
            return
        }

        atExit {
            stopAndClear()
        }

        reporterJob = spawn {
            reporter.start()
            printer.hideCursor()
            reportLoop {
                let report = reporter.report(terminalHeight, terminalWidth)
                let reportLinesCount = report.toString().count("\n") + 1
                let reportLinesCountTrimmed = if (let Some(theight) <- terminalHeight) {
                    min(reportLinesCount, Int64(theight))
                } else {
                    reportLinesCount
                }

                printer.exclusive { printer: TerminalPrettyPrinter =>
                    clearDynamicArea()

                    printer.append("\n" * reportLinesCountTrimmed) // dedicate lines for report
                    printer.up(reportLinesCountTrimmed)
                    printer.saveCursorPos()

                    if (reportLinesCountTrimmed < prevReportHeight) {
                        printer.append("\n" * (prevReportHeight - reportLinesCountTrimmed))
                        prevReportHeight = reportLinesCountTrimmed
                    }

                    printer.toBottom()
                    printer.up(reportLinesCountTrimmed - 1)
                    printer.append(report)

                    if (let Some(theight) <- terminalHeight) {
                        printer.setScrollableMargins(end: Int64(theight) - reportLinesCountTrimmed)
                    }
                    printer.restoreCursorPos()
                }
            }
        }
    }

    private func reportLoop(render: () -> Unit) {
        var tact = 0
        while (!Thread.currentThread.hasPendingCancellation) {
            let timeBeforeUpdate = MonoTime.now()

            /* Recache terminal size.
               Do it infrequently enough to now slow down due to system calls and have dynamically updated size of the report on terminal size changed.
             */
            if (tact % ADJUST_TERMINAL_SIZE_FREQ_REDRAWS == 0) {
                tact = 0
                terminalWidth = printer.terminalWidth
                terminalHeight = printer.terminalHeight
            }

            render()

            tact++
            let updateElapsed = MonoTime.now() - timeBeforeUpdate
            sleep(max(MIN_UPDATE_RELAX_MS, UPDATE_FREQ_MS - updateElapsed.toMilliseconds()) * Duration.millisecond)
        }
    }

    func stopAndClear() {
        if (!isActive.compareAndSwap(true, false)) { return }
        if (let Some(job) <- reporterJob) {
            job.cancel()
            job.get()
            reporterJob = None
        }

        reporter.reset()

        printer.exclusive { printer =>
            clearDynamicArea()
            printer.showCursor()
        }
    }

    private func clearDynamicArea() {
        printer.clearAhead()
        printer.saveCursorPos()
        printer.setScrollableMargins()
        printer.restoreCursorPos()
    }

    static func fromDefaultConfiguration(): ?ProgressReporter {
        let config = defaultConfiguration()
        if (!config.isDynamicProgressEnabled || TestProcessKind.fromDefaultConfiguration().isWorker) {
            return None
        }
        ProgressReporter()
    }
}

extend Configuration {
    prop isDynamicProgressEnabled: Bool {
        get() {
            !(get(KeyNoProgress.noProgress) ?? false) && !bench && !noRun
        }
    }

    prop isDynamicProgressBrief: Bool {
        get() {
            get(KeyProgressBrief.progressBrief) ?? false
        }
    }

    prop dynamicProgressEntriesLimit: ?UInt64 {
        get() {
            match (get(KeyProgressEntriesLimit.progressEntriesLimit)) {
                case Some(0) | None => None
                case Some(x) where x < 0 => throw UnittestCliOptionsFormatException(
                    "--${KeyProgressEntriesLimit.progressEntriesLimit.name}", actual: x.toString(),
                    expected: "Parameter format: non-negative integer value")
                case Some(x) => UInt64(x)
            }
        }
    }
}

interface UTProgressReporter {
    prop updateQueue: NonBlockingQueue<UTProgress>

    /**
     * Indicates start of the reported process.
     * Required initialization could happen here.
     */
    func start(): Unit {}

    func report(terminalHeight: ?UInt64, terminalWidth: ?UInt64): PrettyText

    /**
     * Reset the state of the reported.
     */
    func reset(): Unit {}
}

interface UTProgress {}

private func getDefaultUTProgressReporter(): ?UTProgressReporter {
    let defaultConfig = defaultConfiguration()
    match {
        case defaultConfig.bench => None
        case TestProcessKind.fromDefaultConfiguration().isWorker => None
        case defaultConfig.isDynamicProgressEnabled => TestProgressReporter(
            ParallelInfo.fromDefaultConfiguration().nWorkers,
            isBrief: defaultConfig.isDynamicProgressBrief,
            entriesLimit: defaultConfig.dynamicProgressEntriesLimit
        )
        case _ => None
    }
}
