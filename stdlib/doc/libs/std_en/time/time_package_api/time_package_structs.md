# Struct

## struct DateTime

```cangjie
public struct DateTime <: ToString & Hashable & Comparable<DateTime> & Formattable & Parsable<DateTime>
```

Description: [DateTime](time_package_structs.md#struct-datetime) represents date and time, a temporal type describing a specific point in time. It provides timezone-based date-time reading, calculation, comparison, conversion, as well as serialization and deserialization functionalities.

- [DateTime](time_package_structs.md#struct-datetime) is an immutable type containing date, time, and timezone information. It can represent time within the range [-999,999,999-01-01T00:00:00.000000000, 999,999,999-12-31T23:59:59.999999999], which applies to any valid timezone.
- The following system calls are used by [DateTime](time_package_structs.md#struct-datetime)'s [now](#static-func-nowtimezone) and [nowUTC](#static-func-nowutc) functions to obtain the current time:

  | System    | System Call      | Clock Type     |
  | --------- | ---------------- | -------------- |
  | Linux     | clock_gettime    | CLOCK_REALTIME |
  | Windows   | clock_gettime    | CLOCK_REALTIME |
  | macOS     | clock_gettime    | CLOCK_REALTIME |

Parent Types:

- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)
- [Hashable](../../core/core_package_api/core_package_interfaces.md#interface-hashable)
- [Comparable](../../core/core_package_api/core_package_interfaces.md#interface-comparablet)\<[DateTime](#struct-datetime)>
- [Formattable](../../convert/convert_package_api/convert_package_interfaces.md#interface-formattable)
- [Parsable](../../convert/convert_package_api/convert_package_interfaces.md#interface-parsablet)\<[DateTime](#struct-datetime)>

### static prop UnixEpoch

```cangjie
public static prop UnixEpoch: DateTime
```

Description: Gets the Unix epoch time, which is a [DateTime](time_package_structs.md#struct-datetime) instance representing `January 1, 1970 00:00:00.000000000` in UTC timezone.

Type: [DateTime](time_package_structs.md#struct-datetime)

### prop dayOfMonth

```cangjie
public prop dayOfMonth: Int64
```

Description: Gets the day of the month from the [DateTime](time_package_structs.md#struct-datetime) instance.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### prop dayOfWeek

```cangjie
public prop dayOfWeek: DayOfWeek
```

Description: Gets the day of the week from the [DateTime](time_package_structs.md#struct-datetime) instance.

Type: [DayOfWeek](time_package_enums.md#enum-dayofweek)

### prop dayOfYear

```cangjie
public prop dayOfYear: Int64
```

Description: Gets the day of the year from the [DateTime](time_package_structs.md#struct-datetime) instance.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### prop date

```cangjie
public prop date: (Int64, Month, Int64)
```

Description: Gets the year, month, and day of month from the [DateTime](time_package_structs.md#struct-datetime) instance.

Type: ([Int64](../../core/core_package_api/core_package_intrinsics.md#int64),[Month](time_package_enums.md#enum-month), [Int64](../../core/core_package_api/core_package_intrinsics.md#int64))

### prop hour

```cangjie
public prop hour: Int64
```

Description: Gets the hour from the [DateTime](time_package_structs.md#struct-datetime) instance.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### prop isoWeek

```cangjie
public prop isoWeek: (Int64, Int64)
```

Description: Gets the ISO8601 standard year and week number from the [DateTime](time_package_structs.md#struct-datetime) instance.

Type: ([Int64](../../core/core_package_api/core_package_intrinsics.md#int64), [Int64](../../core/core_package_api/core_package_intrinsics.md#int64))

### prop minute

```cangjie
public prop minute: Int64
```

Description: Gets the minute from the [DateTime](time_package_structs.md#struct-datetime) instance.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### prop month

```cangjie
public prop month: Month
```

Description: Gets the month from the [DateTime](time_package_structs.md#struct-datetime) instance.

Type: [Month](time_package_enums.md#enum-month)

### prop monthValue <sup>(deprecated)</sup>

```cangjie
public prop monthValue: Int64
```

Description: Gets the numeric representation of the month from the [DateTime](time_package_structs.md#struct-datetime) instance.

> **Note:**
>
> This property will be deprecated in future versions.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### prop nanosecond

```cangjie
public prop nanosecond: Int64
```

Description: Gets the nanosecond from the [DateTime](time_package_structs.md#struct-datetime) instance.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### prop second

```cangjie
public prop second: Int64
```

Description: Gets the second from the [DateTime](time_package_structs.md#struct-datetime) instance.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### prop year

```cangjie
public prop year: Int64
```

Description: Gets the year from the [DateTime](time_package_structs.md#struct-datetime) instance.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### prop time

```cangjie
public prop time: (Int64, Int64, Int64)
```

Description: Gets the hour, minute, and second from the [DateTime](time_package_structs.md#struct-datetime) instance.

Type: ([Int64](../../core/core_package_api/core_package_intrinsics.md#int64),[Int64](../../core/core_package_api/core_package_intrinsics.md#int64), [Int64](../../core/core_package_api/core_package_intrinsics.md#int64))

### prop zone

```cangjie
public prop zone: TimeZone
```

Description: Gets the associated timezone of the [DateTime](time_package_structs.md#struct-datetime) instance.

Type: [TimeZone](time_package_classes.md#class-timezone)

### prop zoneId

```cangjie
public prop zoneId: String
```

Description: Gets the timezone ID of the associated [TimeZone](time_package_classes.md#class-timezone) instance from the [DateTime](time_package_structs.md#struct-datetime) instance.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop zoneOffset

```cangjie
public prop zoneOffset: Duration
```

Description: Gets the time offset of the associated [TimeZone](time_package_classes.md#class-timezone) instance from the [DateTime](time_package_structs.md#struct-datetime) instance.

Type: [Duration](../../core/core_package_api/core_package_structs.md#struct-duration)

### static func fromUnixTimeStamp(Duration)

```cangjie
public static func fromUnixTimeStamp(d: Duration): DateTime
```

Description: Gets the date and time after the specified duration `d` from [UnixEpoch](#static-prop-unixepoch).

Parameters:

- d: [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - The time duration.

Return Value:

- [DateTime](time_package_structs.md#struct-datetime) - The date and time after the specified `d` from [UnixEpoch](#static-prop-unixepoch).

Exceptions:

- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - Thrown when the result exceeds the representable range of DateTime.

### static func now(TimeZone)

```cangjie
public static func now(timeZone!: TimeZone = TimeZone.Local): DateTime
```

Description: Gets the current time in the specified timezone `timeZone`. The obtained time is affected by system time. For timing scenarios that should not be affected by system time, use [MonoTime](time_package_structs.md#struct-monotime).now() instead.

Parameters:

- timeZone!: [TimeZone](time_package_classes.md#class-timezone) - The timezone, defaults to local timezone.

Return Value:

- [DateTime](time_package_structs.md#struct-datetime) - Returns the current time in the specified timezone.

### static func nowUTC()

```cangjie
public static func nowUTC(): DateTime
```

Description: Gets the current time in UTC timezone. The obtained time is affected by system time. For timing scenarios that should not be affected by system time, use [MonoTime](time_package_structs.md#struct-monotime).now() instead.

Return Value:

- [DateTime](time_package_structs.md#struct-datetime) - Current time in UTC timezone.

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

Description: Constructs a [DateTime](time_package_structs.md#struct-datetime) instance based on the specified year, month, day, hour, minute, second, nanosecond, and timezone.

Parameters:

- year!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Year, range [-999,999,999, 999,999,999].
- month!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Month, range [1, 12].
- dayOfMonth!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Day, range [1, 31], maximum value depends on month (could be 28, 29, 30, or 31).
- hour!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Hour, range [0, 23].
- minute!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Minute, range [0, 59].
- second!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Second, range [0, 59].
- nanosecond!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Nanosecond, range [0, 999,999,999].
- timeZone!: [TimeZone](time_package_classes.md#class-timezone) - Timezone.

Return Value:

- [DateTime](time_package_structs.md#struct-datetime) - A [DateTime](time_package_structs.md#struct-datetime) instance constructed based on the specified parameters.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when parameter values exceed the specified ranges.

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
Function: Constructs a [DateTime](time_package_structs.md#struct-datetime) instance based on specified year, month, day, hour, minute, second, nanosecond, and timezone parameters.

Parameters:

- year!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Year, range [-999,999,999, 999,999,999].
- month!: [Month](time_package_enums.md#enum-month) - Month, of type [Month](time_package_enums.md#enum-month).
- dayOfMonth!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Day, range [1, 31]. Maximum value must match the month (could be 28, 29, 30, or 31).
- hour!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Hour, range [0, 23].
- minute!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Minute, range [0, 59].
- second!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Second, range [0, 59].
- nanosecond!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Nanosecond, range [0, 999,999,999].
- timeZone!: [TimeZone](time_package_classes.md#class-timezone) - Timezone.

Return Value:

- [DateTime](time_package_structs.md#struct-datetime) - A [DateTime](time_package_structs.md#struct-datetime) instance constructed from the specified parameters.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when parameter values exceed specified ranges.

### static func ofEpoch(Int64, Int64)

```cangjie
public static func ofEpoch(second!: Int64, nanosecond!: Int64): DateTime
```

Function: Constructs a [DateTime](time_package_structs.md#struct-datetime) instance based on input parameters `second` and `nanosecond`. The `second` parameter represents the seconds portion of Unix time, while `nanosecond` represents the nanoseconds portion. Unix time starts counting from [UnixEpoch](#static-prop-unixepoch). The `nanosecond` range must not exceed [0, 999,999,999]; otherwise, an exception will be thrown.

Parameters:

- second!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Seconds portion of Unix time.
- nanosecond!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Nanoseconds portion of Unix time, range must not exceed [0, 999,999,999].

Return Value:

- [DateTime](time_package_structs.md#struct-datetime) - Time after the specified `second` and `nanosecond` from [UnixEpoch](#static-prop-unixepoch).

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when `nanosecond` value exceeds the specified range.
- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - Thrown when the result exceeds the representable range of date-time.

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

Function: Constructs a UTC timezone [DateTime](time_package_structs.md#struct-datetime) instance based on specified year, month, day, hour, minute, second, and nanosecond parameters.

Parameters:

- year!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Year, range [-999,999,999, 999,999,999].
- month!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Month, range [1, 12].
- dayOfMonth!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Day, range [1, 31]. Maximum value must match the month (could be 28, 29, 30, or 31).
- hour!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Hour, range [0, 23].
- minute!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Minute, range [0, 59].
- second!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Second, range [0, 59].
- nanosecond!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Nanosecond, range [0, 999,999,999].

Return Value:

- [DateTime](time_package_structs.md#struct-datetime) - A UTC timezone [DateTime](time_package_structs.md#struct-datetime) instance constructed from the specified parameters.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when parameter values exceed specified ranges.

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

Function: Constructs a UTC timezone [DateTime](time_package_structs.md#struct-datetime) instance based on specified year, month, day, hour, minute, second, and nanosecond parameters.

Parameters:

- year!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Year, range [-999,999,999, 999,999,999].
- month!: [Month](time_package_enums.md#enum-month) - Month, of type [Month](time_package_enums.md#enum-month).
- dayOfMonth!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Day, range [1, 31]. Maximum value must match the month (could be 28, 29, 30, or 31).
- hour!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Hour, range [0, 23].
- minute!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Minute, range [0, 59].
- second!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Second, range [0, 59].
- nanosecond!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Nanosecond, range [0, 999,999,999].

Return Value:

- [DateTime](time_package_structs.md#struct-datetime) - A UTC timezone [DateTime](time_package_structs.md#struct-datetime) instance constructed from the specified parameters.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when parameter values exceed specified ranges.

### static func parse(String)

```cangjie
public static func parse(str: String): DateTime
```

Function: Parses time from the input string `str` and returns a [DateTime](time_package_structs.md#struct-datetime) instance upon successful parsing.

Parameters:

- str: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Time string in `RFC3339` `date-time` format, which may include fractional seconds (e.g., "2023-04-10T08:00:00[.123456]+08:00" where content in `[]` is optional).

Return Value:

- [DateTime](time_package_structs.md#struct-datetime) - A [DateTime](time_package_structs.md#struct-datetime) instance parsed from the input string `str`.

Exceptions:

- [TimeParseException](time_package_exceptions.md#class-timeparseexception) - Thrown when parsing fails.

### static func parse(String, String)

```cangjie
public static func parse(str: String, format: String): DateTime
```

Function: Parses time from the input string `str` according to the specified time format `format` and returns a [DateTime](time_package_structs.md#struct-datetime) instance upon successful parsing.

Parameters:

- str: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Time string (e.g., "2023/04/10 08:00:00 +08:00").
- format: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Time string format (e.g., "yyyy/MM/dd HH:mm:ss OOOO"). For format specifications, see [Time String Format](../time_package_overview.md#time-string-format).

Return Value:

- [DateTime](time_package_structs.md#struct-datetime) - A [DateTime](time_package_structs.md#struct-datetime) instance parsed from the input string `str` according to the specified format `format`.

Exceptions:

- [TimeParseException](time_package_exceptions.md#class-timeparseexception) - Thrown when parsing fails or when multiple values exist for the same `format`.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the `format` is invalid.

### static func parse(String, DateTimeFormat) <sup>(deprecated)</sup>

```cangjie
public static func parse(str: String, format: DateTimeFormat): DateTime
```

Function: Parses time from the input string `str` according to the specified time format `format` and returns a [DateTime](time_package_structs.md#struct-datetime) instance upon successful parsing.

> **Note:**
>
> This method will be deprecated in future versions. Use [parse(String, String)](#static-func-parsestring-string) instead.

Parameters:

- str: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Time string (e.g., "2023/04/10 08:00:00 +08:00").
- format: [DateTimeFormat](./time_package_classes.md#class-datetimeformat) - Time format (e.g., the format corresponding to "yyyy/MM/dd HH:mm:ss OOOO"). For format specifications, see [Time String Format](../time_package_overview.md#time-string-format).

Return Value:

- [DateTime](time_package_structs.md#struct-datetime) - A [DateTime](time_package_structs.md#struct-datetime) instance parsed from the input string `str` according to the specified format `format`.

Exceptions:

- [TimeParseException](time_package_exceptions.md#class-timeparseexception) - Thrown when parsing fails or when multiple values exist for the same `format`.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the `format` is invalid.

### static func tryParse(String)

```cangjie
public static func tryParse(str: String): Option<DateTime>
```

Function: Parses time from the input string `str` and returns an [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[DateTime](time_package_structs.md#struct-datetime)> instance upon successful parsing.

Parameters:

- str: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Time string in `RFC3339` `date-time` format, which may include fractional seconds (e.g., "2023-04-10T08:00:00[.123456]+08:00" where content in `[]` is optional).

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[DateTime](time_package_structs.md#struct-datetime)> - An [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[DateTime](time_package_structs.md#struct-datetime)> instance parsed from the input string `str`. Returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<DateTime>.None if parsing fails.

### func addDays(Int64)

```cangjie
public func addDays(n: Int64): DateTime
```

Function: Returns a new [DateTime](time_package_structs.md#struct-datetime) instance representing the time `n` days after the current [DateTime](time_package_structs.md#struct-datetime) instance.

Parameters:

- n: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Number of days after the current [DateTime](time_package_structs.md#struct-datetime) instance.

Return Value:

- [DateTime](time_package_structs.md#struct-datetime) - Time `n` days after the current [DateTime](time_package_structs.md#struct-datetime) instance.

Exceptions:

- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - Thrown when the resulting date-time exceeds the representable range.

### func addHours(Int64)

```cangjie
public func addHours(n: Int64): DateTime
```

Function: Returns a new [DateTime](time_package_structs.md#struct-datetime) instance representing the time `n` hours after the current [DateTime](time_package_structs.md#struct-datetime) instance.

Parameters:

- n: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Number of hours after the current [DateTime](time_package_structs.md#struct-datetime) instance.

Return Value:

- [DateTime](time_package_structs.md#struct-datetime) - Time `n` hours after the current [DateTime](time_package_structs.md#struct-datetime) instance.

Exceptions:

- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - Thrown when the resulting date-time exceeds the representable range.

### func addMinutes(Int64)

```cangjie
public func addMinutes(n: Int64): DateTime
```

Function: Returns a new [DateTime](time_package_structs.md#struct-datetime) instance representing the time `n` minutes after the current [DateTime](time_package_structs.md#struct-datetime) instance.

Parameters:

- n: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Number of minutes after the current [DateTime](time_package_structs.md#struct-datetime) instance.

Return Value:

- [DateTime](time_package_structs.md#struct-datetime) - Time `n` minutes after the current [DateTime](time_package_structs.md#struct-datetime) instance.

Exceptions:

- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - Thrown when the resulting date-time exceeds the representable range.

### func addMonths(Int64)

```cangjie
public func addMonths(n: Int64): DateTime
```

Function: Returns a new [DateTime](time_package_structs.md#struct-datetime) instance representing the time `n` months after the current [DateTime](time_package_structs.md#struct-datetime) instance.

> **Note:**
>
> Since month intervals are not fixed, if `dt` represents "March 31, 2020", `dt.addMonths(1)` will not return the invalid date "April 31, 2020". To ensure a valid date, it will adjust to the last day of the month, returning "April 30, 2020".

Parameters:

- n: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Number of months after the current [DateTime](time_package_structs.md#struct-datetime) instance.

Return Value:

- [DateTime](time_package_structs.md#struct-datetime) - Time `n` months after the current [DateTime](time_package_structs.md#struct-datetime) instance.

Exceptions:

- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - Thrown when the resulting date-time exceeds the representable range.

### func addNanoseconds(Int64)

```cangjie
public func addNanoseconds(n: Int64): DateTime
```

Function: Returns a new [DateTime](time_package_structs.md#struct-datetime) instance representing the time `n` nanoseconds after the current [DateTime](time_package_structs.md#struct-datetime) instance.

Parameters:

- n: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Number of nanoseconds after the current [DateTime](time_package_structs.md#struct-datetime) instance.

Return Value:

- [DateTime](time_package_structs.md#struct-datetime) - Time `n` nanoseconds after the current [DateTime](time_package_structs.md#struct-datetime) instance.

Exceptions:

- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - Thrown when the resulting date-time exceeds the representable range.

### func addSeconds(Int64)

```cangjie
public func addSeconds(n: Int64): DateTime
```

Function: Obtains a new [DateTime](time_package_structs.md#struct-datetime) instance representing the time `n` seconds after the current [DateTime](time_package_structs.md#struct-datetime) instance.

Parameters:

- n: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The number of seconds after the [DateTime](time_package_structs.md#struct-datetime) instance.

Return Value:

- [DateTime](time_package_structs.md#struct-datetime) - A new [DateTime](time_package_structs.md#struct-datetime) instance representing the time `n` seconds later.

Exceptions:

- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - Thrown when the resulting date-time exceeds the representable range.

### func addWeeks(Int64)

```cangjie
public func addWeeks(n: Int64): DateTime
```

Function: Obtains a new [DateTime](time_package_structs.md#struct-datetime) instance representing the time `n` weeks after the current [DateTime](time_package_structs.md#struct-datetime) instance.

Parameters:

- n: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The number of weeks after the [DateTime](time_package_structs.md#struct-datetime) instance.

Return Value:

- [DateTime](time_package_structs.md#struct-datetime) - A new [DateTime](time_package_structs.md#struct-datetime) instance representing the time `n` weeks later.

Exceptions:

Function: Obtains a new [DateTime](time_package_structs.md#struct-datetime) instance representing the time `n` weeks after the input parameter.

### func addYears(Int64)

```cangjie
public func addYears(n: Int64): DateTime
```

Function: Obtains a new [DateTime](time_package_structs.md#struct-datetime) instance representing the time `n` years after the current [DateTime](time_package_structs.md#struct-datetime) instance.

> **Note:**
>
> Due to variable year intervals, if `dt` represents "February 29, 2020", `dt.addYears(1)` will not return the invalid date "February 29, 2021". To ensure a valid date, it will adjust to the last day of the month, returning "February 28, 2021".

Parameters:

- n: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The number of years after the [DateTime](time_package_structs.md#struct-datetime) instance.

Return Value:

- [DateTime](time_package_structs.md#struct-datetime) - A new [DateTime](time_package_structs.md#struct-datetime) instance representing the time `n` years later.

Exceptions:

- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - Thrown when the resulting date-time exceeds the representable range.

### func compare(DateTime)

```cangjie
public func compare(rhs: DateTime): Ordering
```

Function: Compares the current [DateTime](time_package_structs.md#struct-datetime) instance with parameter `rhs`. Returns [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).GT if greater, [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).EQ if equal, and [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).LT if less.

Parameters:

- rhs: [DateTime](time_package_structs.md#struct-datetime) - The [DateTime](time_package_structs.md#struct-datetime) instance to compare with.

Return Value:

- [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering) - The comparison result between the current [DateTime](time_package_structs.md#struct-datetime) instance and `rhs`.

### func hashCode()

```cangjie
public func hashCode(): Int64
```

Function: Retrieves the hash value of the [DateTime](time_package_structs.md#struct-datetime) instance.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The hash value.

### func inLocal()

```cangjie
public func inLocal(): DateTime
```

Function: Retrieves the [DateTime](time_package_structs.md#struct-datetime) instance in the local timezone.

Return Value:

- [DateTime](time_package_structs.md#struct-datetime) - The [DateTime](time_package_structs.md#struct-datetime) instance in the local timezone.

Exceptions:

- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - Thrown when the resulting date-time exceeds the representable range.

### func inTimeZone(TimeZone)

```cangjie
public func inTimeZone(timeZone: TimeZone): DateTime
```

Function: Retrieves the [DateTime](time_package_structs.md#struct-datetime) instance in the timezone specified by parameter `timeZone`.

Parameters:

- timeZone: [TimeZone](time_package_classes.md#class-timezone) - The target timezone.

Return Value:

- [DateTime](time_package_structs.md#struct-datetime) - The [DateTime](time_package_structs.md#struct-datetime) instance in the specified timezone.

Exceptions:

- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - Thrown when the resulting date-time exceeds the representable range.

### func inUTC()

```cangjie
public func inUTC(): DateTime
```

Function: Retrieves the [DateTime](time_package_structs.md#struct-datetime) instance in UTC timezone.

Return Value:

- [DateTime](time_package_structs.md#struct-datetime) - The [DateTime](time_package_structs.md#struct-datetime) instance in UTC timezone.

Exceptions:

- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - Thrown when the resulting date-time exceeds the representable range.

### func toString()

```cangjie
public func toString(): String
```

Function: Returns a string representation of the [DateTime](time_package_structs.md#struct-datetime) instance in `RFC3339` `date-time` format. If the time includes nanosecond information (non-zero), the fractional seconds will be displayed.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string representation of the [DateTime](time_package_structs.md#struct-datetime) instance.

### func format(String)

```cangjie
public func format(fmt: String): String
```

Function: Returns a string representation of the [DateTime](time_package_structs.md#struct-datetime) instance formatted according to parameter `fmt`. For format specifications, refer to [Time String Format](../time_package_overview.md#time-string-format).

Parameters:

- fmt: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The format string (e.g., "yyyy/MM/dd HH:mm:ss OOOO").

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The formatted string of the [DateTime](time_package_structs.md#struct-datetime) instance. If parsing fails, returns `fmt` as-is.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when `fmt` does not conform to the [Time String Format](../time_package_overview.md#time-string-format).

### func toString(DateTimeFormat) <sup>(deprecated)</sup>

```cangjie
public func toString(format: DateTimeFormat): String
```

Function: Returns a string representation of the [DateTime](time_package_structs.md#struct-datetime) instance formatted according to parameter `format`. For format specifications, refer to [Time String Format](../time_package_overview.md#time-string-format).

> **Note:**
>
> This method will be deprecated in future versions.

Parameters:

- format: [DateTimeFormat](./time_package_classes.md#class-datetimeformat) - The time format (e.g., "yyyy/MM/dd HH:mm:ss OOOO").

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The formatted string of the [DateTime](time_package_structs.md#struct-datetime) instance.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when `format` is invalid.

### func toUnixTimeStamp()

```cangjie
public func toUnixTimeStamp(): Duration
```

Function: Retrieves the time interval between the current instance and [UnixEpoch](#static-prop-unixepoch).

Return Value:

- [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - The time interval since [UnixEpoch](#static-prop-unixepoch).

### operator func !=(DateTime)

```cangjie
public operator func !=(r: DateTime): Bool
```

Function: Determines whether the current [DateTime](time_package_structs.md#struct-datetime) instance is not equal to `r`.

Two [DateTime](time_package_structs.md#struct-datetime) instances are unequal if they do not represent the same UTC time.

Parameters:

- r: [DateTime](time_package_structs.md#struct-datetime) - The [DateTime](time_package_structs.md#struct-datetime) instance to compare.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - `true` if the instances are unequal; otherwise, `false`.

### operator func +(Duration)

```cangjie
public operator func +(r: Duration): DateTime
```

Function: Performs addition between a [DateTime](time_package_structs.md#struct-datetime) and a [Duration](../../core/core_package_api/core_package_structs.md#struct-duration), i.e., [DateTime](time_package_structs.md#struct-datetime) + [Duration](../../core/core_package_api/core_package_structs.md#struct-duration).

Parameters:

- r: [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - The right-hand operand.

Return Value:

- [DateTime](time_package_structs.md#struct-datetime) - The sum of the [DateTime](time_package_structs.md#struct-datetime) instance and `r`.

Exceptions:

- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - Thrown when the result exceeds the representable range.

### operator func -(DateTime)

```cangjie
public operator func -(r: DateTime): Duration
```

Function: Performs subtraction between two [DateTime](time_package_structs.md#struct-datetime) instances, i.e., [DateTime](time_package_structs.md#struct-datetime) - [DateTime](time_package_structs.md#struct-datetime).

Parameters:

- r: [DateTime](time_package_structs.md#struct-datetime) - The right-hand operand.

Return Value:

- [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - The difference between the [DateTime](time_package_structs.md#struct-datetime) instances.

### operator func -(Duration)

```cangjie
public operator func -(r: Duration): DateTime
```

Function: Performs subtraction between a [DateTime](time_package_structs.md#struct-datetime) and a [Duration](../../core/core_package_api/core_package_structs.md#struct-duration), i.e., [DateTime](time_package_structs.md#struct-datetime) - [Duration](../../core/core_package_api/core_package_structs.md#struct-duration).

Parameters:

- r: [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - The right-hand operand.

Return Value:

- [DateTime](time_package_structs.md#struct-datetime) - The difference between the [DateTime](time_package_structs.md#struct-datetime) instance and `r`.

Exceptions:

- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - Thrown when the result exceeds the representable range.

### operator func <(DateTime)

```cangjie
public operator func <(r: DateTime): Bool
```

Function: Determines whether the current [DateTime](time_package_structs.md#struct-datetime) instance is earlier than `r` (a [DateTime](time_package_structs.md#struct-datetime) representing an earlier UTC time is considered smaller).

Parameters:

- r: [DateTime](time_package_structs.md#struct-datetime) - The [DateTime](time_package_structs.md#struct-datetime) instance to compare.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - `true` if the current instance is earlier; otherwise, `false`.### operator func <=(DateTime)

```cangjie
public operator func <=(r: DateTime): Bool
```

Function: Determines whether the current [DateTime](time_package_structs.md#struct-datetime) instance is earlier than or equal to `r` (a [DateTime](time_package_structs.md#struct-datetime) pointing to an earlier UTC time is considered smaller).

Parameters:

- r: [DateTime](time_package_structs.md#struct-datetime) - A [DateTime](time_package_structs.md#struct-datetime) instance.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - `true` or `false`. Returns `true` if the current [DateTime](time_package_structs.md#struct-datetime) instance is earlier than or equal to `r`; otherwise, returns `false`.

### operator func ==(DateTime)

```cangjie
public operator func ==(r: DateTime): Bool
```

Function: Determines whether the current [DateTime](time_package_structs.md#struct-datetime) instance is equal to `r`.

If two [DateTime](time_package_structs.md#struct-datetime) instances are equal, they point to the same UTC time.

Parameters:

- r: [DateTime](time_package_structs.md#struct-datetime) - A [DateTime](time_package_structs.md#struct-datetime) instance.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - `true` or `false`. Returns `true` if the current [DateTime](time_package_structs.md#struct-datetime) instance is equal to `r`; otherwise, returns `false`.

### operator func >(DateTime)

```cangjie
public operator func >(r: DateTime): Bool
```

Function: Determines whether the current [DateTime](time_package_structs.md#struct-datetime) instance is later than `r` (a [DateTime](time_package_structs.md#struct-datetime) pointing to a later UTC time is considered larger).

Parameters:

- r: [DateTime](time_package_structs.md#struct-datetime) - A [DateTime](time_package_structs.md#struct-datetime) instance.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - `true` or `false`. Returns `true` if the current [DateTime](time_package_structs.md#struct-datetime) instance is later than `r`; otherwise, returns `false`.

### operator func >=(DateTime)

```cangjie
public operator func >=(r: DateTime): Bool
```

Function: Determines whether the current [DateTime](time_package_structs.md#struct-datetime) instance is later than or equal to `r` (a [DateTime](time_package_structs.md#struct-datetime) pointing to a later UTC time is considered larger).

Parameters:

- r: [DateTime](time_package_structs.md#struct-datetime) - A [DateTime](time_package_structs.md#struct-datetime) instance.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - `true` or `false`. Returns `true` if the current [DateTime](time_package_structs.md#struct-datetime) instance is later than or equal to `r`; otherwise, returns `false`.

## struct MonoTime

```cangjie
public struct MonoTime <: Hashable & Comparable<MonoTime>
```

Function: [MonoTime](time_package_structs.md#struct-monotime) represents monotonic time, a time type used to measure elapsed time, similar to a continuously running stopwatch. It provides functionalities such as obtaining the current time, calculation, and comparison.

- The representable range of [MonoTime](time_package_structs.md#struct-monotime) is [Duration.Zero](../../core/core_package_api/core_package_structs.md#static-const-zero) to [Duration.Max](../../core/core_package_api/core_package_structs.md#static-const-max), with values represented in [0, 2<sup>63</sup>) (in seconds) and nanosecond precision. A [MonoTime](time_package_structs.md#struct-monotime) created via the [now](#static-func-now) method is always later than any previously created [MonoTime](time_package_structs.md#struct-monotime) using the same method. It is commonly used for performance testing and time-priority task queues.
- The following system call functions are used by the [now](#static-func-now) function in [MonoTime](time_package_structs.md#struct-monotime) to obtain the current time:

  | System    | System Call Function   | Clock Type |
  | --------- | ---------------------- | ---------- |
  | Linux     | clock_gettime          | CLOCK_MONOTONIC |
  | Windows   | clock_gettime          | CLOCK_MONOTONIC |
  | macOS     | clock_gettime          | CLOCK_MONOTONIC |

Parent Types:

- [Hashable](../../core/core_package_api/core_package_interfaces.md#interface-hashable)
- [Comparable](../../core/core_package_api/core_package_interfaces.md#interface-comparablet)\<[MonoTime](#struct-monotime)>

### static func now()

```cangjie
public static func now(): MonoTime
```

Function: Obtains the [MonoTime](time_package_structs.md#struct-monotime) corresponding to the current time.

Return Value:

- [MonoTime](time_package_structs.md#struct-monotime) - The [MonoTime](time_package_structs.md#struct-monotime) corresponding to the current time.

### func compare(MonoTime)

```cangjie
public func compare(rhs: MonoTime): Ordering
```

Function: Determines the size relationship between a [MonoTime](time_package_structs.md#struct-monotime) instance and the parameter `rhs`. Returns [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).GT if greater, [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).EQ if equal, and [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).LT if smaller.

Parameters:

- rhs: [MonoTime](time_package_structs.md#struct-monotime) - The [MonoTime](time_package_structs.md#struct-monotime) instance to compare.

Return Value:

- [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering) - The size relationship between the current [MonoTime](time_package_structs.md#struct-monotime) instance and `rhs`.

### func hashCode()

```cangjie
public func hashCode(): Int64
```

Function: Obtains the hash value of the current [MonoTime](time_package_structs.md#struct-monotime) instance.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The hash value.

### operator func !=(MonoTime)

```cangjie
public operator func !=(r: MonoTime): Bool
```

Function: Determines whether the current [MonoTime](time_package_structs.md#struct-monotime) instance is not equal to `r`.

Parameters:

- r: [MonoTime](time_package_structs.md#struct-monotime) - A monotonic time instance.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - `true` or `false`. Returns `true` if the current [MonoTime](time_package_structs.md#struct-monotime) instance is not equal to `r`; otherwise, returns `false`.

### operator func +(Duration)

```cangjie
public operator func +(r: Duration): MonoTime
```

Function: Implements addition between [MonoTime](time_package_structs.md#struct-monotime) and [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) types, i.e., [MonoTime](time_package_structs.md#struct-monotime) + [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) operation.

Parameters:

- r: [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - A time interval.

Return Value:

- [MonoTime](time_package_structs.md#struct-monotime) - The monotonic time after the time interval represented by parameter `r`.

Exceptions:

- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - Thrown when the result exceeds the representable range of monotonic time.

### operator func -(Duration)

```cangjie
public operator func -(r: Duration): MonoTime
```

Function: Implements subtraction between [MonoTime](time_package_structs.md#struct-monotime) and [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) types, i.e., [MonoTime](time_package_structs.md#struct-monotime) - [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) operation.

Parameters:

- r: [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - A time interval.

Return Value:

- [MonoTime](time_package_structs.md#struct-monotime) - The monotonic time before the time interval represented by parameter `r`.

Exceptions:

- [ArithmeticException](../../core/core_package_api/core_package_exceptions.md#class-arithmeticexception) - Thrown when the result exceeds the representable range of monotonic time.

### operator func -(MonoTime)

```cangjie
public operator func -(r: MonoTime): Duration
```

Function: Implements subtraction between [MonoTime](time_package_structs.md#struct-monotime) types, i.e., [MonoTime](time_package_structs.md#struct-monotime) - [MonoTime](time_package_structs.md#struct-monotime) operation.

Parameters:

- r: [MonoTime](time_package_structs.md#struct-monotime) - A monotonic time instance.

Return Value:

- [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - The time interval elapsed from `r` to the current instance.

### operator func <(MonoTime)

```cangjie
public operator func <(r: MonoTime): Bool
```

Function: Determines whether the current [MonoTime](time_package_structs.md#struct-monotime) instance is earlier than `r`.

Parameters:

- r: [MonoTime](time_package_structs.md#struct-monotime) - A monotonic time instance.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - `true` or `false`. Returns `true` if the current [MonoTime](time_package_structs.md#struct-monotime) instance is earlier than `r`; otherwise, returns `false`.

### operator func <=(MonoTime)

```cangjie
public operator func <=(r: MonoTime): Bool
```

Function: Determines whether the current [MonoTime](time_package_structs.md#struct-monotime) instance is earlier than or equal to `r`.

Parameters:

- r: [MonoTime](time_package_structs.md#struct-monotime) - A monotonic time instance.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - `true` or `false`. Returns `true` if the current [MonoTime](time_package_structs.md#struct-monotime) instance is earlier than or equal to `r`; otherwise, returns `false`.

### operator func ==(MonoTime)

```cangjie
public operator func ==(r: MonoTime): Bool
```

Function: Determines whether the current [MonoTime](time_package_structs.md#struct-monotime) instance is equal to `r`.

Parameters:

- r: [MonoTime](time_package_structs.md#struct-monotime) - A monotonic time instance.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - `true` or `false`. Returns `true` if the current [MonoTime](time_package_structs.md#struct-monotime) instance is equal to `r`; otherwise, returns `false`.

### operator func >(MonoTime)

```cangjie
public operator func >(r: MonoTime): Bool
```

Function: Determines whether the current [MonoTime](time_package_structs.md#struct-monotime) instance is later than `r`.

Parameters:

- r: [MonoTime](time_package_structs.md#struct-monotime) - A monotonic time instance.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - `true` or `false`. Returns `true` if the current [MonoTime](time_package_structs.md#struct-monotime) instance is later than `r`; otherwise, returns `false`.

### operator func >=(MonoTime)

```cangjie
public operator func >=(r: MonoTime): Bool
```

Function: Determines whether the current [MonoTime](time_package_structs.md#struct-monotime) instance is later than or equal to `r`.

Parameters:

- r: [MonoTime](time_package_structs.md#struct-monotime) - A monotonic time instance.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - `true` or `false`. Returns `true` if the current [MonoTime](time_package_structs.md#struct-monotime) instance is later than or equal to `r`; otherwise, returns `false`.