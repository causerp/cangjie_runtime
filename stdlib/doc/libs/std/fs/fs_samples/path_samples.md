# Path 示例

## 不同 Path 实例的属性信息展示

打印 Path 实例的目录部分、文件全名（有扩展名）、扩展名、文件名（无扩展名），并判断 Path 实例是绝对路径还是相对路径

示例：
<!-- verify -->
```cangjie
import std.fs.Path

main() {
    let pathList: Array<String> = [
        // 绝对路径
        "/a/b/c",
        "/a/b/",
        "/a/b/c.cj",
        "/a",
        "/",
        // 相对路径
        "./a/b/c",
        "./a/b/",
        "./a/b/c.cj",
        "./",
        ".",
        "123."
    ]

    for (i in 0..pathList.size) {
        let path: Path = Path(pathList[i])
        // 打印 path 的整个路径字符串
        println("Path${i}: ${path}")
        // 打印 path 的目录路径
        println("Path.parent: ${path.parent}")
        // 打印 path 的文件全名（有扩展名）
        println("Path.fileName: ${path.fileName}")
        // 打印 path 的扩展名
        println("Path.extensionName: ${path.extensionName}")
        // 打印 path 的文件名（无扩展名）
        println("Path.fileNameWithoutExtension: ${path.fileNameWithoutExtension}")
        // 打印 path 是否是绝对路径、相对路径
        println("Path.isAbsolute: ${path.isAbsolute()}; Path.isRelative: ${path.isRelative()}")
        println()
    }
    return 0
}
```

运行结果：

```text
Path0: /a/b/c
Path.parent: /a/b
Path.fileName: c
Path.extensionName: 
Path.fileNameWithoutExtension: c
Path.isAbsolute: true; Path.isRelative: false

Path1: /a/b/
Path.parent: /a
Path.fileName: b
Path.extensionName: 
Path.fileNameWithoutExtension: b
Path.isAbsolute: true; Path.isRelative: false

Path2: /a/b/c.cj
Path.parent: /a/b
Path.fileName: c.cj
Path.extensionName: cj
Path.fileNameWithoutExtension: c
Path.isAbsolute: true; Path.isRelative: false

Path3: /a
Path.parent: /
Path.fileName: a
Path.extensionName: 
Path.fileNameWithoutExtension: a
Path.isAbsolute: true; Path.isRelative: false

Path4: /
Path.parent: /
Path.fileName: 
Path.extensionName: 
Path.fileNameWithoutExtension: 
Path.isAbsolute: true; Path.isRelative: false

Path5: ./a/b/c
Path.parent: ./a/b
Path.fileName: c
Path.extensionName: 
Path.fileNameWithoutExtension: c
Path.isAbsolute: false; Path.isRelative: true

Path6: ./a/b/
Path.parent: ./a
Path.fileName: b
Path.extensionName: 
Path.fileNameWithoutExtension: b
Path.isAbsolute: false; Path.isRelative: true

Path7: ./a/b/c.cj
Path.parent: ./a/b
Path.fileName: c.cj
Path.extensionName: cj
Path.fileNameWithoutExtension: c
Path.isAbsolute: false; Path.isRelative: true

Path8: ./
Path.parent: 
Path.fileName: .
Path.extensionName: 
Path.fileNameWithoutExtension: 
Path.isAbsolute: false; Path.isRelative: true

Path9: .
Path.parent: 
Path.fileName: .
Path.extensionName: 
Path.fileNameWithoutExtension: 
Path.isAbsolute: false; Path.isRelative: true

Path10: 123.
Path.parent: 
Path.fileName: 123.
Path.extensionName: 
Path.fileNameWithoutExtension: 123
Path.isAbsolute: false; Path.isRelative: true
```

## Path 的拼接、判等、规范化处理等操作

示例：
<!-- verify -->
```cangjie
import std.fs.*

main() {
    let dirPath: Path = Path("./a/b/c")

    // 清理上次运行可能残留的目录
    removeIfExists(Path("./a"), recursive: true)
    Directory.create(dirPath, recursive: true)

    // 通过 join 拼接出文件路径 ./a/b/c/d.cj
    let filePath: Path = dirPath.join("d.cj")
    println("拼接结果: ${filePath}")
    if (!exists(filePath)) {
        File.create(filePath).close()
    }

    // 规范化处理冗余路径（多个 "."、".." 会被解析），结果与真实路径一致
    let canonicalizedFilePath: Path = canonicalize(Path("././././a/./../a/b/../../a/b/c/.././../../a/b/c/d.cj"))
    if (canonicalizedFilePath == canonicalize(filePath)) {
        println("规范化路径与真实路径一致")
    }

    // 清理本次运行创建的目录
    removeIfExists(Path("./a"), recursive: true)
    return 0
}
```

运行结果：

```text
拼接结果: ./a/b/c/d.cj
规范化路径与真实路径一致
```

## 通过 Path 创建文件与目录

示例：
<!-- verify -->
```cangjie
import std.fs.*

main() {
    let currentDirPath: Path = Path("./")
    let dirPath: Path = currentDirPath.join("tempDir")
    let filePath: Path = dirPath.join("tempFile.txt")

    // 清理上次运行可能残留的目录
    removeIfExists(dirPath, recursive: true)

    // 创建目录 tempDir
    Directory.create(dirPath)
    println("目录创建成功: ${dirPath}")

    // 在 tempDir 下创建文件 tempFile.txt
    File.create(filePath).close()
    println("文件创建成功: ${filePath}")

    // 清理本次运行创建的目录
    removeIfExists(dirPath, recursive: true)
    return 0
}
```

运行结果：

```text
目录创建成功: ./tempDir
文件创建成功: ./tempDir/tempFile.txt
```
