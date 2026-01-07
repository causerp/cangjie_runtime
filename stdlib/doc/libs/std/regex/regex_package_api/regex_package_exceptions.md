# 异常类

## class RegexException

```cangjie
public class RegexException <: Exception {
    public init()
    public init(message: String)
}
```

功能：提供正则的异常处理。

父类型：

- [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception)

### init()

```cangjie
public init()
```

功能：创建  [RegexException](regex_package_exceptions.md#class-regexexception) 实例。

示例：

<!-- verify -->
```cangjie
import std.regex.*

main(): Unit {
    // 抛出一个 RegexException 实例
    try {
        throw RegexException()
    } catch (e: RegexException) {
        println("捕获到异常: ${e}")
    }
}
```

运行结果：

```text
捕获到异常: RegexException
```

### init(String)

```cangjie
public init(message: String)
```

功能：根据异常信息创建 [RegexException](regex_package_exceptions.md#class-regexexception) 实例。

参数：

- message: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 异常提示信息。

示例：

<!-- verify -->
```cangjie
import std.regex.*

main(): Unit {
    // 抛出一个 RegexException 实例
    try {
        throw RegexException("正则表达式语法错误")
    } catch (e: RegexException) {
        println("捕获到异常: ${e}")
    }
}
```

运行结果：

```text
捕获到异常: RegexException: 正则表达式语法错误
```