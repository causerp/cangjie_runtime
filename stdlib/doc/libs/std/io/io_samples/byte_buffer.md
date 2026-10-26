# ByteBuffer 示例

下面是 ByteBuffer 对流进行写入数据，读取数据等操作的示例。
<!-- verify -->
```cangjie
import std.io.*

main(): Unit {
    let sourceBytes = "test case".toArray()
    let byteBuffer = ByteBuffer()

    // 将数据写入流中
    byteBuffer.write(sourceBytes)

    // 读取前 4 个字节
    let headBytes = Array<Byte>(4, repeat: 0)
    byteBuffer.read(headBytes)
    println("前 4 个字节: ${String.fromUtf8(headBytes)}")

    // 将流的索引指向起点，读取全部数据
    byteBuffer.seek(Begin(0))
    let allBytes = readToEnd(byteBuffer)
    println("全部数据: ${String.fromUtf8(allBytes)}")

    // 将流的索引指向字母 'c' 的位置，读取剩余数据
    byteBuffer.seek(End(-4))
    let remainingStr = readString(byteBuffer)
    println("剩余数据: ${remainingStr}")
}
```

运行结果：

```text
前 4 个字节: test
全部数据: test case
剩余数据: case
```
