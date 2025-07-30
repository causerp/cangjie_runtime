/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.core

enum MemoryOrder {
    SeqCst
}

@Intrinsic
func load<ATOMIC_TYPE, TYPE>(atomicType: ATOMIC_TYPE, memoryOrder: MemoryOrder): TYPE

@Intrinsic
func store<ATOMIC_TYPE, TYPE>(atomicType: ATOMIC_TYPE, value: TYPE, memoryOrder: MemoryOrder): Unit

@Intrinsic
func fetchAdd<ATOMIC_TYPE, TYPE>(atomicType: ATOMIC_TYPE, value: TYPE, memoryOrder: MemoryOrder): TYPE

@Intrinsic
func compareAndSwap<ATOMIC_TYPE, TYPE>(
    atomicType: ATOMIC_TYPE,
    oldValue: TYPE,
    newValue: TYPE,
    successOrder: MemoryOrder,
    failureOrder: MemoryOrder
): Bool

class AtomicBool {
    private var value: Int8 = 0
    init(val: Bool) {
        var valInt8: Int8 = if (val) {
            1
        } else {
            0
        }
        store<AtomicBool, Int8>(this, valInt8, MemoryOrder.SeqCst)
    }

    func load(): Bool {
        var v = load<AtomicBool, Int8>(this, MemoryOrder.SeqCst)
        return v != 0
    }

    func store(val: Bool): Unit {
        var valInt8: Int8 = if (val) {
            1
        } else {
            0
        }
        store<AtomicBool, Int8>(this, valInt8, MemoryOrder.SeqCst)
    }
}

class AtomicInt64 {
    private var value: Int64

    init(val: Int64) {
        value = val
        store<AtomicInt64, Int64>(this, val, MemoryOrder.SeqCst)
    }

    func fetchAdd(val: Int64): Int64 {
        fetchAdd<AtomicInt64, Int64>(this, val, MemoryOrder.SeqCst)
    }

    func load(): Int64 {
        load<AtomicInt64, Int64>(this, MemoryOrder.SeqCst)
    }

    func store(val: Int64): Unit {
        store<AtomicInt64, Int64>(this, val, MemoryOrder.SeqCst)
    }

    func compareAndSwap(old: Int64, new: Int64): Bool {
        return compareAndSwap<AtomicInt64, Int64>(this, old, new, MemoryOrder.SeqCst, MemoryOrder.SeqCst)
    }
}

class AtomicReference<T> where T <: Object {
    private var value: T

    init(val: T) {
        value = val
        store<AtomicReference<T>, T>(this, val, MemoryOrder.SeqCst)
    }

    func load(): T {
        load<AtomicReference<T>, T>(this, MemoryOrder.SeqCst)
    }

    func store(val: T): Unit {
        store<AtomicReference<T>, T>(this, val, MemoryOrder.SeqCst)
    }
}

/**
 * A wrapper class to atomically load/store values of any types.
 */
class AtomicBox<T> {
    private let boxRef: AtomicReference<Box<T>>

    init(val: T) {
        boxRef = AtomicReference((Box(val)))
    }

    func load(): T {
        boxRef.load().value
    }

    func store(val: T): Unit {
        boxRef.store(Box<T>(val))
    }
}
