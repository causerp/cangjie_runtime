# HashMap 的 add/remove/clear 函数

此示例展示了 HashMap 的基本使用方法。

示例：

<!-- verify -->

```cangjie
import std.collection.*

main() {
    var map: HashMap<String, Int64> = HashMap<String, Int64>()

    // 添加单个键值对
    map.add("apple", 10)
    map.add("banana", 20)
    println("添加两个键值对后: ${map}")

    // 批量添加键值对
    var arr: Array<(String, Int64)> = [("orange", 30), ("grape", 40)]
    map.add(all: arr)
    println("批量添加后: ${map}")

    // 删除键
    map.remove("banana")
    println("删除banana后: ${map}")

    // 清空映射
    map.clear()
    println("清空后: ${map}")

    return 0
}
```

运行结果：

```text
添加两个键值对后: [(apple, 10), (banana, 20)]
批量添加后: [(apple, 10), (banana, 20), (orange, 30), (grape, 40)]
删除banana后: [(apple, 10), (orange, 30), (grape, 40)]
清空后: []
```
