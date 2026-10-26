# TCP 使用示例

<!-- verify -->
```cangjie
import std.net.*

let SERVER_PORT: UInt16 = 33333

func runTcpServer() {
    // 绑定端口并监听
    try (serverSocket = TcpServerSocket(bindAt: SERVER_PORT)) {
        serverSocket.bind()

        // 接受客户端连接并读取数据
        try (client = serverSocket.accept()) {
            let readBuffer = Array<Byte>(10, repeat: 0)
            let count = client.read(readBuffer)
            println("服务端读取到 ${count} 个字节: ${readBuffer}")
        }
    }
}

main(): Int64 {
    // 启动服务端线程
    let serverFuture = spawn {
        runTcpServer()
    }

    // 等待服务端完成绑定（预留 1 秒）
    sleep(Duration.second)

    // 客户端连接并发送数据
    try (socket = TcpSocket("127.0.0.1", SERVER_PORT)) {
        socket.connect()
        socket.write([1, 2, 3])
    }

    serverFuture.get()

    return 0
}
```

运行结果：

```text
服务端读取到 3 个字节: [1, 2, 3, 0, 0, 0, 0, 0, 0, 0]
```
