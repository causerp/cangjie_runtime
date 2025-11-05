# 异常

## class EnvException

```cangjie
public class EnvException <: Exception {
    public init(message: String)
}
```

功能：`env` 包的异常类。

父类型：

- [Exception](../../../std/core/core_package_api/core_package_exceptions.md#class-exception)

### init(String)

```cangjie
public init(message: String)
```

功能：创建 [EnvException](../../process/process_package_api/process_package_exceptions.md#class-processexception) 实例。

参数：

- message: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 异常提示信息。

示例：

<!-- run -->
```cangjie
import std.env.*

main() {
    // 使用带消息的构造函数创建EnvException实例
    let exception = EnvException("自定义异常信息")
}
```