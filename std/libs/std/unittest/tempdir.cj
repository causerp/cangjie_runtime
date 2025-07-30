/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest

import std.sync.ReentrantMutex
import std.random.Random
import std.fs.*
import std.env.getTempDirectory

// std.fs.File.createTempt can only create up to 26 files
// so we have this to workaround it
class TempDirectory {
    private static const ID_SIZE: Int64 = 16
    private static const MAX_ATTEMPTS: Int64 = 100
    private static const BUFFER_SIZE: Int64 = 100
    private static let VOCAB = "abcdefghijklmnopqrstuvwxyz0123456789".toRuneArray()

    private let lock = ReentrantMutex()
    private let rnd = Random()
    private let buffer = Array<Rune>(ID_SIZE * BUFFER_SIZE, repeat: r'0')
    private var currentOffset = buffer.size
    private var tempDir: ?Path = None

    prop path: Path {
        get() {
            synchronized(lock) {
                match (tempDir) {
                    case Some(dir) => return dir
                    case None =>
                        let dir = getDir()
                        tempDir = dir
                        return dir
                }
            }
        }
    }

    private static func getDir(): Path {
        try {
            let dir = getTempDirectory()
            if (exists(dir)) {
                return dir
            }
        } catch (cause: Exception) {
            eprintln("Failed to find the temp directory: ${cause}")
        }

        return Path(".")
    }

    private func nextId(): Array<Rune> {
        func fillBuffer() {
            for (index in 0..buffer.size) {
                buffer[index] = VOCAB[rnd.nextInt64(VOCAB.size)]
            }
            currentOffset = 0
        }

        synchronized(lock) {
            if (currentOffset >= buffer.size) {
                fillBuffer()
            }

            let startOffset = currentOffset
            currentOffset += ID_SIZE
            buffer[startOffset..startOffset + ID_SIZE].clone()
        }
    }

    private func nextId(prefix: String, suffix: String): String {
        let sb = StringBuilder()
        sb.append(prefix)
        sb.append(nextId())
        sb.append(suffix)
        return sb.toString()
    }

    func createTempFile(dir!: Path = path, prefix!: String = "tempFile", suffix!: String = ".tmp"): File {
        for (_ in 0..MAX_ATTEMPTS) {
            let path = createTempPath(dir: dir, prefix: prefix, suffix: suffix)
            try {
                return File.create(path) // File.create is not atomic, may clash
            } catch (_) {
            }
        }
        throw Exception("Too many attempts to create a temporary file")
    }

    func createTempPath(dir!: Path = path, prefix!: String = "tempFile", suffix!: String = ".tmp"): Path {
        for (_ in 0..MAX_ATTEMPTS) {
            let path = dir.join(nextId(prefix, suffix))
            if (!exists(path)) {
                return path
            }
        }
        throw Exception("Too many attempts to create a temporary file")
    }
}
