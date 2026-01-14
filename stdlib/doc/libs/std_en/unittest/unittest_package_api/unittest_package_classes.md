# Class

## class AssertionCtx

```cangjie
public class AssertionCtx {}
```

Function: Stores the state of user-defined assertions. Provides methods for writing user-defined assertions.

### prop args

```cangjie
public prop args: String
```

Function: Returns a comma-separated string of unresolved user-defined assertion parameters.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string).

### prop caller

```cangjie
public prop caller: String
```

Function: Gets the identifier of the user-defined assertion function.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string).

### prop hasErrors

```cangjie
public prop hasErrors: Bool
```

Function: Returns `true` if any assertion within the user-defined function fails. Otherwise returns `false`.

Type: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool)

### func arg(String)

```cangjie
public func arg(key: String): String
```

Function: Returns the string representation of the parameter value corresponding to the passed identifier, matching the identifier in the parameter list.

Parameters:

- key: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The identifier in the function parameter list.

Returns:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string representation of the parameter value corresponding to the identifier.

### func fail(String)

```cangjie
public func fail(message: String): Nothing 
```

Function: Stores failure information and throws [`AssertExpection`](./unittest_package_exceptions.md#class-assertexception) within the user-defined assertion function.

Parameters:

- message: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The failure message.

### func fail\<PP>(PP)

```cangjie
public func fail<PP>(pt: PP): Nothing where PP <: PrettyPrintable
```

Function: Stores failure information and throws [`AssertExpection`](./unittest_package_exceptions.md#class-assertexception) within the user-defined assertion function.

Parameters:

- pt: PP <: [PrettyPrintable](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-prettyprintable) - The failure message.

### func failExpect(String)

```cangjie
public func failExpect(message: String): Unit 
```

Function: Stores failure information and continues function execution within the user-defined assertion function.

Parameters:

- message: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The failure message.

### func failExpect\<PP>(PP)

```cangjie
public func failExpect<PP>(pt: PP): Unit where PP <: PrettyPrintable
```

Function: Stores failure information and continues function execution within the user-defined assertion function.

Parameters:

- pt: PP <: [PrettyPrintable](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-prettyprintable) - The failure message.

### func setArgsAliases(Array\<String>)

```cangjie
public func setArgsAliases(aliases: Array<String>): Unit
```

Function: Sets aliases to access unresolved user-defined assertion function parameters via the [`arg`](#func-argstring) function. For internal framework use; users do not need to call this function.

Parameters:

- aliases: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[String](../../core/core_package_api/core_package_structs.md#struct-string)> - An array of identifiers. The array size should match the parameter list (excluding [`AssertionCtx`](#class-assertionctx)).

## class Benchmark

```cangjie
public class Benchmark {}
```

Function: This class provides methods for creating and running individual performance test cases.

Example:

<!-- run -->
```cangjie
import std.unittest.*

main() {
    let conf = Configuration()
    conf.set(KeyWarmup.warmup, Duration.Zero)
    conf.set(KeyMinDuration.minDuration, Duration.nanosecond)
    let bench = Benchmark.create("ordinary", configuration: conf, body: {=>})

    println("Running ${bench.name}...") // Prints: Running ordinary...
    bench.run().reportTo(ConsoleReporter())
    let parametrized = Benchmark.createParameterized(
        "parametrized",
        [1, 2, 3],
        configuration: conf,
        body: {_ =>}
    )

    println("Running ${parametrized.name}...")
    parametrized.run().reportTo(ConsoleReporter())
}
```

Possible output:

```text
Running ordinary...
Starting the benchmark `TestCase_ordinary.ordinary()`.
    Warming up for 0 ns.
    Starting measurements of 10 batches. Measuring Duration.
    Max batch size: 1, estimated execution time: 5.670 us.

--------------------------------------------------------------------------------------------------
TP: default, time elapsed: 275407 ns, RESULT:
    TCS: TestCase_ordinary, time elapsed: 270977 ns, RESULT:
    | Case     | Median |    Err |   Err% |   Mean |
    |:---------|-------:|-------:|-------:|-------:|
    | ordinary |   0 ns |  ±0 ns |  ±0.0% |   0 ns |
    [ PASSED ] CASE: ordinary (48166 ns)
Summary: TOTAL: 1
    PASSED: 1, SKIPPED: 0, ERROR: 0
    FAILED: 0
--------------------------------------------------------------------------------------------------
Running parametrized...
Starting the benchmark `TestCase_parametrized.parametrized(1)`.
    Warming up for 0 ns.
    Starting measurements of 10 batches. Measuring Duration.
    Max batch size: 1, estimated execution time: 13.42 us.

Starting the benchmark `TestCase_parametrized.parametrized(2)`.
    Warming up for 0 ns.
    Starting measurements of 10 batches. Measuring Duration.
    Max batch size: 1, estimated execution time: 11.85 us.

Starting the benchmark `TestCase_parametrized.parametrized(3)`.
    Warming up for 0 ns.
    Starting measurements of 10 batches. Measuring Duration.
    Max batch size: 1, estimated execution time: 0.910 us.

--------------------------------------------------------------------------------------------------
TP: default, time elapsed: 202400 ns, RESULT:
    TCS: TestCase_parametrized, time elapsed: 198092 ns, RESULT:
    | Case         | Args   | Median |       Err |   Err% |     Mean |
    |:-------------|:-------|-------:|----------:|-------:|---------:|
    | parametrized | 1      |   0 ns | ±206.0 ns |  ±inf% | 112.9 ns |
    | parametrized | 2      |   0 ns | ±35.23 ns |  ±inf% | 7.549 ns |
    | parametrized | 3      |   0 ns | ±46.55 ns |  ±inf% | 25.53 ns |
    [ PASSED ] CASE: parametrized (13302 ns)
Summary: TOTAL: 1
    PASSED: 1, SKIPPED: 0, ERROR: 0
    FAILED: 0
--------------------------------------------------------------------------------------------------
```

### prop name

```cangjie
public prop name: String
```

Function: Gets the test case name.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string).

### func run()

```cangjie
public func run(): BenchReport
```

Function: Runs the performance test case.

Returns:

- [BenchReport](#class-benchreport) - The execution result report.

### static func create(String, Configuration, Measurement, () -> Unit)

```cangjie
public static func create(
    name: String,
    configuration!: Configuration = Configuration(),
    measurement!: Measurement = TimeNow(),
    body!: () -> Unit
): Benchmark
```

Function: Creates a performance test case object.

Parameters:

- name: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The test case name.
- configuration!: [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration) - The test case configuration information.
- measurement: [Measurement](unittest_package_interfaces.md#interface-measurement) - The measurement method information.
- body: () -> Unit - The test case execution body.

Returns:

- [Benchmark](#class-benchmark) - The performance test case object.

### static func createParameterized\<T>(String, DataStrategy\<T>, Configuration, Measurement, (T) -> Unit)

```cangjie
public static func createParameterized<T>(
    name: String,
    strategy: DataStrategy<T>,
    configuration!: Configuration = Configuration(),
    measurement!: Measurement = TimeNow(),
    body!: (T) -> Unit
): Benchmark
```

Function: Creates a parameterized performance test case object.

Parameters:

- name: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The test case name.
- strategy: [DataStrategy](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-datastrategy) - The parameter data strategy.
- configuration: [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration) - The test case configuration information.
- measurement!: [Measurement](unittest_package_interfaces.md#interface-measurement) - The measurement method information.
- body: () -> Unit - The test case execution body.

Returns:

- [Benchmark](#class-benchmark) - The performance test case object.

### static func createParameterized\<T>(String, DataStrategyProcessor\<T>, Configuration, Measurement, (T) -> Unit)

```cangjie
public static func createParameterized<T>(
    name: String,
    strategy: DataStrategyProcessor<T>,
    configuration!: Configuration = Configuration(),
    measurement!: Measurement = TimeNow(),
    body!: (T) -> Unit
): Benchmark
```

Function: Creates a parameterized performance test case object.

Parameters:

- name: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The test case name.
- strategy: [DataStrategyProcessor](#class-datastrategyprocessort) - The parameter data processor.
- configuration: [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration) - The test case configuration information.
- measurement: [Measurement](unittest_package_interfaces.md#interface-measurement) - The measurement method information.
- body: () -> Unit - The test case execution body.

Returns:

- [Benchmark](#class-benchmark) - The performance test case object.

## class BenchReport

```cangjie
public class BenchReport <: Report {}
```

Function: Provides capabilities for processing performance test case execution result reports.

Parent Type:

- [Report](#class-report)

### func reportTo\<T>(Reporter\<BenchReport, T>)

```cangjie
public func reportTo<T>(reporter: Reporter<BenchReport, T>): T
```

Function: Prints the performance test case result report.

Parameters:

- reporter: [Reporter](#class-report)\<[BenchReport](#class-benchreport), T> - The performance test case result report.

Returns:

- T: The return value of the print operation. Typically of type Unit.

Example:

<!-- run -->
```cangjie
import std.unittest.*
import std.unittest.testmacro.*
import std.time.*
import std.sync.*

foreign func usleep(arg: UIntNative): UIntNative

@Test
class FooTest {
    @Bench[x in [ 1 ]]
    @Configure[minDuration: Duration.second]
    func testSleep(x: Int64): Unit {
        unsafe { usleep(30000) }
    }
}

main() {
    let startTime = DateTime.now()
    let report: BenchReport = FooTest().asTestSuite().runBenchmarks()
    let duration = DateTime.now() - startTime
    report.reportTo(ConsoleReporter(colored: false))

    let results = report.reportTo(RawStatsReporter())["testSleep1"]
    @Assert(results[0] < 50_000000.0 && results[0] > 25_000000.0)
}
```

## class CartesianProductProcessor\<T0,T1>

```cangjie
public class CartesianProductProcessor<T0, T1> <: DataStrategyProcessor<(T0, T1)> {
    public CartesianProductProcessor(let left: DataStrategyProcessor<T0>, let right: DataStrategyProcessor<T1>)
}
```

Function: Cartesian product processor.

Parent Type:

- [DataStrategyProcessor](#class-datastrategyprocessort)\<(T0, T1)>

### CartesianProductProcessor(DataStrategyProcessor\<T0>, DataStrategyProcessor\<T1>)

```cangjie
public CartesianProductProcessor(let left: DataStrategyProcessor<T0>, let right: DataStrategyProcessor<T1>)
```

Function: CartesianProductProcessor constructor.

Parameters:

- left: [DataStrategyProcessor](#class-datastrategyprocessort)\<T0> - The data strategy processor.
- right: [DataStrategyProcessor](#class-datastrategyprocessort)\<T1> - The data strategy processor.

## class ConsoleReporter

```cangjie
public class ConsoleReporter <: Reporter<TestReport, Unit> & Reporter<BenchReport, Unit>{
    public ConsoleReporter(let colored!: Bool = true)
}
```

Function: Prints unit test case results or performance test case results to the console.

Parent Types:

- [Reporter](unittest_package_interfaces.md#interface-reporter)\<[TestReport](#class-testreport), [Unit](../../core/core_package_api/core_package_intrinsics.md#unit)>
- [Reporter](unittest_package_interfaces.md#interface-reporter)\<[BenchReport](#class-benchreport), [Unit](../../core/core_package_api/core_package_intrinsics.md#unit)>

Example:

<!-- run -->
```cangjie
import std.unittest.*
import std.unittest.testmacro.*

main() {
    let testCase = UnitTestCase.create("testCase", body: {
        => @Fail("failing test")
    })
    let report = testCase.run()
    report.reportTo(ConsoleReporter())
}
```

Possible output:

```text
--------------------------------------------------------------------------------------------------
TP: default, time elapsed: 323478 ns, RESULT:
    TCS: TestCase_testCase, time elapsed: 317308 ns, RESULT:
    [ FAILED ] CASE: testCase (53267 ns)
    Assert Failed: `(failing test)`

Summary: TOTAL: 1
    PASSED: 0, SKIPPED: 0, ERROR: 0
    FAILED: 1, listed below:
            TCS: TestCase_testCase, CASE: testCase
--------------------------------------------------------------------------------------------------
```

### ConsoleReporter(Bool)

```cangjie
public ConsoleReporter(let colored!: Bool = true)
```

Function: ConsoleReporter constructor.

Parameters:

- colored!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether to use colored printing. Default is colored.

## class TextReporter\<PP>

```cangjie
public class TextReporter<PP> <: Reporter<TestReport, PP> & Reporter<BenchReport, PP> where PP <: PrettyPrinter {
    public TextReporter(let into!: PP)
}
```

Function: Prints unit test case results or performance test results to a subclass of [PrettyPrinter](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-prettyprinter). The format is identical to [ConsoleReporter](#class-consolereporter).

Parent Types:

- [Reporter](unittest_package_interfaces.md#interface-reporter)\<[TestReport](#class-testreport), PP>
- [Reporter](unittest_package_interfaces.md#interface-reporter)\<[BenchReport](#class-benchreport), PP>

Example:

<!-- run -->
```cangjie
import std.unittest.common.*
import std.unittest.*
import std.unittest.testmacro.*

main() {
    let testCase = UnitTestCase.create("testCase", body: {
        => @Fail("failing test")
    })
    let report = testCase.run()
    let pp = PrettyText()
    report.reportTo(TextReporter(into: pp))
    println(pp.toString())
}
```

Possible output:

```text
--------------------------------------------------------------------------------------------------
TP: default, time elapsed: 331021 ns, RESULT:
    TCS: TestCase_testCase, time elapsed: 322025 ns, RESULT:
    [ FAILED ] CASE: testCase (41768 ns)
    Assert Failed: `(failing test)`

Summary: TOTAL: 1
    PASSED: 0, SKIPPED: 0, ERROR: 0
    FAILED: 1, listed below:
            TCS: TestCase_testCase, CASE: testCase
--------------------------------------------------------------------------------------------------
```

### TextReporter(PP)

```cangjie
public TextReporter(let into!: PP)
```

Function: TextReporter constructor.

Parameters:

- into!: PP - A subclass of [PrettyPrinter](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-prettyprinter). Prints the report.

## class CsvReporter

```cangjie
public class CsvReporter <: Reporter<BenchReport, Unit> {
    public CsvReporter(let directory: Path)
}
```

Function: Prints performance test case result data to a CSV file.

Parent Type:

- [Reporter](unittest_package_interfaces.md#interface-reporter)\<[BenchReport](#class-benchreport), [Unit](../../core/core_package_api/core_package_intrinsics.md#unit)>

Example:

<!-- run -->
```cangjie
import std.fs.*
import std.unittest.*

main() {
    let conf = Configuration()
    conf.set(KeyWarmup.warmup, Duration.Zero)
    conf.set(KeyMinDuration.minDuration, Duration.nanosecond)
    let bench = Benchmark.create("bench", configuration: conf, body: {=>})
    bench.run().reportTo(CsvReporter(Path(".")))
    let report = File.readFrom("./benchmarks/bench-default.TestCase_bench.csv") |> String.fromUtf8
    println(report)
}
```

Possible output:

```text
Starting the benchmark `TestCase_bench.bench()`.
    Warming up for 0 ns.
    Starting measurements of 10 batches. Measuring Duration.
    Max batch size: 1, estimated execution time: 6.000 us.

Case,Args,Median,Err,Err%,Mean,Unit,Measurement
"bench",,"0.000000","38.153846","inf","7.576368","ns","Duration"
```

### CsvReporter(Path)

```cangjie
public CsvReporter(let directory: Path)
```

Function: CsvReporter constructor.

Parameters:

- directory: [Path](../../fs/fs_package_api/fs_package_structs.md#struct-path) - The output file directory.

## class CsvRawReporter

```cangjie
public class CsvRawReporter <: Reporter<BenchReport, Unit> {
    public CsvRawReporter(let directory: Path)
}
```

Function: Prints performance test case result data containing only raw measurement values per batch to a CSV file.

Parent Type:

- [Reporter](unittest_package_interfaces.md#interface-reporter)\<[BenchReport](#class-benchreport), [Unit](../../core/core_package_api/core_package_intrinsics.md#unit)>

Example:

<!-- run -->
```cangjie
import std.fs.*
import std.unittest.*

main() {
    let conf = Configuration()
    conf.set(KeyWarmup.warmup, Duration.Zero)
    conf.set(KeyMinDuration.minDuration, Duration.nanosecond)
    let bench = Benchmark.create("bench", configuration: conf, body: {=>})
    bench.run().reportTo(CsvRawReporter(Path(".")))
    let report = File.readFrom("./benchmarks/bench-default.TestCase_bench.csv") |> String.fromUtf8
    println(report)
}
```

Possible output:

```text
Starting the benchmark `TestCase_bench.bench()`.
    Warming up for 0 ns.
    Starting measurements of 10 batches. Measuring Duration.
    Max batch size: 1, estimated execution time: 7.330 us.

Case,Args,BatchSize,Duration,Unit,Measurement
"bench",,"1","256.000000","ns","Duration"
"bench",,"0","0.000000","ns","Duration"
"bench",,"1","0.000000","ns","Duration"
"bench",,"0","0.000000","ns","Duration"
"bench",,"1","256.000000","ns","Duration"
"bench",,"0","0.000000","ns","Duration"
"bench",,"1","0.000000","ns","Duration"
"bench",,"0","0.000000","ns","Duration"
"bench",,"1","0.000000","ns","Duration"
"bench",,"0","0.000000","ns","Duration"
"bench",,"1","0.000000","ns","Duration"
"bench",,"0","0.000000","ns","Duration"
"bench",,"1","0.000000","ns","Duration"
"bench",,"0","0.000000","ns","Duration"
"bench",,"1","0.000000","ns","Duration"
"bench",,"0","256.000000","ns","Duration"
"bench",,"1","0.000000","ns","Duration"
"bench",,"0","0.000000","ns","Duration"
"bench",,"1","0.000000","ns","Duration"
"bench",,"0","0.000000","ns","Duration"
"bench",,"0","0.000000","ns","Duration"
```

### CsvRawReporter(Path)

```cangjie
public CsvRawReporter(let directory: Path)
```

Function: CsvRawReporter constructor.

Parameters:

- directory: [Path](../../fs/fs_package_api/fs_package_structs.md#struct-path) - The output file directory.

## class DataStrategyProcessor\<T>

```cangjie
abstract sealed class DataStrategyProcessor<T> {}
```

Function: Base class for all [DataStrategy](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-datastrategy) components. Instances of this class are created by the [@Strategy](../../unittest_testmacro/unittest_testmacro_package_api/unittest_testmacro_package_macros.md#strategy-宏) macro or member functions.

### prop isInfinite

```cangjie
protected prop isInfinite: Bool
```

Function: Gets whether this strategy is infinite.

Type: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool).

### func intoBenchmark(String, Configuration, (T, Int64, Int64) -> Float64)

```cangjie
public func intoBenchmark(
    caseName!: String,
    configuration!: Configuration,
    doRun!: (T, Int64, Int64) -> Float64
): Benchmark
```

Function: A helper function used by macro-generated code. Creates a performance test case using this strategy.

Parameters:

- caseName!: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Test case name.
- configuration!: [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration) - Configuration information.
- doRun!: (T, Int64, Int64) -> Float64 - Performance test case execution body.

Returns:

- [Benchmark](#class-benchmark) - Performance test case object.

### func intoUnitTestCase(String, Configuration, (T) -> Unit)

```cangjie
public func intoUnitTestCase(
    caseName!: String,
    configuration!: Configuration,
    doRun!: (T) -> Unit
): UnitTestCase
```

Function: A helper function used by macro-generated code. Creates a test case using this strategy.

Parameters:

- caseName!: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Test case name.
- configuration!: [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration) - Configuration information.
- doRun!: (T) -> Unit - Test case execution body.

Returns:

- [UnitTestCase](#class-unittestcase) - Test case object.

### func lastItemInfo()

```cangjie
protected func lastItemInfo(): Array<InputParameter>
```

Function: Retrieves information about the last processed item.

Returns:

- Array\<[InputParameter](./unittest_package_classes.md#class-inputparameter)> - Information about the last processed item.

### func lastItem(Configuration)

```cangjie
protected func lastItem(configuration: Configuration): T
```

Function: Retrieves the last processed item.

Parameters:

- configuration: [Configuration](./../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration) - Processing strategy configuration information.

Returns:

- T - The last processed item.

### func provide(Configuration)

```cangjie
protected func provide(configuration: Configuration): Iterable<T>
```

Function: Generates a data iterator based on configuration information and data strategy.

Parameters:

- configuration: [Configuration](./../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration) - Processing strategy configuration information.

Returns:

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - Data iterator.

### func shrinkLastItem(Configuration, LazyCyclicNode)

```cangjie
protected func shrinkLastItem(configuration: Configuration, engine: LazyCyclicNode): Iterable<T>
```

Function: Shrinks the last item.

Parameters:

- configuration: [Configuration](./../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration) - Configuration information.
- engine: [LazyCyclicNode](./unittest_package_classes.md#class-lazycyclicnode) - Lazy node.

Returns:

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - Shrunk data iterator.

### static func start(DataStrategy\<T>, String)

```cangjie
public static func start(s: DataStrategy<T>, name: String): SimpleProcessor<T>
```

Function: Starting point for composition and mapping of [DataStrategy](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-datastrategy).

Parameters:

- s: [DataStrategy](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-datastrategy)\<T> - Data strategy.
- name: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Test case name.

Returns:

- [SimpleProcessor\<T>](#class-simpleprocessort) - Test case processor.

### static func start\<U>(() -> DataStrategy\<U>, String)

```cangjie
public static func start<U>(
    f: () -> DataStrategy<U>,
    name: String
): DataStrategyProcessor<U> where U <: BenchInputProvider < T >
```

Function: Starting point for composition and mapping of [DataStrategy](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-datastrategy).

Parameters:

- s: () -> [DataStrategy](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-datastrategy)\<U> - Closure that generates a data strategy.
- name: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Test case name.

Returns:

- [DataStrategyProcessor](#class-datastrategyprocessort)\<T> - Data strategy processor.

### static func start(() -> DataStrategy\<T>, String, Int64)

```cangjie
public static func start(
    f: () -> DataStrategy<T>,
    name: String,
    x!: Int64 = 0
): SimpleProcessor<T>
```

Function: Starting point for composition and mapping of [DataStrategy](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-datastrategy).

Parameters:

- s: () -> [DataStrategy](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-datastrategy)\<T> - Closure that generates a data strategy.
- name: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Test case name.
- x!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Additional parameter added for refactoring to achieve different return values.

Returns:

- [SimpleProcessor\<T>](#class-simpleprocessort) - Test case processor.

### static func start(() -> DataStrategyProcessor\<T>, String)

```cangjie
public static func start(f: () -> DataStrategyProcessor<T>, name: String): DataStrategyProcessor<T>
```

Function: Starting point for composition and mapping of [DataStrategy](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-datastrategy).

Parameters:

- s: () -> [DataStrategyProcessor](#class-datastrategyprocessort)\<T> - Closure that generates a data strategy processor.
- name: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Test case name.

Returns:

- [DataStrategyProcessor](#class-datastrategyprocessort)\<T> - Data strategy processor.

### static func start\<U>(() -> DataStrategyProcessor\<U>, String, Int64)

```cangjie
public static func start<U>(
    f: () -> DataStrategyProcessor<U>,
    name: String,
    x!: Int64 = 0
): DataStrategyProcessor<U> where U <: BenchInputProvider<T>
```

Function: Starting point for composition and mapping of [DataStrategy](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-datastrategy).

Parameters:

- s: () -> [DataStrategyProcessor](#class-datastrategyprocessort)\<U> - Closure that generates a data strategy processor.
- name: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Test case name.
- x!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Additional parameter added for refactoring to achieve different return values.

Returns:

- [DataStrategyProcessor](#class-datastrategyprocessort)\<U> where U <: [BenchInputProvider](./unittest_package_interfaces.md#interface-benchinputprovider)\<T> - Data strategy processor.

### extend \<T> DataStrategyProcessor\<T>

```cangjie
extend <T> DataStrategyProcessor<T> {}
```

#### func map\<R>((T) -> R)

```cangjie
public func map<R>(f: (T) -> R): MapProcessor<T, R>
```

Function: Simply applies `f` to each item of the original data strategy. [Shrink](../../unittest_prop_test/unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-shrinkt) also occurs on the original input before mapping.

Parameters:

- f: (T) -> R - Additional processing logic function to be applied.

Returns:

- [MapProcessor\<T, R>](#class-mapprocessortr) - Processor after applying `f`.

#### func mapWithConfig\<R>((T, Configuration) -> R)

```cangjie
public func mapWithConfig<R>(f: (T, Configuration) -> R): MapProcessor<T, R>
```

Function: Can access the current [Configuration](./../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration), simply applies `f` to each item of the original data strategy. [Shrink](../../unittest_prop_test/unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-shrinkt) also occurs on the original input before mapping.

Parameters:

- f: (T, Configuration) -> R - Additional processing logic function to be applied.

Returns:

- [MapProcessor\<T, R>](#class-mapprocessortr) - Processor after applying `f`.

#### func flatMap\<R>((T) -> DataProvider\<R>)

```cangjie
public func flatMap<R>(f: (T) -> DataProvider<R>): FlatMapProcessor<T, R>
```

Function: Simply applies `f` to each item of the original data strategy, then flattens the result. [Shrink](../../unittest_prop_test/unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-shrinkt) also occurs on the original input before [flatMap](../../collection/collection_package_api/collection_package_function.md#func-flatmapt-r-t---iterabler).

Parameters:

- f: (T) -> [DataProvider](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-datastrategy)\<R> - Additional processing logic function to be applied.

Returns:

- [FlatMapProcessor\<T, R>](#class-flatmapprocessortr) - Processor after applying `f`.

#### func flatMapStrategy((T) -> DataStrategy\<R>)

```cangjie
public func flatMapStrategy<R>(f: (T) -> DataStrategy<R>): FlatMapStrategyProcessor<T, R>
```

Function: Simply applies `f` to each item of the original data strategy, then flattens the result. [Shrink](../../unittest_prop_test/unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-shrinkt) is performed using the returned strategy rather than the original input.

Parameters:

- f: (T) -> [DataStrategy](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-datastrategy)\<R> - Additional processing logic function to be applied.

Returns:

- [FlatMapStrategyProcessor\<T, R>](#class-flatmapstrategyprocessortr) - Processor after applying `f`.

#### func product(DataStrategyProcessor\<R>)

```cangjie
public func product<R>(p: DataStrategyProcessor<R>): CartesianProductProcessor<T, R>
```

Function: Cartesian product combinator creates a data strategy containing all possible permutations of elements from the original strategy.
For infinite strategies, it first iterates through all finite substructures before advancing infinite ones.
[Shrink](../../unittest_prop_test/unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-shrinkt) occurs independently and uniformly on each element of the original strategy.

Parameters:

- p: [DataStrategyProcessor](#class-datastrategyprocessort)\<R> - Data strategy processor.

Returns:

- [CartesianProductProcessor\<T, R>](#class-cartesianproductprocessort0t1) - Cartesian product processor.

#### func productWithUnit\<P>(P): MapProcessor\<(T, Unit), T>

```cangjie
public func productWithUnit<P>(p: P): MapProcessor<(T, Unit), T> where P <: DataStrategyProcessor<Unit>
```

Function: Convenience adapter for [DataStrategyProcessor](#class-datastrategyprocessort).

Parameters:

- p: [P](#class-datastrategyprocessort) - Data strategy processor.

Returns:

- | [MapProcessor\<(T, Unit),R>](../unittest_package_api/unittest_package_classes.md#class-mapprocessortr) - Processor.

## class FlatMapProcessor\<T,R>

```cangjie
public class FlatMapProcessor<T,R> <: DataStrategyProcessor<R> {}
```

Function: Processor that performs [FlatMap](../../collection/collection_package_api/collection_package_function.md#func-flatmapt-r-t---iterabler) on parameter data.

Parent Type:

- [DataStrategyProcessor](#class-datastrategyprocessort)\<R>

## class FlatMapStrategyProcessor\<T,R>

```cangjie
public class FlatMapStrategyProcessor<T,R> <: DataStrategyProcessor<R> {}
```

Function: Processor that performs [FlatMap](../../collection/collection_package_api/collection_package_function.md#func-flatmapt-r-t---iterabler) on parameter data.

Parent Type:

- [DataStrategyProcessor](#class-datastrategyprocessort)\<R>

## class InputParameter

```cangjie
public class InputParameter {}
```

Function: Input parameter object type.

## class LazyCyclicNode

```cangjie
public open class LazyCyclicNode {}
```

Function: Internal lazy iterator used to advance type-erased values one after another in a cycle.

### func advance()

```cangjie
protected open func advance(): ?Unit
```

Function: Advances one value.

Returns:

- ?Unit - Returns None when unable to advance, otherwise returns Unit.

### func recover()

```cangjie
protected open func recover(): Unit
```

Function: Recovers or retreats one value.

## class MapProcessor\<T,R>

```cangjie
public class MapProcessor<T,R> <: DataStrategyProcessor<R> {}
```

Function: Processor that performs [Map](../../collection/collection_package_api/collection_package_function.md#func-mapt-rt---r) on parameter data.

Parent Type:

- [DataStrategyProcessor](#class-datastrategyprocessort)\<R>

## class PowerAssertDiagramBuilder

```cangjie
public class PowerAssertDiagramBuilder {
    public init(expression: String)
}
```

Function: [PowerAssert](../../unittest_testmacro/unittest_testmacro_package_api/unittest_testmacro_package_macros.md#powerassert-macro) output result builder.

### init(String)

```cangjie
public init(expression: String)
```

Function: Constructor.

Parameters:

- expression: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Expression string.

### func r\<T>(T, String, Int64)

```cangjie
public func r<T>(
    value: T,
    exprAsText: String,
    position: Int64
): T 
```

Function: Records comparison data.

Parameters:

- value: T - Data to be recorded.
- exprAsText: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Expression string.
- position: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Position information.

Returns:

- T - Recorded data.

### func r(String, String, Int64)

```cangjie
public func r(
    value: String,
    exprAsText: String,
    position: Int64
): String
```

Function: Records comparison data.

Parameters:

- value: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Data to be recorded.
- exprAsText: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Expression string.
- position: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Position information.

Returns:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - Recorded data.

### func r(Rune, String, Int64)

```cangjie
public func r(
    value: Rune,
    exprAsText: String,
    position: Int64
): Rune
```

Function: Records comparison data.

Parameters:

- value: [Rune](../../core/core_package_api/core_package_intrinsics.md#rune) - Data to be recorded.
- exprAsText: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Expression string.
- position: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Position information.

Returns:

- [Rune](../../core/core_package_api/core_package_structs.md#struct-string) - Recorded data.

### func h(Exception, String, Int64)

```cangjie
public func h(
    exception: Exception,
    exprAsText: String,
    position: Int64
): Nothing
```

Function: Handles exceptions.

Parameters:

- exception: Exception - Exception to be handled.
- exprAsText: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Expression string.
- position: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Position information.

### func w(Bool)

```cangjie
public func w(passed: Bool): Unit
```

Function: Returns a success result when the test case passes; throws an exception and prints comparison results when it fails.

Parameters:

- passed: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether the test case passed.
 
## class Report

```cangjie
sealed abstract class Report {}
```

Function: Base class for printing test case result reports.

Example:

<!-- run -->
```cangjie
import std.unittest.*
import std.unittest.testmacro.*

main() {
    let suite = TestSuite
        .builder("tests")
        .add(UnitTestCase.create("case1", body: {=> @Fail("failing case")}))
        .add(UnitTestCase.create("case2", body: {=> @Assert(1 + 2, 3)}))
        .build()
    let report = suite.runTests()
    println("Cases: ${report.caseCount}")
    println("Skipped: ${report.skippedCount}")
    println("Passed: ${report.passedCount}")
    println("Errors: ${report.errorCount}")
    println("Failed: ${report.failedCount}")
}
```

Possible output:

```text
Cases: 2
Skipped: 0
Passed: 1
Errors: 0
Failed: 1
```

### prop errorCount

```cangjie
public prop errorCount: Int64
```

Function: Gets the number of erroneous test cases.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64).

### prop caseCount

```cangjie
public prop caseCount: Int64
```

Function: Gets the total number of test cases.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64).

### prop passedCount

```cangjie
public prop passedCount:   Int64
```

Function: Gets the number of passed test cases.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64).

### prop failedCount

```cangjie
public prop failedCount:   Int64
```

Function: Gets the number of failed test cases.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64).

### prop skippedCount

```cangjie
public prop skippedCount:   Int64
```

Function: Gets the number of skipped test cases.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64).

## class RawStatsReporter

```cangjie
public class RawStatsReporter <: Reporter<BenchReport, HashMap<String, (Float64, Float64)>> {
    public RawStatsReporter()
}
```

Function: Raw performance test data reporter. For internal framework use only.

Parent Types:

- [Reporter](unittest_package_interfaces.md#interface-reporter)\<[BenchReport](#class-benchreport), [HashMap](../../collection/collection_package_api/collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek)\<[String](../../core/core_package_api/core_package_structs.md#struct-string), ([Float64](../../core/core_package_api/core_package_intrinsics.md#float64), [Float64](../../core/core_package_api/core_package_intrinsics.md#float64))>>

### RawStatsReporter()

```cangjie
public RawStatsReporter()
```

Function: RawStatsReporter constructor.

## class SimpleProcessor\<T>

```cangjie
public class SimpleProcessor<T> <: DataStrategyProcessor<T> {
    public SimpleProcessor(let buildDelegate:() -> DataStrategy<T>, let name: String)
}
```

Function: Simple data strategy processor. An implementation of [DataStrategyProcessor](#class-datastrategyprocessort).

Parent Types:

- [DataStrategyProcessor](#class-datastrategyprocessort)\<T>

### SimpleProcessor(() -> DataStrategy\<T>, String)

```cangjie
public SimpleProcessor(let buildDelegate:() -> DataStrategy<T>, let name: String)
```

Function: SimpleProcessor constructor.

Parameters:

- buildDelegate: () -> [DataStrategy](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-datastrategy)\<T> - Closure for generating data strategy.
- name: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Processor name.

## class TestGroup

```cangjie
public class TestGroup {}
```

Function: Provides methods for building and running test groups.

Example:

<!-- run -->
```cangjie
import std.unittest.*
import std.unittest.testmacro.*

main() {
    let suite1 = TestSuite
        .builder("tests")
        .add(UnitTestCase.create("case1", body: {=> @Fail("failing case")}))
        .add(UnitTestCase.create("case2", body: {=> @Assert(1 + 2, 3)}))
        .build()
    let suite2 = TestSuite.builder("benchmarks").add(Benchmark.create("bench", body: {=>})).build()
    let group = TestGroup.builder("group").add(suite1).add(suite2).build()

    println("Running ${group.name}...")
    group.runTests().reportTo(ConsoleReporter())

    let conf = Configuration()
    conf.set(KeyWarmup.warmup, Duration.Zero)
    conf.set(KeyMinDuration.minDuration, Duration.nanosecond)
    group.runBenchmarks(conf).reportTo(ConsoleReporter())
}
```

Possible output:

```text
Running group...
--------------------------------------------------------------------------------------------------
TP: group, time elapsed: 298091 ns, RESULT:
    TCS: tests, time elapsed: 290964 ns, RESULT:
    [ PASSED ] CASE: case2 (8340 ns)
    [ FAILED ] CASE: case1 (35797 ns)
    Assert Failed: `(failing case)`

    TCS: benchmarks, No test functions found
Summary: TOTAL: 2
    PASSED: 1, SKIPPED: 0, ERROR: 0
    FAILED: 1, listed below:
            TCS: tests, CASE: case1
--------------------------------------------------------------------------------------------------
Starting the benchmark `benchmarks.bench()`.
    Warming up for 0 ns.
    Starting measurements of 10 batches. Measuring Duration.
    Max batch size: 1, estimated execution time: 6.410 us.

--------------------------------------------------------------------------------------------------
TP: group, time elapsed: 83094 ns, RESULT:
    TCS: tests, No test functions found
    TCS: benchmarks, time elapsed: 77760 ns, RESULT:
    | Case   | Median |    Err |   Err% |   Mean |
    |:-------|-------:|-------:|-------:|-------:|
    | bench  |   0 ns |  ±0 ns |  ±0.0% |   0 ns |
    [ PASSED ] CASE: bench (2716 ns)
Summary: TOTAL: 1
    PASSED: 1, SKIPPED: 0, ERROR: 0
    FAILED: 0
--------------------------------------------------------------------------------------------------
```

### prop name

```cangjie
public prop name: String
```

Function: Gets the test group name.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string).

### func runBenchmarks()

```cangjie
public func runBenchmarks(): BenchReport
```

Function: Runs all benchmark test cases.

Returns:

- [BenchReport](#class-benchreport) - Benchmark test case report.

### func runBenchmarks(Configuration)

```cangjie
public func runBenchmarks(Configuration): BenchReport
```

Function: Executes all benchmark test cases with runtime configuration.

Parameters:

- configuration: [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration) - Runtime configuration.

Returns:

- [BenchReport](#class-benchreport) - Benchmark test case report.

### func runTests()

```cangjie
public func runTests(): TestReport
```

Function: Executes all unit test cases.

Returns:

- [TestReport](#class-testreport) - Unit test case report.

### func runTests(Configuration)

```cangjie
public func runTests(configuration: Configuration): TestReport
```

Function: Executes all unit test cases with runtime configuration.

Parameters:

- configuration: [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration) - Runtime configuration.

Returns:

- [TestReport](#class-testreport) - Unit test case report.

### static func builder(String)

```cangjie
public static func builder(name: String): TestGroupBuilder
```

Function: Creates a test group builder.

Parameters:

- name: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Test group name.

Returns:

- [TestGroupBuilder](#class-testgroupbuilder) - Test group builder.

### static func builder(TestGroup)

```cangjie
public static func builder(group: TestGroup): TestGroupBuilder
```

Function: Creates a test group builder.

Parameters:

- group: [TestGroup](#class-testgroup) - Test group.

Returns:

- [TestGroupBuilder](#class-testgroupbuilder) - Test group builder.

## class TestGroupBuilder

```cangjie
public class TestGroupBuilder {}
```

Function: Builder that provides methods for configuring test groups.

See example: [TestGroup](#class-testgroup).

### func add(Benchmark)

```cangjie
public func add(benchmark: Benchmark): TestGroupBuilder
```

Function: Adds a benchmark test case to the test group.

Parameters:

- benchmark: [Benchmark](#class-benchmark) - Benchmark test case.

Returns:

- [TestGroupBuilder](#class-testgroupbuilder) - Test group builder.

### func add(TestSuite)

```cangjie
public func add(suite: TestSuite): TestGroupBuilder
```

Function: Adds a test suite to the test group.

Parameters:

- suite: [TestSuite](#class-testsuite) - Test suite.

Returns:

- [TestGroupBuilder](#class-testgroupbuilder) - Test group builder.

### func add(UnitTestCase)

```cangjie
public func add(test: UnitTestCase): TestGroupBuilder
```

Function: Adds a unit test case to the test group.

Parameters:

- test: [UnitTestCase](#class-unittestcase) - Unit test case.

Returns:

- [TestGroupBuilder](#class-testgroupbuilder) - Test group builder.

### func build()

```cangjie
public func build(): TestGroup
```

Function: Builds the test group object after configuration.

Returns:

- [TestGroup](#class-testgroup) - Test group.

### func configure(Configuration)

```cangjie
public func configure(configuration: Configuration): TestGroupBuilder
```

Function: Configures the test group with configuration information.

Parameters:

- configuration: [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration) - Configuration information.

Returns:

- [TestGroupBuilder](#class-testgroupbuilder) - Test group builder.

### func setName(String)

```cangjie
public func setName(name: String): TestGroupBuilder
```

Function: Sets the name for the test group.

Parameters:

- name: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Name.

Returns:

- [TestGroupBuilder](#class-testgroupbuilder) - Test group builder.

## class TestPackage

```cangjie
public class TestPackage {
    public TestPackage(let name: String)
}
```

Function: Test package object.

### TestPackage(String)

```cangjie
public TestPackage(let name: String)
```

Function: TestPackage constructor.

Parameters:

- name: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Test package name.

### func registerCase(() -> UnitTestCase)

```cangjie
public func registerCase(testCase: () -> UnitTestCase): Unit
```

Function: Registers a unit test case.

Parameters:

- testCase: () -> [UnitTestCase](#class-unittestcase) - Unit test case generation closure.

### func registerSuite(() -> TestSuite)

```cangjie
public func registerSuite(suite: () -> TestSuite): Unit
```

Function: Registers a test suite.

Parameters:

- suite: () -> [TestSuite](#class-testsuite) - Test suite generation closure.

### func registerBench(() -> Benchmark)

```cangjie
public func registerBench(bench: () -> Benchmark): Unit
```

Function: Registers a benchmark case.

Parameters:

- bench: () -> [Benchmark](#class-benchmark) - Benchmark case generation closure.

### func enableOptimizedMockForBench()

```cangjie
public func enableOptimizedMockForBench(): Unit
```

Function: Enables optimization to use both mocks and benchmarks in tests.

## class TestReport

```cangjie
public class TestReport <: Report {}
```

Function: Unit test execution result report.

Parent Types:

- [Report](#class-report)

### func reportTo\<T>(Reporter\<TestReport, T>)

```cangjie
public func reportTo<T>(reporter: Reporter<TestReport, T>): T
```

Function: Prints the unit test execution report.

Parameters:

- reporter: [Reporter](#class-report)\<[TestReport](#class-testreport), T> - Unit test report printer.

Returns:

- T - Print return value, typically Unit.
 
## class TestSuite

```cangjie
public class TestSuite {}
```

Purpose: Provides a class for constructing and executing test suites.

Example:

<!-- run -->
```cangjie
import std.unittest.*
import std.unittest.testmacro.*

main() {
    let template = TestSuite
        .builder("template")
        .beforeEach({=> println("Starting case!")})
        .afterEach({name => println("Finished with ${name}")})
        .build()
    let suite = TestSuite
        .builder("suite")
        .template(template)
        .add(UnitTestCase.create("case1", body: {=> @Fail("failing case")}))
        .add(UnitTestCase.create("case2", body: {=> @Assert(1 + 2, 3)}))
        .add(Benchmark.create("bench", body: {=>}))
        .beforeAll({=> println("All tests are about to run!")})
        .afterAll({=> println("All tests are finished!")})
        .build()

    println("Running tests from ${suite.name}...")
    suite.runTests().reportTo(ConsoleReporter())

    println("Running benchmarks from ${suite.name}...")
    let conf = Configuration()
    conf.set(KeyWarmup.warmup, Duration.Zero)
    conf.set(KeyMinDuration.minDuration, Duration.nanosecond)
    suite.runBenchmarks(conf).reportTo(ConsoleReporter())
}
```

Possible output:

```text
Running tests from suite...
All tests are about to run!
Starting case!
Finished with case1
Starting case!
Finished with case2
All tests are finished!
--------------------------------------------------------------------------------------------------
TP: default, time elapsed: 349990 ns, RESULT:
    TCS: suite, time elapsed: 344021 ns, RESULT:
    [ PASSED ] CASE: case2 (10200 ns)
    [ FAILED ] CASE: case1 (38423 ns)
    Assert Failed: `(failing case)`

Summary: TOTAL: 2
    PASSED: 1, SKIPPED: 0, ERROR: 0
    FAILED: 1, listed below:
            TCS: suite, CASE: case1
--------------------------------------------------------------------------------------------------
Running benchmarks from suite...
All tests are about to run!
Starting case!
Starting the benchmark `suite.bench()`.
    Warming up for 0 ns.
    Starting measurements of 10 batches. Measuring Duration.
    Max batch size: 1, estimated execution time: 15.33 us.

Finished with bench
All tests are finished!
--------------------------------------------------------------------------------------------------
TP: default, time elapsed: 107250 ns, RESULT:
    TCS: suite, time elapsed: 106224 ns, RESULT:
    | Case   | Median |       Err |   Err% |     Mean |
    |:-------|-------:|----------:|-------:|---------:|
    | bench  |   0 ns | ±42.67 ns |  ±inf% | 15.50 ns |
    [ PASSED ] CASE: bench (5316 ns)
Summary: TOTAL: 1
    PASSED: 1, SKIPPED: 0, ERROR: 0
    FAILED: 0
--------------------------------------------------------------------------------------------------
```

### prop name

```cangjie
public prop name: String
```

Purpose: Gets the name of the test suite.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string).

### func runBenchmarks()

```cangjie
public func runBenchmarks(): BenchReport
```

Purpose: Runs all benchmark test cases.

Returns:

- [BenchReport](#class-benchreport) - Benchmark test execution results.

### func runBenchmarks(Configuration)

```cangjie
public func runBenchmarks(configuration: Configuration): BenchReport
```

Purpose: Runs all benchmark test cases with configuration.

Parameters:

- configuration: [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration) - Execution configuration.

Returns:

- [BenchReport](#class-benchreport) - Benchmark test execution results.

### func runTests()

```cangjie
public func runTests(): TestReport
```

Purpose: Executes the test suite.

Returns:

- [TestReport](#class-testreport) - Test suite execution results.

### func runTests(Configuration)

```cangjie
public func runTests(configuration: Configuration): TestReport
```

Purpose: Executes the test suite with configuration.

Parameters:

- configuration: [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration) - Execution configuration.

Returns:

- [TestReport](#class-testreport) - Test suite execution results.

### static func builder(String)

```cangjie
public static func builder(name: String): TestSuiteBuilder
```

Purpose: Creates a test suite builder.

Parameters:

- name: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Test suite name.

Returns:

- [TestSuiteBuilder](#class-testsuitebuilder) - Test suite builder.

### static func builder(TestSuite)

```cangjie
public static func builder(suite: TestSuite): TestSuiteBuilder
```

Purpose: Creates a test suite builder.

Parameters:

- suite: [TestSuite](#class-testsuite) - Test suite.

Returns:

- [TestSuiteBuilder](#class-testsuitebuilder) - Test suite builder.

## class TestSuiteBuilder

```cangjie
public class TestSuiteBuilder {}
```

Purpose: Provides a test suite builder for configuring test suite methods.

See example: [TestSuite](#class-testsuite).

### func add(Benchmark)

```cangjie
public func add(benchmark: Benchmark): TestSuiteBuilder
```

Purpose: Adds a benchmark test case to the test suite.

Parameters:

- benchmark: [Benchmark](#class-benchmark) - Benchmark test case.

Returns:

- [TestSuiteBuilder](#class-testsuitebuilder) - Test suite builder.

### func add(UnitTestCase)

```cangjie
public func add(test: UnitTestCase): TestSuiteBuilder
```

Purpose: Adds a unit test case to the test suite.

Parameters:

- test: [UnitTestCase](#class-unittestcase) - Unit test case.

Returns:

- [TestSuiteBuilder](#class-testsuitebuilder) - Test suite builder.

### func afterAll(() -> Unit)

```cangjie
public func afterAll(body: () -> Unit): TestSuiteBuilder
```

Purpose: Adds a lifecycle management closure to be executed after all test cases complete.

Parameters:

- body: () -> Unit - Execution body.

Returns:

- [TestSuiteBuilder](#class-testsuitebuilder) - Test suite builder.

### func afterEach(() -> Unit)

```cangjie
public func afterEach(body: () -> Unit): TestSuiteBuilder
```

Purpose: Adds a lifecycle management closure to be executed after each test case completes.

Parameters:

- body: () -> Unit - Execution body.

Returns:

- [TestSuiteBuilder](#class-testsuitebuilder) - Test suite builder.

### func afterEach((String) -> Unit)

```cangjie
public func afterEach(body: (String) -> Unit): TestSuiteBuilder
```

Purpose: Adds a lifecycle management closure to be executed after each test case completes.

Parameters:

- body: (String) -> Unit - Execution body.

Returns:

- [TestSuiteBuilder](#class-testsuitebuilder) - Test suite builder.

### func beforeAll(() -> Unit)

```cangjie
public func beforeAll(body: () -> Unit): TestSuiteBuilder
```

Purpose: Adds a lifecycle management closure to be executed before all test cases begin.

Parameters:

- body: () -> Unit - Execution body.

Returns:

- [TestSuiteBuilder](#class-testsuitebuilder) - Test suite builder.

### func beforeEach(() -> Unit)

```cangjie
public func beforeEach(body: () -> Unit): TestSuiteBuilder
```

Purpose: Adds a lifecycle management closure to be executed before each test case begins.

Parameters:

- body: () -> Unit - Execution body.

Returns:

- [TestSuiteBuilder](#class-testsuitebuilder) - Test suite builder.

### func beforeEach((String) -> Unit)

```cangjie
public func beforeEach(body: (String) -> Unit): TestSuiteBuilder
```

Purpose: Adds a lifecycle management closure to be executed before each test case begins.

Parameters:

- body: (String) -> Unit - Execution body.

Returns:

- [TestSuiteBuilder](#class-testsuitebuilder) - Test suite builder.

### func template(TestSuite)

```cangjie
public func template(template: TestSuite): TestSuiteBuilder
```

Purpose: Sets a template for the test suite.

Parameters:

- template: TestSuite - The test suite to use as template.

Returns:

- [TestSuiteBuilder](#class-testsuitebuilder) - Test suite builder.

### func build()

```cangjie
public func build(): TestSuite
```

Purpose: Constructs the test suite after configuration.

Returns:

- [TestSuite](#class-testsuite) - The test suite.

### func configure(Configuration)

```cangjie
public func configure(configuration: Configuration): TestSuiteBuilder
```

Purpose: Adds configuration information to the test suite.

Parameters:

- configuration: [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration) - Test configuration.

Returns:

- [TestSuiteBuilder](#class-testsuitebuilder) - Test suite builder.

### func setName(String)

```cangjie
public func setName(name: String): TestSuiteBuilder
```

Purpose: Sets the name for the test suite.

Parameters:

- name: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Test suite name.

Returns:

- [TestSuiteBuilder](#class-testsuitebuilder) - Test suite builder.

## class UnitTestCase

```cangjie
public class UnitTestCase {}
```

Purpose: Provides methods for creating and executing unit test cases.

Example:

<!-- run -->
```cangjie
import std.unittest.*
import std.unittest.testmacro.*

main() {
    let testCase = UnitTestCase.create("ordinary", body: {
        => @Fail("failing test")
    })

    println("Running ${testCase.name}...")
    testCase.run().reportTo(ConsoleReporter())
    let parametrizedTestCase = UnitTestCase.createParameterized(
        "parametrized",
        [1, 2, 3],
        body: {x => @Assert(1 <= x && x <= 3)}
    )

    println("Running ${parametrizedTestCase.name}...")
    parametrizedTestCase.run().reportTo(ConsoleReporter())
}
```

Possible output:

```text
Running ordinary...
--------------------------------------------------------------------------------------------------
TP: default, time elapsed: 294492 ns, RESULT:
    TCS: TestCase_ordinary, time elapsed: 289499 ns, RESULT:
    [ FAILED ] CASE: ordinary (35884 ns)
    Assert Failed: `(failing test)`

Summary: TOTAL: 1
    PASSED: 0, SKIPPED: 0, ERROR: 0
    FAILED: 1, listed below:
            TCS: TestCase_ordinary, CASE: ordinary
--------------------------------------------------------------------------------------------------
Running parametrized...
--------------------------------------------------------------------------------------------------
TP: default, time elapsed: 113318 ns, RESULT:
    TCS: TestCase_parametrized, time elapsed: 111489 ns, RESULT:
    [ PASSED ] CASE: parametrized (21603 ns)
Summary: TOTAL: 1
    PASSED: 1, SKIPPED: 0, ERROR: 0
    FAILED: 0
--------------------------------------------------------------------------------------------------
```

### prop name

```cangjie
public prop name: String
```

Purpose: Gets the name of the unit test.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string).

### func run()

```cangjie
public func run(): TestReport
```

Purpose: Executes the unit test case.

Returns:

- [TestReport](#class-testreport) - Unit test execution report.

### static func create(String, Configuration, () -> Unit)

```cangjie
public static func create(
    name: String,
    configuration!: Configuration = Configuration(),
    body!: () -> Unit
): UnitTestCase
```

Purpose: Creates a unit test case.

Parameters:

- name: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Test case name.
- configuration!: [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration) - Test case configuration.
- body!: () -> Unit - Test case execution body.

Returns:

- [UnitTestCase](#class-unittestcase) - Unit test case object.

### static func createParameterized\<T>(String, DataStrategy\<T>, Configuration, (T) -> Unit)

```cangjie
public static func createParameterized<T>(
    name: String,
    strategy: DataStrategy<T>,
    configuration!: Configuration = Configuration(),
    body!: (T) -> Unit
): UnitTestCase
```

Purpose: Creates a parameterized unit test case.

Parameters:

- name: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Test case name.
- strategy: [DataStrategy](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-datastrategy) - Parameter data strategy.
- configuration!: [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration) - Test case configuration.
- body!: () -> Unit - Test case execution body.

Returns:

- [UnitTestCase](#class-unittestcase) - Unit test case object.

### static func createParameterized\<T>(String, DataStrategyProcessor\<T>, Configuration, (T) -> Unit)

```cangjie
public static func createParameterized<T>(
    name: String,
    strategy: DataStrategyProcessor<T>,
    configuration!: Configuration = Configuration(),
    body!: (T) -> Unit
): UnitTestCase
```

Purpose: Creates a parameterized unit test case.

Parameters:

- name: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Test case name.
- strategy: [DataStrategyProcessor](#class-datastrategyprocessort) - Parameter data processor.
- configuration!: [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration) - Test case configuration.
- body!: () -> Unit - Test case execution body.

Returns:

- [UnitTestCase](#class-unittestcase) - Unit test case object.
 
## class XmlReporter

```cangjie
public class XmlReporter <: Reporter<TestReport, Unit> {
    public XmlReporter(let directory: Path)
}
```

Function: Outputs unit test case result data to XML files.

Parent Types:

- [Reporter](unittest_package_interfaces.md#interface-reporter)\<[TestReport](#class-testreport), [Unit](../../core/core_package_api/core_package_intrinsics.md#unit)>

Example:

<!-- run -->
```cangjie
import std.fs.*
import std.unittest.*
import std.unittest.testmacro.*

main() {
    let testCase = UnitTestCase.create("testCase", body: {
        => @Fail("failing example")
    })
    let suite1 = TestSuite.builder("suite1").add(testCase).build()
    let suite2 = TestSuite.builder("suite2").build()
    let group = TestGroup.builder("group").add(suite1).add(suite2).build()
    group.runTests().reportTo(XmlReporter(Path(".")))
    let report1 = File.readFrom("./tests/test-group.suite1.xml") |> String.fromUtf8
    let report2 = File.readFrom("./tests/test-group.suite2.xml") |> String.fromUtf8
    println(report1)
    println(report2)
}
```

Possible output:

```text
<?xml version="1.0" encoding="UTF-8"?>
<>
        <testsuite name="group.suite1" tests="1" failures="1" errors="0" skipped="0" time="0.000350" timestamp="2025-12-30T16:27:15.005019525+03:00">
                <testcase name="testCase" classname="group.suite1" assertions="1" time="0.000045">
                        <failure>Assert Failed: `(failing example)`</failure>
                </testcase>
        </testsuite>
</>

<?xml version="1.0" encoding="UTF-8"?>
<>
        <testsuite name="group.suite2" tests="0" failures="0" errors="0" skipped="0" time="0.000000" timestamp="2025-12-30T16:27:15.00537593+03:00"/>
</>
```

### XmlReporter(Path)

```cangjie
public XmlReporter(let directory: Path)
```

Function: Constructor for XmlReporter.

Parameters:

- directory: [Path](../../fs/fs_package_api/fs_package_structs.md#struct-path) - The output file generation path.

## class XmlPerPackageReporter

```cangjie
public class XmlPerPackageReporter <: Reporter<TestReport, Unit> {
    public XmlPerPackageReporter(let directory: Path)
}
```

Function: Outputs unit test case result data to XML files per package.

Parent Types:

- [Reporter](unittest_package_interfaces.md#interface-reporter)\<[TestReport](#class-testreport), [Unit](../../core/core_package_api/core_package_intrinsics.md#unit)>

Example:

<!-- run -->
```cangjie
import std.fs.*
import std.unittest.*
import std.unittest.testmacro.*

main() {
    let testCase = UnitTestCase.create("testCase", body: {
        => @Fail("failing example")
    })
    let suite1 = TestSuite.builder("suite1").add(testCase).build()
    let suite2 = TestSuite.builder("suite2").build()
    let group = TestGroup.builder("group").add(suite1).add(suite2).build()
    group.runTests().reportTo(XmlPerPackageReporter(Path(".")))
    let report = File.readFrom("./tests/test-group.xml") |> String.fromUtf8
    println(report)
}
```

Possible output:

```text
<?xml version="1.0" encoding="UTF-8"?>
<testsuites name="group" tests="1" failures="1" errors="0" skipped="0" time="0.000288" timestamp="2025-12-30T16:28:16.852259739+03:00">
        <testsuite name="group.suite1" tests="1" failures="1" errors="0" skipped="0" time="0.000280" timestamp="2025-12-30T16:28:16.852264581+03:00">
                <testcase name="testCase" classname="group.suite1" assertions="1" time="0.000046">
                        <failure>Assert Failed: `(failing example)`</failure>
                </testcase>
        </testsuite>
        <testsuite name="group.suite2" tests="0" failures="0" errors="0" skipped="0" time="0.000000" timestamp="2025-12-30T16:28:16.852547919+03:00"/>
</testsuites>
```

### XmlPerPackageReporter(Path)

```cangjie
public XmlPerPackageReporter(let directory: Path)
```

Function: Constructor for XmlPerPackageReporter.

Parameters:

- directory: [Path](../../fs/fs_package_api/fs_package_structs.md#struct-path) - The output file generation path.
