/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest

import std.unittest.common.*
import std.collection.*
import std.fs.*
import std.process.*
import std.sync.Semaphore

private let OP_INTERNAL_TESTRUNNER_INPUT_PATH_NAME = camelCaseToKebabCase(KeyInternalTestrunnerInputPath().name)
private let OP_INTERNAL_TESTRUNNER_INPUT_PATH = "--${OP_INTERNAL_TESTRUNNER_INPUT_PATH_NAME}"

extend Configuration {
    prop launchedWithTestRunner: Bool {
        get() {
            get(KeyInternalTestrunnerInputPath.internalTestrunnerInputPath).isSome()
        }
    }
}

private let MAX_N_WORKERS_PER_PACKAGE = 5

public func entryMain(testPackage: TestPackage): Int64 {
    if (printUnittestHelpPageIfRequested()) {
        return 0
    }
    /* -m Compiler completes the module name in the constructor */
    /* -p Compiler completes the package name in the constructor */
    let reportFormat = ReportFormat.fromDefaultConfiguration() // check report options correctness before tests execution
    let testGroup = testPackage.build()
    let outputReporter = TestOutputReporter.fromDefaultConfiguration()
    let progressReporter = ProgressReporter.fromDefaultConfiguration()
    progressReporter?.startReporting()
    let filterService = FilterService.fromDefaultConfiguration()
    let hasWorersInSetup = needStartWorker(testGroup.suites, outputReporter) || TestProcessKind
        .fromDefaultConfiguration()
        .isWorker
    let result = Framework.launch(api: FromCli, progressQueue: progressReporter?.updateQueue,
        hasWorkersInSetup: hasWorersInSetup) {
        => executeSmart(testGroup.name, testGroup.suites, filterService, outputReporter,
            needStartWorker: hasWorersInSetup)
    }

    progressReporter?.stopAndClear()
    if (!TestProcessKind.fromDefaultConfiguration().isWorker) {
        let pp = TerminalPrettyPrinter.fromDefaultConfiguration()
        TextReports.printDefaultReport(pp, result, outputReporter, defaultConfiguration())
        reportFormat?.report(result)
    }
    errorCode(result.details)
}

// Test runner should be placed in std package to be able to call it.
protected func testRunnerEntryMain(): Int64 {
    let nWorkers = ParallelInfo.fromDefaultConfiguration().nWorkers
    let semaphore = Semaphore(nWorkers)
    // We need to prevent situation when user wants to use 300 workers but
    // we are executing a lot of small packages and many worker processes just start,
    // figure out that there is nothing to do and terminate.
    let nWorkersPerPackage = if (defaultConfiguration().noRun) { 1 } else {
        min(MAX_N_WORKERS_PER_PACKAGE, nWorkers)
    }
    let parallelCtx = ParallelCtx(nWorkersPerPackage, semaphore)
    let format = ReportFormat.fromDefaultConfiguration()
    let outputReporter = TestOutputReporter.fromDefaultConfiguration()
    let progressReporter = ProgressReporter.fromDefaultConfiguration()
    progressReporter?.startReporting()
    let perPackageReporter = PerPackageReporter(format, outputReporter)
    let reportCtx = ReportCtx(perPackageReporter, outputReporter)
    let project = ExecutableTestProject.fromDefaultConfiguration()
    let projectResult = Framework.launch(api: FromCli, progressQueue: progressReporter?.updateQueue,
        hasWorkersInSetup: true) {
        project.execute(parallelCtx, reportCtx)
    }
    TextReports.printProjectSummaryReport(projectResult, outputReporter, defaultConfiguration())
    progressReporter?.stopAndClear()
    errorCode(projectResult.details)
}

// NOTE: Project/Module results only exists in our model of execution
// they're not available for users to interact with them
class ModuleExecutionResult <: ResultContainer<TestGroupResult> {
    ModuleExecutionResult(
        let moduleName: String
    ) {}
}

class ProjectExecutionResult <: ResultContainer<ModuleExecutionResult> {}

class PackageExecutionResult {
    PackageExecutionResult(let packageResult: TestGroupResult) {}
}

// Serialization should remain compatible with previous versions cause CJPM uses it.
private struct ExecutableTestProject <: Serializable<ExecutableTestProject> {
    ExecutableTestProject(let testModules: Array<ExecutableTestModule>) {}
    static let API_VERSION = 2

    public func serializeInternal(): DataModel {
        throw Exception("Implemented in CJPM")
    }

    public static func deserialize(dm: DataModel): ExecutableTestProject {
        let dms = dm as DataModelStruct ?? throw Exception("Data is expected to be a DataModelStruct")
        if (Int64.deserialize(dms.get("apiVersion")) != API_VERSION) {
            throw Exception("This version of CJPM is not compatible with std.unittest")
        }
        ExecutableTestProject(
            Array<ExecutableTestModule>.deserialize(dms.get("testModules"))
        )
    }

    static func fromJson(string: String): ExecutableTestProject {
        string |>
            JsonValue.fromStr |>
            DataModelStruct.fromJson |>
            ExecutableTestProject.deserialize
    }

    static func fromDefaultConfiguration(): ExecutableTestProject {
        if (let Some(path) <- defaultConfiguration().get(KeyInternalTestrunnerInputPath.internalTestrunnerInputPath)) {
            Path(path) |> File.readFrom |> String.fromUtf8 |> ExecutableTestProject.fromJson
        } else {
            eprintln(
                "Error: std.testrunner executable is expected to be called only by 'cjpm test' command internally.")
            throw Exception("${OP_INTERNAL_TESTRUNNER_INPUT_PATH} is expected")
        }
    }

    func execute(parallelCtx: ParallelCtx, reportCtx: ReportCtx): ProjectExecutionResult {
        this.testModules |> mapParallelOrdered(this.testModules.size) { testModule =>
            testModule.registerTestCases(parallelCtx, reportCtx)
        } |> collectArray

        let projectResult = ProjectExecutionResult()
        this.testModules |>
            mapParallelOrdered(this.testModules.size) { testModule =>
                testModule.execute(parallelCtx, reportCtx)
            } |>
            forEach(projectResult.add)
        projectResult.finish()
        projectResult
    }
}

// Serialization should remain compatible with previous versions cause CJPM uses it.
private struct ExecutableTestModule <: Serializable<ExecutableTestModule> {
    ExecutableTestModule(let name: String, let testPackages: Array<ExecutableTestPackage>) {}

    public func serializeInternal(): DataModel {
        throw Exception("Implemented in CJPM")
    }

    public static func deserialize(dm: DataModel): ExecutableTestModule {
        let dms = dm as DataModelStruct ?? throw Exception("Data is expected to be a DataModelStruct")
        ExecutableTestModule(
            String.deserialize(dms.get("name")),
            Array<ExecutableTestPackage>.deserialize(dms.get("testPackages"))
        )
    }

    func registerTestCases(parallelCtx: ParallelCtx, reportCtx: ReportCtx): Unit {
        this.testPackages |> mapParallelOrdered(this.testPackages.size) { testPackage =>
            testPackage.registerTestCases(parallelCtx, reportCtx)
        } |> collectArray
    }

    func execute(parallelCtx: ParallelCtx, reportCtx: ReportCtx): ModuleExecutionResult {
        let packageResults = ModuleExecutionResult(name)
        this.testPackages |> mapParallelOrdered(this.testPackages.size) { testPackage =>
            let packageResult = testPackage.execute(parallelCtx, reportCtx)
            reportCtx.perPackageReporter.printIntermediateResult(packageResult)
            reportCtx.perPackageReporter.dumpPackageReport(packageResult)
            packageResult.packageResult
        } |> forEach(packageResults.add)
        packageResults.finish()
        // at this point we're no longer storing output streams after they've been reported
        packageResults
    }
}

// Serialization should remain compatible with previous versions cause CJPM uses it.
private struct ExecutableTestPackage <: Serializable<ExecutableTestPackage> {
    ExecutableTestPackage(let name: String, let executeCommand: TestPackageExecuteCommand) {}

    public func serializeInternal(): DataModel {
        throw Exception("Implemented in CJPM")
    }

    public static func deserialize(dm: DataModel): ExecutableTestPackage {
        let dms = dm as DataModelStruct ?? throw Exception("Data is expected to be a DataModelStruct")
        ExecutableTestPackage(
            String.deserialize(dms.get("name")),
            TestPackageExecuteCommand.deserialize(dms.get("executeCommand"))
        )
    }

    private let registeredWorkers = ArrayList<WorkerProcess>()

    private func buildExecutionContext(parallelCtx: ParallelCtx, reportCtx: ReportCtx): MainExecutionCtx {
        let inheritingCommand = this.executeCommand
            .overridingCurrentEnv()
            .withJsonConfiguration()
            .withRunnerOption()
        MainExecutionCtx(
            parallelCtx.nWorkersPerPackage,
            parallelCtx.workersQuota,
            reportCtx.outputReporter,
            inheritingCommand
        )
    }

    func registerTestCases(parallelCtx: ParallelCtx, reportCtx: ReportCtx): Unit {
        // It will require too much refactoring to get whole environment from CJPM,
        // so we reuse current one overriding some properties.
        registeredWorkers.add(all: initWorkersMain(buildExecutionContext(parallelCtx, reportCtx)))
    }

    func execute(parallelCtx: ParallelCtx, reportCtx: ReportCtx): PackageExecutionResult {
        let ctx = buildExecutionContext(parallelCtx, reportCtx)
        let result = PackageExecutionResult(executeMain(registeredWorkers.toArray(), this.name, ctx))
        registeredWorkers.clear()
        return result
    }
}

// Serialization should remain compatible with previous versions cause CJPM uses it.
struct TestPackageExecuteCommand <: Serializable<TestPackageExecuteCommand> {
    TestPackageExecuteCommand(
        public let command: String,
        public let args: Array<String>,
        public let env: Map<String, String>
    ) {}

    public func serializeInternal(): DataModel {
        throw Exception("Implemented in CJPM")
    }

    public static func deserialize(dm: DataModel): TestPackageExecuteCommand {
        let dms = dm as DataModelStruct ?? throw Exception("Data is expected to be a DataModelStruct")
        TestPackageExecuteCommand(
            String.deserialize(dms.get("command")),
            Array<String>.deserialize(dms.get("args")),
            HashMap<String, String>.deserialize(dms.get("env"))
        )
    }

    func overridingCurrentEnv(): TestPackageExecuteCommand {
        let env = HashMap<String, String>()
        try {
            env.add(all: Process.current.environment)
        } catch (_: ProcessException) { /* do nothing */ }
        env.add(all: this.env)
        TestPackageExecuteCommand(command, args, env)
    }

    func withJsonConfiguration(): TestPackageExecuteCommand {
        let args = ArrayList<String>()
        args.add(all: this.args)
        for (arg in Process.currentArgs where arg.contains("--json-configuration")) {
            args.add(arg)
        }
        TestPackageExecuteCommand(command, args.toArray(), env)
    }

    /**
     * Save information about launching from test runner.
     */
    func withRunnerOption(): TestPackageExecuteCommand {
        for (arg in Process.currentArgs where arg.contains(OP_INTERNAL_TESTRUNNER_INPUT_PATH)) {
            return TestPackageExecuteCommand(command, args + arg, env)
        }
        throw Exception("Expected test runner input")
    }

    func withArgs(newArgs: Array<String>): TestPackageExecuteCommand {
        let args = ArrayList<String>()
        args.add(all: this.args)
        args.add(all: newArgs)
        TestPackageExecuteCommand(command, args.toArray(), env)
    }

    static func fromCurrentProcess(): TestPackageExecuteCommand {
        let env = HashMap<String, String>()
        try {
            env.add(all: Process.current.environment)
        } catch (_: ProcessException) { /* do nothing */ }
        TestPackageExecuteCommand(Process.current.command, Process.currentArgs, env)
    }
}

struct ParallelCtx {
    ParallelCtx(let nWorkersPerPackage: Int64, let workersQuota: Semaphore) {}
}

struct ReportCtx {
    ReportCtx(let perPackageReporter: PerPackageReporter, let outputReporter: TestOutputReporter) {}
}

class PerPackageReporter {
    PerPackageReporter(private let format: ?ReportFormat, private let outputReporter: TestOutputReporter) {}

    func printIntermediateResult(executionResult: PackageExecutionResult) {
        let pp = TerminalPrettyPrinter.fromDefaultConfiguration()
        pp.exclusive { pp =>
            let packageResult = executionResult.packageResult
            TextReports.printIntermediatePackageResult(pp, packageResult, outputReporter, defaultConfiguration())
        }
    }

    func dumpPackageReport(executionResult: PackageExecutionResult) {
        format?.report(executionResult.packageResult)
    }
}

private func errorCode(details: Details): Int64 {
    if (TestProcessKind.fromDefaultConfiguration().isWorker) {
        0
    } else {
        details.errorCount + details.failedCount
    }
}

private func needStartWorker(tests: Array<TestSuite>, outputReporter: TestOutputReporter): Bool {
    isParallelEnabled() || deathAwareEnabled() || anyTimeout(tests) || outputReporter.capture
}

private func isParallelEnabled(): Bool {
    let parallelInfo = ParallelInfo.fromDefaultConfiguration()
    match (parallelInfo) {
        case Parallel(_) => true
        case NoParalell => false
    }
}

private func deathAwareEnabled(): Bool {
    defaultConfiguration().get(KeyDeathAware.deathAware) ?? false
}

private func anyTimeout(suites: Array<TestSuite>): Bool {
    if (defaultConfiguration().timeout.isSome()) {
        return true
    }
    if (suites |> any { it => it.suiteConfiguration.timeout.isSome() }) {
        return true
    }
    suites |>
        flatMap<TestSuite, CaseOrBench> { it => it.cases } |>
        any<CaseOrBench> { it => it.caseConfiguration.timeout.isSome() }
}
