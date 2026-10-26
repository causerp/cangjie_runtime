# threadScope Usage Example

The following example launches several tasks in a [threadScope](../concurrent_package_api/concurrent_package_funcs.md#func-threadscopet-rthreadgroupt---r), consumes their results, and returns the aggregated value from the scope.

<!-- verify -->
```cangjie
import std.concurrent.*

main() {
    let total = threadScope<Int64, Int64> {
        group =>
            group.launch {1}
            group.launch {2}
            group.launch {3}

            var sum = 0
            for (result in group) {
                sum += result
            }
            sum
    }

    println(total)
}
```

Execution Result:

```text
6
```
