# MultiOutputStream Example

The following demonstrates how MultiOutputStream writes data to all bound streams.
<!-- verify -->

```cangjie
import std.io.*

main(): Unit {
    const size = 2

    /* Bind two ByteBuffers to MultiOutputStream */
    let streamArr = Array<OutputStream>(size, {_ => ByteBuffer()})
    let multiOutputStream = MultiOutputStream(streamArr)

    /* Writing data to MultiOutputStream will simultaneously write to both bound ByteBuffers */
    multiOutputStream.write("test".toArray())

    /* Read data from ByteBuffers to verify results */
    for (i in 0..size) {
        match (streamArr[i]) {
            case v: ByteBuffer => println(String.fromUtf8(readToEnd(v)))
            case _ => throw Exception()
        }
    }
}
```

Execution Result:

```text
test
test
```