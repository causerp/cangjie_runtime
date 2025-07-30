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

foreign func CJ_MRT_TcpsockInit(): Int32

foreign func CJ_MRT_UdpsockInit(): Int32

foreign func CJ_MRT_RawsockInit(): Int32

@When[os != "Windows"]
foreign func CJ_MRT_DomainsockInit(): Int32

/**
 * For static link, we have to call this init function in coroutine module.
 * Save the result as a global variable to make sure this init function is called before other functions.
 */
let CJ_MRT_TCP_SOCK_INIT: Int32 = unsafe { CJ_MRT_TcpsockInit() }
let CJ_MRT_UDP_SOCK_INIT: Int32 = unsafe { CJ_MRT_UdpsockInit() }
let CJ_MRT_RAW_SOCK_INIT: Int32 = unsafe { CJ_MRT_RawsockInit() }
@When[os != "Windows"]
let CJ_MRT_DOMAIN_SOCK_INIT: Int32 = unsafe {
    CJ_MRT_DomainsockInit()
}

/**
 * CJ_MRT_SockCreate type
 */
const SOCK_STREAM: Int32 = 1
const SOCK_DGRAM: Int32 = 2
@When[os == "Windows" || os == "macOS"]
const SOCK_RDM: Int32 = 4
@When[os == "Windows" || os == "macOS"]
const SOCK_SEQPACKET: Int32 = 5

/* Error code in runtime */
const ERRNO_SOCK_ARG_INVALID: Int32 = 0x100C0000
const ERRNO_SOCK_NOT_SUPPORTED: Int32 = 0x100C0001
const ERRNO_SOCK_NOT_REGISTERED: Int32 = 0x100C0002
const ERRNO_SOCK_HANDLE_INVALID: Int32 = 0x100C0003
const ERRNO_SOCK_FD_NUM_OVER_LIMIT: Int32 = 0x100C0004
const ERRNO_SOCK_TIMEOUT: Int32 = 0x100C0005
const ERRNO_SOCK_CREATE: Int32 = 0x100C0006
const ERRNO_SOCK_EAGAIN: Int32 = 0x100C0007
const ERRNO_SOCK_CLOSED: Int32 = 269484036

func localAddrGet(handle: Int64, addr: CPointer<SockAddr>): Int32 {
    unsafe { CJ_MRT_SockLocalAddrGet(handle, addr) }
}

func peerAddrGet(handle: Int64, addr: CPointer<SockAddr>): Int32 {
    unsafe { CJ_MRT_SockPeerAddrGet(handle, addr) }
}

/*
 * @throws SocketException while some system errors are happened.
 * @throws SocketException while malloc socket address is failed.
 */
func getAddress(handle: Int64, getAddressFunc: (Int64, CPointer<SockAddr>) -> Int32, msg: String): SockAddr {
    var addr = SockAddr()
    let res: Int32 = getAddressFunc(handle, inout addr)
    if (res < 0) {
        let errno: Int32 = unsafe { CJ_SockErrnoGet() }
        unsafe { addr.free() }
        throw SocketException("Failed to obtain the ${msg} address: ${sockError(errno)}.")
    }
    return addr
}

func getLocalAddress(handle: Int64): SocketAddress {
    let addr = getAddress(handle, localAddrGet, "local")
    let local = unsafe { addr.toSocketAddress() }
    unsafe { addr.free() }
    return local
}

func getRemoteAddress(handle: Int64): SocketAddress {
    let addr = getAddress(handle, peerAddrGet, "remote")
    let local = unsafe { addr.toSocketAddress() }
    unsafe { addr.free() }
    return local
}

foreign {
    func CJ_MRT_SockCreate(domain: Int32, sock_type: Int32, protocol: Int32, net: CString): Int64

    func CJ_MRT_SockBind(sock: Int64, addr: CPointer<SockAddr>, backlog: Int32): Int64

    func CJ_MRT_SockAccept(sock: Int64, addr: CPointer<SockAddr>): Int64

    func CJ_MRT_SockAcceptTimeout(sock: Int64, addr: CPointer<SockAddr>, timeout: UInt64): Int64

    func CJ_MRT_SockConnect(sock: Int64, local_addr: CPointer<SockAddr>, peer_addr: CPointer<SockAddr>): Int64

    func CJ_MRT_SockConnectTimeout(sock: Int64, local_addr: CPointer<SockAddr>, peer_addr: CPointer<SockAddr>,
        timeout: UInt64): Int64

    func CJ_MRT_SockDisconnect(sock: Int64, isIpv6: Bool): Int32

    func CJ_MRT_SockClose(sock: Int64): Int32

    func CJ_MRT_SockShutdown(sock: Int64): Int32

    func CJ_MRT_SockSend(sock: Int64, buf: CPointer<UInt8>, length: UInt32, flags: Int32): Int32

    func CJ_MRT_SockSendTimeout(sock: Int64, buf: CPointer<UInt8>, length: UInt32, flags: Int32, timeout: UInt64): Int32

    func CJ_MRT_SockSendNonBlock(handle: Int64, buf: CPointer<UInt8>, len: Int32, flags: Int32): Int32

    func CJ_MRT_SockRecv(sock: Int64, buf: CPointer<UInt8>, length: UInt32, flags: Int32): Int32

    func CJ_MRT_SockRecvTimeout(sock: Int64, buf: CPointer<UInt8>, length: UInt32, flags: Int32, timeout: UInt64): Int32

    func CJ_MRT_SockRecvNonBlock(handle: Int64, buf: CPointer<UInt8>, len: Int32, flags: Int32): Int32

    func CJ_MRT_SockRecvfromTimeout(sock: Int64, buf: CPointer<UInt8>, length: UInt32, flags: Int32,
        addr: CPointer<SockAddr>, timeout: UInt64): Int32

    func CJ_MRT_SockWaitRecv(handle: Int64): Int32

    func CJ_MRT_SockWaitRecvTimeout(handle: Int64, timeout: UInt64): Int32

    func CJ_MRT_SockWaitSend(handle: Int64): Int32

    func CJ_MRT_SockWaitSendTimeout(handle: Int64, timeout: UInt64): Int32
    // raw socket
    func CJ_MRT_SockListen(sockfd: Int64, backlog: Int32): Int64

    func CJ_MRT_SockSendtoNonBlock(sockfd: Int64, buf: CPointer<UInt8>, size: Int32, flags: Int32,
        sockaddr: CPointer<SockAddr>): Int32

    func CJ_MRT_SockRecvfromNonBlock(sockfd: Int64, buf: CPointer<UInt8>, size: Int32, flags: Int32,
        sockaddr: CPointer<SockAddr>): Int32

    func CJ_MRT_SockLocalAddrGet(sock: Int64, addr: CPointer<SockAddr>): Int32

    func CJ_MRT_SockPeerAddrGet(sock: Int64, addr: CPointer<SockAddr>): Int32
}

enum ErrnoLabel <: ToString {
    Accept | Connect | Read | Write | CreateSock | Bind | Listen

    public override func toString(): String {
        match (this) {
            case Accept => "accept"
            case Connect => "connect"
            case Read => "read data"
            case Write => "write data"
            case CreateSock => "create socket"
            case Bind => "bind"
            case Listen => "listen"
        }
    }
}

func getSocketError(): Int32 {
    unsafe { CJ_SockErrnoGet() }
}

func socketProcessErrno(label: ErrnoLabel): Nothing {
    let errno = getSocketError()

    // There is no EWOULDBLOCK/ ETIMEDOUT / EAGAIN in runtime, the socket is in NONBLOCK mode.
    if (errno == ERRNO_SOCK_TIMEOUT) {
        throw SocketTimeoutException("Failed to ${label}: ${label} timeout.")
    }

    if (errno == ERRNO_SOCK_CLOSED) {
        SocketException.throwClosedException()
    }
    throw SocketException("Failed to ${label} ${errno}: ${sockError(errno)}.")
}

func sockError(errno: Int32): String {
    if (errno == 0) {
        return ""
    }
    return match {
        case errno == ERRNO_SOCK_ARG_INVALID => "socket input parameter invalid"
        case errno == ERRNO_SOCK_NOT_SUPPORTED => "socket not supported"
        case errno == ERRNO_SOCK_NOT_REGISTERED => "socket not registered"
        case errno == ERRNO_SOCK_HANDLE_INVALID => "socket handle invalid"
        case errno == ERRNO_SOCK_FD_NUM_OVER_LIMIT => "socket fd number over limit"
        case errno == ERRNO_SOCK_CREATE => "wrong combination of domain, type and protocol"
        case _ => formatError(errno)
    }
}

@When[os != "Windows"]
const ERRNO_EINVAL: Int32 = 0x16
@When[os == "Windows"]
const ERRNO_EINVAL: Int32 = 0x2726

func isSocketErrorInvalidArgument(errno: Int32): Bool {
    errno == ERRNO_SOCK_ARG_INVALID || errno == ERRNO_EINVAL
}
