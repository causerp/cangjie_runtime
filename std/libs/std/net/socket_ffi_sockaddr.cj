/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.net

@When[os != "macOS"]
unsafe func setFamily(ptr: CPointer<Unit>, v: Int16): Unit {
    CPointer<Int16>(ptr).write(v)
}

@When[os != "macOS"]
unsafe func readFamily(ptr: CPointer<Unit>): Int16 {
    CPointer<Int16>(ptr).read()
}

@When[os == "macOS"]
unsafe func setFamily(ptr: CPointer<Unit>, v: Int16): Unit {
    CPointer<Int8>(ptr).write(1, Int8(v))
}

@When[os == "macOS"]
unsafe func readFamily(ptr: CPointer<Unit>): Int16 {
    Int16(CPointer<Int8>(ptr).read(1))
}

@C
struct SockAddr {
    let ptr: CPointer<Unit>
    let len: UInt32 // warning: this will never work as intended as the type in C is socklen_t

    private static const socket_address_in_len: UInt32 = 16 // sizeof(SockAddrIn)
    private static const socket_address_in6_len: UInt32 = 28 // sizeof(SockAddrIn6)
    private static const socket_address_un_len: UInt32 = 110 // sizeof(SockAddrUn)
    private static const socket_address_all_len: Int64 = 120

    init(buffer: CPointer<Unit>, length: Int64) {
        ptr = buffer
        len = UInt32(length)
        if (buffer.isNull()) {
            throw SocketException("Input parameter is null.")
        }
    }

    init() {
        let buffer = CPointer<Unit>(LibC.malloc<UInt8>(count: socket_address_all_len))
        if (buffer.isNull()) {
            throw SocketException("Failed to allocate memory")
        }
        zeroMemory(CPointer<UInt8>(buffer), socket_address_all_len)

        this.ptr = buffer
        this.len = UInt32(socket_address_all_len)
    }

    /**
     * Construct a SockAddr that stores address from SocketAddress instance
     * Malloc inside, should call free().
     */
    @When[backend == "cjnative"]
    init(sa: SocketAddress) {
        unsafe {
            match {
                case sa.family == AddressFamily.INET =>
                    len = socket_address_in_len
                    let ip = (sa as IPSocketAddress)?.address ?? throw SocketException("invalid IP family")
                    let port = (sa as IPSocketAddress)?.port ?? 0
                    ptr = CPointer<Unit>(LibC.malloc<UInt8>(count: Int64(socket_address_in_len)))
                    if (ptr.isNull()) {
                        throw SocketException("failed to malloc socket_address_in_len.")
                    }
                    setIpv4(ip.getAddressBytes(), port)
                case sa.family == AddressFamily.INET6 =>
                    len = socket_address_in6_len
                    let ip = (sa as IPSocketAddress)?.address ?? throw SocketException("invalid IP family")
                    let port = (sa as IPSocketAddress)?.port ?? 0
                    ptr = CPointer<Unit>(LibC.malloc<UInt8>(count: Int64(socket_address_in6_len)))
                    if (ptr.isNull()) {
                        throw SocketException("failed to malloc socket_address_in6_len.")
                    }
                    setIpv6(ip.getAddressBytes(), port)
                case sa.family == AddressFamily.UNIX =>
                    len = socket_address_un_len
                    let un = (sa as UnixSocketAddress)?.toString() ?? throw SocketException("invalid IP family")
                    ptr = CPointer<Unit>(LibC.malloc<UInt8>(count: Int64(socket_address_un_len)))
                    if (ptr.isNull()) {
                        throw SocketException("failed to malloc socket_address_un_len.")
                    }
                    zeroMemory(CPointer<UInt8>(ptr), Int64(socket_address_un_len))
                    setUnix(un.toArray())
                case _ => throw SocketException("Unsupported address family: ${sa.family}.")
            }
        }
    }

    @When[backend == "cjnative"]
    @OverflowWrapping
    private unsafe func setPort(port: UInt16) {
        CPointer<UInt8>(ptr).write(2, UInt8(port >> 8)) // skip family
        CPointer<UInt8>(ptr).write(3, UInt8(port))
    }

    @When[backend == "cjnative"]
    private unsafe func setIpv4(addr: Array<UInt8>, port: UInt16) {
        setFamily(ptr, AF_INET)
        setPort(port)
        for (i in 0..SOCK_ADDR_IPV4_LEN) {
            CPointer<UInt8>(ptr).write(4 + i, addr[i])
        }
        CPointer<UInt64>(ptr).write(1, UInt64(0))
    }

    @When[backend == "cjnative"]
    private unsafe func setIpv6(addr: Array<UInt8>, port: UInt16) {
        setFamily(ptr, AF_INET6)
        setPort(port)
        CPointer<UInt32>(ptr).write(1, UInt32(0)) // sin6_flowinfo
        for (i in 0..SOCK_ADDR_IPV6_LEN) {
            CPointer<UInt8>(ptr).write(8 + i, addr[i])
        }
        CPointer<UInt32>(ptr).write(6, UInt32(0)) // sin6_scope_id
    }

    /*
     * No windows.
     */
    @When[backend == "cjnative"]
    private unsafe func setUnix(addr: Array<UInt8>) {
        setFamily(ptr, AF_UNIX)
        for (i in 0..min(SOCK_ADDR_DOMAIN_LEN, addr.size)) {
            CPointer<UInt8>(ptr).write(2 + i, addr[i])
        }
    }

    @When[backend == "cjnative"]
    public unsafe func free(): Unit {
        LibC.free(ptr)
    }

    @When[backend == "cjnative"]
    private unsafe func getIpv4(): Array<UInt8> {
        return Array<UInt8>(SOCK_ADDR_IPV4_LEN, {i => CPointer<UInt8>(ptr).read(4 + i)}) // skip family, port.
    }

    @When[backend == "cjnative"]
    private unsafe func getIpv6(): Array<UInt8> {
        return Array<UInt8>(SOCK_ADDR_IPV6_LEN, {i => CPointer<UInt8>(ptr).read(8 + i)}) // skip family, port, sin6_flowinfo.
    }

    @When[backend == "cjnative"]
    private unsafe func getPort(): UInt16 {
        let high = CPointer<UInt8>(ptr).read(2) // skip family
        let low = CPointer<UInt8>(ptr).read(3)
        return UInt16(high) << 8 | UInt16(low)
    }

    @When[backend == "cjnative"]
    private unsafe func getDomain(): Array<UInt8> {
        return Array<UInt8>(SOCK_ADDR_DOMAIN_LEN, {i => CPointer<UInt8>(ptr).read(2 + i)}) // skip family.
    }

    @When[backend == "cjnative"]
    prop family: Int16 {
        get() {
            unsafe {
                readFamily(ptr)
            }
        }
    }

    @When[backend == "cjnative"]
    unsafe func toSocketAddress(): SocketAddress {
        match {
            case family == AF_INET =>
                let ip = getIpv4()
                IPSocketAddress(IPv4Address(ip[0], ip[1], ip[2], ip[3]), getPort())
            case family == AF_INET6 => IPSocketAddress(IPv6Address(getIpv6()), getPort())
            case family == AF_UNIX => UnixSocketAddress(getDomain())
            case _ => throw SocketException("Unsupported socket family ${family}")
        }
    }

    @When[backend == "cjnative"]
    unsafe func toRawAddress(): RawAddress {
        let remoteArr = Array<Byte>(Int64(len), {i => CPointer<Byte>(ptr).read(i)})
        return RawAddress(remoteArr)
    }
}
