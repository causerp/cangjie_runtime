# threadScope Cancellation Example

The following example shows that [threadScope](../concurrent_package_api/concurrent_package_funcs.md#func-threadscopet-rthreadgroupt---r) sends cancellation requests to tasks in the group when one task fails. The long-running task checks [Thread.currentThread.hasPendingCancellation](../../core/core_package_api/core_package_classes.md#prop-haspendingcancellation) and stops after receiving the cancellation request.

<!-- verify -->
```cangjie
import std.concurrent.*

main() {
    try {
        threadScope<Int64, Unit> {
            group =>
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

Execution Result:

```text
worker cancelled
stop scope
```
