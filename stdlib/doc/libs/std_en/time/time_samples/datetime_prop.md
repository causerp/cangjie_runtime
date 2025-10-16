# Retrieving Date and Time Information

This example demonstrates how to retrieve year, month, day, and other information from a datetime object.

> **Note:**
>
> The example uses the [TimeZone.load](../time_package_api/time_package_classes.md#static-func-loadstring) function to load timezone information. Loading timezone information has different dependencies across platforms, and users need to configure accordingly based on their requirements.

<!-- verify -->

```cangjie
import std.time.*

main() {
    let datetime = DateTime.of(
        year: 2024,
        month: May,
        dayOfMonth: 22,
        hour: 12,
        minute: 34,
        second: 56,
        nanosecond: 789000000,
        timeZone: TimeZone.load("Asia/Shanghai")
    )

    let yr = datetime.year
    let mon = datetime.month
    let day = datetime.dayOfMonth
    let hr = datetime.hour
    let min = datetime.minute
    let sec = datetime.second
    let ns = datetime.nanosecond
    let zoneId = datetime.zoneId
    let offset = datetime.zoneOffset
    let dayOfWeek = datetime.dayOfWeek
    let dayOfYear = datetime.dayOfYear
    let (isoYear, isoWeek) = datetime.isoWeek

    println("datetime is ${yr}, ${mon}, ${day}, ${hr}, ${min}, ${sec}, ${ns}, ${zoneId}, ${offset}")
    println("datetime.toString() = ${datetime}")
    println("${dayOfWeek}, ${dayOfYear}th day, ${isoWeek}th week of ${isoYear}")
}
```

Execution result:

```text
datetime is 2024, May, 22, 12, 34, 56, 789000000, Asia/Shanghai, 8h
datetime.toString() = 2024-05-22T12:34:56.789+08:00
Wednesday, 143th day, 21th week of 2024
```