# 获取日期时间信息

该示例演示了如何获取日期时间的年、月、日等信息。

> **说明：**
>
> 示例中使用 [TimeZone.load](../time_package_api/time_package_classes.md#static-func-loadstring) 函数加载时区信息，在不同平台上加载时区信息有不同的依赖，用户需按要求进行设置。

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

    // 获取日期相关信息
    let year = datetime.year
    let month = datetime.month
    let day = datetime.dayOfMonth
    println("年: ${year}, 月: ${month}, 日: ${day}")

    // 获取时间相关信息
    let hour = datetime.hour
    let minute = datetime.minute
    let second = datetime.second
    let nanosecond = datetime.nanosecond
    println("时: ${hour}, 分: ${minute}, 秒: ${second}, 纳秒: ${nanosecond}")

    // 获取时区相关信息
    let zoneId = datetime.zoneId
    let offset = datetime.zoneOffset
    println("时区 ID: ${zoneId}, 偏移: ${offset}")

    // 获取星期、一年中的第几天、ISO 周数等信息
    let dayOfWeek = datetime.dayOfWeek
    let dayOfYear = datetime.dayOfYear
    let (isoYear, isoWeek) = datetime.isoWeek
    println("datetime.toString() = ${datetime}")
    println("${dayOfWeek}, 第 ${dayOfYear} 天, ${isoYear} 年第 ${isoWeek} 周")
}
```

运行结果：

```text
年: 2024, 月: May, 日: 22
时: 12, 分: 34, 秒: 56, 纳秒: 789000000
时区 ID: Asia/Shanghai, 偏移: 8h
datetime.toString() = 2024-05-22T12:34:56.789+08:00
Wednesday, 第 143 天, 2024 年第 21 周
```
