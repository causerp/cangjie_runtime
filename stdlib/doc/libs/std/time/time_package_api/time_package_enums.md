# 枚举

## enum DayOfWeek

```cangjie
public enum DayOfWeek <: ToString & Equatable<DayOfWeek> {
    | Sunday
    | Monday
    | Tuesday
    | Wednesday
    | Thursday
    | Friday
    | Saturday
}
```

功能：[DayOfWeek](time_package_enums.md#enum-dayofweek) 表示一周中的某一天，提供了与 [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) 类型转换，相等性判别以及获取枚举值的字符串表示的功能。

父类型：

- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)
- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[DayOfWeek](time_package_enums.md#enum-dayofweek)>

### Friday

```cangjie
Friday
```

功能：构造一个表示周五的 [DayOfWeek](time_package_enums.md#enum-dayofweek) 实例。

### Monday

```cangjie
Monday
```

功能：构造一个表示周一的 [DayOfWeek](time_package_enums.md#enum-dayofweek) 实例。

### Saturday

```cangjie
Saturday
```

功能：构造一个表示周六的 [DayOfWeek](time_package_enums.md#enum-dayofweek) 实例。

### Sunday

```cangjie
Sunday
```

功能：构造一个表示周日的 [DayOfWeek](time_package_enums.md#enum-dayofweek) 实例。

### Thursday

```cangjie
Thursday
```

功能：构造一个表示周四的 [DayOfWeek](time_package_enums.md#enum-dayofweek) 实例。

### Tuesday

```cangjie
Tuesday
```

功能：构造一个表示周二的 [DayOfWeek](time_package_enums.md#enum-dayofweek) 实例。

### Wednesday

```cangjie
Wednesday
```

功能：构造一个表示周三的 [DayOfWeek](time_package_enums.md#enum-dayofweek) 实例。

### static func of(Int64)

```cangjie
public static func of(dayOfWeek: Int64): DayOfWeek
```

功能：获取参数 `dayOfWeek` 对应的 [DayOfWeek](time_package_enums.md#enum-dayofweek) 实例。

参数：

- dayOfWeek: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 周几的整数表示，合法范围为 [0, 6]。其中，0 表示周日，1 至 6 表示周一至周六。

返回值：

- [DayOfWeek](time_package_enums.md#enum-dayofweek) - 参数 `dayOfWeek` 对应的 [DayOfWeek](time_package_enums.md#enum-dayofweek) 实例。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 当参数 `dayOfWeek` 不在 [0, 6] 范围内时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 使用 of 函数创建 DayOfWeek 实例
    let monday = DayOfWeek.of(1)
    let friday = DayOfWeek.of(5)
    let sunday = DayOfWeek.of(0)

    println("周一: ${monday}")
    println("周五: ${friday}")
    println("周日: ${sunday}")

    // 尝试创建一个无效的值（会抛出异常）
    try {
        DayOfWeek.of(7) // 这会抛出 IllegalArgumentException
    } catch (e: IllegalArgumentException) {
        println("异常: ${e.message}")
    }
    return 0
}
```

运行结果：

```text
周一: Monday
周五: Friday
周日: Sunday
异常: The input parameter ranges from 0 to 6
```

### func toInteger()

```cangjie
public func toInteger(): Int64
```

功能：获取当前 [DayOfWeek](time_package_enums.md#enum-dayofweek) 实例的整数表示，周日表示为 0，周一至周六表示为 1 至 6。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 当前 [DayOfWeek](time_package_enums.md#enum-dayofweek) 实例的整数表示。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建一些 DayOfWeek 实例
    let monday = DayOfWeek.Monday
    let friday = DayOfWeek.Friday
    let sunday = DayOfWeek.Sunday

    // 使用 toInteger 函数获取整数表示
    let monInt = monday.toInteger()
    let friInt = friday.toInteger()
    let sunInt = sunday.toInteger()

    println("周一的整数表示: ${monInt}")
    println("周五的整数表示: ${friInt}")
    println("周日的整数表示: ${sunInt}")
}
```

运行结果：

```text
周一的整数表示: 1
周五的整数表示: 5
周日的整数表示: 0
```

### func toString()

```cangjie
public func toString(): String
```

功能：返回当前 [DayOfWeek](time_package_enums.md#enum-dayofweek) 实例的字符串表示，如 "Monday" 表示周一。

返回值：

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - 当前 [DayOfWeek](time_package_enums.md#enum-dayofweek) 实例的字符串表示。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建一些 DayOfWeek 实例
    let monday = DayOfWeek.Monday
    let friday = DayOfWeek.Friday
    let sunday = DayOfWeek.Sunday

    // 使用 toString 函数获取字符串表示
    let monStr = monday.toString()
    let friStr = friday.toString()
    let sunStr = sunday.toString()

    println("周一的字符串表示: ${monStr}")
    println("周五的字符串表示: ${friStr}")
    println("周日的字符串表示: ${sunStr}")
}
```

运行结果：

```text
周一的字符串表示: Monday
周五的字符串表示: Friday
周日的字符串表示: Sunday
```

### func value() <sup>(deprecated)</sup>

```cangjie
public func value(): Int64
```

功能：获取当前 [DayOfWeek](time_package_enums.md#enum-dayofweek) 实例的整数表示，周日表示为 0，周一至周六表示为 1 至 6。

> **注意：**
>
> 未来版本即将废弃，可使用 [toInteger()](#func-tointeger) 替代。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 当前 [DayOfWeek](time_package_enums.md#enum-dayofweek) 实例的整数表示。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建一些 DayOfWeek 实例
    let monday = DayOfWeek.Monday
    let friday = DayOfWeek.Friday
    let sunday = DayOfWeek.Sunday

    // 使用已废弃的 value 函数获取整数表示
    let monInt = monday.value()
    let friInt = friday.value()
    let sunInt = sunday.value()

    println("周一的整数表示: ${monInt}")
    println("周五的整数表示: ${friInt}")
    println("周日的整数表示: ${sunInt}")

    // 推荐使用 toInteger() 替代
    println("推荐使用 toInteger() 替代 value()")
}
```

运行结果：

```text
周一的整数表示: 1
周五的整数表示: 5
周日的整数表示: 0
推荐使用 toInteger() 替代 value()
```

### operator func !=(DayOfWeek)

```cangjie
public operator func !=(r: DayOfWeek): Bool
```

功能：判断当前 [DayOfWeek](time_package_enums.md#enum-dayofweek) 和 `r` 是否不为一周中的同一天。

参数：

- r: [DayOfWeek](time_package_enums.md#enum-dayofweek) - [DayOfWeek](time_package_enums.md#enum-dayofweek) 实例。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - `true` 或 `false`。当前 [DayOfWeek](time_package_enums.md#enum-dayofweek) 实例不等于 `r` 时，返回 `true`；否则，返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建一些 DayOfWeek 实例
    let monday = DayOfWeek.Monday
    let friday = DayOfWeek.Friday
    let anotherMonday = DayOfWeek.Monday

    // 使用 != 操作符比较两个 DayOfWeek 实例
    if (monday != friday) {
        println("周一不等于周五")
    } else {
        println("周一等于周五")
    }

    if (monday != anotherMonday) {
        println("两个周一实例不相等")
    } else {
        println("两个周一实例相等")
    }
}
```

运行结果：

```text
周一不等于周五
两个周一实例相等
```

### operator func +(Int64)

```cangjie
public operator func +(n: Int64): DayOfWeek
```

功能：计算基于当前实例 `n` 天之后（n 为正数时）的表示值。若 `n` 为负数，则表示当天之前。

参数：

- n: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 后多少天。

返回值：

- [DayOfWeek](time_package_enums.md#enum-dayofweek) - `n` 天后的周数值。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建一个 DayOfWeek 实例
    let monday = DayOfWeek.Monday

    // 使用 + 操作符计算几天后的星期几
    let wednesday = monday + 2 // 周一 + 2天 = 周三
    let sunday = monday + 6 // 周一 + 6天 = 周日
    let nextMonday = monday + 7 // 周一 + 7天 = 下周一（还是周一）

    println("周一: ${monday}")
    println("周一 + 2天 = ${wednesday}")
    println("周一 + 6天 = ${sunday}")
    println("周一 + 7天 = ${nextMonday}")

    // 计算负数天数
    let saturday = monday + (-2) // 周一 - 2天 = 周六
    println("周一 - 2天 = ${saturday}")
}
```

运行结果：

```text
周一: Monday
周一 + 2天 = Wednesday
周一 + 6天 = Sunday
周一 + 7天 = Monday
周一 - 2天 = Saturday
```

### operator func -(Int64)

```cangjie
public operator func -(n: Int64): DayOfWeek
```

功能：计算基于当前实例 `n` 天之前（n 为正数时）的表示值。若 `n` 为负数，则表示当天之后。

参数：

- n: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 前多少天。

返回值：

- [DayOfWeek](time_package_enums.md#enum-dayofweek) - `n` 天前的周数值。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建一个 DayOfWeek 实例
    let monday = DayOfWeek.Monday

    // 使用 - 操作符计算几天前的星期几
    let saturday = monday - 2 // 周一 - 2天 = 周六
    let wednesday = monday - (-2) // 周一 - (-2天) = 周三

    println("周一: ${monday}")
    println("周一 - 2天 = ${saturday}")
    println("周一 - (-2天) = ${wednesday}")

    // 计算跨越一周的情况
    let previousFriday = monday - 3 // 周一 - 3天 = 上周五
    println("周一 - 3天 = ${previousFriday}")
}
```

运行结果：

```text
周一: Monday
周一 - 2天 = Saturday
周一 - (-2天) = Wednesday
周一 - 3天 = Friday
```

### operator func ==(DayOfWeek)

```cangjie
public operator func ==(r: DayOfWeek): Bool
```

功能：判断当前 [DayOfWeek](time_package_enums.md#enum-dayofweek) 和 `r` 是否表示一周中的同一天。

参数：

- r: [DayOfWeek](time_package_enums.md#enum-dayofweek) - [DayOfWeek](time_package_enums.md#enum-dayofweek) 实例。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - `true` 或 `false`。当前 [DayOfWeek](time_package_enums.md#enum-dayofweek) 实例等于 `r` 时，返回 `true`；否则，返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建一些 DayOfWeek 实例
    let monday = DayOfWeek.Monday
    let friday = DayOfWeek.Friday
    let anotherMonday = DayOfWeek.Monday

    // 使用 == 操作符比较两个 DayOfWeek 实例
    if (monday == friday) {
        println("周一等于周五")
    } else {
        println("周一不等于周五")
    }

    if (monday == anotherMonday) {
        println("两个周一实例相等")
    } else {
        println("两个周一实例不相等")
    }
}
```

运行结果：

```text
周一不等于周五
两个周一实例相等
```

## enum Month

```cangjie
public enum Month <: ToString & Equatable<Month> {
    | January
    | February
    | March
    | April
    | May
    | June
    | July
    | August
    | September
    | October
    | November
    | December
}
```

功能：[Month](time_package_enums.md#enum-month) 用以表示月份，表示一年中的某一月，提供了与 [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) 类型转换和计算，相等性判别以及获取枚举值的字符串表示的功能。

父类型：

- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)
- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[Month](time_package_enums.md#enum-month)>

### April

```cangjie
April
```

功能：构造一个表示四月的 [Month](time_package_enums.md#enum-month) 实例。

### August

```cangjie
August
```

功能：构造一个表示八月的 [Month](time_package_enums.md#enum-month) 实例。

### December

```cangjie
December
```

功能：构造一个表示十二月的 [Month](time_package_enums.md#enum-month) 实例。

### February

```cangjie
February
```

功能：构造一个表示二月的 [Month](time_package_enums.md#enum-month) 实例。

### January

```cangjie
January
```

功能：构造一个表示一月的 [Month](time_package_enums.md#enum-month) 实例。

### July

```cangjie
July
```

功能：构造一个表示七月的 [Month](time_package_enums.md#enum-month) 实例。

### June

```cangjie
June
```

功能：构造一个表示六月的 [Month](time_package_enums.md#enum-month) 实例。

### March

```cangjie
March
```

功能：构造一个表示三月的 [Month](time_package_enums.md#enum-month) 实例。

### May

```cangjie
May
```

功能：构造一个表示五月的 [Month](time_package_enums.md#enum-month) 实例。

### November

```cangjie
November
```

功能：构造一个表示十一月的 [Month](time_package_enums.md#enum-month) 实例。

### October

```cangjie
October
```

功能：构造一个表示十月的 [Month](time_package_enums.md#enum-month) 实例。

### September

```cangjie
September
```

功能：构造一个表示九月的 [Month](time_package_enums.md#enum-month) 实例。

### static func of(Int64)

```cangjie
public static func of(mon: Int64): Month
```

功能：获取参数 `mon` 对应 [Month](time_package_enums.md#enum-month) 类型实例。

参数：

- mon: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 整数形式的月，合法范围为 [1, 12]，分别表示一年中的十二个月。

返回值：

- [Month](time_package_enums.md#enum-month) - 参数 `mon` 对应的 [Month](time_package_enums.md#enum-month) 类型实例。

异常：

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - 当参数 `mon` 不在 [1, 12] 范围内时，抛出异常。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 使用 of 函数创建 Month 实例
    let january = Month.of(1)
    let june = Month.of(6)
    let december = Month.of(12)

    println("一月: ${january}")
    println("六月: ${june}")
    println("十二月: ${december}")

    // 尝试创建一个无效的值（会抛出异常）
    try {
        Month.of(13) // 这会抛出 IllegalArgumentException
    } catch (e: IllegalArgumentException) {
        println("异常: ${e.message}")
    }
    return 0
}
```

运行结果：

```text
一月: January
六月: June
十二月: December
异常: The input parameter ranges from 1 to 12
```

### func toInteger()

```cangjie
public func toInteger(): Int64
```

功能：获取当前 [Month](time_package_enums.md#enum-month) 实例的整数表示，一月至十二月分别表示为 1 至 12。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 当前 [Month](time_package_enums.md#enum-month) 实例的整数表示。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建一些 Month 实例
    let january = Month.January
    let june = Month.June
    let december = Month.December

    // 使用 toInteger 函数获取整数表示
    let janInt = january.toInteger()
    let junInt = june.toInteger()
    let decInt = december.toInteger()

    println("一月的整数表示: ${janInt}")
    println("六月的整数表示: ${junInt}")
    println("十二月的整数表示: ${decInt}")
}
```

运行结果：

```text
一月的整数表示: 1
六月的整数表示: 6
十二月的整数表示: 12
```

### func toString()

```cangjie
public func toString(): String
```

功能：返回当前 [Month](time_package_enums.md#enum-month) 实例的字符串表示，如 "January" 表示一月。

返回值：

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - 当前 [Month](time_package_enums.md#enum-month) 实例的字符串表示。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建一些 Month 实例
    let january = Month.January
    let june = Month.June
    let december = Month.December

    // 使用 toString 函数获取字符串表示
    let janStr = january.toString()
    let junStr = june.toString()
    let decStr = december.toString()

    println("一月的字符串表示: ${janStr}")
    println("六月的字符串表示: ${junStr}")
    println("十二月的字符串表示: ${decStr}")
}
```

运行结果：

```text
一月的字符串表示: January
六月的字符串表示: June
十二月的字符串表示: December
```

### func value() <sup>(deprecated)</sup>

```cangjie
public func value(): Int64
```

功能：获取当前 [Month](time_package_enums.md#enum-month) 实例的整数表示，一月至十二月分别表示为 1 至 12。

> **注意：**
>
> 未来版本即将废弃，可使用 [toInteger()](#func-tointeger-1) 替代。

返回值：

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 当前 [Month](time_package_enums.md#enum-month) 实例的整数表示。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建一些 Month 实例
    let january = Month.January
    let june = Month.June
    let december = Month.December

    // 使用已废弃的 value 函数获取整数表示
    let janInt = january.value()
    let junInt = june.value()
    let decInt = december.value()

    println("一月的整数表示: ${janInt}")
    println("六月的整数表示: ${junInt}")
    println("十二月的整数表示: ${decInt}")

    // 推荐使用 toInteger() 替代
    println("推荐使用 toInteger() 替代 value()")
}
```

运行结果：

```text
一月的整数表示: 1
六月的整数表示: 6
十二月的整数表示: 12
推荐使用 toInteger() 替代 value()
```

### operator func !=(Month)

```cangjie
public operator func !=(r: Month): Bool
```

功能：判断当前 [Month](time_package_enums.md#enum-month) 实例和 `r` 是否不为同一个月。

参数：

- r: [Month](time_package_enums.md#enum-month) - [Month](time_package_enums.md#enum-month) 实例。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - 当前 [Month](time_package_enums.md#enum-month) 实例是否不等于 `r`。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建一些 Month 实例
    let january = Month.January
    let june = Month.June
    let anotherJanuary = Month.January

    // 使用 != 操作符比较两个 Month 实例
    if (january != june) {
        println("一月不等于六月")
    } else {
        println("一月等于六月")
    }

    if (january != anotherJanuary) {
        println("两个一月实例不相等")
    } else {
        println("两个一月实例相等")
    }
}
```

运行结果：

```text
一月不等于六月
两个一月实例相等
```

### operator func +(Int64)

```cangjie
public operator func +(n: Int64): Month
```

功能：计算基于当前日历月份 `n` 个月之后（n 为正数时）的日历月份。若 `n` 为负数，则表示当月之前。

参数：

- n: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 后多少月的数量。

返回值：

- [Month](time_package_enums.md#enum-month) - `n` 月后的月份。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建一个 Month 实例
    let january = Month.January

    // 使用 + 操作符计算几个月后的月份
    let march = january + 2 // 一月 + 2个月 = 三月
    let july = january + 6 // 一月 + 6个月 = 七月
    let nextJanuary = january + 12 // 一月 + 12个月 = 下一年的一月

    println("一月: ${january}")
    println("一月 + 2个月 = ${march}")
    println("一月 + 6个月 = ${july}")
    println("一月 + 12个月 = ${nextJanuary}")

    // 计算负数月数
    let november = january + (-2) // 一月 - 2个月 = 十一月
    println("一月 - 2个月 = ${november}")
}
```

运行结果：

```text
一月: January
一月 + 2个月 = March
一月 + 6个月 = July
一月 + 12个月 = January
一月 - 2个月 = November
```

### operator func -(Int64)

```cangjie
public operator func -(n: Int64): Month
```

功能：计算基于当前日历月份 `n` 个前之后（n 为正数时）的日历月份。若 `n` 为负数，则表示当月之后。

参数：

- n: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - 前多少月的数量。

返回值：

- [Month](time_package_enums.md#enum-month) - `n` 月前的月份。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建一个 Month 实例
    let january = Month.January

    // 使用 - 操作符计算几个月前的月份
    let november = january - 2 // 一月 - 2个月 = 十一月
    let july = january - (-6) // 一月 - (-6个月) = 七月

    println("一月: ${january}")
    println("一月 - 2个月 = ${november}")
    println("一月 - (-6个月) = ${july}")

    // 计算跨越年的月份
    let previousJuly = january - 6 // 一月 - 6个月 = 上一年的七月
    println("一月 - 6个月 = ${previousJuly}")
}
```

运行结果：

```text
一月: January
一月 - 2个月 = November
一月 - (-6个月) = July
一月 - 6个月 = July
```

### operator func ==(Month)

```cangjie
public operator func ==(r: Month): Bool
```

功能：判断当前 [Month](time_package_enums.md#enum-month) 实例和 `r` 是否表示同一个月。

参数：

- r: [Month](time_package_enums.md#enum-month) - [Month](time_package_enums.md#enum-month) 实例。

返回值：

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - `true` 或 `false`。当前 [Month](time_package_enums.md#enum-month) 实例等于 `r` 时，返回 `true`；否则，返回 `false`。

示例：

<!-- verify -->
```cangjie
import std.time.*

main() {
    // 创建一些 Month 实例
    let january = Month.January
    let june = Month.June
    let anotherJanuary = Month.January

    // 使用 == 操作符比较两个 Month 实例
    if (january == june) {
        println("一月等于六月")
    } else {
        println("一月不等于六月")
    }

    if (january == anotherJanuary) {
        println("两个一月实例相等")
    } else {
        println("两个一月实例不相等")
    }
}
```

运行结果：

```text
一月不等于六月
两个一月实例相等
```
