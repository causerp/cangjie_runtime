# Class

## class Generators

```cangjie
public class Generators {}
```

Function: A utility class containing helper functions to assist developers in writing their own generators.

### static func generate\<T>(() -> T)

```cangjie
public static func generate<T>(body: () -> T): Generator<T>
```

Function: Creates a generator that produces values by repeatedly invoking a function.

Parameters:

- body: () -> T - The generator closure to be invoked.

Return Value:

- [Generator](../../unittest/unittest_package_api/unittest_package_interfaces.md#interface-generatort)\<T> - The generator.

### static func iterable\<T>(RandomSource, Array\<T>)

```cangjie
public static func iterable<T>(random: RandomSource, collection: Array<T>): Generator<T>
```

Function: Creates a generator that produces values by randomly selecting from an array.

Parameters:

- random: [RandomSource](./unittest_prop_test_package_interfaces.md#interface-randomsource) - The random number source.
- collection: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - The array from which elements are selected.

Return Value:

- [Generator](../../unittest/unittest_package_api/unittest_package_interfaces.md#interface-generatort)\<T> - The generator.

### static func lookup\<T>(RandomSource) where T <: Arbitrary\<T>

```cangjie
public static func lookup<T>(random: RandomSource): Generator<T> where T <: Arbitrary<T>
```

Function: Creates a generator provided by T's [Arbitrary](./unittest_prop_test_package_interfaces.md#interface-arbitrary) instance.

Parameters:

- random: [RandomSource](./unittest_prop_test_package_interfaces.md#interface-randomsource) - The random number source.

Return Value:

- [Generator](../../unittest/unittest_package_api/unittest_package_interfaces.md#interface-generatort)\<T> - The generator.

### static func mapped\<T, R>(RandomSource,(T) -> R) where T <: Arbitrary\<T>

```cangjie
public static func mapped<T, R>(random: RandomSource, body: (T) -> R): Generator<R> where T <: Arbitrary<T>
```

Function: Obtains a generator provided by T's [Arbitrary](./unittest_prop_test_package_interfaces.md#interface-arbitrary) instance and uses the function body to produce values of type R.

Parameters:

- random: [RandomSource](./unittest_prop_test_package_interfaces.md#interface-randomsource) - The random number source.
- body: (T) -> R - The function that produces values of type R.

Return Value:

- [Generator](../../unittest/unittest_package_api/unittest_package_interfaces.md#interface-generatort)\<T> - The generator.

### static func mapped\<T1, T2, R>(RandomSource, (T1, T2) -> R) where T1 <: Arbitrary\<T1>, T2 <: Arbitrary\<T2>

```cangjie
 public static func mapped<T1, T2, R>(random: RandomSource, body: (T1, T2) -> R): Generator<R> where T1 <: Arbitrary<T1>, T2 <: Arbitrary<T2>
```

Function: Obtains generators provided by T1 and T2's [Arbitrary](./unittest_prop_test_package_interfaces.md#interface-arbitrary) instances and uses the function body to produce values of type R.

Parameters:

- random: [RandomSource](./unittest_prop_test_package_interfaces.md#interface-randomsource) - The random number source.
- body: (T1, T2) -> R - The function that produces values of type R.

Return Value:

- [Generator](../../unittest/unittest_package_api/unittest_package_interfaces.md#interface-generatort)\<T> - The generator.

### static func mapped\<T1, T2, T3, R>(RandomSource, (T1, T2, T3) -> R) where T1 <: Arbitrary\<T1>, T2 <: Arbitrary\<T2>, T3 <: Arbitrary\<T3>

```cangjie
public static func mapped<T1, T2, T3, R>(random: RandomSource, body: (T1, T2, T3) -> R): Generator<R>
            where T1 <: Arbitrary<T1>, T2 <: Arbitrary<T2>, T3 <: Arbitrary<T3>
```

Function: Obtains generators provided by T1, T2, and T3's [Arbitrary](./unittest_prop_test_package_interfaces.md#interface-arbitrary) instances and uses the function body to produce values of type R.

Parameters:

- random: [RandomSource](./unittest_prop_test_package_interfaces.md#interface-randomsource) - The random number source.
- body: (T1, T2,T3) -> R - The function that produces values of type R.

Return Value:

- [Generator](../../unittest/unittest_package_api/unittest_package_interfaces.md#interface-generatort)\<T> - The generator.

### static func mapped\<T1, T2, T3, T4, R>(RandomSource, (T1, T2, T3, T4) -> R) where T1 <: Arbitrary\<T1>, T2 <: Arbitrary\<T2>, T3 <: Arbitrary\<T3>, T4 <: Arbitrary\<T4>

```cangjie
public static func mapped<T1, T2, T3, T4, R>(random: RandomSource, body: (T1, T2, T3, T4) -> R): Generator<R>
            where T1 <: Arbitrary<T1>, T2 <: Arbitrary<T2>, T3 <: Arbitrary<T3>, T4 <: Arbitrary<T4>
```

Function: Obtains generators provided by T1, T2, T3, and T4's [Arbitrary](./unittest_prop_test_package_interfaces.md#interface-arbitrary) instances and uses the function body to produce values of type R.

Parameters:

- random: [RandomSource](./unittest_prop_test_package_interfaces.md#interface-randomsource) - The random number source.
- body: (T1, T2,T3,T4) -> R - The function that produces values of type R.

Return Value:

- [Generator](../../unittest/unittest_package_api/unittest_package_interfaces.md#interface-generatort)\<T> - The generator.

### static func pick\<T>(RandomSource, Array\<Generator\<T>>)

```cangjie
public static func pick<T>(random: RandomSource, variants: Array<Generator<T>>): Generator<T>
```

Function: Creates a generator that produces values by randomly selecting from an array of generators.

Parameters:

- random: [RandomSource](./unittest_prop_test_package_interfaces.md#interface-randomsource) - The random number source.
- variants: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Generator](../../unittest/unittest_package_api/unittest_package_interfaces.md#interface-generatort)\<T>> - The array of generators.

Return Value:

- [Generator](../../unittest/unittest_package_api/unittest_package_interfaces.md#interface-generatort)\<T> - The generator.

### static func single\<T>(T)

```cangjie
public static func single<T>(value: T): Generator<T>
```

Function: Creates a generator that always returns the same value.

Parameters:

- value: T - The value to be returned by the generator.

Return Value:

- [Generator](../../unittest/unittest_package_api/unittest_package_interfaces.md#interface-generatort)\<T> - The generator.

### static func weighted\<T>(RandomSource, Array\<(UInt64, Generator\<T>)>)

```cangjie
public static func weighted<T>(random: RandomSource, variants: Array<(UInt64, Generator<T>)>): Generator<T>
```

Function: Creates a generator that produces values by randomly selecting from an array of (weight, generator) pairs.

Parameters:

- random: [RandomSource](./unittest_prop_test_package_interfaces.md#interface-randomsource) - The random number source.
- variants: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<(UInt64, Generator\<T>)> - The array of (weight, generator) pairs.

Return Value:

- [Generator](../../unittest/unittest_package_api/unittest_package_interfaces.md#interface-generatort)\<T> - The generator.

## class LazySeq\<T>

```cangjie
public class LazySeq<T> <: Iterable<T> {
    public init()
    public init(element: T)
}
```

Function: A lazily evaluated sequence of values of type T. Values are computed and memoized during iteration.
This is completely immutable; each operation produces a new sequence.

Parent Type:

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

- element: T - The initial element.

### func append(T)

```cangjie
public func append(element: T): LazySeq<T>
```

Function: Appends an element.

Parameters:

- element: T - The element to be appended.

Return Value:

- [LazySeq](#class-lazyseqt)\<T> - The sequence with the appended element.

### func concat(LazySeq\<T>)

```cangjie
public func concat(other: LazySeq<T>): LazySeq<T>
```

Function: Concatenates another sequence to this sequence. Complexity is O(1).

Parameters:

- other: [LazySeq](#class-lazyseqt)\<T> - The sequence to be concatenated.

Return Value:

- [LazySeq](#class-lazyseqt)\<T> - The concatenated sequence.

### func iterator()

```cangjie
public func iterator(): Iterator<T>
```

Function: Implements the sequence's iterator.

Return Value:

- [Iterator](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - The sequence iterator.

### func map\<U>((T) -> U)

```cangjie
public func map<U>(body: (T) -> U): LazySeq<U>
```

Function: Applies a closure to each element of the sequence.

Parameters:

- body: (T) -> U - The closure to be applied to each element.

Return Value:

- [LazySeq](#class-lazyseqt)\<U> - The transformed sequence.

### func mixWith(LazySeq\<T>)

```cangjie
public func mixWith(other: LazySeq<T>): LazySeq<T>
```

Function: Interleaves another sequence into this sequence.

Example: {1,2,3,4}.mixWith({5,6,7}) -> {1,5,2,6,3,7,4}

Parameters:

- other: [LazySeq](#class-lazyseqt)\<T> - The sequence to be interleaved.

Return Value:

- [LazySeq](#class-lazyseqt)\<U> - The interleaved sequence.

### func prepend(T)

```cangjie
public func prepend(element: T): LazySeq<T>
```

Function: Prepends a new sequence to the beginning of this sequence.Parameters:

- other: [LazySeq](#class-lazyseqt)\<T> - The sequence to be inserted.

Return Value:

- [LazySeq](#class-lazyseqt)\<U> - The processed sequence.

### static func mix(LazySeq\<T>,LazySeq\<T>)

```cangjie
public static func mix(l1: LazySeq<T>, l2: LazySeq<T>)
```

Function: Interleaves two sequences into one.

Example: mix({1,2,3,4}, {5,6,7}) -> {1,5,2,6,3,7,4}

Parameters:

- l1: [LazySeq](#class-lazyseqt)\<T> - The first sequence to interleave.
- l2: [LazySeq](#class-lazyseqt)\<T> - The second sequence to interleave.

Return Value:

- [LazySeq](#class-lazyseqt)\<U> - The processed sequence.

### static func mix(LazySeq\<T>,LazySeq\<T>,LazySeq\<T>)

```cangjie
public static func mix(l1: LazySeq<T>, l2: LazySeq<T>, l3: LazySeq<T>)
```

Function: Interleaves three sequences into one.

Parameters:

- l1: [LazySeq](#class-lazyseqt)\<T> - The first sequence to interleave.
- l2: [LazySeq](#class-lazyseqt)\<T> - The second sequence to interleave.
- l3: [LazySeq](#class-lazyseqt)\<T> - The third sequence to interleave.

Return Value:

- [LazySeq](#class-lazyseqt)\<U> - The processed sequence.

### static func mix(LazySeq\<T>,LazySeq\<T>,LazySeq\<T>,LazySeq\<T>)

```cangjie
public static func mix(l1: LazySeq<T>, l2: LazySeq<T>, l3: LazySeq<T>, l4: LazySeq<T>)
```

Function: Interleaves four sequences into one.

Parameters:

- l1: [LazySeq](#class-lazyseqt)\<T> - The first sequence to interleave.
- l2: [LazySeq](#class-lazyseqt)\<T> - The second sequence to interleave.
- l3: [LazySeq](#class-lazyseqt)\<T> - The third sequence to interleave.
- l4: [LazySeq](#class-lazyseqt)\<T> - The fourth sequence to interleave.

Return Value:

- [LazySeq](#class-lazyseqt)\<U> - The processed sequence.

### static func mix(LazySeq\<T>,LazySeq\<T>,LazySeq\<T>,LazySeq\<T>,LazySeq\<T>)

```cangjie
public static func mix(l1: LazySeq<T>, l2: LazySeq<T>, l3: LazySeq<T>, l4: LazySeq<T>, l5: LazySeq<T>)
```

Function: Interleaves five sequences into one.

Parameters:

- l1: [LazySeq](#class-lazyseqt)\<T> - The first sequence to interleave.
- l2: [LazySeq](#class-lazyseqt)\<T> - The second sequence to interleave.
- l3: [LazySeq](#class-lazyseqt)\<T> - The third sequence to interleave.
- l4: [LazySeq](#class-lazyseqt)\<T> - The fourth sequence to interleave.
- l5: [LazySeq](#class-lazyseqt)\<T> - The fifth sequence to interleave.

Return Value:

- [LazySeq](#class-lazyseqt)\<U> - The processed sequence.

### static func of(Iterable\<T>)

```cangjie
public static func of(iterable: Iterable<T>)
```

Function: Constructs a sequence from an iterable.

Parameters:

- iterable: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - The iterable to process.

Return Value:

- [LazySeq](#class-lazyseqt)\<U> - The processed sequence.

### static func of(Array\<T>)

```cangjie
public static func of(array: Array<T>)
```

Function: Constructs a sequence from an array.

Parameters:

- array: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - The array to process.

Return Value:

- [LazySeq](#class-lazyseqt)\<U> - The processed sequence.

## class ShrinkHelpers

```cangjie
public class ShrinkHelpers {}
```

Function: Provides methods for implementing shrink iterators on tuples.

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

- tuple: (T0, T1) - The tuple to shrink.
- t0: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T0> - Shrink iterator for the first tuple member.
- t1: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\\<T1> - Shrink iterator for the second tuple member.

Return Value:

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<(T0, T1)> - The tuple shrink iterator.

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

- tuple: (T0, T1, T2) - The tuple to shrink.
- t0: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T0> - Shrink iterator for the first tuple member.
- t1: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T1> - Shrink iterator for the second tuple member.
- t2: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T2> - Shrink iterator for the third tuple member.

Return Value:

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<(T0, T1, T2)> - The tuple shrink iterator.

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

- tuple: (T0, T1, T2, T3) - The tuple to shrink.
- t0: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T0> - Shrink iterator for the first tuple member.
- t1: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T1> - Shrink iterator for the second tuple member.
- t2: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T2> - Shrink iterator for the third tuple member.
- t3: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T3> - Shrink iterator for the fourth tuple member.

Return Value:

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<(T0, T1, T2, T3)> - The tuple shrink iterator.

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

- tuple: (T0, T1, T2, T3, T4) - The tuple to shrink.
- t0: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T0> - Shrink iterator for the first tuple member.
- t1: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T1> - Shrink iterator for the second tuple member.
- t2: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T2> - Shrink iterator for the third tuple member.
- t3: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T3> - Shrink iterator for the fourth tuple member.
- t4: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T4> - Shrink iterator for the fifth tuple member.

Return Value:

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<(T0, T1, T2, T3, T4)> - The tuple shrink iterator.