/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

import std.collection.*
import std.time.*

const SIZE: Int64 = 200000
const ROUNDS: Int64 = 5

func permuteKey(i: Int64): Int64 {
    return (i * 48271) % SIZE
}

func buildMap(): TreeMap<Int64, Int64> {
    let map = TreeMap<Int64, Int64>()
    for (i in 0..SIZE) {
        let key = permuteKey(i)
        map.add(key, key)
    }
    return map
}

func measureAdd(): Int64 {
    let map = TreeMap<Int64, Int64>()
    let start = MonoTime.now()
    for (i in 0..SIZE) {
        let key = permuteKey(i)
        map.add(key, key)
    }
    return (MonoTime.now() - start).toNanoseconds()
}

func measureGet(): (Int64, Int64) {
    let map = buildMap()
    var checksum: Int64 = 0
    let start = MonoTime.now()
    for (i in 0..SIZE) {
        let key = permuteKey(i)
        checksum += map.get(key).getOrThrow()
    }
    return ((MonoTime.now() - start).toNanoseconds(), checksum)
}

func measureGetMissing(): (Int64, Int64) {
    let map = buildMap()
    var checksum: Int64 = 0
    let start = MonoTime.now()
    for (i in 0..SIZE) {
        let key = SIZE + permuteKey(i)
        if (map.get(key).isNone()) {
            checksum++
        }
    }
    return ((MonoTime.now() - start).toNanoseconds(), checksum)
}

func measureRemoveExisting(): (Int64, Int64) {
    let map = buildMap()
    var checksum: Int64 = 0
    let start = MonoTime.now()
    for (i in 0..SIZE) {
        let key = permuteKey(i)
        checksum += map.remove(key).getOrThrow()
    }
    return ((MonoTime.now() - start).toNanoseconds(), checksum)
}

func measureRemoveMissing(): (Int64, Int64) {
    let map = buildMap()
    var checksum: Int64 = 0
    let start = MonoTime.now()
    for (i in 0..SIZE) {
        let key = SIZE + permuteKey(i)
        if (map.remove(key).isNone()) {
            checksum++
        }
    }
    return ((MonoTime.now() - start).toNanoseconds(), checksum)
}

func printBest(name: String, bestNs: Int64): Unit {
    println("${name}: total=${bestNs} ns, ns/op=${bestNs / SIZE}")
}

main() {
    measureAdd()
    measureGet()
    measureGetMissing()
    measureRemoveExisting()
    measureRemoveMissing()

    var bestAdd: Int64 = 0
    var bestGet: Int64 = 0
    var bestGetMissing: Int64 = 0
    var bestRemoveExisting: Int64 = 0
    var bestRemoveMissing: Int64 = 0
    var checksum: Int64 = 0

    for (_ in 0..ROUNDS) {
        let addNs = measureAdd()
        let (getNs, getChecksum) = measureGet()
        let (getMissingNs, getMissingChecksum) = measureGetMissing()
        let (removeExistingNs, removeExistingChecksum) = measureRemoveExisting()
        let (removeMissingNs, removeMissingChecksum) = measureRemoveMissing()

        if (bestAdd == 0 || addNs < bestAdd) {
            bestAdd = addNs
        }
        if (bestGet == 0 || getNs < bestGet) {
            bestGet = getNs
        }
        if (bestGetMissing == 0 || getMissingNs < bestGetMissing) {
            bestGetMissing = getMissingNs
        }
        if (bestRemoveExisting == 0 || removeExistingNs < bestRemoveExisting) {
            bestRemoveExisting = removeExistingNs
        }
        if (bestRemoveMissing == 0 || removeMissingNs < bestRemoveMissing) {
            bestRemoveMissing = removeMissingNs
        }
        checksum += getChecksum + getMissingChecksum + removeExistingChecksum + removeMissingChecksum
    }

    println("TreeMap add/get/remove benchmark: size=${SIZE}, rounds=${ROUNDS}")
    printBest("add", bestAdd)
    printBest("get", bestGet)
    printBest("get missing", bestGetMissing)
    printBest("remove existing", bestRemoveExisting)
    printBest("remove missing", bestRemoveMissing)
    println("checksum=${checksum}")
}
