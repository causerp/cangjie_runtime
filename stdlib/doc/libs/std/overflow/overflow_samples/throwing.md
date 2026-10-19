# 抛出异常策略的示例

下面是抛出异常策略的示例，示例中尝试运算 Int64.Max + 1，发生溢出，抛出 OverflowException。

<!-- run.error -->
```cangjie
import std.overflow.*

main() {
    // 尝试计算 Int64.Max + 1，发生溢出时抛出 OverflowException
    let value: Int64 = Int64.Max
    println(value.throwingAdd(1))
}
```

运行结果：

```text
An exception has occurred:
OverflowException: add
```
