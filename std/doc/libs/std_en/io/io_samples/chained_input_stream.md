# ChainedInputStream Example

The following demonstrates how ChainedInputStream cyclically reads data from bound streams.
<!-- verify -->

```cangjie
import std.io.*
import std.collection.ArrayList

main(): Unit {
    const size = 2

    /* Create two ByteBuffers and write data */
    let streamArr = Array<InputStream>(size, {_ => ByteBuffer()})
    for (i in 0..size) {
        match (streamArr[i]) {
            case v: OutputStream =>
                let str = "now ${i}"
                v.write(str.toArray())
            case _ => throw Exception()
        }
    }

    /* Bind two ByteBuffers to ChainedInputStream */
    let chainedInputStream = ChainedInputStream(streamArr)
    let res = ArrayList<Byte>()
    let buffer = Array<Byte>(20, repeat: 0)
    var readLen = chainedInputStream.read(buffer)

    /* Cyclically read data from chainedInputStream */
    while (readLen != 0) {
        res.add(all: buffer[..readLen])
        readLen = chainedInputStream.read(buffer)
    }
    println(String.fromUtf8(res.toArray()))
}
```

Execution result:

```text
now 0now 1
```