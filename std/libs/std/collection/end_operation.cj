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
 * Operate on each item of an iteratable object.
 */
package std.collection

/**
 * This func reduce is calculated from left to right using the first value as initial value.
 *
 * @param operation This is the callback function that executes each value in Iterator.
 * @return (Iterable<T>) -> Option<T> An iteration function accept an Iterable as its input.
 *
 */
@Frozen
public func reduce<T>(operation: (T, T) -> T): (Iterable<T>) -> Option<T> {
    return {
        it: Iterable<T> =>
        var itt = it.iterator()
        var result: T = itt.next() ?? return None
        while (let Some(value) <- itt.next()) {
            result = operation(result, value)
        }
        return result
    }
}

/**
 * This func fold is calculated from left to right using the specified initial value.
 *
 * @param initial This is initial value.
 * @param operation This is the callback function that executes each value in Iterator.
 * @return (Iterable<T>) -> R An iteration function accept an Iterable as its input.
 *
 */
public func fold<T, R>(initial: R, operation: (R, T) -> R): (Iterable<T>) -> R {
    return {
        it: Iterable<T> =>
        var result: R = initial
        for (item in it) {
            result = operation(result, item)
        }
        return result
    }
}

/**
 * This func isEmpty is used to check whether Iterable<T> is empty.
 *
 * @param it An Iteratable.
 * @return Bool Whether the Iterable is empty.
 *
 */
public func isEmpty<T>(it: Iterable<T>): Bool {
    return match (it.iterator().next()) {
        case None => true
        case _ => false
    }
}

/**
 * This func count is used to count the number of Iterable<T>.
 *
 * @param it An Iteratable.
 * @return Int64 The number of the Iterable.
 *
 */
public func count<T>(it: Iterable<T>): Int64 {
    var count: Int64 = 0
    for (_ in it) {
        count++
    }
    return count
}

/**
 * This func contains is used to check whether Iterable<T> contains a specified element.
 *
 * @param element The specified element.
 * @return (Iterable<T>) -> Bool An iteration function accept an Iterable as its input.
 *
 */
public func contains<T>(element: T): (Iterable<T>) -> Bool where T <: Equatable<T> {
    return {
        it: Iterable<T> =>
        for (item in it) {
            if (item == element) {
                return true
            }
        }
        return false
    }
}

/**
 * This func max is used to find the maximum value of Iterable<T>.
 *
 * @param it An Iteratable.
 * @return Option<T> The maximum value.
 *
 */
public func max<T>(it: Iterable<T>): Option<T> where T <: Comparable<T> {
    var result: Option<T> = None
    for (item in it) {
        match (result) {
            case Some(value) =>
                if (item > value) {
                    result = Some(item)
                }
            case _ => result = Some(item)
        }
    }
    return result
}

/**
 * This func min is used to find the minimum value of Iterable<T>.
 *
 * @param it An Iteratable.
 * @return Option<T> The minimum value.
 *
 */
public func min<T>(it: Iterable<T>): Option<T> where T <: Comparable<T> {
    var result: Option<T> = None
    for (item in it) {
        match (result) {
            case Some(value) =>
                if (item < value) {
                    result = Some(item)
                }
            case _ => result = Some(item)
        }
    }
    return result
}

/**
 * This func all is used to check whether all elements pass the test.
 *
 * @param predicate The function used to test each element.
 * @return (Iterable<T>) -> Bool An iteration function accept an Iterable as its input.
 *
 */
public func all<T>(predicate: (T) -> Bool): (Iterable<T>) -> Bool {
    return {
        it: Iterable<T> =>
        for (item in it) {
            if (!predicate(item)) {
                return false
            }
        }
        return true
    }
}

/**
 * This func any is used to check that at least one element passes the test.
 *
 * @param predicate The function used to test each element.
 * @return (Iterable<T>) -> Bool An iteration function accept an Iterable as its input.
 *
 */
public func any<T>(predicate: (T) -> Bool): (Iterable<T>) -> Bool {
    return {
        it: Iterable<T> =>
        for (item in it) {
            if (predicate(item)) {
                return true
            }
        }
        return false
    }
}

/**
 * This func none is used to check whether all elements fail the test.
 *
 * @param predicate The function used to test each element.
 * @return (Iterable<T>) -> Bool An iteration function accept an Iterable as its input.
 *
 */
public func none<T>(predicate: (T) -> Bool): (Iterable<T>) -> Bool {
    return {
        it: Iterable<T> =>
        for (item in it) {
            if (predicate(item)) {
                return false
            }
        }
        return true
    }
}

/**
 * This func first is used to get the first element of the Iterator.
 *
 * @param it An Iteratable.
 * @return Option<T> The first element.
 *
 */
public func first<T>(it: Iterable<T>): Option<T> {
    return it.iterator().next()
}

/**
 * This func last is used to get the last element of the Iterator.
 *
 * @param it An Iteratable.
 * @return Option<T> The last element.
 *
 */
public func last<T>(it: Iterable<T>): Option<T> {
    var result: Option<T> = None
    for (item in it) {
        result = Some(item)
    }
    return result
}

/**
 * This func at function is used to get the specified index element of the iterator.
 *
 * @param n The specified index.
 * @return (Iterable<T>) -> Option<T> An iteration function accept an Iterable as its input.
 *
 */
public func at<T>(n: Int64): (Iterable<T>) -> Option<T> {
    return {
        it: Iterable<T> =>
        if (n < 0) {
            return None
        }
        var i: Int64 = 0
        for (item in it) {
            if (i == n) {
                return Some(item)
            }
            i++
        }
        return None
    }
}

/**
 * This func forEach function is used to perform a specific function on each element of Iterable.
 *
 * @param action The function executed by each element.
 * @return (Iterable<T>) -> Unit An iteration function accept an Iterable as its input.
 *
 */
public func forEach<T>(action: (T) -> Unit): (Iterable<T>) -> Unit {
    return {
        it: Iterable<T> => for (item in it) {
            action(item)
        }
    }
}
