# Structs

## struct Function0Wrapper\<R>

```cangjie
public struct Function0Wrapper<R> {
    public Function0Wrapper(public let function: () -> R)
}
```

Function: Wraps a closure into a struct.

### Function0Wrapper(() -> R)

```cangjie
public Function0Wrapper(public let function: () -> R)
```

Function: Constructor for Function0Wrapper.

Parameters:

- function: () -> R - The closure to be wrapped.

### let function

```cangjie
public let function: () -> R
```

Function: The function object itself.

Type: ()->R

### operator func ()()

```cangjie
public operator func () (): R
```

Function: Call operator function. Converts the closure into a struct's call operator function.

Return value:

- R - Same as the closure's return value.

### extend\<R> Function0Wrapper\<R> <: Arbitrary\<Function0Wrapper\<R>> where R <: Arbitrary\<R>

```cangjie
extend<R> Function0Wrapper<R> <: Arbitrary<Function0Wrapper<R>> where R <: Arbitrary<R>
```

Function: Extends [Arbitrary](./unittest_prop_test_package_interfaces.md#interface-arbitrary) implementation for [Function0Wrapper](#struct-function0wrapperr).

Parent type:

- [Arbitrary](unittest_prop_test_package_interfaces.md#interface-arbitrary)\<[Function0Wrapper](#struct-function0wrapperr)\<R>>

#### static func arbitrary(RandomSource)

```cangjie
public static func arbitrary(random: RandomSource): Generator<Function0Wrapper<R>>
```

Function: Gets a generator for random values of type [Function0Wrapper](#struct-function0wrapperr)\<R>.

Return value:

- [Generator](../unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-generatort)\<[Function0Wrapper](../unittest_prop_test_package_api/unittest_prop_test_package_structs.md#struct-function0wrapperr)\<R>> - The generator.

## struct KeyRandom

```cangjie
public struct KeyRandom <: KeyFor<RandomSource> {}
```

Function: Used to create key-value pairs in [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration).

Parent type:

- [KeyFor](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-keyfor)<[RandomSource](./unittest_prop_test_package_interfaces.md#interface-randomsource)>

### prop random

```cangjie
public static prop random: KeyRandom
```

Function: Key for configuration items.

### prop name

```cangjie
public prop name: String
```

Function: Name of the configuration item's key.

## struct TupleWrapper2\<T0, T1>

```cangjie
public struct TupleWrapper2<T0, T1> {
    public TupleWrapper2(public let tuple: (T0, T1))
}
```

Function: Wraps a closure into a struct. The closure takes two parameters.

### TupleWrapper2((T0, T1))

```cangjie
public TupleWrapper2(public let tuple: (T0, T1))
```

Function: Constructor for TupleWrapper2.

Parameters:

- tuple: (T0, T1) - The two input parameters of the closure.

### let tuple

```cangjie
public let tuple: (T0, T1)
```

Function: The tuple itself.

Type: (T0, T1)

### func apply\<R>((T0, T1) -> R)

```cangjie
public func apply<R>(f: (T0, T1) -> R): R
```

Function: Executes the closure function.

Parameters:

- f: (T0, T1) -> R - The closure to be executed.

Return value:

- R - Execution result of the closure.

### extend\<T0, T1> TupleWrapper2\<T0, T1> <: ToString

```cangjie
extend<T0, T1> TupleWrapper2<T0, T1> <: ToString
```

Function: Extends [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring) implementation for [TupleWrapper2](#struct-tuplewrapper2t0-t1).

Parent type:

- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

#### func toString()

```cangjie
public func toString()
```

Function: String representation of [TupleWrapper2](#struct-tuplewrapper2t0-t1).

### extend\<T0, T1> TupleWrapper2\<T0, T1> <: Equatable\<TupleWrapper2\<T0, T1>>

```cangjie
extend<T0, T1> TupleWrapper2<T0, T1> <: Equatable<TupleWrapper2<T0, T1>>
```

Function: Extends [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet) implementation for [TupleWrapper2](#struct-tuplewrapper2t0-t1).

Parent type:

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[TupleWrapper2](#struct-tuplewrapper2t0-t1)\<T0, T1>>

#### operator func ==(TupleWrapper2\<T0, T1>)

```cangjie
public operator func ==(other: TupleWrapper2<T0, T1>): Bool
```

Function: Compares two 2-tuples.

Parameters:

- other: [TupleWrapper2](#struct-tuplewrapper2t0-t1)\<T0, T1> - The tuple to compare.

Return value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if equal, otherwise `false`.

#### operator func !=(TupleWrapper2\<T0, T1>)

```cangjie
public operator func !=(other: TupleWrapper2<T0, T1>): Bool
```

Function: Compares two 2-tuples.

Parameters:

- other: [TupleWrapper2](#struct-tuplewrapper2t0-t1)\<T0, T1> - The tuple to compare.

Return value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if not equal, otherwise `false`.

### extend\<T0, T1> TupleWrapper2\<T0, T1> <: IndexAccess

```cangjie
extend<T0, T1> TupleWrapper2<T0, T1> <: IndexAccess
```

Function: Extends [IndexAccess](./unittest_prop_test_package_interfaces.md#interface-indexaccess) implementation for [TupleWrapper2](#struct-tuplewrapper2t0-t1).

Parent type:

- [IndexAccess](unittest_prop_test_package_interfaces.md#interface-indexaccess)

#### func getElementAsAny(Int64)

```cangjie
public func getElementAsAny(index: Int64): ?Any
```

Function: Gets the value inside the tuple by index.

Parameters:

- index: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The index value.

Return value:

- ?[Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - The value inside the tuple. Returns `None` if the index is invalid.

### extend\<T0, T1> TupleWrapper2\<T0, T1> <: Arbitrary\<TupleWrapper2\<T0, T1>> where T0 <: Arbitrary\<T0>,T1 <: Arbitrary\<T1>

```cangjie
extend<T0, T1> TupleWrapper2<T0, T1> <: Arbitrary<TupleWrapper2<T0, T1>> where T0 <: Arbitrary<T0>,T1 <: Arbitrary<T1>
```

Function: Extends [Arbitrary](./unittest_prop_test_package_interfaces.md#interface-arbitrary) implementation for [TupleWrapper2](#struct-tuplewrapper2t0-t1).

Parent type:

- [Arbitrary](unittest_prop_test_package_interfaces.md#interface-arbitrary)\<[TupleWrapper2](#struct-tuplewrapper2t0-t1)\<T0, T1>>

#### static func arbitrary(RandomSource)

```cangjie
public static func arbitrary(random: RandomSource): Generator<TupleWrapper2<T0, T1>>
```

Function: Gets a generator for random values of type [TupleWrapper2](#struct-tuplewrapper2t0-t1)\<T0, T1>.

Return value:

- [Generator](../unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-generatort)\<[TupleWrapper2](#struct-tuplewrapper2t0-t1)\<T0, T1>> - The generator.

### extend\<T0, T1> TupleWrapper2\<T0, T1> <: Shrink\<TupleWrapper2\<T0, T1>> where T0 <: Shrink\<T0>,T1 <: Shrink\<T1>

```cangjie
extend<T0, T1> TupleWrapper2<T0, T1> <: Shrink<TupleWrapper2<T0, T1>>
        where T0 <: Shrink<T0>,
              T1 <: Shrink<T1> {
    public func shrink(): Iterable<TupleWrapper2<T0, T1>>
}
```

#### func shrink()

```cangjie
override func shrink(): Iterable<TupleWrapper2<T0, T1>>
```

Function: Shrinks the tuple.

Return value:

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<TupleWrapper2<T0, T1> - Data iterator.

## struct TupleWrapper3\<T0, T1, T2>

```cangjie
public struct TupleWrapper3<T0, T1, T2> {
    public TupleWrapper3(public let tuple: (T0, T1,T2))
}
```

Function: Wraps a closure into a struct. The closure takes two parameters.

### TupleWrapper3((T0, T1, T2))

```cangjie
public TupleWrapper3(public let tuple: (T0, T1, T2))
```

Function: Constructor for TupleWrapper3.

Parameters:

- tuple: (T0, T1, T2) - The three input parameters of the closure.

### let tuple

```cangjie
public let tuple: (T0, T1, T2)
```

Function: The tuple itself.

Type: (T0, T1, T2)

### func apply\<R>((T0, T1, T2) -> R)

```cangjie
public func apply<R>(f: (T0, T1,T2) -> R): R
```

Function: Executes the closure function.

Parameters:

- f: (T0, T1,T2) -> R - The closure to be executed.

Return value:

- R - Execution result of the closure.

### extend\<T0, T1, T2> TupleWrapper3\<T0, T1, T2> <: ToString

```cangjie
extend<T0, T1, T2> TupleWrapper3<T0, T1, T2> <: ToString
```

Function: Extends [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring) implementation for [TupleWrapper3](#struct-tuplewrapper3t0-t1-t2).

Parent type:

- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

#### func toString()

```cangjie
public func toString()
```

Function: String representation of [TupleWrapper3](#struct-tuplewrapper3t0-t1-t2).

### extend\<T0, T1, T2> TupleWrapper3\<T0, T1, T2> <: Equatable\<TupleWrapper3\<T0, T1, T2>>

```cangjie
extend<T0, T1, T2> TupleWrapper3<T0, T1, T2> <: Equatable<TupleWrapper3<T0, T1, T2>>
```

Function: Extends [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet) implementation for [TupleWrapper3](#struct-tuplewrapper3t0-t1-t2).

Parent type:

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[TupleWrapper3](#struct-tuplewrapper3t0-t1-t2)\<T0, T1, T2>>

#### operator func ==(TupleWrapper3\<T0, T1, T2>)

```cangjie
public operator func ==(other: TupleWrapper3<T0, T1, T2>): Bool
```

Function: Compares two tuples.

Parameters:

- other: [TupleWrapper3](#struct-tuplewrapper3t0-t1-t2)\<T0, T1, T2> - The tuple to compare.

Return value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if equal, otherwise `false`.

#### operator func !=(TupleWrapper3\<T0, T1, T2>)

```cangjie
public operator func !=(other: TupleWrapper3<T0, T1, T2>): Bool
```

Function: Compares two tuples.

Parameters:

- other: [TupleWrapper3](#struct-tuplewrapper3t0-t1-t2)\<T0, T1, T2> - The tuple to compare.

Return value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if not equal, otherwise `false`.

### extend\<T0, T1, T2> TupleWrapper3\<T0, T1, T2> <: IndexAccess

```cangjie
extend<T0, T1, T2> TupleWrapper3<T0, T1, T2> <: IndexAccess
```

Function: Extends [IndexAccess](./unittest_prop_test_package_interfaces.md#interface-indexaccess) implementation for [TupleWrapper3](#struct-tuplewrapper3t0-t1-t2).

Parent type:

- [IndexAccess](unittest_prop_test_package_interfaces.md#interface-indexaccess)

#### func getElementAsAny(Int64)

```cangjie
public func getElementAsAny(index: Int64): ?Any
```

Function: Gets the value inside the tuple by index.

Parameters:

- index: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The index value.

Return value:

- ?[Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - The value inside the tuple. Returns `None` if the index is invalid.

### extend\<T0, T1, T2> TupleWrapper3\<T0, T1, T2> <: Arbitrary\<TupleWrapper3\<T0, T1, T2>>  where T0 <: Arbitrary\<T0>,T1 <: Arbitrary\<T1>,T2 <: Arbitrary\<T2>

```cangjie
extend<T0, T1, T2> TupleWrapper3<T0, T1, T2> <: Arbitrary<TupleWrapper3<T0, T1, T2>>  where T0 <: Arbitrary<T0>,T1 <: Arbitrary<T1>,T2 <: Arbitrary<T2>
```

Function: Extends [Arbitrary](./unittest_prop_test_package_interfaces.md#interface-arbitrary) implementation for [TupleWrapper3](#struct-tuplewrapper3t0-t1-t2).

Parent type:

- [Arbitrary](unittest_prop_test_package_interfaces.md#interface-arbitrary)\<[TupleWrapper3](#struct-tuplewrapper3t0-t1-t2)\<T0, T1, T2>>

#### static func arbitrary(RandomSource)

```cangjie
public static func arbitrary(random: RandomSource): Generator<TupleWrapper3<T0, T1, T2>>
```

Function: Gets a generator for random values of type [TupleWrapper3](#struct-tuplewrapper3t0-t1-t2)\<T0, T1, T2>.

Return value:

- [Generator](../unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-generatort)\<[TupleWrapper3](#struct-tuplewrapper3t0-t1-t2)\<T0, T1, T2>> - The generator.

### extend\<T0, T1, T2> TupleWrapper3\<T0, T1, T2> <: Shrink\<TupleWrapper3\<T0, T1, T2>> where T0 <: Shrink\<T0>,T1 <: Shrink\<T1>,T2 <: Shrink\<T2>

```cangjie
extend<T0, T1, T2> TupleWrapper3<T0, T1, T2> <: Shrink<TupleWrapper3<T0, T1, T2>>
        where T0 <: Shrink<T0>,
              T1 <: Shrink<T1>,
              T2 <: Shrink<T2> {
    public func shrink(): Iterable<TupleWrapper3<T0, T1, T2>>
}
```

### func shrink()

```cangjie
override func shrink(): Iterable<TupleWrapper3<T0, T1, T2>>
```

Function: Shrinks the tuple.

Return value:

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<TupleWrapper3<T0, T1, T2> - Data iterator.## struct TupleWrapper4\<T0, T1, T2, T3>

```cangjie
public struct TupleWrapper4<T0, T1, T2, T3> {
    public TupleWrapper4(public let tuple: (T0, T1, T2, T3))
}
```

Function: Encapsulates a closure into a struct. The closure takes two parameters.

### TupleWrapper4((T0, T1, T2, T3))

```cangjie
public TupleWrapper4(public let tuple: (T0, T1, T2, T3))
```

Function: TupleWrapper4 constructor.

Parameters:

- tuple: (T0, T1, T2, T3) - The four input parameters of the closure.

### let tuple

```cangjie
public let tuple: (T0, T1, T2, T3)
```

Function: The tuple itself.

Type: (T0, T1, T2, T3)

### func apply\<R>((T0, T1, T2, T3) -> R)

```cangjie
public func apply<R>(f: (T0, T1, T2, T3) -> R): R
```

Function: Executes the closure function.

Parameters:

- f: (T0, T1, T2, T3) -> R - The closure to be executed.

Return Value:

- R - The execution result of the closure.

### extend\<T0, T1, T2, T3> TupleWrapper4\<T0, T1, T2, T3> <: ToString

```cangjie
extend<T0, T1, T2, T3> TupleWrapper4<T0, T1, T2, T3> <: ToString
```

Function: Extends [TupleWrapper4](#struct-tuplewrapper4t0-t1-t2-t3) with [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring) implementation.

Parent Type:

- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

#### func toString()

```cangjie
public func toString()
```

Function: String representation of [TupleWrapper4](#struct-tuplewrapper4t0-t1-t2-t3).

### extend\<T0, T1, T2, T3> TupleWrapper4\<T0, T1, T2, T3> <: Equatable\<TupleWrapper4\<T0, T1, T2, T3>>

```cangjie
extend<T0, T1, T2> TupleWrapper3<T0, T1, T2> <: Equatable<TupleWrapper3<T0, T1, T2>>
```

Function: Extends [TupleWrapper4](#struct-tuplewrapper4t0-t1-t2-t3) with [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet) implementation.

Parent Type:

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[TupleWrapper3](#struct-tuplewrapper3t0-t1-t2)\<T0, T1, T2>>

#### operator func ==(TupleWrapper4\<T0, T1, T2, T3>)

```cangjie
public operator func ==(other: TupleWrapper4<T0, T1, T2, T3>): Bool
```

Function: Compares two tuples.

Parameters:

- other: TupleWrapper4\<T0, T1, T2, T3> - The tuple to be compared.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if equal, otherwise `false`.

#### operator func !=(TupleWrapper4\<T0, T1, T2, T3>)

```cangjie
public operator func !=(other: TupleWrapper4<T0, T1，T2, T3>): Bool
```

Function: Compares two tuples.

Parameters:

- other: [TupleWrapper4](#struct-tuplewrapper4t0-t1-t2-t3)\<T0, T1, T2, T3> - The tuple to be compared.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if not equal, otherwise `false`.

### extend\<T0, T1, T2, T3> TupleWrapper4\<T0, T1, T2, T3> <: IndexAccess

```cangjie
extend<T0, T1, T2, T3> TupleWrapper4<T0, T1, T2, T3> <: IndexAccess
```

Function: Extends [TupleWrapper4](#struct-tuplewrapper4t0-t1-t2-t3) with [IndexAccess](./unittest_prop_test_package_interfaces.md#interface-indexaccess) implementation.

Parent Type:

- [IndexAccess](unittest_prop_test_package_interfaces.md#interface-indexaccess)

#### func getElementAsAny(Int64)

```cangjie
public func getElementAsAny(index: Int64): ?Any
```

Function: Retrieves the value inside the tuple by index.

Parameters:

- index: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The index value.

Return Value:

- ?[Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - The retrieved value inside the tuple. Returns `None` if the index is invalid.

### extend\<T0, T1, T2, T3> TupleWrapper4\<T0, T1, T2, T3><: Arbitrary\<TupleWrapper4\<T0, T1, T2, T3>> where where T0 <: Arbitrary\<T0>,T1 <: Arbitrary\<T1>,T2 <: Arbitrary\<T2>,T3 <: Arbitrary\<T3>

```cangjie
extend<T0, T1, T2, T3> TupleWrapper4<T0, T1, T2, T3><: Arbitrary<TupleWrapper4<T0, T1, T2, T3>> where where T0 <: Arbitrary<T0>,T1 <: Arbitrary<T1>,T2 <: Arbitrary<T2>,T3 <: Arbitrary<T3>
```

Function: Extends [TupleWrapper4](#struct-tuplewrapper4t0-t1-t2-t3) with [Arbitrary](./unittest_prop_test_package_interfaces.md#interface-arbitrary) implementation.

Parent Type:

- [Arbitrary](unittest_prop_test_package_interfaces.md#interface-arbitrary)\<[TupleWrapper4](#struct-tuplewrapper4t0-t1-t2-t3)\<T0, T1, T2, T3>>

#### static func arbitrary(RandomSource)

```cangjie
public static func arbitrary(random: RandomSource): Generator<TupleWrapper2<T0, T1, T2, T3>>
```

Function: Gets a generator for random values of type [TupleWrapper4](#struct-tuplewrapper4t0-t1-t2-t3)\<T0, T1, T2, T3>.

Return Value:

- [Generator](../unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-generatort)\<[TupleWrapper4](#struct-tuplewrapper4t0-t1-t2-t3)\<T0, T1, T2, T3>> - The generator.

### extend\<T0, T1, T2, T3> TupleWrapper4\<T0, T1, T2, T3> <: Shrink\<TupleWrapper4\<T0, T1, T2, T3>> where T0 <: Shrink\<T0>,T1 <: Shrink\<T1>,T2 <: Shrink\<T2>, T3 <: Shrink\<T3>

```cangjie
extend<T0, T1, T2, T3> TupleWrapper4<T0, T1, T2, T3> <: Shrink<TupleWrapper4<T0, T1, T2, T3>>
        where T0 <: Shrink<T0>,
              T1 <: Shrink<T1>,
              T2 <: Shrink<T2>,
              T3 <: Shrink<T3> {
    public func shrink(): Iterable<TupleWrapper4<T0, T1, T2, T3>>
}
```

### func shrink()

```cangjie
override func shrink(): Iterable<TupleWrapper4<T0, T1, T2, T3>>
```

Function: Shrinks the tuple.

Return Value:

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<TupleWrapper4<T0, T1, T2, T3>> - The data iterator.

## struct TupleWrapper5\<T0, T1, T2, T3, T4>

```cangjie
public struct TupleWrapper5<T0, T1, T2, T3, T4> {
    public TupleWrapper5(public let tuple: (T0, T1, T2, T3, T4))
}
```

Function: Encapsulates a closure into a struct. The closure takes two parameters.

### TupleWrapper5((T0, T1, T2, T3, T4))

```cangjie
public TupleWrapper5(public let tuple: (T0, T1, T2, T3, T4))
```

Function: TupleWrapper5 constructor.

Parameters:

- tuple: (T0, T1, T2, T3, T4) - The five input parameters of the closure.

### let tuple

```cangjie
public let tuple: (T0，T1, T2, T3, T4)
```

Function: The tuple itself.

Type: (T0, T1, T2, T3, T4)

### func apply\<R>((T0, T1, T2, T3, T4) -> R)

```cangjie
public func apply<R>(f: (T0, T1, T2, T3, T4) -> R): R
```

Function: Executes the closure function.

Parameters:

- f: (T0, T1, T2, T3, T4) -> R - The closure to be executed.

Return Value:

- R - The execution result of the closure.

### extend\<T0, T1, T2, T3, T4> TupleWrapper5\<T0, T1, T2, T3, T4> <: ToString

```cangjie
extend<T0, T1, T2, T3, T4> TupleWrapper5<T0, T1, T2, T3, T4> <: ToString
```

Function: Extends [TupleWrapper5](#struct-tuplewrapper5t0-t1-t2-t3-t4) with [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring) implementation.

Parent Type:

- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

#### func toString()

```cangjie
public func toString()
```

Function: String representation of [TupleWrapper5](#struct-tuplewrapper5t0-t1-t2-t3-t4).

### extend\<T0, T1, T2, T3, T4> TupleWrapper5\<T0, T1, T2, T3, T4> <: Equatable\<TupleWrapper5\<T0, T1, T2, T3, T4>>

```cangjie
extend<T0, T1, T2> TupleWrapper3<T0, T1, T2> <: Equatable<TupleWrapper3<T0, T1, T2>>
```

Function: Extends [TupleWrapper5](#struct-tuplewrapper5t0-t1-t2-t3-t4) with [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet) implementation.

Parent Type:

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[TupleWrapper3](#struct-tuplewrapper3t0-t1-t2)\<T0, T1, T2>>

#### operator func ==(TupleWrapper5\<T0, T1, T2, T3, T4>)

```cangjie
public operator func ==(other: TupleWrapper5<T0, T1, T2, T3, T4>): Bool
```

Function: Compares two binary tuples.

Parameters:

- other: [TupleWrapper5](#struct-tuplewrapper5t0-t1-t2-t3-t4)\<T0, T1, T2, T3> - The tuple to be compared.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if equal, otherwise `false`.

#### operator func !=(TupleWrapper5\<T0, T1, T2, T3, T4>)

```cangjie
public operator func !=(other: TupleWrapper2<T0, T1, T2, T3, T4>): Bool
```

Function: Compares two tuples.

Parameters:

- other: [TupleWrapper5](#struct-tuplewrapper5t0-t1-t2-t3-t4)\<T0, T1, T2, T3, T4> - The tuple to be compared.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if not equal, otherwise `false`.

### extend\<T0, T1, T2, T3, T4> TupleWrapper5\<T0, T1, T2, T3, T4> <: IndexAccess

```cangjie
extend<T0, T1, T2, T3, T4> TupleWrapper5<T0, T1, T2, T3, T4> <: IndexAccess
```

Function: Extends [TupleWrapper5](#struct-tuplewrapper5t0-t1-t2-t3-t4) with [IndexAccess](./unittest_prop_test_package_interfaces.md#interface-indexaccess) implementation.

Parent Type:

- [IndexAccess](unittest_prop_test_package_interfaces.md#interface-indexaccess)

#### func getElementAsAny(Int64)

```cangjie
public func getElementAsAny(index: Int64): ?Any
```

Function: Retrieves the value inside the tuple by index.

Parameters:

- index: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The index value.

Return Value:

- ?[Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - The retrieved value inside the tuple. Returns `None` if the index is invalid.

### extend\<T0, T1, T2, T3, T4> TupleWrapper5\<T0, T1, T2, T3, T4> <: Arbitrary\<TupleWrapper2\<T0, T1, T2, T3, T4>> where T0 <: Arbitrary\<T0>,T1 <: Arbitrary\<T1>,T2 <: Arbitrary\<T2>,T3 <: Arbitrary\<T3>,T4 <: Arbitrary\<T4>

```cangjie
extend<T0, T1, T2, T3, T4> TupleWrapper5<T0, T1, T2, T3, T4> <: Arbitrary<TupleWrapper2<T0, T1, T2, T3, T4>> where T0 <: Arbitrary<T0>,T1 <: Arbitrary<T1>,T2 <: Arbitrary<T2>,T3 <: Arbitrary<T3>,T4 <: Arbitrary<T4>
```

Function: Extends [TupleWrapper5](#struct-tuplewrapper5t0-t1-t2-t3-t4) with [Arbitrary](./unittest_prop_test_package_interfaces.md#interface-arbitrary) implementation.

Parent Type:

- [Arbitrary](unittest_prop_test_package_interfaces.md#interface-arbitrary)\<[TupleWrapper2](#struct-tuplewrapper2t0-t1)\<T0, T1, T2, T3, T4>>

#### static func arbitrary(RandomSource)

```cangjie
public static func arbitrary(random: RandomSource): Generator<TupleWrapper5<T0, T1, T2, T3, T4>>
```

Function: Gets a generator for random values of type [TupleWrapper5](#struct-tuplewrapper5t0-t1-t2-t3-t4)\<T0, T1, T2, T3, T4>.

Return Value:

- [Generator](../unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-generatort)\[TupleWrapper5](#struct-tuplewrapper5t0-t1-t2-t3-t4)\<T0, T1, T2, T3, T4>> - The generator.

### extend\<T0, T1, T2, T3, T4> TupleWrapper5\<T0, T1, T2, T3, T4> <: Shrink\<TupleWrapper5\<T0, T1, T2, T3, T4>> where T0 <: Shrink\<T0>,T1 <: Shrink\<T1>,T2 <: Shrink\<T2>, T3 <: Shrink\<T3>, T4 <: Shrink\<T4>

```cangjie
extend<T0, T1, T2, T3, T4> TupleWrapper5<T0, T1, T2, T3, T4> <: Shrink<TupleWrapper5<T0, T1, T2, T3, T4>>
        where T0 <: Shrink<T0>,
              T1 <: Shrink<T1>,
              T2 <: Shrink<T2>,
              T3 <: Shrink<T3>,
              T4 <: Shrink<T4> {
    public func shrink(): Iterable<TupleWrapper5<T0, T1, T2, T3, T4>>
}
```

### func shrink()

```cangjie
override func shrink(): Iterable<TupleWrapper5<T0, T1, T2, T3, T4>>
```

Function: Shrinks the tuple.

Return Value:

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee