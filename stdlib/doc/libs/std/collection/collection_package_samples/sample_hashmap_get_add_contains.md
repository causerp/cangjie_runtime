# HashMap 的 get/add/contains 函数

此示例展示了 HashMap 的基本使用方法。

示例：

<!-- verify -->

```cangjie
import std.collection.*

main() {
    var map: HashMap<String, Int64> = HashMap<String, Int64>()

    // 添加键值对
    map.add("apple", 10)
    map.add("banana", 20)
    map.add("orange", 30)
    println("添加后: ${map}")

    // 使用contains检查键是否存在
    println("包含apple: ${map.contains("apple")}")
    println("包含grape: ${map.contains("grape")}")

    // 使用get获取值
    println("apple的值: ${map.get("apple").getOrThrow()}")
    println("banana的值: ${map.get("banana").getOrThrow()}")

    return 0
}
```

运行结果：

```text
添加后: [(apple, 10), (banana, 20), (orange, 30)]
包含apple: true
包含grape: false
apple的值: 10
banana的值: 20
```
