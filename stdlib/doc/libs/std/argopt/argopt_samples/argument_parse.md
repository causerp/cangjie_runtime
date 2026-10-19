# 命令行参数解析

## 不带回调

示例：

<!-- run -->
```cangjie
import std.argopt.*

main(args: Array<String>): Unit {
    // 定义命令行参数规格
    let argSpecList = [
        Short(r'a', NoValue), // 短选项 -a，无参数值
        Long("test1", RequiredValue), // 长选项 --test1，必须有参数值
        Full("test2", r'c', OptionalValue) // 完整选项 --test2 或 -c，参数值可选
    ]

    try {
        // 解析命令行参数
        var parseResult = parseArguments(args, argSpecList)

        // 输出解析结果
        println("Got a: ${parseResult.options.contains('a')}")
        println("Test1: ${parseResult.options.get("test1")}")
        println("Test2: ${parseResult.options.get("test2")}")
        println("c: ${parseResult.options.get('c')}")
        println("NonOptions: ${parseResult.nonOptions}")
    } catch (e: ArgumentParseException) {
        println("Usage: error")
        return
    }
}
```

运行结果：

```bash
$ cjc main.cj && ./main -a --test1 t1val
Got a: true
Test1: Some(t1val)
Test2: None
c: None
NonOptions: []

$ cjc main.cj && ./main -a --test1
Usage: error

$ cjc main.cj && ./main -a --test1 t1val --test2
Got a: true
Test1: Some(t1val)
Test2: Some()
c: None
NonOptions: []

$ cjc main.cj && ./main -a --test1 t1val --test2 t2val
Got a: true
Test1: Some(t1val)
Test2: Some()
c: None
NonOptions: [t2val]

$ cjc main.cj && ./main -a --test1 t1val -ct2val
Got a: true
Test1: Some(t1val)
Test2: None
c: Some(t2val)
NonOptions: []
```

## 带回调

示例：

<!-- run -->
```cangjie
import std.argopt.*

main(args: Array<String>): Unit {
    // 定义参数规格及回调函数
    let argSpecList = [
        Short(r'a', NoValue) {_ => println("Got a")}, // -a 选项回调
        Long("test1", RequiredValue) {v => println("Got test1: `${v}`")}, // --test1 选项回调
        Full("test2", r'c', OptionalValue) {v => println("Got test2: `${v}`")}, // --test2 或 -c 选项回调
        NonOptions {v => println("Got NonOptions: ${v}")} // 非选项参数回调
    ]

    try {
        // 解析参数并执行回调
        parseArguments(args, argSpecList)
    } catch (e: ArgumentParseException) {
        println("Usage: xxxx")
    }
}
```

运行结果：

```bash
$ cjc main.cj && ./main -a --test1 t1val --test2 t2val
Got a
Got test1: `t1val`
Got test2: ``
Got NonOptions: [t2val]
```
