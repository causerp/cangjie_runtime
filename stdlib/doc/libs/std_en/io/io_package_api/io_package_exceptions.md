# Exceptions

## class ContentFormatException

```cangjie
public class ContentFormatException <: Exception {
    public init()
    public init(message: String)
}
```

Function: Provides exception handling related to character formatting.

Parent Type:

- [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception)

### init()

```cangjie
public init()
```

Function: Creates a [ContentFormatException](io_package_exceptions.md#class-contentformatexception) instance.

### init(String)

```cangjie
public init(message: String)
```

Function: Creates a [ContentFormatException](io_package_exceptions.md#class-contentformatexception) instance with exception message.

Parameters:

- message: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Exception message.

## class IOException

```cangjie
public open class IOException <: Exception {
    public init()
    public init(message: String)
}
```

Function: Provides exception handling related to IO streams.

Parent Type:

- [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception)

### init()

```cangjie
public init()
```

Function: Creates an [IOException](io_package_exceptions.md#class-ioexception) instance.

### init(String)

```cangjie
public init(message: String)
```

Function: Creates an [IOException](io_package_exceptions.md#class-ioexception) instance with exception message.

Parameters:

- message: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Exception message.

### func getClassName()

```cangjie
protected override open func getClassName(): String
```

Function: Gets the class name.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - Class name.