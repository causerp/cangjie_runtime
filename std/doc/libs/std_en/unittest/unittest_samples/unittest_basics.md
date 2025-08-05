# Unittest Fundamentals and Usage

## Tests and Test Cases

A test is an entity marked with the `@Test` macro that executes during the testing process.  
The Cangjie unittest framework supports two types of tests: test classes and test functions.  
Test functions are relatively simple, with each function containing all the code for test execution.  
Test classes are suitable for introducing deeper structural organization in tests or scenarios involving [test lifecycle behaviors](#test-lifecycle).

Each test class consists of multiple test cases, each marked with the `@TestCase` macro.  
Every test case is a function within the test class.  
The example from the previous section can be rewritten as the following test class:

<!-- run -->
```cangjie
func add(a: Int64, b: Int64) {
    a + b
}
@Test
class AddTests {
    @TestCase
    func addTest() {
        @Expect(add(2, 3), 5)
    }

    @TestCase
    func addZero() {
        @Expect(add(2, 0), 2)
    }
}
```

A test function is essentially a function containing a single test case. In this case, the `@TestCase` macro is not required.

Running this new test class with `cjpm test` produces output similar to the following:

```text
--------------------------------------------------------------------------------------------------
TP: example/example, time elapsed: 67369 ns, Result:
    TCS: AddTests, time elapsed: 31828 ns, RESULT:
    [ PASSED ] CASE: addTest (25650 ns)
    [ PASSED ] CASE: addZero (4312 ns)
    Summary: TOTAL: 2
    PASSED: 2, SKIPPED: 0, ERROR: 0
    FAILED: 0
--------------------------------------------------------------------------------------------------
cjpm test success
```

## Assertions

Assertions are individual condition checks executed within test case function bodies to verify code behavior.  
There are two types of assertions: `@Expect` and `@Assert`.  
To illustrate their differences, let's create an incorrect test:

<!-- run -->
```cangjie
func add(a: Int64, b: Int64) {
    a + b
}
@Test
func testAddIncorrect() {
    @Expect(add(3, 3), 5)
}
```

Running this test fails and produces the following output (showing only the relevant part):

```text
    TCS: TestCase_testAddIncorrect, time elapsed: 4236 ns, RESULT:
    [ FAILED ] CASE: testAddIncorrect (3491 ns)
    Expect Failed: `(add ( 3 , 3 ) == 5)`
       left: 6
      right: 5
```

In this example, replacing `@Expect` with `@Assert` would yield no difference. Now let's add another check and rerun:

<!-- run -->
```cangjie
func add(a: Int64, b: Int64) {
    a + b
}
@Test
func testAddIncorrect() {
    @Expect(add(3, 3), 5)
    @Expect(add(5, 3), 9)
}
```

Running the test fails with the following output (showing only the relevant part):

```text
    TCS: TestCase_testAddIncorrect, time elapsed: 5058 ns, RESULT:
    [ FAILED ] CASE: testAddIncorrect (4212 ns)
    Expect Failed: `(add ( 3 , 3 ) == 5)`
       left: 6
      right: 5

    Expect Failed: `(add ( 5 , 3 ) == 9)`
       left: 8
      right: 9
```

Both check results are visible in the output.  
However, if we replace `@Expect` with `@Assert`:

<!-- run -->
```cangjie
func add(a: Int64, b: Int64) {
    a + b
}
@Test
func testAddIncorrectAssert() {
    @Assert(add(3, 3), 5)
    @Assert(add(5, 3), 9)
}
```

The output becomes:

```text
    TCS: TestCase_testAddIncorrectAssert, time elapsed: 31653 ns, RESULT:
    [ FAILED ] CASE: testAddIncorrectAssert (30893 ns)
    Assert Failed: `(add ( 3 , 3 ) == 5)`
       left: 6
      right: 5
```

Only the first `@Assert` check fails, and subsequent tests don't even run.  
This is because the `@Assert` macro implements a *fail-fast* mechanism: upon the first assertion failure, the entire test case fails, and no further assertions are checked.

This is particularly important in large tests with numerous assertions, especially when using assertions within loops.  
Users can identify issues immediately after the first failure without waiting for all checks to complete.

The choice between `@Assert` and `@Expect` depends on test complexity and whether fail-fast behavior is desired.

When using the two assertion macros provided by `unittest`, the following approaches are available:

- **Equality assertions**: `@Assert(a, b)` or `@Expect(a, b)` checks whether parameters `a` and `b` have equal values. If `a` has type `A` and `b` has type `B`, `A` must implement `Equatable<B>`.
- **Boolean assertions**: `@Assert(c)` or `@Expect(c)` where parameter `c` is of type `Bool`, checking for `true` or `false`.

The second form `@Assert(c)` can be considered shorthand for `@Assert(c, true)`.

<!-- TODO: @PowerAssert -->

### Failure Assertions

Failure assertions cause test cases to fail. `@Fail` employs the fail-fast mechanism: when executed, the entire test case fails immediately, and no further assertions are checked. `@FailExpect` causes the test case to fail but continues checking subsequent assertions.  
These macros take a string parameter describing the failure reason. `@Fail` returns type `Nothing`, while `@FailExpect` returns `Unit`.

For example:

<!-- run -->
```cangjie
import std.time.*

func generateRandomEven(): Int64 {
    return DateTime.now().nanosecond
}

@Test
func validate_even_number_generator() {
    let even = generateRandomEven()
    if (even % 2 == 1) {
        @Fail("Not even number was generated: ${even}")
    }
}
```

Produces the following error message:

```text
    [ FAILED ] CASE: validate_even_number_generator (54313 ns)
    Assert Failed: `(Not even number was generated: 111)`
```

### Expected Exception Assertions

These assertions fail if the expected exception type is not thrown. `@AssertThrows` stops further checking upon failure, while `@ExpectThrows` continues.  
These macros accept attribute parameters listing expected exception types separated by `|`. Without attribute parameters, they expect the base `Exception` class. The input is an expression or code block expected to throw exceptions.

Examples:

```cangjie
// No.1
@AssertThrows(throw Exception())
 
// Semantically equivalent to No.1
@AssertThrows[Exception](throw Exception())
 
@AssertThrows[IllegalStateException | NoneValueException](random.seed = 42u64)
 
@ExpectThrows[OutOfMemoryError](foo())
 
@ExpectThrows({
    foo()
    boo()
})
 
@ExpectThrows[OutOfMemoryError]({
    for (i in list) {
        foo(i)
    }
})
```

#### Return Type of `@AssertThrows`

If only one exception type is specified, the return type matches the expected exception type:

```cangjie
let e: NoneValueException = @AssertThrows[NoneValueException](foo())
```

If multiple exception types are specified, the return type is the least common supertype of the expected exceptions:

```cangjie
// A <: C
// B <: C
let e: C = @AssertThrows[A | B](foo())
```

#### Return Type of `@ExpectThrows`

`@ExpectThrows` continues execution after failure. When only one exception type is specified, it returns `Option<T>` where `T` is the expected exception type:

```cangjie
let e: ?NoneValueException = @ExpectThrows[NoneValueException](foo())
```

When multiple exception types are specified, it returns `?Exception`:

```cangjie
let e: ?Exception = @ExpectThrows[NoneValueException | IllegalMemoryException](foo())
```

## Test Lifecycle

Test cases sometimes need shared setup or cleanup code. The testing framework supports four lifecycle phases, each configured via corresponding macros. Lifecycle steps can only be specified for `@Test` test classes, not for top-level `@Test` functions.

| Macro | Lifecycle Phase |
| ---  | --- |
| @BeforeAll | Runs before all test cases |
| @BeforeEach | Runs once before each test case |
| @AfterEach | Runs once after each test case |
| @AfterAll | Runs after all test cases complete |

These macros must be applied to member or static functions of `@Test` test classes. `@BeforeAll` and `@AfterAll` functions cannot declare any parameters. `@BeforeEach` and `@AfterEach` functions can declare one `String` parameter (or no parameters).

<!-- run -->
```cangjie
@Test
class FooTest {
    @BeforeAll
    func setup() {
        // This code runs before test execution.
    }
}
```

Multiple functions in a single test class can be marked with the same lifecycle macro. Multiple lifecycle macros can be applied to a single function. Lifecycle macros cannot be applied to functions marked with `@TestCase` or similar macros.

When multiple functions are marked for the same lifecycle phase, they execute in declaration order (top to bottom).

The testing framework ensures:

1. **Before all** steps run at least once before any test cases execute.
2. For each test case `TC` in the test class:  
    a) **Before each** steps run once before `TC`.  
    b) `TC` executes.  
    c) **After each** steps run once after `TC`.  
3. **After all** steps run after all test cases in the class complete.

> **Note:**  
> If no test cases run, the above does not apply.

In simple scenarios, **before all** and **after all** steps run only once. Exceptions include:

<!-- TODO: link parallel running -->
- For [type-parameterized tests](./unittest_parameterized_tests.md#type-parameterized-tests), **before/after all** steps run for each combination of type parameters.
- If test cases run in parallel across different processes, **before/after all** steps run once per process.

`@BeforeEach` and `@AfterEach` can access the test case being created or destroyed by declaring a `String` parameter.

<!-- run -->
```cangjie
@Test
class Foo {
    @BeforeEach
    func prepareData(testCaseName: String) {
        // The test case function name is passed as parameter
        // "bar" in this example
    }

    @AfterEach
    func cleanup() {
        // Parameters are optional
    }
    @TestCase
    func bar() {}
}
```

When configuring the lifecycle for [parameterized tests](./unittest_parameterized_tests.md#parameterized-tests) or parameterized performance tests, note that steps marked as **before each** or **after each** are executed only once for all parameters before or after running the test case or benchmark. In other words, from a lifecycle perspective, the test subject executed multiple times with different parameters is treated as a single test case.

If each parameter of a parameterized test requires separate setup/teardown, the corresponding code must be configured within the test case body itself. Additionally, the parameters themselves can be accessed.

<!-- TODO: mention and link how to do setup/teardown per parameter in benchmarks -->

## Test Configuration

Other advanced features in the unit testing framework may require additional configuration.  
Refer to the following three methods for configuring tests:

- Using the `@Configure` macro
- Directly using command-line arguments when running tests or in `cjpm test`
- Using the `cjpm` configuration file

<!-- TODO: configuration conversion algorithm -->

## Runtime Configuration

### Usage

When running the executable `test` compiled by cjc, add the following parameter options:

```shell
./test --bench --filter=MyTest.*Test,-stringTest
```

### `--bench`

By default, only functions decorated with `@TestCase` are executed. When using `--bench`, only cases decorated with the `@Bench` macro are executed.

### `--filter`

To filter a subset of tests by test class and test case names, use the format `--filter=TestClassName.TestCaseName`. For example:

1. `--filter=*` matches all test classes.
2. `--filter=*.*` matches all test cases in all test classes (same result as `*`).
3. `--filter=*.*Test,*.*case*` matches all test cases ending with `Test` in any test class or test cases containing `case` in their names.
4. `--filter=MyTest*.*Test,*.*case*,-*.*myTest` matches all test cases ending with `Test` in test classes starting with `MyTest`, or test cases containing `case` in their names, or test cases not containing `myTest`.

### `--dry-run`

Executes the unit testing framework without actually running the tests. Useful for listing test cases.

### `--include-tags`

To select a subset of tests based on categories specified in the [`@Tag`](../../unittest_testmacro/unittest_testmacro_package_api/unittest_testmacro_package_macros.md#tag-macro) macro, use the `--include-tags` or `--exclude-tags` runtime options. For example:

1. `--include-tags=Unittest` runs all test cases with `@Tag[Unittest]`.
2. `--include-tags=Unittest,Smoke` runs all test cases with `@Tag[Unittest]` and/or `@Tag[Smoke]`.
3. `--include-tags=Unittest+Smoke` runs all test cases with both `@Tag[Unittest]` and `@Tag[Smoke]`.
4. `--include-tags=Unittest+Smoke+JiraTask3271,Backend` runs all test cases with `@Tag[Backend]` and/or `@Tag[Unittest, Smoke, JiraTask3271]`.

> **Note**  
> If no test cases match the specified tag categories, the framework will not run anything.  
> Can be combined with `exclude-tags`. See [`--exclude-tags`](./unittest_basics.md#--exclude-tags) for details.

### `--exclude-tags`

To exclude a subset of tests based on categories specified in the [`@Tag`](../../unittest_testmacro/unittest_testmacro_package_api/unittest_testmacro_package_macros.md#tag-macro) macro, use the `--include-tags` or `--exclude-tags` runtime options. For example:

1. `--exclude-tags=Unittest` runs all test cases **not** tagged with `@Tag[Unittest]`.
2. `--exclude-tags=Unittest,Smoke` runs all test cases **not** tagged with `@Tag[Unittest]` and/or `@Tag[Smoke]`.
3. `--exclude-tags=Unittest+Smoke` runs all test cases **not** tagged with both `@Tag[Unittest]` and `@Tag[Smoke]`.
4. `--include-tags=Unittest --exclude-tags=Smoke` runs all test cases tagged with `@Tag[Unittest]` but not `@Tag[Smoke]`.

> **Note**  
> `exclude-tags` takes precedence over `include-tags`. If a test case is excluded, it will not be executed. For example, `--include-tags=Unittest+Smoke --exclude-tags=Smoke` will not execute test cases tagged with `@Tag[Smoke]`.

### `--timeout-each=timeout`

Using the `--timeout-each=timeout` option is equivalent to decorating all test classes with `@Timeout[timeout]`. If `@Timeout[timeout]` is already present in the code, the timeout value in the code takes precedence (i.e., the option's timeout configuration has lower priority than the code's timeout configuration).

The `timeout` value must follow this syntax:  
`number ('millis' | 's' | 'm' | 'h')`  
For example: `10s`, `9millis`, etc.

- `millis`: milliseconds  
- `s`: seconds  
- `m`: minutes  
- `h`: hours  

### `--parallel`

Enabling `--parallel` causes the testing framework to execute different test classes in separate processes concurrently.  
Test classes should be independent and not rely on shared mutable state.  
Static initialization may occur multiple times.  
Cannot be used with `--bench`. Since performance tests are sensitive to underlying resources, parallel execution may affect results, so combining with `--bench` is prohibited.

- `--parallel=<BOOL>`: `<BOOL>` can be `true` or `false`. If `true`, test classes can run in parallel, with the number of parallel processes controlled by the system's CPU cores. Omitting `=true` is also allowed.
- `--parallel=nCores`: Specifies that the number of parallel test processes should equal the available CPU cores.
- `--parallel=NUMBER`: Specifies the number of parallel test processes. Must be a positive integer.
- `--parallel=NUMBERnCores`: Specifies the number of parallel test processes as a multiple of available CPU cores. The value must be positive (supports floats or integers).

### `--option=value`

Any non-standard options provided in the `--option=value` format are processed as configuration parameters (similar to `@Configure` macro parameters) and applied in order:

`option` and `value` are arbitrary key-value pairs for runtime configuration. `option` can be any hyphen-separated English characters, converted to camelCase in `@Configure`. `value` follows these rules:

Note: Currently, the legality of `option` and `value` is not checked, and the option's priority is lower than `@Configure` in code.

- If `=value` is omitted, the option is treated as a `Bool` value `true`. For example, `--no-color` generates the configuration entry `noColor = true`.
- If `value` is strictly `true` or `false`, the option is treated as a `Bool` value: `--no-color=false` generates `noColor = false`.
- If `value` is a valid decimal integer, the option is treated as an `Int64` value. For example, `--random-seed=42` generates `randomSeed = 42`.
- If `value` is a valid decimal float, the option is treated as a `Float64` value. For example, `--angle=42.0` generates `angle = 42`.
- If `value` is a quoted string literal (enclosed in `"`), the option is treated as a `String`, and the value is decoded (handling escape sequences like `\n`, `\t`, `\"`). For example, `--mode="ABC \"2\""` generates `mode = "ABC \"2\""`.
- Otherwise, `value` is treated as a literal `String`. For example, `--mode=ABC23[1,2,3]` generates `mode = "ABC23[1,2,3]"`.

### `--report-path=path`

Specifies the directory path for generating test reports after execution. By default, no report is generated if this option is omitted.

### `--report-format=value`

Specifies the format of the generated test report.

Currently, unit tests only support the default XML format.

Benchmark tests support:

- `csv`: CSV reports include statistical data.
- `csv-raw`: CSV-raw reports contain only raw measurements for batches.
- `html`: HTML reports display all results and various statistical properties. Viewable in any browser. For each benchmark function, the HTML report includes:
  - A summary for each benchmark parameter.
  - Aggregated execution environment details (e.g., hardware, OS, compilation, environment variables).
  - Detailed statistics for each benchmark parameter in tabs.
  - Kernel density estimation plots (probability estimates of actual execution time).
  - Raw measurements and linear regression plots.
  - Tables with statistical properties (e.g., mean, median, R-squared, framework overhead, standard deviation) and their confidence intervals.

The default format for benchmark tests is `csv`.

### `--baseline-path=path`

Specifies the path for performance reports used for comparison. By default, uses the value of [`--report-path`](#--report-pathpath).

### `--capture-output`

Enables capturing of test case print output.  
By default, capturing is enabled during `cjpm test` execution and disabled otherwise.  
When disabled, print output is immediately propagated to the unit test output. Otherwise, the framework collects and processes the output.

Use cases for capturing output:

- Preventing interleaved output when using `--parallel`.
- Hiding output from passed tests for cleaner reports.
- Separating output per test case for debugging.

### `--no-capture-output`

Disables capturing of test case print output.  
By default, capturing is enabled during `cjpm test` execution and disabled otherwise.  

Causes test case output to propagate immediately to the unit test output.

### `--show-all-output`

The framework prints all output in the report, including output from passed test cases.  
This option has no effect if output capturing is disabled.

### `--coverage-guided`

Enables [coverage-guided randomized parameterized tests](./unittest_parameterized_tests.md#coverage-guided-randomized-parameterized-tests).

### `--progress-brief`

Enables a brief (single-line) dynamic progress report for unit tests.

### `--progress-entries-limit=limit`

Limits the maximum number of entries displayed in the progress output. Valid `limit` values: non-negative integers.  
`0` means no limit. Default: unlimited.

### `--no-progress`

Disables dynamic progress reporting.  
Implied if `--dry-run` is specified.
