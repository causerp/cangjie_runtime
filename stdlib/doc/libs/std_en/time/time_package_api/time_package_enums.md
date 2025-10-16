# Enumerations

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

Functionality: [DayOfWeek](time_package_enums.md#enum-dayofweek) represents a day of the week, providing capabilities for conversion to/from [Int64](../../core/core_package_api/core_package_intrinsics.md#int64), equality comparison, and string representation.

Parent types:

- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)
- [Equatable](../../../std_en/core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[DayOfWeek](time_package_enums.md#enum-dayofweek)>

### Friday

```cangjie
Friday
```

Functionality: Constructs a [DayOfWeek](time_package_enums.md#enum-dayofweek) instance representing Friday.

### Monday

```cangjie
Monday
```

Functionality: Constructs a [DayOfWeek](time_package_enums.md#enum-dayofweek) instance representing Monday.

### Saturday

```cangjie
Saturday
```

Functionality: Constructs a [DayOfWeek](time_package_enums.md#enum-dayofweek) instance representing Saturday.

### Sunday

```cangjie
Sunday
```

Functionality: Constructs a [DayOfWeek](time_package_enums.md#enum-dayofweek) instance representing Sunday.

### Thursday

```cangjie
Thursday
```

Functionality: Constructs a [DayOfWeek](time_package_enums.md#enum-dayofweek) instance representing Thursday.

### Tuesday

```cangjie
Tuesday
```

Functionality: Constructs a [DayOfWeek](time_package_enums.md#enum-dayofweek) instance representing Tuesday.

### Wednesday

```cangjie
Wednesday
```

Functionality: Constructs a [DayOfWeek](time_package_enums.md#enum-dayofweek) instance representing Wednesday.

### static func of(Int64)

```cangjie
public static func of(dayOfWeek: Int64): DayOfWeek
```

Functionality: Returns the [DayOfWeek](time_package_enums.md#enum-dayofweek) instance corresponding to the parameter `dayOfWeek`.

Parameters:

- dayOfWeek: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Integer representation of the day, valid range [0, 6]. 0 represents Sunday, 1-6 represent Monday through Saturday.

Return value:

- [DayOfWeek](time_package_enums.md#enum-dayofweek) - The [DayOfWeek](time_package_enums.md#enum-dayofweek) instance corresponding to `dayOfWeek`.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when `dayOfWeek` is outside the [0, 6] range.

### func toString()

```cangjie
public func toString(): String
```

Functionality: Returns the string representation of the current [DayOfWeek](time_package_enums.md#enum-dayofweek) instance, e.g. "Monday" for Monday.

Return value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - String representation of the current [DayOfWeek](time_package_enums.md#enum-dayofweek) instance.

### func toInteger()

```cangjie
public func toInteger(): Int64
```

Functionality: Returns the integer representation of the current [DayOfWeek](time_package_enums.md#enum-dayofweek) instance, where Sunday is 0 and Monday through Saturday are 1 through 6.

Return value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Integer representation of the current [DayOfWeek](time_package_enums.md#enum-dayofweek) instance.

### func value() <sup>(deprecated)</sup>

```cangjie
public func value(): Int64
```

Functionality: Returns the integer representation of the current [DayOfWeek](time_package_enums.md#enum-dayofweek) instance, where Sunday is 0 and Monday through Saturday are 1 through 6.

> **Note:**
>
> This will be deprecated in future versions. Use [toInteger()](#func-tointeger) instead.

Return value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Integer representation of the current [DayOfWeek](time_package_enums.md#enum-dayofweek) instance.

### operator func !=(DayOfWeek)

```cangjie
public operator func !=(r: DayOfWeek): Bool
```

Functionality: Determines whether the current [DayOfWeek](time_package_enums.md#enum-dayofweek) and `r` represent different days of the week.

Parameters:

- r: [DayOfWeek](time_package_enums.md#enum-dayofweek) - A [DayOfWeek](time_package_enums.md#enum-dayofweek) instance.

Return value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - `true` or `false`. Returns `true` if the current instance is not equal to `r`; otherwise, returns `false`.

### operator func ==(DayOfWeek)

```cangjie
public operator func ==(r: DayOfWeek): Bool
```

Functionality: Determines whether the current [DayOfWeek](time_package_enums.md#enum-dayofweek) and `r` represent the same day of the week.

Parameters:

- r: [DayOfWeek](time_package_enums.md#enum-dayofweek) - A [DayOfWeek](time_package_enums.md#enum-dayofweek) instance.

Return value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - `true` or `false`. Returns `true` if the current instance equals `r`; otherwise, returns `false`.

### operator func +(Int64)

```cangjie
public operator func +(n: Int64): DayOfWeek
```

Functionality: Calculates the day of the week `n` days after the current instance (when `n` is positive). If `n` is negative, calculates the day before.

Parameters:

- n: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Number of days to add.

Return value:

- [DayOfWeek](time_package_enums.md#enum-dayofweek) - The day of the week `n` days later.

### operator func -(Int64)

```cangjie
public operator func -(n: Int64): DayOfWeek
```

Functionality: Calculates the day of the week `n` days before the current instance (when `n` is positive). If `n` is negative, calculates the day after.

Parameters:

- n: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Number of days to subtract.

Return value:

- [DayOfWeek](time_package_enums.md#enum-dayofweek) - The day of the week `n` days earlier.

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

Functionality: [Month](time_package_enums.md#enum-month) represents a month of the year, providing capabilities for conversion to/from [Int64](../../core/core_package_api/core_package_intrinsics.md#int64), calculations, equality comparison, and string representation.

Parent types:

- [ToString](../../../std_en/core/core_package_api/core_package_interfaces.md#interface-tostring)
- [Equatable](../../../std_en/core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[Month](time_package_enums.md#enum-month)>

### April

```cangjie
April
```

Functionality: Constructs a [Month](time_package_enums.md#enum-month) instance representing April.

### August

```cangjie
August
```

Functionality: Constructs a [Month](time_package_enums.md#enum-month) instance representing August.

### December

```cangjie
December
```

Functionality: Constructs a [Month](time_package_enums.md#enum-month) instance representing December.

### February

```cangjie
February
```

Functionality: Constructs a [Month](time_package_enums.md#enum-month) instance representing February.

### January

```cangjie
January
```

Functionality: Constructs a [Month](time_package_enums.md#enum-month) instance representing January.

### July

```cangjie
July
```

Functionality: Constructs a [Month](time_package_enums.md#enum-month) instance representing July.

### June

```cangjie
June
```

Functionality: Constructs a [Month](time_package_enums.md#enum-month) instance representing June.

### March

```cangjie
March
```

Functionality: Constructs a [Month](time_package_enums.md#enum-month) instance representing March.

### May

```cangjie
May
```

Functionality: Constructs a [Month](time_package_enums.md#enum-month) instance representing May.### November

```cangjie
November
```

Function: Constructs a [Month](time_package_enums.md#enum-month) instance representing November.

### October

```cangjie
October
```

Function: Constructs a [Month](time_package_enums.md#enum-month) instance representing October.

### September

```cangjie
September
```

Function: Constructs a [Month](time_package_enums.md#enum-month) instance representing September.

### static func of(Int64)

```cangjie
public static func of(mon: Int64): Month
```

Function: Obtains the [Month](time_package_enums.md#enum-month) instance corresponding to the parameter `mon`.

Parameters:

- mon: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The month in integer form, with a valid range of [1, 12], representing the twelve months of the year.

Return Value:

- [Month](time_package_enums.md#enum-month) - The [Month](time_package_enums.md#enum-month) instance corresponding to the parameter `mon`.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the parameter `mon` is outside the range [1, 12].

### func toString()

```cangjie
public func toString(): String
```

Function: Returns the string representation of the current [Month](time_package_enums.md#enum-month) instance, e.g., "January" represents the first month.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string representation of the current [Month](time_package_enums.md#enum-month) instance.

### func toInteger()

```cangjie
public func toInteger(): Int64
```

Function: Obtains the integer representation of the current [Month](time_package_enums.md#enum-month) instance, where January to December are represented as 1 to 12, respectively.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The integer representation of the current [Month](time_package_enums.md#enum-month) instance.

### func value() <sup>(deprecated)</sup>

```cangjie
public func value(): Int64
```

Function: Obtains the integer representation of the current [Month](time_package_enums.md#enum-month) instance, where January to December are represented as 1 to 12, respectively.

> **Note:**
>
> This method will be deprecated in future versions. Use [toInteger()](#func-tointeger-1) instead.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The integer representation of the current [Month](time_package_enums.md#enum-month) instance.

### operator func !=(Month)

```cangjie
public operator func !=(r: Month): Bool
```

Function: Determines whether the current [Month](time_package_enums.md#enum-month) instance and `r` represent different months.

Parameters:

- r: [Month](time_package_enums.md#enum-month) - A [Month](time_package_enums.md#enum-month) instance.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether the current [Month](time_package_enums.md#enum-month) instance is not equal to `r`.

### operator func +(Int64)

```cangjie
public operator func +(n: Int64): Month
```

Function: Calculates the calendar month `n` months after the current calendar month (when `n` is positive). If `n` is negative, it represents months before the current month.

Parameters:

- n: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The number of months to add.

Return Value:

- [Month](time_package_enums.md#enum-month) - The month after `n` months.

### operator func -(Int64)

```cangjie
public operator func -(n: Int64): Month
```

Function: Calculates the calendar month `n` months before the current calendar month (when `n` is positive). If `n` is negative, it represents months after the current month.

Parameters:

- n: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The number of months to subtract.

Return Value:

- [Month](time_package_enums.md#enum-month) - The month before `n` months.

### operator func ==(Month)

```cangjie
public operator func ==(r: Month): Bool
```

Function: Determines whether the current [Month](time_package_enums.md#enum-month) instance and `r` represent the same month.

Parameters:

- r: [Month](time_package_enums.md#enum-month) - A [Month](time_package_enums.md#enum-month) instance.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - `true` or `false`. Returns `true` if the current [Month](time_package_enums.md#enum-month) instance equals `r`; otherwise, returns `false`.