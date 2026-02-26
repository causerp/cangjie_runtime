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

<!--RP1-->
```cangjie
public open class Exception <: ToString {
    public init()
    public init(causedBy: Exception)
    public init(message: String)
    public init(message: String, causedBy: Exception)
}
```
<!--RP1End-->

Purpose: [Exception](core_package_exceptions.md#class-exception) is the parent class for all exception classes.

Supports constructing exception classes, setting/getting exception messages, converting to string, getting/printing stack traces, and setting exception names (for string representation).

Parent Types:

- [ToString](core_package_interfaces.md#interface-tostring)

<!--Del-->
### prop causedBy

```cangjie
public mut prop causedBy: ?Exception
```

Function: Cause of exception.

Type: ?[Exception](core_package_exceptions.md#class-exception)

Example:

<!-- verify -->
```cangjie
main() {
    try {
        throwException()
    } catch (e: Exception) {
        println(e)
        if (let Some(cause) <- e.causedBy) {
            println(cause)
        }
    }
}

func throwException() {
    try {
        throwCause()
    } catch (e: Exception) {
        let exception = Exception("This is an exception")
        exception.causedBy = e
        throw exception
    }
}

func throwCause() {
    throw Exception("This is a cause")
}
```

Execution Result:

```text
Exception: This is an exception
Exception: This is a cause
```

> **Note：**
>
> Unsupported platform：OpenHarmony
<!--DelEnd-->

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

<!--Del-->
### init(Exception)

```cangjie
public init(causedBy: Exception)
```

Function: Constructs a [Exception](core_package_exceptions.md#class-exception) instance with the specified cause and empty default exception message.

Parameters:

- causedBy: [Exception](core_package_exceptions.md#class-exception) - Cause of exception.

Example:

<!-- verify -->
```cangjie
main() {
    try {
        throwException()
    } catch (e: Exception) {
        println(e)
        if (let Some(cause) <- e.causedBy) {
            println(cause)
        }
    }
}

func throwException() {
    try {
        throwCause()
    } catch (e: Exception) {
        throw Exception(e)
    }
}

func throwCause() {
    throw Exception("This is a cause")
}
```

Execution Result:

```text
Exception
Exception: This is a cause
```

> **Note：**
>
> Unsupported platform：OpenHarmony
<!--DelEnd-->

### init(String)

```cangjie
public init(message: String)
```

Purpose: Constructs an [Exception](core_package_exceptions.md#class-exception) instance with specified exception message.

Parameters:

- message: [String](core_package_structs.md#struct-string) - Exception message.

<!--Del-->
### init(String, Exception)

```cangjie
public init(message: String, causedBy: Exception)
```

Function: Construct a [Exception](core_package_exceptions.md#class-exception) instance with the specified exception message and cause。

Parameters:

- message: [String](core_package_structs.md#struct-string) - Exception message.
- causedBy: [Exception](core_package_exceptions.md#class-exception) - Cause of exception.

Example:

<!-- run -->
```cangjie
main(): Unit {
    try {
        throwException()
    } catch (e: Exception) {
        throw Exception("This is the exception to be thrown", e)
    }

    ()
}

func throwException() {
    try {
        throwCause()
    } catch (e: Exception) {
        throw Exception("This is an exception", e)
    }
}

func throwCause() {
    throw Exception("This is a cause")
}
```

Possible execution result:

```text
An exception has occurred:
Exception: This is the exception to be thrown
     at default::main()(/tmp/test-exception-chain.cj:5)
Caused by: Exception: This is an exception
     at default::throwException()(/tmp/test-exception-chain.cj:15)
     at default::main()(/tmp/test-exception-chain.cj:3)
Caused by: Exception: This is a cause
     at default::throwCause()(/tmp/test-exception-chain.cj:20)
     at default::throwException()(/tmp/test-exception-chain.cj:13)
     ... 1 more
```

> **Note：**
>
> Unsupported platform：OpenHarmony
<!--DelEnd-->

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

Example:

<!-- verify -->
```cangjie
// Create subclass of IllegalArgumentException to demonstrate getClassName()
class MyException <: IllegalArgumentException {
    public init() {
        super()
    }
    
    public init(message: String) {
        super(message)
    }
    
    // Call protected method getClassName()
    public func getExceptionClassName(): String {
        return this.getClassName()
    }
}

main() {
    let exception = MyException("Test exception")
    println("Exception class name: " + exception.getExceptionClassName())
}
```

Output:

```text
Exception class name: IllegalArgumentException
```
<!--Del-->
## class ExclusiveScopeException

```cangjie
public class ExclusiveScopeException <: Exception
```

Purpose: Custom exception class used to wrap exceptions thrown in an exclusive scope. It preserves the stack trace information of the original exception, does not support actively constructing this exception, but it can be caught.

Parent Type: 
- [Exception](#class-exception)

### func toString()

```cangjie
public override func toString(): String
```
Purpose: Get class name.

Return Value:

- [String](core_package_structs.md#struct-string) - Class name.

Example:

<!-- code_no_check -->
```cangjie
// This example is for demonstration only, assuming an ExclusiveScopeException is thrown
main() {
    try {
    // Assume memory error occurs
    } catch (e: ExclusiveScopeException) {
        println(e.message)
    }
}
```

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

- message: [String](core_package_structs.md#struct-string) - Exception message.

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