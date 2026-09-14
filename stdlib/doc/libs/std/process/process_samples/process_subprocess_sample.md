# 子进程相关操作

下面是子进程相关操作示例，以下示例不支持 Windows 平台。

示例：

<!-- run -->
```cangjie
import std.process.*
import std.io.*
import std.fs.*

main(): Int64 {
    // 创建用于演示 workingDirectory 参数的目录
    let workDirPath: Path = Path("./subprocess_workdir")
    removeIfExists(workDirPath, recursive: true)
    Directory.create(workDirPath)

    // 在指定工作目录中启动子进程
    let sleepProcess: SubProcess = launch("sleep", "10s", workingDirectory: workDirPath)
    println("进程 ID: ${sleepProcess.pid}")
    println("进程名: ${sleepProcess.name}")
    println("进程命令: ${sleepProcess.command}")

    // 强制终止子进程并等待其结束
    sleepProcess.terminate(force: true)
    let exitCode = sleepProcess.wait()
    println("sleepProcess 退出码: ${exitCode}")

    // 启动子进程执行 echo 命令，并通过管道读取其标准输出
    let echoProcess: SubProcess = launch("echo", "hello cangjie!", stdOut: ProcessRedirect.Pipe)
    let stdOutReader: StringReader<InputStream> = StringReader(echoProcess.stdOutPipe)
    println(stdOutReader.readToEnd())

    // 清理本次运行创建的目录
    removeIfExists(workDirPath, recursive: true)
    return 0
}
```

运行结果可能如下：

```text
进程 ID: 65953
进程名: sleep
进程命令: sleep
sleepProcess 退出码: 9
hello cangjie!
```
