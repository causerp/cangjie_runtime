/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest

import std.unittest.common.PrettyText
import std.collection.*
import std.math.abs
import std.runtime.ProcessorInfo
import std.random.Random

type BenchRawMeasurement = (Float64, Float64)

class BenchExecutor<T> <: Executor {
    var step = 0
    BenchExecutor(
        private let strategy: DataStrategyProcessor<T>,
        private let doRun: (T, Int64, Int64) -> Float64
    ) {
    }

    public func execute(tcase: TestCaseResult, configuration: Configuration): Unit {
        let progress = ProgressOutput(configuration)
        let benchRunner = BenchRunner(configuration, progress)
        strategy.nextIteration(configuration)

        while (true) {
            let result = strategy.processNextWith(configuration) { v, inputs =>
                runSingle(v, inputs, tcase.caseId, benchRunner, progress, step)
            }

            match (result) {
                case Success(result) =>
                    step += 1
                    tcase.add(result)
                case Failure(input, failure) =>
                    tcase.add(failure)
                    break
                case NoItems => break
                case StrategyError(e) =>
                    tcase.add(strategyErrorAsResult(e, ArgumentDescription(None, step, 0, None)))
            }
        }
    }

    func runSingle(
        value: T, inputs: Array<InputParameter>, caseId: TestCaseId,
        benchRunner: BenchRunner, progress: ProgressOutput, step: Int64
    ): RunStepResult {
        let args = formatArgs(inputs)
        progress.println {
            "Starting the benchmark `${caseId.suiteId.suiteName}.${caseId.caseName}(${args?.toString() ?? ""})`."
        }

        benchRunner.benchmark = SimpleBenchWrapper<T>(value, doRun)

        benchRunner.measurements = ArrayList()
        let stepKind = CaseStep(ArgumentDescription(args, step, 0, None))
        Framework.runStepBody(stepKind, StepInfo.Bench(BenchmarkResult(benchRunner.measurements))) {
            benchRunner.runBench()
            progress.println {""}
        }
    }

    private func formatArgs(inputs: Array<InputParameter>): ?PrettyText {
        if (inputs.isNoArg()) {
            return None
        }
        let sb = StringBuilder()
        for (i in 0..inputs.size) {
            // skip empty unit strategy
            if (inputs[i].name.isEmpty()) {
                continue
            }

            if (inputs[i].repr.size < 15) {
                sb.append(inputs[i].repr)
            } else {
                sb.append("${inputs[i].name}[${inputs[i].position}]")
            }
            if (i < inputs.size - 1) {
                sb.append(',')
            }
        }
        match (sb.toString()) {
            case "" => None
            case argString => PrettyText(argString)
        }
    }
}

struct StatisticsSample {
    let _kde: ArrayList<(Float64, Float64)> = ArrayList<(Float64, Float64)>()
    StatisticsSample(let sample: Sample) {}

    init() {
        this(Sample(ArrayList()))
    }

    func append(data: Float64) {
        sample.data.add(data)
    }

    func finish() {
        sample.data.removeIf { x => x.isNaN() }
        sample.data.sort()
    }

    prop mean: Float64 { get() {
        sample.mean()
    }}

    prop median: Float64 { get() {
        sample.percentile(0.5)
    }}

    prop lowerBound: Float64 { get() {
        sample.percentile(0.01)
    }}

    prop upperBound: Float64 { get() {
        sample.percentile(0.99)
    }}

    private func update() {
        if (_kde.isEmpty()) {
            _kde.add(all: sample.kde(0.4))
        }
    }

    prop kde: ArrayList<(Float64, Float64)> { get() {
        update()
        _kde
    }}

    prop mode: Float64 { get () {
        kde.iterator().maxBy{ a => a[1] }[0]
    }}

    // second mode to detect multimodality
    func mode2(): Float64 {
        let (modeIdx, (mode, modeDensity)) = kde.iterator().enumerate().maxBy{ a => a[1][1] }

        let kdeCopy = _kde.clone()

        // remove points related to main mode
        for (direction in [1, -1]) {
            var i = modeIdx + direction
            var localMin = modeDensity
            while (i < kdeCopy.size && i >= 0) {
                let (val, density) = kdeCopy[i]
                if (density < localMin) {
                    localMin = density
                }
                if (density > localMin * 2.0) {
                    break
                }

                kdeCopy[i] = (val, 0.0)
                i += direction
            }
        }
        kdeCopy[modeIdx] = (mode, 0.0)

        // find mode of remaining distribution
        let (mode2, density2) = kdeCopy.iterator().maxBy{ a => a[1] }

        // if the second mode is big enough
        if (density2 / modeDensity > 0.15) {
            mode2
        } else {
            Float64.NaN
        }
    }
}

let BOOTSTRAP_ITERATIONS: Int64 = 2000

class BenchmarkResult {
    var finished = false

    var bootstrapped: BootstrapResult = BootstrapResult()

    prop median: Float64 { get() {
        bootstrapped.medianStats.sample.percentile(0.5)
    }}
    // median confidence interval radius
    prop medianCI99: Float64 { get() {
        (bootstrapped.medianStats.sample.percentile(0.99) - bootstrapped.medianStats.sample.percentile(0.01)) / 2.0
    }}
    prop medianOverhead: Float64 { get() {
        bootstrapped.medianOverheadStats.sample.percentile(0.5)
    }}

    prop mean: Float64 { get() {
        bootstrapped.meanStats.sample.mean()
    }}
    prop meanCI99: Float64 { get() {
        (bootstrapped.meanStats.sample.percentile(0.99) - bootstrapped.meanStats.sample.percentile(0.01)) / 2.0
    }}
    prop meanLower: Float64 { get() { mean-meanCI99 } }
    prop meanUpper: Float64 { get() { mean+meanCI99 } }
    prop meanOverhead: Float64 { get() {
        bootstrapped.meanOverheadStats.sample.percentile(0.5)
    }}

    prop mainResult: Float64 {
        get() {
            // to get more stable output when result is basically zero
            if (median < 0.001) { 0.0 } else { median }
        }
    }
    prop errorEst: Float64 { get () {
        if (meanCI99 < 0.001) { 0.0 } else { meanCI99 }
    }}

    BenchmarkResult(var data: ArrayList<BenchRawMeasurement>) {}

    func calculate() {
        if (finished) { return }

        bootstrap()

        finished = true
    }

    private func bootstrap() {
        let workers = min(ProcessorInfo.processorCount, 8)
        bootstrapped = (0..workers) |>
            map { _ => ArrayList<BenchRawMeasurement>(data.size) } |>
            mapParallelOrdered(workers) { subsample =>
                let results = BootstrapResult()
                let random = Random()
                for (_ in 0..BOOTSTRAP_ITERATIONS / workers) {
                    subsample.clear()
                    for (_ in 0..data.size) {
                        subsample.add(data[random.nextInt64(data.size)])
                    }
                    results.appendStatisticsFromSample(subsample)
                }
                results
            } |>
            fold(BootstrapResult()) { a, b => a.join(b) }

        bootstrapped.finish()
    }

    // bootstrap actual values distribution accounting for batch size and overhead
    func valuesSample(): StatisticsSample {
        let bootstrapped = ArrayList<Float64>()
        let medianOverhead = this.bootstrapped.medianOverheadStats.sample.data
        let random = Random()
        for (_ in 0..1000) {
            let overhead = max(medianOverhead[random.nextInt64(medianOverhead.size)], 0.0)
            let batch = data[random.nextInt64(data.size)]
            if (batch[1] <= overhead) {
                continue
            }
            let value = (batch[1] - overhead) / batch[0]
            if (value.isNormal()) {
                bootstrapped.add(value)
            }
        }

        StatisticsSample(Sample(bootstrapped))
    }
}

extend<T> Iterator<T> {
    func minBy<K>(f: (T) -> K): T where K <: Comparable<K> {
        var current = this.next().getOrThrow()
        var key = f(current)
        for (e in this) {
            let new_key = f(e)
            if (new_key < key) {
                key = new_key
                current = e
            }
        }

        current
    }

    func maxBy<K>(f: (T) -> K): T where K <: Comparable<K> {
        var current = this.next().getOrThrow()
        var key = f(current)
        for (e in this) {
            let new_key = f(e)
            if (new_key > key) {
                key = new_key
                current = e
            }
        }

        current
    }
}

struct BootstrapResult {
    let meanStats = StatisticsSample()
    let meanOverheadStats = StatisticsSample()
    let medianStats = StatisticsSample()
    let medianOverheadStats = StatisticsSample()
    let r2Stats = StatisticsSample()
    let buffer = ArrayList<Float64>()

    func join(other: BootstrapResult): BootstrapResult {
        meanStats.sample.data.add(all: other.meanStats.sample.data)
        meanOverheadStats.sample.data.add(all: other.meanOverheadStats.sample.data)
        medianStats.sample.data.add(all: other.medianStats.sample.data)
        medianOverheadStats.sample.data.add(all: other.medianOverheadStats.sample.data)
        r2Stats.sample.data.add(all: other.r2Stats.sample.data)
        this
    }

    func finish() {
        meanStats.finish()
        meanOverheadStats.finish()
        medianStats.finish()
        medianOverheadStats.finish()
        r2Stats.finish()
    }

    func appendStatisticsFromSample(subsample: ArrayList<BenchRawMeasurement>) {
        let (median, overheadMedian) = medianRegression(subsample)
        if (!median.isNaN()) {
            this.medianStats.append(median)
            this.medianOverheadStats.append(overheadMedian)
        }

        let (mean, meanOverhead, r2) = olsRegression(subsample)
        if (!mean.isNaN()) {
            this.meanStats.append(mean)
            this.meanOverheadStats.append(meanOverhead)
            this.r2Stats.append(r2)
        }
    }

    private func olsRegression(subsample: ArrayList<BenchRawMeasurement>): (Float64, Float64, Float64) {
        let result = Measurements(subsample.toArray()).calculateMean()
        (result.mainSlope, result.intercept, result.r2)
    }

    private func medianRegression(subsample: ArrayList<BenchRawMeasurement>): (Float64, Float64) {
        let slopes = buffer
        slopes.clear()
        let (x1, y1) = subsample[0]
        for ((x2, y2) in subsample) {
            if (abs(x1 - x2) > 0.0001) {
                let slope = (y1 - y2) / (x1 - x2)
                let yat0 = abs(y2 - x2 * slope) - 0.001
                if (yat0 > y2 || yat0 > y1) {
                    // do not include nonsensical values
                    continue
                }
                slopes.add(slope)
            }
        }
        let sample = Sample(slopes)
        let slope = sample.percentile(0.5)
        (slope, y1 - x1 * slope)
    }
}
