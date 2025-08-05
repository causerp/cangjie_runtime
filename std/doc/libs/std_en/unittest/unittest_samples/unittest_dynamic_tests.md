# Dynamic Testing

## Introduction to Dynamic Testing

The Cangjie testing framework supports dynamic testing, which enables the construction of test cases when test data is unknown at compile time. Key scenarios include:

- Creating test suites based on external data.
- Creating test suites based on parameters or configuration files.

By comparing with regular test cases, you can see how to construct dynamic test cases using `@TestBuilder`.

Below is a simple test suite constructed with `@Test/@TestCase`:

<!-- run -->
```cangjie
@Test
class A {
    @TestCase
    func f() {
        @Assert(false)
    }

    @TestCase[x in [ 1, 2 ]]
    func g(x: Int) {
        @Assert( x >= 1 )
    }
}
```

Using `@TestBuilder`, you can create a dynamic test suite with equivalent logic:

<!-- run -->
```cangjie
@TestBuilder
public func buildCustomTestSuite(): TestSuite {
    let suiteBuilder = TestSuite.builder("A")
    let caseConfiguration = Configuration()
    suiteBuilder.add(UnitTestCase.create("f", configuration: caseConfiguration) {@Assert(false)})
    suiteBuilder.add(UnitTestCase.createParameterized("g", [1, 2]) {value => @Assert( value >= 1 )})
    suiteBuilder.build()
}
```

`TestSuite` creates a `TestSuiteBuilder` object that supports adding test cases. Cases are constructed via static functions in the `UnitTestCase` class, which supports both simple and parameterized cases. After configuring the `TestSuiteBuilder`, it ultimately generates a `TestSuite` object as the return value of the function decorated with `@TestBuilder`.

When the above code is compiled with `--test` and executed, the output matches that of the test suite constructed with `@Test`/`@TestCase`.

```text
--------------------------------------------------------------------------------------------------
TP: default, time elapsed: 121592 ns, RESULT:
    TCS: A, time elapsed: 121592 ns, RESULT:
    [ PASSED ] CASE: g (13969 ns)
    [ FAILED ] CASE: f (91641 ns)
    Assert Failed: `(false == true)`
       left: false
      right: true

Summary: TOTAL: 2
    PASSED: 1, SKIPPED: 0, ERROR: 0
    FAILED: 1, listed below:
            TCS: A, CASE: f
--------------------------------------------------------------------------------------------------
```

`@TestBuilder` has the following constraints:

- It can only decorate top-level functions and cannot be applied to `foreign` functions.
- Its return type must be explicitly specified as `TestSuite`.
- It can be combined with macros like `@Configure`, `@Timeout`, or `@Parallel`, but cannot be used with other macros from the `unittest.testmacro` package.

## Running Dynamic Tests and Capturing Output

If you need to run test cases internally rather than through the unit testing framework, you can use the `TestSuite`'s `runTests()` function.

For example:

<!-- run -->
```cangjie
import std.unittest.*
import std.unittest.testmacro.*

main() {
    let suiteBuilder = TestSuite.builder("A")
    let caseConfiguration = Configuration()
    suiteBuilder.add(UnitTestCase.create("f", configuration: caseConfiguration) {@Assert(false)})
    suiteBuilder.add(UnitTestCase.createParameterized("g", [1, 2]) {value => @Assert( value >= 1 )})
    let suite = suiteBuilder.build()
    let report = suite.runTests()
    report.reportTo(ConsoleReporter(colored: true))
}
```

The `runTests` function returns an instance of the `Report` class. You can use the `Report` object to:

- Print results to the console using `ConsoleReporter`: `report.reportTo(ConsoleReporter(colored: true))`.
- Print to any `PrettyPrinter` implementation using `TextReporter`: `report.reportTo(TextReporter(into: PrettyText()))`.
- Export results in supported formats, such as XML (`XmlReporter`, for unit tests only, not performance tests) or CSV (`CsvReporter` or `CsvRawReporter`, for performance tests only).