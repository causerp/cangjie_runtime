# ChainedInputStream 示例

下面是 ChainedInputStream 从绑定的流中循环读取数据示例。
<!-- verify -->
```cangjie
import std.io.*
import std.collection.ArrayList

main(): Unit {
    const size = 2

    // 创建两个 ByteBuffer 并分别写入数据
    let streams = Array<InputStream>(size, {_ => ByteBuffer()})
    for (i in 0..size) {
        match (streams[i]) {
            case v: OutputStream =>
                let str = "now ${i}"
                v.write(str.toArray())
            case _ => throw Exception()
        }
    }

    // 将两个流绑定到 ChainedInputStream，读取时按绑定顺序依次进行
    let chainedInputStream = ChainedInputStream(streams)
    let readBytes = ArrayList<Byte>()
    let buffer = Array<Byte>(20, repeat: 0)
    var readLen = chainedInputStream.read(buffer)

    // 循环读取，直到没有数据
    while (readLen != 0) {
        readBytes.add(all: buffer[..readLen])
        readLen = chainedInputStream.read(buffer)
    }
    println("读取的完整数据: ${String.fromUtf8(readBytes.toArray())}")
}
```

运行结果：

```text
读取的完整数据: now 0now 1
```
