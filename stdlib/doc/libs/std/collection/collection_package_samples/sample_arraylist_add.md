# ArrayList 的 add 函数

ArrayList 中添加元素的方法如下：

<!-- verify -->

```cangjie
import std.collection.*

main() {
    var list: ArrayList<Int64> = ArrayList<Int64>()

    // 在末尾添加单个元素
    list.add(10)
    list.add(20)
    list.add(30)
    println("添加元素后: ${list}")

    // 在指定位置插入单个元素
    list.add(15, at: 1)
    println("在索引1插入15后: ${list}")

    // 批量添加数组元素到末尾
    var arr: Array<Int64> = [40, 50]
    list.add(all: arr)
    println("批量添加[40, 50]后: ${list}")

    // 在指定位置批量插入数组
    var newArr: Array<Int64> = [100, 200]
    list.add(all: newArr, at: 2)
    println("在索引2插入[100, 200]后: ${list}")

    return 0
}
```

运行结果：

```text
添加元素后: [10, 20, 30]
在索引1插入15后: [10, 15, 20, 30]
批量添加[40, 50]后: [10, 15, 20, 30, 40, 50]
在索引2插入[100, 200]后: [10, 15, 100, 200, 20, 30, 40, 50]
```
