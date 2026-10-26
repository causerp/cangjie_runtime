# ArrayList 的 get/set 函数

此示例展示了如何使用 get 方法获取 ArrayList 中对应索引的值，以及如何修改值。

示例：

<!-- verify -->

```cangjie
import std.collection.*

main() {
    var list = ArrayList<Int64>([10, 20, 30, 40, 50])
    println("初始列表: ${list}")

    // 使用下标修改元素值
    list[1] = 25
    println("修改索引1为25后: ${list}")

    list[3] = 45
    println("修改索引3为45后: ${list}")

    // 使用get方法获取元素
    var value0 = list.get(0)
    println("索引0的元素: ${value0.getOrThrow()}")

    var value2 = list.get(2)
    println("索引2的元素: ${value2.getOrThrow()}")

    return 0
}
```

运行结果：

```text
初始列表: [10, 20, 30, 40, 50]
修改索引1为25后: [10, 25, 30, 40, 50]
修改索引3为45后: [10, 25, 30, 45, 50]
索引0的元素: 10
索引2的元素: 30
```
