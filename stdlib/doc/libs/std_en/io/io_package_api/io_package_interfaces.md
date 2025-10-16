# Interface

## interface IOStream

```cangjie
public interface IOStream <: InputStream & OutputStream {}
```

Function: Input/output stream interface.

Parent types:

- [InputStream](#interface-inputstream)
- [OutputStream](#interface-outputstream)

## interface InputStream

```cangjie
public interface InputStream {
    func read(buffer: Array<Byte>): Int64
}
```

Function: Input stream interface.

### func read(Array\<Byte>)

```cangjie
func read(buffer: Array<Byte>): Int64
```

Function: Reads data from the input stream into `buffer`.

Parameters:

- buffer: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)> - Buffer for storing data read from the input stream.

Return value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Number of bytes read.

## interface OutputStream

```cangjie
public interface OutputStream {
    func write(buffer: Array<Byte>): Unit
    func flush(): Unit
}
```

Function: Output stream interface.

### func flush()

```cangjie
func flush(): Unit
```

Function: Flushes the buffer. The default implementation of this function is empty.

### func write(Array\<Byte>)

```cangjie
func write(buffer: Array<Byte>): Unit
```

Function: Writes data from `buffer` to the output stream.

Parameters:

- buffer: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)> - Buffer containing data to be written to the output stream.

## interface Seekable

```cangjie
public interface Seekable {
    prop length: Int64
    prop position: Int64
    prop remainLength: Int64
    func seek(sp: SeekPosition): Int64
}
```

Function: Cursor positioning interface.

### prop length

```cangjie
prop length: Int64
```

Function: Returns the total amount of data in the current stream (in bytes).

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### prop position

```cangjie
prop position: Int64
```

Function: Returns the current cursor position.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### prop remainLength

```cangjie
prop remainLength: Int64
```

Function: Returns the amount of unread data in the current stream (in bytes).

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### func seek(SeekPosition)

```cangjie
func seek(sp: SeekPosition): Int64
```

Function: Moves the cursor to the specified position.

Parameters:

- sp: [SeekPosition](io_package_enums.md#enum-seekposition) - Specifies the target position after cursor movement.

Return value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Returns the offset (in bytes) from the start of the stream data to the new position.