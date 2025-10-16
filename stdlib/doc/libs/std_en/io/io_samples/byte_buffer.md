# ByteBuffer Example

The following demonstrates operations such as writing data to and reading data from a stream using ByteBuffer.
<!-- verify -->

```cangjie
import std.io.*

main(): Unit {
    let arr1 = "test case".toArray()
    let byteBuffer = ByteBuffer()

    /* Write data from arr1 to the stream */
    byteBuffer.write(arr1)

    /* Read the first 4 bytes of data into arr2 */
    let arr2 = Array<Byte>(4, repeat: 0)
    byteBuffer.read(arr2)
    println(String.fromUtf8(arr2))

    /* Reset the stream index to the starting point */
    byteBuffer.seek(Begin(0))

    /* Read all data from the stream */
    let arr3 = readToEnd(byteBuffer)
    println(String.fromUtf8(arr3))

    /* Position the stream index at the letter 'c' */
    byteBuffer.seek(End(-4))

    /* Read the remaining data in the stream */
    let str = readString(byteBuffer)
    println(str)
}
```

Execution result:

```text
test
test case
case
```