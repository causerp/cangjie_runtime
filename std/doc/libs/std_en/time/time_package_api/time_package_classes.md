# Class

## class DateTimeFormat

```cangjie
public class DateTimeFormat {
    public static const RFC1123: String = "www, dd MMM yyyy HH:mm:ss z"
    public static const RFC3339: String = "yyyy-MM-ddTHH:mm:ssOOOO"
    public static const RFC822: String = "ww dd MMM yy HH:mm:ss z"
    public static const RFC850: String = "wwww, dd-MMM-yy HH:mm:ss z"
}
```

Function: Provides datetime formatting functionality for parsing and generating [DateTime](../time_package_api/time_package_structs.md#struct-datetime).

### static const RFC1123

```cangjie
public static const RFC1123: String = "www, dd MMM yyyy HH:mm:ss z"
```

Function: Provides RFC1123 datetime format, with datetime string format as `www, dd MMM yyyy HH:mm:ss z`.

Type: [String](../../../std_en/core/core_package_api/core_package_structs.md#struct-string)

### static const RFC3339

```cangjie
public static const RFC3339: String = "yyyy-MM-ddTHH:mm:ssOOOO"
```

Function: Provides RFC3339 datetime format, with datetime string format as `yyyy-MM-ddTHH:mm:ssOOOO`.

Type: [String](../../../std_en/core/core_package_api/core_package_structs.md#struct-string)

### static const RFC822

```cangjie
public static const RFC822: String = "ww dd MMM yy HH:mm:ss z"
```

Function: Provides RFC822 datetime format, with datetime string format as `ww dd MMM yy HH:mm:ss z`.

Type: [String](../../../std_en/core/core_package_api/core_package_structs.md#struct-string)

### static const RFC850

```cangjie
public static const RFC850: String = "wwww, dd-MMM-yy HH:mm:ss z"
```

Function: Provides RFC850 datetime format, with datetime string format as `wwww, ww-MMM-yy HH:mm:ss z`.

Type: [String](../../../std_en/core/core_package_api/core_package_structs.md#struct-string)

### prop format: String <sup>(deprecated)</sup>

```cangjie
public prop format: String
```

Function: The string format of the DateTimeFormat instance.

> **Note:**
>
> Will be deprecated in future versions.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### static func of(String) <sup>(deprecated)</sup>

```cangjie
public static func of(format: String): DateTimeFormat
```

Function: Creates a specific DateTimeFormat type instance based on the input string.

For string format specifications, see [Datetime String Format](../time_package_overview.md#time-string-format)

> **Note:**
>
> Will be deprecated in future versions.

Parameters:

- format: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string format.

Return Value:

- [DateTimeFormat](#class-datetimeformat) - The datetime format.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the input format violates the character count rules specified in [Datetime String Format](../time_package_overview.md#time-string-format).

## class TimeZone

```cangjie
public class TimeZone <: ToString & Equatable<TimeZone> {
    public static let Local: TimeZone
    public static let UTC: TimeZone
    public init(id: String, offset: Duration)
}
```

Function: TimeZone represents time zones, recording the time offset of a region relative to UTC at different times, and provides functionalities such as loading time zones from the system and creating custom time zones.

Parent Types:

- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)
- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[TimeZone](#class-timezone)>

### static let Local

```cangjie
public static let Local: TimeZone
```

Function: Gets the local time zone.

`Local` retrieves the time zone ID from the system environment variable TZ and loads the corresponding time zone from system time zone files. Its behavior is identical to the function [load](#static-func-loadstring).

The value of environment variable TZ follows the standard time zone ID format (consistent across operating systems), e.g., "Asia/Shanghai".

If environment variable TZ is not set or empty, the local time zone loading rules are as follows:

- On Linux/Unix-like systems: Load the symbolic link at "/etc/localtime", with the time zone name matching the relative path pointed to by "/etc/localtime", e.g., "Asia/Shanghai".
- If the above fails or on Windows systems: Returns a time zone with ID "UTC&offset", e.g., "Asia/Shanghai" corresponds to "UTC+08:00".

Type: [TimeZone](time_package_classes.md#class-timezone)

### static let UTC

```cangjie
public static let UTC: TimeZone
```

Function: Gets the UTC time zone.

Type: [TimeZone](time_package_classes.md#class-timezone)

### prop id

```cangjie
public prop id: String
```

Function: Gets the time zone ID associated with the current [TimeZone](time_package_classes.md#class-timezone) instance.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### init(String, Duration)

```cangjie
public init(id: String, offset: Duration)
```

Function: Constructs a custom [TimeZone](time_package_classes.md#class-timezone) instance with the specified time zone ID and offset.

Parameters:

- id: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The time zone ID. Uses "/" as separator, e.g., "Asia/Shanghai", following the same standard across operating systems.
- offset: [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - The offset relative to UTC, with second-level precision. Positive for east, negative for west. Valid range: (-25 * [Duration](../../core/core_package_api/core_package_structs.md#struct-duration).hour, 26 * [Duration](../../core/core_package_api/core_package_structs.md#struct-duration).hour).

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when `id` is an empty string or `offset` is outside the valid range.

### static func load(String)

```cangjie
public static func load(id: String): TimeZone
```

Function: Loads the time zone specified by parameter `id` from the system.

> **Note:**
>
> - On Linux/macOS systems: If environment variable CJ_TZPATH exists, uses the specified path to load time zone files (if multiple paths are separated by ":", searches in order and loads the first found time zone file). Otherwise, loads from the system time zone directory ("/usr/share/zoneinfo" on Linux/macOS).
> - On Windows systems: Users need to download [time zone files](https://www.iana.org/time-zones), compile them, and set environment variable CJ_TZPATH to point to the zoneinfo directory (if multiple paths are separated by ";", searches in order and loads the first found time zone file). Otherwise, an exception will be thrown.

Parameters:

- id: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The time zone ID.

Return Value:

- [TimeZone](time_package_classes.md#class-timezone) - The loaded time zone.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when `id` is empty, exceeds 4096 bytes, or violates the standard time zone ID format.
- [InvalidDataException](time_package_exceptions.md#class-invaliddataexception) - Thrown when time zone file loading fails (file not found, parsing failure, etc.).

### static func loadFromPaths(String, Array\<String>)

```cangjie
public static func loadFromPaths(id: String, tzpaths: Array<String>): TimeZone
```

Function: Loads the time zone specified by parameter `id` from the time zone file directories specified by parameter `tzpaths`.

When loading, the time zone will be loaded from the first successfully read time zone file path. The time zone file format must comply with [Time Zone Information Format](https://datatracker.ietf.org/doc/html/rfc8536).

Parameters:

- id: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The time zone ID.
- tzpaths: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[String](../../core/core_package_api/core_package_structs.md#struct-string)> - Array of time zone file paths.

Return Value:

- [TimeZone](time_package_classes.md#class-timezone) - The loaded time zone.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when `id` is empty, exceeds 4096 bytes, or violates the standard time zone ID format.
- [InvalidDataException](time_package_exceptions.md#class-invaliddataexception) - Thrown when time zone file loading fails (file not found, parsing failure, etc.).

### static func loadFromTZData(String, Array\<UInt8>)

```cangjie
public static func loadFromTZData(id: String, data: Array<UInt8>): TimeZone
```

Function: Constructs a custom [TimeZone](time_package_classes.md#class-timezone) instance with the specified time zone ID and time zone data. `id` can be any valid string, while `data` must comply with IANA time zone file format. Returns a [TimeZone](time_package_classes.md#class-timezone) instance on success, otherwise throws an exception.

Parameters:

- id: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The time zone ID.
- data: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8)> - Data compliant with [Time Zone Information Format](https://datatracker.ietf.org/doc/html/rfc8536).

Return Value:

- [TimeZone](time_package_classes.md#class-timezone) - The loaded time zone.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when `id` is empty.
- [InvalidDataException](time_package_exceptions.md#class-invaliddataexception) - Thrown when `data` parsing fails.

### func toString()

```cangjie
public func toString(): String
```

Function: Gets the string representation of the time zone ID for this [TimeZone](time_package_classes.md#class-timezone) instance.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string representation of the time zone ID.

### operator func !=(TimeZone)

```cangjie
public operator func !=(r: TimeZone): Bool
```

Function: Determines whether the reference of the current [TimeZone](time_package_classes.md#class-timezone) instance is not equal to the reference of `r`.

Parameters:

- r: [TimeZone](time_package_classes.md#class-timezone) - A [TimeZone](time_package_classes.md#class-timezone) instance.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - `true` or `false`. Returns `true` if the references are not equal; otherwise, returns `false`.

### operator func ==(TimeZone)

```cangjie
public operator func ==(r: TimeZone): Bool
```

Function: Determines whether the reference of the current [TimeZone](time_package_classes.md#class-timezone) instance is equal to the reference of `r`.

Parameters:

- r: [TimeZone](time_package_classes.md#class-timezone) - A [TimeZone](time_package_classes.md#class-timezone) instance.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - `true` or `false`. Returns `true` if the references are equal; otherwise, returns `false`.