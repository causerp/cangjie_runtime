# Interface

## interface DatagramSocket

```cangjie
public interface DatagramSocket <: Resource & ToString {
    prop localAddress: SocketAddress
    prop remoteAddress: ?SocketAddress
    mut prop receiveTimeout: ?Duration
    mut prop sendTimeout: ?Duration
    func receiveFrom(buffer: Array<Byte>): (SocketAddress, Int64)
    func sendTo(address: SocketAddress, payload: Array<Byte>): Unit
}
```

Description: [DatagramSocket](net_package_interfaces.md#interface-datagramsocket) is a socket for receiving and sending datagram packets.

A datagram packet typically has a finite size and may be empty. Different datagram socket types have different maximum packet sizes. For example, a `UDP` socket can handle packets up to 64KB in size.
Datagram transmission is not reliable and does not guarantee delivery order. The packet size is determined at the sender side. For example: if one end sends packets of 10 bytes and 15 bytes, the receiving end will receive corresponding packets of the same sizes (10 bytes and 15 bytes).

Parent Types:

- [Resource](../../core/core_package_api/core_package_interfaces.md#interface-resource)
- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

### prop localAddress

```cangjie
prop localAddress: SocketAddress
```

Description: Reads the local address to which the `Socket` is or will be bound.

Type: [SocketAddress](net_package_classes.md#class-socketaddress)

Exceptions:

- [SocketException](net_package_exceptions.md#class-socketexception) - Thrown when the `Socket` is closed or no local address is available (local address not configured and socket not connected).

### prop receiveTimeout

```cangjie
mut prop receiveTimeout: ?Duration
```

Description: Sets and reads the timeout for `receiveFrom`. Set to `None` for no timeout.

If the set time is too small, it will be adjusted to the minimum clock cycle value; if too large, it will be set to the maximum timeout (2<sup>63</sup>-1 nanoseconds). Default value is `None`.

Type: ?[Duration](../../core/core_package_api/core_package_structs.md#struct-duration)

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when timeout is less than 0.

### prop remoteAddress

```cangjie
prop remoteAddress: ?SocketAddress
```

Description: Reads the remote address to which the `Socket` is connected. Returns `None` if the `Socket` is not connected.

Type: ?[SocketAddress](net_package_classes.md#class-socketaddress)

Exceptions:

- [SocketException](net_package_exceptions.md#class-socketexception) - Thrown when the `Socket` is closed.

### prop sendTimeout

```cangjie
mut prop sendTimeout: ?Duration
```

Description: Sets and reads the timeout for `sendTo`. Default is `None`.

If the set time is too small, it will be adjusted to the minimum clock cycle value; if too large, it will be set to the maximum timeout (2<sup>63</sup>-1 nanoseconds). Default value is `None`.

Type: ?[Duration](../../core/core_package_api/core_package_structs.md#struct-duration)

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when timeout is less than 0.

### func receiveFrom(Array\<Byte>)

```cangjie
func receiveFrom(buffer: Array<Byte>): (SocketAddress, Int64)
```

Description: Blocks and waits to receive a packet into `buffer`.

Parameters:

- buffer: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)> - Buffer space for storing packet content. `buffer` should have an appropriate size; otherwise, the packet may be truncated, and the returned packet size may exceed the buffer size.

Return Value:

- ([SocketAddress](net_package_classes.md#class-socketaddress), [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)) - The sender's address and the size of the received packet (may be 0 or larger than the `buffer` size).

Exceptions:

- [SocketException](net_package_exceptions.md#class-socketexception) - Thrown when the local buffer is too small to read the packet.
- [SocketTimeoutException](net_package_exceptions.md#class-sockettimeoutexception) - Thrown when the read operation times out.

### func sendTo(SocketAddress, Array\<Byte>)

```cangjie
func sendTo(address: SocketAddress, payload: Array<Byte>): Unit
```

Description: Sends a packet to the specified remote address. This operation may block if the receiver's buffer is insufficient, and the packet may be discarded.

Parameters:

- address: [SocketAddress](net_package_classes.md#class-socketaddress) - The remote address to send to.
- payload: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Byte](../../core/core_package_api/core_package_types.md#type-byte)> - The packet content to send.

## interface ServerSocket

```cangjie
public interface ServerSocket <: Resource & ToString {
    prop localAddress: SocketAddress
    func accept(): StreamingSocket
    func accept(timeout!: ?Duration): StreamingSocket
    func bind(): Unit
}
```

Description: Provides the interface required for server-side `Socket`.

Parent Types:

- [Resource](../../core/core_package_api/core_package_interfaces.md#interface-resource)
- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

### prop localAddress

```cangjie
prop localAddress: SocketAddress
```

Description: Reads the local address to which the `Socket` is or will be bound.

Type: [SocketAddress](net_package_classes.md#class-socketaddress)

Exceptions:

- [SocketException](net_package_exceptions.md#class-socketexception) - Thrown when the `Socket` is closed.

### func accept()

```cangjie
func accept(): StreamingSocket
```

Description: Accepts a client socket connection request, blocking until a connection is established.

Return Value:

- [StreamingSocket](net_package_interfaces.md#interface-streamingsocket) - The successfully connected client socket.

### func accept(?Duration)

```cangjie
func accept(timeout!: ?Duration): StreamingSocket
```

Description: Accepts a client socket connection request, blocking until a connection is established or timeout occurs.

Parameters:

- timeout!: ?[Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - The timeout duration for waiting.

Return Value:

- [StreamingSocket](net_package_interfaces.md#interface-streamingsocket) - The successfully connected client socket.

Exceptions:

- [SocketTimeoutException](net_package_exceptions.md#class-sockettimeoutexception) - Thrown when the connection request times out.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when timeout is less than 0.

### func bind()

```cangjie
func bind(): Unit
```

Description: Binds the socket.

If the `reuse` property is not set, the local port, address, or file path is already in use, or the previous socket binding failed, the socket must be `closed`. Multiple retries of this operation are not supported before executing `accept()`.

Exceptions:

- [SocketException](net_package_exceptions.md#class-socketexception) - Thrown when binding fails due to system reasons.

## interface StreamingSocket

```cangjie
public interface StreamingSocket <: IOStream & Resource & ToString {
    prop localAddress: SocketAddress
    prop remoteAddress: SocketAddress
    mut prop readTimeout: ?Duration
    mut prop writeTimeout: ?Duration
}
```

Description: A `Socket` operating in full-duplex streaming mode, supporting both read and write operations.

[StreamingSocket](net_package_interfaces.md#interface-streamingsocket) can be bound (`bind`) and connected (`connect`). Users can set the local and remote addresses for binding and connecting via properties.
[StreamingSocket](net_package_interfaces.md#interface-streamingsocket) can transmit byte streams in ordered packets. A buffer space is used to store the byte streams for reading and writing. The read interface (`read()`) blocks by default when no data arrives, waiting until the next data arrives or a timeout occurs. The write operation (`write()`) writes data to the buffer for subsequent transmission. If the buffer is insufficient or the write speed exceeds the transmission speed, the write operation will block until buffer space is available or a timeout occurs.
The order of read and write operations is always preserved, but the packetization strategy and size during transmission may differ from the sender's. For example: if one end sends a 10-byte packet followed by a 15-byte packet, the receiving end may receive them as separate 10-byte and 15-byte packets or as a single 25-byte packet.
When an abnormal packet is received, the packet length will be returned as -1.

Parent Types:

- [IOStream](../../io/io_package_api/io_package_interfaces.md#interface-iostream)
- [Resource](../../core/core_package_api/core_package_interfaces.md#interface-resource)
- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

### prop localAddress

```cangjie
prop localAddress: SocketAddress
```

Description: Reads the local address to which the `Socket` is or will be bound.

Type: [SocketAddress](net_package_classes.md#class-socketaddress)

Exceptions:

- [SocketException](net_package_exceptions.md#class-socketexception) - Thrown when the `Socket` is closed or no local address is available (local address not configured and socket not connected).

### prop readTimeout

```cangjie
mut prop readTimeout: ?Duration
```

Description: Sets and reads the read timeout.

If the set time is too small, it will be adjusted to the minimum clock cycle value; if too large, it will be set to the maximum timeout (2<sup>63</sup>-1 nanoseconds). Default value is `None`.

Type: ?[Duration](../../core/core_package_api/core_package_structs.md#struct-duration)

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when timeout is less than 0.

### prop remoteAddress

```cangjie
prop remoteAddress: SocketAddress
```

Description: Reads the remote address to which the `Socket` is or will be connected.

Type: [SocketAddress](net_package_classes.md#class-socketaddress)

Exceptions:

- [SocketException](net_package_exceptions.md#class-socketexception) - Thrown when the `Socket` is closed.

### prop writeTimeout

```cangjie
mut prop writeTimeout: ?Duration
```

Description: Sets and reads the write timeout.

If the set time is too small, it will be adjusted to the minimum clock cycle value; if too large, it will be set to the maximum timeout (2<sup>63</sup>-1 nanoseconds). Default value is `None`.

Type: ?[Duration](../../core/core_package_api/core_package_structs.md#struct-duration)

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when timeout is less than 0.