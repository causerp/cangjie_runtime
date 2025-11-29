# 异常类

## class OvershiftException

```cangjie
public class OvershiftException <: Exception {
    public init()
    public init(message: String)
}
```

功能：移位运算中，当移位位数超过操作数位数时抛出的异常。

父类型：

- [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception)

### init()

```cangjie
public init()
```

功能：创建 [OvershiftException](overflow_package_exceptions.md#class-overshiftexception) 实例。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    try {
        // 抛出OvershiftException异常
        throw OvershiftException()
    } catch (e: OvershiftException) {
        println("Caught Exception: ${e}")
    }
    return 0
}
```

运行结果：

```text
Caught Exception: OvershiftException
```

### init(String)

```cangjie
public init(message: String)
```

功能：创建带有异常信息 message 的 [OvershiftException](overflow_package_exceptions.md#class-overshiftexception) 实例。

参数：

- message: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 异常信息。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    try {
        // 抛出带消息的OvershiftException异常
        throw OvershiftException("Shift count exceeds the number of bits in the operand")
    } catch (e: OvershiftException) {
        println("Caught OvershiftException: ${e}")
        println("Exception message: ${e.message}")
    }
    return 0
}
```

运行结果：

```text
Caught OvershiftException: OvershiftException: Shift count exceeds the number of bits in the operand
Exception message: Shift count exceeds the number of bits in the operand
```

## class UndershiftException

```cangjie
public class UndershiftException <: Exception {
    public init()
    public init(message: String)
}
```

功能：移位运算中，当移位位数小于 0 时抛出的异常。

父类型：

- [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception)

### init()

```cangjie
public init()
```

功能：创建 [UndershiftException](overflow_package_exceptions.md#class-undershiftexception) 实例。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    try {
        // 抛出UndershiftException异常
        throw UndershiftException()
    } catch (e: UndershiftException) {
        println("Caught UndershiftException: ${e}")
    }
    return 0
}
```

运行结果：

```text
Caught UndershiftException: UndershiftException
```

### init(String)

```cangjie
public init(message: String)
```

功能：创建带有异常信息 message 的 [UndershiftException](overflow_package_exceptions.md#class-undershiftexception) 实例。

参数：

- message: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 异常信息。

示例：

<!-- verify -->
```cangjie
import std.overflow.*

main(): Int64 {
    try {
        // 抛出带消息的UndershiftException异常
        throw UndershiftException("Shift count is negative")
    } catch (e: UndershiftException) {
        println("Caught UndershiftException: ${e}")
        println("Exception message: ${e.message}")
    }
    return 0
}
```

运行结果：

```text
Caught UndershiftException: UndershiftException: Shift count is negative
Exception message: Shift count is negative
```
