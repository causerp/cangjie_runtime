/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/**
 * @file
 *
 * This file defines ArrayQueue and related classes.
 */
package std.collection

public class ArrayQueue<T> <: Queue<T> {
    let _data: ArrayDeque<T>

    public init() {
        _data = ArrayDeque<T>()
    }

    public init(capacity: Int64) {
        _data = ArrayDeque<T>(capacity)
    }

    public func peek(): ?T {
        _data.first
    }

    public func add(element: T): Unit {
        _data.addLast(element)
    }

    public func remove(): ?T {
        _data.removeFirst()
    }

    public prop size: Int64 {
        get() {
            _data.size
        }
    }

    public prop capacity: Int64 {
        get() {
            _data.capacity
        }
    }

    public func isEmpty(): Bool {
        _data.isEmpty()
    }

    public func clear(): Unit {
        _data.clear()
    }

    @Frozen
    public func iterator(): Iterator<T> {
        _data.iterator()
    }

    public func toArray(): Array<T> {
        _data.toArray()
    }

    public func reserve(additional: Int64): Unit {
        _data.reserve(additional)
    }
}

extend<T> ArrayQueue<T> <: ToString where T <: ToString {
    public func toString(): String {
        this._data.toString()
    }
}
