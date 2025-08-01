/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.net

import std.sync.*

/*
 * Represents a TCP streaming socket.
 *
 * Once an instance is created, it is not yet connected so should be connected explicitly via connect().
 *
 * Instances of this type should be explicitly closed even when the connect() hasn't been invoked.
 *
 * @see StreamingSocket for more details on how do streaming sockets work.
 */
public class TcpSocket <: StreamingSocket & Equatable<TcpSocket> & Hashable {
    // we need this due to identity support missing in CJ
    private let id = counter.fetchAdd(1)
    private static let counter = AtomicInt64(1)

    /**
     * Creates an internally precreated socket. See TcpServerSocket.accept.
     */
    TcpSocket(private let impl: SocketCommon<ActualTcpPlatformSocket>) {
        noDelay = true
    }

    /**
     * Create an unconnected TCP socket ready to connect to the specified address and port
     */
    public init(address: String, port: UInt16) {
        this(IPSocketAddress(resolveHelper(address), port))
    }

    /**
     * Create an unconnected TCP socket ready to connect to the specified address and port
     */
    public init(address: SocketAddress) {
        this(address, localAddress: None)
    }

    /**
     * Create an unconnected TCP socket ready to connect to the specified address and port
     * and optionally binding client socket to the particular localAddress (None to automatically find local address to bind)
     *
     * Specifying localAddress usually makes sense to give a hint, which network interface to use for connection.
     * If in doubt or don't know, specify None or use the constructor without localAddress.
     * Specifying localAddress does also configure SO_REUSEADDR by default for convenience ortherwise spurious "address already in use" may occur.
     * Use setSocketOptionBool(SocketOptions.SOL_SOCKET, SocketOptions.SO_REUSEADDR, false) to eliminate this option if needed.
     * Also note that local and remote address should always have the same address family: for example, both IPv4.
     */
    public init(address: SocketAddress, localAddress!: ?SocketAddress) {
        checkAddress(address, "address")
        if (let Some(localAddress) <- localAddress) {
            checkAddress(localAddress, "localAddress")
            if (address.family != localAddress.family) {
                throw IllegalArgumentException(
                    "remote address kind (${address.family}) should have the same address " +
                    " family as local (${localAddress.family})")
            }
        }
        throwIfIPv4ZeroOnWindows(address)

        this.impl = SocketCommon(SocketNet.TCP, address.family, SocketMode.StreamingMode)
        impl.remoteAddress = address
        if (let Some(localAddress) <- localAddress) {
            impl.localAddress = localAddress
            setSocketOptionBool(SOL_SOCKET, SOCK_REUSEADDR, true)
        }

        noDelay = true
    }

    /**
     * Remote address the socket will be or is currently connected to.
     *
     * @throws SocketException is the socket is already closed.
     */
    public override prop remoteAddress: SocketAddress {
        get() {
            impl.remoteAddress ?? SocketException.notYetConnected()
        }
    }

    /**
     * Local address the socket will be or currently is bound at.
     *
     * @throws SocketException is the socket is already closed
     * or no local address is available (local address was not provided during creation and the socket is not connected).
     */
    public override prop localAddress: SocketAddress {
        get() {
            impl.localAddress ?? SocketException.notYetConnected()
        }
    }

    /**
     * Read operation time limit or `None` for infinite read attempts.
     * The value specified here is actually the minimal amount of time before a read operation cancelled.
     * The actual time is not guaranteed but it will be never cancelled earlier than the specified timeout value.
     * If the duration is too big than it can be bumped to the infinite. When it's too small then if will be bumped to the minimal clock granularity.
     *
     * The default value is None.
     * @throws IllegalArgumentException if the specified timeout duration is negative.
     */
    public override mut prop readTimeout: ?Duration {
        get() {
            impl.readTimeout
        }
        set(timeout) {
            impl.readTimeout = timeout?.throwIfNegative("Read timeout").toNanosecondGranularity()
        }
    }

    /**
     * Write operation time limit or `None` for infinite read attempts.
     *
     * The value specified here is actually the minimal amount of time before a write operation cancelled.
     * The actual time is not guaranteed but it will be never cancelled earlier than the specified timeout value.
     * If the duration is too big than it can be bumped to the infinite. When it's too small then if will be bumped to the minimal clock granularity.
     *
     * The default value is None.
     * @throws IllegalArgumentException if the specified timeout duration is negative.
     */
    public override mut prop writeTimeout: ?Duration {
        get() {
            impl.writeTimeout
        }
        set(timeout) {
            impl.writeTimeout = timeout?.throwIfNegative("Write timeout").toNanosecondGranularity()
        }
    }

    /**
     * Network interface name to bind at.
     * Despite it's a client TCP socket, we still do bind before
     * connect to occupy a local port and it is sometimes important
     * to bind at some particular network interface to try to
     * enforce the particular route.
     *
     * This option is a hint for the operating system that may decide to ignore the value
     * or reject an attempt to configure it, especially when it's not
     * allowed, unsupported or we specify a wrong name.
     */
    public mut prop bindToDevice: ?String {
        get() {
            impl.bindToDevice
        }
        set(newDevice) {
            impl.bindToDevice = newDevice
        }
    }

    /**
     * TCP Keep-Alive options or `None` if disabled.
     * If not configured, the operating system may decide to use some default keep-alive configuration.
     * Changing this option may have delayed effect or may be silently ignored or reinterpreted by the operating system
     * due to some reasons such as system configurations and/or missing support of particular features in the underlying TCP stack implementation.
     */
    public mut prop keepAlive: ?SocketKeepAliveConfig {
        get() {
            impl.keepAlive
        }
        set(newConfig) {
            impl.keepAlive = newConfig
        }
    }

    /**
     * `TCP_NODELAY`, true by default
     *
     * This option disables the Nagel's algorithm so any bytes chunk
     * written to the socket is scheduled for sending immediately without delay.
     * When this option is disabled, then Nagel's implementation does introduce time-based
     * delay before actually sending bytes. This is done to group outgoing byte chunks to bigger
     * TCP packets so there will be less quantity of them and the overhead decreases. In other words,
     * this is a time-based debouncing algorithm.
     * Despite that it looks reasonable, most applications already have proper buffering usually
     * on multiple application layers so this Nagel algorithm will simply introduce latency without
     * any benefits. So in this case TCP_NODELAY option is used to disable the debouncing.
     */
    public mut prop noDelay: Bool {
        get() {
            impl.getSocketOptionBool(IPPROTO_TCP, SOCK_TCP_NODELAY)
        }
        set(newState) {
            impl.setSocketOptionBool(IPPROTO_TCP, SOCK_TCP_NODELAY, newState)
        }
    }

    /**
     * TCP_QUICKACK, false by default
     *
     * This is similar to TCP_NODELAY but affects only TCP ACK and first response bytes chunk.
     * Usually (without TCP_QUICKACK), the TCP stack implementation does defer sending TCP ACK packet
     * until the first bytes will be sent (but with some time limit).
     * The idea is to group ACK and data bytes into a single batch, and reduce overhead.
     * Because of this, the remote peer doesn't get connection acknowledgement immediately but after some delay.
     * In some latency-sensitive or interactive protocols it is not acceptable.
     * So here TCP_QUCKACK option comes and provides a way to force sending TCP ACK immediately to reduce
     * the connection latency. However, generally this is not always good as we sacrify throughput a little bit
     * and increase the number of network packets, enlarging load on network hardware, switches.
     * Increasing the number of packets also leads to loss probability growth reducing robustness.
     * This is why this option could be good or bad depending on the usage scenario and environment.
     *
     * Not supported on windows and macOS
     */
    public mut prop quickAcknowledge: Bool {
        get() {
            impl.getSocketOptionBool(IPPROTO_TCP, SOCK_TCP_QUICKACK)
        }
        set(newState) {
            impl.setSocketOptionBool(IPPROTO_TCP, SOCK_TCP_QUICKACK, newState)
        }
    }

    /**
     * SO_LINGER duration, the default is system-dependant. `None` if linger is disabled.
     *
     * When a socket is closed, if there are pending outgoing bytes, we are waiting
     * for the linger time before aborting connection. If the time is out but bytes were not sent yet,
     * then usually the connection get aborted (via reset / TCP reset).
     *
     * When the linger is disabled (`None`), then the connection will be aborted immediately:
     * depending on the presence of pending outgoing bytes, it will be either terminated successully (FIN-ACK)
     * or reset (RST).
     *
     * @throws IllegalArgumentException if the specified timeout duration is negative.
     */
    public mut prop linger: ?Duration {
        get() {
            impl.getLinger()
        }
        set(newLinger) {
            impl.setLinger(newLinger)
        }
    }

    /**
     * SO_SNDBUF option, providing a way to specify hint for the underlying
     * native socket implementation about the desired outgoing buffer size.
     *
     * Changing this option is not guaranteed to have any effect since it's
     * completely up to the operating system.
     *
     * Reading this property could also provide non-realistic values on some systems in
     * some cases so no logic should strictly rely on this value.
     *
     * @throws IllegalArgumentException if the specified buffer size is negative or 0.
     */
    public mut prop sendBufferSize: Int64 {
        get() {
            Int64(impl.getSocketOptionIntNative(SOL_SOCKET, SOCK_SNDBUF))
        }
        set(newSize) {
            if (newSize <= 0) {
                throw IllegalArgumentException("Buffer size should be positive, got ${newSize}.")
            }
            impl.setSocketOptionIntNative(SOL_SOCKET, SOCK_SNDBUF, IntNative(newSize))
        }
    }

    /**
     * SO_RCVBUF option, providing a way to specify hint for the underlying
     * native socket implementation about the desired receive buffer size.
     *
     * Changing this option is not guaranteed to have any effect since it's
     * completely up to the operating system.
     *
     * Reading this property could also provide non-realistic values on some systems in
     * some cases so no logic should strictly rely on this value.
     *
     * @throws IllegalArgumentException if the specified buffer size is negative or 0.
     */
    public mut prop receiveBufferSize: Int64 {
        get() {
            Int64(impl.getSocketOptionIntNative(SOL_SOCKET, SOCK_RCVBUF))
        }
        set(newSize) {
            if (newSize <= 0) {
                throw IllegalArgumentException("Buffer size should be positive, got ${newSize}.")
            }
            impl.setSocketOptionIntNative(SOL_SOCKET, SOCK_RCVBUF, IntNative(newSize))
        }
    }

    /**
     * Read at least one byte to the specified buffer waiting for incoming data if necessary.
     *
     * Returns number of bytes written to the buffer or 0 when the remote peer closed the stream
     * or also 0 when the socket is closed.
     *
     * @throws IllegalArgumentException if the specified buffer is empty
     * @throws SocketTimeoutException if the waiting time has expired.
     * @throws SocketException when the connection is broken
     */
    public override func read(buffer: Array<Byte>): Int64 {
        impl.read(buffer)
    }

    /**
     * Write the payload bytes to the socket waiting for the output buffer space if necessary.
     *
     * The provided bytes are copied and transmitted asynchronously so returning from this function
     * doesn't guarantee actual data delivery. When the link is poor or the remote peer is unable
     * to handle data fast enough, the send buffer may overflow and in this case an attempt
     * to write more bytes may block coroutine here until enough bytes will be transmitted to
     * get enough send buffer space to write the payload. If the payload is too big to fit the send
     * buffer, then the payload will be fragmented and sent chunk by chunk.
     *
     * Also note that due to the nature of IP and TCP having packet fragmentation,
     * the underlying network may split the payload into smaller parts of any size
     * so it is not guaranteed that the the whole payload will be delivered to the remote peer at once.
     *
     * Despite TCP provides delivery acknowledge, the delivery here means that bytes were transmitted
     * to the remote peer and it doesn't gurantee that the remote application actually received
     * and processed bytes. Also, this function only schedule the payload for sending.
     * Therefore, successfully returning write() invocation doesn't mean that bytes were
     * deliverd. To get guaranteed delivery, use application-level acknowledges instead.
     *
     * @throws IllegalArgumentException if the specified buffer is empty
     * @throws SocketTimeoutException if the waiting time has expired.
     * @throws SocketException when the socket is closed or the connection is broken
     */
    public override func write(payload: Array<Byte>): Unit {
        impl.write(payload)
    }

    /**
     * Connects to the remote peer within the specified timeout.
     * If the timeout is `None`, then connection attempts will continue without time limit.
     * Please note that this function doesn't do retry so if the server peer does reject connection, we get error despite the timeout duration.
     *
     * This function also does bind first before doing connect so there is no need to invoke bind
     *
     * @throws SocketException if the connection cannot be established.
     * @throws SocketTimeoutException if the waiting time has expired.
     * @throws IllegalArgumentException if the specified timeout duration is negative.
     */
    public func connect(timeout!: ?Duration = None): Unit {
        impl.connect(timeout?.throwIfNegative("Timeout"))
    }

    /**
     * Read the specified socket option writing the result to value buffer
     * of the specified valueLength (in bytes).
     * Before invoking this function valueLength should be initialized with the buffer size
     * After invoking this function valueLength will contain the actual result
     * size in bytes.
     *
     * See SocketOptions for popular option constants.
     *
     * Throws an exception if failed (when getsockopt returns -1).
     */
    public func getSocketOption(
        level: Int32,
        option: Int32,
        value: CPointer<Unit>,
        valueLength: CPointer<UIntNative>
    ): Unit {
        unsafe {
            impl.getSocketOption(level, option, value, valueLength)
        }
    }

    /**
     * Write the specified socket option from value buffer having valueLength
     * size in bytes.
     *
     * See SocketOptions for popular option constants.
     *
     * Throws an exception if failed (when setsockopt returns -1).
     */
    public func setSocketOption(
        level: Int32,
        option: Int32,
        value: CPointer<Unit>,
        valueLength: UIntNative
    ): Unit {
        unsafe {
            impl.setSocketOption(level, option, value, valueLength)
        }
    }

    /**
     * Read the specified socket option returning it's value as IntNative result.
     *
     * See SocketOptions for popular option constants.
     *
     * Throws an exception if failed (when getsockopt returns -1) or if the result
     * has size different from IntNative.
     */
    public func getSocketOptionIntNative(
        level: Int32,
        option: Int32
    ): IntNative {
        impl.getSocketOptionIntNative(level, option)
    }

    /**
     * Write a numeric IntNative value to the specified socket option.
     *
     * See SocketOptions for popular option constants.
     *
     * Throws an exception if failed (when setsockopt returns -1), for example
     * when the option size is different from IntNative.
     */
    public func setSocketOptionIntNative(
        level: Int32,
        option: Int32,
        value: IntNative
    ): Unit {
        impl.setSocketOptionIntNative(level, option, value)
    }

    /**
     * Read the specified socket option returning it's value as a boolean value
     * converting it from an IntNative.
     *
     * See SocketOptions for popular option constants.
     *
     * The conversion is defined as 0 => false, other values => true.
     *
     * Throws an exception if failed (when getsockopt returns -1) or if the result
     * has size different from IntNative.
     */
    public func getSocketOptionBool(
        level: Int32,
        option: Int32
    ): Bool {
        impl.getSocketOptionBool(level, option)
    }

    /**
     * Write a boolean value to the specified socket option converting it to IntNative.
     *
     * See SocketOptions for popular option constants.
     *
     * The conversion is defined as false => 0, true => 1
     *
     * Throws an exception if failed (when setsockopt returns -1), for example
     * when the option size is different from IntNative.
     */
    public func setSocketOptionBool(
        level: Int32,
        option: Int32,
        value: Bool
    ): Unit {
        impl.setSocketOptionBool(level, option, value)
    }

    /**
     * Close the socket releasing all resources. All operations except for close() and isClose() are no longer available.
     * This function is reentrant.
     **/
    public func close(): Unit {
        impl.close()
    }

    /**
     * Checks whether this socket has been explicitly closed via close()
     **/
    public func isClosed(): Bool {
        impl.isClosed()
    }

    public override operator func ==(other: TcpSocket): Bool {
        id == other.id
    }

    public override operator func !=(other: TcpSocket): Bool {
        id != other.id
    }

    public override func hashCode(): Int64 {
        id.hashCode()
    }

    public override func toString(): String {
        "TcpSocket(${impl.toString()})"
    }

    private static func checkAddress(address: SocketAddress, name: String): SocketAddress {
        if (address.family != AddressFamily.INET && address.family != AddressFamily.INET6) {
            throw IllegalArgumentException(
                "${name} should be either IPv4 or IPv6 but got ${address.family}: ${address}")
        }
        return address
    }
}
