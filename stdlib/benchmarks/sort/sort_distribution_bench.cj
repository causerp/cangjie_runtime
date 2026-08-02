/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// Distribution-sensitive stable and unstable natural-sort benchmark.

import std.env.*
import std.random.*
import std.sort.*
import std.time.*

private const WARMUPS: Int64 = 3
private const ROUNDS: Int64 = 10
private const SIZE: Int64 = 100_000
private const SEED: UInt64 = 2651

private func hasArgument(expected: String): Bool {
    for (argument in getCommandLine()) {
        if (argument == expected) {
            return true
        }
    }
    return false
}

private func selectedType(): String {
    let typeNames = [
        "Int8",
        "Int16",
        "Int32",
        "Int64",
        "IntNative",
        "UInt8",
        "UInt16",
        "UInt32",
        "UInt64",
        "UIntNative",
        "Float16",
        "Float32",
        "Float64",
        "Rune"
    ]
    for (typeName in typeNames) {
        if (hasArgument("--type=${typeName}")) {
            return typeName
        }
    }
    return "all"
}

private func selectedDistribution(): String {
    let distributions = [
        "random",
        "sorted",
        "reverse",
        "equal",
        "low-cardinality",
        "nearly-sorted",
        "finite-inf-zero"
    ]
    for (distribution in distributions) {
        if (hasArgument("--distribution=${distribution}")) {
            return distribution
        }
    }
    return "all"
}

private func selectedMode(): String {
    if (hasArgument("--stable-only")) {
        return "stable"
    }
    if (hasArgument("--unstable-only")) {
        return "unstable"
    }
    return "both"
}

private func printUsage(): Unit {
    println(
        "Usage: sort_distribution_bench [--type=<name>] [--distribution=<name>] " + "[--stable-only|--unstable-only]")
}

private func verifyAscending<T>(data: Array<T>): Unit where T <: Comparable<T> {
    for (i in 1..data.size) {
        if (data[i - 1].compare(data[i]) == Ordering.GT) {
            throw Exception("sort result is not ordered")
        }
    }
}

private func nearlySorted<T>(orderedValue: (Int64) -> T): Array<T> {
    let data = Array<T>(SIZE, {i => orderedValue(i)})
    for (i in 1..SIZE : 100) {
        let previous = i - 1
        let temporary = data[previous]
        data[previous] = data[i]
        data[i] = temporary
    }
    return data
}

private func benchmarkDistribution<T>(
    typeName: String,
    distribution: String,
    stable: Bool,
    factory: () -> Array<T>
): Unit where T <: Comparable<T> {
    let mode = if (stable) {
        "stable"
    } else {
        "unstable"
    }
    for (round in 0..(WARMUPS + ROUNDS)) {
        let data = factory()
        let started = MonoTime.now()
        sort(data, stable: stable)
        let elapsed = MonoTime.now() - started
        verifyAscending(data)
        let kind = if (round < WARMUPS) {
            "warmup"
        } else {
            "measurement"
        }
        let index = if (round < WARMUPS) {
            round
        } else {
            round - WARMUPS
        }
        println("${kind},${typeName},${distribution},${mode},${index},${SIZE},${elapsed.toNanoseconds()}")
    }
}

private func benchmarkBoth<T>(
    typeName: String,
    distribution: String,
    factory: () -> Array<T>
): Unit where T <: Comparable<T> {
    let typeSelection = selectedType()
    let distributionSelection = selectedDistribution()
    if ((typeSelection != "all" && typeSelection != typeName) || (distributionSelection != "all" &&
        distributionSelection != distribution)) {
        return
    }
    let mode = selectedMode()
    if (mode == "both" || mode == "unstable") {
        benchmarkDistribution<T>(typeName, distribution, false, factory)
    }
    if (mode == "both" || mode == "stable") {
        benchmarkDistribution<T>(typeName, distribution, true, factory)
    }
}

private func benchmarkType<T>(
    typeName: String,
    randomValue: (Random) -> T,
    orderedValue: (Int64) -> T,
    equalValue: T,
    lowCardinalityValue: (Random) -> T
): Unit where T <: Comparable<T> {
    benchmarkBoth<T>(
        typeName,
        "random",
        {
            =>
                let random = Random(SEED)
                Array<T>(SIZE, {_ => randomValue(random)})
        }
    )
    benchmarkBoth<T>(typeName, "sorted", {=> Array<T>(SIZE, {i => orderedValue(i)})})
    benchmarkBoth<T>(typeName, "reverse", {=> Array<T>(SIZE, {i => orderedValue(SIZE - i - 1)})})
    benchmarkBoth<T>(typeName, "equal", {=> Array<T>(SIZE, {_ => equalValue})})
    benchmarkBoth<T>(
        typeName,
        "low-cardinality",
        {
            =>
                let random = Random(SEED)
                Array<T>(SIZE, {_ => lowCardinalityValue(random)})
        }
    )
    benchmarkBoth<T>(typeName, "nearly-sorted", {=> nearlySorted<T>(orderedValue)})
}

private func float16Special(): Array<Float16> {
    let values: Array<Float16> = [-Float16.Inf, -1.0, -0.0, 0.0, 1.0, Float16.Inf]
    return Array<Float16>(SIZE, {i => values[i % values.size]})
}

private func float32Special(): Array<Float32> {
    let values: Array<Float32> = [-Float32.Inf, -1.0, -0.0, 0.0, 1.0, Float32.Inf]
    return Array<Float32>(SIZE, {i => values[i % values.size]})
}

private func float64Special(): Array<Float64> {
    let values: Array<Float64> = [-Float64.Inf, -1.0, -0.0, 0.0, 1.0, Float64.Inf]
    return Array<Float64>(SIZE, {i => values[i % values.size]})
}

main(): Int64 {
    if (hasArgument("--help")) {
        printUsage()
        return 0
    }
    println("kind,type,distribution,mode,index,size,elapsed_ns")
    benchmarkType<Int8>("Int8", {r => r.nextInt8()}, {i => Int8((i * 255) / SIZE - 128)}, 7,
        {r => Int8(r.nextUInt8(UInt8(16)))})
    benchmarkType<Int16>("Int16", {r => r.nextInt16()}, {i => Int16((i * 65535) / SIZE - 32768)}, 7,
        {r => Int16(r.nextUInt16(UInt16(16)))})
    benchmarkType<Int32>("Int32", {r => r.nextInt32()}, {i => Int32(i)}, 7, {r => Int32(r.nextUInt32(UInt32(16)))})
    benchmarkType<Int64>("Int64", {r => r.nextInt64()}, {i => i}, 7, {r => Int64(r.nextUInt64(UInt64(16)))})
    benchmarkType<IntNative>("IntNative", {r => IntNative(r.nextInt64())}, {i => IntNative(i)}, 7,
        {r => IntNative(r.nextUInt64(UInt64(16)))})
    benchmarkType<UInt8>(
        "UInt8",
        {r => r.nextUInt8()},
        {i => UInt8((i * 255) / SIZE)},
        7,
        {r => r.nextUInt8(UInt8(16))}
    )
    benchmarkType<UInt16>("UInt16", {r => r.nextUInt16()}, {i => UInt16((i * 65535) / SIZE)}, 7,
        {r => r.nextUInt16(UInt16(16))})
    benchmarkType<UInt32>("UInt32", {r => r.nextUInt32()}, {i => UInt32(i)}, 7, {r => r.nextUInt32(UInt32(16))})
    benchmarkType<UInt64>("UInt64", {r => r.nextUInt64()}, {i => UInt64(i)}, 7, {r => r.nextUInt64(UInt64(16))})
    benchmarkType<UIntNative>("UIntNative", {r => UIntNative(r.nextUInt64())}, {i => UIntNative(i)}, 7,
        {r => UIntNative(r.nextUInt64(UInt64(16)))})
    benchmarkType<Float16>("Float16", {r => r.nextFloat16()}, {i => Float16(i)}, 7.0,
        {r => Float16(r.nextUInt32(UInt32(16)))})
    benchmarkType<Float32>("Float32", {r => r.nextFloat32()}, {i => Float32(i)}, 7.0,
        {r => Float32(r.nextUInt32(UInt32(16)))})
    benchmarkType<Float64>("Float64", {r => r.nextFloat64()}, {i => Float64(i)}, 7.0,
        {r => Float64(r.nextUInt32(UInt32(16)))})
    benchmarkType<Rune>("Rune", {r => Rune(UInt32(32) + r.nextUInt32(UInt32(95)))},
        {i => Rune(UInt32(32) + UInt32((i * 95) / SIZE))}, r'g', {r => Rune(UInt32(32) + r.nextUInt32(UInt32(8)))})

    benchmarkBoth<Float16>("Float16", "finite-inf-zero", float16Special)
    benchmarkBoth<Float32>("Float32", "finite-inf-zero", float32Special)
    benchmarkBoth<Float64>("Float64", "finite-inf-zero", float64Special)
    return 0
}
