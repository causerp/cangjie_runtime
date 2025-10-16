# Unittest Basic Concepts and Usage

## Tests and Test Cases

A test is an entity marked with the `@Test` macro that gets executed during testing.  
The Cangjie unittest framework supports two types of tests: test classes and test functions.  
Test functions are relatively simple, with each function containing all the code for test execution.  
Test classes are suitable for introducing deeper structural hierarchies in tests or scenarios involving [test lifecycle behaviors](#test-lifecycle).

Each test class consists of multiple test cases, with each case marked by the `@TestCase` macro.  
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

A test function is essentially a function containing a single test case. In this case, the `@TestCase` macro is unnecessary.

Running this new test class with `cjpm test` produces output similar to:

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

Assertions are individual condition checks executed within test case functions to verify code behavior.  
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

Running this test fails with the following output (showing only the relevant part):

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

Only the first `@Assert` check fails; subsequent assertions aren't even executed.  
This is because the `@Assert` macro follows a *fail-fast* mechanism: upon the first assertion failure, the entire test case fails immediately, skipping remaining checks.

This behavior is crucial for large tests with numerous assertions, especially when assertions are used within loops.  
Users don't need to wait for all failures—the first failure provides immediate feedback.

The choice between `@Assert` and `@Expect` depends on test complexity and whether fail-fast behavior is desired.

When using the two assertion macros provided by `unittest`, the following approaches are available:

- Equality assertions: `@Assert(a, b)` or `@Expect(a, b)` compare parameters `a` and `b` for equality. Assuming `a` has type `A` and `b` has type `B`, `A` must implement `Equatable<B>`.
- Boolean assertions: `@Assert(c)` or `@Expect(c)` where parameter `c` is of type `Bool`, checking for `true` or `false`.

The second form `@Assert(c)` can be considered shorthand for `@Assert(c, true)`.

<!-- TODO: @PowerAssert -->

### Failure Assertions

Failure assertions force test cases to fail. `@Fail` follows the fail-fast mechanism—execution stops immediately, skipping subsequent checks. `@FailExpect` marks the case as failed but continues checking remaining assertions.  
Both macros accept a string parameter describing the failure reason. `@Fail` returns type `Nothing`, while `@FailExpect` returns `Unit`.

Example:

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

Outputs the following error:

```text
    [ FAILED ] CASE: validate_even_number_generator (54313 ns)
    Assert Failed: `(Not even number was generated: 111)`
```

### Expected Exception Assertions

These assertions fail if the expected exception type isn't thrown. `@AssertThrows` stops further checks upon failure, while `@ExpectThrows` continues.  
The macro attributes specify expected exception types separated by `|`. Without attributes, the base `Exception` class is expected. The parameter is the expression or code block expected to throw.

Examples:

```cangjie
// No.1
@AssertThrows(throw Exception())
 
// Semantically identical to No.1
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

If only one exception type is specified, the return type matches the expected exception:

```cangjie
let e: NoneValueException = @AssertThrows[NoneValueException](foo())
```

For multiple exception types, the return type is the least common supertype:

```cangjie
// A <: C
// B <: C
let e: C = @AssertThrows[A | B](foo())
```

#### Return Type of `@ExpectThrows`

`@ExpectThrows` continues execution after failure. For a single exception type, it returns `Option<T>` where `T` is the expected exception:

```cangjie
let e: ?NoneValueException = @ExpectThrows[NoneValueException](foo())
```

For multiple exception types, it returns `?Exception`:

```cangjie
let e: ?Exception = @ExpectThrows[NoneValueException | IllegalMemoryException](foo())
```

#### Approximate Equality

Certain parameter types (e.g., floating-point numbers) may require approximate equality checks.  

The package provides the [NearEqutable](../unittest_package_api/unittest_package_interfaces.md#interface-nearequatablect-d) interface. Types needing approximate equality can extend this interface and use the `delta` parameter in `@Assert`, `@Expect`, or `@PowerAssert` macros to enable this feature.

Approximate equality logic:

```text
a <= b with delta <=> a.isNear(b, delta) || a <= b
a >= b with delta <=> a.isNear(b, delta) || a >= b
a != b with delta <=> !a.isNear(b, delta)
a == b with delta <=> a.isNear(b, delta)
a < b with delta <=> !a.isNear(b, delta) && a < b
a > b with delta <=> !a.isNear(b, delta) && a > b
```

For floating-point types, the relative delta structure [RelativeDelta](../unittest_package_api/unittest_package_structs.md#struct-relativedeltat) is also provided:

Example:

<!-- run -->
```cangjie
// Basic types
@Test
func test1() {
    @Expect(1.0, 1.001, delta: 0.001) // Desugars to @Expect(1.0 == 1.001, delta: 0.001)
    @Expect(1.0 == 1.001, delta: 0.001)
    @Expect(1.0 != 1.901, delta: RelativeDelta(absoluteDelta: 0.001, relativeDelta: 0.02))
    @Expect(1.0 < 1.401, delta: 0.001)
}
// Custom types
class Point <: NearEquatable<Point, Point> {
    Point(let x: Int64, let y: Int64) { }

    public func isNear(obj: Point, delta: Point): Bool {
        if (x < 0 || y < 0) {
            throw IllegalArgumentException("Coordinates must be non negative. Actual: ($x, $y)")
        }
        abs(x - obj.x) < delta.x && abs(y - obj.y) < delta.y
    }
}

// Test case
@Test
func test() {
    let p1 = Point(1, 5)
    let p2 = Point(5, 5)
    let delta = Point(1, 1)

    @Expect(p1 != p2, delta: delta)
}
```

## Test Lifecycle

Test cases sometimes share setup or cleanup code. The framework supports four lifecycle phases, each configured via specific macros. Lifecycle steps can only be specified for `@Test` classes, not top-level `@Test` functions.

| Macro | Lifecycle Phase |
| ---  | --- |
| @BeforeAll | Runs before all test cases |
| @BeforeEach | Runs once before each test case |
| @AfterEach | Runs once after each test case |
| @AfterAll | Runs after all test cases complete |

These macros must be applied to member or static functions of `@Test` classes. `@BeforeAll` and `@AfterAll` functions cannot declare parameters. `@BeforeEach` and `@AfterEach` functions may declare one `String` parameter (or none).

<!-- run -->
```cangjie
@Test
class FooTest {
    @BeforeAll
    func setup() {
        // Runs before test execution.
    }
}
```

Multiple functions per class can be marked with the same lifecycle macro. Multiple lifecycle macros can be applied to a single function. Lifecycle macros cannot be combined with `@TestCase` or similar macros.

If multiple functions share the same lifecycle phase, they execute in declaration order (top to bottom).

The framework guarantees:

1. **Before all** steps run at least once before any test case.
2. For each test case `TC` in the class:
    1) **Before each** steps run once before `TC`.
    2) `TC` executes.
    3) **After each** steps run once after `TC`.
3. **After all** steps run after all test cases complete.

> **Note:**
>
> If no test cases run, these guarantees don't apply.

In simple scenarios, **before/after all** steps run exactly once. Exceptions include:

<!-- TODO: link parallel running -->
- For [type-parameterized tests](./unittest_parameterized_tests.md#type-parameterized-tests), **before/after all** steps run per type parameter combination.
- When tests run in parallel across processes, **before/after all** steps run once per process.

`@BeforeEach` and `@AfterEach` can access the current test case by declaring a `String` parameter.

<!-- run -->
```cangjie
@Test
class Foo {
    @BeforeEach
    func prepareData(testCaseName: String) {
        // Receives the test case function name
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

For [parameterized tests](./unittest_parameterized_tests.md#parameterized-tests) or parameterized benchmarks, note that **before/after each** steps execute once per test case or benchmark across all parameters. From a lifecycle perspective, a test body executed with different parameters counts as a single test case.

For per-parameter setup/cleanup, include the code within the test case body itself. Parameters are also accessible there.

<!-- TODO: mention and link how to do setup/teardown per parameter in benchmarks -->

## Test Configuration

Advanced unittest features may require additional configuration.  
Three configuration methods are available:

- Using the `@Configure` macro
- Direct command-line arguments during test execution or via `cjpm test`
- Using `cjpm` configuration files

<!-- TODO: configuration conversion algorithm -->

## Runtime Configuration

### Usage

Run the test executable compiled by cjc with additional options:

```shell
./test --bench --filter=MyTest.*Test,-stringTest
```

### `--bench`

By default, only functions marked with `@TestCase` execute. With `--bench`, only `@Bench`-marked cases run.

### `--filter`

To filter a subset of tests by class and case names, use `--filter=TestClassName.TestCaseName` patterns:

1. `--filter=*` matches all test classes
2. `--filter=*.*` matches all test cases (same as *)
3. `--filter=*.*Test,*.*case*` matches cases ending with "Test" or containing "case"
4. `--filter=MyTest*.*Test,*.*case*,-*.*myTest` matches:
   - Cases ending with "Test" in classes starting with "MyTest"
   - Cases containing "case"
   - Excludes cases containing "myTest"### `--dry-run`

Execute the unit testing framework without actually running the tests. Can be used to view the list of test cases.

### `--include-tags`

To select a subset of tests based on categories specified in the [`@Tag`](../../unittest_testmacro/unittest_testmacro_package_api/unittest_testmacro_package_macros.md#tag-macro) macro, use the `--include-tags` or `--exclude-tags` runtime options. For example:

1. `--include-tags=Unittest` runs all test cases tagged with `@Tag[Unittest]`.
2. `--include-tags=Unittest,Smoke` runs all test cases tagged with `@Tag[Unittest]` and/or `@Tag[Smoke]`.
3. `--include-tags=Unittest+Smoke` runs all test cases tagged with both `@Tag[Unittest]` and `@Tag[Smoke]`.
4. `--include-tags=Unittest+Smoke+JiraTask3271,Backend` runs all test cases tagged with `@Tag[Backend]` and/or `@Tag[Unittest, Smoke, JiraTask3271]`.

> **Note**  
> If no test cases match the specified tag categories, the framework will not execute anything.  
> Can be combined with `exclude-tags`. See [`--exclude-tags`](./unittest_basics.md#--exclude-tags) for details.

### `--exclude-tags`

To select a subset of tests based on categories specified in the [`@Tag`](../../unittest_testmacro/unittest_testmacro_package_api/unittest_testmacro_package_macros.md#tag-macro) macro, use the `--include-tags` or `--exclude-tags` runtime options. For example:

1. `--exclude-tags=Unittest` runs all test cases **not** tagged with `@Tag[Unittest]`.
2. `--exclude-tags=Unittest,Smoke` runs all test cases **not** tagged with `@Tag[Unittest]` and/or `@Tag[Smoke]`.
3. `--exclude-tags=Unittest+Smoke` runs all test cases **not** tagged with both `@Tag[Unittest]` and `@Tag[Smoke]`.
4. `--include-tags=Unittest --exclude-tags=Smoke` runs all test cases tagged with `@Tag[Unittest]` but **not** tagged with `@Tag[Smoke]`.

> **Note**  
> `exclude-tags` takes precedence over `include-tags`. If a test case is excluded, it will not be executed. For example, `--include-tags=Unittest+Smoke --exclude-tags=Smoke` will not execute any test cases tagged with `@Tag[Smoke]`.

### `--show-tags`

To display [`@Tag`](../../unittest_testmacro/unittest_testmacro_package_api/unittest_testmacro_package_macros.md#tag-macro) information in the test report, use the `--show-tags` runtime option.

In `--dry-run` mode with the report format set to `xml`, `Tag` information will always be included.

### `--timeout-each=timeout`

Using the `--timeout-each=timeout` option is equivalent to applying `@Timeout[timeout]` to all test classes. If `@Timeout[timeout]` is already specified in the code, the in-code timeout configuration will override this option (i.e., the option's timeout has lower priority than the in-code timeout).

The `timeout` value must follow this syntax:  
    `number ('millis' | 's' | 'm' | 'h')`  
Examples: `10s`, `9millis`, etc.

- millis: milliseconds  
- s: seconds  
- m: minutes  
- h: hours  

### `--parallel`

Enabling `--parallel` will cause the testing framework to execute different test classes in separate parallel processes.  
Test classes should be independent and not rely on shared mutable state.  
Static initialization may occur multiple times.  
Cannot be used with `--bench`. Since performance tests are sensitive to underlying resources, parallel execution may affect their results, so combining `--parallel` with `--bench` is prohibited.

- `--parallel=<BOOL>` `<BOOL>` can be `true` or `false`. When set to `true`, test classes will run in parallel, with the number of processes controlled by the system's CPU cores. Additionally, `--parallel` can omit `=true`.
- `--parallel=nCores` specifies that the number of parallel test processes should equal the available CPU cores.
- `--parallel=NUMBER` specifies the exact number of parallel test processes. Must be a positive integer.
- `--parallel=NUMBERnCores` specifies the number of parallel test processes as a multiple of the available CPU cores. The multiplier must be a positive number (supports integers or floating-point values).

### `--option=value`

Any non-standard options provided in the `--option=value` format will be processed and converted into configuration parameters (similar to those handled by the `@Configure` macro) and applied in order:

`option` and `value` are arbitrary key-value pairs for runtime configuration. `option` can be any hyphen-separated English string, which will be converted to camelCase when processed by `@Configure`. The `value` format follows these rules:

Note: Currently, no validation is performed on `option` or `value`, and the priority of these options is lower than in-code `@Configure` settings.

- If `=value` is omitted, the option is treated as a `Bool` value `true`. For example, `--no-color` generates the configuration entry `noColor = true`.
- If `value` is strictly `true` or `false`, the option is treated as a `Bool` with the corresponding meaning: `--no-color=false` generates `noColor = false`.
- If `value` is a valid decimal integer, the option is treated as an `Int64` value. For example, `--random-seed=42` generates `randomSeed = 42`.
- If `value` is a valid decimal number, the option is treated as a `Float64` value. For example, `--angle=42.0` generates `angle = 42`.
- If `value` is a quoted string literal (enclosed in `"`), the option is treated as a `String` type, and the value is decoded by processing escape sequences like `\n`, `\t`, and `\"`. For example, `--mode="ABC \"2\""` generates `mode = "ABC \"2\""`.
- In all other cases, `value` is treated as a `String` type and taken verbatim. For example, `--mode=ABC23[1,2,3]` generates `mode = "ABC23[1,2,3]"`.

### `--report-path=path`

This option specifies the directory path for generating test reports after execution. By default, no report is generated if this option is not explicitly set.

### `--report-format=value`

This option specifies the format of the test report generated after execution.

Currently, unit tests only support the default `xml` format.

Benchmark tests support:

- `csv`: The CSV report includes statistical data.
- `csv-raw`: The CSV-raw report contains only raw measurements for batches.
- `html`: The HTML report displays all results and various statistical properties. It can be viewed in any browser. For each benchmark function, the HTML report includes:
  - A summary for each benchmark parameter.
  - Aggregated execution environment details (e.g., hardware, OS, compilation info, environment variables).
  - Tabs with detailed statistics for each benchmark parameter.
  - A kernel density estimation plot, which estimates the probability distribution of execution times.
  - Raw measurements and their linear regression plot.
  - A table of statistical properties (e.g., mean, median, R-squared, framework overhead, standard deviation) with confidence intervals.

The default format for benchmark tests is:

- `csv`

### `--baseline-path=path`

This option specifies the path to the performance report used for comparison. By default, the value of [`--report-path`](#--report-pathpath) is used.

### `--capture-output`

This option enables capturing of test case print output.  
By default, capture is enabled during `cjpm test` execution and disabled otherwise.  
When capture is disabled, print output is immediately propagated to the unit test output. Otherwise, the unit test collects and processes the print output.

Capture is useful in the following scenarios:

- Preventing interleaved output when using `--parallel`.
- Hiding output from passed tests to make reports clearer.
- Separating output by test case to identify which test case produced which output.

### `--no-capture-output`

This option disables capturing of test case print output.  
By default, capture is enabled during `cjpm test` execution and disabled otherwise.  

Test case print output is immediately propagated to the unit test output.

### `--show-all-output`

The unit test framework will print all output in the report, including output from passed test cases.  
This option has no effect if test output capture is disabled.

### `--coverage-guided`

The unit test framework will enable [coverage-guided randomized parameterized tests](./unittest_parameterized_tests.md#coverage-guided-randomized-parameterized-tests).

### `--progress-brief`

Enables a brief (single-line) dynamic progress report for unit tests.

### `--progress-entries-limit=limit`

Limits the maximum number of entries displayed in the progress output. Valid values for `limit`: non-negative integers.  
A value of `0` means no limit. Default: unlimited.

### `--no-progress`

Disables the dynamic progress report.  
If the `--dry-run` option is specified, `--no-progress` is implicitly enabled.