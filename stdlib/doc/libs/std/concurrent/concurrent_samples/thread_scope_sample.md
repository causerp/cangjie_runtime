# threadScope 使用示例

下面示例在 [threadScope](../concurrent_package_api/concurrent_package_funcs.md#func-threadscopet-rthreadgroupt---r) 中启动多个任务，消费这些任务的结果，并从作用域返回聚合后的值。

<!-- verify -->
```cangjie
import std.concurrent.*

main() {
    let total = threadScope<Int64, Int64> { group =>
        group.launch { 1 }
        group.launch { 2 }
        group.launch { 3 }

        var sum = 0
        for (result in group) {
            sum += result
        }
        sum
    }

    println(total)
}
```

运行结果：

```text
6
```
