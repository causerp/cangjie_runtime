# Functions

## func digest\<T>(T, Array\<Byte>) where T <: Digest

```cangjie
public func digest<T>(algorithm: T, data: Array<Byte>): Array<Byte> where T <: Digest
```

Function: Provides a generic digest function that performs digest computation using the specified digest algorithm.

Parameters:

- algorithm: T - The specific digest algorithm.
- data: [Array](../../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../../core/core_package_api/core_package_types.md#type-byte)> - Data to be processed for digest computation.

Return Value:

- [Array](../../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../../core/core_package_api/core_package_types.md#type-byte)> - The result of digest computation.

Example:

<!-- verify -->
```cangjie
import std.crypto.digest.*

main() {
    let data: Array<Byte> = [1, 2, 3, 4, 5]
    let mydigest = MyDigest()
    let digestBytes = digest<MyDigest>(mydigest, data)
    println(digestBytes)
}

// Custom Digest
class MyDigest <: Digest {
    public prop size: Int64 {
        get() { 0 }
    }
    public prop blockSize: Int64 {
        get() { 0 }
    }
    public prop algorithm: String {
        get() { "" }
    }
    public func write(buffer: Array<Byte>): Unit {
        println("buffer = ${buffer}")
    }
    public func finish(to!: Array<Byte>): Unit {
        println("to = ${to}")
    }
    public func finish(): Array<Byte> {
        [3, 2, 1]
    }
    public func reset(): Unit {}
}
```

Execution Result:

```text
buffer = [1, 2, 3, 4, 5]
[3, 2, 1]
```

## func digest\<T>(T, String) where T <: Digest <sup>(deprecated)</sup>

```cangjie
public func digest<T>(algorithm: T, data: String): Array<Byte> where T <: Digest
```

Function: Provides a generic digest function that performs digest computation using the specified digest algorithm.

> **Note:**
>
> This will be deprecated in future versions. Use [digest\<T>(T, Array\<Byte>) where T <: Digest](./digest_package_funcs.md#func-digesttt-arraybyte-where-t--digest) instead.

Parameters:

- algorithm: T - The specific digest algorithm.
- data: [String](../../../core/core_package_api/core_package_structs.md#struct-string) - Data to be processed for digest computation.

Return Value:

- [Array](../../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../../core/core_package_api/core_package_types.md#type-byte)> - The result of digest computation.

## func digest\<T>(T, InputStream) where T <: Digest

```cangjie
public func digest<T>(algorithm: T, input: InputStream): Array<Byte> where T <: Digest
```

Function: Provides a generic digest function that performs digest computation on data from an InputStream using the specified digest algorithm.

Parameters:

- algorithm: T - The specific digest algorithm.
- input: [InputStream](../../../io/io_package_api/io_package_interfaces.md#interface-inputstream) - InputStream containing data to be processed for digest computation.

Return Value:

- [Array](../../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../../core/core_package_api/core_package_types.md#type-byte)> - The result of digest computation.

Example:

<!-- verify -->

```cangjie
import std.crypto.digest.*
import std.io.*

main() {
    /* Convert original byte array data into a BufferedInputStream */
    let data: Array<Byte> = [1, 2, 3, 4, 5]
    let byteBuffer = ByteBuffer(data)
    let bufferedInputStream = BufferedInputStream(byteBuffer)
    let mydigest = MyDigest()
    let digestBytes = digest<MyDigest>(mydigest, bufferedInputStream)
    println(digestBytes)
}

// Custom Digest
class MyDigest <: Digest {
    public prop size: Int64 {
        get() { 0 }
    }
    public prop blockSize: Int64 {
        get() { 2 }
    }
    public prop algorithm: String {
        get() { "" }
    }
    public func write(buffer: Array<Byte>): Unit {
        println("buffer = ${buffer}")
    }
    public func finish(to!: Array<Byte>): Unit {
        println("to = ${to}")
    }
    public func finish(): Array<Byte> {
        [3, 2, 1]
    }
    public func reset(): Unit {}
}
```

Execution Result:

```text
buffer = [1, 2]
buffer = [3, 4]
buffer = [5]
[3, 2, 1]
```