/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest

import std.sync.ReentrantMutex
import std.time.DateTime
import std.collection.ArrayList
import std.collection.concurrent.ConcurrentLinkedQueue

enum LaunchApi {
    | FromPublicApi // dynamic tests
    | FromCli
}

enum LaunchSource {
    | TestBinary
    | TestRunner

    static func fromDefaultConfiguration(): LaunchSource {
        if (defaultConfiguration().launchedWithTestRunner) {
            TestRunner
        } else {
            TestBinary
        }
    }
}

// provides entry point to test execution
// macros like @Assert/@Fail submit results via context statically held by this
class Framework {
    private var transport: ?Transport = None
    private var progressQueue: ?ConcurrentLinkedQueue<UTProgress> = None
    private let mtx: ReentrantMutex = ReentrantMutex()

    // "global utils" like @Assert/@Expect/@Fail will be reported here
    private var currentlyRunning: RunContext = OutsideOfFrameworkContext()
    private static let instance = Framework()
    private static let internalContext = FrameworkInternalsContext()

    private init() {}

    // must be called at every entry point to initialize global state
    // parallel calls to this will lead to unclear exceptions, need to add diagnostics to prohibit this scenario
    static func launch<T>(api!: LaunchApi, hasWorkersInSetup!: Bool,
        progressQueue!: ?ConcurrentLinkedQueue<UTProgress> = None, body!: () -> T): T {
        instance.transport = if (hasWorkersInSetup) {
            Transport.fromDefaultConfiguration()
        } else {
            None
        }
        match (api) {
            case FromCli => instance.progressQueue = progressQueue
            case _ => ()
        }
        instance.currentlyRunning = internalContext
        try {
            body()
        } finally {
            instance.currentlyRunning = OutsideOfFrameworkContext()
            instance.transport?.close()
            instance.progressQueue = None
        }
    }

    static func isExecuting(): Bool {
        !(instance.currentlyRunning is OutsideOfFrameworkContext)
    }

    private func enterContext(newContext: RunContext): Unit {
        synchronized(mtx) {
            currentlyRunning = newContext
        }
    }

    private func leaveContext(leavingContext: RunContext) {
        synchronized(mtx) {
            if (!refEq(currentlyRunning, leavingContext)) {
                throw AssertException("Invalid context structure")
            }
            currentlyRunning = internalContext
        }
    }

    static func runStepBody(stepKind: StepKind, info: StepInfo, body: () -> Unit): RunStepResult {
        let context = RunStepContext(stepKind, info)
        instance.enterContext(context)
        try {
            body()
        } catch (e: Exception) {
            context.onException(e)
        } catch (e: Error) {
            context.onException(ErrorWrapperException(e))
        } finally {
            instance.leaveContext(context)
        }

        context.finishStep()
    }

    static func runCatching(f: () -> Unit) {
        try {
            f()
        } catch (e: Exception) {
            withCurrentContext{ ctx => ctx.onException(e) }
        } catch (e: Error) {
            withCurrentContext{ ctx => ctx.onException(ErrorWrapperException(e)) }
        }
    }

    static func withCurrentContext<T>(f: (RunContext) -> T): T {
        synchronized(instance.mtx) {
            f(instance.currentlyRunning)
        }
    }

    // returns None if no step currently running
    static func abortCurrentStep(): ?RunStepResult {
        withCurrentContext { ctx =>
            let stepCtx = ctx as RunStepContext ?? return None

            // attach unattached failures to current step
            stepCtx.checkResults.add(all: internalContext.checkResults)
            internalContext.checkResults.clear()
            let result = stepCtx.finishStep()
            instance.leaveContext(ctx)
            result
        }
    }

    static func collectUnattachedFailures(): ArrayList<CheckResult> {
        withCurrentContext { _ =>
            let buf = ArrayList<CheckResult>()

            for (cr in internalContext.checkResults) {
                if (cr is TimeoutCheckResult) {
                    buf.add(cr)
                } else {
                    buf.add(UnattachedCheckResult(cr))
                }
            }

            internalContext.checkResults.clear()
            buf
        }
    }

    static func onTestCasesRegistered(packageName: String, casesCount: UInt64): Unit {
        let workerId = match (TestProcessKind.fromDefaultConfiguration()) {
            case Worker(_, _, nCasesSkip, _) where nCasesSkip > 0 => return // Do not call test cases registration repetetive
            case Worker(workerId, _, _, _) => workerId
            case _ => 0
        }

        let message = TestCasesRegistrationPart(casesCount, workerId: workerId, packageName: packageName)
        instance.progressQueue?.add(TestProgressData(message, workerId: workerId))

        let channel = match (instance.transport) {
            case Some(transport) => transport.channel ?? return;
            case None => return;
        }

        channel.send(message)

        // Delimit output of static initialization and test execution.
        instance.transport?.channel?.delimitOutput()

        match (channel.receive(limit: 1).next()) {
            case Some(ExecutionPermitPart) => ()
            case _ => throw Exception("Expected execution permission from the Main process")
        }
    }

    static func onLifecycleStart(suiteId: TestSuiteId, step: LStep): Unit {
        let header = LifecycleExecutionResultHeader(suiteId, step, DateTime.now())
        instance.progressQueue?.add(TestProgressData(header))
        instance.transport?.channel?.send(header)
    }

    static func onTestCaseStarted(caseId: TestCaseId): Unit {
        let header = TestCaseExecutionResultHeader(caseId, DateTime.now())
        instance.progressQueue?.add(TestProgressData(header))
        instance.transport?.channel?.send(header)
    }

    static func onFinished(result: TestCaseResult): Unit {
        let body = ExecutionResultBody(result)
        instance.progressQueue?.add(TestProgressData(body))
        instance.transport?.channel?.send(body)
        instance.transport?.channel?.delimitOutput()
    }

    static func initWorker(ctx: MainExecutionCtx, workerId!: Int64): WorkerProcess {
        let manager = instance.transport.getOrThrow().manager.getOrThrow()
        let port = manager.port
        let overriddenCtx = ctx.withCommand(
            ctx.executeCommand.withArgs("--${KeyInternalMainProcessPort().name}=${port}"))
        withCurrentContext {
            _ => WorkerProcess.create(overriddenCtx, workerId, instance.progressQueue) {
                manager.accept()
            }
        }
    }
}

class OutsideOfFrameworkContext <: RunContext {
    protected func storeCheckResult(_: CheckResult) {
        // behaviour for @Assert/@Expect outside of test cases can be defined here
    }
}

// Used to collect all checks that were executed outside of case body
class FrameworkInternalsContext <: RunContext {}

abstract class RunContext {
    let checkResults = ArrayList<CheckResult>()
    private var suppressed = false
    var passedChecks: Int64 = 0

    protected open func checkFailed(c: CheckResult): Unit {
        storeCheckResult(c)
    }

    protected open func onException(e: Exception): Unit {
        storeCheckResult(e.asCheckResult() ?? return)
    }

    protected open func storeCheckResult(check: CheckResult): Unit {
        if (suppressed) { return }
        checkResults.add(check)
    }

    func checkPassed(): Unit {
        passedChecks++
    }

    func suppressIfHasFailures() {
        if (!checkResults.isEmpty()) {
            suppressed = true
        }
    }

    func hasFailures(): Bool {
        !checkResults.isEmpty()
    }
}

class RunStepContext <: RunContext {
    var startTime: DateTime = DateTime.now()

    RunStepContext(
        var stepKind: StepKind,
        var stepInfo: StepInfo
    ) {}

    protected func checkFailed(c: CheckResult) {
        storeCheckResult(c)
        if (let Bench(_) <- stepInfo) {
            throw BenchmarkStoppedError()
        }
    }

    func finishStep(): RunStepResult {
        let info = if (checkResults.isEmpty()) {
            stepInfo
        } else {
            Failure(checkResults.toArray())
        }
        RunStepResult(passedChecks, startTime, stepKind, info)
    }
}

class BenchmarkStoppedError <: Exception {
    BenchmarkStoppedError() {
        super("Any failure in benchmark stops it.")
    }
}
