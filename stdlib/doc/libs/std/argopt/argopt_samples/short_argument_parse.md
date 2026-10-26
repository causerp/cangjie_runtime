# 短命令行参数解析 <sup>(deprecated)</sup>

示例：

<!-- verify -->
```cangjie
import std.argopt.*

main() {
    // 模拟命令行参数
    let simulatedArgs: Array<String> = ["-a123", "-bofo", "-cccc"]

    // 定义短参数名称规范（冒号表示需要参数值）
    let shortParamSpec: String = "a:b:c"

    // 定义长参数名称规范（此处为空）
    let longParamSpec: Array<String> = Array<String>()

    // 创建参数解析器
    let argParser: ArgOpt = ArgOpt(simulatedArgs, shortParamSpec, longParamSpec)

    // 获取并输出各参数的值
    println(argParser.getArg("-a") ?? "None")
    println(argParser.getArg("-b") ?? "None")
    println(argParser.getArg("-c") ?? "None")
}
```

运行结果：

```text
123
ofo
None
```
