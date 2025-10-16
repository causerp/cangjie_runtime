# Functions

## func sort\<T>(Array\<T>, Bool, Bool) where T <: Comparable\<T>

```cangjie
public func sort<T>(data: Array<T>, stable!: Bool = false, descending!: Bool = false): Unit where T <: Comparable<T>
```

Function: Sorts an array. Can specify whether to perform stable sorting and whether to sort in ascending or descending order via parameters.

Parameters:

- data: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - The array to be sorted.
- stable!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether to use stable sorting, defaults to false.
- descending!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether to sort in descending order, defaults to false.

Example:

<!-- verify -->
```cangjie
import std.sort.*

class Rectangle <: Comparable<Rectangle> & ToString {
    var width: Int64
    var height: Int64

    public init(width: Int64, height: Int64) {
        this.width = width
        this.height = height
    }

    public func compare(r: Rectangle) {
        let tValue: Int64 = this.width * this.height
        let rValue: Int64 = r.width * r.height
        if (tValue > rValue) {
            return Ordering.GT
        } else if (tValue == rValue) {
            return Ordering.EQ
        } else {
            return Ordering.LT
        }
    }

    public func toString(): String {
        return "#width: ${this.width}, height: ${this.height}"
    }
}

main() {
    /* Sort by area in descending order */
    var arr = [Rectangle(4, 8), Rectangle(6, 7), Rectangle(2, 6)]
    sort<Rectangle>(arr, stable: true, descending: true)
    println(arr)
    return 0
}
```

Output:

```text
[#width: 6, height: 7, #width: 4, height: 8, #width: 2, height: 6]
```

## func sort\<T>(Array\<T>, (T, T) -> Ordering, Bool, Bool)

```cangjie
public func sort<T>(data: Array<T>, by!: (T, T) -> Ordering, stable!: Bool = false, descending!: Bool = false): Unit
```

Function: Sorts an array using a custom comparison function. Can specify whether to perform stable sorting and whether to sort in ascending or descending order via parameters.

The user needs to provide a custom comparison function `by`. If `by` returns [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).GT, `t1` will appear after `t2` after sorting; if it returns [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).LT, `t1` will appear before `t2`; if it returns [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).EQ, the relative positions of `t1` and `t2` will depend on whether stable sorting is used - maintaining original order if stable, otherwise potentially changing.

Parameters:

- data: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - The array to be sorted.
- by!: (T, T) ->[Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering) - The comparison function.
- stable!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether to use stable sorting, defaults to false.
- descending!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether to sort in descending order, defaults to false.

Example:

<!-- verify -->
```cangjie
import std.sort.*

class Rectangle <: ToString {
    var width: Int64
    var height: Int64

    public init(width: Int64, height: Int64) {
        this.width = width
        this.height = height
    }

    public func toString(): String {
        return "#width: ${this.width}, height: ${this.height}"
    }
}

main() {
    /* Sort by area in descending order */
    var arr = [Rectangle(4, 8), Rectangle(6, 7), Rectangle(2, 6)]
    sort<Rectangle>(
        arr,
        by: {
            r1: Rectangle, r2: Rectangle =>
            let r1Value: Int64 = r1.width * r1.height
            let r2Value: Int64 = r2.width * r2.height
            if (r1Value > r2Value) {
                return Ordering.GT
            } else if (r1Value == r2Value) {
                return Ordering.EQ
            } else {
                return Ordering.LT
            }
        },
        stable: true,
        descending: true
    )
    println(arr)
    return 0
}
```

Output:

```text
[#width: 6, height: 7, #width: 4, height: 8, #width: 2, height: 6]
```

## func sort\<T>(Array\<T>, (T, T) -> Bool, Bool, Bool)

```cangjie
public func sort<T>(data: Array<T>, lessThan!: (T, T) -> Bool, stable!: Bool = false, descending!: Bool = false): Unit
```

Function: Sorts an array using a custom comparison function. Can specify whether to perform stable sorting and whether to sort in ascending or descending order via parameters.

The user needs to provide a custom comparison function `lessThan`. If `lessThan` returns `true`, `t1` will appear before `t2` after sorting; if it returns `false`, there are two cases: if `t1` and `t2` are not equal, `t1` will appear after `t2`; if equal, their relative positions will depend on whether stable sorting is used - maintaining original order if stable, otherwise potentially changing.

Parameters:

- data: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - The array to be sorted.
- lessThan!: (T, T) ->[Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The comparison function.
- stable!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether to use stable sorting, defaults to false.
- descending!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether to sort in descending order, defaults to false.

Example:

<!-- verify -->
```cangjie
import std.sort.*

class Rectangle <: ToString {
    var width: Int64
    var height: Int64

    public init(width: Int64, height: Int64) {
        this.width = width
        this.height = height
    }

    public func toString(): String {
        return "#width: ${this.width}, height: ${this.height}"
    }
}

main() {
    /* Sort by area in descending order */
    var arr = [Rectangle(4, 8), Rectangle(6, 7), Rectangle(2, 6)]
    sort<Rectangle>(
        arr,
        lessThan: {
            r1: Rectangle, r2: Rectangle =>
            let r1Value: Int64 = r1.width * r1.height
            let r2Value: Int64 = r2.width * r2.height
            return r1Value < r2Value
        },
        stable: true,
        descending: true
    )
    println(arr)
    return 0
}
```

Output:

```text
[#width: 6, height: 7, #width: 4, height: 8, #width: 2, height: 6]
```

## func sort\<T, K>(Array\<T>, (T) -> K, Bool, Bool) where K <: Comparable\<K>

```cangjie
public func sort<T, K>(data: Array<T>, key!: (T) -> K, stable!: Bool = false, descending!: Bool = false): Unit where K <: Comparable<K>
```

Function: Sorts an array by specified keys (where keys are comparable). Can specify whether to perform stable sorting and whether to sort in ascending or descending order via parameters.

The user needs to provide a mapping function from array elements to keys.

Parameters:

- data: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - The array to be sorted.
- key!: (T) -> K - The element-to-key mapping function.
- stable!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether to use stable sorting, defaults to false.
- descending!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether to sort in descending order, defaults to false.

Example:

<!-- verify -->
```cangjie
import std.sort.*

class Rectangle <: ToString {
    var width: Int64
    var height: Int64

    public init(width: Int64, height: Int64) {
        this.width = width
        this.height = height
    }

    public func toString(): String {
        return "#width: ${this.width}, height: ${this.height}"
    }
}

main() {
    /* Sort by width in descending order */
    var arr = [Rectangle(4, 8), Rectangle(6, 7), Rectangle(2, 6)]
    sort<Rectangle, Int64>(
        arr,
        key: {
            r: Rectangle => return r.width
        },
        stable: true,
        descending: true
    )
    println(arr)
    return 0
}
```

Output:

```text
[#width: 6, height: 7, #width: 4, height: 8, #width: 2, height: 6]
```

## func sort\<T>(ArrayList\<T>, Bool, Bool) where T <: Comparable\<T>

```cangjie
public func sort<T>(data: ArrayList<T>, stable!: Bool = false, descending!: Bool = false): Unit where T <: Comparable<T>
```

Function: Sorts an `ArrayList`. Can specify whether to perform stable sorting and whether to sort in ascending or descending order via parameters.

Parameters:

- data: [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<T> - The `ArrayList` to be sorted.
- stable!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether to use stable sorting, defaults to false.
- descending!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether to sort in descending order, defaults to false.

Example:

<!-- verify -->
```cangjie
import std.sort.*
import std.collection.*

class Rectangle <: Comparable<Rectangle> & ToString {
    var width: Int64
    var height: Int64

    public init(width: Int64, height: Int64) {
        this.width = width
        this.height = height
    }

    public func compare(r: Rectangle) {
        let tValue: Int64 = this.width * this.height
        let rValue: Int64 = r.width * r.height
        if (tValue > rValue) {
            return Ordering.GT
        } else if (tValue == rValue) {
            return Ordering.EQ
        } else {
            return Ordering.LT
        }
    }

    public func toString(): String {
        return "#width: ${this.width}, height: ${this.height}"
    }
}

main() {
    /* Sort by area in descending order */
    var arr = ArrayList<Rectangle>([Rectangle(4, 8), Rectangle(6, 7), Rectangle(2, 6)])
    sort<Rectangle>(arr, stable: true, descending: true)
    println(arr)
    return 0
}
```

Execution result:

```text
[#width: 6, height: 7, #width: 4, height: 8, #width: 2, height: 6]
```

## func sort\<T>(ArrayList\<T>, (T, T) -> Ordering, Bool, Bool)

```cangjie
public func sort<T>(data: ArrayList<T>, by!: (T, T) -> Ordering, stable!: Bool = false, descending!: Bool = false): Unit
```

Function: Sorts an `ArrayList` using a comparison function. Parameters can specify whether to perform stable sorting and whether to sort in ascending or descending order.

The user must provide a custom comparison function `by`. If `by` returns [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).GT, `t1` will be placed after `t2` after sorting; if it returns [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).LT, `t1` will be placed before `t2`; if it returns [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).EQ, the relative positions of `t1` and `t2` will depend on whether stable sorting is enabled (maintaining original order if stable, otherwise potentially changing).

Parameters:

- data: [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<T> - The `ArrayList` to be sorted.
- by!: (T, T) ->[Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering) - The comparison function.
- stable!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether to use stable sorting, defaults to false.
- descending!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether to sort in descending order, defaults to false.

Example:

<!-- verify -->
```cangjie
import std.sort.*
import std.collection.*

class Rectangle <: ToString {
    var width: Int64
    var height: Int64

    public init(width: Int64, height: Int64) {
        this.width = width
        this.height = height
    }

    public func toString(): String {
        return "#width: ${this.width}, height: ${this.height}"
    }
}

main() {
    /* Sort by area in descending order */
    var arr = ArrayList<Rectangle>([Rectangle(4, 8), Rectangle(6, 7), Rectangle(2, 6)])
    sort<Rectangle>(
        arr,
        by: {
            r1: Rectangle, r2: Rectangle =>
            let r1Value: Int64 = r1.width * r1.height
            let r2Value: Int64 = r2.width * r2.height
            if (r1Value > r2Value) {
                return Ordering.GT
            } else if (r1Value == r2Value) {
                return Ordering.EQ
            } else {
                return Ordering.LT
            }
        },
        stable: true,
        descending: true
    )
    println(arr)
    return 0
}
```

Execution result:

```text
[#width: 6, height: 7, #width: 4, height: 8, #width: 2, height: 6]
```

## func sort\<T>(ArrayList\<T>, (T, T) -> Bool, Bool, Bool)

```cangjie
public func sort<T>(data: ArrayList<T>, lessThan!: (T, T) -> Bool, stable!: Bool = false, descending!: Bool = false): Unit
```

Function: Sorts an `ArrayList` using a comparison function. Parameters can specify whether to perform stable sorting and whether to sort in ascending or descending order.

The user must provide a custom comparison function `lessThan`. If `lessThan` returns `true`, `t1` will be placed before `t2` after sorting; if it returns `false`, there are two cases: if `t1` and `t2` are not equal, `t1` will be placed after `t2`; if equal, their relative positions depend on whether stable sorting is enabled (maintaining original order if stable, otherwise potentially changing).

Parameters:

- data: [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<T> - The `ArrayList` to be sorted.
- lessThan!: (T, T) ->[Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The comparison function.
- stable!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether to use stable sorting, defaults to false.
- descending!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether to sort in descending order, defaults to false.

Example:

<!-- verify -->
```cangjie
import std.sort.*
import std.collection.*

class Rectangle <: ToString {
    var width: Int64
    var height: Int64

    public init(width: Int64, height: Int64) {
        this.width = width
        this.height = height
    }

    public func toString(): String {
        return "#width: ${this.width}, height: ${this.height}"
    }
}

main() {
    /* Sort by area in descending order */
    var arr = ArrayList<Rectangle>([Rectangle(4, 8), Rectangle(6, 7), Rectangle(2, 6)])
    sort<Rectangle>(
        arr,
        lessThan: {
            r1: Rectangle, r2: Rectangle =>
            let r1Value: Int64 = r1.width * r1.height
            let r2Value: Int64 = r2.width * r2.height
            return r1Value < r2Value
        },
        stable: true,
        descending: true
    )
    println(arr)
    return 0
}
```

Execution result:

```text
[#width: 6, height: 7, #width: 4, height: 8, #width: 2, height: 6]
```

## func sort\<T, K>(ArrayList\<T>, (T) -> K, Bool, Bool) where K <: Comparable\<K>

```cangjie
public func sort<T, K>(data: ArrayList<T>, key!: (T) -> K, stable!: Bool = false, descending!: Bool = false): Unit where K <: Comparable<K>
```

Function: Sorts an `ArrayList` by specified keys (keys must be comparable). Parameters can specify whether to perform stable sorting and whether to sort in ascending or descending order.

The user must provide a mapping function from elements to keys.

Parameters:

- data: [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<T> - The `ArrayList` to be sorted.
- key!: (T) -> K - The element-to-key mapping function.
- stable!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether to use stable sorting, defaults to false.
- descending!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether to sort in descending order, defaults to false.

Example:

<!-- verify -->
```cangjie
import std.sort.*
import std.collection.*

class Rectangle <: ToString {
    var width: Int64
    var height: Int64

    public init(width: Int64, height: Int64) {
        this.width = width
        this.height = height
    }

    public func toString(): String {
        return "#width: ${this.width}, height: ${this.height}"
    }
}

main() {
    /* Sort by width in descending order */
    var arr = ArrayList<Rectangle>([Rectangle(4, 8), Rectangle(6, 7), Rectangle(2, 6)])
    sort<Rectangle, Int64>(
        arr,
        key: {
            r: Rectangle => return r.width
        },
        stable: true,
        descending: true
    )
    println(arr)
    return 0
}
```

Execution result:

```text
[#width: 6, height: 7, #width: 4, height: 8, #width: 2, height: 6]
```

## func sort\<T>(List\<T>, Bool, Bool) where T <: Comparable\<T>

```cangjie
public func sort<T>(data: List<T>, stable!: Bool = false, descending!: Bool = false): Unit where T <: Comparable<T>
```

Function: Sorts a `List`. Parameters can specify whether to perform stable sorting and whether to sort in ascending or descending order.

Parameters:

- data: [List](../../collection/collection_package_api/collection_package_interface.md#interface-Listt)\<T> - The `List` to be sorted.
- stable!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether to use stable sorting, defaults to false.
- descending!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether to sort in descending order, defaults to false.

## func sort\<T>(List\<T>, (T, T) -> Ordering, Bool, Bool)

```cangjie
public func sort<T>(data: List<T>, by!: (T, T) -> Ordering, stable!: Bool = false, descending!: Bool = false): Unit
```

Function: Sorts a `List` using a comparison function. Parameters can specify whether to perform stable sorting and whether to sort in ascending or descending order.

The user must provide a custom comparison function `by`. If `by` returns [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).GT, `t1` will be placed after `t2` after sorting; if it returns [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).LT, `t1` will be placed before `t2`; if it returns [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).EQ, the relative positions of `t1` and `t2` will depend on whether stable sorting is enabled (maintaining original order if stable, otherwise potentially changing).

Parameters:

- data: [List](../../collection/collection_package_api/collection_package_interface.md#interface-Listt)\<T> - The `List` to be sorted.
- by!: (T, T) ->[Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering) - The comparison function.
- stable!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether to use stable sorting, defaults to false.
- descending!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether to sort in descending order, defaults to false.

## func sort\<T>(List\<T>, (T, T) -> Bool, Bool, Bool)

```cangjie
public func sort<T>(data: List<T>, lessThan!: (T, T) -> Bool, stable!: Bool = false, descending!: Bool = false): Unit
```

Function: Sorts a `List` using a comparison function. Parameters can specify whether to perform stable sorting and whether to sort in ascending or descending order.

The user must provide a custom comparison function `lessThan`. If `lessThan` returns `true`, `t1` will be placed before `t2` after sorting; if it returns `false`, there are two cases: if `t1` and `t2` are not equal, `t1` will be placed after `t2`; if equal, their relative positions depend on whether stable sorting is enabled (maintaining original order if stable, otherwise potentially changing).

Parameters:

- data: [List](../../collection/collection_package_api/collection_package_interface.md#interface-Listt)\<T> - The `List` to be sorted.
- lessThan!: (T, T) ->[Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The comparison function.
- stable!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether to use stable sorting, defaults to false.
- descending!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether to sort in descending order, defaults to false.

## func sort\<T, K>(List\<T>, (T) -> K, Bool, Bool) where K <: Comparable\<K>

```cangjie
public func sort<T, K>(data: List<T>, key!: (T) -> K, stable!: Bool = false, descending!: Bool = false): Unit where K <: Comparable<K>
```

Function: Sorts a `List` by specified keys (keys must be comparable). Parameters can specify whether to perform stable sorting and whether to sort in ascending or descending order.

The user must provide a mapping function from elements to keys.

Parameters:

- data: [List](../../collection/collection_package_api/collection_package_interface.md#interface-Listt)\<T> - The `List` to be sorted.
- key!: (T) -> K - The element-to-key mapping function.
- stable!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether to use stable sorting, defaults to false.
- descending!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether to sort in descending order, defaults to false.

## func stableSort\<T>(Array\<T>) where T <: Comparable\<T> <sup>(deprecated)</sup>

```cangjie
public func stableSort<T>(data: Array<T>): Unit where T <: Comparable<T>
```

Function: Performs stable ascending sorting on an array.

> **Note:**
>
> This will be deprecated in future versions. Use [sort](sort_package_funcs.md#func-sorttarrayt-bool-bool-where-t--comparablet) instead.

Parameters:

- data: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - The array to be sorted.

## func stableSort\<T>(Array\<T>, (T, T) -> Ordering) <sup>(deprecated)</sup>

```cangjie
public func stableSort<T>(data: Array<T>, comparator: (T, T) -> Ordering): Unit
```

Function: Performs stable sorting on an array.

The user can provide a custom comparison function `comparator`. If `comparator` returns [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).GT, `t1` will be placed after `t2` after sorting; if it returns [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).LT, `t1` will be placed before `t2`; if it returns [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).EQ, the relative positions of `t1` and `t2` will maintain their original order.

> **Note:**
>
> This will be deprecated in future versions. Use [sort](sort_package_funcs.md#func-sorttarrayt-t-t---ordering-bool-bool) instead.Parameters:

- data: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - The array to be sorted.
- comparator: (T, T) ->[Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering) - User-provided comparison function.

## func unstableSort\<T>(Array\<T>) where T <: Comparable\<T> <sup>(deprecated)</sup>

```cangjie
public func unstableSort<T>(data: Array<T>): Unit where T <: Comparable<T>
```

Function: Performs unstable ascending sort on the array.

> **Note:**
>
> Will be deprecated in future versions. Use [sort](sort_package_funcs.md#func-sorttarrayt-bool-bool-where-t--comparablet) instead.

Parameters:

- data: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - The array to be sorted.

## func unstableSort\<T>(Array\<T>, (T, T) -> Ordering) <sup>(deprecated)</sup>

```cangjie
public func unstableSort<T>(data: Array<T>, comparator: (T, T) -> Ordering): Unit
```

Function: Performs unstable sort on the array.

Users can provide a custom comparison function `comparator`. If `comparator` returns [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).GT, `t1` will be placed after `t2` after sorting; if it returns [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).LT, `t1` will be placed before `t2`; if it returns [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).EQ, the relative positions of `t1` and `t2` will remain unchanged from before sorting.

> **Note:**
>
> Will be deprecated in future versions. Use [sort](sort_package_funcs.md#func-sorttarrayt-t-t---ordering-bool-bool) instead.

Parameters:

- data: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - The array to be sorted.
- comparator: (T, T) ->[Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering) - User-provided comparison function.