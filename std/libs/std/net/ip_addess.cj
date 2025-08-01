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

const IPV4_ADDRESS_LEN: Int64 = 4
const IPV6_ADDRESS_LEN: Int64 = 16

sealed abstract class IPAddress <: ToString & Equatable<IPAddress> & Hashable & BigEndianOrder<IPAddress> {
    public prop size: Int64 {
        get() {
            match (this) {
                case v4: IPv4Address => 4
                case v6: IPv6Address => 16
                case _ => 0
            }
        }
    }

    public prop hostName: ?String {
        get() {
            throw UnsupportedException("Current not supported.")
        }
    }

    // parse a address string into IPAddress
    public static func parse(s: String): IPAddress {
        for (b in s) {
            match (b) {
                case b'.' => return parseIPv4(s, s).unwrap()
                case b':' => return parseIPv6(s, s).unwrap()
                case b'%' => throw IllegalFormatException("Missing IPv6 address: ${s}.")
                case _ => ()
            }
        }
        throw IllegalFormatException("Unable to parse IP: '${s}'.")
    }

    public static func tryParse(s: String): ?IPAddress {
        for (b in s) {
            match (b) {
                case b'.' => match (parseIPv4(s, s)) {
                    case Ok(v) => return Some(v)
                    case _ => return None
                }
                case b':' => match (parseIPv6(s, s)) {
                    case Ok(v) => return Some(v)
                    case _ => return None
                }
                case b'%' => return None
                case _ => ()
            }
        }
        return None
    }

    // resolve domain
    public static func resolve(family: AddressFamily, domain: String): Array<IPAddress> {
        match (IPAddress.tryParse(domain)) {
            case Some(ip) => return [ip]
            case _ =>
                if (!isDomainValid(domain)) {
                    return []
                }
                return resolveDomain(family, domain)
        }
    }

    public static func resolve(domain: String): Array<IPAddress> {
        return IPAddress.resolve(AddressFamily.UNSPEC, domain)
    }

    // get addr bytes
    public func getAddressBytes(): Array<Byte> {
        match (this) {
            case v4: IPv4Address =>
                let arr = Array<Byte>(4, repeat: 0)
                v4.writeBigEndian(arr)
                return arr
            case v6: IPv6Address =>
                let arr = Array<Byte>(IPV6_ADDRESS_LEN, repeat: 0)
                v6.writeBigEndian(arr)
                return arr
            case _ => return Array<Byte>()
        }
    }

    // is ipv4 addr
    public func isIPv4(): Bool {
        match (this) {
            case v4: IPv4Address => true
            case v6: IPv6Address => false
            case _ => throw Exception()
        }
    }
    // is ipv6 addr
    public func isIPv6(): Bool {
        match (this) {
            case v4: IPv4Address => false
            case v6: IPv6Address => true
            case _ => throw Exception()
        }
    }

    // either the IPv4 address "0.0.0.0" or the IPv6 address "::".
    public open func isUnspecified(): Bool {
        match (this) {
            case v4: IPv4Address => v4.isUnspecified()
            case v6: IPv6Address => v6.isUnspecified()
            case _ => false
        }
    }

    // Requirements for Internet Hosts -- Communication Layers (3.2.1.3 Addressing)
    // https://www.rfc-editor.org/rfc/rfc1122.html#section-3.2.1.3
    public open func isLoopback(): Bool {
        match (this) {
            case v4: IPv4Address => v4.isLoopback()
            case v6: IPv6Address => v6.isLoopback()
            case _ => false
        }
    }

    // Host Extensions for IP Multicasting (4. HOST GROUP ADDRESSES)
    // https://www.rfc-editor.org/rfc/rfc1112.html#section-4
    public open func isMulticast(): Bool
    // RFC 1918 allocates 10.0.0.0/8, 172.16.0.0/12, and 192.168.0.0/16 as
    // private IPv4 address subnets.
    public open func isPrivate(): Bool
    // Dynamic Configuration of IPv4 Link-Local Addresses
    // https://www.rfc-editor.org/rfc/rfc3927.html#section-2.1
    public open func isLinkLocal(): Bool
    // Whether the address is a global unicast IPv6 address or a public IPv4 address
    public open func isGlobalUnicast(): Bool

    // Obtains the IP prefix object based on the prefix length.
    public open func getPrefix(prefixLen: UInt8): IPPrefix {
        match (this) {
            case v4: IPv4Address => v4.getPrefix(prefixLen)
            case v6: IPv6Address => v6.getPrefix(prefixLen)
            case _ => throw Exception()
        }
    }

    public open func writeBigEndian(buffer: Array<Byte>): Int64 {
        match (this) {
            case v4: IPv4Address => v4.writeBigEndian(buffer)
            case v6: IPv6Address => v6.writeBigEndian(buffer)
            case _ => throw Exception()
        }
    }

    public static func readBigEndian(buffer: Array<Byte>): IPAddress {
        if (buffer.size == 4) {
            return IPv4Address(buffer[0], buffer[1], buffer[2], buffer[3])
        }
        if (buffer.size == 16) {
            return IPv6Address(buffer)
        }
        throw IllegalArgumentException("The buffer size must be 4 or 16")
    }

    public operator func ==(rhs: IPAddress): Bool {
        match ((this, rhs)) {
            case (lv4: IPv4Address, rv4: IPv4Address) => lv4 == rv4
            case (lv6: IPv6Address, rv6: IPv6Address) => lv6 == rv6
            case _ => false
        }
    }
    public operator func !=(rhs: IPAddress): Bool {
        return !(this == rhs)
    }

    public func hashCode(): Int64 {
        var df = DefaultHasher()
        match (this) {
            case v4: IPv4Address => df.write(v4.toBits())
            case v6: IPv6Address => for (i in 0..v6._octets.size) {
                df.write(v6._octets[i])
                if (let Some(scopeId) <- v6.scopeId) {
                    df.write(scopeId)
                }
            }
            case _ => throw Exception()
        }
        df.finish()
    }
}

func parseIPv4(address: String, origin: String): Result<IPv4Address> {
    if (address.size < 7) {
        return Err(IllegalFormatException("Parse (${origin}): IPv4 address too short."))
    }
    if (address.size > 15) {
        return Err(IllegalFormatException("Parse (${origin}): IPv4 address too long."))
    }

    var ip = Array<Byte>(IPV4_ADDRESS_LEN, repeat: 0)
    var cur = 0
    var s = address[cur..]
    var count = 0
    for (i in 0..ip.size) {
        match (parseNumber(s, 10, 1, 3, false, origin)) {
            case Ok((digit, bytes_read)) =>
                if (digit > 255) {
                    return Err(IllegalFormatException("Parse (${origin}): IPv4 field has value >255."))
                }
                ip[i] = UInt8(digit)
                s = s[bytes_read..]
                count++
                if (count == 4) {
                    break
                }
                if (s.size == 0) {
                    break
                }
                if (s[0] != b'.') {
                    return Err(IllegalFormatException("Parse (${origin}): unexpected character."))
                }
                // skip the dot
                s = s[1..]
            case Err(e) => return Err(e)
        }
    }
    if (count != IPV4_ADDRESS_LEN) {
        return Err(IllegalFormatException("Parse (${origin}): invalid IPv4 address."))
    }
    if (s.size != 0) {
        return Err(IllegalFormatException("Parse (${origin}): unexpected character."))
    }

    return Ok(IPv4Address(ip[0], ip[1], ip[2], ip[3]))
}

// result, bytes_read
func parseNumber(part: String, radix: UInt32, minDigits: UInt8, maxDigits: UInt8, allowZeroPrefix: Bool, origin: String): Result<(UInt32, 
    Int64)> {
    if (part.size == 0) {
        return Err(IllegalFormatException("Parse (${origin}): got empty field part."))
    }
    var result = 0u32
    var digitCount = 0u8
    let hasLeadingZero = part[0] == b'0'

    for (i in 0..part.size) {
        match (part[i].toDigit(radix)) {
            case Some(digit) =>
                result *= radix
                result += digit
                digitCount += 1
                if (digitCount > maxDigits) {
                    return Err(
                        IllegalFormatException("Parse (${origin}): field part value width large than ${maxDigits}."))
                }
            case _ => break
        }
    }
    if (digitCount < minDigits) {
        return Err(IllegalFormatException("Parse (${origin}): each segment must have at least ${minDigits} digit."))
    } else if (!allowZeroPrefix && hasLeadingZero && digitCount > 1) {
        return Err(IllegalFormatException("Parse (${origin}): has leading zero."))
    } else {
        return Ok((result, Int64(digitCount)))
    }
}

@OverflowWrapping
func parseIPv6(src: String, origin: String): Result<IPv6Address> {
    if (src.size < 2) {
        return Err(IllegalFormatException("Parse (${origin}): address string too short."))
    }
    var scopeId: ?UInt32 = None
    var s = src
    // parse scopeId
    if (let Some(v) <- origin.indexOf(b'%')) {
        let zone = s[v + 1..]
        scopeId = UInt32.tryParse(zone) ?? return Err(
            IllegalFormatException("Parse (${origin}): IPv6 scope ID must be a valid UInt32 value."))
        s = s[..v]
    }

    var ellipsis: ?Int64 = None

    if (s.size >= 2 && s[0] == b':') {
        if (s[1] == b':') {
            ellipsis = 0
            s = s[2..]
            if (s.size == 0) {
                return Ok(IPv6Address.unspecified.scope(scopeId))
            }
        } else {
            return Err(IllegalFormatException("Parse (${origin}): unexpected character, want colon."))
        }
    }
    let res = innerParseIPv6(s, origin, ellipsis)
    if (res.isErr()) {
        return Err(res.unwrapErr())
    }
    let (_, o, i, e, ip) = res.unwrap()
    s = s[o..]
    ellipsis = e
    if (s.size != 0) {
        return Err(IllegalFormatException("Parse (${origin}): extra characters at the end of the address."))
    }
    if (i < 16) {
        if (let Some(ellipsis_index) <- ellipsis) {
            let nb_zeros = 16 - i
            for (index in i - 1..=ellipsis_index : -1) {
                ip[index + nb_zeros] = ip[index]
            }
            for (index in ellipsis_index + nb_zeros - 1..=ellipsis_index : -1) {
                ip[index] = 0
            }
        } else {
            return Err(IllegalFormatException("Parse (${origin}): address string too short."))
        }
    } else if (ellipsis.isSome()) {
        return Err(IllegalFormatException("Parse (${origin}): does not contain a valid network address."))
    }
    return Ok(IPv6Address(ip, scopeId: scopeId))
}

@OverflowWrapping
func innerParseIPv6(src: String, origin: String, e: ?Int64): Result<(Bool, Int64, Int64, ?Int64, Array<UInt8>)> {
    var ip = Array<UInt8>(IPV6_ADDRESS_LEN, repeat: 0)
    var s = src
    var i = 0
    var ellipsis = e
    while (i < IPV6_ADDRESS_LEN) {
        var bytes_read = 0
        var hextet = 0u32
        match (parseNumber(s, 16, 0, 4, true, origin)) {
            case Ok((hex, read)) =>
                hextet = hex
                bytes_read = read
            case Err(e) => return Err(e)
        }
        if (bytes_read == 0) {
            if (s[0] != b':') {
                return Err(IllegalFormatException("Parse (${origin}): each field must have at least one digit."))
            }
            if (ellipsis.isSome()) {
                return Err(IllegalFormatException("Parse (${origin}): an IPv6 address can only have one ellipsis."))
            }
            ellipsis = i
            // the colon
            s = s[1..]
            if (s.size == 0) {
                break
            }
            continue
        }
        i += UInt16(hextet).writeBigEndian(ip[i..])
        s = s[bytes_read..]
        if (i == 16 || s.size == 0) {
            break
        }

        match (s[0]) {
            case ':' => s = s[1..]
            // if next byte is '.', may be is mapped-ipv4 addr
            case '.' =>
                if (ellipsis.isNone() && i != 12) {
                    return Err(IllegalFormatException("Parse (${origin}): expect hex digits but got IPv4 address."))
                }
                if (i + 4 > 16) {
                    return Err(IllegalFormatException("Parse (${origin}): too many hex fields."))
                }
                match (parseIPv4(src[src.size - s.size - bytes_read..], origin)) {
                    case Ok(ipv4) =>
                        ipv4.writeBigEndian(ip[i - 2..])
                        i += 2
                        s = s[s.size..]
                    case Err(e) => return Err(e)
                }
                break
            case _ => return Err(IllegalFormatException("Parse (${origin}): contain invalid character."))
        }
    }
    return Ok((true, src.size - s.size, i, ellipsis, ip))
}
