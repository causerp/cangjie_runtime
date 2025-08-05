# Structs

## struct Function0Wrapper\<R>

```cangjie
public struct Function0Wrapper<R> {
    public Function0Wrapper(public let function: () -> R)
}
```

Function: Encapsulates a closure into a struct.

### Function0Wrapper(() -> R)

```cangjie
public Function0Wrapper(public let function: () -> R)
```

Function: Constructor for Function0Wrapper.

Parameters:

- function: () -> R - The closure to be encapsulated.

### operator func ()()

```cangjie
public operator func () (): R
```

Function: Call operator function. Converts the closure into a callable operator function of the struct.

Return value:

- R - Same as the return value of the closure.

### extend\<R> Function0Wrapper\<R> <: Arbitrary\<Function0Wrapper\<R>> where R <: Arbitrary\<R>

```cangjie
extend<R> Function0Wrapper<R> <: Arbitrary<Function0Wrapper<R>> where R <: Arbitrary<R>
```

Function: Extends [Function0Wrapper](#struct-function0wrapperr) with [Arbitrary](./unittest_prop_test_package_interfaces.md#interface-arbitrary) implementation.

Parent type:

- [Arbitrary](unittest_prop_test_package_interfaces.md#interface-arbitrary)\<[Function0Wrapper](#struct-function0wrapperr)\<R>>

#### static func arbitrary(RandomSource)

```cangjie
public static func arbitrary(random: RandomSource): Generator<Function0Wrapper<R>>
```

Function: Gets a generator for random values of type [Function0Wrapper](#struct-function0wrapperr)\<R>.

## struct TupleWrapper2\<T0, T1>

```cangjie
public struct TupleWrapper2<T0, T1> {
    public TupleWrapper2(public let tuple: (T0, T1))
}
```

Function: Encapsulates a closure into a struct. The closure takes two parameters.

### TupleWrapper2((T0, T1))

```cangjie
public TupleWrapper2(public let tuple: (T0, T1))
```

Function: Constructor for TupleWrapper2.

Parameters:

- tuple: (T0, T1) - The two input parameters of the closure.

### func apply\<R>(f: (T0, T1) -> R)

```cangjie
public func apply<R>(f: (T0, T1) -> R): R
```

Function: Executes the closure function.

Parameters:

- f: (T0, T1) -> R - The closure to be executed.

Return value:

- R - The execution result of the closure.

### extend\<T0, T1> TupleWrapper2\<T0, T1> <: ToString

```cangjie
extend<T0, T1> TupleWrapper2<T0, T1> <: ToString
```

Function: Extends [TupleWrapper2](#struct-tuplewrapper2t0-t1) with [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring) implementation.

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

Function: Extends [TupleWrapper2](#struct-tuplewrapper2t0-t1) with [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet) implementation.

Parent type:

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[TupleWrapper2](#struct-tuplewrapper2t0-t1)\<T0, T1>>

#### operator func ==(TupleWrapper2\<T0, T1>)

```cangjie
public operator func ==(other: TupleWrapper2<T0, T1>)
```

Function: Compares two 2-element tuples.

Parameters:

- other: [TupleWrapper2](#struct-tuplewrapper2t0-t1)\<T0, T1> - The tuple to compare.

Return value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if equal, otherwise `false`.

#### operator func !=(TupleWrapper2\<T0, T1>)

```cangjie
public operator func !=(other: TupleWrapper2<T0, T1>)
```

Function: Compares two 2-element tuples.

Parameters:

- other: [TupleWrapper2](#struct-tuplewrapper2t0-t1)\<T0, T1> - The tuple to compare.

Return value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if not equal, otherwise `false`.

### extend\<T0, T1> TupleWrapper2\<T0, T1> <: IndexAccess

```cangjie
extend<T0, T1> TupleWrapper2<T0, T1> <: IndexAccess
```

Function: Extends [TupleWrapper2](#struct-tuplewrapper2t0-t1) with [IndexAccess](./unittest_prop_test_package_interfaces.md#interface-indexaccess) implementation.

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

Function: Extends [TupleWrapper2](#struct-tuplewrapper2t0-t1) with [Arbitrary](./unittest_prop_test_package_interfaces.md#interface-arbitrary) implementation.

Parent type:

- [Arbitrary](unittest_prop_test_package_interfaces.md#interface-arbitrary)\<[TupleWrapper2](#struct-tuplewrapper2t0-t1)\<T0, T1>>

#### static func arbitrary(RandomSource)

```cangjie
public static func arbitrary(random: RandomSource): Generator<TupleWrapper2<T0, T1>>
```

Function: Gets a generator for random values of type [TupleWrapper2](#struct-tuplewrapper2t0-t1)\<T0, T1>.

## struct TupleWrapper3\<T0, T1, T2>

```cangjie
public struct TupleWrapper3<T0, T1, T2> {
    public TupleWrapper3(public let tuple: (T0, T1,T2))
}
```

Function: Encapsulates a closure into a struct. The closure takes two parameters.

### TupleWrapper3((T0, T1,T2))

```cangjie
public TupleWrapper3(public let tuple: (T0, T1,T2))
```

Function: Constructor for TupleWrapper3.

Parameters:

- tuple: (T0, T1,T2) - The two input parameters of the closure.

### func apply\<R>(f: (T0, T1,T2) -> R)

```cangjie
public func apply<R>(f: (T0, T1,T2) -> R): R
```

Function: Executes the closure function.

Parameters:

- f: (T0, T1,T2) -> R - The closure to be executed.

Return value:

- R - The execution result of the closure.

### extend\<T0, T1, T2> TupleWrapper3\<T0, T1, T2> <: ToString

```cangjie
extend<T0, T1, T2> TupleWrapper3<T0, T1, T2> <: ToString
```

Function: Extends [TupleWrapper3](#struct-tuplewrapper3t0-t1-t2) with [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring) implementation.

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

Function: Extends [TupleWrapper3](#struct-tuplewrapper3t0-t1-t2) with [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet) implementation.

Parent type:

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[TupleWrapper3](#struct-tuplewrapper3t0-t1-t2)\<T0, T1, T2>>

#### operator func ==(TupleWrapper3\<T0, T1, T2>)

```cangjie
public operator func ==(other: TupleWrapper3<T0, T1, T2>)
```

Function: Compares two tuples.

Parameters:

- other: [TupleWrapper3](#struct-tuplewrapper3t0-t1-t2)\<T0, T1, T2> - The tuple to compare.

Return value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if equal, otherwise `false`.

#### operator func !=(TupleWrapper3\<T0, T1, T2>)

```cangjie
public operator func !=(other: TupleWrapper3<T0, T1, T2>)
```

Function: Compares two tuples.Parameters:

- other: [TupleWrapper3](#struct-tuplewrapper3t0-t1-t2)\<T0, T1, T2> - The tuple to be compared.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` when not equal, otherwise returns `false`.

### extend\<T0, T1, T2> TupleWrapper3\<T0, T1, T2> <: IndexAccess

```cangjie
extend<T0, T1, T2> TupleWrapper3<T0, T1, T2> <: IndexAccess
```

Function: Extends [TupleWrapper3](#struct-tuplewrapper3t0-t1-t2) with [IndexAccess](./unittest_prop_test_package_interfaces.md#interface-indexaccess) implementation.

Parent Type:

- [IndexAccess](unittest_prop_test_package_interfaces.md#interface-indexaccess)

#### func getElementAsAny(Int64)

```cangjie
public func getElementAsAny(index: Int64): ?Any
```

Function: Retrieves a value from the tuple by index.

Parameters:

- index: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The index value.

Return Value:

- ?[Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - The retrieved value from the tuple. Returns `None` if the index is invalid.

### extend\<T0, T1, T2> TupleWrapper3\<T0, T1, T2> <: Arbitrary\<TupleWrapper3\<T0, T1, T2>> where T0 <: Arbitrary\<T0>, T1 <: Arbitrary\<T1>, T2 <: Arbitrary\<T2>

```cangjie
extend<T0, T1, T2> TupleWrapper3<T0, T1, T2> <: Arbitrary<TupleWrapper3<T0, T1, T2>> where T0 <: Arbitrary<T0>, T1 <: Arbitrary<T1>, T2 <: Arbitrary<T2>
```

Function: Extends [TupleWrapper3](#struct-tuplewrapper3t0-t1-t2) with [Arbitrary](./unittest_prop_test_package_interfaces.md#interface-arbitrary) implementation.

Parent Type:

- [Arbitrary](unittest_prop_test_package_interfaces.md#interface-arbitrary)\<[TupleWrapper3](#struct-tuplewrapper3t0-t1-t2)\<T0, T1, T2>>

#### static func arbitrary(RandomSource)

```cangjie
public static func arbitrary(random: RandomSource): Generator<TupleWrapper3<T0, T1, T2>>
```

Function: Obtains a generator for random values of type [TupleWrapper3](#struct-tuplewrapper3t0-t1-t2)\<T0, T1, T2>.

## struct TupleWrapper4\<T0, T1, T2, T3>

```cangjie
public struct TupleWrapper4<T0, T1, T2, T3> {
    public TupleWrapper4(public let tuple: (T0, T1, T2, T3))
}
```

Function: Encapsulates a closure into a struct. The closure takes four parameters.

### TupleWrapper4((T0, T1, T2, T3))

```cangjie
public TupleWrapper4(public let tuple: (T0, T1, T2, T3))
```

Function: Constructor for TupleWrapper4.

Parameters:

- tuple: (T0, T1, T2, T3) - The four input parameters of the closure.

### func apply\<R>(f: (T0, T1, T2, T3) -> R)

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
public operator func ==(other: TupleWrapper4<T0, T1, T2, T3>)
```

Function: Compares two tuples.

Parameters:

- other: TupleWrapper4\<T0, T1, T2, T3> - The tuple to be compared.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` when equal, otherwise returns `false`.

#### operator func !=(TupleWrapper4\<T0, T1, T2, T3>)

```cangjie
public operator func !=(other: TupleWrapper4<T0, T1, T2, T3>)
```

Function: Compares two tuples.

Parameters:

- other: [TupleWrapper4](#struct-tuplewrapper4t0-t1-t2-t3)\<T0, T1, T2, T3> - The tuple to be compared.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` when not equal, otherwise returns `false`.

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

Function: Retrieves a value from the tuple by index.

Parameters:

- index: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The index value.

Return Value:

- ?[Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - The retrieved value from the tuple. Returns `None` if the index is invalid.

### extend\<T0, T1, T2, T3> TupleWrapper4\<T0, T1, T2, T3> <: Arbitrary\<TupleWrapper4\<T0, T1, T2, T3>> where T0 <: Arbitrary\<T0>, T1 <: Arbitrary\<T1>, T2 <: Arbitrary\<T2>, T3 <: Arbitrary\<T3>

```cangjie
extend<T0, T1, T2, T3> TupleWrapper4<T0, T1, T2, T3> <: Arbitrary<TupleWrapper4<T0, T1, T2, T3>> where T0 <: Arbitrary<T0>, T1 <: Arbitrary<T1>, T2 <: Arbitrary<T2>, T3 <: Arbitrary<T3>
```

Function: Extends [TupleWrapper4](#struct-tuplewrapper4t0-t1-t2-t3) with [Arbitrary](./unittest_prop_test_package_interfaces.md#interface-arbitrary) implementation.

Parent Type:

- [Arbitrary](unittest_prop_test_package_interfaces.md#interface-arbitrary)\<[TupleWrapper4](#struct-tuplewrapper4t0-t1-t2-t3)\<T0, T1, T2, T3>>

#### static func arbitrary(RandomSource)

```cangjie
public static func arbitrary(random: RandomSource): Generator<TupleWrapper2<T0, T1, T2, T3>>
```

Function: Obtains a generator for random values of type [TupleWrapper4](#struct-tuplewrapper4t0-t1-t2-t3)\<T0, T1, T2, T3>.

## struct TupleWrapper5\<T0, T1, T2, T3, T4>

```cangjie
public struct TupleWrapper5<T0, T1, T2, T3, T4> {
    public TupleWrapper5(public let tuple: (T0, T1, T2, T3, T4))
}
```

Function: Encapsulates a closure into a struct. The closure takes five parameters.

### TupleWrapper5((T0, T1, T2, T3, T4))

```cangjie
public TupleWrapper5(public let tuple: (T0, T1, T2, T3, T4))
```

Function: Constructor for TupleWrapper5.

Parameters:

- tuple: (T0, T1, T2, T3, T4) - The five input parameters of the closure.

### func apply\<R>(f: (T0, T1, T2, T3, T4) -> R)

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
public operator func ==(other: TupleWrapper5<T0, T1, T2, T3, T4>)
```

Function: Compares two binary tuples.

Parameters:

- other: [TupleWrapper5](#struct-tuplewrapper5t0-t1-t2-t3-t4)\<T0, T1, T2, T3> - The tuple to be compared.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` when equal, otherwise returns `false`.

#### operator func !=(TupleWrapper5\<T0, T1, T2, T3, T4>)

```cangjie
public operator func !=(other: TupleWrapper2<T0, T1, T2, T3, T4>)
```

Function: Compares two tuples.Parameters:

- other: [TupleWrapper5](#struct-tuplewrapper5t0-t1-t2-t3-t4)\<T0, T1, T2, T3, T4> - The tuple to be compared.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` when not equal, otherwise returns `false`.

### extend\<T0, T1, T2, T3, T4> TupleWrapper5\<T0, T1, T2, T3, T4> <: IndexAccess

```cangjie
extend<T0, T1, T2, T3, T4> TupleWrapper5<T0, T1, T2, T3, T4> <: IndexAccess
```

Function: Extends [IndexAccess](./unittest_prop_test_package_interfaces.md#interface-indexaccess) implementation for [TupleWrapper5](#struct-tuplewrapper5t0-t1-t2-t3-t4).

Parent Type:

- [IndexAccess](unittest_prop_test_package_interfaces.md#interface-indexaccess)

#### func getElementAsAny(Int64)

```cangjie
public func getElementAsAny(index: Int64): ?Any
```

Function: Retrieves the value within the tuple by index.

Parameters:

- index: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The index value.

Return Value:

- ?[Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - The retrieved value within the tuple. Returns `None` when the index is invalid.

### extend\<T0, T1, T2, T3, T4> TupleWrapper5\<T0, T1, T2, T3, T4> <: Arbitrary\<TupleWrapper2\<T0, T1, T2, T3, T4>> where T0 <: Arbitrary\<T0>,T1 <: Arbitrary\<T1>,T2 <: Arbitrary\<T2>,T3 <: Arbitrary\<T3>,T4 <: Arbitrary\<T4>

```cangjie
extend<T0, T1, T2, T3, T4> TupleWrapper5<T0, T1, T2, T3, T4> <: Arbitrary<TupleWrapper2<T0, T1, T2, T3, T4>> where T0 <: Arbitrary<T0>,T1 <: Arbitrary<T1>,T2 <: Arbitrary<T2>,T3 <: Arbitrary<T3>,T4 <: Arbitrary<T4>
```

Function: Extends [Arbitrary](./unittest_prop_test_package_interfaces.md#interface-arbitrary) implementation for [TupleWrapper5](#struct-tuplewrapper5t0-t1-t2-t3-t4).

Parent Type:

- [Arbitrary](unittest_prop_test_package_interfaces.md#interface-arbitrary)\<[TupleWrapper2](#struct-tuplewrapper2t0-t1)\<T0, T1, T2, T3, T4>>

#### static func arbitrary(RandomSource)

```cangjie
public static func arbitrary(random: RandomSource): Generator<TupleWrapper5<T0, T1, T2, T3, T4>>
```

Function: Obtains a generator for random values of type [TupleWrapper5](#struct-tuplewrapper5t0-t1-t2-t3-t4)\<T0, T1, T2, T3, T4>.