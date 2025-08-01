/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest.prop_test

import std.collection.filter
import std.unittest.common.*

public struct KeyRandom <: KeyFor<RandomSource> {
    public static prop random: KeyRandom {
        get() {
            KeyRandom()
        }
    }

    public prop name: String {
        get() {
            "random"
        }
    }
}

class GeneratorAsIterator<T> <: Iterator<T> {
    GeneratorAsIterator(private var gen: ?Generator<T>) {}
    public override func next(): ?T {
        // return exactly one random result
        let result = gen?.next()
        gen = None
        return result
    }
}

/**
 * An implementation of DataProvider interface using random data generation.
 * Supported configuration:
 * - "random" of type std.random.Random the random generator to use
 * @param T the type of data to provide
 */
public class RandomDataProvider<T> <: DataProvider<T> where T <: Arbitrary<T> {

    /**
     * Random data provider constructor
     * @param configuration the configuration object, this must contain a random generator
     *                      with name "random" and type random.RandomSource
     * @throws IllegalArgumentException if the configuration does not contain instance of random
     */
    public RandomDataProvider(private let configuration: Configuration) {
        this.random = configuration.get<RandomSource>(KeyRandom.random) ??
                throw IllegalArgumentException("RandomDataProvider initialized without configured random generator instance")
    }
    /**
     * Provide the randomly generated data
     * @return An infinite Iterable created from Arbitrary instance for T
     */
    public override func provide(): Iterable<T> {
        return GeneratorAsIterator(T.arbitrary(random))
    }

    private let random: RandomSource
}

/**
 * An implementation of DataShrinker interface using random data generation.
 * @param T the type of data to reduce
 */
public class RandomDataShrinker<T> <: DataShrinker<T> {
    /**
     * Reduce the given value using Shrink instance
     * @return if value implements Shrink<T>, return reduced values
     *         if value does not implement Shrink<T>, return empty array
     */
    public override func shrink(value: T): Iterable<T> {
        match (value) {
            case shrinkable: Shrink<T> => shrinkable.shrink()
            case _ => []
        }
    }
}

/**
 * An implementation of DataStrategy interface using random data generation.
 * @param T the type of data to generate
 */
public class RandomDataStrategy<T> <: DataStrategy<T> where T <: Arbitrary<T> {
    /**
     * Get the provider of random data. Returns an instance of RandomDataProvider
     * @param configuration the configuration object
     *        Uses the following configuration keys:
     *        - "random" of type std.random.Random: the random generator to use for generation
     */
    public override func provider(configuration: Configuration): RandomDataProvider<T> {
        RandomDataProvider<T>(configuration)
    }
    /**
     * Get the reducer of random data. Returns an instance of RandomDataShrinker
     * @param configuration the configuration object, ignored for now
     */
    public override func shrinker(_: Configuration): RandomDataShrinker<T> {
        RandomDataShrinker<T>()
    }

    /**
     * Does this produce infinite data?
     * @return always true
     */
    public override prop isInfinite: Bool {
        get() { true }
    }
}

/**
 * An implementation of DataStrategy interface using random data generation.
 * @param T the type of data to generate
 * @return an instance of RandomDataStrategy<T>
 */
public func random<T>(): RandomDataStrategy<T> where T <: Arbitrary<T> {
    RandomDataStrategy<T>()
}

public class RandomDataProviderRange<T> <: DataProvider<T> where T <: ArbitraryRange<T> {
    public RandomDataProviderRange(private let configuration: Configuration, private let min: T, private let max: T) {
        this.random = configuration.get<RandomSource>(KeyRandom.random) ??
                throw IllegalArgumentException("RandomDataProvider initialized without configured random generator instance")
    }

    public override func provide(): Iterable<T> {
        return GeneratorAsIterator(T.arbitraryRange(random, min, max))
    }

    private let random: RandomSource
}

public class RandomDataShrinkerRange<T> <: DataShrinker<T> where T <: Comparable<T> {
    RandomDataShrinkerRange(private let min: T, private let max: T) {}

    public override func shrink(value: T): Iterable<T> {
        match (value) {
            case shrinkable: Shrink<T> => shrinkable.shrink() |> filter { it => min <= it && it <= max }
            case _ => []
        }
    }
}

public class RandomDataStrategyRange<T> <: DataStrategy<T> where T <: ArbitraryRange<T> {
    RandomDataStrategyRange(private let min: T, private let max: T) {}

    public override func provider(configuration: Configuration): RandomDataProviderRange<T> {
        RandomDataProviderRange<T>(configuration, min, max)
    }

    public override func shrinker(_: Configuration): RandomDataShrinkerRange<T> {
        RandomDataShrinkerRange<T>(min, max)
    }

    public override prop isInfinite: Bool {
        get() { true }
    }
}

public func randomInRange<T>(min!: Option<T> = None, max!: Option<T> = None): RandomDataStrategyRange<T> where T <: ArbitraryRange<T> {
    if ((min ?? T.min()) > (max ?? T.max())) {
        throw IllegalArgumentException("the interval you provided is empty")
    }
    RandomDataStrategyRange<T>(min ?? T.min(), max ?? T.max())
}
