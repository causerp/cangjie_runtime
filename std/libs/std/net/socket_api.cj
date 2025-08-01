/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.net

import std.io.*

/**
 * Represents a socket that works in streaming mode. It is a duplex stream having both read and write operations.
 *
 * A streaming socket could be bound and connected. The remote and local address could be determined via the corresponding properties.
 * Read and write operations can optionally have completion time limit.
 *
 * A streaming socket does send bytes sequentially (possibly batching by packets), the order or incoming and outgoing bytes is always considered
 * and kept. The actuall streaming socket implementation usually has buffers for reading and writing.
 *
 * The read function copies some incoming bytes to the specified buffer, the actual amount of bytes per invocation is generally unpredictable
 * and depends on many factors like the buffer size, the underlying buffer size, timing and the operating system and it's implementation.
 * Every time read() function is invoked, a batch of bytes (at least one byte) is copied and the bytes are remembered as read.
 * So the next read invocation can only receive remaining bytes. If there are no unprocessed incoming bytes yet, the read operation blocks until
 * any bytes arrives (or timeout limit exceeded).
 * The write operation works in a similar way: writing buffer does copy and schedule bytes for sending. If the underlying buffer capacity is not enough
 * or we are writing bytes faster then they are transferred, then the write operation may block until some buffer space get freed or the timeout limit exceeded.
 *
 * The order of bytes and batches/packets is always preserved in both read and write direction.
 * However, the timing and the number of batches is not guaranteed to remain the same during transferring, only the total number of bytes and the content.
 * For example, a peer sends 10 bytes and then 15 more bytes. The remote peer could receive these bytes in two pieces (10 then 15 bytes) or
 * it may receive all bytes at once (25 bytes) depending on timing, network strucuture and many other reasons.
 *
 * A streaming socket is usually (but not necessarily) connected to a stream of unknown/unpredictable size
 * so the length property inherited from InputStream returns -1 for such sockets.
 */
public interface StreamingSocket <: IOStream & Resource & ToString {
    /**
     * Local address the socket will be or currently is bound at.
     *
     * @throws SocketException is the socket is already closed
     * or no local address is available (local address was not provided during creation and the socket is not connected).
     */
    prop localAddress: SocketAddress

    /**
     * Remote address the socket will be or is currently connected to.
     *
     * @throws SocketException is the socket is already closed.
     */
    prop remoteAddress: SocketAddress

    /**
     * Read operation time limit or `None` for infinite read attempts.
     * The value specified here is actually the minimal amount of time before a read operation cancelled.
     * The actual time is not guaranteed but it will be never cancelled earlier than the specified timeout value.
     * If the duration is too big than it can be bumped to the infinite. When it's too small then if will be bumped to the minimal clock granularity.
     *
     * The default value is None.
     *
     * @throws IllegalArgumentException if the specified timeout duration is negative.
     */
    mut prop readTimeout: ?Duration

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
    mut prop writeTimeout: ?Duration
}

/**
 * Represents a socket that handles datagrams in both input and output directions.
 *
 * A datagram is a bytes message of a finite size (possibly empty).
 * Depending on the actual datagram socket kind, there is usually a maxmimal datagram size. For example, a UDP socket can handle up to 64KiB at once.
 *
 * A datagram is transferred at once while the order or datagrams is not guaranteed, only the order and content of bytes inside.
 * Unlike streaming socket, datagrams may arrive in different order or not arrive at all.
 * This is because datagrams are routed independently and possibly via different actual routes.
 * Also, datagram size is always preserved (if possible, see receive/receiveFrom). For example, a peer sends datagrams of 10 and 15 bytes. Then,
 * the remote peer receives bytes in batches of the same size, 10 bytes and 15 bytes.
 */
public interface DatagramSocket <: Resource & ToString {
    /**
     * Local address the socket will be or currently is bound at.
     *
     * @throws SocketException is the socket is already closed
     * or no local address is available (local address was not provided during creation and the socket is not connected).
     */
    prop localAddress: SocketAddress

    /**
     * Remote address the socket is connected to or `None` if the socket is unconnected.
     *
     * @throws SocketException is the socket is already closed.
     */
    prop remoteAddress: ?SocketAddress

    /**
     * Receive/ReceiveFrom operation time limit or `None` for infinite read attempts.
     * The value specified here is actually the minimal amount of time before a read operation cancelled.
     * The actual time is not guaranteed but it will be never cancelled earlier than the specified timeout value.
     * If the duration is too big than it can be bumped to the infinite. When it's too small then if will be bumped to the minimal clock granularity
     *
     * The default value is None.
     * @throws IllegalArgumentException if the specified timeout duration is negative.
     */
    mut prop receiveTimeout: ?Duration

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
    mut prop sendTimeout: ?Duration

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
     * @throws SocketTimeoutException if reading time has expired
     */
    func receiveFrom(buffer: Array<Byte>): (SocketAddress, Int64)

    /**
     * Send datagram to the specified remote peer.
     *
     * It also may block in this function invocation if there is not enough
     * output buffer space available for some reason. Depending on the underlying
     * implementation, it may also silently discard a datagram in this case.
     */
    func sendTo(address: SocketAddress, payload: Array<Byte>): Unit
}

public interface ServerSocket <: Resource & ToString {
    /**
     * Local address the server socket will be or currently is bound at.
     *
     * @throws SocketException is the socket is already closed.
     */
    prop localAddress: SocketAddress

    /**
     * Bind a streaming socket. Depending on reuse flags and environment state,
     * it may fail if the local port/address/path is already occupied
     * or when there are connections remaining from the previously bound socket.
     * This function also does listen just after binding creating an incoming connections queue that could be accessed via "accept()" function.
     */
    func bind(): Unit

    /**
     * Accept a client socket, waiting for one if there are no pending connection requests.
     *
     * The OS implementation usually provides an incoming connection requests queue,
     * so calling accept() does takes a candidate from the queue
     * or wait until we get some request if the queue is empty.
     *
     * @throws SocketTimeoutException if the specified timeout ellapsed before any connection request were made.
     * @throws IllegalArgumentException if the specified timeout duration is negative.
     */
    func accept(timeout!: ?Duration): StreamingSocket

    /**
     * Accept a client socket, waiting for one if there are no pending connection requests.
     *
     * The OS implementation usually provides an incoming connection requests queue,
     * so calling accept() does takes a candidate from the queue
     * or wait until we get some request if the queue is empty.
     */
    func accept(): StreamingSocket {
        accept(timeout: None)
    }
}
