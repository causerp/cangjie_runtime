# 迭代器操作函数

此示例展示了迭代器操作函数结合 `pipeline` 表达式的使用方法。

示例：

<!-- verify -->

```cangjie
import std.collection.*

main() {
    let arr = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    println("原始数组: ${arr}")

    // 过滤出大于5的元素
    println("大于5的元素:")
    arr |> filter {num: Int64 => num > 5} |> forEach<Int64>(println)

    // 先跳过前2个元素，再每隔2个取样
    let sampled = arr |> skip<Int64>(2) |> step<Int64>(2) |> collectArray
    println("跳过前2个后每隔2个取样: ${sampled}")

    // 过滤出奇数并用">"连接成字符串
    let oddNumbersString = arr |> filter {num: Int64 => num % 2 == 1} |> collectString<Int64>(delimiter: ">")
    println("奇数元素连接: ${oddNumbersString}")

    // 检查数组是否包含元素6
    println("包含6: ${arr |> contains(6_i64)}")

    return 0
}
```

运行结果：

```text
原始数组: [1, 2, 3, 4, 5, 6, 7, 8, 9]
大于5的元素:
6
7
8
9
跳过前2个后每隔2个取样: [3, 5, 7, 9]
奇数元素连接: 1>3>5>7>9
包含6: true
```
