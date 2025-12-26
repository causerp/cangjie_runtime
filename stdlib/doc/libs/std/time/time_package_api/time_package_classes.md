# 类

## class DateTimeFormat

```cangjie
public class DateTimeFormat {
    public static const RFC1123: String = "www, dd MMM yyyy HH:mm:ss z"
    public static const RFC3339: String = "yyyy-MM-ddTHH:mm:ssOOOO"
    public static const RFC822: String = "ww dd MMM yy HH:mm:ss z"
    public static const RFC850: String = "wwww, dd-MMM-yy HH:mm:ss z"
}
```

功能：提供时间格式的功能，用于解析和生成 [DateTime](../time_package_api/time_package_structs.md#struct-datetime) 。

### static const RFC1123

```cangjie
public static const RFC1123: String = "www, dd MMM yyyy HH:mm:ss z"
```

功能：提供 RFC1123 时间格式，时间字符串格式为 `www, dd MMM yyyy HH:mm:ss z`。

类型：[String](../../../std/core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 解析一个 RFC1123 格式的时间字符串
    let rfc1123Str = "Tue, 16 Dec 2025 15:29:25 UTC"
    let parsed = DateTime.parse(rfc1123Str, DateTimeFormat.RFC1123)
    println("解析的时间: ${parsed}")

    // 使用 RFC1123 格式格式化一个 DateTime 对象
    let datetime = parsed
    let formatted = datetime.format(DateTimeFormat.RFC1123)
    println("RFC1123 格式: ${formatted}")
}
```

运行结果：

```text
解析的时间: 2025-12-16T15:29:25Z
RFC1123 格式: Tue, 16 Dec 2025 15:29:25 UTC
```

### static const RFC3339

```cangjie
public static const RFC3339: String = "yyyy-MM-ddTHH:mm:ssOOOO"
```

功能：提供 RFC3339 时间格式，时间字符串格式为 `yyyy-MM-ddTHH:mm:ssOOOO`。

类型：[String](../../../std/core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 解析一个 RFC3339 格式的时间字符串
    let rfc3339Str = "2025-12-16T15:28:29+08:00"
    let parsed = DateTime.parse(rfc3339Str, DateTimeFormat.RFC3339)
    println("解析的时间: ${parsed}")

    // 使用 RFC3339 格式格式化一个 DateTime 对象
    let datetime = parsed
    let formatted = datetime.format(DateTimeFormat.RFC3339)
    println("RFC3339 格式: ${formatted}")
}
```

运行结果：

```text
解析的时间: 2025-12-16T15:28:29+08:00
RFC3339 格式: 2025-12-16T15:28:29+08:00
```

### static const RFC822

```cangjie
public static const RFC822: String = "ww dd MMM yy HH:mm:ss z"
```

功能：提供 RFC822 时间格式，时间字符串格式为 `ww dd MMM yy HH:mm:ss z`。

类型：[String](../../../std/core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 解析一个 RFC822 格式的时间字符串
    let rfc822Str = "02 16 Dec 25 15:27:09 UTC"
    let parsed = DateTime.parse(rfc822Str, DateTimeFormat.RFC822)
    println("解析的时间: ${parsed}")

    // 使用 RFC822 格式格式化一个 DateTime 对象
    let datetime = parsed
    let formatted = datetime.format(DateTimeFormat.RFC822)
    println("RFC822 格式: ${formatted}")
}
```

运行结果：

```text
解析的时间: 2025-12-16T15:27:09Z
RFC822 格式: 02 16 Dec 25 15:27:09 UTC
```

### static const RFC850

```cangjie
public static const RFC850: String = "wwww, dd-MMM-yy HH:mm:ss z"
```

功能：提供 RFC850 时间格式，时间字符串格式为 `wwww, ww-MMM-yy HH:mm:ss z`。

类型：[String](../../../std/core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 解析一个 RFC850 格式的时间字符串
    let rfc850Str = "Tuesday, 16-Dec-25 15:31:43 UTC"
    let parsed = DateTime.parse(rfc850Str, DateTimeFormat.RFC850)
    println("解析的时间: ${parsed}")

    // 使用 RFC850 格式格式化一个 DateTime 对象
    let datetime = parsed
    let formatted = datetime.format(DateTimeFormat.RFC850)
    println("RFC850 格式: ${formatted}")
}
```

运行结果：

```text
解析的时间: 2025-12-16T15:31:43Z
RFC850 格式: Tuesday, 16-Dec-25 15:31:43 UTC
```

### prop format <sup>(deprecated)</sup>

```cangjie
public prop format: String
```

功能：DateTimeFormat实例的字符串格式。

> **注意：**
>
> 未来版本即将废弃不再使用。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建一个 DateTimeFormat 实例
    let formatter = DateTimeFormat.of("yyyy-MM-dd HH:mm:ss")

    // 访问 format 属性（虽然已废弃，但仍可使用）
    let formatStr = formatter.format
    println("格式字符串: ${formatStr}")

    // 使用这个格式创建一个 DateTime 并格式化
    let datetime = DateTime.parse("2025-12-16T15:18:25+08:00", DateTimeFormat.RFC3339)
    let formatted = datetime.format(formatStr)
    println("格式化时间: ${formatted}")
}
```

运行结果：

```text
格式字符串: yyyy-MM-dd HH:mm:ss
格式化时间: 2025-12-16 15:18:25
```

### static func of(String) <sup>(deprecated)</sup>

```cangjie
public static func of(format: String): DateTimeFormat
```

功能：根据字符串创建具体的 DateTimeFormat 类型实例。

字符串的具体格式见[时间字符串格式](../time_package_overview.md#时间字符串格式)

> **注意：**
>
> 未来版本即将废弃不再使用。

参数：

- format: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 字符串格式。

返回值：

- [DateTimeFormat](#class-datetimeformat) - 时间格式。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 当入参格式不符合[时间字符串格式](../time_package_overview.md#时间字符串格式)中字母数量的规定时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 使用已废弃的 of 方法创建 DateTimeFormat 实例
    let formatter = DateTimeFormat.of("yyyy/MM/dd HH:mm:ss z")

    // 解析一个时间字符串
    let timeStr = "2024/12/25 15:30:45 UTC"
    let parsed = DateTime.parse(timeStr, formatter.format)
    println("解析的时间: ${parsed}")

    // 使用这个格式化器格式化一个固定时间
    let datetime = parsed
    let formatted = datetime.format(formatter.format)
    println("格式化的时间: ${formatted}")
}
```

运行结果：

```text
解析的时间: 2024-12-25T15:30:45Z
格式化的时间: 2024/12/25 15:30:45 UTC
```

## class TimeZone

```cangjie
public class TimeZone <: ToString & Equatable<TimeZone> {
    public static let Local: TimeZone
    public static let UTC: TimeZone
    public init(id: String, offset: Duration)
}
```

功能：TimeZone 表示时区，记录了某一地区在不同时间较零时区的时间偏移，提供了从系统加载时区、自定义时区等功能。

父类型：

- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)
- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[TimeZone](#class-timezone)>

### static let Local

```cangjie
public static let Local: TimeZone
```

功能：获取本地时区。

`Local` 从系统环境变量 TZ 中获取时区 ID，并根据该时区 ID 从系统时区文件中加载时区。其行为与函数[load](#static-func-loadstring)相同。

环境变量 TZ 的取值为标准时区 ID 格式（各操作系统遵循相同规范），例如“Asia/Shanghai”。

若环境变量 TZ 未设置或者为空，加载本地时区的规则如下：

- 在 Linux、macOS、OpenHarmony、HarmonyOS、iOS、Android 系统上：加载系统路径“/etc/localtime”链接，时区名与“/etc/localtime”指向的相对路径名相同，例如“Asia/Shanghai”。
- 如果上一条执行失败或者在 Windows 系统上，返回 ID 为 “UTC&偏移量” 的时区，例如“Asia/Shanghai”对应的时区为“UTC+08:00”。

类型：[TimeZone](time_package_classes.md#class-timezone)

示例：

<!-- run -->
```cangjie
import std.time.*

main() {
    // 获取本地时区
    let localTZ = TimeZone.Local
    println("本地时区: ${localTZ}")
    println("本地时区ID: ${localTZ.id}")
}
```

可能的运行结果：

```text
本地时区: Asia/Shanghai
本地时区ID: Asia/Shanghai
```

### static let UTC

```cangjie
public static let UTC: TimeZone
```

功能：获取 UTC 时区。

类型：[TimeZone](time_package_classes.md#class-timezone)

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 获取UTC时区
    let utcTZ = TimeZone.UTC
    println("UTC时区: ${utcTZ}")
    println("UTC时区ID: ${utcTZ.id}")
}
```

可能的运行结果：

```text
UTC时区: UTC
UTC时区ID: UTC
```

### prop id

```cangjie
public prop id: String
```

功能：获取当前 [TimeZone](time_package_classes.md#class-timezone) 实例所关联的时区 ID。

类型：[String](../../core/core_package_api/core_package_structs.md#struct-string)

示例：

<!-- run -->
```cangjie
import std.time.*

main() {
    // 获取本地时区
    let localTZ = TimeZone.Local

    // 获取时区ID
    let tzId = localTZ.id
    println("时区ID: ${tzId}")
}
```

可能的运行结果：

```text
时区ID: Asia/Shanghai
```

### init(String, Duration)

```cangjie
public init(id: String, offset: Duration)
```

功能：使用指定的时区 ID 和偏移量构造一个自定义 [TimeZone](time_package_classes.md#class-timezone) 实例。

参数：

- id: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 时区 ID。使用“/”作为分隔符，例如“Asia/Shanghai”，各操作系统使用相同规范。
- offset: [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - 相对 UTC 时区的偏移量，精度为秒，向东为正、向西为负。取值范围为 (-25 * [Duration](../../core/core_package_api/core_package_structs.md#struct-duration).hour, 26 * [Duration](../../core/core_package_api/core_package_structs.md#struct-duration).hour)。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 当输入 `id` 为空字符串，或 `offset` 超出有效区间时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 使用指定的时区ID和偏移量构造自定义时区
    let customTZ = TimeZone("Custom/Timezone", 8 * Duration.hour)
    println("自定义时区: ${customTZ}")
    println("自定义时区ID: ${customTZ.id}")
}
```

运行结果：

```text
自定义时区: Custom/Timezone
自定义时区ID: Custom/Timezone
```

### static func load(String)

```cangjie
public static func load(id: String): TimeZone
```

功能：从系统中加载参数 `id` 指定的时区。

> **说明：**
>
> - 在 Linux、macOS、OpenHarmony、HarmonyOS、iOS、Android 系统中，若存在环境变量 CJ_TZPATH，则使用环境变量指定的路径加载时区文件（若存在多个通过分隔符 “:” 分开的环境变量值，则按照分隔路径的先后顺序依次查找时区文件，并加载第一个找到的时区文件），否则从系统时区文件目录（例如：Linux 和 macOS 为 "/usr/share/zoneinfo"）加载时区。
> - 在 Windows 系统中，用户需下载[时区文件](https://www.iana.org/time-zones)并编译，设置环境变量 CJ_TZPATH 指向 zoneinfo 目录（若存在多个通过分隔符 “;” 分开的环境变量值，则按照分隔路径的先后顺序依次查找时区文件，并加载第一个找到的时区文件），否则会导致异常。

参数：

- id: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 时区 ID。

返回值：

- [TimeZone](time_package_classes.md#class-timezone) - 时区。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 当参数 `id` 为空，或长度超过 4096 字节，或不符合标准时区 ID 格式时，抛出异常。
- [InvalidDataException](time_package_exceptions.md#class-invaliddataexception) - 当时区文件加载失败(找不到文件，文件解析失败等)时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 从系统中加载指定的时区
    let shanghaiTZ = TimeZone.load("Asia/Shanghai")
    println("上海时区: ${shanghaiTZ}")
    println("上海时区ID: ${shanghaiTZ.id}")

    // 加载UTC时区
    let utcTZ = TimeZone.load("UTC")
    println("UTC时区: ${utcTZ}")
    println("UTC时区ID: ${utcTZ.id}")
}
```

运行结果：

```text
上海时区: Asia/Shanghai
上海时区ID: Asia/Shanghai
UTC时区: UTC
UTC时区ID: UTC
```

### static func loadFromPaths(String, Array\<String>)

```cangjie
public static func loadFromPaths(id: String, tzpaths: Array<String>): TimeZone
```

功能：根据参数 `tzpaths` 指定的时区文件目录，加载参数 `id` 指定的时区。

加载时区时，将从第一个被读取成功的时区文件路径中加载时区。时区文件格式需要满足[时区信息格式](https://datatracker.ietf.org/doc/html/rfc8536)。

参数：

- id: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 时区 ID。
- tzpaths: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[String](../../core/core_package_api/core_package_structs.md#struct-string)> - 时区文件路径数组。

返回值：

- [TimeZone](time_package_classes.md#class-timezone) - 加载的时区。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 当 `id` 为空，或长度超过 4096 字节，或不符合标准时区 ID 格式时，抛出异常。
- [InvalidDataException](time_package_exceptions.md#class-invaliddataexception) - 当时区文件加载失败(找不到文件，文件解析失败等)时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.time.*

main(): Int64 {
    // 创建时区文件路径数组
    let tzPaths = ["/usr/share/zoneinfo", "/etc/zoneinfo"]

    // 注意：实际使用时需要确保路径存在且包含有效的时区文件
    println("时区文件搜索路径:")
    for (path in tzPaths) {
        println("  ${path}")
    }
    let tz = TimeZone.loadFromPaths("Asia/Shanghai", tzPaths)
    println("时区ID: ${tz.id}")
    return 0
}
```

运行结果：

```text
时区文件搜索路径:
  /usr/share/zoneinfo
  /etc/zoneinfo
时区ID: Asia/Shanghai
```

### static func loadFromTZData(String, Array\<UInt8>)

```cangjie
public static func loadFromTZData(id: String, data: Array<UInt8>): TimeZone
```

功能：使用指定的时区 ID 和时区数据构造一个自定义 [TimeZone](time_package_classes.md#class-timezone) 实例。`id` 可以是任何合法字符串，`data` 需要满足 IANA 时区文件格式，加载成功时获得 [TimeZone](time_package_classes.md#class-timezone) 实例，否则抛出异常。

参数：

- id: [String](../../core/core_package_api/core_package_structs.md#struct-string) - 时区 ID。
- data: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)> - 满足[时区信息格式](https://datatracker.ietf.org/doc/html/rfc8536)的数据。

返回值：

- [TimeZone](time_package_classes.md#class-timezone) - 加载的时区。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 当 `id` 为空时，抛出异常。
- [InvalidDataException](time_package_exceptions.md#class-invaliddataexception) - 如果 `data` 解析失败，则抛出异常。

示例：

<!-- verify -->
```cangjie
import std.time.*
import std.fs.*

main(): Int64 {
    // 一般情况下，时区数据文件位于 /usr/share/zoneinfo 目录下
    let tzData = File.readFrom("/usr/share/zoneinfo/Asia/Shanghai")
    let tz = TimeZone.loadFromTZData("Asia/Shanghai", tzData)
    println("时区ID: ${tz.id}")
    return 0
}
```

运行结果：

```text
时区ID: Asia/Shanghai
```

### func toString()

```cangjie
public func toString(): String
```

功能：获取本 [TimeZone](time_package_classes.md#class-timezone) 实例时区 ID 的字符串表示。

返回值：

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - 时区 ID 的字符串表示。

示例：

<!-- run -->
```cangjie
import std.time.*

main() {
    // 获取本地时区
    let localTZ = TimeZone.Local

    // 获取时区的字符串表示
    let tzStr = localTZ.toString()
    println("时区的字符串表示: ${tzStr}")

    // 获取UTC时区的字符串表示
    let utcTZ = TimeZone.UTC
    let utcStr = utcTZ.toString()
    println("UTC时区的字符串表示: ${utcStr}")
}
```

可能的运行结果：

```text
时区的字符串表示: Asia/Shanghai
UTC时区的字符串表示: UTC
```

### operator func !=(TimeZone)

```cangjie
public operator func !=(r: TimeZone): Bool
```

功能：判断当前 [TimeZone](time_package_classes.md#class-timezone) 实例的引用是否不等于 `r` 的引用。

参数：

- r: [TimeZone](time_package_classes.md#class-timezone) - [TimeZone](time_package_classes.md#class-timezone) 实例。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - `true` 或 `false`。当前 [TimeZone](time_package_classes.md#class-timezone) 实例的引用不等于 `r` 的引用时，返回 `true`；否则，返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 获取本地时区
    let localTZ = TimeZone.Local

    // 获取UTC时区
    let utcTZ = TimeZone.UTC

    // 使用 != 操作符比较两个时区是否不相等
    if (localTZ != utcTZ) {
        println("本地时区与UTC时区不相等")
    } else {
        println("本地时区与UTC时区相等")
    }

    // 创建另一个本地时区引用进行比较
    let localTZ2 = TimeZone.Local
    if (localTZ != localTZ2) {
        println("两个本地时区引用不相等")
    } else {
        println("两个本地时区引用相等")
    }
}
```

运行结果：

```text
本地时区与UTC时区不相等
两个本地时区引用相等
```

### operator func ==(TimeZone)

```cangjie
public operator func ==(r: TimeZone): Bool
```

功能：判断当前 [TimeZone](time_package_classes.md#class-timezone) 实例的引用是否等于 `r` 的引用。

参数：

- r: [TimeZone](time_package_classes.md#class-timezone) - [TimeZone](time_package_classes.md#class-timezone) 实例。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - `true` 或 `false`。当前 [TimeZone](time_package_classes.md#class-timezone) 实例的引用等于 `r` 的引用时，返回 `true`；否则，返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 获取本地时区
    let localTZ = TimeZone.Local

    // 获取UTC时区
    let utcTZ = TimeZone.UTC

    // 使用 == 操作符比较两个时区是否相等
    if (localTZ == utcTZ) {
        println("本地时区与UTC时区相等")
    } else {
        println("本地时区与UTC时区不相等")
    }

    // 创建另一个本地时区引用进行比较
    let localTZ2 = TimeZone.Local
    if (localTZ == localTZ2) {
        println("两个本地时区引用相等")
    } else {
        println("两个本地时区引用不相等")
    }
}
```

运行结果：

```text
本地时区与UTC时区不相等
两个本地时区引用相等
```
