# Timing with MonoTime

This example demonstrates how to perform timing using the `MonoTime` type.

<!-- run -->

```cangjie
import std.time.*

const count = 10000

main() {
    let start = MonoTime.now()
    for (_ in 0..count) {
        DateTime.now()
    }
    let end = MonoTime.now()
    let result = end - start
    println("total cost: ${result.toNanoseconds()}ns")
}
```

Execution result (actual results may vary)

```text
total cost: 951159ns
```