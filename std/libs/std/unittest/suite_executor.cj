/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest

import std.unittest.common.PrettyText
import std.unittest.mock.*
import std.collection.*
import std.collection.concurrent.LinkedBlockingQueue
import std.time.DateTime
import std.env.exit

class TestSuiteExecutor {
    private let suiteConfiguration: Configuration

    TestSuiteExecutor(
        private let externalConfiguration: Configuration,
        private let suiteId: TestSuiteId,
        private let testSuite: TestSuite,
        private let filterService: FilterService
    ) {
        this.suiteConfiguration = Configuration.merge(externalConfiguration, testSuite.wholeConfiguration)
    }

    func execute(): TestSuiteResult {
        let result = TestSuiteResult(suiteId)

        let testCases = testSuite.allCasesToBeExecuted(filterService, suiteId)

        if (shallNotRunLifecycle(testCases)) {
            for (testCase in testCases) {
                result.add(tryRun(testCase))
            }
            result.finish()
            return result
        }

        MockFramework.openSession("initializer of class ${testSuite.name}", Stateless)

        let beforeAllResult = runNonTestBodyStep(suiteId, BeforeAll) {
            testSuite.runBeforeAll()
        }
        result.add(beforeAllResult)

        if (!beforeAllResult.hasFailures()) {
            for (testCase in testCases) {
                result.add(tryRun(testCase))
            }
        }

        let afterAllResult = runNonTestBodyStep(suiteId, AfterAll) {
            testSuite.runAfterAll()
            // collect hanging failures in this step so that they are not lost
            Framework.withCurrentContext { ctx =>
                for (unattached in Framework.collectUnattachedFailures()) {
                    ctx.storeCheckResult(unattached)
                }
            }
        }

        if (!beforeAllResult.hasFailures()) {
            result.add(afterAllResult)
        }

        // making sure mock session close, but only reporting errors
        // if there are no other error during teardown step
        try {
            MockFramework.closeSession()
        } catch (e: Exception) {
            // Note: for now we assumes that it should not throw exceptions
        }
        result.finish()
        result
    }

    private func shallNotRunLifecycle(testCases: Collection<CaseOrBench>): Bool {
        suiteConfiguration.skip || externalConfiguration.noRun || testCases.isEmpty() || allSkipped(testCases)
    }

    private func allSkipped(testCases: Collection<CaseOrBench>): Bool {
        testCases |> all<CaseOrBench> { it => it.caseConfiguration.skip }
    }

    private func tryRun(testOrBench: CaseOrBench): TestCaseResult {
        let caseId = TestCaseId(suiteId, testOrBench.name, isBench: testOrBench.isBench)
        let caseConfiguration = Configuration.merge(suiteConfiguration, testOrBench.caseConfiguration)
        let caseKey = CaseFilterKey(caseId, tags: caseConfiguration.tags, isTopLevel: caseConfiguration.fromTopLevel)
        let shouldSkip = suiteConfiguration.skip || caseConfiguration.skip ||
            filterService.userFilter.shouldSkipTestCase(caseKey)

        caseConfiguration.initRandom()
        let caseRunner: (TestCaseResult) -> Unit = if (shouldSkip) {
            runSkip
        } else if (externalConfiguration.noRun) {
            runNoRun
        } else {
            var testBody = runSingleCase(caseConfiguration, testOrBench.executor)
            if (let Some(duration) <- caseConfiguration.timeout) {
                // test body decorator if any time constraints are specified
                testBody = runConsideringTimeout(duration, testBody)
            }
            testBody
        }

        runTestCaseStep(caseId, caseConfiguration, caseRunner)
    }

    private static func runNonTestBodyStep(suiteId: TestSuiteId, stepKind: LStep, stepBody: () -> Unit): TestCaseResult {
        Framework.onLifecycleStart(suiteId, stepKind)

        let id = TestCaseId(suiteId, stepKind.toString(), isBench: false)
        let step = runLifecycleStep(stepKind, stepBody)
        let result = TestCaseResult.fromSingleStep(id, step)
        result.finish()

        Framework.onFinished(result)
        return result
    }

    private static func runLifecycleStep(step: LStep, stepBody: () -> Unit): RunStepResult {
        Framework.runStepBody(Lifecycle(step), Test(0), stepBody)
    }

    private static func runTestCaseStep(
        caseId: TestCaseId,
        configuration: Configuration,
        caseRunner: (TestCaseResult) -> Unit
    ): TestCaseResult {
        Framework.onTestCaseStarted(caseId)

        let testCaseResult = TestCaseResult(caseId, RenderOptions.fromConfiguration(configuration))
        caseRunner(testCaseResult)
        testCaseResult.finish()
        Framework.onFinished(testCaseResult)
        return testCaseResult
    }

    func runSkip(testCaseResult: TestCaseResult): Unit {
        testCaseResult.add(RunStepResult(0, DateTime.now(), StepKind.Skip, Test(0), duration: Duration.Zero))
    }

    func runNoRun(testCaseResult: TestCaseResult): Unit {
        testCaseResult.add(RunStepResult(0, DateTime.now(), StepKind.NoRun, Test(0), duration: Duration.Zero))
    }

    func runSingleCase(caseConfiguration: Configuration, executor: Executor): (TestCaseResult) -> Unit {
        return { result =>
            let caseId = result.caseId
            let beforeEachResult = runLifecycleStep(BeforeEach) {
                testSuite.runBeforeEach(caseId.caseName)
            }
            result.add(beforeEachResult)

            if (!beforeEachResult.hasFailures()) {
                executor.execute(result, caseConfiguration)
            }

            let afterEachResult = runLifecycleStep(AfterEach) {
                testSuite.runAfterEach(caseId.caseName)
            }
            if (!result.hasFailures() && afterEachResult.hasFailures()) {
                // NOTE: for now these failures are suppressed if there are existing errors
                result.add(afterEachResult)
            }
        }
    }

    private static func runConsideringTimeout(
        duration: Duration,
        testBody: (TestCaseResult) -> Unit
    ): (TestCaseResult) -> Unit {
        return { testCaseResult =>
            let finishedBeforeTimeoutSignalQueue = LinkedBlockingQueue<Unit>(1)
            let killerThread = spawn {
                if (let None <- finishedBeforeTimeoutSignalQueue.remove(duration)) {
                    exitOnTimeout(testCaseResult)
                }
            }
            testBody(testCaseResult)
            finishedBeforeTimeoutSignalQueue.add(())
            killerThread.get()
        }
    }

    private static func exitOnTimeout(testCaseResult: TestCaseResult) {
        Framework.withCurrentContext { ctx => ctx.storeCheckResult(TimeoutCheckResult()) }
        if (let Some(currentResult) <- Framework.abortCurrentStep()) {
            testCaseResult.add(currentResult)
        } else if (let Some(prev) <- testCaseResult.subResults.pop()) {
            let newFailures = prev.checkResults |> concat(Framework.collectUnattachedFailures()) |> collectArray
            let newResult = RunStepResult(prev.checksPassed, prev.startTimestamp, prev.kind, Failure(newFailures),
                duration: prev.duration)
            testCaseResult.add(newResult)
        } else {
            // this case is almost nonsensical, but technically it can happen if there is sleep in the first iteration of @Strategy
            let failures = Framework.collectUnattachedFailures().toArray()
            let newResult = RunStepResult(0, DateTime.now(), UserCode, Failure(failures))
            testCaseResult.add(newResult)
        }

        testCaseResult.finish()
        Framework.onFinished(testCaseResult)
        exit(EXIT_CODE_ON_TIMEOUT)
    }
}

extend TestSuite {
    prop wholeConfiguration: Configuration {
        get() {
            Configuration.merge(this.template?.wholeConfiguration ?? Configuration(), this.suiteConfiguration)
        }
    }

    prop allCasesIterator: Iterable<CaseOrBench> {
        get() {
            // Better run some basic tests from template before.
            chain(template?.allCasesIterator ?? Array<CaseOrBench>().iterator(), cases)
        }
    }

    func allCasesToBeExecuted(filterService: FilterService, suiteId: TestSuiteId): Array<CaseOrBench> {
        allCasesIterator |> filter { cob: CaseOrBench =>
            let caseKey = CaseFilterKey.fromTestCase(suiteId, cob, config: cob.caseConfiguration)
            !filterService.frameworkFilter.shouldSkipTestCase(caseKey)
        } |> collectArray
    }

    func casesCountToBeExecuted(filterService: FilterService, suiteId: TestSuiteId): Int64 {
        allCasesToBeExecuted(filterService, suiteId).size
    }

    func runBeforeEach(caseShortName: String): Unit {
        try {
            MockFramework.openSession("func beforeEach", Forbidden)
            runBeforeEachMocked(caseShortName)
        } finally {
            MockFramework.closeSession()
        }
    }

    private func runBeforeEachMocked(caseShortName: String): Unit {
        // Run template initializers before
        this.template?.runBeforeEachMocked(caseShortName)
        for (c in beforeEachs) {
            c(caseShortName)
        }
    }

    func runAfterEach(caseShortName: String): Unit {
        for (c in afterEachs) {
            c(caseShortName)
        }
        // Run template cleanups after
        this.template?.runAfterEach(caseShortName)
    }

    func runBeforeAll(): Unit {
        // Run template initializers before
        this.template?.runBeforeAll()
        for (c in beforeAlls) {
            c()
        }
    }

    func runAfterAll(): Unit {
        for (c in afterAlls) {
            c()
        }
        // Run template cleanups after
        this.template?.runAfterAll()
    }
}

extend Configuration {
    prop skip: Bool {
        get() {
            this.get(KeySkip.skip) ?? false
        }
    }
}
