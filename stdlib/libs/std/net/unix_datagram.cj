/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.net

/*
 * Represents a Unix Domain datagram socket.
 *
 * Once an instance is created, it is not yet bound so should be bound explicitly via bind().
 * Unlike UnixSocket, a UnixDatagramSocket may remain unconnected and work without pairing to any remote address handling
 * multiple peers at the same time.
 * However, a UnixDatagramSocket socket could be optionally paired via connect() to an existing bound socket file.
 * A created pairing (after connect invocation) could be terminated via disconnect().
 *
 * Unlike UDP, Unix Domain socket don't limit datagram size to 64Kib, however due to the underlying implementation and operation system
 * limitations, the maximum datagram size could be still limited to some amount.
 *
 * Instances of this type should be explicitly closed even when the bind() hasn't been invoked.
 *
 * @see DatagramSocket for more details on how do datagram sockets work.
 */
@When[os != "Windows"]
public class UnixDatagramSocket <: DatagramSocket {
    private let impl: SocketCommon<ActualPlatformSocket>

    /**
     * Creates an unbound Unix datagram socket ready to bind at the specified path
     *
     * @param bindAt local path (should be a non-existing path that will be created during bind)
     */
    public init(bindAt!: String) {
        this(bindAt: UnixSocketAddress(bindAt))
    }

    /**
     * Creates an unbound Unix datagram socket ready to bind at the specified address
     *
     * @param bindAt local path (should be a non-existing path that will be created during bind)
     */
    public init(bindAt!: SocketAddress) {
        checkUnixSocketAddress(bindAt, "bindAt")

        impl = SocketCommon(SocketNet.UNIX, bindAt.family, DatagramMode)
        impl.localAddress = bindAt
    }

    /**
     * Remote address the socket is connected to or `None` if the socket is unconnected.
     *
     * @throws SocketException is the socket is already closed.
     */
    public override prop remoteAddress: ?SocketAddress {
        get() {
            impl.remoteAddress
        }
    }

    /**
     * Local address the socket will be or is currently bound at.
     *
     * @throws SocketException is the socket is already closed.
     */
    public override prop localAddress: SocketAddress {
        get() {
            impl.localAddress ?? SocketException.notYetBoundNeedBind()
        }
    }

    /**
     * Receive/ReceiveFrom operation time limit or `None` for infinite read attempts.
     * The value specified here is actually the minimal amount of time before a read operation cancelled.
     * The actual time is not guaranteed but it will be never cancelled earlier than the specified timeout value.
     * If the duration is too big than it can be bumped to the infinite. When it's too small then if will be bumped to the minimal clock granularity.
     *
     * The default value is None.
     * @throws IllegalArgumentException if the specified timeout duration is negative.
     */
    public override mut prop receiveTimeout: ?Duration {
        get() {
            impl.readTimeout
        }
        set(timeout) {
            impl.readTimeout = timeout?.throwIfNegative("Receive timeout").toNanosecondGranularity()
        }
    }

    /**
     * Send/SendTo operation time limit or `None` for infinite read attempts.
     *
     * The value specified here is actually the minimal amount of time before a write operation cancelled.
     * The actual time is not guaranteed but it will be never cancelled earlier than the specified timeout value.
     * If the duration is too big than it can be bumped to the infinite. When it's too small then if will be bumped to the minimal clock granularity.
     *
     * The default value is None.
     * @throws IllegalArgumentException if the specified timeout duration is negative.
     */
    public override mut prop sendTimeout: ?Duration {
        get() {
            impl.writeTimeout
        }
        set(timeout) {
            impl.writeTimeout = timeout?.throwIfNegative("Send timeout").toNanosecondGranularity()
        }
    }

    /**
     * Close the socket releasing all resources. All operations except for close() and isClose() are no longer available.
     * This function is reentrant.
     **/
    public override func close(): Unit {
        impl.close()
    }

    /**
     * Checks whether this socket has been explicitly closed via close()
     **/
    public override func isClosed(): Bool {
        impl.isClosed()
    }

    /**
     * Bind Unix datagram socket at local path.
     *
     * This operation does atomically create a socket file at the local path.
     *
     * @throws SocketException if the socket is already bound or path already exists.
     */
    public func bind(): Unit {
        impl.bind(None)
    }

    /**
     * Configure the socket to only work with the specified remote peer address. To undo this action use disconnect()
     *
     * After invoking this function with a particular address, we will not be able to send message to peers other than this. We will also never receive any messages from other peers (they will be just filtered out). Invoking disconnect() reverts the filter to the initial state so it will be possible to send message to any recipients again.
     *
     * This function should be only invoked after bind()
     */
    public func connect(remotePath: String): Unit {
        connect(UnixSocketAddress(remotePath))
    }

    /**
     * Configure the socket to only work with the specified remote peer address. To undo this action use disconnect()
     *
     * After invoking this function with a particular address, we will not be able to send message to peers other than this. We will also never receive any messages from other peers (they will be just filtered out). Invoking disconnect() reverts the filter to the initial state so it will be possible to send message to any recipients again.
     *
     * This function should be only invoked after bind()
     *
     * @throws SocketException if the socket is not bound.
     * @throws SocketException if the connection cannot be established.
     */
    public func connect(remote: SocketAddress): Unit {
        checkUnixSocketAddress(remote, "remote")
        impl.connectToRemote(remote)
    }

    /**
     * Reverts the effect of connect() function so we can send and receive to/from any address again.
     * This function makes no effect if invoked multiple times or if we invoke disconnect without connect invocation.
     *
     * @throws SocketException if the socket is not bound.
     * @throws SocketException if the connection cannot be established.
     */
    public func disconnect(): Unit {
        impl.disconnect()
    }

    /**
     * Receive the next datagram into the specified buffer waiting for data if needed.
     *
     * Returns a pair of the datagram sender address and the actual size of received datagram, possibly zero
     * or a value greater than the passed buffer size.
     *
     * Unlike read in streams, this function requires a buffer of proper size (big enough),
     * otherwise a datagram that is bigger than the provided buffer will be
     * truncated and the returned datagram size will be greater that the buffer size.
     *
     * @throws SocketException if buffer is empty or if it is not possible to read the data.
     * @throws SocketTimeoutException if reading time has expired.
     */
    public override func receiveFrom(buffer: Array<Byte>): (SocketAddress, Int64) {
        impl.receiveFrom(buffer) ?? SocketException.throwClosedException()
    }

    /**
     * Sends datagram of the payload to the specified recipient address.
     *
     * It also may block in this function invocation if there is not enough
     * output buffer space available for some reason. Depending on the underlying
     * implementation, it may also silently discard a datagram in this case.
     */
    public override func sendTo(recipient: SocketAddress, payload: Array<Byte>): Unit {
        checkUnixSocketAddress(recipient, "recipient")

        impl.send(payload, recipient)
    }

    /**
     * Send a message with the specified payload to the peer with preconfigured address.
     * This only works if address has been specified using `connect() ` otherwise will fail immediately.
     *
     * In other aspects, it works the same as regular `sendTo(recipient,payload).
     */
    public func send(payload: Array<Byte>): Unit {
        if (OS == "macOS") {
            impl.write(payload)
        } else {
            sendTo(impl.remoteAddress ?? SocketException.notYetConnected(), payload)
        }
    }

    /**
     * Receive a datagram message from the preconfigured peer address.
     * This only works if the address has been specified via connect() otherwise will fail.
     * In other aspects, it works the same as regular `receiveFrom(buffer).
     */
    public func receive(buffer: Array<Byte>): Int64 {
        let _ = impl.remoteAddress ?? SocketException.notYetConnected()
        let (_, size) = receiveFrom(buffer)
        return size
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
        get() { impl.getSendBufferSize() }
        set(newSize) { impl.setSendBufferSize(newSize) }
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
        get() { impl.getReceiveBufferSize() }
        set(newSize) { impl.setReceiveBufferSize(newSize) }
    }

    public func getSocketOptionBool(level: Int32, option: Int32): Bool {
        impl.getSocketOptionBool(level, option)
    }

    public func setSocketOptionBool(level: Int32, option: Int32, value: Bool): Unit {
        impl.setSocketOptionBool(level, option, value)
    }

    /**
     * Read the specified socket option writing the result to value buffer
     * of the specified valueLength (in bytes).
     * Before invoking this function valueLength should be initialized with the buffer size
     * After invoking this function valueLength will contain the actual result
     * size in bytes.
     *
     * Throws an exception if failed (when getsockopt returns -1).
     */
    public func getSocketOption(level: Int32, option: Int32, value: CPointer<Unit>, valueLength: CPointer<UIntNative>): Unit {
        unsafe { impl.getSocketOption(level, option, value, valueLength) }
    }

    /**
     * Write the specified socket option from value buffer having valueLength
     * size in bytes.
     *
     * See SocketOptions for popular option constants.
     *
     * Throws an exception if failed (when setsockopt returns -1).
     */
    public func setSocketOption(level: Int32, option: Int32, value: CPointer<Unit>, valueLength: UIntNative): Unit {
        unsafe { impl.setSocketOption(level, option, value, valueLength) }
    }

    /**
     * Read the specified socket option returning it's value as IntNative result.
     *
     * See SocketOptions for popular option constants.
     *
     * Throws an exception if failed (when getsockopt returns -1) or if the result
     * has size different from IntNative.
     */
    public func getSocketOptionIntNative(level: Int32, option: Int32): IntNative {
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
    public func setSocketOptionIntNative(level: Int32, option: Int32, value: IntNative): Unit {
        impl.setSocketOptionIntNative(level, option, value)
    }

    public override func toString(): String {
        "UnixDatagramSocket(${impl.toString()})"
    }
}

@When[os == "Windows"]
@Deprecated
public class UnixDatagramSocket <: DatagramSocket {
    private let impl: SocketCommon<ActualPlatformSocket>

    /**
     * Creates an unbound Unix datagram socket ready to bind at the specified path
     *
     * @param bindAt local path (should be a non-existing path that will be created during bind)
     */
    public init(bindAt!: String) {
        this(bindAt: UnixSocketAddress(bindAt))
    }

    /**
     * Creates an unbound Unix datagram socket ready to bind at the specified address
     *
     * @param bindAt local path (should be a non-existing path that will be created during bind)
     */
    public init(bindAt!: SocketAddress) {
        checkUnixSocketAddress(bindAt, "bindAt")

        impl = SocketCommon(SocketNet.UNIX, bindAt.family, DatagramMode)
        impl.localAddress = bindAt
    }

    /**
     * Remote address the socket is connected to or `None` if the socket is unconnected.
     *
     * @throws SocketException is the socket is already closed.
     */
    public override prop remoteAddress: ?SocketAddress {
        get() {
            this.impl.remoteAddress
        }
    }

    /**
     * Local address the socket will be or is currently bound at.
     *
     * @throws SocketException is the socket is already closed.
     */
    public override prop localAddress: SocketAddress {
        get() {
            this.impl.localAddress ?? SocketException.notYetBoundNeedBind()
        }
    }

    /**
     * Receive/ReceiveFrom operation time limit or `None` for infinite read attempts.
     * The value specified here is actually the minimal amount of time before a read operation cancelled.
     * The actual time is not guaranteed but it will be never cancelled earlier than the specified timeout value.
     * If the duration is too big than it can be bumped to the infinite. When it's too small then if will be bumped to the minimal clock granularity.
     *
     * The default value is None.
     * @throws IllegalArgumentException if the specified timeout duration is negative.
     */
    public override mut prop receiveTimeout: ?Duration {
        get() {
            this.impl.readTimeout
        }
        set(timeout) {
            this.impl.readTimeout = timeout?.throwIfNegative("Receive timeout").toNanosecondGranularity()
        }
    }

    /**
     * Send/SendTo operation time limit or `None` for infinite read attempts.
     *
     * The value specified here is actually the minimal amount of time before a write operation cancelled.
     * The actual time is not guaranteed but it will be never cancelled earlier than the specified timeout value.
     * If the duration is too big than it can be bumped to the infinite. When it's too small then if will be bumped to the minimal clock granularity.
     *
     * The default value is None.
     * @throws IllegalArgumentException if the specified timeout duration is negative.
     */
    public override mut prop sendTimeout: ?Duration {
        get() {
            this.impl.writeTimeout
        }
        set(timeout) {
            this.impl.writeTimeout = timeout?.throwIfNegative("Send timeout").toNanosecondGranularity()
        }
    }

    /**
     * Close the socket releasing all resources. All operations except for close() and isClose() are no longer available.
     * This function is reentrant.
     **/
    public override func close(): Unit {
        this.impl.close()
    }

    /**
     * Checks whether this socket has been explicitly closed via close()
     **/
    public override func isClosed(): Bool {
        this.impl.isClosed()
    }

    /**
     * Bind Unix datagram socket at local path.
     *
     * This operation does atomically create a socket file at the local path.
     *
     * @throws SocketException if the socket is already bound or path already exists.
     */
    public func bind(): Unit {
        this.impl.bind(None)
    }

    /**
     * Configure the socket to only work with the specified remote peer address. To undo this action use disconnect()
     *
     * After invoking this function with a particular address, we will not be able to send message to peers other than this. We will also never receive any messages from other peers (they will be just filtered out). Invoking disconnect() reverts the filter to the initial state so it will be possible to send message to any recipients again.
     *
     * This function should be only invoked after bind()
     */
    public func connect(remotePath: String): Unit {
        connect(UnixSocketAddress(remotePath))
    }

    /**
     * Configure the socket to only work with the specified remote peer address. To undo this action use disconnect()
     *
     * After invoking this function with a particular address, we will not be able to send message to peers other than this. We will also never receive any messages from other peers (they will be just filtered out). Invoking disconnect() reverts the filter to the initial state so it will be possible to send message to any recipients again.
     *
     * This function should be only invoked after bind()
     *
     * @throws SocketException if the socket is not bound.
     * @throws SocketException if the connection cannot be established.
     */
    public func connect(remote: SocketAddress): Unit {
        checkUnixSocketAddress(remote, "remote")
        this.impl.connectToRemote(remote)
    }

    /**
     * Reverts the effect of connect() function so we can send and receive to/from any address again.
     * This function makes no effect if invoked multiple times or if we invoke disconnect without connect invocation.
     *
     * @throws SocketException if the socket is not bound.
     * @throws SocketException if the connection cannot be established.
     */
    public func disconnect(): Unit {
        this.impl.disconnect()
    }

    /**
     * Receive the next datagram into the specified buffer waiting for data if needed.
     *
     * Returns a pair of the datagram sender address and the actual size of received datagram, possibly zero
     * or a value greater than the passed buffer size.
     *
     * Unlike read in streams, this function requires a buffer of proper size (big enough),
     * otherwise a datagram that is bigger than the provided buffer will be
     * truncated and the returned datagram size will be greater that the buffer size.
     *
     * @throws SocketException if buffer is empty or if it is not possible to read the data.
     * @throws SocketTimeoutException if reading time has expired.
     */
    public override func receiveFrom(buffer: Array<Byte>): (SocketAddress, Int64) {
        this.impl.receiveFrom(buffer) ?? SocketException.throwClosedException()
    }

    /**
     * Receive a datagram message from the preconfigured peer address.
     * This only works if the address has been specified via connect() otherwise will fail.
     * In other aspects, it works the same as regular `receiveFrom(buffer).
     */
    public func receive(buffer: Array<Byte>): Int64 {
        let _ = this.impl.remoteAddress ?? SocketException.notYetConnected()
        let (_, size) = receiveFrom(buffer)
        return size
    }

    /**
     * Sends datagram of the payload to the specified recipient address.
     *
     * It also may block in this function invocation if there is not enough
     * output buffer space available for some reason. Depending on the underlying
     * implementation, it may also silently discard a datagram in this case.
     */
    public override func sendTo(recipient: SocketAddress, payload: Array<Byte>): Unit {
        checkUnixSocketAddress(recipient, "recipient")

        this.impl.send(payload, recipient)
    }

    /**
     * Send a message with the specified payload to the peer with preconfigured address.
     * This only works if address has been specified using `connect() ` otherwise will fail immediately.
     *
     * In other aspects, it works the same as regular `sendTo(recipient,payload).
     */
    public func send(payload: Array<Byte>): Unit {
        if (OS == "macOS") {
            this.impl.write(payload)
        } else {
            sendTo(this.impl.remoteAddress ?? SocketException.notYetConnected(), payload)
        }
    }

    public override func toString(): String {
        "UnixDatagramSocket(${this.impl.toString()})"
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
        get() { this.impl.getSendBufferSize() }
        set(newSize) { this.impl.setSendBufferSize(newSize) }
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
        get() { this.impl.getReceiveBufferSize() }
        set(newSize) { this.impl.setReceiveBufferSize(newSize) }
    }

    public func getSocketOptionBool(level: Int32, option: Int32): Bool {
        this.impl.getSocketOptionBool(level, option)
    }

    public func setSocketOptionBool(level: Int32, option: Int32, value: Bool): Unit {
        this.impl.setSocketOptionBool(level, option, value)
    }

    /**
     * Read the specified socket option writing the result to value buffer
     * of the specified valueLength (in bytes).
     * Before invoking this function valueLength should be initialized with the buffer size
     * After invoking this function valueLength will contain the actual result
     * size in bytes.
     *
     * Throws an exception if failed (when getsockopt returns -1).
     */
    public func getSocketOption(level: Int32, option: Int32, value: CPointer<Unit>, valueLength: CPointer<UIntNative>): Unit {
        unsafe { this.impl.getSocketOption(level, option, value, valueLength) }
    }

    /**
     * Write the specified socket option from value buffer having valueLength
     * size in bytes.
     *
     * See SocketOptions for popular option constants.
     *
     * Throws an exception if failed (when setsockopt returns -1).
     */
    public func setSocketOption(level: Int32, option: Int32, value: CPointer<Unit>, valueLength: UIntNative): Unit {
        unsafe { this.impl.setSocketOption(level, option, value, valueLength) }
    }

    /**
     * Read the specified socket option returning it's value as IntNative result.
     *
     * See SocketOptions for popular option constants.
     *
     * Throws an exception if failed (when getsockopt returns -1) or if the result
     * has size different from IntNative.
     */
    public func getSocketOptionIntNative(level: Int32, option: Int32): IntNative {
        this.impl.getSocketOptionIntNative(level, option)
    }

    /**
     * Write a numeric IntNative value to the specified socket option.
     *
     * See SocketOptions for popular option constants.
     *
     * Throws an exception if failed (when setsockopt returns -1), for example
     * when the option size is different from IntNative.
     */
    public func setSocketOptionIntNative(level: Int32, option: Int32, value: IntNative): Unit {
        this.impl.setSocketOptionIntNative(level, option, value)
    }
}
