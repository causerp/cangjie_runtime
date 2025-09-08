# Mock Basic Concepts and Usage

## Creating Mock Objects

**Mock constructors** can create two types of objects by calling the `mock<T>` and `spy<T>` functions: **mock** and **spy**, where `T` represents the class or interface being mocked.

```cangjie
public func mock<T>(): T
public func spy<T>(objectToSpyOn: T): T
```

<!-- Link to mock/spy constructors -->

**Mock** serves as a skeleton object and performs no operations on members by default.

**Spy** is a special type of mock object used to wrap an existing instance of a class or interface. By default, a spy object delegates member calls to the underlying object. In other aspects, spy and mock objects are very similar.

Only **classes** (including final and sealed classes) and **interfaces** can be mocked this way.

See [Using Mock and Spy Objects](#using-spy-and-mock-objects).

See [Top-Level and Static Declarations](#top-level-and-static-declarations) for details on mocking top-level and static declarations.

## Configuration API

The **Configuration API** is the core of the framework, allowing you to define the behavior of mock/spy object members (or redefine spy objects, top-level/static declarations).

The entry point for the **Configuration API** is the `@On` macro invocation.

<!--compile.onlyformat-->
```cangjie
@On(storage.getComments(testId)).returns(testComments)
```

In this example, if the mock object `storage` *receives* a call to the `getComments` method with the specified argument `testId`, it returns `testComment`.

This behavior is called **stubbing**. Stubs (simulated components that are either unimplemented or cannot be executed in the test environment) must be defined within the test case body first.

The following declaration types can be stubbed:

* Instance members of classes and interfaces (including final members)
* Static functions, properties, and fields
* Top-level functions and variables

The following declarations **cannot** be stubbed:

* Extension members
* Foreign functions
* Local functions and variables
* Constructors
* Constants
* Any private declarations

A complete **stub declaration** consists of the following parts:

1. The **stub signature** described in the `@On` macro invocation.
2. The [operation](#operation-api) used to describe the stub behavior.
3. (Optional) A cardinality specifier (an expression specifying the expected number of executions) for setting [expectations](#expectations).
4. (Optional) A [continuation](#stub-chaining) (an expression supporting chained calls).

The mock framework intercepts calls matching the stub signature and executes the specified operation in the stub declaration.

### Top-Level and Static Declarations

Unlike members of classes or interfaces, when stubbing static members or top-level functions/variables, no mock object needs to be created. These declarations should be stubbed directly using the Configuration API (e.g., the `@On` macro).

Here is an example of stubbing a top-level function:

<!--run -->
```cangjie
import std.unittest.mock.*
import std.unittest.mock.mockmacro.*

public class Entry {
    Entry(let id: Int64, let title: String, let description: String) {}
    static func parse(): Entry {
        Entry(1, "1", "1")
    }
}

public func loadLastEntryInCatalog(): Entry {
    return Entry.parse()
}

public func drawLastEntryWidget() {
    let lastEntry = loadLastEntryInCatalog()
    // drawing...
}

@Test
class RightsTest {
    @TestCase
    func removeLastEntry() {
        @On(loadLastEntryInCatalog()).returns(Entry(1, "Test entry", "Test description"))
        drawLastEntryWidget()
    }
}
```

### Stub Signature

The **stub signature** defines a set of conditions that match a specific subset of calls, including the following parts:

* A reference to the mock/spy object, which must be a single identifier. (Standalone declarations—top-level or static functions/variables—do not require this part.)
* The member or standalone declaration being called.
* A specific format for argument calls, as described in [Argument Matchers](#argument-matchers).

The signature can match the following entities:

* Methods
* Property getters
* Property setters
* Field read operations
* Field write operations
* Static functions
* Static property getters
* Static property setters
* Static field read operations
* Static field write operations
* Top-level functions
* Top-level field read operations
* Top-level field write operations

A stub signature matches a call when the corresponding declaration is invoked and all arguments (if any) match the respective argument matchers.

The structure of a method stub signature: `<mock object name>.<method name>(<argument matcher>*)`.

<!--compile.onlyformat-->
```cangjie
@On(foo.method(0, 1)) // Method call with arguments 0 and 1
@On(foo.method(param1: 0, param2: 1)) // Method call with named arguments
```

When stubbing property getters/setters or field read/write operations, use `<mock object name>.<property or field name>` or `<mock object name>.<property or field name> = <argument matcher>`.

<!--compile.onlyformat-->
```cangjie
@On(foo.prop) // Property getter
@On(foo.prop = 3) // Property setter with argument 3
```

For top-level and static functions, the signatures are similar:

* Top-level function: `<function name>(<argument matcher>*)`
* Static function: `<class name>.<static method name>(<argument matcher>*)`

Signatures for top-level variables and static properties/fields are as follows:

* Top-level variable: `<top-level variable name>` or `<top-level variable name> = <argument matcher>`
* Static property/field: `<class name>.<static property/field name>` or `<class name>.<static property/field name> = <argument matcher>`

When stubbing operator functions, the operator's receiver must be a single reference to the mock/spy object, and the operator's arguments must be argument matchers.

<!--compile.onlyformat-->
```cangjie
@On(foo + 3) // 'operator func +' with argument 3
@On(foo[0]) // 'operator func []' with argument 0
```

### Argument Matchers

Each stub signature must include **argument matchers** for all parameters. A single argument matcher defines a condition that accepts a subset of all possible argument values. Each matcher is defined by calling a static method of the `Matchers` class. For example, `Matchers.any()` is a valid matcher that allows any argument. For convenience, a syntax sugar omitting the `Matcher.` prefix is provided.

Predefined matchers include:

| Matcher | Description | Syntax Sugar |
| ------- | ----------- | ------------ |
| `any()` | Any argument | `_` symbol |
| `eq(value: Equatable)` | Argument with structural equality (object values are equal, not necessarily the same memory) | Single `identifier` and constant literals allowed |
| `same(reference: Object)` | Argument with referential equality (same object reference, same memory) | Single `identifier` allowed |
| `ofType<T>()` | Matches only values of type `T` | - |
| `argThat(predicate: (T) -> Bool)` | Matches only values of type `T` filtered by `predicate` | - |
| `none()` | Matches the `None` value of option types | - |

If a single identifier is used as an argument matcher, structural equality is prioritized.

If a method has default parameters and they are not explicitly specified, the `any()` matcher is used.

Example:

<!--compile.onlyformat-->
```cangjie
let p = mock<Printer>() // Assume print takes a single ToString-type parameter.

@On(p.print(_)) // The "_" special character can be used instead of any().

@On(p.print(eq("foo"))) // Only matches the "foo" argument.
@On(p.print("foo")) // Constant strings can omit explicit matchers.

let predefined = "foo" // A single identifier can be passed instead of an argument matcher.
@On(p.print(predefined)) // If types match, structural equality is used for matching.

@On(p.print(ofType<Bar>())) // Only matches arguments of type Bar.

// For more complex matchers, the following pattern is encouraged.
let hasQuestionMark = { arg: String => arg.contains("?") }
@On(p.print(argThat(hasQuestionMark))) // Only matches strings containing a question mark.
```

Correct function overload selection relies on Cangjie's type inference mechanism. `ofType` can be used to resolve compile-time issues related to type inference.
<!-- TODO: Add a section on stub overloading in the "Stub Usage Guide" -->

Important rule: Function calls used as **argument matchers** are treated as calls to the matcher.

```cangjie
@On(foo.bar(calculateArgument())) // Incorrect, calculateArgument() is not a matcher.

let expectedArgument = calculateArgument()
@On(foo.bar(expectedArgument)) // Correct, as long as 'expectedArgument' is equatable and/or a reference type.
```

### Operation API

The mock framework provides an API to specify stub operations. When a stub is triggered, the stubbed declaration executes the specified operation. A stub is triggered if the call matches the signature specified in the corresponding `@On` macro invocation.

Each stub function **must** specify an operation. The `ActionSelector` subtype returned by the `@On` macro invocation defines the available operations. The list of operations depends on the entity being stubbed.

<!-- Link to operation documentation -->

#### Generic (Operations)

Operations applicable to all stubs.

* `throws(exception: Exception)`: Throws `exception`.
* `throws(exceptionFactory: () -> Exception)`: Calls `exceptionFactory` to construct the exception thrown when the stub is triggered.
* `fails()`: Fails the test if the stub is triggered.

> **Note:**
>
> `throws` is used to test system behavior when stubbed declarations throw exceptions. `fails` is used to test whether stubbed declarations are not called.

<!--compile.onlyformat-->
```cangjie
@On(service.request()).throws(TimeoutException())
```

#### Functions and Property/Field Getters and Top-Level Variable Read Operations

**R** represents the return type of the corresponding member.

* `returns()`: Does nothing and returns `()`, available only when `R` is `Unit`.
* `returns(value: R)`: Returns `value`.
* `returns(valueFactory: () -> R)`: Calls `valueFactory` to construct the value returned when the stub is triggered.
* `returnsConsecutively(values: Array<R>)`, `returnsConsecutively(values: ArrayList<R>)`: Returns the next element in `values` when the stub is triggered.

```cangjie
@On(foo.bar()).returns(2) // Returns 0
@On(foo.bar()).returnsConsecutively(1, 2, 3) // Returns 1, 2, 3 in sequence
```

#### Property/Field Setters and Top-Level Variable Write Operations

* `doesNothing()`: Ignores the call and does nothing. Similar to `returns()` for functions returning Unit. For more details, see [here](./mock_framework_stubs.md#setting-properties-and-fields-and-top-level-variables).

#### Spy Operations

For spy objects, additional operations are available to delegate to the monitored instance.

* `callsOriginal()`: Calls the original method.
* `getsOriginal()`: Calls the original property getter or retrieves the field value from the original instance.
* `setsOriginal()`: Calls the original property setter or sets the field value in the original instance.

### Expectations

Expectations are implicitly or explicitly attached to stubs when they are defined. A stub **can** define an expected cardinality. **Operations** (except `fails` and `returnsConsecutively`) return an instance of `CardinalitySelector`, which can customize expectations using **cardinality specifiers**.

**CardinalitySelector** defines the following functions:

* `once()`
* `atLeastOnce()`
* `anyTimes()`
* `times(expectedTimes: Int64)`
* `times(min!: Int64, max!: Int64)`
* `atLeastTimes(minTimesExpected: Int64)`

The `anyTimes` specifier is used to relax expectations, meaning the test will not fail even if the stub is never triggered. Other specifiers imply upper and lower bounds for the number of times the stub is called in the test code. If the stub is triggered more times than expected, the test fails immediately. Lower bounds are checked after the test code execution completes.

Example:

<!--run -->
```cangjie
import std.unittest.mock.*
import std.unittest.mock.mockmacro.*

class Foo {
    func bar() { }
}

@Test
func tooFewInvocations() {
    let foo = mock<Foo>()
    @On(foo.bar()).returns().times(2)
    foo.bar()
}
```

Output:

```text
Expectation failed
    Too few invocations for stub foo.bar() declared at example_test.cj:9.
        Required: exactly 2 times
        Actual: 1
        Invocations handled by this stub occured at:
            example_test.cj:6
```

If no custom expectations are defined, the mock framework uses default expectations:

| Operation | Default Cardinality | Allows Custom Cardinality |
| --------- | ------------------- | ------------------------- |
| `fails` | Must not be called | No |
| `returns` | `atLeastOnce` | Yes |
| `returnsConsecutively` | `times(values.size)` | No |
| `throws` | `atLeastOnce` | Yes |
| `doesNothing` | `atLeastOnce` | Yes |
| `(calls/gets/sets)Original` | `atLeastOnce` | Yes |

### Stub Chaining

The **returnsConsecutively** operation and the **once** and **times(n)** cardinality specifiers return a **continuation** instance. As the name suggests, a **continuation** allows chaining, meaning a new operation can be specified to execute immediately after the previous operation completes.

<!-- Link to continuation -->

The **continuation** itself only provides a `then()` function that returns a new `ActionSelector`. All operations in the chain follow the same rules. If `then()` is called, a new operation **must** be specified.

The total expectation is the sum of the expectations for each part of the chain. If a complex chain is specified in a test, all parts of the chain must be triggered.

<!--compile.onlyformat-->
```cangjie
@On(foo.bar()).returnsConsecutively(1, 2, 3, 4)
// Equivalent to:
@On(foo.bar()).returnsConsecutively(1, 2).then().returnsConsecutively(3, 4)
```

```cangjie
// Specifies a stub that must be called NUM_OF_RETRIES times in total
@On(service.request()).throws(TimeoutException()).times(NUM_OF_RETRIES - 1). // Requests will time out a few times first
    then().returns(response).once() // After the first successful response, stop sending requests
```

## Using Spy and Mock Objects

**Spy** objects and **mock** objects are similar in configuration, except that spy objects monitor existing instances.

The main differences are: When a member call does not trigger any stub, a spy object calls the original implementation of the underlying instance, while a mock object throws a runtime error (and the test fails).

Mock objects eliminate the need to create real dependencies for testing APIs—only the behavior required for specific test scenarios needs to be configured.

Spy objects allow overriding the observable behavior of real instances. Only calls made through the spy object reference are intercepted. Creating a spy object does not affect references to the original spy instance. Calls to its own methods by the spy are not intercepted.

<!--compile.onlyformat-->
```cangjie
let serviceSpy = spy(service)
// Simulate a timeout, then continue using the real implementation
@On(serviceSpy.request()).throws(TimeoutException()).once().then().callsOriginal()
// Test code must use the 'serviceSpy' reference
```

> **Note:**
>
> Stubbing behavior for static members or top-level functions/variables is similar to spies—i.e., for unstubbed declarations, the original member or top-level function/variable is called, unlike mocks, which throw exceptions.

## Mock Dependencies

Interfaces can always be mocked. When mocking a class from another package, the class itself and its superclasses must be compiled in a specific way—i.e., only interfaces from precompiled libraries (e.g., **stdlib**) can be mocked, not classes.

### Compiling with cjc

For **cjc**, mocking is controlled by the `--mock` flag. To mock class `p` in a specific package, add the `--mock=on` flag to the cjc invocation.

> **Note:**
>
> This flag must also be added when compiling packages that depend on `p`.

No additional flags are required when using mock objects in tests (`cjc --test`).

### Compiling with cjpm

**cjpm** automatically detects mock usage and generates the correct **cjc** invocations, ensuring that classes can be mocked from any package compiled from source.

You can also use cjpm configuration files to control which packages support mocking.

<!-- TODO: Add a section on default mock behavior. -->

<!-- TODO: Add references to other documentation. -->