/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// Configurable large-input natural-sort matrix for the fourteen primitive types.

import std.env.*
import std.random.*
import std.sort.*
import std.time.*

private const WARMUPS: Int64 = 3
private const ROUNDS: Int64 = 10
private const DEFAULT_SIZE: Int64 = 1_000_000
private const SEED: UInt64 = 2651

private func hasArgument(expected: String): Bool {
    for (argument in getCommandLine()) {
        if (argument == expected) {
            return true
        }
    }
    return false
}

private func selectedSize(): Int64 {
    if (hasArgument("--size=100000")) {
        return 100_000
    }
    if (hasArgument("--size=10000000")) {
        return 10_000_000
    }
    return DEFAULT_SIZE
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
    println("Usage: sort_primitive_matrix_bench [--type=<name>] [--size=<size>] [--stable-only|--unstable-only]")
    println("Types: Int8 Int16 Int32 Int64 IntNative UInt8 UInt16 UInt32 UInt64 UIntNative")
    println("       Float16 Float32 Float64 Rune")
    println("Sizes: 100000, 1000000 (default), 10000000")
}

private func verifyAscending<T>(data: Array<T>): Unit where T <: Comparable<T> {
    for (i in 1..data.size) {
        if (data[i - 1].compare(data[i]) == Ordering.GT) {
            throw Exception("sort result is not ordered")
        }
    }
}

private func benchmarkNatural<T>(
    typeName: String,
    stable: Bool,
    size: Int64,
    factory: (Int64) -> Array<T>
): Unit where T <: Comparable<T> {
    let mode = if (stable) {
        "stable"
    } else {
        "unstable"
    }
    for (round in 0..(WARMUPS + ROUNDS)) {
        let data = factory(size)
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
        println("${kind},${typeName},${mode},${index},${size},${elapsed.toNanoseconds()}")
    }
}

private func benchmarkType<T>(
    typeName: String,
    typeSelection: String,
    mode: String,
    size: Int64,
    factory: (Int64) -> Array<T>
): Unit where T <: Comparable<T> {
    if (typeSelection != "all" && typeSelection != typeName) {
        return
    }
    if (mode == "both" || mode == "unstable") {
        benchmarkNatural<T>(typeName, false, size, factory)
    }
    if (mode == "both" || mode == "stable") {
        benchmarkNatural<T>(typeName, true, size, factory)
    }
}

main(): Int64 {
    if (hasArgument("--help")) {
        printUsage()
        return 0
    }

    let size = selectedSize()
    let typeSelection = selectedType()
    let mode = selectedMode()
    println("kind,type,mode,index,size,elapsed_ns")
    benchmarkType<Int8>(
        "Int8",
        typeSelection,
        mode,
        size,
        {
            n =>
            let r = Random(SEED);
            Array<Int8>(n, {_ => r.nextInt8()})
        }
    )
    benchmarkType<Int16>(
        "Int16",
        typeSelection,
        mode,
        size,
        {
            n =>
            let r = Random(SEED);
            Array<Int16>(n, {_ => r.nextInt16()})
        }
    )
    benchmarkType<Int32>(
        "Int32",
        typeSelection,
        mode,
        size,
        {
            n =>
            let r = Random(SEED);
            Array<Int32>(n, {_ => r.nextInt32()})
        }
    )
    benchmarkType<Int64>(
        "Int64",
        typeSelection,
        mode,
        size,
        {
            n =>
            let r = Random(SEED);
            Array<Int64>(n, {_ => r.nextInt64()})
        }
    )
    benchmarkType<IntNative>(
        "IntNative",
        typeSelection,
        mode,
        size,
        {
            n =>
                let r = Random(SEED)
                Array<IntNative>(n, {_ => IntNative(r.nextInt64())})
        }
    )
    benchmarkType<UInt8>(
        "UInt8",
        typeSelection,
        mode,
        size,
        {
            n =>
            let r = Random(SEED);
            Array<UInt8>(n, {_ => r.nextUInt8()})
        }
    )
    benchmarkType<UInt16>(
        "UInt16",
        typeSelection,
        mode,
        size,
        {
            n =>
            let r = Random(SEED);
            Array<UInt16>(n, {_ => r.nextUInt16()})
        }
    )
    benchmarkType<UInt32>(
        "UInt32",
        typeSelection,
        mode,
        size,
        {
            n =>
            let r = Random(SEED);
            Array<UInt32>(n, {_ => r.nextUInt32()})
        }
    )
    benchmarkType<UInt64>(
        "UInt64",
        typeSelection,
        mode,
        size,
        {
            n =>
            let r = Random(SEED);
            Array<UInt64>(n, {_ => r.nextUInt64()})
        }
    )
    benchmarkType<UIntNative>(
        "UIntNative",
        typeSelection,
        mode,
        size,
        {
            n =>
                let r = Random(SEED)
                Array<UIntNative>(n, {_ => UIntNative(r.nextUInt64())})
        }
    )
    benchmarkType<Float16>(
        "Float16",
        typeSelection,
        mode,
        size,
        {
            n =>
            let r = Random(SEED);
            Array<Float16>(n, {_ => r.nextFloat16()})
        }
    )
    benchmarkType<Float32>(
        "Float32",
        typeSelection,
        mode,
        size,
        {
            n =>
            let r = Random(SEED);
            Array<Float32>(n, {_ => r.nextFloat32()})
        }
    )
    benchmarkType<Float64>(
        "Float64",
        typeSelection,
        mode,
        size,
        {
            n =>
            let r = Random(SEED);
            Array<Float64>(n, {_ => r.nextFloat64()})
        }
    )
    benchmarkType<Rune>(
        "Rune",
        typeSelection,
        mode,
        size,
        {
            n =>
                let r = Random(SEED)
                Array<Rune>(n, {_ => Rune(UInt32(32) + r.nextUInt32(UInt32(95)))})
        }
    )
    return 0
}
