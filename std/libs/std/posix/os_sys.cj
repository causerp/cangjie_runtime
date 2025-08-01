/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/**
 * @file
 *
 * This is a library for posix.
 */

package std.posix

/**
 * Test for read permission.
 */
@Deprecated
public const R_OK: Int32 = 0x4

/**
 * Test for write permission.
 */
@Deprecated
public const W_OK: Int32 = 0x2

/**
 * Test for execute permission.
 */
@Deprecated
public const X_OK: Int32 = 0x1

/**
 * Test for existence.
 */
@Deprecated
public const F_OK: Int32 = 0x0

/**
 * File access permission. The value is 0 for success and -1 for failure.
 * Binding POSIX API is [access](https://man7.org/linux/man-pages/man2/access.2.html).
 *
 * @param path the file path.
 * @param mode description of determining the read/write type, incoming Type R_OK, W_OK, X_OK, F_OK.
 * @throws IllegalArgumentException while path contains null character.
 * @return if all permissions to be checked pass the check, the value 0 is returned, indicating that the check is successful.
 * if one permission is disabled, the value -1 is returned.
 *
 * @since 0.16.5
 */
@When[os == "Linux" || os == "Windows" || os == "macOS"]
@Deprecated
public func access(path: String, mode: Int32): Int32 {
    checkPath(path)
    unsafe {
        var p: CString = LibC.mallocCString(path)
        let r: Int32 = access(p, mode)
        LibC.free(p)
        return r
    }
}

/**
 * Viewing FD Access Rights.
 * Binding POSIX API is [faccessat](https://man7.org/linux/man-pages/man2/faccessat.2.html).
 *
 * @param fd a file descriptor.
 * @param path the file path.
 * @param mode description of determining, incoming Type R_OK, W_OK, X_OK, F_OK.
 * @param flag parameter.
 * @throws IllegalArgumentException while path contains null character.
 * @return if the operation succeeds, 0 is returned. Otherwise, all return -1.
 *
 * @since 0.16.5
 */
@When[os == "Linux" || os == "macOS"]
@Deprecated
public func faccessat(fd: Int32, path: String, mode: Int32, flag: Int32): Int32 {
    checkPath(path)
    unsafe {
        var p: CString = LibC.mallocCString(path)
        let r: Int32 = faccessat(fd, p, mode, flag)
        LibC.free(p)
        return r
    }
}

/**
 * Set Default Permission Mask.
 * Binding POSIX API is [umask](https://man7.org/linux/man-pages/man2/umask.2.html).
 *
 * @param cmask file Permission Parameters
 * @return the previous value of the mask.
 *
 * @since 0.16.5
 */
@When[os == "Linux" || os == "Windows" || os == "macOS"]
@Deprecated
public func umask(cmask: UInt32): UInt32 {
    return unsafe { CJ_OS_Umask(cmask) }
}

/**
 * Modify the file owner and the group to which the file owner belongs.
 * Binding POSIX API is [chown](https://man7.org/linux/man-pages/man2/chown.2.html).
 *
 * @param path the file path.
 * @param owner uid parameter.
 * @param group specifies the gid parameter.
 * @throws IllegalArgumentException while path contains null character.
 * @return 0 on success, -1 on error.
 *
 * @since 0.16.5
 */
@When[os == "Linux" || os == "macOS"]
@Deprecated
public func chown(path: String, owner: UInt32, group: UInt32): Int32 {
    checkPath(path)
    unsafe {
        var p: CString = LibC.mallocCString(path)
        let r: Int32 = chown(p, owner, group)
        LibC.free(p)
        return r
    }
}

/**
 * Modify the fd file owner and the group to which the file owner belongs.
 * If the operation succeeds, 0 is returned. If an error occurs, -1 is returned.
 * Binding POSIX API is [fchown](https://man7.org/linux/man-pages/man2/fchown.2.html).
 *
 * @param fd a file descriptor.
 * @param owner uid parameter.
 * @param group specifies the gid parameter.
 * @return succeeds 0 is returned. If an error occurs, -1 is returned.
 *
 * @since 0.16.5
 */
@When[os == "Linux" || os == "macOS"]
@Deprecated
public func fchown(fd: Int32, owner: UInt32, group: UInt32): Int32 {
    return unsafe { CJ_OS_Fchown(fd, owner, group) }
}

/**
 * Modify the file owner and the group to which the file owner belongs.
 * Changes a function that changes the ownership of the source file when the link is changed.
 * Binding POSIX API is [lchown](https://man7.org/linux/man-pages/man2/lchown.2.html).
 *
 * @param path the file path.
 * @param owner uid parameter.
 * @param group specifies the gid parameter.
 * @throws IllegalArgumentException while path contains null character.
 * @return on success, zero is returned.  on error, -1 is returned, and errno is set to indicate the error.
 *
 * @since 0.16.5
 */
@When[os == "Linux" || os == "macOS"]
@Deprecated
public func lchown(path: String, owner: UInt32, group: UInt32): Int32 {
    checkPath(path)
    unsafe {
        var p: CString = LibC.mallocCString(path)
        let r: Int32 = lchown(p, owner, group)
        LibC.free(p)
        return r
    }
}

/**
 * Modify the fd file owner and the group to which the file owner belongs.
 * Binding POSIX API is [fchownat](https://man7.org/linux/man-pages/man2/fchownat.2.html).
 *
 * @param fd a file descriptor.
 * @param path the file path.
 * @param owner uid parameter.
 * @param group specifies the gid parameter.
 * @param flag parameter.
 * @throws IllegalArgumentException while path contains null character.
 * @return on success, zero is returned.on error, -1 is returned, and errno is set to indicate the error.
 *
 * @since 0.16.5
 */
@When[os == "Linux" || os == "macOS"]
@Deprecated
public func fchownat(fd: Int32, path: String, owner: UInt32, group: UInt32, flag: Int32): Int32 {
    checkPath(path)
    unsafe {
        var p: CString = LibC.mallocCString(path)
        let r: Int32 = fchownat(fd, p, owner, group, flag)
        LibC.free(p)
        return r
    }
}

/**
 * Modifying File Permissions.
 * Binding POSIX API is [chmod](https://man7.org/linux/man-pages/man2/chmod.2.html).
 *
 * @param path the file path.
 * @param mode description of determining.
 * @throws IllegalArgumentException while path contains null character.
 * @return on success,returns 0. on error, -1.
 *
 * @since 0.16.5
 */
@When[os == "Linux" || os == "Windows" || os == "macOS"]
@Deprecated
public func chmod(path: String, mode: UInt32): Int32 {
    checkPath(path)
    unsafe {
        var p: CString = LibC.mallocCString(path)
        let r: Int32 = chmod(p, mode)
        LibC.free(p)
        return r
    }
}

/**
 * Modifying fd File Permissions.
 * Binding POSIX API is [fchmod](https://man7.org/linux/man-pages/man2/fchmod.2.html).
 *
 * @param fd a file descriptor.
 * @param mode is description of determining.
 * @return 0 on success, -1 on error
 *
 * @since 0.16.5
 */
@When[os == "Linux" || os == "macOS"]
@Deprecated
public func fchmod(fd: Int32, mode: UInt32): Int32 {
    return unsafe { CJ_OS_Fchmod(fd, mode) }
}

/**
 * Modifying fd File Permissions.
 * Binding POSIX API is [fchmodat](https://man7.org/linux/man-pages/man2/fchmodat.2.html).
 *
 * @param fd a file descriptor.
 * @param path the file path.
 * @param mode description of determining.
 * @param flag parameter
 * @throws IllegalArgumentException while path contains null character.
 * @return on success returns 0. on error, -1.
 *
 * @since 0.16.5
 */
@When[os == "Linux" || os == "macOS"]
@Deprecated
public func fchmodat(fd: Int32, path: String, mode: UInt32, flag: Int32): Int32 {
    checkPath(path)
    unsafe {
        var p: CString = LibC.mallocCString(path)
        let r: Int32 = fchmodat(fd, p, mode, flag)
        LibC.free(p)
        return r
    }
}

/**
 * Test whether a file descriptor refers to a terminal.
 * Binding POSIX API is [isatty](https://man7.org/linux/man-pages/man3/isatty.3.html).
 *
 * @param fd a file descriptor.
 * @return on success returns true, otherwise false is returned.
 *
 * @since 0.18.5
 */
@When[os == "Linux" || os == "Windows" || os == "macOS"]
@Deprecated
public func isatty(fd: Int32): Bool {
    return unsafe { CJ_OS_Isatty(fd) }
}

/**
 * Return name of a terminal.
 * Binding POSIX API is [ttyname](https://man7.org/linux/man-pages/man3/ttyname.3.html).
 *
 * @param fd a file descriptor.
 * @return pathname on success. On error, empty String is returned.
 *
 * @since 0.18.5
 */
@When[os == "Linux" || os == "macOS"]
@Deprecated
public func ttyname(fd: Int32): String {
    unsafe {
        var cstr: CString = CJ_OS_TtynameR(fd)
        if (cstr.isNull()) {
            return String()
        }
        try {
            return cstr.toString()
        } finally {
            LibC.free(cstr)
        }
    }
}
