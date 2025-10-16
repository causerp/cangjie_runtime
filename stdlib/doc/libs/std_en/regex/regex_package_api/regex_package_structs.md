# Structs

## struct MatchData

```cangjie
public struct MatchData {}
```

Function: Stores regular expression matching results and provides functions to query the matching results.

### func groupCount()

```cangjie
public func groupCount(): Int64
```

Function: Gets the number of capturing groups.

Return value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The number of capturing groups.

Example:

<!-- verify -->
```cangjie
import std.regex.*

main(): Unit {
    let r = Regex(#"(?<year>\d{4})-(?<month>\d{2})-(?<day>\d{2})"#)
    let iter = r.lazyFindAll("2024-10-24&2025-01-01", group: true)
    while (true) {
        match (iter.next()) {
            case Some(md) => println("# found: `${md.matchString()}` and groupCount: ${md.groupCount()}")
            case None => break
        }
    }
}
```

Execution result:

```text
# found: `2024-10-24` and groupCount: 3
# found: `2025-01-01` and groupCount: 3
```

### func groupNumber() <sup>(deprecated)</sup>

```cangjie
public func groupNumber(): Int64
```

Function: Gets the number of capturing groups.

> **Note:**
>
> Will be deprecated in future versions, use [groupCount()](#func-groupcount) instead.

Return value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The number of capturing groups.

### func matchPosition()

```cangjie
public func matchPosition(): Position
```

Function: Gets the start and end indices of the last matched substring in the input string.

Return value:

- [Position](#struct-position) - Position information of the matching result.

Example:

<!-- verify -->
```cangjie
import std.regex.*

main(): Unit {
    let r = Regex(#"(?<year>\d{4})-(?<month>\d{2})-(?<day>\d{2})"#)
    let iter = r.lazyFindAll("2024-10-24&2025-01-01", group: true)
    while (true) {
        match (iter.next()) {
            case Some(md) =>
                println("# found: ${md.matchString()} and groupCount: ${md.groupCount()}")
                let pos = md.matchPosition(0)
                println("pos: [${pos.start}, ${pos.end}]")
            case None => break
        }
    }
}
```

Execution result:

```text
# found: 2024-10-24 and groupCount: 3
pos: [0, 10]
# found: 2025-01-01 and groupCount: 3
pos: [11, 21]
```

### func matchPosition(Int64)

```cangjie
public func matchPosition(group: Int64): Position
```

Function: Gets the position information of the substring matched by the specified capturing group in the last match based on the given index.

Parameters:

- group: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Specified group.

Return value:

- [Position](#struct-position) - Position information of the corresponding capturing group.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception when capturing group extraction is not enabled, or when group is less than 0 or greater than groupCount.

Example:

<!-- verify -->
```cangjie
import std.regex.*

main(): Unit {
    let r = Regex(#"(?<year>\d{4})-(?<month>\d{2})-(?<day>\d{2})"#)
    let iter = r.lazyFindAll("2024-10-24&2025-01-01", group: true)
    while (true) {
        match (iter.next()) {
            case Some(md) =>
                println("# found: ${md.matchString()} and groupCount: ${md.groupCount()}")
                /* The capturing group index for month is 2 */
                let pos = md.matchPosition(2)
                println("# month: [${pos.start}, ${pos.end}]")
            case None => break
        }
    }
}
```

Execution result:

```text
# found: 2024-10-24 and groupCount: 3
# month: [5, 7]
# found: 2025-01-01 and groupCount: 3
# month: [16, 18]
```

### func matchPosition(String)

```cangjie
public func matchPosition(group: String): Position
```

Function: Gets the position information of the substring matched by the specified named capturing group in the last match based on the given name.

Parameters:

- group: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Name of the specified named capturing group.

Return value:

- [Position](#struct-position) - Position information of the corresponding capturing group.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception when capturing group extraction is not enabled, or when the capturing group name does not exist.

Example:

<!-- verify -->
```cangjie
import std.regex.*

main(): Unit {
    let r = Regex(#"(?<year>\d{4})-(?<month>\d{2})-(?<day>\d{2})"#)
    let iter = r.lazyFindAll("2024-10-24&2025-01-01", group: true)
    while (true) {
        match (iter.next()) {
            case Some(md) =>
                println("# found: ${md.matchString()} and groupCount: ${md.groupCount()}")
                let pos = md.matchPosition("year")
                println("year: [${pos.start}, ${pos.end}]")
            case None => break
        }
    }
}
```

Execution result:

```text
# found: 2024-10-24 and groupCount: 3
year: [0, 4]
# found: 2025-01-01 and groupCount: 3
year: [11, 15]
```

### func matchString()

```cangjie
public func matchString(): String
```

Function: Gets the last matched substring, equivalent to calling matchString(0).

Return value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The matched substring.

Example:

<!-- verify -->
```cangjie
import std.regex.*

main(): Unit {
    let r1 = Regex("ab")
    let r2 = Regex("ab", IgnoreCase)
    match (r1.find("aB")) {
        case Some(r) => println(r.matchString())
        case None => println("None")
    }
    match (r2.find("aB")) {
        case Some(r) => println(r.matchString())
        case None => println("None")
    }
}
```

Execution result:

```text
None
aB
```

### func matchString(Int64)

```cangjie
public func matchString(group: Int64): String
```

Function: Gets the substring matched by the specified capturing group in the last match based on the given index.

Capturing group indices start from 1, where index 0 represents the entire regular expression match result.

Parameters:

- group: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Specified group.

Return value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The matched substring.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception when capturing group extraction is not enabled, or when group is less than 0 or greater than groupCount.

### func matchString(String)

```cangjie
public func matchString(group: String): String
```

Function: Gets the substring matched by the specified named capturing group in the last match based on the given name.

Parameters:

- group: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Name of the specified named capturing group.

Return value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The matched substring.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception when capturing group extraction is not enabled, or when the capturing group name does not exist.

## struct Position

```cangjie
public struct Position {
    public let end: Int64
    public let start: Int64
}
```

Function: Stores position information, representing a half-open interval [start, end).

### let end

```cangjie
public let end: Int64
```

Function: End position of the range.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### let start

```cangjie
public let start: Int64
```

Function: Starting position of the range.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)