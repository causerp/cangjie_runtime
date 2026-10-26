# BigInt 基本属性示例

以下为初始化 `BigInt` 对象的，并查询对象的基本属性的示例：
<!-- verify -->
```cangjie
import std.math.numeric.*

main() {
    let bigInt = BigInt.parse("-123456")
    println("BigInt 值: ${bigInt}")
    println("符号: ${bigInt.sign}")
    println("二进制位长度: ${bigInt.bitLen}")
    return 0
}
```

运行结果：

```text
BigInt 值: -123456
符号: -1
二进制位长度: 18
```
