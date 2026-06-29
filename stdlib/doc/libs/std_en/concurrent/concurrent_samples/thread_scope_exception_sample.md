# threadScope Exception Handling Example

The following example shows that an exception thrown by a launched task is rethrown when the task result is consumed from the [ThreadGroup](../concurrent_package_api/concurrent_package_classes.md#class-threadgroupt).

<!-- verify -->
```cangjie
import std.concurrent.*

main() {
    try {
        threadScope<Int64, Unit> {
            group =>
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

Execution Result:

```text
task failed
```
