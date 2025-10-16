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
 * This file defines the Queue interface.
 */
package std.collection

/**
 * Interface for a double-ended queue.
 *
 * @param <T> The type of elements in the queue.
 */
public interface Deque<T> <: Collection<T> {

    /**
     * Get the first element in the queue.
     *
     * @return The first element if the queue is not empty, otherwise null.
     */
    prop first: ?T

    /**
     * Get the last element in the queue.
     *
     * @return The last element if the queue is not empty, otherwise null.
     */
    prop last: ?T

    /**
     * Add an element to the front of the queue.
     *
     * @param element The element to add.
     */
    func addFirst(element: T): Unit

    /**
     * Add an element to the back of the queue.
     *
     * @param element The element to add.
     */
    func addLast(element: T): Unit

    /**
     * Remove the first element from the queue.
     *
     * @return The removed element if the queue was not empty, otherwise null.
     */
    func removeFirst(): ?T

    /**
     * Remove the last element from the queue.
     *
     * @return The removed element if the queue was not empty, otherwise null.
     */
    func removeLast(): ?T
}

/**
 * Queue interface that inherits from the Collection interface.
 * @param <T> The type of elements in the queue.
 */
public interface Queue<T> <: Collection<T> {

    /**
     * Adds an element to the queue.
     * @param element The element to add.
     * @return No return value.
     */
    func add(element: T): Unit

    /**
     * Views the head element of the queue but does not remove it.
     * @return The head element of the queue, or None if the queue is empty.
     */
    func peek(): ?T

    /**
     * Removes and returns the head element of the queue.
     * @return The removed head element, or None if the queue is empty.
     */
    func remove(): ?T
}
