# Class

## class Directory

```cangjie
public class Directory {}
```

Functionality: Represents a directory in the file system, providing capabilities for creation, movement, copying, deletion, attribute querying, and directory traversal.

> **Note:**
>
> An illegal path refers to any of the following scenarios:
>
> - Path contains illegal characters such as spaces, tabs, line breaks, etc.
> - Path contains invalid characters such as special characters or control characters.
> - Path contains non-existent directories or files.
> - Path contains inaccessible directories or files due to insufficient permissions or being locked.

When inputting paths, avoid using illegal characters to ensure path validity for correct access to target files or directories.

### static func create(Path, Bool)

```cangjie
public static func create(path: Path, recursive!: Bool = false): Unit
```

Functionality: Creates a directory.

Specifies whether to create recursively. If recursive creation is required, it will create non-existent directories level by level in the path.

Parameters:

- path: [Path](fs_package_structs.md#struct-path) - The directory path to be created.
- recursive!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether to create directories recursively. true for recursive creation, false for non-recursive creation. Default is false.

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Throws an exception when the directory already exists, intermediate directories don't exist during non-recursive creation, insufficient permissions, or other reasons prevent directory creation.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception when the directory is empty, current directory, root directory, or contains null characters.

### static func create(String, Bool)

```cangjie
public static func create(path: String, recursive!: Bool = false): Unit
```

Functionality: Creates a directory.

Specifies whether to create recursively. If recursive creation is required, it will create non-existent directories level by level in the path.

Parameters:

- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The directory path to be created.
- recursive!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether to create directories recursively. true for recursive creation, false for non-recursive creation. Default is false.

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Throws an exception when the directory already exists, intermediate directories don't exist during non-recursive creation, insufficient permissions, or other reasons prevent directory creation.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception when the directory is empty, current directory, root directory, or contains null characters.

### static func createTemp(Path)

```cangjie
public static func createTemp(directoryPath: Path): Path
```

Functionality: Creates a temporary directory under the specified directory.

Parameters:

- directoryPath: [Path](fs_package_structs.md#struct-path) - Directory path in [Path](fs_package_structs.md#struct-path) format.

Return Value:

- [Path](./fs_package_structs.md#struct-path) - Path corresponding to the temporary directory.

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Throws an exception when the directory doesn't exist or creation fails for other reasons.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception when the directory is empty or contains null characters.

### static func createTemp(String)

```cangjie
public static func createTemp(directoryPath: String): Path
```

Functionality: Creates a temporary directory under the specified directory.

Parameters:

- directoryPath: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Directory path in string format.

Return Value:

- [Path](./fs_package_structs.md#struct-path) - Path corresponding to the temporary directory.

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Throws an exception when the directory doesn't exist or creation fails for other reasons.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception when the directory is empty or contains null characters.

### static func isEmpty(Path)

```cangjie
public static func isEmpty(path: Path): Bool
```

Functionality: Checks if the specified directory is empty.

Parameters:

- path: [Path](./fs_package_structs.md#struct-path) - Path corresponding to the directory to be checked for emptiness.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if the directory is empty, false otherwise.

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Throws an exception when the specified path doesn't exist, is not a directory, or system interface errors occur during checking.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception when the specified path is empty or contains null characters.

### static func isEmpty(String)

```cangjie
public static func isEmpty(path: String): Bool
```

Functionality: Checks if the specified directory is empty.

Parameters:

- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Path corresponding to the directory to be checked for emptiness.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if the directory is empty, false otherwise.

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Throws an exception when the specified path doesn't exist, is not a directory, or system interface errors occur during checking.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception when the specified path is empty or contains null characters.

### static func readFrom(Path)

```cangjie
public static func readFrom(path: Path): Array<FileInfo>
```

Functionality: Retrieves the list of child items in the current directory.

The order of child items in the array depends on the system's file sorting.

Parameters:

- path: [Path](./fs_package_structs.md#struct-path) - Path corresponding to the directory whose children are to be read.

Return Value:

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[FileInfo](fs_package_structs.md#struct-fileinfo)> - List of child items in the current directory.

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Throws an exception when the specified path doesn't exist, is not a directory, or fails to retrieve member information.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception when the specified path is empty or contains null characters.

### static func readFrom(String)

```cangjie
public static func readFrom(path: String): Array<FileInfo>
```

Functionality: Retrieves the list of child items in the current directory.

The order of child items in the array depends on the system's file sorting.

Parameters:

- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Path corresponding to the directory whose children are to be read.

Return Value:

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[FileInfo](./fs_package_structs.md#struct-fileinfo)> - List of child items in the current directory.

Exceptions:

- [FSException](./fs_package_exceptions.md#class-fsexception) - Throws an exception when the specified path doesn't exist, is not a directory, or fails to retrieve member information.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception when the specified path is empty or contains null characters.

### static func walk(Path, (FileInfo)->Bool)

```cangjie
public static func walk(path: Path, f: (FileInfo)->Bool): Unit
```

Functionality: Traverses child items (non-recursively, excluding subdirectory items) under the directory corresponding to path, executing a callback function for each child item.

The walk function exits when traversal completes or the callback function f returns false. Traversal order depends on system file sorting.

Parameters:

- path: [Path](./fs_package_structs.md#struct-path) - Path corresponding to the directory to be traversed.
- f: ([FileInfo](./fs_package_structs.md#struct-fileinfo)) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Callback function executed for each child item. Input parameter is the child item's metadata. Return value indicates whether to continue traversal.

Exceptions:

- [FSException](./fs_package_exceptions.md#class-fsexception) - Throws an exception when the specified path doesn't exist, is not a directory, or fails to retrieve member information.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception when the specified path is empty or contains null characters.

### static func walk(String, (FileInfo)->Bool)

```cangjie
public static func walk(path: String, f: (FileInfo)->Bool): Unit
```

Functionality: Traverses child items (non-recursively, excluding subdirectory items) under the directory corresponding to path, executing a callback function for each child item.

The walk function exits when traversal completes or the callback function f returns false. Traversal order depends on system file sorting.

Parameters:

- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Path corresponding to the directory to be traversed.
- f: ([FileInfo](./fs_package_structs.md#struct-fileinfo)) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Callback function executed for each child item. Input parameter is the child item's metadata. Return value indicates whether to continue traversal.

Exceptions:

- [FSException](./fs_package_exceptions.md#class-fsexception) - Throws an exception when the specified path doesn't exist, is not a directory, or fails to retrieve member information.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception when the specified path is empty or contains null characters.

## class File

```cangjie
public class File <: Resource & IOStream & Seekable {
    public init(path: String, mode: OpenMode)
    public init(path: Path, mode: OpenMode)
}
```

Functionality: Provides functions for file operations including opening, creating, closing, moving, copying, deleting, stream-based read/write operations, attribute querying, and other functions.

> **Note:**
>
> An illegal path refers to any of the following scenarios:
>
> - Path contains illegal characters such as spaces, tabs, line breaks, etc.
> - Path contains invalid characters such as special characters or control characters.
> - Path contains non-existent directories or files.
> - Path contains inaccessible directories or files due to insufficient permissions or being locked.

When inputting paths, avoid using illegal characters to ensure path validity for correct access to target files or directories.

> **Warning:**
>
> Created [File](fs_package_classes.md#class-file) objects will open the corresponding file by default. When finished, promptly call the [close](fs_package_classes.md#func-close) function to close the file to prevent resource leaks.

Parent Types:

- [Resource](../../core/core_package_api/core_package_interfaces.md#interface-resource)
- [IOStream](../../io/io_package_api/io_package_interfaces.md#interface-iostream)
- [Seekable](../../io/io_package_api/io_package_interfaces.md#interface-seekable)

### prop fileDescriptor

```cangjie
public prop fileDescriptor: FileDescriptor
```

Functionality: Retrieves file descriptor information.

Type: [FileDescriptor](fs_package_structs.md#struct-filedescriptor)

### prop info

```cangjie
public prop info: FileInfo
```

Functionality: Retrieves file metadata information.

Type: [FileInfo](fs_package_structs.md#struct-fileinfo)

### prop length

```cangjie
public prop length: Int64
```

Functionality: Retrieves the number of data bytes from the file header to the file tail.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### init(Path, OpenMode)

```cangjie
public init(path: Path, mode: OpenMode)
```

Functionality: Creates a [File](fs_package_classes.md#class-file) object.The file path and opening mode (read/write permissions) must be specified. Both relative and absolute paths are supported.

Parameters:

- path: [Path](fs_package_structs.md#struct-path) - File path.
- mode: [OpenMode](fs_package_enums.md#enum-openmode) - File opening mode.

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown if attempting to open a non-existent file in read-only mode, parent directory doesn't exist, or other reasons prevent file opening.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if path is empty or contains null characters.

### init(String, OpenMode)

```cangjie
public init(path: String, mode: OpenMode)
```

Function: Creates a [File](fs_package_classes.md#class-file) object.

The file path and opening mode (read/write permissions) must be specified. Both relative and absolute paths are supported.

Parameters:

- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - File path string.
- mode: [OpenMode](fs_package_enums.md#enum-openmode) - File opening mode.

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown if attempting to open a non-existent file in read-only mode, parent directory doesn't exist, or other reasons prevent file opening.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if path is an empty string or contains null characters.

### static func appendTo(Path, Array\<Byte>)

```cangjie
public static func appendTo(path: Path, buffer: Array<Byte>): Unit
```

Function: Opens the specified file and appends the buffer contents. Creates the file if it doesn't exist.

Parameters:

- path: [Path](fs_package_structs.md#struct-path) - File path.
- buffer: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)> - Bytes to be written.

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown if file opening or writing fails.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if file path is empty or contains null characters.

### static func appendTo(String, Array\<Byte>)

```cangjie
public static func appendTo(path: String, buffer: Array<Byte>): Unit
```

Function: Opens the specified file and appends the buffer contents. Creates the file if it doesn't exist.

Parameters:

- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - File path string.
- buffer: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)> - Bytes to be written.

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown if file opening or writing fails.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if file path is empty or contains null characters.

### static func create(Path)

```cangjie
public static func create(path: Path): File
```

Function: Creates a file at the specified path and returns a write-only [File](#class-file) instance.

Parameters:

- path: [Path](fs_package_structs.md#struct-path) - File path.

Returns:

- [File](fs_package_classes.md#class-file) - [File](fs_package_classes.md#class-file) instance.

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown if parent directory doesn't exist or file already exists.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if file path is empty or contains null characters.

### static func create(String)

```cangjie
public static func create(path: String): File
```

Function: Creates a file at the specified path and returns a write-only [File](#class-file) instance.

Parameters:

- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - File path string.

Returns:

- [File](fs_package_classes.md#class-file) - [File](fs_package_classes.md#class-file) instance.

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown if parent directory doesn't exist or file already exists.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if file path is an empty string or contains null characters.

### static func createTemp(Path)

```cangjie
public static func createTemp(directoryPath: Path): File
```

Function: Creates a temporary file in the specified directory.

The created file follows the naming pattern tmpFileXXXXXX. Unused temporary files should be manually deleted.

Parameters:

- directoryPath: [Path](fs_package_structs.md#struct-path) - Directory path.

Returns:

- [File](fs_package_classes.md#class-file) - Temporary file [File](fs_package_classes.md#class-file) instance.

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown if file creation fails or path doesn't exist.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if file path is empty or contains null characters.

### static func createTemp(String)

```cangjie
public static func createTemp(directoryPath: String): File
```

Function: Creates a temporary file in the specified directory.

The created file follows the naming pattern tmpFileXXXXXX. Unused temporary files should be manually deleted.

Parameters:

- directoryPath: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Directory path string.

Returns:

- [File](fs_package_classes.md#class-file) - Temporary file [File](fs_package_classes.md#class-file) instance.

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown if file creation fails or path doesn't exist.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if file path is an empty string or contains null characters.

### static func readFrom(Path)

```cangjie
public static func readFrom(path: Path): Array<Byte>
```

Function: Reads the entire content of the specified file and returns it as a byte array.

Parameters:

- path: [Path](fs_package_structs.md#struct-path) - File path.

Returns:

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)> - File content as a byte array.

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown if file path is empty, file is unreadable, or reading fails.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if file path contains null characters.

### static func readFrom(String)

```cangjie
public static func readFrom(path: String): Array<Byte>
```

Function: Reads the entire content of the specified file and returns it as a byte array.

Parameters:

- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - File path string.

Returns:

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)> - File content as a byte array.

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown if reading fails, closing fails, path is empty, or file is unreadable.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if file path contains null characters.

### static func writeTo(Path, Array\<Byte>)

```cangjie
public static func writeTo(path: Path, buffer: Array<Byte>): Unit
```

Function: Opens the specified file and overwrites its content with the buffer. Truncates existing files to zero bytes. Creates the file if it doesn't exist.

Parameters:

- path: [Path](fs_package_structs.md#struct-path) - File path.
- buffer: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)> - Bytes to be written.

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown if file opening or writing fails.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if file path is empty or contains null characters.

### static func writeTo(String, Array\<Byte>)

```cangjie
public static func writeTo(path: String, buffer: Array<Byte>): Unit
```

Function: Opens the specified file and overwrites its content with the buffer. Truncates existing files to zero bytes. Creates the file if it doesn't exist.

Parameters:

- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - File path string.
- buffer: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)> - Bytes to be written.

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown if file opening or writing fails.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if file path is an empty string or contains null characters.

### func canRead()

```cangjie
public func canRead(): Bool
```

Function: Determines whether the current [File](fs_package_classes.md#class-file) object is readable.

The return value is determined by the openMode used to create the file object. Returns false after the file object is closed.

Returns:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if readable, false if unreadable or file object is closed.

### func canWrite()

```cangjie
public func canWrite(): Bool
```

Function: Determines whether the current [File](fs_package_classes.md#class-file) object is writable.

The return value is determined by the openMode used to create the file object. Returns false after the file object is closed.

Returns:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if writable, false if unwritable or file object is closed.

### func close()

```cangjie
public func close(): Unit
```

Function: Closes the current [File](fs_package_classes.md#class-file) object.

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown if closing fails.

### func flush()

```cangjie
public func flush(): Unit
```

Function: Flushes buffer data to the stream. This function has no actual effect since [File](fs_package_classes.md#class-file) doesn't use buffers.

### func isClosed()

```cangjie
public func isClosed(): Bool
```

Function: Determines whether the current [File](fs_package_classes.md#class-file) object is closed.

Returns:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if closed, false if open.

### func read(Array\<Byte>)

```cangjie
public func read(buffer: Array<Byte>): Int64
```
Function: Reads data from a file into a buffer.

Parameters:

- buffer: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)> - The buffer to store the read data.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Returns the number of bytes read if successful; returns 0 if the file has been completely read.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if the buffer is empty.
- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown if the read operation fails, the file is closed, or the file is not readable.

### func seek(SeekPosition)

```cangjie
public func seek(sp: SeekPosition): Int64
```

Function: Moves the cursor to the specified position.

The specified position cannot be before the file header. The position can exceed the end of the file, but the maximum offset from the specified position to the file header must not exceed the maximum value allowed by the current file system. This maximum value is close to the maximum file size allowed by the current file system, typically the maximum file size minus 4096 bytes.

Parameters:

- sp: [SeekPosition](../../io/io_package_api/io_package_enums.md#enum-seekposition) - The target position after the cursor jump.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Returns the offset (in bytes) from the file header to the new cursor position.

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown if the specified position does not meet the above conditions or if the file cannot be seeked.

### func setLength(Int64)

```cangjie
public func setLength(length: Int64): Unit
```

Function: Truncates the current file to the specified length. If the length is greater than the current file length, the file is padded with zeros until the target length is reached. This method does not change the file cursor position.

Parameters:

- length: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The target truncation length.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if the specified length is negative.
- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown if the file truncation operation fails.

### func write(Array\<Byte>)

```cangjie
public func write(buffer: Array<Byte>): Unit
```

Function: Writes data from the buffer to the file.

Parameters:

- buffer: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)> - The buffer containing the data to be written. If the buffer is empty, the method returns immediately.

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown if the write operation fails, only partial data is written, the file is closed, or the file is not writable.

## class HardLink

```cangjie
public class HardLink
```

Function: Provides interfaces for handling file system hard links.

### static func create(Path, Path)

```cangjie
public static func create(link: Path, to!: Path): Unit
```

Function: Creates a new hard link to an existing path. If the new path already exists, it will not be overwritten.

Parameters:

- link: [Path](fs_package_structs.md#struct-path) - The name of the new path.
- to!: [Path](fs_package_structs.md#struct-path) - The name of the existing path.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if the path is empty or contains null characters.
- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown if the hard link creation fails.

### static func create(String, String)

```cangjie
public static func create(link: String, to!: String): Unit
```

Function: Creates a new hard link to an existing path. If the new path already exists, it will not be overwritten.

Parameters:

- link: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The name of the new path.
- to!: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The name of the existing path.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if the path is empty or contains null characters.
- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown if the hard link creation fails.

## class SymbolicLink

```cangjie
public class SymbolicLink
```

Function: Provides interfaces for handling file system symbolic links.

### static func create(Path, Path)

```cangjie
public static func create(link: Path, to!: Path): Unit
```

Function: Creates a new symbolic link to an existing path.

> **Note:**
>
> On Windows, creating a symbolic link to a non-existent target will create a file symbolic link. If the target path is later created as a directory, the symbolic link will not work.

Parameters:

- link: [Path](fs_package_structs.md#struct-path) - The symbolic link to be created.
- to!: [Path](fs_package_structs.md#struct-path) - The target path of the symbolic link.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if the path is empty or contains null characters.
- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown if the symbolic link creation fails.

### static func create(String, String)

```cangjie
public static func create(link: String, to!: String): Unit
```

Function: Creates a new symbolic link to an existing path.

> **Note:**
>
> On Windows, creating a symbolic link to a non-existent target will create a file symbolic link. If the target path is later created as a directory, the symbolic link will not work.

Parameters:

- link: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The symbolic link to be created.
- to!: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The target path of the symbolic link.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if the path is empty or contains null characters.
- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown if the symbolic link creation fails.

### static func readFrom(Path, Bool)

```cangjie
public static func readFrom(path: Path, recursive!: Bool = false): Path
```

Function: Retrieves the target of the specified symbolic link. When 'recursive' is set to 'true', it follows the link to the final target and returns the full path of the target. When 'recursive' is set to 'false', it reads the current target link and returns it.

Parameters:

- path: [Path](fs_package_structs.md#struct-path) - The address of the symbolic link.
- recursive!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether to recursively read the target address. Default is 'false'.

Return Value:

- [Path](fs_package_structs.md#struct-path) - The target address of the symbolic link.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if the path is empty or contains null characters.
- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown if the symbolic link read operation fails.

### static func readFrom(String, Bool)

```cangjie
public static func readFrom(path: String, recursive!: Bool = false): Path
```

Function: Retrieves the target of the specified symbolic link. When 'recursive' is set to 'true', it follows the link to the final target and returns the full path of the target. When 'recursive' is set to 'false', it reads the current target link and returns it.

Parameters:

- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The address of the symbolic link.
- recursive!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether to recursively read the target address. Default is 'false'.

Return Value:

- [Path](fs_package_structs.md#struct-path) - The target address of the symbolic link.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if the path is empty or contains null characters.
- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown if the symbolic link read operation fails.