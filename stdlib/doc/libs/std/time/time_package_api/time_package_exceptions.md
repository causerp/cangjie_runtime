# 异常类

## class InvalidDataException

```cangjie
public class InvalidDataException <: Exception {
    public init()
    public init(message: String)
}
```

功能：[InvalidDataException](time_package_exceptions.md#class-invaliddataexception) 表示加载时区时的异常。

父类型：

- [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception)

### init()

```cangjie
public init()
```

功能：构造一个 [InvalidDataException](time_package_exceptions.md#class-invaliddataexception) 实例。

示例：

<!-- verify -->
```cangjie
import std.time.*

main(): Unit {
    // 抛出一个 InvalidDataException 实例
    try {
        throw InvalidDataException()
    } catch (e: InvalidDataException) {
        println("捕获到异常: ${e}")
    }
}
```

运行结果：

```text
捕获到异常: InvalidDataException
```

### init(String)

```cangjie
public init(message: String)
```

功能：根据参数 `message` 指定的异常信息，构造一个 [InvalidDataException](time_package_exceptions.md#class-invaliddataexception) 实例。

参数：

- message: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 预定义消息。

示例：

<!-- verify -->
```cangjie
import std.time.*

main(): Unit {
    // 抛出一个带有消息的 InvalidDataException 实例
    try {
        throw InvalidDataException("时区数据无效")
    } catch (e: InvalidDataException) {
        println("捕获到异常: ${e}")
        println("异常消息: ${e.message}")
    }
}
```

运行结果：

```text
捕获到异常: InvalidDataException: 时区数据无效
异常消息: 时区数据无效
```

## class TimeParseException

```cangjie
public class TimeParseException <: Exception {
    public init()
    public init(message: String)
}
```

功能：[TimeParseException](time_package_exceptions.md#class-timeparseexception) 表示解析时间字符串时的异常。

父类型：

- [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception)

### init()

```cangjie
public init()
```

功能：构造一个 [TimeParseException](time_package_exceptions.md#class-timeparseexception) 实例。

示例：

<!-- verify -->
```cangjie
import std.time.*

main(): Unit {
    // 抛出一个 TimeParseException 实例
    try {
        throw TimeParseException()
    } catch (e: TimeParseException) {
        println("捕获到异常: ${e}")
    }
}
```

运行结果：

```text
捕获到异常: TimeParseException
```

### init(String)

```cangjie
public init(message: String)
```

功能：根据参数 `message` 指定的异常信息，构造一个 [TimeParseException](time_package_exceptions.md#class-timeparseexception) 实例。

参数：

- message: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 预定义消息。

示例：

<!-- verify -->
```cangjie
import std.time.*

main(): Unit {
    // 抛出一个带有消息的 TimeParseException 实例
    try {
        throw TimeParseException("时间解析失败")
    } catch (e: TimeParseException) {
        println("捕获到异常: ${e}")
        println("异常消息: ${e.message}")
    }
}
```

运行结果：

```text
捕获到异常: TimeParseException: 时间解析失败
异常消息: 时间解析失败
```
