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
 * This file defines Directory related classes.
 */
package std.fs

import std.collection.*

public class Directory {
    /*
     * @throws IllegalArgumentException while path is empty, or path is current directory,
     * or path is root directory, or path contains null character.
     * @throws FSException while path is exist, or while recursive is false
     * and the middle path is not exist.
     */
    public static func create(path: String, recursive!: Bool = false): Unit {
        let normalPath = removeTralingSlashChar(path)
        if (exists(normalPath)) {
            throw FSException("The path of directory exists.")
        }
        if (recursive) {
            Directory.createRecursive(normalPath)
        } else {
            Directory.createNoRecursive(normalPath)
        }
    }

    /*
     * @throws IllegalArgumentException while path is empty, or path is current directory,
     * or path is root directory, or path contains null character.
     * @throws FSException while path is exist, or while recursive is false
     * and the middle path is not exist.
     */
    public static func create(path: Path, recursive!: Bool = false): Unit {
        create(path.toString(), recursive: recursive)
    }

    /*
     * @throws FSException while path is not exist or failed to create temporary directory
     * @throws IllegalArgumentException while path is empty or path contains null character
     */
    public static func createTemp(directoryPath: String): Path {
        createTemp(Path(directoryPath))
    }

    /*
     * @throws FSException while path is not exist or failed to create temporary directory.
     * @throws IllegalArgumentException while path is empty or path contains null character
     */
    public static func createTemp(directoryPath: Path): Path {
        var directoryPathArr = unsafe { canonicalize(directoryPath).toString().rawData() }

        // Append Six random characters and r'\0'
        var tmpStr = TMP_DIR
        var tempArr = Array<Byte>(directoryPathArr.size + tmpStr.size, repeat: 0)
        directoryPathArr.copyTo(tempArr, 0, 0, directoryPathArr.size)
        tmpStr.copyTo(tempArr, 0, directoryPathArr.size, tmpStr.size)
        unsafe {
            var arrPtr: CPointerHandle<Byte> = acquireArrayRawData(tempArr)
            var ret: Bool = CJ_FS_CreateTempDir(arrPtr.pointer)
            releaseArrayRawData(arrPtr)
            if (!ret) {
                throw FSException("Failed to create the temporary directory!")
            }
        }
        return Path(String.fromUtf8(tempArr.slice(0, tempArr.size - 1)))
    }

    public static func isEmpty(path: Path): Bool {
        isEmpty(path.toString())
    }

    public static func isEmpty(path: String): Bool {
        unsafe {
            let absPath = checkDirectoryPath(Path(path))
            let cPath: CString = LibC.mallocCString(absPath.toString())
            let ret = CJ_FS_ISDirEmpty(cPath)
            LibC.free(cPath)
            if (ret < 0) {
                throw FSException("Failed to check whether the directory is empty!")
            }
            return ret == 0
        }
    }

    public static func readFrom(path: Path): Array<FileInfo> {
        let fileInfos = ArrayList<FileInfo>()
        walk(path) {
            info =>
            fileInfos.add(info)
            true
        }
        return fileInfos.toArray()
    }

    public static func readFrom(path: String): Array<FileInfo> {
        readFrom(Path(path))
    }

    public static func walk(path: Path, f: (FileInfo) -> Bool): Unit {
        let absPath = checkDirectoryPath(path)
        let (subData, subSize) = getSubData(absPath.toString())
        var pos = 0
        while (pos < subSize) {
            try {
                let len = Int64(subData[pos])
                let name = String.fromUtf8(subData.slice(pos + 2, len))
                pos = pos + len + 2
                let fullPathName = String.join([absPath.toString(), name], delimiter: SLASH_STRING)
                if (!f(FileInfo(Path(fullPathName), false))) {
                    return
                }
            } catch (e: Exception) {
                throw FSException("Failed to get file info: ${e.message}.")
            }
        }
    }

    public static func walk(path: String, f: (FileInfo) -> Bool): Unit {
        walk(Path(path), f)
    }

    private static func copyCheck(sourceDirPath: String, destinationDirPath: String, overwrite: Bool): Unit {
        if (sourceDirPath.contains(NULL_BYTE) || destinationDirPath.contains(NULL_BYTE)) {
            throw IllegalArgumentException(
                "The directory source path or destination path cannot contain null character!")
        }
        if (!exists(sourceDirPath)) {
            throw FSException("The `${sourceDirPath}` does not exist!")
        }
        if (!overwrite && exists(destinationDirPath)) {
            throw FSException("The `${destinationDirPath}` already exists!")
        }
    }

    private static func createSubDirectory(parent: String, name: String): String {
        if (name.contains(NULL_BYTE)) {
            throw IllegalArgumentException("The name cannot contain null character.")
        }
        if (containsSlash(name)) {
            throw FSException("The name cannot contain path information.")
        }
        let pathStr = String.join([parent, name], delimiter: SLASH_STRING)
        if (exists(pathStr)) {
            throw FSException("The name of directory exists.")
        }
        callNativeFunc(pathStr, CJ_FS_DirCreate, "Failed to create directory")
        return pathStr
    }

    private static func copyDirectory(srcDir: String, destDir: String): Int64 {
        let srcQueue = ArrayList<String>()
        let destQueue = ArrayList<String>()
        srcQueue.add(srcDir)
        destQueue.add(destDir)
        let fail = Box<Bool>(false)
        while (!srcQueue.isEmpty()) {
            let index = srcQueue.size - 1
            walkAndCopy(srcQueue, destQueue, index, fail)
            if (fail.value) {
                return -1
            }
            srcQueue.remove(at: index)
            destQueue.remove(at: index)
        }
        return 0
    }

    private static func walkAndCopy(srcQueue: ArrayList<String>, destQueue: ArrayList<String>, index: Int64,
        fail: Box<Bool>): Unit {
        let (curSrcDir, curDestDir) = (srcQueue[index], destQueue[index])
        walk(curSrcDir) {
            info =>
            var fName = info.path.fileName
            if (fName.isEmpty()) {
                throw FSException("File name cannot be empty!")
            }
            if (info.isDirectory()) {
                let destPath = Path(curDestDir).join(fName)
                var destPathStr = if (exists(destPath)) {
                    destPath.toString()
                } else {
                    createSubDirectory(curDestDir, fName)
                }
                destQueue.add(destPathStr)
                srcQueue.add(info.path.toString())
                return true
            }
            unsafe {
                var srcPath = info.path.toString()
                var destPath = Path(curDestDir).join(fName).toString()
                try (srcString = LibC.mallocCString(srcPath).asResource(),
                    destString = LibC.mallocCString(destPath).asResource()) {
                    var ret: Int8 = -1
                    if (info.isRegular()) {
                        ret = CJ_FS_CopyREF(srcString.value, destString.value)
                    } else if (info.isSymbolicLink()) {
                        ret = CJ_FS_CopyLink(srcString.value, destString.value)
                    }
                    if (ret < 0) {
                        fail.value = true
                        return false
                    }
                }
            }
            return true
        }
    }

    /*
     * @throws FSException while sourceDirPath is not exist,
     * or destinationDirPath is exit while overwrite is false, or failed to copy,
     * or destinationDirPath is in sourceDirPath.
     * @throws IllegalArgumentException while path contains null character.
     */
    static func copy(sourceDirPath: String, destinationDirPath: String, overwrite: Bool): Unit {
        copyCheck(sourceDirPath, destinationDirPath, overwrite)
        if (!exists(destinationDirPath)) {
            Directory.create(destinationDirPath, recursive: true)
        }
        let srcFullPath = canonicalize(sourceDirPath).toString()
        let destFullPath = canonicalize(destinationDirPath).toString()
        if (destFullPath == srcFullPath) {
            return
        }
        if (destFullPath.startsWith(srcFullPath) && destFullPath.removePrefix(srcFullPath).startsWith(SLASH_STRING)) {
            throw FSException("The `${destinationDirPath}` is in the ${sourceDirPath}!")
        }
        if (copyDirectory(srcFullPath, destFullPath) == -1) {
            throw FSException("Failed to copy `${sourceDirPath}` to `${destinationDirPath}`!")
        }
    }

    /*
     * private functions
     * @throws FSException if get number of obtain members in the directory failed
     */
    private static func getSubData(path: String): (Array<Byte>, Int64) {
        let arr = Array<Byte>((256 + 2) * size(path), repeat: 0) // UInt8 name_size + UInt8 file_type + UInt8[256]
        unsafe {
            let cPath = LibC.mallocCString(path)
            let arrPtr: CPointerHandle<Byte> = acquireArrayRawData(arr)
            let ret: Int64 = CJ_FS_DirGetData(cPath, arrPtr.pointer, arr.size)
            releaseArrayRawData(arrPtr)
            LibC.free(cPath)
            if (ret < 0) {
                throw FSException("Failed to obtain members in the directory.")
            } else if (ret == 0) {
                return (Array<Byte>(), 0)
            } else {
                return (arr, ret)
            }
        }
    }

    /*
     * @throws FSException if get number of subFiles in directory failed
     */
    private static func size(pathStr: String): Int64 {
        unsafe {
            let cPath: CString = LibC.mallocCString(pathStr)
            let ret: Int64 = CJ_FS_DirGetNumber(cPath)
            LibC.free(cPath)
            if (ret < 0) {
                throw FSException("Failed to get number of subFiles in directory.")
            }
            return ret
        }
    }

    /*
     * @throws FSException if parent directory does not exists
     * @throws FSException if path is null or system create directory failed
     */
    private static func createNoRecursive(path: String): Unit {
        let parent = Path(path).parent
        if (!parent.isEmpty() && !exists(parent)) {
            throw FSException("Failed to create directory, parent directory: `${parent}` does not exist.")
        }
        callNativeFunc(path, CJ_FS_DirCreate, "Failed to create directory")
    }

    /*
     * @throws IllegalArgumentException if path is invalid
     */
    private static func removeTralingSlashChar(path: String): String {
        // cannot create path "", "./" or "/" or r'\0'
        if (path.isEmpty() || path == CURRENT_DIRECTORY_STRING || path == ROOT_DIRECTORY_STRING || path.contains(
            NULL_BYTE)) {
            throw IllegalArgumentException("Invalid path, failed to create directory.")
        }

        // skip the end r'/'
        var lastLetterIdx: Int64 = skipEndSlash(path)

        // cannot create path "/[/]*/",
        if (lastLetterIdx < 0) {
            throw IllegalArgumentException("Invalid path, failed to create directory.")
        }
        return path[..=lastLetterIdx]
    }

    /*
     * @throws FSException if directory path already exists
     * @throws FSException if system create directory failed
     */
    private static func createRecursive(path: String): Unit {
        callNativeFunc(path, CJ_FS_DirCreateRecursive, "Failed to recursive create directory")
    }
}

func checkDirectoryPath(path: Path): Path {
    let info = FileInfo(path)
    if (!info.isDirectory()) {
        throw FSException("The path '${path}' is not a directory!")
    }
    return info.path
}
