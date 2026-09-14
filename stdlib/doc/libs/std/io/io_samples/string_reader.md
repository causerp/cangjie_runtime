# StringReader 示例

下面是 StringReader 从流中读取数据示例。
<!-- verify -->
```cangjie
import std.io.*

main(): Unit {
    let sourceBytes = "012\n346789".toArray()
    let byteBuffer = ByteBuffer()
    byteBuffer.write(sourceBytes)
    let stringReader = StringReader(byteBuffer)

    // 读取一个字符
    let ch = stringReader.read()
    println("读取一个字符: ${ch.getOrThrow()}")

    // 读取一行数据
    let line = stringReader.readln()
    println("读取一行: ${line.getOrThrow()}")

    // 读取数据直到遇到字符 '6'
    let untilStr = stringReader.readUntil(r'6')
    println("读取到字符 '6' 为止: ${untilStr.getOrThrow()}")

    // 读取剩余的全部数据
    let remainingStr = stringReader.readToEnd()
    println("剩余数据: ${remainingStr}")
}
```

运行结果：

```text
读取一个字符: 0
读取一行: 12
读取到字符 '6' 为止: 346
剩余数据: 789
```
