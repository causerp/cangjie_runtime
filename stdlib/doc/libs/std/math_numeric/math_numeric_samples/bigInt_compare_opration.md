# BigInt 大小比较示例

以下为初始化多个 `BigInt` 对象，相互之间大小比较的示例：
<!-- verify -->
```cangjie
import std.math.numeric.*

main() {
    let bigInt1 = BigInt.parse("123456789")
    let bigInt2 = BigInt.parse("987654321")

    // 比较运算符
    println("${bigInt1} > ${bigInt2} = ${bigInt1 > bigInt2}")
    println("${bigInt1} < ${bigInt2} = ${bigInt1 < bigInt2}")
    println("${bigInt1} == ${bigInt2} = ${bigInt1 == bigInt2}")
    println("${bigInt1} != ${bigInt2} = ${bigInt1 != bigInt2}")
    println("${bigInt1} <= ${bigInt2} = ${bigInt1 <= bigInt2}")
    println("${bigInt1} >= ${bigInt2} = ${bigInt1 >= bigInt2}")

    // compare 函数返回 Ordering 类型
    println("${bigInt1}.compare(${bigInt2}) = ${bigInt1.compare(bigInt2)}")
    return 0
}
```

运行结果：

```text
123456789 > 987654321 = false
123456789 < 987654321 = true
123456789 == 987654321 = false
123456789 != 987654321 = true
123456789 <= 987654321 = true
123456789 >= 987654321 = false
123456789.compare(987654321) = Ordering.LT
```
