# StringReader Example

The following demonstrates how StringReader reads data from a stream.
<!-- verify -->

```cangjie
import std.io.*

main(): Unit {
    let arr1 = "012\n346789".toArray()
    let byteBuffer = ByteBuffer()
    byteBuffer.write(arr1)
    let stringReader = StringReader(byteBuffer)

    /* Read one byte */
    let ch = stringReader.read()
    println(ch ?? 'a')

    /* Read one line of data */
    let line = stringReader.readln()
    println(line ?? "error")

    /* Read data until encountering character '6' */
    let until = stringReader.readUntil(r'6')
    println(until ?? "error")

    /* Read all remaining data */
    let all = stringReader.readToEnd()
    println(all)
}
```

Execution result:

```text
0
12
346
789
```