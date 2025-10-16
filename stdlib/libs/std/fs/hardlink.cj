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

public class HardLink {
    private init() {}

    public static func create(link: Path, to!: Path): Unit {
        HardLink.create(link._rawPath, to: to._rawPath)
    }

    public static func create(link: String, to!: String): Unit {
        if (link.isEmpty() || to.isEmpty()) {
            throw IllegalArgumentException("The path 'link' or 'to' cannot be empty!")
        } else if (link.contains(NULL_BYTE) || to.contains(NULL_BYTE)) {
            throw IllegalArgumentException("The path 'link' or 'to' cannot contain null character!")
        }

        unsafe {
            try (cPath1 = LibC.mallocCString(link).asResource(), cPath2 = LibC.mallocCString(to).asResource()) {
                let pret = CJ_FS_Link(cPath1.value, cPath2.value)
                if (pret.isNull()) {
                    throw FSException("Failed malloc in C code!")
                }
                let ret = pret.read()
                LibC.free(pret)
                if (ret.rtnCode != 0) {
                    try {
                        let errMessage = ret.msg.toString()
                        throw FSException("Failed to create link: '${errMessage.trimAscii()}'.")
                    } finally {
                        LibC.free(ret.msg)
                    }
                }
            }
        }
    }
}
