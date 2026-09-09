# 函数

## func parseParameterTypes(String)

```cangjie
public func parseParameterTypes(parameters: String): Array<TypeInfo>
```

功能：从字符串中解析出参数类型，并将其转换为类型数组，以便`getStaticFunction`等函数使用。

函数参数类型限定名称为函数类型的参数类型部分，不包含参数名、默认值，也不包含最外层的 `()`。
因此对于下面的一个仓颉函数：

```cangjie
import m1.p1.T1
func f(a: Int64, b: T1, c!: Int64 = 0, d!: Int64 = 0): Int64 { ... }
```

其限定名称应该为`"Int64, p1.T1, Int64, Int64"`。对于无参函数的限定名称应该为 `""`。

> **注意：**
>
> 不支持平台：macOS、iOS。

参数：

- parameters: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 函数参数类型限定名称。

返回值：

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[TypeInfo](reflect_package_classes.md#class-typeinfo)> - 字符串对应的参数类型信息。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 当字符串中括号不匹配（如出现多余的反括号）或逗号分隔出空的类型名时，抛出异常。
- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - 如果无法获得字符串中的类型信息（包括类型名不符合规范的情形），则会抛出异常。

示例：

<!-- verify -->
```cangjie
import std.reflect.*

class A {}

main(): Unit {
    let types = parseParameterTypes("Int64, String, default.A")
    for (t in types) {
        println(t)
    }
}
```

运行结果：

```text
Int64
String
default.A
```
