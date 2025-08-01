/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.net

type sa_family_t = UInt16

type in_port_t = UInt16

type socklen_t = UInt32

type SockAddrByte = Byte

@C
struct AddrInfo {
    /* additional options, multiple options can be used in conjunction with the or operation */
    var ai_flags: Int32 = 0
    /* AF_INET(IPv4), AF_INET6(IPv6), AF_UNSPEC(IPv4 and IPv6) */
    var ai_family: Int32 = 0
    /* enum __socket_type Type, set to 0 for any type */
    var ai_socktype: Int32 = 0
    /* Protocol type. The value 0 indicates any type. */
    var ai_protocol: Int32 = 0
    /* Length of the socket address */
    var ai_addrlen: socklen_t = 0
    /**
     * ai_addr: The socket address.
     * ai_canonname: the nanonical name of service location.
     * Offset of ai_addr and ai_canonname in struct AddrInfo differs on different platform,
     * e.g. ai_addr before ai_canonname on Linux, ai_addr after ai_canonname on Windows.
     * Here we not make the order clear. When using it, we must get the value from C side.
     */
    var ptr1 = CPointer<Unit>()
    var ptr2 = CPointer<Unit>()
    /* point to the next piece of information, as multiple addresses may be returned */
    var ai_next = CPointer<AddrInfo>()
}

@C
struct SockAddrIn {
    var family: sa_family_t = 0 /* address family: AF_INET */
    var port: in_port_t = 0 /* port in network byte order */
    var addr: UInt32 = 0 /* internet address */
    let pad: Int64 = 0
}

@C
struct SockAddrIn6 {
    var family: sa_family_t = 0 /* AF_INET6 */
    var port: in_port_t = 0 /* port number */
    var flowinfo: UInt32 = 0 /* IPv6 flow information */

    // var addr: VArray<Byte, $16> = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] /* IPv6 address */
    // var addr: UInt128 = UInt128(0, 0)
    var addr: UInt32 = 0
    var pad1: UInt32 = 0
    var pad2: UInt32 = 0
    var pad3: UInt32 = 0
    var scope_id: UInt32 = 0 /* Scope ID (new in 2.4) */
}

type PAddrinfo = CPointer<AddrInfo>

foreign func getaddrinfo(node: CString, service: CPointer<Byte>, hints: PAddrinfo, res: CPointer<PAddrinfo>): Int32

foreign func freeaddrinfo(res: PAddrinfo): Unit

foreign func CJ_SOCKET_GetAddrFromAddrinfo(info: CPointer<AddrInfo>): CPointer<SockAddrByte>

struct SockAddrUn {
    var family: sa_family_t = 0 /* AF_UNIX */
    var sun_path = Array<Byte>(108, repeat: 0) /* Pathname */
}
