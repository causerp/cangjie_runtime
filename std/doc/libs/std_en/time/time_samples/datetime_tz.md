# Local Time in Different Time Zones Simultaneously

This example demonstrates how to convert a China Standard Time to UTC and Eastern Daylight Time (EDT) for the same moment.

> **Note:**
>
> The example uses the [TimeZone.load](../time_package_api/time_package_classes.md#static-func-loadstring) function to load timezone information. Loading timezone data has different dependencies across platforms, and users need to configure them according to requirements.

<!-- verify -->

```cangjie
import std.time.*

main() {
    let datetime = DateTime.of(year: 2024, month: May, dayOfMonth: 22, hour: 12,
        timeZone: TimeZone.load("Asia/Shanghai"))

    println("CST: ${datetime}")
    println("UTC: ${datetime.inUTC()}")
    println("EDT: ${datetime.inTimeZone(TimeZone.load("America/New_York"))}")
}
```

Execution result:

```text
CST: 2024-05-22T12:00:00+08:00
UTC: 2024-05-22T04:00:00Z
EDT: 2024-05-22T00:00:00-04:00
```