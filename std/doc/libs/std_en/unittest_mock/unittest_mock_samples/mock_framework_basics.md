# Mock Basic Concepts and Usage

## Creating Mock Objects

The **mock constructor** can create two types of objects by calling the `mock<T>` and `spy<T>` functions: **mock** and **spy**, where `T` represents the class or interface being mocked.

```cangjie
public func mock<T>(): T
public func spy<T>(objectToSpyOn: T): T
```

<!-- Link to mock/spy constructor -->

A **mock** serves as a skeleton object that performs no operations on members by default.

A **spy** is a special type of mock object used to wrap an existing instance of a class or interface. By default, a spy object delegates member calls to the underlying object. In other aspects, spy and mock objects are very similar.

Only **classes** (including final and sealed classes) and **interfaces** can be mocked this way.

Refer to [Using Mock and Spy Objects](#using-spy-and-mock-objects).

Refer to [Top-Level and Static Declarations](#top-level-and-static-declarations) for information on mocking top-level and static declarations.

## Configuration API

The **Configuration API** is the core of the framework, allowing you to define the behavior of mock/spy object members (or top-level/static declarations) (or redefine spy objects (or top-level/static declarations)).

The entry point for the **Configuration API** is the `@On` macro call.

<!--compile.onlyformat-->
```cangjie
@On(storage.getComments(testId)).returns(testComments)
```

In this example, if the mock object `storage` *receives* a call to the `getComments` method with the specified parameter `testId`, it returns `testComment`.

This behavior is known as **stubbing**, where stubs (simulating components that are not yet implemented or cannot be executed in the test environment) must be defined within the test case body before execution.

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

1. The **stub signature** described in the `@On` macro call.
2. The [operation](#operation-api) used to describe the stub behavior.
3. (Optional) A cardinality specifier (an expression specifying the expected number of executions) for setting [expectations](#expectations).
4. (Optional) A [continuation](#stub-chaining) (an expression supporting chained calls).

The mock framework intercepts calls matching the stub signature and executes the operations specified in the stub declaration.

### Top-Level and Static Declarations

Unlike members of classes or interfaces, when stubbing static members or top-level functions or variables, there is no need to create mock objects. These declarations should be stubbed directly using the Configuration API (e.g., the `@On` macro).

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

* A reference to the mock/spy object, which must be a single identifier. (Standalone declarations (top-level or static functions, variables) do not require this part.)
* The member or standalone declaration call.
* A specific format for parameter calls, as described in [Argument Matchers](#argument-matchers).

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

When the corresponding declaration is called and all parameters (if any) match the respective argument matchers, the stub signature matches the call.

The structure of a method stub signature: `<mock object name>.<method name>(<argument matcher>*)`.

<!--compile.onlyformat-->
```cangjie
@On(foo.method(0, 1)) // Method call with parameters 0 and 1
@On(foo.method(param1: 0, param2: 1)) // Method call with named parameters
```

When stubbing property getters/setters or field read/write operations, use `<mock object name>.<property or field name>` or `<mock object name>.<property or field name> = <argument matcher>`.

<!--compile.onlyformat-->
```cangjie
@On(foo.prop) // Property getter
@On(foo.prop = 3) // Property setter with parameter 3
```

For top-level and static functions, the signature is similar:

* Top-level function: `<function name>(<argument matcher>*)`
* Static function: `<class name>.<static method name>(<argument matcher>*)`

The signatures for top-level variables and static properties or fields are as follows:

* Top-level variable: `<top-level variable name>` or `<top-level variable name> = <argument matcher>`
* Static property or field: `<class name>.<static property/field name>` or `<class name>.<static property/field name> = <argument matcher>`

When stubbing operator functions, the operator's receiver must be a single reference to the mock/spy object, and the operator's arguments must be argument matchers.

<!--compile.onlyformat-->
```cangjie
@On(foo + 3) // 'operator func +' with parameter 3
@On(foo[0]) // 'operator func []' with parameter 0
```

### Argument Matchers

Each stub signature must include **argument matchers** for all parameters. A single argument matcher defines a condition that accepts a subset of all possible parameter values. Each matcher is defined by calling a static method of the `Matchers` class. For example, `Matchers.any()` is a valid matcher that allows any parameter. For convenience, a syntax sugar omitting the `Matcher.` prefix is provided.

Predefined matchers include:

| Matcher | Description | Syntax Sugar |
| ------- | ----------- | ------------ |
| `any()` | Any parameter | `_` symbol |
| `eq(value: Equatable)` | Parameter with structural equality (`value`) (objects are equal in value, not necessarily in memory) | Single `identifier` and constant literals allowed |
| `same(reference: Object)` | Parameter with referential equality (`reference`) (objects are equal in memory) | Single `identifier` allowed |
| `ofType<T>()` | Only matches values of type `T` | - |
| `argThat(predicate: (T) -> Bool)` | Only matches values of type `T` filtered by `predicate` | - |
| `none()` | Matches the `None` value of an option type | - |

If a single identifier is used as an argument matcher, structural equality is prioritized for parameters.

If a method has default parameters and they are not explicitly specified, the `any()` matcher is used.

Example:

<!--compile.onlyformat-->
```cangjie
let p = mock<Printer>() // Assume print takes a single parameter of type ToString.

@On(p.print(_)) // The "_" special character can be used instead of any().

@On(p.print(eq("foo"))) // Only matches the "foo" parameter.
@On(p.print("foo")) // Constant strings can omit explicit matchers.

let predefined = "foo" // A single identifier can be passed instead of an argument matcher.
@On(p.print(predefined)) // If the types are equal, structural equality is used for matching.

@On(p.print(ofType<Bar>())) // Only matches parameters of type Bar.

// For more complex matchers, the following pattern is encouraged.
let hasQuestionMark = { arg: String => arg.contains("?") }
@On(p.print(argThat(hasQuestionMark))) // Only matches strings containing a question mark.
```

Correct function overload selection relies on the Cangjie type inference mechanism. `ofType` can be used to resolve compile-time issues related to type inference.
<!-- TODO: Add a section on stub overloading in the "Stub Usage Guide" -->

Important rule: Function calls used as **argument matchers** are treated as calls to matchers.

```cangjie
@On(foo.bar(calculateArgument())) // Incorrect, calculateArgument() is not a matcher.

let expectedArgument = calculateArgument()
@On(foo.bar(expectedArgument)) // Correct, as long as 'expectedArgument' is equatable and/or a reference type.
```

### Operation API

The mock framework provides an API to specify stub operations. When a stub is triggered, the stubbed declaration executes the specified operation. If a call matches the signature specified in the corresponding `@On` macro call, the stub is triggered.

Each stub function **must** specify an operation.
The `ActionSelector` subtype returned by the `@On` macro call defines the available operations. The list of operations depends on the entity being stubbed.

<!-- Link to operation documentation -->

#### General (Operations)

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

* `returns()`: Performs no operation and returns `()`, only available when `R` is `Unit`.
* `returns(value: R)`: Returns `value`.
* `returns(valueFactory: () -> R)`: Calls `valueFactory` to construct the exception thrown when the stub is triggered.
* `returnsConsecutively(values: Array<R>)`, `returnsConsecutively(values: ArrayList<R>)`: Returns the next element in `values` when the stub is triggered.

```cangjie
@On(foo.bar()).returns(2) // Returns 0
@On(foo.bar()).returnsConsecutively(1, 2, 3) // Returns 1, 2, 3 in sequence
```

#### Property/Field Setters and Top-Level Variable Write Operations

* `doesNothing()`: Ignores the call and performs no operation. Similar to `returns()` for functions returning `Unit`.
For more information, see [here](./mock_framework_stubs.md#setting-properties-and-fields-and-top-level-variables).

#### Spy Operations

For spy objects, additional operations can be used to delegate to the monitored instance.

* `callsOriginal()`: Calls the original method.
* `getsOriginal()`: Calls the original property getter or retrieves the field value from the original instance.
* `setsOriginal()`: Calls the original property setter or sets the field value in the original instance.

### Expectations

When defining a stub, expectations are implicitly or explicitly attached to it. A stub **can** define expected cardinality. **Operations** (except `fails` and `returnsConcesecutively`) return an instance of `CardinalitySelector`, which can be customized with **cardinality specifiers**.

**CardinalitySelector** defines the following functions:

* `once()`
* `atLeastOnce()`
* `anyTimes()`
* `times(expectedTimes: Int64)`
* `times(min!: Int64, max!: Int64)`
* `atLeastTimes(minTimesExpected: Int64)`

The `anyTimes` specifier is used to relax expectations, meaning the test will not fail even if the stub is never triggered. Other specifiers imply upper and lower limits on the number of times a specific stub is called in the test code. If the stub is triggered more times than expected, the test fails immediately. The lower limit is checked after the test code execution completes.

Example:

<!--run -->
```cangjie
import std.unittest.mock.*
import std.unittest.mock.mockmacro.*

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
        Invocations handled by this stub occurred at:
            example_test.cj:6
```

If no custom expectations are defined, the mock framework uses default expectations:

| Operation | Default Expectation Cardinality | Allows Custom Cardinality |
| ----      | ---                            | ---                      |
| fails    | Not invocable                  | No                       |
| returns  | atLeastOnce                   | Yes                      |
| returnsConsecutively | times(values.size) | No          |
| throws   | atLeastOnce                   | Yes                      |
| doesNothing | atLeastOnce               | Yes                  |
| (calls/gets/sets)Original | atLeastOnce | Yes    |

### Stub Chaining

The **returnsConsecutively** operation, along with **once** and **times(n)** cardinality specifiers, returns a **continuation** instance. As the name suggests, a **continuation** indicates that chaining can proceed, meaning a specified operation will execute immediately after the previous one fully completes.

<!-- Link to continuation -->

The **continuation** itself only provides a `then()` function that returns a new `ActionSelector`. All operations in the chain follow the same rules. If `then()` is called, a new operation **must** be specified.

The total expectation is the sum of all individual chain expectations. If a complex chain is specified in a test, all parts of the chain will be triggered.

<!--compile.onlyformat-->
```cangjie
@On(foo.bar()).returnsConsecutively(1, 2, 3, 4)
// Equivalent to:
@On(foo.bar()).returnsConsecutively(1, 2).then().returnsConsecutively(3, 4)
```

```cangjie
// Specifies a stub that must be invoked exactly NUM_OF_RETRIES times in total
@On(service.request()).throws(TimeoutException()).times(NUM_OF_RETRIES - 1). // Requests will timeout several times first
    then().returns(response).once() // After the first successful response, stop sending requests
```

## Using Spy and Mock Objects

**Spy** objects and **mock** objects are similar in configuration, except that spy objects monitor the current instance.

The main differences are: When a member invocation doesn't trigger any stub, a spy object calls the original implementation of the underlying instance, while a mock object throws a runtime error (and the test fails).

Mock objects eliminate the need to create real dependencies for API testing, requiring only the configuration of behaviors specific to the test scenario.

Spy objects support overriding the observable behavior of real instances. Only invocations made through the spy object reference are intercepted. Creating a spy object has no impact on references to the original spied instance. Spy objects calling their own methods are not intercepted.

<!--compile.onlyformat-->
```cangjie
let serviceSpy = spy(service)
// Simulate timeout, then continue using the real implementation
@On(serviceSpy.request()).throws(TimeoutException()).once().then().callsOriginal()
// Test code must use the 'serviceSpy' reference
```

> **Note:**
>
> Stubbing behavior for static members or top-level functions/variables resembles that of spies, meaning unstubbed declarations will call the original member or top-level function/variable, rather than throwing an exception as with mocks.

## Mocking Dependencies

Interfaces can always be mocked. When mocking a class from another package, the class itself and its superclasses must be compiled in a specific way,
meaning only interfaces from precompiled libraries (e.g., **stdlib**) can be mocked, not classes.

### Compiling with cjc

For **cjc**, mocking is controlled via the `--mock` flag.
To mock classes in a specific package `p`, add the `--mock=on` flag to the cjc invocation.

> **Note:**
>
> This flag must also be added when compiling packages that depend on `p`.

No additional flags are needed when using mock objects in tests (`cjc --test`).

### Compiling with cjpm

**cjpm** automatically detects mock usage and generates the correct **cjc** invocations, ensuring classes can be mocked from any package compiled from source.

cjpm configuration files can also control which packages support mocking.

<!-- TODO: Add section about default mocking behavior. -->

<!-- TODO: Add references to other documentation. -->