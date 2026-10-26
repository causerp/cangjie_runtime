# File 示例

## File 常规操作：创建、删除、读写、关闭

示例：
<!-- verify -->
```cangjie
import std.fs.*
import std.io.*

main() {
    let filePath: Path = Path("./tempFile.txt")

    // 清理上次运行可能残留的文件
    removeIfExists(filePath)

    // 以只写模式创建新文件，写入三遍 "123456789\n" 后关闭
    var file: File = File(filePath, Write)
    println("文件创建成功: tempFile.txt")
    let bytes: Array<Byte> = "123456789\n".toArray()
    for (_ in 0..3) {
        file.write(bytes)
    }
    file.close()

    // 以追加模式打开文件，写入 "abcdefghi\n" 后关闭
    file = File(filePath, Append)
    file.write("abcdefghi\n".toArray())
    file.close()

    // 以只读模式打开文件，从指定位置读取数据后关闭
    file = File(filePath, Read)
    let readBuffer: Array<Byte> = Array<Byte>(10, repeat: 0)

    // 从文件头偏移 10 个字节处开始读取 10 个字节
    file.seek(SeekPosition.Begin(10))
    file.read(readBuffer)
    println("第 10 字节之后的 10 个字节: ${String.fromUtf8(readBuffer)}")

    // 读取文件尾部的 10 个字节
    file.seek(SeekPosition.End(-10))
    file.read(readBuffer)
    println("文件末尾的 10 个字节: ${String.fromUtf8(readBuffer)}")
    file.close()

    // 以读+写模式打开文件，先截断为空文件再写入新内容
    file = File(filePath, ReadWrite)
    file.setLength(0)
    file.write("文件已被截断为空文件！".toArray())

    // 重置游标到文件头并读取全部内容
    file.seek(SeekPosition.Begin(0))
    let allBytes: Array<Byte> = readToEnd(file)
    file.close()
    println("截断后新写入的内容: ${String.fromUtf8(allBytes)}")

    // 清理本次运行创建的文件
    removeIfExists(filePath)
    return 0
}
```

运行结果：

```text
文件创建成功: tempFile.txt
第 10 字节之后的 10 个字节: 123456789

文件末尾的 10 个字节: abcdefghi

截断后新写入的内容: 文件已被截断为空文件！
```

## File 的一些 static 函数演示

示例：
<!-- verify -->
```cangjie
import std.fs.*

main() {
    let filePath: Path = Path("./tempFile.txt")

    // 清理上次运行可能残留的文件
    removeIfExists(filePath)

    // 创建新文件并写入 "123456789\n" 后关闭
    var file: File = File.create(filePath)
    file.write("123456789\n".toArray())
    file.close()

    // 以追加模式将 "abcdefghi" 写入文件
    File.appendTo(filePath, "abcdefghi".toArray())

    // 一次性读取文件中的全部数据
    let allBytes: Array<Byte> = File.readFrom(filePath)
    println(String.fromUtf8(allBytes))

    // 清理本次运行创建的文件
    removeIfExists(filePath)
    return 0
}
```

运行结果：

```text
123456789
abcdefghi
```
