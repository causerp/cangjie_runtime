# Exception

## class ConcurrentModificationException

```cangjie
public class ConcurrentModificationException <: Exception {
    public init()
    public init(message: String)
}
```

Function: Concurrent modification exception class. Thrown when a function detects unsynchronized concurrent modifications.

Since none of the container classes provided by the collection package support concurrent modifications, certain operations will throw [ConcurrentModificationException](collection_package_exception.md#class-concurrentmodificationexception).

Typical scenarios that trigger this exception include:

- Modifying a container during for-in iteration (except for the [remove](../../posix/posix_package_api/posix_package_funcs.md#func-removestring-deprecated)() method of [HashMapIterator](collection_package_class.md#class-hashmapiteratork-v-where-k--hashable--equatablek)).
- When using short-lived types like [MapEntryView](collection_package_interface.md#interface-mapentryviewk-v), if the underlying container content is modified, this exception will be thrown.

Parent type:

- [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception)

### init()

```cangjie
public init()
```

Function: Constructs an instance without exception message.

Example:

<!-- verify -->
```cangjie
import std.collection.*

main(): Unit {
    // Create a ConcurrentModificationException instance using the no-argument constructor
    let exception = ConcurrentModificationException()
    println("Created a no-argument ConcurrentModificationException instance")
    
    // The exception can be thrown and caught
    try {
        throw ConcurrentModificationException()
    } catch (e: ConcurrentModificationException) {
        println("Caught a ConcurrentModificationException")
    }
}
```

Execution result:

```text
Created a no-argument ConcurrentModificationException instance
Caught a ConcurrentModificationException
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
import std.collection.*

main(): Unit {
    // Create a ConcurrentModificationException instance with a custom message
    let message = "Concurrent modification exception: Container was modified during iteration"
    let exception = ConcurrentModificationException(message)
    println("Created a ConcurrentModificationException instance with message: ${exception.message}")
    
    // Can throw and catch this exception
    try {
        throw ConcurrentModificationException("Container was modified during iteration")
    } catch (e: ConcurrentModificationException) {
        println("Caught exception: ${e.message}")
    }
}
```

Execution result:

```text
Created a ConcurrentModificationException instance with message: Concurrent modification exception: Container was modified during iteration
Caught exception: Container was modified during iteration
```
