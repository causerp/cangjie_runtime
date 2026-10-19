# UNIX 使用示例

<!-- verify -->
```cangjie
import std.net.*
import std.fs.*

let SOCKET_PATH = "/tmp/tmpsock"

func runUnixServer() {
    // 绑定并监听 Unix 域套接字
    try (serverSocket = UnixServerSocket(bindAt: SOCKET_PATH)) {
        serverSocket.bind()

        // 接受客户端连接并发送数据
        try (client = serverSocket.accept()) {
            client.write("hello".toArray())
        }
    }
}

main(): Int64 {
    // 清理可能残留的套接字文件
    removeIfExists(SOCKET_PATH)

    // 启动服务端线程
    let serverFuture = spawn {
        runUnixServer()
    }

    // 等待服务端完成绑定（预留 1 秒）
    sleep(Duration.second)

    // 客户端连接并读取服务端发来的数据
    try (socket = UnixSocket(SOCKET_PATH)) {
        socket.connect()

        let readBuffer = Array<Byte>(5, repeat: 0)
        socket.read(readBuffer)
        println("客户端读取到: ${String.fromUtf8(readBuffer)}")
    }

    serverFuture.get()
    removeIfExists(SOCKET_PATH)
    return 0
}
```

运行结果：

```text
客户端读取到: hello
```
