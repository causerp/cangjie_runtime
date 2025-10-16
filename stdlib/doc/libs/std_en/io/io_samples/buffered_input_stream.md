# BufferedInputStream Example

The following demonstrates how to read data from a stream using BufferedInputStream.
<!-- verify -->

```cangjie
import std.io.*

main(): Unit {
    let arr1 = "0123456789".toArray()
    let byteBuffer = ByteBuffer()
    byteBuffer.write(arr1)
    let bufferedInputStream = BufferedInputStream(byteBuffer)
    let arr2 = Array<Byte>(20, repeat: 0)

    /* Read data from the stream and return the length of data read */
    let readLen = bufferedInputStream.read(arr2)
    println(String.fromUtf8(arr2[..readLen]))
}
```

Execution result:

```text
0123456789
```