# BufferedOutputStream Example

The following demonstrates writing data to a stream using BufferedOutputStream.
<!-- verify -->

```cangjie
import std.io.*

main(): Unit {
    let arr1 = "01234".toArray()
    let byteBuffer = ByteBuffer()
    byteBuffer.write(arr1)
    let bufferedOutputStream = BufferedOutputStream(byteBuffer)
    let arr2 = "56789".toArray()

    /* Writing data to the stream - data remains in the external stream's buffer at this stage */
    bufferedOutputStream.write(arr2)

    /* Calling the flush function to actually write the data to the internal stream */
    bufferedOutputStream.flush()
    println(String.fromUtf8(readToEnd(byteBuffer)))
}
```

Execution result:

```text
0123456789
```