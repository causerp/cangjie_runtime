/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest

import std.unittest.common.*
import std.unittest.mock.*
import std.collection.ArrayList
import std.random.Random

func runTestStep(
    caseId: TestCaseId, f: () -> Unit
): Unit {
    Framework.runCatching {
        MockFramework.openSession("test case ${caseId.caseName}", Verifiable)
        f()
    }

    // there is no point in additionally showing mock verification errors here
    // because they most likely will be just a consequence of existing errors
    Framework.withCurrentContext { ctx => ctx.suppressIfHasFailures() }
    MockFramework.closeSession()
}

/**
 * None of these configuration parameters are intended as public API for now.
 */
extend Configuration {
    // enable the coverage-guided algorithm
    prop coverageGuided: Bool {
        get(){ get(KeyCoverageGuided.coverageGuided) ?? false }
    }
    // number of initial seeds generated without coverage information
    prop coverageGuidedInitialSeeds: Int64 {
        get(){ get(KeyCoverageGuidedInitialSeeds.coverageGuidedInitialSeeds) ?? 20 }
    }
    // maximum number of candidates in queue
    prop coverageGuidedMaxCandidates: Int64 {
        get(){ get(KeyCoverageGuidedMaxCandidates.coverageGuidedMaxCandidates) ?? 200 }
    }
    // score given to any new trace in queue
    prop coverageGuidedBaselineScore: Int64 {
        get(){ get(KeyCoverageGuidedBaselineScore.coverageGuidedBaselineScore) ?? 2000 }
    }
    // score given to any "good" new trace in queue
    prop coverageGuidedNewCoverageScore: Int64 {
        get(){ get(KeyCoverageGuidedNewCoverageScore.coverageGuidedNewCoverageScore) ?? 4000 }
    }
    // bonus to score given to traces that spawn new coverage through mutation
    prop coverageGuidedNewCoverageBonus: Int64 {
        get(){ get(KeyCoverageGuidedNewCoverageBonus.coverageGuidedNewCoverageBonus) ?? 500 }
    }
}

interface Executor {
    func execute(caseId: TestCaseResult, configuration: Configuration): Unit
}

class TestCaseExecutor<T> <: Executor {
    var generationStep = 0
    var randomSeed = None<Int64>
    var hasMoreParameters: Bool = true

    TestCaseExecutor(
        private let strategy: DataStrategyProcessor<T>,
        private let body: (T) -> Unit
    ) {}

    /*
     * start new strategy iteration or stop
     * @returns false to stop, true to continue
     */
    private func nextIterationOrBreak(
        currentResult: TestCaseResult,
        configuration: Configuration
    ): Bool {
        if (currentResult.hasFailures() || !hasMoreParameters) {
            return false
        }

        let exceptionHandler = { e: Exception =>
            currentResult.add(strategyErrorAsResult(e, argDescription([])))
            false
        }

        try {
            strategy.nextIteration(configuration)
            hasMoreParameters = strategy.isInfinite
        } catch (e: Exception) {
            return exceptionHandler(e)
        } catch (e: Error) {
            return exceptionHandler(ErrorWrapperException(e))
        }

        return true
    }

    private func putToQue(que: ArrayList<(CovRandomSource, Int64)>,
        varg: Array<(element: CovRandomSource, score: Int64)>) {
        que.add(all: varg)
        que.sortBy { l, r => l[1].compare(r[1]) }
    }

    private func popFromQue(que: ArrayList<(CovRandomSource, Int64)>): (CovRandomSource, Int64) {
        let last = que.remove(at: que.size - 1) // last element is the maximum
        last
    }

    private func coverageGuidedLoop(
        tcase: TestCaseResult,
        progress: ProgressOutput,
        localConfiguration: Configuration,
        random: Random,
        que: ArrayList<(CovRandomSource, Int64)>,
        actualBody: (T) -> Unit
    ): Unit {
        var cnt = 0
        progress.verbose("cnt = *, candidates = ${que.size}, cov est = ${currentCoverageEst()}\r")
        let maxQueSize = localConfiguration.coverageGuidedMaxCandidates
        while (que.size != 0) {
            if (que.size > maxQueSize) {
                let cull = que.size - maxQueSize
                progress.verboseLine("Too many candidates in queue, removing lower ${cull} (max is ${maxQueSize})")
                que.remove(0..cull)
            }
            let (cur, score) = popFromQue(que)
            let temp = random.nextUInt8(126) + 2
            let newS = cur.copy(temperature: temp, seed: random.nextUInt64())
            localConfiguration.random = newS
            executeFiniteSubstrategy(tcase, localConfiguration, actualBody)
            if (!nextIterationOrBreak(tcase, localConfiguration)) {
                break
            }

            if (CoverageInfo.newCoverageDiscovered()) {
                progress.verboseLine("new coverage on seed = ${newS.seed}, iter = ${cnt}, temp = ${temp}")
                putToQue(
                    que,
                    (newS.freeze(), localConfiguration.coverageGuidedNewCoverageScore),
                    (cur, score + localConfiguration.coverageGuidedNewCoverageBonus)
                )
            } else {
                putToQue(que, (cur, score - 1))
            }
            if (cnt % 500 == 0) {
                progress.verbose("cnt = ${cnt}, candidates = ${que.size}, cov est = ${currentCoverageEst()}\r")
            }
            cnt++
        }
        progress.verboseLine("")
    }

    private func executeGuided(result: TestCaseResult, configuration: Configuration): Unit {
        let progress = ProgressOutput(configuration)
        unsafe { CJ_MICROFUZZ_RESET_ALL_COVERAGE_INFO() }
        progress.verboseLine("Starting guided execution....")
        let generationSteps = configuration.generationSteps
        let localConfiguration = configuration.clone()

        let random = match (localConfiguration.random) {
            case Some(randomSource: Random) =>
                randomSource
            case _ => Random()
        }

        let initialSeeds = Array(configuration.coverageGuidedInitialSeeds) { _: Int64 => random.nextUInt64() }

        let mutator = Mutator(random: random)

        func actualBody(v: T) {
            unsafe { CJ_MICROFUZZ_RESET_LOCAL_COVERAGE_INFO() }
            unsafe { CJ_MICROFUZZ_ENABLE_TRACE() }
            body(v)
            unsafe { CJ_MICROFUZZ_DISABLE_TRACE() }
        }

        // This should be a priority queue, but we don't have a priority queue implementation
        // so instead we sort an ArrayList after adding each element
        // This is not an algorithmic complexity problem, because the que is typically < 100 elements
        let que = ArrayList<(CovRandomSource, Int64)>()

        progress.verboseLine("Seeding initial generation")
        for (seed in initialSeeds) {
            let ss = CovRandomSource(seed: seed, mutator: mutator)
            localConfiguration.random = ss
            executeFiniteSubstrategy(result, localConfiguration, actualBody)
            if (!nextIterationOrBreak(result, localConfiguration)) {
                return
            }
            if (CoverageInfo.newCoverageDiscovered()) {
                que.add((ss.freeze(), localConfiguration.coverageGuidedNewCoverageScore))
                progress.verboseLine("new coverage on seed = ${seed}")
            } else {
                que.add((ss.freeze(), localConfiguration.coverageGuidedBaselineScore))
            }
        }
        que.sortBy { l, r => l[1].compare(r[1]) }

        coverageGuidedLoop(result, progress, localConfiguration, random, que, actualBody)
    }

    private func argDescription(param: Array<InputParameter>) {
        ArgumentDescription(formatArguments(param), generationStep - 1, strategy.currentReduction, randomSeed)
    }

    private func executeFiniteSubstrategy(
        result: TestCaseResult,
        configuration: Configuration,
        actualBody: (T) -> Unit
    ): Unit {
        let lastInput = Box(Array<InputParameter>())
        let executeBody = { arg: T, input: Array<InputParameter> =>
            let step = CaseStep(argDescription(input))
            lastInput.value = input
            Framework.runStepBody(step, Test(1)) {
                runTestStep(result.caseId) {
                    actualBody(arg)
                }
            }
        }

        while (generationStep < configuration.generationSteps || !strategy.isInfinite) {
            generationStep += 1
            let processorResult = strategy.processNextWith(configuration, executeBody)

            var initialFailure = match (processorResult) {
                case Success(stepResult) =>
                    result.addSuccessfullStep(stepResult)
                    continue
                case NoItems =>
                    generationStep -= 1
                    return
                case StrategyError(e) =>
                    result.add(strategyErrorAsResult(e, argDescription(lastInput.value)))
                    return
                case Failure(input, stepResult) =>
                    (input, stepResult)
            }

            let (input, failure) = match (strategy.shrink(configuration, executeBody)) {
                case None => initialFailure
                case Some(Failure(input, shrunk)) => (input, shrunk)
                case Some(StrategyError(e)) =>
                    result.add(strategyErrorAsResult(e, argDescription(lastInput.value)))
                    return
                case _ =>
                    throw Exception("Unexpected shrinking result")
            }

            // It was decided that we should print full number of reduction steps
            // instead of reduction step number on which we found latest shrinked failure
            result.add(failure.withUpdatedStep(CaseStep(argDescription(lastInput.value))))

            if (strategy.isInfinite) {
                break
            }
        }

        hasMoreParameters = false
    }

    public func execute(tcase: TestCaseResult, configuration: Configuration): Unit {
        generationStep = 0
        // assume that we have data in the beginning
        hasMoreParameters = true
        randomSeed = configuration.get(KeyRandomSeed.randomSeed)

        if (!nextIterationOrBreak(tcase, configuration)) {
            return
        }

        if (configuration.coverageGuided && hasMoreParameters) {
            executeGuided(tcase, configuration)
        } else {
            do {
                executeFiniteSubstrategy(tcase, configuration, body)
            } while (nextIterationOrBreak(tcase, configuration))
        }

        // notify user that there were no steps executed
        if (generationStep == 0) {
            tcase.add(RunStepResult.simpleError(Skip, NoParametersProvidedResult()))
        }
    }

    static func formatArguments(inputs: Array<InputParameter>): ?PrettyText {
        if (inputs.isNoArg()) {
            return None
        }
        let sb = PrettyText()
        for (param in inputs) {
            sb.append(param.name)
            sb.append(" = ")
            sb.appendLine(shieldEscapeSeq(param.repr))
        }
        return sb
    }
}

extend RunStepResult {
    func withUpdatedStep(newKind: StepKind): RunStepResult {
        RunStepResult(checksPassed, startTimestamp, newKind, info, duration: duration)
    }
}

extend Exception {
    func asCheckResult(): ?CheckResult {
        match (this) {
            // relying that mock framework exception are the only ones that are pretty printable
            case mockException: PrettyException => MockFrameworkCheckResult(PrettyText.of(mockException))
            case e: AssertIntermediateException =>
                PowerAssertExceptionCheckResult(e.expression, e.getOriginalStackTrace(), e.diagram)
            case e: AssertException =>
                match (e.cause) {
                    // should have been already reported when thrown originally
                    case Some(_) => None
                    case None => ExceptionThrownCheckResult(
                        PrettyText(e.toString()), renderException(e, None)
                    )
                }
            // should have been already reported when thrown originally
            case _: BenchmarkStoppedError => None
            case anyOther: Exception => ExceptionThrownCheckResult(
                PrettyText(anyOther.toString()), renderException(anyOther, None)
            )
        }
    }
}

func strategyErrorAsResult(e: Exception, descr: ArgumentDescription): RunStepResult {
    let existingChecks = Framework.collectUnattachedFailures()
    let errorCheckResults = e.asCheckResult() ??
        // this part can only happen if we caught exception caused by
        // @Fail / @Assert etc inside the strategy processor itself
        existingChecks.get(0) ??
        // this should never happen
        ExceptionThrownCheckResult(
        PrettyText("Unhandled exception inside strategy: ${e.toString()}"),
        renderException(e, None)
    )
    // losing information about duration here
    let kind = CaseStep(descr)
    RunStepResult.simpleError(kind, errorCheckResults)
}
