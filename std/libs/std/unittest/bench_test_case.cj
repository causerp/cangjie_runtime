/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest

import std.collection.ArrayList
import std.time.DateTime
import std.random.Random
import std.math.*
import std.runtime.GC
import std.convert.Formattable
import std.sort.*

// upper limit on number of saved measurements to keep reasonable statistics calculation time and memory cost
const MEASUREMENTS_LIMIT = 5000
const MAX_BATCH_SIZE = 2 ** 60

private struct EmptyBenchmark <: BenchmarkWrapper {
    public func measureLoopOnce(_: Int64, _: Int64): Float64 { 0.0 }

    public func timeLoopOnce(_: Int64, _: Int64): Float64 { 0.0 }
}

class BenchRunner {
    var benchmark: BenchmarkWrapper = EmptyBenchmark()
    var measurements: ArrayList<BenchRawMeasurement> = ArrayList()
    private let time: TimeNow = TimeNow()
    private var explicitGC: ExplicitGcType = Light
    private var targetDuration: Duration = Duration.second
    private var minBatches: Int64 = 100
    private var batchSize: Range<Int64> = 1..MAX_BATCH_SIZE
    private var overheadPerIteration = 0.0
    private var overheadPerBatch = 0.0
    private var random = Random()
    var isRunning: Bool = false
    private var ema0 = Ema(0)
    private var ema1 = Ema(0)

    public BenchRunner(let configuration: Configuration, let progress: ProgressOutput) {
        if (configuration.get<Measurement>(KeyMeasurement.measurement).isSome()) {
            let warning = "Warning: configuring measurement via @Configure[measurement: <Measurement>] is deprecated and not used any more. " +
                "Use @Measure macro instead."
            println(warning)
        }
    }

    private func warmupFixedSize(warmupCount: Int64): Float64 {
        if (warmupCount < 0) {
            throw IllegalArgumentException("Number of warmup iterations must be non negative")
        }
        if (warmupCount == 0) {
            if (batchSize.end >= MAX_BATCH_SIZE) {
                throw IllegalArgumentException("if 'warmup' parameter is zero then 'batchSize' must be specified")
            }
            progress.println { "    Warmup disabled." }
            let avgBatchSize = Float64(batchSize.end + batchSize.start) / 2.0
            return Float64(targetDuration.toNanoseconds()) / avgBatchSize / Float64(minBatches)
        }
        progress.println { "    Warming up for ${warmupCount} iterations." }

        let batches = max(warmupCount / batchSize.end, 1)
        var ema = Ema(batches / 2)
        for (i in 0..batches) {
            ema.append(runMultipleAndEstimateTime(warmupCount / batches))
        }

        overheadPerIteration = max(overheadPerIteration / Float64(warmupCount / batches * batches), 0.0)
        overheadPerBatch = max(overheadPerBatch / Float64(batches), 0.0)
        return ema.result
    }

    private func warmupAndEstimate(): Float64 {
        if (let Some(warmupCount) <- configuration.get<Int64>(KeyWarmup.warmup)) {
            return warmupFixedSize(warmupCount)
        }

        let warmupTime = configuration.get<Duration>(KeyWarmup.warmup) ?? Duration.second
        progress.println { "    Warming up for ${printDuration(warmupTime)}."}

        var executedBatches = 0
        var n = 0
        var aggregateTime = 0.0
        var aggregateRuns = 0
        // use exponential moving average to prevent single abnormal result
        // on last warmup iteration to ruin some subsequent calculations
        // which can cause benchmark to work for too long
        var ema = Ema(3)
        do {
            n = min(n * 12 / 10 + 1, batchSize.end) // ~20% increase
            let estimation = runMultipleAndEstimateTime(n)
            aggregateRuns += n
            executedBatches += 1
            //if estimation is that small then most likely result will be zero so we can speed up things
            if (estimation <= 0.001) {
                if (n > 100000 || aggregateRuns > 1000000) {
                    break
                }

                n = n * 10
            }
            aggregateTime += estimation * Float64(n)
            ema.append(estimation)
        } while (aggregateTime < Float64(warmupTime.toNanoseconds()))

        overheadPerIteration = max(overheadPerIteration / Float64(aggregateRuns), 0.0)
        overheadPerBatch = max(overheadPerBatch / Float64(executedBatches), 0.0)
        ema.result
    }

    func runBench() {
        this.explicitGC = configuration.get(KeyExplicitGC.explicitGC) ?? ExplicitGcType.Light

        this.targetDuration = configuration.get(KeyMinDuration.minDuration) ?? Duration.second * 5
        let minBatches = configuration.get(KeyMinBatches.minBatches) ?? 10
        this.minBatches = max(minBatches, 1)

        if (let Some(range) <- configuration.get<Range<Int64>>(KeyBatchSize.batchSize)) {
            this.batchSize = range
        }
        if (let Some(size) <- configuration.get<Int64>(KeyBatchSize.batchSize)) {
            this.batchSize = size..=size
        }

        measurements.reserve(minBatches)

        if (isRunning == true) {
            throw IllegalStateException("It is not allowed to run benchmark inside another benchmark")
        }
        isRunning = true
        try {
            runBenchInner()
        } finally {
            isRunning = false
        }
    }

    func runBenchInner(): Unit {
        if (this.batchSize.end <= 0) {
            throw IllegalArgumentException("batchSize must be positive")
        }
        // do warmup and estimate the benchmark time
        let estimation = warmupAndEstimate()

        let (batchSize, batchCount) = calcBatchSize(estimation)
        this.measurements.reserve(min(batchCount, MEASUREMENTS_LIMIT) - this.measurements.size)

        var batch = Float64(batchSize.start)
        // we use non-constant step to have more data points located closer to zero
        // which allows better overhead calculation and accounts for potential heteroskedasticity
        let avgStep = Float64(batchSize.end - batchSize.start) / Float64(batchCount)
        let stepChange = 2.0 * avgStep / Float64(batchCount)
        var step = stepChange * 0.5
        let start = DateTime.now()
        progress.println {
            let batch = Float64(batchSize.start)
            let avgLen = Float64(batchSize.end - batchSize.start)
            let measurementInfo = configuration.get(KeyMeasurementInfo.measurementInfo) ?? TimeNow().info
            let execTime = Duration.nanosecond * (batch + avgLen / 2.0) * batchCount * avgIterTime(estimation)
            "    Starting measurements of ${batchCount} batches. Measuring ${measurementInfo.name}.\n" +
                "    Max batch size: ${batchSize.end}, estimated execution time: ${printDuration(execTime)}."
        }

        for (i in 0..batchCount) {
            batch = batch + step
            step += stepChange
            runMultipleAndMeasure(Int64(batch |> round), batchSize.end)
            if (batchSize.end == 1) {
                // IMPORTANT: this code MUST be inside this loop and not in a separate loop
                // That is to ensure that any possible external effect is applied to overhead measurements in the same way
                runMultipleAndMeasure(0, batchSize.end)
            }
            // sanity check to prevent too long executions that look like hangs
            if (i > minBatches && DateTime.now() - start > targetDuration * 4 && targetDuration > Duration.Zero) {
                break
            }
        }

        // add some measurements with zero executions to better account for measurement overhead
        runMultipleAndMeasure(0, batchSize.end)

        // invoke here so that we have cleaned heap before next run
        // otherwise GC can be triggered on next bench warmup polluting the results
        ExplicitGcType.Heavy.invoke()
    }

    private func avgIterTime(estimation: Float64): Float64 {
        // last summand is important when user explicitly specifies small batchSize for small benchmark
        estimation + overheadPerIteration * 2.0 + overheadPerBatch / Float64(batchSize.end)
    }

    func calcBatchSize(estimation: Float64): (Range<Int64>, Int64) {
        let targetDurationNs = max(Float64(targetDuration.toNanoseconds()), 0.0)

        let avgOneIterationTime = avgIterTime(estimation)

        // how many batches if executing batches with sizes 1,2,3..N
        // it would be a solution to the quadratic equation: (estimation+overhead*2)*N^2 = duration
        let batchesFrom1ToN = targetDurationNs / avgOneIterationTime |> sqrt |> ceil

        // apply all of the constraints on amount of batches
        let batches = max(min(batchesFrom1ToN, 200.0), Float64(minBatches))

        let avgBatchSize = if (targetDurationNs > 0.0) {
            targetDurationNs / avgOneIterationTime / batches
        } else if (this.batchSize.end >= MAX_BATCH_SIZE) {
            throw IllegalArgumentException("if 'minDuration' parameter is zero then 'batchSize' must be specified")
        } else {
            Float64(this.batchSize.end + this.batchSize.start) / 2.0
        }

        // Setup special aggregating of results when not in batch mode and benchmark is small
        if (this.batchSize.end == 1 && avgBatchSize > 10.0) {
            ema0 = Ema(Int64(avgBatchSize))
            ema1 = Ema(Int64(avgBatchSize))
        }

        // apply all of the constraints on batch size
        let maxBatchSize = min(Int64(ceil((avgBatchSize - 1.0) * 2.0 + 1.0)), this.batchSize.end)
        let range = this.batchSize.start..=max(maxBatchSize, this.batchSize.start)

        let finalAvgBatchSize = Float64(range.start + range.end) / 2.0
        let finalBatches = max(targetDurationNs / avgOneIterationTime / finalAvgBatchSize, Float64(minBatches))

        (range, Int64(ceil(finalBatches)))
    }

    private func runMultipleAndEstimateTime(times: Int64): Float64 {
        let baseWithRun = benchmark.timeLoopOnce(times, times)
        let baseLoopOnly = benchmark.timeLoopOnce(0, times)
        let base = benchmark.timeLoopOnce(0, 0)
        overheadPerIteration += baseLoopOnly - base
        overheadPerBatch += base

        max((baseWithRun - baseLoopOnly) / Float64(times), 0.001)
    }

    private func runMultipleAndMeasure(times: Int64, max: Int64) {
        let dur = benchmark.measureLoopOnce(times, max)

        let result = (Float64(times), dur)

        if (max == 1 && ema0.maxLength != 0) {
            // in that case for small benchmarks if we just save raw results
            // it takes too much memory and takes too long to process later,
            // but at the same time we still need to collect statistical distribution
            // in order to detect signal in all of the noise
            if (times == 0) {
                ema0.append(dur)
                if (ema0.reachedMax()) {
                    explicitGC.invoke()
                    measurements.add((0.0, ema0.result))
                    ema0.reset()
                }
            }
            if (times == 1) {
                ema1.append(dur)
                if (ema1.reachedMax()) {
                    explicitGC.invoke()
                    measurements.add((1.0, ema1.result))
                    ema1.reset()
                }
            }
        } else if (measurements.size > MEASUREMENTS_LIMIT) {
            explicitGC.invoke()
            let randomIdx = abs(random.nextInt64()) % measurements.size
            measurements[randomIdx] = result
        } else {
            explicitGC.invoke()
            measurements.add(result)
        }
    }
}

struct Ema {
    var result: Float64 = 0.0
    private var currentLength: Float64 = 0.0
    Ema(let maxLength: Int64) {}

    mut func reset() {
        result = 0.0
        currentLength = 0.0
    }

    func reachedMax(): Bool {
        currentLength >= Float64(maxLength - 1)
    }

    mut func append(next: Float64) {
        result = (result * currentLength + next) / (currentLength + 1.0)
        currentLength = min(currentLength + 1.0, Float64(maxLength - 1))
    }
}

/**
 * Interface for all kinds of data that can be collected and analyzed during benchmarking.
 */
public interface Measurement {
    func setup() {}

    /**
     * @return representation of the measurement data that will be used for statistical analisys
     * and should be suitable for substraction.
     */
    @Frozen
    func measure(): Float64 { 0.0 }

    /**
     * Conversion table for measured values, contains value multipliers mapped to measurement unit representation.
     */
    prop conversionTable: MeasurementUnitTable {
        get() { [(1.0, "")] }
    }

    /**
     * Name for this type of measurement. Helps to distinguish between different types of Measurement.
     */
    prop name: String {
        get() { "Measurement" }
    }

    /**
     * Simple description of the measurement to be displayed in some reports
     */
    prop textDescription: String {
        get() { "Measures ${name}" }
    }

    prop info: MeasurementInfo {
        get() {
            MeasurementInfo(
                conversionTable, name, textDescription
            )
        }
    }
}

public struct MeasurementInfo {
    MeasurementInfo(
        public let conversionTable: MeasurementUnitTable,
        public let name: String,
        public let textDescription: String
    ) {}
}

/**
 * Conversion table for <value>, contains <value> multiplier and its measurement unit.
 */
public type MeasurementUnitTable = Array<(Float64, String)>

let RADIX_UNIT_TABLE: MeasurementUnitTable = [
    TimeUnit.Nanos.conversionRow(),
    TimeUnit.Micros.conversionRow(),
    TimeUnit.Millis.conversionRow(),
    TimeUnit.Seconds.conversionRow()
]

func printDuration(dur: Duration): String {
    let duration = Float64(dur.toNanoseconds())
    TimeNow().conversionTable.toString(duration)
}

extend MeasurementUnitTable {
    private func adjustMeasurementPrecision(value: Float64): String {
        // calculate how much precision do we need to print 4 most significant digits
        // with at most 3 digits after the dot
        let precision = 3 - Int64(log10(clamp(value, 0.0001, 1000.0)))
        if (precision <= 5) {
            "${value.format(".${precision}")}"
        } else {
            "${value.format(".2G")}"
        }
    }

    /**
     * Representation of measured `value` in suitable measurement unit.
     */
    func toString(value: Float64): String {
        let (boundary, unit) = suitablePair(value)
        toString(value, boundary: boundary, unit: unit)
    }

    /**
     * Representation of measured `value` in suitable measurement `unit` in `boundary`.
     */
    func toString(value: Float64, boundary!: Float64, unit!: String): String {
        if (value.isInf() || value.isNaN()) {
            return value.toString()
        }

        let part = value / boundary
        let formattedPart = adjustMeasurementPrecision(part)
        if (unit.isEmpty()) {
            formattedPart
        } else {
            "${formattedPart} ${unit}"
        }
    }

    func suitablePair(value: Float64): (Float64, String) {
        this.sortBy(comparator: { a, b =>
            let (aMultiplier, _) = a
            let (bMultiplier, _) = b
            aMultiplier.compare(bMultiplier)
        })

        if (this.isEmpty()) {
            (1.0, "")
        } else {
            var result = (this[0][0], this[0][1])
            for ((b, n) in this) {
                let part = value / b
                if (part < 0.5) {
                    break
                }
                result = (b, n)
            }
            result
        }
    }

    func minToNonAdjustedPair(value: Float64): (Float64, String) {
        let (minK, minUnit) = if (this.isEmpty()) {
            (1.0, "")
        } else {
            var (_minK, _minUnit) = this[0]
            for ((k, unit) in this) {
                if (k < _minK) {
                    _minK = k
                    _minUnit = unit
                }
            }
            (_minK, _minUnit)
        }
        (value / minK, minUnit)
    }
}

/**
 * Measures how much time takes to execute a function.
 */
public struct TimeNow <: Measurement {
    var unit: ?TimeUnit = None
    /**
     * @param unit Allows to specify a unit of time that will be used for printing results.
     */
    public init(unit: ?TimeUnit) {
        this.unit = unit
    }
    /**
     * Chooses output precision automatically for each case.
     */
    public init() {}

    @Frozen
    public func measure(): Float64 {
        Float64(DateTime.now().toUnixTimeStamp().toNanoseconds())
    }

    public prop conversionTable: MeasurementUnitTable {
        get() {
            match (unit) {
                case Some(u) => [(u.inNanos(), u.toString())]
                case None => RADIX_UNIT_TABLE
            }
        }
    }

    public prop name: String {
        get() {
            let unitStr = match (unit) {
                case None => ""
                case Some(u) => "(${u})"
            }
            "Duration${unitStr}"
        }
    }

    public prop textDescription: String {
        get() {
            "Measures execution time using std.time.DateTime"
        }
    }
}

/**
 * Used to explicitly specify the time unit used when `TimeNow` prints time.
 */
public enum TimeUnit <: ToString {
    | Nanos
    | Micros
    | Millis
    | Seconds

    public func toString(): String {
        match (this) {
            case Nanos => "ns"
            case Micros => "us"
            case Millis => "ms"
            case Seconds => "s"
        }
    }

    func inNanos(): Float64 {
        match (this) {
            case Nanos => 1.0
            case Micros => 1e3
            case Millis => 1e6
            case Seconds => 1e9
        }
    }

    func conversionRow(): (Float64, String) {
        (inNanos(), toString())
    }
}

/**
 * Used to specify what type of GC is invoked by the test framework in benchmarks.
 * See std.runtime.GC(heavy: bool) for details about types of GC invokations
 */
public enum ExplicitGcType <: ToString {
    // GC is not invoked explicitly
    | Disabled
    // GC(heavy: false) is invoked after each batch
    | Light
    // GC(heavy: true) is invoked after each batch
    | Heavy

    func invoke() {
        match (this) {
            case Disabled => ()
            case Light => GC()
            case Heavy => GC(heavy: true)
        }
    }

    public func toString(): String {
        match (this) {
            case Disabled => "Disabled"
            case Light => "Light"
            case Heavy => "Heavy"
        }
    }
}

@When[arch == "x86_64"]
foreign func GetRdtsc(): UInt64

@When[arch == "x86_64"]
foreign func GetRdtscp(): UInt64

// corresponds to HW_REF_CPU_CYCLES Perf measurements
@When[arch == "x86_64"]
public struct CpuCycles <: Measurement {
    @Frozen
    public func measure(): Float64 {
        unsafe { Float64(GetRdtscp()) }
    }

    public func setup() {}

    public prop conversionTable: MeasurementUnitTable {
        get() { [(1.0, "cycles")] }
    }

    public prop name: String {
        get() { "CpuCycles" }
    }

    public prop textDescription: String {
        get() {
            "Measures how many CPU cycles are taken by function execution using baremetal x86 RDTSCP instruction"
        }
    }
}

@When[os == "Linux"]
foreign func InitPerf(counter: IntNative): IntNative

@When[os == "Linux"]
foreign func ReadPerf(): UInt64

@When[os == "Linux"]
public struct Perf <: Measurement {
    public Perf(var counter: PerfCounter) {}

    public init() {
        this(PerfCounter.HW_INSTRUCTIONS)
    }

    public func setup() {
        let rc = unsafe { InitPerf(counter.asRaw()) }
        match (rc) {
            case 0 => return
            case 13 => // EACCESS
                throw Exception("""
Not enough permissions to access performance counters. You need to reduce required permission by
setting `kernel.perf_event_paranoid` system configuration parameter to value 1 or less.
On systemd distributions it can be done with:
    sudo sysctl kernel.perf_event_paranoid=1
""")
            case 2 | 19 | 95 => // ENOENT|ENODEV|EOPNOTSUPP
                throw Exception(
                "${counter} performance counter is unsupported by current CPU or linux kernel. errno=${rc}")
            case _ => throw Exception(
                "Initialization for ${counter} performance counter failed. perf_event_open syscall returned errno=${rc}")
        }
    }

    @Frozen
    public func measure(): Float64 {
        let result = unsafe { ReadPerf() }
        if (result == UInt64.Max) {
            throw Exception("Error while reading performance counter descriptor")
        }
        Float64(result)
    }

    public prop conversionTable: MeasurementUnitTable {
        get() { [(1.0, counter.unit())] }
    }

    public prop name: String {
        get() { "Perf(${counter.unit()})" }
    }

    public prop textDescription: String {
        get() {
            "Measures how many ${counter.description()} has happened during the execution using linux perf facility with ${counter} counter.\n"+
            "For more details about specific counter see documentation for perf_event_open linux syscall"
        }
    }
}

// Detailed cache counters are not supported yet
@When[os == "Linux"]
public enum PerfCounter <: ToString {
    | HW_CPU_CYCLES
    | HW_INSTRUCTIONS
    | HW_CACHE_REFERENCES
    | HW_CACHE_MISSES
    | HW_BRANCH_INSTRUCTIONS
    | HW_BRANCH_MISSES
    | HW_BUS_CYCLES
    | HW_STALLED_CYCLES_FRONTEND
    | HW_STALLED_CYCLES_BACKEND
    | HW_REF_CPU_CYCLES
    | SW_CPU_CLOCK
    | SW_TASK_CLOCK
    | SW_PAGE_FAULTS
    | SW_CONTEXT_SWITCHES
    | SW_CPU_MIGRATIONS
    | SW_PAGE_FAULTS_MIN
    | SW_PAGE_FAULTS_MAJ
    | SW_EMULATION_FAULTS

    func asRaw(): IntNative {
        match (this) {
            case HW_CPU_CYCLES => 0
            case HW_INSTRUCTIONS => 1
            case HW_CACHE_REFERENCES => 2
            case HW_CACHE_MISSES => 3
            case HW_BRANCH_INSTRUCTIONS => 4
            case HW_BRANCH_MISSES => 5
            case HW_BUS_CYCLES => 6
            case HW_STALLED_CYCLES_FRONTEND => 7
            case HW_STALLED_CYCLES_BACKEND => 8
            case HW_REF_CPU_CYCLES => 9
            case SW_CPU_CLOCK => 10
            case SW_TASK_CLOCK => 11
            case SW_PAGE_FAULTS => 12
            case SW_CONTEXT_SWITCHES => 13
            case SW_CPU_MIGRATIONS => 14
            case SW_PAGE_FAULTS_MIN => 15
            case SW_PAGE_FAULTS_MAJ => 16
            case SW_EMULATION_FAULTS => 17
        }
    }

    func unit(): String {
        match (this) {
            case HW_CPU_CYCLES => "cycles"
            case HW_INSTRUCTIONS => "instr"
            case HW_CACHE_REFERENCES => "cache"
            case HW_CACHE_MISSES => "cmiss"
            case HW_BRANCH_INSTRUCTIONS => "branch"
            case HW_BRANCH_MISSES => "bmiss"
            case HW_BUS_CYCLES => "bcycles"
            case HW_STALLED_CYCLES_FRONTEND => "stalledf"
            case HW_STALLED_CYCLES_BACKEND => "stalledb"
            case HW_REF_CPU_CYCLES => "rcycles"
            case SW_CPU_CLOCK => "clock"
            case SW_TASK_CLOCK => "tclock"
            case SW_PAGE_FAULTS => "pf"
            case SW_CONTEXT_SWITCHES => "cswitch"
            case SW_CPU_MIGRATIONS => "cpumig"
            case SW_PAGE_FAULTS_MIN => "pfmin"
            case SW_PAGE_FAULTS_MAJ => "pfmaj"
            case SW_EMULATION_FAULTS => "emu"
        }
    }

    public func toString(): String {
        match (this) {
            case HW_CPU_CYCLES => "PERF_COUNT_HW_CPU_CYCLES"
            case HW_INSTRUCTIONS => "PERF_COUNT_HW_INSTRUCTIONS"
            case HW_CACHE_REFERENCES => "PERF_COUNT_HW_CACHE_REFERENCES"
            case HW_CACHE_MISSES => "PERF_COUNT_HW_CACHE_MISSES"
            case HW_BRANCH_INSTRUCTIONS => "PERF_COUNT_HW_BRANCH_INSTRUCTIONS"
            case HW_BRANCH_MISSES => "PERF_COUNT_HW_BRANCH_MISSES"
            case HW_BUS_CYCLES => "PERF_COUNT_HW_BUS_CYCLES"
            case HW_STALLED_CYCLES_FRONTEND => "PERF_COUNT_HW_STALLED_CYCLES_FRONTEND"
            case HW_STALLED_CYCLES_BACKEND => "PERF_COUNT_HW_STALLED_CYCLES_BACKEND"
            case HW_REF_CPU_CYCLES => "PERF_COUNT_HW_REF_CPU_CYCLES"
            case SW_CPU_CLOCK => "PERF_COUNT_SW_CPU_CLOCK"
            case SW_TASK_CLOCK => "PERF_COUNT_SW_TASK_CLOCK"
            case SW_PAGE_FAULTS => "PERF_COUNT_SW_PAGE_FAULTS"
            case SW_CONTEXT_SWITCHES => "PERF_COUNT_SW_CONTEXT_SWITCHES"
            case SW_CPU_MIGRATIONS => "PERF_COUNT_SW_CPU_MIGRATIONS"
            case SW_PAGE_FAULTS_MIN => "PERF_COUNT_SW_PAGE_FAULTS_MIN"
            case SW_PAGE_FAULTS_MAJ => "PERF_COUNT_SW_PAGE_FAULTS_MAJ"
            case SW_EMULATION_FAULTS => "PERF_COUNT_SW_EMULATION_FAULTS"
        }
    }

    func description(): String {
        match (this) {
            case HW_CPU_CYCLES => "raw CPU cycles"
            case HW_INSTRUCTIONS => "retired CPU instructions"
            case HW_CACHE_REFERENCES => "cache accesses"
            case HW_CACHE_MISSES => "cache misses"
            case HW_BRANCH_INSTRUCTIONS => "retired branch CPU instructions"
            case HW_BRANCH_MISSES => "branch prediction failures"
            case HW_BUS_CYCLES => "bus cycles"
            case HW_STALLED_CYCLES_FRONTEND => "CPU cycles was wasted on waiting in fronted phase of CPU pipeline"
            case HW_STALLED_CYCLES_BACKEND => "CPU cycles was wasted on waiting in backend phase of CPU pipeline"
            case HW_REF_CPU_CYCLES => "frequency independent CPU cycles"
            case SW_CPU_CLOCK => "per-CPU clock time"
            case SW_TASK_CLOCK => "per task CPU clock time"
            case SW_PAGE_FAULTS => "page faults"
            case SW_CONTEXT_SWITCHES => "OS context switches"
            case SW_CPU_MIGRATIONS => "task migrations between CPUs"
            case SW_PAGE_FAULTS_MIN => "minor page faults"
            case SW_PAGE_FAULTS_MAJ => "major page faults"
            case SW_EMULATION_FAULTS => "unsupported instructions that required kernel emulation"
        }
    }
}
