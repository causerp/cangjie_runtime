# BufferedOutputStream 示例

下面是 BufferedOutputStream 向流中写入数据示例。
<!-- verify -->
```cangjie
import std.io.*

main(): Unit {
    // 准备源数据并写入 ByteBuffer
    let sourceBytes = "01234".toArray()
    let byteBuffer = ByteBuffer()
    byteBuffer.write(sourceBytes)

    // 用缓冲输出流包装 ByteBuffer
    let bufferedOutputStream = BufferedOutputStream(byteBuffer)
    let appendBytes = "56789".toArray()

    // 向流中写入数据，此时数据暂存在缓冲区中
    bufferedOutputStream.write(appendBytes)

    // 调用 flush 函数，将缓冲区数据真正写入内部流
    bufferedOutputStream.flush()
    println("刷新后的完整数据: ${String.fromUtf8(readToEnd(byteBuffer))}")
}
```

运行结果：

```text
刷新后的完整数据: 0123456789
```
