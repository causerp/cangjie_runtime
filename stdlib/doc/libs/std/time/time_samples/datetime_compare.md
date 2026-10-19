# DateTime 比较

该示例选取中国标准时间（CST，时区 ID 为“Asia/Shanghai”）和美国东部夏令时时间（EDT，时区 ID 为“America/New_York”）进行时间比较。

> **说明：**
>
> 示例中使用 [TimeZone.load](../time_package_api/time_package_classes.md#static-func-loadstring) 函数加载时区信息，在不同平台上加载时区信息有不同的依赖，用户需按要求进行设置。

<!-- verify -->
```cangjie
import std.time.*

main() {
    let shanghaiTimeZone = TimeZone.load("Asia/Shanghai")
    let newYorkTimeZone = TimeZone.load("America/New_York")

    // 上海 2024-05-25 08:00 与纽约 2024-05-24 20:00 是同一时刻（UTC 2024-05-25T00:00:00Z）
    let shanghai1 = DateTime.of(year: 2024, month: May, dayOfMonth: 25, hour: 8, timeZone: shanghaiTimeZone)
    let newYork1 = DateTime.of(year: 2024, month: May, dayOfMonth: 24, hour: 20, timeZone: newYorkTimeZone)

    // 上海 2024-05-25 09:00 与纽约 2024-05-24 21:00 是同一时刻（UTC 2024-05-25T01:00:00Z）
    let shanghai2 = DateTime.of(year: 2024, month: May, dayOfMonth: 25, hour: 9, timeZone: shanghaiTimeZone)
    let newYork2 = DateTime.of(year: 2024, month: May, dayOfMonth: 24, hour: 21, timeZone: newYorkTimeZone)

    // 六种比较运算
    println("两个时间相等: ${shanghai1 == newYork1}")
    println("两个时间不等: ${shanghai1 != newYork2}")
    println("小于等于: ${shanghai1 <= newYork2}")
    println("小于: ${shanghai1 < newYork2}")
    println("大于等于: ${shanghai2 >= newYork1}")
    println("大于: ${shanghai2 > newYork1}")
}
```

运行结果：

```text
两个时间相等: true
两个时间不等: true
小于等于: true
小于: true
大于等于: true
大于: true
```
