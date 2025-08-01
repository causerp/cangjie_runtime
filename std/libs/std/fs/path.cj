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
 * This file defines Path related classes.
 */
package std.fs

public func canonicalize(path: String): Path {
    Path(path).checkPath()
    if (!exists(path)) {
        throw FSException("Failed to canonical: the path may not exist or permission denied!")
    }
    return Path(processPathHeader(path, Path.canonicalizePath(path)))
}

public func canonicalize(path: Path): Path {
    path.checkPath()
    let rawPath = path.toString()
    if (!exists(rawPath)) {
        throw FSException("Failed to canonical: the path may not exist or permission denied!")
    }
    return Path(processPathHeader(rawPath, Path.canonicalizePath(rawPath)))
}

@When[os != "Windows"]
const PATH_SEPARATOR = "/"
@When[os == "Windows"]
const PATH_SEPARATOR = "\\"
@When[os != "Windows"]
const PATH_LISTSEPARATOR = ":"
@When[os == "Windows"]
const PATH_LISTSEPARATOR = ";"
@When[os != "Windows"]
const PATH_SEPARATOR_BYTE = b'/'
@When[os == "Windows"]
const PATH_SEPARATOR_BYTE = b'\\'
@When[os != "Windows"]
const isWindows = false
@When[os == "Windows"]
const isWindows = true

public struct Path <: Equatable<Path> & Hashable & ToString {
    let _rawPath: String

    public static const Separator: String = PATH_SEPARATOR
    public static const ListSeparator: String = PATH_LISTSEPARATOR

    public init(rawPath: String) {
        _rawPath = rawPath
    }

    /**
     * @throws IllegalArgumentException while path contains null character,
     * or path is empty.
     */
    public prop parent: Path {
        get() {
            checkPath()
            return getParent(_rawPath)
        }
    }

    /**
     * @throws IllegalArgumentException while path contains null character,
     * or path is empty.
     */
    public prop fileName: String {
        get() {
            checkPath()
            return getFileName(_rawPath)
        }
    }

    /**
     * @throws IllegalArgumentException while path contains null character,
     * or path is empty.
     */
    public prop extensionName: String {
        get() {
            checkPath()
            let name = this.fileName
            if (let Some(dot) <- name.lastIndexOf(b'.')) {
                return name[dot + 1..]
            }
            return ""
        }
    }

    /**
     * @throws IllegalArgumentException while path contains null character,
     * or path is empty.
     */
    public prop fileNameWithoutExtension: String {
        get() {
            checkPath()
            let name = this.fileName
            if (let Some(dot) <- name.lastIndexOf(b'.')) {
                return name[..dot]
            }
            return name
        }
    }

    /**
     * @throws IllegalArgumentException while path contains null character,
     * or path is empty.
     */
    public func isAbsolute(): Bool {
        checkPath()
        return isAbsolutePath(_rawPath)
    }

    /**
     * @throws IllegalArgumentException while path contains null character,
     * or path is empty.
     */
    public func isRelative(): Bool {
        checkPath()
        return !isAbsolutePath(_rawPath)
    }

    private func checkWindowsSpecialPrefix(path: String) {
        if (!isWindows) {
            return
        }
        let specialPrefix = #"\??\"#
        if (path.contains(specialPrefix)) {
            throw IllegalArgumentException("Path cannot contain `${specialPrefix}`!")
        }
    }

    /**
     * @throws IllegalArgumentException while rawpath or path contains null character, or rawpath is empty.
     * @throws FSException if path is an absolute path.
     */
    public func join(path: String): Path {
        if (path.contains(NULL_BYTE)) {
            throw IllegalArgumentException("The `path` cannot contain null character!")
        }
        checkPath()
        if (path.isEmpty()) {
            if (isSlash(_rawPath[_rawPath.size - 1])) {
                return this
            }
            return Path(String.join([_rawPath, SLASH_STRING]))
        }
        if (isAbsolutePath(path)) {
            throw FSException("The `path` cannot be an absolute path!")
        }
        var newPath = if (isSlash(_rawPath[_rawPath.size - 1])) {
            String.join([_rawPath, path])
        } else {
            String.join([_rawPath, path], delimiter: SLASH_STRING)
        }
        checkWindowsSpecialPrefix(newPath)
        return Path(newPath)
    }

    /**
     * @throws IllegalArgumentException while path contains null character,
     * or path is empty.
     */
    public func join(path: Path): Path {
        return join(path.toString())
    }

    public func isEmpty(): Bool {
        _rawPath.isEmpty()
    }

    private func checkWindowsMiddleVolumeName(path: String): Bool {
        if (!isWindows) {
            return false
        }
        if (let Some(indexOfColon) <- path.indexOf(":")) {
            if (indexOfColon <= 1) {
                return false
            }
            if (let Some(indexOfSeparator) <- path.indexOf("/") && indexOfSeparator < indexOfColon) {
                return true
            }
            if (let Some(indexOfSeparator) <- path.indexOf("\\") && indexOfSeparator < indexOfColon) {
                return true
            }
        }
        return false
    }

    private func checkWindowsLeadingVolumeName(path: String): Bool {
        if (!isWindows) {
            return false
        }
        if (let Some(indexOfColon) <- path.indexOf(":")) {
            if (indexOfColon == 1) {
                return true
            }
        }
        return false
    }

    public func normalize(): Path {
        if (_rawPath.isEmpty()) {
            return Path(".")
        }
        // dst string
        let newPath = Array<Byte>(_rawPath.size, repeat: 0)
        // find root
        var rootLen = getRootLen(_rawPath)
        // normalize root
        for (i in 0..rootLen) {
            if (isSlash(_rawPath[i])) {
                newPath[i] = PATH_SEPARATOR_BYTE
            } else {
                newPath[i] = _rawPath[i]
            }
        }
        // only root
        if (_rawPath.size == rootLen) {
            return unsafe { Path(String.fromUtf8Unchecked(newPath[..rootLen])) }
        }

        var (left, right, newIdx) = (rootLen, rootLen, rootLen)
        // _rawPath[left..right] point to a part between two separators
        while (right < _rawPath.size) {
            // inside a part, just go on
            if (!isSlash(_rawPath[right])) {
                right++
                continue
            }
            // end of a part, process the part
            newIdx = normalizePart(_rawPath[left..right], newPath, right - left, newIdx, rootLen)
            right++
            left = right
        }
        // process the last part
        if (left < right) {
            newIdx = normalizePart(_rawPath[left..right], newPath, right - left, newIdx, rootLen)
        }
        // if the result is empty, return "."
        if (newIdx == 0) {
            return Path(".")
        }
        let newPathString = unsafe { String.fromUtf8Unchecked(newPath[..newIdx]) }
        checkWindowsSpecialPrefix(newPathString)
        if (checkWindowsMiddleVolumeName(_rawPath) && checkWindowsLeadingVolumeName(newPathString)) {
            return Path(".\\${newPathString}")
        }
        return Path(newPathString)
    }

    func normalizePart(part: String, newPath: Array<Byte>, partlen: Int64, newPathIdx: Int64, rootLen: Int64): Int64 {
        var newIdx = newPathIdx
        return match (part) {
            case "" | "." => newPathIdx
            case ".." => processDotDot(newPath, newIdx, rootLen)
            case _ =>
                var newIdx = newPathIdx
                // append a separator
                if (newIdx != rootLen) {
                    newPath[newIdx] = PATH_SEPARATOR_BYTE
                    newIdx++
                }
                unsafe { part.rawData() }.copyTo(newPath, 0, newIdx, partlen)
                newIdx + partlen
        }
    }

    // revert the prev part
    // newIdx point to the next position to be written
    func processDotDot(newPath: Array<Byte>, newIdx: Int64, rootLen: Int64): Int64 {
        if (newIdx == rootLen) {
            // if it's first byte after root, and the root ends with a slash, just ignore the ../ part
            // if there's a leading slash, it must have been writen to newPath
            if (rootLen > 0 && isSlash(newPath[rootLen - 1])) {
                return newIdx
            } else {
                // if it's first byte, and there's no slash before, append .. to newPath
                newPath[newIdx] = b'.'
                newPath[newIdx + 1] = b'.'
                return newIdx + 2
            }
        }
        // find the prev part: newPath[(prev + 1)..newIdx]
        var prev = newIdx - 1
        var skipPrevSlash = false
        while (prev >= rootLen) {
            if (isSlash(newPath[prev])) {
                skipPrevSlash = true
                break
            }
            prev--
        }
        // now prev point to the last separator before prev part
        // if prev part is ".."，append "/.."
        if (prev + 3 == newIdx && newPath[prev + 1] == b'.' && newPath[prev + 2] == b'.') {
            newPath[newIdx] = PATH_SEPARATOR_BYTE
            newPath[newIdx + 1] = b'.'
            newPath[newIdx + 2] = b'.'
            return newIdx + 3
        }
        return if (skipPrevSlash) {
            prev
        } else {
            prev + 1
        }
    }

    public operator func ==(that: Path): Bool {
        this.normalize()._rawPath == that.normalize()._rawPath
    }

    public func hashCode(): Int64 {
        return this.normalize()._rawPath.hashCode()
    }

    public func toString(): String {
        return _rawPath
    }

    /**
     * @throws FSException if cPath is invalid
     */
    static func canonicalizePath(pathStr: String): Array<Byte> {
        unsafe {
            var realPathArr = Array<Byte>(PATH_MAX_SIZE, repeat: 0)
            let cPath = LibC.mallocCString(pathStr)
            var arrPtr: CPointerHandle<Byte> = acquireArrayRawData(realPathArr)
            let resultptr = CJ_FS_NormalizePath(cPath, arrPtr.pointer)
            releaseArrayRawData(arrPtr)
            LibC.free(cPath)
            if (resultptr.isNull()) {
                throw FSException("Failed malloc in C code!")
            }
            let result = resultptr.read()
            LibC.free(resultptr)
            let availLen = result.rtnCode
            if (availLen <= 0) {
                try {
                    let errMessage = result.msg.toString()
                    throw FSException("Failed to canonical: \"${errMessage.trimAscii()}\".")
                } finally {
                    LibC.free(result.msg)
                }
            }
            realPathArr.slice(0, availLen)
        }
    }

    func checkPath(): Unit {
        if (_rawPath.isEmpty()) {
            throw IllegalArgumentException("The `rawPath` cannot be an empty string!")
        }
        if (_rawPath.contains(NULL_BYTE)) {
            throw IllegalArgumentException("The `rawPath` cannot contain null character!")
        }
    }
}
