/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest.prop_test

import std.random.Random

/**
 * Generator: similar to an iterator, but next() is non-optional, so the values are produced infinitely
 */
public interface Generator<T> {
    /**
     * Next value of this generator
     */
    func next(): T
}

class OneValueGenerator<T> <: Generator<T> {
    OneValueGenerator(let value: T) {}

    public override func next(): T {
        value
    }
}

class FunctionGenerator<T> <: Generator<T> {
    FunctionGenerator(let body: () -> T) {}

    public override func next(): T {
        body()
    }
}

class ArrayGenerator<T> <: Generator<T> {
    ArrayGenerator(let random: RandomSource, let array: Array<T>) {}

    public override func next(): T {
        array[random.nextInt64(array.size)]
    }
}

class SelectionGenerator<T> <: Generator<T> {
    private let total: UInt64

    SelectionGenerator(let random: RandomSource, let variants: Array<(UInt64, Generator<T>)>) {
        var total: UInt64 = 0
        for ((v, _) in variants) {
            total += v
        }
        this.total = total
    }

    public override func next(): T {
        var pick = random.nextUInt64(total)
        for ((n, g) in variants) {
            if (pick < n) {
                return g.next()
            }

            pick -= n
        }

        // should never happen
        variants[variants.size - 1][1].next()
    }
}

class RangeGenerator<T> <: Generator<T> {
    let l: T
    let r: T
    RangeGenerator(l: T, r: T, let body: (T, T) -> T) {
        this.l = l
        this.r = r
    }
    public override func next(): T {
        body(l, r)
    }
}

/**
 * Class that contains helper functions to help developer write their own Generators
 **/
public class Generators {
    /**
     * Generator that generates values by repeatedly calling a function body that generates random values in [l, r]
     */
    public static func generate<T>(l: T, r: T, body: (T, T) -> T): Generator<T> {
        RangeGenerator(l, r, body)
    }
    /**
     * Generator that always returns the same value
     */
    public static func single<T>(value: T): Generator<T> {
        FunctionGenerator({=> value})
    }
    /**
     * Generator that generates values by repeatedly calling a function
     */
    public static func generate<T>(body: () -> T): Generator<T> {
        FunctionGenerator(body)
    }
    /**
     * Generator that generates values by picking randomly from an array
     */
    public static func iterable<T>(random: RandomSource, collection: Array<T>): Generator<T> {
        ArrayGenerator<T>(random, collection)
    }
    /**
     * Generator that generates values by picking randomly from an array of pairs (weight, generator).
     * The result is randomly chosen between the generators in the array with higher weight having higher probability.
     */
    public static func weighted<T>(random: RandomSource, variants: Array<(UInt64, Generator<T>)>): Generator<T> {
        SelectionGenerator<T>(random, variants)
    }
    /**
     * Generator that generates values by picking randomly from an array of generators.
     * The result is randomly chosen between the generators in the array uniformly.
     */
    public static func pick<T>(random: RandomSource, variants: Array<Generator<T>>): Generator<T> {
        SelectionGenerator<T>(random, Array(variants.size) {i: Int64 => (UInt64(1), variants[i])})
    }
    /**
     * Get the generator provided by T's Arbitrary instance
     */
    public static func lookup<T>(random: RandomSource): Generator<T> where T <: Arbitrary<T> {
        T.arbitrary(random)
    }
    /**
     * Get the generator provided by T's Arbitrary instance and use function body to generate values of type R
     */
    public static func mapped<T, R>(random: RandomSource, body: (T) -> R): Generator<R> where T <: Arbitrary<T> {
        let base = lookup<T>(random)
        generate {body(base.next())}
    }
    /**
     * Get the generators provided by T1 and T2 Arbitrary instances and use function body to generate values of type R
     */
    public static func mapped<T1, T2, R>(random: RandomSource, body: (T1, T2) -> R): Generator<R> where T1 <: Arbitrary<T1>,
        T2 <: Arbitrary<T2> {
        let v1 = lookup<T1>(random)
        let v2 = lookup<T2>(random)
        generate {body(v1.next(), v2.next())}
    }
    /**
     * Get the generators provided by T1, T2 and T3 Arbitrary instances and use function body to generate values of type R
     */
    public static func mapped<T1, T2, T3, R>(random: RandomSource, body: (T1, T2, T3) -> R): Generator<R> where T1 <: Arbitrary<T1>,
        T2 <: Arbitrary<T2>, T3 <: Arbitrary<T3> {
        let v1 = lookup<T1>(random)
        let v2 = lookup<T2>(random)
        let v3 = lookup<T3>(random)
        generate {body(v1.next(), v2.next(), v3.next())}
    }
    /**
     * Get the generators provided by T1, T2, T3 and T4 Arbitrary instances and use function body to generate values of type R
     */
    public static func mapped<T1, T2, T3, T4, R>(random: RandomSource, body: (T1, T2, T3, T4) -> R): Generator<R> where T1 <: Arbitrary<T1>,
        T2 <: Arbitrary<T2>, T3 <: Arbitrary<T3>, T4 <: Arbitrary<T4> {
        let v1 = lookup<T1>(random)
        let v2 = lookup<T2>(random)
        let v3 = lookup<T3>(random)
        let v4 = lookup<T4>(random)
        generate {body(v1.next(), v2.next(), v3.next(), v4.next())}
    }
}
