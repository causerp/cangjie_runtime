# HashMap's get/add/contains Functions

This use case demonstrates the basic usage of HashMap.

The code is as follows:

<!-- verify -->

```cangjie
import std.collection.*

main() {
    var map: HashMap<String, Int64> = HashMap<String, Int64>()
    map.add("a", 99) // map : [("a", 99)]
    map.add("b", 100) // map : [("a", 99), ("b", 100)]
    var a = map.get("a")
    var bool = map.contains("a")
    print("a=${a.getOrThrow()} ")
    print("bool=${bool.toString()}")
    return 0
}
```

Execution result:

```text
a=99 bool=true
```
