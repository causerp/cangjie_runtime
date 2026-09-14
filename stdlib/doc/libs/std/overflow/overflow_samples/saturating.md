# 饱和策略的示例

下面是饱和策略的示例，示例中尝试运算 UInt16.Max 乘 16，运算结果超过 UInt16 的最大值，发生上溢，故返回 UInt16 的最大值。

<!-- verify -->
```cangjie
import std.overflow.*

main() {
    // 尝试计算 UInt16.Max 乘 16，发生上溢时饱和为 UInt16 的最大值
    let value: UInt16 = UInt16.Max
    println("saturatingMul 计算结果: ${value.saturatingMul(16)}")
}
```

运行结果：

```text
saturatingMul 计算结果: 65535
```
