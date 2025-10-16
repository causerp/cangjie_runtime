# std.fs

## Features

The fs (file system) package provides a set of functions for operations on files, directories, paths, and file metadata information.

Currently supports Linux, macOS, and Windows platforms.

## API List

### Functions

| Function Name | Description |
| --------------------------------- | ---------------------------------- |
| [canonicalize(Path)](./fs_package_api/fs_package_funcs.md#func-canonicalizepath) | Normalizes a [Path](./fs_package_api/fs_package_structs.md#struct-path) instance to obtain a canonical path in absolute form. |
| [canonicalize(String)](./fs_package_api/fs_package_funcs.md#func-canonicalizestring) | Constructs a [Path](./fs_package_api/fs_package_structs.md#struct-path) instance from a path string, then normalizes it to obtain a canonical path in absolute form. |
| [copy(Path, Path, Bool)](./fs_package_api/fs_package_funcs.md#func-copypath-path-bool)| Implements file system copy functionality for copying files or directories. |
| [copy(String, String, Bool)](./fs_package_api/fs_package_funcs.md#func-copystring-string-bool)| Implements file system copy functionality for copying files or directories. |
| [exists(Path)](./fs_package_api/fs_package_funcs.md#func-existspath) | Checks whether the target path exists. |
| [exists(String)](./fs_package_api/fs_package_funcs.md#func-existsstring) | Checks whether the target path exists. |
| [rename(Path, Path, Bool)](./fs_package_api/fs_package_funcs.md#func-renamepath-path-bool)| Renames a file. |
| [rename(String, String, Bool)](./fs_package_api/fs_package_funcs.md#func-renamestring-string-bool)| Renames a file. |
| [remove(Path, Bool)](./fs_package_api/fs_package_funcs.md#func-removepath-bool)| Deletes a file or directory. |
| [remove(String, Bool)](./fs_package_api/fs_package_funcs.md#func-removestring-bool)| Deletes a file or directory. |
| [removeIfExists(Path, Bool)](./fs_package_api/fs_package_funcs.md#func-removeifexistspath-bool)| Checks if the target exists and deletes it if present. |
| [removeIfExists(String, Bool)](./fs_package_api/fs_package_funcs.md#func-removeifexistsstring-bool)| Checks if the target exists and deletes it if present. |

### Classes

| Class Name | Description |
| --------------------------------- | ---------------------------------- |
| [Directory](./fs_package_api/fs_package_classes.md#class-directory) | Represents a directory in the file system, providing capabilities for creation, attribute querying, and directory traversal. |
| [File](./fs_package_api/fs_package_classes.md#class-file) | Provides functions for file operations including opening, creating, closing, stream-based read/write operations, attribute querying, and other utilities. |
| [HardLink](./fs_package_api/fs_package_classes.md#class-hardlink) | Provides interfaces for handling file system hard links. |
| [SymbolicLink](./fs_package_api/fs_package_classes.md#class-symbolicLink) | Provides interfaces for handling file system symbolic links. |

### Enums

| Enum Name | Description |
| --------------------------- | ------------------------ |
| [OpenMode](./fs_package_api/fs_package_enums.md#enum-openmode) | Represents different file opening modes. |

### Structs

| Struct Name | Description |
| --------------------------- | ------------------------ |
| [FileDescriptor](./fs_package_api/fs_package_structs.md#struct-filedescriptor) | Used for obtaining file handle information. |
| [FileInfo](./fs_package_api/fs_package_structs.md#struct-fileinfo) | Represents file metadata in the file system, providing functions for querying and setting file attributes. |
| [Path](./fs_package_api/fs_package_structs.md#struct-path) | Provides path-related functions. |

### Exception Classes

| Exception Class Name | Description |
| --------------------------- | ------------------------ |
| [FSException](./fs_package_api/fs_package_exceptions.md#class-fsexception) | File stream exception class, inherits from IO stream exception class. |