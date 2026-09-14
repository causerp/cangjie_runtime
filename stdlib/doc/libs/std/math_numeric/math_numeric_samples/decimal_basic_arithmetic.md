# Decimal 基础数学运算示例

以下为通过不同构造函数初始化 `Decimal` 对象，并进行基础数学运算的示例：
<!-- verify -->
```cangjie
import std.math.*
import std.math.numeric.*

main() {
    // 通过字符串解析构造 Decimal 对象
    let decimal1: Decimal = Decimal.parse("12345.6789")

    // 通过无标度值和标度构造 Decimal 对象，表示 987654321 * 10^-6 = 987.654321
    let decimal2: Decimal = Decimal(BigInt.parse("987654321"), 6)

    // 四则运算
    println("${decimal1} + ${decimal2} = ${decimal1 + decimal2}")
    println("${decimal1} - ${decimal2} = ${decimal1 - decimal2}")
    println("${decimal1} * ${decimal2} = ${decimal1 * decimal2}")
    println("${decimal1} / ${decimal2} = ${decimal1 / decimal2}")

    // 指定精度 10 和舍入模式 HalfEven 的除法
    println(
        "${decimal1} / ${decimal2} with precision 10 and rounding mode HalfEven = ${decimal1.divWithPrecision(decimal2, 10, roundingMode: HalfEven)}")

    // 同时获取商和余数
    let (quotient, remainder) = decimal1.divAndMod(decimal2)
    println("${decimal1} divAndMod ${decimal2}: 商 = ${quotient}, 余数 = ${remainder}")
    return 0
}
```

运行结果：

```text
12345.6789 + 987.654321 = 13333.333221
12345.6789 - 987.654321 = 11358.024579
12345.6789 * 987.654321 = 12193263.1112635269
12345.6789 / 987.654321 = 12.49999988609375000142382812498220
12345.6789 / 987.654321 with precision 10 and rounding mode HalfEven = 12.49999989
12345.6789 divAndMod 987.654321: 商 = 12, 余数 = 493.827048
```
