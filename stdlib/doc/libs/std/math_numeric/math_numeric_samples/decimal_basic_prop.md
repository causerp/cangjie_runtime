# Decimal 基本属性示例

以下为初始化 `Decimal` 对象，并查询对象的基本属性的示例：
<!-- verify -->
```cangjie
import std.math.*
import std.math.numeric.*

main() {
    let decimal = Decimal.parse("-123456.7890123456789")
    println("decimal 值: ${decimal}")
    println("符号: ${decimal.sign}")
    println("标度: ${decimal.scale}")
    println("无标度值: ${decimal.value}")
    println("精度: ${decimal.precision}")

    // 如果希望初始化一个带有指定精度和舍入方式的 Decimal 对象，可以采用如下方式
    let roundedDecimal = Decimal.parse("-123456.7890123456789").roundWithPrecision(10, roundingMode: HalfEven)
    println("指定精度后的值: ${roundedDecimal}")
    println("符号: ${roundedDecimal.sign}")
    println("标度: ${roundedDecimal.scale}")
    println("无标度值: ${roundedDecimal.value}")
    println("精度: ${roundedDecimal.precision}")

    return 0
}
```

运行结果：

```text
decimal 值: -123456.7890123456789
符号: -1
标度: 13
无标度值: -1234567890123456789
精度: 19
指定精度后的值: -123456.7890
符号: -1
标度: 4
无标度值: -1234567890
精度: 10
```
