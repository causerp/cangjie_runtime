# 任意进程相关操作

下面是任意进程相关操作示例，以下示例不支持 Windows 平台。

示例：

<!-- run -->
```cangjie
import std.process.*

main(): Int64 {
    // 启动一个 sleep 子进程
    let sleepProcess: SubProcess = launch("sleep", "10s")

    // 通过进程 ID 查找该进程
    let foundProcess: Process = findProcess(sleepProcess.pid)
    println("进程 ID: ${foundProcess.pid}")
    println("进程名: ${foundProcess.name}")
    println("进程命令: ${foundProcess.command}")

    // 强制终止该进程
    foundProcess.terminate(force: true)
    return 0
}
```

运行结果可能如下：

```text
进程 ID: 70753
进程名: sleep
进程命令: sleep
```
