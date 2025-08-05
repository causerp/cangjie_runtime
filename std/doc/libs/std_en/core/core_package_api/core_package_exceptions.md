# Exception Classes

## class ArithmeticException

```cangjie
public open class ArithmeticException <: Exception {
    public init()
    public init(message: String)
}
```

Function: Arithmetic exception class, used when arithmetic exceptions occur.

Parent Types:

- [Exception](#class-exception)

### init()

```cangjie
public init()
```

Function: Constructs a default [ArithmeticException](core_package_exceptions.md#class-arithmeticexception) instance with empty default exception message.

### init(String)

```cangjie
public init(message: String)
```

Function: Constructs an [ArithmeticException](core_package_exceptions.md#class-arithmeticexception) instance with the specified exception message.

Parameters:

- message: [String](core_package_structs.md#struct-string) - Exception prompt message.

### func getClassName()

```cangjie
protected open override func getClassName(): String
```

Function: Gets the class name.

Return Value:

- [String](core_package_structs.md#struct-string) - Class name string.

## class Error

```cangjie
public open class Error <: ToString
```

Function: [Error](core_package_exceptions.md#class-error) is the base class for all error classes. This class cannot be inherited or instantiated, but can be caught.

Parent Types:

- [ToString](core_package_interfaces.md#interface-tostring)

### prop message

```cangjie
public open prop message: String
```

Function: Gets the error message.

Type: [String](core_package_structs.md#struct-string)

### func getClassName()

```cangjie
protected open func getClassName(): String
```

Function: Gets the class name.

Return Value:

- [String](core_package_structs.md#struct-string) - Class name.

### func getStackTrace()

```cangjie
public func getStackTrace(): Array<StackTraceElement>
```

Function: Gets the stack trace information, where each stack trace element is represented by a [StackTraceElement](core_package_classes.md#class-stacktraceelement) instance, returning an array of [StackTraceElement](core_package_classes.md#class-stacktraceelement).

Return Value:

- [Array](core_package_structs.md#struct-arrayt)\<[StackTraceElement](core_package_classes.md#class-stacktraceelement)> - Stack trace information array.

### func getStackTraceMessage()

```cangjie
public open func getStackTraceMessage(): String
```

Function: Gets the stack trace message.

Return Value:

- [String](core_package_structs.md#struct-string) - Stack trace message.

### func printStackTrace()

```cangjie
public open func printStackTrace(): Unit
```

Function: Prints the stack trace to the console.

### func toString()

```cangjie
public open func toString(): String
```

Function: Gets the string representation of the current [Error](core_package_exceptions.md#class-error) instance, including the class name and error message.

Return Value:

- [String](core_package_structs.md#struct-string) - Error message string.

## class Exception

```cangjie
public open class Exception <: ToString {
    public init()
    public init(message: String)
}
```

Function: [Exception](core_package_exceptions.md#class-exception) is the parent class for all exception classes.

Supports constructing an exception class, setting/getting exception messages, converting to string, getting/printing stack traces, and setting exception names (for string representation).

Parent Types:

- [ToString](core_package_interfaces.md#interface-tostring)

### prop message

```cangjie
public open prop message: String
```

Function: Gets the exception message.

Type: [String](core_package_structs.md#struct-string)

### init()

```cangjie
public init()
```

Function: Constructs a default [Exception](core_package_exceptions.md#class-exception) instance with empty default exception message.

### init(String)

```cangjie
public init(message: String)
```

Function: Constructs an [Exception](core_package_exceptions.md#class-exception) instance with the specified exception message.

Parameters:

- message: [String](core_package_structs.md#struct-string) - Exception prompt message.

### func getClassName()

```cangjie
protected open func getClassName(): String
```

Function: Gets the class name.

Return Value:

- [String](core_package_structs.md#struct-string) - Class name.

### func getStackTrace()

```cangjie
public func getStackTrace(): Array<StackTraceElement>
```

Function: Gets the stack trace information, where each stack trace element is represented by a [StackTraceElement](core_package_classes.md#class-stacktraceelement) instance, returning an array of [StackTraceElement](core_package_classes.md#class-stacktraceelement).

Return Value:

- [Array](core_package_structs.md#struct-arrayt)\<[StackTraceElement](core_package_classes.md#class-stacktraceelement)> - Stack trace information array.

### func printStackTrace()

```cangjie
public func printStackTrace(): Unit
```

Function: Prints the stack trace to the console.

### func toString()

```cangjie
public open func toString(): String
```

Function: Gets the string representation of the current [Exception](core_package_exceptions.md#class-exception) instance, including the class name and exception message.

Return Value:

- [String](core_package_structs.md#struct-string) - Exception string.

## class IllegalArgumentException

```cangjie
public open class IllegalArgumentException <: Exception {
    public init()
    public init(message: String)
}
```

Function: Represents an exception class for illegal arguments.

Parent Types:

- [Exception](#class-exception)

### init()

```cangjie
public init()
```

Function: Constructs a default [IllegalArgumentException](core_package_exceptions.md#class-illegalargumentexception) instance with empty default exception message.

### init(String)

```cangjie
public init(message: String)
```

Function: Constructs an [IllegalArgumentException](core_package_exceptions.md#class-illegalargumentexception) instance with the specified exception message.

Parameters:

- message: [String](core_package_structs.md#struct-string) - Exception prompt message.

### func getClassName()

```cangjie
protected override open func getClassName(): String
```

Function: Gets the class name.

Return Value:

- [String](core_package_structs.md#struct-string) - Class name.

## class IllegalFormatException

```cangjie
public open class IllegalFormatException <: IllegalArgumentException {
    public init()
    public init(message: String)
}
```

Function: Represents an exception class for invalid or non-standard variable formats.

Parent Types:

- [IllegalArgumentException](#class-illegalargumentexception)

### init()

```cangjie
public init()
```

Function: Constructs a default [IllegalFormatException](core_package_exceptions.md#class-illegalformatexception) instance with empty default exception message.

### init(String)

```cangjie
public init(message: String)
```

Function: Constructs an [IllegalFormatException](core_package_exceptions.md#class-illegalformatexception) instance with the specified exception message.

Parameters:

- message: [String](core_package_structs.md#struct-string) - Exception prompt message.## class IllegalMemoryException

```cangjie
public class IllegalMemoryException <: Exception {
    public init()
    public init(message: String)
}
```

Purpose: Represents an exception class for memory operation errors.

Parent Types:

- [Exception](#class-exception)

### init()

```cangjie
public init()
```

Purpose: Constructs a default [IllegalMemoryException](core_package_exceptions.md#class-illegalmemoryexception) instance with empty error message.

### init(String)

```cangjie
public init(message: String)
```

Purpose: Constructs an [IllegalMemoryException](core_package_exceptions.md#class-illegalmemoryexception) instance with specified error message.

Parameters:

- message: [String](core_package_structs.md#struct-string) - Exception message.

## class IllegalStateException

```cangjie
public class IllegalStateException <: Exception {
    public init()
    public init(message: String)
}
```

Purpose: Represents an exception class for illegal states.

Parent Types:

- [Exception](#class-exception)

### init()

```cangjie
public init()
```

Purpose: Constructs a default [IllegalStateException](core_package_exceptions.md#class-illegalstateexception) instance with empty error message.

### init(String)

```cangjie
public init(message: String)
```

Purpose: Constructs an [IllegalStateException](core_package_exceptions.md#class-illegalstateexception) instance with specified error message.

Parameters:

- message: [String](core_package_structs.md#struct-string) - Exception message.

## class IncompatiblePackageException

```cangjie
public class IncompatiblePackageException <: Exception {
    public init()
    public init(message: String)
}
```

Purpose: Represents an exception class for incompatible packages.

Parent Types:

- [Exception](#class-exception)

### init()

```cangjie
public init()
```

Purpose: Constructs a default [IncompatiblePackageException](core_package_exceptions.md#class-incompatiblepackageexception) instance with empty error message.

### init(String)

```cangjie
public init(message: String)
```

Purpose: Constructs an [IncompatiblePackageException](core_package_exceptions.md#class-incompatiblepackageexception) instance with specified error message.

Parameters:

- message: [String](core_package_structs.md#struct-string) - Exception message.

## class IndexOutOfBoundsException

```cangjie
public class IndexOutOfBoundsException <: Exception {
    public init()
    public init(message: String)
}
```

Purpose: Represents an exception class for index out-of-bounds errors.

Parent Types:

- [Exception](#class-exception)

### init()

```cangjie
public init()
```

Purpose: Constructs a default [IndexOutOfBoundsException](core_package_exceptions.md#class-indexoutofboundsexception) instance with empty error message.

### init(String)

```cangjie
public init(message: String)
```

Purpose: Constructs an [IndexOutOfBoundsException](core_package_exceptions.md#class-indexoutofboundsexception) instance with specified error message.

Parameters:

- message: [String](core_package_structs.md#struct-string) - Exception message.

## class InternalError

```cangjie
public class InternalError <: Error
```

Purpose: Represents an internal error class that cannot be instantiated but can be caught.

Parent Types:

- [Error](#class-error)

## class NegativeArraySizeException

```cangjie
public class NegativeArraySizeException <: Exception {
    public init()
    public init(message: String)
}
```

Purpose: Represents an exception class for negative array sizes.

Parent Types:

- [Exception](#class-exception)

### init()

```cangjie
public init()
```

Purpose: Constructs a default [NegativeArraySizeException](core_package_exceptions.md#class-negativearraysizeexception) instance with empty error message.

### init(String)

```cangjie
public init(message: String)
```

Purpose: Constructs a [NegativeArraySizeException](core_package_exceptions.md#class-negativearraysizeexception) instance with specified error message.

Parameters:

- message: [String](core_package_structs.md#struct-string) - Exception message.

## class NoneValueException

```cangjie
public class NoneValueException <: Exception {
    public init()
    public init(message: String)
}
```

Purpose: Represents an exception class when an [Option](core_package_enums.md#enum-optiont)\<T> instance has `None` value, typically thrown by `getOrThrow` function.

Parent Types:

- [Exception](#class-exception)

### init()

```cangjie
public init()
```

Purpose: Constructs a default [NoneValueException](core_package_exceptions.md#class-nonevalueexception) instance with empty error message.

### init(String)

```cangjie
public init(message: String)
```

Purpose: Constructs a [NoneValueException](core_package_exceptions.md#class-nonevalueexception) instance with specified error message.

Parameters:

- message: [String](core_package_structs.md#struct-string) - Exception message.

## class OutOfMemoryError

```cangjie
public class OutOfMemoryError <: Error
```

Purpose: Represents an out-of-memory error class that cannot be inherited or instantiated but can be caught.

Parent Types:

- [Error](#class-error)

## class OverflowException

```cangjie
public class OverflowException <: ArithmeticException {
    public init()
    public init(message: String)
}
```

Purpose: Represents an exception class for arithmetic overflow.

Parent Types:

- [ArithmeticException](#class-arithmeticexception)

### init()

```cangjie
public init()
```

Purpose: Constructs a default [OverflowException](core_package_exceptions.md#class-overflowexception) instance with empty error message.

### init(String)

```cangjie
public init(message: String)
```

Purpose: Constructs an [OverflowException](core_package_exceptions.md#class-overflowexception) instance with specified error message.

Parameters:

- message: [String](core_package_structs.md#struct-string) - Exception message.

## class SpawnException

```cangjie
public class SpawnException <: Exception {
    public init()
    public init(message: String)
}
```

Purpose: Thread exception class indicating errors during thread processing.

Parent Types:

- [Exception](#class-exception)

### init()

```cangjie
public init()
```

Purpose: Constructs a default [SpawnException](core_package_exceptions.md#class-spawnexception) instance with empty error message.

### init(String)

```cangjie
public init(message: String)
```

Purpose: Constructs a [SpawnException](core_package_exceptions.md#class-spawnexception) instance with specified error message.

Parameters:

- message: [String](core_package_structs.md#struct-string) - Exception message.Parameters:

- message: [String](core_package_structs.md#struct-string) - Exception message.

## class StackOverflowError

```cangjie
public class StackOverflowError <: Error
```

Function: Represents a stack overflow error class. This class cannot be inherited or instantiated, but can be caught.

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

Function: Thrown when a blocking operation times out.

Parent Type:

- [Exception](#class-exception)

### init()

```cangjie
public init()
```

Function: Constructs a default [TimeoutException](core_package_exceptions.md#class-timeoutexception) instance with an empty exception message.

### init(String)

```cangjie
public init(message: String)
```

Function: Constructs a [TimeoutException](core_package_exceptions.md#class-timeoutexception) instance with the specified exception message.

Parameters:

- message: [String](core_package_structs.md#struct-string) - Exception message.

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

Function: Constructs a default [UnsupportedException](core_package_exceptions.md#class-unsupportedexception) instance with an empty exception message.

### init(String)

```cangjie
public init(message: String)
```

Function: Constructs an [UnsupportedException](core_package_exceptions.md#class-unsupportedexception) instance with the specified exception message.

Parameters:

- message: [String](core_package_structs.md#struct-string) - Exception message.