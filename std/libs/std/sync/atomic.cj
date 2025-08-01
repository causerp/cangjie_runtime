/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.sync

/**
 * Don't edit this, or the order should be the same as C's atomic memory_order.
 */
@Deprecated
public enum MemoryOrder {
    | SeqCst
}

@Deprecated
public let DefaultMemoryOrder: MemoryOrder = MemoryOrder.SeqCst

@Intrinsic
func load<ATOMIC_TYPE, TYPE>(atomicType: ATOMIC_TYPE, memoryOrder: MemoryOrder): TYPE

@Intrinsic
func store<ATOMIC_TYPE, TYPE>(atomicType: ATOMIC_TYPE, value: TYPE, memoryOrder: MemoryOrder): Unit

@Intrinsic
func swap<ATOMIC_TYPE, TYPE>(atomicType: ATOMIC_TYPE, value: TYPE, memoryOrder: MemoryOrder): TYPE

@Intrinsic
func compareAndSwap<ATOMIC_TYPE, TYPE>(
    atomicType: ATOMIC_TYPE,
    oldValue: TYPE,
    newValue: TYPE,
    successOrder: MemoryOrder,
    failureOrder: MemoryOrder
): Bool

@Intrinsic
func fetchAdd<ATOMIC_TYPE, TYPE>(atomicType: ATOMIC_TYPE, value: TYPE, memoryOrder: MemoryOrder): TYPE

@Intrinsic
func fetchSub<ATOMIC_TYPE, TYPE>(atomicType: ATOMIC_TYPE, value: TYPE, memoryOrder: MemoryOrder): TYPE

@Intrinsic
func fetchAnd<ATOMIC_TYPE, TYPE>(atomicType: ATOMIC_TYPE, value: TYPE, memoryOrder: MemoryOrder): TYPE

@Intrinsic
func fetchOr<ATOMIC_TYPE, TYPE>(atomicType: ATOMIC_TYPE, value: TYPE, memoryOrder: MemoryOrder): TYPE

@Intrinsic
func fetchXor<ATOMIC_TYPE, TYPE>(atomicType: ATOMIC_TYPE, value: TYPE, memoryOrder: MemoryOrder): TYPE

// NOTE:
// The APIs of atomic types should have a naming parameter with a default argument,
// like `atomicInt8.load(memoryOrder!: MemoryOrder.SeqCst)`.
// However, most APIs are used with the default argument that will be obtained by
// an extra function and passed to the API call.
// The default argument construction incurs a huge performance overhead compared to the API call.
// So, we split the API with two methods.
//   - A method without the order parameter
//   - A method with a naming parameter

public class AtomicInt8 {
    private var value: Int8

    public init(val: Int8) {
        value = val
        store<AtomicInt8, Int8>(this, val, DefaultMemoryOrder)
    }

    @Frozen
    public func load(): Int8 {
        load<AtomicInt8, Int8>(this, DefaultMemoryOrder)
    }

    @Deprecated[message: "Use `public func load(): Int8` instead."]
    @Frozen
    public func load(memoryOrder!: MemoryOrder): Int8 {
        load<AtomicInt8, Int8>(this, memoryOrder)
    }

    @Frozen
    public func store(val: Int8): Unit {
        store<AtomicInt8, Int8>(this, val, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func store(val: Int8): Unit` instead."]
    public func store(val: Int8, memoryOrder!: MemoryOrder): Unit {
        store<AtomicInt8, Int8>(this, val, memoryOrder)
    }

    @Frozen
    public func swap(val: Int8): Int8 {
        swap<AtomicInt8, Int8>(this, val, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func swap(val: Int8): Int8` instead."]
    public func swap(val: Int8, memoryOrder!: MemoryOrder): Int8 {
        swap<AtomicInt8, Int8>(this, val, memoryOrder)
    }

    @Frozen
    public func compareAndSwap(old: Int8, new: Int8): Bool {
        return compareAndSwap<AtomicInt8, Int8>(this, old, new, DefaultMemoryOrder, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func compareAndSwap(old: Int8, new: Int8): Bool` instead."]
    public func compareAndSwap(old: Int8, new: Int8, successOrder!: MemoryOrder, failureOrder!: MemoryOrder): Bool {
        return compareAndSwap<AtomicInt8, Int8>(this, old, new, successOrder, failureOrder)
    }

    @Frozen
    public func fetchAdd(val: Int8): Int8 {
        fetchAdd<AtomicInt8, Int8>(this, val, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func fetchAdd(val: Int8): Int8` instead."]
    public func fetchAdd(val: Int8, memoryOrder!: MemoryOrder): Int8 {
        fetchAdd<AtomicInt8, Int8>(this, val, memoryOrder)
    }

    @Frozen
    public func fetchSub(val: Int8): Int8 {
        fetchSub<AtomicInt8, Int8>(this, val, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func fetchSub(val: Int8): Int8` instead."]
    public func fetchSub(val: Int8, memoryOrder!: MemoryOrder): Int8 {
        fetchSub<AtomicInt8, Int8>(this, val, memoryOrder)
    }

    @Frozen
    public func fetchAnd(val: Int8): Int8 {
        fetchAnd<AtomicInt8, Int8>(this, val, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func fetchAnd(val: Int8): Int8` instead."]
    public func fetchAnd(val: Int8, memoryOrder!: MemoryOrder): Int8 {
        fetchAnd<AtomicInt8, Int8>(this, val, memoryOrder)
    }

    @Frozen
    public func fetchOr(val: Int8): Int8 {
        fetchOr<AtomicInt8, Int8>(this, val, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func fetchOr(val: Int8): Int8` instead."]
    public func fetchOr(val: Int8, memoryOrder!: MemoryOrder): Int8 {
        fetchOr<AtomicInt8, Int8>(this, val, memoryOrder)
    }

    @Frozen
    public func fetchXor(val: Int8): Int8 {
        fetchXor<AtomicInt8, Int8>(this, val, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func fetchXor(val: Int8): Int8` instead."]
    public func fetchXor(val: Int8, memoryOrder!: MemoryOrder): Int8 {
        fetchXor<AtomicInt8, Int8>(this, val, memoryOrder)
    }
}

public class AtomicInt16 {
    private var value: Int16

    public init(val: Int16) {
        value = val
        store<AtomicInt16, Int16>(this, val, DefaultMemoryOrder)
    }

    @Frozen
    public func load(): Int16 {
        load<AtomicInt16, Int16>(this, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func load(): Int16` instead."]
    public func load(memoryOrder!: MemoryOrder): Int16 {
        load<AtomicInt16, Int16>(this, memoryOrder)
    }

    @Frozen
    public func store(val: Int16): Unit {
        store<AtomicInt16, Int16>(this, val, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func store(val: Int16): Unit` instead."]
    public func store(val: Int16, memoryOrder!: MemoryOrder): Unit {
        store<AtomicInt16, Int16>(this, val, memoryOrder)
    }

    @Frozen
    public func swap(val: Int16): Int16 {
        swap<AtomicInt16, Int16>(this, val, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func swap(val: Int16): Int16` instead."]
    public func swap(val: Int16, memoryOrder!: MemoryOrder): Int16 {
        swap<AtomicInt16, Int16>(this, val, memoryOrder)
    }

    @Frozen
    public func compareAndSwap(old: Int16, new: Int16): Bool {
        return compareAndSwap<AtomicInt16, Int16>(this, old, new, DefaultMemoryOrder, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func compareAndSwap(old: Int16, new: Int16): Bool` instead."]
    public func compareAndSwap(old: Int16, new: Int16, successOrder!: MemoryOrder, failureOrder!: MemoryOrder): Bool {
        return compareAndSwap<AtomicInt16, Int16>(this, old, new, successOrder, failureOrder)
    }

    @Frozen
    public func fetchAdd(val: Int16): Int16 {
        fetchAdd<AtomicInt16, Int16>(this, val, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func fetchAdd(val: Int16): Int16` instead."]
    public func fetchAdd(val: Int16, memoryOrder!: MemoryOrder): Int16 {
        fetchAdd<AtomicInt16, Int16>(this, val, memoryOrder)
    }

    @Frozen
    public func fetchSub(val: Int16): Int16 {
        fetchSub<AtomicInt16, Int16>(this, val, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func fetchSub(val: Int16): Int16` instead."]
    public func fetchSub(val: Int16, memoryOrder!: MemoryOrder): Int16 {
        fetchSub<AtomicInt16, Int16>(this, val, memoryOrder)
    }

    @Frozen
    public func fetchAnd(val: Int16): Int16 {
        fetchAnd<AtomicInt16, Int16>(this, val, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func fetchAnd(val: Int16): Int16` instead."]
    public func fetchAnd(val: Int16, memoryOrder!: MemoryOrder): Int16 {
        fetchAnd<AtomicInt16, Int16>(this, val, memoryOrder)
    }

    @Frozen
    public func fetchOr(val: Int16): Int16 {
        fetchOr<AtomicInt16, Int16>(this, val, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func fetchOr(val: Int16): Int16` instead."]
    public func fetchOr(val: Int16, memoryOrder!: MemoryOrder): Int16 {
        fetchOr<AtomicInt16, Int16>(this, val, memoryOrder)
    }

    @Frozen
    public func fetchXor(val: Int16): Int16 {
        fetchXor<AtomicInt16, Int16>(this, val, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func fetchXor(val: Int16): Int16` instead."]
    public func fetchXor(val: Int16, memoryOrder!: MemoryOrder): Int16 {
        fetchXor<AtomicInt16, Int16>(this, val, memoryOrder)
    }
}

public class AtomicInt32 {
    private var value: Int32

    public init(val: Int32) {
        value = val
        store<AtomicInt32, Int32>(this, val, DefaultMemoryOrder)
    }

    @Frozen
    public func load(): Int32 {
        load<AtomicInt32, Int32>(this, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func load(): Int32` instead."]
    public func load(memoryOrder!: MemoryOrder): Int32 {
        load<AtomicInt32, Int32>(this, memoryOrder)
    }

    @Frozen
    public func store(val: Int32): Unit {
        store<AtomicInt32, Int32>(this, val, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func store(val: Int32): Unit` instead."]
    public func store(val: Int32, memoryOrder!: MemoryOrder): Unit {
        store<AtomicInt32, Int32>(this, val, memoryOrder)
    }

    @Frozen
    public func swap(val: Int32): Int32 {
        swap<AtomicInt32, Int32>(this, val, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func swap(val: Int32): Int32` instead."]
    public func swap(val: Int32, memoryOrder!: MemoryOrder): Int32 {
        swap<AtomicInt32, Int32>(this, val, memoryOrder)
    }

    @Frozen
    public func compareAndSwap(old: Int32, new: Int32): Bool {
        return compareAndSwap<AtomicInt32, Int32>(this, old, new, DefaultMemoryOrder, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func compareAndSwap(old: Int32, new: Int32): Bool` instead."]
    public func compareAndSwap(old: Int32, new: Int32, successOrder!: MemoryOrder, failureOrder!: MemoryOrder): Bool {
        return compareAndSwap<AtomicInt32, Int32>(this, old, new, successOrder, failureOrder)
    }

    @Frozen
    public func fetchAdd(val: Int32): Int32 {
        fetchAdd<AtomicInt32, Int32>(this, val, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func fetchAdd(val: Int32): Int32` instead."]
    public func fetchAdd(val: Int32, memoryOrder!: MemoryOrder): Int32 {
        fetchAdd<AtomicInt32, Int32>(this, val, memoryOrder)
    }

    @Frozen
    public func fetchSub(val: Int32): Int32 {
        fetchSub<AtomicInt32, Int32>(this, val, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func fetchSub(val: Int32): Int32` instead."]
    public func fetchSub(val: Int32, memoryOrder!: MemoryOrder): Int32 {
        fetchSub<AtomicInt32, Int32>(this, val, memoryOrder)
    }

    @Frozen
    public func fetchAnd(val: Int32): Int32 {
        fetchAnd<AtomicInt32, Int32>(this, val, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func fetchAnd(val: Int32): Int32` instead."]
    public func fetchAnd(val: Int32, memoryOrder!: MemoryOrder): Int32 {
        fetchAnd<AtomicInt32, Int32>(this, val, memoryOrder)
    }

    @Frozen
    public func fetchOr(val: Int32): Int32 {
        fetchOr<AtomicInt32, Int32>(this, val, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func fetchOr(val: Int32): Int32` instead."]
    public func fetchOr(val: Int32, memoryOrder!: MemoryOrder): Int32 {
        fetchOr<AtomicInt32, Int32>(this, val, memoryOrder)
    }

    @Frozen
    public func fetchXor(val: Int32): Int32 {
        fetchXor<AtomicInt32, Int32>(this, val, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func fetchXor(val: Int32): Int32` instead."]
    public func fetchXor(val: Int32, memoryOrder!: MemoryOrder): Int32 {
        fetchXor<AtomicInt32, Int32>(this, val, memoryOrder)
    }
}

public class AtomicInt64 {
    private var value: Int64

    public init(val: Int64) {
        value = val
        store<AtomicInt64, Int64>(this, val, DefaultMemoryOrder)
    }

    @Frozen
    public func load(): Int64 {
        load<AtomicInt64, Int64>(this, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func load(): Int64` instead."]
    public func load(memoryOrder!: MemoryOrder): Int64 {
        load<AtomicInt64, Int64>(this, memoryOrder)
    }

    @Frozen
    public func store(val: Int64): Unit {
        store<AtomicInt64, Int64>(this, val, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func store(val: Int64): Unit` instead."]
    public func store(val: Int64, memoryOrder!: MemoryOrder): Unit {
        store<AtomicInt64, Int64>(this, val, memoryOrder)
    }

    @Frozen
    public func swap(val: Int64): Int64 {
        swap<AtomicInt64, Int64>(this, val, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func swap(val: Int64): Int64` instead."]
    public func swap(val: Int64, memoryOrder!: MemoryOrder): Int64 {
        swap<AtomicInt64, Int64>(this, val, memoryOrder)
    }

    @Frozen
    public func compareAndSwap(old: Int64, new: Int64): Bool {
        return compareAndSwap<AtomicInt64, Int64>(this, old, new, DefaultMemoryOrder, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func compareAndSwap(old: Int64, new: Int64): Bool` instead."]
    public func compareAndSwap(old: Int64, new: Int64, successOrder!: MemoryOrder, failureOrder!: MemoryOrder): Bool {
        return compareAndSwap<AtomicInt64, Int64>(this, old, new, successOrder, failureOrder)
    }

    @Frozen
    public func fetchAdd(val: Int64): Int64 {
        fetchAdd<AtomicInt64, Int64>(this, val, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func fetchAdd(val: Int64): Int64` instead."]
    public func fetchAdd(val: Int64, memoryOrder!: MemoryOrder): Int64 {
        fetchAdd<AtomicInt64, Int64>(this, val, memoryOrder)
    }

    @Frozen
    public func fetchSub(val: Int64): Int64 {
        fetchSub<AtomicInt64, Int64>(this, val, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func fetchSub(val: Int64): Int64` instead."]
    public func fetchSub(val: Int64, memoryOrder!: MemoryOrder): Int64 {
        fetchSub<AtomicInt64, Int64>(this, val, memoryOrder)
    }

    @Frozen
    public func fetchAnd(val: Int64): Int64 {
        fetchAnd<AtomicInt64, Int64>(this, val, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func fetchAnd(val: Int64): Int64` instead."]
    public func fetchAnd(val: Int64, memoryOrder!: MemoryOrder): Int64 {
        fetchAnd<AtomicInt64, Int64>(this, val, memoryOrder)
    }

    @Frozen
    public func fetchOr(val: Int64): Int64 {
        fetchOr<AtomicInt64, Int64>(this, val, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func fetchOr(val: Int64): Int64` instead."]
    public func fetchOr(val: Int64, memoryOrder!: MemoryOrder): Int64 {
        fetchOr<AtomicInt64, Int64>(this, val, memoryOrder)
    }

    @Frozen
    public func fetchXor(val: Int64): Int64 {
        fetchXor<AtomicInt64, Int64>(this, val, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func fetchXor(val: Int64): Int64` instead."]
    public func fetchXor(val: Int64, memoryOrder!: MemoryOrder): Int64 {
        fetchXor<AtomicInt64, Int64>(this, val, memoryOrder)
    }
}

public class AtomicUInt8 {
    private var value: UInt8

    public init(val: UInt8) {
        value = val
        store<AtomicUInt8, UInt8>(this, val, DefaultMemoryOrder)
    }

    @Frozen
    public func load(): UInt8 {
        load<AtomicUInt8, UInt8>(this, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func load(): UInt8` instead."]
    public func load(memoryOrder!: MemoryOrder): UInt8 {
        load<AtomicUInt8, UInt8>(this, memoryOrder)
    }

    @Frozen
    public func store(val: UInt8): Unit {
        store<AtomicUInt8, UInt8>(this, val, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func store(val: UInt8): Unit` instead."]
    public func store(val: UInt8, memoryOrder!: MemoryOrder): Unit {
        store<AtomicUInt8, UInt8>(this, val, memoryOrder)
    }

    @Frozen
    public func swap(val: UInt8): UInt8 {
        swap<AtomicUInt8, UInt8>(this, val, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func swap(val: UInt8): UInt8` instead."]
    public func swap(val: UInt8, memoryOrder!: MemoryOrder): UInt8 {
        swap<AtomicUInt8, UInt8>(this, val, memoryOrder)
    }

    @Frozen
    public func compareAndSwap(old: UInt8, new: UInt8): Bool {
        return compareAndSwap<AtomicUInt8, UInt8>(this, old, new, DefaultMemoryOrder, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func compareAndSwap(old: UInt8, new: UInt8): Bool` instead."]
    public func compareAndSwap(old: UInt8, new: UInt8, successOrder!: MemoryOrder, failureOrder!: MemoryOrder): Bool {
        return compareAndSwap<AtomicUInt8, UInt8>(this, old, new, successOrder, failureOrder)
    }

    @Frozen
    public func fetchAdd(val: UInt8): UInt8 {
        fetchAdd<AtomicUInt8, UInt8>(this, val, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func fetchAdd(val: UInt8): UInt8` instead."]
    public func fetchAdd(val: UInt8, memoryOrder!: MemoryOrder): UInt8 {
        fetchAdd<AtomicUInt8, UInt8>(this, val, memoryOrder)
    }

    @Frozen
    public func fetchSub(val: UInt8): UInt8 {
        fetchSub<AtomicUInt8, UInt8>(this, val, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func fetchSub(val: UInt8): UInt8` instead."]
    public func fetchSub(val: UInt8, memoryOrder!: MemoryOrder): UInt8 {
        fetchSub<AtomicUInt8, UInt8>(this, val, memoryOrder)
    }

    @Frozen
    public func fetchAnd(val: UInt8): UInt8 {
        fetchAnd<AtomicUInt8, UInt8>(this, val, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func fetchAnd(val: UInt8): UInt8` instead."]
    public func fetchAnd(val: UInt8, memoryOrder!: MemoryOrder): UInt8 {
        fetchAnd<AtomicUInt8, UInt8>(this, val, memoryOrder)
    }

    @Frozen
    public func fetchOr(val: UInt8): UInt8 {
        fetchOr<AtomicUInt8, UInt8>(this, val, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func fetchOr(val: UInt8): UInt8` instead."]
    public func fetchOr(val: UInt8, memoryOrder!: MemoryOrder): UInt8 {
        fetchOr<AtomicUInt8, UInt8>(this, val, memoryOrder)
    }

    @Frozen
    public func fetchXor(val: UInt8): UInt8 {
        fetchXor<AtomicUInt8, UInt8>(this, val, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func fetchXor(val: UInt8): UInt8` instead."]
    public func fetchXor(val: UInt8, memoryOrder!: MemoryOrder): UInt8 {
        fetchXor<AtomicUInt8, UInt8>(this, val, memoryOrder)
    }
}

public class AtomicUInt16 {
    private var value: UInt16

    public init(val: UInt16) {
        value = val
        store<AtomicUInt16, UInt16>(this, val, DefaultMemoryOrder)
    }

    @Frozen
    public func load(): UInt16 {
        load<AtomicUInt16, UInt16>(this, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func load(): UInt16` instead."]
    public func load(memoryOrder!: MemoryOrder): UInt16 {
        load<AtomicUInt16, UInt16>(this, memoryOrder)
    }

    @Frozen
    public func store(val: UInt16): Unit {
        store<AtomicUInt16, UInt16>(this, val, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func store(val: UInt16): Unit` instead."]
    public func store(val: UInt16, memoryOrder!: MemoryOrder): Unit {
        store<AtomicUInt16, UInt16>(this, val, memoryOrder)
    }

    @Frozen
    public func swap(val: UInt16): UInt16 {
        swap<AtomicUInt16, UInt16>(this, val, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func swap(val: UInt16): UInt16` instead."]
    public func swap(val: UInt16, memoryOrder!: MemoryOrder): UInt16 {
        swap<AtomicUInt16, UInt16>(this, val, memoryOrder)
    }

    @Frozen
    public func compareAndSwap(old: UInt16, new: UInt16): Bool {
        return compareAndSwap<AtomicUInt16, UInt16>(this, old, new, DefaultMemoryOrder, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func compareAndSwap(old: UInt16, new: UInt16): Bool` instead."]
    public func compareAndSwap(old: UInt16, new: UInt16, successOrder!: MemoryOrder, failureOrder!: MemoryOrder): Bool {
        return compareAndSwap<AtomicUInt16, UInt16>(this, old, new, successOrder, failureOrder)
    }

    @Frozen
    public func fetchAdd(val: UInt16): UInt16 {
        fetchAdd<AtomicUInt16, UInt16>(this, val, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func fetchAdd(val: UInt16): UInt16` instead."]
    public func fetchAdd(val: UInt16, memoryOrder!: MemoryOrder): UInt16 {
        fetchAdd<AtomicUInt16, UInt16>(this, val, memoryOrder)
    }

    @Frozen
    public func fetchSub(val: UInt16): UInt16 {
        fetchSub<AtomicUInt16, UInt16>(this, val, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func fetchSub(val: UInt16): UInt16` instead."]
    public func fetchSub(val: UInt16, memoryOrder!: MemoryOrder): UInt16 {
        fetchSub<AtomicUInt16, UInt16>(this, val, memoryOrder)
    }

    @Frozen
    public func fetchAnd(val: UInt16): UInt16 {
        fetchAnd<AtomicUInt16, UInt16>(this, val, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func fetchAnd(val: UInt16): UInt16` instead."]
    public func fetchAnd(val: UInt16, memoryOrder!: MemoryOrder): UInt16 {
        fetchAnd<AtomicUInt16, UInt16>(this, val, memoryOrder)
    }

    @Frozen
    public func fetchOr(val: UInt16): UInt16 {
        fetchOr<AtomicUInt16, UInt16>(this, val, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func fetchOr(val: UInt16): UInt16` instead."]
    public func fetchOr(val: UInt16, memoryOrder!: MemoryOrder): UInt16 {
        fetchOr<AtomicUInt16, UInt16>(this, val, memoryOrder)
    }

    @Frozen
    public func fetchXor(val: UInt16): UInt16 {
        fetchXor<AtomicUInt16, UInt16>(this, val, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func fetchXor(val: UInt16): UInt16` instead."]
    public func fetchXor(val: UInt16, memoryOrder!: MemoryOrder): UInt16 {
        fetchXor<AtomicUInt16, UInt16>(this, val, memoryOrder)
    }
}

public class AtomicUInt32 {
    private var value: UInt32

    public init(val: UInt32) {
        value = val
        store<AtomicUInt32, UInt32>(this, val, DefaultMemoryOrder)
    }

    @Frozen
    public func load(): UInt32 {
        load<AtomicUInt32, UInt32>(this, DefaultMemoryOrder)
    }

    @Deprecated[message: "Use `public func load(): UInt32` instead."]
    @Frozen
    public func load(memoryOrder!: MemoryOrder): UInt32 {
        load<AtomicUInt32, UInt32>(this, memoryOrder)
    }

    @Frozen
    public func store(val: UInt32): Unit {
        store<AtomicUInt32, UInt32>(this, val, DefaultMemoryOrder)
    }

    @Deprecated[message: "Use `public func store(val: UInt32): Unit` instead."]
    @Frozen
    public func store(val: UInt32, memoryOrder!: MemoryOrder): Unit {
        store<AtomicUInt32, UInt32>(this, val, memoryOrder)
    }

    @Frozen
    public func swap(val: UInt32): UInt32 {
        swap<AtomicUInt32, UInt32>(this, val, DefaultMemoryOrder)
    }

    @Deprecated[message: "Use `public func swap(val: UInt32): UInt32` instead."]
    @Frozen
    public func swap(val: UInt32, memoryOrder!: MemoryOrder): UInt32 {
        swap<AtomicUInt32, UInt32>(this, val, memoryOrder)
    }

    @Frozen
    public func compareAndSwap(old: UInt32, new: UInt32): Bool {
        return compareAndSwap<AtomicUInt32, UInt32>(this, old, new, DefaultMemoryOrder, DefaultMemoryOrder)
    }

    @Deprecated[message: "Use `public func compareAndSwap(old: UInt32, new: UInt32): Bool` instead."]
    @Frozen
    public func compareAndSwap(old: UInt32, new: UInt32, successOrder!: MemoryOrder, failureOrder!: MemoryOrder): Bool {
        return compareAndSwap<AtomicUInt32, UInt32>(this, old, new, successOrder, failureOrder)
    }

    @Frozen
    public func fetchAdd(val: UInt32): UInt32 {
        fetchAdd<AtomicUInt32, UInt32>(this, val, DefaultMemoryOrder)
    }

    @Deprecated[message: "Use `public func fetchAdd(val: UInt32): UInt32` instead."]
    @Frozen
    public func fetchAdd(val: UInt32, memoryOrder!: MemoryOrder): UInt32 {
        fetchAdd<AtomicUInt32, UInt32>(this, val, memoryOrder)
    }

    @Frozen
    public func fetchSub(val: UInt32): UInt32 {
        fetchSub<AtomicUInt32, UInt32>(this, val, DefaultMemoryOrder)
    }

    @Deprecated[message: "Use `public func fetchSub(val: UInt32): UInt32` instead."]
    @Frozen
    public func fetchSub(val: UInt32, memoryOrder!: MemoryOrder): UInt32 {
        fetchSub<AtomicUInt32, UInt32>(this, val, memoryOrder)
    }

    @Frozen
    public func fetchAnd(val: UInt32): UInt32 {
        fetchAnd<AtomicUInt32, UInt32>(this, val, DefaultMemoryOrder)
    }

    @Deprecated[message: "Use `public func fetchAnd(val: UInt32): UInt32` instead."]
    @Frozen
    public func fetchAnd(val: UInt32, memoryOrder!: MemoryOrder): UInt32 {
        fetchAnd<AtomicUInt32, UInt32>(this, val, memoryOrder)
    }

    @Frozen
    public func fetchOr(val: UInt32): UInt32 {
        fetchOr<AtomicUInt32, UInt32>(this, val, DefaultMemoryOrder)
    }

    @Deprecated[message: "Use `public func fetchOr(val: UInt32): UInt32` instead."]
    @Frozen
    public func fetchOr(val: UInt32, memoryOrder!: MemoryOrder): UInt32 {
        fetchOr<AtomicUInt32, UInt32>(this, val, memoryOrder)
    }

    @Frozen
    public func fetchXor(val: UInt32): UInt32 {
        fetchXor<AtomicUInt32, UInt32>(this, val, DefaultMemoryOrder)
    }

    @Deprecated[message: "Use `public func fetchXor(val: UInt32): UInt32` instead."]
    @Frozen
    public func fetchXor(val: UInt32, memoryOrder!: MemoryOrder): UInt32 {
        fetchXor<AtomicUInt32, UInt32>(this, val, memoryOrder)
    }
}

public class AtomicUInt64 {
    private var value: UInt64

    public init(val: UInt64) {
        value = val
        store<AtomicUInt64, UInt64>(this, val, DefaultMemoryOrder)
    }

    @Frozen
    public func load(): UInt64 {
        load<AtomicUInt64, UInt64>(this, DefaultMemoryOrder)
    }

    @Deprecated[message: "Use `public func load(): UInt64` instead."]
    @Frozen
    public func load(memoryOrder!: MemoryOrder): UInt64 {
        load<AtomicUInt64, UInt64>(this, memoryOrder)
    }

    @Frozen
    public func store(val: UInt64): Unit {
        store<AtomicUInt64, UInt64>(this, val, DefaultMemoryOrder)
    }

    @Deprecated[message: "Use `public func store(val: UInt64): Unit` instead."]
    @Frozen
    public func store(val: UInt64, memoryOrder!: MemoryOrder): Unit {
        store<AtomicUInt64, UInt64>(this, val, memoryOrder)
    }

    @Frozen
    public func swap(val: UInt64): UInt64 {
        swap<AtomicUInt64, UInt64>(this, val, DefaultMemoryOrder)
    }

    @Deprecated[message: "Use `public func swap(val: UInt64): UInt64` instead."]
    @Frozen
    public func swap(val: UInt64, memoryOrder!: MemoryOrder): UInt64 {
        swap<AtomicUInt64, UInt64>(this, val, memoryOrder)
    }

    @Frozen
    public func compareAndSwap(old: UInt64, new: UInt64): Bool {
        return compareAndSwap<AtomicUInt64, UInt64>(this, old, new, DefaultMemoryOrder, DefaultMemoryOrder)
    }

    @Deprecated[message: "Use `public func compareAndSwap(old: UInt64, new: UInt64): Bool` instead."]
    @Frozen
    public func compareAndSwap(old: UInt64, new: UInt64, successOrder!: MemoryOrder, failureOrder!: MemoryOrder): Bool {
        return compareAndSwap<AtomicUInt64, UInt64>(this, old, new, successOrder, failureOrder)
    }

    @Frozen
    public func fetchAdd(val: UInt64): UInt64 {
        fetchAdd<AtomicUInt64, UInt64>(this, val, DefaultMemoryOrder)
    }

    @Deprecated[message: "Use `public func fetchAdd(val: UInt64): UInt64` instead."]
    @Frozen
    public func fetchAdd(val: UInt64, memoryOrder!: MemoryOrder): UInt64 {
        fetchAdd<AtomicUInt64, UInt64>(this, val, memoryOrder)
    }

    @Frozen
    public func fetchSub(val: UInt64): UInt64 {
        fetchSub<AtomicUInt64, UInt64>(this, val, DefaultMemoryOrder)
    }

    @Deprecated[message: "Use `public func fetchSub(val: UInt64): UInt64` instead."]
    @Frozen
    public func fetchSub(val: UInt64, memoryOrder!: MemoryOrder): UInt64 {
        fetchSub<AtomicUInt64, UInt64>(this, val, memoryOrder)
    }

    @Frozen
    public func fetchAnd(val: UInt64): UInt64 {
        fetchAnd<AtomicUInt64, UInt64>(this, val, DefaultMemoryOrder)
    }

    @Deprecated[message: "Use `public func fetchAnd(val: UInt64): UInt64` instead."]
    @Frozen
    public func fetchAnd(val: UInt64, memoryOrder!: MemoryOrder): UInt64 {
        fetchAnd<AtomicUInt64, UInt64>(this, val, memoryOrder)
    }

    @Frozen
    public func fetchOr(val: UInt64): UInt64 {
        fetchOr<AtomicUInt64, UInt64>(this, val, DefaultMemoryOrder)
    }

    @Deprecated[message: "Use `public func fetchOr(val: UInt64): UInt64` instead."]
    @Frozen
    public func fetchOr(val: UInt64, memoryOrder!: MemoryOrder): UInt64 {
        fetchOr<AtomicUInt64, UInt64>(this, val, memoryOrder)
    }

    @Frozen
    public func fetchXor(val: UInt64): UInt64 {
        fetchXor<AtomicUInt64, UInt64>(this, val, DefaultMemoryOrder)
    }

    @Deprecated[message: "Use `public func fetchXor(val: UInt64): UInt64` instead."]
    @Frozen
    public func fetchXor(val: UInt64, memoryOrder!: MemoryOrder): UInt64 {
        fetchXor<AtomicUInt64, UInt64>(this, val, memoryOrder)
    }
}

public class AtomicBool {
    private var value: Int8 = 0
    public init(val: Bool) {
        var valInt8 = transBoolToInt8(val)
        store<AtomicBool, Int8>(this, valInt8, DefaultMemoryOrder)
    }

    @Frozen
    public func load(): Bool {
        var v = load<AtomicBool, Int8>(this, DefaultMemoryOrder)
        return transInt8ToBool(v)
    }

    @Deprecated[message: "Use `public func load(): Bool` instead."]
    @Frozen
    public func load(memoryOrder!: MemoryOrder): Bool {
        var v = load<AtomicBool, Int8>(this, memoryOrder)
        return transInt8ToBool(v)
    }

    @Frozen
    public func store(val: Bool): Unit {
        var valInt8 = transBoolToInt8(val)
        store<AtomicBool, Int8>(this, valInt8, DefaultMemoryOrder)
    }

    @Deprecated[message: "Use `public func store(val: Bool): Unit` instead."]
    @Frozen
    public func store(val: Bool, memoryOrder!: MemoryOrder): Unit {
        var valInt8 = transBoolToInt8(val)
        store<AtomicBool, Int8>(this, valInt8, memoryOrder)
    }

    @Frozen
    public func swap(val: Bool): Bool {
        var valInt8 = transBoolToInt8(val)
        var ret: Int8 = swap<AtomicBool, Int8>(this, valInt8, DefaultMemoryOrder)
        return transInt8ToBool(ret)
    }

    @Deprecated[message: "Use `public func swap(val: Bool): Bool` instead."]
    @Frozen
    public func swap(val: Bool, memoryOrder!: MemoryOrder): Bool {
        var valInt8 = transBoolToInt8(val)
        var ret: Int8 = swap<AtomicBool, Int8>(this, valInt8, memoryOrder)
        return transInt8ToBool(ret)
    }

    @Frozen
    public func compareAndSwap(old: Bool, new: Bool): Bool {
        var oldInt8 = transBoolToInt8(old)
        var newInt8 = transBoolToInt8(new)
        return compareAndSwap<AtomicBool, Int8>(this, oldInt8, newInt8, DefaultMemoryOrder, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func compareAndSwap(old: Bool, new: Bool): Bool` instead."]
    public func compareAndSwap(old: Bool, new: Bool, successOrder!: MemoryOrder, failureOrder!: MemoryOrder): Bool {
        var oldInt8 = transBoolToInt8(old)
        var newInt8 = transBoolToInt8(new)
        return compareAndSwap<AtomicBool, Int8>(this, oldInt8, newInt8, successOrder, failureOrder)
    }

    private func transBoolToInt8(v: Bool): Int8 {
        return if (v) {
            1
        } else {
            0
        }
    }
    private func transInt8ToBool(v: Int8): Bool {
        return v == 1
    }
}

public class AtomicReference<T> where T <: Object {
    private var value4cjnative: T

    public init(val: T) {
        value4cjnative = val
        store<AtomicReference<T>, T>(this, val, DefaultMemoryOrder)
    }

    @Frozen
    public func load(): T {
        load<AtomicReference<T>, T>(this, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func load(): T` instead."]
    public func load(memoryOrder!: MemoryOrder): T {
        load<AtomicReference<T>, T>(this, DefaultMemoryOrder)
    }

    @Frozen
    public func store(val: T): Unit {
        store<AtomicReference<T>, T>(this, val, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func store(val: T): Unit` instead."]
    public func store(val: T, memoryOrder!: MemoryOrder): Unit {
        store<AtomicReference<T>, T>(this, val, DefaultMemoryOrder)
    }

    @Frozen
    public func swap(val: T): T {
        swap<AtomicReference<T>, T>(this, val, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func swap(val: T): T` instead."]
    public func swap(val: T, memoryOrder!: MemoryOrder): T {
        swap<AtomicReference<T>, T>(this, val, DefaultMemoryOrder)
    }

    @Frozen
    public func compareAndSwap(old: T, new: T): Bool {
        return compareAndSwap<AtomicReference<T>, T>(this, old, new, DefaultMemoryOrder, DefaultMemoryOrder)
    }

    @Frozen
    @Deprecated[message: "Use `public func compareAndSwap(old: T, new: T): Bool` instead."]
    public func compareAndSwap(old: T, new: T, successOrder!: MemoryOrder, failureOrder!: MemoryOrder): Bool {
        return compareAndSwap<AtomicReference<T>, T>(this, old, new, DefaultMemoryOrder, DefaultMemoryOrder)
    }
}

/**
 * AtomicOptionReference is an atomic reference type which could store null value, i.e. Option<T>.None.
 */
public class AtomicOptionReference<T> where T <: Object {
    private var value: Option<T> = None

    /**
     * Initialize an AtomicOptionReference with null initial value.
     */
    @Frozen
    public init() {}

    /**
     * Initialize an AtomicOptionReference with the given initial value.
     */
    @Frozen
    public init(val: Option<T>) {
        value = val
        store<AtomicOptionReference<T>, Option<T>>(this, val, DefaultMemoryOrder)
    }

    /**
     * Load the current value.
     */
    @Frozen
    public func load(): Option<T> {
        load<AtomicOptionReference<T>, Option<T>>(this, DefaultMemoryOrder)
    }

    /**
     * Load the current value with the given memory order.
     */
    @Frozen
    @Deprecated[message: "Use `public func load(): Option<T>` instead."]
    public func load(memoryOrder!: MemoryOrder): Option<T> {
        load<AtomicOptionReference<T>, Option<T>>(this, DefaultMemoryOrder)
    }

    /**
     * Store the given value.
     */
    @Frozen
    public func store(val: Option<T>): Unit {
        store<AtomicOptionReference<T>, Option<T>>(this, val, DefaultMemoryOrder)
    }

    /**
     * Store the given value with the given memory order.
     */
    @Frozen
    @Deprecated[message: "Use `public func store(val: Option<T>): Unit` instead."]
    public func store(val: Option<T>, memoryOrder!: MemoryOrder): Unit {
        store<AtomicOptionReference<T>, Option<T>>(this, val, DefaultMemoryOrder)
    }

    /**
     * Atomically store the given value and return the old value.
     * @return the old value
     */
    @Frozen
    public func swap(val: Option<T>): Option<T> {
        swap<AtomicOptionReference<T>, Option<T>>(this, val, DefaultMemoryOrder)
    }

    /**
     * Atomically store the given value with the given memory order and return the old value.
     * @return the old value
     */
    @Frozen
    @Deprecated[message: "Use `public func swap(val: Option<T>): Option<T>` instead."]
    public func swap(val: Option<T>, memoryOrder!: MemoryOrder): Option<T> {
        swap<AtomicOptionReference<T>, Option<T>>(this, val, DefaultMemoryOrder)
    }

    /**
     * Atomically store the new value if the current value is equal to the old value.
     * @return `true` if store the new value successfully
     * @return `false` indicates that the current value is not equal to the old value
     */
    @Frozen
    public func compareAndSwap(old: Option<T>, new: Option<T>): Bool {
        return compareAndSwap<AtomicOptionReference<T>, Option<Object>>(
            this,
            match (old) {
                case Some(v) => Option<Object>.Some(v)
                case _ => Option<Object>.None
            },
            match (new) {
                case Some(v) => Option<Object>.Some(v)
                case _ => Option<Object>.None
            },
            DefaultMemoryOrder,
            DefaultMemoryOrder
        )
    }

    /**
     * Atomically store the new value with the given memory order if the current value is equal to the old value.
     * @return `true` if store the new value successfully
     * @return `false` indicates that the current value is not equal to the old value
     */
    @Frozen
    @Deprecated[message: "Use `public func compareAndSwap(old: Option<T>, new: Option<T>): Bool` instead."]
    public func compareAndSwap(
        old: Option<T>,
        new: Option<T>,
        successOrder!: MemoryOrder,
        failureOrder!: MemoryOrder
    ): Bool {
        return compareAndSwap<AtomicOptionReference<T>, Option<Object>>(
            this,
            match (old) {
                case Some(v) => Option<Object>.Some(v)
                case _ => Option<Object>.None
            },
            match (new) {
                case Some(v) => Option<Object>.Some(v)
                case _ => Option<Object>.None
            },
            DefaultMemoryOrder,
            DefaultMemoryOrder
        )
    }
}
