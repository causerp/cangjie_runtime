# 异常类

## class ASTException

```cangjie
public class ASTException <: Exception {
    public init()
    public init(message: String)
}
```

功能：ast 库的异常类，在 ast 库调用过程中发生异常时使用。

父类型：

- [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception)

### init()

```cangjie
public init()
```

功能：构造一个默认的 [ASTException](ast_package_exceptions.md#class-astexception) 对象。

示例：

<!-- verify -->
```cangjie
import std.ast.*

main(): Unit {
    // 在 try 块中抛出异常
    try {
        throw ASTException()
    } catch (e: ASTException) {
        // 捕获并输出异常
        println(e)
    }
}
```

运行结果：

```text
ASTException
```

### init(String)

```cangjie
public init(message: String)
```

功能：根据异常信息构造一个 [ASTException](ast_package_exceptions.md#class-astexception) 对象。

参数：

- message: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 异常信息。

示例：

<!-- verify -->
```cangjie
import std.ast.*

main(): Unit {
    // 在 try 块中抛出异常
    try {
        throw ASTException("Exception in try block")
    } catch (e: ASTException) {
        // 捕获并输出异常
        println(e)
    }
}
```

运行结果：

```text
ASTException: Exception in try block
```

## class MacroContextException

```cangjie
public class MacroContextException <: Exception {
    public init()
    public init(message: String)
}
```

功能：ast 库的上下文宏异常类，在上下文宏的相关接口中发生异常时使用。

父类型：

- [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception)

### init()

```cangjie
public init()
```

功能：构造一个默认的 [MacroContextException](ast_package_exceptions.md#class-macrocontextexception) 对象。

示例：

<!-- compile.error -macro0-->
<!-- cfg="--compile-macro" -->
```cangjie
// 宏定义
macro package M

import std.ast.*
import std.collection.ArrayList

public macro inner(input: Tokens) {
    // 向外层宏发送 Int64 类型消息
    setItem("Int64FromInner", 100)
    return input
}

public macro outer(input: Tokens) {
    // 获取名为 inner 的内层宏所发送的全部消息
    let messages = getChildMessages("inner")

    // 判断内层宏是否发送了对应的消息
    let result = messages[0].hasItem("OtherMessage")
    if (!result) {
        throw MacroContextException()
    }
    return input
}
```

<!-- compile.error -macro0-->
<!-- cfg="--debug-macro" -->
```cangjie
// 宏调用
import M.*

// 展开时报错
@outer(@inner(var a = 1))

main() {
}
```

### init(String)

```cangjie
public init(message: String)
```

功能：根据异常信息构造一个 [MacroContextException](ast_package_exceptions.md#class-macrocontextexception) 对象。

参数：

- message: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 异常信息。

示例：

<!-- compile.error -macro1-->
<!-- cfg="--compile-macro" -->
```cangjie
// 宏定义
macro package M

import std.ast.*
import std.collection.ArrayList

public macro inner(input: Tokens) {
    // 向外层宏发送 Int64 类型消息
    setItem("Int64FromInner", 100)
    return input
}

public macro outer(input: Tokens) {
    // 获取名为 inner 的内层宏所发送的全部消息
    let messages = getChildMessages("inner")

    // 判断内层宏是否发送了对应的消息
    let result = messages[0].hasItem("OtherMessage")
    if (!result) {
        throw MacroContextException("No such item")
    }
    return input
}
```

<!-- compile.error -macro1-->
<!-- cfg="--debug-macro" -->
```cangjie
// 宏调用
import M.*

// 展开时报错
@outer(@inner(var a = 1))

main() {
}
```

## class ParseASTException

```cangjie
public class ParseASTException <: Exception {
    public init()
    public init(message: String)
}
```

功能：ast 库的解析异常类，在节点解析过程中发生异常时使用。

父类型：

- [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception)

### init()

```cangjie
public init()
```

功能：构造一个默认的 [ParseASTException](ast_package_exceptions.md#class-parseastexception) 对象。

示例：

<!-- verify -->
```cangjie
import std.ast.*

main(): Unit {
    // 在 try 块中抛出异常
    try {
        throw ParseASTException()
    } catch (e: ParseASTException) {
        // 捕获并输出异常
        println(e)
    }
}
```

运行结果：

```text
ParseASTException
```

### init(String)

```cangjie
public init(message: String)
```

功能：根据异常信息构造一个 [ParseASTException](ast_package_exceptions.md#class-parseastexception) 对象。

参数：

- message: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 异常信息。

示例：

<!-- verify -->
```cangjie
import std.ast.*

main(): Unit {
    // 在 try 块中抛出异常
    try {
        throw ParseASTException("Exception in try block")
    } catch (e: ParseASTException) {
        // 捕获并输出异常
        println(e)
    }
}
```

运行结果：

```text
ParseASTException: Exception in try block
```
