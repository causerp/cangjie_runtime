/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest

import std.time.DateTime

// Marker interface to be able to detect BenchInputProvider<T> when we do not know `T`
public interface BenchmarkInputMarker {}

// Interface to handle benchmarks where some code needs to be executed before the benchmark
// or input of the benchmark is mutated and has to be generated each time from scratch.
public interface BenchInputProvider<T> <: BenchmarkInputMarker {
    // Called before benchmark measurements.
    // After this function was called, subsequent `get(i)` calls must success for `i` in `0..max`
    @Frozen
    mut func reset(max: Int64) {
        let _ = max
    }

    // Execution time of this function is included in benchmark measurements
    // and then it is excluded from results as part of framework overhead calculations
    @Frozen
    mut func get(idx: Int64): T
}

// Default and simplest input provider that just copies data for each invokation of the benchmark.
public struct ImmutableInputProvider<T> <: BenchInputProvider<T> {
    @Frozen
    public ImmutableInputProvider(let data: T) {}

    @Frozen
    public mut func get(_: Int64): T { data }

    @Frozen
    public static func createOrExisting(arg: T, x!: Int64 = 0): ImmutableInputProvider<T> {
        let _ = x
        ImmutableInputProvider(arg)
    }

    @Frozen
    public static func createOrExisting<U>(arg: U): U where U <: BenchInputProvider<T> {
        arg
    }
}

// Input provider that generates input for the whole benchmark batch in a buffer before executing it
public struct BatchInputProvider<T> <: BenchInputProvider<T> {
    var data: Array<T> = []

    @Frozen
    public BatchInputProvider(let builder: () -> T) {}

    @Frozen
    public mut func reset(max: Int64) {
        if (data.size >= max) {
            // reuse existing array if possible
            for (i in 0..data.size) {
                data[i] = builder()
            }
        } else {
            let x = builder
            data = Array(max, { _ => x() })
        }
    }

    @Frozen
    public mut func get(idx: Int64): T { data[idx] }
}

// Benchmark input provider that generates input right before each execution of benchmark.
// The difference with `GenerateEachInputProvider` is that when batch size is 1 we can measure
// each benchmark invocation independently so input generation is never included in the measurements.
// Should be used if `GenerateEachInputProvider` gives poor quality results.
public struct BatchSizeOneInputProvider<T> <: BenchInputProvider<T> {
    var data: T

    @Frozen
    public BatchSizeOneInputProvider(let builder: () -> T) {
        data = builder()
    }

    @Frozen
    public mut func reset(max: Int64) {
        if (max > 1) {
            throw IllegalStateException("Please set `batchSize` parameter equal to 1 in @Configure.")
        }
        data = builder()
    }

    @Frozen
    public mut func get(_: Int64): T { data }
}

// Benchmark input provider that generates input right before each execution of benchmark.
// Generation time is included in benchmark measurements
// and then later it is excluded from results as part of framework overhead calculations.
public struct GenerateEachInputProvider<T> <: BenchInputProvider<T> {
    @Frozen
    public GenerateEachInputProvider(let builder: () -> T) {}

    @Frozen
    public mut func reset(_: Int64) {}

    @Frozen
    public mut func get(_: Int64): T { builder() }
}

struct SimpleBenchWrapper<T> <: BenchmarkWrapper {
    SimpleBenchWrapper(let input: T, let f: (T, Int64, Int64) -> Float64) {}

    public func measureLoopOnce(times: Int64, max: Int64): Float64 {
        f(input, times, max)
    }

    public func timeLoopOnce(times: Int64, max: Int64): Float64 {
        let tmp = DateTime.now()
        f(input, times, max)
        Float64((DateTime.now() - tmp).toNanoseconds())
    }
}

// Internal unifying interface for various benchmarks types
interface BenchmarkWrapper {
    func measureLoopOnce(times: Int64, max: Int64): Float64

    func timeLoopOnce(times: Int64, max: Int64): Float64
}

public interface BenchmarkConfig {
    // Corresponds to the batchSize parameter of @Configure macro
    func batchSize(b: Int64): Unit
    // Corresponds to the batchSize parameter of @Configure macro
    func batchSize(x: Range<Int64>): Unit
    // Corresponds to the warmup parameter of @Configure macro
    func warmup(x: Int64): Unit
    // Corresponds to the warmup parameter of @Configure macro
    func warmup(x: Duration): Unit
    // Corresponds to the minDuration parameter of @Configure macro
    func minDuration(x: Duration): Unit
    // Corresponds to the explicitGC parameter of @Configure macro
    func explicitGC(x: ExplicitGcType): Unit
    // Corresponds to the batchSize parameter of @Configure macro
    func minBatches(x: Int64): Unit
}

extend Configuration <: BenchmarkConfig {
    public func batchSize(b: Int64) {
        batchSize(b..=b)
    }

    public func batchSize(x: Range<Int64>) {
        if (x.end < 1 || x.end > MAX_BATCH_SIZE) {
            throw IllegalArgumentException("batch size must be in range from 1 to ${MAX_BATCH_SIZE}")
        }
        this.set(KeyBatchSize.batchSize, x)
    }

    public func warmup(x: Int64) {
        this.set(KeyWarmup.warmup, x)
    }

    public func warmup(x: Duration) {
        this.set(KeyWarmup.warmup, x)
    }

    public func minDuration(x: Duration) {
        this.set(KeyMinDuration.minDuration, x)
    }

    public func explicitGC(x: ExplicitGcType) {
        this.set(KeyExplicitGC.explicitGC, x)
    }

    public func minBatches(x: Int64) {
        this.set(KeyMinBatches.minBatches, x)
    }
}
