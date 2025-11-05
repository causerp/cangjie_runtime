# 异常

## class ContentFormatException

```cangjie
public class ContentFormatException <: Exception {
    public init()
    public init(message: String)
}
```

功能：提供字符格式相关的异常处理。

父类型：

- [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception)

### init()

```cangjie
public init()
```

功能：创建 [ContentFormatException](io_package_exceptions.md#class-contentformatexception) 实例。

示例：

<!-- verify -->
```cangjie
import std.io.*

main(): Unit {
    try {
        throw ContentFormatException()
    } catch (e: ContentFormatException) {
        println("捕获异常: ${e.message}")
    }
}
```

运行结果：

```text
捕获异常:
```

### init(String)

```cangjie
public init(message: String)
```

功能：根据异常信息创建 [ContentFormatException](io_package_exceptions.md#class-contentformatexception) 实例。

参数：

- message: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 异常提示信息。

示例：

<!-- verify -->
```cangjie
import std.io.*

main(): Unit {
    try {
        throw ContentFormatException("数据格式不正确")
    } catch (e: ContentFormatException) {
        println("捕获异常: ${e.message}")
    }
}
```

运行结果：

```text
捕获异常: 数据格式不正确
```

## class IOException

```cangjie
public open class IOException <: Exception {
    public init()
    public init(message: String)
}
```

功能：提供 IO 流相关的异常处理。

父类型：

- [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception)

### init()

```cangjie
public init()
```

功能：创建 [IOException](io_package_exceptions.md#class-ioexception) 实例。

示例：

<!-- verify -->
```cangjie
import std.io.*

main(): Unit {
    try {
        throw IOException()
    } catch (e: IOException) {
        println("捕获异常: ${e.message}")
    }
}
```

运行结果：

```text
捕获异常:
```

### init(String)

```cangjie
public init(message: String)
```

功能：根据异常信息创建 [IOException](io_package_exceptions.md#class-ioexception) 实例。

参数：

- message: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 异常提示信息。

示例：

<!-- verify -->
```cangjie
import std.io.*

main(): Unit {
    try {
        throw IOException("文件读取失败")
    } catch (e: IOException) {
        println("捕获异常: ${e.message}")
    }
}
```

运行结果：

```text
捕获异常: 文件读取失败
```

### func getClassName()

```cangjie
protected override open func getClassName(): String
```

功能：获得类名。

返回值：

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - 类名。

示例：

<!-- verify -->
```cangjie
import std.io.*

// 创建一个继承自IOException的类来访问受保护的getClassName方法
public class MyIOException <: IOException {
    public init() {
        super()
    }
    
    public init(message: String) {
        super(message)
    }
    
    // 公共方法来调用受保护的getClassName方法
    public func getClassNamePublic(): String {
        return getClassName()
    }
}

main() {
    let exception = MyIOException("测试异常")
    let className = exception.getClassNamePublic()
    println("类名: ${className}")
}
```

运行结果：

```text
类名: IOException
```
