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
 * This file defines HashSet and related classes.
 */
package std.collection

/**
 * This class implements the Set interface. The underlying structure is a hash table.
 * (Actually, It is an instance of encapsulating HashMap.) . It is not an ordered set.
 * Please note that, this class is asynchronous. When multiple threads access this class
 * at the same time and at least one thread modifies it,it may cause thread insecureness.
 *
 * @see Collection
 * @see Set
 * @see HashMap
 *
 * @since 0.18.4
 */
public class HashSet<T> <: Set<T> where T <: Hashable & Equatable<T> {
    /* hashMap */
    private var map: HashMap<T, Unit>

    /**
     * Constructs a new, empty set; the backing @p HashSet instance has
     * default initial capacity (16) and load factor (0.75).
     *
     * @since 0.18.4
     */
    @Frozen
    public init() {
        map = HashMap<T, Unit>()
    }

    /**
     * Construct a HashSet with an incoming iterator for initialization.
     *
     * @param elements an incoming iterator is initialized.
     *
     * @since 0.18.4
     */
    @Frozen
    public init(elements: Collection<T>) {
        this.map = HashMap<T, Unit>(elements.size)
        for (i in elements) {
            this.map.putWithoutResize(i, ())
        }
    }

    /**
     * Construct a HashSet with an incoming array for initialization.
     *
     * @param elements an incoming array is initialized.
     *
     * @since 0.18.4
     */
    @Frozen
    public init(elements: Array<T>) {
        this.map = HashMap<T, Unit>(elements.size)
        for (i in elements) {
            this.map.putWithoutResize(i, ())
        }
    }

    /**
     * Construct a HashSet with an incoming @p myCapacity for initialization.
     *
     * @param capacity myCapacity an incoming capacity is initialized.
     *
     * @since 0.18.4
     */
    @Frozen
    public init(capacity: Int64) {
        this.map = HashMap<T, Unit>(capacity)
    }

    /**
     * Constructs a hash map with an incoming size and an initial element for initialization.
     *
     * @param size the size of the incoming initial element.
     * @param initElement an incoming initElement is initialized.
     *
     * @since 0.18.4
     */
    @Frozen
    public init(size: Int64, initElement: (Int64) -> T) {
        this.map = HashMap<T, Unit>(size, {i => (initElement(i), ())})
    }

    /**
     * Checks whether the mapping relationship corresponding to the specified key exists in this mapping.
     *
     * @param element key transfer the key to be judged.
     * @return bool returns true if exists; otherwise, false.
     *
     * @since 0.18.4
     */
    @Frozen
    public func contains(element: T): Bool {
        return map.contains(element)
    }

    /**
     * Check whether the set is a subset of other.
     *
     * @param other a set of the set type.
     * @return bool returns true if it is a subset, false otherwise.
     *
     * @since 0.18.4
     */
    @Frozen
    public func subsetOf(other: ReadOnlySet<T>): Bool {
        for (i in this) {
            if (!other.contains(i)) {
                return false
            }
        }
        return true
    }

    /**
     * Checks whether the mapping relationship corresponding to the collection key exists in this mapping.
     *
     * @param elements keys transfer the collection key to be judged.
     * @return bool returns true if exists; otherwise, false.
     *
     * @since 0.18.4
     */
    @Frozen
    public func contains(all!: Collection<T>): Bool {
        return map.contains(all: all)
    }

    /**
     * Add element operation. If the element already exists, it will not be added.
     *
     * @param element the key to put.
     * @return bool returns true if element is added; otherwise, false.
     *
     * @since 0.18.4
     */
    @Frozen
    public func add(element: T): Bool {
        return match (this.map.add(element, ())) {
            case None => true
            case _ => false
        }
    }

    /**
     * Removes the key-value pair corresponding to the key based on the specified key from this mapping, if one exists.
     *
     * @param element key pass in the key to be deleted.
     *
     * @since 0.18.4
     */
    @Frozen
    public func remove(element: T): Bool {
        return match (map.remove(element)) {
            case None => false
            case _ => true
        }
    }

    /**
     * Transfer specified elements for traversal and assign values in sequence.
     * If you map a mapping that previously contained a key, the old value is replaced.
     *
     * @param elements the element passing in for traversal assignment.
     *
     * @since 0.18.4
     */
    @Frozen
    public func add(all!: Collection<T>): Unit {
        for (i in all) {
            this.map.add(i, ())
        }
    }

    /**
     * Traverse the set of transferred keys and delete them based on the traversal result.
     *
     * @param elements keys pass in the collection to traverse.
     *
     * @since 0.18.4
     */
    @Frozen
    public func remove(all!: Collection<T>): Unit {
        map.remove(all: all)
    }

    /**
     * Transfer a lambda expression and delete the corresponding key value if the condition is met.
     *
     * @param predicate transfer a lambda expression for judgment.
     *
     * @since 0.18.4
     */
    @Frozen
    public func removeIf(predicate: (T) -> Bool): Unit {
        this.map.removeIf({k, _ => predicate(k)})
    }

    /**
     * Clear all key-value pairs.
     *
     * @since 0.18.4
     */
    @Frozen
    public func clear(): Unit {
        this.map.clear()
    }

    /**
     * Retain only duplicate T.
     * Removes all elements from this collection that are not contained
     * in the specified collection. This function depends on the contains function.
     * Please note that. If the incoming interface is a subtype of a malicious implementation.
     * We do not guarantee the correctness of results for retaining duplicate elements.
     *
     * @param elements collections to be saved.
     *
     * @since 0.18.4
     */
    @Frozen
    public func retain(all!: Set<T>): Unit {
        let it: HashMapIterator<T, Unit> = this.map.iterator()
        for ((k, _) in it where !all.contains(k)) {
            it.remove()
        }
    }

    /**
     * Clone of hashset.
     *
     * @return a clone value of HashSet.
     *
     * @since 0.18.4
     */
    @Frozen
    public func clone(): HashSet<T> {
        return HashSet<T>(this)
    }

    /**
     * Ensure that there is sufficient capacity. additional indicates the quantity to be added.
     * If the additional parameter is negative, the hash map does not change.
     * If the additional parameter plus the size of the hashset is smaller than the capacity of the  array, the hashset does not change.
     *
     * @param additional size of the increment.
     *
     * @since 0.18.4
     */
    @Frozen
    public func reserve(additional: Int64): Unit {
        this.map.reserve(additional)
    }

    /**
     * Returns the capacity of the hashSet.
     *
     * @return the capacity of the hashSet.
     *
     * @since 0.18.4
     */
    @Frozen
    public prop capacity: Int64 {
        get() {
            return this.map.capacity
        }
    }

    /**
     * Returns iterator of hashSet.
     *
     * @return iterator of Keys.
     *
     * @since 0.18.4
     */
    @Frozen
    public func iterator(): Iterator<T> {
        return this.map.keys().iterator()
    }

    /**
     * Returns sizes of key-value.
     *
     * @return sizes of key-value.
     *
     * @since 0.18.4
     */
    @Frozen
    public prop size: Int64 {
        get() {
            return this.map.size
        }
    }

    /**
     * Check whether the size is empty. If yes, true is returned. Otherwise, false is returned.
     *
     * @return bool if yes, true is returned. Otherwise, false is returned.
     *
     * @since 0.18.4
     */
    @Frozen
    public func isEmpty(): Bool {
        return map.isEmpty()
    }

    /**
     * Returns the element in this HashSet as an Array.
     *
     * @throws IndexOutOfBoundsException if "mySize" is out of bound.
     */
    @Frozen
    public func toArray(): Array<T> {
        return map.keys().toArray()
    }

    /**
     * Computes the intersection of this set and another set.
     * Returns a new set containing only the elements that are present in both sets.
     *
     * - Parameter other: Another set to intersect with.
     * - Returns: A new `HashSet` containing elements common to both sets.
     *
     * Example:
     * ```
     * let set1 = HashSet([1, 2, 3])
     * let set2 = HashSet([2, 3, 4])
     * let result = set1 & set2 // result is [2, 3]
     * ```
     */
    @Frozen
    public operator func &(other: ReadOnlySet<T>): HashSet<T> {
        let result = HashSet<T>()
        for (key in this.map.keys() where other.contains(key)) {
            result.add(key)
        }
        return result
    }

    /**
     * Computes the union of this set and another set.
     * Returns a new set containing all unique elements from both sets.
     *
     * - Parameter other: Another set to unite with.
     * - Returns: A new `HashSet` containing all unique elements from both sets.
     *
     * Example:
     * ```
     * let set1 = HashSet([1, 2, 3])
     * let set2 = HashSet([3, 4, 5])
     * let result = set1 | set2 // result is [1, 2, 3, 4, 5]
     * ```
     */
    @Frozen
    public operator func |(other: ReadOnlySet<T>): HashSet<T> {
        let result = this.clone()
        result.add(all: other)
        return result
    }

    /**
     * Computes the difference of this set and another set.
     * Returns a new set containing elements that are present in this set but not in the other set.
     *
     * - Parameter other: Another set to subtract from this set.
     * - Returns: A new `HashSet` containing elements unique to this set.
     *
     * Example:
     * ```
     * let set1 = HashSet([1, 2, 3])
     * let set2 = HashSet([3, 4, 5])
     * let result = set1 - set2 // result is [1, 2]
     * ```
     */
    @Frozen
    public operator func -(other: ReadOnlySet<T>): HashSet<T> {
        let result = HashSet<T>()
        for (key in this.map.keys() where !other.contains(key)) {
            result.add(key)
        }
        return result
    }
}

/**
 * Defines the HashSet inherits the Equalable method and determines whether = = and! = methods.
 *
 * @since 0.18.4
 */
extend<T> HashSet<T> <: Equatable<HashSet<T>> {
    /** overloaded determination equal function. */
    @Frozen
    public operator func ==(that: HashSet<T>): Bool {
        if (this.size != that.size) {
            return false
        }
        for (key in that where !this.contains(key)) {
            return false
        }
        return true
    }

    /** overloaded determination unequal function. */
    @Frozen
    public operator func !=(that: HashSet<T>): Bool {
        return !(this == that)
    }
}

extend<T> HashSet<T> <: ToString where T <: ToString {
    @Frozen
    public func toString(): String {
        return collectionToString<HashSet<T>, T>(this)
    }
}
