# env 示例

## 当前进程相关操作

示例：

<!-- compile -->
```cangjie
import std.env.*

main(): Int64 {
    // 获取当前进程相关信息
    println("进程 ID: ${getProcessId()}")
    println("执行命令名: ${getCommand()}")
    println("完整命令行: ${getCommandLine()}")
    println("工作目录: ${getWorkingDirectory()}")

    // 注册进程退出时执行的回调函数
    atExit(printExitMessage)

    // 退出当前进程，退出前会执行已注册的回调
    exit(0)
    return 0
}

func printExitMessage(): Unit {
    println("进程即将退出，hello cangjie!")
}
```

运行结果可能如下（输出结果中 main 为当前进程执行命令名，回调执行完成后当前进程会退出）：

```text
进程 ID: 28481
执行命令名: main
完整命令行: [./main]
工作目录: /root/code/workplace/cangjie
进程即将退出，hello cangjie!
```

## Console 示例

下面是 Console 示例，示例中接收用户输入的两条信息，并将这些信息通过标准输出原样返回给用户。

<!-- compile -->
```cangjie
import std.env.*

main() {
    // 读取并输出第一条信息
    getStdOut().write("请输入信息1：")
    var inputResult = getStdIn().readln() // 输入：你好，请问今天星期几？
    var inputText = inputResult.getOrThrow()
    getStdOut().writeln("输入的信息1为：" + inputText)

    // 读取并输出第二条信息
    getStdOut().write("请输入信息2：")
    inputResult = getStdIn().readln() // 输入：你好，请问今天几号？
    inputText = inputResult.getOrThrow()
    getStdOut().writeln("输入的信息2为：" + inputText)

    return
}
```

运行结果：

```text
请输入信息1：你好，请问今天星期几？
输入的信息1为：你好，请问今天星期几？
请输入信息2：你好，请问今天几号？
输入的信息2为：你好，请问今天几号？
```
