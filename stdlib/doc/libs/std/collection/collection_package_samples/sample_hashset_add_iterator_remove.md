# HashSet 的 add/iterator/remove 函数

此示例展示了 HashSet 的基本使用方法。

示例：

<!-- verify -->

```cangjie
import std.collection.*

main() {
    var set: HashSet<String> = HashSet<String>()

    // 添加元素
    set.add("apple")
    set.add("banana")
    set.add("orange")
    set.add("peach")
    println("添加元素后: ${set}")

    // 使用迭代器遍历集合
    println("遍历集合:")
    var iterator = set.iterator()
    while (true) {
        var nextValue = iterator.next()
        match (nextValue) {
            case Some(v) => println(v)
            case None => break
        }
    }

    // 删除元素
    set.remove("apple")
    println("删除apple后: ${set}")

    return 0
}
```

由于 HashSet 中的顺序不是固定的，因此运行结果可能如下：

```text
添加元素后: [apple, banana, orange, peach]
遍历集合:
apple
banana
orange
peach
删除apple后: [banana, orange, peach]
```
