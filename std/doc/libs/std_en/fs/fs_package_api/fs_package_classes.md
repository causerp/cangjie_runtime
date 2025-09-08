# Classes

## class Directory

```cangjie
public class Directory {}
```

Functionality: Represents a directory in the file system, providing capabilities for creation, movement, copying, deletion, attribute querying, and directory traversal.

> **Note:**
>
> An illegal path refers to any of the following cases:
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

Specifies whether to create recursively. If recursive creation is required, non-existent directories in the path will be created level by level.

Parameters:

- path: [Path](fs_package_structs.md#struct-path) - The directory path to be created.
- recursive!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether to create directories recursively. true for recursive creation, false for non-recursive creation (default: false).

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Throws an exception if the directory already exists, intermediate directories do not exist during non-recursive creation, insufficient permissions, or other reasons prevent directory creation.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception if the directory is empty, the current directory, the root directory, or contains null characters.

### static func create(String, Bool)

```cangjie
public static func create(path: String, recursive!: Bool = false): Unit
```

Functionality: Creates a directory.

Specifies whether to create recursively. If recursive creation is required, non-existent directories in the path will be created level by level.

Parameters:

- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The directory path string to be created.
- recursive!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether to create directories recursively. true for recursive creation, false for non-recursive creation (default: false).

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Throws an exception if the directory already exists, intermediate directories do not exist during non-recursive creation, insufficient permissions, or other reasons prevent directory creation.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception if the directory is empty, the current directory, the root directory, or contains null characters.

### static func createTemp(Path)

```cangjie
public static func createTemp(directoryPath: Path): Path
```

Functionality: Creates a temporary directory under the specified directory.

Parameters:

- directoryPath: [Path](fs_package_structs.md#struct-path) - The directory path in [Path](fs_package_structs.md#struct-path) format.

Return Value:

- [Path](./fs_package_structs.md#struct-path) - The path corresponding to the temporary directory.

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Throws an exception if the directory does not exist or creation fails for other reasons.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception if the directory is empty or contains null characters.

### static func createTemp(String)

```cangjie
public static func createTemp(directoryPath: String): Path
```

Functionality: Creates a temporary directory under the specified directory.

Parameters:

- directoryPath: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The directory path string.

Return Value:

- [Path](./fs_package_structs.md#struct-path) - The path corresponding to the temporary directory.

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Throws an exception if the directory does not exist or creation fails for other reasons.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception if the directory is empty or contains null characters.

### static func isEmpty(Path)

```cangjie
public static func isEmpty(path: Path): Bool
```

Functionality: Checks if the specified directory is empty.

Parameters:

- path: [Path](./fs_package_structs.md#struct-path) - The path corresponding to the directory to be checked.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if the directory is empty, false otherwise.

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Throws an exception if the specified path does not exist, is not a directory, or an error occurs in the underlying interface during checking.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception if the specified path is empty or contains null characters.

### static func isEmpty(String)

```cangjie
public static func isEmpty(path: String): Bool
```

Functionality: Checks if the specified directory is empty.

Parameters:

- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The path string corresponding to the directory to be checked.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if the directory is empty, false otherwise.

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Throws an exception if the specified path does not exist, is not a directory, or an error occurs in the underlying interface during checking.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception if the specified path is empty or contains null characters.

### static func readFrom(Path)

```cangjie
public static func readFrom(path: Path): Array<FileInfo>
```

Functionality: Retrieves the list of sub-items in the current directory.

The order of sub-items in the array depends on the system's file sorting.

Parameters:

- path: [Path](./fs_package_structs.md#struct-path) - The path corresponding to the directory whose sub-items are to be read.

Return Value:

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[FileInfo](fs_package_structs.md#struct-fileinfo)> - The list of sub-items in the current directory.

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Throws an exception if the specified path does not exist, is not a directory, or fails to retrieve member information.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception if the specified path is empty or contains null characters.

### static func readFrom(String)

```cangjie
public static func readFrom(path: String): Array<FileInfo>
```

Functionality: Retrieves the list of sub-items in the current directory.

The order of sub-items in the array depends on the system's file sorting.

Parameters:

- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The path string corresponding to the directory whose sub-items are to be read.

Return Value:

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[FileInfo](./fs_package_structs.md#struct-fileinfo)> - The list of sub-items in the current directory.

Exceptions:

- [FSException](./fs_package_exceptions.md#class-fsexception) - Throws an exception if the specified path does not exist, is not a directory, or fails to retrieve member information.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception if the specified path is empty or contains null characters.

### static func walk(Path, (FileInfo)->Bool)

```cangjie
public static func walk(path: Path, f: (FileInfo)->Bool): Unit
```

Functionality: Traverses sub-items (non-recursive, excluding sub-directories' sub-items) under the directory corresponding to `path` and executes a callback function for each sub-item.

The `walk` function exits when traversal completes or the callback function `f` returns false. The traversal order depends on the system's file sorting.

Parameters:

- path: [Path](./fs_package_structs.md#struct-path) - The path corresponding to the directory to be traversed.
- f: ([FileInfo](./fs_package_structs.md#struct-fileinfo)) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The callback function executed for each sub-item. The input parameter is the metadata of the sub-item, and the return value indicates whether to continue traversal.

Exceptions:

- [FSException](./fs_package_exceptions.md#class-fsexception) - Throws an exception if the specified path does not exist, is not a directory, or fails to retrieve member information.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception if the specified path is empty or contains null characters.

### static func walk(String, (FileInfo)->Bool)

```cangjie
public static func walk(path: String, f: (FileInfo)->Bool): Unit
```

Functionality: Traverses sub-items (non-recursive, excluding sub-directories' sub-items) under the directory corresponding to `path` and executes a callback function for each sub-item.

The `walk` function exits when traversal completes or the callback function `f` returns false. The traversal order depends on the system's file sorting.

Parameters:

- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The path string corresponding to the directory to be traversed.
- f: ([FileInfo](./fs_package_structs.md#struct-fileinfo)) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The callback function executed for each sub-item. The input parameter is the metadata of the sub-item, and the return value indicates whether to continue traversal.

Exceptions:

- [FSException](./fs_package_exceptions.md#class-fsexception) - Throws an exception if the specified path does not exist, is not a directory, or fails to retrieve member information.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception if the specified path is empty or contains null characters.

## class File

```cangjie
public class File <: Resource & IOStream & Seekable {
    public init(path: String, mode: OpenMode)
    public init(path: Path, mode: OpenMode)
}
```

Functionality: Provides functions for file operations, including opening, creating, closing, moving, copying, deleting, stream-based read/write operations, attribute querying, and other functions.

> **Note:**
>
> An illegal path refers to any of the following cases:
>
> - Path contains illegal characters such as spaces, tabs, line breaks, etc.
> - Path contains invalid characters such as special characters or control characters.
> - Path contains non-existent directories or files.
> - Path contains inaccessible directories or files due to insufficient permissions or being locked.

When inputting paths, avoid using illegal characters to ensure path validity for correct access to target files or directories.

> **Warning:**
>
> The created [File](fs_package_classes.md#class-file) object will open the corresponding file by default. Call the [close](fs_package_classes.md#func-close) function promptly after use to avoid resource leaks.

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

Functionality: Retrieves the byte count of data from the file header to the file tail.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### init(Path, OpenMode)

```cangjie
public init(path: Path, mode: OpenMode)
```

Functionality: Creates a [File](fs_package_classes.md#class-file) object.

Specifies the file path and opening mode (read/write permissions). The path supports both relative and absolute paths.

Parameters:

- path: [Path](fs_package_structs.md#struct-path) - The file path.
- mode: [OpenMode](fs_package_enums.md#enum-openmode) - The file opening mode.

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Throws an exception if the file does not exist when opened in read-only mode, the parent directory does not exist, or other reasons prevent file opening.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception if the path is empty or contains null characters.

### init(String, OpenMode)

```cangjie
public init(path: String, mode: OpenMode)
```

Functionality: Creates a [File](fs_package_classes.md#class-file) object.

Specifies the file path and opening mode (read/write permissions). The path supports both relative and absolute paths.

Parameters:

- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The file path string.
- mode: [OpenMode](fs_package_enums.md#enum-openmode) - The file opening mode.

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Throws an exception if the file does not exist when opened in read-only mode, the parent directory does not exist, or other reasons prevent file opening.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception if the path is an empty string or contains null characters.

### static func appendTo(Path, Array\<Byte>)

```cangjie
public static func appendTo(path: Path, buffer: Array<Byte>): Unit
```

Functionality: Opens the file at the specified path and writes the buffer in append mode. Creates the file if it does not exist.

Parameters:

- path: [Path](fs_package_structs.md#struct-path) - The file path.
- buffer: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)> - The bytes to be written.

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Throws an exception if file opening or writing fails.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception if the file path is empty or contains null characters.

### static func appendTo(String, Array\<Byte>)

```cangjie
public static func appendTo(path: String, buffer: Array<Byte>): Unit
```

Functionality: Opens the file at the specified path and writes the buffer in append mode. Creates the file if it does not exist.

Parameters:

- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The file path string.
- buffer: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)> - The bytes to be written.

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Throws an exception if file opening or writing fails.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception if the file path is an empty string or contains null characters.

### static func create(Path)

```cangjie
public static func create(path: Path): File
```

Functionality: Creates a file at the specified path and returns a [File](#class-file) instance in write-only mode.

Parameters:

- path: [Path](fs_package_structs.md#struct-path) - The file path.

Return Value:

- [File](fs_package_classes.md#class-file) - The [File](fs_package_classes.md#class-file) instance.

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Throws an exception if the parent directory of the path does not exist or the file already exists.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception if the file path is empty or contains null characters.

### static func create(String)

```cangjie
public static func create(path: String): File
```

Functionality: Creates a file at the specified path and returns a [File](#class-file) instance in write-only mode.

Parameters:

- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The file path string.

Return Value:

- [File](fs_package_classes.md#class-file) - The [File](fs_package_classes.md#class-file) instance.

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Throws an exception if the parent directory of the path does not exist or the file already exists.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception if the file path is an empty string or contains null characters.

### static func createTemp(Path)

```cangjie
public static func createTemp(directoryPath: Path): File
```

Functionality: Creates a temporary file under the specified directory.

The file name follows the pattern `tmpFileXXXX```markdown
## class HardLink

```cangjie
public class HardLink
```

Function: Provides interfaces for handling filesystem hard links.

### static func create(Path, Path)

```cangjie
public static func create(link: Path, to!: Path): Unit
```

Function: Creates a new hard link to an existing path. If the new path already exists, it will not be overwritten.

Parameters:

- link: [Path](fs_package_structs.md#struct-path) - Name of the new path.
- to!: [Path](fs_package_structs.md#struct-path) - Name of the existing path.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the path parameter is empty or contains null characters.
- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown when hard link creation fails.

### static func create(String, String)

```cangjie
public static func create(link: String, to!: String): Unit
```

Function: Creates a new hard link to an existing path. If the new path already exists, it will not be overwritten.

Parameters:

- link: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Name of the new path.
- to!: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Name of the existing path.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the path parameter is empty or contains null characters.
- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown when hard link creation fails.

## class SymbolicLink

```cangjie
public class SymbolicLink
```

Function: Provides interfaces for handling filesystem symbolic links.

### static func create(Path, Path)

```cangjie
public static func create(link: Path, to!: Path): Unit
```

Function: Creates a new symbolic link to an existing path.

> **Note:**
>
> On Windows, when creating a symbolic link to a non-existent target, a file symbolic link will be created. If the target path is later created as a directory, the symbolic link will not function.

Parameters:

- link: [Path](fs_package_structs.md#struct-path) - The symbolic link to be created.
- to!: [Path](fs_package_structs.md#struct-path) - The target path of the symbolic link to be created.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the path parameter is empty or contains null characters.
- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown when symbolic link creation fails.

### static func create(String, String)

```cangjie
public static func create(link: String, to!: String): Unit
```

Function: Creates a new symbolic link to an existing path.

> **Note:**
>
> On Windows, when creating a symbolic link to a non-existent target, a file symbolic link will be created. If the target path is later created as a directory, the symbolic link will not function.

Parameters:

- link: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The symbolic link to be created.
- to!: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The target path of the symbolic link to be created.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the path parameter is empty or contains null characters.
- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown when symbolic link creation fails.

### static func readFrom(Path, Bool)

```cangjie
public static func readFrom(path: Path, recursive!: Bool = false): Path
```

Function: Retrieves the target of the specified symbolic link. When 'recursive' is set to 'true', it follows the link to the final target and returns the full path of the target. When 'recursive' is set to 'false', it reads the current target link and returns it.

Parameters:

- path: [Path](fs_package_structs.md#struct-path) - Address of the symbolic link.
- recursive!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether to recursively read the target address. Default is 'false'.

Return Value:

- [Path](fs_package_structs.md#struct-path) - Target address of the symbolic link.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the path parameter is empty or contains null characters.
- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown when reading the symbolic link fails.

### static func readFrom(String, Bool)

```cangjie
public static func readFrom(path: String, recursive!: Bool = false): Path
```

Function: Retrieves the target of the specified symbolic link. When 'recursive' is set to 'true', it follows the link to the final target and returns the full path of the target. When 'recursive' is set to 'false', it reads the current target link and returns it.

Parameters:

- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Address of the symbolic link.
- recursive!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether to recursively read the target address. Default is 'false'.

Return Value:

- [Path](fs_package_structs.md#struct-path) - Target address of the symbolic link.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the path parameter is empty or contains null characters.
- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown when reading the symbolic link fails.
```