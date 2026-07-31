/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

import std.collection.*

var failures: Int64 = 0
var passed: Int64 = 0

func check(name: String, cond: Bool): Unit {
    if (cond) {
        passed++
    } else {
        failures++
        println("FAIL: ${name}")
    }
}

func checkEqual(name: String, actual: Int64, expected: Int64): Unit {
    check(name, actual == expected)
    if (actual != expected) {
        println("  expected=${expected}, actual=${actual}")
    }
}

/* Remove on an empty tree must return None and keep size 0. */
func testRemoveOnEmpty(): Unit {
    let map = TreeMap<Int64, Int64>()
    check("removeOnEmpty returns None", map.remove(1).isNone())
    checkEqual("removeOnEmpty size", map.size, 0)
    check("removeOnEmpty isEmpty", map.isEmpty())
}

/* Removing a key that was never inserted returns None without side effects. */
func testRemoveMissingKey(): Unit {
    let map = TreeMap<Int64, Int64>()
    for (i in 0..10) {
        map.add(i, i * 10)
    }
    let before = map.size
    check("removeMissing returns None", map.remove(100).isNone())
    check("removeMissing returns None 2", map.remove(-1).isNone())
    checkEqual("removeMissing size unchanged", map.size, before)
    check("removeMissing contains still true", map.contains(5))
}

/* Single element add/remove cycle collapses the tree back to empty. */
func testRemoveSingleNode(): Unit {
    let map = TreeMap<Int64, Int64>()
    map.add(42, 100)
    checkEqual("singleNode size before", map.size, 1)
    let removed = map.remove(42)
    check("singleNode removed value", removed == Option<Int64>.Some(100))
    checkEqual("singleNode size after", map.size, 0)
    check("singleNode isEmpty", map.isEmpty())
    check("singleNode get returns None", map.get(42).isNone())
}

/* Sequentially remove every element and confirm the tree drains to empty. */
func testRemoveAllSequential(): Unit {
    let map = TreeMap<Int64, Int64>()
    let n = 1000
    for (i in 0..n) {
        map.add(i, i)
    }
    checkEqual("removeAll size before", map.size, n)
    for (i in 0..n) {
        let r = map.remove(i)
        check("removeAll returns old value ${i}", r == Option<Int64>.Some(i))
        check("removeAll get after remove ${i}", map.get(i).isNone())
        check("removeAll contains false ${i}", !map.contains(i))
    }
    checkEqual("removeAll size after", map.size, 0)
    check("removeAll isEmpty", map.isEmpty())
}

/* Remove in reverse order to exercise different predecessor paths. */
func testRemoveAllReverse(): Unit {
    let map = TreeMap<Int64, Int64>()
    let n = 1000
    for (i in 0..n) {
        map.add(i, i * 2)
    }
    for (i in 0..n) {
        let key = n - 1 - i
        let r = map.remove(key)
        check("removeAllReverse returns old value ${key}", r == Option<Int64>.Some(key * 2))
    }
    checkEqual("removeAllReverse size after", map.size, 0)
    check("removeAllReverse isEmpty", map.isEmpty())
}

/* Remove in a permuted order to stress non-leaf rebalancing. */
func testRemoveAllPermuted(): Unit {
    let map = TreeMap<Int64, Int64>()
    let n = 2000
    for (i in 0..n) {
        let key = (i * 48271) % n
        map.add(key, key)
    }
    checkEqual("removeAllPermuted size before", map.size, n)
    for (i in 0..n) {
        let key = (i * 48271) % n
        let r = map.remove(key)
        check("removeAllPermuted returns old value ${key}", r == Option<Int64>.Some(key))
        check("removeAllPermuted get None ${key}", map.get(key).isNone())
    }
    checkEqual("removeAllPermuted size after", map.size, 0)
    check("removeAllPermuted isEmpty", map.isEmpty())
}

/* After partial removal the surviving entries must stay ordered and reachable. */
func testRemoveThenIterate(): Unit {
    let map = TreeMap<Int64, Int64>()
    let n = 500
    for (i in 0..n) {
        map.add(i, i)
    }
    // Remove all even keys.
    for (i in 0..n) {
        if (i % 2 == 0) {
            map.remove(i)
        }
    }
    checkEqual("removeThenIterate surviving count", map.size, n / 2)
    var prev: Int64 = -1
    var count: Int64 = 0
    for ((k, _) in map) {
        check("removeThenIterate ascending order", k > prev)
        check("removeThenIterate only odd keys", k % 2 == 1)
        prev = k
        count++
    }
    checkEqual("removeThenIterate iterated count", count, n / 2)
}

/* Add must overwrite the existing value and keep the size unchanged. */
func testAddOverwrite(): Unit {
    let map = TreeMap<Int64, Int64>()
    check("addOverwrite first add None", map.add(1, 10).isNone())
    let old = map.add(1, 20)
    check("addOverwrite returns old value", old == Option<Int64>.Some(10))
    checkEqual("addOverwrite size", map.size, 1)
    check("addOverwrite get new value", map.get(1) == Option<Int64>.Some(20))
}

/* After deleting everything, re-adding must produce a usable tree. */
func testRemoveAllThenReadd(): Unit {
    let map = TreeMap<Int64, Int64>()
    let n = 300
    for (i in 0..n) {
        map.add(i, i)
    }
    for (i in 0..n) {
        map.remove(i)
    }
    check("removeAllThenReadd empty", map.isEmpty())
    for (i in 0..n) {
        map.add(i, i + 1)
    }
    checkEqual("removeAllThenReadd size", map.size, n)
    for (i in 0..n) {
        check("removeAllThenReadd get ${i}", map.get(i) == Option<Int64>.Some(i + 1))
    }
}

/* removeFirst / removeLast must return the extreme key and shrink the tree. */
func testRemoveFirstLast(): Unit {
    let map = TreeMap<Int64, Int64>()
    let n = 200
    for (i in 0..n) {
        map.add(i, i)
    }
    let first = map.removeFirst()
    match (first) {
        case Some((k, v)) =>
            check("removeFirst key", k == 0)
            check("removeFirst value", v == 0)
        case None => check("removeFirst Some", false)
    }
    checkEqual("removeFirst size after", map.size, n - 1)
    let last = map.removeLast()
    match (last) {
        case Some((k, v)) =>
            check("removeLast key", k == n - 1)
            check("removeLast value", v == n - 1)
        case None => check("removeLast Some", false)
    }
    checkEqual("removeLast size after", map.size, n - 2)
}

/* removeIf must delete exactly the entries matching the predicate. */
func testRemoveIf(): Unit {
    let map = TreeMap<Int64, Int64>()
    let n = 100
    for (i in 0..n) {
        map.add(i, i)
    }
    map.removeIf { _, v =>
        v % 3 == 0
    }
    var surviving = 0
    for (i in 0..n) {
        if (map.contains(i)) {
            surviving++
            check("removeIf keeps non-multiple-of-3", i % 3 != 0)
        }
    }
    checkEqual("removeIf surviving count", surviving, n - n / 3 - 1)
}

/* get on missing keys must not throw and must return None. */
func testGetMissing(): Unit {
    let map = TreeMap<Int64, Int64>()
    for (i in 0..50) {
        map.add(i * 2, i)
    }
    for (i in 0..50) {
        check("getMissing odd key None", map.get(i * 2 + 1).isNone())
        check("getMissing even key Some", map.get(i * 2) == Option<Int64>.Some(i))
    }
}

main(): Int64 {
    testRemoveOnEmpty()
    testRemoveMissingKey()
    testRemoveSingleNode()
    testRemoveAllSequential()
    testRemoveAllReverse()
    testRemoveAllPermuted()
    testRemoveThenIterate()
    testAddOverwrite()
    testRemoveAllThenReadd()
    testRemoveFirstLast()
    testRemoveIf()
    testGetMissing()

    println("TreeMap functional test: passed=${passed}, failures=${failures}")
    if (failures > 0) {
        return 1
    }
    return 0
}
