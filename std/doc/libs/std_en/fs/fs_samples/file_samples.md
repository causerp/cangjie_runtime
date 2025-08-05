# File Example

## File Basic Operations: Create, Delete, Read/Write, Close

Code:
<!-- verify -->

```cangjie
import std.fs.*
import std.io.*

main() {
    let filePath: Path = Path("./tempFile.txt")
    if (exists(filePath)) {
        remove(filePath)
    }

    /* Create a new file 'tempFile.txt' in write-only mode in current directory, write "123456789\n" three times and close the file */
    var file: File = File(filePath, Write)
    if (exists(filePath)) {
        println("The file 'tempFile.txt' is created successfully in current directory.\n")
    }
    let bytes: Array<Byte> = "123456789\n".toArray()
    for (_ in 0..3) {
        file.write(bytes)
    }
    file.close()

    /* Open file './tempFile.txt' in append mode, write "abcdefghi\n" and close the file */
    file = File(filePath, Append)
    file.write("abcdefghi\n".toArray())
    file.close()

    /* Open file './tempFile.txt' in read-only mode, read data as required and close the file */
    file = File(filePath, Read)
    let bytesBuf: Array<Byte> = Array<Byte>(10, repeat: 0)
    // Read 10 bytes of data starting from the 10th byte after the file header
    file.seek(SeekPosition.Begin(10))
    file.read(bytesBuf)
    println("Data of the 10th byte after the 10th byte: ${String.fromUtf8(bytesBuf)}")
    // Read the last 10 bytes of data
    file.seek(SeekPosition.End(-10))
    file.read(bytesBuf)
    println("Data of the last 10 bytes: ${String.fromUtf8(bytesBuf)}")
    file.close()

    /* Open file './tempFile.txt' in read-write mode, perform operations and close the file */
    file = File(filePath, ReadWrite)
    // Truncate file size to 0
    file.setLength(0)
    // Write new content to the file
    file.write("The file was truncated to an empty file!".toArray())
    // Reset cursor to file header
    file.seek(SeekPosition.Begin(0))
    // Read file content
    let allBytes: Array<Byte> = readToEnd(file)
    // Close the file
    file.close()
    println("Data written newly: ${String.fromUtf8(allBytes)}")

    remove(filePath)
    return 0
}
```

Execution Result:

```text
The file 'tempFile.txt' is created successfully in current directory.

Data of the 10th byte after the 10th byte: 123456789

Data of the last 10 bytes: abcdefghi

Data written newly: The file was truncated to an empty file!
```

## Demonstration of Some File Static Functions

Code:
<!-- verify -->

```cangjie
import std.fs.*

main() {
    let filePath: Path = Path("./tempFile.txt")
    if (exists(filePath)) {
        remove(filePath)
    }

    /* Create file in write-only mode, write "123456789\n" and close the file */
    var file: File = File.create(filePath)
    file.write("123456789\n".toArray())
    file.close()

    /* Append "abcdefghi\n" to the file in append mode */
    File.appendTo(filePath, "abcdefghi".toArray())

    /* Directly read all data from the file */
    let allBytes: Array<Byte> = File.readFrom(filePath)
    println(String.fromUtf8(allBytes))

    remove(filePath)
    return 0
}
```

Execution Result:

```text
123456789
abcdefghi
```