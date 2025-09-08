# Interfaces

## interface BigEndianOrder\<T>

```cangjie
public interface BigEndianOrder<T> {
    func writeBigEndian(buffer: Array<UInt8>): Int64
    static func readBigEndian(buffer: Array<UInt8>): T
}
```

Function: Interface for big-endian byte sequence conversion.

### static func readBigEndian(Array\<UInt8>)

```cangjie
static func readBigEndian(buffer: Array<UInt8>): T
```

Function: Reads a value of type T from a byte array in big-endian order.

Parameters:

- buffer: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)> - Buffer containing the data to be read.

Return value:

- T - The value of type T.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the buffer is too small to read a value of type T.

### func writeBigEndian(Array\<UInt8>)

```cangjie
func writeBigEndian(buffer: Array<UInt8>): Int64
```

Function: Writes a value of type T to a byte array in big-endian order.

Parameters:

- buffer: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)> - Buffer to store the data to be written.

Return value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The number of bytes written.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the buffer is too small to store a value of type T.

### extend Bool <: BigEndianOrder\<Bool>

```cangjie
extend Bool <: BigEndianOrder<Bool>
```

Function: Extends [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) with the [BigEndianOrder](binary_package_interfaces.md#interface-bigendianordert) interface to enable conversion between [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) values and big-endian byte sequences.

Parent type:

- [BigEndianOrder](#interface-bigendianordert)\<[Bool](../../core/core_package_api/core_package_intrinsics.md#bool)>

#### static func readBigEndian(Array\<UInt8>)

```cangjie
public static func readBigEndian(buffer: Array<UInt8>): Bool
```

Function: Reads a [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) value from a byte array in big-endian order.

Parameters:

- buffer: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)> - Buffer containing the data to be read.

Return value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) value.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the buffer is too small to read a [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) value.

Example:

<!-- verify -->
```cangjie
import std.binary.*

main() {
    let buffer: Array<UInt8> = [0x1]
    let n = Bool.readBigEndian(buffer)
    println(n)
}
```

Output:

```text
true
```

#### func writeBigEndian(Array\<UInt8>)

```cangjie
public func writeBigEndian(buffer: Array<UInt8>): Int64
```

Function: Writes a [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) value to a byte array in big-endian order.

Parameters:

- buffer: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)> - Buffer to store the data to be written.

Return value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The number of bytes written.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the buffer is too small to store a [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) value.

Example:

<!-- verify -->
```cangjie
import std.binary.*

main() {
    let buffer = Array<UInt8>(8, repeat: 0)
    let n = true.writeBigEndian(buffer)
    println(n == 1)
    println(buffer[0] == 0x01u8)
}
```

Output:

```text
true
true
```

### extend Float16 <: BigEndianOrder\<Float16>

```cangjie
extend Float16 <: BigEndianOrder<Float16>
```

Function: Extends [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) with the [BigEndianOrder](binary_package_interfaces.md#interface-bigendianordert) interface to enable conversion between [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) values and big-endian byte sequences.

Parent type:

- [BigEndianOrder](#interface-bigendianordert)\<[Float16](../../core/core_package_api/core_package_intrinsics.md#float16)>

#### static func readBigEndian(Array\<UInt8>)

```cangjie
public static func readBigEndian(buffer: Array<UInt8>): Float16
```

Function: Reads a [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) value from a byte array in big-endian order.

Parameters:

- buffer: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)> - Buffer containing the data to be read.

Return value:

- [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) - The [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) value.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the buffer is too small to read a [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) value.

Example:

<!-- verify -->
```cangjie
import std.binary.*

main() {
    /* IEEE 754 representation of 12.5 is 0x4A40 */
    let buffer: Array<UInt8> = [0x4A, 0x40]
    let n = Float16.readBigEndian(buffer)
    println(n == 12.5)
}
```

Output:

```text
true
```

#### func writeBigEndian(Array\<UInt8>)

```cangjie
public func writeBigEndian(buffer: Array<UInt8>): Int64
```

Function: Writes a [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) value to a byte array in big-endian order.

Parameters:

- buffer: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)> - Buffer to store the data to be written.

Return value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The number of bytes written.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the buffer is too small to store a [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) value.

Example:

<!-- verify -->
```cangjie
import std.binary.*

main() {
    let buffer = Array<UInt8>(8, repeat: 0)
    let len = 12.5f16.writeBigEndian(buffer)
    println(len)

    /* 0x4A in decimal is 74, 0x40 in decimal is 64 */
    println(buffer[0..len])
}
```

Output:

```text
2
[74, 64]
```

### extend Float32 <: BigEndianOrder\<Float32>

```cangjie
extend Float32 <: BigEndianOrder<Float32>
```

Function: Extends [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) with the [BigEndianOrder](binary_package_interfaces.md#interface-bigendianordert) interface to enable conversion between [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) values and big-endian byte sequences.

Parent type:

- [BigEndianOrder](#interface-bigendianordert)\<[Float32](../../core/core_package_api/core_package_intrinsics.md#float32)>

#### static func readBigEndian(Array\<UInt8>)

```cangjie
public static func readBigEndian(buffer: Array<UInt8>): Float32
```

Function: Reads a [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) value from a byte array in big-endian order.

Parameters:

- buffer: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)> - Buffer containing the data to be read.

Return value:

- [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) - The [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) value.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the buffer is too small to read a [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) value.

Example:

<!-- verify -->
```cangjie
import std.binary.*

main() {
    let buffer: Array<UInt8> = [0x41, 0x48, 0x00, 0x00]
    let n = Float32.readBigEndian(buffer)
    println(n)
}
```

Output:

```text
12.500000
```

#### func writeBigEndian(Array\<UInt8>)

```cangjie
public func writeBigEndian(buffer: Array<UInt8>): Int64
```

Function: Writes a [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) value to a byte array in big-endian order.

Parameters:

- buffer: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)> - Buffer to store the data to be written.

Return value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The number of bytes written.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the buffer is too small to store a [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) value.

Example:

<!-- verify -->
```cangjie
import std.binary.*

main() {
    let buffer = Array<UInt8>(8, repeat: 0)
    let len = 12.5f32.writeBigEndian(buffer)
    println(len)

    /* IEEE 754 single-precision floating-point representation of 12.5 is 0x4148, where 0x41 in decimal is 65 and 0x48 is 72 */
    println(buffer[0..len])
}
```

Output:

```text
4
[65, 72, 0, 0]
```

### extend Float64 <: BigEndianOrder\<Float64>

```cangjie
extend Float64 <: BigEndianOrder<Float64>
```

Function: Extends [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) with the [BigEndianOrder](binary_package_interfaces.md#interface-bigendianordert) interface to enable conversion between [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) values and big-endian byte sequences.

Parent type:

- [BigEndianOrder](#interface-bigendianordert)\<[Float64](../../core/core_package_api/core_package_intrinsics.md#float64)>

#### static func readBigEndian(Array\<UInt8>)

```cangjie
public static func readBigEndian(buffer: Array<UInt8>): Float64
```

Function: Reads a [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) value from a byte array in big-endian order.

Parameters:

- buffer: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)> - Buffer containing the data to be read.

Return value:

- [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - The [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) value.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the buffer is too small to read a [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) value.

Example:

<!-- run -->
```cangjie
import std.binary.*
import std.unittest.*
import std.unittest.testmacro.*

main() {
    let buffer: Array<UInt8> = [0x40, 0x29, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]
    let n = Float64.readBigEndian(buffer)
    @Assert(n, 12.5)
}
```

#### func writeBigEndian(Array\<UInt8>)

```cangjie
public func writeBigEndian(buffer: Array<UInt8>): Int64
```

Function: Writes a [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) value to a byte array in big-endian order.

Parameters:

- buffer: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)> - Buffer to store the data to be written.

Return value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The number of bytes written.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the buffer is too small to store a [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) value.

Example:

<!-- run -->
```cangjie
import std.binary.*
import std.unittest.*
import std.unittest.testmacro.*

main() {
    let buffer = Array<UInt8>(8, repeat: 0)
    let n = 12.5f64.writeBigEndian(buffer)
    @Assert(n, 8)
    @Assert(buffer[..n] == [0x40, 0x29, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00])
}
```### extend Int16 <: BigEndianOrder\<Int16>

```cangjie
extend Int16 <: BigEndianOrder<Int16>
```

Function: Extends the [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) type with the [BigEndianOrder](binary_package_interfaces.md#interface-bigendianordert) interface to enable conversion between [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) values and big-endian byte sequences.

Parent Type:

- [BigEndianOrder](#interface-bigendianordert)\<[Int16](../../core/core_package_api/core_package_intrinsics.md#int16)>

#### static func readBigEndian(Array\<UInt8>)

```cangjie
public static func readBigEndian(buffer: Array<UInt8>): Int16
```

Function: Reads an [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) value from a byte array in big-endian order.

Parameters:

- buffer: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)> - The buffer containing the data to be read.

Return Value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) value.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the buffer is too small to read an [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) value.

Example:

<!-- run -->
```cangjie
import std.binary.*
import std.unittest.*
import std.unittest.testmacro.*

main() {
    let buffer: Array<UInt8> = [0x12, 0x34]
    let n = Int16.readBigEndian(buffer)
    @Assert(n, 0x1234)
}
```

#### func writeBigEndian(Array\<UInt8>)

```cangjie
public func writeBigEndian(buffer: Array<UInt8>): Int64
```

Function: Writes an [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) value to a byte array in big-endian order.

Parameters:

- buffer: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)> - The buffer to store the written data.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The number of bytes written.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the buffer is too small to store an [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) value.

Example:

<!-- run -->
```cangjie
import std.binary.*
import std.unittest.*
import std.unittest.testmacro.*

main() {
    let buffer = Array<UInt8>(8, repeat: 0)
    let n = 0x1234i16.writeBigEndian(buffer)
    @Assert(n, 2)
    @Assert(buffer[..n] == [0x12, 0x34])
}
```

### extend Int32 <: BigEndianOrder\<Int32>

```cangjie
extend Int32 <: BigEndianOrder<Int32>
```

Function: Extends the [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) type with the [BigEndianOrder](binary_package_interfaces.md#interface-b极速赛车开奖结果查询官网## interface LittleEndianOrder\<T>

```cangjie
public interface LittleEndianOrder<T> {
    func writeLittleEndian(buffer: Array<UInt8>): Int64
    static func readLittleEndian(buffer: Array<UInt8>): T
}
```

Function: Interface for little-endian byte sequence conversion.

### static func readLittleEndian(Array\<UInt8>)

```cangjie
static func readLittleEndian(buffer: Array<UInt8>): T
```

Function: Reads a value of type T from a byte array in little-endian order.

Parameters:

- buffer: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)> - Buffer containing the data to be read.

Return value:

- T - The value of type T.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the buffer is too small to read a value of type T.

### func writeLittleEndian(Array\<UInt8>)

```cangjie
func writeLittleEndian(buffer: Array<UInt8>): Int64
```

Function: Writes a value of type T to a byte array in little-endian order.

Parameters:

- buffer: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)> - Buffer for storing the data to be written.

Return value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Number of bytes written.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the buffer is too small to store a value of type T.

### extend Bool <: LittleEndianOrder\<Bool>

```cangjie
extend Bool <: LittleEndianOrder<Bool>
```

Function: Extends [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) with the [LittleEndianOrder](binary_package_interfaces.md#interface-littleendianordert) interface to enable conversion between [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) values and little-endian byte sequences.

Parent type:

- [LittleEndianOrder](#interface-littleendianordert)\<[Bool](../../core/core_package_api/core_package_intrinsics.md#bool)>

#### static func readLittleEndian(Array\<UInt8>)

```cangjie
public static func readLittleEndian(buffer: Array<UInt8>): Bool
```

Function: Reads a [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) value from a byte array in little-endian order.

Parameters:

- buffer: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)> - Buffer containing the data to be read.

Return value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) value.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the buffer is too small to read a [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) value.

Example:

<!-- run -->
```cangjie
import std.binary.*
import std.unittest.*
import std.unittest.testmacro.*

main() {
    let buffer: Array<UInt8> = [0x1]
    let n = Bool.readLittleEndian(buffer)
    @Assert(n, true)
}
```

#### func writeLittleEndian(Array\<UInt8>)

```cangjie
public func writeLittleEndian(buffer: Array<UInt8>): Int64
```

Function: Writes a [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) value to a byte array in little-endian order.

Parameters:

- buffer: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)> - Buffer for storing the data to be written.

Return value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Number of bytes written.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the buffer is too small to store a [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) value.

Example:

<!-- run -->
```cangjie
import std.binary.*
import std.unittest.*
import std.unittest.testmacro.*

main() {
    let buffer = Array<UInt8>(8, repeat: 0)
    let n = true.writeLittleEndian(buffer)
    @Assert(n, 1)
    @Assert(buffer[..n] == [0x01])
}
```

### extend Float16 <: LittleEndianOrder\<Float16>

```cangjie
extend Float16 <: LittleEndianOrder<Float16>
```

Function: Extends [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) with the [LittleEndianOrder](binary_package_interfaces.md#interface-littleendianordert) interface to enable conversion between [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) values and little-endian byte sequences.

Parent type:

- [LittleEndianOrder](#interface-littleendianordert)\<[Float16](../../core/core_package_api/core_package_intrinsics.md#float16)>

#### static func readLittleEndian(Array\<UInt8>)

```cangjie
public static func readLittleEndian(buffer: Array<UInt8>): Float16
```

Function: Reads a [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) value from a byte array in little-endian order.

Parameters:

- buffer: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)> - Buffer containing the data to be read.

Return value:

- [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) - The [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) value.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the buffer is too small to read a [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) value.

Example:

<!-- run -->
```cangjie
import std.binary.*
import std.unittest.*
import std.unittest.testmacro.*

main() {
    let buffer: Array极抱歉，我还没有学会回答这个问题。如果你有其他问题，我非常乐意为你提供帮助。### extend Int32 <: LittleEndianOrder\<Int32>

```cangjie
extend Int32 <: LittleEndianOrder<Int32>
```

Function: Extends the [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) type with the [LittleEndianOrder](binary_package_interfaces.md#interface-littleendianordert) interface to enable conversion between [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) values and little-endian byte sequences.

Parent Type:

- [LittleEndianOrder](#interface-littleendianordert)\<[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)>

#### static func readLittleEndian(Array\<UInt8>)

```cangjie
public static func readLittleEndian(buffer: Array<UInt8>): Int32
```

Function: Reads an [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) value from a byte array in little-endian order.

Parameters:

- buffer: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)> - The buffer containing the data to be read.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) value.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the buffer is too small to read an [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) value.

Example:

<!-- run -->
```cangjie
import std.binary.*
import std.unittest.*
import std.unittest.testmacro.*

main() {
    let buffer: Array<UInt8> = [0x78, 0x56, 0x34, 0x12]
    let n = Int32.readLittleEndian(buffer)
    @Assert(n, 0x12345678)
}
```

#### func writeLittleEndian(Array\<UInt8>)

```cangjie
public func writeLittleEndian(buffer: Array<UInt8>): Int64
```

Function: Writes an [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) value to a byte array in little-endian order.

Parameters:

- buffer: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)> - The buffer to store the written data.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The number of bytes written.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the buffer is too small to store an [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) value.

Example:

<!-- run -->
```cangjie
import std.binary.*
import std.unittest.*
import std.unittest.testmacro.*

main() {
    let buffer = Array<UInt8>(8, repeat: 0)
    let n = 0x12345678i32.writeLittleEndian(buffer)
    @Assert(n, 4)
    @Assert(buffer[..n] == [0x78, 0x56, 0x34, 0x12])
}
```

### extend Int64 <: LittleEndianOrder\<Int64>

```cangjie
extend Int64 <: LittleEndianOrder<Int64>
```

Function: Extends the [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) type with the [LittleEndianOrder](binary_package_interfaces.md#interface-littleendianordert) interface to enable conversion between [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) values and little-endian byte sequences.

Parent Type:

- [LittleEndianOrder](#interface-littleendianordert)\<[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)>

#### static func readLittleEndian(Array\<UInt8>)

```cangjie
public static func readLittleEndian(buffer: Array极抱歉，我还没有学会回答这个问题。如果你有其他问题，我非常乐意为你提供帮助。## interface SwapEndianOrder\<T>

```cangjie
public interface SwapEndianOrder<T> {
    func swapBytes(): T
}
```

Function: Interface for reversing byte order.

### func swapBytes()

```cangjie
func swapBytes(): T
```

Function: Reverses the byte order of a value of type T.

Return value:

- T - The value of type T.

### extend Int16 <: SwapEndianOrder\<Int16>

```cangjie
extend Int16 <: SwapEndianOrder<Int16>
```

Function: Extends the [SwapEndianOrder](binary_package_interfaces.md#interface-swapendianordert) interface for [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) to implement byte order reversal for [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) values.

Parent type:

- [SwapEndianOrder](#interface-swapendianordert)\<[Int16](../../core/core_package_api/core_package_intrinsics.md#int16)>

#### func swapBytes()

```cangjie
public func swapBytes(): Int16
```

Function: Reverses the byte order of an [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) value.

Return value:

- [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) - The [Int16](../../core/core_package_api/core_package_intrinsics.md#int16) value.

Example:

<!-- run -->
```cangjie
import std.binary.*
import std.unittest.*
import std.unittest.testmacro.*

main() {
    let n = 0x1234i16
    let m = n.swapBytes()
    @Assert(m, 0x3412)
}
```

### extend Int32 <: SwapEndianOrder\<Int32>

```cangjie
extend Int32 <: SwapEndianOrder<Int32>
```

Function: Extends the [SwapEndianOrder](binary_package_interfaces.md#interface-swapendianordert) interface for [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) to implement byte order reversal for [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) values.

Parent type:

- [SwapEndianOrder](#interface-swapendianordert)\<[Int32](../../core/core_package_api/core_package_intrinsics.md#int32)>

#### func swapBytes()

```cangjie
public func swapBytes(): Int32
```

Function: Reverses the byte order of an [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) value.

Return value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) value.

Example:

<!-- run -->
```cangjie
import std.binary.*
import std.unittest.*
import std.unittest.testmacro.*

main() {
    let n = 0x12345678i32
    let m = n.swapBytes()
    @Assert(m, 0x78563412)
}
```

### extend Int64 <: SwapEndianOrder\<Int64>

```cangjie
extend Int64 <: SwapEndianOrder<Int64>
```

Function: Extends the [SwapEndianOrder](binary_package_interfaces.md#interface-swapendianordert) interface for [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) to implement byte order reversal for [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) values.

Parent type:

- [SwapEndianOrder](#interface-swapendianordert)\<[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)>

#### func swapBytes()

```cangjie
public func swapBytes(): Int64
```

Function: Reverses the byte order of an [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) value.

Return value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) value.

Example:

<!-- run -->
```cangjie
import std.binary.*
import std.unittest.*
import std.unittest.testmacro.*

main() {
    let n = 0x1234567890123456i64
    let m = n.swapBytes()
    @Assert(m, 0x5634129078563412)
}
```

### extend Int8 <: SwapEndianOrder\<Int8>

```cangjie
extend Int8 <: SwapEndianOrder<Int8>
```

Function: Extends the [SwapEndianOrder](binary_package_interfaces.md#interface-swapendianordert) interface for [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) to implement byte order reversal for [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) values.

Parent type:

- [SwapEndianOrder](#interface-swapendianordert)\<[Int8](../../core/core_package_api/core_package_intrinsics.md#int8)>

#### func swapBytes()

```cangjie
public func swapBytes(): Int8
```

Function: Reverses the byte order of an [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) value.

Return value:

- [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) - The [Int8](../../core/core_package_api/core_package_intrinsics.md#int8) value.

Example:

<!-- run -->
```cangjie
import std.binary.*
import std.unittest.*
import std.unittest.testmacro.*

main() {
    let n = 0x12i8
    let m = n.swapBytes()
    @Assert(m, 0x12)
}
```

### extend UInt16 <: SwapEndianOrder\<UInt16>

```cangjie
extend UInt16 <: SwapEndianOrder<UInt16>
```

Function: Extends the [SwapEndianOrder](binary_package_interfaces.md#interface-swapendianordert) interface for [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) to implement byte order reversal for [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) values.

Parent type:

- [SwapEndianOrder](#interface-swapendianordert)\<[UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16)>

#### func swapBytes()

```cangjie
public func swapBytes(): UInt16
```

Function: Reverses the byte order of a [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) value.

Return value:

- [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) - The [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16) value.

Example:

<!-- run -->
```cangjie
import std.binary.*
import std.unittest.*
import std.unittest.testmacro.*

main() {
    let n = 0x1234u16
    let m = n.swapBytes()
    @Assert(m, 0x3412)
}
```

### extend UInt32 <: SwapEndianOrder\<UInt32>

```cangjie
extend UInt32 <: SwapEndianOrder<UInt32>
```

Function: Extends the [SwapEndianOrder](binary_package_interfaces.md#interface-swapendianordert) interface for [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) to implement byte order reversal for [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) values.

Parent type:

- [SwapEndianOrder](#interface-swapendianordert)\<[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)>

#### func swapBytes()

```cangjie
public func swapBytes(): UInt32
```

Function: Reverses the byte order of a [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) value.

Return value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) value.

Example:

<!-- run -->
```cangjie
import std.binary.*
import std.unittest.*
import std.unittest.testmacro.*

main() {
    let n = 0x12345678u32
    let m = n.swapBytes()
    @Assert(m, 0x78563412)
}
```

### extend UInt64 <: SwapEndianOrder\<UInt64>

```cangjie
extend UInt64 <: SwapEndianOrder<UInt64>
```

Function: Extends the [SwapEndianOrder](binary_package_interfaces.md#interface-swapendianordert) interface for [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) to implement byte order reversal for [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) values.

Parent type:

- [SwapEndianOrder](#interface-swapendianordert)\<[UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64)>

#### func swapBytes()

```cangjie
public func swapBytes(): UInt64
```

Function: Reverses the byte order of a [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) value.

Return value:

- [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) - The [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64) value.

Example:

<!-- run -->
```cangjie
import std.binary.*
import std.unittest.*
import std.unittest.testmacro.*

main() {
    let n = 0x1234567890123456u64
    let m = n.swapBytes()
    @Assert(m, 0x5634129078563412)
}
```

### extend UInt8 <: SwapEndianOrder\<UInt8>

```cangjie
extend UInt8 <: SwapEndianOrder<UInt8>
```

Function: Extends the [SwapEndianOrder](binary_package_interfaces.md#interface-swapendianordert) interface for [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) to implement byte order reversal for [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) values.

Parent type:

- [SwapEndianOrder](#interface-swapendianordert)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)>

#### func swapBytes()

```cangjie
public func swapBytes(): UInt8
```

Function: Reverses the byte order of a [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) value.

Return value:

- [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) - The [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8) value.

Example:

<!-- run -->
```cangjie
import std.binary.*
import std.unittest.*
import std.unittest.testmacro.*

main() {
    let n = 0x12u8
    let m = n.swapBytes()
    @Assert(m, 0x12)
}
```