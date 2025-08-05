# Examples of Saturation Strategy

Below is an example of the saturation strategy. The example attempts to multiply UInt16.Max by 16. Since the operation result exceeds the maximum value of UInt16, an overflow occurs, and thus the maximum value of UInt16 is returned.

<!-- verify -->

```cangjie
import std.overflow.*
import std.math.*

main() {
    let a: UInt16 = UInt16.Max
    println(a.saturatingMul(16))
}
```

Execution result:

```text
65535
```