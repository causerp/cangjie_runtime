/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.sort

import std.collection.*

/**
 * Sorting element T.
 *
 * @param data Array of elements to be sorted.
 * @param stable Whether to use stable sorting.
 * @param descending Indicates whether to use descending sorting.
 *
 */
@Frozen
public func sort<T>(data: Array<T>, stable!: Bool = false, descending!: Bool = false): Unit where T <: Comparable<T> {
    if (descending) {
        let comparator = {l: T, r: T => r.compare(l)}
        if (stable) {
            stableSort(data, comparator)
        } else {
            unstableSort(data, comparator)
        }
    } else {
        if (stable) {
            stableSort(data)
        } else {
            unstableSort(data)
        }
    }
}

/**
 * Sorting element T.
 *
 * @param data Array of elements to be sorted.
 * @param by Comparator.
 * @param stable Whether to use stable sorting.
 * @param descending Indicates whether to use descending sorting.
 *
 */
@Frozen
public func sort<T>(data: Array<T>, by!: (T, T) -> Ordering, stable!: Bool = false, descending!: Bool = false): Unit {
    var comparator = by
    if (descending) {
        comparator = {l: T, r: T => match (by(l, r)) {
                case GT => LT
                case LT => GT
                case _ => EQ
            }
        }
    }
    if (stable) {
        stableSort(data, comparator)
    } else {
        unstableSort(data, comparator)
    }
}

/**
 * Sorting element T.
 *
 * @param data Array of elements to be sorted.
 * @param lessThan Comparator.
 * @param stable Whether to use stable sorting.
 * @param descending Indicates whether to use descending sorting.
 *
 */
public func sort<T>(data: Array<T>, lessThan!: (T, T) -> Bool, stable!: Bool = false, descending!: Bool = false): Unit {
    let comparator = {l: T, r: T => match (lessThan(l, r)) {
            case true => LT
            case false => if (lessThan(r, l)) {
                    GT
                } else {
                    EQ
                }
        }
    }
    sort(data, by: comparator, stable: stable, descending: descending)
}

/**
 * Sorting element T.
 *
 * @param data Array of elements to be sorted.
 * @param key Mapping of elements T to K.
 * @param stable Whether to use stable sorting.
 * @param descending Indicates whether to use descending sorting.
 *
 */
public func sort<T, K>(data: Array<T>, key!: (T) -> K, stable!: Bool = false, descending!: Bool = false): Unit where K <: Comparable<K> {
    let comparator = if (descending) {
        {l: T, r: T => key(r).compare(key(l))}
    } else {
        {l: T, r: T => key(l).compare(key(r))}
    }
    if (stable) {
        stableSort(data, comparator)
    } else {
        unstableSort(data, comparator)
    }
}

/**
 * Sorting element T.
 *
 * @param data List of elements to be sorted.
 * @param stable Whether to use stable sorting.
 * @param descending Indicates whether to use descending sorting.
 *
 */
public func sort<T>(data: List<T>, stable!: Bool = false, descending!: Bool = false): Unit where T <: Comparable<T> {
    var dataArray = data.toArray()
    sort(dataArray, stable: stable, descending: descending)
    data.clear()
    for (i in dataArray) {
        data.add(i)
    }
}

/**
 * Sorting element T.
 *
 * @param data List of elements to be sorted.
 * @param by Comparator.
 * @param stable Whether to use stable sorting.
 * @param descending Indicates whether to use descending sorting.
 *
 */
public func sort<T>(data: List<T>, by!: (T, T) -> Ordering, stable!: Bool = false, descending!: Bool = false): Unit {
    var dataArray = data.toArray()
    data.clear()
    sort(dataArray, by: by, stable: stable, descending: descending)
    for (i in dataArray) {
        data.add(i)
    }
}

/**
 * Sorting element T.
 *
 * @param data List of elements to be sorted.
 * @param lessThan Comparator.
 * @param stable Whether to use stable sorting.
 * @param descending Indicates whether to use descending sorting.
 *
 */
public func sort<T>(data: List<T>, lessThan!: (T, T) -> Bool, stable!: Bool = false, descending!: Bool = false): Unit {
    var dataArray = data.toArray()
    data.clear()
    sort(dataArray, lessThan: lessThan, stable: stable, descending: descending)
    for (i in dataArray) {
        data.add(i)
    }
}

/**
 * Sorting element T.
 *
 * @param data List of elements to be sorted.
 * @param key Mapping of elements T to K.
 * @param stable Whether to use stable sorting.
 * @param descending Indicates whether to use descending sorting.
 *
 */
public func sort<T, K>(data: List<T>, key!: (T) -> K, stable!: Bool = false, descending!: Bool = false): Unit where K <: Comparable<K> {
    var dataArray = data.toArray()
    data.clear()
    sort(dataArray, key: key, stable: stable, descending: descending)
    for (i in dataArray) {
        data.add(i)
    }
}

/**
 * Sorting element T.
 *
 * @param data List of elements to be sorted.
 * @param stable Whether to use stable sorting.
 * @param descending Indicates whether to use descending sorting.
 *
 */
public func sort<T>(data: ArrayList<T>, stable!: Bool = false, descending!: Bool = false): Unit where T <: Comparable<T> {
    unsafe {
        var dataArray = data.getRawArray()
        sort(dataArray[0..data.size], stable: stable, descending: descending)
        data.updateVersion()
    }
}

/**
 * Sorting element T.
 *
 * @param data List of elements to be sorted.
 * @param by Comparator.
 * @param stable Whether to use stable sorting.
 * @param descending Indicates whether to use descending sorting.
 *
 */
public func sort<T>(data: ArrayList<T>, by!: (T, T) -> Ordering, stable!: Bool = false, descending!: Bool = false): Unit {
    unsafe {
        var dataArray = data.getRawArray()
        sort(dataArray[0..data.size], by: by, stable: stable, descending: descending)
        data.updateVersion()
    }
}

/**
 * Sorting element T.
 *
 * @param data List of elements to be sorted.
 * @param lessThan Comparator.
 * @param stable Whether to use stable sorting.
 * @param descending Indicates whether to use descending sorting.
 *
 */
public func sort<T>(data: ArrayList<T>, lessThan!: (T, T) -> Bool, stable!: Bool = false, descending!: Bool = false): Unit {
    unsafe {
        var dataArray = data.getRawArray()
        sort(dataArray[0..data.size], lessThan: lessThan, stable: stable, descending: descending)
        data.updateVersion()
    }
}

/**
 * Sorting element T.
 *
 * @param data List of elements to be sorted.
 * @param key Mapping of elements T to K.
 * @param stable Whether to use stable sorting.
 * @param descending Indicates whether to use descending sorting.
 *
 */
public func sort<T, K>(data: ArrayList<T>, key!: (T) -> K, stable!: Bool = false, descending!: Bool = false): Unit where K <: Comparable<K> {
    unsafe {
        var dataArray = data.getRawArray()
        sort(dataArray[0..data.size], key: key, stable: stable, descending: descending)
        data.updateVersion()
    }
}

@Deprecated[message: "The interface is deprecated, no substitutions."]
public interface SortByExtension<T> {
    /**
     * Incoming Sort by Condition.
     *
     * @param comparator transfer the condition to be judged.
     *
     * @since 0.27.3
     */
    func sortBy(comparator!: (T, T) -> Ordering): Unit
    /**
     * Incoming Sort by Condition.
     *
     * @param comparator transfer the condition to be judged.
     * @param stable Whether to use stable sorting
     *
     * @since 0.27.3
     */
    func sortBy(stable!: Bool, comparator!: (T, T) -> Ordering): Unit
}

@Deprecated[message: "The interface is deprecated, no substitutions."]
public interface SortExtension {
    /**
     * Sort data in ascending order.
     *
     * @since 0.27.3
     */
    func sort(): Unit
    /**
     * Sort data in ascending order.
     *
     * @param stable Whether to use stable sorting
     *
     * @since 0.27.3
     */
    func sort(stable!: Bool): Unit

    /*
     * Sort data in descending order.
     *
     * @since 0.27.3
     */
    func sortDescending(): Unit
    /*
     * Sort data in descending order.
     *
     * @param stable Whether to use stable sorting
     *
     * @since 0.27.3
     */
    func sortDescending(stable!: Bool): Unit
}

extend<T> Array<T> <: SortByExtension<T> {
    @Deprecated[message: "Use global function `public func sort<T>(data: Array<T>, by!: (T, T) -> Ordering, stable!: Bool = false, descending!: Bool = false): Unit` instead."]
    public func sortBy(comparator!: (T, T) -> Ordering): Unit {
        unstableSort(this, comparator)
    }

    @Deprecated[message: "Use global function `public func sort<T>(data: Array<T>, by!: (T, T) -> Ordering, stable!: Bool = false, descending!: Bool = false): Unit` instead."]
    public func sortBy(stable!: Bool, comparator!: (T, T) -> Ordering): Unit {
        if (stable) {
            stableSort(this, comparator)
        } else {
            unstableSort(this, comparator)
        }
    }
}

extend<T> Array<T> <: SortExtension where T <: Comparable<T> {
    @Deprecated[message: "Use global function `public func sort<T>(data: Array<T>, stable!: Bool = false, descending!: Bool = false): Unit where T <: Comparable<T>` instead."]
    public func sort(): Unit {
        unstableSort(this)
    }

    @Deprecated[message: "Use global function `public func sort<T>(data: Array<T>, stable!: Bool = false, descending!: Bool = false): Unit where T <: Comparable<T>` instead."]
    public func sort(stable!: Bool): Unit {
        if (stable) {
            stableSort(this)
        } else {
            unstableSort(this)
        }
    }

    @Deprecated[message: "Use global function `public func sort<T>(data: Array<T>, stable!: Bool = false, descending!: Bool = false): Unit where T <: Comparable<T>` instead."]
    public func sortDescending(): Unit {
        let comparator = {l: T, r: T => r.compare(l)}
        unstableSort(this, comparator)
    }

    @Deprecated[message: "Use global function `public func sort<T>(data: Array<T>, stable!: Bool = false, descending!: Bool = false): Unit where T <: Comparable<T>` instead."]
    public func sortDescending(stable!: Bool): Unit {
        let comparator = {l: T, r: T => r.compare(l)}
        if (stable) {
            stableSort(this, comparator)
        } else {
            unstableSort(this, comparator)
        }
    }
}
