# Exception

## class ArgumentParseException

```cangjie
public class ArgumentParseException <: Exception {
    public init()
    public init(message: String)
}
```

Function: Argument parsing exception class. This exception is thrown when argument parsing fails (e.g., unrecognized option, missing value for an option).

Parent Type:

- [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception)

### init()

```cangjie
public init()
```

Function: Constructs an instance without exception message.

### init(String)

```cangjie
public init(message: String)
```

Function: Constructs an exception instance with the specified message.

Parameters:

- message: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The exception message.