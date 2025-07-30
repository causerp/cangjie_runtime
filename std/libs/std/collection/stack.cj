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
 * This file defines the Stack interface.
 */
package std.collection

/**
 * Stack interface, inherits from Collection interface
 * @param <T> Generic parameter
 */
public interface Stack<T> <: Collection<T> {

    /**
     * Peek at the top element without removing it
     * @return The top element, or None if the stack is empty
     */
    func peek(): ?T

    /**
     * Remove and return the top element
     * @return The removed element, or None if the stack is empty
     */
    func remove(): ?T

    /**
     * Push an element onto the top of the stack
     * @param element The element to be pushed
     * @return No return value
     */
    func add(element: T): Unit
}
