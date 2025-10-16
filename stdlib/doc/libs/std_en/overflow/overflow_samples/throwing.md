# Example of Exception Throwing Strategy

The following is an example of an exception throwing strategy. In this example, attempting to compute `Int64.Max + 1` causes an overflow, throwing an `OverflowException`.

<!-- run.error -->

```cangjie
import std.overflow.*
import std.math.*

main() {
    let a: Int64 = Int64.Max
    println(a.throwingAdd(1))
}
```

Execution result:

```text
An exception has occurred:
OverflowException: add
```