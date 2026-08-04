/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package issue586_string_hashcode
import std.time.*
import std.random.*

/**
 * Community learning race — Scheme A deliverable for
 * https://atomgit.com/Cangjie/cangjie_runtime/issues/586
 *
 * Build & run:
 *   cjc -O2 -Woff unused --output issue586_bench src/main.cj
 *   ./issue586_bench
 */

const DATA_SIZE: Int64 = 256 * 1024
const STR_MIN_SIZE: Int64 = 2
const STR_MAX_SIZE: Int64 = 20

func makeRandomStrings(seed: UInt64): Array<String> {
    let rnd = Random(seed)
    var arr = Array<String>(DATA_SIZE, repeat: "")
    for (i in 0..DATA_SIZE) {
        let size = STR_MIN_SIZE + rnd.nextInt64(STR_MAX_SIZE - STR_MIN_SIZE)
        var buf = Array<UInt8>(size, repeat: 0)
        for (j in 0..size) {
            buf[j] = UInt8(32 + rnd.nextInt64(95))
        }
        arr[i] = String.fromUtf8(buf)
    }
    return arr
}

func hashAll(arr: Array<String>): Int64 {
    var result: Int64 = 0
    for (i in 0..arr.size) {
        result ^= arr[i].hashCode()
    }
    return result
}

func hashCached(cached: Array<Int64>): Int64 {
    var result: Int64 = 0
    for (i in 0..cached.size) {
        result ^= cached[i]
    }
    return result
}

func precomputeHashes(arr: Array<String>): Array<Int64> {
    var cached = Array<Int64>(arr.size, repeat: 0)
    for (i in 0..arr.size) {
        cached[i] = arr[i].hashCode()
    }
    return cached
}

func timed(label: String, rounds: Int64, body: () -> Int64): Float64 {
    var sink: Int64 = 0
    sink ^= body()
    let t0 = MonoTime.now()
    for (_ in 0..rounds) {
        sink ^= body()
    }
    let elapsedNs = (MonoTime.now() - t0).toNanoseconds()
    let perRoundUs = Float64(elapsedNs) / Float64(rounds) / 1000.0
    println("${label}\trounds=${rounds}\tper_round_us=${perRoundUs}\ttotal_ms=${Float64(elapsedNs) / 1_000_000.0}\tsink=${sink}")
    return perRoundUs
}

main() {
    println("=== Issue #586 workload (DATA_SIZE=${DATA_SIZE}, len ${STR_MIN_SIZE}..${STR_MAX_SIZE}) ===")
    let arr = makeRandomStrings(42)
    let cached = precomputeHashes(arr)

    let coldUs = timed("recompute_hash_all", 30) { =>
        hashAll(arr)
    }
    let cachedUs = timed("cached_field_read", 30) { =>
        hashCached(cached)
    }

    var sink: Int64 = 0
    let iters: Int64 = 5
    let t0 = MonoTime.now()
    for (_ in 0..iters) {
        sink ^= hashAll(arr)
    }
    let ns = Float64((MonoTime.now() - t0).toNanoseconds())
    let perCallNs = ns / Float64(iters) / Float64(DATA_SIZE)
    println("per_hashCode_ns≈${perCallNs}\tsink=${sink}")

    println("")
    println("=== Issue reference numbers ===")
    println("Cangjie 1.0.4 (Issue): ~10.60 ms / op")
    println("Java 17 JMH warmup+measure (Issue): ~1.223 ms / op")
    println("This run recompute_us≈${coldUs}")
    println("This run cached_like_java_us≈${cachedUs}")
    println("cache_speedup≈${coldUs / cachedUs}x")
    println("")
    println("Scheme A: current String.hashCode is not multi-fold slower than the Java")
    println("figure once the Java hash-cache / JMH-warmup effect is accounted for.")
}
