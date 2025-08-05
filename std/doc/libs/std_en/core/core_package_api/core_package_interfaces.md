# Interfaces

## interface Any

```cangjie
public interface Any
```

Description: [Any](core_package_interfaces.md#interface-any) is the parent type of all types. All `interface` types implicitly inherit it, and all non-`interface` types implicitly implement it.

### extend Byte

```cangjie
extend Byte
```

Description: Provides a series of extension methods for the [Byte](core_package_types.md#type-byte) type, primarily for character judgment and conversion operations within the ASCII character set range.

#### func isAscii()

```cangjie
public func isAscii(): Bool
```

Description: Determines whether the [Byte](core_package_types.md#type-byte) is within the ASCII range.

Return value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if the [Byte](core_package_types.md#type-byte) is within the ASCII range, otherwise returns false.

#### func isAsciiControl()

```cangjie
public func isAsciiControl(): Bool
```

Description: Determines whether the [Byte](core_package_types.md#type-byte) is within the ASCII control character range. The valid range is the union of [00, 1F] and {7F}.

Return value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if the [Byte](core_package_types.md#type-byte) is within the ASCII control character range, otherwise returns false.

#### func isAsciiGraphic()

```cangjie
public func isAsciiGraphic(): Bool
```

Description: Determines whether the [Byte](core_package_types.md#type-byte) is within the ASCII graphic character range. The valid range is [21, 7E].

Return value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if the [Byte](core_package_types.md#type-byte) is within the ASCII graphic character range, otherwise returns false.

#### func isAsciiHex()

```cangjie
public func isAsciiHex(): Bool
```

Description: Determines whether the [Byte](core_package_types.md#type-byte) is within the ASCII hexadecimal digit range.

Return value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if the [Byte](core_package_types.md#type-byte) is within the ASCII hexadecimal digit range, otherwise returns false.

#### func isAsciiLetter()

```cangjie
public func isAsciiLetter(): Bool
```

Description: Determines whether the [Byte](core_package_types.md#type-byte) is within the ASCII Latin letter range.

Return value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if the [Byte](core_package_types.md#type-byte) is within the ASCII Latin letter range, otherwise returns false.

#### func isAsciiLowerCase()

```cangjie
public func isAsciiLowerCase(): Bool
```

Description: Determines whether the [Byte](core_package_types.md#type-byte) is within the ASCII lowercase Latin letter range.

Return value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if the [Byte](core_package_types.md#type-byte) is within the ASCII lowercase Latin letter range, otherwise returns false.

#### func isAsciiNumber()

```cangjie
public func isAsciiNumber(): Bool
```

Description: Determines whether the [Byte](core_package_types.md#type-byte) is within the ASCII decimal digit range.

Return value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if the [Byte](core_package_types.md#type-byte) is within the ASCII decimal digit range, otherwise returns false.

#### func isAsciiNumberOrLetter()

```cangjie
public func isAsciiNumberOrLetter(): Bool
```

Description: Determines whether the [Byte](core_package_types.md#type-byte) is within the ASCII decimal digit and Latin letter range.

Return value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if the [Byte](core_package_types.md#type-byte) is within the ASCII decimal digit and Latin letter range, otherwise returns false.

#### func isAsciiOct()

```cangjie
public func isAsciiOct(): Bool
```

Description: Determines whether the [Byte](core_package_types.md#type-byte) is within the ASCII octal digit range.

Return value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if the [Byte](core_package_types.md#type-byte) is within the ASCII octal digit range, otherwise returns false.

#### func isAsciiPunctuation()

```cangjie
public func isAsciiPunctuation(): Bool
```

Description: Determines whether the [Byte](core_package_types.md#type-byte) is within the ASCII punctuation character range. The valid range is the union of [21, 2F], [3A, 40], [5B, 60], and [7B, 7E].

Return value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if the [Byte](core_package_types.md#type-byte) is within the ASCII punctuation character range, otherwise returns false.

#### func isAsciiUpperCase()

```cangjie
public func isAsciiUpperCase(): Bool
```

Description: Determines whether the [Byte](core_package_types.md#type-byte) is within the ASCII uppercase Latin letter range.

Return value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if the [Byte](core_package_types.md#type-byte) is within the ASCII uppercase Latin letter range, otherwise returns false.

#### func isAsciiWhiteSpace()

```cangjie
public func isAsciiWhiteSpace(): Bool
```

Description: Determines whether the [Byte](core_package_types.md#type-byte) is within the ASCII whitespace character range. The valid range is the union of [09, 0D] and {20}.

Return value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if the [Byte](core_package_types.md#type-byte) is within the ASCII whitespace character range, otherwise returns false.

#### func toAsciiLowerCase()

```cangjie
public func toAsciiLowerCase(): Byte
```

Description: Converts the [Byte](core_package_types.md#type-byte) to its corresponding ASCII lowercase character [Byte](core_package_types.md#type-byte). If conversion is not possible, the original value is preserved.

Return value:

- [Byte](core_package_types.md#type-byte) - The converted [Byte](core_package_types.md#type-byte), or the original [Byte](core_package_types.md#type-byte) if conversion is not possible.

#### func toAsciiUpperCase()

```cangjie
public func toAsciiUpperCase(): Byte
```

Description: Converts the [Byte](core_package_types.md#type-byte) to its corresponding ASCII uppercase character [Byte](core_package_types.md#type-byte). If conversion is not possible, the original value is preserved.

Return value:

- [Byte](core_package_types.md#type-byte) - The converted [Byte](core_package_types.md#type-byte), or the original [Byte](core_package_types.md#type-byte) if conversion is not possible.

## interface CType

```cangjie
sealed interface CType
```

Description: Represents an interface that supports interoperability with the C language.

The [CType](core_package_interfaces.md#interface-ctype) interface is a built-in empty interface that serves as the concrete implementation of the [CType](core_package_interfaces.md#interface-ctype) constraint. All C-interoperable types implicitly implement this interface, allowing them to be used as subtypes of the [CType](core_package_interfaces.md#interface-ctype) type.

> **Note:**
>
> - The [CType](core_package_interfaces.md#interface-ctype) interface is an interface type in Cangjie and does not itself satisfy the [CType](core_package_interfaces.md#interface-ctype) constraint.
> - The [CType](core_package_interfaces.md#interface-ctype) interface cannot be inherited or extended by users.
> - The [CType](core_package_interfaces.md#interface-ctype) interface does not bypass subtype usage restrictions.

Example:

<!-- run -->
```cangjie
@C
struct Data {}

@C
func foo() {}

main() {
    var c: CType = Data() // ok
    c = 0 // ok
    c = true // ok
    c = CString(CPointer<UInt8>()) // ok
    c = CPointer<Int8>() // ok
    c = foo // ok
}
```

## interface Collection\<T>

```cangjie
public interface Collection<T> <: Iterable<T> {
    prop size: Int64
    func isEmpty(): Bool
    func toArray(): Array<T>
}
```

Description: This interface represents collections. Container types should typically implement this interface.

Parent types:

- [Iterable](#interface-iterablee)\<T>

### prop size

```cangjie
prop size: Int64
```

Description: Gets the size of the current collection, i.e., the number of elements it contains.

Type: [Int64](core_package_intrinsics.md#int64)

### func isEmpty()

```cangjie
func isEmpty(): Bool
```

Description: Determines whether the current collection is empty.

Return value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if the collection is empty, otherwise returns false.

### func toArray()

```cangjie
func toArray(): Array<T>
```

Description: Converts the current collection to an array type.

Return value:

- [Array](core_package_structs.md#struct-arrayt)\<T> - The resulting array after conversion.

## interface Comparable\<T>

```cangjie
public interface Comparable<T> <: Equatable<T> & Less<T> & Greater<T> & LessOrEqual<T> & GreaterOrEqual<T> {
    func compare(that: T): Ordering
    operator func <(rhs: T): Bool
    operator func <=(rhs: T): Bool
    operator func ==(rhs: T): Bool
    operator func >(rhs: T): Bool
    operator func >=(rhs: T): Bool
}
```

Description: This interface represents comparison operations and is a combination of the equality, inequality, less-than, greater-than, less-than-or-equal, and greater-than-or-equal interfaces.

This interface provides default implementations for the operators ==, !=, <, <=, >, and >=. The default implementations determine their return values based on the result of the compare function. For example: if a.compare(b) returns EQ, then a == b returns true; otherwise, it returns false.

Parent types:

- [Equatable](#interface-equatablet)\<T>
- [Less](#interface-lesst)\<T>
- [Greater](#interface-greatert)\<T>
- [LessOrEqual](#interface-lessorequalt)\<T>
- [GreaterOrEqual](#interface-greaterorequalt)\<T>

### func compare(T)

```cangjie
func compare(that: T): Ordering
```

Function: Determines the size relationship between the current instance of type `T` and the parameter instance of type `T`.

Parameters:

- that: T - Another instance to be compared with the current instance.

Return Value:

- [Ordering](core_package_enums.md#enum-ordering) - Returns [Ordering](core_package_enums.md#enum-ordering).GT if greater, [Ordering](core_package_enums.md#enum-ordering).EQ if equal, or [Ordering](core_package_enums.md#enum-ordering).LT if less.

### operator func <(T)

```cangjie
operator func <(rhs: T): Bool
```

Function: Determines whether the current instance of type `T` is less than the parameter instance of type `T`. This function is a default implementation of this interface.

Parameters:

- rhs: T - Another instance to be compared with the current instance.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if less, otherwise false.

### operator func <=(T)

```cangjie
operator func <=(rhs: T): Bool
```

Function: Determines whether the current instance of type `T` is less than or equal to the parameter instance of type `T`. This function is a default implementation of this interface.

Parameters:

- rhs: T - Another instance to be compared with the current instance.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if less than or equal, otherwise false.

### operator func ==(T)

```cangjie
operator func ==(rhs: T): Bool
```

Function: Determines whether two instances are equal. This function is a default implementation of this interface.

Parameters:

- rhs: T - Another instance to be compared.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if equal, otherwise false.

### operator func >(T)

```cangjie
operator func >(rhs: T): Bool
```

Function: Determines whether the current instance of type `T` is greater than the parameter instance of type `T`. This function is a default implementation of this interface.

Parameters:

- rhs: T - Another instance to be compared with the current instance.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if greater, otherwise false.

### operator func >=(T)

```cangjie
operator func >=(rhs: T): Bool
```

Function: Determines whether the current instance of type `T` is greater than or equal to the parameter instance of type `T`. This function is a default implementation of this interface.

Parameters:

- rhs: T - Another instance to be compared with the current instance.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if greater than or equal, otherwise false.

## interface Countable\<T>

```cangjie
public interface Countable<T> {
    func next(right: Int64): T
    func position(): Int64
}
```

Function: This interface represents a countable type.

Each instance of a countable type corresponds to a position ([Int64](core_package_intrinsics.md#int64) value), and other instances of this type can be obtained by counting forward.

### func next(Int64)

```cangjie
func next(right: Int64): T
```

Function: Obtains the instance of type `T` at the position `right` units to the right of the current instance.

Parameters:

- right: [Int64](core_package_intrinsics.md#int64) - The number of units to count to the right.

Return Value:

- T - The instance of type `T` at the position `right` units to the right.

### func position()

```cangjie
func position(): Int64
```

Function: Obtains the position information of the current countable instance, converting the current instance to an [Int64](core_package_intrinsics.md#int64) value.

Return Value:

- [Int64](core_package_intrinsics.md#int64) - The converted [Int64](core_package_intrinsics.md#int64) value.

### extend Float64

```cangjie
extend Float64
```

Function: Extends the [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) type as the left operand and the [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) type as the right operand for multiplication.

#### operator func *(Duration)

```cangjie
public operator func *(r: Duration): Duration
```

Function: Implements multiplication between [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) and [Duration](../../core/core_package_api/core_package_structs.md#struct-duration), i.e., [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) * [Duration](../../core/core_package_api/core_package_structs.md#struct-duration).

Parameters:

- r: [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - An instance of [Duration](../../core/core_package_api/core_package_structs.md#struct-duration).

Return Value:

- [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - The product of the [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) instance and `r`.

Exceptions:

- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - Thrown when the multiplication result exceeds the representable range of [Duration](../../core/core_package_api/core_package_structs.md#struct-duration).

### extend Int64

```cangjie
extend Int64
```

Function: Extends the [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) type as the left operand and the [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) type as the right operand for multiplication.

#### operator func *(Duration)

```cangjie
public operator func *(r: Duration): Duration
```

Function: Implements multiplication between [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) and [Duration](../../core/core_package_api/core_package_structs.md#struct-duration), i.e., [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) * [Duration](../../core/core_package_api/core_package_structs.md#struct-duration).

For example, 2 * [Duration](../../core/core_package_api/core_package_structs.md#struct-duration).second returns a [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) instance representing a 2-second time interval.

Parameters:

- r: [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - The right operand of the multiplication.

Return Value:

- [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - The product of the [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) instance and `r`.

Exceptions:

- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - Thrown when the multiplication result exceeds the representable range of [Duration](../../core/core_package_api/core_package_structs.md#struct-duration).

## interface Equal\<T>

```cangjie
public interface Equal<T> {
    operator func ==(rhs: T): Bool
}
```

Function: This interface supports equality comparison operations.

### operator func ==(T)

```cangjie
operator func ==(rhs: T): Bool
```

Function: Determines whether two instances are equal.

Parameters:

- rhs: T - Another instance to be compared.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if equal, otherwise false.

## interface Equatable\<T>

```cangjie
public interface Equatable<T> <: Equal<T> & NotEqual<T> {
    operator func !=(rhs: T): Bool
}
```

Function: This interface combines the equality and inequality comparison interfaces.

This interface provides a default implementation for the != operator, which determines its return value based on the == operator. For example, if a == b returns true, then a != b returns false, and vice versa.

This interface has been implemented for several Cangjie types, including: [Unit](core_package_intrinsics.md#unit), [Bool](core_package_intrinsics.md#bool), [Rune](core_package_intrinsics.md#rune), [Int64](core_package_intrinsics.md#int64), [Int32](core_package_intrinsics.md#int32), [Int16](core_package_intrinsics.md#int16), [Int8](core_package_intrinsics.md#int8), [UIntNative](core_package_intrinsics.md#uintnative), [UInt64](core_package_intrinsics.md#uint64), [UInt32](core_package_intrinsics.md#uint32), [UInt16](core_package_intrinsics.md#uint16), [UInt8](core_package_intrinsics.md#uint8), [Float64](core_package_intrinsics.md#float64), [Float32](core_package_intrinsics.md#float32), [Float16](core_package_intrinsics.md#float16), [String](core_package_structs.md#struct-string), [Array](core_package_structs.md#struct-arrayt), [Box](core_package_classes.md#class-boxt), [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt), [HashSet](../../collection/collection_package_api/collection_package_class.md#class-hashsett-where-t--hashable--equatablet).

Parent Types:

- [Equal](#interface-equalt)\<T>
- [NotEqual](#interface-notequalt)\<T>

### operator func !=(T)

```cangjie
operator func !=(rhs: T): Bool
```

Function: Determines whether two instances are not equal. This function is a default implementation of this interface.

Parameters:

- rhs: T - Another instance to be compared.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if not equal, otherwise false.

## interface GreaterOrEqual\<T>

```cangjie
public interface GreaterOrEqual<T> {
    operator func >=(rhs: T): Bool
}
```

Function: This interface represents the greater-than-or-equal operation.

### operator func >=(T)

```cangjie
operator func >=(rhs: T): Bool
```

Function: Determines whether the current instance of type `T` is greater than or equal to the parameter instance of type `T`.

Parameters:

- rhs: T - Another instance to be compared with the current instance.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if greater than or equal, otherwise false.

## interface Greater\<T>

```cangjie
public interface Greater<T> {
    operator func >(rhs: T): Bool
}
```

Function: This interface represents the greater-than operation.

### operator func >(T)

```cangjie
operator func >(rhs: T): Bool
```

Function: Determines whether the current instance of type `T` is greater than the parameter instance of type `T`.

Parameters:

- rhs: T - Another instance to be compared with the current instance.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if greater than, otherwise returns false.

## interface Hashable

```cangjie
public interface Hashable {
    func hashCode(): Int64
}
```

Function: This interface is used for calculating hash values.

It has been implemented for some Cangjie types, including: [Bool](core_package_intrinsics.md#bool), [Rune](core_package_intrinsics.md#rune), [IntNative](core_package_intrinsics.md#intnative), [Int64](core_package_intrinsics.md#int64), [Int32](core_package_intrinsics.md#int32), [Int16](core_package_intrinsics.md#int16), [Int8](core_package_intrinsics.md#int8), [UIntNative](core_package_intrinsics.md#uintnative), [UInt64](core_package_intrinsics.md#uint64), [UInt32](core_package_intrinsics.md#uint32), [UInt16](core_package_intrinsics.md#uint16), [UInt8](core_package_intrinsics.md#uint8), [Float64](core_package_intrinsics.md#float64), [Float32](core_package_intrinsics.md#float32), [Float16](core_package_intrinsics.md#float16), [String](core_package_structs.md#struct-string), [Box](core_package_classes.md#class-boxt).

### func hashCode()

```cangjie
func hashCode(): Int64
```

Function: Obtains the hash value of the instance type.

Return Value:

- [Int64](core_package_intrinsics.md#int64) - Returns the hash value of the instance type.

## interface Hasher

```cangjie
public interface Hasher {
    func finish(): Int64
    mut func reset(): Unit
    mut func write(value: Bool): Unit
    mut func write(value: Rune): Unit
    mut func write(value: Int8): Unit
    mut func write(value: Int16): Unit
    mut func write(value: Int32): Unit
    mut func write(value: Int64): Unit
    mut func write(value: UInt8): Unit
    mut func write(value: UInt16): Unit
    mut func write(value: UInt32): Unit
    mut func write(value: UInt64): Unit
    mut func write(value: Float16): Unit
    mut func write(value: Float32): Unit
    mut func write(value: Float64): Unit
    mut func write(value: String): Unit
}
```

Function: This interface is used for handling hash combination operations.

A series of write functions can be used to input instances of different data types and compute their combined hash values.

### func finish()

```cangjie
func finish(): Int64
```

Function: Obtains the result of the hash operation.

Return Value:

- [Int64](core_package_intrinsics.md#int64) - The computed hash value.

### func reset()

```cangjie
mut func reset(): Unit
```

Function: Resets the hash value to 0.

### func write(Bool)

```cangjie
mut func write(value: Bool): Unit
```

Function: Inputs the [Bool](core_package_intrinsics.md#bool) value to be hashed and performs the hash combination operation.

Parameters:

- value: [Bool](core_package_intrinsics.md#bool) - The value to be hashed.

### func write(Float16)

```cangjie
mut func write(value: Float16): Unit
```

Function: Inputs the [Float16](core_package_intrinsics.md#float16) value to be hashed and performs the hash combination operation.

Parameters:

- value: [Float16](core_package_intrinsics.md#float16) - The value to be hashed.

### func write(Float32)

```cangjie
mut func write(value: Float32): Unit
```

Function: Inputs the [Float32](core_package_intrinsics.md#float32) value to be hashed and performs the hash combination operation.

Parameters:

- value: [Float32](core_package_intrinsics.md#float32) - The value to be hashed.

### func write(Float64)

```cangjie
mut func write(value: Float64): Unit
```

Function: Inputs the [Float64](core_package_intrinsics.md#float64) value to be hashed and performs the hash combination operation.

Parameters:

- value: [Float64](core_package_intrinsics.md#float64) - The value to be hashed.

### func write(Int16)

```cangjie
mut func write(value: Int16): Unit
```

Function: Inputs the [Int16](core_package_intrinsics.md#int16) value to be hashed and performs the hash combination operation.

Parameters:

- value: [Int16](core_package_intrinsics.md#int16) - The value to be hashed.

### func write(Int32)

```cangjie
mut func write(value: Int32): Unit
```

Function: Inputs the [Int32](core_package_intrinsics.md#int32) value to be hashed and performs the hash combination operation.

Parameters:

- value: [Int32](core_package_intrinsics.md#int32) - The value to be hashed.

### func write(Int64)

```cangjie
mut func write(value: Int64): Unit
```

Function: Inputs the [Int64](core_package_intrinsics.md#int64) value to be hashed and performs the hash combination operation.

Parameters:

- value: [Int64](core_package_intrinsics.md#int64) - The value to be hashed.

### func write(Int8)

```cangjie
mut func write(value: Int8): Unit
```

Function: Inputs the [Int8](core_package_intrinsics.md#int8) value to be hashed and performs the hash combination operation.

Parameters:

- value: [Int8](core_package_intrinsics.md#int8) - The value to be hashed.

### func write(Rune)

```cangjie
mut func write(value: Rune): Unit
```

Function: Inputs the [Rune](core_package_intrinsics.md#rune) value to be hashed and performs the hash combination operation.

Parameters:

- value: [Rune](core_package_intrinsics.md#rune) - The value to be hashed.

### func write(String)

```cangjie
mut func write(value: String): Unit
```

Function: Inputs the [String](core_package_structs.md#struct-string) value to be hashed and performs the hash combination operation.

Parameters:

- value: [String](core_package_structs.md#struct-string) - The value to be hashed.

### func write(UInt16)

```cangjie
mut func write(value: UInt16): Unit
```

Function: Inputs the [UInt16](core_package_intrinsics.md#uint16) value to be hashed and performs the hash combination operation.

Parameters:

- value: [UInt16](core_package_intrinsics.md#uint16) - The value to be hashed.

### func write(UInt32)

```cangjie
mut func write(value: UInt32): Unit
```

Function: Inputs the [UInt32](core_package_intrinsics.md#uint32) value to be hashed and performs the hash combination operation.

Parameters:

- value: [UInt32](core_package_intrinsics.md#uint32) - The value to be hashed.

### func write(UInt64)

```cangjie
mut func write(value: UInt64): Unit
```

Function: Inputs the [UInt64](core_package_intrinsics.md#uint64) value to be hashed and performs the hash combination operation.

Parameters:

- value: [UInt64](core_package_intrinsics.md#uint64) - The value to be hashed.

### func write(UInt8)

```cangjie
mut func write(value: UInt8): Unit
```

Function: Inputs the [UInt8](core_package_intrinsics.md#uint8) value to be hashed and performs the hash combination operation.

Parameters:

- value: [UInt8](core_package_intrinsics.md#uint8) - The value to be hashed.

## interface Iterable\<E>

```cangjie
public interface Iterable<E> {
    func iterator(): Iterator<E>
}
```

Function: This interface represents iterability. Types implementing this interface (typically container types) can be iterated over in `for-in` statements or obtain corresponding iterator instances to perform iteration by calling the `next` function.

This package has implemented this interface for basic container types such as [Array](core_package_structs.md#struct-arrayt), [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt), [HashMap](../../collection/collection_package_api/collection_package_class.md#class-hashmapk-v). Users can implement this interface for other types to enable iteration functionality.

### func iterator()

```cangjie
func iterator(): Iterator<E>
```

Function: Obtains the iterator.

Return Value:

- [Iterator](core_package_classes.md#class-iteratort)\<E> - The iterator.

## interface LessOrEqual\<T>

```cangjie
public interface LessOrEqual<T> {
    operator func <=(rhs: T): Bool
}
```

Function: This interface represents less-than-or-equal-to comparison.

### operator func <=(T)

```cangjie
operator func <=(rhs: T): Bool
```

Function: Determines whether the current instance of type `T` is less than or equal to another instance of type `T` pointed to by the parameter.

Parameters:

- rhs: T - Another instance to compare with the current instance.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if less than or equal to, otherwise returns false.

## interface Less\<T>

```cangjie
public interface Less<T> {
    operator func <(rhs: T): Bool
}
```

Function: This interface represents the less-than comparison operation.

### operator func <(T)

```cangjie
operator func <(rhs: T): Bool
```

Function: Determines whether the current instance of type `T` is less than the instance of type `T` pointed to by the parameter.

Parameters:

- rhs: T - Another instance to be compared with the current instance.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if less than, otherwise returns false.

## interface NotEqual\<T>

```cangjie
public interface NotEqual<T> {
    operator func !=(rhs: T): Bool
}
```

Function: This interface is used to support inequality comparison operations.

### operator func !=(T)

```cangjie
operator func !=(rhs: T): Bool
```

Function: Determines whether two instances are not equal.

Parameters:

- rhs: T - Another instance to be compared.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if not equal, otherwise returns false.

## interface Resource

```cangjie
public interface Resource {
    func close(): Unit
    func isClosed(): Bool
}
```

Function: This interface is used for resource management, typically for closing and releasing resources such as memory and handles.

Types implementing this interface can achieve automatic resource release in `try-with-resource` syntax contexts.

### func isClosed()

```cangjie
func isClosed(): Bool
```

Function: Determines whether the resource has been closed.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if already closed, otherwise returns false.

#### func close()

```cangjie
func close(): Unit
```

Function: Closes the resource.

## interface ThreadContext

```cangjie
public interface ThreadContext {
    func end(): Unit
    func hasEnded(): Bool
}
```

Function: Cangjie thread context interface.

When users create a `thread`, in addition to the default `spawn` expression parameters, they can also pass instances of different [ThreadContext](core_package_interfaces.md#interface-threadcontext) types to select different thread contexts, thereby controlling concurrent behavior to some extent.

Currently, users are not allowed to implement the [ThreadContext](core_package_interfaces.md#interface-threadcontext) interface themselves. The Cangjie language provides `MainThreadContext` based on usage scenarios. For specific definitions, refer to the terminal framework library.

### func end()

```cangjie
func end(): Unit
```

Function: Ends the method, used to send a termination request to the current context.

### func hasEnded()

```cangjie
func hasEnded(): Bool
```

Function: Checks whether the current context has ended.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if ended, otherwise returns false.

## interface ToString

```cangjie
public interface ToString {
    func toString(): String
}
```

Function: This interface is used to provide a string representation of a specific type.

### func toString()

```cangjie
func toString(): String
```

Function: Obtains the string representation of the instance type.

Return Value:

- [String](core_package_structs.md#struct-string) - Returns the string representation of the instance type.