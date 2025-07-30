/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.net

import std.binary.*

func findLastNoneZeroIdx(path: Array<Byte>): Int64 {
    let len = path.size
    if (len > 108) {
        throw IllegalArgumentException("Path size(${len}) is too long, expect <= 108.")
    }
    var lastNoneZeroIdx = 0
    for (i in path.size - 1..=0 : -1) {
        if (path[i] != 0) {
            lastNoneZeroIdx = i + 1
            break
        }
    }
    return lastNoneZeroIdx
}

public class UnixSocketAddress <: SocketAddress & Equatable<UnixSocketAddress> {
    let _path: String
    let _len: Int64

    public init(path: Array<Byte>) {
        this(unsafe { String.fromUtf8Unchecked(path[..findLastNoneZeroIdx(path)]) })
    }
    public init(path: String) {
        _len = path.size
        if (_len > 108) {
            throw IllegalArgumentException("Path size(${_len}) is too long, expect <= 108.")
        }
        if (_len == 0) { // Unnamed socket address
            _path = ""
        } else if (path[0] == 0) { // Abstract socket address
            let un = path[1..]
            if (let Some(idx) <- un.indexOf(0)) {
                throw IllegalArgumentException(
                    "Unix domain socket path must not contain interior null bytes: ${un.toArray()}")
            }
            _path = path
        } else { // Pathname socket address
            if (let Some(idx) <- path.indexOf(0)) {
                throw IllegalArgumentException(
                    "Unix domain socket path must not contain interior null bytes: ${path.toArray()}")
            }
            _path = path
        }
    }
    public prop size: Int64 {
        get() {
            2 + _len
        }
    }
    public prop family: AddressFamily {
        get() {
            AddressFamily.UNIX
        }
    }
    public operator func ==(rhs: UnixSocketAddress): Bool {
        return _path[0.._len] == rhs._path[0..rhs._len]
    }
    public operator func !=(rhs: UnixSocketAddress): Bool {
        return !(this == rhs)
    }
    public func getAddressBytes(): Array<Byte> {
        let buf = Array<Byte>(this.size, repeat: 0)
        // 2bytes family
        this.family.value.writeLittleEndian(buf)
        // sun_un path
        buf[2..] = _path[.._len].toArray()
        return buf
    }
    public func hashCode(): Int64 {
        var df = DefaultHasher()
        for (i in 0.._len) {
            df.write(_path[i])
        }
        df.finish()
    }
    public func toString(): String {
        _path[0.._len]
    }
}
