# Classes

## class Console <sup>(deprecated)</sup>

```cangjie
public class Console
```

Functionality: This class provides interfaces for obtaining standard input, standard output, and standard error streams.

> **Note:**
>
> Will be deprecated in future versions. Use corresponding functions in the [env](../../env/env_package_overview.md#functions) package instead.

### static prop stdErr

```cangjie
public static prop stdErr: ConsoleWriter
```

Functionality: This member property is of type [ConsoleWriter](console_package_class.md#class-consolewriter-deprecated), providing access to standard error.

Type: [ConsoleWriter](console_package_class.md#class-consolewriter-deprecated)

### static prop stdIn

```cangjie
public static prop stdIn: ConsoleReader
```

Functionality: This member property is of type [ConsoleReader](console_package_class.md#class-consolereader-deprecated), providing access to standard input.

Type: [ConsoleReader](console_package_class.md#class-consolereader-deprecated)

### static prop stdOut

```cangjie
public static prop stdOut: ConsoleWriter
```

Functionality: This member property is of type [ConsoleWriter](console_package_class.md#class-consolewriter-deprecated), providing access to standard output.

Type: [ConsoleWriter](console_package_class.md#class-consolewriter-deprecated)

## class ConsoleReader <sup>(deprecated)</sup>

```cangjie
public class ConsoleReader <: InputStream
```

Functionality: Provides functionality to read data from the console and convert it into characters or strings.

This type cannot be instantiated directly; instances can only be obtained through [Console.stdIn](console_package_class.md#static-prop-stdin).
Read operations are synchronous, with an internal buffer storing console input content. When the end of the console input stream is reached, console read functions will return `None`.

[ConsoleReader](console_package_class.md#class-consolereader-deprecated) has only one instance, with all methods sharing the same buffer. The `read` methods return `None` under the following circumstances:

- When standard input is redirected to a file and EOF is encountered.
- In Linux environments, when `Ctrl+D` is pressed.
- In Windows environments, when `Ctrl+Z` is pressed followed by Enter.

> **Note:**
>
> Will be deprecated in future versions. Use [ConsoleReader](../../env/env_package_api/env_package_classes.md#class-consolereader) instead.

Parent Types:

- [InputStream](../../io/io_package_api/io_package_interfaces.md#interface-inputstream)

### func read()

```cangjie
public func read(): ?Rune
```

Functionality: Reads the next character from standard input.

Return Value:

- ?[Rune](../../core/core_package_api/core_package_intrinsics.md#rune) - Returns ?[Rune](../../core/core_package_api/core_package_intrinsics.md#rune) if a character is read, otherwise returns `None`.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception): Thrown when the input is not a `UTF-8` encoded string.

### func read(Array\<Byte>)

```cangjie
public func read(arr: Array<Byte>): Int64
```

Functionality: Reads from standard input and stores the data in `arr`.

> **Note:**
>
> This function carries a risk: the read result might truncate a `UTF-8 code point`. If truncation occurs, converting this [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)> to a string may yield incorrect results or throw an exception.

Parameters:

- arr: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)> - Target [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt).

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Returns the number of bytes read.

### func readToEnd()

```cangjie
public func readToEnd(): ?String
```

Functionality: Reads all characters from standard input.

Reads until the end-of-file marker `EOF` is encountered, or until `Ctrl+D` is pressed in Linux or `Ctrl+Z` + Enter in Windows. Returns ?[String](../../core/core_package_api/core_package_structs.md#struct-string) if characters are read, otherwise returns `None`. This interface does not throw exceptions. Even if the input is not a `UTF-8` encoded string, it will construct and return a [String](../../core/core_package_api/core_package_structs.md#struct-string), behaving equivalently to [String](../../core/core_package_api/core_package_structs.md#struct-string).[fromUtf8Uncheck](../../core/core_package_api/core_package_structs.md#static-func-fromutf8uncheckedarrayuint8)([Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)>).

Return Value:

- ?[String](../../core/core_package_api/core_package_structs.md#struct-string) - Returns all read data as ?[String](../../core/core_package_api/core_package_structs.md#struct-string).

### func readUntil((Rune) -> Bool)

```cangjie
public func readUntil(predicate: (Rune) -> Bool): ?String
```

Functionality: Reads data from standard input until the read character satisfies the `predicate` condition.

Characters that satisfy the predicate: (Rune) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) condition are included in the result. Returns `None` if reading fails.

Parameters:

- predicate: (Rune) ->[Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Condition to terminate reading.

Return Value:

- ?[String](../../core/core_package_api/core_package_structs.md#struct-string) - Returns the read data as ?[String](../../core/core_package_api/core_package_structs.md#struct-string).

### func readUntil(Rune)

```cangjie
public func readUntil(ch: Rune): ?String
```

Functionality: Reads data from standard input until the character `ch` is encountered.

`ch` is included in the result. If EOF is encountered, returns all read data. Returns `None` if reading fails.

Parameters:

- ch: [Rune](../../core/core_package_api/core_package_intrinsics.md#rune) - Termination character.

Return Value:

- ?[String](../../core/core_package_api/core_package_structs.md#struct-string) - Returns the read data as ?[String](../../core/core_package_api/core_package_structs.md#struct-string).

### func readln()

```cangjie
public func readln(): ?String
```

Functionality: Reads a line of string from standard input.

Returns ?[String](../../core/core_package_api/core_package_structs.md#struct-string) if characters are read, excluding the trailing newline character. This interface does not throw exceptions. Even if the input is not a `UTF-8` encoded string, it will construct and return a [String](../../core/core_package_api/core_package_structs.md#struct-string), behaving equivalently to [String](../../core/core_package_api/core_package_structs.md#struct-string).fromUtf8Uncheck([Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)>).

Return Value:

- ?[String](../../core/core_package_api/core_package_structs.md#struct-string) - The read line data, or `None` if reading fails.

## class ConsoleWriter <sup>(deprecated)</sup>

```cangjie
public class ConsoleWriter <: OutputStream
```

Functionality: This class provides thread-safe standard output functionality.

Each `write` call produces complete output to the console, and results from different `write` function calls will not be mixed.
This type cannot be instantiated directly; instances can only be obtained through [Console.stdOut](console_package_class.md#static-prop-stdout) for standard output or [Console.stdErr](console_package_class.md#static-prop-stderr) for standard error.

> **Note:**
>
> Will be deprecated in future versions. Use [ConsoleWriter](../../env/env_package_api/env_package_classes.md#class-consolewriter) instead.

Parent Types:

- [OutputStream](../../io/io_package_api/io_package_interfaces.md#interface-outputstream)

### func flush()

```cangjie
public func flush(): Unit
```

Functionality: Flushes the output stream.

### func write(Array\<Byte>)

```cangjie
public func write(buffer: Array<Byte>): Unit
```

Functionality: Writes the specified byte array `buffer` to standard output or standard error stream.

Parameters:

- buffer: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)> - The byte array to be written.

### func write(Bool)

```cangjie
public func write(v: Bool): Unit
```

Functionality: Writes the text representation of the specified boolean value to standard output or standard error stream.

Parameters:

- v: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The value to write.

### func write(Float16)

```cangjie
public func write(v: Float16): Unit
```

Functionality: Writes the text representation of the specified 16-bit floating-point value to standard output or standard error stream.

Parameters:

- v: [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) - The value to write.

### func write(Float32)

```cangjie
public func write(v: Float32): Unit
```

Functionality: Writes the text representation of the specified 32-bit floating-point value to standard output or standard error stream.

Parameters:

- v: [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) - The value to write.

### func write(Float64)

```cangjie
public func write(v: Float64): Unit
```

Functionality: Writes the text representation of the specified 64-bit floating-point value to standard output or standard error stream.

Parameters:

- v: [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - The value to write.

### func write(Int16)

```cangjie
public func write(v: Int16): Unit
```

Functionality: Writes the text representation of the specified 16-bit signed integer value to standard output or standard error stream.

Parameters:

- v: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The value to write.

### func write(Int32)

```cangjie
public func write(v: Int32): Unit
```

Functionality: Writes the text representation of the specified 32-bit signed integer value to standard output or standard error stream.

Parameters:

- v: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The value to write.

### func write(Int64)

```cangjie
public func write(v: Int64): Unit
```

Functionality: Writes the text representation of the specified 64-bit signed integer value to standard output or standard error stream.

Parameters:

- v: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The value to write.

### func write(Int8)

```cangjie
public func write(v: Int8): Unit
```

Functionality: Writes the text representation of the specified 8-bit signed integer value to standard output or standard error stream.

Parameters:

- v: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The value to write.Parameters:

- v: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The value to be written.

### func write(Rune)

```cangjie
public func write(v: Rune): Unit
```

Function: Writes the Unicode character value of the specified [Rune](../../../std_en/core/core_package_api/core_package_intrinsics.md#rune) to the standard output or standard error stream.

Parameters:

- v: [Rune](../../../std_en/core/core_package_api/core_package_intrinsics.md#rune) - The value to be written.

### func write(String)

```cangjie
public func write(v: String): Unit
```

Function: Writes the specified string value to the standard output or standard error stream.

Parameters:

- v: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The value to be written.

### func write(UInt16)

```cangjie
public func write(v: UInt16): Unit
```

Function: Writes the textual representation of the specified 16-bit unsigned integer value to the standard output or standard error stream.

Parameters:

- v: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The value to be written.

### func write(UInt32)

```cangjie
public func write(v: UInt32): Unit
```

Function: Writes the textual representation of the specified 32-bit unsigned integer value to the standard output or standard error stream.

Parameters:

- v: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The value to be written.

### func write(UInt64)

```cangjie
public func write(v: UInt64): Unit
```

Function: Writes the textual representation of the specified 64-bit unsigned integer value to the standard output or standard error stream.

Parameters:

- v: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The value to be written.

### func write(UInt8)

```cangjie
public func write(v: UInt8): Unit
```

Function: Writes the textual representation of the specified 8-bit unsigned integer value to the standard output or standard error stream.

Parameters:

- v: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The value to be written.

### func write\<T>(T) where T <: ToString

```cangjie
public func write<T>(v: T): Unit where T <: ToString
```

Function: Writes data types that implement the [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring) interface to the standard output or standard error stream.

Parameters:

- v: T - An instance of [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring) type to be written.

### func writeln(Array\<Byte>)

```cangjie
public func writeln(buffer: Array<Byte>): Unit
```

Function: Writes the specified byte array buffer (followed by a newline character) to the standard output or standard error stream.

Parameters:

- buffer: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)> - The value to be written.

### func writeln(Bool)

```cangjie
public func writeln(v: Bool): Unit
```

Function: Writes the textual representation of the specified boolean value (followed by a newline character) to the standard output or standard error stream.

Parameters:

- v: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The value to be written.

### func writeln(Float16)

```cangjie
public func writeln(v: Float16): Unit
```

Function: Writes the textual representation of the specified 16-bit floating-point value (followed by a newline character) to the standard output or standard error stream.

Parameters:

- v: [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) - The value to be written.

### func writeln(Float32)

```cangjie
public func writeln(v: Float32): Unit
```

Function: Writes the textual representation of the specified 32-bit floating-point value (followed by a newline character) to the standard output or standard error stream.

Parameters:

- v: [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) - The value to be written.

### func writeln(Float64)

```cangjie
public func writeln(v: Float64): Unit
```

Function: Writes the textual representation of the specified 64-bit floating-point value (followed by a newline character) to the standard output or standard error stream.

Parameters:

- v: [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - The value to be written.

### func writeln(Int16)

```cangjie
public func writeln(v: Int16): Unit
```

Function: Writes the textual representation of the specified 16-bit signed integer value (followed by a newline character) to the standard output or standard error stream.

Parameters:

- v: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The value to be written.

### func writeln(Int32)

```cangjie
public func writeln(v: Int32): Unit
```

Function: Writes the textual representation of the specified 32-bit signed integer value (followed by a newline character) to the standard output or standard error stream.

Parameters:

- v: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The value to be written.

### func writeln(Int64)

```cangjie
public func writeln(v: Int64): Unit
```

Function: Writes the textual representation of the specified 64-bit signed integer value (followed by a newline character) to the standard output or standard error stream.

Parameters:

- v: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The value to be written.

### func writeln(Int8)

```cangjie
public func writeln(v: Int8): Unit
```

Function: Writes the textual representation of the specified 8-bit signed integer value (followed by a newline character) to the standard output or standard error stream.

Parameters:

- v: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The value to be written.

### func writeln(Rune)

```cangjie
public func writeln(v: Rune): Unit
```

Function: Writes the specified Unicode character value (followed by a newline character) to the standard output or standard error stream.

Parameters:

- v: Rune - The value to be written.

### func writeln(String)

```cangjie
public func writeln(v: String): Unit
```

Function: Writes the specified string value (followed by a newline character) to the standard output or standard error stream.

Parameters:

- v: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The value to be written.

### func writeln(UInt16)

```cangjie
public func writeln(v: UInt16): Unit
```

Function: Writes the textual representation of the specified 16-bit unsigned integer value (followed by a newline character) to the standard output or standard error stream.

Parameters:

- v: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The value to be written.

### func writeln(UInt32)

```cangjie
public func writeln(v: UInt32): Unit
```

Function: Writes the textual representation of the specified 32-bit unsigned integer value (followed by a newline character) to the standard output or standard error stream.

Parameters:

- v: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The value to be written.

### func writeln(UInt64)

```cangjie
public func writeln(v: UInt64): Unit
```

Function: Writes the textual representation of the specified 64-bit unsigned integer value (followed by a newline character) to the standard output or standard error stream.

Parameters:

- v: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The value to be written.

### func writeln(UInt8)

```cangjie
public func writeln(v: UInt8): Unit
```

Function: Writes the textual representation of the specified 8-bit unsigned integer value (followed by a newline character) to the standard output or standard error stream.

Parameters:

- v: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The value to be written.

### func writeln\<T>(T) where T <: ToString

```cangjie
public func writeln<T>(v: T): Unit where T <: ToString
```

Function: Writes the string converted from a data type implementing the [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring) interface (followed by a newline character) to the standard output or standard error stream.

Parameters:

- v: T - The value to be written.