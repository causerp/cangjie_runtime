# ArrayList's add Function

The methods for adding elements to an ArrayList are as follows:

<!-- verify -->

```cangjie
import std.collection.*

main() {
    var list: ArrayList<Int64> = ArrayList<Int64>(10) // Create an ArrayList with a capacity of 10
    var arr: Array<Int64> = [1, 2, 3]
    list.add(all: arr) // list: [1, 2, 3]
    list[1] = 120 // list: [1, 120, 3]
    var b = list.get(2)
    print("b=${b.getOrThrow()},")
    list.add(12, at: 1) // list: [1, 12, 120, 3]
    var c = list.get(2)
    print("c=${c.getOrThrow()},")
    var arr1: Array<Int64> = [1, 2, 3]
    list.add(all: arr1, at: 1) // list: [1, 1, 2, 3, 12, 120, 3]
    var d = list.get(2)
    print("d=${d.getOrThrow()}")
    return 0
}
```

Execution result:

```text
b=3,c=120,d=2
```
