# UnixDatagram 使用示例

<!-- verify -->
```cangjie
import std.net.*
import std.fs.*
import std.random.*
import std.env.*

// 在系统临时目录下生成一个随机路径，用作 Unix 域数据报套接字的绑定地址
func createTempFile(): String {
    let tempDir: Path = getTempDirectory()
    let randomSuffix: String = Random().nextUInt64().toString()
    return tempDir.join("tmp${randomSuffix}").toString()
}

func runUnixDatagramServer(serverPath: String, clientPath: String) {
    try (serverSocket = UnixDatagramSocket(bindAt: serverPath)) {
        serverSocket.bind()

        // 接收数据并获取发送方地址
        let buf = Array<Byte>(3, repeat: 0)
        let (clientAddr, count) = serverSocket.receiveFrom(buf)

        if (count == 3 && buf == [1, 2, 3]) {
            println("服务端接收成功")
        }
        if (clientAddr.toString() == clientPath) {
            println("客户端地址验证正确")
        }
    }
}

main(): Int64 {
    let clientPath = createTempFile()
    let serverPath = createTempFile()

    // 启动服务端线程
    let serverFuture = spawn {
        runUnixDatagramServer(serverPath, clientPath)
    }

    // 等待服务端完成绑定（预留 1 秒）
    sleep(Duration.second)

    // 客户端绑定自己的地址后连接服务端并发送数据
    try (unixSocket = UnixDatagramSocket(bindAt: clientPath)) {
        unixSocket.sendTimeout = Duration.second * 2
        unixSocket.bind()
        unixSocket.connect(serverPath)

        unixSocket.send([1, 2, 3])
    }

    serverFuture.get()

    // 清理本次运行创建的套接字文件
    removeIfExists(clientPath)
    removeIfExists(serverPath)

    return 0
}
```

运行结果：

```text
服务端接收成功
客户端地址验证正确
```
