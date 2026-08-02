/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// Boundary and repeated-call benchmark used to select one shared fast-path threshold.

import std.env.*
import std.random.*
import std.sort.*
import std.time.*

private const WARMUPS: Int64 = 3
private const ROUNDS: Int64 = 10
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
    println("Usage: sort_size_boundary_bench [--type=<name>] [--stable-only|--unstable-only]")
}

private func repetitions(size: Int64): Int64 {
    if (size <= 65) {
        return 2_000
    }
    if (size <= 1_000) {
        return 20
    }
    return 1
}

private func verifyAscending<T>(data: Array<T>): Unit where T <: Comparable<T> {
    for (i in 1..data.size) {
        if (data[i - 1].compare(data[i]) == Ordering.GT) {
            throw Exception("sort result is not ordered")
        }
    }
}

private func benchmarkSize<T>(
    typeName: String,
    size: Int64,
    stable: Bool,
    factory: (Int64) -> Array<T>
): Unit where T <: Comparable<T> {
    let count = repetitions(size)
    let mode = if (stable) {
        "stable"
    } else {
        "unstable"
    }
    for (round in 0..(WARMUPS + ROUNDS)) {
        let batch = Array<Array<T>>(count, {_ => factory(size)})
        let started = MonoTime.now()
        for (data in batch) {
            sort(data, stable: stable)
        }
        let elapsed = MonoTime.now() - started
        for (data in batch) {
            verifyAscending(data)
        }
        let elapsedNs = elapsed.toNanoseconds()
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
        println("${kind},${typeName},${mode},${index},${size},${count},${elapsedNs},${elapsedNs / count}")
    }
}

private func benchmarkType<T>(
    typeName: String,
    typeSelection: String,
    mode: String,
    factory: (Int64) -> Array<T>
): Unit where T <: Comparable<T> {
    if (typeSelection != "all" && typeSelection != typeName) {
        return
    }
    let sizes: Array<Int64> = [2, 8, 15, 16, 17, 31, 32, 33, 63, 64, 65, 1_000, 100_000]
    for (size in sizes) {
        if (mode == "both" || mode == "unstable") {
            benchmarkSize<T>(typeName, size, false, factory)
        }
        if (mode == "both" || mode == "stable") {
            benchmarkSize<T>(typeName, size, true, factory)
        }
    }
}

main(): Int64 {
    if (hasArgument("--help")) {
        printUsage()
        return 0
    }
    let typeSelection = selectedType()
    let mode = selectedMode()
    println("kind,type,mode,index,size,repetitions,elapsed_ns,ns_per_sort")
    benchmarkType<Int8>(
        "Int8",
        typeSelection,
        mode,
        {
            size =>
            let r = Random(SEED);
            Array<Int8>(size, {_ => r.nextInt8()})
        }
    )
    benchmarkType<Int16>(
        "Int16",
        typeSelection,
        mode,
        {
            size =>
            let r = Random(SEED);
            Array<Int16>(size, {_ => r.nextInt16()})
        }
    )
    benchmarkType<Int32>(
        "Int32",
        typeSelection,
        mode,
        {
            size =>
            let r = Random(SEED);
            Array<Int32>(size, {_ => r.nextInt32()})
        }
    )
    benchmarkType<Int64>(
        "Int64",
        typeSelection,
        mode,
        {
            size =>
            let r = Random(SEED);
            Array<Int64>(size, {_ => r.nextInt64()})
        }
    )
    benchmarkType<IntNative>(
        "IntNative",
        typeSelection,
        mode,
        {
            size =>
                let r = Random(SEED)
                Array<IntNative>(size, {_ => IntNative(r.nextInt64())})
        }
    )
    benchmarkType<UInt8>(
        "UInt8",
        typeSelection,
        mode,
        {
            size =>
            let r = Random(SEED);
            Array<UInt8>(size, {_ => r.nextUInt8()})
        }
    )
    benchmarkType<UInt16>(
        "UInt16",
        typeSelection,
        mode,
        {
            size =>
            let r = Random(SEED);
            Array<UInt16>(size, {_ => r.nextUInt16()})
        }
    )
    benchmarkType<UInt32>(
        "UInt32",
        typeSelection,
        mode,
        {
            size =>
            let r = Random(SEED);
            Array<UInt32>(size, {_ => r.nextUInt32()})
        }
    )
    benchmarkType<UInt64>(
        "UInt64",
        typeSelection,
        mode,
        {
            size =>
            let r = Random(SEED);
            Array<UInt64>(size, {_ => r.nextUInt64()})
        }
    )
    benchmarkType<UIntNative>(
        "UIntNative",
        typeSelection,
        mode,
        {
            size =>
                let r = Random(SEED)
                Array<UIntNative>(size, {_ => UIntNative(r.nextUInt64())})
        }
    )
    benchmarkType<Float16>(
        "Float16",
        typeSelection,
        mode,
        {
            size =>
            let r = Random(SEED);
            Array<Float16>(size, {_ => r.nextFloat16()})
        }
    )
    benchmarkType<Float32>(
        "Float32",
        typeSelection,
        mode,
        {
            size =>
            let r = Random(SEED);
            Array<Float32>(size, {_ => r.nextFloat32()})
        }
    )
    benchmarkType<Float64>(
        "Float64",
        typeSelection,
        mode,
        {
            size =>
            let r = Random(SEED);
            Array<Float64>(size, {_ => r.nextFloat64()})
        }
    )
    benchmarkType<Rune>(
        "Rune",
        typeSelection,
        mode,
        {
            size =>
                let r = Random(SEED)
                Array<Rune>(size, {_ => Rune(UInt32(32) + r.nextUInt32(UInt32(95)))})
        }
    )
    return 0
}
