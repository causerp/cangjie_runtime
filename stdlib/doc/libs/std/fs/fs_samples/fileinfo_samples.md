# FileInfo 示例

## FileInfo 一些基础操作演示

示例：
<!-- verify -->
```cangjie
import std.fs.*
import std.time.*

main() {
    // 在当前目录下创建固定名称的文件，用于 FileInfo 的演示
    let filePath: Path = Path("./fileinfo_demo.txt")
    let file: File = File.create(filePath)
    file.write("123456789\n".toArray())

    // 获取该文件的 FileInfo
    let fileInfo: FileInfo = file.info
    file.close()

    // 获取文件路径，返回值为绝对路径，与实际环境有关
    let _: Path = fileInfo.path

    // 获取父级目录的 FileInfo，返回值为绝对路径，与实际环境有关
    let _: Option<FileInfo> = fileInfo.parentDirectory

    // 获取文件的创建时间、最后访问时间、最后修改时间，具体值随系统时间变化
    let _: DateTime = fileInfo.creationTime
    let _: DateTime = fileInfo.lastAccessTime
    let _: DateTime = fileInfo.lastModificationTime

    // 获取文件大小（字节数；如果 FileInfo 对应目录，则表示该目录下所有文件占用空间的大小，不包含子目录）
    println("文件大小: ${fileInfo.size}")

    // 判断文件是否是软链接、普通文件、目录
    println("是软链接: ${fileInfo.isSymbolicLink()}")
    println("是普通文件: ${fileInfo.isRegular()}")
    println("是目录: ${fileInfo.isDirectory()}")

    // 判断当前用户对该文件的权限
    println("只读: ${fileInfo.isReadOnly()}")
    println("隐藏: ${fileInfo.isHidden()}")
    println("可执行: ${fileInfo.canExecute()}")
    println("可读: ${fileInfo.canRead()}")
    println("可写: ${fileInfo.canWrite()}")

    // 修改当前用户对该文件的权限：设置为不可执行、可读、不可写
    fileInfo.setExecutable(false)
    fileInfo.setReadable(true)
    fileInfo.setWritable(false)
    println("修改权限后是否只读: ${fileInfo.isReadOnly()}")

    // 清理本次运行创建的文件
    removeIfExists(filePath)
    return 0
}
```

运行结果：

```text
文件大小: 10
是软链接: false
是普通文件: true
是目录: false
只读: false
隐藏: false
可执行: false
可读: true
可写: true
修改权限后是否只读: true
```
