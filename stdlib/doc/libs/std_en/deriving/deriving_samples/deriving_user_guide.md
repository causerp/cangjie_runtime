# Deriving

A simple example:

<!-- run -->
```cangjie
import std.deriving.*

@Derive[ToString]
class User {
    User(
        let name: String,
        let id: Int
    ) {}
}

main() {
    println(User("id0", 0)) // -> "User(name: id0, id: 0)"
}
```

When `@Derive[ToString]` is applied to a class or struct, Deriving collects and uses both mutable and immutable fields of the class/struct, including those specified in the primary constructor, and automatically implements the `ToString` method. When `@Derive[ToString]` is applied to an enum, Deriving collects the constructor parameters of the enum. Static fields and properties will not be collected or used. Additionally, fields collected by Deriving cannot be private, otherwise a compilation error will be thrown.

For collected fields to be used in Deriving, their types must implement the target interface to combine field results. For example, when processing `ToString`, the generated code will call `toString` on all collected fields, then concatenate the results with corresponding field names into a string. If any field's type doesn't support `ToString`, a compilation error will be thrown and Deriving cannot complete.

> **Note**
> 
> Classes marked for derivation should be final: they should not be open, abstract, or `sealed`.

Some fields may have special meanings where their values aren't particularly meaningful. These can be excluded by applying `@DeriveExclude` to such fields:

<!-- compile -->
```cangjie
import std.deriving.*

@Derive[ToString]
class User {
    User(let name: String) {}

    @DeriveExclude
    let lazyHashCode = 0 // it will not be printed because it's excluded
}
```

By default, Deriving only enables fields. For properties, explicit enabling via `@DeriveInclude` is required:

<!-- run -->
```cangjie
import std.deriving.*

@Derive[ToString]
class User {
    User(let id: Int) {}

    @DeriveInclude
    prop name: String {
        get() {
            "id0"
        }
    }
}

main() {
    println(User(0)) // -> "User(id: 0, name: id0)"
}
```

Note that since the `name` property is declared after `id`, the printing order is `id` first, then `name`.

To change the printing order, use `@DeriveOrder`:

<!-- run -->
```cangjie
import std.deriving.*

@Derive[ToString]
@DeriveOrder[name, id]
class User {
    User(let id: Int) {}

    @DeriveInclude
    prop name: String {
        get() {
            "s_${id}"
        }
    }
}

main() {
    println(User(0)) // -> "User(name: s_0, id: 0)"
}
```

## Common Deriving Syntax

The `@Derive` macro supports a comma-separated list of interface names. Additionally, the macro can be called multiple times, but all `@Derive` macro calls should be at the top of the declaration, while other macros (like `@DeriveOrder`) should always follow.

The order of supported interface lists has no effect.

<!-- compile -->
```cangjie
import std.deriving.*

@Derive[ToString, Hashable]
@Derive[Equatable]
@DeriveOrder[currency, price, quantity]
struct Order {
    let currency = 1
    let price = 100
    let quantity = 200
}
```

When deriving multiple intersecting interfaces (e.g., `Comparable` which includes `Equatable`), having both is allowed and equivalent to only having the most comprehensive one:

```cangjie
@Derive[Comparable] // does also generate Equatable
```

Equivalent to:

```cangjie
@Derive[Comparable, Equatable]
```

## Inclusion and Exclusion

By default, all fields are processed, including those defined as primary constructor parameters.
To exclude a field, apply `@DeriveExclude` to it:

<!-- compile -->
```cangjie
import std.deriving.*

@Derive[ToString]
struct S {
    S(let id: Int) {
        key = "s_${id}"
    }

    @DeriveExclude
    let key: String
}
```

By default, properties are not processed and require inclusion via `@DeriveInclude`.

<!-- compile -->
```cangjie
import std.deriving.*

@Derive[ToString]
struct S {
    S(let id: Int) {}

    @DeriveInclude
    prop key: String {
        get() {
            "s_${id}"
        }
    }
}
```

Fields and properties being derived cannot be `private`. Therefore, `private` fields or properties should either be excluded or made package-visible.

> **Note**
> 
> Static fields and properties are always ignored, so they cannot be modified by `@DeriveInclude` or `@DeriveExclude`.

## Supported Interfaces

Currently, only the following interfaces are supported:

- `ToString`
- `Hashable`
- `Equatable`
- `Comparable`

Custom interfaces are not yet supported.

## Changing Order

When sorting and comparing instances of complex types with multiple fields, the testing order of fields is often important. By default, all fields are considered in declaration order. The `@DeriveOrder` macro can modify this order.

<!-- run -->
```cangjie
import std.deriving.*
import std.sort.*

@Derive[Comparable, ToString]
struct Floor {
    Floor(
        let level: Int,
        let building: Int
    ) {}
}

main() {
    let floors = [
        Floor(1, 2),
        Floor(3, 2),
        Floor(2, 1)
    ]
    sort(floors)
    for (f in floors) {
        println(f)
    }
}
```

The above example will print the following, showing that order doesn't significantly affect the outcome:

```plain
Floor(level = 1, building = 2)
Floor(level = 2, building = 1)
Floor(level = 3, building = 2)
```

However, when implementing `Comparable`, different orders will affect results.

<!-- compile -->
```cangjie
import std.deriving.*

@Derive[Comparable, ToString]
@DeriveOrder[building, level]
struct Floor {
    Floor(
        let level: Int,
        let building: Int
    ) {}
}
```

Now, results will first sort by `building`, then by `level`:

```plain
Floor(building = 1, level = 2)
Floor(building = 2, level = 1)
Floor(building = 2, level = 3)
```

## Generics

Implementing interfaces for generic types typically requires applying constraints so types only implement interfaces under certain conditions. For example:

<!-- compile -->
```cangjie
class Cell<T> {
    Cell(let value: T) {}
}
```

Here, you might want the cell to be printable only when its value is printable. To achieve this, write an extension with constraints:

<!-- compile -->
```cangjie
class Cell<T> {
    Cell(let value: T) {}
}

extend<T> Cell<T> <: ToString where T <: ToString {
    public func toString(): String {
        "Cell(value = ${value})"
    }
}
```

When using Deriving, it attempts to apply constraints to all generic parameters by default, making the following equivalent to the above extension:

<!-- compile -->
```cangjie
import std.deriving.*

@Derive[ToString]
class Cell<T> {
    Cell(let value: T) {}
}
```

However, default behavior may not always be desirable. In such cases, use `where` inside `@Derive` to override default constraints:

<!-- compile -->
```cangjie
import std.deriving.*

interface PrintableCellValue <: ToString { /*...*/ }

@Derive[ToString where T <: PrintableCellValue]
class Cell<T> {}
```

Note that in the above example, custom constraints only apply to `ToString`. If constraints are needed for all interfaces, this action must be repeated separately for each interface.

<!-- compile -->
```cangjie
import std.deriving.*

interface PrintableCellValue <: ToString { /*...*/ }

@Derive[ToString where T <: PrintableCellValue]
@Derive[Hashable where T <: PrintableCellValue & Hashable]
class Cell<T> {}
```

## Performance Notes

Since Deriving is based on Cangjie macros and does not involve any reflection, its runtime performance is comparable to handwritten implementations. However, Deriving involves compile-time code transformation, which may impact compilation time.