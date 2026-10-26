# UDP 使用示例

<!-- verify -->
```cangjie
import std.net.*

let SERVER_PORT: UInt16 = 33333

func runUdpServer() {
    // 绑定端口
    try (serverSocket = UdpSocket(bindAt: SERVER_PORT)) {
        serverSocket.bind()

        // 接收数据并获取发送方地址
        let buf = Array<Byte>(3, repeat: 0)
        let (clientAddr, count) = serverSocket.receiveFrom(buf)
        let sender = (clientAddr as IPSocketAddress)?.address.toString() ?? ""
        println("服务端接收到 ${count} 个字节: ${buf}，来自 ${sender}")
    }
}

main(): Int64 {
    // 启动服务端线程
    let serverFuture = spawn {
        runUdpServer()
    }

    // 等待服务端完成绑定（预留 1 秒）
    sleep(Duration.second)

    // 客户端绑定随机端口后向服务端发送数据
    try (udpSocket = UdpSocket(bindAt: 0)) {
        udpSocket.sendTimeout = Duration.second * 2
        udpSocket.bind()
        udpSocket.sendTo(
            IPSocketAddress("127.0.0.1", SERVER_PORT),
            [1, 2, 3]
        )
    }

    serverFuture.get()

    return 0
}
```

运行结果：

```text
服务端接收到 3 个字节: [1, 2, 3]，来自 127.0.0.1
```
