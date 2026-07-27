# 高位截断策略的示例

下面是高位截断策略的示例，示例中尝试运算 UInt8.Max + 1，UInt8.Max 二进制表示为 0b11111111，UInt8.Max + 1 为 0b100000000，由于 UInt8 只能储存 8 位，高位截断后结果为 0。

<!-- verify -->
```cangjie
import std.overflow.*

main() {
    // 尝试计算 UInt8.Max + 1，发生上溢时高位截断
    let value: UInt8 = UInt8.Max
    println("wrappingAdd 计算结果: ${value.wrappingAdd(1)}")
}
```

运行结果：

```text
wrappingAdd 计算结果: 0
```
