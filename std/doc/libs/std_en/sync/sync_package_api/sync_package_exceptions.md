# Exception Classes

## class IllegalSynchronizationStateException

```cangjie
public class IllegalSynchronizationStateException <: Exception {
    public init()
    public init(message: String)
}
```

Function: This class represents an illegal synchronization state exception.

Parent Types:

- [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception)

### init()

```cangjie
public init()
```

Function: Creates an [IllegalSynchronizationStateException](sync_package_exceptions.md#class-illegalsynchronizationstateexception) instance.

### init(String)

```cangjie
public init(message: String)
```

Function: Creates an [IllegalSynchronizationStateException](sync_package_exceptions.md#class-illegalsynchronizationstateexception) instance with the message specified by the `message` parameter.

Parameters:

- message: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Predefined message.