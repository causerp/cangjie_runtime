# Functions

## func \`open`(String, Int32) <sup>(deprecated)</sup>

```cangjie
public func `open`(path: String, oflag: Int32): Int32
```

Function: Opens a file and returns a new file descriptor, or returns `-1` on failure.

When the file opening mode parameter `oflag` is set to [O_CREAT](posix_package_constants_vars.md#const-o_creat-deprecated), file permissions can be set via parameters.

[O_RDONLY](posix_package_constants_vars.md#const-o_rdonly-deprecated), [O_RDWR](posix_package_constants_vars.md#const-o_rdwr-deprecated), and [O_WRONLY](posix_package_constants_vars.md#const-o_wronly-deprecated) are mutually exclusive as values for `oflag`, but can be used in combination with other operation flags such as [O_APPEND](posix_package_constants_vars.md#const-o_append-deprecated).

> **Note:**
>
> Will be deprecated in future versions.

Parameters:

- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - File path.
- oflag: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - File opening mode.

Return value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Returns a new file descriptor, or `-1` on failure.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws exception when function parameter `path` contains null characters.

## func \`open`(String, Int32, UInt32) <sup>(deprecated)</sup>

```cangjie
public func `open`(path: String, oflag: Int32, flag: UInt32): Int32
```

Function: Opens a file and returns a new file descriptor, or returns `-1` on failure. `path` represents the file path, `oflag` represents the file opening mode, where [O_RDONLY](posix_package_constants_vars.md#const-o_rdonly-deprecated), [O_RDWR](posix_package_constants_vars.md#const-o_rdwr-deprecated), and [O_WRONLY](posix_package_constants_vars.md#const-o_wronly-deprecated) are mutually exclusive as values for `oflag`, but can be used with other operation flags such as [O_APPEND](posix_package_constants_vars.md#const-o_append-deprecated).

When the file opening mode parameter `oflag` is set to [O_CREAT](posix_package_constants_vars.md#const-o_creat-deprecated), file permissions can be set via parameters.

> **Note:**
>
> Will be deprecated in future versions.

Parameters:

- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - File path.
- oflag: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - File opening mode.
- flag: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - If `oflag` includes [O_CREAT](posix_package_constants_vars.md#const-o_creat-deprecated) and a new file needs to be created, the `flag` parameter specifies permissions for the new file; otherwise, `flag` does not change file permissions.

Return value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Returns a new file descriptor, or `-1` on failure.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws exception when function parameter `path` contains null characters.

## func access(String, Int32) <sup>(deprecated)</sup>

```cangjie
public func access(path: String, mode: Int32): Int32
```

Function: Checks if a file has certain permissions. Returns `0` if it does, otherwise returns `-1`.

`mode` specifies the permission to check, with possible values: [R_OK](posix_package_constants_vars.md#const-r_ok-deprecated), `W_OK`, [X_OK](posix_package_constants_vars.md#const-x_ok-deprecated), [F_OK](posix_package_constants_vars.md#const-f_ok-deprecated).

> **Note:**
>
> Will be deprecated in future versions.

Parameters:

- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - File path.
- mode: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Permission to check.

Return value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Returns `0` if the file has the specified permission, otherwise returns `-1`.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws exception when function parameter `path` contains null characters.

## func chdir(String) <sup>(deprecated)</sup>

```cangjie
public func chdir(path: String): Int32
```

Function: Changes the current working directory of the calling process by specifying a path.

> **Note:**
>
> Will be deprecated in future versions.

Parameters:

- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - New path.

Return value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Returns `0` on success, `-1` on failure.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws exception when function parameter `path` contains null characters.

## func chmod(String, UInt32) <sup>(deprecated)</sup>

```cangjie
public func chmod(path: String, mode: UInt32): Int32
```

Function: Modifies file access permissions.

In `Windows` environment:
- All files and directories are readable; [chmod](posix_package_funcs.md#func-chmodstring-uint32-deprecated)() cannot change read permissions;
- In `Windows`, executable permissions for files are set via file extensions; all directories are executable; [chmod](posix_package_funcs.md#func-chmodstring-uint32-deprecated)() cannot change executable permissions for files and directories.

> **Note:**
>
> Will be deprecated in future versions.

Parameters:

- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - File path.
- mode: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - Permissions to modify.

Return value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Returns `0` on success, `-1` on failure. When `mode` is an invalid parameter, [chmod](posix_package_funcs.md#func-chmodstring-uint32-deprecated) ignores the parameter and returns `0`.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws exception when function parameter `path` contains null characters.

## func chown(String, UInt32, UInt32) <sup>(deprecated)</sup>

```cangjie
public func chown(path: String, owner: UInt32, group: UInt32): Int32
```

Function: Modifies file owner and owner group.

> **Note:**
>
> Will be deprecated in future versions.

Parameters:

- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - File path.
- owner: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - Owner `uid`.
- group: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - Specified `gid` parameter.

Return value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Returns `0` on success, `-1` on failure.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws exception when function parameter `path` contains null characters.

## func close(Int32) <sup>(deprecated)</sup>

```cangjie
public func close(fd: Int32): Int32
```

Function: Closes a file. [close](posix_package_funcs.md#func-closeint32-deprecated) will trigger data write-back to disk and release resources occupied by the file.

> **Note:**
>
> Will be deprecated in future versions.

Parameters:

- fd: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - File descriptor.

Return value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Returns `0` on success, `-1` on failure.

## func creat(String, UInt32) <sup>(deprecated)</sup>

```cangjie
public func creat(path: String, flag: UInt32): Int32
```

Function: Creates a file and returns its file descriptor, or returns `-1` on failure.

> **Note:**
>
> Will be deprecated in future versions.

Parameters:

- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - File path.
- flag: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - File creation permissions.

Return value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Returns file descriptor, or `-1` on failure.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws exception when function parameter `path` contains null characters.

## func dup(Int32) <sup>(deprecated)</sup>

```cangjie
public func dup(fd: Int32): Int32
```

Function: Duplicates the file descriptor specified by the old `fd` parameter and returns it. This new file descriptor and the old parameter `fd` reference the same file, sharing all file states. They share all locks, read/write positions, permissions, and flags.

> **Note:**
>
> Will be deprecated in future versions.

Parameters:

- fd: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - File descriptor.

Return value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Returns the smallest unused file descriptor, or `-1` on failure.

## func dup2(Int32, Int32) <sup>(deprecated)</sup>

```cangjie
public func dup2(fd: Int32, fd2: Int32): Int32
```

Function: Duplicates the file descriptor specified by the `oldfd` parameter and returns it to the `newfd` parameter. If the `newfd` parameter is an open file descriptor, the file specified by `newfd` will be closed first.

> **Note:**
>
> Will be deprecated in future versions.

Parameters:

- fd: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - File descriptor specified by `oldfd` parameter.
- fd2: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - File descriptor specified by `newfd` parameter.

Return value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - `fd2` file descriptor.

## func faccessat(Int32, String, Int32, Int32) <sup>(deprecated)</sup>

```cangjie
public func faccessat(fd: Int32, path: String, mode: Int32, flag: Int32): Int32
```

Function: Checks if the file corresponding to `fd` has certain permissions. Returns `0` if it does, otherwise returns `-1`.

`mode` specifies the permission to check, with possible values: [R_OK](posix_package_constants_vars.md#const-r_ok-deprecated), `W_OK`, [X_OK](posix_package_constants_vars.md#const-x_ok-deprecated), [F_OK](posix_package_constants_vars.md#const-f_ok-deprecated).

> **Note:**
>
> Will be deprecated in future versions.

Parameters:

- fd: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - File descriptor.
- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - File path.
- mode: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Permission to check.
- flag: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Obtained by bitwise OR of one or more of the following values: `(512)` performs access check using effective user and group IDs (default uses effective IDs); `(256)` if pathname is a symbolic link, does not dereference it but returns information about the link itself.

Return value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Returns `0` if the file has the specified permission, otherwise returns `-1`.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws exception when function parameter `path` contains null characters.

## func fchdir(Int32) <sup>(deprecated)</sup>

```cangjie
public func fchdir(fd: Int32): Int32
```

Function: Changes the current working directory of the calling process by specifying a file path descriptor.

> **Note:**
>
> Will be deprecated in future versions.

Parameters:

- fd: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Descriptor of the new file path.

Return value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Returns `0` on success, `-1` on failure.

## func fchmod(Int32, UInt32) <sup>(deprecated)</sup>

```cangjie
public func fchmod(fd: Int32, mode: UInt32): Int32
```

Function: Modifies access permissions for the file corresponding to the file descriptor.

> **Note:**
>
> Will be deprecated in future versions.

Parameters:

- fd: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - File descriptor.
- mode: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - Permissions to modify.

Return value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Returns `0` on success, `-1` on failure.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws exception when function parameter `path` contains null characters.

## func fchmodat(Int32, String, UInt32, Int32) <sup>(deprecated)</sup>

```cangjie
public func fchmodat(fd: Int32, path: String, mode: UInt32, flag: Int32): Int32
```

Function: Modifies access permissions for the file corresponding to the file descriptor.

- When `path` is relative and `fd` is the special value `AT_FDCWD`, the path is relative to the calling process's current working directory.
- When `path` is relative and `fd` is not `AT_FDCWD`, the path is relative to the directory referenced by `fd`.
- When `path` is absolute, the `fd` parameter is ignored.

> **Note:**
>
> Will be deprecated in future versions.

Parameters:

- fd: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - File descriptor.
- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - File path.
- mode: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - Permissions to modify.
- flag: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Can be `0`, or `(256)` if pathname is a symbolic link, does not dereference it but returns information about the link itself.

Return value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Returns `0` on success, `-1` on failure.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws exception when function parameter `path` contains null characters.

## func fchown(Int32, UInt32, UInt32) <sup>(deprecated)</sup>

```cangjie
public func fchown(fd: Int32, owner: UInt32, group: UInt32): Int32
```

Function: Modifies owner and owner group for the file corresponding to `fd`.

> **Note:**
>
> Will be deprecated in future versions.

Parameters:

- fd: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - File descriptor.
- owner: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - Owner `uid`.
- group: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - Specified `gid` parameter.

Return value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Returns `0` on success, `-1` on failure.

## func fchownat(Int32, String, UInt32, UInt32, Int32) <sup>(deprecated)</sup>

```cangjie
public func fchownat(fd: Int## func getcwd() <sup>(deprecated)</sup>

```cangjie
public func getcwd(): String
```

Function: Gets the absolute path of the current working directory of the executing process.

> **Note:**
>
> This function will be deprecated in future versions.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - Returns a string containing path information on success, or an empty string on failure.

## func getgid() <sup>(deprecated)</sup>

```cangjie
public func getgid(): UInt32
```

Function: Gets the group `ID`.

> **Note:**
>
> This function will be deprecated in future versions.

Return Value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The current group `ID`.

## func getgroups(Int32, CPointer\<UInt32>) <sup>(deprecated)</sup>

```cangjie
public unsafe func getgroups(size: Int32, gidArray: CPointer<UInt32>): Int32
```

Function: Gets the group codes of the current user's groups.

If the `size` parameter of `gidArray` is zero, the function only returns the number of groups the user belongs to without populating `gidArray` with `gid` values.

> **Note:**
>
> This function will be deprecated in future versions.

Parameters:

- size: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The number of `gid` values that `gidArray` can hold.
- gidArray: [CPointer](../../core/core_package_api/core_package_intrinsics.md#cpointert)\<[UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)> - Stores `gid` information.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Returns group codes on success, or `-1` on failure.

## func gethostname() <sup>(deprecated)</sup>

```cangjie
public func gethostname(): String
```

Function: Gets the hostname, which is typically the name of the host on a `TCP`/`IP` network.

> **Note:**
>
> This function will be deprecated in future versions.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - Returns the hostname string on success, or an empty string on failure.

## func getlogin() <sup>(deprecated)</sup>

```cangjie
public func getlogin(): String
```

Function: Gets the current login name.

> **Note:**
>
> This function will be deprecated in future versions.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - Returns the login name on success, or an empty string on failure.

## func getos() <sup>(deprecated)</sup>

```cangjie
public func getos(): String
```

Function: Gets Linux system information from the `/proc/version` file. Example: `Linux version 4.15.0-142-generic (buildd@lgw01-amd64-036) (gcc version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04)) #146-Ubuntu SMP Tue Apr 13 01:11:19 UTC 2021`.

> **Note:**
>
> This function will be deprecated in future versions.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - Returns the Linux system information string.

## func getpgid(Int32) <sup>(deprecated)</sup>

```cangjie
public func getpgid(pid: Int32): Int32
```

Function: Gets the `PGID` of the process specified by `pid`. If `pid` is zero, returns the process `ID` of the calling process.

> **Note:**
>
> This function will be deprecated in future versions.

Parameter:

- pid: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The target process `ID`.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Returns the process group `ID` on success, or `-1` on failure.

## func getpgrp() <sup>(deprecated)</sup>

```cangjie
public func getpgrp(): Int32
```

Function: Gets the parent process `ID` of the calling process.

> **Note:**
>
> This function will be deprecated in future versions.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Returns the parent process `ID` of the calling process.

## func getpid() <sup>(deprecated)</sup>

```cangjie
public func getpid(): Int32
```

Function: Gets the process `ID (PID)` of the calling process.

> **Note:**
>
> This function will be deprecated in future versions.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Returns the process `ID (PID)` of the calling process.

## func getppid() <sup>(deprecated)</sup>

```cangjie
public func getppid(): Int32
```

Function: Gets the parent process `ID` of the calling process.

> **Note:**
>
> This function will be deprecated in future versions.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Returns the parent process `ID` of the calling process.

## func getuid() <sup>(deprecated)</sup>

```cangjie
public func getuid(): UInt32
```

Function: Gets the real user `ID` of the calling process.

> **Note:**
>
> This function will be deprecated in future versions.

Return Value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The current real user `ID`.

## func isBlk(String) <sup>(deprecated)</sup>

```cangjie
public func isBlk(path: String): Bool
```

Function: Checks if the input object is a block device and returns a boolean value.

> **Note:**
>
> This function will be deprecated in future versions.

Parameter:

- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The file path.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if it is a block device, otherwise `false`.

## func isChr(String) <sup>(deprecated)</sup>

```cangjie
public func isChr(path: String): Bool
```

Function: Checks if the input object is a character device and returns a boolean value.

> **Note:**
>
> This function will be deprecated in future versions.

Parameter:

- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The file path.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if it is a character device, otherwise `false`.

## func isDir(String) <sup>(deprecated)</sup>

```cangjie
public func isDir(path: String): Bool
```

Function: Checks if the input object is a directory and returns a boolean value.

> **Note:**
>
> This function will be deprecated in future versions.

Parameter:

- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The file path.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if it is a directory, otherwise `false`.

## func isFIFO(String) <sup>(deprecated)</sup>

```cangjie
public func isFIFO(path: String): Bool
```

Function: Checks if the input object is a `FIFO` file and returns a boolean value.

> **Note:**
>
> This function will be deprecated in future versions.

Parameter:

- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The file path.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if it is a `FIFO` file, otherwise `false`.

## func isLnk(String) <sup>(deprecated)</sup>

```cangjie
public func isLnk(path: String): Bool
```

Function: Checks if the input object is a symbolic link and returns a boolean value.

> **Note:**
>
> This function will be deprecated in future versions.

Parameter:

- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The file path.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if it is a symbolic link, otherwise `false`.

## func isReg(String) <sup>(deprecated)</sup>

```cangjie
public func isReg(path: String): Bool
```

Function: Checks if the input object is a regular file and returns a boolean value.

> **Note:**
>
> This function will be deprecated in future versions.

Parameter:

- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The file path.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if it is a regular file, otherwise `false`.

## func isSock(String) <sup>(deprecated)</sup>

```cangjie
public func isSock(path: String): Bool
```

Function: Checks if the input object is a socket file and returns a boolean value.

> **Note:**
>
> This function will be deprecated in future versions.

Parameter:

- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The file path.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if it is a socket file, otherwise `false`.

## func isType(String, UInt32) <sup>(deprecated)</sup>

```cangjie
public func isType(path: String, mode: UInt32): Bool
```

Function: Checks if the file matches the specified mode. Returns `true` if it matches, otherwise `false`. The type is determined based on the mode value.

> **Note:**
>
> This function will be deprecated in future versions.

Parameters:

- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The file path.
- mode: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - The mode parameter.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the file matches the specified mode, otherwise `false`.

## func isatty(Int32) <sup>(deprecated)</sup>

```cangjie
public func isatty(fd: Int32): Bool
```

Function: Tests whether the file descriptor refers to a terminal. Returns `true` on success, otherwise `false`.

> **Note:**
>
> This function will be deprecated in future versions.

Parameter:

- fd: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The file descriptor.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` on success, otherwise `false`.

## func kill(Int32, Int32) <sup>(deprecated)</sup>

```cangjie
public func kill(pid: Int32, sig: Int32): Int32
```

Function: The system call can be used to send any signal to any process group or process.

- If `pid` is greater than `0`, the signal `sig` is sent to the process corresponding to `pid`.
- If `pid` equals `0`, then `sig` is sent to every process in the process group of the calling process.
- If `pid` equals `-1`, then `sig` is sent to every process for which the calling process has permission to send signals.
- If `pid` is less than `-1`, then `sig` is sent to every process in the process group whose `ID` is `-pid`.

> **Note:**
>
> This function will be deprecated in future versions.

Parameters:

- pid: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The process `ID`.
- sig: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The signal `ID`.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Returns `0` on success, otherwise `-1`.

## func killpg(Int32, Int32) <sup>(deprecated)</sup>

```cangjie
public func killpg(pgid: Int32, sig: Int32): Int32
```

Function: Sends the signal `sig` to the process group `pgrp`. If `pgrp` is `0`, [killpg](posix_package_funcs.md#func-killpgint32-int32-deprecated)() sends the signal to the process group of the calling process.

> **Note:**
>
> This function will be deprecated in future versions.

Parameters:

- pgid: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The group `ID`.
- sig: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - The signal `ID`.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Returns `0` on success, otherwise `-1`.## func lchown(String, UInt32, UInt32) <sup>(deprecated)</sup>

```cangjie
public func lchown(path: String, owner: UInt32, group: UInt32): Int32
```

Function: Changes the owner and group of a symbolic link itself.

> **Note:**
>
> This function will be deprecated in future versions.

Parameters:

- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - File path as a string.
- owner: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - Owner `uid`.
- group: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - Specified `gid` parameter.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Returns `0` on success, `-1` on failure.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws exception when the `path` parameter contains null characters.

## func link(String, String) <sup>(deprecated)</sup>

```cangjie
public func link(path: String, newpath: String): Int32
```

Function: Creates a link to an existing file, allowing multiple directory entries to reference the same `i-node`.

> **Note:**
>
> This function will be deprecated in future versions.

Parameters:

- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - File path.
- newpath: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Alternative file path.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Returns `0` on success, `-1` on error.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws exception when the `path` or `newPath` parameters contain null characters.

## func linkat(Int32, String, Int32, String, Int32) <sup>(deprecated)</sup>

```cangjie
public func linkat(fd: Int32, path: String, nfd: Int32, newPath: String, lflag: Int32): Int32
```

Function: Creates a file link relative to directory file descriptors.

- When `path` is relative and `fd` has the special value `AT_FDCWD`, the path is relative to the calling process's current working directory.
- When `path` is relative and `fd` is not `AT_FDCWD`, the path is relative to the directory referenced by `fd`.
- When `path` is absolute, the `fd` parameter is ignored.
- The same logic applies to `newPath`, except relative paths are resolved against the directory referenced by `nfd`.

> **Note:**
>
> This function will be deprecated in future versions.

Parameters:

- fd: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - File descriptor.
- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - File path.
- nfd: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Alternative file descriptor.
- newPath: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Alternative file path (existing `newpath` will not be overwritten).
- lflag: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - [AT_EMPTY_PATH](posix_package_constants_vars.md#const-at_empty_path-deprecated) or `AT_SYMLINK_FOLLOW` or `0`.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Returns `0` on success, `-1` on error.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws exception when the `path` or `newPath` parameters contain null characters.

## func lseek(Int32, Int64, Int32) <sup>(deprecated)</sup>

```cangjie
public func lseek(fd: Int32, offset: Int64, whence: Int32): Int64
```

Function: Controls the read/write position of a file. On success, returns the current position (byte offset from file start). Returns `-1` on error.

> **Note:**
>
> This function will be deprecated in future versions.

Parameters:

- fd: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Open file descriptor.
- offset: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Offset value.
- whence: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Control mode indicator.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Returns current read/write position (byte offset from file start) on success.

## func nice(Int32) <sup>(deprecated)</sup>

```cangjie
public func nice(inc: Int32): Int32
```

Function: Changes the priority of the current thread.

Returns new priority value on success, `-1` on failure. When `inc` exceeds `19`, caps at `19`. Only superusers can use negative `inc` values (higher priority, faster execution). Valid range: `+19` (lowest) to `-20` (highest).

> **Note:**
>
> This function will be deprecated in future versions.

Parameters:

- inc: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Priority increment, range `+19` (low) to `-20` (high).

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Returns new priority value.

## func open64(String, Int32) <sup>(deprecated)</sup>

```cangjie
public func open64(path: String, oflag: Int32): Int32
```

Function: Opens a file and returns a new file descriptor, or `-1` on failure.

- When `oflag` includes [O_CREAT](posix_package_constants_vars.md#const-o_creat-deprecated), file permissions can be set via parameters.
- [O_RDONLY](posix_package_constants_vars.md#const-o_rdonly-deprecated), [O_RDWR](posix_package_constants_vars.md#const-o_rdwr-deprecated), and [O_WRONLY](posix_package_constants_vars.md#const-o_wronly-deprecated) are mutually exclusive but can be combined with other flags like [O_APPEND](posix_package_constants_vars.md#const-o_append-deprecated).

> **Note:**
>
> This function will be deprecated in future versions.

Parameters:

- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - File path.
- oflag: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - File opening mode.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Returns new file descriptor on success, `-1` on failure.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws exception when the `path` parameter contains null characters.

## func open64(String, Int32, UInt32) <sup>(deprecated)</sup>

```cangjie
public func open64(path: String, oflag: Int32, flag: UInt32): Int32
```

Function: Opens a file and returns a new file descriptor, or `-1` on failure.

- When `oflag` includes [O_CREAT](posix_package_constants_vars.md#const-o_creat-deprecated), file permissions can be set via parameters.
- [O_RDONLY](posix_package_constants_vars.md#const-o_rdonly-deprecated), [O_RDWR](posix_package_constants_vars.md#const-o_rdwr-deprecated), and [O_WRONLY](posix_package_constants_vars.md#const-o_wronly-deprecated) are mutually exclusive but can be combined with other flags like [O_APPEND](posix_package_constants_vars.md#const-o_append-deprecated).

> **Note:**
>
> This function will be deprecated in future versions.

Parameters:

- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - File path.
- oflag: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - File opening mode.
- flag: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - When `oflag` includes [O_CREAT](posix_package_constants_vars.md#const-o_creat-deprecated) and a new file is created, `flag` specifies permissions; otherwise, `flag` doesn't modify file permissions.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Returns new file descriptor on success, `-1` on failure.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws exception when the `path` parameter contains null characters.

## func openat(Int32, String, Int32) <sup>(deprecated)</sup>

```cangjie
public func openat(fd: Int32, path: String, oflag: Int32): Int32
```

Function: Opens a file relative to a directory descriptor and returns a new file descriptor, or `-1` on failure.

- When `oflag` includes [O_CREAT](posix_package_constants_vars.md#const-o_creat-deprecated), file permissions can be set via parameters.
- [O_RDONLY](posix_package_constants_vars.md#const-o_rdonly-deprecated), [O_RDWR](posix_package_constants_vars.md#const-o_rdwr-deprecated), and [O_WRONLY](posix_package_constants_vars.md#const-o_wronly-deprecated) are mutually exclusive but can be combined with other flags like [O_APPEND](posix_package_constants_vars.md#const-o_append-deprecated).

> **Note:**
>
> This function will be deprecated in future versions.

Parameters:

- fd: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Directory file descriptor.
- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - File path.
- oflag: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - File opening mode.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Returns new file descriptor on success, `-1` on failure.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws exception when the `path` parameter contains null characters.

## func openat(Int32, String, Int32, UInt32) <sup>(deprecated)</sup>

```cangjie
public func openat(fd: Int32, path: String, oflag: Int32, flag: UInt32): Int32
```

Function: Opens a file relative to a directory descriptor and returns a new file descriptor, or `-1` on failure.

- When `oflag` includes [O_CREAT](posix_package_constants_vars.md#const-o_creat-deprecated), file permissions can be set via parameters.
- [O_RDONLY](posix_package_constants_vars.md#const-o_rdonly-deprecated), [O_RDWR](posix_package_constants_vars.md#const-o_rdwr-deprecated), and [O_WRONLY](posix_package_constants_vars.md#const-o_wronly-deprecated) are mutually exclusive but can be combined with other flags like [O_APPEND](posix_package_constants_vars.md#const-o_append-deprecated).

> **Note:**
>
> This function will be deprecated in future versions.

Parameters:

- fd: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Directory file descriptor.
- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - File path.
- oflag: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - File opening mode.
- flag: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - When `oflag` includes [O_CREAT](posix_package_constants_vars.md#const-o_creat-deprecated) and a new file is created, `flag` specifies permissions; otherwise, `flag` doesn't modify file permissions.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Returns new file descriptor on success, `-1` on failure.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws exception when the `path` parameter contains null characters.

## func openat64(Int32, String, Int32) <sup>(deprecated)</sup>

```cangjie
public func openat64(fd: Int32, path: String, oflag: Int32): Int32
```

Function: Opens a file relative to a directory descriptor and returns a new file descriptor, or `-1` on failure.

- When `oflag` includes [O_CREAT](posix_package_constants_vars.md#const-o_creat-deprecated), file permissions can be set via parameters.
- [O_RDONLY](posix_package_constants_vars.md#const-o_rdonly-deprecated), [O_RDWR](posix_package_constants_vars.md#const-o_rdwr-deprecated), and [O_WRONLY](posix_package_constants_vars.md#const-o_wronly-deprecated) are mutually exclusive but can be combined with other flags like [O_APPEND](posix_package_constants_vars.md#const-o_append-deprecated).

> **Note:**
>
> This function will be deprecated in future versions.

Parameters:

- fd: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Directory file descriptor.
- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - File path.
- oflag: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - File opening mode.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Returns new file descriptor on success, `-1` on failure.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws exception when the `path` parameter contains null characters.

## func openat64(Int32, String, Int32, UInt32) <sup>(deprecated)</sup>

```cangjie
public func openat64(fd: Int32, path: String, oflag: Int32, flag: UInt32): Int32
```

Function: Opens a file relative to a directory descriptor and returns a new file descriptor, or `-1` on failure.

- When `oflag` includes [O_CREAT](posix_package_constants_vars.md#const-o_creat-deprecated), file permissions can be set via parameters.
- [O_RDONLY](posix_package_constants_vars.md#const-o_rdonly-deprecated), [O_RDWR](posix_package_constants_vars.md#const-o_rdwr-deprecated), and [O_WRONLY](posix_package_constants_vars.md#const-o_wronly-deprecated) are mutually exclusive but can be combined with other flags like [O_APPEND](posix_package_constants_vars.md#const-o_append-deprecated).

> **Note:**
>
> This function will be deprecated in future versions.

Parameters:

- fd: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Directory file descriptor.
- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - File path.
- oflag: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - File opening mode.
- flag: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - When `oflag` includes [O_CREAT](posix_package_constants_vars.md#const-o_creat-deprecated) and a new file is created, `flag` specifies permissions; otherwise, `flag` doesn't modify file permissions.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Returns new file descriptor on success, `-1` on failure.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws exception when the `path` parameter contains null characters.

## func pread(Int32, CPointer\<UInt8>, UIntNative, Int32) <sup>(deprecated)</sup>

```cangjie
public unsafe func pread(fd: Int32, buffer: CPointer<UInt8>, nbyte: UIntNative, offset: Int32): IntNative
```

Function: Reads `nbyte` bytes from the file referenced by `fd` into the memory pointed to by `buffer` at specified offset. Returns actual bytes read (0 indicates EOF or read error). File position changes accordingly.

Recommended: `nbyte` should match `buffer` size, with `buffer` size ≤ 150## func rename(String, String) <sup>(deprecated)</sup>

```cangjie
public func rename(oldName: String, newName: String): Int32
```

Function: Renames a file, moving it to a new directory if necessary. Any other hard links to the file are unaffected. File descriptors opened with the old path remain valid.

Various constraints determine whether the rename operation succeeds, as detailed below:

- If `newName` already exists, it will be atomically replaced such that another process attempting to access `newName` will not find it missing, though there may be a brief window where both old and new paths reference the file being renamed.
- If the old and new paths refer to existing hard links of the same file, the rename operation performs no action and returns success.
- If `newName` exists but the operation fails for any reason, the rename guarantees to preserve the instance of `newName`.
- `oldName` may specify a directory. In this case, `newName` must either not exist or specify an empty directory.
- If the old path refers to a symbolic link, the link itself will be renamed; if the new path refers to a symbolic link, that link will be overwritten.

> **Note:**
>
> This function will be deprecated in future versions.

Parameters:

- oldName: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Filename (including path).
- newName: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Filename (including path).

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Returns `0` on success, `-1` on error.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when parameters `oldName` or `newName` contain null characters.

## func renameat(Int32, String, Int32, String) <sup>(deprecated)</sup>

```cangjie
public func renameat(oldfd: Int32, oldName: String, newfd: Int32, newName: String): Int32
```

Function: Renames a file, moving it to a new directory if necessary.

[renameat](posix_package_funcs.md#func-renameatint32-string-int32-string-deprecated)() behaves identically to [rename](posix_package_funcs.md#func-renamestring-string-deprecated)(), with the following differences:

- If `oldName` is a relative path and `oldfd` equals the special value `AT_FDCWD`, the path is resolved relative to the calling process's current working directory.
- If `oldName` is a relative path and `oldfd` is not `AT_FDCWD`, the path is resolved relative to the directory referenced by `oldfd`.
- If `oldName` is an absolute path, the `oldfd` parameter is ignored.
- The same rules apply to `newName`, except relative paths are resolved relative to the directory referenced by `newfd`.

> **Note:**
>
> This function will be deprecated in future versions.

Parameters:

- oldfd: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - File descriptor.
- oldName: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Filename.
- newfd: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - File descriptor.
- newName: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Filename.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Returns `0` on success, `-1` on error.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when parameters `oldName` or `newName` contain null characters.

## func setgid(UInt32) <sup>(deprecated)</sup>

```cangjie
public func setgid(id: UInt32): Int32
```

Function: Sets the effective group ID of the calling process, requiring appropriate privileges.

> **Note:**
>
> This function will be deprecated in future versions.

Parameters:

- id: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - Effective group ID number for the calling process.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Returns `0` on success, `-1` on failure.

## func sethostname(String) <sup>(deprecated)</sup>

```cangjie
public func sethostname(buf: String): Int32
```

Function: Sets the hostname, callable only by superusers.

> **Note:**
>
> This function will be deprecated in future versions.

Parameters:

- buf: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Hostname to set.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Returns `0` on success, `-1` on failure.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if parameter `buf` contains null characters.

## func setpgid(Int32, Int32) <sup>(deprecated)</sup>

```cangjie
public func setpgid(pid: Int32, pgrp: Int32): Int32
```

Function: Sets the group ID of the process specified by `pid` to the group ID specified by `pgrp`. If `pid` is `0`, the current process's group ID is used.

> **Note:**
>
> This function will be deprecated in future versions.

Parameters:

- pid: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Process ID.
- pgrp: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Process group ID.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Returns the group ID on success, `-1` on failure.

## func setpgrp() <sup>(deprecated)</sup>

```cangjie
public func setpgrp(): Int32
```

Function: Sets the group ID of the current process to its process ID. Equivalent to calling [setpgid](posix_package_funcs.md#func-setpgidint32-int32-deprecated)(0, 0).

> **Note:**
>
> This function will be deprecated in future versions.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Returns the current process's group ID on success, `-1` on failure.

## func setuid(UInt32) <sup>(deprecated)</sup>

```cangjie
public func setuid(id: UInt32): Int32
```

Function: Sets the effective user ID of the calling process, requiring appropriate privileges.

> **Note:**
>
> This function will be deprecated in future versions.

Parameters:

- id: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - Effective user ID number for the calling process.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Returns `0` on success, `-1` on failure.

## func symlink(String, String) <sup>(deprecated)</sup>

```cangjie
public func symlink(path: String, symPath: String): Int32
```

Function: Creates a symbolic link named `symPath` pointing to the file specified by `path`.

- Symbolic links are interpreted at runtime as if the link's contents were substituted into the path being traversed.
- Symbolic links may contain `..` path components, which (when used at the start) refer to the parent directory of where the link resides.
- Symbolic links (soft links) may point to existing or non-existent files (dangling links).
- Symbolic link permissions are irrelevant; ownership is ignored when following links but checked when deleting/renaming links in sticky-bit directories.
- If `symPath` exists, it will not be overwritten.

> **Note:**
>
> This function will be deprecated in future versions.

Parameters:

- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - File path.
- symPath: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Link file path.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Returns `0` on success, `-1` on error.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when parameters `path` or `symPath` contain null characters.

## func symlinkat(String, Int32, String) <sup>(deprecated)</sup>

```cangjie
public func symlinkat(path: String, fd: Int32, symPath: String): Int32
```

Function: Creates a symbolic link named `symPath` pointing to the file specified by `path` and `fd`.

- If `symPath` is relative and `fd` equals `AT_FDCWD`, the path is resolved relative to the current working directory.
- If `symPath` is relative and `fd` is not `AT_FDCWD`, the path is resolved relative to the directory referenced by `fd`.
- If `symPath` is absolute, the `fd` parameter is ignored.

> **Note:**
>
> This function will be deprecated in future versions.

Parameters:

- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - File path.
- fd: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - File descriptor.
- symPath: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Link file path.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Returns `0` on success, `-1` on error.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when parameters `path` or `symPath` contain null characters.

## func ttyname(Int32) <sup>(deprecated)</sup>

```cangjie
public func ttyname(fd: Int32): String
```

Function: Returns the terminal name.

> **Note:**
>
> This function will be deprecated in future versions.

Parameters:

- fd: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - File descriptor.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - Returns the pathname on success, `NULL` on failure.

## func umask(UInt32) <sup>(deprecated)</sup>

```cangjie
public func umask(cmask: UInt32): UInt32
```

Function: Sets the file mode creation mask.

> **Note:**
>
> This function will be deprecated in future versions.

Parameters:

- cmask: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - File permission parameter.

Return Value:

- [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32) - Returns the previous value of the file mode mask.

## func unlink(String) <sup>(deprecated)</sup>

```cangjie
public func unlink(path: String): Int32
```

Function: Removes a file from the filesystem.

- If `path` is the last link to a file and no processes have it open, the file is deleted and its space becomes reusable.
- If `path` is the last link but processes still have the file open, the file persists until the last file descriptor is closed.
- If `path` refers to a symbolic link, the link is removed.
- If `path` refers to a socket, FIFO, or device, the file is deleted but open instances may continue to be used.

> **Note:**
>
> This function will be deprecated in future versions.

Parameters:

- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - File path.

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Returns `0` on success, `-1` on error.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when parameter `path` contains null characters.

## func unlinkat(Int32, String, Int32) <sup>(deprecated)</sup>

```cangjie
public func unlinkat(fd: Int32, path: String, ulflag: Int32): Int32
```

Function: Removes a file from the filesystem.

This system call behaves identically to [unlink](posix_package_funcs.md#func-unlinkstring-deprecated), except for the following differences:

- If `path` is relative and `fd` equals `AT_FDCWD`, the path is resolved relative to the current working directory.
- If `path` is relative and `fd` is not `AT_FDCWD`, the path is resolved relative to the directory referenced by `fd`.
- If `path` is absolute, the `fd` parameter is ignored.

> **Note:**
>
> This function will be deprecated in future versions.

Parameters:

- fd: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - File descriptor.
- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - File path.
- ulflag: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - May be `0` or a bitwise OR of flags controlling operation behavior (currently only supports [AT_REMOVEDIR](posix_package_constants_vars.md#const-at_removedir-deprecated)).

Return Value:

- [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - Returns `0` on success, `-1` on error.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when parameter `path` contains null characters.

## func write(Int32, CPointer\<UInt8>, UIntNative) <sup>(deprecated)</sup>

```cangjie
public unsafe func write(fd: Int32, buffer: CPointer<UInt8>, nbyte: UIntNative): IntNative
```

Function: Writes `nbyte` bytes from memory pointed to by `buffer` into the file referenced by `fd`. The file's read/write position is updated accordingly.

Recommended that `nbyte` matches `buffer`'s size and does not exceed 150,000 bytes.

> **Note:**
>
> This function will be deprecated in future versions.

Parameters:

- fd: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32) - File descriptor for writing.
- buffer: [CPointer](../../core/core_package_api/core_package_intrinsics.md#cpointert)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)> - Buffer container.
- nbyte: [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative) - Number of bytes to write (recommended to use `buffer.size`).

Return Value:

- [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative) - Returns actual bytes written, `-1` on error.