# Macros

## `@AfterAll` Macro

Function: Declares a function in a test class as a [test lifecycle](../../unittest/unittest_samples/unittest_basics.md#test-lifecycle) function. The function decorated with this macro runs once after all test cases.

## `@AfterEach` Macro

Function: Declares a function in a test class as a [test lifecycle](../../unittest/unittest_samples/unittest_basics.md#test-lifecycle) function. The function decorated with this macro runs once after each test case.

## `@Assert` Macro

Function: `@Assert` declares an Assert assertion, used inside test functions. If the assertion fails, the test case stops.

1. `@Assert(leftExpr, rightExpr)`: Compares whether `leftExpr` and `rightExpr` have the same value.
2. `@Assert(condition: Bool)`: Checks whether `condition` is `true`, i.e., `@Assert(condition: Bool)` is equivalent to `@Assert(condition: Bool, true)`.
3. `@Assert[customAssertion](arguments...)`: Calls the `customAssertion` function with the specified `arguments`. For details, see [`@CustomAssertion`](#customassertion-macro).
4. `@Assert(leftExpr, rightExpr, delta: deltaExpr)`: Enables approximate equality functionality using the `delta` parameter.
5. `@Assert(leftExpr <comparison_operator> rightExpr, delta: deltaExpr)`: Enables approximate equality functionality using the `delta` parameter.

## `@AssertThrows` Macro

Function: Declares an [expected exception assertion](../../unittest/unittest_samples/unittest_basics.md#expected-exception-assertion), used inside test functions. If the assertion fails, the test case stops.

## `@BeforeAll` Macro

Function: Declares a function in a test class as a [test lifecycle](../../unittest/unittest_samples/unittest_basics.md#test-lifecycle) function. The function decorated with this macro runs once before all test cases.

## `@BeforeEach` Macro

Function: Declares a function in a test class as a [test lifecycle](../../unittest/unittest_samples/unittest_basics.md#test-lifecycle) function. The function decorated with this macro runs once before each test case.

## `@Bench` Macro

Function: The `@Bench` macro marks a function to be executed multiple times and calculates its expected execution time.

Such functions are executed in batches, and the execution time is measured for the entire batch. This measurement is repeated multiple times to obtain a statistical distribution of results, and various statistical parameters of this distribution are calculated.
Currently supported parameters include:

- Median
- Absolute value of the median's 99% confidence interval used as an error estimate
- Relative value of the median's 99% confidence interval
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

The output is as follows, with an additional `Args` column listing test data under different parameters. Each parameter value is output as a performance test case, and full combinatorial scenarios are listed for multiple parameters:

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

The syntax rule is `@Configure[parameter1: <value1>,parameter2: <value2>]`, where `parameter1` is a Cangjie identifier, and `value` is any valid Cangjie expression. Both are case-sensitive.
`value` can be a constant or any valid Cangjie expression within the scope of the declaration marked with `@Configure`.
If multiple parameters have different types, they can have the same name. If multiple parameters with the same name and type are specified, the latest one is used.

Currently supported configuration parameters include:

- `randomSeed`: Type is [Int64](../../core/core_package_api/core_package_intrinsics.md#int64). Sets the initial random seed for all functions using random generation.
- `generationSteps`: Type is [Int64](../../core/core_package_api/core_package_intrinsics.md#int64): The maximum number of steps for generating values in the parameterized test algorithm.
- `reductionSteps`: Type is [Int64](../../core/core_package_api/core_package_intrinsics.md#int64): The maximum number of steps for reducing values in the parameterized test algorithm.

The following parameters are generally used for Benchmark test functions decorated with `@Bench`:

- `explicitGC`: Type is [ExplicitGcType](../../unittest/unittest_package_api/unittest_package_enums.md#enum-explicitgctype): How to call [GC](../../runtime/runtime_package_api/runtime_package_funcs.md#func-gcbool) during Benchmark function testing. The default value is [ExplicitGcType](../../unittest/unittest_package_api/unittest_package_enums.md#enum-explicitgctype).Light.
- `baseline`: Type is [String](../../core/core_package_api/core_package_structs.md#struct-string): The parameter value is the name of the Benchmark function, used as a baseline for comparing Benchmark function execution results. This result value will be added as an additional column to the output, containing the comparison results.
- `batchSize`: Type is [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) or [Range](../../core/core_package_api/core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet)\<[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)>: Configures the batch size for Benchmark functions. The default value is calculated by the framework during warmup.
- `minBatches`: Type is [Int64](../../core/core_package_api/core_package_intrinsics.md#int64): Configures how many batches will be executed during Benchmark function testing. The default value is `10`.
- `minDuration`: Type is [Duration](../../core/core_package_api/core_package_structs.md#struct-duration): Configures the time for repeated execution of Benchmark functions to obtain better results. The default value is [Duration](../../core/core_package_api/core_package_structs.md#struct-duration).second * 5.
- `warmup`: Type is [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) or [Int64](../../core/core_package_api/core_package_intrinsics.md#int64): Configures the time or number of times to repeat the Benchmark function before collecting results. The default value is [Duration](../../core/core_package_api/core_package_structs.md#struct-duration).second. When the value is 0, it means no warmup, and the number of executions is calculated as the user-input `batchSize` multiplied by `minBatches`. If `batchSize` is not specified, an exception will be thrown.

Users can specify other configuration parameters in the `@Configure` macro, which may be used in the future.
If a test class uses the `@Configure` macro to specify configurations, all test functions in this class will inherit these configuration parameters.
If a test function in this class is also marked with the `@Configure` macro, the configuration parameters will be merged from the class and function, with function-level macros taking precedence.

## `@CustomAssertion` Macro

Function: `@CustomAssertions` specifies a function as a user-defined assertion.

The function decorated with this macro must meet two requirements:

1. It must be a top-level function.
2. Its first parameter must be of type [`AssertionCtx`](../../unittest/unittest_package_api/unittest_package_classes.md#class-assertionctx).

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

The output of `@CustomAssertion` is a tree structure to improve readability for [nested assertions](#nested-assertions).

For example:

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

If the function decorated with `@CustomAssertion` has a return value, it will be returned by the `@Assert` macro.

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

In the definition of `@CustomAssertion`, [`@Assert`](#assert-macro)/[`@Expect`](#expect-macro) (including custom assertions), [`@AssertThrows`](#assertthrows-macro)/[`@ExpectThrows`](#expectthrows-macro), [`@Fail`](#fail-macro)/[`@FailExpect`](#failexpect-macro) macros can be called to form nested assertions.

For example:

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

If a user-defined assertion throws [`AssertException`](../../unittest/unittest_package_api/unittest_package_exceptions.md#class-assertexception) when called by [`@Expect`](#expect-macro), it will be caught and not propagated outward.
Similarly, if a user-defined assertion fails without raising an exception when called by [`@Assert`](#assert-macro), an exception will be created and thrown.

### Specifying Generic Types

When specifying generic type parameters, the same syntax as regular generics can be used.

For example:

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

Function: `@Expect` declares an Expect assertion, used inside test functions. If the assertion fails, the test case continues execution.

1. `@Expect(leftExpr, rightExpr)`: Compares whether `leftExpr` and `rightExpr` are the same.
2. `@Expect(condition: Bool)`: Checks whether `condition` is `true`, i.e., `@Expect(condition: Bool)` is equivalent to `@Expect(condition: Bool, true)`.
3. `@Expect[customAssertion](arguments...)`: Calls the `customAssertion` function with the specified `arguments`. For details, see [`@CustomAssertion`](#customassertion-macro).
4. `@Expect(leftExpr, rightExpr, delta: deltaExpr)`: Enables approximate equality functionality using the `delta` parameter.
5. `@Expect(leftExpr <comparison_operator> rightExpr, delta: deltaExpr)`: Enables approximate equality functionality using the `delta` parameter.

## `@ExpectThrows` Macro

Function: Declares an [expected exception assertion](../../unittest/unittest_samples/unittest_basics.md#expected-exception-assertion), used inside test functions. If the assertion fails, the test case continues execution.

## `@Fail` Macro

Function: Declares an [expected failure assertion](../../unittest/unittest_samples/unittest_basics.md#failure-assertion), used inside test functions. If the assertion fails, the test case stops.

## `@FailExpect` Macro

Function: Declares an [expected failure assertion](../../unittest/unittest_samples/unittest_basics.md#failure-assertion), used inside test functions. If the assertion fails, the test case continues execution.

## `@Measure` Macro

Function: Used to specify a [Measurement](../../unittest/unittest_package_api/unittest_package_interfaces.md#interface-measurement) instance for performance testing. It can only be applied within the scope of a class or top-level function marked with `@Test`.
For each `Measurement`, different measurements are performed. Therefore, specifying more `Measurement` instances will take more time for performance testing.
The default value is [TimeNow](../../unittest/unittest_package_api/unittest_package_structs.md#struct-timenow)(), which internally uses [DateTime](../../time/time_package_api/time_package_structs.md#struct-datetime).now() for measurement.

For example:

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

The output test report is as follows:

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

1. All related test cases should be independent and not depend on any mutable shared state values.
2. `beforeAll()` and `afterAll()` should be reentrant so they can be run multiple times in different processes.
3. The test cases to be parallelized should themselves be time-consuming. Otherwise, the overhead of multiple `beforeAll()` and `afterAll()` calls introduced by parallelization may exceed the benefits of parallelization.
4. Concurrent use## `@Test` Macro

Functionality: The `@Test` macro is applied to top-level functions or top-level classes to convert them into unit test classes.

If applied to a top-level function, it creates a new class containing a single test case for framework use, while the function remains callable as a normal function.

Classes marked with `@Test` must satisfy the following conditions:

1. They must have a parameterless constructor.
2. They cannot inherit from other classes.

> Implementation Note: The `@Test` macro introduces a new base class `unittest.TestCases` for any class it marks.  
All public and protected members of `unittest.TestCases` (see API overview below) become available in classes or functions marked with `@Test`, including two fields:
    1. `ctx`: A `TestContext` instance containing this test.
    2. `name`: The name of the class.  
Users of the unit testing framework should not modify these fields, as it may lead to unexpected errors.

## `@TestBuilder` Macro

Functionality: Declares a [dynamic test suite](../../unittest/unittest_samples/unittest_dynamic_tests.md#dynamic-tests).

## `@TestCase` Macro

Functionality: The `@TestCase` macro marks functions within a unit test class as test cases for unit testing.

Functions marked with `@TestCase` must satisfy the following conditions:

1. The class must be marked with `@Test`.
2. The function's return type must be [Unit](../../core/core_package_api/core_package_intrinsics.md#unit).

```cangjie
@Test
class Tests {
    @TestCase
    func fooTest(): Unit {...}
}
```

Test cases may have parameters. In such cases, developers must specify the values of these parameters using the parameterized test DSL:

```cangjie
@Test[x in source1, y in source2, z in source3]
func test(x: Int64, y: String, z: Float64): Unit {}
```

This DSL can be used with the `@Test`, `@Strategy`, `@Bench`, and `@TestCase` macros, where `@Test` is only available for top-level functions. If a test function has both `@Bench` and `@TestCase`, only `@Bench` can include the DSL.  
In the DSL syntax, the identifiers before `in` (e.g., `x`, `y`, and `z` in the example above) must directly correspond to the function's parameters. The parameter sources (`source1`, `source2`, and `source3` in the example) can be any valid Cangjie expression (the expression type must implement either the [DataStrategy](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-datastrategy)\<T> or [DataStrategyProcessor](../../unittest/unittest_package_api/unittest_package_classes.md#class-datastrategyprocessort)\<T> interface, detailed below).  
The element type of the parameter source (provided as the generic parameter `T` to [DataStrategy](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-datastrategy)\<T>) must exactly match the type of the corresponding function parameter.

Supported parameter source types include:

- Arrays: `x in [1,2,3,4]`.
- Ranges: `x in 0..14`.
- Randomly generated values: `x in random()`.
- Values read from JSON files: `x in json("filename.json")`.
- Values read from CSV files: `x in csv("filename.csv")`.
- Functions marked with `@Strategy`: `x in nameOfStrategyAnnotatedFunction`.
- Results combined using [DataStrategyProcessor](../../unittest/unittest_package_api/unittest_package_classes.md#class-datastrategyprocessort).

> Advanced users can introduce their own parameter source types by defining custom types that implement the [DataStrategy](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-datastrategy)\<T> interface.

The `random()` function supports the following types by default:

- [Unit](../../core/core_package_api/core_package_intrinsics.md#unit)
- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool)
- All built-in integer types (signed and unsigned)
- All built-in float types
- [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering)
- Array types of all supported types
- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) types of all supported types

> To add support for other types with `random()`, extend the [Arbitrary](../../unittest_prop_test/unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-arbitraryt) interface.  
> When multiple parameter values are provided, `beforeEach`/`afterEach` will not execute repeatedly for each value but only once. If initialization and cleanup are needed per value, include them in the test body. For performance testing, `@Strategy` should be used for setup code excluded from benchmarks. No special API is provided for this case, as such code typically depends on specific parameter values.

## `@TestTemplate` Macro

Functionality: The `@TestTemplate` macro marks an abstract class as a [test template](../../unittest/unittest_samples/unittest_test_templates.md).

## `@Timeout` Macro

Functionality: The `@Timeout` macro specifies that a test should terminate after a given duration. It is useful for testing complex algorithms that may run for extended periods or enter infinite loops.

Syntax: `@Timeout[expr]`

Here, `expr` must be of type `std.time.[Duration](../../core/core_package_api/core_package_structs.md#struct-duration)`.  
When applied to a test class, it sets the timeout for each corresponding test case.

## `@Types` Macro

Functionality: The `@Types` macro provides type parameters for test classes or test functions. It can be placed on test classes or test functions.

Syntax: `@Types[Id1 in <Type1, Type2, Type3>, Id2 in <Type4, Type5> ...]`  
Here, `Id1`, `Id2`, etc., are valid type parameter identifiers, and `Type1`, `Type2`, etc., are valid Cangjie types.

Restrictions for `@Types`:

- Must be used with `@Test`, `@TestCase`, or `@Bench`.
- Only one `@Types` macro can be applied per declaration.
- The declaration must be a generic class or function with the same type parameters listed in the `@Types` macro.
- Types in the list must not depend on each other. For example, `@Types[A in <Int64, String>, B in <List<A>>]` will fail to compile. However, types provided for the test class can be used for test functions within the class. Example:

```cangjie
@Test
@Types[T in <...>]
class TestClass<T> {
    @TestCase
    @Types[U in <Array<T>>]
    func testfunc<U>() {}
}
```

This mechanism can be combined with other testing framework features, such as `@Configure`.

## `@UnittestOption` Macro

This macro registers custom configuration options. Only registered options can be used with the unit testing framework. The macro's parameters are the **type**, **option name**, optional **validator callback**, and optional **description**.  
Strict checks on all unit test configuration options ensure correctness for both console input and source code, preventing typos and incorrect value types.

Examples:

```cangjie
@UnittestOption[String, Int](optionName)
@UnittestOption[String](opt, /*validator*/ { str: String => str.size < 5 })
@UnittestOption[A, B](option3, { x: Any => ... })
@UnittestOption[Bool](needLog, /*description*/ "The option do ...")
@UnittestOption[Int](public myOpt)
```

Rules:

- `@UnittestOption` cannot be reused for the same option.
- `@UnittestOption` must be at the top level.
- If an option accepts multiple types, the validator callback parameter should be `Any`. If only one type is valid, the parameter should be that specific type.
- The validator callback returns `Bool` or `?String`.
    - `true` indicates the option is valid; `false` indicates it is invalid.
    - `Some<String>` contains a description of why the option is invalid; `None<String>` indicates validity.

Example with `Configuration`:

Option key names are constructed by capitalizing the first letter and prefixing with `Key`. For example, an option named `zxc` will have the key `KeyZxc.zxc`.

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

The [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration) class handles inheritance correctly. Example:

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