# 结构体

## struct DateTime

```cangjie
public struct DateTime <: ToString & Hashable & Comparable<DateTime> & Formattable & Parsable<DateTime>
```

功能：[DateTime](time_package_structs.md#struct-datetime) 表示日期时间，是一个描述某一时间点的时间类型，提供了基于时区的日期时间读取、计算、比较、转换，以及序列化和反序列化等功能。

- [DateTime](time_package_structs.md#struct-datetime) 是不可变的类型，包含了日期，时间和时区信息。可表示的时间区间为 [-999,999,999-01-01T00:00:00.000000000, 999,999,999-12-31T23:59:59.999999999]，该区间适用于任何合法的时区。
- 以下为 [DateTime](time_package_structs.md#struct-datetime) 中 [now](#static-func-nowtimezone) 和 [nowUTC](#static-func-nowutc) 函数获取当前时间使用的系统调用函数：

  | 系统    | 系统调用函数   | 时钟类型 |
  | ------- | ------------- |--------------- |
  | Linux       | clock_gettime | CLOCK_REALTIME |
  | Windows     | clock_gettime | CLOCK_REALTIME |
  | macOS       | clock_gettime | CLOCK_REALTIME |
  | OpenHarmony | clock_gettime | CLOCK_REALTIME |
  | HarmonyOS   | clock_gettime | CLOCK_REALTIME |
  | iOS         | clock_gettime | CLOCK_REALTIME |
  | Android     | clock_gettime | CLOCK_REALTIME |

父类型：

- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)
- [Hashable](../../core/core_package_api/core_package_interfaces.md#interface-hashable)
- [Comparable](../../core/core_package_api/core_package_interfaces.md#interface-comparablet)\<[DateTime](#struct-datetime)>
- [Formattable](../../convert/convert_package_api/convert_package_interfaces.md#interface-formattable)
- [Parsable](../../convert/convert_package_api/convert_package_interfaces.md#interface-parsablet)\<[DateTime](#struct-datetime)>

### static prop UnixEpoch

```cangjie
public static prop UnixEpoch: DateTime
```

功能：获取 Unix 时间纪元，即表示零时区 `1970 年 1 月 1 日 0 时 0 分 0 秒 0 纳秒` 的 [DateTime](time_package_structs.md#struct-datetime) 实例。

类型：[DateTime](time_package_structs.md#struct-datetime)

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 获取 Unix 时间纪元
    let epoch = DateTime.UnixEpoch
    println("Unix 时间纪元: ${epoch}")
    println("Unix 时间纪元的年份: ${epoch.year}")
    println("Unix 时间纪元的月份: ${epoch.month}")
    println("Unix 时间纪元的日期: ${epoch.dayOfMonth}")
    println("Unix 时间纪元的时区: ${epoch.zoneId}")
}
```

运行结果：

```text
Unix 时间纪元: 1970-01-01T00:00:00Z
Unix 时间纪元的年份: 1970
Unix 时间纪元的月份: January
Unix 时间纪元的日期: 1
Unix 时间纪元的时区: UTC
```

### prop date

```cangjie
public prop date: (Int64, Month, Int64)
```

功能：获取 [DateTime](time_package_structs.md#struct-datetime) 实例的年份、月份和当前月第几日。

类型：([Int64](../../core/core_package_api/core_package_intrinsics.md#int64),[Month](time_package_enums.md#enum-month), [Int64](../../core/core_package_api/core_package_intrinsics.md#int64))

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建一个 DateTime 实例
    let datetime = DateTime.of(
        year: 2024,
        month: May,
        dayOfMonth: 22,
        timeZone: TimeZone.UTC
    )

    // 获取日期信息
    let (year, month, day) = datetime.date
    println("日期信息: ${year}年 ${month} ${day}日")
}
```

运行结果：

```text
日期信息: 2024年 May 22日
```

### prop dayOfMonth

```cangjie
public prop dayOfMonth: Int64
```

功能：获取 [DateTime](time_package_structs.md#struct-datetime) 实例基于当前月第几日。

类型：[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建一个 DateTime 实例
    let datetime = DateTime.of(
        year: 2024,
        month: May,
        dayOfMonth: 22,
        timeZone: TimeZone.UTC
    )

    // 获取日期信息
    println("DateTime 实例: ${datetime}")
    println("当前月的第几天: ${datetime.dayOfMonth}")
}
```

运行结果：

```text
DateTime 实例: 2024-05-22T00:00:00Z
当前月的第几天: 22
```

### prop dayOfWeek

```cangjie
public prop dayOfWeek: DayOfWeek
```

功能：获取 [DateTime](time_package_structs.md#struct-datetime) 实例基于当前周的第几日。

类型：[DayOfWeek](time_package_enums.md#enum-dayofweek)

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建一个 DateTime 实例
    let datetime = DateTime.of(
        year: 2024,
        month: May,
        dayOfMonth: 22,
        timeZone: TimeZone.UTC
    )

    // 获取星期信息
    println("DateTime 实例: ${datetime}")
    println("当前周的第几天: ${datetime.dayOfWeek}")
    println("当前周的第几天(整数表示): ${datetime.dayOfWeek.toInteger()}")
}
```

运行结果：

```text
DateTime 实例: 2024-05-22T00:00:00Z
当前周的第几天: Wednesday
当前周的第几天(整数表示): 3
```

### prop dayOfYear

```cangjie
public prop dayOfYear: Int64
```

功能：获取 [DateTime](time_package_structs.md#struct-datetime) 实例基于当前年份的第几日。

类型：[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建一个 DateTime 实例
    let datetime = DateTime.of(
        year: 2024,
        month: May,
        dayOfMonth: 22,
        timeZone: TimeZone.UTC
    )

    // 获取年内天数信息
    println("DateTime 实例: ${datetime}")
    println("当前年的第几天: ${datetime.dayOfYear}")
}
```

运行结果：

```text
DateTime 实例: 2024-05-22T00:00:00Z
当前年的第几天: 143
```

### prop hour

```cangjie
public prop hour: Int64
```

功能：获取 [DateTime](time_package_structs.md#struct-datetime) 实例的小时。

类型：[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建一个 DateTime 实例
    let datetime = DateTime.of(
        year: 2024,
        month: May,
        dayOfMonth: 22,
        hour: 12,
        minute: 34,
        timeZone: TimeZone.UTC
    )

    // 获取小时信息
    println("DateTime 实例: ${datetime}")
    println("小时: ${datetime.hour}")
}
```

运行结果：

```text
DateTime 实例: 2024-05-22T12:34:00Z
小时: 12
```

### prop isoWeek

```cangjie
public prop isoWeek: (Int64, Int64)
```

功能：获取 [DateTime](time_package_structs.md#struct-datetime) 实例基于 ISO8601 标准的年份和基于年的周数。

类型：([Int64](../../core/core_package_api/core_package_intrinsics.md#int64), [Int64](../../core/core_package_api/core_package_intrinsics.md#int64))

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建一个 DateTime 实例
    let datetime = DateTime.of(
        year: 2024,
        month: May,
        dayOfMonth: 22,
        timeZone: TimeZone.UTC
    )

    // 获取ISO周信息
    let (isoYear, isoWeek) = datetime.isoWeek
    println("DateTime 实例: ${datetime}")
    println("ISO年份: ${isoYear}")
    println("ISO周数: ${isoWeek}")
}
```

运行结果：

```text
DateTime 实例: 2024-05-22T00:00:00Z
ISO年份: 2024
ISO周数: 21
```

### prop minute

```cangjie
public prop minute: Int64
```

功能：获取 [DateTime](time_package_structs.md#struct-datetime) 实例的分钟。

类型：[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建一个 DateTime 实例
    let datetime = DateTime.of(
        year: 2024,
        month: May,
        dayOfMonth: 22,
        hour: 12,
        minute: 34,
        timeZone: TimeZone.UTC
    )

    // 获取分钟信息
    println("DateTime 实例: ${datetime}")
    println("分钟: ${datetime.minute}")
}
```

运行结果：

```text
DateTime 实例: 2024-05-22T12:34:00Z
分钟: 34
```

### prop month

```cangjie
public prop month: Month
```

功能：获取 [DateTime](time_package_structs.md#struct-datetime) 实例的月份。

类型：[Month](time_package_enums.md#enum-month)

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建一个 DateTime 实例
    let datetime = DateTime.of(
        year: 2024,
        month: May,
        dayOfMonth: 22,
        timeZone: TimeZone.UTC
    )

    // 获取月份信息
    println("DateTime 实例: ${datetime}")
    println("月份: ${datetime.month}")
    println("月份(整数表示): ${datetime.month.toInteger()}")
}
```

运行结果：

```text
DateTime 实例: 2024-05-22T00:00:00Z
月份: May
月份(整数表示): 5
```

### prop monthValue <sup>(deprecated)</sup>

```cangjie
public prop monthValue: Int64
```

功能：获取 [DateTime](time_package_structs.md#struct-datetime) 实例以数字形式表示的月份。

> **注意：**
>
> 未来版本即将废弃不再使用。

类型：[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建一个 DateTime 实例
    let datetime = DateTime.of(
        year: 2024,
        month: May,
        dayOfMonth: 22,
        timeZone: TimeZone.UTC
    )

    // 获取月份信息（已废弃的属性）
    println("DateTime 实例: ${datetime}")
    println("月份(整数表示，已废弃): ${datetime.monthValue}")

    // 推荐使用 month.toInteger() 替代
    println("推荐使用 month.toInteger() 替代 monthValue")
    println("月份(整数表示，推荐方式): ${datetime.month.toInteger()}")
}
```

运行结果：

```text
DateTime 实例: 2024-05-22T00:00:00Z
月份(整数表示，已废弃): 5
推荐使用 month.toInteger() 替代 monthValue
月份(整数表示，推荐方式): 5
```

### prop nanosecond

```cangjie
public prop nanosecond: Int64
```

功能：获取 [DateTime](time_package_structs.md#struct-datetime) 实例的纳秒。

类型：[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建一个 DateTime 实例
    let datetime = DateTime.of(
        year: 2024,
        month: May,
        dayOfMonth: 22,
        hour: 12,
        minute: 34,
        second: 56,
        nanosecond: 789000000,
        timeZone: TimeZone.UTC
    )

    // 获取纳秒信息
    println("DateTime 实例: ${datetime}")
    println("纳秒: ${datetime.nanosecond}")
}
```

运行结果：

```text
DateTime 实例: 2024-05-22T12:34:56.789Z
纳秒: 789000000
```

### prop second

```cangjie
public prop second: Int64
```

功能：获取 [DateTime](time_package_structs.md#struct-datetime) 实例的秒。

类型：[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建一个 DateTime 实例
    let datetime = DateTime.of(
        year: 2024,
        month: May,
        dayOfMonth: 22,
        hour: 12,
        minute: 34,
        second: 56,
        timeZone: TimeZone.UTC
    )

    // 获取秒信息
    println("DateTime 实例: ${datetime}")
    println("秒: ${datetime.second}")
}
```

运行结果：

```text
DateTime 实例: 2024-05-22T12:34:56Z
秒: 56
```

### prop time

```cangjie
public prop time: (Int64, Int64, Int64)
```

功能：获取 [DateTime](time_package_structs.md#struct-datetime) 实例的时、分、秒。

类型：([Int64](../../core/core_package_api/core_package_intrinsics.md#int64),[Int64](../../core/core_package_api/core_package_intrinsics.md#int64), [Int64](../../core/core_package_api/core_package_intrinsics.md#int64))

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建一个 DateTime 实例
    let datetime = DateTime.of(
        year: 2024,
        month: May,
        dayOfMonth: 22,
        hour: 12,
        minute: 34,
        second: 56,
        timeZone: TimeZone.UTC
    )

    // 获取时间信息
    let (hour, minute, second) = datetime.time
    println("DateTime 实例: ${datetime}")
    println("时间信息: ${hour}时 ${minute}分 ${second}秒")
}
```

运行结果：

```text
DateTime 实例: 2024-05-22T12:34:56Z
时间信息: 12时 34分 56秒
```

### prop year

```cangjie
public prop year: Int64
```

功能：获取 [DateTime](time_package_structs.md#struct-datetime) 实例的年份。

类型：[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建一个 DateTime 实例
    let datetime = DateTime.of(
        year: 2024,
        month: May,
        dayOfMonth: 22,
        timeZone: TimeZone.UTC
    )

    // 获取年份信息
    println("DateTime 实例: ${datetime}")
    println("年份: ${datetime.year}")
}
```

运行结果：

```text
DateTime 实例: 2024-05-22T00:00:00Z
年份: 2024
```

### prop zone

```cangjie
public prop zone: TimeZone
```

功能：获取 [DateTime](time_package_structs.md#struct-datetime) 实例所关联的时区。

类型：[TimeZone](time_package_classes.md#class-timezone)

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建一个 DateTime 实例
    let datetime = DateTime.of(
        year: 2024,
        month: May,
        dayOfMonth: 22,
        hour: 12,
        minute: 34,
        second: 56,
        nanosecond: 789000000,
        timeZone: TimeZone.UTC
    )

    // 获取时区信息
    println("DateTime 实例: ${datetime}")
    println("时区: ${datetime.zone}")
    println("时区ID: ${datetime.zoneId}")
    println("时区偏移: ${datetime.zoneOffset}")
}
```

运行结果：

```text
DateTime 实例: 2024-05-22T12:34:56.789Z
时区: UTC
时区ID: UTC
时区偏移: 0s
```

### prop zoneId

```cangjie
public prop zoneId: String
```

功能：获取 [DateTime](time_package_structs.md#struct-datetime) 实例所关联的 [TimeZone](time_package_classes.md#class-timezone) 实例的时区 ID。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建一个 DateTime 实例
    let datetime = DateTime.of(
        year: 2024,
        month: May,
        dayOfMonth: 22,
        hour: 12,
        minute: 34,
        second: 56,
        nanosecond: 789000000,
        timeZone: TimeZone.UTC
    )

    // 获取时区ID信息
    println("DateTime 实例: ${datetime}")
    println("时区ID: ${datetime.zoneId}")
}
```

运行结果：

```text
DateTime 实例: 2024-05-22T12:34:56.789Z
时区ID: UTC
```

### prop zoneOffset

```cangjie
public prop zoneOffset: Duration
```

功能：获取 [DateTime](time_package_structs.md#struct-datetime) 实例所关联的 [TimeZone](time_package_classes.md#class-timezone) 实例的时间偏移。

类型：[Duration](../../core/core_package_api/core_package_structs.md#struct-duration)

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建一个 DateTime 实例
    let datetime = DateTime.of(
        year: 2024,
        month: May,
        dayOfMonth: 22,
        hour: 12,
        minute: 34,
        second: 56,
        nanosecond: 789000000,
        timeZone: TimeZone.UTC
    )

    // 获取时区偏移信息
    println("DateTime 实例: ${datetime}")
    println("时区偏移: ${datetime.zoneOffset}")
}
```

运行结果：

```text
DateTime 实例: 2024-05-22T12:34:56.789Z
时区偏移: 0s
```

### static func fromUnixTimeStamp(Duration)

```cangjie
public static func fromUnixTimeStamp(d: Duration): DateTime
```

功能：获取自 [UnixEpoch](#static-prop-unixepoch) 开始，参数 `d` 指定时间间隔后的日期时间。

参数：

- d: [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - 时间间隔。

返回值：

- [DateTime](time_package_structs.md#struct-datetime) - 自 [UnixEpoch](#static-prop-unixepoch) 开始，指定 `d` 后的日期时间。

异常：

- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - 当结果超过日期时间的表示范围时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建一个 Duration 实例，表示从 Unix 纪元开始的时间间隔
    let duration = 1000 * Duration.second // 1000秒

    // 使用 fromUnixTimeStamp 函数创建 DateTime 实例
    let datetime = DateTime.fromUnixTimeStamp(duration)

    println("时间间隔: ${duration}")
    println("对应的 DateTime: ${datetime}")
    println("年份: ${datetime.year}")
    println("月份: ${datetime.month}")
    println("日期: ${datetime.dayOfMonth}")
    println("小时: ${datetime.hour}")
    println("分钟: ${datetime.minute}")
    println("秒: ${datetime.second}")
}
```

运行结果：

```text
时间间隔: 16m40s
对应的 DateTime: 1970-01-01T00:16:40Z
年份: 1970
月份: January
日期: 1
小时: 0
分钟: 16
秒: 40
```

### static func now(TimeZone)

```cangjie
public static func now(timeZone!: TimeZone = TimeZone.Local): DateTime
```

功能：获取参数 `timeZone` 指定时区的当前时间。该方法获取的当前时间受系统时间影响，如存在使用不受系统时间影响的计时场景，可使用 [MonoTime](time_package_structs.md#struct-monotime).now() 替代。

参数：

- timeZone!: [TimeZone](time_package_classes.md#class-timezone) - 时区，默认为本地时区。

返回值：

- [DateTime](time_package_structs.md#struct-datetime) - 返回指定时区当前时间。

示例：

<!-- run -->
```cangjie
import std.time.*

main() {
    // 获取本地时区的当前时间
    let localTime = DateTime.now()
    println("本地时区当前时间: ${localTime}")

    // 获取 UTC 时区的当前时间
    let utcTime = DateTime.now(timeZone: TimeZone.UTC)
    println("UTC时区当前时间: ${utcTime}")

    // 获取本地时区时间
    let localTimeExplicit = DateTime.now(timeZone: TimeZone.Local)
    println("显式指定本地时区时间: ${localTimeExplicit}")
}
```

可能的运行结果：

```text
本地时区当前时间: 2025-12-17T11:08:59.840002825+08:00
UTC时区当前时间: 2025-12-17T03:08:59.840035743Z
显式指定本地时区时间: 2025-12-17T11:08:59.840040297+08:00
```

### static func nowUTC()

```cangjie
public static func nowUTC(): DateTime
```

功能：获取 UTC 时区的当前时间。该方法获取的当前时间受系统时间影响，如存在使用不受系统时间影响的计时场景，可使用 [MonoTime](time_package_structs.md#struct-monotime).now() 替代。

返回值：

- [DateTime](time_package_structs.md#struct-datetime) - UTC 时区当前时间。

示例：

<!-- run -->
```cangjie
import std.time.*

main() {
    // 获取 UTC 时区的当前时间
    let utcTime = DateTime.nowUTC()
    println("UTC时区当前时间: ${utcTime}")

    // 显示详细信息
    println("年份: ${utcTime.year}")
    println("月份: ${utcTime.month}")
    println("日期: ${utcTime.dayOfMonth}")
    println("小时: ${utcTime.hour}")
    println("分钟: ${utcTime.minute}")
    println("秒: ${utcTime.second}")
    println("纳秒: ${utcTime.nanosecond}")
    println("时区ID: ${utcTime.zoneId}")
}
```

可能的运行结果：

```text
UTC时区当前时间: 2025-12-17T03:09:39.59772355Z
年份: 2025
月份: December
日期: 17
小时: 3
分钟: 9
秒: 39
纳秒: 597723550
时区ID: UTC
```

### static func of(Int64, Int64, Int64, Int64, Int64, Int64, Int64, TimeZone)

```cangjie
public static func of(
    year!: Int64,
    month!: Int64,
    dayOfMonth!: Int64,
    hour!: Int64 = 0,
    minute!: Int64 = 0,
    second!: Int64 = 0,
    nanosecond!: Int64 = 0,
    timeZone!: TimeZone = TimeZone.Local
): DateTime
```

功能：根据参数指定的年、月、日、时、分、秒、纳秒、时区构造 [DateTime](time_package_structs.md#struct-datetime) 实例。

参数：

- year!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 年，范围[-999,999,999, 999,999,999]。
- month!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 月，范围[1, 12]。
- dayOfMonth!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 日，范围[1, 31]，最大取值需要跟 month 匹配，可能是 28、29、30、31。
- hour!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 时，范围[0, 23]。
- minute!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 分，范围[0, 59]。
- second!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 秒，范围[0, 59]。
- nanosecond!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 纳秒，范围[0, 999,999,999]。
- timeZone!: [TimeZone](time_package_classes.md#class-timezone) - 时区。

返回值：

- [DateTime](time_package_structs.md#struct-datetime) - 根据指定参数构造的 [DateTime](time_package_structs.md#struct-datetime) 实例。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 当参数值超出指定范围，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 使用整数参数创建 DateTime 实例
    let datetime = DateTime.of(
        year: 2024,
        month: 5, // 5月
        dayOfMonth: 22,
        hour: 12,
        minute: 34,
        second: 56,
        nanosecond: 789000000,
        timeZone: TimeZone.UTC
    )

    println("创建的 DateTime: ${datetime}")
    println("年份: ${datetime.year}")
    println("月份: ${datetime.month}")
    println("日期: ${datetime.dayOfMonth}")
    println("小时: ${datetime.hour}")
    println("分钟: ${datetime.minute}")
    println("秒: ${datetime.second}")
    println("纳秒: ${datetime.nanosecond}")
    println("时区ID: ${datetime.zoneId}")
}
```

运行结果：

```text
创建的 DateTime: 2024-05-22T12:34:56.789Z
年份: 2024
月份: May
日期: 22
小时: 12
分钟: 34
秒: 56
纳秒: 789000000
时区ID: UTC
```

### static func of(Int64, Month, Int64, Int64, Int64, Int64, Int64, TimeZone)

```cangjie
public static func of(
    year!: Int64,
    month!: Month,
    dayOfMonth!: Int64,
    hour!: Int64 = 0,
    minute!: Int64 = 0,
    second!: Int64 = 0,
    nanosecond!: Int64 = 0,
    timeZone!: TimeZone = TimeZone.Local
): DateTime
```

功能：根据参数指定的年、月、日、时、分、秒、纳秒、时区构造 [DateTime](time_package_structs.md#struct-datetime) 实例。

参数：

- year!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 年，范围[-999,999,999, 999,999,999]。
- month!: [Month](time_package_enums.md#enum-month) - 月，[Month](time_package_enums.md#enum-month) 类型。
- dayOfMonth!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 日，范围[1, 31]，最大取值需要跟 month 匹配，可能是 28、29、30、31。
- hour!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 时，范围[0, 23]。
- minute!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 分，范围[0, 59]。
- second!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 秒，范围[0, 59]。
- nanosecond!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 纳秒，范围[0, 999,999,999]。
- timeZone!: [TimeZone](time_package_classes.md#class-timezone) - 时区。

返回值：

- [DateTime](time_package_structs.md#struct-datetime) - 根据指定参数构造的 [DateTime](time_package_structs.md#struct-datetime) 实例。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 当参数值超出指定范围，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 使用 Month 枚举参数创建 DateTime 实例
    let datetime = DateTime.of(
        year: 2024,
        month: May, // 使用 Month 枚举
        dayOfMonth: 22,
        hour: 12,
        minute: 34,
        second: 56,
        nanosecond: 789000000,
        timeZone: TimeZone.UTC
    )

    println("创建的 DateTime: ${datetime}")
    println("年份: ${datetime.year}")
    println("月份: ${datetime.month}")
    println("日期: ${datetime.dayOfMonth}")
    println("小时: ${datetime.hour}")
    println("分钟: ${datetime.minute}")
    println("秒: ${datetime.second}")
    println("纳秒: ${datetime.nanosecond}")
    println("时区ID: ${datetime.zoneId}")
}
```

运行结果：

```text
创建的 DateTime: 2024-05-22T12:34:56.789Z
年份: 2024
月份: May
日期: 22
小时: 12
分钟: 34
秒: 56
纳秒: 789000000
时区ID: UTC
```

### static func ofEpoch(Int64, Int64)

```cangjie
public static func ofEpoch(second!: Int64, nanosecond!: Int64): DateTime
```

功能：基于 Unix 新纪元（[UnixEpoch](#static-prop-unixepoch)）时间戳创建 UTC 基准的 DateTime 实例，支持纳秒级高精度时间表示。

参数：

- second!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 从 1970-01-01 00:00:00 UTC 起至目标时间的总秒数（Unix 秒级时间戳）。
- nanosecond!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 秒级时间戳的纳秒偏移量，取值范围 0 ~ 999,999,999，用于补充秒以下的高精度时间。

返回值：

- [DateTime](time_package_structs.md#struct-datetime) - 对应时间戳的 UTC 时区 DateTime 对象。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 当 `nanosecond` 值超出[0, 999,999,999]范围时，抛出异常。
- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - 当结果超过日期时间的表示范围时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 使用 Unix 时间戳创建 DateTime 实例
    let datetime = DateTime.ofEpoch(
        second: 1000, // 1000秒
        nanosecond: 500000000 // 0.5秒
    )

    println("创建的 DateTime: ${datetime}")
    println("年份: ${datetime.year}")
    println("月份: ${datetime.month}")
    println("日期: ${datetime.dayOfMonth}")
    println("小时: ${datetime.hour}")
    println("分钟: ${datetime.minute}")
    println("秒: ${datetime.second}")
    println("纳秒: ${datetime.nanosecond}")
    println("时区ID: ${datetime.zoneId}")
}
```

运行结果：

```text
创建的 DateTime: 1970-01-01T00:16:40.5Z
年份: 1970
月份: January
日期: 1
小时: 0
分钟: 16
秒: 40
纳秒: 500000000
时区ID: UTC
```

### static func ofUTC(Int64, Int64, Int64, Int64, Int64, Int64, Int64)

```cangjie
public static func ofUTC(
    year!: Int64,
    month!: Int64,
    dayOfMonth!: Int64,
    hour!: Int64 = 0,
    minute!: Int64 = 0,
    second!: Int64 = 0,
    nanosecond!: Int64 = 0
): DateTime
```

功能：根据参数指定的年、月、日、时、分、秒、纳秒构造 `UTC` 时区 [DateTime](time_package_structs.md#struct-datetime) 实例。

参数：

- year!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 年，范围[-999,999,999, 999,999,999]。
- month!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 月，范围[1, 12]。
- dayOfMonth!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 日，范围[1, 31]，最大取值需要跟 month 匹配，可能是 28、29、30、31。
- hour!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 时，范围[0, 23]。
- minute!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 分，范围[0, 59]。
- second!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 秒，范围[0, 59]。
- nanosecond!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 纳秒，范围[0, 999,999,999]。

返回值：

- [DateTime](time_package_structs.md#struct-datetime) - 根据指定参数构造的 `UTC` 时区 [DateTime](time_package_structs.md#struct-datetime) 实例。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 当参数值超出指定范围时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 使用整数参数创建 UTC 时区的 DateTime 实例
    let datetime = DateTime.ofUTC(
        year: 2024,
        month: 5, // 5月
        dayOfMonth: 22,
        hour: 12,
        minute: 34,
        second: 56,
        nanosecond: 789000000
    )

    println("创建的 DateTime: ${datetime}")
    println("年份: ${datetime.year}")
    println("月份: ${datetime.month}")
    println("日期: ${datetime.dayOfMonth}")
    println("小时: ${datetime.hour}")
    println("分钟: ${datetime.minute}")
    println("秒: ${datetime.second}")
    println("纳秒: ${datetime.nanosecond}")
    println("时区ID: ${datetime.zoneId}")
}
```

运行结果：

```text
创建的 DateTime: 2024-05-22T12:34:56.789Z
年份: 2024
月份: May
日期: 22
小时: 12
分钟: 34
秒: 56
纳秒: 789000000
时区ID: UTC
```

### static func ofUTC(Int64, Month, Int64, Int64, Int64, Int64, Int64)

```cangjie
public static func ofUTC(
    year!: Int64,
    month!: Month,
    dayOfMonth!: Int64,
    hour!: Int64 = 0,
    minute!: Int64 = 0,
    second!: Int64 = 0,
    nanosecond!: Int64 = 0
): DateTime
```

功能：根据参数指定的年、月、日、时、分、秒、纳秒构造 `UTC` 时区 [DateTime](time_package_structs.md#struct-datetime) 实例。

参数：

- year!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 年，范围[-999,999,999, 999,999,999]。
- month!: [Month](time_package_enums.md#enum-month) - 月，[Month](time_package_enums.md#enum-month) 类型。
- dayOfMonth!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 日, 范围[1, 31]，最大取值需要跟 month 匹配，可能是 28、29、30、31。
- hour!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 时，范围[0, 23]。
- minute!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 分，范围[0, 59]。
- second!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 秒，范围[0, 59]。
- nanosecond!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 纳秒，范围[0, 999,999,999]。

返回值：

- [DateTime](time_package_structs.md#struct-datetime) - 根据指定参数构造的 `UTC` 时区 [DateTime](time_package_structs.md#struct-datetime) 实例。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 当参数值超出指定范围时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 使用 Month 枚举参数创建 UTC 时区的 DateTime 实例
    let datetime = DateTime.ofUTC(
        year: 2024,
        month: May, // 使用 Month 枚举
        dayOfMonth: 22,
        hour: 12,
        minute: 34,
        second: 56,
        nanosecond: 789000000
    )

    println("创建的 DateTime: ${datetime}")
    println("年份: ${datetime.year}")
    println("月份: ${datetime.month}")
    println("日期: ${datetime.dayOfMonth}")
    println("小时: ${datetime.hour}")
    println("分钟: ${datetime.minute}")
    println("秒: ${datetime.second}")
    println("纳秒: ${datetime.nanosecond}")
    println("时区ID: ${datetime.zoneId}")
}
```

运行结果：

```text
创建的 DateTime: 2024-05-22T12:34:56.789Z
年份: 2024
月份: May
日期: 22
小时: 12
分钟: 34
秒: 56
纳秒: 789000000
时区ID: UTC
```

### static func parse(String)

```cangjie
public static func parse(str: String): DateTime
```

功能：从参数 `str` 中解析得到时间，解析成功时返回 [DateTime](time_package_structs.md#struct-datetime) 实例。

参数：

- str: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 时间字符串，格式为 `RFC3339` 中 `date-time` 格式，可包含小数秒，如 "2023-04-10T08:00:00[.123456]+08:00"(`[]` 中的内容表示可选项)。

返回值：

- [DateTime](time_package_structs.md#struct-datetime) - 从参数 `str` 中解析出的 [DateTime](time_package_structs.md#struct-datetime) 实例。

异常：

- [TimeParseException](time_package_exceptions.md#class-timeparseexception) - 无法正常解析时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 从 RFC3339 格式的字符串解析 DateTime
    let datetimeStr = "2024-05-22T12:34:56.789Z"
    let datetime = DateTime.parse(datetimeStr)

    println("解析的字符串: ${datetimeStr}")
    println("解析的 DateTime: ${datetime}")
    println("年份: ${datetime.year}")
    println("月份: ${datetime.month}")
    println("日期: ${datetime.dayOfMonth}")
    println("小时: ${datetime.hour}")
    println("分钟: ${datetime.minute}")
    println("秒: ${datetime.second}")
    println("纳秒: ${datetime.nanosecond}")
    println("时区ID: ${datetime.zoneId}")
}
```

运行结果：

```text
解析的字符串: 2024-05-22T12:34:56.789Z
解析的 DateTime: 2024-05-22T12:34:56.789Z
年份: 2024
月份: May
日期: 22
小时: 12
分钟: 34
秒: 56
纳秒: 789000000
时区ID: GMT
```

### static func parse(String, DateTimeFormat) <sup>(deprecated)</sup>

```cangjie
public static func parse(str: String, format: DateTimeFormat): DateTime
```

功能：根据 `format` 指定的时间格式，从字符串 `str` 中解析得到时间，解析成功时返回 [DateTime](time_package_structs.md#struct-datetime) 实例。

> **注意：**
>
> 未来版本即将废弃，使用 [parse(String, String)](#static-func-parsestring-string) 替代。

参数：

- str: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 时间字符串，例如："2023/04/10 08:00:00 +08:00"。
- format: [DateTimeFormat](./time_package_classes.md#class-datetimeformat) - 时间格式，例如："yyyy/MM/dd HH:mm:ss OOOO"对应的时间格式。格式说明详见[时间字符串格式](../time_package_overview.md#时间字符串格式)。

返回值：

- [DateTime](time_package_structs.md#struct-datetime) - 根据参数 `format` 指定的时间格式，从参数 `str` 中解析出的 [DateTime](time_package_structs.md#struct-datetime) 实例。

异常：

- [TimeParseException](time_package_exceptions.md#class-timeparseexception) - 当无法正常解析时，或存在同一 `format` 的多次取值时，抛出异常。
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 当 `format` 格式不正确时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 使用已废弃的 of 方法创建 DateTimeFormat 实例
    let formatter = DateTimeFormat.of("yyyy/MM/dd HH:mm:ss z")
    // 使用已废弃的 parse 方法解析 DateTime
    let datetime = DateTime.parse("2024/05/22 12:34:56 UTC", formatter)
    println("DateTime: ${datetime}")
    println("年: ${datetime.year}")
    println("月: ${datetime.month}")
    println("日: ${datetime.dayOfMonth}")
    println("时: ${datetime.hour}")
    println("分: ${datetime.minute}")
    println("秒: ${datetime.second}")
}
```

运行结果：

```text
DateTime: 2024-05-22T12:34:56Z
年: 2024
月: May
日: 22
时: 12
分: 34
秒: 56
```

### static func parse(String, String)

```cangjie
public static func parse(str: String, format: String): DateTime
```

功能：根据 `format` 指定的时间格式，从字符串 `str` 中解析得到时间，解析成功时返回 [DateTime](time_package_structs.md#struct-datetime) 实例。

参数：

- str: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 时间字符串，例如："2023/04/10 08:00:00 +08:00"。
- format: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 时间字符串的格式，例如："yyyy/MM/dd HH:mm:ss OOOO"。格式说明详见[时间字符串格式](../time_package_overview.md#时间字符串格式)。

返回值：

- [DateTime](time_package_structs.md#struct-datetime) - 根据参数 `format` 指定的时间格式，从参数 `str` 中解析出的 [DateTime](time_package_structs.md#struct-datetime) 实例。

异常：

- [TimeParseException](time_package_exceptions.md#class-timeparseexception) - 当无法正常解析时，或存在同一 `format` 的多次取值时，抛出异常。
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 当 `format` 格式不正确时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 从自定义格式的字符串解析 DateTime
    let datetimeStr = "2024/05/22 12:34:56 +00:00"
    let format = "yyyy/MM/dd HH:mm:ss OOOO"
    let datetime = DateTime.parse(datetimeStr, format)

    println("解析的字符串: ${datetimeStr}")
    println("使用的格式: ${format}")
    println("解析的 DateTime: ${datetime}")
    println("年份: ${datetime.year}")
    println("月份: ${datetime.month}")
    println("日期: ${datetime.dayOfMonth}")
    println("小时: ${datetime.hour}")
    println("分钟: ${datetime.minute}")
    println("秒: ${datetime.second}")
    println("纳秒: ${datetime.nanosecond}")
    println("时区ID: ${datetime.zoneId}")
}
```

运行结果：

```text
解析的字符串: 2024/05/22 12:34:56 +00:00
使用的格式: yyyy/MM/dd HH:mm:ss OOOO
解析的 DateTime: 2024-05-22T12:34:56Z
年份: 2024
月份: May
日期: 22
小时: 12
分钟: 34
秒: 56
纳秒: 0
时区ID: GMT
```

### static func tryParse(String)

```cangjie
public static func tryParse(str: String): Option<DateTime>
```

功能：从参数 `str` 中解析得到时间，解析成功时返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[DateTime](time_package_structs.md#struct-datetime)> 实例。

参数：

- str: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 时间字符串，格式为 `RFC3339` 中 `date-time` 格式，可包含小数秒，如 "2023-04-10T08:00:00[.123456]+08:00"(`[]` 中的内容表示可选项)。

返回值：

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[DateTime](time_package_structs.md#struct-datetime)> - 从参数 `str` 中解析出的 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[DateTime](time_package_structs.md#struct-datetime)> 实例，如果解析失败返回 [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<DateTime>.None。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 尝试从 RFC3339 格式的字符串解析 DateTime
    let datetimeStr = "2024-05-22T12:34:56.789Z"
    let result = DateTime.tryParse(datetimeStr)

    println("解析的字符串: ${datetimeStr}")
    match (result) {
        case Some(datetime) => println("解析成功: ${datetime}")
        case None => println("解析失败")
    }
}
```

运行结果：

```text
解析的字符串: 2024-05-22T12:34:56.789Z
解析成功: 2024-05-22T12:34:56.789Z
```

### func addDays(Int64)

```cangjie
public func addDays(n: Int64): DateTime
```

功能：获取 [DateTime](time_package_structs.md#struct-datetime) 实例 `n` 天之后的时间，返回新的 [DateTime](time_package_structs.md#struct-datetime) 实例。

参数：

- n: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 自 [DateTime](time_package_structs.md#struct-datetime) 实例后多少天的数量。

返回值：

- [DateTime](time_package_structs.md#struct-datetime) - [DateTime](time_package_structs.md#struct-datetime) 实例 `n` 天后的时间。

异常：

- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - [DateTime](time_package_structs.md#struct-datetime) 实例 `n` 天后的日期时间超过表示范围时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建一个 DateTime 实例
    let datetime = DateTime.ofUTC(
        year: 2024,
        month: 5, // 5月
        dayOfMonth: 22,
        hour: 12,
        minute: 34,
        second: 56,
        nanosecond: 789000000
    )

    println("原始 DateTime: ${datetime}")

    // 添加 10 天
    let newDatetime = datetime.addDays(10)

    println("添加 10 天后: ${newDatetime}")
    println("年份: ${newDatetime.year}")
    println("月份: ${newDatetime.month}")
    println("日期: ${newDatetime.dayOfMonth}")
}
```

运行结果：

```text
原始 DateTime: 2024-05-22T12:34:56.789Z
添加 10 天后: 2024-06-01T12:34:56.789Z
年份: 2024
月份: June
日期: 1
```

### func addHours(Int64)

```cangjie
public func addHours(n: Int64): DateTime
```

功能：获取 [DateTime](time_package_structs.md#struct-datetime) 实例 `n` 小时之后的时间，返回新的 [DateTime](time_package_structs.md#struct-datetime) 实例。

参数：

- n: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 自 [DateTime](time_package_structs.md#struct-datetime) 实例后多少小时的数量。

返回值：

- [DateTime](time_package_structs.md#struct-datetime) - [DateTime](time_package_structs.md#struct-datetime) 实例 `n` 小时后的时间。

异常：

- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - [DateTime](time_package_structs.md#struct-datetime) 实例 `n` 小时后的日期时间超过表示范围时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建一个 DateTime 实例
    let datetime = DateTime.ofUTC(
        year: 2024,
        month: 5, // 5月
        dayOfMonth: 22,
        hour: 12,
        minute: 34,
        second: 56,
        nanosecond: 789000000
    )

    println("原始 DateTime: ${datetime}")

    // 添加 5 小时
    let newDatetime = datetime.addHours(5)

    println("添加 5 小时后: ${newDatetime}")
    println("小时: ${newDatetime.hour}")
    println("分钟: ${newDatetime.minute}")
}
```

运行结果：

```text
原始 DateTime: 2024-05-22T12:34:56.789Z
添加 5 小时后: 2024-05-22T17:34:56.789Z
小时: 17
分钟: 34
```

### func addMinutes(Int64)

```cangjie
public func addMinutes(n: Int64): DateTime
```

功能：获取 [DateTime](time_package_structs.md#struct-datetime) 实例 `n` 分钟之后的时间，返回新的 [DateTime](time_package_structs.md#struct-datetime) 实例。

参数：

- n: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 自 [DateTime](time_package_structs.md#struct-datetime) 实例后多少分钟的数量。

返回值：

- [DateTime](time_package_structs.md#struct-datetime) - [DateTime](time_package_structs.md#struct-datetime) 实例 `n` 分钟后的时间。

异常：

- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - [DateTime](time_package_structs.md#struct-datetime) 实例 `n` 分钟后的日期时间超过表示范围时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建一个 DateTime 实例
    let datetime = DateTime.ofUTC(
        year: 2024,
        month: 5, // 5月
        dayOfMonth: 22,
        hour: 12,
        minute: 34,
        second: 56,
        nanosecond: 789000000
    )

    println("原始 DateTime: ${datetime}")

    // 添加 30 分钟
    let newDatetime = datetime.addMinutes(30)

    println("添加 30 分钟后: ${newDatetime}")
    println("小时: ${newDatetime.hour}")
    println("分钟: ${newDatetime.minute}")
}
```

运行结果：

```text
原始 DateTime: 2024-05-22T12:34:56.789Z
添加 30 分钟后: 2024-05-22T13:04:56.789Z
小时: 13
分钟: 4
```

### func addMonths(Int64)

```cangjie
public func addMonths(n: Int64): DateTime
```

功能：获取 [DateTime](time_package_structs.md#struct-datetime) 实例 `n` 月之后的时间，返回新的 [DateTime](time_package_structs.md#struct-datetime) 实例。

> **注意：**
>
> 由于月的间隔不固定，若设 dt 表示 “2020 年 3 月 31 日”，`dt.addMonths(1)` 不会返回非法日期“2020 年 4 月 31 日”。为了尽量返回有效的日期，会偏移到当月最后一天，返回“2020 年 4 月 30 日”。

参数：

- n: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 自 [DateTime](time_package_structs.md#struct-datetime) 实例后多少月的数量。

返回值：

- [DateTime](time_package_structs.md#struct-datetime) - [DateTime](time_package_structs.md#struct-datetime) 实例 `n` 月后的时间。

异常：

- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - [DateTime](time_package_structs.md#struct-datetime) 实例 `n` 月后的日期时间超过表示范围时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建一个 DateTime 实例
    let datetime = DateTime.ofUTC(
        year: 2024,
        month: 5, // 5月
        dayOfMonth: 22,
        hour: 12,
        minute: 34,
        second: 56,
        nanosecond: 789000000
    )

    println("原始 DateTime: ${datetime}")

    // 添加 3 个月
    let newDatetime = datetime.addMonths(3)

    println("添加 3 个月后: ${newDatetime}")
    println("年份: ${newDatetime.year}")
    println("月份: ${newDatetime.month}")
    println("日期: ${newDatetime.dayOfMonth}")
}
```

运行结果：

```text
原始 DateTime: 2024-05-22T12:34:56.789Z
添加 3 个月后: 2024-08-22T12:34:56.789Z
年份: 2024
月份: August
日期: 22
```

### func addNanoseconds(Int64)

```cangjie
public func addNanoseconds(n: Int64): DateTime
```

功能：获取 [DateTime](time_package_structs.md#struct-datetime) 实例 `n` 纳秒之后的时间，返回新的 [DateTime](time_package_structs.md#struct-datetime) 实例。

参数：

- n: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 自 [DateTime](time_package_structs.md#struct-datetime) 实例后多少纳秒的数量。

返回值：

- [DateTime](time_package_structs.md#struct-datetime) - [DateTime](time_package_structs.md#struct-datetime) 实例 `n` 纳秒后的时间。

异常：

- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - [DateTime](time_package_structs.md#struct-datetime) 实例 `n` 纳秒后时间的日期时间超过表示范围时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建一个 DateTime 实例
    let datetime = DateTime.ofUTC(
        year: 2024,
        month: 5, // 5月
        dayOfMonth: 22,
        hour: 12,
        minute: 34,
        second: 56,
        nanosecond: 789000000
    )

    println("原始 DateTime: ${datetime}")

    // 添加 500000000 纳秒 (0.5 秒)
    let newDatetime = datetime.addNanoseconds(500000000)

    println("添加 500000000 纳秒后: ${newDatetime}")
    println("秒: ${newDatetime.second}")
    println("纳秒: ${newDatetime.nanosecond}")
}
```

运行结果：

```text
原始 DateTime: 2024-05-22T12:34:56.789Z
添加 500000000 纳秒后: 2024-05-22T12:34:57.289Z
秒: 57
纳秒: 289000000
```

### func addSeconds(Int64)

```cangjie
public func addSeconds(n: Int64): DateTime
```

功能：获取 [DateTime](time_package_structs.md#struct-datetime) 实例 `n` 秒之后的时间，返回新的 [DateTime](time_package_structs.md#struct-datetime) 实例。

参数：

- n: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 自 [DateTime](time_package_structs.md#struct-datetime) 实例后多少秒的数量。

返回值：

- [DateTime](time_package_structs.md#struct-datetime) - [DateTime](time_package_structs.md#struct-datetime) 实例 `n` 秒后的时间。

异常：

- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - [DateTime](time_package_structs.md#struct-datetime) 实例 `n` 秒后的日期时间超过表示范围时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建一个 DateTime 实例
    let datetime = DateTime.ofUTC(
        year: 2024,
        month: 5, // 5月
        dayOfMonth: 22,
        hour: 12,
        minute: 34,
        second: 56,
        nanosecond: 789000000
    )

    println("原始 DateTime: ${datetime}")

    // 添加 30 秒
    let newDatetime = datetime.addSeconds(30)

    println("添加 30 秒后: ${newDatetime}")
    println("分钟: ${newDatetime.minute}")
    println("秒: ${newDatetime.second}")
}
```

运行结果：

```text
原始 DateTime: 2024-05-22T12:34:56.789Z
添加 30 秒后: 2024-05-22T12:35:26.789Z
分钟: 35
秒: 26
```

### func addWeeks(Int64)

```cangjie
public func addWeeks(n: Int64): DateTime
```

功能：获取 [DateTime](time_package_structs.md#struct-datetime) 实例 `n` 周之后的时间，返回新的 [DateTime](time_package_structs.md#struct-datetime) 实例。

参数：

- n: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 自 [DateTime](time_package_structs.md#struct-datetime) 实例后多少周的数量。

返回值：

- [DateTime](time_package_structs.md#struct-datetime) - [DateTime](time_package_structs.md#struct-datetime) 实例 `n` 周后的时间。

异常：

功能：获取入参 n 周之后的时间，返回新的 [DateTime](time_package_structs.md#struct-datetime) 实例。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建一个 DateTime 实例
    let datetime = DateTime.ofUTC(
        year: 2024,
        month: 5, // 5月
        dayOfMonth: 22,
        hour: 12,
        minute: 34,
        second: 56,
        nanosecond: 789000000
    )

    println("原始 DateTime: ${datetime}")

    // 添加 2 周
    let newDatetime = datetime.addWeeks(2)

    println("添加 2 周后: ${newDatetime}")
    println("年份: ${newDatetime.year}")
    println("月份: ${newDatetime.month}")
    println("日期: ${newDatetime.dayOfMonth}")
}
```

运行结果：

```text
原始 DateTime: 2024-05-22T12:34:56.789Z
添加 2 周后: 2024-06-05T12:34:56.789Z
年份: 2024
月份: June
日期: 5
```

### func addYears(Int64)

```cangjie
public func addYears(n: Int64): DateTime
```

功能：获取 [DateTime](time_package_structs.md#struct-datetime) 实例 `n` 年之后的时间，返回新的 [DateTime](time_package_structs.md#struct-datetime) 实例。

> **注意：**
>
> 由于年的间隔不固定，若设 dt 表示 “2020 年 2 月 29 日”，`dt.addYears(1)` 不会返回非法日期“2021 年 2 月 29 日”。为了尽量返回有效的日期，会偏移到当月最后一天，返回 “2021 年 2 月 28 日”。

参数：

- n: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 自 [DateTime](time_package_structs.md#struct-datetime) 实例后多少年的数量。

返回值：

- [DateTime](time_package_structs.md#struct-datetime) - [DateTime](time_package_structs.md#struct-datetime) 实例 `n` 年后的时间。

异常：

- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - [DateTime](time_package_structs.md#struct-datetime) 实例 `n` 年后的日期时间超过表示范围时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建一个 DateTime 实例
    let datetime = DateTime.ofUTC(
        year: 2024,
        month: 5, // 5月
        dayOfMonth: 22,
        hour: 12,
        minute: 34,
        second: 56,
        nanosecond: 789000000
    )

    println("原始 DateTime: ${datetime}")

    // 添加 2 年
    let newDatetime = datetime.addYears(2)

    println("添加 2 年后: ${newDatetime}")
    println("年份: ${newDatetime.year}")
    println("月份: ${newDatetime.month}")
    println("日期: ${newDatetime.dayOfMonth}")
}
```

运行结果：

```text
原始 DateTime: 2024-05-22T12:34:56.789Z
添加 2 年后: 2026-05-22T12:34:56.789Z
年份: 2026
月份: May
日期: 22
```

### func compare(DateTime)

```cangjie
public func compare(rhs: DateTime): Ordering
```

功能：判断一个 [DateTime](time_package_structs.md#struct-datetime) 实例与参数 `rhs` 的大小关系。如果大于，返回 [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).GT；如果等于，返回 [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).EQ；如果小于，返回 [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).LT。

参数：

- rhs: [DateTime](time_package_structs.md#struct-datetime) - 参与比较的 [DateTime](time_package_structs.md#struct-datetime) 实例。

返回值：

- [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering) - [DateTime](time_package_structs.md#struct-datetime) 实例与 `rhs` 大小关系。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建三个 DateTime 实例
    let datetime1 = DateTime.ofUTC(
        year: 2024,
        month: 5, // 5月
        dayOfMonth: 22,
        hour: 12,
        minute: 34,
        second: 56,
        nanosecond: 789000000
    )

    let datetime2 = DateTime.ofUTC(
        year: 2024,
        month: 5, // 5月
        dayOfMonth: 22,
        hour: 12,
        minute: 34,
        second: 56,
        nanosecond: 789000000
    )

    let datetime3 = DateTime.ofUTC(
        year: 2024,
        month: 5, // 5月
        dayOfMonth: 23, // 23日
        hour: 12,
        minute: 34,
        second: 56,
        nanosecond: 789000000
    )

    println("datetime1: ${datetime1}")
    println("datetime2: ${datetime2}")
    println("datetime3: ${datetime3}")

    // 比较 datetime1 和 datetime2
    let result1 = datetime1.compare(datetime2)
    println("datetime1.compare(datetime2): ${result1}")

    // 比较 datetime1 和 datetime3
    let result2 = datetime1.compare(datetime3)
    println("datetime1.compare(datetime3): ${result2}")

    // 比较 datetime3 和 datetime1
    let result3 = datetime3.compare(datetime1)
    println("datetime3.compare(datetime1): ${result3}")
}
```

运行结果：

```text
datetime1: 2024-05-22T12:34:56.789Z
datetime2: 2024-05-22T12:34:56.789Z
datetime3: 2024-05-23T12:34:56.789Z
datetime1.compare(datetime2): Ordering.EQ
datetime1.compare(datetime3): Ordering.LT
datetime3.compare(datetime1): Ordering.GT
```

### func format(String)

```cangjie
public func format(fmt: String): String
```

功能：返回一个表示 [DateTime](time_package_structs.md#struct-datetime) 实例的字符串，其格式由参数 `fmt` 指定。格式说明详见[时间字符串格式](../time_package_overview.md#时间字符串格式)。

参数：

- fmt: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 返回字符串的格式，其格式可为 "yyyy/MM/dd HH:mm:ss OOOO"。

返回值：

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - [DateTime](time_package_structs.md#struct-datetime) 实例在 `fmt` 指定格式下的字符串，如果无法解析则原样返回 `fmt` 指定格式。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 当 `fmt` 格式不符合[时间字符串格式](../time_package_overview.md#时间字符串格式)，则抛出异常。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建一个 DateTime 实例
    let datetime = DateTime.ofUTC(
        year: 2024,
        month: 5, // 5月
        dayOfMonth: 22,
        hour: 12,
        minute: 34,
        second: 56,
        nanosecond: 789000000
    )

    println("原始 DateTime: ${datetime}")

    // 使用不同的格式字符串格式化
    let format1 = "yyyy/MM/dd HH:mm:ss"
    let formatted1 = datetime.format(format1)
    println("格式 '${format1}': ${formatted1}")

    let format2 = "yyyy-MM-dd HH:mm:ss.SSS OOOO"
    let formatted2 = datetime.format(format2)
    println("格式 '${format2}': ${formatted2}")
}
```

运行结果：

```text
原始 DateTime: 2024-05-22T12:34:56.789Z
格式 'yyyy/MM/dd HH:mm:ss': 2024/05/22 12:34:56
格式 'yyyy-MM-dd HH:mm:ss.SSS OOOO': 2024-05-22 12:34:56.789000000 Z
```

### func hashCode()

```cangjie
public func hashCode(): Int64
```

功能：获取 [DateTime](time_package_structs.md#struct-datetime) 实例的哈希值。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 哈希值。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建一个 DateTime 实例
    let datetime = DateTime.ofUTC(
        year: 2024,
        month: 5, // 5月
        dayOfMonth: 22,
        hour: 12,
        minute: 34,
        second: 56,
        nanosecond: 789000000
    )

    println("DateTime: ${datetime}")

    // 获取哈希值
    let hash = datetime.hashCode()
    println("哈希值: ${hash}")
}
```

运行结果：

```text
DateTime: 2024-05-22T12:34:56.789Z
哈希值: -8244767606933226637
```

### func inLocal()

```cangjie
public func inLocal(): DateTime
```

功能：获取 [DateTime](time_package_structs.md#struct-datetime) 实例在本地时区的时间。

返回值：

- [DateTime](time_package_structs.md#struct-datetime) - [DateTime](time_package_structs.md#struct-datetime) 实例在本地时区的时间。

异常：

- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - 当返回的 [DateTime](time_package_structs.md#struct-datetime) 实例表示的日期时间超过表示范围时，抛出异常。

示例：

<!-- run -->
```cangjie
import std.time.*

main() {
    // 创建一个 UTC 时区的 DateTime 实例
    let datetime = DateTime.ofUTC(
        year: 2024,
        month: 5, // 5月
        dayOfMonth: 22,
        hour: 12,
        minute: 34,
        second: 56,
        nanosecond: 789000000
    )

    println("UTC 时间: ${datetime}")
    println("时区ID: ${datetime.zoneId}")

    // 转换为本地时区时间
    let localDatetime = datetime.inLocal()

    println("本地时间: ${localDatetime}")
    println("本地时区ID: ${localDatetime.zoneId}")
}
```

可能的运行结果：

```text
UTC 时间: 2024-05-22T12:34:56.789Z
时区ID: UTC
本地时间: 2024-05-22T20:34:56.789+08:00
本地时区ID: Asia/Shanghai
```

### func inTimeZone(TimeZone)

```cangjie
public func inTimeZone(timeZone: TimeZone): DateTime
```

功能：获取 [DateTime](time_package_structs.md#struct-datetime) 实例在参数 `timeZone` 指定时区的时间。

参数：

- timeZone: [TimeZone](time_package_classes.md#class-timezone) - 目标时区。

返回值：

- [DateTime](time_package_structs.md#struct-datetime) - [DateTime](time_package_structs.md#struct-datetime) 实例在参数 `timezone` 指定时区的时间。

异常：

- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - 当返回的 [DateTime](time_package_structs.md#struct-datetime) 实例表示的日期时间超过表示范围时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建一个 UTC 时区的 DateTime 实例
    let datetime = DateTime.ofUTC(
        year: 2024,
        month: 5, // 5月
        dayOfMonth: 22,
        hour: 12,
        minute: 34,
        second: 56,
        nanosecond: 789000000
    )

    println("UTC 时间: ${datetime}")
    println("时区ID: ${datetime.zoneId}")

    // 创建一个纽约时区
    let nyTimeZone = TimeZone.load("America/New_York")

    // 转换为纽约时区时间
    let nyDatetime = datetime.inTimeZone(nyTimeZone)

    println("纽约时间: ${nyDatetime}")
    println("纽约时区ID: ${nyDatetime.zoneId}")
}
```

运行结果：

```text
UTC 时间: 2024-05-22T12:34:56.789Z
时区ID: UTC
纽约时间: 2024-05-22T08:34:56.789-04:00
纽约时区ID: America/New_York
```

### func inUTC()

```cangjie
public func inUTC(): DateTime
```

功能：获取 [DateTime](time_package_structs.md#struct-datetime) 实例在 `UTC` 时区的时间。

返回值：

- [DateTime](time_package_structs.md#struct-datetime) - [DateTime](time_package_structs.md#struct-datetime) 实例在 `UTC` 时区的时间。

异常：

- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - 当返回的 [DateTime](time_package_structs.md#struct-datetime) 实例表示的日期时间超过表示范围时，抛出异常。

示例：

<!-- run -->
```cangjie
import std.time.*

main() {
    // 创建一个本地时区的 DateTime 实例
    let datetime = DateTime.of(
        year: 2024,
        month: 5, // 5月
        dayOfMonth: 22,
        hour: 12,
        minute: 34,
        second: 56,
        nanosecond: 789000000,
        timeZone: TimeZone.Local
    )

    println("本地时间: ${datetime}")
    println("时区ID: ${datetime.zoneId}")

    // 转换为 UTC 时区时间
    let utcDatetime = datetime.inUTC()

    println("UTC 时间: ${utcDatetime}")
    println("UTC 时区ID: ${utcDatetime.zoneId}")
}
```

可能的运行结果：

```text
本地时间: 2024-05-22T12:34:56.789+08:00
时区ID: Asia/Shanghai
UTC 时间: 2024-05-22T04:34:56.789Z
UTC 时区ID: UTC
```

### func toString()

```cangjie
public func toString(): String
```

功能：返回一个表示 [DateTime](time_package_structs.md#struct-datetime) 实例的字符串，其格式为 `RFC3339` 中 `date-time` 格式，如果时间包含纳秒信息（不为零），会打印出小数秒。

返回值：

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - [DateTime](time_package_structs.md#struct-datetime) 实例的字符串表示。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建一个 DateTime 实例
    let datetime = DateTime.ofUTC(
        year: 2024,
        month: 5, // 5月
        dayOfMonth: 22,
        hour: 12,
        minute: 34,
        second: 56,
        nanosecond: 789000000
    )

    println("DateTime: ${datetime}")

    // 转换为字符串
    let str = datetime.toString()
    println("字符串表示: ${str}")
}
```

运行结果：

```text
DateTime: 2024-05-22T12:34:56.789Z
字符串表示: 2024-05-22T12:34:56.789Z
```

### func toString(DateTimeFormat) <sup>(deprecated)</sup>

```cangjie
public func toString(format: DateTimeFormat): String
```

功能：返回一个表示 [DateTime](time_package_structs.md#struct-datetime) 实例的字符串，其格式由参数 `format` 指定。格式说明详见[时间字符串格式](../time_package_overview.md#时间字符串格式)。

> **注意：**
>
> 未来版本即将废弃不再使用。

参数：

- format: [DateTimeFormat](./time_package_classes.md#class-datetimeformat) - 时间格式，其格式可为 "yyyy/MM/dd HH:mm:ss OOOO"。

返回值：

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - [DateTime](time_package_structs.md#struct-datetime) 实例在 `format` 指定格式下的字符串。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 当 `format` 格式不正确时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建一个 DateTime 实例
    let datetime = DateTime.ofUTC(
        year: 2024,
        month: 5, // 5月
        dayOfMonth: 22,
        hour: 12,
        minute: 34,
        second: 56,
        nanosecond: 789000000
    )
    // 使用已废弃的 of 方法创建 DateTimeFormat 实例
    let formatter = DateTimeFormat.of("yyyy/MM/dd HH:mm:ss")
    println("DateTime: ${datetime}")
    println("格式化后的字符串: ${datetime.toString(formatter)}")
}
```

运行结果：

```text
DateTime: 2024-05-22T12:34:56.789Z
格式化后的字符串: 2024/05/22 12:34:56
```

### func toUnixTimeStamp()

```cangjie
public func toUnixTimeStamp(): Duration
```

功能：获取当前实例自 [UnixEpoch](#static-prop-unixepoch) 的时间间隔。

返回值：

- [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - 当前实例自 [UnixEpoch](#static-prop-unixepoch) 的时间间隔。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建一个 DateTime 实例
    let datetime = DateTime.ofUTC(
        year: 2024,
        month: 5, // 5月
        dayOfMonth: 22,
        hour: 12,
        minute: 34,
        second: 56,
        nanosecond: 789000000
    )

    println("DateTime: ${datetime}")

    // 转换为 Unix 时间戳
    let duration = datetime.toUnixTimeStamp()
    println("Unix 时间戳: ${duration}")
}
```

运行结果：

```text
DateTime: 2024-05-22T12:34:56.789Z
Unix 时间戳: 19865d12h34m56s789ms
```

### operator func !=(DateTime)

```cangjie
public operator func !=(r: DateTime): Bool
```

功能：判断当前 [DateTime](time_package_structs.md#struct-datetime) 实例是否不等于 `r`。

若两个 [DateTime](time_package_structs.md#struct-datetime) 不相等，那么它们指向的不是同一 UTC 时间。

参数：

- r: [DateTime](time_package_structs.md#struct-datetime) - [DateTime](time_package_structs.md#struct-datetime) 实例。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - `true` 或 `false`。当前 [DateTime](time_package_structs.md#struct-datetime) 实例不等于 `r` 时，返回 `true`；否则，返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建两个相同的 DateTime 实例
    let datetime1 = DateTime.ofUTC(
        year: 2024,
        month: 5, // 5月
        dayOfMonth: 22,
        hour: 12,
        minute: 34,
        second: 56,
        nanosecond: 789000000
    )

    let datetime2 = DateTime.ofUTC(
        year: 2024,
        month: 5, // 5月
        dayOfMonth: 22,
        hour: 12,
        minute: 34,
        second: 56,
        nanosecond: 789000000
    )

    // 创建一个不同的 DateTime 实例
    let datetime3 = DateTime.ofUTC(
        year: 2024,
        month: 5, // 5月
        dayOfMonth: 23, // 23日
        hour: 12,
        minute: 34,
        second: 56,
        nanosecond: 789000000
    )

    println("datetime1: ${datetime1}")
    println("datetime2: ${datetime2}")
    println("datetime3: ${datetime3}")

    // 比较 datetime1 和 datetime2 (相同)
    let result1 = datetime1 != datetime2
    println("datetime1 != datetime2: ${result1}")

    // 比较 datetime1 和 datetime3 (不同)
    let result2 = datetime1 != datetime3
    println("datetime1 != datetime3: ${result2}")
}
```

运行结果：

```text
datetime1: 2024-05-22T12:34:56.789Z
datetime2: 2024-05-22T12:34:56.789Z
datetime3: 2024-05-23T12:34:56.789Z
datetime1 != datetime2: false
datetime1 != datetime3: true
```

### operator func +(Duration)

```cangjie
public operator func +(r: Duration): DateTime
```

功能：实现 [DateTime](time_package_structs.md#struct-datetime) 类型和 [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) 类型加法，即 [DateTime](time_package_structs.md#struct-datetime) + [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) 运算。

参数：

- r: [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - 加法的右操作数。

返回值：

- [DateTime](time_package_structs.md#struct-datetime) - [DateTime](time_package_structs.md#struct-datetime) 类型实例和 `r` 的和。

异常：

- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - 当结果超过日期时间的表示范围时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建一个 DateTime 实例
    let datetime = DateTime.ofUTC(
        year: 2024,
        month: 5, // 5月
        dayOfMonth: 22,
        hour: 12,
        minute: 34,
        second: 56,
        nanosecond: 789000000
    )

    println("原始 DateTime: ${datetime}")

    // 创建一个 Duration 实例 (1天2小时30分钟)
    let duration = 1 * Duration.day + 2 * Duration.hour + 30 * Duration.minute

    // 使用 + 操作符将 Duration 加到 DateTime 上
    let newDatetime = datetime + duration

    println("增加的时间: ${duration}")
    println("新的 DateTime: ${newDatetime}")
}
```

运行结果：

```text
原始 DateTime: 2024-05-22T12:34:56.789Z
增加的时间: 1d2h30m
新的 DateTime: 2024-05-23T15:04:56.789Z
```

### operator func -(DateTime)

```cangjie
public operator func -(r: DateTime): Duration
```

功能：实现 [DateTime](time_package_structs.md#struct-datetime) 类型之间的减法，即 [DateTime](time_package_structs.md#struct-datetime) - [DateTime](time_package_structs.md#struct-datetime) 运算。

参数：

- r: [DateTime](time_package_structs.md#struct-datetime) - 减法的右操作数。

返回值：

- [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - [DateTime](time_package_structs.md#struct-datetime) 类型实例和 `r` 的差。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建两个 DateTime 实例
    let datetime1 = DateTime.ofUTC(
        year: 2024,
        month: 5, // 5月
        dayOfMonth: 22,
        hour: 12,
        minute: 34,
        second: 56,
        nanosecond: 789000000
    )

    let datetime2 = DateTime.ofUTC(
        year: 2024,
        month: 5, // 5月
        dayOfMonth: 20, // 20日
        hour: 10,
        minute: 30,
        second: 30,
        nanosecond: 123000000
    )

    println("datetime1: ${datetime1}")
    println("datetime2: ${datetime2}")

    // 使用 - 操作符计算两个 DateTime 之间的时间差
    let duration = datetime1 - datetime2

    println("时间差: ${duration}")
}
```

运行结果：

```text
datetime1: 2024-05-22T12:34:56.789Z
datetime2: 2024-05-20T10:30:30.123Z
时间差: 2d2h4m26s666ms
```

### operator func -(Duration)

```cangjie
public operator func -(r: Duration): DateTime
```

功能：实现 [DateTime](time_package_structs.md#struct-datetime) 类型和 [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) 类型减法，即 [DateTime](time_package_structs.md#struct-datetime) - [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) 运算。

参数：

- r: [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - 减法的右操作数。

返回值：

- [DateTime](time_package_structs.md#struct-datetime) - [DateTime](time_package_structs.md#struct-datetime) 类型实例和 `r` 的差。

异常：

- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - 当结果超过日期时间的表示范围时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建一个 DateTime 实例
    let datetime = DateTime.ofUTC(
        year: 2024,
        month: 5, // 5月
        dayOfMonth: 22,
        hour: 12,
        minute: 34,
        second: 56,
        nanosecond: 789000000
    )

    println("原始 DateTime: ${datetime}")

    // 创建一个 Duration 实例 (1天2小时30分钟)
    let duration = 1 * Duration.day + 2 * Duration.hour + 30 * Duration.minute

    // 使用 - 操作符从 DateTime 中减去 Duration
    let newDatetime = datetime - duration

    println("减少的时间: ${duration}")
    println("新的 DateTime: ${newDatetime}")
}
```

运行结果：

```text
原始 DateTime: 2024-05-22T12:34:56.789Z
减少的时间: 1d2h30m
新的 DateTime: 2024-05-21T10:04:56.789Z
```

### operator func <(DateTime)

```cangjie
public operator func <(r: DateTime): Bool
```

功能：判断当前 [DateTime](time_package_structs.md#struct-datetime) 实例是否早于 `r`（指向更早的 UTC 时间的 [DateTime](time_package_structs.md#struct-datetime) 更小）。

参数：

- r: [DateTime](time_package_structs.md#struct-datetime) - [DateTime](time_package_structs.md#struct-datetime) 实例。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - `true` 或 `false`。当前 [DateTime](time_package_structs.md#struct-datetime) 实例早于 `r` 时，返回 `true`；否则，返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建两个 DateTime 实例
    let datetime1 = DateTime.ofUTC(
        year: 2024,
        month: 5, // 5月
        dayOfMonth: 22,
        hour: 12,
        minute: 34,
        second: 56,
        nanosecond: 789000000
    )

    let datetime2 = DateTime.ofUTC(
        year: 2024,
        month: 5, // 5月
        dayOfMonth: 23, // 23日
        hour: 12,
        minute: 34,
        second: 56,
        nanosecond: 789000000
    )

    println("datetime1: ${datetime1}")
    println("datetime2: ${datetime2}")

    // 使用 < 操作符比较两个 DateTime
    let result1 = datetime1 < datetime2
    println("datetime1 < datetime2: ${result1}")

    let result2 = datetime2 < datetime1
    println("datetime2 < datetime1: ${result2}")
}
```

运行结果：

```text
datetime1: 2024-05-22T12:34:56.789Z
datetime2: 2024-05-23T12:34:56.789Z
datetime1 < datetime2: true
datetime2 < datetime1: false
```

### operator func <=(DateTime)

```cangjie
public operator func <=(r: DateTime): Bool
```

功能：判断当前 [DateTime](time_package_structs.md#struct-datetime) 实例是否早于或等于 `r`（指向更早的 UTC 时间的 [DateTime](time_package_structs.md#struct-datetime) 更小）。

参数：

- r: [DateTime](time_package_structs.md#struct-datetime) - [DateTime](time_package_structs.md#struct-datetime) 实例。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - `true` 或 `false`。当前 [DateTime](time_package_structs.md#struct-datetime) 实例早于或等于 `r` 时，返回 `true`；否则，返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建三个 DateTime 实例
    let datetime1 = DateTime.ofUTC(
        year: 2024,
        month: 5, // 5月
        dayOfMonth: 22,
        hour: 12,
        minute: 34,
        second: 56,
        nanosecond: 789000000
    )

    let datetime2 = DateTime.ofUTC(
        year: 2024,
        month: 5, // 5月
        dayOfMonth: 23, // 23日
        hour: 12,
        minute: 34,
        second: 56,
        nanosecond: 789000000
    )

    let datetime3 = DateTime.ofUTC(
        year: 2024,
        month: 5, // 5月
        dayOfMonth: 22,
        hour: 12,
        minute: 34,
        second: 56,
        nanosecond: 789000000
    )

    println("datetime1: ${datetime1}")
    println("datetime2: ${datetime2}")
    println("datetime3: ${datetime3}")

    // 使用 <= 操作符比较两个 DateTime
    let result1 = datetime1 <= datetime2
    println("datetime1 <= datetime2: ${result1}")

    let result2 = datetime2 <= datetime1
    println("datetime2 <= datetime1: ${result2}")

    let result3 = datetime1 <= datetime3
    println("datetime1 <= datetime3: ${result3}")
}
```

运行结果：

```text
datetime1: 2024-05-22T12:34:56.789Z
datetime2: 2024-05-23T12:34:56.789Z
datetime3: 2024-05-22T12:34:56.789Z
datetime1 <= datetime2: true
datetime2 <= datetime1: false
datetime1 <= datetime3: true
```

### operator func ==(DateTime)

```cangjie
public operator func ==(r: DateTime): Bool
```

功能：判断当前 [DateTime](time_package_structs.md#struct-datetime) 实例是否等于 `r`。

若两个 [DateTime](time_package_structs.md#struct-datetime) 相等，那么它们指向同一 UTC 时间。

参数：

- r: [DateTime](time_package_structs.md#struct-datetime) - [DateTime](time_package_structs.md#struct-datetime) 实例。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - `true` 或 `false`。当前 [DateTime](time_package_structs.md#struct-datetime) 实例等于 `r` 时，返回 `true`；否则，返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建两个相同的 DateTime 实例
    let datetime1 = DateTime.ofUTC(
        year: 2024,
        month: 5, // 5月
        dayOfMonth: 22,
        hour: 12,
        minute: 34,
        second: 56,
        nanosecond: 789000000
    )

    let datetime2 = DateTime.ofUTC(
        year: 2024,
        month: 5, // 5月
        dayOfMonth: 22,
        hour: 12,
        minute: 34,
        second: 56,
        nanosecond: 789000000
    )

    // 创建一个不同的 DateTime 实例
    let datetime3 = DateTime.ofUTC(
        year: 2024,
        month: 5, // 5月
        dayOfMonth: 23, // 23日
        hour: 12,
        minute: 34,
        second: 56,
        nanosecond: 789000000
    )

    println("datetime1: ${datetime1}")
    println("datetime2: ${datetime2}")
    println("datetime3: ${datetime3}")

    // 使用 == 操作符比较两个 DateTime
    let result1 = datetime1 == datetime2
    println("datetime1 == datetime2: ${result1}")

    let result2 = datetime1 == datetime3
    println("datetime1 == datetime3: ${result2}")
}
```

运行结果：

```text
datetime1: 2024-05-22T12:34:56.789Z
datetime2: 2024-05-22T12:34:56.789Z
datetime3: 2024-05-23T12:34:56.789Z
datetime1 == datetime2: true
datetime1 == datetime3: false
```

### operator func >(DateTime)

```cangjie
public operator func >(r: DateTime): Bool
```

功能：判断当前 [DateTime](time_package_structs.md#struct-datetime) 实例是否晚于 `r`（指向更晚的 UTC 时间的 [DateTime](time_package_structs.md#struct-datetime) 更大）。

参数：

- r: [DateTime](time_package_structs.md#struct-datetime) - [DateTime](time_package_structs.md#struct-datetime) 实例。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - `true` 或 `false`。当前 [DateTime](time_package_structs.md#struct-datetime) 实例晚于 `r` 时，返回 `true`；否则，返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建两个 DateTime 实例
    let datetime1 = DateTime.ofUTC(
        year: 2024,
        month: 5, // 5月
        dayOfMonth: 22,
        hour: 12,
        minute: 34,
        second: 56,
        nanosecond: 789000000
    )

    let datetime2 = DateTime.ofUTC(
        year: 2024,
        month: 5, // 5月
        dayOfMonth: 23, // 23日
        hour: 12,
        minute: 34,
        second: 56,
        nanosecond: 789000000
    )

    println("datetime1: ${datetime1}")
    println("datetime2: ${datetime2}")

    // 使用 > 操作符比较两个 DateTime
    let result1 = datetime1 > datetime2
    println("datetime1 > datetime2: ${result1}")

    let result2 = datetime2 > datetime1
    println("datetime2 > datetime1: ${result2}")
}
```

运行结果：

```text
datetime1: 2024-05-22T12:34:56.789Z
datetime2: 2024-05-23T12:34:56.789Z
datetime1 > datetime2: false
datetime2 > datetime1: true
```

### operator func >=(DateTime)

```cangjie
public operator func >=(r: DateTime): Bool
```

功能：判断当前 [DateTime](time_package_structs.md#struct-datetime) 实例是否晚于或等于 `r`（指向更晚的 UTC 时间的 [DateTime](time_package_structs.md#struct-datetime) 更大）。

参数：

- r: [DateTime](time_package_structs.md#struct-datetime) - [DateTime](time_package_structs.md#struct-datetime) 实例。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - `true` 或 `false`。当前 [DateTime](time_package_structs.md#struct-datetime) 实例晚于或等于 `r` 时，返回 `true`；否则，返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建三个 DateTime 实例
    let datetime1 = DateTime.ofUTC(
        year: 2024,
        month: 5, // 5月
        dayOfMonth: 22,
        hour: 12,
        minute: 34,
        second: 56,
        nanosecond: 789000000
    )

    let datetime2 = DateTime.ofUTC(
        year: 2024,
        month: 5, // 5月
        dayOfMonth: 23, // 23日
        hour: 12,
        minute: 34,
        second: 56,
        nanosecond: 789000000
    )

    let datetime3 = DateTime.ofUTC(
        year: 2024,
        month: 5, // 5月
        dayOfMonth: 22,
        hour: 12,
        minute: 34,
        second: 56,
        nanosecond: 789000000
    )

    println("datetime1: ${datetime1}")
    println("datetime2: ${datetime2}")
    println("datetime3: ${datetime3}")

    // 使用 >= 操作符比较两个 DateTime
    let result1 = datetime1 >= datetime2
    println("datetime1 >= datetime2: ${result1}")

    let result2 = datetime2 >= datetime1
    println("datetime2 >= datetime1: ${result2}")

    let result3 = datetime1 >= datetime3
    println("datetime1 >= datetime3: ${result3}")
}
```

运行结果：

```text
datetime1: 2024-05-22T12:34:56.789Z
datetime2: 2024-05-23T12:34:56.789Z
datetime3: 2024-05-22T12:34:56.789Z
datetime1 >= datetime2: false
datetime2 >= datetime1: true
datetime1 >= datetime3: true
```

## struct MonoTime

```cangjie
public struct MonoTime <: Hashable & Comparable<MonoTime>
```

功能：[MonoTime](time_package_structs.md#struct-monotime) 表示单调时间，是一个用来衡量经过时间的时间类型，类似于一直运行的秒表，提供了获取当前时间，计算和比较等功能。

- [MonoTime](time_package_structs.md#struct-monotime) 可表示的范围为 [Duration.Zero](../../core/core_package_api/core_package_structs.md#static-const-zero) 至 [Duration.Max](../../core/core_package_api/core_package_structs.md#static-const-max)，数值表示为 [0, 2<sup>63</sup>)（单位为秒），精度为纳秒。通过 [now](#static-func-now) 方法创建的 [MonoTime](time_package_structs.md#struct-monotime) 总是晚于先使用该方式创建的 [MonoTime](time_package_structs.md#struct-monotime)，常用于性能测试和时间优先的任务队列。
- 以下为 [MonoTime](time_package_structs.md#struct-monotime) 中 [now](#static-func-now) 函数获取当前时间使用的系统调用函数：

  | 系统    | 系统调用函数   | 时钟类型 |
  | ------- | ------------- |---------------- |
  | Linux   | clock_gettime | CLOCK_MONOTONIC |
  | Windows | clock_gettime | CLOCK_MONOTONIC |
  | macOS   | clock_gettime | CLOCK_MONOTONIC |

父类型：

- [Hashable](../../core/core_package_api/core_package_interfaces.md#interface-hashable)
- [Comparable](../../core/core_package_api/core_package_interfaces.md#interface-comparablet)\<[MonoTime](#struct-monotime)>

### static func now()

```cangjie
public static func now(): MonoTime
```

功能：获取与当前时间对应的 [MonoTime](time_package_structs.md#struct-monotime)。

返回值：

- [MonoTime](time_package_structs.md#struct-monotime) - 与当前时间对应的 [MonoTime](time_package_structs.md#struct-monotime)。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    let currentTime = MonoTime.now()

    // 等待一小段时间
    for (i in 0..1000000) {
        let _ = i
    }

    let laterTime = MonoTime.now()

    // 验证时间顺序
    println("较早时间 < 较晚时间: ${currentTime < laterTime}")
}
```

运行结果：

```text
较早时间 < 较晚时间: true
```

### func compare(MonoTime)

```cangjie
public func compare(rhs: MonoTime): Ordering
```

功能：判断一个 [MonoTime](time_package_structs.md#struct-monotime) 实例与另一个 [MonoTime](time_package_structs.md#struct-monotime) 实例大小关系。

参数：

- rhs: [MonoTime](time_package_structs.md#struct-monotime) - 参与比较的 [MonoTime](time_package_structs.md#struct-monotime) 实例。

返回值：

- [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering) - 当前 [MonoTime](time_package_structs.md#struct-monotime) 实例与另一个 [MonoTime](time_package_structs.md#struct-monotime) 实例大小关系。如果大于，返回 [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).GT；如果等于，返回 [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).EQ；如果小于，返回 [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).LT。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    let time1 = MonoTime.now()

    // 等待一小段时间
    for (i in 0..1000000) {
        let _ = i
    }

    let time2 = MonoTime.now()

    // 使用 compare 方法比较两个时间
    let ordering = time1.compare(time2)

    if (ordering == Ordering.LT) {
        println("time1 比 time2 早")
    }
}
```

运行结果：

```text
time1 比 time2 早
```

### func hashCode()

```cangjie
public func hashCode(): Int64
```

功能：获取当前 [MonoTime](time_package_structs.md#struct-monotime) 实例的哈希值。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 哈希值。

示例：

<!-- run -->
```cangjie
import std.time.*

main() {
    let time = MonoTime.now()

    // 获取哈希值
    let hash = time.hashCode()

    println("MonoTime 的哈希值: ${hash}")
}
```

可能的运行结果：

```text
MonoTime 的哈希值: -8244754742239507916
```

### operator func !=(MonoTime)

```cangjie
public operator func !=(r: MonoTime): Bool
```

功能：判断当前 [MonoTime](time_package_structs.md#struct-monotime) 实例是否不等于另一个 [MonoTime](time_package_structs.md#struct-monotime) 实例。

参数：

- r: [MonoTime](time_package_structs.md#struct-monotime) - 单调时间。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - `true` 或 `false`。当前 [MonoTime](time_package_structs.md#struct-monotime) 实例不等于另一个 [MonoTime](time_package_structs.md#struct-monotime) 实例时，返回 `true`；否则，返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    let time1 = MonoTime.now()
    // 等待一小段时间
    for (i in 0..1000000) {
        let _ = i
    }
    let time2 = MonoTime.now()

    // 不同时间的比较
    let notEqual = time1 != time2
    println("不同时间不相等: ${notEqual}")

    // 相同时间的比较
    let time3 = time1 // 引用同一个实例
    let stillNotEqual = time1 != time3
    println("相同实例不等于自身: ${stillNotEqual}")
}
```

运行结果：

```text
不同时间不相等: true
相同实例不等于自身: false
```

### operator func +(Duration)

```cangjie
public operator func +(r: Duration): MonoTime
```

功能：实现 [MonoTime](time_package_structs.md#struct-monotime) 类型和 [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) 类型加法，即 [MonoTime](time_package_structs.md#struct-monotime) + [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) 运算。

参数：

- r: [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - 时间间隔。

返回值：

- [MonoTime](time_package_structs.md#struct-monotime) - 时间间隔后的单调时间。

异常：

- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - 当结果超过单调时间的表示范围时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    let startTime = MonoTime.now()

    // 定义一个时间间隔
    let interval = 100 * Duration.millisecond // 100毫秒

    // 执行加法运算
    let futureTime = startTime + interval

    println("增加100毫秒")

    // 验证时间差
    let actualInterval = futureTime - startTime
    println("实际间隔: ${actualInterval.toNanoseconds()} 纳秒")
    println("预期间隔: ${interval.toNanoseconds()} 纳秒")
    println("间隔匹配: ${actualInterval == interval}")

    // 验证时间顺序
    println("未来时间在起始时间之后: ${futureTime > startTime}")
}
```

运行结果：

```text
增加100毫秒
实际间隔: 100000000 纳秒
预期间隔: 100000000 纳秒
间隔匹配: true
未来时间在起始时间之后: true
```

### operator func -(Duration)

```cangjie
public operator func -(r: Duration): MonoTime
```

功能：实现 [MonoTime](time_package_structs.md#struct-monotime) 类型和 [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) 类型减法，即 [MonoTime](time_package_structs.md#struct-monotime) - [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) 运算。

参数：

- r: [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - 时间间隔。

返回值：

- [MonoTime](time_package_structs.md#struct-monotime) - 时间间隔前的单调时间。

异常：

- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - 当结果超过单调时间的表示范围时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    let currentTime = MonoTime.now()

    // 定义一个时间间隔
    let interval = 50 * Duration.millisecond // 50毫秒

    // 执行减法运算，得到过去的时间点
    let pastTime = currentTime - interval

    println("减去50毫秒")

    // 验证时间差
    let actualInterval = currentTime - pastTime
    println("实际间隔: ${actualInterval.toNanoseconds()} 纳秒")
    println("预期间隔: ${interval.toNanoseconds()} 纳秒")
    println("间隔匹配: ${actualInterval == interval}")
}
```

运行结果：

```text
减去50毫秒
实际间隔: 50000000 纳秒
预期间隔: 50000000 纳秒
间隔匹配: true
```

### operator func -(MonoTime)

```cangjie
public operator func -(r: MonoTime): Duration
```

功能：实现 [MonoTime](time_package_structs.md#struct-monotime) 类型之间的减法，即 [MonoTime](time_package_structs.md#struct-monotime) - [MonoTime](time_package_structs.md#struct-monotime) 运算。

参数：

- r: [MonoTime](time_package_structs.md#struct-monotime) - 单调时间。

返回值：

- [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - 经过的时间间隔。

示例：

<!-- run -->
```cangjie
import std.time.*

main() {
    let startTime = MonoTime.now()

    // 等待一小段时间
    for (i in 0..1000000) {
        let _ = i
    }

    let endTime = MonoTime.now()

    // 计算时间差
    let duration = endTime - startTime

    println("经过时间: ${duration.toNanoseconds()} 纳秒")
}
```

可能的运行结果：

```text
经过时间: 3290397 纳秒
```

### operator func <(MonoTime)

```cangjie
public operator func <(r: MonoTime): Bool
```

功能：判断当前 [MonoTime](time_package_structs.md#struct-monotime) 实例是否早于另一个 [MonoTime](time_package_structs.md#struct-monotime) 实例。

参数：

- r: [MonoTime](time_package_structs.md#struct-monotime) - 单调时间。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - `true` 或 `false`。当前 [MonoTime](time_package_structs.md#struct-monotime) 实例早于另一个 [MonoTime](time_package_structs.md#struct-monotime) 实例时，返回 `true`；否则，返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    let time1 = MonoTime.now()

    // 等待一小段时间
    for (i in 0..1000000) {
        let _ = i
    }

    let time2 = MonoTime.now()

    // 使用 < 操作符比较
    let isEarlier = time1 < time2

    println("Time1 早于 Time2: ${isEarlier}")
}
```

运行结果：

```text
Time1 早于 Time2: true
```

### operator func <=(MonoTime)

```cangjie
public operator func <=(r: MonoTime): Bool
```

功能：判断当前 [MonoTime](time_package_structs.md#struct-monotime) 实例是否早于或等于另一个 [MonoTime](time_package_structs.md#struct-monotime) 实例。

参数：

- r: [MonoTime](time_package_structs.md#struct-monotime) - 单调时间。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - `true` 或 `false`。当前 [MonoTime](time_package_structs.md#struct-monotime) 实例早于或等于另一个 [MonoTime](time_package_structs.md#struct-monotime) 实例时，返回 `true`；否则，返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    let time1 = MonoTime.now()
    let time2 = time1 // 同一个实例

    // 等待一小段时间
    for (i in 0..1000000) {
        let _ = i
    }
    let time3 = MonoTime.now() // 稍晚的时间

    // 测试 <= 操作符
    let earlierOrEqual1 = time1 <= time2 // 相等的情况
    let earlierOrEqual2 = time1 <= time3 // 早于的情况
    let earlierOrEqual3 = time3 <= time1 // 晚于的情况

    println("Time1 和 Time2 是相同实例")
    println("Time1 <= Time2: ${earlierOrEqual1}")
    println("Time1 <= Time3: ${earlierOrEqual2}")
    println("Time3 <= Time1: ${earlierOrEqual3}")
}
```

运行结果：

```text
Time1 和 Time2 是相同实例
Time1 <= Time2: true
Time1 <= Time3: true
Time3 <= Time1: false
```

### operator func ==(MonoTime)

```cangjie
public operator func ==(r: MonoTime): Bool
```

功能：判断当前 [MonoTime](time_package_structs.md#struct-monotime) 实例是否等于另一个 [MonoTime](time_package_structs.md#struct-monotime) 实例。

参数：

- r: [MonoTime](time_package_structs.md#struct-monotime) - 单调时间。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - `true` 或 `false`。当前 [MonoTime](time_package_structs.md#struct-monotime) 实例等于另一个 [MonoTime](time_package_structs.md#struct-monotime) 实例时，返回 `true`；否则，返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    let time1 = MonoTime.now()
    let time2 = time1 // 同一个实例的引用

    // 经过一段时间
    for (i in 0..100000) {
        let _ = i
    }
    let time3 = MonoTime.now() // 不同的实例

    // 测试 == 操作符
    let isEqual1 = time1 == time2 // 相同引用
    let isEqual2 = time1 == time3 // 不同实例

    println("Time1 和 Time2 引用了同一实例")
    println("Time1 == Time2 (相同引用): ${isEqual1}")
    println("Time1 == Time3 (不同实例): ${isEqual2}")
}
```

运行结果：

```text
Time1 和 Time2 引用了同一实例
Time1 == Time2 (相同引用): true
Time1 == Time3 (不同实例): false
```

### operator func >(MonoTime)

```cangjie
public operator func >(r: MonoTime): Bool
```

功能：判断当前 [MonoTime](time_package_structs.md#struct-monotime) 实例是否晚于另一个 [MonoTime](time_package_structs.md#struct-monotime) 实例。

参数：

- r: [MonoTime](time_package_structs.md#struct-monotime) - 单调时间。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - `true` 或 `false`。当前 [MonoTime](time_package_structs.md#struct-monotime) 实例晚于另一个 [MonoTime](time_package_structs.md#struct-monotime) 实例时，返回 `true`；否则，返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    let time1 = MonoTime.now()

    // 等待一小段时间
    for (i in 0..1000000) {
        let _ = i
    }

    let time2 = MonoTime.now()

    // 使用 > 操作符比较
    let isLater = time2 > time1

    println("Time2 晚于 Time1: ${isLater}")
}
```

运行结果：

```text
Time2 晚于 Time1: true
```

### operator func >=(MonoTime)

```cangjie
public operator func >=(r: MonoTime): Bool
```

功能：判断当前 [MonoTime](time_package_structs.md#struct-monotime) 实例是否晚于或等于另一个 [MonoTime](time_package_structs.md#struct-monotime) 实例。

参数：

- r: [MonoTime](time_package_structs.md#struct-monotime) - 单调时间。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - `true` 或 `false`。当前 [MonoTime](time_package_structs.md#struct-monotime) 实例晚于或等于另一个 [MonoTime](time_package_structs.md#struct-monotime) 实例时，返回 `true`；否则，返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    let time1 = MonoTime.now()
    let time2 = time1 // 同一个实例

    // 等待一小段时间
    for (i in 0..1000000) {
        let _ = i
    }
    let time3 = MonoTime.now() // 稍晚的时间

    // 测试 >= 操作符
    let laterOrEqual1 = time2 >= time1 // 相等的情况
    let laterOrEqual2 = time3 >= time1 // 晚于的情况
    let laterOrEqual3 = time1 >= time3 // 早于的情况

    println("Time1 和 Time2 是相同实例")
    println("Time2 >= Time1: ${laterOrEqual1}")
    println("Time3 >= Time1: ${laterOrEqual2}")
    println("Time1 >= Time3: ${laterOrEqual3}")
}
```

运行结果：

```text
Time1 和 Time2 是相同实例
Time2 >= Time1: true
Time3 >= Time1: true
Time1 >= Time3: false
```
