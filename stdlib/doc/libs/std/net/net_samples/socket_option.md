# 属性配置使用用例

## 属性配置

<!-- run -->
```cangjie
import std.net.*

main() {
    try (tcpSocket = TcpSocket("127.0.0.1", 80)) {
        // 配置读超时时间
        tcpSocket.readTimeout = Duration.second

        // 配置是否关闭 Nagle 算法
        tcpSocket.noDelay = false

        // 配置关闭时等待未发送数据的时间
        tcpSocket.linger = Duration.minute

        // 配置 keepalive 探测参数
        tcpSocket.keepAlive = SocketKeepAliveConfig(
            interval: Duration.second * 7,
            count: 15
        )
    }
}
```

## 增加自定义属性

<!-- verify -->
```cangjie
import std.net.*

// 通过扩展为 TcpSocket 增加自定义属性
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

    // 设置并读取自定义属性
    socket.customNoDelay = 1
    println("自定义属性 customNoDelay: ${socket.customNoDelay}")
}
```

运行结果：

```text
自定义属性 customNoDelay: 1
```
