# ArrayList 的 remove/clear/slice 函数

此示例展示了 ArrayList 的 remove/clear/slice 函数的使用方法。

示例：

<!-- verify -->

```cangjie
import std.collection.*

main() {
    var list: ArrayList<Int64> = ArrayList<Int64>([10, 20, 30, 40, 50, 60, 70])
    println("初始列表: ${list}")

    // 删除索引1处的元素
    list.remove(at: 1)
    println("删除索引1后: ${list}")

    // 删除索引3处的元素
    list.remove(at: 3)
    println("删除索引3后: ${list}")

    // 切片获取子列表（从索引1到索引4，步长为1）
    let r: Range<Int64> = 1..=4 : 1
    var sublist: ArrayList<Int64> = list.slice(r)
    println("切片索引范围1..=4: ${sublist}")

    // 清空列表
    list.clear()
    println("清空后: ${list}")

    return 0
}
```

运行结果：

```text
初始列表: [10, 20, 30, 40, 50, 60, 70]
删除索引1后: [10, 30, 40, 50, 60, 70]
删除索引3后: [10, 30, 40, 60, 70]
切片索引范围1..=4: [30, 40, 60, 70]
清空后: []
```
