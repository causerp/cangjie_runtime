# Iterator Operation Functions

This use case demonstrates the usage of iterator operation functions combined with `pipeline` expressions.

The code is as follows:

<!-- verify -->

```cangjie
import std.collection.*

main() {
    let arr = [-1, 2, 3, 4, 5, 6, 7, 8, 9]
    arr |> filter {a: Int64 => a > 0} |> // filter -1
        step<Int64>(2) |> // [2, 4, 6, 8]
        skip<Int64>(2) |> // [6, 8]
        forEach<Int64>(println)

    let str = arr |> filter {a: Int64 => a % 2 == 1} |> collectString<Int64>(delimiter: ">")
    println(str)
    println(arr |> contains(6_i64))
    return 0
}
```

Execution results:

```text
6
8
3>5>7>9
true
```
