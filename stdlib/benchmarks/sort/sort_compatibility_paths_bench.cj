/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

// Container, comparator and generic-fallback performance controls.

import std.collection.*
import std.env.*
import std.random.*
import std.sort.*
import std.time.*

private const WARMUPS: Int64 = 3
private const ROUNDS: Int64 = 10
private const SIZE: Int64 = 1_000
private const PATH_REPETITIONS: Int64 = 20
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
        "Rune",
        "String",
        "Person"
    ]
    for (typeName in typeNames) {
        if (hasArgument("--type=${typeName}")) {
            return typeName
        }
    }
    return "all"
}

private func printUsage(): Unit {
    println(
        "Usage: sort_compatibility_paths_bench [--type=<name>] " +
            "[--natural-only|--unchanged-only|--fallback-only|--threshold-selection]")
}

private class Person <: Comparable<Person> {
    let age: Int32
    let sequence: Int64

    init(age: Int32, sequence: Int64) {
        this.age = age
        this.sequence = sequence
    }

    public func compare(rhs: Person): Ordering {
        this.age.compare(rhs.age)
    }
    public operator func ==(rhs: Person): Bool {
        this.age == rhs.age && this.sequence == rhs.sequence
    }
    public operator func !=(rhs: Person): Bool {
        !(this == rhs)
    }
    public operator func <(rhs: Person): Bool {
        this.age < rhs.age
    }
    public operator func >(rhs: Person): Bool {
        this.age > rhs.age
    }
    public operator func <=(rhs: Person): Bool {
        this.age <= rhs.age
    }
    public operator func >=(rhs: Person): Bool {
        this.age >= rhs.age
    }
}

private func verify<T>(data: Array<T>, descending: Bool): Unit where T <: Comparable<T> {
    for (i in 1..data.size) {
        let ordering = data[i - 1].compare(data[i])
        if ((!descending && ordering == Ordering.GT) || (descending && ordering == Ordering.LT)) {
            throw Exception("sort result is not ordered")
        }
    }
}

private func benchmarkArrayPath<T>(
    typeName: String,
    path: String,
    descending: Bool,
    factory: () -> Array<T>,
    action: (Array<T>) -> Unit
): Unit where T <: Comparable<T> {
    for (round in 0..(WARMUPS + ROUNDS)) {
        let batch = Array<Array<T>>(PATH_REPETITIONS, {_ => factory()})
        let started = MonoTime.now()
        for (data in batch) {
            action(data)
        }
        let elapsed = MonoTime.now() - started
        for (data in batch) {
            verify(data, descending)
        }
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
        let elapsedNs = elapsed.toNanoseconds()
        println(
            "${kind},${typeName},Array,${path},${index},${SIZE},${PATH_REPETITIONS}," +
                "${elapsedNs},${elapsedNs / PATH_REPETITIONS}")
    }
}

private func benchmarkArrayList<T>(
    typeName: String,
    stable: Bool,
    factory: () -> Array<T>
): Unit where T <: Comparable<T> {
    let mode = if (stable) {
        "natural-stable"
    } else {
        "natural-unstable"
    }
    for (round in 0..(WARMUPS + ROUNDS)) {
        let data = ArrayList<T>(factory())
        let started = MonoTime.now()
        sort(data, stable: stable)
        let elapsed = MonoTime.now() - started
        verify(data.toArray(), false)
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
        let elapsedNs = elapsed.toNanoseconds()
        println("${kind},${typeName},ArrayList,${mode},${index},${SIZE},1,${elapsedNs},${elapsedNs}")
    }
}

private func benchmarkList<T>(
    typeName: String,
    stable: Bool,
    factory: () -> Array<T>
): Unit where T <: Comparable<T> {
    let mode = if (stable) {
        "natural-stable"
    } else {
        "natural-unstable"
    }
    for (round in 0..(WARMUPS + ROUNDS)) {
        var data: List<T> = ArrayList<T>(factory())
        let started = MonoTime.now()
        sort(data, stable: stable)
        let elapsed = MonoTime.now() - started
        verify(data.toArray(), false)
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
        let elapsedNs = elapsed.toNanoseconds()
        println("${kind},${typeName},List,${mode},${index},${SIZE},1,${elapsedNs},${elapsedNs}")
    }
}

private func benchmarkPrimitivePaths<T>(
    typeName: String,
    factory: () -> Array<T>,
    mode: String
): Unit where T <: Comparable<T> {
    let typeSelection = selectedType()
    if (typeSelection != "all" && typeSelection != typeName) {
        return
    }
    if (mode == "all" || mode == "natural") {
        benchmarkArrayPath<T>(typeName, "natural-unstable", false, factory, {data => sort(data, stable: false)})
        benchmarkArrayPath<T>(typeName, "natural-stable", false, factory, {data => sort(data, stable: true)})
    }
    if (mode == "all" || mode == "unchanged") {
        benchmarkArrayPath<T>(typeName, "by", false, factory,
            {data => sort(data, by: {left, right => left.compare(right)})})
        benchmarkArrayPath<T>(typeName, "lessThan", false, factory,
            {data => sort(data, lessThan: {left, right => left.compare(right) == Ordering.LT})})
        benchmarkArrayPath<T>(typeName, "key", false, factory, {data => sort(data, key: {value => value})})
        benchmarkArrayPath<T>(typeName, "descending", true, factory, {data => sort(data, descending: true)})
    }
    if (mode == "all" || mode == "natural") {
        benchmarkArrayList<T>(typeName, false, factory)
        benchmarkArrayList<T>(typeName, true, factory)
        benchmarkList<T>(typeName, false, factory)
        benchmarkList<T>(typeName, true, factory)
    }
}

private func fallbackRepetitions(size: Int64): Int64 {
    if (size <= 16) {
        return 10_000
    }
    if (size <= 64) {
        return 2_000
    }
    if (size <= 1_000) {
        return 20
    }
    return 1
}

private func benchmarkFallback<T>(
    typeName: String,
    size: Int64,
    stable: Bool,
    factory: (Int64) -> Array<T>
): Unit where T <: Comparable<T> {
    let count = fallbackRepetitions(size)
    let path = if (stable) {
        "fallback-stable"
    } else {
        "fallback-unstable"
    }
    for (round in 0..(WARMUPS + ROUNDS)) {
        let batch = Array<Array<T>>(count, {_ => factory(size)})
        let started = MonoTime.now()
        for (data in batch) {
            sort(data, stable: stable)
        }
        let elapsed = MonoTime.now() - started
        for (data in batch) {
            verify(data, false)
        }
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
        let elapsedNs = elapsed.toNanoseconds()
        println("${kind},${typeName},Array,${path},${index},${size},${count},${elapsedNs},${elapsedNs / count}")
    }
}

private func benchmarkMode(): String {
    if (hasArgument("--threshold-selection")) {
        return "threshold"
    }
    if (hasArgument("--unchanged-only")) {
        return "unchanged"
    }
    if (hasArgument("--fallback-only")) {
        return "fallback"
    }
    if (hasArgument("--natural-only")) {
        return "natural"
    }
    return "all"
}

private func benchmarkFallbacks(selectionOnly: Bool, typeSelection: String): Unit {
    let sizes: Array<Int64> = if (selectionOnly) {
        [16, 64]
    } else {
        [16, 1_000]
    }
    for (size in sizes) {
        if (typeSelection == "all" || typeSelection == "String") {
            benchmarkFallback<String>("String", size, false, {n => Array<String>(n, {i => "value-${(n - i) % 4096}"})})
            benchmarkFallback<String>("String", size, true, {n => Array<String>(n, {i => "value-${(n - i) % 4096}"})})
        }
        if (typeSelection == "all" || typeSelection == "Person") {
            benchmarkFallback<Person>("Person", size, false,
                {n => Array<Person>(n, {i => Person(Int32((n - i) % 4096), i)})})
            benchmarkFallback<Person>("Person", size, true, {n =>
                Array<Person>(n, {i => Person(Int32((n - i) % 4096), i)})
            })
        }
    }

    if (!selectionOnly && (typeSelection == "all" || typeSelection == "Person")) {
        benchmarkArrayPath<Person>("Person", "key", false,
            {=> Array<Person>(SIZE, {i => Person(Int32((SIZE - i) % 4096), i)})},
            {data => sort(data, key: {person => person.age}, stable: true)})
    }
}

main(): Int64 {
    if (hasArgument("--help")) {
        printUsage()
        return 0
    }
    println("kind,type,container,path,index,size,repetitions,elapsed_ns,ns_per_sort")
    let mode = benchmarkMode()
    let typeSelection = selectedType()
    if (mode == "threshold") {
        benchmarkFallbacks(true, typeSelection)
        return 0
    }
    if (mode == "all" || mode == "natural" || mode == "unchanged") {
        benchmarkPrimitivePaths<Int8>(
            "Int8",
            {
                =>
                let r = Random(SEED);
                Array<Int8>(SIZE, {_ => r.nextInt8()})
            },
            mode
        )
        benchmarkPrimitivePaths<Int16>(
            "Int16",
            {
                =>
                let r = Random(SEED);
                Array<Int16>(SIZE, {_ => r.nextInt16()})
            },
            mode
        )
        benchmarkPrimitivePaths<Int32>(
            "Int32",
            {
                =>
                let r = Random(SEED);
                Array<Int32>(SIZE, {_ => r.nextInt32()})
            },
            mode
        )
        benchmarkPrimitivePaths<Int64>(
            "Int64",
            {
                =>
                let r = Random(SEED);
                Array<Int64>(SIZE, {_ => r.nextInt64()})
            },
            mode
        )
        benchmarkPrimitivePaths<IntNative>(
            "IntNative",
            {
                =>
                    let r = Random(SEED)
                    Array<IntNative>(SIZE, {_ => IntNative(r.nextInt64())})
            },
            mode
        )
        benchmarkPrimitivePaths<UInt8>(
            "UInt8",
            {
                =>
                let r = Random(SEED);
                Array<UInt8>(SIZE, {_ => r.nextUInt8()})
            },
            mode
        )
        benchmarkPrimitivePaths<UInt16>(
            "UInt16",
            {
                =>
                let r = Random(SEED);
                Array<UInt16>(SIZE, {_ => r.nextUInt16()})
            },
            mode
        )
        benchmarkPrimitivePaths<UInt32>(
            "UInt32",
            {
                =>
                let r = Random(SEED);
                Array<UInt32>(SIZE, {_ => r.nextUInt32()})
            },
            mode
        )
        benchmarkPrimitivePaths<UInt64>(
            "UInt64",
            {
                =>
                let r = Random(SEED);
                Array<UInt64>(SIZE, {_ => r.nextUInt64()})
            },
            mode
        )
        benchmarkPrimitivePaths<UIntNative>(
            "UIntNative",
            {
                =>
                    let r = Random(SEED)
                    Array<UIntNative>(SIZE, {_ => UIntNative(r.nextUInt64())})
            },
            mode
        )
        benchmarkPrimitivePaths<Float16>(
            "Float16",
            {
                =>
                let r = Random(SEED);
                Array<Float16>(SIZE, {_ => r.nextFloat16()})
            },
            mode
        )
        benchmarkPrimitivePaths<Float32>(
            "Float32",
            {
                =>
                let r = Random(SEED);
                Array<Float32>(SIZE, {_ => r.nextFloat32()})
            },
            mode
        )
        benchmarkPrimitivePaths<Float64>(
            "Float64",
            {
                =>
                let r = Random(SEED);
                Array<Float64>(SIZE, {_ => r.nextFloat64()})
            },
            mode
        )
        benchmarkPrimitivePaths<Rune>(
            "Rune",
            {
                =>
                    let r = Random(SEED)
                    Array<Rune>(SIZE, {_ => Rune(UInt32(32) + r.nextUInt32(UInt32(95)))})
            },
            mode
        )
    }
    if (mode == "all" || mode == "fallback") {
        benchmarkFallbacks(false, typeSelection)
    }
    return 0
}
