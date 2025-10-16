/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest.common

/**
 * Component of the DataStrategy that is used to provide data to test
 * @param T the type of the data this provider provides
 */
public interface DataProvider<T> {
    /**
     * Get the data provided by this provider
     * @return the data in the form of an Iterable<T>
     */
    func provide(): Iterable<T>
}

/**
 * Component of the DataStrategy that is used to reduce the data during testing
 * @param T the type of the data this shrinker handles
 */
public interface DataShrinker<T> {
    /**
     * Take a value of type T and produce a collection of smaller values.
     * What is considered "smaller" depends on the type of the data
     * @param value the value to reduce
     * @return a collection of smaller values, or empty collection if the data cannot be reduced further
     */
    func shrink(value: T): Iterable<T>
}

/**
 * Implementation of DataShrinker that does nothing
 */
class NoShrinker<T> <: DataShrinker<T> {
    /**
     * Take a value of type T and produce a collection of smaller values.
     * Always returns an empty array.
     * @param value the value to reduce, always ignored
     */
    public override func shrink(_: T): Iterable<T> { [] }

    /**
     * Singleton instance of NoShrinker<T>
     */
    static func instance(): DataShrinker<T> {
        NoShrinker<T>()
    }
}

/**
 * A strategy that provides data to a parameterized test
 * @param T the type of the data this strategy operates on
 */
public interface DataStrategy<T> {
    /**
     * Get the provider component of this strategy given configuration
     * @param configuration the configuration object
     * @return the data provider
     */
    func provider(configuration: Configuration): DataProvider<T>
    /**
     * Get the provider shrinker of this strategy given configuration, default implementation does nothing
     * @param configuration the configuration object
     * @return the data shrinker
     */
    func shrinker(configuration: Configuration): DataShrinker<T> {
        NoShrinker<T>.instance()
    }

    /**
     * Does this strategy expects to be
     * @return true if the result of `provider` should be iterated indefinitely, false otherwise
     */
    prop isInfinite: Bool {
        get() { false }
    }
}

/**
 * The implementation of DataStrategy interface for Array
 * Is needed to allow tests in the form
 * ```
 * @Test[x in [1,2,3]]
 * func test(x: Int64) {}
 * ```
 */
extend<T> Array<T> <: DataStrategy<T> & DataProvider<T> {
    /**
     * Get the provided data from the provider
     * @return this
     */
    public func provide(): Iterable<T> { this }
    /**
     * Is this provider infinite?
     * @returns false
     */
    public prop isInfinite: Bool {
        get() { false }
    }
    /**
     * Get the provider using the configuration object. Does not actually use any configuration.
     * @return this
     */
    public func provider(_: Configuration): DataProvider<T> { this }
}
/**
 * The implementation of DataStrategy interface for Range
 * Is needed to allow tests in the form
 * ```
 * @Test[x in (0..5)]
 * func test(x: Int64) {}
 * ```
 */
extend<T> Range<T> <: DataStrategy<T> & DataProvider<T> {
    /**
     * Get the provided data from the provider
     * @return this
     */
    public func provide(): Iterable<T> { this }
    /**
     * Is this provider infinite?
     * @returns false
     */
    public prop isInfinite: Bool {
        get() { false }
    }
    /**
     * Get the provider using the configuration object. Does not actually use any configuration.
     * @return this
     */
    public func provider(_: Configuration): DataProvider<T> { this }
}
