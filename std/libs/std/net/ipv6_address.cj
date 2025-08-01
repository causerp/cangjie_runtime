/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.net

import std.convert.*
import std.binary.{SwapEndianOrder, BigEndianOrder, LittleEndianOrder}

// ref https://www.rfc-editor.org/rfc/rfc4291.html
public class IPv6Address <: IPAddress & ToString & Equatable<IPv6Address> & LessOrEqual<IPv6Address> {
    public static let localhost: IPv6Address = IPv6Address(0u16, 0, 0, 0, 0, 0, 0, 1)
    public static let unspecified: IPv6Address = IPv6Address(0u16, 0, 0, 0, 0, 0, 0, 0)

    var _octets = Array<Byte>(16, repeat: 0)
    let _scopeId: ?UInt32

    init(bits: UInt128, scopeId!: ?UInt32 = None) {
        bits.writeBigEndian(_octets)
        _scopeId = scopeId
    }
    public init(octets: Array<Byte>, scopeId!: ?UInt32 = None) {
        if (octets.size < 16) {
            throw IllegalArgumentException("Octets size[${octets.size}] must be at least 16.")
        }
        _octets = [octets[0], octets[1], octets[2], octets[3], octets[4], octets[5], octets[6], octets[7], octets[8],
            octets[9], octets[10], octets[11], octets[12], octets[13], octets[14], octets[15]]
        _scopeId = scopeId
    }
    public init(a: UInt16, b: UInt16, c: UInt16, d: UInt16, e: UInt16, f: UInt16, g: UInt16, h: UInt16,
        scopeId!: ?UInt32 = None) {
        var addr16: Array<UInt16> = [
            a.toBigEndian(),
            b.toBigEndian(),
            c.toBigEndian(),
            d.toBigEndian(),
            e.toBigEndian(),
            f.toBigEndian(),
            g.toBigEndian(),
            h.toBigEndian()
        ]

        for (i in 0..addr16.size) {
            addr16[i].writeLittleEndian(_octets[i * 2..])
        }
        _scopeId = scopeId
    }
    public prop scopeId: ?UInt32 {
        get() {
            _scopeId
        }
    }
    func toBits(): UInt128 {
        return UInt128.readBigEndian(_octets)
    }
    func segments(): Array<UInt16> {
        let dst = Array<UInt16>(8, repeat: 0)
        for (i in 0..dst.size) {
            dst[i] = UInt16.readBigEndian(_octets[i * 2..])
        }
        return dst
    }
    public func getPrefix(prefixLen: UInt8): IPPrefix {
        return IPv6Prefix(this, prefixLen)
    }
    public func toIPv4(): ?IPv4Address {
        let octs = segments()
        if (octs[0] == 0 && octs[1] == 0 && octs[2] == 0 && octs[3] == 0 && octs[4] == 0 && (octs[5] == 0 || octs[5] ==
            0xffff)) {
            let buf = Array<Byte>(4, repeat: 0)
            octs[6].writeBigEndian(buf)
            octs[7].writeBigEndian(buf[2..])
            return IPv4Address(buf[0], buf[1], buf[2], buf[3])
        } else {
            return None
        }
    }
    public func toIPv4Mapped(): ?IPv4Address {
        let octs = segments()
        if (octs[0] == 0 && octs[1] == 0 && octs[2] == 0 && octs[3] == 0 && octs[4] == 0 && octs[5] == 0xffff) {
            let buf = Array<Byte>(4, repeat: 0)
            octs[6].writeBigEndian(buf)
            octs[7].writeBigEndian(buf[2..])
            return IPv4Address(buf[0], buf[1], buf[2], buf[3])
        } else {
            return None
        }
    }
    public func scope(scopeId: ?UInt32): IPv6Address {
        if (this.scopeId == scopeId) {
            return this
        }
        return IPv6Address(_octets, scopeId: scopeId)
    }
    public func writeBigEndian(buffer: Array<Byte>): Int64 {
        if (buffer.size < 16) {
            throw IllegalArgumentException("Buffer size(${buffer.size}) is too small.")
        }
        for (i in 0.._octets.size) {
            buffer[i] = _octets[i]
        }
        return 16
    }
    public static func readBigEndian(buffer: Array<Byte>): IPv6Address {
        if (buffer.size < 16) {
            throw IllegalArgumentException("Buffer size(${buffer.size}) is too small.")
        }
        return IPv6Address(buffer)
    }
    public func isGlobalUnicast(): Bool {
        this != IPv6Address.unspecified && !this.isLoopback() && !this.isMulticast() && !this.isLinkLocal()
    }
    public func isIPv4Mapped(): Bool {
        let addr16 = this.segments()
        return addr16[0] == 0 && addr16[1] == 0 && addr16[2] == 0 && addr16[3] == 0 && addr16[4] == 0 && addr16[5] ==
            0xffff
    }
    public func isLinkLocal(): Bool {
        return (this.segments()[0] & 0xffc0) == 0xfe80
    }
    public func isLoopback(): Bool {
        return this == IPv6Address.localhost
    }
    public func isMulticast(): Bool {
        return (this.segments()[0] & 0xff00) == 0xff00
    }
    public func isPrivate(): Bool {
        return (this._octets[0] & 0xfe) == 0xfc
    }
    public func isTeredo(): Bool {
        let addr16 = this.segments()
        return addr16[0] == 0x2001 && addr16[1] == 0
    }
    public func isUnspecified(): Bool {
        return this == IPv6Address.unspecified
    }
    public operator func <=(rhs: IPv6Address): Bool {
        return _octets <= rhs._octets
    }
    public operator func ==(rhs: IPv6Address): Bool {
        return _octets == rhs._octets && this._scopeId == rhs._scopeId
    }
    public operator func !=(rhs: IPv6Address): Bool {
        return !(this == rhs)
    }
    public func toString(): String {
        let sb = StringBuilder()
        let segments = segments()
        if (let Some(ipv4) <- this.toIPv4Mapped()) {
            sb.append("::ffff:${ipv4}")
        } else {
            let (resStart, resLen) = countZeros(segments)
            if (resLen > 1) {
                u16ArrToHexString(sb, segments[..resStart])
                sb.append("::")
                u16ArrToHexString(sb, segments[resStart + resLen..])
            } else {
                u16ArrToHexString(sb, segments)
            }
        }
        if (let Some(scopeId) <- _scopeId) {
            sb.append("%${scopeId}")
        }
        return sb.toString()
    }

    func countZeros(segments: Array<UInt16>): (Int64, Int64) {
        var curLen = 0
        var curStart = 0
        var resStart = 0
        var resLen = 0
        for (i in 0..segments.size) {
            let segment = segments[i]
            if (segment == 0) {
                if (curLen == 0) {
                    curStart = i
                }
                curLen++
                if (curLen > resLen) {
                    resStart = curStart
                    resLen = curLen
                }
            } else {
                curStart = 0
                curLen = 0
            }
        }
        return (resStart, resLen)
    }

    func u16ArrToHexString(sb: StringBuilder, chunk: Array<UInt16>) {
        if (chunk.size > 0) {
            sb.append(chunk[0].format("x"))
            if (chunk.size > 1) {
                for (segment in chunk[1..]) {
                    sb.append(":")
                    sb.append(segment.format("x"))
                }
            }
        }
    }
}

extend UInt16 {
    func toBigEndian(): UInt16 {
        match (Endian.Platform) {
            case Big => this
            case Little => this.swapBytes()
        }
    }
}
