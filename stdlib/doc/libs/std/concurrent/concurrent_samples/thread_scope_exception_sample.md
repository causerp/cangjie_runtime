# threadScope 异常处理示例

下面示例展示了已启动任务抛出的异常会在通过 [ThreadGroup](../concurrent_package_api/concurrent_package_classes.md#class-threadgroupt) 消费该任务结果时重新抛出。

<!-- verify -->
```cangjie
import std.concurrent.*

main() {
    try {
        threadScope<Int64, Unit> { group =>
            group.launch {
                throw IllegalArgumentException("task failed")
            }

            for (_ in group) {}
        }
    } catch (e: IllegalArgumentException) {
        println(e.message)
    }
}
```

运行结果：

```text
task failed
```
