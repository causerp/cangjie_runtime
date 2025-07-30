/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/**
 * @file The file declares several ffi functions and classes.
 */

package std.net

const SOCK_ADDR_IPV4_LEN: Int64 = 4
const SOCK_ADDR_IPV6_LEN: Int64 = 16
const SOCK_ADDR_DOMAIN_LEN: Int64 = 108
// XXX: TCP use this, while Unix/Udp should be 0xFFFF, but in write/send, we still use this to do checking.
const SOCK_READ_BUFFER_SIZE: Int32 = 4 * 1024
const SOCK_WRITE_BUFFER_SIZE: Int32 = 64 * 1024
const NULL_BYTE = "\0"
const IPV4_ADDR_LEN: Int64 = 16
const IPV6_ADDR_LEN: Int64 = 28
/**
 * CJ_SockCreate domain
 */
const AF_INET: Int16 = 2
@When[os != "Windows" && os != "macOS"]
const AF_UNIX: Int16 = 1
@When[os != "Windows" && os != "macOS"]
const AF_INET6: Int16 = 10
@When[os != "Windows" && os != "macOS"]
const AF_NETLINK: Int16 = 16
@When[os != "Windows" && os != "macOS"]
const AF_PACKET: Int16 = 17
@When[os == "Windows"]
const AF_UNIX: Int16 = 0
@When[os == "Windows"]
const AF_INET6: Int16 = 23
@When[os == "macOS"]
const AF_UNIX: Int16 = 1
@When[os == "macOS"]
const AF_INET6: Int16 = 30

/**
 * CJ_SockCreate type
 */
let SOCKET_STREAM: Int32 = 1
let SOCKET_DGRAM: Int32 = 2
let SOCKET_RAW: Int32 = 3
let SOCKET_SEQPACKET: Int32 = 5

/**
 * sock option level
 */
const IPPROTO_IP: Int32 = 0
const IPPROTO_ICMP: Int32 = 1
const IPPROTO_IPV4: Int32 = 4
const IPPROTO_TCP: Int32 = 6
const IPPROTO_UDP: Int32 = 17
const IPPROTO_IPV6: Int32 = 41
const IPPROTO_RAW: Int32 = 255
@When[os != "Windows" && os != "macOS"]
const SOL_SOCKET: Int32 = 1
@When[os == "Windows" || os == "macOS"]
const SOL_SOCKET: Int32 = 0xFFFF

/**
 * sock option optname, If the value of an option is 0xFFFF, the option is not supported in the environment.
 */
@When[os != "Windows" && os != "macOS"]
const SOCK_DEBUG: Int32 = 0x0001
@When[os != "Windows" && os != "macOS"]
const SOCK_REUSEADDR: Int32 = 0x0002
@When[os != "Windows" && os != "macOS"]
const SOCK_ERROR: Int32 = 0x0004
@When[os != "Windows" && os != "macOS"]
const SOCK_DONTROUTE: Int32 = 0x0005
@When[os != "Windows" && os != "macOS"]
const SOCK_BROADCAST: Int32 = 0x0006
@When[os != "Windows" && os != "macOS"]
const SOCK_SNDBUF: Int32 = 0x0007
@When[os != "Windows" && os != "macOS"]
const SOCK_RCVBUF: Int32 = 0x0008
@When[os != "Windows" && os != "macOS"]
const SOCK_KEEPALIVE: Int32 = 0x0009
@When[os != "Windows" && os != "macOS"]
const SOCK_OOBINLINE: Int32 = 0x000A
@When[os != "Windows" && os != "macOS"]
const SOCK_LINGER: Int32 = 0x000D
@When[os != "Windows" && os != "macOS"]
const SOCK_REUSEPORT: Int32 = 0x000F
@When[os != "Windows" && os != "macOS"]
const SOCK_RCVTIMEO: Int32 = 0x0014
@When[os != "Windows" && os != "macOS"]
const SOCK_SNDTIMEO: Int32 = 0x0015
@When[os != "Windows" && os != "macOS"]
const SOCK_BINDTODEVICE: Int32 = 0x0019
@When[os != "Windows" && os != "macOS"]
const SOCK_ACCEPTCONN: Int32 = 0x001E
@When[os != "Windows" && os != "macOS"]
const SOCK_TCP_NODELAY: Int32 = 0x0001
@When[os != "Windows" && os != "macOS"]
const SOCK_TCP_QUICKACK: Int32 = 0x000C
@When[os != "Windows" && os != "macOS"]
const SOCK_TCP_KEEPIDLE: Int32 = 0x0004
@When[os != "Windows" && os != "macOS"]
const SOCK_TCP_KEEPINTVL: Int32 = 0x0005
@When[os != "Windows" && os != "macOS"]
const SOCK_TCP_KEEPCNT: Int32 = 0x0006
@When[os != "Windows" && os != "macOS"]
const SOCK_IP_TOS: Int32 = 0x0001
@When[os != "Windows" && os != "macOS"]
const SOCK_IP_TTL: Int32 = 0x0002
@When[os != "Windows" && os != "macOS"]
const SOCK_IP_HDRINCL: Int32 = 0x0003
@When[os == "Windows"]
const SOCK_DEBUG: Int32 = 0x0001
@When[os == "Windows"]
const SOCK_ACCEPTCONN: Int32 = 0x0002
@When[os == "Windows"]
const SOCK_REUSEADDR: Int32 = 0x0004
@When[os == "Windows"]
const SOCK_KEEPALIVE: Int32 = 0x0008
@When[os == "Windows"]
const SOCK_DONTROUTE: Int32 = 0x0010
@When[os == "Windows"]
const SOCK_BROADCAST: Int32 = 0x0020
@When[os == "Windows"]
const SOCK_OOBINLINE: Int32 = 0x0100
@When[os == "Windows"]
const SOCK_LINGER: Int32 = 0x0080
@When[os == "Windows"]
const SOCK_SNDBUF: Int32 = 0x1001
@When[os == "Windows"]
const SOCK_RCVBUF: Int32 = 0x1002
@When[os == "Windows"]
const SOCK_SNDTIMEO: Int32 = 0x1005
@When[os == "Windows"]
const SOCK_RCVTIMEO: Int32 = 0x1006
@When[os == "Windows"]
const SOCK_ERROR: Int32 = 0x1007
@When[os == "Windows"]
const SOCK_TYPE: Int32 = 0x1008
@When[os == "Windows"]
const SOCK_REUSEPORT: Int32 = 0xFFFF // Not on windows
@When[os == "Windows"]
const SOCK_BINDTODEVICE: Int32 = 0xFFFF // Not on windows

@When[os == "Windows"]
const SOCK_TCP_NODELAY: Int32 = 0x0001
@When[os == "Windows"]
const SOCK_TCP_KEEPIDLE: Int32 = 0x0003
@When[os == "Windows"]
const SOCK_TCP_KEEPCNT: Int32 = 0x0010
@When[os == "Windows"]
const SOCK_TCP_KEEPINTVL: Int32 = 0x0011
@When[os == "Windows"]
const SOCK_TCP_QUICKACK: Int32 = 0xFFFF // Not on windows

@When[os == "Windows"]
const SOCK_IP_HDRINCL: Int32 = 0x0002
@When[os == "Windows"]
const SOCK_IP_TOS: Int32 = 0x0003
@When[os == "Windows"]
const SOCK_IP_TTL: Int32 = 0x0004
@When[os == "macOS"]
const SOCK_DEBUG: Int32 = 0x0001
@When[os == "macOS"]
const SOCK_ACCEPTCONN: Int32 = 0x0002
@When[os == "macOS"]
const SOCK_REUSEADDR: Int32 = 0x0004
@When[os == "macOS"]
const SOCK_KEEPALIVE: Int32 = 0x0008
@When[os == "macOS"]
const SOCK_DONTROUTE: Int32 = 0x0010
@When[os == "macOS"]
const SOCK_BROADCAST: Int32 = 0x0020
@When[os == "macOS"]
const SOCK_OOBINLINE: Int32 = 0x0100
@When[os == "macOS"]
const SOCK_LINGER: Int32 = 0x0080
@When[os == "macOS"]
const SOCK_SNDBUF: Int32 = 0x1001
@When[os == "macOS"]
const SOCK_RCVBUF: Int32 = 0x1002
@When[os == "macOS"]
const SOCK_SNDTIMEO: Int32 = 0x1005
@When[os == "macOS"]
const SOCK_RCVTIMEO: Int32 = 0x1006
@When[os == "macOS"]
const SOCK_ERROR: Int32 = 0x1007
@When[os == "macOS"]
const SOCK_TYPE: Int32 = 0x1008
@When[os == "macOS"]
const SOCK_REUSEPORT: Int32 = 0x0200
@When[os == "macOS"]
const SOCK_BINDTODEVICE: Int32 = 0xFFFF // Not on macOS

@When[os == "macOS"]
const SOCK_TCP_NODELAY: Int32 = 0x0001
@When[os == "macOS"]
const SOCK_TCP_KEEPIDLE: Int32 = 0x0010
@When[os == "macOS"]
const SOCK_TCP_KEEPCNT: Int32 = 0x0102
@When[os == "macOS"]
const SOCK_TCP_KEEPINTVL: Int32 = 0x0101
@When[os == "macOS"]
const SOCK_TCP_QUICKACK: Int32 = 0xFFFF // Not on macOS

@When[os == "macOS"]
const SOCK_IP_HDRINCL: Int32 = 0x0002
@When[os == "macOS"]
const SOCK_IP_TOS: Int32 = 0x0003
@When[os == "macOS"]
const SOCK_IP_TTL: Int32 = 0x0004

/**
 * tcp socket default backlog
 */
const SOCKET_DEFAULT_BACKLOG: Int32 = 1024

/**
 * keep alive configuration struct
 */
@C
struct SockKeepAliveCfgS {
    /* Indicates whether to enable the keepalive function. The options are as follows: 0: disable 1: enable */
    var keep_alive: UInt32

    /* If no data is exchanged within the `idle` period (second), the probe is performed. */
    var idle: UInt32

    /* The interval for sending probe packets is `interval` (second). */
    var interval: UInt32

    /* Number of times probe packets are sent. If all times out, the connection is considered invalid. */
    var count: UInt32
    init(keep_alive!: UInt32, idle!: UInt32, interval!: UInt32, count!: UInt32) {
        this.keep_alive = keep_alive
        this.idle = idle
        this.interval = interval
        this.count = count
    }
}

foreign {
    func CJ_SockErrnoGet(): Int32

    func CJ_SockKeepAliveSet(sock: Int64, cfg: CPointer<SockKeepAliveCfgS>): Int32

    func CJ_SockOptionSet(sock: Int64, level: Int32, optname: Int32, optval: CPointer<Unit>, oplen: Int32): Int32

    func CJ_SockOptionGet(
        sock: Int64,
        level: Int32,
        optname: Int32,
        optval: CPointer<Unit>,
        oplen: CPointer<Int32>
    ): Int32

    func CJ_SOCKET_GetErrMessage(errno: Int32): CString

    func CJ_GetOptionInt(sock: Int64, level: Int32, optname: Int32): Int32

    func CJ_SetOptionInt(sock: Int64, level: Int32, optname: Int32, optval: Int32): Int32
    // raw socket
    func CJ_RawAddressCreate(arr: CPointer<Byte>, size: Int32): CPointer<SockAddr>

    func CJ_RawAddressLenGet(addrPtr: CPointer<SockAddr>): UIntNative

    func CJ_RawAddressDestroy(addrPtr: CPointer<SockAddr>): Unit
}

func getAddrPointer(addr: Array<Byte>): (CPointerHandle<Byte>, CPointer<SockAddr>) {
    unsafe {
        let handle = acquireArrayRawData(addr)
        let addrPtr = CJ_RawAddressCreate(handle.pointer, Int32(addr.size))
        if (addrPtr.isNull()) {
            releaseArrayRawData(handle)
            throw SocketException("Failed to allocate memory.")
        }
        return (handle, addrPtr)
    }
}

func releaseAddrPointer(handle: CPointerHandle<Byte>, addrPtr: CPointer<SockAddr>): Unit {
    unsafe {
        releaseArrayRawData(handle)
        CJ_RawAddressDestroy(addrPtr)
    }
}
