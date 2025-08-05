# Classes

## class ConsoleReader

```cangjie
public class ConsoleReader <: InputStream
```

Functionality: Provides the capability to read data from the console and convert it into characters or strings.

This type cannot be instantiated directly; instances can only be obtained via [getStdIn()](./env_package_funcs.md#func-getStdIn).  
Read operations are synchronous, with an internal buffer storing console input content. When the end of the console input stream is reached, console reading functions will return `None`.

> **Note:**
>
> There is only one instance of [ConsoleReader](./env_package_classes.md#class-consolereader), with all methods sharing the same buffer. The `read` methods return `None` under the following circumstances:
>
> - When standard input is redirected to a file and the end-of-file (EOF) is reached.
> - In Linux environments, when `Ctrl+D` is pressed.
> - In Windows environments, when `Ctrl+Z` is pressed followed by Enter.

Parent Type:

- [InputStream](../../io/io_package_api/io_package_interfaces.md#interface-inputstream)

### func read()

```cangjie
public func read(): ?Rune
```

Functionality: Reads the next character from standard input.

Return Value:

- ?[Rune](../../core/core_package_api/core_package_intrinsics.md#rune) - Returns the read character as ?[Rune](../../core/core_package_api/core_package_intrinsics.md#rune), or `None` if no character is read.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the input does not conform to a `UTF-8` encoded string.

Example:
<!-- compile -->

```cangjie
import std.env.*

main() {
    getStdOut().write("Please enter information: ")
    var c = getStdIn().read() // Input: abc
    var r = c.getOrThrow()
    getStdOut().write("Input received: ")
    getStdOut().writeln(r)

    return
}
```

Execution Result:

```text
Please enter information: abc
Input received: a
```

### func read(Array\<Byte>)

```cangjie
public func read(arr: Array<Byte>): Int64
```

Functionality: Reads from standard input and stores the data in `arr`.

> **Warning:**
>
> This function carries a risk: the read result might truncate a `UTF-8 code point` in the middle. If truncation occurs, converting this [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)> to a string may produce incorrect results or throw an exception.

Parameters:

- arr: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)> - The target array.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Returns the number of bytes read.

Example:
<!-- compile -->

```cangjie
import std.env.*

main() {
    var arr = Array<Byte>(3, repeat: 0)
    getStdOut().write("Please enter information: ")
    getStdIn().read(arr) // Input: 567
    getStdOut().write("Resulting array: ")
    getStdOut().writeln(arr)

    return
}
```

Execution Result:

```text
Please enter information: 567
Resulting array: 567
```

### func readToEnd()

```cangjie
public func readToEnd(): ?String
```

Functionality: Reads all characters from standard input.

Reading continues until the end-of-file marker `EOF` is encountered, or until `Ctrl+D` is pressed in Linux or `Ctrl+Z` + Enter in Windows. Returns the read characters as ?[String](../../core/core_package_api/core_package_structs.md#struct-string), or `None` if no characters are read. This interface does not throw exceptions; even if the input is not a valid `UTF-8` encoded string, it will construct and return a [String](../../core/core_package_api/core_package_structs.md#struct-string), behaving equivalently to [String](../../core/core_package_api/core_package_structs.md#struct-string).[fromUtf8Uncheck](../../core/core_package_api/core_package_structs.md#static-func-fromutf8uncheckedarrayuint8)([Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)>).

Return Value:

- ?[String](../../core/core_package_api/core_package_structs.md#struct-string) - Returns all read data as ?[String](../../core/core_package_api/core_package_structs.md#struct-string).

### func readUntil((Rune) -> Bool)

```cangjie
public func readUntil(predicate: (Rune) -> Bool): ?String
```

Functionality: Reads data from standard input until a character satisfies the `predicate` condition.

The character that satisfies predicate: (Rune) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) is included in the result. Returns `None` if reading fails.

Parameters:

- predicate: (Rune) ->[Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The condition to terminate reading.

Return Value:

- ?[String](../../core/core_package_api/core_package_structs.md#struct-string) - Returns the read data as ?[String](../../core/core_package_api/core_package_structs.md#struct-string).

Example:
<!-- compile -->

```cangjie
import std.env.*

main() {
    getStdOut().write("Please enter information: ")
    var c = getStdIn().readUntil({ch: Rune => ch > r'd' && ch < r'g'}) // Input: abcdefg
    var r = c.getOrThrow()
    getStdOut().writeln("Input received: " + r)

    return
}
```

Execution Result:

```text
Please enter information: abcdefg
Input received: abcde
```

### func readUntil(Rune)

```cangjie
public func readUntil(ch: Rune): ?String
```

Functionality: Reads data from standard input until the character `ch` is encountered.

`ch` is included in the result. If the end-of-file marker EOF is encountered, all read information is returned. Returns `None` if reading fails.

Parameters:

- ch: [Rune](../../core/core_package_api/core_package_intrinsics.md#rune) - The terminating character.

Return Value:

- ?[String](../../core/core_package_api/core_package_structs.md#struct-string) - Returns the read data as ?[String](../../core/core_package_api/core_package_structs.md#struct-string).

Example:
<!-- compile -->

```cangjie
import std.env.*

main() {
    getStdOut().write("Please enter information: ")
    var c = getStdIn().readUntil(r'b') // Input: abc
    var r = c.getOrThrow()
    getStdOut().write("Input received: ")
    getStdOut().writeln(r)

    return
}
```

Execution Result:

```text
Please enter information: abc
Input received: ab
```

### func readln()

```cangjie
public func readln(): ?String
```

Functionality: Reads a line of text from standard input.

Returns the read characters as ?[String](../../core/core_package_api/core_package_structs.md#struct-string), excluding the trailing newline character. This interface does not throw exceptions; even if the input is not a valid `UTF-8` encoded string, it will construct and return a [String](../../core/core_package_api/core_package_structs.md#struct-string), behaving equivalently to [String](../../core/core_package_api/core_package_structs.md#struct-string).[fromUtf8Uncheck](../../core/core_package_api/core_package_structs.md#static-func-fromutf8uncheckedarrayuint8)([Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)>).

Return Value:

- ?[String](../../core/core_package_api/core_package_structs.md#struct-string) - The read line of data, or `None` if reading fails.

Example:
<!-- compile -->

```cangjie
import std.env.*

main() {
    getStdOut().write("Please enter information: ")
    var c = getStdIn().readln() // Input: abc
    var r = c.getOrThrow()
    getStdOut().write("Input received: ")
    getStdOut().writeln(r)

    return
}
```

Execution Result:

```text
Please enter information: abc
Input received: abc
```

## class ConsoleWriter

```cangjie
public class ConsoleWriter <: OutputStream
```

Functionality: This class provides thread-safe standard output functionality.

Each `write` call produces complete output to the console, and results from different `write` function calls will not be interleaved.  
This type cannot be instantiated directly; instances can only be obtained via [getStdOut()](./env_package_funcs.md#func-getStdOut) for standard output or [getStdErr()](./env_package_funcs.md#func-getStdErr) for standard error.

Parent Type:

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

Parameters:- v: [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) - The value to be written.

### func write(Float32)

```cangjie
public func write(v: Float32): Unit
```

Function: Writes the text representation of the specified 32-bit floating-point value to the standard output or standard error stream.

Parameters:

- v: [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) - The value to be written.

### func write(Float64)

```cangjie
public func write(v: Float64): Unit
```

Function: Writes the text representation of the specified 64-bit floating-point value to the standard output or standard error stream.

Parameters:

- v: [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - The value to be written.

### func write(Int16)

```cangjie
public func write(v: Int16): Unit
```

Function: Writes the text representation of the specified 16-bit signed integer value to the standard output or standard error stream.

Parameters:

- v: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The value to be written.

### func write(Int32)

```cangjie
public func write(v: Int32): Unit
```

Function: Writes the text representation of the specified 32-bit signed integer value to the standard output or standard error stream.

Parameters:

- v: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The value to be written.

### func write(Int64)

```cangjie
public func write(v: Int64): Unit
```

Function: Writes the text representation of the specified 64-bit signed integer value to the standard output or standard error stream.

Parameters:

- v: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The value to be written.

### func write(Int8)

```cangjie
public func write(v: Int8): Unit
```

Function: Writes the text representation of the specified 8-bit signed integer value to the standard output or standard error stream.

Parameters:

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

Function: Writes the text representation of the specified 16-bit unsigned integer value to the standard output or standard error stream.

Parameters:

- v: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The value to be written.

### func write(UInt32)

```cangjie
public func write(v: UInt32): Unit
```

Function: Writes the text representation of the specified 32-bit unsigned integer value to the standard output or standard error stream.

Parameters:

- v: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The value to be written.

### func write(UInt64)

```cangjie
public func write(v: UInt64): Unit
```

Function: Writes the text representation of the specified 64-bit unsigned integer value to the standard output or standard error stream.

Parameters:

- v: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The value to be written.

### func write(UInt8)

```cangjie
public func write(v: UInt8): Unit
```

Function: Writes the text representation of the specified 8-bit unsigned integer value to the standard output or standard error stream.

Parameters:

- v: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The value to be written.

### func write\<T>(T) where T <: ToString

```cangjie
public func write<T>(v: T): Unit where T <: ToString
```

Function: Writes a data type that implements the [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring) interface to the standard output or standard error stream.

Parameters:

- v: T - An instance of the [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring) type to be written.

### func writeln(Array\<Byte>)

```cangjie
public func writeln(buffer: Array<Byte>): Unit
```

Function: Writes the specified byte array buffer (followed by a newline) to the standard output or standard error stream.

Parameters:

- buffer: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)> - The value to be written.

### func writeln(Bool)

```cangjie
public func writeln(v: Bool): Unit
```

Function: Writes the text representation of the specified boolean value (followed by a newline) to the standard output or standard error stream.

Parameters:

- v: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The value to be written.

### func writeln(Float16)

```cangjie
public func writeln(v: Float16): Unit
```

Function: Writes the text representation of the specified 16-bit floating-point value (followed by a newline) to the standard output or standard error stream.

Parameters:

- v: [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) - The value to be written.

### func writeln(Float32)

```cangjie
public func writeln(v: Float32): Unit
```

Function: Writes the text representation of the specified 32-bit floating-point value (followed by a newline) to the standard output or standard error stream.

Parameters:

- v: [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) - The value to be written.

### func writeln(Float64)

```cangjie
public func writeln(v: Float64): Unit
```

Function: Writes the text representation of the specified 64-bit floating-point value (followed by a newline) to the standard output or standard error stream.

Parameters:

- v: [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - The value to be written.

### func writeln(Int16)

```cangjie
public func writeln(v: Int16): Unit
```

Function: Writes the text representation of the specified 16-bit signed integer value (followed by a newline) to the standard output or standard error stream.

Parameters:

- v: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The value to be written.

### func writeln(Int32)

```cangjie
public func writeln(v: Int32): Unit
```

Function: Writes the text representation of the specified 32-bit signed integer value (followed by a newline) to the standard output or standard error stream.

Parameters:

- v: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The value to be written.

### func writeln(Int64)

```cangjie
public func writeln(v: Int64): Unit
```

Function: Writes the text representation of the specified 64-bit signed integer value (followed by a newline) to the standard output or standard error stream.

Parameters:

- v: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The value to be written.

### func writeln(Int8)

```cangjie
public func writeln(v: Int8): Unit
```

Function: Writes the text representation of the specified 8-bit signed integer value (followed by a newline) to the standard output or standard error stream.

Parameters:

- v: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The value to be written.

### func writeln(Rune)

```cangjie
public func writeln(v: Rune): Unit
```

Function: Writes the specified Unicode character value (followed by a newline) to the standard output or standard error stream.

Parameters:

- v: Rune - The value to be written.

### func writeln(String)

```cangjie
public func writeln(v: String): Unit
```

Function: Writes the specified string value (followed by a newline) to the standard output or standard error stream.

Parameters:

- v: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The value to be written.

### func writeln(UInt16)

```cangjie
public func writeln(v: UInt16): Unit
```

Function: Writes the text representation of the specified 16-bit unsigned integer value (followed by a newline) to the standard output or standard error stream.

Parameters:- v: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The value to be written.

### func writeln(UInt32)

```cangjie
public func writeln(v: UInt32): Unit
```

Function: Writes the text representation of the specified 32-bit unsigned integer value (followed by a newline) to the standard output or standard error stream.

Parameters:

- v: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The value to be written.

### func writeln(UInt64)

```cangjie
public func writeln(v: UInt64): Unit
```

Function: Writes the text representation of the specified 64-bit unsigned integer value (followed by a newline) to the standard output or standard error stream.

Parameters:

- v: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The value to be written.

### func writeln(UInt8)

```cangjie
public func writeln(v: UInt8): Unit
```

Function: Writes the text representation of the specified 8-bit unsigned integer value (followed by a newline) to the standard output or standard error stream.

Parameters:

- v: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The value to be written.

### func writeln\<T>(T) where T <: ToString

```cangjie
public func writeln<T>(v: T): Unit where T <: ToString
```

Function: Writes the string converted from a data type implementing the [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring) interface (followed by a newline) to the standard output or standard error stream.

Parameters:

- v: T - The value to be written.