# Exception Classes

## class IllegalSetException

```cangjie
public class IllegalSetException <: ReflectException {
    public init()
    public init(message: String)
}
```

Function: [IllegalSetException](reflect_package_exceptions.md#class-illegalsetexception) is the exception thrown when attempting to modify an immutable type.

Parent Type:

- [ReflectException](#class-reflectexception)

### init()

```cangjie
public init()
```

Function: Creates an instance of [IllegalSetException](reflect_package_exceptions.md#class-illegalsetexception).

### init(String)

```cangjie
public init(message: String)
```

Function: Creates an instance of [IllegalSetException](reflect_package_exceptions.md#class-illegalsetexception) with the specified error message.

Parameters:

- message: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The error message.

## class IllegalTypeException

```cangjie
public class IllegalTypeException <: ReflectException {
    public init()
    public init(message: String)
}
```

Function: [IllegalTypeException](reflect_package_exceptions.md#class-illegaltypeexception) is the exception thrown for type mismatch errors.

Parent Type:

- [ReflectException](#class-reflectexception)

### init()

```cangjie
public init()
```

Function: Creates an instance of [IllegalTypeException](reflect_package_exceptions.md#class-illegaltypeexception).

### init(String)

```cangjie
public init(message: String)
```

Function: Creates an instance of [IllegalTypeException](reflect_package_exceptions.md#class-illegaltypeexception) with the specified error message.

Parameters:

- message: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The error message.

## class InfoNotFoundException

```cangjie
public class InfoNotFoundException <: ReflectException {
    public init()
    public init(message: String)
}
```

Function: [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) is the exception thrown when corresponding information cannot be found.

Parent Type:

- [ReflectException](#class-reflectexception)

### init()

```cangjie
public init()
```

Function: Creates an instance of [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception).

### init(String)

```cangjie
public init(message: String)
```

Function: Creates an instance of [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) with the specified error message.

Parameters:

- message: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The error message.

## class InvocationTargetException

```cangjie
public class InvocationTargetException <: ReflectException {
    public init()
    public init(message: String)
}
```

Function: [InvocationTargetException](reflect_package_exceptions.md#class-invocationtargetexception) is the wrapper exception for function invocation errors.

Parent Type:

- [ReflectException](#class-reflectexception)

### init()

```cangjie
public init()
```

Function: Creates an instance of [InvocationTargetException](reflect_package_exceptions.md#class-invocationtargetexception).

### init(String)

```cangjie
public init(message: String)
```

Function: Creates an instance of [InvocationTargetException](reflect_package_exceptions.md#class-invocationtargetexception) with the specified error message.

Parameters:

- message: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The error message.

## class MisMatchException

```cangjie
public class MisMatchException <: ReflectException {
    public init()
    public init(message: String)
}
```

Function: [MisMatchException](reflect_package_exceptions.md#class-mismatchexception) is the exception thrown when calling corresponding functions.

Parent Type:

- [ReflectException](#class-reflectexception)

### init()

```cangjie
public init()
```

Function: Creates an instance of [MisMatchException](reflect_package_exceptions.md#class-mismatchexception).

### init(String)

```cangjie
public init(message: String)
```

Function: Creates an instance of [MisMatchException](reflect_package_exceptions.md#class-mismatchexception) with the specified error message.

Parameters:

- message: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The error message.

## class ReflectException

```cangjie
public open class ReflectException <: Exception {
    public init()
    public init(message: String)
}
```

Function: [ReflectException](reflect_package_exceptions.md#class-reflectexception) is the base exception class for the Reflect package.

Parent Type:

- [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception)

### init()

```cangjie
public init()
```

Function: Creates an instance of [ReflectException](reflect_package_exceptions.md#class-reflectexception).

### init(String)

```cangjie
public init(message: String)
```

Function: Creates an instance of [ReflectException](reflect_package_exceptions.md#class-reflectexception) with the specified error message.

Parameters:

- message: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The error message.

### func getClassName()

```cangjie
protected override open func getClassName(): String
```

Function: Retrieves the class name.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The class name string.