# 函数

## func atExit(() -> Unit)

```cangjie
public func atExit(callback: () -> Unit): Unit
```

功能：注册回调函数，当前进程退出时执行注册函数。

> **注意：**
>
> 请不要使用 C 语言 atexit 函数，避免出现非预期问题。

参数：

- callback: () ->[Unit](../../core/core_package_api/core_package_intrinsics.md#unit) - 需要被注册回调的函数。

示例：

<!-- verify -->
```cangjie
import std.env.*

var globalVar: Int64 = 0

func cleanup() {
    globalVar = 100
    println("Cleanup function called. GlobalVar is now: ${globalVar}")
}

main() {
    // 注册退出回调函数
    atExit(cleanup)

    println("Main function ending")
}
```

运行结果：

```text
Main function ending
Cleanup function called. GlobalVar is now: 100
```

## func exit(Int64)

```cangjie
public func exit(code: Int64): Nothing
```

功能：立即终止当前进程，并返回指定的退出状态码。

参数：

- code: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 当前进程退出状态码。

示例：

<!-- verify -->
```cangjie
import std.env.*

main() {
    println("Program started")

    // 正常退出程序，返回状态码0
    exit(0)

    // 这行代码不会被执行
    println("This line will not be printed")
}
```

运行结果：

```text
Program started
```

## func getCommand()

```cangjie
public func getCommand(): String
```

功能：获取进程命令。

返回值：

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - 当前进程命令。

异常：

- [EnvException](./env_package_exceptions.md#class-envexception) - 当进程不存在或对应进程为僵尸进程，无法获取进程名时，抛出异常。

示例：

<!-- run -->
```cangjie
import std.env.*

main() {
    // 获取当前进程命令
    let command = getCommand()

    println("Current process command: ${command}")
}
```

可能的运行结果：

```text
Current process command: ./getcommand_example
```

## func getCommandLine()

```cangjie
public func getCommandLine(): Array<String>
```

功能：获取当前进程命令行。对于 Windows 平台，只能获取当前进程的命令行，其他场景下无法在非特权 API 下获取到本属性。

> **注意：**
>
> 不支持平台：iOS。

返回值：

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[String](../../core/core_package_api/core_package_structs.md#struct-string)> - 当前进程命令行。

异常：

- [EnvException](./env_package_exceptions.md#class-envexception) - 当进程不存在、对应进程为僵尸进程或在其他不支持的场景下无法获取进程命令行时，抛出异常。

示例：

<!-- run -->
```cangjie
import std.env.*

main() {
    // 获取当前进程命令行
    let commandLine = getCommandLine()

    println("Command line arguments:")
    for (arg in commandLine) {
        println("  ${arg}")
    }
}
```

可能的运行结果：

```text
Command line arguments:
  ./getcommandline_example
  arg1
  arg2
```

## func getHomeDirectory()

```cangjie
public func getHomeDirectory(): Path
```

功能：获取当前进程 home 目录的路径。

返回值：

- [Path](../../fs/fs_package_api/fs_package_structs.md#struct-path) - 当前进程 home 目录的路径。

示例：

<!-- run -->
```cangjie
import std.env.*

main() {
    // 获取当前进程home目录的路径
    let homeDir = getHomeDirectory()

    println("Home directory: ${homeDir}")
}
```

可能的运行结果：

```text
Home directory: /home/user
```

## func getProcessId()

```cangjie
public func getProcessId(): Int64
```

功能：获取当前进程 id。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 当前进程 id。

示例：

<!-- run -->
```cangjie
import std.env.*

main() {
    // 获取当前进程ID
    let pid = getProcessId()

    println("Current process ID: ${pid}")
}
```

可能的运行结果：

```text
Current process ID: 3658549
```

## func getStdErr()

```cangjie
public func getStdErr(): ConsoleWriter
```

功能：获取当前进程标准错误流。

返回值：

- [ConsoleWriter](./env_package_classes.md#class-consolewriter) - 进程标准错误流。

示例：

<!-- run -->
```cangjie
import std.env.*

main() {
    // 获取标准错误流
    let stderr = getStdErr()

    // 向标准错误流写入信息
    stderr.write("This is an error message")
    stderr.writeln(" with a newline")
}
```

运行结果：

```text
This is an error message with a newline
```

## func getStdIn()

```cangjie
public func getStdIn(): ConsoleReader
```

功能：获取当前进程标准输入流。

返回值：

- [ConsoleReader](./env_package_classes.md#class-consolereader) - 进程标准输入流。

示例：

<!-- compile -->
```cangjie
import std.env.*

main() {
    // 获取标准输入流
    let stdin = getStdIn()

    // 获取标准输出流
    let stdout = getStdOut()

    stdout.write("Please enter your name: ")

    // 从标准输入流读取一行，需要手动输出名字，这里输入zhangsan
    let name = stdin.readln()

    match (name) {
        case Some(n) => stdout.writeln("Hello, ${n}!")
        case None => stdout.writeln("No input received.")
    }
}
```

运行结果：

```text
Please enter your name: zhangsan
Hello, zhangsan!
```

## func getStdOut()

```cangjie
public func getStdOut(): ConsoleWriter
```

功能：获取当前进程标准输出流。

返回值：

- [ConsoleWriter](./env_package_classes.md#class-consolewriter) - 进程标准输出流。

示例：

<!-- verify -->
```cangjie
import std.env.*

main() {
    // 获取标准输出流
    let stdout = getStdOut()

    // 向标准输出流写入信息
    stdout.write("Hello, ")
    stdout.writeln("World!")
}
```

运行结果：

```text
Hello, World!
```

## func getTempDirectory()

```cangjie
public func getTempDirectory(): Path
```

功能：获取当前进程临时目录的路径。从环境变量中获取 TMPDIR、TMP、TEMP 和 TEMPDIR 环境变量。如果以上值在环境变量中均不存在，则默认返回 /tmp 目录。

返回值：

- [Path](../../fs/fs_package_api/fs_package_structs.md#struct-path) - 当前进程临时目录的路径。

示例：

<!-- run -->
```cangjie
import std.env.*

main() {
    // 获取当前进程临时目录的路径
    let tempDir = getTempDirectory()

    println("Temporary directory: ${tempDir}")
}
```

可能的运行结果：

```text
Temporary directory: /tmp
```

## func getVariable(String)

```cangjie
public func getVariable(key: String): ?String
```

功能：获取当前进程指定名称的环境变量值。

参数：

- key: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 指定名称。

返回值：

- ?[String](../../core/core_package_api/core_package_structs.md#struct-string) - 当前进程指定名称的环境变量值。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 当函数参数 key 包含空字符时，抛出异常。

示例：

<!-- run -->
```cangjie
import std.env.*

main() {
    // 获取PATH环境变量的值
    let path = getVariable("PATH")

    match (path) {
        case Some(p) => println("PATH environment variable: ${p}")
        case None => println("PATH environment variable not found")
    }

    // 尝试获取一个不存在的环境变量
    let nonexistent = getVariable("NONEXISTENT_VAR")

    match (nonexistent) {
        case Some(value) => println("NONEXISTENT_VAR: ${value}")
        case None => println("NONEXISTENT_VAR not found")
    }
}
```

可能的运行结果：

```text
PATH environment variable: /home/user/cangjie/bin:/home/user/cangjie/tools/bin:...
NONEXISTENT_VAR not found
```

## func getVariables()

```cangjie
public func getVariables(): Array<(String, String)>
```

功能：获取当前进程环境变量。对于 Windows 平台，只能获取当前进程的环境变量，其他场景下无法在非特权 API 下获取到本属性。

> **注意：**
>
> 不支持平台：iOS。

返回值：

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<([String](../../core/core_package_api/core_package_structs.md#struct-string), [String](../../core/core_package_api/core_package_structs.md#struct-string))> - 当前进程环境变量。

异常：

- [EnvException](./env_package_exceptions.md#class-envexception) - 当进程不存在、对应进程为僵尸进程或在其他不支持的场景下无法获取进程环境变量时，抛出异常。

示例：

<!-- run -->
```cangjie
import std.env.*

main() {
    // 获取当前进程的所有环境变量
    let variables = getVariables()

    println("Environment variables:")
    for ((key, value) in variables) {
        // 只打印前几个环境变量以避免输出过长
        if (key == "PATH" || key == "HOME" || key == "USER") {
            println("  ${key}: ${value}")
        }
    }

    println("Total number of environment variables: ${variables.size}")
}
```

可能的运行结果：

```text
Environment variables:
  HOME: /home/user
  USER: user
  PATH: /home/user/cangjie/bin:/home/user/cangjie/tools/bin:...
Total number of environment variables: 37
```

## func getWorkingDirectory()

```cangjie
public func getWorkingDirectory(): Path
```

功能：获取当前进程工作路径。对于 Windows 平台，只能获取当前进程的工作路径，其他场景下无法在非特权 API 下获取到本属性。

返回值：

- [Path](../../fs/fs_package_api/fs_package_structs.md#struct-path) - 当前进程工作路径。

异常：

- [EnvException](./env_package_exceptions.md#class-envexception) - 当进程不存在、对应进程为僵尸进程或在其他不支持的场景下无法获取进程工作路径时，抛出异常。

示例：

<!-- run -->
```cangjie
import std.env.*

main() {
    // 获取当前进程工作路径
    let workingDir = getWorkingDirectory()

    println("Working directory: ${workingDir}")
}
```

可能的运行结果：

```text
Working directory: /home/user/...
```

## func removeVariable(String)

```cangjie
public func removeVariable(key: String): Unit
```

功能：通过指定环境变量名称移除环境变量。

参数：

- key: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 环境变量名称。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 当函数参数 key 包含空字符时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.env.*

main() {
    // 先设置一个环境变量
    setVariable("TEST_VAR", "test_value")

    // 验证环境变量已设置
    let value = getVariable("TEST_VAR")
    match (value) {
        case Some(v) => println("Before removal - TEST_VAR: ${v}")
        case None => println("Before removal - TEST_VAR not found")
    }

    // 移除环境变量
    removeVariable("TEST_VAR")

    // 验证环境变量已移除
    let valueAfter = getVariable("TEST_VAR")
    match (valueAfter) {
        case Some(v) => println("After removal - TEST_VAR: ${v}")
        case None => println("After removal - TEST_VAR not found")
    }
}
```

运行结果：

```text
Before removal - TEST_VAR: test_value
After removal - TEST_VAR not found
```

## func setVariable(String, String)

```cangjie
public func setVariable(key: String, value: String): Unit
```

功能：用于设置一对环境变量。如果设置了同名环境变量，原始环境变量值将被覆盖。

> **说明：**
>
> Windows 下如果传入的参数 v 是空字符串，那么会从环境中移除变量 k。

参数：

- key: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 环境变量名称。
- value: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 环境变量值。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 当函数参数 key 或 value 中包含空字符时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.env.*

main() {
    // 设置一个环境变量
    setVariable("MY_VAR", "my_value")

    // 验证环境变量已设置
    let value = getVariable("MY_VAR")
    match (value) {
        case Some(v) => println("MY_VAR: ${v}")
        case None => println("MY_VAR not found")
    }

    // 修改环境变量的值
    setVariable("MY_VAR", "new_value")

    // 验证环境变量已更新
    let newValue = getVariable("MY_VAR")
    match (newValue) {
        case Some(v) => println("MY_VAR after update: ${v}")
        case None => println("MY_VAR not found")
    }
}
```

运行结果：

```text
MY_VAR: my_value
MY_VAR after update: new_value
```
