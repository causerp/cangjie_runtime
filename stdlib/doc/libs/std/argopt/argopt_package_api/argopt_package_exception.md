# 异常类

## class ArgumentParseException

```cangjie
public class ArgumentParseException <: Exception {
    public init()
    public init(message: String)
}
```

功能：参数解析异常类。当参数解析出错（如：不识别的选项、缺少值的选项）时，抛出此异常。

父类型：

- [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception)

### init()

```cangjie
public init()
```

功能：构造一个不带异常信息的实例。

示例：

<!-- verify -->
```cangjie
import std.argopt.*

main(): Unit {
    // 使用无参构造函数创建异常实例
    let exception = ArgumentParseException()
    println("创建了无参的ArgumentParseException实例")

    // 可以抛出并捕获该异常
    try {
        throw ArgumentParseException()
    } catch (e: ArgumentParseException) {
        println("捕获到ArgumentParseException异常")
    }
}
```

可能的运行结果：

```text
创建了无参的ArgumentParseException实例
捕获到ArgumentParseException异常
```

### init(String)

```cangjie
public init(message: String)
```

功能：根据异常信息构造异常实例。

参数：

- message: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 异常信息。

示例：

<!-- verify -->
```cangjie
import std.argopt.*

main(): Unit {
    // 使用带消息的构造函数创建异常实例
    let message = "参数解析失败：未知选项 --xyz"
    let exception = ArgumentParseException(message)
    println("创建了带消息的ArgumentParseException实例: ${exception.message}")

    // 可以抛出并捕获该异常
    try {
        throw ArgumentParseException("无效的参数格式")
    } catch (e: ArgumentParseException) {
        println("捕获到异常: ${e.message}")
    }
}
```

可能的运行结果：

```text
创建了带消息的ArgumentParseException实例: 参数解析失败：未知选项 --xyz
捕获到异常: 无效的参数格式
```
