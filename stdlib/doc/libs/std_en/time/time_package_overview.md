# std.time

## Functionality Overview

The `time` package provides time-related types including datetime, time intervals, monotonic time, time zones, and offers functionalities for calculation and comparison.

### Time String Format

String parsing of time has the following requirements:

- The string must contain information describing specific year, month, and day: such as Gregorian year (y) + month (M) and day (d), or Gregorian year (y) and day of the year (D).

- If hour, minute, or second information is not included, they default to 0; if time zone information is not included, it defaults to the current time zone TimeZone.Local.

- The same letter format cannot be assigned values twice, e.g., assigning values to the Gregorian year (y) format twice is not allowed; the time zone formats O and Z also cannot appear together.

- Other letter formats will serve as auxiliary information for validation. For example, when parsing "2023-04-24-Mon" using the format "yyyy-MM-dd-www", the correctness of "Mon" will be verified.

### Letter Meanings

| Letter | Meaning           |
| ------ | ----------------- |
| a      | AM/PM             |
| y      | Gregorian year    |
| Y      | Week-based year   |
| M      | Month             |
| d      | Day               |
| D      | Day of the year   |
| w      | Day of the week   |
| W      | ISO-8601 week     |
| h      | 12-hour clock     |
| H      | 24-hour clock     |
| m      | Minute            |
| s      | Second            |
| S      | Fraction of a second |
| z      | Time zone name and ID |
| Z      | Offset from UTC   |
| O      | Time zone offset  |
| G      | Era               |

The rules corresponding to each letter are as follows.

### Rules

#### AM/PM

Valid count is 1, representing AM or PM, fixed as "AM" or "PM".

#### Year

| Letter Count | Parsing                           | Output           |
| ------------ | --------------------------------- | ---------------- |
| 1, 3, 4      | Parses 4-digit years, e.g., 2023, 0001, etc. | Outputs at least 4-digit years, e.g., 2023, 0001, 99999, etc., padding with 0 if fewer than 4 digits. |
| 2            | Parses 2-digit years, e.g., 23, 69, etc., where xx >= 69 is parsed as 19xx, otherwise as 20xx; negative years follow the same rule. | Outputs 2-digit or more years, e.g., 23, 69, etc., where [1969, 1999] outputs as [69, 99], [2000, 2068] outputs as [00, 68]; negative years follow the same rule. Other cases output at least 4 digits, padding with 0 if fewer than 4 digits. |
| 5 ~ 9        | Parses years with the corresponding number of digits. | Outputs years with the corresponding number of digits, padding with 0 if necessary. |

#### Month

| Letter Count | Parsing                           | Output           |
| ------------ | --------------------------------- | ---------------- |
| 1            | Parses 1 ~ 2-digit numbers, e.g., 1, 01, 11, etc. | Outputs 1 ~ 2-digit numbers, e.g., 1, 11, etc. |
| 2            | Parses 2-digit numbers, e.g., 01, 11, etc. | Outputs 2-digit numbers, e.g., 01, 11, etc. |
| 3            | Parses abbreviated months, e.g., Jan, Dec, etc. | Outputs abbreviated months, e.g., Jan, Dec, etc. |
| 4            | Parses full month names, e.g., January, December, etc. | Outputs full month names, e.g., January, December, etc. |

#### Numeric Values

The representation range of different number types varies based on actual value size.

| Letter Count | Parsing                           | Output           |
| ------------ | --------------------------------- | ---------------- |
| 1            | Parses 1 ~ 2-digit numbers, e.g., 1, 01, 11, etc. | Outputs 1 ~ 2-digit numbers, e.g., 1, 11, etc. |
| 2            | Parses 2-digit numbers, e.g., 01, 11, etc. | Outputs 2-digit numbers, e.g., 01, 11, etc. |

#### Fractional Seconds

| Letter Count | Parsing                           | Output           |
| ------------ | --------------------------------- | ---------------- |
| 1            | Parses 3-digit numbers, e.g., 001, 123, etc., as milliseconds. | Outputs 3-digit numbers, e.g., 001, 123, etc., as milliseconds. |
| 2            | Parses 6-digit numbers, e.g., 000001, 123456, etc., as microseconds. | Outputs 6-digit numbers, e.g., 000001, 123456, etc., as microseconds. |
| 3            | Parses 9-digit numbers, e.g., 000000001, 123456789, etc., as nanoseconds. | Outputs 9-digit numbers, e.g., 000000001, 123456789, etc., as nanoseconds. |

#### Time Zone Offset

| Letter Count | Parsing                           | Output           |
| ------------ | --------------------------------- | ---------------- |
| 1            | Parses formats like: +08, -08, etc. | Outputs formats like: +08, -08, etc.; if the offset is not a whole hour, it is truncated. |
| 2            | Parses formats like: +08:00, -08:59, etc. | Outputs formats like: +08:00, -08:59, etc.; if the offset is not a whole minute, it is truncated. |
| 3            | Parses formats like: +08:00:00, -08:59:59, etc. | Outputs formats like: +08:00:00, -08:59:59, etc. |
| 4            | Parses formats like: +08:00:00, -08:59:59, etc. | Outputs formats like case2 or case3; if the offset is 0, outputs Z. |

#### Time Zone Name and ID

| Letter Count | Parsing                           | Output           |
| ------------ | --------------------------------- | ---------------- |
| 1, 2, 3      | Parses formats like: CST, GMT, etc. | Outputs formats like: CST, GMT, etc. |
| 4            | Parses time zone IDs, e.g., "Asia/Shanghai", etc. | Outputs time zone IDs, e.g., "Asia/Shanghai", etc. |

#### Offset from UTC

| Letter Count | Parsing                           | Output           |
| ------------ | --------------------------------- | ---------------- |
| 1            | Parses formats like: GMT+0, GMT+10, etc. | Outputs formats like: GMT+0, GMT+10, etc. |
| 2            | Parses formats like: GMT+00:00, GMT+10:00, etc. | Outputs formats like: GMT+00:00, GMT+10:00, etc. |
| 3            | Parses formats like: GMT+00:00:00, GMT+10:00:00, etc. | Outputs formats like: GMT+00:00:00, GMT+10:00:00, etc. |
| 4            | Formats with count 2 or 3. | Formats with count 2 or 3. |

#### Day of the Year

| Letter Count | Parsing                           | Output           |
| ------------ | --------------------------------- | ---------------- |
| 1            | Parses formats like: 1, 01, 001, etc., as 1 ~ 3-digit numbers. | Outputs formats like: 1, 12, 123, etc., as 1 ~ 3-digit numbers. |
| 2            | Parses formats like: 01, 001, etc., as 2 ~ 3-digit numbers. | Outputs formats like: 001, 012, 123, etc., as 2 ~ 3-digit numbers. |

#### Day of the Week

| Letter Count | Parsing                           | Output           |
| ------------ | --------------------------------- | ---------------- |
| 1            | Parses 1-digit numbers, e.g., 0, 6, etc., where 0 represents Sunday, others represent Monday to Saturday. | Outputs 1-digit numbers, e.g., 0, 6, etc., where 0 represents Sunday, others represent Monday to Saturday. |
| 2            | Parses 2-digit numbers, e.g., 00, 06, etc., where 00 represents Sunday, others represent Monday to Saturday. | Parses 2-digit numbers, e.g., 00, 06, etc., where 00 represents Sunday, others represent Monday to Saturday. |
| 3            | Parses abbreviated weekdays, e.g., Sun, Sat, etc. | Parses abbreviated weekdays, e.g., Sun, Sat, etc. |
| 4            | Parses full weekday names, e.g., Sunday, Saturday, etc. | Parses full weekday names, e.g., Sunday, Saturday, etc. |

#### Era

| Letter Count | Parsing              | Output           |
| ------------ | -------------------- | ---------------- |
| 1            | Parses A.            | Outputs A.       |
| 2            | Parses AD.           | Outputs AD.      |
| 3            | Parses Anno Domini.  | Outputs Anno Domini. |

## API List

### Classes

|                 Class Name              |                Functionality                |
| --------------------------------------- | ------------------------------------------ |
| [DateTimeFormat](./time_package_api/time_package_classes.md#class-datetimeformat) | Provides datetime formatting functionality for parsing and generating [DateTime](./time_package_api/time_package_structs.md#struct-datetime). |
| [TimeZone](./time_package_api/time_package_classes.md#class-timezone) | `TimeZone` represents a time zone, recording the time offset from UTC for a region at different times, and provides functionalities like loading time zones from the system and custom time zones. |

### Enums

|                 Enum Name              |                Functionality                |
| --------------------------------------- | ------------------------------------------ |
| [DayOfWeek](./time_package_api/time_package_enums.md#enum-dayofweek) | `DayOfWeek` represents a day of the week, providing functionalities for conversion to/from `Int64`, equality comparison, and obtaining string representations of enum values. |
| [Month](./time_package_api/time_package_enums.md#enum-month) | `Month` represents a month of the year, providing functionalities for conversion to/from `Int64`, calculation, equality comparison, and obtaining string representations of enum values. |

### Structs

|                 Struct Name              |                Functionality                |
| --------------------------------------- | ------------------------------------------ |
| [DateTime](./time_package_api/time_package_structs.md#struct-datetime) | `DateTime` represents a datetime, describing a specific point in time, and provides functionalities for reading, calculating, comparing, converting, serializing, and deserializing datetime based on time zones. |
| [MonoTime](./time_package_api/time_package_structs.md#struct-monotime) | `MonoTime` represents monotonic time, a time type used to measure elapsed time, similar to a running stopwatch, and provides functionalities for obtaining current time, calculation, and comparison. |

### Exception Classes

|                 Exception Class Name              |                Functionality                |
| ------------------------------------------------ | ------------------------------------------ |
| [InvalidDataException](./time_package_api/time_package_exceptions.md#class-invaliddataexception) | `InvalidDataException` represents exceptions when loading time zones. |
| [TimeParseException](./time_package_api/time_package_exceptions.md#class-timeparseexception) | `TimeParseException` represents exceptions when parsing time strings. |