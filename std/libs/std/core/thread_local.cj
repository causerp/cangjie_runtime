/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.core

class ThreadLocalKey <: Hashable {
    // Magic number for Fibonacci Hashing
    // The value is (2^64) / (1 - 0.618)
    static const ALPHA = 0x61c8864680b583eb
    static let CURR = AtomicInt64(0)
    static func nextHash(): Int64 {
        return CURR.fetchAdd(ALPHA)
    }

    let code: Int64 = nextHash()

    func equals(another: ThreadLocalKey): Bool {
        return code == another.hashCode()
    }

    public func hashCode(): Int64 {
        return code
    }
}

let EMPTY_KEY = ThreadLocalKey()
let DELETED_KEY = ThreadLocalKey()

/**
 * ThreadLocal is used to provide thread-local variables.
 */
public class ThreadLocal<T> {
    let key: ThreadLocalKey = ThreadLocalKey()

    /**
     * Return the value of this thread-local variable in the current thread.
     */
    public func get(): ?T {
        let map: ThreadLocalMap = getThreadLocalMap()
        return map.get(tlKey: key)
    }

    /**
     * Set the current thread's thread-local variable with the value parameter.
     * If None is passed as the parameter, the value of this thread-local variable
     * will be removed from the current thread.
     */
    public func set(value: ?T): Unit {
        let map: ThreadLocalMap = getThreadLocalMap()
        match (value) {
            case Some(v) => map.set(tlKey: key, value: v)
            case None => map.remove(tlKey: key)
        }
    }
}

func getThreadLocalMap(): ThreadLocalMap {
    return match (Thread.currentThread._threadLocalMap) {
        case Some(map) => map
        case None =>
            let map = ThreadLocalMap()
            Thread.currentThread._threadLocalMap = map
            map
    }
}

struct Entry {
    let tlKey: ThreadLocalKey
    let boxedValue: Object

    init(k: ThreadLocalKey, v: Object) {
        tlKey = k
        boxedValue = v
    }

    func isValid(): Bool {
        return !tlKey.equals(EMPTY_KEY) && !tlKey.equals(DELETED_KEY)
    }
}

let EMPTY_ENTRY = Entry(EMPTY_KEY, EMPTY_KEY)
let DELETED_ENTRY = Entry(DELETED_KEY, DELETED_KEY)

class ThreadLocalMap {
    private static let DEFAULT_CAPACITY: Int64 = 16

    var entries: Array<Entry>
    var size: Int64 = 0

    init() {
        entries = Array<Entry>(DEFAULT_CAPACITY, repeat: EMPTY_ENTRY)
    }

    func get<T>(tlKey!: ThreadLocalKey): Option<T> {
        return match (findEntry(tlKey)) {
            case Some(index) => (entries[index].boxedValue as Box<T>).getOrThrow() // Unwrap Option<Box<T>>
                .value // Get value from Box<T>
            case None => None
        }
    }

    func set<T>(tlKey!: ThreadLocalKey, value!: T): Unit {
        let index = findIndexToInsert(tlKey, entries)
        if (entries[index].tlKey.equals(EMPTY_ENTRY.tlKey)) {
            size += 1
        }
        entries[index] = Entry(tlKey, Box<T>(value))
        if (needResize()) {
            resize()
        }
    }

    func remove(tlKey!: ThreadLocalKey): Unit {
        if (let Some(index) <- findEntry(tlKey)) {
            entries[index] = DELETED_ENTRY
        }
    }

    // ============= Auxiliary methods ==================

    // ------------- Find entry -------------------------
    private func findEntry(tlKey: ThreadLocalKey): Option<Int64> {
        var index = tlKey.hashCode() & (entries.size - 1) // Compute the starting index
        while (true) { // Linear probing entries until
            let entry = entries[index]
            if (entry.tlKey.equals(EMPTY_ENTRY.tlKey)) { // Case 1: the target non-exists
                return None
            }
            if (tlKey.equals(entry.tlKey)) { // Case 2: find the target
                return Some(index)
            } else {
                index = (index + 1) & (entries.size - 1) // Move index forward
            }
        }
        return None // Unreachable
    }

    private func findIndexToInsert(tlKey: ThreadLocalKey, arr: Array<Entry>): Int64 {
        var index = tlKey.hashCode() & (arr.size - 1) // Compute the starting index
        while (true) { // Linear probing entries until
            let entry = arr[index]
            if (!entry.isValid()) { // Case 1: the target non-exists
                return index //                return the new location it will insert to
            }
            if (tlKey.equals(entry.tlKey)) { // Case 2: find the target
                return index //                         return the existing index to insert
            } else {
                index = (index + 1) & (arr.size - 1) // Move index forward
            }
        }
        return -1 // Unreachable
    }

    // ------------- Map resize -------------------------
    /**
     * The threshold to resize is at worst 3/4 of the capacity.
     */
    private func needResize(): Bool {
        let threshold = (entries.size * 3) >> 2
        return size > threshold
    }

    /**
     * Double size.
     */
    private func resize(): Unit {
        let newCapacity = entries.size << 1
        let newEntries = Array<Entry>(newCapacity, repeat: EMPTY_ENTRY)

        var validEntryCount = 0

        for (i in 0..entries.size) {
            let entry = entries[i]
            if (entry.isValid()) {
                let index = findIndexToInsert(entry.tlKey, newEntries)
                newEntries[index] = entry
                validEntryCount += 1
            }
        }

        size = validEntryCount
        entries = newEntries
    }
}
