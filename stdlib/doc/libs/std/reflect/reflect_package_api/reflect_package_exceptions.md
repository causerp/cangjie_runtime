# 异常类

## class IllegalSetException

```cangjie
public class IllegalSetException <: ReflectException {
    public init()
    public init(message: String)
}
```

功能：[IllegalSetException](reflect_package_exceptions.md#class-illegalsetexception) 为对不可变类型进行更改异常。

> **注意：**
>
> 不支持平台：macOS、iOS。

父类型：

- [ReflectException](#class-reflectexception)

### init()

```cangjie
public init()
```

功能：创建 [IllegalSetException](reflect_package_exceptions.md#class-illegalsetexception) 实例。

> **注意：**
>
> 不支持平台：macOS、iOS。

示例：

<!-- run -->
```cangjie
import std.reflect.IllegalSetException

main(): Int64 {
    // 创建 IllegalSetException 实例
    let exception = IllegalSetException()
    return 0
}
```

### init(String)

```cangjie
public init(message: String)
```

功能：根据异常信息创建 [IllegalSetException](reflect_package_exceptions.md#class-illegalsetexception) 实例。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- message: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 异常信息。

示例：

<!-- run -->
```cangjie
import std.reflect.IllegalSetException

main(): Int64 {
    // 根据异常信息创建 IllegalSetException 实例
    let exception = IllegalSetException("更改异常")
    return 0
}
```

## class IllegalTypeException

```cangjie
public class IllegalTypeException <: ReflectException {
    public init()
    public init(message: String)
}
```

功能：[IllegalTypeException](reflect_package_exceptions.md#class-illegaltypeexception) 为类型不匹配异常。

> **注意：**
>
> 不支持平台：macOS、iOS。

父类型：

- [ReflectException](#class-reflectexception)

### init()

```cangjie
public init()
```

功能：创建 [IllegalTypeException](reflect_package_exceptions.md#class-illegaltypeexception) 实例。

> **注意：**
>
> 不支持平台：macOS、iOS。

示例：

<!-- run -->
```cangjie
import std.reflect.IllegalTypeException

main(): Int64 {
    // 创建 IllegalTypeException 实例
    let exception = IllegalTypeException()
    return 0
}
```

### init(String)

```cangjie
public init(message: String)
```

功能：根据异常信息创建 [IllegalTypeException](reflect_package_exceptions.md#class-illegaltypeexception) 实例。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- message: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 异常信息。

示例：

<!-- run -->
```cangjie
import std.reflect.IllegalTypeException

main(): Int64 {
    // 根据异常信息创建 IllegalTypeException 实例
    let exception = IllegalTypeException("类型不匹配")
    return 0
}
```

## class InfoNotFoundException

```cangjie
public class InfoNotFoundException <: ReflectException {
    public init()
    public init(message: String)
}
```

功能：[InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) 为无法找到对应信息异常。

> **注意：**
>
> 不支持平台：macOS、iOS。

父类型：

- [ReflectException](#class-reflectexception)

### init()

```cangjie
public init()
```

功能：创建 [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) 实例。

> **注意：**
>
> 不支持平台：macOS、iOS。

示例：

<!-- run -->
```cangjie
import std.reflect.InfoNotFoundException

main(): Int64 {
    // 创建 InfoNotFoundException 实例
    let exception = InfoNotFoundException()
    return 0
}
```

### init(String)

```cangjie
public init(message: String)
```

功能：根据异常信息创建 [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) 实例。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- message: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 异常信息。

示例：

<!-- run -->
```cangjie
import std.reflect.InfoNotFoundException

main(): Int64 {
    // 根据异常信息创建 InfoNotFoundException 实例
    let exception = InfoNotFoundException("未找到相关信息")
    return 0
}
```

## class InvocationTargetException

```cangjie
public class InvocationTargetException <: ReflectException {
    public init()
    public init(message: String)
}
```

功能：[InvocationTargetException](reflect_package_exceptions.md#class-invocationtargetexception) 为调用函数包装异常。

> **注意：**
>
> 不支持平台：macOS、iOS。

父类型：

- [ReflectException](#class-reflectexception)

### init()

```cangjie
public init()
```

功能：创建 [InvocationTargetException](reflect_package_exceptions.md#class-invocationtargetexception) 实例。

> **注意：**
>
> 不支持平台：macOS、iOS。

示例：

<!-- run -->
```cangjie
import std.reflect.InvocationTargetException

main(): Int64 {
    // 创建 InvocationTargetException 实例
    let exception = InvocationTargetException()
    return 0
}
```

### init(String)

```cangjie
public init(message: String)
```

功能：根据异常信息创建 [InvocationTargetException](reflect_package_exceptions.md#class-invocationtargetexception) 实例。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- message: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 异常信息。

示例：

<!-- run -->
```cangjie
import std.reflect.InvocationTargetException

main(): Int64 {
    // 根据异常信息创建 InvocationTargetException 实例
    let exception = InvocationTargetException("调用目标异常")
    return 0
}
```

## class MisMatchException

```cangjie
public class MisMatchException <: ReflectException {
    public init()
    public init(message: String)
}
```

功能：[MisMatchException](reflect_package_exceptions.md#class-mismatchexception) 为调用对应函数抛出异常。

> **注意：**
>
> 不支持平台：macOS、iOS。

父类型：

- [ReflectException](#class-reflectexception)

### init()

```cangjie
public init()
```

功能：创建 [MisMatchException](reflect_package_exceptions.md#class-mismatchexception) 实例。

> **注意：**
>
> 不支持平台：macOS、iOS。

示例：

<!-- run -->
```cangjie
import std.reflect.MisMatchException

main(): Int64 {
    // 创建 MisMatchException 实例
    let exception = MisMatchException()
    return 0
}
```

### init(String)

```cangjie
public init(message: String)
```

功能：根据异常信息创建 [MisMatchException](reflect_package_exceptions.md#class-mismatchexception) 实例。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- message: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 异常信息。

示例：

<!-- run -->
```cangjie
import std.reflect.MisMatchException

main(): Int64 {
    // 根据异常信息创建 MisMatchException 实例
    let exception = MisMatchException("函数调用不匹配")
    return 0
}
```

## class ReflectException

```cangjie
public open class ReflectException <: Exception {
    public init()
    public init(message: String)
}
```

功能：[ReflectException](reflect_package_exceptions.md#class-reflectexception) 为 Reflect 包的基异常类。

> **注意：**
>
> 不支持平台：macOS、iOS。

父类型：

- [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception)

### init()

```cangjie
public init()
```

功能：创建 [ReflectException](reflect_package_exceptions.md#class-reflectexception) 实例。

> **注意：**
>
> 不支持平台：macOS、iOS。

示例：

<!-- run -->
```cangjie
import std.reflect.ReflectException

main(): Int64 {
    // 创建 ReflectException 实例
    let exception = ReflectException()
    return 0
}
```

### init(String)

```cangjie
public init(message: String)
```

功能：根据异常信息创建 [ReflectException](reflect_package_exceptions.md#class-reflectexception) 实例。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- message: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 异常信息。

示例：

<!-- run -->
```cangjie
import std.reflect.ReflectException

main(): Int64 {
    // 根据异常信息创建 ReflectException 实例
    let exception = ReflectException("反射操作异常")
    return 0
}
```

### func getClassName()

```cangjie
protected override open func getClassName(): String
```

功能：获得类名。

> **注意：**
>
> 不支持平台：macOS、iOS。

返回值：

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - 类名字符串。

示例：

<!-- verify -->
```cangjie
import std.reflect.ReflectException

class MyReflectException <: ReflectException {
    public init() {
        super()
    }
    
    public func getClassNameWrapper(): String {
        // 调用受保护的 getClassName 方法
        return this.getClassName()
    }
}

main(): Int64 {
    // 创建自定义异常实例
    let myException = MyReflectException()
    
    // 通过包装函数获得类名
    let className = myException.getClassNameWrapper()
    println("类名: ${className}")
    
    return 0
}
```

运行结果：

```text
类名: ReflectException
```
