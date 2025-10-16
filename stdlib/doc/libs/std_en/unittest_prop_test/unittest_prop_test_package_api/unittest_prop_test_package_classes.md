# Classes

## class Generators

```cangjie
public class Generators {}
```

Function: A class containing helper functions to assist developers in writing their own generators.

### static func generate\<T>(T, T, (T, T) -> T)

```cangjie
public static func generate<T>(l: T, r: T, body: (T, T) -> T): Generator<T>
```

Function: Generates a generator that produces values by repeatedly calling a function within the range [l, r].

Parameters:

- l: T - Minimum value.
- r: T - Maximum value.
- body: () -> T - The generator closure to be called.

Return Value:

- [Generator](../../unittest_prop_test/unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-generatort)\<T> - The generator.

### static func generate\<T>(() -> T)

```cangjie
public static func generate<T>(body: () -> T): Generator<T>
```

Function: Generates a generator that produces values by repeatedly calling a function.

Parameters:

- body: () -> T - The generator closure to be called.

Return Value:

- [Generator](../../unittest_prop_test/unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-generatort)\<T> - The generator.

### static func iterable\<T>(RandomSource, Array\<T>)

```cangjie
public static func iterable<T>(random: RandomSource, collection: Array<T>): Generator<T>
```

Function: Generates a generator that produces values by randomly selecting from an array.

Parameters:

- random: [RandomSource](./unittest_prop_test_package_interfaces.md#interface-randomsource) - Random number source.
- collection: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - The array from which values are selected.

Return Value:

- [Generator](../../unittest_prop_test/unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-generatort)\<T> - The generator.

### static func lookup\<T>(RandomSource)

```cangjie
public static func lookup<T>(random: RandomSource): Generator<T> where T <: Arbitrary<T>
```

Function: Provides a generator via the [Arbitrary](./unittest_prop_test_package_interfaces.md#interface-arbitrary) instance of T.

Parameters:

- random: [RandomSource](./unittest_prop_test_package_interfaces.md#interface-randomsource) - Random number source.

Return Value:

- [Generator](../../unittest_prop_test/unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-generatort)\<T> - The generator.

### static func mapped\<T, R>(RandomSource,(T) -> R)

```cangjie
public static func mapped<T, R>(random: RandomSource, body: (T) -> R): Generator<R> where T <: Arbitrary<T>
```

Function: Obtains a generator provided by the [Arbitrary](./unittest_prop_test_package_interfaces.md#interface-arbitrary) instance of T and uses the function body to generate values of type R.

Parameters:

- random: [RandomSource](./unittest_prop_test_package_interfaces.md#interface-randomsource) - Random number source.
- body: (T) -> R - Generates values of type R.

Return Value:

- [Generator](../../unittest_prop_test/unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-generatort)\<R> - The generator.

### static func mapped\<T1, T2, R>(RandomSource, (T1, T2) -> R)

```cangjie
 public static func mapped<T1, T2, R>(random: RandomSource, body: (T1, T2) -> R): Generator<R> where T1 <: Arbitrary<T1>, T2 <: Arbitrary<T2>
```

Function: Obtains generators provided by the [Arbitrary](./unittest_prop_test_package_interfaces.md#interface-arbitrary) instances of T1 and T2 and uses the function body to generate values of type R.

Parameters:

- random: [RandomSource](./unittest_prop_test_package_interfaces.md#interface-randomsource) - Random number source.
- body: (T1, T2) -> R - Generates values of type R.

Return Value:

- [Generator](../../unittest_prop_test/unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-generatort)\<R> - The generator.

### static func mapped\<T1, T2, T3, R>(RandomSource, (T1, T2, T3) -> R)

```cangjie
public static func mapped<T1, T2, T3, R>(random: RandomSource, body: (T1, T2, T3) -> R): Generator<R>
            where T1 <: Arbitrary<T1>, T2 <: Arbitrary<T2>, T3 <: Arbitrary<T3>
```

Function: Obtains generators provided by the [Arbitrary](./unittest_prop_test_package_interfaces.md#interface-arbitrary) instances of T1, T2, and T3 and uses the function body to generate values of type R.

Parameters:

- random: [RandomSource](./unittest_prop_test_package_interfaces.md#interface-randomsource) - Random number source.
- body: (T1, T2,T3) -> R - Generates values of type R.

Return Value:

- [Generator](../../unittest_prop_test/unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-generatort)\<R> - The generator.

### static func mapped\<T1, T2, T3, T4, R>(RandomSource, (T1, T2, T3, T4) -> R)

```cangjie
public static func mapped<T1, T2, T3, T4, R>(random: RandomSource, body: (T1, T2, T3, T4) -> R): Generator<R>
            where T1 <: Arbitrary<T1>, T2 <: Arbitrary<T2>, T3 <: Arbitrary<T3>, T4 <: Arbitrary<T4>
```

Function: Obtains generators provided by the [Arbitrary](./unittest_prop_test_package_interfaces.md#interface-arbitrary) instances of T1, T2, T3, and T4 and uses the function body to generate values of type R.

Parameters:

- random: [RandomSource](./unittest_prop_test_package_interfaces.md#interface-randomsource) - Random number source.
- body: (T1, T2,T3,T4) -> R - Generates values of type R.

Return Value:

- [Generator](../../unittest_prop_test/unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-generatort)\<R> - The generator.

### static func pick\<T>(RandomSource, Array\<Generator\<T>>)

```cangjie
public static func pick<T>(random: RandomSource, variants: Array<Generator<T>>): Generator<T>
```

Function: Generates a generator that produces values by randomly selecting from an array of generators.

Parameters:

- random: [RandomSource](./unittest_prop_test_package_interfaces.md#interface-randomsource) - Random number source.
- variants: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Generator](../../unittest_prop_test/unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-generatort)\<T>> - Array of generators.

Return Value:

- [Generator](../../unittest_prop_test/unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-generatort)\<T> - The generator.

### static func single\<T>(T)

```cangjie
public static func single<T>(value: T): Generator<T>
```

Function: A generator that always returns the same value.

Parameters:

- value: T - The value returned by the generator.

Return Value:

- [Generator](../../unittest_prop_test/unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-generatort)\<T> - The generator.

### static func weighted\<T>(RandomSource, Array\<(UInt64, Generator\<T>)>)

```cangjie
public static func weighted<T>(random: RandomSource, variants: Array<(UInt64, Generator<T>)>): Generator<T>
```

Function: Generates a generator that produces values by randomly selecting from an array of (weight, generator) pairs.

Parameters:

- random: [RandomSource](./unittest_prop_test_package_interfaces.md#interface-randomsource) - Random number source.
- variants: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<(UInt64, Generator\<T>)> - Array of (weight, generator) pairs.

Return Value:

- [Generator](../../unittest_prop_test/unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-generatort)\<T> - The generator.

## class RandomDataProvider\<T>

```cangjie
public class RandomDataProvider<T> <: DataProvider<T> where T <: Arbitrary<T> {
    public RandomDataProvider(private let configuration: Configuration)
}
```

Function: An implementation of the [DataProvider](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-dataprovider) interface using random data generation.

Parent Type:

- [DataProvider](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-dataprovider)\<T>

### RandomDataProvider(Configuration)

```cangjie
public RandomDataProvider(private let configuration: Configuration)
```

Function: Constructs a RandomDataProvider object.

Parameters:

- configuration: [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration) - Configuration object, which must include a random generator named `random` of type random.[Random](../../random/random_package_api/random_package_classes.md#class-random).

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the configuration does not contain a random instance.

### func provide()

```cangjie
public override func provide(): Iterable<T>
```

Function: Provides randomly generated data.

Return Value:

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - An infinite iterator created from the arbitrary instance of T.

## class RandomDataProviderRange\<T>

```cangjie
public class RandomDataProviderRange<T> <: DataProvider<T> where T <: ArbitraryRange<T> {
    public RandomDataProviderRange(configuration: Configuration, min: T, max: T)
}
```

Function: A data provider capable of generating data within a specified range.

Parent Type:

- [DataProvider\<T>](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-dataprovider)

### RandomDataProviderRange(Configuration, T, T)

```cangjie
RandomDataProviderRange(configuration: Configuration, min: T, max: T)
```

Function: Constructor.

Parameters:

- configuration: [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration) - Configuration parameters.
- min: T - Minimum value (inclusive).
- max: T - Maximum value (exclusive).

### func provide()

```cangjie
override func provide(): Iterable<T>
```

Function: Provides randomly generated data.

Return Value:

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - Data iterator.

## class RandomDataShrinker\<T>

```cangjie
public class RandomDataShrinker<T> <: DataShrinker<T> {}
```

Function: An implementation of the [DataShrinker](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-datashrinkert) interface using random data generation.

Parent Type:

- [DataShrinker](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-datashrinkert)\<T>

### func shrink(T)

```cangjie
public override func shrink(value: T): Iterable<T>
```

Function: Obtains a shrinker for the value.

Parameters:

- value: T - Parameter value.

Return Value:

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - If the parameter implements the [Shrink](../../unittest_prop_test/unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-shrinkt) interface, returns an iterator of shrunk values; otherwise, returns an empty array.

## class RandomDataShrinkerRange\<T>

```cangjie
public class RandomDataShrinkerRange<T> <: DataShrinker<T> where T <: Comparable<T> {}
```

Function: A data shrinker capable of shrinking data within a specified range.

Parent Type:

- [DataShrinker\<T>](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-datashrinkert)

### func shrink(T)

```cangjie
public override func shrink(value: T): Iterable<T>
```

Function: Shrinks the value into a set of possible "smaller" values.

Return Value:

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - Data iterator.

## class RandomDataStrategy\<T>

```cangjie
public class RandomDataStrategy<T> <: DataStrategy<T> where T <: Arbitrary<T>{}
```

Function: An implementation of the [DataStrategy](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-datastrategy) interface using random data generation.

Parent Type:

- [DataStrategy](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-datastrategy)\<T>

### prop isInfinite

```cangjie
public override prop isInfinite: Bool
```

Function: When this strategy is infinite, the value is true; otherwise, false.

Type: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool).

### func provider(Configuration)

```cangjie
public override func provider(configuration: Configuration): RandomDataProvider<T>
```

Function: Obtains a random data provider.

Parameters:

- configuration: [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration) - Configuration parameters.

Return Value:

- [RandomDataProvider](#class-randomdataprovidert)\<T> - Random data provider.

### func shrinker(Configuration)

```cangjie
public override func shrinker(_: Configuration): RandomDataShrinker<T>
```

Function: Obtains a random data shrinker.

Parameters:

- _: [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration) - Configuration parameters.

Return Value:

- [RandomDataShrinker](#class-randomdatashrinkert)\<T> - Random data shrinker.

## class RandomDataStrategyRange\<T>

```cangjie
public class RandomDataStrategyRange<T> <: DataStrategy<T> where T <: ArbitraryRange<T> {}
```

Function: A data strategy generator that operates within specified ranges.

Parent Types:

- [DataStrategy\<T>](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-datastrategy)

### func provider(Configuration)

```cangjie
public override func provider(configuration: Configuration): RandomDataProviderRange<T>
```

Function: Gets a random data provider.

Parameters:

- configuration: [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration) - Configuration parameters.

Return Value:

- [RandomDataProviderRange](unittest_prop_test_package_classes.md#class-randomdataproviderranget)\<T> - Random number provider.

### func shrinker(Configuration)

```cangjie
public override func shrinker(_: Configuration): RandomDataShrinkerRange<T>
```

Function: Gets a random data shrinker.

Parameters:

- _: [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration) - Configuration parameters.

Return Value:

- [RandomDataShrinkerRange](#class-randomdatashrinkerranget)\<T> - Random data shrinker.

### prop isInfinite

```cangjie
public prop isInfinite: Bool 
```

Function: Returns true if this strategy is infinite, otherwise false.

Type: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool).

## class LazySeq\<T>

```cangjie
public class LazySeq<T> <: Iterable<T> {
    public init()
    public init(element: T) 
}
```

Function: A lazily computed sequence of values of type T. Values are computed and memoized during iteration.
This is completely immutable - each operation produces a new sequence.

Parent Types:

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>

### init()

```cangjie
public init()
```

Function: Constructor.

### init(T)

```cangjie
public init(element: T)
```

Function: Constructor.

Parameters:

- element: T - Initial element.

### func append(T)

```cangjie
public func append(element: T): LazySeq<T>
```

Function: Appends an element.

Parameters:

- element: T - Element to append.

Return Value:

- [LazySeq](#class-lazyseqt)\<T> - Sequence after appending the element.

### func concat(LazySeq\<T>)

```cangjie
public func concat(other: LazySeq<T>): LazySeq<T>
```

Function: Concatenates another sequence to this one. Time complexity is O(1).

Parameters:

- other: [LazySeq](#class-lazyseqt)\<T> - Sequence to concatenate.

Return Value:

- [LazySeq](#class-lazyseqt)\<T> - Resulting sequence after concatenation.

### func iterator()

```cangjie
public func iterator(): Iterator<T>
```

Function: Implements the sequence iterator.

Return Value:

- [Iterator](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - Sequence iterator.

### func map\<U>((T) -> U)

```cangjie
public func map<U>(body: (T) -> U): LazySeq<U>
```

Function: Applies a closure to each element in the sequence.

Parameters:

- body: (T) -> U - Closure to apply to each element.

Return Value:

- [LazySeq](#class-lazyseqt)\<U> - Transformed sequence.

### func mixWith(LazySeq\<T>)

```cangjie
public func mixWith(other: LazySeq<T>): LazySeq<T>
```

Function: Interleaves another sequence into this one.

Example: {1,2,3,4}.mixWith({5,6,7}) -> {1,5,2,6,3,7,4}

Parameters:

- other: [LazySeq](#class-lazyseqt)\<T> - Sequence to interleave.

Return Value:

- [LazySeq](#class-lazyseqt)\<T> - Resulting interleaved sequence.

### func prepend(T)

```cangjie
public func prepend(element: T): LazySeq<T>
```

Function: Prepends a sequence to the beginning of this sequence.

Parameters:

- other: [LazySeq](#class-lazyseqt)\<T> - Sequence to prepend.

Return Value:

- [LazySeq](#class-lazyseqt)\<T> - Resulting sequence after prepending.

### static func mix(LazySeq\<T>,LazySeq\<T>)

```cangjie
public static func mix(l1: LazySeq<T>, l2: LazySeq<T>): LazySeq<T>
```

Function: Interleaves two sequences into one.

Example: mix({1,2,3,4}, {5,6,7}) -> {1,5,2,6,3,7,4}

Parameters:

- l1: [LazySeq](#class-lazyseqt)\<T> - First sequence to interleave.
- l2: [LazySeq](#class-lazyseqt)\<T> - Second sequence to interleave.

Return Value:

- [LazySeq](#class-lazyseqt)\<T> - Resulting interleaved sequence.

### static func mix(LazySeq\<T>,LazySeq\<T>,LazySeq\<T>)

```cangjie
public static func mix(l1: LazySeq<T>, l2: LazySeq<T>, l3: LazySeq<T>): LazySeq<T>
```

Function: Interleaves three sequences into one.

Parameters:

- l1: [LazySeq](#class-lazyseqt)\<T> - First sequence to interleave.
- l2: [LazySeq](#class-lazyseqt)\<T> - Second sequence to interleave.
- l3: [LazySeq](#class-lazyseqt)\<T> - Third sequence to interleave.

Return Value:

- [LazySeq](#class-lazyseqt)\<T> - Resulting interleaved sequence.

### static func mix(LazySeq\<T>,LazySeq\<T>,LazySeq\<T>,LazySeq\<T>)

```cangjie
public static func mix(l1: LazySeq<T>, l2: LazySeq<T>, l3: LazySeq<T>, l4: LazySeq<T>): LazySeq<T>
```

Function: Interleaves four sequences into one.

Parameters:

- l1: [LazySeq](#class-lazyseqt)\<T> - First sequence to interleave.
- l2: [LazySeq](#class-lazyseqt)\<T> - Second sequence to interleave.
- l3: [LazySeq](#class-lazyseqt)\<T> - Third sequence to interleave.
- l4: [LazySeq](#class-lazyseqt)\<T> - Fourth sequence to interleave.

Return Value:

- [LazySeq](#class-lazyseqt)\<T> - Resulting interleaved sequence.

### static func mix(LazySeq\<T>,LazySeq\<T>,LazySeq\<T>,LazySeq\<T>,LazySeq\<T>)

```cangjie
public static func mix(l1: LazySeq<T>, l2: LazySeq<T>, l3: LazySeq<T>, l4: LazySeq<T>, l5: LazySeq<T>): LazySeq<T> 
```

Function: Interleaves five sequences into one.

Parameters:

- l1: [LazySeq](#class-lazyseqt)\<T> - First sequence to interleave.
- l2: [LazySeq](#class-lazyseqt)\<T> - Second sequence to interleave.
- l3: [LazySeq](#class-lazyseqt)\<T> - Third sequence to interleave.
- l4: [LazySeq](#class-lazyseqt)\<T> - Fourth sequence to interleave.
- l5: [LazySeq](#class-lazyseqt)\<T> - Fifth sequence to interleave.

Return Value:

- [LazySeq](#class-lazyseqt)\<T> - Resulting interleaved sequence.

### static func of(Iterable\<T>)

```cangjie
public static func of(iterable: Iterable<T>): LazySeq<T>
```

Function: Constructs a sequence from an iterable.

Parameters:

- iterable: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - Iterable to process.

Return Value:

- [LazySeq](#class-lazyseqt)\<T> - Resulting sequence.

### static func of(Array\<T>)

```cangjie
public static func of(array: Array<T>): LazySeq<T>
```

Function: Constructs a sequence from an array.

Parameters:

- array: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - Array to process.

Return Value:

- [LazySeq](#class-lazyseqt)\<T> - Resulting sequence.

## class ShrinkHelpers

```cangjie
public class ShrinkHelpers {}
```

Function: Provides methods for implementing shrink iterators for tuples.

### static func shrinkTuple\<T0, T1>((T0, T1),Iterable\<T0>,Iterable\<T1>)

```cangjie
public static func shrinkTuple<T0, T1>(
    tuple: (T0, T1),
    t0: Iterable<T0>,
    t1: Iterable<T1>
): Iterable<(T0, T1)>
```

Function: Implements a shrink iterator for tuples.

Parameters:

- tuple: (T0, T1) - Tuple to shrink.
- t0: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T0> - Shrink iterator for the first tuple element.
- t1: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T1> - Shrink iterator for the second tuple element.

Return Value:

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<(T0, T1)> - Tuple shrink iterator.

### static func shrinkTuple\<T0, T1, T2>((T0, T1, T2),Iterable\<T0>,Iterable\<T1>,Iterable\<T2>)

```cangjie
public static func shrinkTuple<T0, T1, T2>(
    tuple: (T0, T1, T2),
    t0: Iterable<T0>,
    t1: Iterable<T1>,
    t2: Iterable<T2>
): Iterable<(T0, T1, T2)>
```

Function: Implements a shrink iterator for tuples.

Parameters:

- tuple: (T0, T1, T2) - Tuple to shrink.
- t0: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T0> - Shrink iterator for the first tuple element.
- t1: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T1> - Shrink iterator for the second tuple element.
- t2: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T2> - Shrink iterator for the third tuple element.

Return Value:

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<(T0, T1, T2)> - Tuple shrink iterator.

### static func shrinkTuple\<T0, T1, T2, T3>((T0, T1, T2, T3),Iterable\<T0>,Iterable\<T1>,Iterable\<T2>,Iterable\<T3>)

```cangjie
public static func shrinkTuple<T0, T1, T2, T3>(
    tuple: (T0, T1, T2, T3),
    t0: Iterable<T0>,
    t1: Iterable<T1>,
    t2: Iterable<T2>,
    t3: Iterable<T3>
): Iterable<(T0, T1, T2, T3)>
```

Function: Implements a shrink iterator for tuples.

Parameters:

- tuple: (T0, T1, T2, T3) - Tuple to shrink.
- t0: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T0> - Shrink iterator for the first tuple element.
- t1: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T1> - Shrink iterator for the second tuple element.
- t2: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T2> - Shrink iterator for the third tuple element.
- t3: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T3> - Shrink iterator for the fourth tuple element.

Return Value:

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<(T0, T1, T2,T3)> - Tuple shrink iterator.

### static func shrinkTuple\<T0, T1, T2, T3, T4>((T0, T1, T2, T3, T4),Iterable\<T0>,Iterable\<T1>,Iterable\<T2>,Iterable\<T3>,Iterable\<T4>)

```cangjie
public static func shrinkTuple<T0, T1, T2, T3, T4>(
    tuple: (T0, T1, T2, T3, T4),
    t0: Iterable<T0>,
    t1: Iterable<T1>,
    t2: Iterable<T2>,
    t3: Iterable<T3>,
    t4: Iterable<T4>
): Iterable<(T0, T1, T2, T3, T4)>
```

Function: Implements a shrink iterator for tuples.

Parameters:

- tuple: (T0, T1, T2, T3, T4) - Tuple to shrink.
- t0: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T0> - Shrink iterator for the first tuple element.
- t1: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T1> - Shrink iterator for the second tuple element.
- t2: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T2> - Shrink iterator for the third tuple element.
- t3: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T3> - Shrink iterator for the fourth tuple element.
- t4: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T4> - Shrink iterator for the fifth tuple element.

Return Value:

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<(T0, T1, T2,T3,T4)> - Tuple shrink iterator.

### static func mix\<T>(Array<Iterable\<T>>)

```cangjie
public static func mix<T>(iterables: Array<Iterable<T>>): Iterable<T>
```

Function: Combines a list of iterators into a single iterator.

Parameters:

- iterables: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>> - The list of iterables to be mixed.

Return Value:

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - The mixed iterator.
