# std.core  

## Functionality  

The `core` package is the foundational package of the standard library, providing the most basic API capabilities for programming in the Cangjie language.  

It includes built-in types (signed integers, unsigned integers, floating-point numbers, etc.), common functions (`print`, `println`, `eprint`, etc.), common interfaces (`ToString`, `Hashable`, `Equatable`, `Collection`, etc.), common classes and structs (`Array`, `String`, `Range`, etc.), and common exception classes (`Error`, `Exception`, and their specialized subclasses).  

> **Note:**  
>
> The `core` package does not require explicit importing—it is imported by default.  

## API List  

### Functions  

| Function Name | Description |  
| ------------ | ------------ |  
| [acquireArrayRawData(Array\<T>) where T <: CType](./core_package_api/core_package_funcs.md#func-acquirearrayrawdatatarrayt-where-t--ctype) | Retrieves the raw pointer instance of the data in `Array<T>`, where `T` must satisfy the `CType` constraint. |  
| [alignOf\<T>() where T <: CType](./core_package_api/core_package_funcs.md#func-alignoft-where-t--ctype) | Gets the memory alignment value of type `T`. |  
| [eprint(String, Bool)](./core_package_api/core_package_funcs.md#func-eprintstring-bool) | Prints the specified string to the standard error stream. |  
| [eprintln(String)](./core_package_api/core_package_funcs.md#func-eprintlnstring) | Prints the specified string to the standard error stream, appending a newline at the end. |  
| [eprint\<T>(T, Bool) where T <: ToString](./core_package_api/core_package_funcs.md#func-eprinttt-bool-where-t--tostring) | Prints the string representation of the specified `T` type instance to the standard error stream. |  
| [eprintln\<T>(T) where T <: ToString](./core_package_api/core_package_funcs.md#func-eprintlntt-where-t--tostring) | Prints the string representation of the specified `T` type instance to the standard error stream, appending a newline at the end. |  
| [ifNone(Option\<T>, () -> Unit)](./core_package_api/core_package_funcs.md#func-ifnonetoptiont----unit) | Executes the `action` function if the input is of type `Option.None`. |  
| [ifSome(Option\<T>, (T) -> Unit)](./core_package_api/core_package_funcs.md#func-ifsometoptiont-t---unit) | Executes the `action` function if the input is of type `Option.Some`. |  
| [max\<T>(T, T, Array\<T>) where T <: Comparable\<T>](./core_package_api/core_package_funcs.md#func-maxtt-t-arrayt-where-t--comparablet) | Retrieves the maximum value from a set of data. |  
| [min\<T>(T, T, Array\<T>) where T <: Comparable\<T>](./core_package_api/core_package_funcs.md#func-mintt-t-arrayt-where-t--comparablet) | Retrieves the minimum value from a set of data. |  
| [print(Bool, Bool)](./core_package_api/core_package_funcs.md#func-printbool-bool) | Outputs the string representation of a `Bool` type value to the console. |  
| [print(Float16, Bool)](./core_package_api/core_package_funcs.md#func-printfloat16-bool) | Outputs the string representation of a `Float16` type value to the console. |  
| [print(Float32, Bool)](./core_package_api/core_package_funcs.md#func-printfloat32-bool) | Outputs the string representation of a `Float32` type value to the console. |  
| [print(Float64, Bool)](./core_package_api/core_package_funcs.md#func-printfloat64-bool) | Outputs the string representation of a `Float64` type value to the console. |  
| [print(Int16, Bool)](./core_package_api/core_package_funcs.md#func-printint16-bool) | Outputs the string representation of an `Int16` type value to the console. |  
| [print(Int32, Bool)](./core_package_api/core_package_funcs.md#func-printint32-bool) | Outputs the string representation of an `Int32` type value to the console. |  
| [print(Int64, Bool)](./core_package_api/core_package_funcs.md#func-printint64-bool) | Outputs the string representation of an `Int64` type value to the console. |  
| [print(Int8, Bool)](./core_package_api/core_package_funcs.md#func-printint8-bool) | Outputs the string representation of an `Int8` type value to the console. |  
| [print(Rune, Bool)](./core_package_api/core_package_funcs.md#func-printrune-bool) | Outputs the string representation of a `Rune` type value to the console. |  
| [print(String, Bool)](./core_package_api/core_package_funcs.md#func-printstring-bool) | Outputs the specified string to the console. |  
| [print(UInt16, Bool)](./core_package_api/core_package_funcs.md#func-printuint16-bool) | Outputs the string representation of a `UInt16` type value to the console. |  
| [print(UInt32, Bool)](./core_package_api/core_package_funcs.md#func-printuint32-bool) | Outputs the string representation of a `UInt32` type value to the console. |  
| [print(UInt64, Bool)](./core_package_api/core_package_funcs.md#func-printuint64-bool) | Outputs the string representation of a `UInt64` type value to the console. |  
| [print(UInt8, Bool)](./core_package_api/core_package_funcs.md#func-printuint8-bool) | Outputs the string representation of a `UInt8` type value to the console. |  
| [print\<T>(T, Bool) where T <: ToString](./core_package_api/core_package_funcs.md#func-printtt-bool-where-t--tostring) | Outputs the string representation of a `T` type instance to the console. |  
| [println()](./core_package_api/core_package_funcs.md#func-println) | Outputs a newline character to the standard output (stdout). |  
| [println(Bool)](./core_package_api/core_package_funcs.md#func-printlnbool) | Outputs the string representation of a `Bool` type value to the console, appending a newline at the end. |  
| [println(Float16)](./core_package_api/core_package_funcs.md#func-printlnfloat16) | Outputs the string representation of a `Float16` type value to the console, appending a newline at the end. |  
| [println(Float32)](./core_package_api/core_package_funcs.md#func-printlnfloat32) | Outputs the string representation of a `Float32` type value to the console, appending a newline at the end. |  
| [println(Float64)](./core_package_api/core_package_funcs.md#func-printlnfloat64) | Outputs the string representation of a `Float64` type value to the console, appending a newline at the end. |  
| [println(Int16)](./core_package_api/core_package_funcs.md#func-printlnint16) | Outputs the string representation of an `Int16` type value to the console, appending a newline at the end. |  
| [println(Int32)](./core_package_api/core_package_funcs.md#func-printlnint32) | Outputs the string representation of an `Int32` type value to the console, appending a newline at the end. |  
| [println(Int64)](./core_package_api/core_package_funcs.md#func-printlnint64) | Outputs the string representation of an `Int64` type value to the console, appending a newline at the end. |  
| [println(Int8)](./core_package_api/core_package_funcs.md#func-printlnint8) | Outputs the string representation of an `Int8` type value to the console, appending a newline at the end. |  
| [println(Rune)](./core_package_api/core_package_funcs.md#func-printlnrune) | Outputs the string representation of a `Rune` type value to the console, appending a newline at the end. |  
| [println(String)](./core_package_api/core_package_funcs.md#func-printlnstring) | Outputs the specified string to the console, appending a newline at the end. |  
| [println(UInt16)](./core_package_api/core_package_funcs.md#func-printlnuint16) | Outputs the string representation of a `UInt16` type value to the console, appending a newline at the end. |  
| [println(UInt32)](./core_package_api/core_package_funcs.md#func-printlnuint32) | Outputs the string representation of a `UInt32` type value to the console, appending a newline at the end. |  
| [println(UInt64)](./core_package_api/core_package_funcs.md#func-printlnuint64) | Outputs the string representation of a `UInt64` type value to the console, appending a newline at the end. |  
| [println(UInt8)](./core_package_api/core_package_funcs.md#func-printlnuint8) | Outputs the string representation of a `UInt8` type value to the console, appending a newline at the end. |  
| [println\<T>(T) where T <: ToString](./core_package_api/core_package_funcs.md#func-printlntt-where-t--tostring) | Outputs the string representation of a `T` type instance to the console, appending a newline at the end. |  
| [readln()](./core_package_api/core_package_funcs.md#func-readln) | Accepts console input until encountering a newline or EOF. |  
| [refEq(Object, Object)](./core_package_api/core_package_funcs.md#func-refeqobject-object) | Determines whether two `Object` instances share the same memory address. |  
| [releaseArrayRawData(CPointerHandle\<T>) where T <: CType](./core_package_api/core_package_funcs.md#func-releasearrayrawdatatcpointerhandlet-where-t--ctype) | Releases the raw pointer instance obtained via `acquireArrayRawData`. |  
| [sizeOf\<T>() where T <: CType](./core_package_api/core_package_funcs.md#func-sizeoft-where-t--ctype) | Gets the memory size occupied by type `T`. |  
| [sleep(Duration)](./core_package_api/core_package_funcs.md#func-sleepduration) | Suspends the current thread. |  
| [zeroValue\<T>()](./core_package_api/core_package_funcs.md#func-zerovaluet) | Retrieves a zero-initialized instance of type `T`. |

### Type Aliases

| Type Alias | Function |
| ------------ | ------------ |
| [Byte](./core_package_api/core_package_types.md#type-byte) | The `Byte` type is an alias for the built-in type `UInt8`. |
| [Int](./core_package_api/core_package_types.md#type-int) | The `Int` type is an alias for the built-in type `Int64`. |
| [UInt](./core_package_api/core_package_types.md#type-uint) | The `UInt` type is an alias for the built-in type `UInt64`. |

### Built-in Types

| Built-in Type Name | Function |
| ------------ | ------------ |
| [Int8](./core_package_api/core_package_intrinsics.md#int8) | Represents an 8-bit signed integer with a range of [-2^7, 2^7 - 1]. |
| [Int16](./core_package_api/core_package_intrinsics.md#int16) | Represents a 16-bit signed integer with a range of [-2^{15}, 2^{15} - 1]. |
| [Int32](./core_package_api/core_package_intrinsics.md#int32) | Represents a 32-bit signed integer with a range of [-2^{31}, 2^{31} - 1]. |
| [Int64](./core_package_api/core_package_intrinsics.md#int64) | Represents a 64-bit signed integer with a range of [-2^{63}, 2^{63} - 1]. |
| [IntNative](./core_package_api/core_package_intrinsics.md#intnative) | Represents a platform-dependent signed integer with a length matching the current system's bit width. |
| [UInt8](./core_package_api/core_package_intrinsics.md#uint8) | Represents an 8-bit unsigned integer with a range of [0 ~ 2^8 - 1]. |
| [UInt16](./core_package_api/core_package_intrinsics.md#uint16) | Represents a 16-bit unsigned integer with a range of [0 ~ 2^{16} - 1]. |
| [UInt32](./core_package_api/core_package_intrinsics.md#uint32) | Represents a 32-bit unsigned integer with a range of [0 ~ 2^{32} - 1]. |
| [UInt64](./core_package_api/core_package_intrinsics.md#uint64) | Represents a 64-bit unsigned integer with a range of [0 ~ 2^{64} - 1]. |
| [UIntNative](./core_package_api/core_package_intrinsics.md#uintnative) | Represents a platform-dependent unsigned integer with a length matching the current system's bit width. |
| [Float16](./core_package_api/core_package_intrinsics.md#float16) | Represents a 16-bit floating-point number conforming to the `IEEE 754` half-precision format (`binary16`). |
| [Float32](./core_package_api/core_package_intrinsics.md#float32) | Represents a 32-bit floating-point number conforming to the `IEEE 754` single-precision format (`binary32`). |
| [Float64](./core_package_api/core_package_intrinsics.md#float64) | Represents a 64-bit floating-point number conforming to the `IEEE 754` double-precision format (`binary64`). |
| [Bool](./core_package_api/core_package_intrinsics.md#bool) | Represents a boolean type with two possible values: `true` and `false`. |
| [Rune](./core_package_api/core_package_intrinsics.md#rune) | Represents a character in the Unicode character set. |
| [Unit](./core_package_api/core_package_intrinsics.md#unit) | Represents the type of expressions in the Cangjie language that only care about side effects and not values. |
| [CPointer\<T>](./core_package_api/core_package_intrinsics.md#cpointert) | Represents a pointer to an instance of type `T`, used in scenarios interacting with C, corresponding to `T*` in C. |
| [CString](./core_package_api/core_package_intrinsics.md#cstring) | Represents a C-style string, used in scenarios interacting with C. |

### Interfaces

| Interface Name | Function |
| ------------ | ------------ |
| [Any](./core_package_api/core_package_interfaces.md#interface-any) | `Any` is the parent type of all types. All `interface`s implicitly inherit it, and all non-`interface` types implicitly implement it. |
| [Hasher](./core_package_api/core_package_interfaces.md#interface-hasher) | This interface is used for hash combination operations. |
| [ThreadContext](./core_package_api/core_package_interfaces.md#interface-threadcontext) | Cangjie thread context interface. |
| [Countable\<T>](./core_package_api/core_package_interfaces.md#interface-countablet) | This interface indicates that a type is countable. |
| [Collection\<T>](./core_package_api/core_package_interfaces.md#interface-collectiont) | This interface represents a collection. Typically, container types should implement this interface. |
| [Less\<T>](./core_package_api/core_package_interfaces.md#interface-lesst) | This interface represents a less-than comparison. |
| [Greater\<T>](./core_package_api/core_package_interfaces.md#interface-greatert) | This interface represents a greater-than comparison. |
| [LessOrEqual\<T>](./core_package_api/core_package_interfaces.md#interface-lessorequalt) | This interface represents a less-than-or-equal comparison. |
| [GreaterOrEqual\<T>](./core_package_api/core_package_interfaces.md#interface-greaterorequalt) | This interface represents a greater-than-or-equal comparison. |
| [Comparable\<T>](./core_package_api/core_package_interfaces.md#interface-comparablet) | This interface represents comparison operations, combining the equal, less-than, greater-than, less-than-or-equal, and greater-than-or-equal interfaces. |
| [Equal\<T>](./core_package_api/core_package_interfaces.md#interface-equalt) | This interface supports equality checks. |
| [NotEqual\<T>](./core_package_api/core_package_interfaces.md#interface-notequalt) | This interface supports inequality checks. |
| [Equatable\<T>](./core_package_api/core_package_interfaces.md#interface-equatablet) | This interface combines the equality and inequality check interfaces. |
| [Hashable](./core_package_api/core_package_interfaces.md#interface-hashable) | This interface is used for computing hash values. |
| [Iterable\<E>](./core_package_api/core_package_interfaces.md#interface-iterablee) | This interface indicates iterability. Types implementing this interface (typically container types) can be iterated over in `for-in` statements or by obtaining an instance of their corresponding iterator type and calling the `next` function. |
| [Resource](./core_package_api/core_package_interfaces.md#interface-resource) | This interface is used for resource management, typically for closing and releasing resources such as memory and handles. |
| [ToString](./core_package_api/core_package_interfaces.md#interface-tostring) | This interface provides a string representation of a specific type. |
| [CType](./core_package_api/core_package_interfaces.md#interface-ctype) | Represents an interface supporting interoperability with C. |

### Classes

| Class Name | Functionality |
| ------------ | ------------ |
| [ArrayIterator\<T>](./core_package_api/core_package_classes.md#class-arrayiteratort) | Array iterator. For detailed iteration functionality, refer to the `Iterable` and `Iterator` interface descriptions. |
| [Box\<T>](./core_package_api/core_package_classes.md#class-boxt) | The `Box` type provides the capability to add a `class` wrapper layer to other types. |
| [Future\<T>](./core_package_api/core_package_classes.md#class-futuret) | A `Future\<T>` instance represents a Cangjie thread task, which can be used to retrieve computation results from Cangjie threads or send cancellation signals to them. |
| [Iterator\<T>](./core_package_api/core_package_classes.md#class-iteratort) | This class represents an iterator, providing the `next` method to support iterative traversal of container members. |
| [Object](./core_package_api/core_package_classes.md#class-object) | Constructs an `object` instance. |
| [RangeIterator\<T> <: Iterator\<T> where T <: Countable\<T> & Comparable\<T> & Equatable\<T>](./core_package_api/core_package_classes.md#class-rangeiteratort--iteratort-where-t--countablet--comparablet--equatablet) | Iterator for the `Range` type. For detailed iteration functionality, refer to the `Iterable` and `Iterator` interface descriptions. |
| [StackTraceElement](./core_package_api/core_package_classes.md#class-stacktraceelement) | Represents specific information about an exception stack trace, including the class name, function name, file name, and line number where the exception occurred. |
| [StringBuilder](./core_package_api/core_package_classes.md#class-stringbuilder) | This class is primarily used for string construction. |
| [Thread](./core_package_api/core_package_classes.md#class-thread) | The `Thread` class represents a Cangjie thread, which can be used to retrieve thread IDs and names, check for cancellation requests, register unhandled exception handlers, etc. |
| [ThreadLocal\<T>](./core_package_api/core_package_classes.md#class-threadlocalt) | This class represents Cangjie thread-local variables. |

### Enums

| Enum Name | Functionality |
| ------------ | ------------ |
| [AnnotationKind](./core_package_api/core_package_enums.md#enum-annotationkind) | Indicates the supported positions for custom annotations. |
| [Endian](./core_package_api/core_package_enums.md#enum-endian) | The `Endian` enum type represents the endianness of the runtime platform, divided into big-endian and little-endian. |
| [Ordering](./core_package_api/core_package_enums.md#enum-ordering) | `Ordering` represents the result of a comparison, which includes three cases: less than, greater than, and equal. |
| [Option\<T>](./core_package_api/core_package_enums.md#enum-optiont) | `Option\<T>` is a wrapper for type `T`, indicating that a value may or may not exist. |

### Structs

| Struct Name | Functionality |
| ------------ | ------------ |
| [Array\<T>](./core_package_api/core_package_structs.md#struct-arrayt) | The Cangjie array type, used to represent an ordered sequence of elements of a single type. |
| [CPointerHandle\<T> where T <: CType](./core_package_api/core_package_structs.md#struct-cpointerhandlet-where-t--ctype) | Represents the raw pointer of an `Array`. The generic parameter in this type must satisfy the `CType` constraint. |
| [CPointerResource\<T> where T <: CType](./core_package_api/core_package_structs.md#struct-cpointerresourcet-where-t--ctype) | This struct represents the resource management type corresponding to `CPointer`. Its instances can be obtained via the `asResource` member function of `CPointer`. |
| [CStringResource](./core_package_api/core_package_structs.md#struct-cstringresource) | This struct represents the resource management type corresponding to `CString`. Its instances can be obtained via the `asResource` member function of `CString`. |
| [DefaultHasher](./core_package_api/core_package_structs.md#struct-defaulthasher) | This struct provides the default hash algorithm implementation. |
| [Duration](./core_package_api/core_package_structs.md#struct-duration) | Represents a time interval, describing a period of time. It provides commonly used static instances, as well as calculation and comparison functionalities. |
| [LibC](./core_package_api/core_package_structs.md#struct-libc) | Provides frequently used C interfaces in Cangjie, such as allocating and deallocating `CType` instances on the heap. |
| [Range\<T> where T <: Countable\<T> & Comparable\<T> & Equatable\<T>](./core_package_api/core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet) | This class represents a range type, used to denote a sequence of `T` with a fixed range and step size. `T` must be countable and ordered. |
| [String](./core_package_api/core_package_structs.md#struct-string) | This struct represents Cangjie strings, providing a series of string operations such as construction, searching, and concatenation. |

### Exception Classes

| Exception Class Name | Functionality |
| ------------ | ------------ |
| [ArithmeticException](./core_package_api/core_package_exceptions.md#class-arithmeticexception) | Arithmetic exception class, used when arithmetic exceptions occur. |
| [Error](./core_package_api/core_package_exceptions.md#class-error) | `Error` is the parent class of all error classes. This class cannot be inherited or instantiated but can be caught. |
| [Exception](./core_package_api/core_package_exceptions.md#class-exception) | `Exception` is the parent class of all exception classes. |
| [IllegalArgumentException](./core_package_api/core_package_exceptions.md#class-illegalargumentexception) | Exception class indicating illegal arguments. |
| [IllegalFormatException](./core_package_api/core_package_exceptions.md#class-illegalformatexception) | Exception class indicating invalid or non-standard variable formats. |
| [IllegalMemoryException](./core_package_api/core_package_exceptions.md#class-illegalmemoryexception) | Exception class indicating memory operation errors. |
| [IllegalStateException](./core_package_api/core_package_exceptions.md#class-illegalstateexception) | Exception class indicating illegal states. |
| [IncompatiblePackageException](./core_package_api/core_package_exceptions.md#class-incompatiblepackageexception) | Exception class indicating package incompatibility. |
| [IndexOutOfBoundsException](./core_package_api/core_package_exceptions.md#class-indexoutofboundsexception) | Exception class indicating index out of bounds. |
| [NegativeArraySizeException](./core_package_api/core_package_exceptions.md#class-negativearraysizeexception) | Exception class indicating negative array size. |
| [NoneValueException](./core_package_api/core_package_exceptions.md#class-nonevalueexception) | Exception class indicating that an `Option\<T>` instance has a `None` value, typically thrown in the `getOrThrow` function. |
| [OutOfMemoryError](./core_package_api/core_package_exceptions.md#class-outofmemoryerror) | Error class indicating insufficient memory. This class cannot be inherited or instantiated but can be caught. |
| [OverflowException](./core_package_api/core_package_exceptions.md#class-overflowexception) | Exception class indicating arithmetic overflow. |
| [SpawnException](./core_package_api/core_package_exceptions.md#class-spawnexception) | Thread exception class, indicating exceptions during thread processing. |
| [StackOverflowError](./core_package_api/core_package_exceptions.md#class-stackoverflowerror) | Error class indicating stack overflow. This class cannot be inherited or instantiated but can be caught. |
| [TimeoutException](./core_package_api/core_package_exceptions.md#class-timeoutexception) | Exception thrown when a blocking operation times out. |
| [UnsupportedException](./core_package_api/core_package_exceptions.md#class-unsupportedexception) | Exception class indicating unsupported functionality. |
