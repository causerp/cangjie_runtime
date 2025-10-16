/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
protected package std.unittest.mock.internal

import std.collection.*

public interface HasDefaultValueForStub<T> {
    static func defaultValueForStub(): T
}

extend Unit <: HasDefaultValueForStub<Unit> {
    public static func defaultValueForStub(): Unit { () }
}

extend Int8 <: HasDefaultValueForStub<Int8> {
    public static func defaultValueForStub(): Int8 { 0 }
}

extend Int16 <: HasDefaultValueForStub<Int16> {
    public static func defaultValueForStub(): Int16 { 0 }
}

extend Int32 <: HasDefaultValueForStub<Int32> {
    public static func defaultValueForStub(): Int32 { 0 }
}

extend Int64 <: HasDefaultValueForStub<Int64> {
    public static func defaultValueForStub(): Int64 { 0 }
}

extend Float16 <: HasDefaultValueForStub<Float16> {
    public static func defaultValueForStub(): Float16 { 0.0 }
}

extend Float32 <: HasDefaultValueForStub<Float32> {
    public static func defaultValueForStub(): Float32 { 0.0 }
}

extend Float64 <: HasDefaultValueForStub<Float64> {
    public static func defaultValueForStub(): Float64 { 0.0 }
}

extend Bool <: HasDefaultValueForStub<Bool> {
    public static func defaultValueForStub(): Bool { false }
}

extend String <: HasDefaultValueForStub<String> {
    public static func defaultValueForStub(): String { "" }
}

extend<T> Option<T> <: HasDefaultValueForStub<Option<T>> {
    public static func defaultValueForStub(): Option<T> { Option<T>.None }
}

extend<T> Array<T> <: HasDefaultValueForStub<Array<T>> {
    public static func defaultValueForStub(): Array<T> { [] }
}

extend<T> ArrayList<T> <: HasDefaultValueForStub<ArrayList<T>> {
    public static func defaultValueForStub(): ArrayList<T> { ArrayList<T>() }
}

extend<T> HashSet<T> <: HasDefaultValueForStub<HashSet<T>> {
    public static func defaultValueForStub(): HashSet<T> { HashSet<T>() }
}

extend<K, V> HashMap<K, V> <: HasDefaultValueForStub<HashMap<K, V>> {
    public static func defaultValueForStub(): HashMap<K, V> { HashMap<K, V>() }
}
