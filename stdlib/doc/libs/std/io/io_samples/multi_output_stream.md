# MultiOutputStream 示例

下面是 MultiOutputStream 向绑定的所有流中写入数据示例。
<!-- verify -->
```cangjie
import std.io.*

main(): Unit {
    const size = 2

    // 将两个 ByteBuffer 绑定到 MultiOutputStream
    let streams = Array<OutputStream>(size, {_ => ByteBuffer()})
    let multiOutputStream = MultiOutputStream(streams)

    // 向 MultiOutputStream 写入数据，数据会同时写入绑定的两个流
    multiOutputStream.write("test".toArray())

    // 依次读取每个流中的数据
    for (i in 0..size) {
        match (streams[i]) {
            case v: ByteBuffer => println("流 ${i} 中的数据: ${String.fromUtf8(readToEnd(v))}")
            case _ => throw Exception()
        }
    }
}
```

运行结果：

```text
流 0 中的数据: test
流 1 中的数据: test
```
