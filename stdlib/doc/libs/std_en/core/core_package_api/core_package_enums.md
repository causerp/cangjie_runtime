# Enumerations

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

Function: Parameters in member functions/constructors (excluding enum constructor parameters).

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

Function: The enumeration type [Endian](core_package_enums.md#enum-endian) represents the endianness of the runtime platform, divided into big-endian and little-endian.

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

Function: Gets the endianness of the runtime platform.

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

It contains two constructors: [Some](#somet) and [None](#none). [Some](#somet) carries a parameter indicating a value exists, while [None](#none) has no parameter, indicating no value. When you need to represent that a type may or may not have a value, you can use the [Option](core_package_enums.md#enum-optiont) type.

An alternative notation for the [Option](core_package_enums.md#enum-optiont) type is prefixing the type name with `?`. For any type `Type`, `?Type` is equivalent to [Option](core_package_enums.md#enum-optiont)\<Type>.

### None

```cangjie
None
```

Function: Constructs a parameterless [Option](core_package_enums.md#enum-optiont)\<T> instance, indicating no value.

### Some(T)

```cangjie
Some(T)
```

Function: Constructs an [Option](core_package_enums.md#enum-optiont)\<T> instance with a parameter, indicating a value exists.

### func filter((T)->Bool)

```cangjie
public func filter(predicate: (T) -> Bool): Option<T>
```

Function: Provides "filter" functionality for the [Option](core_package_enums.md#enum-optiont) type.

Parameters:

- predicate: (T) -> [Bool](core_package_intrinsics.md#bool) - The filter function.

Return Value:

- Option\<T> - If the [Option](core_package_enums.md#enum-optiont) value is [Some](#somet)(v) and v satisfies `predicate(v) = true`, returns [Some](#somet)(v); otherwise, returns [None](#none).

Example:

<!-- verify -->
```cangjie
main() {
    // Create a Some value
    var someValue: Option<Int64> = Some(5)
    
    // Filter values greater than 3
    var filtered1 = someValue.filter({x => x > 3})
    println("Filter values > 3: ${filtered1}")
    
    // Filter values less than 3
    var filtered2 = someValue.filter({x => x < 3})
    println("Filter values < 3: ${filtered2}")
    
    // Create a None value
    var noneValue: Option<Int64> = None
    
    // Apply filter to None value
    var filtered3 = noneValue.filter({x => x > 3})
    println("Filter None value: ${filtered3}")
}
```

Execution Result:

```text
Filter values > 3: Some(5)
Filter values < 3: None
Filter None value: None
```

### func flatMap\<R>((T) -> Option\<R>)

```cangjie
public func flatMap<R>(transform: (T) -> Option<R>): Option<R>
```

Function: Provides a mapping function from [Option](core_package_enums.md#enum-optiont)\<T> to [Option](core_package_enums.md#enum-optiont)\<R>. If the current instance value is [Some](#somet), executes the transform function and returns the result; otherwise, returns [None](#none).

Parameters:

- transform: (T) -> [Option](core_package_enums.md#enum-optiont)\<R> - The mapping function.

Return Value:

- [Option](core_package_enums.md#enum-optiont)\<R> - If the current instance value is [Some](#somet), executes the transform function and returns the result; otherwise, returns [None](#none).

Example:

<!-- verify -->
```cangjie
// Define a function to convert Int64 to Option<String>
func intToStringOption(x: Int64): Option<String> {
    if (x > 0) {
        return Some("Positive: ${x}")
    } else {
        return None
    }
}

main() {
    // Create a Some value
    var someValue: Option<Int64> = Some(5)
    
    // Use flatMap to convert Int64 to String
    var flatMapped1 = someValue.flatMap(intToStringOption)
    println("Apply flatMap to Some value: ${flatMapped1}")
    
    // Create a negative Some value
    var someNegativeValue: Option<Int64> = Some(-3)
    
    // Apply flatMap to negative value
    var flatMapped2 = someNegativeValue.flatMap(intToStringOption)
    println("Apply flatMap to negative Some value: ${flatMapped2}")
    
    // Create a None value
    var noneValue: Option<Int64> = None
    
    // Apply flatMap to None value
    var flatMapped3 = noneValue.flatMap(intToStringOption)
    println("Apply flatMap to None value: ${flatMapped3}")
}
```

Execution Result:

```text
Apply flatMap to Some value: Some(Positive: 5)
Apply flatMap to negative Some value: None
Apply flatMap to None value: None
```

### func getOrDefault(() -> T)

```cangjie
public func getOrDefault(other: () -> T): T
```

Function: Gets the value or returns a default value. If the [Option](core_package_enums.md#enum-optiont) value is [Some](#somet), returns the instance of type `T`; if the [Option](core_package_enums.md#enum-optiont) value is [None](#none), calls the input parameter and returns the value of type `T`.

Parameters:

- other: () -> T - The default function. If the current instance value is [None](#none), calls this function to get an instance of type `T` and returns it.

Return Value:

- T - If the current instance value is [Some](#somet)\<T>, returns the instance of type `T` carried by the current instance. If the [Option](core_package_enums.md#enum-optiont) value is [None](#none), calls the specified function to get an instance of type `T` and returns it.

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

- exception: () ->[Exception](core_package_exceptions.md#class-exception) - The exception function. If the current instance value is [None](#none), executes this function and throws the returned exception.

Return Value:

- T - If the current instance value is [Some](#somet)\<T>, returns the instance of type `T`.

Exceptions:

- [Exception](core_package_exceptions.md#class-exception) - If the current instance is [None](#none), throws the exception returned by the exception function.

Example:

<!-- verify -->
```cangjie
main() {
    // Create a Some value
    var someValue: Option<Int64> = Some(42)
    
    // Apply getOrThrow to Some value, should return the value
    var value1 = someValue.getOrThrow({=> Exception("Value is None")})
    println("Value obtained from Some: ${value1}")
    
    // Create a None value
    var noneValue: Option<Int64> = None
    
    // Apply getOrThrow to None value, should throw exception
    try {
        noneValue.getOrThrow({=> Exception("Value is None")})
        println("This line won't execute")
    } catch (e: Exception) {
        println("Caught exception: ${e.message}")
    }
}
```

Execution Result:

```text
Value obtained from Some: 42
Caught exception: Value is None
```

### func getOrThrow()

```cangjie
public func getOrThrow(): T
```

Function: Gets the value or throws an exception.

Return Value:

- T - If the current instance value is [Some](#somet)\<T>, returns the instance of type `T`.

Exceptions:

- [NoneValueException](core_package_exceptions.md#class-nonevalueexception) - If the current instance is [None](#none), throws an exception.

Example:

<!-- verify -->
```cangjie
main() {
    // Create a Some value
    var someValue: Option<Int64> = Some(42)
    
    // Apply getOrThrow to Some value, should return the value
    var value1 = someValue.getOrThrow()
    println("Value obtained from Some: ${value1}")
    
    // Create a None value
    var noneValue: Option<Int64> = None
    
    // Apply getOrThrow to None value, should throw NoneValueException
    try {
        noneValue.getOrThrow()
        println("This line won't execute")
    } catch (e: NoneValueException) {
        println("Caught NoneValueException")
    }
}
```

Execution Result:

```text
Value obtained from Some: 42
Caught NoneValueException
```

### func isNone()

```cangjie
public func isNone(): Bool
```

Function: Determines whether the current instance value is [None](#none).

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if the current instance value is [None](#none), otherwise returns false.

Example:

<!-- verify -->
```cangjie
main() {
    // Create a Some value
    var someValue: Option<Int64> = Some(42)
    
    // Check if it is None
    println("Some(42) is None: ${someValue.isNone()}")
    
    // Create a None value
    var noneValue: Option<Int64> = None
    
    // Check if it is None
    println("None is None: ${noneValue.isNone()}")
}
```

Execution Result:

```text
Some(42) is None: false
None is None: true
```

### func isSome()

```cangjie
public func isSome(): Bool
```

Function: Determines whether the current instance value is [Some](#somet).

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if the current instance value is [Some](#somet), otherwise returns false.

Example:

<!-- verify -->
```cangjie
main() {
    // Create a Some value
    var someValue: Option<Int64> = Some(42)
    
    // Check if it is Some
    println("Some(42) is Some: ${someValue.isSome()}")
    
    // Create a None value
    var noneValue: Option<Int64> = None
    
    // Check if it is Some
    println("None is Some: ${noneValue.isSome()}")
}
```

Execution Result:

```text
Some(42) is Some: true
None is Some: false
```

### func map\<R>((T)->R)

```cangjie
public func map<R>(transform: (T)-> R): Option<R>
```

Function: Provides a mapping function from [Option](#enum-optiont)\<T> type to [Option](#enum-optiont)\<R> type. If the current instance value is [Some](#somet), executes the transform function and returns the result encapsulated in [Some](#somet); otherwise, returns [None](#none).

Parameters:

- transform: (T)-> R - The mapping function.

Return Value:

- [Option](core_package_enums.md#enum-optiont)\<R> - If the current instance value is [Some](#somet), executes the transform function and returns the result as [Option](#enum-optiont)\<R> type; otherwise, returns [None](#none).

Example:

<!-- verify -->
```cangjie
main() {
    // Create a Some value
    var someValue: Option<Int64> = Some(42)
    
    // Use map to convert Int64 to String
    var mapped1 = someValue.map({x => "Number: ${x}"})
    println("Applying map to Some value: ${mapped1}")
    
    // Create a None value
    var noneValue: Option<Int64> = None
    
    // Apply map to None value
    var mapped2 = noneValue.map({x => "Number: ${x}"})
    println("Applying map to None value: ${mapped2}")
}
```

Execution Result:

```text
Applying map to Some value: Some(Number: 42)
Applying map to None value: None
```

### extend\<T> Option\<T> <: Equatable\<Option\<T>> where T <: Equatable\<T>

```cangjie
extend<T> Option<T> <: Equatable<Option<T>> where T <: Equatable<T>
```

Function: Extends the [Equatable](core_package_interfaces.md#interface-equatablet)\<[Option](core_package_enums.md#enum-optiont)\<T>> interface for the [Option](core_package_enums.md#enum-optiont)\<T> enum to support equality comparison operations.

Parent Type:

- [Equatable](core_package_interfaces.md#interface-equatablet)\<[Option](#enum-optiont)\<T>>

#### operator func !=(Option\<T>)

```cangjie
public operator func !=(that: Option<T>): Bool
```

Function: Determines whether the current instance is not equal to the [Option](core_package_enums.md#enum-optiont)\<T> instance pointed to by the parameter.

Parameters:

- that: [Option](core_package_enums.md#enum-optiont)\<T> - The [Option](core_package_enums.md#enum-optiont)\<T> instance to compare.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if not equal, otherwise returns false.

Example:

<!-- verify -->
```cangjie
main() {
    // Create identical Some values
    var someValue1: Option<Int64> = Some(42)
    var someValue2: Option<Int64> = Some(42)
    
    // Compare two identical Some values
    println("Some(42) != Some(42): ${someValue1 != someValue2}")
    
    // Create different Some values
    var someValue3: Option<Int64> = Some(42)
    var someValue4: Option<Int64> = Some(24)
    
    // Compare two different Some values
    println("Some(42) != Some(24): ${someValue3 != someValue4}")
    
    // Create a Some value and a None value
    var someValue5: Option<Int64> = Some(42)
    var noneValue1: Option<Int64> = None
    
    // Compare Some value with None value
    println("Some(42) != None: ${someValue5 != noneValue1}")
    
    // Create two None values
    var noneValue2: Option<Int64> = None
    var noneValue3: Option<Int64> = None
    
    // Compare two None values
    println("None != None: ${noneValue2 != noneValue3}")
}
```

Execution Result:

```text
Some(42) != Some(42): false
Some(42) != Some(24): true
Some(42) != None: true
None != None: false
```

#### operator func ==(Option\<T>)

```cangjie
public operator func ==(that: Option<T>): Bool
```

Function: Determines whether the current instance is equal to the [Option](core_package_enums.md#enum-optiont)\<T> instance pointed to by the parameter.

If both are None, they are equal; if both are Some(v1) and Some(v2), and v1 equals v2, they are equal.

Parameters:

- that: [Option](core_package_enums.md#enum-optiont)\<T> - The [Option](core_package_enums.md#enum-optiont)\<T> instance to compare.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if equal, otherwise returns false.

Example:

<!-- verify -->
```cangjie
main() {
    // Create identical Some values
    var someValue1: Option<Int64> = Some(42)
    var someValue2: Option<Int64> = Some(42)
    
    // Compare two identical Some values
    println("Some(42) == Some(42): ${someValue1 == someValue2}")
    
    // Create different Some values
    var someValue3: Option<Int64> = Some(42)
    var someValue4: Option<Int64> = Some(24)
    
    // Compare two different Some values
    println("Some(42) == Some(24): ${someValue3 == someValue4}")
    
    // Create a Some value and a None value
    var someValue5: Option<Int64> = Some(42)
    var noneValue1: Option<Int64> = None
    
    // Compare Some value with None value
    println("Some(42) == None: ${someValue5 == noneValue1}")
    
    // Create two None values
    var noneValue2: Option<Int64> = None
    var noneValue3: Option<Int64> = None
    
    // Compare two None values
    println("None == None: ${noneValue2 == noneValue3}")
}
```

Execution Result:

```text
Some(42) == Some(42): true
Some(42) == Some(24): false
Some(42) == None: false
None == None: true
```

### extend\<T> Option\<T> <: Hashable where T <: Hashable

```cangjie
extend<T> Option<T> <: Hashable where T <: Hashable
```

Function: Extends the [Hashable](core_package_interfaces.md#interface-hashable) interface for the [Option](core_package_enums.md#enum-optiont) type.

The hash value of [Some](#somet)\<T> equals the hash value of the contained `T` value. The hash value of [None](#none) equals [Int64](core_package_intrinsics.md#int64)(0).

Parent Type:

- [Hashable](core_package_interfaces.md#interface-hashable)

#### func hashCode()

```cangjie
public func hashCode(): Int64
```

Function: Retrieves the hash value.

Return Value:

- [Int64](core_package_intrinsics.md#int64) - The hash value.

Example:

<!-- verify -->
```cangjie
main() {
    // Create a Some value
    var someValue: Option<Int64> = Some(42)
    
    // Get the hash code of Some value
    var someHashCode = someValue.hashCode()
    println("Hash code of Some(42): ${someHashCode}")
    
    // Create a None value
    var noneValue: Option<Int64> = None
    
    // Get the hash code of None value
    var noneHashCode = noneValue.hashCode()
    println("Hash code of None: ${noneHashCode}")
    
    // Compare hash codes of two identical Some values
    var someValue1: Option<Int64> = Some(42)
    var someValue2: Option<Int64> = Some(42)
    
    println("Hash codes of Some(42) and Some(42) are equal: ${someValue1.hashCode() == someValue2.hashCode()}")
    
    // Compare hash codes of two different Some values
    var someValue3: Option<Int64> = Some(42)
    var someValue4: Option<Int64> = Some(24)
    
    println("Hash codes of Some(42) and Some(24) are equal: ${someValue3.hashCode() == someValue4.hashCode()}")
}
```

Execution Result:

```text
Hash code of Some(42): 42
Hash code of None: 0
Hash codes of Some(42) and Some(42) are equal: true
Hash codes of Some(42) and Some(24) are equal: false
```

### extend\<T> Option\<T> <: ToString where T <: ToString

```cangjie
extend<T> Option<T> <: ToString where T <: ToString
```

Function: Implements the [ToString](core_package_interfaces.md#interface-tostring) interface for the [Option](core_package_enums.md#enum-optiont)\<T> enum to support string conversion operations.

Parent Type:

- [ToString](core_package_interfaces.md#interface-tostring)

#### func toString()

```cangjie
public func toString(): String
```

Function: Converts [Option](core_package_enums.md#enum-optiont) to an output string, with content being "Some(${T.toString()})" or "None".

Return Value:

- [String](core_package_structs.md#struct-string) - The converted string.

Example:

<!-- verify -->
```cangjie
main() {
    // Create a Some value
    var someValue: Option<Int64> = Some(42)
    
    // Convert Some value to string
    var someStr = someValue
    println("Some(42) converted to string: ${someStr}")
    
    // Create a None value
    var noneValue: Option<Int64> = None
    
    // Convert None value to string
    var noneStr = noneValue
    println("None converted to string: ${noneStr}")
    
    // Create a Some value of String type
    var someStringValue: Option<String> = Some("Hello")
    
    // Convert String-type Some value to string
    var someStringStr = someStringValue
    println("Some(\"Hello\") converted to string: ${someStringStr}")
}
```

Execution Result:

```text
Some(42) converted to string: Some(42)
None converted to string: None
Some("Hello") converted to string: Some(Hello)
```

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

Example:

<!-- verify -->
```cangjie
main() {
    // Create a Some(Some(42)) value of Option<Option<Int64>> type
    var nestedSome: Option<Option<Int64>> = Some(Some(42))
    
    // Flatten the nested Option
    var flattened1 = nestedSome.flatten()
    println("Some(Some(42)) flattened: ${flattened1}")
    
    // Create a Some(None) value of Option<Option<Int64>> type
    var someNone: Option<Option<Int64>> = Some(None)
    
    // Flatten the nested Option
    var flattened2 = someNone.flatten()
    println("Some(None) flattened: ${flattened2}")
    
    // Create a None value of Option<Option<Int64>> type
    var noneValue: Option<Option<Int64>> = None
    
    // Flatten the nested Option
    var flattened3 = noneValue.flatten()
    println("None flattened: ${flattened3}")
    
    // Demonstrate chained calls
    var chainedValue: Option<Option<Option<String>>> = Some(Some(Some("Hello")))
    var flattenedChained = chainedValue.flatten().flatten()
    println("Chained flattening of Some(Some(Some(\"Hello\"))): ${flattenedChained}")
}
```

Execution Result:

```text
Some(Some(42)) flattened: Some(42)
Some(None) flattened: None
None flattened: None
Chained flattening of Some(Some(Some("Hello"))): Some(Hello)
```

## enum Ordering

```cangjie
public enum Ordering {
    | LT
    | GT
    | EQ
}
```

Function: [Ordering](core_package_enums.md#enum-ordering) represents the result of a comparison operation, containing three possible cases: less than, greater than, and equal to.

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

Function: Extends the [Ordering](core_package_enums.md#enum-ordering) type with the [Comparable](core_package_interfaces.md#interface-comparablet)\<[Ordering](core_package_enums.md#enum-ordering)> interface, enabling comparison operations.

Parent Types:

- [Comparable](core_package_interfaces.md#interface-comparablet)\<[Ordering](#enum-ordering)>

#### func compare(Ordering)

```cangjie
public func compare(that: Ordering): Ordering
```

Function: Determines the relative ordering between the current [Ordering](core_package_enums.md#enum-ordering) instance and the specified [Ordering](core_package_enums.md#enum-ordering) instance.

The ordering relationship for [Ordering](core_package_enums.md#enum-ordering) enums is: GT > EQ > LT.

Parameters:

- that: [Ordering](core_package_enums.md#enum-ordering) - The [Ordering](core_package_enums.md#enum-ordering) instance to compare with.

Return Value:

- [Ordering](core_package_enums.md#enum-ordering) - Returns GT if greater than, EQ if equal, or LT if less than.

Example:

<!-- verify -->
```cangjie
main() {
    // Create Ordering instances
    var gt: Ordering = GT
    var eq: Ordering = EQ
    var lt: Ordering = LT
    
    // Test comparison between GT and EQ
    var result1 = gt.compare(eq)
    println("GT.compare(EQ): ${result1.toString()}")
    
    // Test comparison between EQ and LT
    var result2 = eq.compare(lt)
    println("EQ.compare(LT): ${result2.toString()}")
    
    // Test comparison between LT and GT
    var result3 = lt.compare(gt)
    println("LT.compare(GT): ${result3.toString()}")
    
    // Test equality case
    var result4 = gt.compare(gt)
    println("GT.compare(GT): ${result4.toString()}")
}
```

Execution Result:

```text
GT.compare(EQ): Ordering.GT
EQ.compare(LT): Ordering.GT
LT.compare(GT): Ordering.LT
GT.compare(GT): Ordering.EQ
```

### extend Ordering <: Hashable

```cangjie
extend Ordering <: Hashable
```

Function: Extends the [Ordering](core_package_enums.md#enum-ordering) type with the [Hashable](core_package_interfaces.md#interface-hashable) interface, enabling hash value computation.

Parent Types:

- [Hashable](core_package_interfaces.md#interface-hashable)

#### func hashCode()

```cangjie
public func hashCode(): Int64
```

Function: Computes the hash value. GT has a hash value of 3, EQ has 2, and LT has 1.

Return Value:

- [Int64](core_package_intrinsics.md#int64) - The computed hash value.

Example:

<!-- verify -->
```cangjie
main() {
    // Create Ordering instances
    var gt: Ordering = GT
    var eq: Ordering = EQ
    var lt: Ordering = LT
    
    // Compute hash values
    var gtHash = gt.hashCode()
    var eqHash = eq.hashCode()
    var ltHash = lt.hashCode()
    
    println("GT hash value: ${gtHash}")
    println("EQ hash value: ${eqHash}")
    println("LT hash value: ${ltHash}")
}
```

Execution Result:

```text
GT hash value: 3
EQ hash value: 2
LT hash value: 1
```

### extend Ordering <: ToString

```cangjie
extend Ordering <: ToString
```

Function: Extends the [Ordering](core_package_enums.md#enum-ordering) type with the [ToString](core_package_interfaces.md#interface-tostring) interface, enabling string conversion.

Parent Types:

- [ToString](core_package_interfaces.md#interface-tostring)

#### func toString()

```cangjie
public func toString(): String
```

Function: Converts the [Ordering](core_package_enums.md#enum-ordering) instance to a printable string.

Conversion results are as follows:

- GT: "[Ordering](core_package_enums.md#enum-ordering).GT".
- LT: "[Ordering](core_package_enums.md#enum-ordering).ET".
- EQ: "[Ordering](core_package_enums.md#enum-ordering).EQ".

Return Value:

- [String](core_package_structs.md#struct-string) - The converted string.

Example:

<!-- verify -->
```cangjie
main() {
    // Create Ordering instances
    var gt: Ordering = GT
    var eq: Ordering = EQ
    var lt: Ordering = LT
    
    // Convert to strings
    var gtStr = gt.toString()
    var eqStr = eq.toString()
    var ltStr = lt.toString()
    
    println("GT as string: ${gtStr}")
    println("EQ as string: ${eqStr}")
    println("LT as string: ${ltStr}")
}
```

Execution Result:

```text
GT as string: Ordering.GT
EQ as string: Ordering.EQ
LT as string: Ordering.LT
```

## enum ThreadState

```cangjie
public enum ThreadState <: ToString {
    | Ready
    | Running
    | Pending
    | Terminated 
    | ...
}
```

Function: Represents the state of a thread.

Parent Types:

- [ToString](core_package_interfaces.md#interface-tostring)

### Ready

```cangjie
Ready
```

Function: Indicates that the thread has just been created or has ended suspension and is waiting to be scheduled for execution.

### Running

```cangjie
Running
```

Function: Indicates that the thread is currently executing.

### Pending

```cangjie
Pending
```

Function: Indicates that the thread is suspended.

### Terminated

```cangjie
Terminated
```

Function: Indicates that the thread has finished execution.

### func toString()

```cangjie
public func toString(): String
```

Function: Converts the [ThreadState](core_package_enums.md#enum-threadstate) instance to a printable string.

Conversion results are as follows:

- Ready: "Ready".
- Running: "Running".
- Pending: "Pending".
- Terminated: "Terminated".

Return Value:

- [String](core_package_structs.md#struct-string) - The converted string.

### func ==(ThreadState)

```cangjie
public operator func ==(rhs: ThreadState): Bool
```

Function: Compares two [ThreadState](core_package_enums.md#enum-threadstate) enum values for equality.

Parameters:

- rhs: [ThreadState](core_package_enums.md#enum-threadstate) - Another [ThreadState](core_package_enums.md#enum-threadstate) enum value to compare with the current object.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if the two [ThreadState](core_package_enums.md#enum-threadstate) enums are identical, otherwise false.

### func !=(ThreadState)

```cangjie
public operator func !=(rhs: ThreadState): Bool
```

Function: Compares two [ThreadState](core_package_enums.md#enum-threadstate) enum values for inequality.

Parameters:

- rhs: [ThreadState](core_package_enums.md#enum-threadstate) - Another [ThreadState](core_package_enums.md#enum-threadstate) enum value to compare with the current object.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if the two [ThreadState](core_package_enums.md#enum-threadstate) enums are different, otherwise false.