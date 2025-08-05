# Sorting Arrays and Lists

## Sorting Arrays

Create an unordered Array and sort it.

Example:

<!-- verify -->
```cangjie
import std.sort.*

class Student <: ToString {
    public var name: String
    public var age: Int64
    public init(name: String, age: Int64) {
        this.name = name
        this.age = age
    }
    public func toString(): String {
        return "{name: ${name} age: ${age}}"
    }
}

main() {
    /* Sort Int64 array in ascending order */
    var a = [1, 3, 5, 2, 4]
    sort(a)
    println(a)

    /* Sort by age in ascending order */
    var b = [Student("A", 8), Student("B", 7), Student("C", 3), Student("D", 4), Student("E", 6)]
    let comparator = {l: Student, r: Student => l.age.compare(r.age)}
    sort(b, by: comparator)
    println(b)

    /* Sort by age in descending order */
    var c = [Student("A", 8), Student("B", 7), Student("C", 3), Student("D", 4), Student("E", 6)]
    let lessThan = {l: Student, r: Student => l.age < r.age}
    sort(c, lessThan: lessThan, descending: true)
    println(c)

    /* Sort by age in ascending order with stable sort */
    var d = [Student("A", 8), Student("B", 7), Student("C", 7), Student("D", 4), Student("E", 7)]
    let key = {i: Student => i.age}
    sort(d, key: key, stable: true)
    println(d)
    return 0
}
```

Execution result:

```text
[1, 2, 3, 4, 5]
[{name: C age: 3}, {name: D age: 4}, {name: E age: 6}, {name: B age: 7}, {name: A age: 8}]
[{name: A age: 8}, {name: B age: 7}, {name: E age: 6}, {name: D age: 4}, {name: C age: 3}]
[{name: D age: 4}, {name: B age: 7}, {name: C age: 7}, {name: E age: 7}, {name: A age: 8}]
```

## Sorting Lists

Create an unordered List and sort it.

Example:

<!-- verify -->
```cangjie
import std.sort.*
import std.collection.*

class Student <: ToString {
    public var name: String
    public var age: Int64
    public init(name: String, age: Int64) {
        this.name = name
        this.age = age
    }
    public func toString(): String {
        return "{name: ${name} age: ${age}}"
    }
}

main() {
    /* Sort Int64 List in ascending order */
    var a = ArrayList<Int64>([1, 3, 5, 2, 4])
    sort(a)
    println(a)

    /* Sort by age in ascending order */
    var b = ArrayList<Student>([Student("A", 8), Student("B", 7), Student("C", 3), Student("D", 4), Student("E", 6)])
    let comparator = {l: Student, r: Student => l.age.compare(r.age)}
    sort(b, by: comparator)
    println(b)

    /* Sort by age in descending order */
    var c = ArrayList<Student>([Student("A", 8), Student("B", 7), Student("C", 3), Student("D", 4), Student("E", 6)])
    let lessThan = {l: Student, r: Student => l.age < r.age}
    sort(c, lessThan: lessThan, descending: true)
    println(c)

    /* Sort by age in ascending order with stable sort */
    var d = ArrayList<Student>([Student("A", 8), Student("B", 7), Student("C", 7), Student("D", 4), Student("E", 7)])
    let key = {i: Student => i.age}
    sort(d, key: key, stable: true)
    println(d)
    return 0
}
```

Execution result:

```text
[1, 2, 3, 4, 5]
[{name: C age: 3}, {name: D age: 4}, {name: E age: 6}, {name: B age: 7}, {name: A age: 8}]
[{name: A age: 8}, {name: B age: 7}, {name: E age: 6}, {name: D age: 4}, {name: C age: 3}]
[{name: D age: 4}, {name: B age: 7}, {name: C age: 7}, {name: E age: 7}, {name: A age: 8}]
```