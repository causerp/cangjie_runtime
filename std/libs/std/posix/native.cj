/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.posix

/**
 * open and possibly create a file
 *
 * @param pathname identifies file to open
 * @param flags controls semantics of call
 * @param mode specifies permissions when creating new file
 * @return a file descriptor (nonnegative integer)
 *
 * @since 0.18.2
 *
 * manual: https://man7.org/linux/man-pages/man2/open.2.html
 * signature: int open(const char *pathname, int flags, ...);
 */
@FastNative
foreign func open(pathname: CString, flags: Int32, ...): Int32

@FastNative
@When[os != "Windows" && os != "macOS"]
foreign func open64(pathname: CString, flags: Int32, ...): Int32

/**
 * open and possibly create a file,Similar to open(), but has extra argument dirfd
 *
 * @param dirfd File descriptor that refers to a directory
 * @param pathname identifies file to open
 * @param flags controls semantics of call
 * @param mode specifies permissions when creating new file
 * @return a file descriptor (nonnegative integer)
 *
 * @since 0.18.2
 *
 * manual: https://man7.org/linux/man-pages/man2/openat.2.html
 * signature: int openat(int dirfd, const char *pathname, int flags, ...);
 */
@FastNative
@When[os != "Windows"]
foreign func openat(dirfd: Int32, pathname: CString, flags: Int32, ...): Int32

@FastNative
@When[os != "Windows" && os != "macOS"]
foreign func openat64(dirfd: Int32, pathname: CString, flags: Int32, ...): Int32

/**
 * open and possibly create a file
 *
 * @param pathname the file path.
 * @param flags Indicates the permission to create a file.
 * @return a new file descriptor, and -1 if an error occurs.
 *
 * @since 0.18.2
 *
 * manual: https://man7.org/linux/man-pages/man2/open.2.html
 * signature: int creat(const char *pathname, mode_t mode);
 */
@FastNative
foreign func creat(pathname: CString, flags: UInt32): Int32

/**
 * If the file is no longer needed, close the file by using close().
 * Close() causes the data to be written back to disk and frees the resources occupied by the file.
 *
 * @param fd a file descriptor.
 * @return 0: success;–1: error.
 *
 * @since 0.18.2
 *
 * manual: https://man7.org/linux/man-pages/man2/close.2.html
 * signature: int close(int fd);
 */
@FastNative
foreign func CJ_OS_Close(fd: Int32): Int32

/**
 * reposition read/write file offset
 *
 * @param fd a file descriptor.
 * @param offset the number of bits moved.
 * @param whence three ways to move. There are SEEK_SET,SEEK_CUR,SEEK_END.
 * @return when the call is successful, the current read/write position is returned, that is, the number of bytes from the beginning of the file.
 * if an error occurs, -1 is returned, and errno stores the error code.
 *
 * @since 0.18.2
 *
 * manual: https://man7.org/linux/man-pages/man2/lseek.2.html
 * signature: off_t lseek(int fd, off_t offset, int whence);
 */
@FastNative
foreign func CJ_OS_Lseek(fd: Int32, offset: Int64, whence: Int32): Int64

/**
 * duplicate a file descriptor
 *
 * @param oldfd a file descriptor.
 * @return when the copy is successful, the minimum and unused file descriptors are returned. Returns -1 if there is an error.
 *
 * @since 0.18.2
 *
 * manual: https://man7.org/linux/man-pages/man2/dup.2.html
 * signature: int dup(int oldfd);
 */
@FastNative
foreign func CJ_OS_Dup(oldfd: Int32): Int32

/**
 * duplicate a file descriptor
 *
 * @param oldfd a file descriptor.
 * @param newfd a file descriptor.
 * @return return the new file descriptor on success. Returns -1 if there is an error.
 *
 * @since 0.18.2
 *
 * manual: https://man7.org/linux/man-pages/man2/dup2.2.html
 * signature: int dup2(int oldfd, int newfd);
 */
@FastNative
foreign func CJ_OS_Dup2(oldfd: Int32, newfd: Int32): Int32

/**
 * read from a file descriptor
 *
 * @param fd a file descriptor.
 * @param buf reads data to the buffer container.
 * @param count size to read, buffer.size() is recommended.
 * @return number of characters actually read.
 *
 * @since 0.18.2
 *
 * manual: https://man7.org/linux/man-pages/man2/read.2.html
 * signature: ssize_t read(int fd, void *buf, size_t count);
 */
foreign func CJ_OS_Read(fd: Int32, buf: CPointer<UInt8>, count: UIntNative): IntNative

/**
 * read from a file descriptor at a given offset
 *
 * @param fd a file descriptor.
 * @param buf reads data to the buffer container.
 * @param count size to read, buffer.size() is recommended.
 * @param offset Offset of the buffer.
 * @return actual Number of reads,on error, -1 is returned.
 *
 * @since 0.18.2
 *
 * manual: https://man7.org/linux/man-pages/man2/pread.2.html
 * signature: ssize_t pread(int fd, void *buf, size_t count, off_t offset);
 */
@When[os != "Windows"]
foreign func CJ_OS_Pread(fd: Int32, buf: CPointer<UInt8>, count: UIntNative, offset: Int32): IntNative

/**
 * write to a file descriptor
 *
 * @param fd  file descriptor
 * @param buf pointer to data to be written
 * @param count number of bytes to write
 * @return number of bytes written,May be less than count (e.g., device full, or insufficient space to write entire buffer to nonblocking socket).
 * –1 on error.
 *
 * @since 0.18.2
 *
 * manual: https://man7.org/linux/man-pages/man2/write.2.html
 * signature: ssize_t write(int fd, const void *buf, size_t count);
 */
foreign func CJ_OS_Write(fd: Int32, buf: CPointer<UInt8>, count: UIntNative): IntNative

/**
 * write to a file descriptor at a given offset
 *
 * @param fd a file descriptor.
 * @param buf write data to the buffer container.
 * @param count size to write, buffer.size() is recommended.
 * @param offset offset of the buffer.
 * @return actual Number of write,on error, -1 is returned.
 *
 * @since 0.18.2
 *
 * manual: https://man7.org/linux/man-pages/man2/pwrite.2.html
 * signature: ssize_t pwrite(int fd, const void *buf, size_t count, off_t offset);
 */
@When[os != "Windows"]
foreign func CJ_OS_Pwrite(fd: Int32, buf: CPointer<UInt8>, count: UIntNative, offset: Int32): IntNative

@FastNative
@When[os != "Windows"]
foreign func CJ_OS_IsType(pathname: CString, mode: UInt32): Bool

@FastNative
foreign func CJ_OS_IsTypeFunc(fileName: CString, typeNum: Int32): Bool

/**
 * File access permission. The value is 0 for success and -1 for failure.
 *
 * @param path the file path.
 * @param mode description of determining the read/write type, incoming Type R_OK, W_OK, X_OK, F_OK.
 * @return if all permissions to be checked pass the check, the value 0 is returned, indicating that the check is successful.
 * if one permission is disabled, the value -1 is returned.
 *
 * @since 0.16.5
 *
 * manual: https://man7.org/linux/man-pages/man2/access.2.html
 * signature: int access(const char *pathname, int mode);
 */
@FastNative
foreign func access(pathname: CString, mode: Int32): Int32

/**
 * Viewing FD Access Rights.
 *
 * @param fd a file descriptor.
 * @param pathname the file path.
 * @param mode description of determining, incoming Type R_OK, W_OK, X_OK, F_OK.
 * @param flags parameter.
 * @return if the operation succeeds, 0 is returned. Otherwise, all return -1.
 *
 * @since 0.16.5
 *
 * manual: https://man7.org/linux/man-pages/man2/faccessat.2.html
 * signature:
 *
 * manual: https://man7.org/linux/man-pages/man2/faccessat.2.html
 * signature: int faccessat(int dirfd, const char *pathname, int mode, int flags);
 */
@FastNative
foreign func faccessat(dirfd: Int32, pathname: CString, mode: Int32, flags: Int32): Int32

/**
 * Set Default Permission Mask.
 *
 * @param mask file Permission Parameters
 * @return the previous value of the mask.
 *
 * @since 0.16.5
 *
 * manual: https://man7.org/linux/man-pages/man2/umask.2.html
 * signature: mode_t umask(mode_t mask);
 */
@FastNative
foreign func CJ_OS_Umask(mask: UInt32): UInt32

/**
 * Modify the file owner and the group to which the file owner belongs.
 *
 * @param pathname the file path.
 * @param owner uid parameter.
 * @param group specifies the gid parameter.
 * @return 0 on success, -1 on error.
 *
 * @since 0.16.5
 *
 * manual: https://man7.org/linux/man-pages/man2/chown.2.html
 * signature: int chown(const char *pathname, uid_t owner, gid_t group);
 */
@FastNative
foreign func chown(pathname: CString, owner: UInt32, group: UInt32): Int32

/**
 * Modify the fd file owner and the group to which the file owner belongs.
 * If the operation succeeds, 0 is returned. If an error occurs, -1 is returned.
 *
 * @param fd a file descriptor.
 * @param owner uid parameter.
 * @param group specifies the gid parameter.
 * @return succeeds 0 is returned. If an error occurs, -1 is returned.
 *
 * @since 0.16.5
 *
 * manual: https://man7.org/linux/man-pages/man2/fchown.2.html
 * signature: int fchown(int fd, uid_t owner, gid_t group);
 */
@FastNative
foreign func CJ_OS_Fchown(fd: Int32, owner: UInt32, group: UInt32): Int32

/**
 * Modify the file owner and the group to which the file owner belongs.
 * Changes a function that changes the ownership of the source file when the link is changed.
 *
 * @param pathname the file path.
 * @param owner uid parameter.
 * @param group specifies the gid parameter.
 * @return on success, zero is returned.  on error, -1 is returned, and errno is set to indicate the error.
 *
 * @since 0.16.5
 *
 * manual: https://man7.org/linux/man-pages/man2/lchown.2.html
 * signature: int lchown(const char *pathname, uid_t owner, gid_t group);
 */
@FastNative
foreign func lchown(pathname: CString, owner: UInt32, group: UInt32): Int32

/**
 * Modify the fd file owner and the group to which the file owner belongs.
 *
 * @param dirfd a file descriptor.
 * @param pathname the file path.
 * @param owner uid parameter.
 * @param group specifies the gid parameter.
 * @param flags parameter.
 * @return on success, zero is returned.on error, -1 is returned, and errno is set to indicate the error.
 *
 * @since 0.16.5
 *
 * manual: https://man7.org/linux/man-pages/man2/fchownat.2.html
 * signature: int fchownat(int dirfd, const char *pathname, uid_t owner, gid_t group, int flags);
 */
@FastNative
foreign func fchownat(dirfd: Int32, pathname: CString, owner: UInt32, group: UInt32, flags: Int32): Int32

/**
 * Modifying File Permissions.
 *
 * @param pathname the file path.
 * @param mode description of determining.
 * @return on success,returns 0. on error, -1.
 *
 * @since 0.16.5
 *
 * manual: https://man7.org/linux/man-pages/man2/chmod.2.html
 * signature: int chmod(const char *pathname, mode_t mode);
 */
@FastNative
foreign func chmod(pathname: CString, mode: UInt32): Int32

/**
 * Modifying fd File Permissions.
 *
 * @param fd a file descriptor.
 * @param mode is description of determining.
 * @return 0 on success, -1 on error
 *
 * @since 0.16.5
 *
 * manual: https://man7.org/linux/man-pages/man2/fchmod.2.html
 * signature: int fchmod(int fd, mode_t mode);
 */
@FastNative
foreign func CJ_OS_Fchmod(fd: Int32, mode: UInt32): Int32

/**
 * Modifying fd File Permissions.
 *
 * @param dirfd a file descriptor.
 * @param pathname the file path.
 * @param mode description of determining.
 * @param flags parameter
 * @return on success returns 0. on error, -1.
 *
 * @since 0.16.5
 *
 * manual: https://man7.org/linux/man-pages/man2/fchmodat.2.html
 * signature: int fchmodat(int dirfd, const char *pathname, mode_t mode, int flags);
 */
@FastNative
foreign func fchmodat(dirfd: Int32, pathname: CString, mode: UInt32, flags: Int32): Int32

/**
 * Obtain the user group ID.
 *
 * @return the user group ID.
 *
 * @since 0.18.2
 *
 * manual: https://man7.org/linux/man-pages/man2/getgid.2.html
 * signature: gid_t getgid(void);
 */
@FastNative
foreign func CJ_OS_Getgid(): UInt32

/**
 * Returns the real user ID of the calling process.
 *
 * @return the user id.
 *
 * @since 0.18.2
 *
 * manual: https://man7.org/linux/man-pages/man2/getuid.2.html
 * signature: uid_t getuid(void);
 */
@FastNative
foreign func CJ_OS_Getuid(): UInt32

/**
 * Sets the effective group ID of the calling process,requires appropriate permissions.
 *
 * @param gid to be set.
 * @return if the setting is successful, 0 is returned. If the setting fails, -1 is returned.
 *
 * @since 0.18.2
 *
 * manual: https://man7.org/linux/man-pages/man2/setgid.2.html
 * signature: int setgid(gid_t gid);
 */
@FastNative
foreign func CJ_OS_Setgid(gid: UInt32): Int32

/**
 * Sets the effective user ID of the calling process,requires appropriate permissions.
 *
 * @param uid to be set.
 * @return if the setting is successful, 0 is returned. If the setting fails, -1 is returned.
 *
 * @since 0.18.2
 *
 * manual: https://man7.org/linux/man-pages/man2/setuid.2.html
 * signature: int setuid(uid_t uid);
 */
@FastNative
foreign func CJ_OS_Setuid(uid: UInt32): Int32

/**
 * Returns the PGID of the process specified by pid.If pid is zero, the process ID of the calling process is used.
 *
 * @param pid process id.
 * @return if the execution is successful, the process group ID is returned. If an error occurs, -1 is returned.
 *
 * @since 0.18.2
 *
 * manual: https://man7.org/linux/man-pages/man2/getpgid.2.html
 * signature: pid_t getpgid(pid_t pid);
 */
@FastNative
foreign func CJ_OS_Getpgid(pid: Int32): Int32

/**
 * Function description getgroup() is used to get the code of the group to which the current user belongs. The value of size is list.
 * Number of gid_ts that [] can hold. If the parameter size has a value of zero, this function returns only
 * Indicates the number of groups to which a user belongs.
 *
 * @param size number of data stored in the @p gidArray.
 * @param gidArray stores group information.
 * @return the group identifier, or -1 for errors.
 *
 * @since 0.18.2
 *
 * manual: https://man7.org/linux/man-pages/man2/getgroups.2.html
 * signature: int getgroups(int size, gid_t list[]);
 */
@FastNative
foreign func CJ_OS_Getgroups(size: Int32, gidArray: CPointer<UInt32>): Int32

/**
 * Returns the process ID (PID) of the calling process.
 *
 * @return obtain the current process ID.
 *
 * @since 0.18.2
 *
 * manual: https://man7.org/linux/man-pages/man2/getpid.2.html
 * signature: pid_t getpid(void);
 */
@FastNative
foreign func CJ_OS_Getpid(): Int32

/**
 * Returns the process ID of the parent of the calling process.
 * @return obtain the ID of the current parent process.
 *
 * @since 0.18.2
 *
 * manual: https://man7.org/linux/man-pages/man2/getppid.2.html
 * signature: pid_t getppid(void);
 */
@FastNative
foreign func CJ_OS_Getppid(): Int32

/**
 * Function description getpgrp() is used to get the ID of the group to which the current process belongs.
 * This function is equivalent to callinggetpgid(0);The return value returns the ID of the group to which the current process belongs.
 *
 * @return obtains the ID of the group to which the current process belongs.
 *
 * @since 0.18.2
 *
 * manual: https://man7.org/linux/man-pages/man2/getpgrp.2.html
 * signature: pid_t getpgrp(pid_t pid);
 */
@FastNative
foreign func CJ_OS_Getpgrp(): Int32

/**
 * Function description setpgrp() sets the group ID to which the current process belongs to the process ID of the current process.
 * This function is equivalent to calling setpgid(0, 0).
 *
 * @return if the operation is successful, the group ID is returned. If there is an error, -1 is returned.
 *
 * @since 0.18.2
 *
 * manual: https://man7.org/linux/man-pages/man2/setpgrp.2.html
 * signature: int setpgrp(void);
 */
@FastNative
foreign func CJ_OS_Setpgrp(): Int32

/**
 * Function description setpgid() sets the group ID specified by the parameter pid to the group ID specified by the parameter pgid.
 * If the value of pid is 0,the group ID of the current process is used.
 *
 * @param pid process id.
 * @param pgid Process group ID.
 * @return if the operation is successful, the group ID is returned. If there is an error, -1 is returned.
 *
 * @since 0.18.2
 *
 * manual: https://man7.org/linux/man-pages/man2/setpgid.2.html
 * signature: int setpgid(pid_t pid, pid_t pgid);
 */
@FastNative
foreign func CJ_OS_Setpgid(pid: Int32, pgid: Int32): Int32

/**
 * Change the priority of the current thread.
 * Only the super user can use a negative inc value, which indicates that the priority is first and the process executes faster.
 *
 * @param inc Priority of the current process,the range of the nice value is +19 (low priority) to -20.
 * @return on success, the new nice value is returned (but see NOTES below),on error, -1 is returned, and errno is set to indicate the error.
 *     inc returns the maximum value 19 when the value is greater than 19.
 *
 * @since 0.18.2
 *
 * manual: https://man7.org/linux/man-pages/man2/nice.2.html
 * signature: int nice(int inc);
 */
@FastNative
foreign func CJ_OS_Nice(inc: Int32): Int32

/**
 * System call can be used to send any signal to any process group or process.
 * If pid is positive, then signal sig is sent to the process with the ID specified by pid.
 * If pid equals 0, then sig is sent to every process in the process group of the calling process.
 * If pid equals -1, then sig is sent to every process for which the calling process has permission to send signals,
 *     except for process 1 (init), but see below.
 * If pid is less than -1, then sig is sent to every process in the process group whose ID is -pid.
 *
 * @param pid Process ID.
 * @param sig indicates the signal ID
 * @return if the execution is successful, 0 is returned. if there is an error, -1 is returned.
 *
 * @since 0.18.2
 *
 * manual: https://man7.org/linux/man-pages/man2/kill.2.html
 * signature: int kill(pid_t pid, int sig);
 */
@FastNative
foreign func CJ_OS_Kill(pid: Int32, sig: Int32): Int32

/**
 * Sends the signal sig to the process group pgrp. If pgrp is 0, killpg() sends the signal to the calling process's process group.
 *
 * @param pgrp group ID.
 * @param sig indicates the signal ID.
 * @return if the execution is successful, 0 is returned. if there is an error, -1 is returned.
 *
 * @since 0.18.2
 *
 * manual: https://man7.org/linux/man-pages/man2/killpg.2.html
 * signature: int killpg(int pgrp, int sig);
 */
@FastNative
foreign func CJ_OS_Killpg(pgrp: Int32, sig: Int32): Int32

/**
 * Gethostname function to return only the name of the host.
 * This name is usually the name of the host on a TCP/IP network.
 *
 * @param name CString stores hostname.
 * @param len length of name.
 * @return the tuple type. CString stores hostname. Int32 stores Returns: 0 if OK, -1 on error.
 *
 * @since 0.18.4
 *
 * manual: https://man7.org/linux/man-pages/man2/gethostname.2.html
 * signature: int gethostname(char *name, size_t len);
 */
@FastNative
@When[os != "Windows"]
foreign func gethostname(name: CString, len: UIntNative): Int32

/**
 * The host name is set by the superuser using a similar function, sethostname.
 *
 * @param name CString stores hostname.
 * @param len length of name.
 * @return on success, zero is returned.  On error, -1 is returned, and errno is set to indicate the error.
 *
 * @since 0.18.4
 *
 * manual: https://man7.org/linux/man-pages/man2/sethostname.2.html
 * signature: int sethostname(const char *name, size_t len);
 */
@FastNative
@When[os != "Windows"]
foreign func sethostname(name: CString, len: UIntNative): Int32

/**
 * The host name is set by the superuser using a similar function, sethostname.
 * Binding POSIX API is .
 *
 * @return if the operation is successful, the login name of the CString type is returned. An empty CString is returned upon failure.
 *
 * @since 0.18.4
 *
 * manual: https://man7.org/linux/man-pages/man3/getlogin.3.html
 * signature: char *getlogin(void);
 */
@FastNative
foreign func CJ_OS_Getlogin(): CString

/**
 * We can change the current working directory of the calling process by calling the
 * chdir function.
 *
 * @param path the file path.
 * @return If the operation succeeds, 0 is returned. If an error occurs, -1 is returned.
 *
 * @since 0.18.5
 *
 * manual: https://man7.org/linux/man-pages/man2/chdir.2.html
 * signature: int chdir(const char *path);
 */
@FastNative
foreign func chdir(path: CString): Int32

/**
 * We can change the current working directory of the calling process by calling the
 * fchdir function.
 *
 * @param fd a file descriptor.
 * @return If the operation succeeds, 0 is returned. If an error occurs, -1 is returned.
 *
 * @since 0.18.5
 *
 * manual: https://man7.org/linux/man-pages/man2/fchdir.2.html
 * signature: int fchdir(int fd);
 */
@FastNative
foreign func CJ_OS_Fchdir(fd: Int32): Int32

@FastNative
foreign func CJ_OS_GetCwd(): CString

/**
 * a file can have multiple directory entries pointing to its i-node.
 * We can use either the link function to create a link to an existing file.
 *
 * @param oldpath the file path.
 * @param newpath other file path.if newpath exists, it will not be overwritten.
 * @return on success, zero is returned.  on error, -1 is returned, and errno is set to indicate the error.
 *
 * @since 0.18.5
 *
 * manual: https://man7.org/linux/man-pages/man2/link.2.html
 * signature: int link(const char *oldpath, const char *newpath);
 */
@FastNative
foreign func link(oldpath: CString, newpath: CString): Int32

/**
 * deletes a name from the filesystem.
 * If that name was the last link to a file and no processes have the file open, the file is deleted
 *    and the space it was using is made available for reuse.
 * If the name was the last link to a file but any processes still have the file open,
 *    the file will remain in existence until the last file descriptor referring to it is closed.
 * If the name referred to a symbolic link, the link is removed.
 * If the name referred to a socket, FIFO, or device, the name for it is removed but processes which have the object open may continue to use it.
 *
 * @param pathname the file path.
 * @return on success, zero is returned.  on error, -1 is returned, and errno is set to indicate the error.
 *
 * @since 0.18.5
 *
 * manual: https://man7.org/linux/man-pages/man2/unlink.2.html
 * signature: int unlink(const char *pathname);
 */
@FastNative
@When[os != "Windows"]
foreign func unlink(pathname: CString): Int32

/**
 * If oldpath is absolute, then olddirfd is ignored. The interpretation of newpath is as for oldpath, except that a relative
 * pathname is interpreted relative to the directory referred to by the file descriptor newdirfd.
 *
 * @param olddirfd a file descriptor.
 * @param oldpath the file path.
 * @param newdirfd a file descriptor.
 * @param newpath other file path.if newpath exists, it will not be overwritten.
 * @param flags AT_EMPTY_PATH or AT_SYMLINK_FOLLOW or 0
 * @return on success, zero is returned.  on error, -1 is returned, and errno is set to indicate the error.
 *
 * @since 0.18.5
 *
 * manual: https://man7.org/linux/man-pages/man2/linkat.2.html
 * signature: int linkat(int olddirfd, const char *oldpath, int newdirfd, const char *newpath, int flags);
 */
@FastNative
@When[os != "Windows"]
foreign func linkat(olddirfd: Int32, oldpath: CString, newdirfd: Int32, newpath: CString, flags: Int32): Int32

/**
 * The unlinkat() system call operates in exactly the same way as either unlink() or rmdir(2) (depending on whether
 *     or not flags includes the AT_REMOVEDIR flag) except for the differences described here.
 * If the pathname given in pathname is relative, then it is interpreted relative to the directory referred to by the file descriptor dirfd.
 * If the pathname given in pathname is relative and dirfd is the special value AT_FDCWD, then pathname is
 *    interpreted relative to the current working directory of the calling process (like unlink() and rmdir(2)).
 * If the pathname given in pathname is absolute, then dirfd is ignored.
 *
 * @param dirfd a file descriptor.
 * @param pathname the file path.
 * @param flags AT_REMOVEDIR The superuser can call unlink with pathname specifying a directory if the filesystem supports it, or 0 .
 * @return on success, zero is returned.  on error, -1 is returned, and errno is set to indicate the error.
 *
 * @since 0.18.5
 *
 * manual: https://man7.org/linux/man-pages/man2/unlinkat.2.html
 * signature: int unlinkat(int dirfd, const char *pathname, int flags);
 */
@FastNative
foreign func unlinkat(dirfd: Int32, pathname: CString, flags: Int32): Int32

/**
 * symlink() creates a symbolic link named linkpath which contains the string target.
 * Symbolic links are interpreted at run time as if the contents of the link had been substituted into the path being followed to find a file or directory.
 * Symbolic links may contain .. path components, which (if used at the start of the link) refer to the parent directories of that in which the link resides.
 * A symbolic link (also known as a soft link) may point to an existing file or to a nonexistent one; the latter case is known as a dangling link.
 * The permissions of a symbolic link are irrelevant; the ownership is ignored when following the link,
 *     but is checked when removal or renaming of the link is requested and the link is in a directory with the sticky bit set.
 * If linkpath exists, it will not be overwritten.
 *
 * @param target the file path.
 * @param linkpath the file path
 * @return on success, zero is returned.  on error, -1 is returned, and errno is set to indicate the error.
 *
 * @since 0.18.5
 *
 * manual: https://man7.org/linux/man-pages/man2/symlink.2.html
 * signature: int symlink(const char *target, const char *linkpath);
 */
@FastNative
foreign func symlink(target: CString, linkpath: CString): Int32

/**
 * If the pathname given in linkpath is relative, then it is interpreted relative to the directory referred to
 *    by the file descriptor newdirfd (rather than relative to the current working directory of the calling process).
 * If linkpath is relative and newdirfd is the special value AT_FDCWD, then linkpath
 *    is interpreted relative to the current working directory of the calling process.If linkpath is absolute, then newdirfd is ignored.
 *
 * @param target the file path.
 * @param newdirfd a file descriptor.
 * @param linkpath the file path.
 * @return on success, zero is returned.  on error, -1 is returned, and errno is set to indicate the error.
 *
 * @since 0.18.5
 *
 * manual: https://man7.org/linux/man-pages/man2/symlinkat.2.html
 * signature: int symlinkat(const char *target, int newdirfd, const char *linkpath);
 */
@FastNative
foreign func symlinkat(target: CString, newdirfd: Int32, linkpath: CString): Int32

/**
 * We can also unlink a file or a directory with the remove function. For a file,
 * remove is identical to unlink. For a directory, remove is identical to rmdir.
 *
 * @param pathname the file path.
 * @return on success, zero is returned.  on error, -1 is returned, and errno is set to indicate the error.
 *
 * @since 0.18.5
 *
 * manual: https://man7.org/linux/man-pages/man3/remove.3.html
 * signature: int remove(const char *pathname);
 */
@FastNative
foreign func remove(pathname: CString): Int32

/**
 * rename() renames a file, moving it between directories if required.  Any other hard links to the file
 *          (as created using link(2)) are unaffected.  Open file descriptors for oldpath are also unaffected.
 * Various restrictions determine whether or not the rename operation succeeds: see ERRORS below.
 * If newpath already exists, it will be atomically replaced, so that there is no point at which another process
 *    attempting to access newpath will find it missing.  However, there will probably be a window in which both oldpath and newpath refer to the file being renamed.
 * If oldpath and newpath are existing hard links referring to the same file, then rename() does nothing, and returns a success status.
 * If newpath exists but the operation fails for some reason,rename() guarantees to leave an instance of newpath in place.
 * oldpath can specify a directory.  In this case, newpath must either not exist, or it must specify an empty directory.
 * If oldpath refers to a symbolic link, the link is renamed; if newpath refers to a symbolic link, the link will be overwritten.
 *
 * @param oldpath the file pathname.
 * @param newpath new the file pathname.
 * @return on success, zero is returned. on error, -1 is returned, and errno is set to indicate the error.
 *
 * @since 0.18.5
 *
 * manual: https://man7.org/linux/man-pages/man2/rename.2.html
 * signature: int rename(const char *oldpath, const char *newpath);
 */
@FastNative
foreign func rename(oldpath: CString, newpath: CString): Int32

/**
 * The renameat() system call operates in exactly the same way as rename(), except for the differences described here.
 * If the pathname given in oldpath is relative, then it is interpreted relative to the directory referred to by the file descriptor olddirfd
 * If oldpath is relative and olddirfd is the special value  AT_FDCWD, then oldpath
 *    is interpreted relative to the current working directory of the calling process (like rename()).If oldpath is absolute, then olddirfd is ignored.
 * The interpretation of newpath is as for oldpath, except that a relative pathname is interpreted relative to the directory
 *    referred to by the file descriptor newdirfd.
 *
 * @param olddirfd a file descriptor.
 * @param oldpath the file pathname.
 * @param newdirfd a file descriptor.
 * @param newpath other file pathname.
 * @return on success, zero is returned.  on error, -1 is returned, and errno is set to indicate the error.
 *
 * @since 0.18.5
 *
 * manual: https://man7.org/linux/man-pages/man2/renameat.2.html
 * signature: int renameat(int olddirfd, const char *oldpath, int newdirfd, const char *newpath);
 */
@FastNative
foreign func renameat(olddirfd: Int32, oldpath: CString, newdirfd: Int32, newpath: CString): Int32

/**
 * Test whether a file descriptor refers to a terminal.
 *
 * @param fd a file descriptor.
 * @return on success returns true, otherwise false is returned.
 *
 * @since 0.18.5
 *
 * manual: https://man7.org/linux/man-pages/man3/isatty.3.html
 * signature: int isatty(int fd);
 */
@FastNative
foreign func CJ_OS_Isatty(fd: Int32): Bool

foreign func CJ_OS_TtynameR(fd: Int32): CString
