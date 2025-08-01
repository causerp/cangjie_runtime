/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.net

const SOCK_LEN_MAX: Int64 = 120

/**
 * Socket domain values.
 */
@When[os != "Windows" && os != "macOS"]
public struct SocketDomain <: Equatable<SocketDomain> & ToString & Hashable {
    let val: Int32

    public static let IPV4: SocketDomain = SocketDomain(AF_INET)
    public static let IPV6: SocketDomain = SocketDomain(AF_INET6)
    public static let UNIX: SocketDomain = SocketDomain(AF_UNIX)
    public static let NETLINK: SocketDomain = SocketDomain(AF_NETLINK)
    public static let PACKET: SocketDomain = SocketDomain(AF_PACKET)

    private init(domain: Int16) {
        this(Int32(domain))
    }

    public init(domain: Int32) {
        this.val = domain
    }

    public operator func ==(r: SocketDomain): Bool {
        return this.val == r.val
    }

    public operator func !=(r: SocketDomain): Bool {
        return !(this == r)
    }

    public func toString(): String {
        return match {
            case val == Int32(AF_INET) => "IPv4"
            case val == Int32(AF_INET6) => "IPv6"
            case val == Int32(AF_UNIX) => "unix"
            case val == Int32(AF_NETLINK) => "netlink"
            case val == Int32(AF_PACKET) => "packet"
            case _ => "Domain(${val})"
        }
    }

    public func hashCode(): Int64 {
        return Int64(val)
    }
}

@When[os == "Windows" || os == "macOS"]
public struct SocketDomain <: Equatable<SocketDomain> & ToString & Hashable {
    let val: Int32

    public static let IPV4: SocketDomain = SocketDomain(AF_INET)
    public static let IPV6: SocketDomain = SocketDomain(AF_INET6)
    public static let UNIX: SocketDomain = SocketDomain(AF_UNIX)

    private init(domain: Int16) {
        this(Int32(domain))
    }

    public init(domain: Int32) {
        this.val = domain
    }

    public operator func ==(r: SocketDomain): Bool {
        return this.val == r.val
    }

    public operator func !=(r: SocketDomain): Bool {
        return !(this == r)
    }

    public func toString(): String {
        return match {
            case val == Int32(AF_INET) => "IPv4"
            case val == Int32(AF_INET6) => "IPv6"
            case val == Int32(AF_UNIX) => "unix"
            case _ => "Domain(${val})"
        }
    }

    public func hashCode(): Int64 {
        return Int64(val)
    }
}

/**
 * Socket type values.
 */
public struct SocketType <: Equatable<SocketType> & ToString & Hashable {
    let val: Int32

    public static let STREAM: SocketType = SocketType(SOCKET_STREAM)
    public static let DATAGRAM: SocketType = SocketType(SOCKET_DGRAM)
    public static let RAW: SocketType = SocketType(SOCKET_RAW)
    public static let SEQPACKET: SocketType = SocketType(SOCKET_SEQPACKET)

    public init(`type`: Int32) {
        this.val = `type`
    }

    public operator func ==(r: SocketType): Bool {
        return this.val == r.val
    }

    public operator func !=(r: SocketType): Bool {
        return !(this == r)
    }

    public func toString(): String {
        return match {
            case val == SOCKET_STREAM => "STREAM"
            case val == SOCKET_DGRAM => "DATAGRAM"
            case val == SOCKET_RAW => "RAW"
            case val == SOCKET_SEQPACKET => "SEQPACKET"
            case _ => "Type(${val})"
        }
    }

    public func hashCode(): Int64 {
        return Int64(val)
    }
}

/**
 * Socket protocol values.
 */
public struct ProtocolType <: Equatable<ProtocolType> & ToString & Hashable {
    let val: Int32

    public static let Unspecified: ProtocolType = ProtocolType(0)
    public static let IPV4: ProtocolType = ProtocolType(IPPROTO_IPV4)
    public static let IPV6: ProtocolType = ProtocolType(IPPROTO_IPV6)
    public static let ICMP: ProtocolType = ProtocolType(IPPROTO_ICMP)
    public static let TCP: ProtocolType = ProtocolType(IPPROTO_TCP)
    public static let UDP: ProtocolType = ProtocolType(IPPROTO_UDP)
    public static let RAW: ProtocolType = ProtocolType(IPPROTO_RAW)

    public init(protocol: Int32) {
        this.val = protocol
    }

    public operator func ==(r: ProtocolType): Bool {
        return this.val == r.val
    }

    public operator func !=(r: ProtocolType): Bool {
        return !(this == r)
    }

    public func toString(): String {
        return match {
            case val == 0 => "Unspecified"
            case val == IPPROTO_IPV4 => "IPv4"
            case val == IPPROTO_IPV6 => "IPv6"
            case val == IPPROTO_ICMP => "ICMP"
            case val == IPPROTO_TCP => "TCP"
            case val == IPPROTO_UDP => "UDP"
            case val == IPPROTO_RAW => "RAW"
            case _ => "Protocol(${val})"
        }
    }

    public func hashCode(): Int64 {
        return Int64(val)
    }
}

/**
 * Socket option level values.
 */
public struct OptionLevel {
    public static const IP: Int32 = IPPROTO_IP
    public static const TCP: Int32 = IPPROTO_TCP
    public static const UDP: Int32 = IPPROTO_UDP
    public static const ICMP: Int32 = IPPROTO_ICMP
    public static const RAW: Int32 = IPPROTO_RAW
    public static const SOCKET: Int32 = SOL_SOCKET
}

/**
 * Socket optoin name values.
 */
public struct OptionName {
    // IPOption
    public static const IP_HDRINCL: Int32 = SOCK_IP_HDRINCL
    public static const IP_TOS: Int32 = SOCK_IP_TOS
    public static const IP_TTL: Int32 = SOCK_IP_TTL
    // TCPOption
    public static const TCP_KEEPCNT: Int32 = SOCK_TCP_KEEPCNT
    public static const TCP_KEEPIDLE: Int32 = SOCK_TCP_KEEPIDLE
    public static const TCP_KEEPINTVL: Int32 = SOCK_TCP_KEEPINTVL
    public static const TCP_NODELAY: Int32 = SOCK_TCP_NODELAY
    // SOCKETOption
    public static const SO_DEBUG: Int32 = SOCK_DEBUG
    public static const SO_ACCEPTCONN: Int32 = SOCK_ACCEPTCONN
    public static const SO_REUSEADDR: Int32 = SOCK_REUSEADDR
    public static const SO_KEEPALIVE: Int32 = SOCK_KEEPALIVE
    public static const SO_DONTROUTE: Int32 = SOCK_DONTROUTE
    public static const SO_BROADCAST: Int32 = SOCK_BROADCAST
    public static const SO_LINGER: Int32 = SOCK_LINGER
    public static const SO_OOBINLINE: Int32 = SOCK_OOBINLINE
    public static const SO_SNDBUF: Int32 = SOCK_SNDBUF
    public static const SO_RCVBUF: Int32 = SOCK_RCVBUF
    public static const SO_SNDTIMEO: Int32 = SOCK_SNDTIMEO
    public static const SO_RCVTIMEO: Int32 = SOCK_RCVTIMEO
    public static const SO_ERROR: Int32 = SOCK_ERROR
}

/**
 * This class defines the address for RawSocket.
 */
public struct RawAddress {
    let addr_: Array<Byte>

    /* Get the array of RawAddress */
    public prop addr: Array<Byte> {
        get() {
            this.addr_
        }
    }

    /**
     * Initialize an address with a byte array.
     * The byte array needs to be memory aligned with the C struct, such as SockAddrIn, SockAddrUn.
     *
     * @param addr The byte sequence corresponding to socket address.
     */
    public init(addr: Array<Byte>) {
        this.addr_ = addr
    }
}

func getTimeout(timeout: Option<Duration>): Int64 {
    match (timeout) {
        case Some(v) =>
            if (v < Duration.Zero) {
                throw IllegalArgumentException("Timeout should not be negative.")
            }
            if (v > MAX_TIMEOUT_DURATION) {
                return MAX_TIMEOUT_NS
            }
            return v.toNanoseconds()
        case None => return -1
    }
}
