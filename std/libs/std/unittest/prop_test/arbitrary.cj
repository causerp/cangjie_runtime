/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest.prop_test

import std.collection.*
import std.math.abs

/*
 * Arbitrary is an interface that allows to generate random values of type T
 */
public interface Arbitrary<T> {
    static func arbitrary(random: RandomSource): Generator<T>
}

// this does not compile (backend error)
// extend Nothing <: Arbitrary<Nothing> {
//     public static func arbitrary(random: RandomSource): Generator<Nothing> {
//         Generators.generate<Nothing> { => throw Exception("Arbitrary<Nothing>.generate") }
//     }
// }

/*
 * Arbitrary instance for Unit: always returns ()
 */
extend Unit <: Arbitrary<Unit> {
    public static func arbitrary(_: RandomSource): Generator<Unit> {
        Generators.single(())
    }
}

/*
 * Arbitrary instance for Bool: returns true or false randomly
 */
extend Bool <: Arbitrary<Bool> {
    public static func arbitrary(random: RandomSource): Generator<Bool> {
        Generators.generate { random.suggestBool() }
    }
}

/*
 * Arbitrary instance for signed integer: has a higher probability of generating
 * border values: 0, 1, -1, Max and Min
 */
extend Int8 <: Arbitrary<Int8> {
    public static func arbitrary(random: RandomSource): Generator<Int8> {
        Generators.generate { random.suggestInt8() }
    }
}

/*
 * Arbitrary instance for signed integer: has a higher probability of generating
 * border values: 0, 1, -1, Max and Min. Short numbers are generated more frequently.
 */
extend Int16 <: Arbitrary<Int16> {
    public static func arbitrary(random: RandomSource): Generator<Int16> {
        Generators.generate { random.suggestInt16() }
    }
}

/*
 * Arbitrary instance for signed integer: has a higher probability of generating
 * border values: 0, 1, -1, Max and Min. Short numbers are generated more frequently.
 */
extend Int32 <: Arbitrary<Int32> {
    public static func arbitrary(random: RandomSource): Generator<Int32> {
        Generators.generate { random.suggestInt32() }
    }
}

/*
 * Arbitrary instance for signed integer: has a higher probability of generating
 * border values: 0, 1, -1, Max and Min. Short numbers are generated more frequently.
 */
extend Int64 <: Arbitrary<Int64> {
    public static func arbitrary(random: RandomSource): Generator<Int64> {
        Generators.generate { random.suggestInt64() }
    }
}

/*
 * Arbitrary instance for signed integer: has a higher probability of generating
 * border values: 0, 1, -1, Max and Min. Short numbers are generated more frequently.
 */
extend IntNative <: Arbitrary<IntNative> {
    public static func arbitrary(random: RandomSource): Generator<IntNative> {
        Generators.generate { random.suggestIntNative() }
    }
}

/*
 * Arbitrary instance for unsigned integer: has a higher probability of generating
 * border values: 0, 1 and Max
 */
extend UInt8 <: Arbitrary<UInt8> {
    public static func arbitrary(random: RandomSource): Generator<UInt8> {
        Generators.generate { random.suggestUInt8() }
    }
}

/*
 * Arbitrary instance for unsigned integer: has a higher probability of generating
 * border values: 0, 1 and Max. Short numbers are generated more frequently.
 */
extend UInt16 <: Arbitrary<UInt16> {
    public static func arbitrary(random: RandomSource): Generator<UInt16> {
        Generators.generate { random.suggestUInt16() }
    }
}

/*
 * Arbitrary instance for unsigned integer: has a higher probability of generating
 * border values: 0, 1 and Max
 */
extend UInt32 <: Arbitrary<UInt32> {
    public static func arbitrary(random: RandomSource): Generator<UInt32> {
        Generators.generate { random.suggestUInt32() }
    }
}

/*
 * Arbitrary instance for unsigned integer: has a higher probability of generating
 * border values: 0, 1 and Max
 */
extend UInt64 <: Arbitrary<UInt64> {
    public static func arbitrary(random: RandomSource): Generator<UInt64> {
        Generators.generate { random.suggestUInt64() }
    }
}

/*
 * Arbitrary instance for unsigned integer: has a higher probability of generating
 * border values: 0, 1 and Max. Short numbers are generated more frequently.
 */
extend UIntNative <: Arbitrary<UIntNative> {
    public static func arbitrary(random: RandomSource): Generator<UIntNative> {
        Generators.generate { random.suggestUIntNative() }
    }
}

/*
 * Arbitrary instance for float: returns random float
 */
extend Float16 <: Arbitrary<Float16> {
    public static func arbitrary(random: RandomSource): Generator<Float16> {
        Generators.generate { random.suggestFloat16() }
    }
}

/*
 * Arbitrary instance for float: returns random float
 */
extend Float32 <: Arbitrary<Float32> {
    public static func arbitrary(random: RandomSource): Generator<Float32> {
        Generators.generate { random.suggestFloat32() }
    }
}

/*
 * Arbitrary instance for float: returns random float
 */
extend Float64 <: Arbitrary<Float64> {
    public static func arbitrary(random: RandomSource): Generator<Float64> {
        Generators.generate { random.suggestFloat64() }
    }
}

/*
 * Arbitrary instance for Rune: has a higher probability to return characters from basic set,
 * otherwise can return any valid UTF-8 character
 */
extend Rune <: Arbitrary<Rune> {
    public static func arbitrary(random: RandomSource): Generator<Rune> {
        Generators.generate { random.suggestRune() }
    }
}

let SIZE_UPPER_LIMIT = 4000

func sizeGenerator(random: RandomSource): Generator<Int64> {
    func suggestSizeUpTo(max: Int64): Int64 {
        var size = random.nextInt64()
        if (size == Int64.Min) { size = max - 1 }
        return abs(size) % max
    }

    func approximatedNormalDist(sigma: Int64) {
        let t = sigma / 8
        /* ideally, we want normal distribution with mean = 0, deviation = sigma
           let's approximate it with uniform piecewise function with period t = sigma/8

           Let Q_N be the probability of getting what we want from (0, end_of_interval)
           for each interval as follows

           P(1t..2t) = Q1/1 + Q2/2 + Q3/3 + Q4/4 + Q5/5 + Q6/6 + Q7/7
               + Q8/8 + Q9/10 + Q10/12 + Q11/14 + Q12/16 + Q13/24 + Q4/32 + Q15/40
           P(2t..3t) = Q2/2 + Q3/3 + Q4/4 + Q5/5 + Q6/6 + Q7/7 + Q8/8
               + Q9/10 + Q10/12 + Q11/14 + Q12/16 + Q13/24 + Q4/32 + Q15/40
           P(3t..4t) = Q3/3 + Q4/4 + Q5/5 + Q6/6 + Q7/7 + Q8/8 + Q9/10
               + Q10/12 + Q11/14 + Q12/16 + Q13/24 + Q4/32 + Q15/40
           P(4t..5t) = Q4/4 + Q5/5 + Q6/6 + Q7/7 + Q8/8 + Q9/10
               + Q10/12 + Q11/14 + Q12/16 + Q13/24 + Q4/32 + Q15/40
           P(5t..6t) = Q5/5 + Q6/6 + Q7/7 + Q8/8 + Q9/10 + Q10/12
               + Q11/14 + Q12/16 + Q13/24 + Q4/32 + Q15/40
           P(6t..7t) = Q6/6 + Q7/7 + Q8/8 + Q9/10 + Q10/12
               + Q11/14 + Q12/16 + Q13/24 + Q4/32 + Q15/40
           P(7t..8t) = Q7/7 + Q8/8 + Q9/10 + Q10/12 + Q11/14
               + Q12/16 + Q13/24 + Q4/32 + Q15/40
           // after 1 sigma we go by 1/4 sigma = 2t
           P(8t..10t) = Q8/8 + Q9/10 + Q10/12 + Q11/14 + Q12/16 + Q13/24 + Q4/32 + Q15/40
           P(10t..12t) = Q9/5 + Q10/6 + Q11/7 + Q12/8 + Q13/12 + Q4/16 + Q15/20
           P(12t..14t) = Q10/6 + Q11/7 + Q12/8 + Q13/12 + Q4/16 + Q15/20
           P(14t..16t) = Q11/7 + Q12/8 + Q13/12 + Q4/16 + Q15/20
           // after 2 sigma we go by 1 sigma = 8t
           P(16t..24t) = Q12/8 + Q13/12 + Q4/16 + Q15/20
           P(24t..32t) = Q13/3 + Q4/4 + Q15/5
           P(32t..40t) = Q4/4 + Q15/5

           The overall logic of the above equation is the following: something from interval (a, b)
           can be acqured from any interval (0, c) containing (a, b) with probability c / (b - a)
           so every Q needs to be multiplied by the size it covers and divided by size of corresponding piece

           Why these 15 periods? Because it gives a visually good approximation.

           using normal distribution probability calculator, we find

           P(1t..2t) = 9.94%
           P(2t..3t) = 9.8%
           P(3t..4t) = 9.5%
           P(4t..5t) = 9.06%
           P(5t..6t) = 8.52%
           P(6t..7t) = 7.88%
           P(7t..8t) = 7.16%
           P(8t..10t) = 6.42%
           P(10t..12t) = 10.6%
           P(12t..14t) = 7.76%
           P(14t..16t) = 5.34%
           P(16t..24t) = 3.46%
           P(24t..32t) = 4.28%
           P(32t..40t) = 0.26%
           P(>40t) = 0.02%

           All the equations solved for each Q give us

           Q1 = 0.14
           Q2 = 0.6
           Q3 = 1.32
           Q4 = 2.16
           Q5 = 3.2
           Q6 = 4.32
           Q7 = 5.18
           Q8 = 8.96
           Q9 = 14.2
           Q10 = 14.52
           Q11 = 13.16
           Q12 = 19.12
           Q13 = 12.06
           Q14 = 0.96
           Q15 = 0.1, but we just leave the rest to max limit

           Generators.weighted requires integers, so we multiply by 50 and round to integer
         */
        Generators.weighted<Int64>(
            random,
            [
                (7, Generators.generate {suggestSizeUpTo(1 * t)}),
                (30, Generators.generate {suggestSizeUpTo(2 * t)}),
                (66, Generators.generate {suggestSizeUpTo(3 * t)}),
                (108, Generators.generate {suggestSizeUpTo(4 * t)}),
                (160, Generators.generate {suggestSizeUpTo(5 * t)}),
                (216, Generators.generate {suggestSizeUpTo(6 * t)}),
                (259, Generators.generate {suggestSizeUpTo(7 * t)}),
                (448, Generators.generate {suggestSizeUpTo(8 * t)}),
                (710, Generators.generate {suggestSizeUpTo(10 * t)}),
                (726, Generators.generate {suggestSizeUpTo(12 * t)}),
                (658, Generators.generate {suggestSizeUpTo(14 * t)}),
                (956, Generators.generate {suggestSizeUpTo(16 * t)}),
                (603, Generators.generate {suggestSizeUpTo(24 * t)}),
                (48, Generators.generate {suggestSizeUpTo(32 * t)}),
                (5, Generators.generate {suggestSizeUpTo(SIZE_UPPER_LIMIT)})
            ]
        )
    }

    const sigma = 256
    Generators.weighted<Int64>(
        random,
        [
            (5, Generators.single(0)),
            (5, Generators.single(1)),
            (90, approximatedNormalDist(sigma))
        ]
    )
}

/*
 * Arbitrary instance for Array: has a higher probability to generate empty or single-element arrays,
 * the size is random but leaned towards smaller values and not bigger than SIZE_UPPER_LIMIT
 * Elements are random according to their respective Arbitrary instances
 */
extend<T> Array<T> <: Arbitrary<Array<T>> where T <: Arbitrary<T> {
    public static func arbitrary(random: RandomSource): Generator<Array<T>> {
        let elementGenerator = T.arbitrary(random)
        let sizeGenerator = sizeGenerator(random)

        Generators.weighted<Array<T>>(
            random,
            [
                (10, Generators.single([])),
                (10, Generators.generate {[elementGenerator.next()]}),
                (80, Generators.generate {
                    var size = sizeGenerator.next()
                    Array<T>(size) { _ => elementGenerator.next() }
                })
            ]
        )
    }
}

/*
 * ArrayList instance size has same principals as for Array
 */
extend<T> ArrayList<T> <: Arbitrary<ArrayList<T>> where T <: Arbitrary<T> {
    // `Generators.mapped` not used due to possible OOM,
    // So here is copypaste of `Arbitrary<Array<T>>`
    public static func arbitrary(random: RandomSource): Generator<ArrayList<T>> {
        let elementGenerator = T.arbitrary(random)
        let sizeGenerator = sizeGenerator(random)

        Generators.weighted<ArrayList<T>>(
            random,
            [
                (10, Generators.single(ArrayList<T>([]))),
                (10, Generators.generate { ArrayList<T>([elementGenerator.next()]) }),
                (80, Generators.generate {
                    var size = sizeGenerator.next()
                    ArrayList<T>(size) { _ => elementGenerator.next() }
                })
            ]
        )
    }
}

/*
 * HashSet instance size has same principals as for Array
 */
extend<T> HashSet<T> <: Arbitrary<HashSet<T>> where T <: Arbitrary<T> {
    // `Generators.mapped` not used due to possible OOM,
    // So here is copypaste of `Arbitrary<HashMap<T, Unit>>`
    public static func arbitrary(random: RandomSource): Generator<HashSet<T>> {
        let elementGenerator = T.arbitrary(random)
        let sizeGenerator = sizeGenerator(random)

        Generators.weighted<HashSet<T>>(
            random,
            [
                (10, Generators.single(HashSet<T>())),
                (10, Generators.generate { HashSet<T>([elementGenerator.next()]) }),
                (80, Generators.generate {
                    var size = sizeGenerator.next()

                    let set = HashSet<T>()
                    for (_ in 0..size) {
                        let v = elementGenerator.next()
                        set.add(v)
                    }

                    return set
                })
            ]
        )
    }
}

/*
 * instance size has same principals as for Array
 * Keys and values are random according to their respective Arbitrary instances
 */
extend<K, V> HashMap<K, V> <: Arbitrary<HashMap<K, V>> where K <: Arbitrary<K>, V <: Arbitrary<V> {
    public static func arbitrary(random: RandomSource): Generator<HashMap<K, V>> {
        let keyGenerator = K.arbitrary(random)
        let valueGenerator = V.arbitrary(random)
        let sizeGenerator = sizeGenerator(random)

        Generators.weighted<HashMap<K, V>>(
            random,
            [
                (10, Generators.single(HashMap<K, V>())),
                (10, Generators.generate { HashMap<K, V>([(keyGenerator.next(), valueGenerator.next())]) }),
                (80, Generators.generate {
                    var size = sizeGenerator.next()

                    let hmap = HashMap<K, V>()
                    for (_ in 0..size) {
                        let k = keyGenerator.next()
                        let v = valueGenerator.next()

                        hmap[k] = v
                    }

                    return hmap
                })
            ]
        )
    }
}

/*
 * Arbitrary instance for String: has a higher probability to generate empty or single-element arrays,
 * the size is random but leaned towards smaller values and not bigger than SIZE_UPPER_LIMIT
 * Elements are random according to their respective Arbitrary instances
 */
extend String <: Arbitrary<String> {
    public static func arbitrary(random: RandomSource): Generator<String> {
        Generators.mapped<Array<Rune>, String>(random) { it: Array<Rune> => String(it) }
    }
}

/*
 * Arbitrary instance for Option: has a high probability to generate None,
 * in other cases generates values according to elements' respective Arbitrary instance
 */
extend<T> Option<T> <: Arbitrary<Option<T>> where T <: Arbitrary<T> {
    public static func arbitrary(random: RandomSource): Generator<Option<T>> {
        Generators.weighted<Option<T>>(
            random,
            [
                (30, Generators.single<Option<T>>(Option<T>.None)),
                (70, Generators.mapped<T, Option<T>>(random) { it: T => it })
            ]
        )
    }
}

/*
 * Arbitrary instance for Ordering: generates random Ordering values
 */
extend Ordering <: Arbitrary<Ordering> {
    public static func arbitrary(random: RandomSource): Generator<Ordering> {
        Generators.iterable(random, [Ordering.LT, Ordering.EQ, Ordering.GT])
    }
}

/*
 * Arbitrary instance for zero-argument functions, through wrapper struct
 * Generates functions returning arbitrary values.
 * NOTE: research whether we need to support other kinds of functions
 */
extend<R> Function0Wrapper<R> <: Arbitrary<Function0Wrapper<R>> where R <: Arbitrary<R> {
    public static func arbitrary(random: RandomSource): Generator<Function0Wrapper<R>> {
        Generators.mapped<R, Function0Wrapper<R>>(random) { it: R => Function0Wrapper { => it } }
    }
}

/*
 * Arbitrary instance for tuple (through TupleWrapper classes)
 * Generates random tuple values using random element values
 */
extend<T0, T1> TupleWrapper2<T0, T1> <: Arbitrary<TupleWrapper2<T0, T1>>
        where T0 <: Arbitrary<T0>,
              T1 <: Arbitrary<T1> {
    public static func arbitrary(random: RandomSource): Generator<TupleWrapper2<T0, T1>> {
        let gen0 = T0.arbitrary(random)
        let gen1 = T1.arbitrary(random)
        Generators.generate { TupleWrapper2((gen0.next(), gen1.next())) }
    }
}

/*
 * Arbitrary instance for tuple (through TupleWrapper classes)
 * Generates random tuple values using random element values
 */
extend<T0, T1, T2> TupleWrapper3<T0, T1, T2> <: Arbitrary<TupleWrapper3<T0, T1, T2>>
        where T0 <: Arbitrary<T0>,
              T1 <: Arbitrary<T1>,
              T2 <: Arbitrary<T2> {
    public static func arbitrary(random: RandomSource): Generator<TupleWrapper3<T0, T1, T2>> {
        let gen0 = T0.arbitrary(random)
        let gen1 = T1.arbitrary(random)
        let gen2 = T2.arbitrary(random)
        Generators.generate { TupleWrapper3((gen0.next(), gen1.next(), gen2.next())) }
    }
}

/*
 * Arbitrary instance for tuple (through TupleWrapper classes)
 * Generates random tuple values using random element values
 */
extend<T0, T1, T2, T3> TupleWrapper4<T0, T1, T2, T3> <: Arbitrary<TupleWrapper4<T0, T1, T2, T3>>
        where T0 <: Arbitrary<T0>,
              T1 <: Arbitrary<T1>,
              T2 <: Arbitrary<T2>,
              T3 <: Arbitrary<T3> {
    public static func arbitrary(random: RandomSource): Generator<TupleWrapper4<T0, T1, T2, T3>> {
        let gen0 = T0.arbitrary(random)
        let gen1 = T1.arbitrary(random)
        let gen2 = T2.arbitrary(random)
        let gen3 = T3.arbitrary(random)
        Generators.generate { TupleWrapper4((gen0.next(), gen1.next(), gen2.next(), gen3.next())) }
    }
}

/*
 * Arbitrary instance for tuple (through TupleWrapper classes)
 * Generates random tuple values using random element values
 */
extend<T0, T1, T2, T3, T4> TupleWrapper5<T0, T1, T2, T3, T4> <: Arbitrary<TupleWrapper5<T0, T1, T2, T3, T4>>
        where T0 <: Arbitrary<T0>,
              T1 <: Arbitrary<T1>,
              T2 <: Arbitrary<T2>,
              T3 <: Arbitrary<T3>,
              T4 <: Arbitrary<T4> {
    public static func arbitrary(random: RandomSource): Generator<TupleWrapper5<T0, T1, T2, T3, T4>> {
        let gen0 = T0.arbitrary(random)
        let gen1 = T1.arbitrary(random)
        let gen2 = T2.arbitrary(random)
        let gen3 = T3.arbitrary(random)
        let gen4 = T4.arbitrary(random)
        Generators.generate { TupleWrapper5((gen0.next(), gen1.next(), gen2.next(), gen3.next(), gen4.next())) }
    }
}
