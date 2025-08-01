/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest

import std.collection.*
import std.collection.*
import std.collection.concurrent.NonBlockingQueue
import std.math.abs
import std.time.*
import std.unittest.common.*

private const GROUP_WORD = "group"
private const TEST_WORD = "test"
private const PROGRESS_INDICATOR_FINISHED_FILL = "|"
private const PROGRESS_INDICATOR_REMAIN_FILL = "-"
private const DEFAULT_PROGRESS_INDICATOR_WIDTH = 20
private const MIN_PROGRESS_INDICATOR_WIDTH = 10
private const MAX_PROGRESS_INDICATOR_WIDTH = 50
private const PERCENT_VALUE_WIDTH = 3
private const MARK_WIDTH = 4
private const STATIC_SIZED_AREA_WIDTH = 1 /* " " */ + PERCENT_VALUE_WIDTH + 5 /* "% [] " */ + MARK_WIDTH + 1 /* " " */ + 10 /* (hh:mm:ss) */ // = 24

private const DEFAULT_NAMED_AREA_WIDTH = 36 // "📦 group <name> "
private const MIN_NAMED_AREA_WIDTH = 20
private const DEFAULT_HEIGHT = 12
private const DEFAULT_WIDTH = STATIC_SIZED_AREA_WIDTH + DEFAULT_PROGRESS_INDICATOR_WIDTH + DEFAULT_NAMED_AREA_WIDTH // = 80

private const MIN_WIDTH = STATIC_SIZED_AREA_WIDTH + MIN_PROGRESS_INDICATOR_WIDTH + MIN_NAMED_AREA_WIDTH // = 54
private const MIN_HEIGHT = 4 // 1 line for group, 1 line for possible error test case, 1 line for test case, 1 line for summary

private func NAMED_AREA_WIDTH(total: Int64): Int64 {
    total - STATIC_SIZED_AREA_WIDTH - PROGRESS_INDICATOR_WIDTH(total) // 64% of free area
}

private func PROGRESS_INDICATOR_WIDTH(total: Int64): Int64 {
    let v = (total - STATIC_SIZED_AREA_WIDTH) * 36 / 100 // 36% of free area
    max(min(v, MAX_PROGRESS_INDICATOR_WIDTH), MIN_PROGRESS_INDICATOR_WIDTH)
}

private func GROUP_NAME_WIDTH(total: Int64): Int64 {
    NAMED_AREA_WIDTH(total) - GROUP_WORD.size - 4 /* "📦 " and " "  between */
}

private func TEST_CASE_NAME_WIDTH(total: Int64): Int64 {
    total - TEST_WORD.size - 4 /* "🧪 " and " " between */ - 10 /* (hh:mm:ss) */ - MARK_WIDTH - 2 /* spaces between mark */
}

class TestProgressReporter <: UTProgressReporter {
    private var width = DEFAULT_WIDTH
    private var height = DEFAULT_HEIGHT

    /**
     * Space reserved for finished cases counter in summary.
     * Can grow.
     */
    private var markWidth = MARK_WIDTH

    private let booker: TestProgressCollector

    TestProgressReporter(let testCasesParallelism: Int64, let isBrief!: Bool, let entriesLimit!: ?UInt64 = None) {
        booker = TestProgressCollector(testCasesParallelism)
    }

    public override prop updateQueue: NonBlockingQueue<UTProgress> {
        get() {
            booker.updateQueue
        }
    }

    public override func start(): Unit {
        booker.start()
    }

    public override func report(terminalHeight: ?UInt64, terminalWidth: ?UInt64): PrettyText {
        booker.flushChanges()
        let report = PrettyText()
        if (booker.registeredPackagesCount == 0u64) { return report }

        adjustSize(terminalHeight, terminalWidth)
        if (!isBrief) {
            report.append(buildPackagesReport())
            report.append(buildTestCasesReport())
            report.append(buildFailedCaseReport())
        }

        report.append(buildSummaryReport())
        report
    }

    private func buildPackagesReport(): PrettyText {
        let text = PrettyText()
        let packages = booker.currentPackages

        let visiblePackagesSize = min(packages.size, packagesHeightLimit)

        for (pack in packages[..visiblePackagesSize]) {
            let packagename = "${GROUP_WORD} ${pack.trimmed(GROUP_NAME_WIDTH(width)).padEnd(GROUP_NAME_WIDTH(width))}"
            let percent = percentString(pack.finishPercent)

            let markSymbol = match {
                case pack.isFailed => "✗" // 1 grapheme, 1 rune but probably many bytes
                case pack.finishedCases < pack.totalCases => ""
                case _ => "✓" // 1 grapheme, 1 rune but probably many bytes
            }
            let mark = markSymbol.padEnd(MARK_WIDTH + if (markSymbol.size > 1) {
                markSymbol.size - 1
            } else {
                0
            }) // Adjust padding knowing the mark size is 1 grapheme it could takes many bytes

            let duration = pack.duration.toStringFormatted()
            let statusColor = if (pack.isFailed) { Color.RED} else { Color.GREEN }

            text.append("📦").space().append(packagename).space()
            text.append(percent).space()
            pack.progress.pprint(text, width: PROGRESS_INDICATOR_WIDTH(width))
            text.space()
            text.colored(statusColor, mark).space()
            text.append("(").append(duration).append(")").appendLine()
        }
        return text
    }

    private func buildTestCasesReport(): PrettyText {
        let text = PrettyText()
        let cases = booker.currentTestCases

        let visibleCasesSize = min(cases.size, testCasesHeightLimit)

        for (tcase in cases[..visibleCasesSize]) {
            let casename = "${TEST_WORD} ${tcase.trimmed(TEST_CASE_NAME_WIDTH(width)).padEnd(Int64(TEST_CASE_NAME_WIDTH(width)))}"
            let duration = tcase.duration.toStringFormatted()

            text.append("🧪").space().append(casename).space()
            text.append("".padEnd(MARK_WIDTH)).space()
            text.append("(").append(duration).append(")").appendLine()
        }
        return text
    }

    private func buildFailedCaseReport(): PrettyText {
        let text = PrettyText()
        if (let Some(failedCase) <- booker.lastFailedStep) {
            let statusCode = failedCase.check.statusCode().toString()
            let caseNameSpace = NAMED_AREA_WIDTH(width) + PROGRESS_INDICATOR_WIDTH(width) - statusCode.size - 1 - 3 /* "   FAILED " */
            text.append("   ") // alignment of level groups and cases name
            text.colored(Color.RED, statusCode).space()
            text.append(failedCase.trimmed(caseNameSpace).padEnd(caseNameSpace))
        }
        text.appendLine()
        return text
    }

    private func buildSummaryReport(): PrettyText {
        let text = PrettyText()
        let summary = booker.summary

        let percent = percentString(summary.finishPercent)

        let statusInfo = PrettyText()
        statusInfo
            .append("passed:")
            .space()
            .colored(if (summary.passedCases > 0) {
                Color.GREEN
            } else {
                Color.DEFAULT_COLOR
            }, summary.passedCases.toString())
        statusInfo.append(",").space()
        statusInfo
            .append("failed:")
            .space()
            .colored(if (summary.failedCases > 0) {
                Color.RED
            } else {
                Color.DEFAULT_COLOR
            }, summary.failedCases.toString())

        markWidth = max(markWidth, summary.totalCases.toString().size * 2 + 1 /* reserve totalCases space for both totalCases and finishedCases + 1 for "/" */ )
        let emptiness = "".padEnd(NAMED_AREA_WIDTH(width) - statusInfo.toString().size - markWidth + MARK_WIDTH)
        let finishedCounter = "${summary.finishedCases}/${summary.totalCases}".padStart(markWidth)
        let duration = summary.duration.toStringFormatted()

        text.append(statusInfo).append(emptiness).space()
            .append(percent).space()

        summary.progress.pprint(text, width: PROGRESS_INDICATOR_WIDTH(width))
        text.space()

        text.append(finishedCounter).space()
            .append("(").append(duration).append(")").space()

        text
    }

    private prop packagesHeightLimit: Int64 {
        get() {
            height - testCasesHeightLimit - 2
        }
    }

    private prop testCasesHeightLimit: Int64 {
        get() {
            min(height - 2 - 1, testCasesParallelism)
        }
    }

    private func adjustSize(terminalHeight: ?UInt64, terminalWidth: ?UInt64) {
        let prevWidth = width
        let prevHeight = height

        let availableHeight = match (terminalHeight) {
            case Some(h) => Int64(h) - 1
            case _ => DEFAULT_HEIGHT
        }

        height = min(height, Int64(booker.registeredPackagesCount) + testCasesParallelism + 2)
        if (let Some(lim) <- entriesLimit) {
            height = min(height, Int64(lim) + 2) // (packages and test cases) entries + error line + status line
        }

        height = max(height, MIN_HEIGHT)

        if (isBrief) {
            height = 1
        }

        width = match (terminalWidth) {
            case Some(w) => max(Int64(w) - 1, MIN_WIDTH)
            case _ => DEFAULT_WIDTH
        }
        width = max(width, MIN_WIDTH)
    }
}

private class TestProgressCollector {
    let updateQueue = NonBlockingQueue<UTProgress>()

    /**
     * Stores workers that were registered respective the related packages.
     */
    private let registeredWorkers = HashSet<UniqueWorkerId>()
    private let totalPackageCasesCount = HashMap<String, UInt64>()
    private let packagesOrder = ArrayList<String>()
    private let packagesStartTime = HashMap<String, DateTime>()
    private let finishedPackageCasesCount = HashMap<String, UInt64>()
    private let packagesProgress = HashMap<String, Progress>()
    private let failedPackages = HashSet<String>()

    private var _totalCasesCount = 0u64
    private let casesOrder: Array<?Int64> // Worker ids
    private var _finishedCasesCount = 0u64
    private var _passedCasesCount = 0u64
    private var _failedCasesCount = 0u64
    private var _lastFailedStep: ?FailedTestCaseProgressData = None

    private let summaryProgress = Progress(totalPieces: 0)
    private var startTime: MonoTime = MonoTime.now()

    /**
     * Stores currently executing header on the worker with its id.
     */
    private let executing = HashMap<Int64, TestCaseProgressData>()

    private let finishedPackages = ArrayList<String>() // List of finished packages to be shown and removed from progress.

    TestProgressCollector(testCasesParallelism: Int64) {
        casesOrder = Array<?Int64>(testCasesParallelism, repeat: None)
    }

    prop totalCasesCount: UInt64 {
        get() {
            _totalCasesCount
        }
    }

    prop finishedCasesCount: UInt64 {
        get() {
            _finishedCasesCount
        }
    }

    prop passedCasesCount: UInt64 {
        get() {
            _passedCasesCount
        }
    }

    prop failedCasesCount: UInt64 {
        get() {
            _failedCasesCount
        }
    }

    prop registeredPackagesCount: UInt64 {
        get() {
            UInt64(totalPackageCasesCount.size)
        }
    }

    prop currentPackagesCount: UInt64 {
        get() {
            UInt64(packagesOrder.size)
        }
    }

    prop lastFailedStep: ?FailedTestCaseProgressData {
        get() {
            _lastFailedStep
        }
    }

    prop currentPackages: Array<PackageProgressData> {
        get() {
            packagesOrder |> filterMap<String, PackageProgressData> { name: String =>
                let totalCases = totalPackageCasesCount[name]
                // do not show effectively empty packages
                if (totalCases == 0) { return None }
                PackageProgressData(
                    name,
                    totalCases: totalCases,
                    finishedCases: finishedPackageCasesCount[name],
                    isFailed: failedPackages.contains(name),
                    startTime: packagesStartTime[name],
                    progress: packagesProgress[name]
                )
            } |> collectArray
        }
    }

    prop currentTestCases: Array<TestCaseProgressData> {
        get() {
            casesOrder |> filterMap<?Int64, TestCaseProgressData> { id_: ?Int64 =>
                let id = id_ ?? return None
                executing[id]
            } |> collectArray
        }
    }

    prop summary: SummaryProgressData {
        get() {
            SummaryProgressData(
                passedCases: _passedCasesCount,
                failedCases: _failedCasesCount,
                finishedCases: _finishedCasesCount,
                totalCases: _totalCasesCount,
                startTime: startTime,
                progress: summaryProgress
            )
        }
    }

    func start() {
        startTime = MonoTime.now()
    }

    func flushChanges() {
        clearFinishedPackages()
        while (true) {
            let element = match (updateQueue.dequeue()) {
                case None => break
                case Some(n: TestProgressData) => n
                case _ => continue
            }

            match (element.data) {
                case body: ExecutionResultBody => updateBody(body, element.workerId)
                case r: TestCasesRegistrationPart => registerWorkerIfRequired(r.casesCount, id: r.workerId,
                    pack: r.packageName)
                case header: ExecutionResultHeader => updateHeader(header, element.workerId)
                case _ => ()
            }
        }
    }

    private func registerWorkerIfRequired(cases: UInt64, id!: Int64, pack!: String) {
        if (cases == 0) {
            // we still have to initialize the information because this package may be
            // mentioned in other messages from worker, but we don't want it to
            totalPackageCasesCount.addIfAbsent(pack, 0u64)
            finishedPackageCasesCount.addIfAbsent(pack, 0u64)
            packagesProgress.addIfAbsent(pack, Progress(totalPieces: Int64(cases)))
            return
        }
        let worker = UniqueWorkerId(id: id, pack: pack)
        if (registeredWorkers.add(worker)) {
            _totalCasesCount += cases
            totalPackageCasesCount.addIfAbsent(pack, 0u64)
            totalPackageCasesCount[pack] += cases
            finishedPackageCasesCount.addIfAbsent(pack, 0u64)
            if (packagesProgress.addIfAbsent(pack, Progress(totalPieces: Int64(cases))).isSome()) {
                packagesProgress[pack].expand(cases)
            }
            summaryProgress.expand(cases)
        }
    }

    private func clearFinishedPackages() {
        for (pack in finishedPackages) {
            packagesOrder.removeIf { p: String => p == pack }
            packagesStartTime.remove(pack)
            packagesProgress.remove(pack)
            totalPackageCasesCount.remove(pack)
        }
        finishedPackages.clear()
    }

    private func updateBody(body: ExecutionResultBody, workerId: Int64) {
        executing.remove(workerId)
        match (casesOrder.indexOf(workerId)) {
            case Some(i) => casesOrder[i] = None
            case None => ()
        }
        let pack = body.stepResult.caseId.suiteId.groupName

        if (body.isSkip) {
            if (totalPackageCasesCount[pack] == 0) {
                finishedPackages.add(pack)
            }
            return
        }

        if (!body.isClassLifecycle) {
            _finishedCasesCount++
            finishedPackageCasesCount[pack]++
        }

        if (finishedPackageCasesCount[pack] >= totalPackageCasesCount[pack]) {
            finishedPackages.add(pack)
        }

        if (body.isFailed) {
            if (body.isClassLifecycle) {
                _totalCasesCount++
                packagesProgress[pack].expand(1)
                summaryProgress.expand(1)
            }

            _failedCasesCount++
            _lastFailedStep = FailedTestCaseProgressData(body.toCaseName(), suiteId: body.stepResult.caseId.suiteId,
                check: body.firstFailedStep)
            failedPackages.add(pack)
            packagesProgress[pack].update(positive: false)
            summaryProgress.update(positive: false)
        } else if (body.isPassed && !body.isClassLifecycle) {
            _passedCasesCount++
            packagesProgress[pack].update(positive: true)
            summaryProgress.update(positive: true)
        }
    }

    private func updateHeader(header: ExecutionResultHeader, workerId: Int64) {
        if (executing
            .add(workerId, TestCaseProgressData(header.toCaseName(), suiteId: header.suiteId,
                startTime: header.startTime))
            .isNone()) {
            match (casesOrder.indexOf(None)) {
                case Some(i) => casesOrder[i] = workerId
                case None => ()
            }
            let packageName = header.suiteId.groupName

            packagesStartTime[packageName] = if (packagesStartTime.contains(packageName)) {
                min(header.startTime, packagesStartTime[packageName])
            } else {
                header.startTime
            }

            if (packagesOrder |> all {it: String => it != packageName}) {
                packagesOrder.add(packageName)
            }
        }
    }
}

struct TestProgressData <: UTProgress {
    TestProgressData(let data: ExecutionResultPart, let workerId!: Int64 = 0) {}
}

private struct UniqueWorkerId <: Hashable & Equatable<UniqueWorkerId> {
    UniqueWorkerId(let id!: Int64, let pack!: String) {}

    public func hashCode(): Int64 {
        var hasher = DefaultHasher()
        hasher.write(id)
        hasher.write(pack)
        return hasher.finish()
    }

    public operator func ==(other: UniqueWorkerId): Bool {
        this.id == other.id && this.pack == other.pack
    }

    public operator func !=(other: UniqueWorkerId): Bool {
        !(this == other)
    }
}

private struct PackageProgressData {
    PackageProgressData(
        let name: String,
        let totalCases!: UInt64,
        let finishedCases!: UInt64,
        let isFailed!: Bool,
        let startTime!: DateTime,
        let progress!: Progress
    ) {}

    prop finishPercent: UInt64 {
        get() {
            if (totalCases == 0) { 0u64 } else { 100 * finishedCases / totalCases }
        }
    }

    prop duration: Duration {
        get() {
            DateTime.now() - startTime
        }
    }

    func trimmed(limit: Int64): String {
        trimPackage(name, limit: limit)
    }
}

private enum TestCaseName <: ToString {
    | CaseName(TestCaseId)
    | CNStep(LStep) // Consider test class lifecycle methods as cases here and display it.

    public override func toString() {
        match (this) {
            case CaseName(s) => s.caseName
            case CNStep(step) => step.toString()
        }
    }
}

private struct TestCaseProgressData {
    TestCaseProgressData(let name: TestCaseName, let suiteId!: TestSuiteId, let startTime!: DateTime) {}

    prop duration: Duration {
        get() {
            DateTime.now() - startTime
        }
    }

    func trimmed(limit: Int64): String {
        trim(suiteId, name, limit: limit)
    }

    static func trim(suiteId: TestSuiteId, name: TestCaseName, limit!: Int64): String {
        let fullname = "${suiteId.suiteName}" + match (name) {
            case CaseName(_) => "."
            case CNStep(_) => " at "
        } + name.toString()
        if (fullname.size > limit) { fullname[..limit - 3] + "..." } else { fullname }
    }
}

private struct FailedTestCaseProgressData {
    FailedTestCaseProgressData(let name: TestCaseName, let suiteId!: TestSuiteId, let check!: RunStepResult) {}

    func trimmed(limit: Int64): String {
        let caseTrimmed = TestCaseProgressData.trim(suiteId, name, limit: limit)
        trimPackage(suiteId.groupName, limit: limit - caseTrimmed.size) + "." + caseTrimmed
    }
}

private struct SummaryProgressData {
    SummaryProgressData(
        let passedCases!: UInt64,
        let failedCases!: UInt64,
        let finishedCases!: UInt64,
        let totalCases!: UInt64,
        let startTime!: MonoTime,
        let progress!: Progress
    ) {}

    prop finishPercent: UInt64 {
        get() {
            if (totalCases == 0) { 0u64 } else { 100 * finishedCases / totalCases }
        }
    }

    prop isFailed: Bool {
        get() {
            failedCases > 0u64
        }
    }

    prop duration: Duration {
        get() {
            MonoTime.now() - startTime
        }
    }
}

extend ExecutionResultPart {
    func toCaseName(): TestCaseName {
        match (this) {
            case h: TestCaseExecutionResultHeader => CaseName(h.caseId)
            case h: LifecycleExecutionResultHeader => CNStep(h.step)
            case b: ExecutionResultBody => match ((b.stepResult.subResults |> last).getOrThrow().kind) {
                case Lifecycle(step) => CNStep(step)
                case _ => CaseName(b.stepResult.caseId)
            }
            case _ => throw Exception("Unexpected branch")
        }
    }
}

extend ExecutionResultBody {
    prop isSkip: Bool {
        get() {
            stepResult.subResults |> any { it: RunStepResult =>
                match(it.kind) {
                    case Skip => true
                    case _ => false
                }
            }
        }
    }

    prop isFailed: Bool {
        get() {
            stepResult.subResults |> any { it: RunStepResult =>
                it.hasFailures()
            }
        }
    }

    prop firstFailedStep: RunStepResult {
        get() {
            (stepResult.subResults |> filter { it: RunStepResult =>
                it.hasFailures()
            } |> first<RunStepResult>) ?? throw Exception("There is no failed check")
        }
    }

    prop isPassed: Bool {
        get() {
            stepResult.subResults |> all { it: RunStepResult =>
                match ((it.info, it.kind)) {
                    case (Failure(_), _) => false
                    case (_, Skip) => false
                    case (_, UserCode) => false
                    case _ => true
                }
            }
        }
    }

    prop isClassLifecycle: Bool {
        get() {
            stepResult.subResults |> any { it: RunStepResult => it.kind.isClassLifecycle() }
        }
    }

    prop isBeforeAll: Bool {
        get() {
            stepResult.subResults |> any { it: RunStepResult =>
                match (it.kind) {
                    case Lifecycle(BeforeAll) => true
                    case _ => false
                }
            }
        }
    }
}

extend TestCaseId {
    func toDisplayString() {
        "${suiteId.toDisplayString()}.${caseName}"
    }
}

extend TestSuiteId {
    func toDisplayString() {
        "${groupName}.${suiteName}"
    }
}

extend Duration {
    func toStringFormatted(): String {
        let hh = toHours().toString().padStart(2, padding: "0")
        let mm = (toMinutes() % 60).toString().padStart(2, padding: "0")
        let ss = (toSeconds() % 60).toString().padStart(2, padding: "0")
        return "${hh}:${mm}:${ss}"
    }
}

private func trimPackage(pack: String, limit!: Int64): String {
    if (pack.size <= limit) { return pack }
    let levels = pack.split(".")
    var size = pack.size

    for (i in 0..levels.size) {
        if (size <= limit) { break }
        size -= levels[i].size - 1
        levels[i] = String.fromUtf8(levels[i][0])
    }

    let trimmed = levels |> collectString<String>(delimiter: ".")
    match {
        case trimmed.size > limit => trimmed[trimmed.size - limit..]
        case _ => trimmed
    }
}

/**
 * Right-aligned percent
 */
private func percentString(percent: UInt64, width!: Int64 = PERCENT_VALUE_WIDTH): String {
    percent.toString().padStart(width) + "%"
}

private class Progress <: PrettyPrintable {
    /**
     * Cached text incremental representation
     */
    private var text = PrettyText()

    /**
     * Type of the elements in the progress. One element takes about (width of the full progress bar / totalPieces) bars.
     */
    private let pieces = ArrayList<Bool>()

    /**
     * Cached index of bar (single pipe) that should be rendered as the next.
     */
    private var barIdx = 0

    /**
     *  Amount of progress pieces that were rendered and cached.
     */
    private var drawnPieces = 0

    /**
     * Area available for the whole progress pipes during previous render.
     */
    private var prevWidth = 0

    /**
     * Last rendered piece width (in pipes).
     */
    private var prevPieceWidth = 0

    /**
     * Last rendered piece status: positive or negative.
     */
    private var prevPieceStatus = true

    Progress(var totalPieces!: Int64) {
        pieces.reserve(totalPieces)
    }

    private let POSITIVE_COLOR = Color.GREEN
    private let NEGATIVE_COLOR = Color.RED

    func update(positive!: Bool = true): Unit {
        if (pieces.size >= totalPieces) { return }

        pieces.add(positive)
    }

    /**
     * Increase total pieces amount.
     */
    func expand(extendBy: UInt64) {
        pieces.reserve(Int64(extendBy))
        totalPieces += Int64(extendBy)
    }

    public func pprint(to: PrettyPrinter, width!: Int64): PrettyPrinter {
        if (prevWidth != width) {
            text = PrettyText()
            barIdx = 0
            drawnPieces = 0
            prevWidth = width
            prevPieceStatus = true
            prevPieceWidth = 0
            text.append("[")
        }

        for (i in drawnPieces..pieces.size) {
            let pieceWidth = progressWidth(i, fullWidth: width)
            let progress = PROGRESS_INDICATOR_FINISHED_FILL * pieceWidth

            // adjust bars color if previous pieces were failed but had no space to display
            let pieceStatus = match {
                case prevPieceWidth == 0 => pieces[i] && prevPieceStatus
                case _ => pieces[i]
            }
            let pieceColor = if (pieceStatus) { POSITIVE_COLOR } else { NEGATIVE_COLOR }
            text.colored(pieceColor, progress)
            barIdx += pieceWidth
            prevPieceStatus = pieceStatus
            prevPieceWidth = pieceWidth
        }
        drawnPieces = pieces.size

        let remained = PROGRESS_INDICATOR_REMAIN_FILL * (width - barIdx)
        to.append(text)
        to.colored(Color.GRAY, remained)
        to.append("]")

        return to
    }

    public override func pprint(to: PrettyPrinter): PrettyPrinter {
        pprint(to, width: DEFAULT_PROGRESS_INDICATOR_WIDTH)
    }

    private func progressPercent(ofIdx: Int64): Int64 {
        (ofIdx + 1) * 100 / totalPieces
    }

    private func progressWidth(ofIdx: Int64, fullWidth!: Int64): Int64 {
        progressPercent(ofIdx) * fullWidth / 100 - barIdx
    }
}
