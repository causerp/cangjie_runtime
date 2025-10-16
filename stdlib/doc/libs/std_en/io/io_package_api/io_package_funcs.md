# Functions

## func copy(InputStream, OutputStream)

```cangjie
public func copy(from: InputStream, to!: OutputStream): Int64
```

Function: Copies unread data from an input stream to an output stream.

Parameters:

- from: [InputStream](io_package_interfaces.md#interface-inputstream) - The input stream to read data from.
- to!: [OutputStream](io_package_interfaces.md#interface-outputstream) - The output stream to copy data to.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The number of bytes copied.

Example:

<!-- verify -->
```cangjie
import std.io.ByteBuffer
import std.io.copy

main(): Unit {
    let sourceStream = ByteBuffer()
    let targetStream = ByteBuffer()

    /* Write data to source input stream */
    let sourceData = "Hello, World!".toArray()
    sourceStream.write(sourceData)

    /* Use copy function to transfer data from source to target stream */
    let copiedBytes = copy(sourceStream, to: targetStream)
    println("Copied ${copiedBytes} bytes.")

    /* Read data from target output stream */
    let targetData: Array<Byte> = Array<Byte>(sourceData.size, repeat: 0)
    targetStream.read(targetData)
    println("Data copied to target stream: ${String.fromUtf8(targetData)}")
}
```

Execution Result:

```text
Copied 13 bytes.
Data copied to target stream: Hello, World!
```

## func readString\<T>(T) where T <: InputStream & Seekable

```cangjie
public func readString<T>(from: T): String where T <: InputStream & Seekable
```

Function: Reads all remaining content from the parameter and returns a string.

Parameters:

- from: T - The object to read data from.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The resulting string read.

Exceptions:

- [ContentFormatException](io_package_exceptions.md#class-contentformatexception) - Thrown when remaining bytes don't conform to UTF-8 encoding rules.

Example:

<!-- verify -->
```cangjie
import std.io.ByteBuffer
import std.io.readString
import std.io.ContentFormatException

main(): Unit {
    let inputStream = ByteBuffer()

    /* Write data to input stream */
    let sourceData = "Hello, World!".toArray()
    inputStream.write(sourceData)

    /* Use readString to read all remaining content */
    try {
        let result = readString(inputStream)
        println("Read string: ${result}")
    } catch (e: ContentFormatException) {
        println("Error: ${e.message}")
    }

    /* Write an invalid UTF-8 string to input stream */
    let sourceDataError: Array<UInt8> = [0xC3, 0x28, 0x48, 0x65, 0x6C, 0x6C, 0x6F]
    inputStream.write(sourceDataError)

    /* Use readString to read all remaining content */
    try {
        let result = readString(inputStream)
        println("Read string: ${result}")
    } catch (e: ContentFormatException) {
        println("Error: ${e.message}")
    }
}
```

Execution Result:

```text
Read string: Hello, World!
Error: Invalid unicode scalar value.
```

## func readStringUnchecked\<T>(T) where T <: InputStream & Seekable

```cangjie
public unsafe func readStringUnchecked<T>(from: T): String where T <: InputStream & Seekable
```

Function: Reads all remaining content from the parameter and returns a string without validation.

Parameters:

- from: T - The object to read data from.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The resulting string read.

Example:

<!-- run -->
```cangjie
import std.io.ByteBuffer
import std.io.readStringUnchecked
import std.io.ContentFormatException

main(): Unit {
    let inputStream = ByteBuffer()

    /* Write data to input stream */
    let sourceData = "Hello, World!".toArray()
    inputStream.write(sourceData)

    /* Use readString to read all remaining content (normal output: Read string: Hello, World!) */
    unsafe {
        let result = readStringUnchecked(inputStream)
        println("Read string: ${result}")
    }

    /* Write an invalid UTF-8 string to input stream */
    let sourceDataError: Array<UInt8> = [0xC3, 0x28, 0x48, 0x65, 0x6C, 0x6C, 0x6F]
    inputStream.write(sourceDataError)

    /* Using readString on invalid UTF-8 will produce unexpected output characters */
    unsafe {
        let result = readStringUnchecked(inputStream)
        println("Read string: ${result}")
    }
}
```

## func readToEnd\<T>(T) where T <: InputStream & Seekable

```cangjie
public func readToEnd<T>(from: T): Array<Byte> where T <: InputStream & Seekable
```

Function: Retrieves all unread data from the parameter.

Parameters:

- from: T - The object to read data from.

Return Value:

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)> - A copy of the unread data.

Example:

<!-- verify -->
```cangjie
import std.io.ByteBuffer
import std.io.readToEnd

main(): Unit {
    let inputStream = ByteBuffer()

    /* Write data to input stream */
    let sourceData = "Hello, World!".toArray()
    inputStream.write(sourceData)

    /* Use readToEnd to read all remaining content */
    let data = readToEnd(inputStream)
    println("${String.fromUtf8(data)}")
}
```

Execution Result:

```text
Hello, World!
```