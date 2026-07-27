# BufferedInputStream 示例

下面是 BufferedInputStream 从流中读取数据示例。
<!-- verify -->
```cangjie
import std.io.*

main(): Unit {
    // 准备源数据并写入 ByteBuffer
    let sourceBytes = "0123456789".toArray()
    let byteBuffer = ByteBuffer()
    byteBuffer.write(sourceBytes)

    // 用缓冲输入流包装 ByteBuffer
    let bufferedInputStream = BufferedInputStream(byteBuffer)
    let readBuffer = Array<Byte>(20, repeat: 0)

    // 读取流中数据，返回读取到的数据长度
    let readLen = bufferedInputStream.read(readBuffer)
    println("读取到 ${readLen} 个字节: ${String.fromUtf8(readBuffer[..readLen])}")
}
```

运行结果：

```text
读取到 10 个字节: 0123456789
```
