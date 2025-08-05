# Macros

## `@AfterAll` Macro

Function: Declares a function in a test class as a [Test Lifecycle](../../unittest/unittest_samples/unittest_basics.md#test-lifecycle) function. The function decorated with this macro runs once after all test cases.

## `@AfterEach` Macro

Function: Declares a function in a test class as a [Test Lifecycle](../../unittest/unittest_samples/unittest_basics.md#test-lifecycle) function. The function decorated with this macro runs after each test case.

## `@Assert` Macro

Function: `@Assert` declares an Assert assertion, used within test functions. The test case stops if the assertion fails.

1. `@Assert(leftExpr, rightExpr)`: Compares whether `leftExpr` and `rightExpr` have the same value.
2. `@Assert(condition: Bool)`: Checks whether `condition` is `true`, i.e., `@Assert(condition: Bool)` is equivalent to `@Assert(condition: Bool, true)`.
3. `@Assert[customAssertion](arguments...)`: Calls the `customAssertion` function with the specified arguments `arguments`. For details, see [`@CustomAssertion`](#customassertion-macro).

## `@AssertThrows` Macro

Function: Declares an [Expected Exception Assertion](../../unittest/unittest_samples/unittest_basics.md#expected-exception-assertion), used within test functions. The test case stops if the assertion fails.

## `@BeforeAll` Macro

Function: Declares a function in a test class as a [Test Lifecycle](../../unittest/unittest_samples/unittest_basics.md#test-lifecycle) function. The function decorated with this macro runs once before all test cases.

## `@BeforeEach` Macro

Function: Declares a function in a test class as a [Test Lifecycle](../../unittest/unittest_samples/unittest_basics.md#test-lifecycle) function. The function decorated with this macro runs before each test case.

## `@Bench` Macro

Function: The `@Bench` macro marks a function to be executed multiple times and calculates its expected execution time.

Such functions are executed in batches, and the execution time is measured for the entire batch. This measurement is repeated multiple times to obtain a statistical distribution of results, and various statistical parameters of this distribution are calculated.
Currently supported parameters include:

- Median
- Absolute value of the 99% confidence interval for the median, used as an error estimate
- Relative value of the 99% confidence interval for the median
- Mean

An example of parameterized DSL combined with `@Bench` is shown below. For specific syntax and rules, see the [`@TestCase` Macro](#testcase-macro) section:

```cangjie
func sortArray<T>(arr: Array<T>): Unit
        where T <: Comparable<T> {
    if (arr.size < 2) { return }
    var minIndex = 0
    for (i in 1..arr.size) {
        if (arr[i] < arr[minIndex]) {
            minIndex = i
        }
    }
    (arr[0], arr[minIndex]) = (arr[minIndex], arr[0])
    sortArray(arr[1..])
}

@Test
@Configure[baseline: "test1"]
class ArrayBenchmarks{
    @Bench
    func test1(): Unit
    {
        let arr = Array(10) { i: Int64 => i }
        sortArray(arr)
    }

    @Bench[x in 10..20]
    func test2(x:Int64): Unit
    {
        let arr = Array(x) { i: Int64 => i.toString() }
        sortArray(arr)
    }
}
```

The output is as follows, with an additional `Args` column listing test data under different parameters. Each parameter value is output as a performance test case, and all combinations are listed when multiple parameters are involved:

```text
--------------------------------------------------------------------------------------------------
TP: default, time elapsed: 68610430659 ns, Result:
    TCS: ArrayBenchmarks, time elapsed: 68610230100 ns, RESULT:
    | Case   | Args   |   Median |       Err |   Err% |     Mean |
    |:-------|:-------|---------:|----------:|-------:|---------:|
    | test1  | -      | 4.274 us | ±2.916 ns |  ±0.1% | 4.507 us |
    |        |        |          |           |        |          |
    | test2  | 10     | 6.622 us | ±5.900 ns |  ±0.1% | 6.670 us |
    | test2  | 11     | 7.863 us | ±5.966 ns |  ±0.1% | 8.184 us |
    | test2  | 12     | 9.087 us | ±10.74 ns |  ±0.1% | 9.918 us |
    | test2  | 13     | 10.34 us | ±6.363 ns |  ±0.1% | 10.28 us |
    | test2  | 14     | 11.63 us | ±9.219 ns |  ±0.1% | 11.67 us |
    | test2  | 15     | 13.05 us | ±7.520 ns |  ±0.1% | 13.24 us |
    | test2  | 16     | 14.66 us | ±11.59 ns |  ±0.1% | 15.53 us |
    | test2  | 17     | 16.21 us | ±8.972 ns |  ±0.1% | 16.35 us |
    | test2  | 18     | 17.73 us | ±6.288 ns |  ±0.0% | 17.88 us |
    | test2  | 19     | 19.47 us | ±5.819 ns |  ±0.0% | 19.49 us |
    Summary: TOTAL: 11
    PASSED: 11, SKIPPED: 0, ERROR: 0
    FAILED: 0
--------------------------------------------------------------------------------------------------
```

## `@Configure` Macro

Function: The `@Configure` macro provides configuration parameters for test classes or test functions. It can be placed on test classes or test functions.

The syntax rule is `@Configure[parameter1: <value1>,parameter2: <value2>]`
where `parameter1` is a Cangjie identifier, and `value` is any valid Cangjie expression. Both are case-sensitive.
`value` can be a constant or any Cangjie expression valid within the scope of the declaration marked with `@Configure`.
If multiple parameters have different types, they can have the same name. If multiple parameters with the same name and type are specified, the latest one is used.

Currently supported configuration parameters include:

- `randomSeed`: Type is [Int64](../../core/core_package_api/core_package_intrinsics.md#int64). Sets the initial random seed for all functions using random generation.
- `generationSteps`: Type is [Int64](../../core/core_package_api/core_package_intrinsics.md#int64): The maximum number of steps for generating values in the parameterized test algorithm.
- `reductionSteps`: Type is [Int64](../../core/core_package_api/core_package_intrinsics.md#int64): The maximum number of steps for reducing values in the parameterized test algorithm.

The following parameters are generally used for Benchmark test functions decorated with `@Bench`:

- `explicitGC`: Type is [ExplicitGcType](../../unittest/unittest_package_api/unittest_package_enums.md#enum-explicitgctype): Specifies how to call [GC](../../runtime/runtime_package_api/runtime_package_funcs.md#func-gcbool) during Benchmark function testing. The default value is [ExplicitGcType](../../unittest/unittest_package_api/unittest_package_enums.md#enum-explicitgctype).Light.
- `baseline`: Type is [String](../../core/core_package_api/core_package_structs.md#struct-string): The value is the name of a Benchmark function, serving as the baseline for comparing Benchmark function execution results. This result value will be added as an additional column in the output, containing the comparison results.
- `batchSize`: Type is [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) or [Range](../../core/core_package_api/core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet)\<[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)>: Configures the batch size for Benchmark functions. The default value is calculated by the framework during warmup.
- `minBatches`: Type is [Int64](../../core/core_package_api/core_package_intrinsics.md#int64): Configures how many batches will be executed during Benchmark function testing. The default value is `10`.
- `minDuration`: Type is [Duration](../../core/core_package_api/core_package_structs.md#struct-duration): Configures the time for repeatedly executing Benchmark functions to obtain better results. The default value is [Duration](../../core/core_package_api/core_package_structs.md#struct-duration).second * 5.
- `warmup`: Type is [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) or [Int64](../../core/core_package_api/core_package_intrinsics.md#int64): Configures the time or number of times to repeatedly execute Benchmark functions before collecting results. The default value is [Duration](../../core/core_package_api/core_package_structs.md#struct-duration).second. When the value is 0, there is no warmup, and the number of executions is calculated as the user-input `batchSize` multiplied by `minBatches`. If `batchSize` is not specified, an exception will be thrown.

Users can specify other configuration parameters in the `@Configure` macro, which may be used in the future.
If a test class uses the `@Configure` macro to specify configurations, all test functions in this class will inherit these configuration parameters.
If test functions in this class are also marked with the `@Configure` macro, the configuration parameters will be merged from the class and function levels, with function-level macros taking precedence.

## `@CustomAssertion` Macro

Function: `@CustomAssertions` designates a function as a user-defined assertion.

Functions decorated with this macro must meet two requirements:

1. Top-level function
2. The first parameter is of type [`AssertionCtx`](../../unittest/unittest_package_api/unittest_package_classes.md#class-assertionctx).

Example:

```cangjie
@CustomAssertion
public func checkNotNone<T>(ctx: AssertionCtx, value: ?T): T {
    if (let Some(res) <- value) {
        return res
    }
    ctx.fail("Expected ${ctx.arg("value")} to be Some(_) but got None")
}
```

The output of `@CustomAssertion` is structured as a tree to improve readability for [Nested Assertions](#nested-assertions).

Example:

```cangjie
@Test
func customTest() {
    @Assert[checkNotNone](Option<Bool>.None)
}
```

```text
[ FAILED ] CASE: customTest (120812 ns)
Assert Failed: @Assert[checkNotNone](Option < Bool >.None)
└── Assert Failed: `('Option < Bool >.None' was expected to be Some(_) but got None)`
```

### Return Value

When a function decorated with `@CustomAssertion` has a return value, it will be returned by the `@Assert` macro.

Example:

```cangjie
@Test
func testfunc() {
    let maybeValue: Option<SomeObject> = maybeReturnsSomeObject()
    let value = @Assert[checkNotNone](maybeValue)

    @Assert[otherAssertion](value)
}
```

> Note: Custom `@Expect` will always return `Unit`, regardless of the return type of the function decorated with `@CustomAssertion`.

### Nested Assertions

Within `@CustomAssertion` definitions, [`@Assert`](#assert-macro)/[`@Expect`](#expect-macro) (including custom assertions), [`@AssertThrows`](#assertthrows-macro)/[`@ExpectThrows`](#expectthrows-macro), [`@Fail`](#fail-macro)/[`@FailExpect`](#failexpect-macro) macros can be called to form nested assertions.

Example:

```cangjie
@CustomAssertion
func iterableWithoutNone<T>(ctx: AssertionCtx, iter: Interable<?T>): Array<T> {
    iter |> map { it: ?T => @Assert[checkNotNone](it)} |> collectArray
}
```

```cangjie
@Test
func customTest() {
    @Assert[iterWithoutNone]([true, false, Option<Bool>.None])
}
```

```text
[ FAILED ] CASE: customTest
Assert Failed: @Assert[iterWithoutNone]([true, false, Option < Bool >.None])
└── @Assert[checkNotNone](it):
    └── Assert Failed: `('it' was expected to be Some(_) but got None)`
```

If a user-defined assertion throws an [`AssertException`](../../unittest/unittest_package_api/unittest_package_exceptions.md#class-assertexception) when called by the [`@Expect`](#expect-macro) macro, it will be caught and not propagated.
Similarly, if a user-defined assertion fails without raising an exception when called by the [`@Assert`](#assert-macro) macro, an exception will be created and thrown.

### Specifying Generic Types

When specifying generic type parameters, standard syntax can be used.

Example:

```cangjie
@CustomAssertion
public func doesThrow<E>(ctx: AssertionCtx, codeblock: () -> Any): E where E <: Excepiton {
    ...
}

@Test
func customTest() {
    let e = @Assert[doesThrow<NoneValueException>]({ => Option<Bool>.None.getOrThrow()})
}
```

## `@Expect` Macro

Function: `@Expect` declares an Expect assertion, used within test functions. The test case continues execution if the assertion fails.

1. `@Expect(leftExpr, rightExpr)`: Compares whether `leftExpr` and `rightExpr` are the same.
2. `@Expect(condition: Bool)`: Checks whether `condition` is `true`, i.e., `@Expect(condition: Bool)` is equivalent to `@Expect(condition: Bool, true)`.
3. `@Expect[customAssertion](arguments...)`: Calls the `customAssertion` function with the specified arguments `arguments`. For details, see [`@CustomAssertion`](#customassertion-macro).

## `@ExpectThrows` Macro

Function: Declares an [Expected Exception Assertion](../../unittest/unittest_samples/unittest_basics.md#expected-exception-assertion), used within test functions. The test case continues execution if the assertion fails.

## `@Fail` Macro

Function: Declares an [Expected Failure Assertion](../../unittest/unittest_samples/unittest_basics.md#failure-assertion), used within test functions. The test case stops if the assertion fails.

## `@FailExpect` Macro

Function: Declares an [Expected Failure Assertion](../../unittest/unittest_samples/unittest_basics.md#failure-assertion), used within test functions. The test case continues execution if the assertion fails.

## `@Measure` Macro

Function: Used to specify a [Measurement](../../unittest/unittest_package_api/unittest_package_interfaces.md#interface-measurement) instance for performance testing. Can only be applied within the scope of a class or top-level function marked with the `@Test` macro.
For each `Measurement`, different measurements are performed. Therefore, specifying more `Measurement` instances will take more time for performance testing.
The default value is [TimeNow](../../unittest/unittest_package_api/unittest_package_structs.md#struct-timenow)(), which internally uses [DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime).now() for measurement.

Example:

```cangjie
@Test
@Measure[TimeNow(), TimeNow(Nanos)]
class BenchClass {
    @Bench
    func someBench() {
        for (i in 0..1000) {
            1e3 * Float64(i)
        }
    }
}
```

The test report output is as follows:

```text
| Case      | Measurement  |   Median |         Err |   Err% |     Mean |
|:----------|:-------------|---------:|------------:|-------:|---------:|
| someBench | Duration     | 6.319 us | ±0.00019 us |  ±0.0% | 6.319 us |
|           |              |          |             |        |          |
| someBench | Duration(ns) |  6308 ns |   ±0.147 ns |  ±0.0% |  6308 ns |
```

The `CSV` report is as follows:

```csv
Case,Args,Median,Err,Err%,Mean,Unit,Measurement
"someBench",,"6319","0.185632","0.0","6319","ns","Duration"
"someBench",,"6308","0.146873","0.0","6308","ns","Duration(ns)"
```

## `@Parallel` Macro

Function: The `@Parallel` macro can decorate a test class. Test cases in a class decorated with `@Parallel` can be executed in parallel. This configuration only takes effect in `--parallel` mode.

1. All related test cases should be independent and not rely on any mutable shared state values.
2. `beforeAll()` and `afterAll()` should be reentrant so they can be run multiple times in different processes.3. Test cases intended for parallelization should inherently have longer execution times. Otherwise, the overhead introduced by multiple `beforeAll()` and `afterAll()` calls may outweigh the benefits of parallelization.
4. Concurrent usage with `@Bench` is prohibited. Since performance test cases are sensitive to underlying resources, whether test cases execute in parallel will impact performance test results, thus simultaneous use with `@Bench` is forbidden.

## `@PowerAssert` Macro

1. `@PowerAssert(leftExpr, rightExpr)` compares whether the values of `leftExpr` and `rightExpr` are identical.
2. `@PowerAssert(condition: Bool)` checks whether `condition` evaluates to `true`, meaning `@PowerAssert(condition: Bool)` is equivalent to `@PowerAssert(condition: Bool, true)`.

Compared to `@Assert`, the `@PowerAssert` macro displays detailed charts of evaluable sub-expression values within expressions, including exceptions during execution steps.

Its printed detailed information appears as follows:

```text
Assert Failed: `(foo(10, y: "test" + s) == foo(s.size, y: s) + bar(a))`
                |          |        |_||  |   |_|    |   |_|| |   |_||
                |          |       "123"  |  "123"   |  "123" |    1 |
                |          |__________||  |   |______|      | |______|
                |            "test123" |  |       3         |    33  |
                |______________________|  |_________________|        |
                            0             |        1                 |
                                          |__________________________|
                                                        34
--------------------------------------------------------------------------------------------------
```

Note that the returned [Tokens](../../ast/ast_package_api/ast_package_classes.md#class-tokens) represent the initial expression but are wrapped within internal wrappers that enable printing intermediate values and exceptions.

## `@Skip` Macro

Function: The `@Skip` modifier applies to functions already decorated with `@TestCase` / `@Bench`, causing the test case to be skipped.

Syntax rule: `@Skip[expr]`.

1. Currently, `expr` only supports `true`. When the expression is `true`, the test is skipped; all other values are treated as `false`.
2. By default, `expr` is `true`, meaning `@Skip[true]` == `@Skip`.

## `@Strategy` Macro

Function: Using `@Strategy` on a function creates a new [DataStrategy](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-datastrategy). It provides a convenient API for composing, mapping, and reusing strategies.

Functions marked with `@Strategy` must meet the following conditions:

1. Must explicitly specify a return type.
2. Parameters must correspond to the DSL specified in macro arguments.
3. Can be used both inside and outside classes marked with `@Test`.

> Implementation note: The macro expansion results in a variable with the function name and type [DataStrategyProcessor](../../unittest/unittest_package_api/unittest_package_classes.md#class-datastrategyprocessor). This variable can be used anywhere a [DataStrategy](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-datastrategy) is applicable.

## `@Tag` Macro

The `@Tag` macro can be applied to `@Test` classes and `@Test`, `@TestCase`, or `@Bench` functions to provide metadata for test entities. Subsequent filtering of test entities with these tags can be performed using [`--include-tags`](../../unittest/unittest_samples/unittest_basics.md#--include-tags) and [`--exclude-tags`](../../unittest/unittest_samples/unittest_basics.md#--exclude-tags) runtime options.

### Supported Syntax

1. A single `@Tag` on a test function.

    ```cangjie
    @Tag[Unittest]
    func test() {}
    ```

2. A single `@Tag` containing multiple tag names separated by commas.

    ```cangjie
    @Tag[Unittest, TestAuthor]
    func test() {}
    ```

3. Multiple `@Tag` instances on a test function.

    ```cangjie
    @Tag[Smoke]
    @Tag[Backend, JiraTask3271]
    func test() {}
    ```

### Rules and Constraints

- Tags should be valid Cangjie language identifiers.
- The tag list within `@Tag` must not be empty.
- If `@Tag` is placed at the top of a `@Test` class, it propagates its tags to all `@TestCase` functions within.

Example:

```cangjie
@Test
@Tag[Unittest]
public class UnittestClass {
    @TestCase[x in [1, 2, 3, 4, 5]]
    @Tag[JiraTask3271]
    func caseA(x: Int64) {}

    @TestCase
    func caseB() {}
}
```

Equivalent to:

```cangjie
@Test
@Tag[Unittest]
public class UnittestClass {
    @TestCase[x in [1, 2, 3, 4, 5]]
    @Tag[Unittest]
    @Tag[JiraTask3271]
    func caseA(x: Int64) {}

    @TestCase
    @Tag[Unittest]
    func caseB() {}
}
```

## `@Test` Macro

Function: The `@Test` macro applies to top-level functions or top-level classes, converting them into unit test classes.

For top-level functions, the macro creates a class with a single test case for framework use while retaining the function's normal callability.

Classes marked with `@Test` must meet the following conditions:

1. Must have a parameterless constructor.
2. Cannot inherit from other classes.

> Implementation note: The `@Test` macro introduces a new base class `unittest.TestCases` for any marked class. All public and protected members of `unittest.TestCases` (see API overview below) become available in classes or functions marked with `@Test`, including two fields:
    1. `ctx`: Contains the `TestContext` instance for this test.
    2. `name`: Contains the class name.
Users of the unit test framework should not modify these fields, as it may lead to unexpected errors.

## `@TestBuilder` Macro

Function: Declares a [dynamic test](../../unittest/unittest_samples/unittest_dynamic_tests.md#dynamic-tests) suite.

## `@TestCase` Macro

Function: The `@TestCase` macro marks functions within unit test classes as test cases.

Functions marked with `@TestCase` must meet the following conditions:

1. The class must be marked with `@Test`.
2. The function return type must be [Unit](../../core/core_package_api/core_package_intrinsics.md#unit).

```cangjie
@Test
class Tests {
    @TestCase
    func fooTest(): Unit {...}
}
```

Test cases may have parameters, in which case developers must specify parameter values using parameterized test DSL:

```cangjie
@Test[x in source1, y in source2, z in source3]
func test(x: Int64, y: String, z: Float64): Unit {}
```

This DSL is applicable to `@Test`, `@Strategy`, `@Bench`, and `@TestCase` macros, with `@Test` only available on top-level functions. If both `@Bench` and `@TestCase` are present in a test function, only `@Bench` may contain DSL.
In DSL syntax, identifiers before `in` (e.g., `x`, `y`, `z` in the example) must directly correspond to function parameters. Parameter sources (e.g., `source1`, `source2`, `source3`) are any valid Cangjie expressions (the expression type must implement either [DataStrategy](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-datastrategy)\<T> or [DataStrategyProcessor](../../unittest/unittest_package_api/unittest_package_classes.md#class-datastrategyprocessor)\<T> interfaces, detailed below).
The element type of parameter sources (provided as generic parameter `T` to [DataStrategy](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-datastrategy)\<T>) must strictly match the corresponding function parameter type.

Supported parameter source types include:

- Arrays: `x in [1,2,3,4]`.
- Ranges: `x in 0..14`.
- Randomly generated values: `x in random()`.
- Values read from JSON files: `x in json("filename.json")`.
- Values read from CSV files: `x in csv("filename.csv")`.
- Functions marked with `@Strategy`: `x in nameOfStrategyAnnotatedFunction`.
- Results composed using [DataStrategyProcessor](../../unittest/unittest_package_api/unittest_package_classes.md#class-datastrategyprocessor).

> Advanced users can introduce custom parameter source types by defining their own types that implement the [DataStrategy](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-datastrategy)\<T> interface.

Random generation using `random()` natively supports these types:

- [Unit](../../core/core_package_api/core_package_intrinsics.md#unit)
- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool)
- All built-in integer types (signed and unsigned)
- All built-in float types
- [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering)
- Array types of all supported types
- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) types of all supported types

> To add `random()` support for other types, extend the [Arbitrary](../../unittest_prop_test/unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-arbitrary) interface.
> When parameters have multiple values, `beforeEach`/`afterEach` executes only once across all values rather than repeating per value. For per-value setup/teardown, include it in the test body. For performance tests, `@Strategy` should handle setup code excluded from benchmarks. No special API exists for this scenario since such code typically depends on specific parameter values.

## `@Timeout` Macro

Function: `@Timeout` specifies that a test should terminate after a designated duration. It helps test complex algorithms that may run excessively long or enter infinite loops.

Syntax rule: `@Timeout[expr]`

`expr` should be of type std.time.[Duration](../../core/core_package_api/core_package_structs.md#struct-duration).
When applied to test classes, it provides timeout duration for each corresponding test case.

## `@Types` Macro

Function: The `@Types` macro supplies type parameters to test classes or functions. It can be placed on test classes or test functions.

Syntax rule: `@Types[Id1 in <Type1, Type2, Type3>, Id2 in <Type4, Type5> ...]`
where `Id1`, `Id2`... are valid type parameter identifiers, and `Type1`, `Type2`, `Type3`... are valid Cangjie types.

The `@Types` macro has these restrictions:

- Must be used with `@Test`, `@TestCase`, or `@Bench` macros.
- Only one `@Types` macro can modify a declaration.
- The declaration must be a generic class/function with type parameters matching those listed in `@Types`.
- Types in the list must not depend on each other, e.g., `@Types[A in <Int64, String>, B in <List<A>>]` will fail compilation. However, types provided to test classes can be used when supplying types to test functions within. Example:

```cangjie
@Test
@Types[T in <...>]
class TestClass<T> {
    @TestCase
    @Types[U in <Array<T>>]
    func testfunc<U>() {}
}
```

This mechanism works with other test framework features like `@Configure`.

## `@UnittestOption` Macro

This macro registers custom configuration options. Only registered options can be used with the unit test framework. Macro parameters are **type**, **option name**, optional **validator callback**, and optional **description**.
Strict validation of all unit test options ensures correctness for both console input and source code, preventing typos and incorrect value types.

Examples:

```cangjie
@UnittestOption[String, Int](optionName)
@UnittestOption[String](opt, /*validator*/ { str: String => str.size < 5 })
@UnittestOption[A, B](option3, { x: Any => ... })
@UnittestOption[Bool](needLog, /*description*/ "The option do ...")
@UnittestOption[Int](public myOpt)
```

Specific rules:

- `@UnittestOption` cannot be reused for the same option.
- `@UnittestOption` must be at the top level.
- For multi-type options, validator callback parameters should be `Any`; for single-type options, use the specific type.
- Validator callbacks return `Bool` or `?String`.
- `true` indicates valid options; `false` indicates invalid values.
- `Some<String>` contains invalidity reason descriptions; `None<String>` indicates valid values.

Example usage with `Configuration`:

Option key names are constructed by capitalizing the first letter and prefixing with `Key`. For example, option `zxc` becomes `KeyZxc.zxc`.

```cangjie
@UnittestOption[String](opt)

@Test
func test_that_derived_type_overwrite_parent_type_value_in_configuration() {
    let conf = Configuration()

    conf.set(KeyOpt.opt, "a")
    let value = conf.get(KeyOpt.opt).getOrThrow()
    @PowerAssert(value == "a")
}
```

The [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration) class correctly handles inheritance:

```cangjie
open class Base {
    public open func str() {
        "Base"
    }
}

class Derived <: Base {
    public func str() {
        "Derived"
    }
}

@UnittestOption[Base](opt)

@Test
func test_that_derived_type_overwrite_parent_type_value_in_configuration() {
    let conf = Configuration()

    conf.set(KeyOpt.opt, Base())
    let first = conf.get(KeyOpt.opt).getOrThrow()
    @PowerAssert(first.str() == "Base")

    conf.set(KeyOpt.opt, Derived())
    let second = conf.get(KeyOpt.opt).getOrThrow()
    @PowerAssert(second.str() == "Derived")
}
```