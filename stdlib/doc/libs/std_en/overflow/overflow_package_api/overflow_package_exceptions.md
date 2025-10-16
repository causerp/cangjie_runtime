# Exception Classes

## class OvershiftException

```cangjie
public class OvershiftException <: Exception {
    public init()
    public init(message: String)
}
```

Function: Exception thrown when the shift count exceeds the bit width of the operand in shift operations.

Parent Types:

- [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception)

### init()

```cangjie
public init()
```

Function: Creates an instance of [OvershiftException](overflow_package_exceptions.md#class-overshiftexception).

### init(String)

```cangjie
public init(message: String)
```

Function: Creates an instance of [OvershiftException](overflow_package_exceptions.md#class-overshiftexception) with the specified error message.

Parameters:

- message: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The error message.

## class UndershiftException

```cangjie
public class UndershiftException <: Exception {
    public init()
    public init(message: String)
}
```

Function: Exception thrown when the shift count is less than 0 in shift operations.

Parent Types:

- [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception)

### init()

```cangjie
public init()
```

Function: Creates an instance of [UndershiftException](overflow_package_exceptions.md#class-undershiftexception).

### init(String)

```cangjie
public init(message: String)
```

Function: Creates an instance of [UndershiftException](overflow_package_exceptions.md#class-undershiftexception) with the specified error message.

Parameters:

- message: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The error message.