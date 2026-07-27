# Directory 示例

## Directory 一些基础操作演示

示例：
<!-- verify -->
```cangjie
import std.fs.*

main() {
    let testDirPath: Path = Path("./testDir")
    let subDirPath: Path = Path("./testDir/subDir")

    // 清理上次运行可能残留的目录
    removeIfExists(testDirPath, recursive: true)

    // 递归创建目录 "./testDir/subDir"（不存在的父目录会一并创建）
    Directory.create(subDirPath, recursive: true)
    println("递归创建目录成功: ${subDirPath}")

    // 在 "./testDir" 下创建临时目录
    let tempDirPath: Path = Directory.createTemp(testDirPath)
    println("创建临时目录成功: 位于 ./testDir 下")

    // 将 "subDir" 移动到临时目录下并重命名为 "subDir_new"
    let newSubDirPath: Path = tempDirPath.join("subDir_new")
    rename(subDirPath, to: newSubDirPath)
    println("移动并重命名成功: subDir -> subDir_new")

    // 将 "subDir_new" 拷贝到 "./testDir" 下并命名为 "subDir"
    copy(newSubDirPath, to: subDirPath, overwrite: false)
    println("拷贝成功: ${subDirPath}")

    // 清理本次运行创建的目录
    removeIfExists(testDirPath, recursive: true)
    return 0
}
```

运行结果：

```text
递归创建目录成功: ./testDir/subDir
创建临时目录成功: 位于 ./testDir 下
移动并重命名成功: subDir -> subDir_new
拷贝成功: ./testDir/subDir
```
