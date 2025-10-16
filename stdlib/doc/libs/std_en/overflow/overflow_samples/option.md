# Example of Returning `Option` Strategy

Below is an example demonstrating the `Option` return strategy. The example attempts to calculate the square of `Int64.Max`, which results in an overflow and returns `None`.

<!-- verify -->

```cangjie
import std.overflow.*
import std.math.*

main() {
    let a: Int64 = Int64.Max
    println(a.checkedPow(UInt64(2)))
}
```

Execution result:

```text
None
```