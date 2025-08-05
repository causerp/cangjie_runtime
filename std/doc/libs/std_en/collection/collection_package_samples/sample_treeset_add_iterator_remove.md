# TreeSet's add/iterator/remove Functions

This use case demonstrates the basic usage of TreeSet.

Code:

<!-- verify -->

```cangjie
import std.collection.*
/* Test */
main() {
    var set: TreeSet<String> = TreeSet<String>()
    set.add("peach")
    set.add("banana")
    set.add("apple")
    set.add("orange")

    var itset = set.iterator()
    for (e in itset) {
        println(e)
    }

    set.remove("banana")
    println(set)
    return 0
}
```

Execution Result:

```text
apple
banana
orange
peach
[apple, orange, peach]
```
