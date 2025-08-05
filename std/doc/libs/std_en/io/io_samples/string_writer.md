# StringWriter Example

The following demonstrates writing data to a stream using StringWriter.
<!-- verify -->

```cangjie
import std.io.*

main(): Unit {
    let byteBuffer = ByteBuffer()
    let stringWriter = StringWriter(byteBuffer)

    /* Write string */
    stringWriter.write("number")

    /* Write string with automatic newline */
    stringWriter.writeln(" is:")

    /* Write number */
    stringWriter.write(100.0f32)

    stringWriter.flush()

    println(String.fromUtf8(readToEnd(byteBuffer)))
}
```

Execution result:

```text
number is:
100.000000
```