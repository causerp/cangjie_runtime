/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest

import std.collection.*
import std.unittest.common.*
import std.fs.*

private let OP_SHOW_ALL_OUTPUT_NAME = camelCaseToKebabCase(KeyShowAllOutput().name)
private let OP_SHOW_ALL_OUTPUT = "--${OP_SHOW_ALL_OUTPUT_NAME}"
let SHOW_ALL_OUTPUT_KEY = kebabCaseToCamelCase(OP_SHOW_ALL_OUTPUT_NAME)
private let OP_NO_CAPTURE_OUTPUT_NAME = camelCaseToKebabCase(KeyNoCaptureOutput().name)
private let OP_NO_CAPTURE_OUTPUT = "--${OP_NO_CAPTURE_OUTPUT_NAME}"
let NO_CAPTURE_OUTPUT_KEY = kebabCaseToCamelCase(OP_NO_CAPTURE_OUTPUT_NAME)
private let OP_CAPTURE_OUTPUT_NAME = camelCaseToKebabCase(KeyCaptureOutput().name)
let OP_CAPTURE_OUTPUT = "--${OP_CAPTURE_OUTPUT_NAME}"
let CAPTURE_OUTPUT_KEY = kebabCaseToCamelCase(OP_CAPTURE_OUTPUT_NAME)
private let OP_VERBOSE_NAME = camelCaseToKebabCase(KeyVerbose().name)
let OP_VERBOSE = "--${OP_VERBOSE_NAME}"
let VERBOSE_KEY = OP_VERBOSE_NAME

extend PrettyPrinter {
    func appendName(name: String): PrettyPrinter {
        this.colored(YELLOW, name)
    }
}

extend Configuration {
    prop bench: Bool {
        get(){ get(KeyBench.bench) ?? false }
    }

    prop captureOutput: Bool {
        get(){ get(KeyCaptureOutput.captureOutput) ?? false }
    }

    prop noCaptureOutput: Bool {
        get(){ get(KeyNoCaptureOutput.noCaptureOutput) ?? false }
    }

    prop showAllOutput: Bool {
        get(){ get(KeyShowAllOutput.showAllOutput) ?? false }
    }

    prop noRun: Bool {
        get() { get(KeyDryRun.dryRun) ?? false }
    }

    prop verbose: Bool {
        get(){ get(KeyVerbose.verbose) ?? false }
    }
}

class TestOutputReporter {
    private TestOutputReporter(let capture: Bool, let showAllOutput: Bool, let verbose: Bool) {}

    func report(pp: PrettyPrinter, prefix: PrettyText, output: CapturedOutput, success!: Bool): PrettyPrinter {
        if (!success || showAllOutput) {
            if (!output.stdout.isEmpty()) {
                pp.append(prefix).appendLine("STDOUT:")
                appendStream(pp, output.stdout)
            }
            if (!output.stderr.isEmpty()) {
                pp.append(prefix).appendLine("STDERR:")
                appendStream(pp, output.stderr)
            }
        }
        pp
    }

    private static func appendStream(pp: PrettyPrinter, stream: String): PrettyPrinter {
        // Make user's output properly idented.
        for (line in stream.lines()) {
            pp.appendLine(line)
        }
        pp
    }

    static func fromConfiguration(conf: Configuration): TestOutputReporter {
        if (conf.captureOutput && conf.noCaptureOutput) {
            reportInconsistentOptions(OP_CAPTURE_OUTPUT, OP_NO_CAPTURE_OUTPUT)
        }
        let launchSource = LaunchSource.fromDefaultConfiguration()
        let capture = !conf.bench && match (launchSource) {
            case TestBinary => conf.captureOutput
            case TestRunner => !conf.noCaptureOutput
        }
        TestOutputReporter(capture, conf.showAllOutput, conf.verbose)
    }

    static func fromDefaultConfiguration(): TestOutputReporter {
        fromConfiguration(defaultConfiguration())
    }

    private static func reportInconsistentOptions(first: String, second: String): Nothing {
        throw UnittestCliOptionsFormatException(
            "Should not use both ${first} and ${second} options at once."
        )
    }
}

private func allSkipped(suiteResult: TestSuiteResult): Bool {
    suiteResult.details.totalCount == suiteResult.details.skippedCount &&
    suiteResult.details.totalCount != 0
}

class PackageTextReport {
    var baselineReport = HashMap<String, Float64>()
    var baselineId: String = ""
    var failures = HashMap<TestCaseId, Int64>()
    PackageTextReport(
        let pp: PrettyPrinter,
        let outputReporter: TestOutputReporter,
        let config: Configuration,
        let detailed!: Bool
    ) {}

    func printPackage(packageResult: TestGroupResult): Unit {
        loadBaseline(packageResult.groupName)
        pp.append("TP: ").appendName(packageResult.groupName)
            .timeElapsed(packageResult.details, config).appendLine(", RESULT:")
        pp.indent {
            for (groupResultPart in packageResult.subResults) {
                match (groupResultPart) {
                    case SuiteResult(suiteResult) => 
                        if (outputReporter.verbose || !allSkipped(suiteResult)) {
                            printTestSuite(suiteResult)
                        }
                    case ProcessError(err) => pp.appendLine("REASON: failed to run package (exit code = ${err.code})")
                }
            }
        }
        saveBaseline(packageResult.groupName)
        if (detailed) {
            pp.indent {
                for (nonTestOuput in packageResult.nonTestOutputs) {
                    outputReporter.report(pp, PrettyText("BEFORE TESTS "), nonTestOuput.outputBeforeTests,
                        success: packageResult.details.isSuccess)
                    outputReporter.report(pp, PrettyText("AFTER TESTS "), nonTestOuput.outputAfterTests,
                        success: packageResult.details.isSuccess)
                }
            }
            printSummary(pp, packageResult, config, printFailures: true)
        }
    }

    private func loadBaseline(groupName: String) {
        if (!defaultConfiguration().bench) { return }

        let reportPath = getReportDirectory(KeyReportPath.reportPath)
        let baselinePath = [getReportDirectory(KeyBaselinePath.baselinePath), reportPath] |> filterMap{ x => x } |> first
        let rawReportFileName = groupName.toSafeFileName()

        if (let Some(baseline) <- baselinePath) {
            let finalPath = baseline.join("benchmarks").join(rawReportFileName)
            if (File.exists(finalPath.toString())) {
                let model = DataModel.fromJson(JsonValue.fromStr(String.fromUtf8(File.readFrom(finalPath))))
                baselineReport = HashMap<String, Float64>.deserialize(model)
            }

            this.baselineId = if (reportPath == baseline) {
                "100% = previous run"
            } else {
                "100% = ${baseline}"
            }
        }
    }

    private func saveBaseline(groupName: String) {
        if (!defaultConfiguration().bench) { return }

        let reportPath = getReportDirectory(KeyReportPath.reportPath) ?? return
        let dir = reportPath.join("benchmarks")
        Directory.ensureExists(dir)

        //temporary workaround for incorrect NaN json serialization
        baselineReport.removeIf { _, v => v.isNaN() }

        let data = baselineReport.serializeInternal().toJson().toJsonString()
        let filePath = dir.join(groupName.toSafeFileName())
        File.writeTo(filePath, data.toArray())
    }

    private func printTestSuite(suiteResult: TestSuiteResult): Unit {
        if (suiteResult.details.totalCount == 0) {
            pp.append("TCS: ").appendName(suiteResult.suiteId.suiteName).append(", ")
            pp.colored(RED, "No test functions found").newLine()
            return
        }
        pp.append("TCS: ").appendName(suiteResult.suiteId.suiteName)
            .timeElapsed(suiteResult.details, config).appendLine(", RESULT:")

        if (let Some(benchTable) <- BenchTable.build(suiteResult, baselineReport)) {
            let builtTable = benchTable.doBuild()
            if (benchTable.hasBaselineHeader && !baselineId.isEmpty()) {
                pp.appendLine(baselineId)
            }
            pp.append(builtTable)
        } else {
            printPositives(suiteResult)
        }
        printNegatives(suiteResult)
    }

    private func printNegatives(suiteResult: TestSuiteResult) {
        suiteResult.visitAll<TestCaseResult> { tcr =>
            if (!tcr.hasFailures()) { return }
            tcr.visitFailedSteps{ step, caseId =>
                printEntry(failEntry(step, caseId))
            }
            if (!detailed) { return }

            let preamble = if (tcr.details.failedSteps == 1) {
                PrettyText()
            } else {
                PrettyText("CASE: ${tcr.caseId.caseName}, ")
            }
            outputReporter.report(pp, preamble, tcr.output, success: false)
        }
    }

    private func printPositives(suiteResult: TestSuiteResult): Unit {
        if (!detailed) { return }

        suiteResult.visitPassedTests { tc =>
            if (tc.details.testcode == SKIP && !outputReporter.verbose) { return }

            let step = tc.subResults[0]
            // print Before all/After all only if there is any output
            if (step.kind.isClassLifecycle() && tc.output.isEmpty()) { return }

            printEntry(TextReportEntry(tc.subResults[0], tc.caseId.caseName))
            outputReporter.report(pp, PrettyText(), tc.output, success: true)
        }
    }

    private func failEntry(rp: RunStepResult, caseId: TestCaseId): TextReportEntry {
        var caseName = caseId.caseName
        let message = match (rp.kind) {
            case Lifecycle(BeforeEach) =>
                lifecycleStageFailedText(BeforeEach, newLine: true)
            case CaseStep(args) =>
                args.intoErrorMessage()
            case Lifecycle(AfterEach) =>
                lifecycleStageFailedText(AfterEach, newLine: true)
            case Lifecycle(s) =>
                caseName = lifecycleStageFailedText(s, newLine: false).toString()
                PrettyText()
            case _ => PrettyText()
        }
        TextReportEntry(rp, caseName, bodyMessage: message)
    }

    private func printEntry(
        entry: TextReportEntry
    ): Unit {
        let (statusColor, success) = match (entry.statusCode) {
            case PASS | SKIP | NORUN => (GREEN, true)
            case TIMEOUT | FAIL | ERROR => (RED, false)
        }

        pp.append("[").colored(statusColor) { pp.appendCentered(entry.statusCode.toStringTense(), 8) }.append("] ")

        pp.append(entry.preamble)
        if (entry.statusCode != SKIP && entry.statusCode != NORUN) {
            pp.append(" (${entry.duration.toNanoseconds()} ns)")
        }
        pp.newLine()

        if (!detailed || entry.statusCode == SKIP || entry.statusCode == NORUN) { return }

        var isFirst = true
        if (let Some(bodyMessage) <- entry.bodyMessage) {
            pp.append("REASON: ").append(bodyMessage)
            isFirst = false
        }

        for (cr in entry.checkResults) {
            if (!(cr is AssertExpectCheckResult) && isFirst) {
                pp.append("REASON: ")
            }
            cr.pprintWithFailedPrefix(pp)
            isFirst = false
        }
    }
}

/**
 * Print a line covering (hopefully) the whole width of output
 */
func appendDashLine(pp: PrettyPrinter): PrettyPrinter {
    if (pp.isTopLevel) {
        pp.appendLine(
            "--------------------------------------------------------------------------------------------------")
    }
    pp
}

class TextReportEntry {
    let checkResults: Array<CheckResult>
    let duration: Duration
    let statusCode: TestCode
    let preamble: PrettyText

    TextReportEntry(
        source: RunStepResult,
        caseName: String,
        let bodyMessage!: ?PrettyText = None
    ) {
        checkResults = source.checkResults
        duration = source.duration
        statusCode = source.statusCode()
        preamble = if (!source.kind.isClassLifecycle()) {
            PrettyText("CASE: ${caseName}")
        } else {
            PrettyText(caseName)
        }
    }
}

class ProjectTextReport {
    ProjectTextReport(
        private let pp: PrettyPrinter,
        private let outputReporter: TestOutputReporter,
        private let config: Configuration
    ) {}

    func printProject(projectResult: ProjectExecutionResult): Unit {
        appendDashLine(pp)
        pp.append("Project tests finished")
            .timeElapsed(projectResult.details, config).appendLine(", RESULT:")
        for (moduleResult in projectResult.subResults) {
            printModuleDetails(moduleResult)
        }
        printSummary(pp, projectResult, config, printFailures: false)
        appendDashLine(pp)
    }

    private func printModuleDetails(moduleResult: ModuleExecutionResult): Unit {
        pp.append("TP: ").appendName(moduleResult.moduleName).append(".*")
            .timeElapsed(moduleResult.details, config).appendLine(", RESULT:")
        pp.indent {
            printPackages(moduleResult)
        }
    }

    private func printPackages(moduleResult: ModuleExecutionResult): Unit {
        let packageResults = moduleResult.subResults
        printEmptyPackages(packageResults)
        printPassedPackages(packageResults)
        printFailedPackages(packageResults)
        printErrorPackages(packageResults)
    }
    
    private func printEmptyPackages(packageResults: ArrayList<TestGroupResult>): Unit {
        var first = true
        for (packageResult in packageResults where
            packageResult.details.totalCount == 0
        ) {
            if (first) {
                pp.appendLine("EMPTY:")
                first = false
            }
            pp.append("TP: ").appendName(packageResult.groupName).newLine()
        }
    }

    private func printPassedPackages(packageResults: ArrayList<TestGroupResult>): Unit {
        var first = true
        for (packageResult in packageResults where
            packageResult.details.totalCount != 0 &&
            packageResult.details.isSuccess
        ) {
            if (first) {
                pp.appendLine("PASSED:")
                first = false
            }
            if (config.noRun) {
                PackageTextReport(pp, outputReporter, config, detailed: true).
                    printPackage(packageResult)
            } else {
                pp.append("TP: ")
                    .appendName(packageResult.groupName)
                    .timeElapsed(packageResult.details, config)
                    .newLine()
            }
        }
    }

    private func printFailedPackages(packageResults: ArrayList<TestGroupResult>): Unit {
        var first = true
        for (packageResult in packageResults where
            !packageResult.details.isSuccess &&
            !packageResult.hasProcessError
        ) {
            if (first) {
                pp.appendLine("FAILED:")
                first = false
            }
            let packageTextReport = PackageTextReport(
                pp,
                outputReporter,
                config,
                detailed: false
            )
            packageTextReport.printPackage(packageResult)
        }
    }

    private func printErrorPackages(packageResults: ArrayList<TestGroupResult>): Unit {
        var first = true
        for (packageResult in packageResults where 
            packageResult.hasProcessError
        ) { 
            if (first) {
                pp.appendLine("ERROR:")
                first = false
            }
            pp.append("TP: ").appendName(packageResult.groupName)
                .timeElapsed(packageResult.details, config).appendLine(", RESULT:")
            packageResult.visitAll<TestProcessError>{ err =>
                pp.indent {
                    pp.appendLine("REASON: failed to run package (exit code = ${err.code})")
                }
            }
        }
    }
}

class TextReports {
    static func printDefaultReport(
        pp: PrettyPrinter,
        packageResult: TestGroupResult,
        outputReporter: TestOutputReporter,
        config: Configuration
    ): Unit {
        appendDashLine(pp)
        PackageTextReport(pp, outputReporter, config, detailed: true).printPackage(packageResult)
        appendDashLine(pp)
    }

    static func printProjectSummaryReport(
        projectResult: ProjectExecutionResult,
        outputReporter: TestOutputReporter,
        config: Configuration
    ): Unit {
        let pp = TerminalPrettyPrinter.fromDefaultConfiguration()
        pp.exclusive { pp =>
            ProjectTextReport(pp, outputReporter, config).printProject(projectResult)
        }
    }

    static func printIntermediatePackageResult(
        pp: TerminalPrettyPrinter,
        packageResult: TestGroupResult,
        outputReporter: TestOutputReporter,
        config: Configuration
    ): Unit {
        if (packageResult.subResults.isEmpty() || config.noRun) { return }

        appendDashLine(pp)

        func prefix() {
            pp.append("TP: ").appendName(packageResult.groupName).append(", ")
        }

        let textReport = PackageTextReport(pp, outputReporter, config, detailed: true)
        textReport.printPackage(packageResult)
    }
}

private func stepName(step: LStep): String {
    match (step) {
        case BeforeEach => "Before each"
        case AfterEach => "After each"
        case BeforeAll => "Before all"
        case AfterAll => "After all"
    }
}

func lifecycleStageFailedText(ls: LStep, newLine!: Bool = false): PrettyText {
    let stepName = stepName(ls)

    let text = PrettyText()
    text.colored(YELLOW, stepName).append(" step failed.")
    match (ls) {
        case BeforeEach => text.append(" ").colored(RED, "Test case not run.")
        case BeforeAll => text.append(" ").colored(RED, "Tests not run.")
        case _ => ()
    }
    if (newLine) {
        text.newLine()
    }
    text
}

private func listFailures<T>(pp: PrettyPrinter, results: ResultContainer<T>): Unit where T <: Result {
    results.visitAll<TestCaseResult>{ tcr =>
        let caseId = tcr.caseId
        if (!tcr.hasFailures() ) { return }
        let steps = if (tcr.details.failedSteps > 1) {
            " (failed ${tcr.details.failedSteps}/${tcr.details.executedSteps} steps)"
        } else if (tcr.details.executedSteps > 1) {
            let failure = tcr.subResults.iterator().filter{ r => r.hasFailures() }.last().getOrThrow()
            match (failure.kind) {
                case CaseStep(arg) where arg.stepIndex + 1 >= tcr.details.executedSteps =>
                    " (failed after ${arg.stepIndex+1} steps)"
                case CaseStep(_) =>
                    " (failed 1/${tcr.details.executedSteps} steps)"
                case _ => ""

            }
        } else {
            ""
        }

        pp.append("TCS: ")
            .appendName(caseId.suiteId.suiteName)
            .append(", CASE: ${caseId.caseName}")
            .append(steps)
            .newLine()
    }
}

func printSummary<T>(pp: PrettyPrinter, result: ResultContainer<T>, config: Configuration, printFailures!: Bool): Unit where T <: Result {
    let details = result.details
    pp.append("Summary: TOTAL: ${details.totalCount}")
    if (config.noRun) {
        pp.append(", ").append(SKIP).append(": ${details.skippedCount}").newLine()
        return
    }
    pp.indent {
        pp.newLine()
        pp.append(PASS).append(": ${details.passedCount}, ")
        pp.append(SKIP).append(": ${details.skippedCount}, ")
        pp.append(ERROR).append(": ${details.errorCount}")
        pp.newLine()
        pp.append(FAIL).append(": ${details.failedCount}")
        if (printFailures && details.failedCount + details.errorCount > 0) {
            pp.append(", listed below:")
            pp.newLine()
            pp.indent(2) {
                listFailures(pp, result)
            }
        } else {
            pp.newLine()
        }
    }
}

extend CheckResult <: PrettyPrintable {
    public func pprintWithFailedPrefix(pp: PrettyPrinter): PrettyPrinter {
        if (let Some(aecr) <- (this as AssertExpectCheckResult)) {
            match (aecr.kind) {
                case Assert => pp.append("Assert Failed: ") // If for whatever reason you want to change this message,
                case Expect => pp.append("Expect Failed: ") // look accurately at PowerAssert message offset
            }
            this.pprint(pp)
            pp.newLine()
        } else {
            this.pprint(pp)
        }
        pp
    }

    public func pprint(pp: PrettyPrinter): PrettyPrinter {
        match (this) {
            case cr: AssertExpectCheckResult =>
                printAssertExpectFailed(cr, pp)
            case cr: ExceptionThrownCheckResult =>
                pp.append(cr.stackTrace).newLine()
            case cr: MockFrameworkCheckResult =>
                pp.append(cr.mockFrameworkMessage).newLine()
            case cr: CrashedCheckResult => pp.append("Crashed with exit code ${cr.exitCode}.").newLine()
            case cr: TimeoutCheckResult => pp.append("Test case ended with timeout.").newLine()
            case cr: NoParametersProvidedResult => pp.append("Test case body was never executed. Provided strategy has zero elements.").newLine()
            case cr: UnattachedCheckResult =>
                pp.append("Found assert that was not attached to a specific test case:")
                    .newLine()
                    .append(cr.inner)
            case _ => throw Exception("Required due to bug in compiler")
        }
        pp
    }

    private func printAssertExpectFailed(cr: AssertExpectCheckResult, pp: PrettyPrinter) {
        match (cr) {
            case resultValue: PlainCompareCheckResult =>
                pp.append("`(").colored(YELLOW, resultValue.leftExpr)
                pp.append(" == ").colored(YELLOW, resultValue.rightExpr)
                pp.appendLine(")`")
                pp.appendLine("   left: ${resultValue.leftValue}")
                pp.appendLine("  right: ${resultValue.rightValue}")
            case resultValue: PowerAssertCheckResult =>
                pp.append("`(")
                resultValue.diagram.pprintExpression(resultValue.expr, pp)
                pp.appendLine(")`")
                resultValue.diagram.setOffset(16) // "Assert Failed: ".size + 1 ("Expect Failed: ".size + 1)
                pp.appendLine(resultValue.diagram)
            case resultValue: PowerAssertExceptionCheckResult =>
                pp.append("`(")
                resultValue.diagram.pprintExpression(resultValue.expression, pp)
                pp.appendLine(")`")
                resultValue.diagram.setOffset(16) // "Assert Failed: ".size + 1 ("Expect Failed: ".size + 1)
                pp.appendLine(resultValue.diagram)
                pp.appendLine(resultValue.exception)
            case resultValue: FailCheckResult =>
                pp.append("`(")
                pp.colored(YELLOW, resultValue.failMessage)
                pp.appendLine(")`")
            case resultValue: AssertThrowsCheckResult =>
                pp.append("`(")
                pp.colored(YELLOW, resultValue.message)
                pp.appendLine(")`")
                pp.appendLine("    expected types: ${resultValue.expectedExceptions}")
                pp.appendLine("  caught exception: ${resultValue.caughtException}")
            case diffValue: DiffCheckResult =>
                pp.append(diffValue.diffMessage)
            case customValue: CustomCheckResult =>
                pp.append(customValue.custom)
            case _ => throw Exception()
        }
    }
}

extend PrettyPrinter {
    func timeElapsed(details: Details, config: Configuration) {
        let duration = details.duration
        if (duration == Duration.Zero || config.noRun) {
            return this
        } else {
            append(", time elapsed: ${duration.toNanoseconds()} ns")
        }
    }
}
