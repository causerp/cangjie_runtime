# 文件信息相关操作

下面是文件信息相关操作示例，以下示例不支持 Windows 平台。

示例：

<!-- verify -->
```cangjie
import std.posix.*

main(): Int64 {
    // 判断 "/notdirs" 是否为目录（isType 需指定文件类型宏）
    var isDirResult1: Bool = isType("/notdirs", S_IFDIR)
    println("isType(\"/notdirs\", S_IFDIR): ${isDirResult1}")

    // 判断 "/dev" 是否为目录
    var isDirResult2: Bool = isDir("/dev")
    println("isDir(\"/dev\"): ${isDirResult2}")

    // 检查当前目录下 "oscfg.cfg" 是否存在（不存在返回 -1）
    var accessResult = access("./oscfg.cfg", F_OK)
    println("access(\"./oscfg.cfg\", F_OK): ${accessResult}")

    // 修改 "oscfg.cfg" 的权限为用户可执行（文件不存在返回 -1）
    var chmodResult = chmod("oscfg.cfg", UInt32(S_IXUSR))
    println("chmod(\"oscfg.cfg\", S_IXUSR): ${chmodResult}")
    return 0
}
```

运行结果：

```text
isType("/notdirs", S_IFDIR): false
isDir("/dev"): true
access("./oscfg.cfg", F_OK): -1
chmod("oscfg.cfg", S_IXUSR): -1
```
