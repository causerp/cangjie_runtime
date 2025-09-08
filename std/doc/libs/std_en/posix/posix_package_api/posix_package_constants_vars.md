# Constants & Variables

## const AT_EMPTY_PATH <sup>(deprecated)</sup>

```cangjie
public const AT_EMPTY_PATH: Int32 = 0x1000
```

Function: Represents a file descriptor returned when an empty path (i.e., no file or directory specified) is encountered in the file system. Applicable to functions `open`, `open64`, `openat`, `openat64`, belonging to the function parameter `oflag`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const AT_FDCWD <sup>(deprecated)</sup>

```cangjie
public const AT_FDCWD: Int32
```

Function: Represents a special file descriptor constant for relative path operations in the file system, used to specify the starting point for resolving relative paths when using the `*at()` series of system calls. Primarily used in functions like `fchmodat`, `fchownat`, `linkat`, `renameat`, `symlinkat`, `unlinkat`, belonging to the function parameter `fd`. Values across different systems are:

- macOS: -0x2
- Others: -0x64

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const AT_REMOVEDIR <sup>(deprecated)</sup>

```cangjie
public const AT_REMOVEDIR: Int32 = 0x200
```

Function: If the [AT_REMOVEDIR](posix_package_constants_vars.md#const-at_removedir-deprecated) flag is specified, performs an operation equivalent to `rmdir(2)` on `pathname`. Applicable to functions `open`, `open64`, `openat`, `openat64`, belonging to the function parameter `oflag`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const AT_SYMLINK_FOLLOW <sup>(deprecated)</sup>

```cangjie
public const AT_SYMLINK_FOLLOW: Int32
```

Function: Represents a flag controlling symbolic link resolution behavior, specifying whether to follow the target file pointed to by a symbolic link during operations. Typically used in combination with `AT_FDCWD`. Without this flag, most system calls operate directly on the symbolic link itself (e.g., reading the link path). With this flag, system calls first resolve the symbolic link and then operate on its target file. Primarily used in functions like `linkat`, `unlinkat`, belonging to the function parameter `fd`. Values across different systems are:

- macOS: 0x040
- Others: 0x400

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const F_OK <sup>(deprecated)</sup>

```cangjie
public const F_OK: Int32 = 0x0
```

Function: Tests for file existence. Applicable to functions [access](posix_package_funcs.md#func-accessstring-int32-deprecated), [faccessat](posix_package_funcs.md#func-faccessatint32-string-int32-int32-deprecated), belonging to the function parameter `mode`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const O_APPEND <sup>(deprecated)</sup>

```cangjie
public const O_APPEND: Int32
```

Function: When reading or writing a file, data will be moved from the end of the file. That is, written data will be appended to the file's end. Applicable to functions `open`, `open64`, `openat`, `openat64`, belonging to the function parameter `oflag`. Values across different systems are:

- macOS: 0x00000008
- Windows: 0x8
- Others: 0x400

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const O_CLOEXEC <sup>(deprecated)</sup>

```cangjie
public const O_CLOEXEC: Int32
```

Function: Essential in certain multithreaded programs because using a separate `fcntl(2)` `F_SETFD` operation to set the `FD_CLOEXEC` flag is insufficient to avoid race conditions when one thread opens a file descriptor while another executes `fork(2)` plus `execve(2)`. Applicable to functions `open`, `open64`, `openat`, `openat64`, belonging to the function parameter `oflag`. Values across different systems are:

- macOS: 0x01000000
- Others: 0x80000

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const O_CREAT <sup>(deprecated)</sup>

```cangjie
public const O_CREAT: Int32
```

Function: Automatically creates the file if it does not exist. Applicable to functions `open`, `open64`, `openat`, `openat64`, belonging to the function parameter `oflag`. Values across different systems are:

- macOS: 0x00000200
- Windows: 0x100
- Others: 0x40

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const O_DIRECTORY <sup>(deprecated)</sup>

```cangjie
public const O_DIRECTORY: Int32
```

Function: Fails to open the file if `pathname` does not specify a directory. Applicable to functions `open`, `open64`, `openat`, `openat64`, belonging to the function parameter `oflag`. Values across different systems are:

- macOS: 0x00100000
- Others: 0x80000

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const O_DSYNC <sup>(deprecated)</sup>

```cangjie
public const O_DSYNC: Int32
```

Function: Each write operation waits for physical `I/O` completion but does not wait for file attribute updates if the write operation does not affect reading the newly written data. Applicable to functions `open`, `open64`, `openat`, `openat64`, belonging to the function parameter `oflag`. Values across different systems are:

- macOS: 0x400000
- Others: 0x1000

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const O_EXCL <sup>(deprecated)</sup>

```cangjie
public const O_EXCL: Int32
```

Function: When combined with [O_CREAT](posix_package_constants_vars.md#const-o_creat-deprecated), checks if the file exists. If the file does not exist, it is created; otherwise, opening fails. Additionally, if both [O_CREAT](posix_package_constants_vars.md#const-o_creat-deprecated) and [O_EXCL](posix_package_constants_vars.md#const-o_excl-deprecated) are set and the file to be opened is a symbolic link, opening fails. Applicable to functions `open`, `open64`, `openat`, `openat64`, belonging to the function parameter `oflag`. Values across different systems are:

- macOS: 0x00000800
- Windows: 0x400
- Others: 0x80

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const O_NOCTTY <sup>(deprecated)</sup>

```cangjie
public const O_NOCTTY: Int32
```

Function: If the file to be opened is a terminal device, it will not become the controlling terminal for this process. Applicable to functions `open`, `open64`, `openat`, `openat64`, belonging to the function parameter `oflag`. Values across different systems are:

- macOS: 0x00020000
- Others: 0x100

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const O_NOFOLLOW <sup>(deprecated)</sup>

```cangjie
public const O_NOFOLLOW: Int32
```

Function: Fails to open the file if `pathname` specifies a single symbolic link. Applicable to functions `open`, `open64`, `openat`, `openat64`, belonging to the function parameter `oflag`. Values across different systems are:

- macOS: 0x00000100
- Others: 0x20000

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const O_NONBLOCK <sup>(deprecated)</sup>

```cangjie
public const O_NONBLOCK: Int32
```

Function: Opens the file in non-blocking mode, meaning `I/O` operations will not cause the calling process to wait. Applicable to functions `open`, `open64`, `openat`, `openat64`, belonging to the function parameter `oflag`. Values across different systems are:

- macOS: 0x00000004
- Others: 0x800

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const O_RDONLY <sup>(deprecated)</sup>

```cangjie
public const O_RDONLY: Int32 = 0x0
```

Function: Opens the file in read-only mode. Applicable to functions `open`, `open64`, `openat`, `openat64`, belonging to the function parameter `oflag`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const O_RDWR <sup>(deprecated)</sup>

```cangjie
public const O_RDWR: Int32 = 0x2
```

Function: Opens the file in read-write mode. Applicable to functions `open`, `open64`, `openat`, `openat64`, belonging to the function parameter `oflag`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const O_RSYNC <sup>(deprecated)</sup>

```cangjie
public const O_RSYNC: Int32 = 0x101000
```

Function: This flag affects only read operations and must be used in combination with [O_SYNC](posix_package_constants_vars.md#const-o_sync-deprecated) or [O_DSYNC](posix_package_constants_vars.md#const-o_dsync-deprecated). If necessary, it causes read calls to block until the data being read (and possibly metadata) is flushed to disk. Applicable to functions `open`, `open64`, `openat`, `openat64`, belonging to the function parameter `oflag`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const O_SYNC <sup>(deprecated)</sup>

```cangjie
public const O_SYNC: Int32
```

Function: Opens the file synchronously. Applicable to functions `open`, `open64`, `openat`, `openat64`, belonging to the function parameter `oflag`. Values across different systems are:

- macOS: 0x0080
- Others: 0x101000

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const O_TRUNC <sup>(deprecated)</sup>

```cangjie
public const O_TRUNC: Int32
```

Function: If the file exists and is opened for writing, this flag truncates the file length to 0, erasing any previously stored data. Applicable to functions `open`, `open64`, `openat`, `openat64`, belonging to the function parameter `oflag`. Values across different systems are:

- macOS: 0x00000400
- Others: 0x200

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const O_WRONLY <sup>(deprecated)</sup>

```cangjie
public const O_WRONLY: Int32 = 0x1
```

Function: Opens the file in write-only mode. Applicable to functions `open`, `open64`, `openat`, `openat64`, belonging to the function parameter `oflag`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const R_OK <sup>(deprecated)</sup>

```cangjie
public const R_OK: Int32 = 0x4
```

Function: Tests for read permissions on a file. Applicable to functions [access](posix_package_funcs.md#func-accessstring-int32-deprecated), [faccessat](posix_package_funcs.md#func-faccessatint32-string-int32-int32-deprecated), belonging to the function parameter `mode`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const SEEK_CUR <sup>(deprecated)</sup>

```cangjie
public const SEEK_CUR: Int32 = 0x1
```

Function: Adds the offset to the current read or write position. Applicable to function [lseek](posix_package_funcs.md#func-lseekint32-int64-int32-deprecated), belonging to the function parameter `whence`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const SEEK_END <sup>(deprecated)</sup>

```cangjie
public const SEEK_END: Int32 = 0x2
```

Function: Sets the read/write position to the end of the file and adds the offset. Applicable to function [lseek](posix_package_funcs.md#func-lseekint32-int64-int32-deprecated), belonging to the function parameter `whence`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const SEEK_SET <sup>(deprecated)</sup>

```cangjie
public const SEEK_SET: Int32 = 0x0
```

Function: The offset parameter specifies the new read/write position. Applicable to function [lseek](posix_package_funcs.md#func-lseekint32-int64-int32-deprecated), belonging to the function parameter `whence`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const SIGABRT <sup>(deprecated)</sup>

```cangjie
public const SIGABRT: Int32 = 0x6
```

Function: Abnormal termination; default action is termination. Applicable to functions [kill](posix_package_funcs.md#func-killint32-int32-deprecated), [killpg](posix_package_funcs.md#func-killpgint32-int32-deprecated), belonging to the function parameter `sig`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const SIGALRM <sup>(deprecated)</sup>

```cangjie
public const SIGALRM: Int32 = 0xE
```

Function: Timer expiration; default action is termination. Applicable to functions [kill](posix_package_funcs.md#func-killint32-int32-deprecated), [killpg](posix_package_funcs.md#func-killpgint32-int32-deprecated), belonging to the function parameter `sig`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)## const SIGBUS <sup>(deprecated)</sup>

```cangjie
public const SIGBUS: Int32
```

Function: Hardware fault, default action terminates process. Applicable functions: [kill](posix_package_funcs.md#func-killint32-int32-deprecated), [killpg](posix_package_funcs.md#func-killpgint32-int32-deprecated), belongs to function parameter `sig`. Values across different systems:

- macOS: 0xA
- Other cases: 0x7

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const SIGCHLD <sup>(deprecated)</sup>

```cangjie
public const SIGCHLD: Int32
```

Function: Child process status change, default action terminates process. Applicable functions: [kill](posix_package_funcs.md#func-killint32-int32-deprecated), [killpg](posix_package_funcs.md#func-killpgint32-int32-deprecated), belongs to function parameter `sig`. Values across different systems:

- macOS: 0x14
- Other cases: 0x11

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const SIGCONT <sup>(deprecated)</sup>

```cangjie
public const SIGCONT: Int32
```

Function: Continue paused process, default action continues or ignores. Applicable functions: [kill](posix_package_funcs.md#func-killint32-int32-deprecated), [killpg](posix_package_funcs.md#func-killpgint32-int32-deprecated), belongs to function parameter `sig`. Values across different systems:

- macOS: 0x13
- Other cases: 0x12

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const SIGFPE <sup>(deprecated)</sup>

```cangjie
public const SIGFPE: Int32 = 0x8
```

Function: Arithmetic error, default action terminates process. Applicable functions: [kill](posix_package_funcs.md#func-killint32-int32-deprecated), [killpg](posix_package_funcs.md#func-killpgint32-int32-deprecated), belongs to function parameter `sig`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const SIGHUP <sup>(deprecated)</sup>

```cangjie
public const SIGHUP: Int32 = 0x1
```

Function: Connection disconnected, default action terminates process. Applicable functions: [kill](posix_package_funcs.md#func-killint32-int32-deprecated), [killpg](posix_package_funcs.md#func-killpgint32-int32-deprecated), belongs to function parameter `sig`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const SIGILL <sup>(deprecated)</sup>

```cangjie
public const SIGILL: Int32 = 0x4
```

Function: Invalid hardware instruction, default action terminates process. Applicable functions: [kill](posix_package_funcs.md#func-killint32-int32-deprecated), [killpg](posix_package_funcs.md#func-killpgint32-int32-deprecated), belongs to function parameter `sig`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const SIGINT <sup>(deprecated)</sup>

```cangjie
public const SIGINT: Int32 =  0x2
```

Function: Terminal interrupt character, default action terminates process. Applicable functions: [kill](posix_package_funcs.md#func-killint32-int32-deprecated), [killpg](posix_package_funcs.md#func-killpgint32-int32-deprecated), belongs to function parameter `sig`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const SIGIO <sup>(deprecated)</sup>

```cangjie
public const SIGIO: Int32
```

Function: Asynchronous `IO`, default action terminates process. Applicable functions: [kill](posix_package_funcs.md#func-killint32-int32-deprecated), [killpg](posix_package_funcs.md#func-killpgint32-int32-deprecated), belongs to function parameter `sig`. Values across different systems:

- macOS: 0x17
- Other cases: 0x1D

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const SIGIOT <sup>(deprecated)</sup>

```cangjie
public const SIGIOT: Int32 = 0x6
```

Function: Hardware fault, default action terminates process. Applicable functions: [kill](posix_package_funcs.md#func-killint32-int32-deprecated), [killpg](posix_package_funcs.md#func-killpgint32-int32-deprecated), belongs to function parameter `sig`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const SIGKILL <sup>(deprecated)</sup>

```cangjie
public const SIGKILL: Int32 = 0x9
```

Function: Termination, default action terminates process. Applicable functions: [kill](posix_package_funcs.md#func-killint32-int32-deprecated), [killpg](posix_package_funcs.md#func-killpgint32-int32-deprecated), belongs to function parameter `sig`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const SIGPIPE <sup>(deprecated)</sup>

```cangjie
public const SIGPIPE: Int32 = 0xD
```

Function: Write to pipe with no reader, default action terminates process. Applicable functions: [kill](posix_package_funcs.md#func-killint32-int32-deprecated), [killpg](posix_package_funcs.md#func-killpgint32-int32-deprecated), belongs to function parameter `sig`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const SIGPROF <sup>(deprecated)</sup>

```cangjie
public const SIGPROF: Int32 = 0x1B
```

Function: Profiling timer expired, default action terminates process. Applicable functions: [kill](posix_package_funcs.md#func-killint32-int32-deprecated), [killpg](posix_package_funcs.md#func-killpgint32-int32-deprecated), belongs to function parameter `sig`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const SIGPWR <sup>(deprecated)</sup>

```cangjie
public const SIGPWR: Int32 = 0x1E
```

Function: Power failure/restart, invalid system call, default action terminates process. Applicable functions: [kill](posix_package_funcs.md#func-killint32-int32-deprecated), [killpg](posix_package_funcs.md#func-killpgint32-int32-deprecated), belongs to function parameter `sig`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const SIGQUIT <sup>(deprecated)</sup>

```cangjie
public const SIGQUIT: Int32 = 0x3
```

Function: Terminal quit character, default action terminates process. Applicable functions: [kill](posix_package_funcs.md#func-killint32-int32-deprecated), [killpg](posix_package_funcs.md#func-killpgint32-int32-deprecated), belongs to function parameter `sig`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const SIGSEGV <sup>(deprecated)</sup>

```cangjie
public const SIGSEGV: Int32 = 0xB
```

Function: Invalid memory reference, default action terminates process. Applicable functions: [kill](posix_package_funcs.md#func-killint32-int32-deprecated), [killpg](posix_package_funcs.md#func-killpgint32-int32-deprecated), belongs to function parameter `sig`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const SIGSTKFLT <sup>(deprecated)</sup>

```cangjie
public const SIGSTKFLT: Int32 = 0x10
```

Function: Coprocessor stack fault, default action terminates process. Applicable functions: [kill](posix_package_funcs.md#func-killint32-int32-deprecated), [killpg](posix_package_funcs.md#func-killpgint32-int32-deprecated), belongs to function parameter `sig`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const SIGSTOP <sup>(deprecated)</sup>

```cangjie
public const SIGSTOP: Int32
```

Function: Stop process, default action terminates process. Applicable functions: [kill](posix_package_funcs.md#func-killint32-int32-deprecated), [killpg](posix_package_funcs.md#func-killpgint32-int32-deprecated), belongs to function parameter `sig`. Values across different systems:

- macOS: 0x11
- Other cases: 0x13

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const SIGSYS <sup>(deprecated)</sup>

```cangjie
public const SIGSYS: Int32
```

Function: Termination, default action terminates process and generates core dump for debugging analysis. Applicable functions: [kill](posix_package_funcs.md#func-killint32-int32-deprecated), [killpg](posix_package_funcs.md#func-killpgint32-int32-deprecated), belongs to function parameter `sig`. Values across different systems:

- macOS: 0xC
- Other cases: 0x1F

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const SIGTERM <sup>(deprecated)</sup>

```cangjie
public const SIGTERM: Int32 = 0xF
```

Function: Termination, default action terminates process. Applicable functions: [kill](posix_package_funcs.md#func-killint32-int32-deprecated), [killpg](posix_package_funcs.md#func-killpgint32-int32-deprecated), belongs to function parameter `sig`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const SIGTRAP <sup>(deprecated)</sup>

```cangjie
public const SIGTRAP: Int32 = 0x5
```

Function: Hardware fault, default action terminates process. Applicable functions: [kill](posix_package_funcs.md#func-killint32-int32-deprecated), [killpg](posix_package_funcs.md#func-killpgint32-int32-deprecated), belongs to function parameter `sig`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const SIGTSTP <sup>(deprecated)</sup>

```cangjie
public const SIGTSTP: Int32
```

Function: Terminal stop character, default action terminates process. Applicable functions: [kill](posix_package_funcs.md#func-killint32-int32-deprecated), [killpg](posix_package_funcs.md#func-killpgint32-int32-deprecated), belongs to function parameter `sig`. Values across different systems:

- macOS: 0x12
- Other cases: 0x14

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const SIGTTIN <sup>(deprecated)</sup>

```cangjie
public const SIGTTIN: Int32 = 0x15
```

Function: Background read from control `tty`, default action terminates process. Applicable functions: [kill](posix_package_funcs.md#func-killint32-int32-deprecated), [killpg](posix_package_funcs.md#func-killpgint32-int32-deprecated), belongs to function parameter `sig`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const SIGTTOU <sup>(deprecated)</sup>

```cangjie
public const SIGTTOU: Int32 = 0x16
```

Function: Background write to control `tty`, default action terminates process. Applicable functions: [kill](posix_package_funcs.md#func-killint32-int32-deprecated), [killpg](posix_package_funcs.md#func-killpgint32-int32-deprecated), belongs to function parameter `sig`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const SIGURG <sup>(deprecated)</sup>

```cangjie
public const SIGURG: Int32
```

Function: Urgent condition (socket), default action ignored. Applicable functions: [kill](posix_package_funcs.md#func-killint32-int32-deprecated), [killpg](posix_package_funcs.md#func-killpgint32-int32-deprecated), belongs to function parameter `sig`. Values across different systems:

- macOS: 0x10
- Other cases: 0x17

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const SIGUSR1 <sup>(deprecated)</sup>

```cangjie
public const SIGUSR1: Int32
```

Function: User-defined signal, default action terminates process. Applicable functions: [kill](posix_package_funcs.md#func-killint32-int32-deprecated), [killpg](posix_package_funcs.md#func-killpgint32-int32-deprecated), belongs to function parameter `sig`. Values across different systems:

- macOS: 0x1E
- Other cases: 0xA

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const SIGUSR2 <sup>(deprecated)</sup>

```cangjie
public const SIGUSR2: Int32
```

Function: User-defined signal, default action terminates process. Applicable functions: [kill](posix_package_funcs.md#func-killint32-int32-deprecated), [killpg](posix_package_funcs.md#func-killpgint32-int32-deprecated), belongs to function parameter `sig`. Values across different systems:

- macOS: 0x1F
- Other cases: 0xC

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const SIGVTALRM <sup>(deprecated)</sup>

```cangjie
public const SIGVTALRM: Int32 = 0x1A
```

Function: Virtual timer expired, default action terminates process. Applicable functions: [kill](posix_package_funcs.md#func-killint32-int32-deprecated), [killpg](posix_package_funcs.md#func-killpgint32-int32-deprecated), belongs to function parameter `sig`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)## const SIGWINCH <sup>(deprecated)</sup>

```cangjie
public const SIGWINCH: Int32 = 0x1C
```

Function: Terminal window size change, default action terminates. Applicable functions: [kill](posix_package_funcs.md#func-killint32-int32-deprecated), [killpg](posix_package_funcs.md#func-killpgint32-int32-deprecated). Belongs to function parameter `sig`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const SIGXCPU <sup>(deprecated)</sup>

```cangjie
public const SIGXCPU: Int32 = 0x18
```

Function: `CPU` usage exceeds limit, default action terminates. Applicable functions: [kill](posix_package_funcs.md#func-killint32-int32-deprecated), [killpg](posix_package_funcs.md#func-killpgint32-int32-deprecated). Belongs to function parameter `sig`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const SIGXFSZ <sup>(deprecated)</sup>

```cangjie
public const SIGXFSZ: Int32 = 0x19
```

Function: File size exceeds limit, default action terminates. Applicable functions: [kill](posix_package_funcs.md#func-killint32-int32-deprecated), [killpg](posix_package_funcs.md#func-killpgint32-int32-deprecated). Belongs to function parameter `sig`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const S_IFBLK <sup>(deprecated)</sup>

```cangjie
public const S_IFBLK: UInt32 = 0x6000
```

Function: File type is block device. Applicable function: [isType](posix_package_funcs.md#func-istypestring-uint32-deprecated). Belongs to function parameter `mode`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)

## const S_IFCHR <sup>(deprecated)</sup>

```cangjie
public const S_IFCHR: UInt32 = 0x2000
```

Function: File type is character device. Applicable function: [isType](posix_package_funcs.md#func-istypestring-uint32-deprecated). Belongs to function parameter `mode`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)

## const S_IFDIR <sup>(deprecated)</sup>

```cangjie
public const S_IFDIR: UInt32 = 0x4000
```

Function: File type is directory. Applicable function: [isType](posix_package_funcs.md#func-istypestring-uint32-deprecated). Belongs to function parameter `mode`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)

## const S_IFIFO <sup>(deprecated)</sup>

```cangjie
public const S_IFIFO: UInt32 = 0x1000
```

Function: File type is `FIFO` file. Applicable function: [isType](posix_package_funcs.md#func-istypestring-uint32-deprecated). Belongs to function parameter `mode`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)

## const S_IFLNK <sup>(deprecated)</sup>

```cangjie
public const S_IFLNK: UInt32 = 0xA000
```

Function: File type is symbolic link. Applicable function: [isType](posix_package_funcs.md#func-istypestring-uint32-deprecated). Belongs to function parameter `mode`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)

## const S_IFREG <sup>(deprecated)</sup>

```cangjie
public const S_IFREG: UInt32 = 0x8000
```

Function: File type is regular file. Applicable function: [isType](posix_package_funcs.md#func-istypestring-uint32-deprecated). Belongs to function parameter `mode`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)

## const S_IFSOCK <sup>(deprecated)</sup>

```cangjie
public const S_IFSOCK: UInt32 = 0xC000
```

Function: File type is socket file. Applicable function: [isType](posix_package_funcs.md#func-istypestring-uint32-deprecated). Belongs to function parameter `mode`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)

## const S_IRGRP <sup>(deprecated)</sup>

```cangjie
public const S_IRGRP: UInt32 = 0x20
```

Function: Indicates group read permission for file. Applicable functions: open, open64, openat, openat64, [chmod](posix_package_funcs.md#func-chmodstring-uint32-deprecated)(mode), [fchmod](posix_package_funcs.md#func-fchmodint32-uint32-deprecated)(mode), [fchmodat](posix_package_funcs.md#func-fchmodatint32-string-uint32-int32-deprecated)(mode), [creat](posix_package_funcs.md#func-creatstring-uint32-deprecated). Belongs to function parameter `flag`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)

## const S_IROTH <sup>(deprecated)</sup>

```cangjie
public const S_IROTH: UInt32 = 0x4
```

Function: Indicates others' read permission for file. Applicable functions: open, open64, openat, openat64, [chmod](posix_package_funcs.md#func-chmodstring-uint32-deprecated)(mode), [fchmod](posix_package_funcs.md#func-fchmodint32-uint32-deprecated)(mode), [fchmodat](posix_package_funcs.md#func-fchmodatint32-string-uint32-int32-deprecated)(mode), [creat](posix_package_funcs.md#func-creatstring-uint32-deprecated). Belongs to function parameter `flag`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)

## const S_IRUSR <sup>(deprecated)</sup>

```cangjie
public const S_IRUSR: UInt32 = 0x100
```

Function: Indicates owner read permission for file. Applicable functions: open, open64, openat, openat64, [chmod](posix_package_funcs.md#func-chmodstring-uint32-deprecated)(mode), [fchmod](posix_package_funcs.md#func-fchmodint32-uint32-deprecated)(mode), [fchmodat](posix_package_funcs.md#func-fchmodatint32-string-uint32-int32-deprecated)(mode), [creat](posix_package_funcs.md#func-creatstring-uint32-deprecated). Belongs to function parameter `flag`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)

## const S_IRWXG <sup>(deprecated)</sup>

```cangjie
public const S_IRWXG: UInt32 = 0x38
```

Function: Indicates group read/write/execute permissions for file. Applicable functions: open, open64, openat, openat64, [chmod](posix_package_funcs.md#func-chmodstring-uint32-deprecated)(mode), [fchmod](posix_package_funcs.md#func-fchmodint32-uint32-deprecated)(mode), [fchmodat](posix_package_funcs.md#func-fchmodatint32-string-uint32-int32-deprecated)(mode), [creat](posix_package_funcs.md#func-creatstring-uint32-deprecated). Belongs to function parameter `flag`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)

## const S_IRWXO <sup>(deprecated)</sup>

```cangjie
public const S_IRWXO: UInt32 = 0x7
```

Function: Indicates others' read/write/execute permissions for file. Applicable functions: open, open64, openat, openat64, [chmod](posix_package_funcs.md#func-chmodstring-uint32-deprecated)(mode), [fchmod](posix_package_funcs.md#func-fchmodint32-uint32-deprecated)(mode), [fchmodat](posix_package_funcs.md#func-fchmodatint32-string-uint32-int32-deprecated)(mode), [creat](posix_package_funcs.md#func-creatstring-uint32-deprecated). Belongs to function parameter `flag`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)

## const S_IRWXU <sup>(deprecated)</sup>

```cangjie
public const S_IRWXU: UInt32 = 0x1C0
```

Function: Indicates owner read/write/execute permissions for file. Applicable functions: open, open64, openat, openat64, [chmod](posix_package_funcs.md#func-chmodstring-uint32-deprecated)(mode), [fchmod](posix_package_funcs.md#func-fchmodint32-uint32-deprecated)(mode), [fchmodat](posix_package_funcs.md#func-fchmodatint32-string-uint32-int32-deprecated)(mode), [creat](posix_package_funcs.md#func-creatstring-uint32-deprecated). Belongs to function parameter `flag`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)

## const S_IWGRP <sup>(deprecated)</sup>

```cangjie
public const S_IWGRP: UInt32 = 0x10
```

Function: Indicates group write permission for file. Applicable functions: open, open64, openat, openat64, [chmod](posix_package_funcs.md#func-chmodstring-uint32-deprecated)(mode), [fchmod](posix_package_funcs.md#func-fchmodint32-uint32-deprecated)(mode), [fchmodat](posix_package_funcs.md#func-fchmodatint32-string-uint32-int32-deprecated)(mode), [creat](posix_package_funcs.md#func-creatstring-uint32-deprecated). Belongs to function parameter `flag`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)

## const S_IWOTH <sup>(deprecated)</sup>

```cangjie
public const S_IWOTH: UInt32 = 0x2
```

Function: Indicates others' write permission for file. Applicable functions: open, open64, openat, openat64, [chmod](posix_package_funcs.md#func-chmodstring-uint32-deprecated)(mode), [fchmod](posix_package_funcs.md#func-fchmodint32-uint32-deprecated)(mode), [fchmodat](posix_package_funcs.md#func-fchmodatint32-string-uint32-int32-deprecated)(mode), [creat](posix_package_funcs.md#func-creatstring-uint32-deprecated). Belongs to function parameter `flag`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)

## const S_IWUSR <sup>(deprecated)</sup>

```cangjie
public const S_IWUSR: UInt32 = 0x80
```

Function: Indicates owner write permission for file. Applicable functions: open, open64, openat, openat64, [chmod](posix_package_funcs.md#func-chmodstring-uint32-deprecated)(mode), [fchmod](posix_package_funcs.md#func-fchmodint32-uint32-deprecated)(mode), [fchmodat](posix_package_funcs.md#func-fchmodatint32-string-uint32-int32-deprecated)(mode), [creat](posix_package_funcs.md#func-creatstring-uint32-deprecated). Belongs to function parameter `flag`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)

## const S_IXGRP <sup>(deprecated)</sup>

```cangjie
public const S_IXGRP: UInt32 = 0x8
```

Function: Indicates group execute permission for file. Applicable functions: open, open64, openat, openat64, [fchmod](posix_package_funcs.md#func-chmodstring-uint32-deprecated)(mode), [fchmod](posix_package_funcs.md#func-fchmodint32-uint32-deprecated)(mode), [fchmodat](posix_package_funcs.md#func-fchmodatint32-string-uint32-int32-deprecated)(mode), [creat](posix_package_funcs.md#func-creatstring-uint32-deprecated). Belongs to function parameter `flag`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)

## const S_IXOTH <sup>(deprecated)</sup>

```cangjie
public const S_IXOTH: UInt32 = 0x1
```

Function: Indicates others' execute permission for file. Applicable functions: open, open64, openat, openat64, [chmod](posix_package_funcs.md#func-chmodstring-uint32-deprecated)(mode), [fchmod](posix_package_funcs.md#func-fchmodint32-uint32-deprecated)(mode), [fchmodat](posix_package_funcs.md#func-fchmodatint32-string-uint32-int32-deprecated)(mode), [creat](posix_package_funcs.md#func-creatstring-uint32-deprecated). Belongs to function parameter `flag`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)

## const S_IXUSR <sup>(deprecated)</sup>

```cangjie
public const S_IXUSR: UInt32 = 0x40
```

Function: Indicates owner execute permission for file. Applicable functions: open, open64, openat, openat64, [chmod](posix_package_funcs.md#func-chmodstring-uint32-deprecated)(mode), [fchmod](posix_package_funcs.md#func-fchmodint32-uint32-deprecated)(mode), [fchmodat](posix_package_funcs.md#func-fchmodatint32-string-uint32-int32-deprecated)(mode), [creat](posix_package_funcs.md#func-creatstring-uint32-deprecated). Belongs to function parameter `flag`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)

## const W_OK <sup>(deprecated)</sup>

```cangjie
public const W_OK: Int32 = 0x2
```

Function: Tests file write permission. Applicable functions: [access](posix_package_funcs.md#func-accessstring-int32-deprecated), [faccessat](posix_package_funcs.md#func-faccessatint32-string-int32-int32-deprecated). Belongs to function parameter `mode`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const X_OK <sup>(deprecated)</sup>

```cangjie
public const X_OK: Int32 = 0x1
```

Function: Tests file execute permission. Applicable functions: [access](posix_package_funcs.md#func-accessstring-int32-deprecated), [faccessat](posix_package_funcs.md#func-faccessatint32-string-int32-int32-deprecated). Belongs to function parameter `mode`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)
