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
 * Converts an iteratable object to a specified collection type.
 */
package std.collection

/**
 * This function is used to convert Iterable<T> to String.
 *
 * @param delimiter Delimiter used in concatenation.
 * @return String A new string containing all elements's string value in original iterator.
 *
 */
public func collectString<T>(delimiter!: String = ""): (Iterable<T>) -> String where T <: ToString {
    return {
        it: Iterable<T> =>
        let iter = it.iterator()
        let first = iter.next()
        let builder = StringBuilder()
        match (first) {
            case Some(item) => builder.append(item.toString())
            case None => return ""
        }
        while (true) {
            match (iter.next()) {
                case Some(item) =>
                    builder.append(delimiter)
                    builder.append(item.toString())
                case None => break
            }
        }
        return builder.toString()
    }
}

/**
 * This function is used to convert Iterable<T> to Array<T>.
 *
 * @param it This is an Iterable.
 * @return Array<T> A new Array<T> containing all elements in original iterator.
 *
 */
@Frozen
public func collectArray<T>(it: Iterable<T>): Array<T> {
    return collectArrayList<T>(it).toArray()
}

/**
 * This function is used to convert Iterable<T> to ArrayList<T>.
 *
 * @param it This is an Iterable.
 * @return ArrayList<T> A new ArrayList<T> containing all elements in original iterator.
 *
 */
@Frozen
public func collectArrayList<T>(it: Iterable<T>): ArrayList<T> {
    let collector: ArrayList<T> = ArrayList<T>()
    for (item in it) {
        collector.add(item)
    }
    return collector
}

/**
 * This function is used to convert Iterable<T> to HashSet<T>.
 *
 * @param it This is an Iterable.
 * @return HashSet<T> A new HashSet<T> containing all elements in original iterator.
 *
 */
@Frozen
public func collectHashSet<T>(it: Iterable<T>): HashSet<T> where T <: Hashable & Equatable<T> {
    let set: HashSet<T> = HashSet<T>()
    for (item in it) {
        set.add(item)
    }
    return set
}

/**
 * This function is used to convert Iterable<(K, V)> to HashMap<K, V>.
 *
 * @param it This is an Iterable.
 * @return HashMap<K, V> A new HashMap<K, V> containing all elements in original iterator.
 *
 */
@Frozen
public func collectHashMap<K, V>(it: Iterable<(K, V)>): HashMap<K, V> where K <: Hashable & Equatable<K> {
    let map: HashMap<K, V> = HashMap<K, V>()
    for ((key, value) in it) {
        map.add(key, value)
    }
    return map
}
