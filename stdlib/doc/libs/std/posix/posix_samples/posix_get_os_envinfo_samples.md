# 获取各类系统信息

下面是获取各类系统信息示例，以下示例不支持 Windows 平台。

示例：

<!-- run -->
```cangjie
import std.posix.*

main(): Int64 {
    // 获取系统信息、主机名、登录用户名
    var osInfo = getos()
    println("系统信息: ${osInfo}")
    var hostname = gethostname()
    println("主机名: ${hostname}")
    var logname: String = getlogin()
    println("登录用户名: ${logname}")

    // 切换工作目录并获取当前工作目录
    var chdirResult = chdir("/")
    println("切换目录返回值: ${chdirResult}")
    var cwdPath: String = getcwd()
    println("当前工作目录: ${cwdPath}")

    // 先传入 0 获取进程所属组数量
    var groupCount = unsafe { getgroups(0, CPointer<UInt32>()) }
    println("组数量: ${groupCount}")

    // 分配 256 字节缓冲区（可容纳 64 个组 ID），获取组 ID 列表
    var groupBuffer = unsafe { LibC.mallocCString("0123456789abcdef" * 16) }
    var groupIds = CPointer<UInt32>(groupBuffer.getChars())
    unsafe { getgroups(groupCount, groupIds) }
    for (i in 0..groupCount) {
        var groupId = unsafe { groupIds.read(Int64(i)) }
        println("组 ID: ${groupId}")
    }
    unsafe { LibC.free(groupBuffer) }
    return 0
}
```

运行结果如下（根据系统不同返回结果可能不同）：

```text
系统信息: Linux version 4.15.0-159-generic (buildd@lgw01-amd64-055) (gcc version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04)) #167-Ubuntu SMP Tue Sep 21 08:55:05 UTC 2021
主机名: e124e6e0fe0f
登录用户名: root
切换目录返回值: 0
当前工作目录: /
组数量: 1
组 ID: 0
```
