# DateTime Comparison

This example compares time between China Standard Time (CST, timezone ID "Asia/Shanghai") and Eastern Daylight Time (EDT, timezone ID "America/New_York").

> **Note:**
>
> The example uses the [TimeZone.load](../time_package_api/time_package_classes.md#static-func-loadstring) function to load timezone information. Loading timezone information has different dependencies across platforms, and users need to configure accordingly.

<!-- verify -->

```cangjie
import std.time.*

main() {
    let tzSH = TimeZone.load("Asia/Shanghai")
    let tzNY = TimeZone.load("America/New_York")
    // 2024-05-25T00:00:00Z
    let shanghai1 = DateTime.of(year: 2024, month: May, dayOfMonth: 25, hour: 8, timeZone: tzSH)
    let new_york1 = DateTime.of(year: 2024, month: May, dayOfMonth: 24, hour: 20, timeZone: tzNY)

    // 2024-05-25T01:00:00Z
    let shanghai2 = DateTime.of(year: 2024, month: May, dayOfMonth: 25, hour: 9, timeZone: tzSH)
    let new_york2 = DateTime.of(year: 2024, month: May, dayOfMonth: 24, hour: 21, timeZone: tzNY)

    println(shanghai1 == new_york1)
    println(shanghai1 != new_york2)
    println(shanghai1 <= new_york2)
    println(shanghai1 < new_york2)
    println(shanghai2 >= new_york1)
    println(shanghai2 > new_york1)
}
```

Execution result:

```text
true
true
true
true
true
true
```