# std.core

## Functionality Overview

The core package is the foundational package of the standard library, providing the most essential API capabilities for Cangjie language programming.

It includes built-in types (signed integers, unsigned integers, floating-point numbers, etc.), common functions (print, println, eprint, etc.), common interfaces (ToString, Hashable, Equatable, Collection, etc.), frequently used classes and structs (Array, String, Range, etc.), and common exception classes (Error, Exception, and their specialized subclasses).

> **Note:**
>
> The core package does not require explicit importation; it is imported by default.

## API List

### Functions

| Function Name | Description |
| ------------ | ------------ |
| [acquireArrayRawData(Array\<T>) where T <: CType](./core_package_api/core_package_funcs.md#func-acquirearrayrawdatatarrayt-where-t--ctype) | Retrieves the raw pointer instance of the data in Array\<T>, where T must satisfy the CType constraint. |
| [alignOf\<T>() where T <: CType](./core_package_api/core_package_funcs.md#func-alignoft-where-t--ctype) | Gets the memory alignment value of type T. |
| [eprint(String, Bool)](./core_package_api/core_package_funcs.md#func-eprintstring-bool) | Prints the specified string to the standard error text stream. |
| [eprintln(String)](./core_package_api/core_package_funcs.md#func-eprintlnstring) | Prints the specified string to the standard error text stream, appending a newline at the end. |
| [eprint\<T>(T, Bool) where T <: ToString](./core_package_api/core_package_funcs.md#func-eprinttt-bool-where-t--tostring) | Prints the string representation of the specified T-type instance to the standard error text stream. |
| [eprintln\<T>(T) where T <: ToString](./core_package_api/core_package_funcs.md#func-eprintlntt-where-t--tostring) | Prints the string representation of the specified T-type instance to the standard error text stream, appending a newline at the end. |
| [ifNone(Option\<T>, () -> Unit)](./core_package_api/core_package_funcs.md#func-ifnonetoptiont----unit) | Executes the action function if the input is of type Option.None. |
| [ifSome(Option\<T>, (T) -> Unit)](./core_package_api/core_package_funcs.md#func-ifsometoptiont-t---unit) | Executes the action function if the input is of type Option.Some. |
| [max\<T>(T, T, Array\<T>) where T <: Comparable\<T>](./core_package_api/core_package_funcs.md#func-maxtt-t-arrayt-where-t--comparablet) | Retrieves the maximum value from a set of data. |
| [min\<T>(T, T, Array\<T>) where T <: Comparable\<T>](./core_package_api/core_package_funcs.md#func-mintt-t-arrayt-where-t--comparablet) | Retrieves the minimum value from a set of data. |
| [print(Bool, Bool)](./core_package_api/core_package_funcs.md#func-printbool-bool) | Outputs the string representation of Bool-type data to the console. |
| [print(Float16, Bool)](./core_package_api/core_package_funcs.md#func-printfloat16-bool) | Outputs the string representation of Float16-type data to the console. |
| [print(Float32, Bool)](./core_package_api/core_package_funcs.md#func-printfloat32-bool) | Outputs the string representation of Float32-type data to the console. |
| [print(Float64, Bool)](./core_package_api/core_package_funcs.md#func-printfloat64-bool) | Outputs the string representation of Float64-type data to the console. |
| [print(Int16, Bool)](./core_package_api/core_package_funcs.md#func-printint16-bool) | Outputs the string representation of Int16-type data to the console. |
| [print(Int32, Bool)](./core_package_api/core_package_funcs.md#func-printint32-bool) | Outputs the string representation of Int32-type data to the console. |
| [print(Int64, Bool)](./core_package_api/core_package_funcs.md#func-printint64-bool) | Outputs the string representation of Int64-type data to the console. |
| [print(Int8, Bool)](./core_package_api/core_package_funcs.md#func-printint8-bool) | Outputs the string representation of Int8-type data to the console. |
| [print(Rune, Bool)](./core_package_api/core_package_funcs.md#func-printrune-bool) | Outputs the string representation of Rune-type data to the console. |
| [print(String, Bool)](./core_package_api/core_package_funcs.md#func-printstring-bool) | Outputs the specified string to the console. |
| [print(UInt16, Bool)](./core_package_api/core_package_funcs.md#func-printuint16-bool) | Outputs the string representation of UInt16-type data to the console. |
| [print(UInt32, Bool)](./core_package_api/core_package_funcs.md#func-printuint32-bool) | Outputs the string representation of UInt32-type data to the console. |
| [print(UInt64, Bool)](./core_package_api/core_package_funcs.md#func-printuint64-bool) | Outputs the string representation of UInt64-type data to the console. |
| [print(UInt8, Bool)](./core_package_api/core_package_funcs.md#func-printuint8-bool) | Outputs the string representation of UInt8-type data to the console. |
| [print\<T>(T, Bool) where T <: ToString](./core_package_api/core_package_funcs.md#func-printtt-bool-where-t--tostring) | Outputs the string representation of T-type instance to the console. |
| [println()](./core_package_api/core_package_funcs.md#func-println) | Outputs a newline character to the standard output (stdout). |
| [println(Bool)](./core_package_api/core_package_funcs.md#func-printlnbool) | Outputs the string representation of Bool-type data to the console, appending a newline at the end. |
| [println(Float16)](./core_package_api/core_package_funcs.md#func-printlnfloat16) | Outputs the string representation of Float16-type data to the console, appending a newline at the end. |
| [println(Float32)](./core_package_api/core_package_funcs.md#func-printlnfloat32) | Outputs the string representation of Float32-type data to the console, appending a newline at the end. |
| [println(Float64)](./core_package_api/core_package_funcs.md#func-printlnfloat64) | Outputs the string representation of Float64-type data to the console, appending a newline at the end. |
| [println(Int16)](./core_package_api/core_package_funcs.md#func-printlnint16) | Outputs the string representation of Int16-type data to the console, appending a newline at the end. |
| [println(Int32)](./core_package_api/core_package_funcs.md#func-printlnint32) | Outputs the string representation of Int32-type data to the console, appending a newline at the end. |
| [println(Int64)](./core_package_api/core_package_funcs.md#func-printlnint64) | Outputs the string representation of Int64-type data to the console, appending a newline at the end. |
| [println(Int8)](./core_package_api/core_package_funcs.md#func-printlnint8) | Outputs the string representation of Int8-type data to the console, appending a newline at the end. |
| [println(Rune)](./core_package_api/core_package_funcs.md#func-printlnrune) | Outputs the string representation of Rune-type data to the console, appending a newline at the end. |
| [println(String)](./core_package_api/core_package_funcs.md#func-printlnstring) | Outputs the specified string to the console, appending a newline at the end. |
| [println(UInt16)](./core_package_api/core_package_funcs.md#func-printlnuint16) | Outputs the string representation of UInt16-type data to the console, appending a newline at the end. |
| [println(UInt32)](./core_package_api/core_package_funcs.md#func-printlnuint32) | Outputs the string representation of UInt32-type data to the console, appending a newline at the end. |
| [println(UInt64)](./core_package_api/core_package_funcs.md#func-printlnuint64) | Outputs the string representation of UInt64-type data to the console, appending a newline at the end. |
| [println(UInt8)](./core_package_api/core_package_funcs.md#func-printlnuint8) | Outputs the string representation of UInt8-type data to the console, appending a newline at the end. |
| [println\<T>(T) where T <: ToString](./core_package_api/core_package_funcs.md#func-printlntt-where-t--tostring) | Outputs the string representation of `T`-type instance to the console, appending a newline at the end. |
| [readln()](./core_package_api/core_package_funcs.md#func-readln) | Accepts console input until encountering a newline or EOF. |
| [refEq(Object, Object)](./core_package_api/core_package_funcs.md#func-refeqobject-object) | Determines whether two Object instances share the same memory address. |
| [releaseArrayRawData(CPointerHandle\<T>) where T <: CType](./core_package_api/core_package_funcs.md#func-releasearrayrawdatatcpointerhandlet-where-t--ctype) | Releases the raw pointer instance obtained via acquireArrayRawData. |
| [sizeOf\<T>() where T <: CType](./core_package_api/core_package_funcs.md#func-sizeoft-where-t--ctype) | Retrieves the memory space occupied by type T. |
| [sleep(Duration)](./core_package_api/core_package_funcs.md#func-sleepduration) | Suspends the current thread. |
| [zeroValue\<T>()](./core_package_api/core_package_funcs.md#func-zerovaluet) | Retrieves a zero-initialized instance of type T. |

### Type Aliases

| Type Alias | Description |
| ------------ | ------------ |
| [Byte](./core_package_api/core_package_types.md#type-byte) | The `Byte` type is an alias for the built-in type `UInt8`. |
| [Int](./core_package_api/core_package_types.md#type-int) | The `Int` type is an alias for the built-in type `Int64`. |
| [UInt](./core_package_api/core_package_types.md#type-uint) | The `UInt` type is an alias for the built-in type `UInt64`. |

### Built-in Types

| Built-in Type Name | Description |
| ------------ | ------------ |
| [Int8](./core_package_api/core_package_intrinsics.md#int8) | Represents an 8-bit signed integer with a range of [-2^7, 2^7 - 1]. |
| [Int16](./core_package_api/core_package_intrinsics.md#int16) | Represents a 16-bit signed integer with a range of [-2^{15}, 2^{15} - 1]. |
| [Int32](./core_package_api/core_package_intrinsics.md#int32) | Represents a 32-bit signed integer with a range of [-2^{31}, 2^{31} - 1]. |
| [Int64](./core_package_api/core_package_intrinsics.md#int64) | Represents a 64-bit signed integer with a range of [-2^{63}, 2^{63} - 1]. |
| [IntNative](./core_package_api/core_package_intrinsics.md#intnative) | Represents a platform-dependent signed integer whose length matches the system's bit width. |
| [UInt8](./core_package_api/core_package_intrinsics.md#uint8) | Represents an 8-bit unsigned integer with a range of [0 ~ 2^8 - 1]. |
| [UInt16](./core_package_api/core_package_intrinsics.md#uint16) | Represents a 16-bit unsigned integer with a range of [0 ~ 2^{16} - 1]. |
| [UInt32](./core_package_api/core_package_intrinsics.md#uint32) | Represents a 32-bit unsigned integer with a range of [0 ~ 2^{32} - 1]. |
| [UInt64](./core_package_api/core_package_intrinsics.md#uint64) | Represents a 64-bit unsigned integer with a range of [0 ~ 2^{64} - 1]. |
| [UIntNative](./core_package_api/core_package_intrinsics.md#uintnative) | Represents a platform-dependent unsigned integer whose length matches the system's bit width. |
| [Float16](./core_package_api/core_package_intrinsics.md#float16) | Represents a 16-bit floating-point number conforming to the `IEEE 754` half-precision format (`binary16`). |
| [Float32](./core_package_api/core_package_intrinsics.md#float32) | Represents a 32-bit floating-point number conforming to the `IEEE 754` single-precision format (`binary32`). |
| [Float64](./core_package_api/core_package_intrinsics.md#float64) | Represents a 64-bit floating-point number conforming to the `IEEE 754` double-precision format (`binary64`). |
| [Bool](./core_package_api/core_package_intrinsics.md#bool) | Represents a boolean type with two possible values: `true` and `false`. |
| [Rune](./core_package_api/core_package_intrinsics.md#rune) | Represents a character in the Unicode character set. |
| [Unit](./core_package_api/core_package_intrinsics.md#unit) | Represents the type of expressions in Cangjie that care only about side effects, not values. |
| [CPointer\<T>](./core_package_api/core_package_intrinsics.md#cpointert) | Represents a pointer to a `T`-type instance, used in scenarios involving C language interoperability, corresponding to `T*` in C. |
| [CString](./core_package_api/core_package_intrinsics.md#cstring) | Represents a C-style string, used in scenarios involving C language interoperability. |

### Interfaces

| Interface Name | Description |
| ------------ | ------------ |
| [Any](./core_package_api/core_package_interfaces.md#interface-any) | `Any` is the parent type of all types. All `interface`s implicitly inherit it, and all non-`interface` types implicitly implement it. |
| [Hasher](./core_package_api/core_package_interfaces.md#interface-hasher) | This interface handles hash combination operations. |
| [ThreadContext](./core_package_api/core_package_interfaces.md#interface-threadcontext) | The Cangjie thread context interface. |
| [Countable\<T>](./core_package_api/core_package_interfaces.md#interface-countablet) | This interface indicates that a type is countable. |
| [Collection\<T>](./core_package_api/core_package_interfaces.md#interface-collectiont) | This interface represents a collection; typically, container types should implement it. |
| [Less\<T>](./core_package_api/core_package_interfaces.md#interface-lesst) | This interface represents a less-than comparison. |
| [Greater\<T>](./core_package_api/core_package_interfaces.md#interface-greatert) | This interface represents a greater-than comparison. |
| [LessOrEqual\<T>](./core_package_api/core_package_interfaces.md#interface-lessorequalt) | This interface represents a less-than-or-equal comparison. |
| [GreaterOrEqual\<T>](./core_package_api/core_package_interfaces.md#interface-greaterorequalt) | This interface represents a greater-than-or-equal comparison. |
| [Comparable\<T>](./core_package_api/core_package_interfaces.md#interface-comparablet) | This interface represents comparison operations, combining equal-to, less-than, greater-than, less-than-or-equal, and greater-than-or-equal interfaces. |
| [Equal\<T>](./core_package_api/core_package_interfaces.md#interface-equalt) | This interface supports equality checks. |
| [NotEqual\<T>](./core_package_api/core_package_interfaces.md#interface-notequalt) | This interface supports inequality checks. |
| [Equatable\<T>](./core_package_api/core_package_interfaces.md#interface-equatablet) | This interface combines equality and inequality check interfaces. |
| [Hashable](./core_package_api/core_package_interfaces.md#interface-hashable) | This interface computes hash values. |
| [Iterable\<E>](./core_package_api/core_package_interfaces.md#interface-iterablee) | This interface indicates iterability. Types implementing this interface (typically container types) can be iterated over in `for-in` statements or by obtaining their corresponding iterator type instance and calling the `next` function. |
| [Resource](./core_package_api/core_package_interfaces.md#interface-resource) | This interface manages resources, typically used for closing and releasing memory, handles, etc. |
| [ToString](./core_package_api/core_package_interfaces.md#interface-tostring) | This interface provides a string representation of a specific type. |
| [CType](./core_package_api/core_package_interfaces.md#interface