# HashSet's add/iterator/remove Functions

This use case demonstrates the basic usage of HashSet.

The code is as follows:

<!-- verify -->

```cangjie
import std.collection.*
/* Test */
main() {
    var set: HashSet<String> = HashSet<String>() // set: []
    set.add("apple") // set: ["apple"]
    set.add("banana") // set: ["apple", "banana"], not in order
    set.add("orange") // set: ["apple", "banana", "orange"], not in order
    set.add("peach") // set: ["apple", "banana", "orange", "peach"], not in order
    var itset = set.iterator()
    while (true) {
        var value = itset.next()
        match (value) {
            case Some(v) =>
                if (!set.contains(v)) {
                    print("Operation failed")
                    return 1
                } else {
                    println(v)
                }
            case None => break
        }
    }
    set.remove("apple") // set: ["banana", "orange", "peach"], not in order
    println(set)
    return 0
}
```

Since the order in Set is not fixed, the execution result may be as follows:

```text
apple
banana
orange
peach
[banana, orange, peach]
```
