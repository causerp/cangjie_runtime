# Exception Classes

## class SocketException

```cangjie
public class SocketException <: IOException {
    public init()
    public init(message: String)
}
```

Function: Provides socket-related exception handling.

Parent Types:

- [IOException](../../io/io_package_api/io_package_exceptions.md#class-ioexception)

### init()

```cangjie
public init()
```

Function: Creates a [SocketException](net_package_exceptions.md#class-socketexception) instance.

### init(String)

```cangjie
public init(message: String)
```

Function: Creates a [SocketException](net_package_exceptions.md#class-socketexception) instance with exception message.

Parameters:

- message: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Exception prompt message.

## class SocketTimeoutException

```cangjie
public class SocketTimeoutException <: Exception {
    public init()
    public init(message: String)
}
```

Function: Provides socket operation timeout-related exception handling.

Parent Types:

- [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception)

### init()

```cangjie
public init()
```

Function: Creates a [SocketTimeoutException](net_package_exceptions.md#class-sockettimeoutexception) instance.

### init(String)

```cangjie
public init(message: String)
```

Function: Creates a [SocketTimeoutException](net_package_exceptions.md#class-sockettimeoutexception) instance with exception message.

Parameters:

- message: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Exception prompt message.