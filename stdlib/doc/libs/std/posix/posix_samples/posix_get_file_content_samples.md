# 文件内容相关操作

下面是文件内容相关操作示例。

示例：

<!-- run -->
```cangjie
import std.posix.*

main(): Int64 {
    // 打开（不存在则创建）文件，返回文件描述符
    var fd = `open`("testfile.txt", O_RDWR | O_CREAT | O_APPEND, S_IRWXU)
    println("文件描述符: ${fd}")
    close(fd)

    // 通过 dup 复制的文件描述符写入数据
    var writeFd = `open`("testfile.txt", O_RDWR)
    var dupFd = dup(writeFd)
    var writeBuffer = unsafe { LibC.mallocCString("123456") }
    var writtenBytes = unsafe { write(dupFd, writeBuffer.getChars(), UIntNative(writeBuffer.size())) }
    unsafe { LibC.free(writeBuffer) }
    println("写入的字节数: ${writtenBytes}")
    close(writeFd)

    // 通过 lseek 将偏移量移到文件尾，获取文件大小
    var readFd = `open`("testfile.txt", O_RDWR)
    var fileSize = lseek(readFd, 0, SEEK_END)
    println("文件大小: ${fileSize}")

    // 将偏移量移回文件头，读取 2 个字节
    lseek(readFd, 0, SEEK_SET)
    var readBuffer = unsafe { LibC.mallocCString(" ") }
    var readBytes = unsafe { read(readFd, readBuffer.getChars(), 2) }
    unsafe { LibC.free(readBuffer) }
    println("读取的字节数: ${readBytes}")
    close(readFd)

    // 删除文件
    unlink("testfile.txt")
    return 0
}
```

可能出现的运行结果（文件描述符的值与系统有关）：

```text
文件描述符: 3
写入的字节数: 6
文件大小: 6
读取的字节数: 2
```
