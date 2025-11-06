# Class

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

Functionality: This member property is of type [ConsoleWriter](console_package_class.md#class-consolewriter-deprecated), providing access to standard error output.

Type: [ConsoleWriter](console_package_class.md#class-consolewriter-deprecated)

Example:

<!-- run -->
```cangjie
import std.console.*

main() {
    // Get standard error output stream
    let stderr = Console.stdErr
    
    // Output message using standard error stream
    stderr.write("This is a standard error message")
}
```

Execution Result:

```text
This is a standard error message
```

### static prop stdIn

```cangjie
public static prop stdIn: ConsoleReader
```

Functionality: This member property is of type [ConsoleReader](console_package_class.md#class-consolereader-deprecated), providing access to standard input.

Type: [ConsoleReader](console_package_class.md#class-consolereader-deprecated)

Example:

<!-- verify -->
```cangjie
import std.console.*

main() {
    // Get standard input stream
    let stdin = Console.stdIn
    
    // Note: In actual usage, we typically don't directly operate stdin,
    // but use its provided read method to read user input
    println("Standard input stream successfully obtained")
}
```

Execution Result:

```text
Standard input stream successfully obtained
```

### static prop stdOut

```cangjie
public static prop stdOut: ConsoleWriter
```

Functionality: This member property is of type [ConsoleWriter](console_package_class.md#class-consolewriter-deprecated), providing access to standard output.

Type: [ConsoleWriter](console_package_class.md#class-consolewriter-deprecated)

Example:

<!-- verify -->
```cangjie
import std.console.*

main() {
    // Get standard output stream
    let stdout = Console.stdOut
    
    // Output message using standard output stream
    stdout.write("This is a standard output message")
}
```

Execution Result:

```text
This is a standard output message
```

## class ConsoleReader <sup>(deprecated)</sup>

```cangjie
public class ConsoleReader <: InputStream
```

Functionality: Provides functionality to read data from console and convert it to characters or strings.

This type cannot be instantiated directly; instances can only be obtained through [Console.stdIn](console_package_class.md#static-prop-stdin). 
Read operations are synchronous, with an internal buffer storing console input content. When reaching the end of console input stream, console read functions will return `None`.

[ConsoleReader](console_package_class.md#class-consolereader-deprecated) has only one instance, with all methods sharing the same buffer. Scenarios where related `read` methods return `None` include:

- When standard input is redirected to a file and EOF is reached.
- In Linux environment, pressing `Ctrl+D`.
- In Windows environment, pressing `Ctrl+Z` followed by Enter.

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

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception): Thrown when input is not a `UTF-8` encoded string.

Example:

<!-- compile -->
```cangjie
import std.console.*

main() {
    // Get standard input stream
    let stdin = Console.stdIn
    
    // Read next character
    // Note: During actual execution, the program waits for user input. Assume user inputs 'H'
    let r = stdin.read()
    println("User input: ${r}")
}
```

Execution Result:

```text
User input: Some(H)
```

### func read(Array\<Byte>)

```cangjie
public func read(arr: Array<Byte>): Int64
```

Functionality: Reads from standard input and stores in `arr`.

> **Note:**
>
> This function carries risks as it may truncate `UTF-8 code points` during reading. If truncation occurs, converting the [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)> to a string may produce incorrect results or throw exceptions.

Parameters:

- arr: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)> - Target array.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Returns the number of bytes read.

Example:

<!-- compile -->
```cangjie
import std.console.*

main() {
    // Get standard input stream
    let stdin = Console.stdIn
    
    // Create byte array for reading data
    let buffer: Array<Byte> = [0, 0 , 0 , 0 , 0]
    
    // Read data from standard input into array
    // Note: During actual execution, the program waits for user input. Assume input is 'abcde'
    stdin.read(buffer)
    println("Buffer content: ${buffer}")
}
```

Execution Result:

```text
Buffer content: [97, 98, 99, 100, 101]
```

### func readToEnd()

```cangjie
public func readToEnd(): ?String
```

Functionality: Reads all characters from standard input.

Reads until EOF is encountered, or `Ctrl+D` is pressed in Linux or `Ctrl+Z` + Enter in Windows. Returns ?[String](../../core/core_package_api/core_package_structs.md#struct-string) if characters are read, otherwise returns `None`. This interface won't throw exceptions even if input isn't `UTF-8` encoded, behaving equivalently to [String](../../core/core_package_api/core_package_structs.md#struct-string).[fromUtf8Uncheck](../../core/core_package_api/core_package_structs.md#static-func-fromutf8uncheckedarrayuint8)([Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)>).

Return Value:

- ?[String](../../core/core_package_api/core_package_structs.md#struct-string) - Returns all read data as ?[String](../../core/core_package_api/core_package_structs.md#struct-string).

Example:

<!-- compile -->
```cangjie
import std.console.*

main() {
    // Get standard input stream
    let stdin = Console.stdIn
    
    // Read all characters from standard input until EOF
    // Note: During actual execution, the program waits for user input until EOF (Ctrl+D or Ctrl+Z)
    // Current example assumes input 'abcde' followed by pressing Ctrl+D twice
    // If input buffer isn't empty (e.g., just typed 'abcde' without Enter): Ctrl+D only "flushes" buffer content to program without triggering EOF
    // If input buffer is empty (e.g., just pressed Enter with cursor at new line start): Ctrl+D sends EOF signal indicating "no more input"
    let str = stdin.readToEnd()
    println("Input: ${str}")
}
```

Execution Result:

```text
abcdeInput: Some(abcde)
```

### func readUntil((Rune) -> Bool)

```cangjie
public func readUntil(predicate: (Rune) -> Bool): ?String
```

Functionality: Reads data from standard input until the read character satisfies `predicate` condition.

Characters satisfying predicate: (Rune) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) are included in the result. Returns `None` if reading fails.

Parameters:

- predicate: (Rune) ->[Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Condition to terminate reading.

Return Value:

- ?[String](../../core/core_package_api/core_package_structs.md#struct-string) - Returns read data as ?[String](../../core/core_package_api/core_package_structs.md#struct-string).

Example:

<!-- compile -->
```cangjie
import std.console.*

main() {
    // Get standard input stream
    let stdin = Console.stdIn
    
    // Read data from standard input until condition is met
    // Note: During actual execution, the program waits for user input. Assume input 'abcdefg' followed by Enter
    let str = stdin.readUntil({r: Rune => r == r'e'})
    println(str)
}
```

Execution Result:

```text
Some(abcde)
```

### func readUntil(Rune)

```cangjie
public func readUntil(ch: Rune): ?String
```

Functionality: Reads data from standard input until character `ch` is encountered.

`ch` is included in the result. If EOF is encountered, returns all read information. Returns `None` if reading fails.

Parameters:

- ch: [Rune](../../core/core_package_api/core_package_intrinsics.md#rune) - Termination character.

Return Value:

- ?[String](../../core/core_package_api/core_package_structs.md#struct-string) - Returns read data as ?[String](../../core/core_package_api/core_package_structs.md#struct-string).

Example:

<!-- compile -->
```cangjie
import std.console.*

main() {
    // Get standard input stream
    let stdin = Console.stdIn
    
    // Read data from standard input until specified character is encountered
    // Note: During actual execution, the program waits for user input. Assume input 'abcdefg' followed by Enter
    let str = stdin.readUntil(r'e')
    println(str)
}
```

Execution Result:

```text
Some(abcde)
```

### func readln()

```cangjie
public func readln(): ?String
```

Functionality: Reads a line of string from standard input.

Returns ?[String](../../core/core_package_api/core_package_structs.md#struct-string) if characters are read (excluding trailing newline). This interface won't throw exceptions even if input isn't `UTF-8` encoded, behaving equivalently to [String](../../core/core_package_api/core_package_structs.md#struct-string).fromUtf8Uncheck([Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)>).

Return Value:

- ?[String](../../core/core_package_api/core_package_structs.md#struct-string) - Returns the read line data, or `None` if reading fails.

Example:

<!-- compile -->
```cangjie
import std.console.*

main() {
    // Get standard input stream
    let stdin = Console.stdIn
    
    // Read a line of string from standard input
    // Note: During actual execution, the program waits for user input. Assume input 'abcde' followed by Enter
    let str = stdin.readln()
    println(str)
}
```

Execution Result:

```text
Some(abcde)
```

## class ConsoleWriter <sup>(deprecated)</sup>

```cangjie
public class ConsoleWriter <: OutputStream
```

Functionality: This class provides thread-safe standard output functionality.

Each write call produces complete output to console, with no mixing between different write function calls.
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

Example:

<!-- verify -->
```cangjie
import std.console.*

main() {
    // Get standard output stream
    let stdout = Console.stdOut
    
    // Write some data to standard output
    stdout.write("This is some output data\n")
    
    // Flush output stream to ensure immediate output
    stdout.flush()
    
    println("Data has been flushed to output stream")
}
```

Execution Result:

```text
This is some output data
Data has been flushed to output stream
```

### func write(Array\<Byte>)

```cangjie
public func write(buffer: Array<Byte>): Unit
```

Function: Writes the specified byte array `buffer` to the standard output or standard error stream.

Parameters:

- buffer: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)> - The byte array to be written.

Example:

<!-- verify -->
```cangjie
import std.console.*

main() {
    // Get the standard output stream
    let stdout = Console.stdOut
    
    // Create a byte array
    let buffer: Array<Byte> = [72 , 101 , 108 , 108 , 111]  // ASCII codes for "Hello"
    
    // Write the byte array to standard output
    // Note: In actual usage, this will write the byte array contents to stdout
    stdout.write(buffer)
}
```

Execution Result:

```text
Hello
```

### func write(Bool)

```cangjie
public func write(v: Bool): Unit
```

Function: Writes the text representation of the specified boolean value to the standard output or standard error stream.

Parameters:

- v: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The value to write.

Example:

<!-- verify -->
```cangjie
import std.console.*

main() {
    // Get the standard output stream
    let stdout = Console.stdOut
    
    // Write boolean values to standard output
    stdout.write(true)
    stdout.write(false)
}
```

Execution Result:

```text
truefalse
```

### func write(Float16)

```cangjie
public func write(v: Float16): Unit
```

Function: Writes the text representation of the specified 16-bit floating-point value to the standard output or standard error stream.

Parameters:

- v: [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) - The value to write.

Example:

<!-- verify -->
```cangjie
import std.console.*

main() {
    // Get the standard output stream
    let stdout = Console.stdOut
    
    // Write a 16-bit floating-point value to standard output
    stdout.write(3.14f16)
}
```

Execution Result:

```text
3.140625
```

### func write(Float32)

```cangjie
public func write(v: Float32): Unit
```

Function: Writes the text representation of the specified 32-bit floating-point value to the standard output or standard error stream.

Parameters:

- v: [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) - The value to write.

Example:

<!-- verify -->
```cangjie
import std.console.*

main() {
    // Get the standard output stream
    let stdout = Console.stdOut
    
    // Write a 32-bit floating-point value to standard output
    stdout.write(3.14159f32)
}
```

Execution Result:

```text
3.141590
```

### func write(Float64)

```cangjie
public func write(v: Float64): Unit
```

Function: Writes the text representation of the specified 64-bit floating-point value to the standard output or standard error stream.

Parameters:

- v: [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - The value to write.

Example:

<!-- verify -->
```cangjie
import std.console.*

main() {
    // Get the standard output stream
    let stdout = Console.stdOut
    
    // Write a 64-bit floating-point value to standard output
    stdout.write(3.141592653589793)
}
```

Execution Result:

```text
3.141593
```

### func write(Int16)

```cangjie
public func write(v: Int16): Unit
```

Function: Writes the text representation of the specified 16-bit signed integer value to the standard output or standard error stream.

Parameters:

- v: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The value to write.

Example:

<!-- verify -->
```cangjie
import std.console.*

main() {
    // Get the standard output stream
    let stdout = Console.stdOut
    
    // Write a 16-bit signed integer value to standard output
    stdout.write(12345i16)
}
```

Execution Result:

```text
12345
```

### func write(Int32)

```cangjie
public func write(v: Int32): Unit
```

Function: Writes the text representation of the specified 32-bit signed integer value to the standard output or standard error stream.

Parameters:

- v: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The value to write.

Example:

<!-- verify -->
```cangjie
import std.console.*

main() {
    // Get the standard output stream
    let stdout = Console.stdOut
    
    // Write a 32-bit signed integer value to standard output
    stdout.write(1234567890i32)
}
```

Execution Result:

```text
1234567890
```

### func write(Int64)

```cangjie
public func write(v: Int64): Unit
```

Function: Writes the text representation of the specified 64-bit signed integer value to the standard output or standard error stream.

Parameters:

- v: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The value to write.

Example:

<!-- verify -->
```cangjie
import std.console.*

main() {
    // Get the standard output stream
    let stdout = Console.stdOut
    
    // Write a 64-bit signed integer value to standard output
    stdout.write(123456789012345)
}
```

Execution Result:

```text
123456789012345
```

### func write(Int8)

```cangjie
public func write(v: Int8): Unit
```

Function: Writes the text representation of the specified 8-bit signed integer value to the standard output or standard error stream.

Parameters:

- v: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The value to write.

Example:

<!-- verify -->
```cangjie
import std.console.*

main() {
    // Get the standard output stream
    let stdout = Console.stdOut
    
    // Write an 8-bit signed integer value to standard output
    stdout.write(123i8)
}
```

Execution Result:

```text
123
```

### func write(Rune)

```cangjie
public func write(v: Rune): Unit
```

Function: Writes the specified Unicode character value of [Rune](../../../std/core/core_package_api/core_package_intrinsics.md#rune) to the standard output or standard error stream.

Parameters:

- v: [Rune](../../../std/core/core_package_api/core_package_intrinsics.md#rune) - The value to write.

Example:

<!-- verify -->
```cangjie
import std.console.*

main() {
    // Get the standard output stream
    let stdout = Console.stdOut
    
    // Write a Unicode character value to standard output
    stdout.write(r'A')
}
```

Execution Result:

```text
A
```

### func write(String)

```cangjie
public func write(v: String): Unit
```

Function: Writes the specified string value to the standard output or standard error stream.

Parameters:

- v: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The value to write.

Example:

<!-- verify -->
```cangjie
import std.console.*

main() {
    // Get the standard output stream
    let stdout = Console.stdOut
    
    // Write a string value to standard output
    stdout.write("Hello, World!")
}
```

Execution Result:

```text
Hello, World!
```

### func write(UInt16)

```cangjie
public func write(v: UInt16): Unit
```

Function: Writes the text representation of the specified 16-bit unsigned integer value to the standard output or standard error stream.

Parameters:

- v: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The value to write.

Example:

<!-- verify -->
```cangjie
import std.console.*

main() {
    // Get the standard output stream
    let stdout = Console.stdOut
    
    // Write a 16-bit unsigned integer value to standard output
    stdout.write(12345u16)
}
```

Execution Result:

```text
12345
```

### func write(UInt32)

```cangjie
public func write(v: UInt32): Unit
```

Function: Writes the text representation of the specified 32-bit unsigned integer value to the standard output or standard error stream.

Parameters:

- v: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The value to be written.

Example:

<!-- verify -->
```cangjie
import std.console.*

main() {
    // Get the standard output stream
    let stdout = Console.stdOut
    
    // Write a 32-bit unsigned integer value to standard output
    stdout.write(1234567890u32)
}
```

Execution Result:

```text
1234567890
```

### func write(UInt64)

```cangjie
public func write(v: UInt64): Unit
```

Function: Writes the text representation of the specified 64-bit unsigned integer value to the standard output or standard error stream.

Parameters:

- v: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The value to be written.

Example:

<!-- verify -->
```cangjie
import std.console.*

main() {
    // Get the standard output stream
    let stdout = Console.stdOut
    
    // Write a 64-bit unsigned integer value to standard output
    stdout.write(123456789012345u64)
}
```

Execution Result:

```text
123456789012345
```

### func write(UInt8)

```cangjie
public func write(v: UInt8): Unit
```

Function: Writes the text representation of the specified 8-bit unsigned integer value to the standard output or standard error stream.

Parameters:

- v: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The value to be written.

Example:

<!-- verify -->
```cangjie
import std.console.*

main() {
    // Get the standard output stream
    let stdout = Console.stdOut
    
    // Write an 8-bit unsigned integer value to standard output
    stdout.write(123u8)
}
```

Execution Result:

```text
123
```

### func write\<T>(T) where T <: ToString

```cangjie
public func write<T>(v: T): Unit where T <: ToString
```

Function: Writes a data type that implements the [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring) interface to the standard output or standard error stream.

Parameters:

- v: T - An instance of type [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring) to be written.

Example:

<!-- verify -->
```cangjie
import std.console.*

main() {
    // Get the standard output stream
    let stdout = Console.stdOut
    
    // Write a data type implementing the ToString interface to standard output
    stdout.write(MyID())
}

class MyID <: ToString {
    public func toString(): String {
        return "Id: 123"
    }
}
```

Execution Result:

```text
Id: 123
```

### func writeln(Array\<Byte>)

```cangjie
public func writeln(buffer: Array<Byte>): Unit
```

Function: Writes the specified byte array buffer (followed by a newline) to the standard output or standard error stream.

Parameters:

- buffer: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)> - The value to be written.

Example:

<!-- verify -->
```cangjie
import std.console.*

main() {
    // Get the standard output stream
    let stdout = Console.stdOut
    
    // Create a byte array
    let buffer: Array<Byte> = [72 , 101 , 108 , 108 , 111]  // ASCII codes for "Hello"
    
    // Write the byte array to standard output
    stdout.writeln(buffer)
}
```

Execution Result:

```text
Hello
```

### func writeln(Bool)

```cangjie
public func writeln(v: Bool): Unit
```

Function: Writes the text representation of the specified boolean value (followed by a newline) to the standard output or standard error stream.

Parameters:

- v: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The value to be written.

Example:

<!-- verify -->
```cangjie
import std.console.*

main() {
    // Get the standard output stream
    let stdout = Console.stdOut
    
    // Write boolean values to standard output
    stdout.writeln(true)
    stdout.writeln(false)
}
```

Execution Result:

```text
true
false
```

### func writeln(Float16)

```cangjie
public func writeln(v: Float16): Unit
```

Function: Writes the text representation of the specified 16-bit floating-point value (followed by a newline) to the standard output or standard error stream.

Parameters:

- v: [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) - The value to be written.

Example:

<!-- verify -->
```cangjie
import std.console.*

main() {
    // Get the standard output stream
    let stdout = Console.stdOut
    
    // Write a 16-bit floating-point value to standard output
    stdout.writeln(3.14f16)
}
```

Execution Result:

```text
3.140625
```

### func writeln(Float32)

```cangjie
public func writeln(v: Float32): Unit
```

Function: Writes the text representation of the specified 32-bit floating-point value (followed by a newline) to the standard output or standard error stream.

Parameters:

- v: [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) - The value to be written.

Example:

<!-- verify -->
```cangjie
import std.console.*

main() {
    // Get the standard output stream
    let stdout = Console.stdOut
    
    // Write a 32-bit floating-point value to standard output
    stdout.writeln(3.14159f32)
}
```

Execution Result:

```text
3.141590
```

### func writeln(Float64)

```cangjie
public func writeln(v: Float64): Unit
```

Function: Writes the text representation of the specified 64-bit floating-point value (followed by a newline) to the standard output or standard error stream.

Parameters:

- v: [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - The value to be written.

Example:

<!-- verify -->
```cangjie
import std.console.*

main() {
    // Get the standard output stream
    let stdout = Console.stdOut
    
    // Write a 64-bit floating-point value to standard output
    stdout.writeln(3.141592653589793)
}
```

Execution Result:

```text
3.141593
```

### func writeln(Int16)

```cangjie
public func writeln(v: Int16): Unit
```

Function: Writes the text representation of the specified 16-bit signed integer value (followed by a newline) to the standard output or standard error stream.

Parameters:

- v: [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The value to be written.

Example:

<!-- verify -->
```cangjie
import std.console.*

main() {
    // Get the standard output stream
    let stdout = Console.stdOut
    
    // Write a 16-bit signed integer value to standard output
    stdout.writeln(12345i16)
}
```

Execution Result:

```text
12345
```

### func writeln(Int32)

```cangjie
public func writeln(v: Int32): Unit
```

Function: Writes the text representation of the specified 32-bit signed integer value (followed by a newline) to the standard output or standard error stream.

Parameters:

- v: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The value to be written.

Example:

<!-- verify -->
```cangjie
import std.console.*

main() {
    // Get the standard output stream
    let stdout = Console.stdOut
    
    // Write a 32-bit signed integer value to standard output
    stdout.writeln(1234567890i32)
}
```

Execution Result:

```text
1234567890
```

### func writeln(Int64)

```cangjie
public func writeln(v: Int64): Unit
```

Function: Writes the text representation of the specified 64-bit signed integer value (followed by a newline) to the standard output or standard error stream.

Parameters:

- v: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The value to be written.

Example:

<!-- verify -->
```cangjie
import std.console.*

main() {
    // Get the standard output stream
    let stdout = Console.stdOut
    
    // Write a 64-bit signed integer value to standard output
    stdout.writeln(123456789012345)
}
```

Execution Result:

```text
123456789012345
```

### func writeln(Int8)

```cangjie
public func writeln(v: Int8): Unit
```

Function: Writes the text representation of the specified 8-bit signed integer value (followed by a line terminator) to the standard output or standard error stream.

Parameters:

- v: [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The value to write.

Example:

<!-- verify -->
```cangjie
import std.console.*

main() {
    // Get standard output stream
    let stdout = Console.stdOut
    
    // Write 8-bit signed integer value to standard output
    stdout.writeln(123i8)
}
```

Execution Result:

```text
123
```

### func writeln(Rune)

```cangjie
public func writeln(v: Rune): Unit
```

Function: Writes the specified Unicode character value (followed by a line terminator) to the standard output or standard error stream.

Parameters:

- v: Rune - The value to write.

Example:

<!-- verify -->
```cangjie
import std.console.*

main() {
    // Get standard output stream
    let stdout = Console.stdOut
    
    // Write Unicode character value to standard output
    stdout.writeln(r'A')
}
```

Execution Result:

```text
A
```

### func writeln(String)

```cangjie
public func writeln(v: String): Unit
```

Function: Writes the specified string value (followed by a line terminator) to the standard output or standard error stream.

Parameters:

- v: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The value to write.

Example:

<!-- verify -->
```cangjie
import std.console.*

main() {
    // Get standard output stream
    let stdout = Console.stdOut
    
    // Write string value to standard output
    stdout.writeln("Hello, World!")
}
```

Execution Result:

```text
Hello, World!
```

### func writeln(UInt16)

```cangjie
public func writeln(v: UInt16): Unit
```

Function: Writes the text representation of the specified 16-bit unsigned integer value (followed by a line terminator) to the standard output or standard error stream.

Parameters:

- v: [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The value to write.

Example:

<!-- verify -->
```cangjie
import std.console.*

main() {
    // Get standard output stream
    let stdout = Console.stdOut
    
    // Write 16-bit unsigned integer value to standard output
    stdout.writeln(12345u16)
}
```

Execution Result:

```text
12345
```

### func writeln(UInt32)

```cangjie
public func writeln(v: UInt32): Unit
```

Function: Writes the text representation of the specified 32-bit unsigned integer value (followed by a line terminator) to the standard output or standard error stream.

Parameters:

- v: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The value to write.

Example:

<!-- verify -->
```cangjie
import std.console.*

main() {
    // Get standard output stream
    let stdout = Console.stdOut
    
    // Write 32-bit unsigned integer value to standard output
    stdout.writeln(1234567890u32)
}
```

Execution Result:

```text
1234567890
```

### func writeln(UInt64)

```cangjie
public func writeln(v: UInt64): Unit
```

Function: Writes the text representation of the specified 64-bit unsigned integer value (followed by a line terminator) to the standard output or standard error stream.

Parameters:

- v: [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The value to write.

Example:

<!-- verify -->
```cangjie
import std.console.*

main() {
    // Get standard output stream
    let stdout = Console.stdOut
    
    // Write 64-bit unsigned integer value to standard output
    stdout.writeln(123456789012345u64)
}
```

Execution Result:

```text
123456789012345
```

### func writeln(UInt8)

```cangjie
public func writeln(v: UInt8): Unit
```

Function: Writes the text representation of the specified 8-bit unsigned integer value (followed by a line terminator) to the standard output or standard error stream.

Parameters:

- v: [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The value to write.

Example:

<!-- verify -->
```cangjie
import std.console.*

main() {
    // Get standard output stream
    let stdout = Console.stdOut
    
    // Write 8-bit unsigned integer value to standard output
    stdout.writeln(123u8)
}
```

Execution Result:

```text
123
```

### func writeln\<T>(T) where T <: ToString

```cangjie
public func writeln<T>(v: T): Unit where T <: ToString
```

Function: Writes the string converted from a data type implementing the [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring) interface (followed by a line terminator) to the standard output or standard error stream.

Parameters:

- v: T - The value to write.

Example:

<!-- verify -->
```cangjie
import std.console.*

main() {
    // Get standard output stream
    let stdout = Console.stdOut
    
    // Write data type implementing ToString interface to standard output
    stdout.writeln(MyID())
}

class MyID <: ToString {
    public func toString(): String {
        return "Id: 123"
    }
}
```

Execution Result:

```text
Id: 123
```