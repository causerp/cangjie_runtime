/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.net

import std.binary.*

@When[os != "macOS" && os!= "iOS"]
const MAX_UDS_PATH_LENGTH: Int64 = 108

@When[os == "macOS" || os== "iOS"]
const MAX_UDS_PATH_LENGTH: Int64 = 104

func findLastNoneZeroIdx(path: Array<Byte>): Int64 {
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
    let _rawBytes: Array<Byte>
    let _isAbstract: Bool

    public init(path: Array<Byte>) {
        let lastIdx = findLastNoneZeroIdx(path)
        _len = lastIdx
        _isAbstract = lastIdx > 0 && path[0] == 0

        if (!_isAbstract && lastIdx > 0) {
            for (i in 0..lastIdx) {
                if (path[i] == 0) {
                    throw IllegalArgumentException(
                        "Unix domain socket path must not contain interior null bytes: ${path[..lastIdx]}")
                }
            }
        }

        _rawBytes = path[..lastIdx]
        if (_isAbstract) {
            _path = String.empty
        } else {
            _path = try {
                String.fromUtf8(path[..lastIdx])
            } catch (e: Exception) {
                String.empty
            }
        }
    }

    public init(path: String) {
        _len = path.size
        if (_len > MAX_UDS_PATH_LENGTH) {
            throw IllegalArgumentException("Path size(${_len}) is too long, expect <= ${MAX_UDS_PATH_LENGTH}.")
        }
        if (_len == 0) {
            _path = String.empty
            _rawBytes = Array<Byte>(0, repeat: 0)
            _isAbstract = false
        } else if (path[0] == 0) {
            let un = path[1..]
            if (let Some(idx) <- un.indexOf(0)) {
                throw IllegalArgumentException(
                    "Unix domain socket path must not contain interior null bytes: ${un.toArray()}")
            }
            _path = path
            _rawBytes = path.toArray()
            _isAbstract = true
        } else {
            if (let Some(idx) <- path.indexOf(0)) {
                throw IllegalArgumentException(
                    "Unix domain socket path must not contain interior null bytes: ${path.toArray()}")
            }
            _path = path
            _rawBytes = path.toArray()
            _isAbstract = false
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

    public operator func ==(other: UnixSocketAddress): Bool {
        if (_len != other._len) {
            return false
        }
        if (_isAbstract || other._isAbstract) {
            return _rawBytes == other._rawBytes
        }
        return _path == other._path
    }

    public operator func !=(other: UnixSocketAddress): Bool {
        return !(this == other)
    }

    public func getAddressBytes(): Array<Byte> {
        let buf = Array<Byte>(this.size, repeat: 0)
        this.family.value.writeLittleEndian(buf)
        buf[2..] = _rawBytes
        return buf
    }

    public func hashCode(): Int64 {
        var df = DefaultHasher()
        for (b in _rawBytes) {
            df.write(b)
        }
        df.finish()
    }

    public func toString(): String {
        if (_isAbstract) {
            String.fromUtf8(_rawBytes)
        } else {
            _path
        }
    }
}
