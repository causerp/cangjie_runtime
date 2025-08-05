# Constants & Variables

## const AT_EMPTY_PATH <sup>(deprecated)</sup>

```cangjie
public const AT_EMPTY_PATH: Int32 = 0x1000
```

Function: Represents a file descriptor returned when encountering an empty path (i.e., no file or directory specified) in the filesystem. Applies to functions `open`, `open64`, `openat`, `openat64`, and belongs to the function parameter `oflag`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const AT_REMOVEDIR <sup>(deprecated)</sup>

```cangjie
public const AT_REMOVEDIR: Int32 = 0x200
```

Function: When the [AT_REMOVEDIR](posix_package_constants_vars.md#const-at_removedir-deprecated) flag is specified, performs an operation equivalent to `rmdir(2)` on `pathname`. Applies to functions `open`, `open64`, `openat`, `openat64`, and belongs to the function parameter `oflag`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const F_OK <sup>(deprecated)</sup>

```cangjie
public const F_OK: Int32 = 0x0
```

Function: Tests for file existence. Applies to functions [access](posix_package_funcs.md#func-accessstring-int32-deprecated), [faccessat](posix_package_funcs.md#func-faccessatint32-string-int32-int32-deprecated), and belongs to the function parameter `mode`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const O_APPEND <sup>(deprecated)</sup>

```cangjie
public const O_APPEND: Int32
```

Function: When reading/writing files, data will be positioned at the end of file. That is, written data will be appended to EOF. Applies to functions `open`, `open64`, `openat`, `openat64`, and belongs to the function parameter `oflag`. System-specific values:

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

Function: Critical for certain multithreaded programs. Using separate `fcntl(2)` `F_SETFD` operation to set `FD_CLOEXEC` flag cannot avoid race conditions when one thread opens file descriptors while another executes `fork(2)` plus `execve(2)`. Applies to functions `open`, `open64`, `openat`, `openat64`, and belongs to the function parameter `oflag`. System-specific values:

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

Function: If the file doesn't exist, it will be created automatically. Applies to functions `open`, `open64`, `openat`, `openat64`, and belongs to the function parameter `oflag`. System-specific values:

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

Function: If `pathname` doesn't point to a directory, opening will fail. Applies to functions `open`, `open64`, `openat`, `openat64`, and belongs to the function parameter `oflag`. System-specific values:

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

Function: Each write operation waits for physical `I/O` completion, but won't wait for file attribute updates if the write doesn't affect reading newly written data. Applies to functions `open`, `open64`, `openat`, `openat64`, and belongs to the function parameter `oflag`. System-specific values:

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

Function: When combined with [O_CREAT](posix_package_constants_vars.md#const-o_creat-deprecated), checks file existence. If file exists, opening fails. Also, if both [O_CREAT](posix_package_constants_vars.md#const-o_creat-deprecated) and [O_EXCL](posix_package_constants_vars.md#const-o_excl-deprecated) are set and the target is a symbolic link, opening fails. Applies to functions `open`, `open64`, `openat`, `openat64`, and belongs to the function parameter `oflag`. System-specific values:

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

Function: If the file to be opened is a terminal device, it will not become the controlling terminal for this process. Applicable to functions `open`, `open64`, `openat`, `openat64`, and belongs to the function parameter `oflag`. Values for different systems are:

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

Function: If the file specified by `pathname` is a symbolic link, opening the file will fail. Applicable to functions `open`, `open64`, `openat`, `openat64`, and belongs to the function parameter `oflag`. Values for different systems are:  

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

Function: Opens the file in non-blocking mode, meaning `I/O` operations will not cause the calling process to wait. Applicable to functions `open`, `open64`, `openat`, `openat64`, and belongs to the function parameter `oflag`. Values for different systems are:  

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

Function: Opens the file in read-only mode. Applicable to functions `open`, `open64`, `openat`, `openat64`, and belongs to the function parameter `oflag`.  

> **Note:**  
>  
> Will be deprecated in future versions.  

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)  

## const O_RDWR <sup>(deprecated)</sup>  

```cangjie
public const O_RDWR: Int32 = 0x2
```

Function: Opens the file in read-write mode. Applicable to functions `open`, `open64`, `openat`, `openat64`, and belongs to the function parameter `oflag`.  

> **Note:**  
>  
> Will be deprecated in future versions.  

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)  

## const O_RSYNC <sup>(deprecated)</sup>  

```cangjie
public const O_RSYNC: Int32 = 0x101000
```

Function: This flag only affects read operations and must be used in combination with [O_SYNC](posix_package_constants_vars.md#const-o_sync-deprecated) or [O_DSYNC](posix_package_constants_vars.md#const-o_dsync-deprecated). If necessary, it will cause read calls to block until the data being read (and possibly metadata) is flushed to disk. Applicable to functions `open`, `open64`, `openat`, `openat64`, and belongs to the function parameter `oflag`.  

> **Note:**  
>  
> Will be deprecated in future versions.  

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)  

## const O_SYNC <sup>(deprecated)</sup>  

```cangjie
public const O_SYNC: Int32
```

Function: Opens the file synchronously. Applicable to functions `open`, `open64`, `openat`, `openat64`, and belongs to the function parameter `oflag`. Values for different systems are:  

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

Function: If the file exists and is opened for writing, this flag will truncate the file length to 0, and any previously stored data in the file will be lost. Applicable to functions `open`, `open64`, `openat`, `openat64`, and belongs to the function parameter `oflag`. Values for different systems are:  

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

Function: Opens the file in write-only mode. Applicable to functions `open`, `open64`, `openat`, `openat64`, and belongs to the function parameter `oflag`.  

> **Note:**  
>  
> Will be deprecated in future versions.  

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)  

## const R_OK <sup>(deprecated)</sup>  

```cangjie
public const R_OK: Int32 = 0x4
```

Function: Tests the read permission of a file. Applicable to functions [access](posix_package_funcs.md#func-accessstring-int32-deprecated), [faccessat](posix_package_funcs.md#func-faccessatint32-string-int32-int32-deprecated), and belongs to the function parameter `mode`.  

> **Note:**  
>Function: Illegal instruction. Default action: terminate. Used with functions [kill](posix_package_funcs.md#func-killint32-int32-deprecated) and [killpg](posix_package_funcs.md#func-killpgint32-int32-deprecated), as parameter `sig`.

> **Note:**  
> This will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)
Function: Coprocessor stack fault. Default action: terminate. Used with functions [kill](posix_package_funcs.md#func-killint32-int32-deprecated) and [killpg](posix_package_funcs.md#func-killpgint32-int32-deprecated), as parameter `sig`.

> **Note:**  
> This will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const SIGSTOP <sup>(deprecated)</sup>

```cangjie
public const SIGSTOP: Int32
```

Function: Stop process. Default action: terminate. Used with functions [kill](posix_package_funcs.md#func-killint32-int32-deprecated) and [killpg](posix_package_funcs.md#func-killpgint32-int32-deprecated), as parameter `sig`. System-specific values:
- macOS: 0x11
- Others: 0x13

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const SIGTERM <sup>(deprecated)</sup>

```cangjie
public const SIGTERM: Int32 = 0xF
```

Function: Termination signal, default action terminates process. Applicable functions [kill](posix_package_funcs.md#func-killint32-int32-deprecated), [killpg](posix_package_funcs.md#func-killpgint32-int32-deprecated), associated function parameter `sig`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const SIGTRAP <sup>(deprecated)</sup>

```cangjie
public const SIGTRAP: Int32 = 0x5
```

Function: Hardware fault signal, default action terminates process. Applicable functions [kill](posix_package_funcs.md#func-killint32-int32-deprecated), [killpg](posix_package_funcs.md#func-killpgint32-int32-deprecated), associated function parameter `sig`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const SIGTSTP <sup>(deprecated)</sup>

```cangjie
public const SIGTSTP: Int32
```

Function: Terminal stop signal, default action terminates process. Applicable functions [kill](posix_package_funcs.md#func-killint32-int32-deprecated), [killpg](posix_package_funcs.md#func-killpgint32-int32-deprecated), associated function parameter `sig`. Values under different systems:

- macOS: 0x12
- Others: 0x14

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const SIGTTIN <sup>(deprecated)</sup>

```cangjie
public const SIGTTIN: Int32 = 0x15
```

Function: Background process reading from `tty`, default action terminates process. Applicable functions [kill](posix_package_funcs.md#func-killint32-int32-deprecated), [killpg](posix_package_funcs.md#func-killpgint32-int32-deprecated), associated function parameter `sig`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const SIGTTOU <sup>(deprecated)</sup>

```cangjie
public const SIGTTOU: Int32 = 0x16
```

Function: Background process writing to `tty`, default action terminates process. Applicable functions [kill](posix_package_funcs.md#func-killint32-int32-deprecated), [killpg](posix_package_funcs.md#func-killpgint32-int32-deprecated), associated function parameter `sig`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const SIGURG <sup>(deprecated)</sup>

```cangjie
public const SIGURG: Int32
```

Function: Urgent condition (socket), default action ignored. Applicable functions [kill](posix_package_funcs.md#func-killint32-int32-deprecated), [killpg](posix_package_funcs.md#func-killpgint32-int32-deprecated), associated function parameter `sig`. Values under different systems:

- macOS: 0x10
- Others: 0x17

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const SIGUSR1 <sup>(deprecated)</sup>

```cangjie
public const SIGUSR1: Int32
```

Function: User-defined signal 1, default action terminates process. Applicable functions [kill](posix_package_funcs.md#func-killint32-int32-deprecated), [killpg](posix_package_funcs.md#func-killpgint32-int32-deprecated), associated function parameter `sig`. Values under different systems:

- macOS: 0x1E
- Others: 0xA

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const SIGUSR2 <sup>(deprecated)</sup>

```cangjie
public const SIGUSR2: Int32
```

Function: User-defined signal 2, default action terminates process. Applicable functions [kill](posix_package_funcs.md#func-killint32-int32-deprecated), [killpg](posix_package_funcs.md#func-killpgint32-int32-deprecated), associated function parameter `sig`. Values under different systems:

- macOS: 0x1F
- Others: 0xC

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const SIGVTALRM <sup>(deprecated)</sup>

```cangjie
public const SIGVTALRM: Int32 = 0x1A
```

Function: Virtual timer expired, default action terminates process. Applicable functions [kill](posix_package_funcs.md#func-killint32-int32-deprecated), [killpg](posix_package_funcs.md#func-killpgint32-int32-deprecated), associated function parameter `sig`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const SIGWINCH <sup>(deprecated)</sup>

```cangjie
public const SIGWINCH: Int32 = 0x1C
```

Function: Terminal window size changed, default action terminates, applicable functions [kill](posix_package_funcs.md#func-killint32-int32-deprecated), [killpg](posix_package_funcs.md#func-killpgint32-int32-deprecated), associated function parameter `sig`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const SIGXCPU <sup>(deprecated)</sup>

```cangjie
public const SIGXCPU: Int32 = 0x18
```

Function: CPU time limit exceeded, default action terminates, applicable functions [kill](posix_package_funcs.md#func-killint32-int32-deprecated), [killpg](posix_package_funcs.md#func-killpgint32-int32-deprecated), associated function parameter `sig`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const SIGXFSZ <sup>(deprecated)</sup>

```cangjie
public const SIGXFSZ: Int32 = 0x19
```

Function: File size limit exceeded, default action terminates, applicable functions [kill](posix_package_funcs.md#func-killint32-int32-deprecated), [killpg](posix_package_funcs.md#func-killpgint32-int32-deprecated), associated function parameter `sig`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const S_IFBLK <sup>(deprecated)</sup>

```cangjie
public const S_IFBLK: UInt32 = 0x6000
```

Function: Block special file type, applicable function [isType](posix_package_funcs.md#func-istypestring-uint32-deprecated), associated function parameter `mode`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)

## const S_IFCHR <sup>(deprecated)</sup>

```cangjie
public const S_IFCHR: UInt32 = 0x2000
```

Function: Character special file type, applicable function [isType](posix_package_funcs.md#func-istypestring-uint32-deprecated), associated function parameter `mode`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)

## const S_IFDIR <sup>(deprecated)</sup>

```cangjie
public const S_IFDIR: UInt32 = 0x4000
```

Function: Directory file type, applicable function [isType](posix_package_funcs.md#func-istypestring-uint32-deprecated), associated function parameter `mode`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)

## const S_IFIFO <sup>(deprecated)</sup>

```cangjie
public const S_IFIFO: UInt32 = 0x1000
```

Function: FIFO special file type, applicable function [isType](posix_package_funcs.md#func-istypestring-uint32-deprecated), associated function parameter `mode`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)

## const S_IFLNK <sup>(deprecated)</sup>

```cangjie
public const S_IFLNK: UInt32 = 0xA000
```

Function: Symbolic link file type, applicable function [isType](posix_package_funcs.md#func-istypestring-uint32-deprecated), associated function parameter `mode`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)

## const S_IFREG <sup>(deprecated)</sup>

```cangjie
public const S_IFREG: UInt32 = 0x8000
```

Function: Regular file type, applicable function [isType](posix_package_funcs.md#func-istypestring-uint32-deprecated), associated function parameter `mode`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)

## const S_IFSOCK <sup>(deprecated)</sup>

```cangjie
public const S_IFSOCK: UInt32 = 0xC000
```

Function: Socket file type, applicable function [isType](posix_package_funcs.md#func-istypestring-uint32-deprecated), associated function parameter `mode`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)

## const S_IRGRP <sup>(deprecated)</sup>

```cangjie
public const S_IRGRP: UInt32 = 0x20
```

Function: Indicates group read permission for the file. Applicable functions: open, open64, openat, openat64, [chmod](posix_package_funcs.md#func-chmodstring-uint32-deprecated)(mode), [fchmod](posix_package_funcs.md#func-fchmodint32-uint32-deprecated)(mode), [fchmodat](posix_package_funcs.md#func-fchmodatint32-string-uint32-int32-deprecated)(mode), [creat](posix_package_funcs.md#func-creatstring-uint32-deprecated). Belongs to function parameter `flag`.

> **Note:**
>
> Will be deprecated in future versions.

Type: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)

## const S_IROTH <sup>(deprecated)</sup>

```cangjie
public const S_IROTH: UInt32 = 0x4
```

Function: Specifies read permission for other users. Applicable functions: open, open64, openat, openat64, [chmod](posix_package_funcs.md#func-chmodstring-uint32-deprecated)(mode), [fchmod](posix_package_funcs.md#func-fchmodint32-uint32-deprecated)(mode), [fchmodat](posix_package_funcs.md#func-fchmodatint32-string-uint32-int32-deprecated)(mode), [creat](posix_package_funcs.md#func-creatstring-uint32-deprecated). Corresponds to function parameter `flag`.

> **Note:**
>
> This will be deprecated in future releases.

Type: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)

## const S_IRUSR <sup>(deprecated)</sup>

```cangjie
public const S_IRUSR: UInt32 = 0x100
```

Function: Specifies read permission for file owner. Applicable functions: same as above. Corresponds to parameter `flag`.

> **Note:**
>
> This will be deprecated in future releases.

Type: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)

## const S_IRWXG <sup>(deprecated)</sup>

```cangjie
public const S_IRWXG: UInt32 = 0x38
```

Function: Specifies read, write, and execute permissions for group. Applicable functions: same as above. Corresponds to parameter `flag`.

> **Note:**
>
> This will be deprecated in future releases.

Type: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)

## const S_IRWXO <sup>(deprecated)</sup>

```cangjie
public const S_IRWXO: UInt32 = 0x7
```

Function: Specifies read, write, and execute permissions for others. Applicable functions: same as above. Corresponds to parameter `flag`.

> **Note:**
>
> This will be deprecated in future releases.

Type: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)

## const S_IRWXU <sup>(deprecated)</sup>

```cangjie
public const S_IRWXU: UInt32 = 0x1C0
```

Function: Specifies read, write, and execute permissions for owner. Applicable functions: same as above. Corresponds to parameter `flag`.

> **Note:**
>
> This will be deprecated in future releases.

Type: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)

## const S_IWGRP <sup>(deprecated)</sup>

```cangjie
public const S_IWGRP: UInt32 = 0x10
```

Function: Specifies write permission for group. Applicable functions: same as above. Corresponds to parameter `flag`.

> **Note:**
>
> This will be deprecated in future releases.

Type: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)

## const S_IWOTH <sup>(deprecated)</sup>

```cangjie
public const S_IWOTH: UInt32 = 0x2
```

Function: Specifies write permission for others. Applicable functions: same as above. Corresponds to parameter `flag`.

> **Note:**
>
> This will be deprecated in future releases.

Type: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)

## const S_IWUSR <sup>(deprecated)</sup>

```cangjie
public const S_IWUSR: UInt32 = 0x80
```

Function: Specifies write permission for owner. Applicable functions: same as above. Corresponds to parameter `flag`.

> **Note:**
>
> This will be deprecated in future releases.

Type: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)

## const S_IXGRP <sup>(deprecated)</sup>

```cangjie
public const S_IXGRP: UInt32 = 0x8
```

Function: Group execute permission. Same applicability.

> **Note:** Will be deprecated.

Type: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)

## const S_IXOTH <sup>(deprecated)</sup>

```cangjie
public const S_IXOTH: UInt32 = 0x1
```

Function: Others execute permission. Same applicability.

> **Note:** Will be deprecated.

Type: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)

## const S_IXUSR <sup>(deprecated)</sup>

```cangjie
public const S_IXUSR: UInt32 = 0x40
```

Function: Owner execute permission. Same applicability.

> **Note:** Will be deprecated.

Type: [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32)

## const W_OK <sup>(deprecated)</sup>

```cangjie
public const W_OK: Int32 = 0x2
```

Function: Tests write permission. For [access](posix_package_funcs.md#func-accessstring-int32-deprecated) and [faccessat](posix_package_funcs.md#func-faccessatint32-string-int32-int32-deprecated). Parameter `mode`.

> **Note:** Will be deprecated.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)

## const X_OK <sup>(deprecated)</sup>

```cangjie
public const X_OK: Int32 = 0x1
```

Function: Tests execute permission. Same applicability.

> **Note:** Will be deprecated.

Type: [Int32](../../core/core_package_api/core_package_intrinsics.md#int32)