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
 * This file defines TreeSet and related classes.
 */
package std.collection

public class TreeSet<T> <: OrderedSet<T> where T <: Comparable<T> {
    /* TreeMap */
    private var map: TreeMap<T, Unit>

    /**
     * Returns the size.
     *
     * @return size.
     *
     */
    public prop size: Int64 {
        get() {
            return this.map.size
        }
    }

    /**
     * Gets the first node of the TreeSet.
     *
     * @return If the first node exists, the element on the first node is returned. Otherwise, None is returned.
     *
     */
    public prop first: ?T {
        get() {
            this.map.first?[0]
        }
    }

    /**
     * Gets the last node of the TreeSet.
     *
     * @return If the last node exists, the element on the last node is returned. Otherwise, None is returned.
     *
     */
    public prop last: ?T {
        get() {
            this.map.last?[0]
        }
    }

    /**
     * Constructs a new, empty set.
     */
    public init() {
        map = TreeMap<T, Unit>()
    }

    /**
     * Construct a TreeSet with an incoming collection for initialization.
     *
     * @param elements an incoming collection.
     *
     */
    public init(elements: Collection<T>) {
        this.map = TreeMap<T, Unit>()
        for (i in elements) {
            this.map.add(i, ())
        }
    }

    /**
     * Construct a TreeSet with an incoming array for initialization.
     *
     * @param elements an incoming array is initialized.
     *
     */
    private init(elements: Array<T>) {
        this.map = TreeMap<T, Unit>()
        for (i in elements) {
            this.map.add(i, ())
        }
    }

    /**
     * Constructs a tree map with an incoming size and an initial element for initialization.
     *
     * @param size the size of the incoming initial element.
     * @param initElement an incoming initElement is initialized.
     *
     */
    public init(size: Int64, initElement: (Int64) -> T) {
        if (size < 0) {
            throw IllegalArgumentException("Invalid size of TreeSet: ${size}.")
        }
        this.map = TreeMap<T, Unit>(size, {i => (initElement(i), ())})
    }

    /**
     * Statically generate an TreeSet with the specified Array.
     *
     * @param elements input element type array.
     * @return new TreeSet
     */
    public static func of(elements: Array<T>): TreeSet<T> {
        return TreeSet(elements)
    }

    /**
     * Checks whether the specified element is contained in this set.
     *
     * @param element elements to judge.
     * @return bool returns true if contained; otherwise, false.
     *
     */
    public func contains(element: T): Bool {
        return map.contains(element)
    }

    /**
     * Checks whether the specified collection of elements is all contained in this set.
     *
     * @param all collection of elements to be judged.
     * @return bool returns true if all elements are included, false otherwise.
     *
     */
    public func contains(all!: Collection<T>): Bool {
        return map.contains(all: all)
    }

    /**
     * Add element operation. If the element already exists, it will not be added.
     *
     * @param element the element to put.
     * @return Bool returns true if element is added; otherwise, false.
     *
     */
    public func add(element: T): Bool {
        return this.map.add(element, ()).isNone()
    }

    /**
     * All elements in the incoming collection are added.
     *
     * @param all the collection.
     *
     */
    public func add(all!: Collection<T>): Unit {
        for (i in all) {
            this.map.add(i, ())
        }
    }

    /**
     * Removes a specified element from a set.
     *
     * @param element a specified element.
     * @return Bool if the removal is successful, true is returned. If the removal fails or the element does not exist, false is returned.
     *
     */
    public func remove(element: T): Bool {
        return map.remove(element).isSome()
    }

    /**
     * Traversal removal of elements in this collection.
     *
     * @param all the collection.
     *
     */
    public func remove(all!: Collection<T>): Unit {
        map.remove(all: all)
    }

    /**
     * Transfer a lambda expression and delete the corresponding element if the condition is met.
     *
     * @param predicate transfer a lambda expression for judgment.
     *
     */
    public func removeIf(predicate: (T) -> Bool): Unit {
        this.map.removeIf({e, _ => predicate(e)})
    }

    /**
     * Clears all elements.
     */
    public func clear(): Unit {
        this.map.clear()
    }

    /**
     * Copy a TreeSet.
     *
     * @return returns a cloned TreeSet.
     *
     */
    public func clone(): TreeSet<T> {
        return TreeSet<T>(this)
    }

    /**
     * Check whether the size is empty. If yes, true is returned. Otherwise, false is returned.
     *
     * @return bool if yes, true is returned. Otherwise, false is returned.
     *
     */
    public func isEmpty(): Bool {
        return this.map.isEmpty()
    }

    /**
     * Get an iterator.
     *
     * @return the return type is an iterator and contains all elements.
     *
     */
    @Frozen
    public func iterator(): Iterator<T> {
        return this.map.keys().iterator()
    }

    /**
     * Delete the first node of the TreeSet.
     *
     * @return If the first node exists, it is deleted and the element it stores is returned. Otherwise, it returns None.
     *
     */
    public func removeFirst(): ?T {
        return this.map.removeFirst()?[0]
    }

    /**
     * Delete the last node of the TreeSet.
     *
     * @return If the last node exists, it is deleted and the element it stores is returned. Otherwise, it returns None.
     *
     */
    public func removeLast(): ?T {
        return this.map.removeLast()?[0]
    }

    /**
     * Gets a descending iterator.
     * The head node of the iterator is the first node whose value is less than or equal to the marked element, and the tail node is the head node of the original set.
     *
     * @param mark Marked element.
     * @param inclusive Indicates whether the iterator includes the marked element node.
     * If yes, the iterator includes the marked element node. Otherwise, the iterator does not include the marked element node.
     *
     * @return iterator.
     *
     */
    public func backward(mark: T, inclusive!: Bool = true): Iterator<T> {
        return IteratorForSet<T>(this.map.backward(mark, inclusive: inclusive))
    }

    /**
     * Gets a Ascending iterator.
     * The head node of the iterator is the first node with a value greater than or equal to the marked element, and the tail node is the tail node of the original set.
     *
     * @param mark Marked element.
     * @param inclusive Indicates whether the iterator includes the marked element node.
     * If yes, the iterator includes the marked element node. Otherwise, the iterator does not include the marked element node.
     *
     * @return iterator.
     *
     */
    public func forward(mark: T, inclusive!: Bool = true): Iterator<T> {
        return IteratorForSet<T>(this.map.forward(mark, inclusive: inclusive))
    }

    /**
     * Retain only duplicate T.
     * Removes all elements from this collection that are not contained
     * in the specified collection. This function depends on the contains function.
     * Please note that. If the incoming interface is a subtype of a malicious implementation.
     * We do not guarantee the correctness of results for retaining duplicate elements.
     *
     * @param all the other set.
     *
     */
    public func retain(all!: Set<T>): Unit {
        this.map.removeIf({k, _ => !all.contains(k)})
    }

    /**
     * Returns the element in this TreeSet as an Array.
     *
     */
    public func toArray(): Array<T> {
        return map.keys().toArray()
    }

    /**
     * Check whether the set is a subset of other.
     *
     * @param other a set of the set type.
     * @return bool returns true if it is a subset, false otherwise.
     *
     */
    public func subsetOf(other: ReadOnlySet<T>): Bool {
        return other.contains(all: this.map.keys())
    }

    /**
     * Computes the intersection of this set and another set.
     * Returns a new set containing only the elements that are present in both sets.
     *
     * @param other Another set to intersect with.
     * @return A new `TreeSet` containing elements common to both sets.
     *
     * Example:
     * ```
     * let set1 = TreeSet([1, 2, 3])
     * let set2 = TreeSet([2, 3, 4])
     * let result = set1 & set2 // result is [2, 3]
     * ```
     */
    public operator func &(other: ReadOnlySet<T>): TreeSet<T> {
        let result = TreeSet<T>()
        for (key in this.map.keys() where other.contains(key)) {
            result.add(key)
        }
        return result
    }

    /**
     * Computes the union of this set and another set.
     * Returns a new set containing all unique elements from both sets.
     *
     * @param other Another set to unite with.
     * @return A new `TreeSet` containing all unique elements from both sets.
     *
     * Example:
     * ```
     * let set1 = TreeSet([1, 2, 3])
     * let set2 = TreeSet([3, 4, 5])
     * let result = set1 | set2 // result is [1, 2, 3, 4, 5]
     * ```
     */
    public operator func |(other: ReadOnlySet<T>): TreeSet<T> {
        let result = this.clone()
        result.add(all: other)
        return result
    }

    /**
     * Computes the difference of this set and another set.
     * Returns a new set containing elements that are present in this set but not in the other set.
     *
     * @param other Another set to subtract from this set.
     * @return A new `TreeSet` containing elements unique to this set.
     *
     * Example:
     * ```
     * let set1 = TreeSet([1, 2, 3])
     * let set2 = TreeSet([3, 4, 5])
     * let result = set1 - set2 // result is [1, 2]
     * ```
     */
    public operator func -(other: ReadOnlySet<T>): TreeSet<T> {
        let result = TreeSet<T>()
        for (key in this.map.keys() where !other.contains(key)) {
            result.add(key)
        }
        return result
    }
}

class IteratorForSet<T> <: Iterator<T> where T <: Comparable<T> {
    private let it: Iterator<(T, Unit)>

    init(it: Iterator<(T, Unit)>) {
        this.it = it
    }

    @Frozen
    public func next(): Option<T> {
        return it.next()?[0]
    }
}

/**
 * Defines the TreeSet inherits the Equalable method and determines whether == and != methods.
 *
 */
extend<T> TreeSet<T> <: Equatable<TreeSet<T>> {
    /** overloaded determination equal function. */
    public operator func ==(that: TreeSet<T>): Bool {
        if (this.size != that.size) {
            return false
        }
        let iThis = this.iterator()
        let iThat = that.iterator()
        for (_ in 0..this.size where iThis.next() != iThat.next()) {
            return false
        }
        return true
    }

    /** overloaded determination unequal function. */
    public operator func !=(that: TreeSet<T>): Bool {
        return !(this == that)
    }
}

extend<T> TreeSet<T> <: ToString where T <: ToString {
    public func toString(): String {
        return collectionToString<TreeSet<T>, T>(this)
    }
}
