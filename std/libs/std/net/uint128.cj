/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.net

import std.binary.*
import std.convert.*
import std.overflow.*

@C
struct UInt128 {
    static prop Max: UInt128 {
        get() {
            UInt128(0xFFFF_FFFF_FFFF_FFFFu64, 0xFFFF_FFFF_FFFF_FFFFu64)
        }
    }
    static prop Min: UInt128 {
        get() {
            UInt128(0u64, 0u64)
        }
    }
    private let _hi: UInt64
    private let _lo: UInt64
    public const init(hi: UInt64, lo: UInt64) {
        this._hi = hi
        this._lo = lo
    }
    public func checkedShl(shiftcount: UInt64): ?UInt128 {
        if (shiftcount >= 128 || shiftcount < 0) {
            return None
        }
        if (shiftcount < 64) {
            let hi = _hi.wrappingShl(shiftcount) | _lo.wrappingShr(64 - shiftcount)
            let lo = _lo.wrappingShl(shiftcount)
            return UInt128(hi, lo)
        } else {
            let hi = _lo.wrappingShl(shiftcount - 64)
            return UInt128(hi, 0)
        }
    }
    public func checkedShr(shiftcount: UInt64): ?UInt128 {
        if (shiftcount >= 128 || shiftcount < 0) {
            return None
        }
        if (shiftcount < 64) {
            let lo = _lo.wrappingShr(shiftcount) | _hi.wrappingShl(64 - shiftcount)
            let hi = _hi.wrappingShr(shiftcount)
            return UInt128(hi, lo)
        } else {
            let lo = _hi.wrappingShr(shiftcount - 64)
            return UInt128(0, lo)
        }
    }
    public operator func &(rhs: UInt128): UInt128 {
        return UInt128(this._hi & rhs._hi, this._lo & rhs._lo)
    }
    public operator func ^(rhs: UInt128): UInt128 {
        return UInt128(this._hi ^ rhs._hi, this._lo ^ rhs._lo)
    }
    public operator func |(rhs: UInt128): UInt128 {
        return UInt128(this._hi | rhs._hi, this._lo | rhs._lo)
    }
    public operator func !(): UInt128 {
        return UInt128(!this._hi, !this._lo)
    }
    public func toU16(): Array<UInt16> {
        let src = toBigEndian()
        let dst = Array<UInt16>(src.size / 2, repeat: 0)
        for (i in 0..dst.size) {
            dst[i] = UInt16.readBigEndian(src[i * 2..])
        }
        return dst
    }
    public static func fromU16(src: Array<UInt16>): UInt128 {
        let dst = Array<UInt8>(src.size * 2, repeat: 0)
        for (i in 0..src.size) {
            src[i].writeBigEndian(dst[i * 2..])
        }
        return UInt128.readBigEndian(dst)
    }
    public static func readBigEndian(buf: Array<UInt8>): UInt128 {
        return UInt128(UInt64.readBigEndian(buf), UInt64.readBigEndian(buf[8..]))
    }
    public func writeBigEndian(buf: Array<UInt8>): Int64 {
        _hi.writeBigEndian(buf)
        _lo.writeBigEndian(buf[8..])
        return 16
    }
    public static func readLittleEndian(buf: Array<UInt8>): UInt128 {
        return UInt128(UInt64.readLittleEndian(buf[8..]), UInt64.readLittleEndian(buf[..8]))
    }
    public func writeLittleEndian(buf: Array<UInt8>): Int64 {
        _lo.writeLittleEndian(buf)
        _hi.writeLittleEndian(buf[8..])
        return 16
    }
    public func toBigEndian(): Array<UInt8> {
        let buf = Array<Byte>(16, repeat: 0)
        writeBigEndian(buf)
        return buf
    }
    public func toLittleEndian(): Array<UInt8> {
        let buf = Array<Byte>(16, repeat: 0)
        writeLittleEndian(buf)
        return buf
    }
    public func swapBytes(): UInt128 {
        UInt128(this._lo.swapBytes(), this._hi.swapBytes())
    }
    public operator func ==(rhs: UInt128): Bool {
        return this._hi == rhs._hi && this._lo == rhs._lo
    }
    public operator func !=(rhs: UInt128): Bool {
        return !(this == rhs)
    }
    public func toString(): String {
        let octets = toLittleEndian()
        let sb = StringBuilder()
        for (i in octets) {
            sb.append(i.format("#x"))
            sb.append(" ")
        }
        return sb.toString()
    }
}
