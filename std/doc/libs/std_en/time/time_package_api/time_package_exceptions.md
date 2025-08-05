# Exception Classes

## class InvalidDataException

```cangjie
public class InvalidDataException <: Exception {
    public init()
    public init(message: String)
}
```

Function: [InvalidDataException](time_package_exceptions.md#class-invaliddataexception) represents an exception that occurs when loading time zones.

Parent Type:

- [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception)

### init()

```cangjie
public init()
```

Function: Constructs an [InvalidDataException](time_package_exceptions.md#class-invaliddataexception) instance.

### init(String)

```cangjie
public init(message: String)
```

Function: Constructs an [InvalidDataException](time_package_exceptions.md#class-invaliddataexception) instance with the specified error message provided by the `message` parameter.

Parameters:

- message: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The predefined message.

## class TimeParseException

```cangjie
public class TimeParseException <: Exception {
    public init()
    public init(message: String)
}
```

Function: [TimeParseException](time_package_exceptions.md#class-timeparseexception) represents an exception that occurs when parsing time strings.

Parent Type:

- [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception)

### init()

```cangjie
public init()
```

Function: Constructs a [TimeParseException](time_package_exceptions.md#class-timeparseexception) instance.

### init(String)

```cangjie
public init(message: String)
```

Function: Constructs a [TimeParseException](time_package_exceptions.md#class-timeparseexception) instance with the specified error message provided by the `message` parameter.

Parameters:

- message: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The predefined message.