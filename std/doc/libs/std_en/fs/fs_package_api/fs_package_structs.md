# Structures

## struct FileDescriptor

```cangjie
public struct FileDescriptor
```

Function: Used to obtain file handle information.

> **Note:**
>
> A file handle (File Handle) is a data structure allocated by the operating system to track files, used to identify an instance of an opened file. The file handle contains file metadata information (such as filename, path, size, modification time, etc.) as well as the physical location of file data on disk.
>
> The form of file handles may vary across different operating systems. In Unix and Linux systems, file handles are typically non-negative integers allocated by the operating system kernel and returned to applications when files are opened. In Windows systems, file handles are usually pointers to file objects allocated by the operating system kernel and returned to applications when files are opened. Regardless of the form of the file handle, applications can use it to perform operations such as reading, writing, and modifying files.

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
> The underlying implementation of [FileInfo](fs_package_structs.md#struct-fileinfo) does not directly cache file attributes. Each time the API of [FileInfo](fs_package_structs.md#struct-fileinfo) is called, the latest file attributes are retrieved on the spot.
>
> Therefore, there is a scenario to be aware of: for the same [FileInfo](fs_package_structs.md#struct-fileinfo) instance, if the corresponding file entity is modified or replaced by other users or processes between two file attribute retrieval operations, the latter retrieval may not yield the expected file attributes.
>
> If special file operations require avoiding the above scenario, methods such as setting file permissions or locking critical file operations can be employed to ensure consistency.

Parent Types:

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[FileInfo](#struct-fileinfo)>

### prop creationTime

```cangjie
public prop creationTime: DateTime
```

Function: Obtains the creation time.

Type: [DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime)

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown if an error occurs in the underlying system interface during the operation.

### prop lastAccessTime

```cangjie
public prop lastAccessTime: DateTime
```

Function: Obtains the last access time.

Type: [DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime)

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown if an error occurs in the underlying system interface during the operation.

### prop lastModificationTime

```cangjie
public prop lastModificationTime: DateTime
```

Function: Obtains the last modification time.

Type: [DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime)

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown if an error occurs in the underlying system interface during the operation.

### prop name

```cangjie
public prop name: String
```

Function: Obtains the filename or directory name corresponding to the current instance.

This property is equivalent to this.path.fileName. For path resolution rules, refer to the [fileName](./fs_package_structs.md#prop-filename) property of the [Path](./fs_package_structs.md#struct-path) structure.

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

- When the current instance is a file, it represents the disk space occupied by the individual file.
- When the current instance is a directory, it represents the total disk space occupied by all files in the directory.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown if an error occurs in the underlying system interface during the operation.

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

- For files, it checks whether the user has permission to execute the file.
- For directories, it checks whether the user has permission to enter the directory.
- On Windows, the execution permission for files is determined by the file extension; users always have execution permission for directories, so this function is ineffective and returns true.
- On Linux and macOS, this function works as expected.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - true indicates permission; false indicates no permission.

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown if an error occurs in the underlying system interface during the operation.

### func canRead()

```cangjie
public func canRead(): Bool
```

Function: Determines whether the current user has permission to read the file corresponding to this instance.

- For files, it checks whether the user has permission to read the file.
- For directories, it checks whether the user has permission to browse the directory.
- On Windows, users always have read permission for files and directories, so this function is ineffective and returns true.
- On Linux and macOS, this function works as expected.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - true indicates permission; false indicates no permission.

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown if an error occurs in the underlying system interface during the operation.

### func canWrite()

```cangjie
public func canWrite(): Bool
```

Function: Determines whether the current user has permission to write to the file corresponding to this instance.

- For files, it checks whether the user has permission to write to the file.
- For directories, it checks whether the user has permission to delete, move, or create files within the directory.
- On Windows, write permission for files works as expected; users always have write permission for directories, so this function is ineffective and returns true.
- On Linux and macOS, this function works as expected.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - true indicates permission; false indicates no permission.

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown if an error occurs in the underlying system interface during the operation.

### func isDirectory()

```cangjie
public func isDirectory(): Bool
```

Function: Determines whether the current file is a directory.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - true indicates it is a directory; false indicates it is not.

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown if an error occurs in the underlying system interface during the operation.

### func isRegular()

```cangjie
public func isRegular(): Bool
```

Function: Determines whether the current file is a regular file.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - true indicates it is a file; false indicates it is not.

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown if an error occurs in the underlying system interface during the operation.

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

- On Windows, read-only permission for files works as expected; users always have delete/modify permission for directories, so this function is ineffective and returns false.
- On Linux and macOS, this function works as expected.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - true indicates read-only; false indicates not read-only.

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown if an error occurs in the underlying system interface during the operation.### func isSymbolicLink()

```cangjie
public func isSymbolicLink(): Bool
```

Function: Determines whether the current file is a symbolic link.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - true indicates it is a symbolic link; false indicates it is not.

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Throws an exception if an error occurs in the underlying system interface during the check.

### func setExecutable(Bool)

```cangjie
public func setExecutable(executable: Bool): Bool
```

Function: Sets the executable permission for the file owner of the current instance. Throws an exception if the current user lacks permission to modify.

- For files, sets whether the user has permission to execute the file. For directories, sets whether the user has permission to enter the directory.
- On Windows, file execution permissions are determined by file extensions. Users always have execution permissions for directories, making this function ineffective (returns false).
- On Linux and macOS, this function works normally. If the file entity corresponding to this [FileInfo](fs_package_structs.md#struct-fileinfo) is modified by another user or process during this function call, a race condition may prevent other modifications from taking effect.

Parameters:

- executable: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether to set as executable.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - true if the operation succeeds; false if it fails.

### func setReadable(Bool)

```cangjie
public func setReadable(readable: Bool): Bool
```

Function: Sets the readable permission for the file owner of the current instance. Throws an exception if the current user lacks permission to modify.

- For files, sets whether the user has permission to read the file.
- For directories, sets whether the user has permission to browse the directory.
- On Windows, users always have read permissions for files and directories, which cannot be changed. The function is ineffective: returns true when `readable` is true, and false when `readable` is false.
- On Linux and macOS, this function works normally. If the file entity corresponding to this [FileInfo](fs_package_structs.md#struct-fileinfo) is modified by another user or process during this function call, a race condition may prevent other modifications from taking effect.

Parameters:

- readable: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether to set as readable.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - true if the operation succeeds; false if it fails.

### func setWritable(Bool)

```cangjie
public func setWritable(writable: Bool): Bool
```

Function: Sets the writable permission for the file owner of the current instance. Throws an exception if the current user lacks permission to modify.

- For files, sets whether the user has permission to write to the file.
- For directories, sets whether the user has permission to delete, move, or create files within the directory.
- On Windows, file write permissions work normally. Users always have write permissions for directories, which cannot be changed, making this function ineffective (returns false).
- On Linux and macOS, this function works normally. If the file entity corresponding to this [FileInfo](fs_package_structs.md#struct-fileinfo) is modified by another user or process during this function call, a race condition may prevent other modifications from taking effect.

Parameters:

- writable: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether to set as writable.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - true if the operation succeeds; false if it fails.

### operator func ==(FileInfo)

```cangjie
public operator func ==(that: FileInfo): Bool
```

Function: Determines whether the current [FileInfo](fs_package_structs.md#struct-fileinfo) and another [FileInfo](fs_package_structs.md#struct-fileinfo) refer to the same file.

Parameters:

- that: [FileInfo](fs_package_structs.md#struct-fileinfo) - Another [FileInfo](fs_package_structs.md#struct-fileinfo).

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - true if they refer to the same file; false otherwise.

## struct Path

```cangjie
public struct Path <: Equatable<Path> & Hashable & ToString {
    public static const Separator: String = PATH_SEPARATOR
    public static const ListSeparator: String = PATH_LISTSEPARATOR
    public init(rawPath: String)
}
```

Function: Provides path-related functions.

Path represents local paths (Windows supports DOS device paths and UNC paths, with length limits following the system). The maximum string length for a path is 4096 bytes (including the null terminator `\0`).

> **Note:**
>
> An illegal path refers to any of the following:
>
> - Contains illegal characters (e.g., spaces, tabs, line breaks).
> - Contains invalid characters (e.g., special or control characters).
> - Contains non-existent directories or files.
> - Contains inaccessible directories or files (e.g., due to insufficient permissions or locks).

When inputting paths, avoid illegal characters to ensure path validity for correct file or directory access.

Parent Types:

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[Path](#struct-path)>
- [Hashable](../../core/core_package_api/core_package_interfaces.md#interface-hashable)
- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

### static const ListSeparator

```cangjie
public static const ListSeparator: String = PATH_LISTSEPARATOR
```

Function: Retrieves the path list separator, used to separate different paths in a path list.

On Windows, the separator is ";"; on non-Windows systems, it is ":".

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### static const Separator

```cangjie
public static const Separator: String = PATH_SEPARATOR
```

Function: Retrieves the path separator, used to separate multi-level directories.

On Windows, the separator is "\\"; on non-Windows systems, it is "/".

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop extensionName

```cangjie
public prop extensionName: String
```

Function: Retrieves the file extension part of the [Path](fs_package_structs.md#struct-path).

The filename `fileName` is split into `fileNameWithoutExtension` and `extensionName` based on the last '.'. Returns an empty string if no extension exists.

- For "./NewFile.txt", returns `"txt"`.
- For "./.gitignore", returns `"gitignore"`.
- For "./noextension", returns `""`.
- For "./a.b.c", returns `"c"`.
- For "./NewFile.txt/", returns `"txt"`.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception if the path is empty or contains a null terminator.

### prop fileName

```cangjie
public prop fileName: String
```

Function: Retrieves the filename (including extension) part of the [Path](fs_package_structs.md#struct-path).

The full path string is split into `parent` and `fileName` (see [parent](./fs_package_structs.md#prop-parent)). Returns an empty string if no filename exists.

Examples for all systems:

- For "./NewFile.txt", returns "NewFile.txt".
- For "./.gitignore", returns ".gitignore".
- For "./noextension", returns "noextension".
- For "./a.b.c", returns "a.b.c".
- For "./NewDir/", returns "NewDir".

On Windows, `fileName` excludes the volume name:

- For "c:\\a.txt", returns "a.txt".
- For "c:", returns "".
- For "\\\\Server\\Share\\a.txt", returns "a.txt".
- For "\\\\Server\\Share\\", returns "".
- For "\\\\?\\C:a\\b.txt", returns "b.txt".
- For "\\\\?\\C:", returns "".

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception if the path is empty or contains a null terminator.

### prop fileNameWithoutExtension

```cangjie
public prop fileNameWithoutExtension: String
```

Function: Retrieves the filename (excluding extension) part of the [Path](fs_package_structs.md#struct-path).

The filename `fileName` is split into `fileNameWithoutExtension` and `extensionName` based on the last '.'. Returns an empty string if no filename exists.

- For "./NewFile.txt", returns `"NewFile"`.
- For "./.gitignore", returns `""`.
- For "./noextension", returns `"noextension"`.
- For "./a.b.c", returns `"a.b"`.
- For "./NewFile/", returns `"NewFile"`.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception if the path is empty or contains a null terminator.

### prop parent

```cangjie
public prop parent: Path
```

Function: Retrieves the parent path of this [Path](fs_package_structs.md#struct-path) instance.

The full path string is split into `parent` and `fileName`, using the last valid file separator (trailing separators are ignored). If `parent` does not exist, returns a Path instance constructed from an empty string. Neither `parent` nor `fileName` includes trailing separators, but `parent` retains the root directory separator. Returns an empty [Path](./fs_package_structs.md#struct-path) instance if no parent exists.

This property does not access the file system or resolve special names. Use normalization if needed.

Behavior varies by OS:

- On Windows, separators are "\\" or "/" (normalized to "\\").
- On Linux/macOS, separators are "/".

Examples for all systems:

- For "/a/b/c", returns Path("/a/b").
- For "/a/b/", returns Path("/a").
- For "/a", returns Path("/").
- For "/", returns Path("/").
- For "./a/b", returns Path("./a").
- For "./", returns Path("").
- For ".gitignore", returns Path("").
- For "/a/./../b", returns Path("/a/./..").

On Windows, paths include volume names, directory names, and filenames (see Microsoft documentation). `parent` includes volume and directory names.

Windows-specific examples:

- For "C:", returns Path("C:").
- For "C:\\a\\b", returns Path("C:\\a").
- For "\\\\Server\\Share\\xx\\yy", returns Path("\\\\Server\\Share\\xx").
- For "\\\\?\\UNC\\Server\\Share\\xx\\yy", returns Path("\\\\?\\UNC\\Server\\Share\\xx").
- For "\\\\?\\c:\\xx\\yy", returns Path("\\\\?\\c:\\xx").

Type: [Path](fs_package_structs.md#struct-path)

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception if the path is empty or contains a null terminator.

### init(String)

```cangjie
public init(rawPath: String)
```

Function: Creates a [Path](fs_package_structs.md#struct-path) instance without checking path string validity. Supports absolute and relative paths.

Parameters:

- rawPath: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The path string.

### func hashCode()

```cangjie
public func hashCode(): Int64
```

Function: Retrieves the hash value of the [Path](fs_package_structs.md#struct-path).

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The hash value of the [Path](fs_package_structs.md#struct-path).

### func isAbsolute()

```cangjie
public func isAbsolute(): Bool
```

Function: Determines whether the [Path](fs_package_structs.md#struct-path) is absolute. On Unix, paths starting with `/` are absolute.Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - true if it is an absolute path; false otherwise.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the path is empty or contains a string terminator.

### func isEmpty()

```cangjie
public func isEmpty(): Bool
```

Function: Determines whether the current instance is an empty path.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if the current instance is an empty path; otherwise returns false.

### func isRelative()

```cangjie
public func isRelative(): Bool
```

Function: Determines whether the [Path](fs_package_structs.md#struct-path) is a relative path. The result is the opposite of the [isAbsolute](fs_package_structs.md#func-isAbsolute) function.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - true if it is a relative path; false otherwise.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the path is empty or contains a string terminator.

### func join(Path)

```cangjie
public func join(path: Path): Path
```

Function: Concatenates another path string after the current path to form a new path.

- For paths "a/b" and "c", returns "a/b/c".
- For paths "a" and "b/c", returns "a/b/c".

Return Value:

- [Path](fs_package_structs.md#struct-path) - A new [Path](fs_package_structs.md#struct-path) instance of the concatenated path.

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown if the parameter `path` is an absolute path.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the current path is empty or either the current path or the input path is invalid.

### func join(String)

```cangjie
public func join(path: String): Path
```

Function: Concatenates another path string after the current path to form a new path.

- For paths "a/b" and "c", returns "a/b/c".
- For paths "a" and "b/c", returns "a/b/c".

Return Value:

- [Path](fs_package_structs.md#struct-path) - A new [Path](fs_package_structs.md#struct-path) instance of the concatenated path.

Exceptions:

- [FSException](fs_package_exceptions.md#class-fsexception) - Thrown if the parameter `path` is an absolute path.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the current path is empty or either the current path or the input path is invalid.

### func normalize()

```cangjie
public func normalize(): Path
```

Function: Normalizes the path string and constructs a new [Path](./fs_package_structs.md#struct-path) instance with the normalized string. This function only performs string parsing and does not involve IO operations.

Normalization Rules:

- Replace consecutive multiple path separators with a single path separator.
- Remove trailing path separators (except for the root directory separator or characters in volume names).
- Remove each "." path element (representing the current directory).
- Remove each ".." path element (representing the parent directory) and its preceding non-".." path element.
- Remove ".." path elements starting from the root path, i.e., replace "/.." at the beginning with "/" (on Windows systems, "\\.." is replaced with "\\").
- Preserve leading "../" in relative paths (on Windows systems, "..\\" is also preserved).
- If the result is an empty path, return Path(".").

Special Note: On Windows file systems, the volume name part only undergoes separator conversion, i.e., "/" is converted to "\\".

Return Value:

- [Path](./fs_package_structs.md#struct-path) - A normalized [Path](./fs_package_structs.md#struct-path) instance.

### func toString()

```cangjie
public func toString(): String
```

Function: Retrieves the path string of the [Path](fs_package_structs.md#struct-path).

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The path string of the [Path](fs_package_structs.md#struct-path).

### operator func ==(Path)

```cangjie
public operator func ==(that: Path): Bool
```

Function: Determines whether two [Path](fs_package_structs.md#struct-path) instances are equal.

Equality is determined by normalizing both paths. If the normalized strings are equal, the two [Path](fs_package_structs.md#struct-path) instances are considered equal. Refer to the [normalize](./fs_package_structs.md#func-normalize) function for normalization rules.

Parameters:

- that: [Path](fs_package_structs.md#struct-path) - Another [Path](fs_package_structs.md#struct-path) instance.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - true if they represent the same path; false otherwise.