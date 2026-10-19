# BigInt 基础数学运算示例

以下为通过不同构造函数初始化 `BigInt` 对象，并进行基础数学运算的示例：
<!-- verify -->
```cangjie
import std.math.numeric.*

main() {
    // 通过字符串解析构造 BigInt 对象
    let bigInt1: BigInt = BigInt.parse("123456789")
    let bigInt2: BigInt = BigInt.parse("987654321")

    // 四则运算
    println("${bigInt1} + ${bigInt2} = ${bigInt1 + bigInt2}")
    println("${bigInt1} - ${bigInt2} = ${bigInt1 - bigInt2}")
    println("${bigInt1} * ${bigInt2} = ${bigInt1 * bigInt2}")
    println("${bigInt1} / ${bigInt2} = ${bigInt1 / bigInt2}")

    // 同时获取商和余数
    let (quotient, remainder) = bigInt1.divAndMod(bigInt2)
    println("${bigInt1} divAndMod ${bigInt2}: 商 = ${quotient}, 余数 = ${remainder}")

    return 0
}
```

运行结果：

```text
123456789 + 987654321 = 1111111110
123456789 - 987654321 = -864197532
123456789 * 987654321 = 121932631112635269
123456789 / 987654321 = 0
123456789 divAndMod 987654321: 商 = 0, 余数 = 123456789
```
