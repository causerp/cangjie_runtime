# TreeSet 的 add/iterator/remove 函数

此示例展示了 TreeSet 的基本使用方法。

示例：

<!-- verify -->

```cangjie
import std.collection.*

main() {
    var set: TreeSet<String> = TreeSet<String>()

    // 添加元素（TreeSet会自动按字典序排序）
    set.add("peach")
    set.add("banana")
    set.add("apple")
    set.add("orange")
    println("添加元素后（有序）: ${set}")

    // 使用for-in遍历迭代器（按字典序输出）
    println("遍历集合:")
    var iterator = set.iterator()
    for (element in iterator) {
        println(element)
    }

    // 删除元素
    set.remove("banana")
    println("删除banana后: ${set}")

    return 0
}
```

运行结果：

```text
添加元素后（有序）: [apple, banana, orange, peach]
遍历集合:
apple
banana
orange
peach
删除banana后: [apple, orange, peach]
```
