# ArrayList get/set Functions

This example demonstrates how to use the get method to retrieve values from an ArrayList by index, as well as how to modify values.

Code:

<!-- verify -->

```cangjie
import std.collection.*

main() {
    var list = ArrayList<Int64>([97, 100]) // list: [97, 100]

    // Modify value
    list[1] = 120 // list: [97, 120]

    // Get value
    var b = list.get(1)
    print("b=${b.getOrThrow()}")
    return 0
}
```

Execution result:

```text
b=120
```
