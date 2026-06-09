# threadScope 取消示例

下面示例展示了当某个任务失败时，[threadScope](../concurrent_package_api/concurrent_package_funcs.md#func-threadscopet-rthreadgroupt---r) 会向组中的任务发送取消请求。长时间运行的任务检查 [Thread.currentThread.hasPendingCancellation](../../core/core_package_api/core_package_classes.md#prop-haspendingcancellation)，并在收到取消请求后停止。

<!-- verify -->
```cangjie
import std.concurrent.*

main() {
    try {
        threadScope<Int64, Unit> { group =>
            group.launch {
                while (true) {
                    if (Thread.currentThread.hasPendingCancellation) {
                        println("worker cancelled")
                        return 0
                    }
                    sleep(10 * Duration.millisecond)
                }
                return 1
            }

            group.launch {
                throw IllegalArgumentException("stop scope")
            }
        }
    } catch (e: IllegalArgumentException) {
        println(e.message)
    }
}
```

运行结果：

```text
worker cancelled
stop scope
```
