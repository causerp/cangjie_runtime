/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/**
 * @file The file declares HardLink.
 */
package std.fs

public class SymbolicLink {
    private init() {}

    public static func create(link: Path, to!: Path): Unit {
        SymbolicLink.create(link._rawPath, to: to._rawPath)
    }

    public static func create(link: String, to!: String): Unit {
        PathValidator.throwIfEmptyOrContainsNullByte("link", link, true)
        PathValidator.throwIfEmptyOrContainsNullByte("to", to, true)

        unsafe {
            try (cPath1 = LibC.mallocCString(link).asResource(), cPath2 = LibC.mallocCString(to).asResource()) {
                let pRet = CJ_FS_SymLink(cPath1.value, cPath2.value)
                if (pRet.isNull()) {
                    throw FSException("Failed malloc in C code!")
                }
                let ret = pRet.read()
                LibC.free(pRet)
                if (ret.rtnCode == 0) {
                    return
                }
                try {
                    let errMessage = ret.msg.toString()
                    throw FSException("Failed to create symbolic link `${link}` to `${to}` return ${ret.rtnCode}: \"${errMessage.trimAscii()}\".")
                } finally {
                    LibC.free(ret.msg)
                }
            }
        }
    }

    public static func readFrom(path: String, recursive!: Bool = false): Path {
        return SymbolicLink.readFrom(Path(path), recursive: recursive)
    }

    public static func readFrom(path: Path, recursive!: Bool = false): Path {
        PathValidator.throwIfEmptyOrContainsNullByte("path", path, true)
        if (!FileInfo(path).isSymbolicLink()) {
            throw IllegalArgumentException("The input path `${path}` is not a symbolic link.")
        }

        if (recursive) {
            return Path(processPathHeader(path._rawPath, Path.canonicalizePath(path._rawPath)))
        }

        var result = String.empty
        unsafe {
            try (cPath = LibC.mallocCString(path._rawPath).asResource()) {
                let pRet = CJ_FS_ReadLink(cPath.value)

                if (pRet.isNull()) {
                    throw FSException("Failed malloc in C code!")
                }
                let ret = pRet.read()
                LibC.free(pRet)
                try {
                    result = ret.msg.toString()
                } finally {
                    LibC.free(ret.msg)
                }

                if (ret.rtnCode != 0) {
                    throw FSException("${result.trimAscii()}.")
                }
            }
        }
        return Path(result)
    }
}
