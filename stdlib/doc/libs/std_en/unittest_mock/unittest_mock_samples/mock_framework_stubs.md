# Stubbing Guide

Mock/spy objects and stubs can be used in various ways. This document introduces different patterns and use cases to help users write **maintainable and concise** test cases with the **mock framework**.

## How Stubbing Works

[Stubs](./mock_framework_basics.md#configuration-api) are declared by invoking the `@On` macro inside test cases, and remain valid until the specific test case execution completes. Multiple test cases can [share stubs](#sharing-mock-objects-and-stubs).

When the mock framework processes calls to mock/spy object members (or static members or top-level functions or top-level variables), it follows this order:

* Look for specifically declared stubs. Later-declared stubs take precedence over earlier ones. Stubs declared within the test case body take precedence over shared stubs.
* Apply each stub's **argument matchers**. If all arguments match successfully, execute the operation defined by the stub.
* If no stub is found, or no stub matches the actual arguments, apply default behavior:
  * For mock objects, report an **unstubbed call** error;
  * For spy objects, invoke the original member of the spied instance;
  * For static members or top-level functions or variables, invoke the original corresponding declaration.

Whether multiple stubs are defined for a single member or not, each stub has its own expectations that must be satisfied for the test to pass.

!--compile.onlyformat-->
```cangjie
@On(foo.bar(1)).returns(1)
@On(foo.bar(2)).returns(2)

foo.bar(2)
// The first stub is defined but never used, causing the test to fail
```

## Redefining Stubs

To change stub behavior during a test, you can redefine stubs.

<!--compile.onlyformat-->
```cangjie
@On(service.request()).returns(testData)
// Use the service

@On(service.request()).throws(Exception())
// Test what happens when the service starts failing
```

## Defining Multiple Stubs for the Same Declaration

Different behaviors can be defined for different parameters using multiple stubs.

Example:

<!--compile.onlyformat-->
```cangjie
@On(storage.get(_)).returns(None) // 1
@On(storage.get(TEST_ID)).returns(Some(TEST_DATA)) // 2
```

In this example, `storage` returns `None` for all parameters except `TEST_ID`.  
If `get` is never called with the `TEST_ID` parameter, the test fails because stub **2** is unused. If `get` is always called with the `TEST_ID` parameter, the test fails because stub **1** is unused. These constraints ensure test code remains clean, letting developers know when stubs become unused. If this functionality isn't needed, use the `anyTimes()` cardinality specifier to relax these expectations.

<!--compile.onlyformat-->
```cangjie
// The implementation changes frequently, but tests shouldn't break
// Use anyTimes to relax expectations unrelated to the test itself
@On(storage.get(_)).returns(None).anyTimes()
@On(storage.get(TEST_ID)).returns(Some(TEST_DATA)) // The test must call what's being tested
```

Since stub priority is **bottom-up**, the following usage is incorrect.

<!--compile.onlyformat-->
```cangjie
@On(storage.get(TEST_ID)).returns(Some(TEST_DATA)) // Incorrect: this stub will never trigger
@On(storage.get(_)).returns(None) // The above stub will always be shadowed
```

You can also use expectations to check call arguments.

<!--compile.onlyformat-->
```cangjie
let renderer = spy(Renderer())

@On(renderer.render(_)).fails()
let isVisible = { c: Component => c.isVisible }
@On(renderer.render(argThat(isVisible))).callsOriginal() // Only allow visible components
```

## Sharing Mock Objects and Stubs

When tests require extensive use of mock objects, mock objects and/or stubs can be shared across multiple test cases.  
Mock or spy objects can be created anywhere. However, leaking mock objects from one test case to another may cause order-dependent issues or test instability. Thus, this is not recommended, and the mock framework detects such scenarios.  
To share mock or spy objects between test cases within the same test class, place them in the class's instance variables.

Stub declarations implicitly include expectations, making shared stubs harder to handle. Expectations cannot be shared between test cases.  
Places where stubs can be declared:

* Test case body (whether in `@Test` functions or `@TestCase` within `@Test` classes): Expectations are checked.
* In `@BeforeAll` macro-decorated functions or `beforeAll` functions in `@Test` classes: Stubs are shared between test cases. Such stubs cannot declare expectations, and expectations are not checked. Cardinality specifiers are not allowed. Only *stateless* operations like `returns(value)`, `throws(exception)`, `fails()`, `callsOriginal()` are permitted. These stubs can be considered to have an implicit `anyTimes()` cardinality.
* If test cases share the same expectations, extract and call functions (non-test-case member functions in the test class) within the test case body.

> **Note:**
>
> Do not declare stubs in test class constructors. This may cause internal errors in the framework.

Example of declaring stubs in a test case body (`@TestCase` within a `@Test` class):

<!--compile-testBar0-->
```cangjie
import std.unittest.mock.*
import std.unittest.mock.mockmacro.*

class Foo {
    public func bar(x: Int64): String {
        match (x) {
            case 0 => "zero"
            case 1 => "one"
            case _ => "default"
        }
    }
}

@Test
class TestFoo {
    let foo = mock<Foo>()

    func setupDefaultStubs() {
        @On(foo.bar(_)).returns("default")
    }

    @TestCase
    func testZero() {
        setupDefaultStubs()
        @On(foo.bar(0)).returns("zero")

        foo.bar(0) // Returns "zero"
        foo.bar(1) // Returns "default"
    }

    @TestCase
    func testOne() {
        setupDefaultStubs()
        @On(foo.bar(0)).returns("zero")
        foo.bar(0) // Returns "zero"

        // Expectation fails: stub declared but never used
    }
}
```

Example of using `beforeAll` in a `@Test` class:

<!--compile-testBar1-->
```cangjie
import std.unittest.mock.*
import std.unittest.mock.mockmacro.*

@Test
class TestFoo2 {
    let foo = mock<Foo>()

    // The unit test framework calls the following before executing test cases
    @BeforeAll
    public func beforeAll(): Unit {
        // Share default behavior across all test cases
        // This stub doesn't need to be used in every test case
        @On(foo.bar(_)).returns("default")
    }

    @TestCase
    func testZero() {
        @On(foo.bar(0)).returns("zero") // This stub is needed for this test case
        foo.bar(0) // Returns "zero"
        foo.bar(1) // Returns "default"
    }

    @TestCase
    func testOne() {
        @On(foo.bar(0)).returns("one")
        foo.bar(0) // Returns "one"
    }
}
```

## Capturing Arguments
<!-- Link to ValueListener API (auto-generated API docs) -->

The mock framework uses the `captor(ValueListener)` argument matcher to **capture** arguments for inspecting actual arguments passed to stub declarations. Whenever a stub is triggered, the `ValueListener` intercepts the corresponding arguments to inspect them and/or add verification.

For each call, you can also use the `ValueListener.onEach` static function to verify a condition. After accepting a lambda, this lambda is invoked whenever the stub is triggered. The lambda receives the argument's value.

<!--compile.onlyformat-->
```cangjie
let renderer = spy(TextRenderer())
let markUpRenderer = MarkupRenderer(renderer)

// Create a validator
let validator = ValueListener.onEach {
    str: String => @Assert(str == "must be bold")
}

// Use the 'capture' argument matcher to bind arguments to the validator
@On(renderer.renderBold(capture(validator))).callsOriginal() // Test fails if never called

markUpRenderer.render("text inside tag <b>must be bold</b>")
```

Additionally, `ValueListener` provides `allValues()` and `lastValue()` functions to inspect arguments. Pattern:

<!--compile.onlyformat-->
```cangjie
// Create a captor
let captor = ValueListener<String>.new()

// Use the 'capture' argument matcher to bind arguments to the captor
@On(renderer.renderBold(capture(captor))).callsOriginal()

markUpRenderer.render("text inside tag <b>must be bold</b>")

let argumentValues = captor.allValues()
@Assert(argumentValues.size == 1 && argumentValues[0] == "must be bold")
```

The `argThat` matcher is an overloaded function combining argument filtering and capturing. `argThat(listener, filter)` accepts a `ValueListener` instance and a `filter` predicate. The `listener` only collects arguments that pass the `filter` check.

<!-- Link to argThat matcher (auto-generated API docs) -->

<!--compile.onlyformat-->
```cangjie
let filter = { arg: String => arg.contains("bold") }
let captor = ValueListener<String>.new()

// Fails unless arguments are intercepted, but a stub is declared below
@On(renderer.renderBold(_)).fails()
// Only collect strings containing "bold"
@On(renderer.renderBold(argThat(captor, filter))).callsOriginal()

markUpRenderer.render("text inside tag <b>must be bold</b>")

// Use the 'captor' object to inspect all filtered arguments
@Assert(captor.lastValue() == "must be bold")
```

Argument captors can be used with both mock and spy objects. However, such argument matchers are not allowed in the [@Called](./mock_framework_verification.md#verification-statements-and-called-macro) macro.

<!-- Link to @Called macro and verification API (auto-generated API docs) -->

## Customizing and Using Argument Matchers

To avoid repeating the same **argument matchers**, you can customize them.

Example of sharing matchers between test cases:

<!--compile.onlyformat-->
```cangjie
@On(foo.bar(oddNumbers())).returns("Odd")
@On(foo.bar(evenNumbers())).returns("Even")
foo.bar(0) // "Even"
foo.bar(1) // "Odd"
```

Since each matcher is just a static function of the `Matchers` class, you can use **extensions** to customize argument matchers. New argument matchers must invoke existing ones (instances).

<!-- Link to Matchers class (auto-generated API docs) -->
<!--compile-->
```cangjie
import std.unittest.mock.*

extend Matchers {
    static func evenNumbers(): TypedMatcher<Int> {
        argThat {arg: Int => arg % 2 == 0}
    }

    static func oddNumbers(): TypedMatcher<Int> {
        argThat {arg: Int => arg % 2 == 1}
    }
}
```

Function argument matchers can include parameters.
<!--compile-->
```cangjie
import std.unittest.mock.*

extend Matchers {
    // Only accepts Int arguments.
    static func isDivisibleBy(n: Int): TypedMatcher<Int> {
        argThat {arg: Int => arg % n == 0}
    }
}
```

Most matcher functions specify a return type of `TypedMatcher<T>`. Such matchers only accept values of type `T`. When using argument matchers in stub declarations, values of type `T` should be valid arguments for the stubbed function or property setter. In other words, type `T` should be a subtype of the parameter or match the parameter's actual type.

## Stubbing Properties, Fields, and Top-Level Variables

Fields, properties, and top-level variables are stubbed similarly to functions, and can be configured to return values using the [same operations](./mock_framework_basics.md#operations-api).

Setters resemble functions returning `Unit`. The special operation `doesNothing()` can be used for setters.

A common pattern for stubbing mutable properties:

```cangjie
@On(foo.prop).returns("value")  // Configure getter
@On(foo.prop = _).doesNothing() // Ignore setter calls
```
In rare scenarios, we may want mutable properties to behave identically to fields. To create a **synthetic field** (a framework-generated field), use the `SyntheticField.create` static function. Synthetic fields are managed by the mock framework's storage. This is particularly useful when mocking interfaces or abstract classes containing mutable properties and fields.

<!-- Link to SyntheticField class (auto-generated API documentation) -->

Executing `getsField` and `setsField` stubbing operations binds fields or top-level variables to specific invocations, allowing these operations to be configured with expectations like any other operation.

<!-- TODO: Link to field operations -->

<!--compile-->
```cangjie
import std.unittest.mock.*
import std.unittest.mock.mockmacro.*

interface Foo {
    mut prop bar: String
}

@Test
func test() {
    let foo = mock<Foo>()
    let syntheticField = SyntheticField.create(initialValue: "initial")
    @On(foo.bar).getsField(syntheticField) // Reading the property now accesses the synthetic field
    @On(foo.bar = _).setsField(syntheticField) // Assigning a new value to the property

    // The 'bar' property now behaves as a field
}
```

> **Note:**
>
> If a `SyntheticField` object is shared across multiple test cases, its value will be reset to `initialValue` before each test case to prevent mutable state leakage between tests.

## Stubbing Modes

Normally, unmatched invocations throw exceptions. However, for common cases, mock objects can be configured with default behaviors that execute when no stubs match. This is achieved by enabling **stubbing modes**.

Two modes are available: `ReturnsDefaults` and `SyntheticFields`. These modes are represented by the `StubMode` enum. Stubbing modes can be enabled for specific mock objects by passing them to the `mock` function during creation.

```cangjie
public func mock<T>(modes: Array<StubMode>): T
```

Stubbing modes reduce boilerplate code when configuring mock objects and can be freely combined with explicit stubs. Explicit stubs always take precedence over default behaviors.

> **Note:**
>
> Enabling stubbing modes does not impose expectations on mock object members.  
> Use caution when testing whether only specific members of a mock object are invoked. The behavior of the system under test may change unexpectedly while tests still pass.  
> Current stubbing modes do not support stubbing static members or top-level functions/variables.

### ReturnsDefaults Mode

In this mode, members with return types listed in the following table can be invoked without explicit stubbing.

<!--compile.onlyformat-->
```cangjie
let foo = mock<Foo>(ReturnsDefaults)
@Assert(foo.isPretty(), false)
```

Default return values for supported types are shown below:

| Type | Default Value |
| ---  | --- |
| Bool | false |
| Numbers | 0 |
| String | empty string |
| Option | None |
| ArrayList, HashSet, Array | new empty collection |
| HashMap | new empty map |

`ReturnsDefaults` mode only applies to:

* Member functions returning supported types (as per the table above).
* Property getters and fields of supported types (as per the table above).

### SyntheticFields Mode

The `SyntheticFields` mode simplifies `SyntheticField` configuration. For details, see the [Configuring Properties, Fields, and Top-Level Variables](#configuring-properties-fields-and-top-level-variables) section.

`SyntheticFields` automatically creates type-appropriate synthetic fields for all properties and fields via the mock framework. However, these fields can only be read after being assigned. Only mutable properties and fields are affected.

<!--compile.onlyformat-->
```cangjie
let foo = mock<Foo>(SyntheticFields)
// can simply assign a value to a mutable property
foo.bar = "Hello"
@Assert(foo.bar, "Hello")
```

Values assigned to properties and fields are only visible within their respective test cases.

When both `SyntheticFields` and `ReturnsDefaults` are enabled, assigned values take precedence over defaults. However, default values remain available until a field or property is assigned.

<!--compile.onlyformat-->
```cangjie
let foo = mock<Foo>(ReturnsDefaults, SyntheticFields)
@Assert(foo.bar, "")
foo.bar = "Hello"
@Assert(foo.bar, "Hello")
```