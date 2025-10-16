# Exception Classes

## class FSException

```cangjie
public class FSException <: IOException {
    public init()
    public init(message: String)
}
```

Function: File stream exception class, inherits from IO stream exception class.

Parent Types:

- [IOException](../../io/io_package_api/io_package_exceptions.md#class-ioexception)

### init()

```cangjie
public init()
```

Function: Constructs a file exception instance without an error message.

### init(String)

```cangjie
public init(message: String)
```

Function: Constructs a file exception instance with an error message.

Parameters:

- message: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The error message.