# std.posix

## Functionality

The posix package encapsulates POSIX system calls, providing cross-platform system operation interfaces.

This package offers unified multi-platform control capabilities, currently supporting Linux, macOS, and Windows platforms.

> **Note:**
>
> All contents of this package will be deprecated in future versions.

## API List

### Functions

| Function Name | Functionality | Supported Platforms |
| ------------ | ------------ | ----------- |
| [open(String, Int32) <sup>(deprecated)</sup>](./posix_package_api/posix_package_funcs.md#func-openstring-int32-deprecated) | Opens a file and returns a new file descriptor, or `-1` on failure. | `Linux` `Windows` `macOS` |
| [open(String, Int32, UInt32) <sup>(deprecated)</sup>](./posix_package_api/posix_package_funcs.md#func-openstring-int32-uint32-deprecated) | Opens a file and returns a new file descriptor, or `-1` on failure. | `Linux` `Windows` `macOS` |
| [access(String, Int32) <sup>(deprecated)</sup>](./posix_package_api/posix_package_funcs.md#func-accessstring-int32-deprecated) | Checks if a file has specific permissions. Returns `0` if true, otherwise `-1`. | `Linux` `Windows` `macOS` |
| [chdir(String) <sup>(deprecated)</sup>](./posix_package_api/posix_package_funcs.md#func-chdirstring-deprecated) | Changes the current working directory of the calling process using the specified path. | `Linux` `Windows` `macOS` |
| [chmod(String, UInt32) <sup>(deprecated)</sup>](./posix_package_api/posix_package_funcs.md#func-chmodstring-uint32-deprecated) | Modifies file access permissions. | `Linux` `Windows` `macOS` |
| [chown(String, UInt32, UInt32) <sup>(deprecated)</sup>](./posix_package_api/posix_package_funcs.md#func-chownstring-uint32-uint32-deprecated) | Changes file owner and group. | `Linux` `macOS` |
| [close(Int32) <sup>(deprecated)</sup>](./posix_package_api/posix_package_funcs.md#func-closeint32-deprecated) | Closes a file. `close` triggers data write-back to disk and releases file resources. | `Linux` `Windows` `macOS` |
| [creat(String, UInt32) <sup>(deprecated)</sup>](./posix_package_api/posix_package_funcs.md#func-creatstring-uint32-deprecated) | Creates a file and returns its file descriptor, or `-1` on failure. | `Linux` `Windows` `macOS` |
| [dup(Int32) <sup>(deprecated)</sup>](./posix_package_api/posix_package_funcs.md#func-dupint32-deprecated) | Duplicates the file descriptor specified by the old `fd` parameter and returns it. | `Linux` `Windows` `macOS` |
| [dup2(Int32, Int32) <sup>(deprecated)</sup>](./posix_package_api/posix_package_funcs.md#func-dupint32-int32-deprecated) | Duplicates the file descriptor specified by `oldfd` and returns it to the `newfd` parameter. | `Linux` `Windows` `macOS` |
| [faccessat(Int32, String, Int32, Int32) <sup>(deprecated)</sup>](./posix_package_api/posix_package_funcs.md#func-faccessatint32-string-int32-int32-deprecated) | Checks if the file corresponding to `fd` has specific permissions. Returns `0` if true, otherwise `-1`. | `Linux` `macOS` |
| [fchdir(Int32) <sup>(deprecated)</sup>](./posix_package_api/posix_package_funcs.md#func-fchdirint32-deprecated) | Changes the current working directory of the calling process using the file descriptor of the specified path. | `Linux` `macOS` |
| [fchmod(Int32, UInt32) <sup>(deprecated)</sup>](./posix_package_api/posix_package_funcs.md#func-fchmodint32-uint32-deprecated) | Modifies file access permissions for the file descriptor. | `Linux` `Windows` `macOS` |
| [fchmodat(Int32, String, UInt32, Int32) <sup>(deprecated)</sup>](./posix_package_api/posix_package_funcs.md#func-fchmodatint32-string-uint32-int32-deprecated) | Modifies file access permissions for the file descriptor. | `Linux` `Windows` `macOS` |
| [fchown(Int32, UInt32, UInt32) <sup>(deprecated)</sup>](./posix_package_api/posix_package_funcs.md#func-fchownint32-uint32-uint32-deprecated) | Changes file owner and group for the file corresponding to `fd`. | `Linux` `macOS` |
| [fchownat(Int32, String, UInt32, UInt32, Int32) <sup>(deprecated)</sup>](./posix_package_api/posix_package_funcs.md#func-fchownatint32-string-uint32-uint32-int32-deprecated) | Changes file owner and group for the file descriptor. | `Linux` `macOS` |
| [getcwd() <sup>(deprecated)</sup>](./posix_package_api/posix_package_funcs.md#func-getcwd-deprecated) | Gets the absolute path of the current working directory of the executing process. | `Linux` `Windows` `macOS` |
| [getgid() <sup>(deprecated)</sup>](./posix_package_api/posix_package_funcs.md#func-getgid-deprecated) | Gets the group `ID`. | `Linux` `macOS` |
| [getgroups(Int32, CPointer\<UInt32>) <sup>(deprecated)</sup>](./posix_package_api/posix_package_funcs.md#func-getgroupsint32-cpointeruint32-deprecated) | Gets the group codes of the current user. | `Linux` `macOS` |
| [gethostname() <sup>(deprecated)</sup>](./posix_package_api/posix_package_funcs.md#func-gethostname-deprecated) | Gets the hostname, typically the name of the host on a `TCP/IP` network. | `Linux` `macOS` |
| [getlogin() <sup>(deprecated)</sup>](./posix_package_api/posix_package_funcs.md#func-getlogin-deprecated) | Gets the current login name. | `Linux` `macOS` |
| [getos() <sup>(deprecated)</sup>](./posix_package_api/posix_package_funcs.md#func-getos-deprecated) | Gets `Linux` system information from the `/proc/version` file. | `Linux` |
| [getpgid(Int32) <sup>(deprecated)</sup>](./posix_package_api/posix_package_funcs.md#func-getpgidint32-deprecated) | Gets the `PGID` of the process specified by `pid`. If `pid` is zero, returns the process `ID` of the calling process. | `Linux` `macOS` |
| [getpgrp() <sup>(deprecated)</sup>](./posix_package_api/posix_package_funcs.md#func-getpgrp-deprecated) | Gets the parent process `ID` of the calling process. | `Linux` `macOS` |
| [getpid() <sup>(deprecated)</sup>](./posix_package_api/posix_package_funcs.md#func-getpid-deprecated) | Gets the process `ID (PID)` of the calling process. | `Linux` `Windows` `macOS` |
| [getppid() <极简版翻译>](./posix_package_api/posix_package_funcs.md#func-getppid-deprecated) | Gets the parent process `ID` of the calling process. | `Linux` `macOS` |
| [getuid() <sup>(deprecated)</sup>](./posix_package_api/posix_package_funcs.md#func-getuid-deprecated) | Gets the real user `ID` of the calling process. | `Linux` `macOS` |
| [isBlk(String) <sup>(deprecated)</sup>](./posix_package_api/posix_package_funcs.md#func-isblkstring-deprecated) | Checks if the input object is a block device and returns a boolean. | `Linux` `Windows` `macOS` |
| [isChr(String) <sup>(deprecated)</sup>](./posix_package_api/posix_package_funcs.md#func-ischrstring-deprecated) | Checks if the input object is a character device and returns a boolean. | `极简版翻译>](./posix_package_api/posix_package_funcs.md#func-ischrstring-deprecated) | Checks if the input object is a character device and returns a boolean. | `Linux` `Windows` `macOS` |
| [isDir(String) <sup>(deprecated)</sup>](./posix_package_api/posix_package_funcs.md#func-isdirstring-deprecated) | Checks if the input object is a directory and returns a boolean. | `Linux` `Windows` `macOS` |
| [isFIFO(String) <sup>(deprecated)</sup>](./posix_package_api/posix_package_funcs.md#func-isfifostring-deprecated) | Checks if the input object is a `FIFO` file and returns a boolean. | `Linux` `macOS` |
| [isLnk(String) <sup>(deprecated)</sup>](./posix_package_api/posix_package_funcs.md#func-islnkstring-deprecated) | Checks if the input object is a symbolic link and returns a boolean. | `Linux` `macOS` |
| [isReg(String) <sup>(deprecated)</sup>](./posix_package_api/posix_package_funcs.md#func-isregstring-deprecated) | Checks if the input object is a regular file and returns a boolean. | `Linux` `Windows` `macOS` |
| [isSock(String) <sup>(deprecated)</sup>](./posix_package_api/posix_package_funcs.md#func-issockstring-deprecated) | Checks if the input object is a socket file and returns a boolean. | `Linux` `macOS` |
| [isType(String, UInt32) <sup>(deprecated)</sup>](./posix_package_api/posix_package_funcs.md极简版翻译>](./posix_package_api/posix_package_funcs.md#func-istypestring-uint32-deprecated) | Checks if the file is of the specified mode. | `Linux` `macOS` |
| [isatty(Int32) <sup>(deprecated)</sup>](./posix_package_api/posix_package_funcs.md#func-isattyint32-deprecated) | Tests if the file descriptor refers to a terminal. Returns `true` on success, otherwise `false`. | `Linux` `Windows` `macOS` |
| [kill(Int32, Int32) <sup>(deprecated)</sup>](./posix_package_api/posix_package_funcs.md#func-killint32-int32-deprecated) | The system call can be used to send any signal to any process group or process. | `Linux` `macOS` |
| [killpg(Int32, Int32) <sup>(deprecated)</sup>](./posix_package_api/posix_package_funcs.md#func-killpgint32-int32-deprecated) | Sends signal `sig` to process group `pgrp`. If `pgrp` is `0`, killpg() sends the signal to the process group of the calling process. | `Linux` `macOS` |
| [lchown(String, UInt32, UInt32) <sup>(deprecated)</sup>](./posix_package_api/posix_package_funcs.md#func-lchownstring-uint32-uint32-deprecated) | Changes the owner and group of the symbolic link itself. | `Linux` `macOS` |
| [link(String, String) <sup>(deprecated)</sup>](./posix_package_api/posix_package_funcs.md#func-linkstring-string-deprecated) | Creates a link to an existing file. A file can have multiple directory entries pointing to its `i-node`. | `Linux` `macOS` |
| [linkat(Int32, String, Int32, String, Int32) <sup>(deprecated)</sup>](./posix_package_api/posix_package_funcs.md#func-linkatint32-string-int32-string-int32-deprecated) | Creates a file link relative to the directory file descriptor. | `Linux` `macOS` |
| [lseek(Int32, Int64, Int32) <sup>(deprecated)</sup>](./posix_package_api/posix_package_funcs.md#func-lseekint32-int64-int32-deprecated) | When reading or writing a file, the read/write position increases accordingly. | `Linux` `Windows` `macOS` |
| [nice(Int32) <sup>(deprecated)</sup>](./posix_package_api/posix_package_funcs.md#func-niceint32-deprecated) | Changes the priority of the current thread. | `Linux` `macOS` |
| [open64(String, Int32) <sup>(deprecated)</sup>](./posix_package_api/posix_package_funcs.md#func-openstring-int32-deprecated) | Opens a file and returns a new file descriptor, or `-1` on failure. | `Linux` |
| [open64(String, Int32, UInt32) <sup>(deprecated)</sup>](./posix_package_api/posix_package_funcs.md#func-openstring-int32-uint32-deprecated) | Opens a file and returns a new file descriptor, or `-1` on failure. | `Linux` |
| [openat(Int32, String, Int32) <sup>(deprecated)</sup>](./posix_package_api/posix_package_funcs.md#func-openatint32-string-int32-deprecated) | Opens a file and returns a new file descriptor, or `-1` on failure. | `Linux` `macOS` |
| [openat(Int32, String, Int32, UInt32) <sup>(deprecated)</sup>](./posix_package_api/posix_package_funcs.md#func-openatint32-string-int32-uint32-deprecated) | Opens a file and returns a new file descriptor, or `-1` on failure. | `Linux` `macOS` |
| [openat64(Int32, String, Int32) <sup>(deprecated)</sup>](./posix_package_api/posix_package_funcs.md#func-openatint32-string-int32-deprecated) | Opens a file and returns a new file descriptor, or `-1` on failure. | `Linux` `macOS` |
| [openat64(Int32, String, Int32, UInt32) <sup>(deprecated)</sup>](./posix_package_api/posix_package_funcs.md#func-openatint32-string-int32-uint32-deprecated) | Opens a file and returns a new file descriptor, or `-1` on failure. | `Linux` `macOS` |
| [pread(Int32, CPointer\<UInt8>, UIntNative, Int32) <sup>(deprecated)</sup>](./posix_package_api/posix_package_funcs.md#func-preadint32-cpointeruint8-uintnative-int32-deprecated) | Transfers `nbyte` bytes from the file pointed to by `fd` to the memory pointed to by `buffer`. | `Linux` `macOS` |
| [pwrite(Int32, CPointer\<UInt8>, UIntNative, Int32) <sup>(deprecated)</sup>](./posix_package_api/posix_package_funcs.md#func-pwrite极简版翻译>](./posix_package_api/posix_package_funcs.md#func-pwriteint32-cpointeruint8-uintnative-int32-deprecated) | Writes `nbyte` bytes from the memory pointed to by `buffer` to the file pointed to by `fd` starting at the specified offset. | `Linux` `macOS` |
| [read(极简版翻译>](./posix_package_api/posix_package_funcs.md#func-readint32-cpointeruint8-uintnative-deprecated) | Transfers `nbyte` bytes from the file pointed to by `fd` to the memory pointed to by `buffer`. | `Linux` `Windows` `macOS` |
| [remove(String) <sup>(deprecated)</sup>](./posix_package_api/posix_package_funcs.md#func-removestring-deprecated) | Deletes a file or directory. | `Linux` `Windows` `macOS` |
| [rename(String, String) <sup>(deprecated)</sup>](./posix_package_api/posix_package_funcs.md#func-renamestring-string-deprecated) | Renames a file and moves it to another directory if needed. | `Linux` `Windows` `macOS` |
| [renameat(Int32, String, Int32, String) <sup>(deprecated)</sup>](./posix_package_api/posix_package_funcs.md#func-renameatint32-string-int32-string-deprecated) | Renames a file and moves it to another directory if needed. | `Linux` `macOS` |
| [setgid(UInt32) <sup>(deprecated)</sup>](./posix_package_api/posix_package_funcs.md#func-setgiduint32-deprecated) | Sets the