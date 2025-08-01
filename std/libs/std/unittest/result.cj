/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest

import std.unittest.common.*
import std.time.DateTime
import std.collection.*

interface Result <: Serializable<Result> {
    // maybe rename to visitSubResults?
    func visitChildren(visitor: (Result) -> Unit): Unit {}

    func walk(visitor: (Result) -> Unit): Unit {
        visitor(this)
        visitChildren{ x => x.walk(visitor) }
    }

    func serializeInternal(): DataModel {
        match (this) {
            case step: RunStepResult =>
                step.doSerialize().add(field<String>("kind", "step"))
            case testCase: TestCaseResult =>
                testCase.doSerialize().add(field<String>("kind", "case"))
            case suite: TestSuiteResult =>
                suite.doSerialize().add(field<String>("kind", "suite"))
            case group: TestGroupResult =>
                group.doSerialize().add(field<String>("kind", "group"))
            case _ => throw Exception("Required due to bug in compiler")
        }
    }

    static func deserialize(dm: DataModel): Result {
        let dms = dm.asStruct()
        let kind = String.deserialize(dms.get("kind"))
        match (kind) {
            case "step" => RunStepResult.doDeserialize(dms)
            case "case" => TestCaseResult.doDeserialize(dms)
            case "suite" => TestSuiteResult.doDeserialize(dms)
            case "group" => TestGroupResult.doDeserialize(dms)
            case _ => throw Exception("invalid kind ${kind}")
        }
    }

    prop details: Details
}

abstract class ResultContainer<T> <: Result where T <: Result {
    let subResults = ArrayList<T>()

    public func visitChildren(visitor: (Result) -> Unit): Unit {
        for (r in subResults) {
            visitor(r)
        }
    }

    public open func add(child: T) {
        if (!finished) {
            subResults.add(child)
        } else {
            throw IllegalStateException("Should only be called while collecting results")
        }
    }

    protected var _details: Details = Details()
    private var _detailsComputed = false
    private var finished: Bool = false

    prop isFinished: Bool {
        get() {
            finished
        }
    }

    // lazily calculated after execution is finished
    public prop details: Details {
        get() {
            if (_detailsComputed) { return _details }

            if (!finished) {
                throw IllegalStateException("Should be called only after test execution is finished.")
            }

            visitChildren { child =>
                _details.add(child.details)
            }

            _detailsComputed = true
            _details
        }
    }

    func finish(): Unit {
        if (finished) { return }
        visitChildren { child =>
            match (child) {
                case c: ResultContainer<Result> => c.finish()
                case _ => ()
            }
        }
        finished = true
    }

    func visitAll<V>(visitor: (V) -> Unit): Unit where V <: Result {
        walk { node =>
            visitor(node as V ?? return)
        }
    }

    private func forAllStepsWithParent(visitor: (RunStepResult, TestCaseResult) -> Unit) {
        let currentCase: Box<?TestCaseResult> = Box(None)
        visitAll<Result> { r =>
            match (r) {
                case r: TestCaseResult => currentCase.value = r
                // case r: RunStepResult where !r.isPartOfTestCase() => visitor(r, None)
                case r: RunStepResult => visitor(r, currentCase.value.getOrThrow())
                case _ => ()
            }
        }
    }

    public func visitPassedTests(visitor: (TestCaseResult) -> Unit) {
        visitAll<TestCaseResult> { r =>
            if (r.hasFailures()) { return }
            visitor(r)
        }
    }

    public func visitPassedBenches(visitor: (BenchStepEntry) -> Unit) {
        forAllStepsWithParent { r, c =>
            if (r.statusCode().isFailure()) { return }

            if (let Bench(result) <- r.info) {
                if (let CaseStep(arg) <- r.kind) {
                    visitor(BenchStepEntry(result, arg, c.caseId, c.renderOptions.measurementInfo ?? TimeNow().info))
                }
            }
        }
    }

    public func visitFailedSteps(visitor: (RunStepResult, TestCaseId) -> Unit) {
        forAllStepsWithParent { r, c =>
            if (!r.hasFailures()) { return }
            visitor(r,c.caseId)
        }
    }

    func serializeSubResults(): DataModelStruct{
        let serializablePieces = ArrayList<Result>()
        visitChildren{ s =>
            serializablePieces.add(s)
        }
        DataModelStruct()
            .add(field<ArrayList<Result>>("subResults", serializablePieces))
    }
}

struct BenchStepEntry {
    BenchStepEntry(
        let result: BenchmarkResult,
        let arg: ArgumentDescription,
        let caseId: TestCaseId,
        let measurementInfo: MeasurementInfo
    ) {
        result.calculate()
    }
}

class RunStepResult <: Result {
    RunStepResult(
        let checksPassed: Int64,
        let startTimestamp: DateTime,
        let kind: StepKind,
        let info: StepInfo,
        let duration!: Duration = DateTime.now() - startTimestamp
    ) {}

    public prop details: Details {
        get() {
            let isAccountedStep = !kind.isClassLifecycle() || hasFailures()
            let d = Details(statusCode(), isAccountedStep)

            d.executedSteps = match (info) {
                case Test(x) => x
                case Bench(_) => 1
                case Failure(_) =>
                    d.failedSteps = 1
                    1
            }
            d.startTimestamp = startTimestamp
            d.duration = duration
            d
        }
    }

    static func simpleError(step: StepKind, check: CheckResult): RunStepResult {
        RunStepResult(0, DateTime.now(), step, Failure([check]), duration: Duration.Zero)
    }

    public func hasFailures(): Bool {
        statusCode().isFailure()
    }

    public prop checkResults: Array<CheckResult> {
        get() {
            match (info) {
                case Failure(c) => c
                case _ => []
            }
        }
    }

    public func statusCode(): TestCode {
        var code = match (kind) {
            case Skip => TestCode.SKIP
            case NoRun => TestCode.NORUN
            case _ => TestCode.PASS
        }

        let checkResults = match (info) {
            case Failure(_) where kind.isClassLifecycle() => return ERROR
            case Failure(c) => c
            case _ => return code
        }
        for (cr in checkResults) {
            let tc = match (cr) {
                case _: AssertExpectCheckResult => FAIL
                case _: MockFrameworkCheckResult => FAIL
                case _: TimeoutCheckResult => FAIL
                case _ => ERROR
            }

            code = code.mostSevereWith(tc)
            if (code == ERROR) { return code }
        }
        return code
    }
}

class TestCaseResult <: ResultContainer<RunStepResult> {
    TestCaseResult(
        let caseId: TestCaseId,
        let renderOptions: RenderOptions
    ) {}

    static func fromSingleStep(id: TestCaseId, step: RunStepResult) {
        let caseResult = TestCaseResult(id, RenderOptions(None, None))
        caseResult.add(step)
        caseResult.finish()
        caseResult
    }

    private var _output: CapturedOutput = CapturedOutput()
    prop output: CapturedOutput {
        get() {
            _output
        }
    }

    public func addOutput(output: CapturedOutput): Unit {
        _output = output
    }

    // We can't store all successfull steps because there can be too much of them,
    // so we store only last successfull step but make it contain some info from previous steps
    // if in future we will want to count successfull steps as well we can do that here
    public func addSuccessfullStep(next: RunStepResult) {
        let first = subResults[0]
        let steps = if (let Test(steps) <- first.info) {
            steps
        } else {
            throw IllegalStateException("Unreachable")
        }
        let newResult = RunStepResult(
            first.checksPassed + next.checksPassed,
            first.startTimestamp,
            next.kind,
            Test(steps + 1),
            duration: first.duration + next.duration,
        )
        subResults[0] = newResult
    }

    public func hasFailures(): Bool {
        subResults |> any { s => s.hasFailures() }
    }

}

struct CapturedOutput {
    CapturedOutput(let stdout: String, let stderr: String) {}

    init() {
        this("", "")
    }

    init(stdout: Array<Byte>, stderr: Array<Byte>) {
        this(String.fromUtf8(stdout), String.fromUtf8(stderr))
    }

    func isEmpty(): Bool {
        stdout.isEmpty() && stderr.isEmpty()
    }
}

class TestSuiteResult <: ResultContainer<TestCaseResult> {
    TestSuiteResult(
        let suiteId: TestSuiteId
    ) {}

    func merge(other: TestSuiteResult) {
        this.subResults.add(all: other.subResults)
    }

    static func mergeAll(suiteResults: Iterable<TestSuiteResult>): Collection<TestSuiteResult> {
        let resultById = HashMap<TestSuiteId, TestSuiteResult>()
        for (suiteResult in suiteResults) {
            let id = suiteResult.suiteId
            if (resultById.contains(id)) {
                resultById[id].merge(suiteResult)
            } else {
                resultById[id] = suiteResult
            }
        }
        resultById.values()
    }
}

enum GroupResultPart <: Result {
    | SuiteResult(TestSuiteResult)
    | ProcessError(TestProcessError)

    public func walk(visitor: (Result) -> Unit): Unit {
        match (this) {
            case SuiteResult(suiteResult) => 
                suiteResult.walk(visitor)
            case ProcessError(processError) =>
                processError.walk(visitor)
        }
    }

    public func visitAll<V>(visitor: (V) -> Unit): Unit where V <: Result {
        walk { grp =>
            visitor(grp as V ?? return)
        }
    }

    public prop details: Details {
        get() {
            match (this) {
                case SuiteResult(suiteResult) => 
                    suiteResult.details
                case ProcessError(processError) => 
                    processError.details
            }
        }
    }
}

class TestProcessError <: Result & Hashable {
    let _details = Details()

    TestProcessError(let code: Int64) {
        _details.add(Details(ERROR, true))
    }

    public func hashCode(): Int64 {
        var hasher = DefaultHasher()
        hasher.write(code)
        return hasher.finish()
    }

    public prop details: Details {
        get() {
            _details
        }
    }
}

class TestGroupResult <: ResultContainer<GroupResultPart> {
    TestGroupResult(
        let groupName: String,
        let nonTestOutputs: Array<NonTestOutputs>
    ) {}

    static func fromPackageSuites(packageName: String, suiteResults: Collection<TestSuiteResult>,
        processErrors: Array<TestProcessError>, nonTestOutputs: Array<NonTestOutputs>): TestGroupResult {
        let result = TestGroupResult(packageName, nonTestOutputs)
        for (suiteResult in suiteResults) {
            result.add(suiteResult)
        }
        for (err in processErrors) {
            result.add(err)
        }
        result.finish()
        result
    }

    prop hasProcessError: Bool {
        get() {
            for (value in this.subResults) {
                match (value) {
                    case ProcessError(_) => return true
                    case _ => continue
                }
            }

            return false
        }
    }

    func add(testSuite: Result): Unit {
        match (testSuite) {
            case suiteResultPart: TestSuiteResult => 
                let resultPart = GroupResultPart.SuiteResult(suiteResultPart)
                this.add(resultPart)
            case processErrorPart: TestProcessError => 
                let resultPart = GroupResultPart.ProcessError(processErrorPart)
                this.add(resultPart)
            case _ => throw Exception(
                "Internal error: expected TestSuiteResult or TestProcessError but got another type")
        }
    }
}

enum LStep <: ToString {
    | BeforeEach
    | BeforeAll
    | AfterAll
    | AfterEach

    operator func ==(other: LStep): Bool {
        match ((this, other)) {
            case (BeforeEach, BeforeEach) => true
            case (BeforeAll, BeforeAll) => true
            case (AfterAll, AfterAll) => true
            case (AfterEach, AfterEach) => true
            case _ => false
        }
    }

    public func toString() {
        match (this) {
            case BeforeEach => "BeforeEach"
            case BeforeAll => "BeforeAll"
            case AfterEach => "AfterEach"
            case AfterAll => "AfterAll"
        }
    }
}

enum StepKind {
    | Skip | NoRun
    | Lifecycle(LStep)
    | CaseStep(ArgumentDescription)
    | UserCode

    func isClassLifecycle(): Bool {
        match (this) {
            case Lifecycle(BeforeAll) | Lifecycle(AfterAll) => true
            case _ => false
        }
    }
}

struct ArgumentDescription {
    ArgumentDescription(
        let textDescription: ?PrettyText,
        let stepIndex: Int64,
        let reductionIndex: Int64,
        let randomSeed: ?Int64
    ) {}

    func intoErrorMessage(): ?PrettyText {
        let argsText = this.textDescription ?? return None
        let messageBuilder = PrettyText("After ${this.stepIndex + 1} generation steps")
        if (this.reductionIndex != 0) {
            messageBuilder.appendLine(" and ${this.reductionIndex} reduction steps:")
        } else {
            messageBuilder.appendLine(":")
        }

        messageBuilder.indent {
            messageBuilder.append(argsText)
        }

        match (this.randomSeed) {
            case Some(seed) => messageBuilder.appendLine("with randomSeed = ${seed}")
            case _ => ()
        }

        messageBuilder
    }
}

enum StepInfo {
    | Test( /*aggregatedSteps:*/ Int64)
    | Bench(BenchmarkResult)
    | Failure(Array<CheckResult>)
}

// render options are an extract from configuration that affects result report
// we cannot serialize the whole configuration
// but all render options must be serializable (report itself can be in the other process)
struct RenderOptions {
    RenderOptions(
        let baselineString: ?String,
        let measurementInfo: ?MeasurementInfo
    ) {}

    static func fromConfiguration(configuration: Configuration) {
        RenderOptions(
            configuration.get(KeyBaseline.baseline),
            configuration.get(KeyMeasurementInfo.measurementInfo)
        )
    }
}
