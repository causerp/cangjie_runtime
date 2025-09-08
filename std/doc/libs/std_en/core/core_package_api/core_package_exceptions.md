# Exception Classes

## class ArithmeticException

```cangjie
public open class ArithmeticException <: Exception {
    public init()
    public init(message: String)
}
```

Purpose: Arithmetic exception class, used when arithmetic exceptions occur.

Parent Types:

- [Exception](#class-exception)

### init()

```cangjie
public init()
```

Purpose: Constructs a default [ArithmeticException](core_package_exceptions.md#class-arithmeticexception) instance with empty exception message.

### init(String)

```cangjie
public init(message: String)
```

Purpose: Constructs an [ArithmeticException](core_package_exceptions.md#class-arithmeticexception) instance with specified exception message.

Parameters:

- message: [String](core_package_structs.md#struct-string) - Exception message.

### func getClassName()

```cangjie
protected open override func getClassName(): String
```

Purpose: Gets the class name.

Return Value:

- [String](core_package_structs.md#struct-string) - Class name string.

## class Error

```cangjie
public open class Error <: ToString
```

Purpose: [Error](core_package_exceptions.md#class-error) is the base class for all error classes. This class cannot be inherited or initialized, but can be caught.

Parent Types:

- [ToString](core_package_interfaces.md#interface-tostring)

### prop message

```cangjie
public open prop message: String
```

Purpose: Gets the error message.

Type: [String](core_package_structs.md#struct-string)

### func getClassName()

```cangjie
protected open func getClassName(): String
```

Purpose: Gets the class name.

Return Value:

- [String](core_package_structs.md#struct-string) - Class name.

### func getStackTrace()

```cangjie
public func getStackTrace(): Array<StackTraceElement>
```

Purpose: Gets stack trace information, where each stack trace element is represented by a [StackTraceElement](core_package_classes.md#class-stacktraceelement) instance, returning an array of [StackTraceElement](core_package_classes.md#class-stacktraceelement).

Return Value:

- [Array](core_package_structs.md#struct-arrayt)\<[StackTraceElement](core_package_classes.md#class-stacktraceelement)> - Stack trace array.

### func getStackTraceMessage()

```cangjie
public open func getStackTraceMessage(): String
```

Purpose: Gets stack trace information.

Return Value:

- [String](core_package_structs.md#struct-string) - Stack trace message.

### func printStackTrace()

```cangjie
public open func printStackTrace(): Unit
```

Purpose: Prints stack trace to console.

### func toString()

```cangjie
public open func toString(): String
```

Purpose: Gets the string representation of current [Error](core_package_exceptions.md#class-error) instance, including class name and error message.

Return Value:

- [String](core_package_structs.md#struct-string) - Error message string.

## class Exception

```cangjie
public open class Exception <: ToString {
    public init()
    public init(message: String)
}
```

Purpose: [Exception](core_package_exceptions.md#class-exception) is the parent class for all exception classes.

Supports constructing exception classes, setting/getting exception messages, converting to string, getting/printing stack traces, and setting exception names (for string representation).

Parent Types:

- [ToString](core_package_interfaces.md#interface-tostring)

### prop message

```cangjie
public open prop message: String
```

Purpose: Gets the exception message.

Type: [String](core_package_structs.md#struct-string)

### init()

```cangjie
public init()
```

Purpose: Constructs a default [Exception](core_package_exceptions.md#class-exception) instance with empty exception message.

### init(String)

```cangjie
public init(message: String)
```

Purpose: Constructs an [Exception](core_package_exceptions.md#class-exception) instance with specified exception message.

Parameters:

- message: [String](core_package_structs.md#struct-string) - Exception message.

### func getClassName()

```cangjie
protected open func getClassName(): String
```

Purpose: Gets the class name.

Return Value:

- [String](core_package_structs.md#struct-string) - Class name.

### func getStackTrace()

```cangjie
public func getStackTrace(): Array<StackTraceElement>
```

Purpose: Gets stack trace information, where each stack trace element is represented by a [StackTraceElement](core_package_classes.md#class-stacktraceelement) instance, returning an array of [StackTraceElement](core_package_classes.md#class-stacktraceelement).

Return Value:

- [Array](core_package_structs.md#struct-arrayt)\<[StackTraceElement](core_package_classes.md#class-stacktraceelement)> - Stack trace array.

### func printStackTrace()

```cangjie
public func printStackTrace(): Unit
```

Purpose: Prints stack trace to console.

### func toString()

```cangjie
public open func toString(): String
```

Purpose: Gets the string representation of current [Exception](core_package_exceptions.md#class-exception) instance, including class name and exception message.

Return Value:

- [String](core_package_structs.md#struct-string) - Exception string.

## class IllegalArgumentException

```cangjie
public open class IllegalArgumentException <: Exception {
    public init()
    public init(message: String)
}
```

Purpose: Represents illegal argument exception class.

Parent Types:

- [Exception](#class-exception)

### init()

```cangjie
public init()
```

Purpose: Constructs a default [IllegalArgumentException](core_package_exceptions.md#class-illegalargumentexception) instance with empty exception message.

### init(String)

```cangjie
public init(message: String)
```

Purpose: Constructs an [IllegalArgumentException](core_package_exceptions.md#class-illegalargumentexception) instance with specified exception message.

Parameters:

- message: [String](core_package_structs.md#struct-string) - Exception message.

### func getClassName()

```cangjie
protected override open func getClassName(): String
```

Purpose: Gets the class name.

Return Value:

- [String](core_package_structs.md#struct-string) - Class name.

## class IllegalFormatException

```cangjie
public open class IllegalFormatException <: IllegalArgumentException {
    public init()
    public init(message: String)
}
```

Purpose: Represents exception class for invalid or non-standard variable formats.

Parent Types:

- [IllegalArgumentException](#class-illegalargumentexception)

### init()

```cangjie
public init()
```

Purpose: Constructs a default [IllegalFormatException](core_package_exceptions.md#class-illegalformatexception) instance with empty exception message.

### init(String)

```cangjie
public init(message: String)
```

Purpose: Constructs an [IllegalFormatException](core_package_exceptions.md#class-illegalformatexception) instance with specified exception message.

Parameters:

- message: [String](core_package_structs.md#struct-string) - Exception message.

### func getClassName()

```cangjie
protected override func getClassName(): String
```

Purpose: Gets the class name.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - Class name.

## class IllegalMemoryException

```cangjie
public class IllegalMemoryException <: Exception {
    public init()
    public init(message: String)
}
```

Purpose: Represents exception class for memory operation errors.

Parent Types:

- [Exception](#class-exception)

### init()

```cangjie
public init()
```

Purpose: Constructs a default [IllegalMemoryException](core_package_exceptions.md#class-illegalmemoryexception) instance with empty exception message.

### init(String)

```cangjie
public init(message: String)
```

Purpose: Constructs an [IllegalMemoryException](core_package_exceptions.md#class-illegalmemoryexception) instance with specified exception message.

Parameters:

- message: [String](core_package_structs.md#struct-string) - Exception message.

## class IllegalStateException

```cangjie
public class IllegalStateException <: Exception {
    public init()
    public init(message: String)
}
```

Purpose: Represents illegal state exception class.

Parent Types:

- [Exception](#class-exception)

### init()

```cangjie
public init()
```

Purpose: Constructs a default [IllegalStateException](core_package_exceptions.md#class-illegalstateexception) instance with empty exception message.

### init(String)

```cangjie
public init(message: String)
```

Purpose: Constructs an [IllegalStateException](core_package_exceptions.md#class-illegalstateexception) instance with specified exception message.

Parameters:

- message: [String](core_package_structs.md#struct-string) - Exception message.

## class IncompatiblePackageException

```cangjie
public class IncompatiblePackageException <: Exception {
    public init()
    public init(message: String)
}
```

Purpose: Represents incompatible package exception class.

Parent Types:

- [Exception](#class-exception)

### init()

```cangjie
public init()
```

Purpose: Constructs a default [IncompatiblePackageException](core_package_exceptions.md#class-incompatiblepackageexception) instance with empty exception message.

### init(String)

```cangjie
public init(message: String)
```

Purpose: Constructs an [IncompatiblePackageException](core_package_exceptions.md#class-incompatiblepackageexception) instance with specified exception message.

Parameters:

- message: [String](core_package_structs.md#struct-string) - Exception message.```markdown
## class IndexOutOfBoundsException

```cangjie
public class IndexOutOfBoundsException <: Exception {
    public init()
    public init(message: String)
}
```

Function: Represents an exception class for index out-of-bounds errors.

Parent Type:

- [Exception](#class-exception)

### init()

```cangjie
public init()
```

Function: Constructs a default [IndexOutOfBoundsException](core_package_exceptions.md#class-indexoutofboundsexception) instance with an empty error message.

### init(String)

```cangjie
public init(message: String)
```

Function: Constructs an [IndexOutOfBoundsException](core_package_exceptions.md#class-indexoutofboundsexception) instance with the specified error message.

Parameters:

- message: [String](core_package_structs.md#struct-string) - The exception message.

## class NegativeArraySizeException

```cangjie
public class NegativeArraySizeException <: Exception {
    public init()
    public init(message: String)
}
```

Function: Represents an exception class for negative array size errors.

Parent Type:

- [Exception](#class-exception)

### init()

```cangjie
public init()
```

Function: Constructs a default [NegativeArraySizeException](core_package_exceptions.md#class-negativearraysizeexception) instance with an empty error message.

### init(String)

```cangjie
public init(message: String)
```

Function: Constructs a [NegativeArraySizeException](core_package_exceptions.md#class-negativearraysizeexception) instance with the specified error message.

Parameters:

- message: [String](core_package_structs.md#struct-string) - The exception message.

## class NoneValueException

```cangjie
public class NoneValueException <: Exception {
    public init()
    public init(message: String)
}
```

Function: Represents an exception class for [Option](core_package_enums.md#enum-optiont)\<T> instances with `None` value, typically thrown by the `getOrThrow` function.

Parent Type:

- [Exception](#class-exception)

### init()

```cangjie
public init()
```

Function: Constructs a default [NoneValueException](core_package_exceptions.md#class-nonevalueexception) instance with an empty error message.

### init(String)

```cangjie
public init(message: String)
```

Function: Constructs a [NoneValueException](core_package_exceptions.md#class-nonevalueexception) instance with the specified error message.

Parameters:

- message: [String](core_package_structs.md#struct-string) - The exception message.

## class OutOfMemoryError

```cangjie
public class OutOfMemoryError <: Error
```

Function: Represents an error class for out-of-memory conditions. This class cannot be inherited or instantiated but can be caught.

Parent Type:

- [Error](#class-error)

## class OverflowException

```cangjie
public class OverflowException <: ArithmeticException {
    public init()
    public init(message: String)
}
```

Function: Represents an exception class for arithmetic overflow errors.

Parent Type:

- [ArithmeticException](#class-arithmeticexception)

### init()

```cangjie
public init()
```

Function: Constructs a default [OverflowException](core_package_exceptions.md#class-overflowexception) instance with an empty error message.

### init(String)

```cangjie
public init(message: String)
```

Function: Constructs an [OverflowException](core_package_exceptions.md#class-overflowexception) instance with the specified error message.

Parameters:

- message: [String](core_package_structs.md#struct-string) - The exception message.

## class SpawnException

```cangjie
public class SpawnException <: Exception {
    public init()
    public init(message: String)
}
```

Function: Thread exception class indicating errors during thread processing.

Parent Type:

- [Exception](#class-exception)

### init()

```cangjie
public init()
```

Function: Constructs a default [SpawnException](core_package_exceptions.md#class-spawnexception) instance with an empty error message.

### init(String)

```cangjie
public init(message: String)
```

Function: Constructs a [SpawnException](core_package_exceptions.md#class-spawnexception) instance with the specified error message.

Parameters:

- message: [String](core_package_structs.md#struct-string) - The exception message.

## class StackOverflowError

```cangjie
public class StackOverflowError <: Error
```

Function: Represents an error class for stack overflow conditions. This class cannot be inherited or instantiated but can be caught.

Parent Type:

- [Error](#class-error)

### func printStackTrace()

```cangjie
public override func printStackTrace(): Unit
```

Function: Prints stack trace information to the console.

## class TimeoutException

```cangjie
public class TimeoutException <: Exception {
    public init()
    public init(message: String)
}
```

Function: Exception thrown when a blocking operation times out.

Parent Type:

- [Exception](#class-exception)

### init()

```cangjie
public init()
```

Function: Constructs a default [TimeoutException](core_package_exceptions.md#class-timeoutexception) instance with an empty error message.

### init(String)

```cangjie
public init(message: String)
```

Function: Constructs a [TimeoutException](core_package_exceptions.md#class-timeoutexception) instance with the specified error message.

Parameters:

- message: [String](core_package_structs.md#struct-string) - The exception message.

## class UnsupportedException

```cangjie
public class UnsupportedException <: Exception {
    public init()
    public init(message: String)
}
```

Function: Represents an exception class for unsupported features.

Parent Type:

- [Exception](#class-exception)

### init()

```cangjie
public init()
```

Function: Constructs a default [UnsupportedException](core_package_exceptions.md#class-unsupportedexception) instance with an empty error message.

### init(String)

```cangjie
public init(message: String)
```

Function: Constructs an [UnsupportedException](core_package_exceptions.md#class-unsupportedexception) instance with the specified error message.

Parameters:

- message: [String](core_package_structs.md#struct-string) - The exception message.
```