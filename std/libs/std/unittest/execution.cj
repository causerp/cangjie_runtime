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
import std.collection.concurrent.ConcurrentLinkedQueue
import std.process.Process
import std.sync.Semaphore
import std.time.DateTime

let EXIT_CODE_ON_TIMEOUT = 42

struct MainExecutionCtx {
    MainExecutionCtx(
        let nWorkers: Int64,
        let workersQuota: Semaphore,
        let outputReporter: TestOutputReporter,
        let executeCommand: TestPackageExecuteCommand
    ) {}

    func withCommand(command: TestPackageExecuteCommand): MainExecutionCtx {
        MainExecutionCtx(nWorkers, workersQuota, outputReporter, command)
    }
}

func executeSmart(
    packageName: String,
    tests: Array<TestSuite>,
    filterService: FilterService,
    outputReporter: TestOutputReporter,
    needStartWorker!: Bool
): TestGroupResult {
    let processKind = TestProcessKind.fromDefaultConfiguration()
    match (processKind) {
        // Optimization: do not run worker to prevent static initialization happening twice.
        case Main where !needStartWorker =>
            executeWorker(packageName, tests, filterService)
        case Main =>
            let parallelInfo = ParallelInfo.fromDefaultConfiguration()
            let cmd = TestPackageExecuteCommand.fromCurrentProcess()
            let ctx = MainExecutionCtx(parallelInfo.nWorkers, Semaphore(parallelInfo.nWorkers), outputReporter, cmd)
            executeMain(initWorkersMain(ctx), packageName, ctx)
        case Worker(_, _, _, _) =>
            executeWorker(packageName, tests, filterService)
    }
}

func initWorkersMain(ctx: MainExecutionCtx): Array<WorkerProcess> {
    let workers = 0..ctx.nWorkers |> mapParallelOrdered(ctx.nWorkers) { workerId: Int64 =>
        WorkerProcess.createAndRegister(workerId, ctx)
    } |> collectArray // Wait for all test cases registration from workers
    return workers
}

func executeMain(workers: Array<WorkerProcess>, packageName: String, ctx: MainExecutionCtx): TestGroupResult {
    let workerResults = workers |> mapParallelOrdered(ctx.nWorkers) { worker: WorkerProcess =>
        WorkerProcess.executeRestarting(worker, ctx)
    } |> collectArray

    let parsedWorkerResults = ArrayList<TestSuiteResult>()
    let crashWorkerResults = ArrayList<TestProcessError>()
    let nonTestOutputs = ArrayList<NonTestOutputs>()
    for (result in workerResults) {
        match (result) {
            case OkResult(res, output) => 
                parsedWorkerResults.add(all: res)
                nonTestOutputs.add(all: output)
            case CrashResult(res, crash, output) => 
                parsedWorkerResults.add(all: res)
                nonTestOutputs.add(all: output)
                crashWorkerResults.add(crash)
        }
    }

    let uniqueCrahes = uniqueValues(crashWorkerResults)
    let uniqueNonTestOuputs = uniqueValues(nonTestOutputs)
    let mergedTestSuiteResults = TestSuiteResult.mergeAll(parsedWorkerResults)
    return TestGroupResult.fromPackageSuites(packageName, mergedTestSuiteResults, uniqueCrahes, uniqueNonTestOuputs)
}

func uniqueValues<T>(collection: Collection<T>): Array<T> where T <: Hashable {
    let hashToValue = HashMap<Int64, T>()
    for (target in collection) {
        hashToValue.add(target.hashCode(), target)
    }
    return hashToValue.values() |> collectArray
}

func executeWorker(packageName: String, suites: Array<TestSuite>, filterService: FilterService): TestGroupResult {
    let suitesToBeExecuted = registerTestSuites(packageName, suites, filterService)
    let testGroupResult = TestGroupResult(packageName, [])
    for (suite in suitesToBeExecuted) {
        let suiteResult = suite.execute(packageName, defaultConfiguration(), filterService)
        testGroupResult.add(suiteResult)
    }
    testGroupResult.finish()
    testGroupResult
}

private func registerTestSuites(packageName: String, suites: Array<TestSuite>, filterService: FilterService): Array<TestSuite> {
    let suitesToBeExecuted = suites |> filter { suite: TestSuite =>
        let suiteKey = SuiteFilterKey.fromTestSuite(packageName, suite)
        filterService.register(suiteKey, suite)
        let includeSuite = !filterService.frameworkFilter.shouldSkipTestClass(suiteKey)
        if (includeSuite) {
            if (!suite.suiteConfiguration.skip && filterService.userFilter.shouldSkipTestClass(suiteKey)) {
                suite.suiteConfiguration.set(KeySkip.skip, true)
            }
        }
        includeSuite
    } |> collectArray

    let casesToBeExecuted = suitesToBeExecuted |> fold<TestSuite, Int64>(0) { total, suite =>
        let suiteId = TestSuiteId.fromTestSuite(packageName, suite)
        let casesCount = match (suite.suiteConfiguration.get(KeySkip.skip)) {
            case Some(true) => 0
            case _ => suite.casesCountToBeExecuted(filterService, suiteId)
        }
        total + casesCount
    }

    Framework.onTestCasesRegistered(packageName, UInt64(casesToBeExecuted))
    suitesToBeExecuted
}

enum TestProcessKind {
    | Main
    // worker id, number or workers per package, number or test cases to skip, main process port
    | Worker(Int64, Int64, Int64, UInt16)

    static func fromDefaultConfiguration(): TestProcessKind {
        let config = defaultConfiguration()
        match ((
            config.get(KeyInternalWorkerId.internalWorkerId),
            config.get(KeyInternalNWorkers.internalNWorkers),
            config.get(KeyInternalWorkerSkipNTests.internalWorkerSkipNTests),
            config.get(KeyInternalMainProcessPort.internalMainProcessPort)
        )) {
            case (Some(id), Some(nWorkers), Some(nSkip), Some(port)) => Worker(id, nWorkers, nSkip, port)
            case (None, None, None, None) => Main
            case _ => throw Exception(
                "${KeyInternalWorkerId().name}, ${KeyInternalNWorkers().name}," +
                "${KeyInternalWorkerSkipNTests().name} and ${KeyInternalMainProcessPort().name} " +
                "should be provided together"
            )
        }
    }

    prop isWorker: Bool {
        get() {
            match (this) {
                case Main => false
                case Worker(_, _, _, _) => true
            }
        }
    }
}

struct NonTestOutputs <: Hashable {
    NonTestOutputs(
        let outputBeforeTests: CapturedOutput,
        let outputAfterTests: CapturedOutput
    ) {}

    public func hashCode(): Int64 {
        var hasher = DefaultHasher()
        hasher.write(outputBeforeTests.stdout)
        hasher.write(outputBeforeTests.stderr)
        hasher.write(outputAfterTests.stdout)
        hasher.write(outputAfterTests.stderr)
        return hasher.finish()
    }

    init() {
        this(CapturedOutput(), CapturedOutput())
    }

    init(pair: (CapturedOutput, CapturedOutput)) {
        this(pair[0], pair[1])
    }

    func isEmpty(): Bool {
        return outputBeforeTests.isEmpty() && outputAfterTests.isEmpty()
    }
}

private struct BunchExecutionResult {
    BunchExecutionResult(
        let results: Array<ExecutionResult>,
        let status: BunchExecutionResultStatus,
        let nonTestOutputs: NonTestOutputs
    ) {}
}

private enum BunchExecutionResultStatus {
    | FinishedSuccessfuly
    | InProgressTimeout
    | OutOfProgressCrashed(TestProcessError)
    | InProgressCrashed(ExecutionResult)
}

enum ExecuteRestartingResult {
    | OkResult(Collection<TestSuiteResult>, ArrayList<NonTestOutputs>)
    | CrashResult(Collection<TestSuiteResult>, TestProcessError, ArrayList<NonTestOutputs>)
}

class WorkerProcess {
    private WorkerProcess(
        private let process: WrappedProcess,
        private let transportChannel: ?TransportChannel,
        private let progressQueue: ?ConcurrentLinkedQueue<UTProgress>,
        private let outputReporter: TestOutputReporter,
        private let workerId: Int64
    ) {}

    /**
     * Should be called before test cases execution.
     */
    func waitCasesRegistration() {
        match (transportChannel?.receive(limit: 1u64).next()) {
            case Some(Some(p: TestCasesRegistrationPart)) => progressQueue?.add(TestProgressData(p, workerId: workerId))
            case Some(Some(_)) => throw Exception(
                "Expected test cases registration message from worker, but got another message")
            case _ => throw Exception("Expected test cases registration message from worker, but got nothing")
        }
    }

    private func waitExecution(): BunchExecutionResult {
        let messages: Array<ExecutionResultPart> = if (let Some(transportChannel) <- transportChannel) {
            transportChannel.receive() |> inspect { part: ExecutionResultPart =>
                progressQueue?.add(TestProgressData(part, workerId: workerId))
                ()
            } |> collectArray
        } else {
            []
        }

        // if the channel is closed then the process is about to end soon
        // otherwise the process is terminated explicitly by the connection handler due to timeout or an error
        //    so after termination it's going to end as well
        // so the waitpid() invication shouldn't run for long time
        // this is still unsafe though, especially on Windows
        // because on Windows std.process.SubProcess.wait() may accidentally wait on
        // a random irrelevant process so we may stuck forever waiting for some random process to exit
        // this can't be workarounded and need to be entirely rewritten in std.process
        let code = process.wait()

        let output = WorkerOutput(process.stdout(), process.stderr())
        let parseResult = ExecutionResult.combine(messages)
        match (parseResult) {
            case ParsedComplete(results) where code == 0 =>
                let nonTestOutputs = NonTestOutputs(merge(results, output))
                BunchExecutionResult(results, FinishedSuccessfuly, nonTestOutputs)
            case ParsedComplete(results) where code == EXIT_CODE_ON_TIMEOUT =>
                let nonTestOutputs = NonTestOutputs(merge(results, output))
                BunchExecutionResult(results, InProgressTimeout, nonTestOutputs)
            case ParsedComplete(results) => 
                let nonTestOutputs = NonTestOutputs(merge(results, output))
                let error = TestProcessError(code)
                BunchExecutionResult(results, OutOfProgressCrashed(error), nonTestOutputs)
            case ParsedIncomplete(results, header) =>
                let (beforeTests, lastOutput) = merge(results, output)
                let nonTestsOutput = NonTestOutputs(beforeTests, CapturedOutput())
                let status = InProgressCrashed(mkCrashResult(header, lastOutput, code))
                BunchExecutionResult(results, status, nonTestsOutput)
        }
    }

    private func continueExecution() {
        transportChannel?.send(ExecutionPermitPart())
    }

    private func merge(
        bunchResults: Array<ExecutionResult>, output: WorkerOutput
    ): (beforeTests: CapturedOutput, lastOutput: CapturedOutput) {
        if (!outputReporter.capture) { return (CapturedOutput(), CapturedOutput()) }

        let outputs: Array<CapturedOutput> = try {
            output.captured
        } catch (e: IllegalStateException) {
            printDebugOutput(output)
            throw Exception("Internal error: output streams have different number of sections (${e.message})")
        }
        
        if (outputs.size == 1) {
            return (outputs[0], CapturedOutput())
        }
        let outputAfterTests = outputs[outputs.size - 1]
        let (begin, end, outputBeforeTests) = if (bunchResults.size + 2 == outputs.size) {
            (1, outputs.size - 1, outputs[0])
        } else if (bunchResults.size + 1 == outputs.size) {
            (0, outputs.size, CapturedOutput())
        } else {
            printDebugOutput(output)
            throw Exception(
                "Internal error: expected nOutputs == nResults, but got nOutputs=${outputs.size}, nResults=${bunchResults.size}")
        }
        for ((result, out) in bunchResults |> zip(outputs[begin..end])) {
            if (result.hasFailures || outputReporter.showAllOutput) {
                result.add(out)
            }
        }
        (outputBeforeTests, outputAfterTests)
    }

    static func create(ctx: MainExecutionCtx, workerId: Int64, progressQueue: ?ConcurrentLinkedQueue<UTProgress>,
        connect: () -> TransportChannel): WorkerProcess {
        let process = Process.start(ctx)
        let connection: ?TransportChannel = try {
            connect()
        } catch (_: Exception) {
            process.terminate()
            None
        }

        return WorkerProcess(process, connection, progressQueue, ctx.outputReporter, workerId)
    }

    static func createAndRegister(workerId: Int64, ctx: MainExecutionCtx): WorkerProcess {
        ctx.workersQuota.doWith {
            let execution = startWorker(workerId: workerId, ctx: ctx)
            if (execution.hasTransportChannel()) {
                execution.waitCasesRegistration()
            }
            execution
        }
    }

    static func executeRestarting(initialWorker: WorkerProcess, ctx: MainExecutionCtx): ExecuteRestartingResult {
        ctx.workersQuota.doWith {
            var currentTestIdx = 0
            let workerId = initialWorker.workerId
            let nonTestOutput = ArrayList<NonTestOutputs>()
            var outOfprogressCrashed: ?TestProcessError = None
            let bunchResults = HashMap<TestSuiteId, TestSuiteResult>()
            while (true) {
                let execution = match(currentTestIdx) {
                    case 0 =>
                        initialWorker.continueExecution()
                        initialWorker
                    case _ => startWorker(workerId: workerId, startingTestIdx: currentTestIdx, ctx: ctx)
                }
                let result = execution.waitExecution()
                nonTestOutput.add(result.nonTestOutputs)
                commitResults(bunchResults, result.results)
                let nSkipCrashed = match (result.status) {
                    case FinishedSuccessfuly => break
                    case InProgressTimeout => 0
                    case OutOfProgressCrashed(crashResult) =>
                        outOfprogressCrashed = crashResult
                        break
                    case InProgressCrashed(crashResult) => commitCrashResult(bunchResults, crashResult)
                }
                let nSkipPassed = result.results |> filter { it: ExecutionResult => it.isCase } |> count
                currentTestIdx += nSkipPassed + nSkipCrashed
            }
            bunchResults.values() |> forEach { result => result.finish() }
            if (let Some(crash) <- outOfprogressCrashed) {
                return ExecuteRestartingResult.CrashResult(bunchResults.values(), crash, nonTestOutput)
            }
            return ExecuteRestartingResult.OkResult(bunchResults.values(), nonTestOutput)
        }
    }

    private static func startWorker(workerId!: Int64, startingTestIdx!: Int64 = 0, ctx!: MainExecutionCtx): WorkerProcess {
        let workerCommand = ctx.executeCommand.withArgs(
            "--${KeyInternalWorkerId().name}=${workerId}",
            "--${KeyInternalWorkerSkipNTests().name}=${startingTestIdx}",
            "--${KeyInternalNWorkers().name}=${ctx.nWorkers}"
        )
        Framework.initWorker(ctx.withCommand(workerCommand), workerId: workerId)
    }

    private static func commitCrashResult(
        bunchResults: HashMap<TestSuiteId, TestSuiteResult>,
        crashResult: ExecutionResult
    ): Int64 {
        match (crashResult.header) {
            case header: LifecycleExecutionResultHeader where header.step == BeforeAll =>
                // We try to execute suite cases one by one and each of them can report same before all crash.
                if (!bunchResults.contains(crashResult.suiteId)) {
                    commitResults(bunchResults, [crashResult])
                }
                1
            case header: LifecycleExecutionResultHeader where header.step == AfterAll =>
                commitResults(bunchResults, [crashResult])
                0 // no skip
            case _ =>
                commitResults(bunchResults, [crashResult])
                1
        }
    }

    private static func commitResults(
        bunchResults: HashMap<TestSuiteId, TestSuiteResult>,
        results: Array<ExecutionResult>
    ): Unit {
        for (result in results) {
            let suiteResult = bunchResults.getOrInsert(result.suiteId) { =>
                TestSuiteResult(result.suiteId)
            }
            suiteResult.add(result.stepResult)
        }
    }

    private static func mkCrashResult(header: ExecutionResultHeader, output: CapturedOutput, code: Int64): ExecutionResult {
        let crash = RunStepResult(0, header.startTime, crashStepKindOf(header), Failure([CrashedCheckResult(code)]))
        let caseResult = match (header) {
            case lHeader: LifecycleExecutionResultHeader =>
                let id = TestCaseId(lHeader.suiteId, lHeader.step.toString(), isBench: false)
                TestCaseResult.fromSingleStep(id, crash)
            case caseHeader: TestCaseExecutionResultHeader =>
                TestCaseResult.fromSingleStep(caseHeader.caseId, crash)
            case _ => throw Exception("Unreachable")
        }
        let result = ExecutionResult(header, ExecutionResultBody(caseResult))
        result.add(output)
        result
    }

    private static func crashStepKindOf(header: ExecutionResultHeader): StepKind {
        match (header) {
            case header: LifecycleExecutionResultHeader => Lifecycle(header.step)
            case _: TestCaseExecutionResultHeader => CaseStep(ArgumentDescription(None, 0, 0, None))
            case _ => throw Exception("Unreachable")
        }
    }

    private static func reportWorkerInternalCrash(output: WorkerOutput, code: Int64): Nothing {
        printDebugOutput(output)
        throw Exception(
            "Worker test process unexpectedly failed (code = ${code}). " +
            "Some code crashed outside of the @TestCase or lifecycle methods."
        )
    }

    private static func printDebugOutput(output: WorkerOutput): Unit {
        eprintln("STDOUT:")
        for (out in output.stdouts) {
            eprint(out)
        }
        eprintln("")
        eprintln("STDERR:")
        for (err in output.stderrs) {
            eprint(err)
        }
        eprintln("")
    }

    private func hasTransportChannel(): Bool {
        return transportChannel.isSome()
    }
}

abstract class ExecutionResultPart <: Serializable<ExecutionResultPart> {
    public func serializeInternal(): DataModel {
        match (this) {
            case thiz: TestCaseExecutionResultHeader =>
                DataModelStruct().
                    add(field<Int8>("tag", 0)).
                    add(field<TestCaseId>("caseId", thiz.caseId)).
                    add(field<String>("startTime", thiz.startTime.toString()))
            case thiz: LifecycleExecutionResultHeader =>
                DataModelStruct().
                    add(field<Int8>("tag", 1)).
                    add(field<TestSuiteId>("suiteId", thiz.suiteId)).
                    add(field<LStep>("step", thiz.step)).
                    add(field<String>("startTime", thiz.startTime.toString()))
            case thiz: ExecutionResultBody =>
                DataModelStruct().
                    add(field<Int8>("tag", 2)).
                    add(field<Result>("stepResult", thiz.stepResult))
            case thiz: TestCasesRegistrationPart =>
                DataModelStruct().
                    add(field<Int8>("tag", 3)).
                    add(field<UInt64>("tests", thiz.casesCount)).
                    add(field<Int64>("workerId", thiz.workerId)).
                    add(field<String>("package", thiz.packageName))
            case thiz: ExecutionPermitPart =>
                DataModelStruct().add(field<Int8>("tag", 4))
            case _ => throw Exception("Unreachable")
        }
    }

    public static func deserialize(dm: DataModel): ExecutionResultPart {
        let dms = dm.asStruct()
        match (Int8.deserialize(dms.get("tag"))) {
            case 0 => TestCaseExecutionResultHeader(
                TestCaseId.deserialize(dms.get("caseId")),
                DateTime.parse(String.deserialize(dms.get("startTime")))
            )
            case 1 => LifecycleExecutionResultHeader(
                TestSuiteId.deserialize(dms.get("suiteId")),
                LStep.deserialize(dms.get("step")),
                DateTime.parse(String.deserialize(dms.get("startTime")))
            )
            case 2 => ExecutionResultBody(
                (Result.deserialize(dms.get("stepResult")) as TestCaseResult).getOrThrow()
            )
            case 3 => TestCasesRegistrationPart(
                UInt64.deserialize(dms.get("tests")),
                workerId: Int64.deserialize(dms.get("workerId")),
                packageName: String.deserialize(dms.get("package"))
            )
            case 4 => ExecutionPermitPart()
            case tag => throw Exception("Unknown result part tag: ${tag}")
        }
    }
}

/**
 * Should be written before execution of case or step to be able to identify this test in case of crash.
 */
abstract class ExecutionResultHeader <: ExecutionResultPart {
    public prop suiteId: TestSuiteId
    public prop startTime: DateTime
}

class TestCaseExecutionResultHeader <: ExecutionResultHeader {
    TestCaseExecutionResultHeader(let caseId: TestCaseId, private let startTime_: DateTime) {}
    public override prop suiteId: TestSuiteId { get() { caseId.suiteId } }
    public override prop startTime: DateTime { get() { startTime_ } }
}

class LifecycleExecutionResultHeader <: ExecutionResultHeader {
    LifecycleExecutionResultHeader(private let suiteId_: TestSuiteId, let step: LStep, private let startTime_: DateTime) {}
    public override prop suiteId: TestSuiteId { get() { suiteId_ } }
    public override prop startTime: DateTime { get() { startTime_ } }
}

class ExecutionResultBody <: ExecutionResultPart {
    ExecutionResultBody(let stepResult: TestCaseResult) {}
}

/**
 * Workers should send this part before execution as test cases registration is the initial job in the workflow.
 */
class TestCasesRegistrationPart <: ExecutionResultPart {
    TestCasesRegistrationPart(let casesCount: UInt64, let workerId!: Int64, let packageName!: String) {}
}

/**
 * Data, that sent from Main process for a Worker if it's allowed to continue execution after test cases registration.
 */
class ExecutionPermitPart <: ExecutionResultPart {
    ExecutionPermitPart() {}
}

private enum ExecutionsParseResult {
    | ParsedComplete(Array<ExecutionResult>)
    | ParsedIncomplete(Array<ExecutionResult>, ExecutionResultHeader)
}

private struct ExecutionResult {
    ExecutionResult(let header: ExecutionResultHeader, let body: ExecutionResultBody) {}

    prop suiteId: TestSuiteId {
        get() { header.suiteId }
    }

    prop startTime: DateTime {
        get() { header.startTime }
    }

    prop stepResult: TestCaseResult {
        get() { body.stepResult }
    }

    prop isCase: Bool {
        get() { header is TestCaseExecutionResultHeader }
    }

    prop hasFailures: Bool {
        get() { body.stepResult.hasFailures() }
    }

    func add(output: CapturedOutput): Unit {
        this.body.stepResult.addOutput(output)
    }

    static func combine(parts: Array<ExecutionResultPart>): ExecutionsParseResult {
        if (parts.isEmpty()) {
            return ParsedComplete([])
        }

        let results = ArrayList<ExecutionResult>()
        var currentHeader: ?ExecutionResultHeader = None
        for (part in parts) {
            match ((currentHeader, part)) {
                case (_, newHeader: ExecutionResultHeader) =>
                    currentHeader = newHeader
                case (None, _: ExecutionResultBody) =>
                    throw Exception("Result header is expected before data")
                case (Some(header), body: ExecutionResultBody) =>
                    let result = ExecutionResult(header, body)
                    results.add(result)
                    currentHeader = None
                case (_, _: TestCasesRegistrationPart) => () // Repetitive registration could happen if worker crashes, just skip it.
                case _ => throw Exception("Required due to bug in compiler")
            }
        }
        match (currentHeader) {
            case None => ParsedComplete(results.toArray())
            case Some(header) => ParsedIncomplete(results.toArray(), header)
        }
    }
}
