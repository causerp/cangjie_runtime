# Example of High-Order Truncation Strategy

Below is an example demonstrating the high-order truncation strategy. The example attempts to compute `UInt8.Max + 1`. The binary representation of `UInt8.Max` is `0b11111111`, and `UInt8.Max + 1` equals `0b100000000`. Since `UInt8` can only store 8 bits, the high-order bits are truncated, resulting in 0.

<!-- verify -->

```cangjie
import std.overflow.*
import std.math.*

main() {
    let a: UInt8 = UInt8.Max
    println(a.wrappingAdd(1))
}
```

Execution result:

```text
0
```