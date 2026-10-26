# 长命令行参数解析 <sup>(deprecated)</sup>

示例：

<!-- verify -->
```cangjie
import std.argopt.*

main() {
    // 模拟命令行参数（长参数格式）
    let simulatedArgs: Array<String> = ["--test1=abc", "--test2=123", "--test3 xyz"]

    // 定义短参数名称规范（此处为空，仅使用长参数）
    let shortParamSpec: String = ""

    // 定义长参数名称规范（等号表示需要参数值）
    let longParamSpec: Array<String> = ["--test1=", "test2=", "--test3="]

    // 创建参数解析器
    let argParser: ArgOpt = ArgOpt(simulatedArgs, shortParamSpec, longParamSpec)

    // 获取并输出各参数的值
    println(argParser.getArg("--test1") ?? "None")
    println(argParser.getArg("--test2") ?? "None")
    println(argParser.getArg("--test3") ?? "None")
}
```

运行结果：

```text
abc
123
None
```
