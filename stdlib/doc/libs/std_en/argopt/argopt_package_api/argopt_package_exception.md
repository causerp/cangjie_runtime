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

Example：

<!-- verify -->
```cangjie
import std.argopt.*

main(): Unit {
    // Create an exception instance using the no-argument constructor
    let exception = ArgumentParseException()
    println("Created an ArgumentParseException instance with no arguments")
    
    // The exception can be thrown and caught
    try {
        throw ArgumentParseException()
    } catch (e: ArgumentParseException) {
        println("Caught an ArgumentParseException")
    }
}
```

Possible execution result:

```text
Created an ArgumentParseException instance with no arguments
Caught an ArgumentParseException
```

### init(String)

```cangjie
public init(message: String)
```

Function: Constructs an exception instance with the specified message.

Parameters:

- message: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The exception message.

Example:

<!-- verify -->
```cangjie
import std.argopt.*

main(): Unit {
    // Create an exception instance with a message using the constructor
    let message = "Argument parsing failed: unknown option --xyz"
    let exception = ArgumentParseException(message)
    println("Created an ArgumentParseException instance with message: ${exception.message}")
    
    // The exception can be thrown and caught
    try {
        throw ArgumentParseException("Invalid argument format")
    } catch (e: ArgumentParseException) {
        println("Caught exception: ${e.message}")
    }
}
```

Possible execution result:

```text
Created an ArgumentParseException instance with message: Argument parsing failed: unknown option --xyz
Caught exception: Invalid argument format
```
