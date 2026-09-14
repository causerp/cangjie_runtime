# 返回 `Option` 策略的示例

下面是返回 `Option` 策略的示例，示例中尝试运算 Int64.Max 的平方，发生溢出，返回 None。

<!-- verify -->
```cangjie
import std.overflow.*

main() {
    // 尝试计算 Int64.Max 的平方，发生溢出时返回 None
    let value: Int64 = Int64.Max
    println("checkedPow 计算结果: ${value.checkedPow(UInt64(2))}")
}
```

运行结果：

```text
checkedPow 计算结果: None
```
