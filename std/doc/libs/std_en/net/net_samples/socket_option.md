# Property Configuration Usage Examples

## Property Configuration

<!-- run -->

```cangjie
import std.net.*
import std.time.*
import std.sync.*

main() {
    try (tcpSocket = TcpSocket("127.0.0.1", 80)) {
        tcpSocket.readTimeout = Duration.second
        tcpSocket.noDelay = false
        tcpSocket.linger = Duration.minute

        tcpSocket.keepAlive = SocketKeepAliveConfig(
            interval: Duration.second * 7,
            count: 15
        )
    }
}
```

## Adding Custom Properties

<!-- verify -->

```cangjie
import std.net.*

extend TcpSocket {
    public mut prop customNoDelay: Int64 {
        get() {
            Int64(getSocketOptionIntNative(OptionLevel.TCP, SocketOptions.TCP_NODELAY))
        }
        set(value) {
            setSocketOptionIntNative(OptionLevel.TCP, SocketOptions.TCP_NODELAY, IntNative(value))
        }
    }
}

main() {
    let socket = TcpSocket("127.0.0.1", 0)
    socket.customNoDelay = 1
    println(socket.customNoDelay)
}
```

Execution Result:

```text
1
```