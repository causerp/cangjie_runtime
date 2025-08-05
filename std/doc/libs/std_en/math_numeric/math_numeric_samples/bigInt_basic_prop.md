# BigInt Basic Properties Example

The following demonstrates initializing a `BigInt` object and querying its basic properties:
<!-- verify -->

```cangjie
import std.math.numeric.*

main() {
    let int = BigInt.parse("-123456")
    println("BigInt: ${int}")
    println("BigInt sign: ${int.sign}")
    println("BigInt bitLen: ${int.bitLen}")
    return 0
}
```

Execution result:

```text
BigInt: -123456
BigInt sign: -1
BigInt bitLen: 18
```