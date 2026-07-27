# StringWriter 示例

下面是 StringWriter 向流中写入数据示例。
<!-- verify -->
```cangjie
import std.io.*

main(): Unit {
    let byteBuffer = ByteBuffer()
    let stringWriter = StringWriter(byteBuffer)

    // 写入字符串
    stringWriter.write("number")

    // 写入字符串并自动换行
    stringWriter.writeln(" is:")

    // 写入数字
    stringWriter.write(100.0f32)

    // 将缓冲数据刷新到底层流
    stringWriter.flush()

    println("写入的完整内容: ${String.fromUtf8(readToEnd(byteBuffer))}")
}
```

运行结果：

```text
写入的完整内容: number is:
100.000000
```
