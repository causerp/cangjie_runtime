# Enums

## enum AnnotationKind

```cangjie
public enum AnnotationKind {
    | Type
    | Parameter
    | Init
    | MemberProperty
    | MemberFunction
    | MemberVariable
    | EnumConstructor
    | GlobalFunction
    | GlobalVariable
    | Extension
    | ...
}
```

Function: Indicates the supported locations for custom annotations.

### EnumConstructor

```cangjie
EnumConstructor
```

Function: Enum constructor declaration.

### Extension

```cangjie
Extension
```

Function: Extension declaration.

### Init

```cangjie
Init
```

Function: Constructor declaration.

### GlobalFunction

```cangjie
GlobalFunction
```

Function: Global function declaration.

### GlobalVariable

```cangjie
GlobalVariable
```

Function: Global variable declaration.

### MemberFunction

```cangjie
MemberFunction
```

Function: Member function declaration.

### MemberProperty

```cangjie
MemberProperty
```

Function: Member property declaration.

### MemberVariable

```cangjie
MemberVariable
```

Function: Member variable declaration.

### Parameter

```cangjie
Parameter
```

Function: Parameter in member functions/constructors (excluding enum constructor parameters).

### Type

```cangjie
Type
```

Function: Type declaration (class, struct, enum, interface).

## enum Endian

```cangjie
public enum Endian {
    | Big
    | Little
}
```

Function: The enum type [Endian](core_package_enums.md#enum-endian) represents the endianness of the runtime platform, divided into big-endian and little-endian.

### Big

```cangjie
Big
```

Function: Represents big-endian.

### Little

```cangjie
Little
```

Function: Represents little-endian.

### static prop Platform

```cangjie
public static prop Platform: Endian
```

Function: Gets the endianness of the current runtime platform.

Type: [Endian](core_package_enums.md#enum-endian)

Exceptions:

- [UnsupportedException](core_package_exceptions.md#class-unsupportedexception) - Thrown when the endianness returned by the runtime platform is unrecognizable.

Example:

<!-- verify -->
```cangjie
main() {
    let e = Endian.Platform
    match (e) {
        case Big => println("BigEndian")
        case Little => println("LittleEndian")
    }
}
```

Execution Result:

```text
LittleEndian
```

## enum Option\<T>

```cangjie
public enum Option<T> {
    | Some(T)
    | None
}
```

Function: [Option](core_package_enums.md#enum-optiont)\<T> is a wrapper for type `T`, indicating the possibility of having a value or no value.

It contains two constructors: [Some](#somet) and [None](#none). [Some](#somet) carries a parameter indicating a value exists, while [None](#none) has no parameter indicating no value. When needing to represent that a type may or may not have a value, the [Option](core_package_enums.md#enum-optiont) type can be used.

An alternative syntax for the [Option](core_package_enums.md#enum-optiont) type is prefixing the type name with `?`, meaning for any type `Type`, `?Type` is equivalent to [Option](core_package_enums.md#enum-optiont)\<Type>.

### None

```cangjie
None
```

Function: Constructs a parameterless [Option](core_package_enums.md#enum-optiont)\<T> instance, indicating no value.

### Some(T)

```cangjie
Some(T)
```

Function: Constructs a parameterized [Option](core_package_enums.md#enum-optiont)\<T> instance, indicating a value exists.

### func filter((T)->Bool)

```cangjie
public func filter(predicate: (T) -> Bool): Option<T>
```

Function: Provides "filter" functionality for the [Option](core_package_enums.md#enum-optiont) type.

Parameters:

- predicate: (T) -> [Bool](core_package_intrinsics.md#bool) - The filter function.

Return Value:

- Option\<T> - If the [Option](core_package_enums.md#enum-optiont) value is [Some](#somet)(v) and v satisfies `predicate(v) = true`, returns [Some](#somet)(v); otherwise returns [None](#none).

### func flatMap\<R>((T) -> Option\<R>)

```cangjie
public func flatMap<R>(transform: (T) -> Option<R>): Option<R>
```

Function: Provides a mapping function from [Option](core_package_enums.md#enum-optiont)\<T> to [Option](core_package_enums.md#enum-optiont)\<R>. If the current instance value is [Some](#somet), executes the transform function and returns the result; otherwise returns [None](#none).

Parameters:

- transform: (T) -> [Option](core_package_enums.md#enum-optiont)\<R> - The mapping function.

Return Value:

- [Option](core_package_enums.md#enum-optiont)\<R> - If the current instance value is [Some](#somet), executes the transform function and returns the result; otherwise returns [None](#none).

### func getOrDefault(() -> T)

```cangjie
public func getOrDefault(other: () -> T): T
```

Function: Gets the value or returns a default value. If the [Option](core_package_enums.md#enum-optiont) value is [Some](#somet), returns the instance of type `T`; if the [Option](core_package_enums.md#enum-optiont) value is [None](#none), calls the input parameter to return an instance of type `T`.

Parameters:

- other: () -> T - The default function. If the current instance value is [None](#none), calls this function to get an instance of type `T` and returns it.

Return Value:

- T - If the current instance value is [Some](#somet)\<T>, returns the carried instance of type `T`; if the [Option](core_package_enums.md#enum-optiont) value is [None](#none), calls the specified function to get an instance of type `T` and returns it.

Example:

<!-- verify -->
```cangjie
main() {
    var value1: Option<Int64> = Some(2)
    println(value1.getOrDefault({=> 0}))

    var value2: Option<Int64> = None
    println(value2.getOrDefault({=> 0}))
}
```

Execution Result:

```text
2
0
```

### func getOrThrow(() -> Exception)

```cangjie
public func getOrThrow(exception: ()->Exception): T
```

Function: Gets the value or throws a specified exception.

Parameters:

- exception: () ->[Exception](core_package_exceptions.md#class-exception) - The exception function. If the current instance value is [None](#none), executes this function and throws its return value as an exception.

Return Value:

- T - If the current instance value is [Some](#somet)\<T>, returns the instance of type `T`.

Exceptions:

- [Exception](core_package_exceptions.md#class-exception) - If the current instance is [None](#none), throws the exception returned by the exception function.

### func getOrThrow()

```cangjie
public func getOrThrow(): T
```

Function: Gets the value or throws an exception.

Return Value:

- T - If the current instance value is [Some](#somet)\<T>, returns the instance of type `T`.

Exceptions:

- [NoneValueException](core_package_exceptions.md#class-nonevalueexception) - If the current instance is [None](#none), throws an exception.

### func isNone()

```cangjie
public func isNone(): Bool
```

Function: Determines whether the current instance value is [None](#none).

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns `true` if the current instance value is [None](#none), otherwise returns `false`.

### func isSome()

```cangjie
public func isSome(): Bool
```

Function: Determines whether the current instance value is [Some](#somet).

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns `true` if the current instance value is [Some](#somet), otherwise returns `false`.

### func map\<R>((T)->R)

```cangjie
public func map<R>(transform: (T)-> R): Option<R>
```

Function: Provides a mapping function from [Option](#enum-optiont)\<T> type to [Option](#enum-optiont)\<R> type. If the current instance value is [Some](#somet), executes the `transform` function and returns the result encapsulated in [Some](#somet); otherwise returns [None](#none).

Parameters:

- transform: (T)-> R - The mapping function.

Return Value:

- [Option](core_package_enums.md#enum-optiont)\<R> - If the current instance value is [Some](#somet), executes the `transform` function and returns the result as [Option](#enum-optiont)\<R> type; otherwise returns [None](#none).

### extend\<T> Option\<T> <: Equatable\<Option\<T>> where T <: Equatable\<T>

```cangjie
extend<T> Option<T> <: Equatable<Option<T>> where T <: Equatable<T>
```

Function: Extends the [Option](core_package_enums.md#enum-optiont)\<T> enum with the [Equatable](core_package_interfaces.md#interface-equatablet)\<[Option](core_package_enums.md#enum-optiont)\<T>> interface, supporting equality comparison operations.

Parent Types:

- [Equatable](core_package_interfaces.md#interface-equatablet)\<[Option](#enum-optiont)\<T>>

#### operator func !=(Option\<T>)

```cangjie
public operator func !=(that: Option<T>): Bool
```

Function: Determines whether the current instance is not equal to the parameter-specified [Option](core_package_enums.md#enum-optiont)\<T> instance.

Parameters:

- that: [Option](core_package_enums.md#enum-optiont)\<T> - The [Option](core_package_enums.md#enum-optiont)\<T> instance to compare.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns `true` if not equal, otherwise `false`.

#### operator func ==(Option\<T>)

```cangjie
public operator func ==(that: Option<T>): Bool
```

Function: Determines whether the current instance is equal to the parameter-specified [Option](core_package_enums.md#enum-optiont)\<T> instance.

If both are None, they are equal; if both are Some(v1) and Some(v2), and v1 equals v2, they are equal.

Parameters:

- that: [Option](core_package_enums.md#enum-optiont)\<T> - The [Option](core_package_enums.md#enum-optiont)\<T> instance to compare.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns `true` if equal, otherwise `false`.

### extend\<T> Option\<T> <: Hashable where T <: Hashable

```cangjie
extend<T> Option<T> <: Hashable where T <: Hashable
```

Function: Extends the [Option](core_package_enums.md#enum-optiont) type with the [Hashable](core_package_interfaces.md#interface-hashable) interface.

The hash value of [Some](#somet)\<T> equals the hash value of `T`, while the hash value of [None](#none) equals [Int64](core_package_intrinsics.md#int64)(0).

Parent Types:

- [Hashable](core_package_interfaces.md#interface-hashable)

#### func hashCode()

```cangjie
public func hashCode(): Int64
```

Function: Retrieves the hash value.

Return Value:

- [Int64](core_package_intrinsics.md#int64) - The hash value.

### extend\<T> Option\<T> <: ToString where T <: ToString

```cangjie
extend<T> Option<T> <: ToString where T <: ToString
```

Function: Implements the [ToString](core_package_interfaces.md#interface-tostring) interface for the [Option](core_package_enums.md#enum-optiont)\<T> enum, supporting string conversion operations.

Parent Types:

- [ToString](core_package_interfaces.md#interface-tostring)

#### func toString()

```cangjie
public func toString(): String
```

Function: Converts [Option](core_package_enums.md#enum-optiont) to an outputtable string, formatted as "Some(${T.toString()})" or "None".

Return Value:

- [String](core_package_structs.md#struct-string) - The converted string.

### extend\<T> Option\<Option\<T>>

```cangjie
extend<T> Option<Option<T>>
```

Function: Extends certain functionalities for the Option\<Option\<T>> type.

#### func flatten()

```cangjie
public func flatten(): Option<T>
```

Function: Flattens the [Option](core_package_enums.md#enum-optiont)\<[Option](core_package_enums.md#enum-optiont)\<T>> type. If the current instance is [Some](#somet)([Option](core_package_enums.md#enum-optiont)\<T>.[Some](#somet)(v)), the flattened result is [Some](#somet)(v).

Return Value:

- [Option](core_package_enums.md#enum-optiont)\<T> - The flattened result of [Option](core_package_enums.md#enum-optiont)\<[Option](core_package_enums.md#enum-optiont)\<T>> type.

## enum Ordering

```cangjie
public enum Ordering {
    | LT
    | GT
    | EQ
}
```

Function: [Ordering](core_package_enums.md#enum-ordering) represents the result of a comparison, encompassing three cases: less than, greater than, and equal.

### EQ

```cangjie
EQ
```

Function: Constructs an [Ordering](core_package_enums.md#enum-ordering) instance representing equality.

### GT

```cangjie
GT
```

Function: Constructs an [Ordering](core_package_enums.md#enum-ordering) instance representing greater than.

### LT

```cangjie
LT
```

Function: Constructs an [Ordering](core_package_enums.md#enum-ordering) instance representing less than.

### extend Ordering <: Comparable

```cangjie
extend Ordering <: Comparable<Ordering>
```

Function: Extends the [Ordering](core_package_enums.md#enum-ordering) type with the [Comparable](core_package_interfaces.md#interface-comparablet)\<[Ordering](core_package_enums.md#enum-ordering)> interface, supporting comparison operations.

Parent Types:

- [Comparable](core_package_interfaces.md#interface-comparablet)\<[Ordering](#enum-ordering)>

#### func compare(Ordering)

```cangjie
public func compare(that: Ordering): Ordering
```

Function: Determines the size relationship between the current [Ordering](core_package_enums.md#enum-ordering) instance and the parameter-specified [Ordering](core_package_enums.md#enum-ordering) instance.

The size relationship for [Ordering](core_package_enums.md#enum-ordering) enum is: GT > EQ > LT.

Parameters:

- that: [Ordering](core_package_enums.md#enum-ordering) - The [Ordering](core_package_enums.md#enum-ordering) instance to compare.

Return Value:

- [Ordering](core_package_enums.md#enum-ordering) - Returns GT if greater than; EQ if equal; LT if less than.

### extend Ordering <: Hashable

```cangjie
extend Ordering <: Hashable
```

Function: Extends the [Ordering](core_package_enums.md#enum-ordering) type with the [Hashable](core_package_interfaces.md#interface-hashable) interface, supporting hash value computation.

Parent Types:

- [Hashable](core_package_interfaces.md#interface-hashable)

#### func hashCode

```cangjie
public func hashCode(): Int64
```

Function: Retrieves the hash value. GT's hash value is 3, EQ's is 2, and LT's is 1.

Return Value:

- [Int64](core_package_intrinsics.md#int64) - The hash value.

### extend Ordering <: ToString

```cangjie
extend Ordering <: ToString
```

Function: Extends the [Ordering](core_package_enums.md#enum-ordering) type with the [ToString](core_package_interfaces.md#interface-tostring) interface, supporting string conversion operations.

Parent Types:

- [ToString](core_package_interfaces.md#interface-tostring)

#### func toString()

```cangjie
public func toString(): String
```

Function: Converts [Ordering](core_package_enums.md#enum-ordering) to an outputtable string.

Conversion results are as follows:

- GT: "[Ordering](core_package_enums.md#enum-ordering).GT".
- LT: "[Ordering](core_package_enums.md#enum-ordering).LT".
- EQ: "[Ordering](core_package_enums.md#enum-ordering).EQ".

Return Value:

- [String](core_package_structs.md#struct-string) - The converted string.
```