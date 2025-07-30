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
 * This file defines the collection interface.
 */
package std.collection

public interface ReadOnlySet<T> <: Collection<T> {
    func contains(element: T): Bool
    func contains(all!: Collection<T>): Bool
    func subsetOf(other: ReadOnlySet<T>): Bool
}

/**
 * This interface is a collection that does not guarantee the sequence of elements.
 * That is, the sequence of adding elements is different from the sequence of obtaining elements.
 *
 * @since 0.18.4
 */
public interface Set<T> <: ReadOnlySet<T> {
    /**
     * Add element operation. If the element already exists, it will not be added.
     *
     * @param element the key to put.
     * @return bool returns true if element is added; otherwise, false.
     *
     * @since 0.18.4
     */
    func add(element: T): Bool

    /**
     * Transfer specified elements for traversal and assign values in sequence.
     * If you map a mapping that previously contained a key, the old value is replaced.
     *
     * @param elements the element passing in for traversal assignment.
     *
     * @since 0.18.4
     */
    func add(all!: Collection<T>): Unit

    /**
     * Removes the key-value pair corresponding to the key based on the specified key from this mapping, if one exists.
     *
     * @param element key pass in the key to be deleted.
     *
     * @since 0.18.4
     */
    func remove(element: T): Bool

    /**
     * Traverse the set of transferred keys and delete them based on the traversal result.
     *
     * @param elements keys pass in the collection to traverse.
     *
     * @since 0.18.4
     */
    func remove(all!: Collection<T>): Unit

    /**
     * Transfer a lambda expression and delete the corresponding key value if the condition is met.
     *
     * @param predicate transfer a lambda expression for judgment.
     *
     * @since 0.18.4
     */
    func removeIf(predicate: (T) -> Bool): Unit

    /**
     * Clear all key-value pairs.
     *
     * @since 0.18.4
     */
    func clear(): Unit

    /**
     * Retain only duplicate T.
     *
     * @param elements collections to be saved.
     *
     * @since 0.18.4
     */
    func retain(all!: Set<T>): Unit
}

public interface OrderedSet<T> <: Set<T> {
    prop first: ?T
    prop last: ?T
    func removeFirst(): ?T
    func removeLast(): ?T
    func backward(mark: T, inclusive!: Bool): Iterator<T>
    func forward(mark: T, inclusive!: Bool): Iterator<T>
}
