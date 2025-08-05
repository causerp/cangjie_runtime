# Mock Framework Verification API

The Verification API is part of the mock framework, providing the following functionalities:

* Verify whether certain calls were made.
* Verify the number of specific calls.
* Verify whether calls were made with specific parameters.
* Verify whether calls were made in a specific order.

Verification operates by examining the invocation log built during test execution to run assertions. The invocation log covers all calls made accessible to **mock** and **spy** objects (including static members, top-level functions, and top-level variables) during testing. Only calls made on mock/spy objects (including static members, top-level functions, and top-level variables) can be verified.

The `Verify` class serves as the entry point to the Verification API.  
The **@Called** macro is used to construct assertions about the code.

<!-- Link to the Verify class introduction in the Verification API manual (auto-generated) -->

An **@Called** macro invocation constructs a **verification statement**, which is a single assertion checked against the invocation log.

The **Verify** class itself is a collection of static methods. Methods such as `that`, `ordered`, and `unordered` construct **verification blocks**.

## Example

<!--compile.onlyformat-->
```cangjie
let foo = mock<Foo>()
// Configure foo
@On(foo.bar()).returns()
foo.bar()
Verify.that(@Called(foo.bar())) // Verify bar was called at least once
```

## Verification Statements and the `@Called` Macro

A verification statement is represented by the `VerifyStatement` class. Instances of `VerifyStatement` are created by the `@Called` macro.

The `@Called` macro invocation accepts a [stub signature](./mock_framework_basics.md#stub-signature), similar to the `@On` macro, and follows the rules for [argument matchers](./mock_framework_basics.md#argument-matchers).

Examples:

<!--compile.onlyformat-->
```cangjie
@Called(foo.bar(1, _)) // Verification statement matching bar method calls where the first argument is '1'
@Called(Foo.baz)       // Verification statement matching baz static property getter calls
```

The `VerifyStatement` class provides an API similar to the cardinality specifiers available during stub configuration.

Cardinality functions include:

* `once()`
* `atLeastOnce()`
* `times(expectedTimes: Int64)`
* `times(min!: Int64, max!: Int64)`
* `atLeastTimes(minTimesExpected: Int64)`
* `never()`

Calling these functions returns the same `VerifyStatement` instance. A statement's cardinality cannot be reset, and it must be set before the statement is passed to a verification block generator function. If no cardinality is explicitly set, the default cardinality is used.

<!--compile.onlyformat-->
```cangjie
Verify.that(@Called(foo.bar()).atLeastOnce())
Verify.that(@Called(foo.bar()).once())
```

## Verification Blocks

A verification block typically contains one or more verification statements and checks that the statements in the block form more complex assertions.

Verification occurs immediately when a verification block is invoked; any subsequent calls are not verified.

Verification blocks do not alter the state of the invocation log: each call in the log can be checked by any number of blocks. Blocks are checked independently, with no dependencies between them. The order in which verification blocks are checked is irrelevant unless calls occur between blocks or the invocation log is manually cleared.

Verification statements themselves do not perform any verification; they must be passed into verification blocks to be checked.

A single verification block only checks calls made on the mock/spy objects mentioned in its verification statements, ignoring calls to other objects.

The `Verify` class includes several static methods for constructing verification blocks. **Ordered** verification blocks check the exact order of calls. **Unordered** verification blocks only verify the number of calls.

### Ordered

To check the order of calls on one or more objects, use the `ordered` verification block generator.

The `ordered` static function accepts an array of verification statements.

<!--compile.onlyformat-->
```cangjie
for (i in 0..4) {
    foo.bar(i % 2)
}

Verify.ordered(
    @Called(foo.bar(0)),
    @Called(foo.bar(1)),
    @Called(foo.bar(0)),
    @Called(foo.bar(1))
)
```

Checking the call order across multiple objects is allowed.

<!--compile.onlyformat-->
```cangjie
for (i in 0..4) {
    if (i % 2 == 0) {
        fooEven.bar(i)
    } else {
        forOdd.bar(i)
    }
}

Verify.ordered(
    @Called(fooEven.bar(0)),
    @Called(fooOdd.bar(1)),
    @Called(fooEven.bar(2)),
    @Called(fooOdd.bar(3)),
)
```

The default cardinality specifier for **ordered** verification is `once()`. Other cardinality specifiers can be used if needed.

<!--compile.onlyformat-->
```cangjie
for (i in 0..4) {
    foo1.bar(i)
}

for (i in 0..4) {
    foo2.bar(i)
}

Verify.ordered(
    @Called(foo1.bar(_).times(4)),
    @Called(foo2.bar(_).times(4))
)
```

For **ordered** verification, all calls made on the mock/spy objects mentioned in the block must be listed. Any unlisted calls will cause verification to fail.

<!--compile.onlyformat-->
```cangjie
foo.bar(0)
foo.bar(10)
foo.bar(1000)

Verify.ordered(
    @Called(foo.bar(0)),
    @Called(foo.bar(10))
)
```

Output:

```text
Verification failed
    The following calls did not match any statements:
        foo.bar(...) at example_test.cj:6
```

### Unordered

Unordered verification only checks the number of calls specified in its verification statements.

For **unordered** verification, the default cardinality is `atLeastOnce()`, meaning it checks that calls were made at least once unless explicitly specified otherwise.

<!--compile.onlyformat-->
```cangjie
for (i in 0..4) {
    foo.bar(i % 2)
}

// Verify that bar was called at least once with arguments 0 and 1
Verify.unordered(
    @Called(foo.bar(0)),
    @Called(foo.bar(1))
)

// Verify that bar was called twice with arguments 0 and 1
Verify.unordered(
    @Called(foo.bar(0)).times(2),
    @Called(foo.bar(1)).times(2)
)

// Verify that bar was called four times in total
Verify.unordered(@Called(foo.bar(_)).times(4))
```

**Unordered** verification includes **Partial** and **Exhaustive** modes.

By default, **Exhaustive** mode is used, requiring all calls on the mock/spy objects mentioned in the verification statements to be listed.  
**Partial** mode only lists **some** of the calls.

<!--compile.onlyformat-->
```cangjie
for (i in 0..4) {
    foo.bar(i)
}

// Fails because two foo.bar() calls are not listed in the block
Verify.unordered(
    @Called(foo.bar(0)).once(),
    @Called(foo.bar(1)).once()
)

// Ignores irrelevant calls
Verify.unordered(
    Partial,
    @Called(foo.bar(0)).once(),
    @Called(foo.bar(1)).once()
)
```

### Dynamically Constructing Verification Blocks

The `ordered` and `unordered` functions are overloaded to accept lambdas. The `checkThat(statement: VerifyStatement)` function can be used to dynamically add statements.

Example:

<!--compile.onlyformat-->
```cangjie
let totalTimes = 40
for (i in 0..totalTimes) {
    foo.bar(i % 2)
}

Verify.ordered {
    v => for (j in 0..totalTimes) {
        v.checkThat(@Called(foo.bar(eq(j % 2))))
    }
}
```

## Additional APIs

Additionally, the `Verify` class provides the following utilities:

* `that(statement: VerifyStatement)` is an alias for `Verify.unordered(Partial, statement)`, used to check a single statement without requiring all calls on the corresponding mock/spy objects to be listed.
* `noInteractions(mocks: Array<Object>)` checks that no calls were made on the specified mock/spy objects.
* `clearInvocationLog()` resets the log to an empty state. This affects all subsequent verification blocks but does not affect stub expectations.

Example:

<!--compile.onlyformat-->
```cangjie
foo.bar()
Verify.that(@Called(foo.bar())) // OK
Verify.noInteractions(foo)      // Fails because foo.bar() is in the log
Verify.clearInvocationLog()     // Clears the log
Verify.noInteractions(foo)      // All interactions with foo are cleared from the log
Verify.that(@Called(foo.bar())) // Fails
```

## `Verify` Class API

<!--compile.onlyformat-->
```cangjie
public class Verify {
    public static func that(statement: VerifyStatement): Unit

    public static func unordered(
        exhaustive: Exhaustiveness,
        collectStatements: (UnorderedVerifier) -> Unit
    ): Unit

    public static func unordered(
        collectStatements: (UnorderedVerifier) -> Unit
    ): Unit

    public static func unordered(statements: Array<VerifyStatement>): Unit

    public static func unordered(
        exhaustive: Exhaustiveness,
        statements: Array<VerifyStatement>
    ): Unit

    public static func ordered(
        collectStatements: (OrderedVerifier) -> Unit
    ): Unit

    public static func ordered(statements: Array<VerifyStatement>): Unit

    public static func clearInvocationLog(): Unit

    public static func noInteractions(mocks: Array<Object>): Unit
}
```

## Verification Errors

When verification fails, a `VerificationFailedException` is thrown, and the mock framework provides a report. Do not catch this exception.

Failure types include:

* **Too few calls** or **Too many calls**: The number of calls does not match the statements in the block.
* **Statement mismatch**: A statement in the block does not match any calls in the log.
* **Call mismatch**: A call in the log does not match any statements in the block.
* **Unexpected call**: The **ordered** verification block expected a different call.
* **Unnecessary interaction**: **noInteractions** detected unexpected calls.

Another failure type, **Disjoint statements**, does not necessarily indicate an issue with the test code itself. This error occurs when a call matches multiple statements. Using statements with overlapping argument matchers in a single verification block may cause this error. Ambiguous matching between statements and calls is not allowed.## Examples and Patterns

A common pattern when using the verification API is to validate interactions between the test code (whether it's a function, class, or entire package) and external objects.  
As shown below:

* Create **spy** objects.
* Pass these spy objects to the test code.
* Verify the interactions between the code and spy objects.

### Verifying Call Counts

<!--compile.onlyformat-->
```cangjie
import std.unittest.mock.*
import std.unittest.mock.mockmacro.*

func testDataCaching() {
    // Create necessary spy or mock objects
    let uncachedRepo = spy(Repository())
    let invalidationTracker = mock<InvalidationTracker>()
    @On(invalidationTracker.getTimestamp()).returns(0)

    // Prepare test data
    let cachedRepo = CachedRepistory(uncachedRepo, invalidationTracker)

    // Execute test code
    for (i in 0..10) {
        cachedRepo.get(TEST_ID)
    }

    // Verify that the base repo was queried only once, with no additional calls to the uncached repo
    Verify.unordered(
        Exhaustive,
        @Called(uncachedRepo.get(TEST_ID)).once()
    )

    // Clear the log
    Verify.clearInvocationLog()

    // Set other behaviors
    @On(invalidationTracker.getTimestamp()).returns(1)

    for (i in 0..10) {
        cachedRepo.get(TEST_ID)
    }

    // Only one call was made since the last clearance
    Verify.unordered(
        Exhaustive,
        @Called(uncachedRepo.get(TEST_ID)).once()
    )
}
```

### Verifying Calls with Specific Parameters

<!--compile.onlyformat-->
```cangjie
import std.unittest.mock.*
import std.unittest.mock.mockmacro.*

func testDrawingTriangle() {
    // Create necessary spy or mock objects
    let canvas = spy(Canvas())

    // Execute code
    canvas.draw(Triangle())

    // Test that the triangle consists of 3 lines and 3 points

    // Using 'that' block
    Verify.that(@Called(canvas.draw(ofType<Dot>())).times(3))
    Verify.that(@Called(canvas.draw(ofType<Line>())).times(3))

    // Or using a partially unordered verification block

    Verify.unordered(
        Partial, // The actual order of drawing lines and points is unknown
        @Called(canvas.draw(ofType<Dot>())).times(3),
        @Called(canvas.draw(ofType<Line>())).times(3)
    )

    // When using an exhaustive block, all calls must be enumerated
    Verify.unordered(
        Exhaustive,
        @Called(canvas.draw(ofType<Triangle>())).once(),
        @Called(canvas.draw(ofType<Dot>())).times(3),
        @Called(canvas.draw(ofType<Line>())).times(3)
    )

    // Verify that the draw function was never called with Square as a parameter
    Verify.that(@Called(canvas.draw(ofType<Square>)).never())

    // To distinguish parameters using more complex conditions
    // the following pattern can be used
    let isDot = {
        f: Figure => f is Dot // This represents more complex logic
    }

    Verify.that(@Called(canvas.draw(argThat(isDot))).times(3))

    // Note: Statements within the same block must explicitly match only one call
    // The following is a counterexample where some calls match two statements
    Verify.unordered(
        @Called(canvas.draw(_)).times(7),
        @Called(canvas.draw(ofType<Dot>())).times(3)
    )
}
```

### Verifying Call Order

<!--compile.onlyformat-->
```cangjie
import std.unittest.mock.*
import std.unittest.mock.mockmacro.*

func testBuildFlight() {
    let plane = spy(Plane())

    FlightBuilder(plane).planFlight(Shenzhen, Shanghai, Beijing).execute()

    Verify.ordered(
        @Called(plane.takeOffAt(Shenzhen)),
        @Called(plane.landAt(Shanghai)),
        @Called(plane.takeOffAt(Shanghai)),
        @Called(plane.landAt(Beijing))
    )
}
```

## Expectations and Verification API

When configuring stubs, you can set **expectations** and use the verification API to cover some assertions in the test code. In such cases, there's no alternative but to choose the method that best reflects the test's intent.

Generally, it's recommended to avoid repeating configuration steps in verification blocks.

<!--compile.onlyformat-->
```cangjie
let foo = mock<Foo>()
@On(foo.bar(_)).returns() // Test fails if this stub is never used

foo.bar(1)
foo.bar(2)

Verify.that(
    // Not necessary, automatically verified
    @Called(foo.bar(_)).atLeastOnce()
)

// But you can check the call count and specific parameters
Verify.unordered(
    @Called(foo.bar(1)).once(),
    @Called(foo.bar(2)).once()
)
```

The above example can be rewritten using expectations:

<!--compile.onlyformat-->
```cangjie
let foo = mock<Foo>()
@On(foo.bar(1)).returns().once() // Expected to be called only once with parameter `1`
@On(foo.bar(2)).returns().once() // Expected to be called only once with parameter `2`

foo.bar(1)
foo.bar(2)

// Test fails if no stubs are triggered
```