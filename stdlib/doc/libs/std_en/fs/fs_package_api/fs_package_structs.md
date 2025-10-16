# Structures

## struct FileDescriptor

```cangjie
public struct FileDescriptor
```

Function: Used to obtain file handle information.

> **Note:**
>
> A file handle (File Handle) is a data structure allocated by the operating system to track files, used to identify an instance of an opened file. The file handle contains file metadata (such as filename, path, size, modification time, etc.) and the physical location of file data on disk.
>
> The form of file handles may vary across operating systems. In Unix and Linux systems, file handles are typically non-negative integers allocated by the OS kernel and returned to applications when opening files. In Windows systems, file handles are usually pointers to file objects, allocated by the OS kernel and returned to applications when opening files. Regardless of the form, applications can use file handles to perform operations like reading, writing, and modifying files.

### prop fileHandle

```cangjie
public prop fileHandle: IntNative
```

Function: Obtains file handle information.

Type: [IntNative](../../core/core_package_api/core_package_intrinsics.md#IntNative)

## struct FileInfo

```cangjie
public struct FileInfo <: Equatable<FileInfo> {
    public init(path: Path)
    public init(path: String)
}
```

Function: Corresponds to file metadata in the file system.

> **Note:**
>
> File metadata refers to information related to files in the file system, including filename, file size, creation time, modification time, access time, file permissions, file owner, etc.
>
> The underlying implementation of [FileInfo](fs_package_structs.md#struct-fileinfo) does not directly cache file attributes. Each time the [FileInfo](fs_package_structs.md#struct-fileinfo) API is called, the latest file attributes are retrieved on the spot.
>
> Therefore, special attention is required: for the same [FileInfo](fs_package_structs.md#struct-fileinfo) instance, if the corresponding file entity is modified or replaced by other users or processes between two attribute retrieval operations, the latter retrieval may not yield the expected file attributes.
>
> If specific file operations require avoiding such scenarios, file permissions can be set or critical file operations can be locked to ensure consistency.

Parent Types:

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[FileInfo](#struct-fileinfo)>

### prop creationTime

```cangjie
public prop creationTime: DateTime
```

Function: Obtains the creation time.

Type: [DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime)

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown if an error occurs in the underlying interface during the operation.

### prop lastAccessTime

```cangjie
public prop lastAccessTime: DateTime
```

Function: Obtains the last access time.

Type: [DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime)

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown if an error occurs in the underlying interface during the operation.

### prop lastModificationTime

```cangjie
public prop lastModificationTime: DateTime
```

Function: Obtains the last modification time.

Type: [DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime)

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown if an error occurs in the underlying interface during the operation.

### prop name

```cangjie
public prop name: String
```

Function: Obtains the filename or directory name corresponding to the current instance.

This property is equivalent to `this.path.fileName`. For path resolution rules, refer to the [fileName](./fs_package_structs.md#prop-filename) property of the [Path](./fs_package_structs.md#struct-path) structure.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop parentDirectory

```cangjie
public prop parentDirectory: Option<FileInfo>
```

Function: Obtains the parent directory metadata, returned as [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[FileInfo](fs_package_structs.md#struct-fileinfo)>. Returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[FileInfo](fs_package_structs.md#struct-fileinfo)>.Some(v) if a parent exists; otherwise, returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[FileInfo](fs_package_structs.md#struct-fileinfo)>.None.

Type: [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[FileInfo](fs_package_structs.md#struct-fileinfo)>

### prop path

```cangjie
public prop path: Path
```

Function: Obtains the current file path, returned as a [Path](fs_package_structs.md#struct-path).

Type: [Path](fs_package_structs.md#struct-path)

### prop size

```cangjie
public prop size: Int64
```

Function: Returns the current file size.

- For files, this represents the disk space occupied by the file.
- For directories, this represents the total disk space occupied by all files in the directory.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown if an error occurs in the underlying interface during the operation.

### init(Path)

```cangjie
public init(path: Path)
```

Function: Creates a [FileInfo](fs_package_structs.md#struct-fileinfo) instance.

Parameters:

- path: [Path](fs_package_structs.md#struct-path) - The directory path in [Path](fs_package_structs.md#struct-path) form.

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown if the path is invalid.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if the path is empty or contains a string terminator.

### init(String)

```cangjie
public init(path: String)
```

Function: Creates a [FileInfo](fs_package_structs.md#struct-fileinfo) instance.

Parameters:

- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The directory path in [String](../../core/core_package_api/core_package_structs.md#struct-string) form.

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown if the path is invalid.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if the path is empty or contains a string terminator.

### func canExecute()

```cangjie
public func canExecute(): Bool
```

Function: Determines whether the current user has permission to execute the file corresponding to this instance.

- For files, checks if the user has execute permission.
- For directories, checks if the user has permission to enter the directory.
- On Windows, execute permission for files is determined by the file extension; users always have execute permission for directories, and this function returns true without effect.
- On Linux and macOS, this function works as expected.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - true indicates permission; false indicates no permission.

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown if an error occurs in the underlying interface during the operation.

### func canRead()

```cangjie
public func canRead(): Bool
```

Function: Determines whether the current user has permission to read the file corresponding to this instance.

- For files, checks if the user has read permission.
- For directories, checks if the user has permission to browse the directory.
- On Windows, users always have read permission for files and directories, and this function returns true without effect.
- On Linux and macOS, this function works as expected.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - true indicates permission; false indicates no permission.

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown if an error occurs in the underlying interface during the operation.

### func canWrite()

```cangjie
public func canWrite(): Bool
```

Function: Determines whether the current user has permission to write to the file corresponding to this instance.

- For files, checks if the user has write permission.
- For directories, checks if the user has permission to delete, move, or create files within the directory.
- On Windows, write permission for files works as expected; users always have write permission for directories, and this function returns true without effect.
- On Linux and macOS, this function works as expected.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - true indicates permission; false indicates no permission.

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown if an error occurs in the underlying interface during the operation.

### func isDirectory()

```cangjie
public func isDirectory(): Bool
```

Function: Determines whether the current file is a directory.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - true indicates a directory; false indicates not a directory.

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown if an error occurs in the underlying interface during the operation.

### func isRegular()

```cangjie
public func isRegular(): Bool
```

Function: Determines whether the current file is a regular file.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - true indicates a file; false indicates not a file.

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown if an error occurs in the underlying interface during the operation.

### func isHidden()

```cangjie
public func isHidden(): Bool
```

Function: Determines whether the current file is hidden.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - true indicates hidden; false indicates not hidden.

### func isReadOnly()

```cangjie
public func isReadOnly(): Bool
```

Function: Determines whether the current file is read-only.

- On Windows, read-only permission for files works as expected; users always have delete/modify permission for directories, and this function returns false without effect.
- On Linux and macOS, this function works as expected.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - true indicates read-only; false indicates not read-only.

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown if an error occurs in the underlying interface during the operation.

### func isSymbolicLink()

```cangjie
public func isSymbolicLink(): Bool
```

Function: Determines whether the current file is a symbolic link.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - true indicates a symbolic link; false indicates not a symbolic link.

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown if an error occurs in the underlying interface during the operation.

### func setExecutable(Bool)

```cangjie
public func setExecutable(executable: Bool): Bool
```

Function: Sets whether the file owner has execute permission for the file corresponding to this instance. Throws an exception if the current user lacks permission to modify.

- For files, sets execute permission.
- For directories, sets permission to enter the directory.
- On Windows, execute permission for files is determined by the file extension; users always have execute permission for directories, and this function returns false without effect.
- On Linux and macOS, this function works as expected. If the file entity corresponding to this [FileInfo](fs_package_structs.md#struct-fileinfo) is modified by other users or processes during this function call, race conditions may cause other modifications to fail.

Parameters:

- executable: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether to set as executable.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - true indicates success; false indicates failure.

### func setReadable(Bool)

```cangjie
public func setReadable(readable: Bool): Bool
```

Function: Sets whether the file owner has read permission for the file corresponding to this instance. Throws an exception if the current user lacks permission to modify.

- For files, sets read permission.
- For directories, sets permission to browse the directory.
- On Windows, users always have read permission for files and directories, and this function returns true if `readable` is true, otherwise false.
- On Linux and macOS, this function works as expected. If the file entity corresponding to this [FileInfo](fs_package_structs.md#struct-fileinfo) is modified by other users or processes during this function call, race conditions may cause other modifications to fail.

Parameters:

- readable: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether to set as readable.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - true indicates success; false indicates failure.

### func setWritable(Bool)

```cangjie
public func setWritable(writable: Bool): Bool
```

Function: Sets whether the file owner has write permission for the file corresponding to this instance. Throws an exception if the current user lacks permission to modify.

- For files, sets write permission.
- For directories, sets permission to delete, move, or create files within the directory.
- On Windows, write permission for files works as expected; users always have write permission for directories, and this function returns false without effect.
- On Linux and macOS, this function works as expected. If the file entity corresponding to this [FileInfo](fs_package_structs.md#struct-fileinfo) is modified by other users or processes during this function call, race conditions may cause other modifications to fail.

Parameters:

- writable: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether to set as writable.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - true indicates success; false indicates failure.

### operator func ==(FileInfo)

```cangjie
public operator func ==(that: FileInfo): Bool
```

Function: Determines whether the current [FileInfo](fs_package_structs.md#struct-fileinfo) and another [FileInfo](fs_package_structs.md#struct-fileinfo) correspond to the same file.

Parameters:

- that: [FileInfo](fs_package_structs.md#struct-fileinfo) - Another [FileInfo](fs_package_structs.md#struct-fileinfo).

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - true indicates the same file; false indicates different files.

## struct Path

```cangjie
public struct Path <: Equatable<Path> & Hashable & ToString {
    public static const Separator: String = PATH_SEPARATOR
    public static const ListSeparator: String = PATH_LISTSEPARATOR
    public init(rawPath: String)
}
```

Function: Provides path-related functions.

Path is used to represent local paths (DOS device paths and UNC paths are supported on Windows, with length limits following the system). The maximum supported string length is 4096 bytes (including the terminator `\0`).

> **Note:**
>
> An illegal path refers to any of the following:
>
> - The path contains illegal characters, such as spaces, tabs, or newlines.
> - The path contains invalid characters, such as special or control characters.
> - The path contains non-existent directories or files.
> - The path contains inaccessible directories or files, such as due to insufficient permissions or locks.
>
> When entering paths, avoid illegal characters to ensure path validity and correct access to target files or directories.

Parent Types:

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[Path](#struct-path)>
- [Hashable](../../core/core_package_api/core_package_interfaces.md#interface-hashable)
- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)### static const ListSeparator

```cangjie
public static const ListSeparator: String = PATH_LISTSEPARATOR
```

Function: Retrieves the path list separator used to delimit different paths in a path list.

On Windows systems, the path list separator is ";", while on non-Windows systems it is ":".

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### static const Separator

```cangjie
public static const Separator: String = PATH_SEPARATOR
```

Function: Retrieves the path separator used to delimit directory levels.

On Windows systems, the separator is "\\", while on non-Windows systems it is "/".

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop extensionName

```cangjie
public prop extensionName: String
```

Function: Gets the file extension part of the [Path](fs_package_structs.md#struct-path).

The filename `fileName` is divided into two parts based on the last occurrence of r'.': the filename without extension `fileNameWithoutExtension` and the extension `extensionName`. Returns an empty string if no extension exists.

- For path "./NewFile.txt", this property returns `"txt"`.
- For path "./.gitignore", this property returns `"gitignore"`.
- For path "./noextension", this property returns `""`.
- For path "./a.b.c", this property returns `"c"`.
- For path "./NewFile.txt/", this property returns `"txt"`.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the path is empty or contains a string terminator.

### prop fileName

```cangjie
public prop fileName: String
```

Function: Gets the filename part (including extension) of the [Path](fs_package_structs.md#struct-path).

The entire path string is divided into `parent` and `fileName` parts. See [parent](./fs_package_structs.md#prop-parent) for details. Returns an empty string if no filename exists.

Examples applicable to all systems:

- For path "./NewFile.txt", this property returns "NewFile.txt";
- For path "./.gitignore", this property returns ".gitignore";
- For path "./noextension", this property returns "noextension";
- For path "./a.b.c", this property returns "a.b.c";
- For path "./NewDir/", this property returns "NewDir";

Note: In Windows file systems, `fileName` does not include the volume name part.

Windows-specific examples:

- For path "c:\\a.txt", this property returns "a.txt";
- For path "c:", this property returns "";
- For path "\\\\Server\\Share\\a.txt", this property returns "a.txt";
- For path "\\\\Server\\Share\\", this property returns "";
- For path "\\\\?\\C:a\\b.txt", this property returns "b.txt";
- For path "\\\\?\\C:", this property returns "".

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the path is empty or contains a string terminator.

### prop fileNameWithoutExtension

```cangjie
public prop fileNameWithoutExtension: String
```

Function: Gets the filename part (excluding extension) of the [Path](fs_package_structs.md#struct-path).

The filename `fileName` is divided into two parts based on the last occurrence of r'.': the filename without extension `fileNameWithoutExtension` and the extension `extensionName`. Returns an empty string if no filename (without extension) exists.

- For path "./NewFile.txt", this property returns `"NewFile"`.
- For path "./.gitignore", this property returns `""`.
- For path "./noextension", this property returns `"noextension"`.
- For path "./a.b.c", this property returns `"a.b"`.
- For path "./NewFile/", this property returns `"NewFile"`.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the path is empty or contains a string terminator.

### prop parent

```cangjie
public prop parent: Path
```

Function: Gets the parent path of this [Path](fs_package_structs.md#struct-path) instance.

The entire path string is divided into `parent` and `fileName`, using the last valid file separator (trailing separators are ignored) as the boundary. If `parent` doesn't exist, returns a Path instance constructed with an empty string. Neither `parent` nor `fileName` includes trailing separators, but `parent` retains the root directory separator. Returns an empty [Path](./fs_package_structs.md#struct-path) instance when no parent directory exists.

This property does not access the file system or resolve special names. Use with normalization if needed.

Behavior varies by OS: On Windows, file separators are "\\" or "/" (normalized to "\\"); on Linux/macOS, it's "/".

Examples applicable to all systems:

- For path "/a/b/c", returns Path("/a/b");
- For path "/a/b/", returns Path("/a");
- For path "/a", returns Path("/");
- For path "/", returns Path("/");
- For path "./a/b", returns Path("./a");
- For path "./", returns Path("");
- For path ".gitignore", returns Path("");
- For path "/a/./../b", returns Path("/a/./..").

Windows-specific behavior: Paths are divided into volume name, directory name, and filename (see Microsoft documentation). The `parent` property includes volume and directory names.

Windows-specific examples:

- For path "C:", returns Path("C:");
- For path "C:\\a\\b", returns Path("C:\\a");
- For path "\\\\Server\\Share\\xx\\yy", returns Path("\\\\Server\\Share\\xx");
- For path "\\\\?\\UNC\\Server\\Share\\xx\\yy", returns Path("\\\\?\\UNC\\Server\\Share\\xx");
- For path "\\\\?\\c:\\xx\\yy", returns Path("\\\\?\\c:\\xx").

Type: [Path](fs_package_structs.md#struct-path)

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the path is empty or contains a string terminator.

### init(String)

```cangjie
public init(rawPath: String)
```

Function: Creates a [Path](fs_package_structs.md#struct-path) instance without validating path string legality. Supports both absolute and relative paths.

Parameters:

- rawPath: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The path string.

### func hashCode()

```cangjie
public func hashCode(): Int64
```

Function: Gets the hash value of the [Path](fs_package_structs.md#struct-path).

Return value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The hash value of the [Path](fs_package_structs.md#struct-path).

### func isAbsolute()

```cangjie
public func isAbsolute(): Bool
```

Function: Determines whether the [Path](fs_package_structs.md#struct-path) is absolute. On Unix systems, paths starting with `/` are absolute.

Return value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - true if absolute; false otherwise.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the path is empty or contains a string terminator.

### func isEmpty()

```cangjie
public func isEmpty(): Bool
```

Function: Determines whether the current instance is an empty path.

Return value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if the current instance is an empty path; otherwise, false.

### func isRelative()

```cangjie
public func isRelative(): Bool
```

Function: Determines whether the [Path](fs_package_structs.md#struct-path) is relative. The result is opposite to [isAbsolute](fs_package_structs.md#func-isAbsolute).

Return value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - true if relative; false otherwise.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the path is empty or contains a string terminator.

### func join(Path)

```cangjie
public func join(path: Path): Path
```

Function: Concatenates another path string to the current path to form a new path.

- For paths "a/b" and "c", returns "a/b/c".
- For paths "a" and "b/c", returns "a/b/c".

Parameters:

- path: [Path](fs_package_structs.md#struct-path) - Another [Path](fs_package_structs.md#struct-path).

Return value:

- [Path](fs_package_structs.md#struct-path) - A new [Path](fs_package_structs.md#struct-path) instance.

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown if the parameter `path` is absolute.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the current path is empty or either path is invalid.

### func join(String)

```cangjie
public func join(path: String): Path
```

Function: Concatenates another path string to the current path to form a new path.

- For paths "a/b" and "c", returns "a/b/c".
- For paths "a" and "b/c", returns "a/b/c".

Parameters:

- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Another path string.

Return value:

- [Path](fs_package_structs.md#struct-path) - A new [Path](fs_package_structs.md#struct-path) instance.

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown if the parameter `path` is absolute.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the current path is empty or either path is invalid.

### func normalize()

```cangjie
public func normalize(): Path
```

Function: Normalizes the path string and constructs a new [Path](./fs_package_structs.md#struct-path) instance with the normalized string. This function only performs string parsing without IO operations.

Normalization rules:

1. Replace consecutive path separators with a single separator;
2. Remove trailing separators (except root directory separators or volume name characters);
3. Remove each "." path element (current directory);
4. Remove each ".." path element (parent directory) and its preceding non-".." element;
5. Remove ".." elements starting from root (e.g., "/.." becomes "/"; "\\.." becomes "\\" on Windows);
6. Preserve leading "../" in relative paths (and "..\\" on Windows);
7. If the result is empty, return Path(".").

Windows-specific: Volume names only undergo separator conversion (/ to \\).

Return value:

- [Path](./fs_package_structs.md#struct-path) - Normalized [Path](./fs_package_structs.md#struct-path) instance.

### func toString()

```cangjie
public func toString(): String
```

Function: Gets the path string of the [Path](fs_package_structs.md#struct-path).

Return value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The path string of the [Path](fs_package_structs.md#struct-path).

### operator func ==(Path)

```cangjie
public operator func ==(that: Path): Bool
```

Function: Determines whether two [Path](fs_package_structs.md#struct-path) instances are equal.

Equality is determined by comparing normalized strings. Normalization rules: see [normalize](./fs_package_structs.md#func-normalize).

Parameters:

- that: [Path](fs_package_structs.md#struct-path) - Another [Path](fs_package_structs.md#struct-path).

Return value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - true if paths are identical; false otherwise.