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
 * This file defines ArrayStack and related classes.
 */
package std.collection

public class ArrayStack<T> <: Stack<T> {
    // The array used to store the elements of the stack.
    var _data: Array<T> = Array<T>()

    // The size of the stack.
    var _size: Int64 = 0

    // The modecount of stack.
    var _version: Int64 = 0

    // The default capacity of the array.
    private static const DEFAULT_CAPACITY: Int64 = 8

    /**
     * Constructs an empty stack with the specified capacity.
     *
     * @param capacity the capacity of the stack
     * @throws IllegalArgumentException if the capacity is negative
     */
    public init(capacity: Int64) {
        if (capacity < 0) {
            throw IllegalArgumentException("The capacity must be greater than or equal to 0: ${capacity}.")
        }
        let cap: Int64 = if (capacity >= DEFAULT_CAPACITY) {
            capacity
        } else {
            DEFAULT_CAPACITY
        }
        _data = Array<T>(cap, repeat: unsafe { zeroValue<T>() })
    }

    /**
     * Constructs an empty stack with the default capacity.
     */
    public init() {
        _data = Array<T>(DEFAULT_CAPACITY, repeat: unsafe { zeroValue<T>() })
    }

    /**
     * Returns the element at the top of the stack without removing it, or null if the stack is empty.
     *
     * @return the element at the top of the stack, or null if the stack is empty
     */
    public func peek(): ?T {
        if (_size > 0) {
            return _data[_size - 1]
        }
        return None
    }

    /**
     * Removes and returns the element at the top of the stack, or null if the stack is empty.
     *
     * @return the element at the top of the stack, or null if the stack is empty
     */
    public func remove(): ?T {
        if (_size > 0) {
            let result = _data[_size - 1]
            _data[_size - 1] = unsafe { zeroValue<T>() }
            _size--
            incModCount()
            return result
        }
        None
    }

    /**
     * Adds an element to the top of the stack.
     *
     * @param element the element to add
     */
    public func add(element: T): Unit {
        if (_size == _data.size) {
            grow(_size + 1)
        }
        _data[_size] = element
        _size++
        incModCount()
    }

    /**
     * Returns the capacity of the stack.
     *
     * @return the capacity of the stack
     */
    public prop capacity: Int64 {
        get() {
            _data.size
        }
    }

    /**
     * Returns the size of the stack.
     *
     * @return the size of the stack
     */
    public prop size: Int64 {
        get() {
            _size
        }
    }

    /**
     * Returns true if the stack is empty, and false otherwise.
     *
     * @return true if the stack is empty, and false otherwise
     */
    public func isEmpty(): Bool {
        _size == 0
    }

    /**
     * Reserves space for additional elements in the stack.
     *
     * @param additional the number of additional elements to reserve space for
     */
    public func reserve(additional: Int64): Unit {
        if (_data.size - _size >= additional) {
            return
        }
        grow(_size + additional)
        incModCount()
    }

    /**
     * Clears the stack.
     */
    public func clear(): Unit {
        for (i in 0.._size) {
            unsafe { _data.setUnchecked(i, zeroValue<T>()) }
        }
        _size = 0
        incModCount()
    }

    /**
     * Converts the stack to an array.
     *
     * @return an array containing the elements of the stack in the order of popping the stack
     */
    public func toArray(): Array<T> {
        let arr = _data[0..size].clone()
        arr.reverse()
        return arr
    }

    /**
     * Returns an iterator over the elements in the stack.
     *
     * @return an iterator over the elements in the stack
     */
    @Frozen
    public func iterator(): Iterator<T> {
        return ArrayStackIterator<T>(this)
    }

    private func grow(minCapacity: Int64, startIndex!: Int64 = 0): Unit {
        let oldCapacity: Int64 = _data.size
        var newCapacity: Int64 = oldCapacity + (oldCapacity >> 1)
        if (newCapacity < minCapacity) {
            newCapacity = minCapacity
        }
        let newArr: Array<T> = Array<T>(newCapacity, repeat: unsafe { zeroValue<T>() })
        _data.copyTo(newArr, 0, startIndex, _size)
        _data = newArr
    }

    @OverflowWrapping
    private func incModCount(): Unit {
        _version++
    }
}

class ArrayStackIterator<T> <: Iterator<T> {
    // Representing the array stack being iterated
    private let _stack: ArrayStack<T>
    // Private variable, representing the current position in the iteration
    private var _position: Int64
    private let _lockVersion: Int64

    /**
     * Constructor, initializes the iterator
     * @param data The array stack to be iterated
     */
    init(data: ArrayStack<T>) {
        _stack = data
        _position = data._size
        _lockVersion = data._version
    }

    /**
     * Returns the next element in the iteration
     * @return The next element in the iteration, or None if there is no next element
     * @throws ConcurrentModificationException If the version number of the array stack changes during iteration
     */
    @Frozen
    @OverflowWrapping
    public func next(): Option<T> {
        if (_stack._version != _lockVersion) {
            throw ConcurrentModificationException()
        }

        if (_position > 0) {
            _position--
            return _stack._data[_position]
        }
        return None
    }
}

extend<T> ArrayStack<T> <: ToString where T <: ToString {
    public func toString(): String {
        if (size == 0) {
            return "[]"
        }

        let sb = StringBuilder()
        sb.append(r'[')
        sb.append(_data[_size - 1])
        for (i in size - 2..=0 : -1) {
            sb.append(", ")
            sb.append(_data[i])
        }
        sb.append(r']')
        return sb.toString()
    }
}
