# 异常

## class ProcessException

```cangjie
public class ProcessException <: IOException {
    public init(message: String)
}
```

功能：`process` 包的异常类。

父类型：

- [IOException](../../io/io_package_api/io_package_exceptions.md#class-ioexception)

### init(String)

```cangjie
public init(message: String)
```

功能：创建 [ProcessException](process_package_exceptions.md#class-processexception) 实例。

参数：

- message: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 异常提示信息。

示例：

<!-- verify -->
```cangjie
import std.process.*

main(): Int64 {
    try {
        throw ProcessException("Process failed to start")
    } catch (e: ProcessException) {
        println("Caught ProcessException: ${e.message}")
        println("Exception type: ${e}")
    }
    return 0
}
```

运行结果：

```text
Caught ProcessException: Process failed to start
Exception type: ProcessException: Process failed to start
```
