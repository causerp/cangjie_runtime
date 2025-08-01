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
 * Operate on an iteratable object and return a target iterator.
 */
package std.collection

/**
 * This func enumerate returns an Iterator with index.
 *
 * @param it An Iteratable.
 * @return Iterator<Int64*T> An Iterator with index.
 *
 */
public func enumerate<T>(it: Iterable<T>): Iterator<(Int64, T)> {
    return it.iterator().enumerate()
}

/**
 * This func filter is used to filter Iterator<T>.
 *
 * @param predicate Filter condition.
 * @return (Iterable<T>) -> Iterator<T> A filter function accept an Iterable.
 *
 */
@Frozen
public func filter<T>(predicate: (T) -> Bool): (Iterable<T>) -> Iterator<T> {
    return {it: Iterable<T> => it.iterator().filter(predicate)}
}

/**
 * This func filterMap is used to filter and map Iterator<T>.
 *
 * @param transform Filter and map function.
 * @return (Iterable<T>) -> Iterator<R> A filterMap function accept an Iterable.
 *
 */
public func filterMap<T, R>(transform: (T) -> ?R): (Iterable<T>) -> Iterator<R> {
    return {it: Iterable<T> => it.iterator().filterMap<R>(transform)}
}

/**
 * This func map is used to Convert Iterable<T> to Iterator<R>.
 *
 * @param transform The callback function, that converts T to R.
 * @return (Iterable<T>) -> Iterator<R> A map function accept an Iterable as its input.
 *
 */
@Frozen
public func map<T, R>(transform: (T) -> R): (Iterable<T>) -> Iterator<R> {
    return {it: Iterable<T> => it.iterator().map<R>(transform)}
}

/**
 * This func flatten is used to flatten nested structure.
 *
 * @param it An Iteratable.
 * @return Iterator<R>, an Iterator removing one level of indirection.
 *
 */
public func flatten<T, R>(it: Iterable<T>): Iterator<R> where T <: Iterable<R> {
    return FlattenIterator<T, R>(it)
}

/**
 * This func flatMap is used to map and flatten Iterator.
 *
 * @param transform The callback function, that converts T to Iterable<R>.
 * @return (Iterable<T>) -> Iterator<R> A map-flatten function accept an Iterable as its input.
 *
 */
public func flatMap<T, R>(transform: (T) -> Iterable<R>): (Iterable<T>) -> Iterator<R> {
    return {it: Iterable<T> => FlatMapIterator<T, R>(it, transform)}
}

/**
 * This func zip is used to zip two Iterables into one (mainly the short one).
 *
 * @param other An Iteratable.
 * @return (Iterable<T>) -> Iterator<(T, R)> A zip function accept an Iterable as its input.
 *
 */
public func zip<T, R>(other: Iterable<R>): (Iterable<T>) -> Iterator<(T, R)> {
    return {it: Iterable<T> => it.iterator().zip<R>(other.iterator())}
}

/**
 * This func concat is used to concat two Iterables into one.
 *
 * @param other An Iteratable.
 * @return (Iterable<T>) -> Iterator<T> A concat function accept an Iterable as its input.
 *
 */
@Frozen
public func concat<T>(other: Iterable<T>): (Iterable<T>) -> Iterator<T> {
    return {it: Iterable<T> => it.iterator().concat(other.iterator())}
}

/**
 * This func skip is used to skip count in Iterable<T>.
 * if count < 0, an exception will be throwed.
 * if count == 0, no operations will be done.
 * if 0 < count < size, return the remainning elements after skipping.
 * if count >= size, skip all elements and return an empty Iterator.
 *
 * @param count This is an Int64,number of skip.
 * @return (Iterable<T>) -> Iterator<T> A skip function accept an Iterable as its input.
 * @throws IllegalArgumentException if skip count is less than 0.
 */
public func skip<T>(count: Int64): (Iterable<T>) -> Iterator<T> {
    return {it: Iterable<T> => it.iterator().skip(count)}
}

/**
 * This func take is used to take count in Iterable<T>.
 *
 * @param count This is an Int64
 * @return (Iterable<T>) -> Iterator<T> A take function accept an Iterable as its input.
 * @throws IllegalArgumentException if count is less than 0.
 */
public func take<T>(count: Int64): (Iterable<T>) -> Iterator<T> {
    return {it: Iterable<T> => it.iterator().take(count)}
}

/**
 * This func step is used to step count in Iterable<T>.
 *
 * @param count This is an Int64, number of step.
 * @return (Iterable<T>) -> Iterator<T> A step function accept an Iterable as its input.
 * @throws IllegalArgumentException if step count is less than 0.
 */
public func step<T>(count: Int64): (Iterable<T>) -> Iterator<T> {
    return {it: Iterable<T> => it.iterator().step(count)}
}

/**
 * This func inspect performs an extra operation on the current element each time when use next().
 *
 * @param action The function executed by each element.
 * @return (Iterable<T>) -> Iterator<T> An iteration function accept an Iterable as its input.
 *
 */
public func inspect<T>(action: (T) -> Unit): (Iterable<T>) -> Iterator<T> {
    return {it: Iterable<T> => it.iterator().inspect(action)}
}

class FlattenIterator<T, R> <: Iterator<R> where T <: Iterable<R> {
    private var subIt: Option<Iterator<R>> = None
    private let it: Iterator<T>

    /**
     * Flatten Iterator.
     *
     * @param it Iterable.
     *
     */
    init(it: Iterable<T>) {
        this.it = it.iterator()
    }

    /**
     * Get flatten Iterator next.
     *
     * @return Option<R> The return type of Option<R>.
     */
    @Frozen
    public func next(): Option<R> {
        /**
         * Check whether subIt is consumed.
         * If yes, return the resulting value.
         * If not, reset subIt and continue to check from the beginning.
         */
        while (true) {
            match (subIt) {
                case Some(result) => match (result.next()) {
                    case Some(v) => return Some(v)
                    case _ => ()
                }
                case _ => ()
            }

            match (it.next()) {
                case Some(sub) => subIt = Some(sub.iterator())
                case _ => return None
            }
        }
        return None
    }
}

class FlatMapIterator<T, R> <: Iterator<R> {
    private var subIt: Option<Iterator<R>> = None
    private let transform: (T) -> Iterable<R>
    private let it: Iterator<T>

    /*
     * All elements are converted to Iterator<R> by transform func.
     *
     * @param it Iterable.
     * @param transform Transform func.
     *
     * @return Option<R> The return type of Option<R>.
     */
    init(it: Iterable<T>, transform: (T) -> Iterable<R>) {
        this.it = it.iterator()
        this.transform = transform
    }

    /*
     * Get FlatMap Iterator next.
     *
     * @return Option<R> The return type of Option<R>.
     */
    @Frozen
    public func next(): Option<R> {
        /**
         * Check whether subIt is consumed.
         * If yes, return the resulting value.
         * If not, reset subIt and continue to check from the beginning.
         */
        while (true) {
            match (subIt) {
                case Some(result) => match (result.next()) {
                    case Some(v) => return Some(v)
                    case _ => ()
                }
                case _ => ()
            }

            match (it.next()) {
                case Some(sub) => subIt = Some(transform(sub).iterator())
                case _ => return None
            }
        }
        return None
    }
}
