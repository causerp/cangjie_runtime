
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

Function: Returns `true` if any assertion within the user-defined function fails, otherwise `false`.

Type: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool)

### func arg(String)

```cangjie
public func arg(key: String): String
```

Function: Returns the string representation of the parameter value corresponding to the passed identifier, matching the identifier in the parameter list.

Parameters:

- key: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The identifier in the function parameter list.

Return Value:

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

- pt: PP <: [PrettyPrintable](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-prettyprintable) - The failure information.

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

- pt: PP <: [PrettyPrintable](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-prettyprintable) - The failure information.

### func setArgsAliases(Array\<String>)

```cangjie
public func setArgsAliases(aliases: Array<String>): Unit
```

Function: Sets aliases for accessing unresolved user-defined assertion function parameters via the [`arg`](#func-argstring) function. For framework internal use only; users do not need to call this function.

Parameters:

- aliases: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[String](../../core/core_package_api/core_package_structs.md#struct-string)> - An array of identifiers. The array size should match the parameter list (excluding [`AssertionCtx`](#class-assertionctx)).

## class Benchmark

```cangjie
public class Benchmark {}
```

Function: This class provides methods for creating and running individual performance test cases.

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

Return Value:

- [BenchReport](#class-benchreport) - The execution result report.

### static func create(String, Configuration, () -> Unit)

```cangjie
public static func create(
    name: String,
    configuration!: Configuration = Configuration(),
    body!: () -> Unit
): Benchmark
```

Function: Creates a performance test case object.

Parameters:

- name: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The test case name.
- configuration!: [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration) - The test case configuration.
- body!: () -> Unit - The test case execution body.

Return Value:

- [Benchmark](#class-benchmark) - The performance test case object.

### static func createParameterized\<T>(String, DataStrategy\<T>, Configuration, (T) -> Unit)

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
- configuration!: [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration) - The test case configuration.
- measurement!: [Measurement](unittest_package_interfaces.md#interface-measurement) - The measurement method.
- body!: () -> Unit - The test case execution body.

Return Value:

- [Benchmark](#class-benchmark) - The performance test case object.

### static func createParameterized\<T>(String, DataStrategyProcessor\<T>, Configuration, (T) -> Unit)

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
- configuration!: [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration) - The test case configuration.
- measurement!: [Measurement](unittest_package_interfaces.md#interface-measurement) - The measurement method.
- body!: () -> Unit - The test case execution body.

Return Value:

- [Benchmark](#class-benchmark) - The performance test case object.

## class BenchReport

```cangjie
public class BenchReport <: Report {}
```

Function: Provides capabilities for processing performance test case execution result reports.

Parent Types:

- [Report](#class-report)

### func reportTo\<T>(Reporter\<BenchReport, T>)

```cangjie
public func reportTo<T>(reporter: Reporter<BenchReport, T>): T
```

Function: Prints the performance test case result report.

Parameters:

- reporter: [Reporter](#class-report)<[BenchReport](#class-benchreport), T> - The performance test case result report.

Return Value:

- T: The return value of the print operation. Typically of type Unit.

## class CartesianProductProcessor\<T0,T1>

```cangjie
public class CartesianProductProcessor<T0,T1> <: DataStrategyProcessor<(T0,T1)> {
    public CartesianProductProcessor(let left: DataStrategyProcessor<T0>, let right: DataStrategyProcessor<T1>)
}
```

Function: Cartesian product processor.

Parent Types:

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

### ConsoleReporter(Bool)

```cangjie
public ConsoleReporter(let colored!: Bool = true)
```

Function: ConsoleReporter constructor.

Parameters:
- colored!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether to use colored printing, colored by default.

## class TextReporter\<PP>

```cangjie
public class TextReporter<PP> <: Reporter<TestReport, PP> & Reporter<BenchReport, PP> where PP <: PrettyPrinter {
    public TextReporter(let into!: PP)
}
```

Function: Prints unit test case results or benchmark results to a subclass of [PrettyPrinter](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-prettyprinter). The format is identical to [ConsoleReporter](#class-consolereporter).

Parent Types:

- [Reporter](unittest_package_interfaces.md#interface-reporter)\<[TestReport](#class-testreport), PP>
- [Reporter](unittest_package_interfaces.md#interface-reporter)\<[BenchReport](#class-benchreport), PP>

### TextReporter(PP)

```cangjie
public TextReporter(let into!: PP)
```

Function: TextReporter constructor.

Parameters:

- into!: PP - A subclass of [PrettyPrinter](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-prettyprinter). Used to print reports.

## class CsvReporter

```cangjie
public class CsvReporter <: Reporter<BenchReport, Unit> {
    public CsvReporter(let directory: Path)
}
```

Function: Prints benchmark test case result data to CSV files.

Parent Types:

- [Reporter](unittest_package_interfaces.md#interface-reporter)\<[BenchReport](#class-benchreport), [Unit](../../core/core_package_api/core_package_intrinsics.md#unit)>

### CsvReporter(Path)

```cangjie
public CsvReporter(let directory: Path)
```

Function: CsvReporter constructor.

Parameters:

- directory: [Path](../../fs/fs_package_api/fs_package_structs.md#struct-path) - The output directory for generated files.

## class CsvRawReporter

```cangjie
public class CsvRawReporter <: Reporter<BenchReport, Unit> {
    public CsvRawReporter(let directory: Path)
}
```

Function: Prints benchmark test case result data containing only raw measurement values for batches to CSV files.

Parent Types:

- [Reporter](unittest_package_interfaces.md#interface-reporter)\<[BenchReport](#class-benchreport), [Unit](../../core/core_package_api/core_package_intrinsics.md#unit)>

### CsvRawReporter(Path)

```cangjie
public CsvRawReporter(let directory: Path)
```

Function: CsvRawReporter constructor.

Parameters:

- directory: [Path](../../fs/fs_package_api/fs_package_structs.md#struct-path) - The output directory for generated files.

## class DataStrategyProcessor\<T>

```cangjie
abstract sealed class DataStrategyProcessor<T> {}
```

Function: Base class for all [DataStrategy](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-datastrategy) components. Instances of this class are created by the [@Strategy](../../unittest_testmacro/unittest_testmacro_package_api/unittest_testmacro_package_macros.md#strategy-macro) macro or member functions.

### prop isInfinite

```cangjie
protected prop isInfinite: Bool
```

Function: Gets whether the strategy is infinite.

Type: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool).

### func intoBenchmark(String, Configuration, (T, Int64, Int64) -> Float64)

```cangjie
public func intoBenchmark(
    caseName!: String,
    configuration!: Configuration,
    doRun!: (T, Int64, Int64) -> Float64
): Benchmark
```

Function: Helper function used by macro-generated code. Creates a benchmark test case using this strategy.

Parameters:

- caseName!: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Test case name.
- configuration!: [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration) - Configuration information.
- doRun!: (T, Int64, Int64) -> Float64 - Benchmark test case execution body.

Return Value:

- [Benchmark](#class-benchmark) - Benchmark test case object.

### func intoUnitTestCase(String, Configuration, (T) -> Unit)

```cangjie
public func intoUnitTestCase(
    caseName!: String,
    configuration!: Configuration,
    doRun!: (T) -> Unit
): UnitTestCase
```

Function: Helper function used by macro-generated code. Creates a test case using this strategy.

Parameters:

- caseName!: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Test case name.
- configuration!: [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration) - Configuration information.
- doRun!: (T) -> Unit - Test case execution body.

Return Value:

- [UnitTestCase](#class-unittestcase) - Test case object.

### func lastItemInfo()

```cangjie
protected func lastItemInfo(): Array<InputParameter>
```

Function: Gets information about the last processed item.

Return Value:

- Array<[InputParameter](./unittest_package_classes.md#class-inputparameter)> - Information about the last processed item.

### func lastItem(Configuration)

```cangjie
protected func lastItem(configuration: Configuration): T
```

Function: Gets the last processed item.

Parameters:

- configuration : [Configuration](./../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration) - Processing strategy configuration information.

Return Value:

- T - The last processed item.

### func provide(Configuration)

```cangjie
protected func provide(configuration: Configuration): Iterable<T>
```

Function: Generates a data iterator based on configuration information and data strategy.

Parameters:

- configuration : [Configuration](./../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration) - Processing strategy configuration information.

Return Value:

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - Data iterator.

### func shrinkLastItem(Configuration, LazyCyclicNode)

```cangjie
protected func shrinkLastItem(configuration: Configuration, engine: LazyCyclicNode): Iterable<T>
```

Function: Shrinks the last item.

Parameters:

- configuration:[Configuration](./../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration) - Configuration information.
- engine : [LazyCyclicNode](./unittest_package_classes.md#class-lazycyclicnode) - Lazy node.

Return Value:

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - Shrunk data iterator.

### static func start(DataStrategy\<T>, String)

```cangjie
public static func start(s: DataStrategy<T>, name: String): SimpleProcessor<T>
```

Function: Starting point for composition and mapping of [DataStrategy](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-datastrategy).

Parameters:

- s: [DataStrategy](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-datastrategy)\<T> - Data strategy.
- name: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Test case name.

Return Value:

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

Return Value:

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

Return Value:

- [SimpleProcessor\<T>](#class-simpleprocessort) - Test case processor.

### static func start(() -> DataStrategyProcessor\<T>, String)

```cangjie
public static func start(f: () -> DataStrategyProcessor<T>, name: String): DataStrategyProcessor<T>
```

Function: Starting point for composition and mapping of [DataStrategy](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-datastrategy).

Parameters:

- s: () -> [DataStrategyProcessor](#class-datastrategyprocessort)\<T> - Closure that generates a data strategy processor.
- name: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Test case name.

Return Value:

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

Return Value:- [DataStrategyProcessor](#class-datastrategyprocessort)\<U> where U <: [BenchInputProvider](./unittest_package_interfaces.md#interface-benchinputprovider)\<T> - Data Strategy Processor.

### extend \<T> DataStrategyProcessor\<T>

```cangjie
extend <T> DataStrategyProcessor<T> {}
```

#### func map\<R>((T) -> R)

```cangjie
public func map<R>(f: (T) -> R): MapProcessor<T, R>
```

Function: Simply applies `f` to each item of the original data strategy. [Shrink](../../unittest_prop_test/unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-shrinkt) occurs on the original input before mapping.

Parameters:

- f: (T) -> R - The processing logic function to be added.

Return Value:

- [MapProcessor\<T, R>](#class-mapprocessortr) - The processor after applying `f`.

#### func mapWithConfig\<R>((T, Configuration) -> R)

```cangjie
public func mapWithConfig<R>(f: (T, Configuration) -> R): MapProcessor<T, R>
```

Function: Can access the current [Configuration](./../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration), simply applies `f` to each item of the original data strategy. [Shrink](../../unittest_prop_test/unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-shrinkt) occurs on the original input before mapping.

Parameters:

- f: (T, Configuration) -> R - The processing logic function to be added.

Return Value:

- [MapProcessor\<T, R>](#class-mapprocessortr) - The processor after applying `f`.

#### func flatMap\<R>((T) -> DataProvider\<R>)

```cangjie
public func flatMap<R>(f: (T) -> DataProvider<R>): FlatMapProcessor<T, R>
```

Function: Simply applies `f` to each item of the original data strategy, then flattens the result. [Shrink](../../unittest_prop_test/unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-shrinkt) occurs on the original input before [flatMap](../../collection/collection_package_api/collection_package_function.md#func-flatmapt-r-t---iterabler).

Parameters:

- f: (T) -> [DataProvider](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-datastrategy)\<R> - The processing logic function to be added.

Return Value:

- [FlatMapProcessor\<T, R>](#class-flatmapprocessortr) - The processor after applying `f`.

#### func flatMapStrategy((T) -> DataStrategy\<R>)

```cangjie
public func flatMapStrategy<R>(f: (T) -> DataStrategy<R>): FlatMapStrategyProcessor<T, R>
```

Function: Simply applies `f` to each item of the original data strategy, then flattens the result. [Shrink](../../unittest_prop_test/unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-shrinkt) is performed using the returned strategy rather than the original input.

Parameters:

- f: (T) -> [DataStrategy](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-datastrategy)\<R> - The processing logic function to be added.

Return Value:

- [FlatMapStrategyProcessor\<T, R>](#class-flatmapstrategyprocessortr) - The processor after applying `f`.

#### func product(DataStrategyProcessor\<R>)

```cangjie
public func product<R>(p: DataStrategyProcessor<R>): CartesianProductProcessor<T, R>
```

Function: Cartesian product combinator that creates a data strategy containing all possible permutations of elements from the original strategies. For infinite strategies, it first iterates through all finite substructures before advancing infinite ones. [Shrink](../../unittest_prop_test/unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-shrinkt) occurs independently and uniformly on each element of the original strategy.

Parameters:

- p: [DataStrategyProcessor](#class-datastrategyprocessort)\<R> - The data strategy processor.

Return Value:

- [CartesianProductProcessor\<T, R>](#class-cartesianproductprocessort0t1) - The Cartesian product processor.

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

Function: Internal lazy iterator used for type-erased sequential advancement in a cycle.

### func advance()

```cangjie
protected open func advance(): ?Unit
```

Function: Advances one value.

Return Value:

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

- value: T - The data to be recorded.
- exprAsText: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Expression string.
- position: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Position information.

Return Value:

- T - The recorded data.

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

- value: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The data to be recorded.
- exprAsText: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Expression string.
- position: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Position information.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The recorded data.

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

- value: [Rune](../../core/core_package_api/core_package_intrinsics.md#rune) - The data to be recorded.
- exprAsText: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Expression string.
- position: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Position information.

Return Value:

- [Rune](../../core/core_package_api/core_package_structs.md#struct-string) - The recorded data.

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

- exception: Exception - The exception to be handled.
- exprAsText: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Expression string.
- position: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Position information.

### func w(Bool)

```cangjie
public func w(passed: Bool): Unit
```

Function: Returns success result when the test case passes, throws an exception and prints comparison results when it fails.

Parameters:

- passed: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether the test case passed.

## class RandomDataProvider\<T>

```cangjie
public class RandomDataProvider<T> <: DataProvider<T> where T <: Arbitrary<T> {
    public RandomDataProvider(private let configuration: Configuration)
}
```

Function: Implementation of the [DataProvider](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-dataprovider) interface using random data generation.

Parent Type:

- [DataProvider](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-dataprovider)\<T>

### RandomDataProvider(Configuration)

```cangjie
public RandomDataProvider(private let configuration: Configuration)
```
Function: Constructs an object of the RandomDataProvider.

Parameters:

- configuration: [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration) - A configuration object that must contain a random generator named `random` of type random.[Random](../../random/random_package_api/random_package_classes.md#class-random).

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the configuration does not contain a random instance.

### prop isInfinite

```cangjie
public override prop isInfinite: Bool
```

Function: Indicates whether infinite data is generated.

Type: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool).

### func provide()

```cangjie
public override func provide(): Iterable<T>
```

Function: Provides randomly generated data.

Return value:

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - An infinite iterator created from arbitrary instances of T.

## class RandomDataShrinker\<T>

```cangjie
public class RandomDataShrinker<T> <: DataShrinker<T> {}
```

Function: An implementation of the [DataShrinker](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-datashrinkert) interface using random data generation.

Parent type:

- [DataShrinker](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-datashrinkert)\<T>

### func shrinker(T)

```cangjie
public override func shrink(value: T): Iterable<T>
```

Function: Gets a shrinker for the value.

Parameters:

- value: T - The parameter value.

Return value:

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - Returns a shrunk iterator if the parameter implements the [Shrink](../../unittest_prop_test/unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-shrinkt) interface; otherwise, returns an empty array.

## class RandomDataStrategy\<T>

```cangjie
public class RandomDataStrategy<T> <: DataStrategy<T> where T <: Arbitrary<T>{}
```

Function: An implementation of the [DataStrategy](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-datastrategy) interface using random data generation.

Parent type:

- [DataStrategy](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-datastrategy)\<T>

### func provider(Configuration)

```cangjie
public override func provider(configuration: Configuration): RandomDataProvider<T>
```

Function: Gets a provider for random data.

Parameters:

- configuration: [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration) - Configuration information.

Return value:

- [RandomDataProvider](unittest_package_classes.md#class-randomdataprovidert) - A random data provider.

### func shrinker(Configuration)

```cangjie
public override func shrinker(_: Configuration): RandomDataShrinker<T>
```

Function: Gets a shrinker for random data.

Parameters:

- _: [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration) - Configuration information.

Return value:

- [RandomDataShrinker](unittest_package_classes.md#class-randomdatashrinkert) - A random data shrinker.

## class Report

```cangjie
sealed abstract class Report {}
```

Function: Base class for printing test case result reports.

### prop errorCount

```cangjie
public prop errorCount: Int64
```

Function: Gets the number of error cases.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64).

### prop caseCount

```cangjie
public prop caseCount: Int64
```

Function: Gets the number of test cases.

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

Parent types:

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

Function: A simple data strategy processor. An implementation of [DataStrategyProcessor](#class-datastrategyprocessort).

Parent type:

- [DataStrategyProcessor](#class-datastrategyprocessort)\<T>

### SimpleProcessor(() -> DataStrategy\<T>, String)

```cangjie
public SimpleProcessor(let buildDelegate:() -> DataStrategy<T>, let name: String)
```

Function: SimpleProcessor constructor.

Parameters:

- buildDelegate : () -> [DataStrategy](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-datastrategy)\<T> - A closure that generates a data strategy.
- name : [String](../../core/core_package_api/core_package_structs.md#struct-string) - The processor name.

## class TestGroup

```cangjie
public class TestGroup {}
```

Function: Provides methods for building and running test groups.

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

Return value:

- [BenchReport](#class-benchreport) - Benchmark test case report.

### func runBenchmarks(Configuration)

```cangjie
public func runBenchmarks(Configuration): BenchReport
```

Function: Executes all benchmark test cases with a runtime configuration.

Parameters:

- configuration: [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration) - Runtime configuration.

Return value:

- [BenchReport](#class-benchreport) - Benchmark test case report.

### func runTests()

```cangjie
public func runTests(): TestReport
```

Function: Executes all unit test cases.

Return value:

- [TestReport](#class-testreport) - Unit test case report.

### func runTests(Configuration)

```cangjie
public func runTests(configuration: Configuration): TestReport
```

Function: Executes all unit test cases with a runtime configuration.

Parameters:

- configuration: [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration) - Runtime configuration.

Return value:

- [TestReport](#class-testreport) - Unit test case report.

### static func builder(String)

```cangjie
public static func builder(name: String): TestGroupBuilder
```

Function: Creates a test group builder.

Parameters:

- name : [String](../../core/core_package_api/core_package_structs.md#struct-string) - Test group name.

Return value:

- [TestGroupBuilder](#class-testgroupbuilder) - Test group builder.

### static func builder(TestGroup)

```cangjie
public static func builder(group: TestGroup): TestGroupBuilder
```

Function: Creates a test group builder.

Parameters:

- group : [TestGroup](#class-testgroup) - The test group.

Return Value:

- [TestGroupBuilder](#class-testgroupbuilder) - The test group builder.

## class TestGroupBuilder

```cangjie
public class TestGroupBuilder {}
```

Function: A builder that provides methods for configuring test groups.

### func add(Benchmark)

```cangjie
public func add(benchmark: Benchmark): TestGroupBuilder
```

Function: Adds a benchmark test case to the test group.

Parameters:

- benchmark : [Benchmark](#class-benchmark) - The benchmark test case.

Return Value:

- [TestGroupBuilder](#class-testgroupbuilder) - The test group builder.

### func add(TestSuite)

```cangjie
public func add(suite: TestSuite): TestGroupBuilder
```

Function: Adds a unit test suite to the test group.

Parameters:

- suite : [TestSuite](#class-testsuite) - The unit test suite.

Return Value:

- [TestGroupBuilder](#class-testgroupbuilder) - The test group builder.

### func add(UnitTestCase)

```cangjie
public func add(test: UnitTestCase): TestGroupBuilder
```

Function: Adds a unit test case to the test group.

Parameters:

- test : [UnitTestCase](#class-unittestcase) - The unit test case.

Return Value:

- [TestGroupBuilder](#class-testgroupbuilder) - The test group builder.

### func build()

```cangjie
public func build(): TestGroup
```

Function: Constructs the test group object after configuration.

Return Value:

- [TestGroup](#class-testgroup) - The test group.

### func configure(Configuration)

```cangjie
public func configure(configuration: Configuration): TestGroupBuilder
```

Function: Configures the test group with configuration information.

Parameters:

- configuration : [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration) - The configuration information.

Return Value:

- [TestGroupBuilder](#class-testgroupbuilder) - The test group builder.

### func setName(String)

```cangjie
public func setName(name: String): TestGroupBuilder
```

Function: Sets the name for the test group.

Parameters:

- name : [String](../../core/core_package_api/core_package_structs.md#struct-string) - The name.

Return Value:

- [TestGroupBuilder](#class-testgroupbuilder) - The test group builder.

## class TestPackage

```cangjie
public class TestPackage {
    public TestPackage(let name: String)
}
```

Function: A test package object.

### TestPackage(String)

```cangjie
public TestPackage(let name: String)
```

Function: TestPackage constructor.

Parameters:

- name: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The name of the test package.

### func registerCase(() -> UnitTestCase)

```cangjie
public func registerCase(testCase: () -> UnitTestCase): Unit
```

Function: Registers a unit test case.

Parameters:

- testCase: () -> [UnitTestCase](#class-unittestcase) - A closure that generates the unit test case.

### func registerSuite(() -> TestSuite)

```cangjie
public func registerSuite(suite: () -> TestSuite): Unit
```

Function: Registers a test suite.

Parameters:

- suite: () -> [TestSuite](#class-testsuite) - A closure that generates the test suite.

### func registerBench(() -> Benchmark)

```cangjie
public func registerBench(bench: () -> Benchmark): Unit
```

Function: Registers a benchmark test case.

Parameters:

- bench: () -> [Benchmark](#class-benchmark) - A closure that generates the benchmark test case.

## class TestReport

```cangjie
public class TestReport <: Report {}
```

Function: A report of unit test execution results.

Parent Type:

- [Report](#class-report)

### func reportTo\<T>(Reporter\<TestReport, T>)

```cangjie
public func reportTo<T>(reporter: Reporter<TestReport, T>): T
```

Function: Prints the unit test execution report.

Parameters:

- reporter : [Reporter](#class-report)<[TestReport](#class-testreport), T> - The unit test report printer.

Return Value:

- T : The return value of printing, typically Unit.

## class TestSuite

```cangjie
public class TestSuite {}
```

Function: A class that provides methods for building and executing test suites.

### prop name

```cangjie
public prop name: String
```

Function: Gets the name of the test suite.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string).

### func runBenchmarks()

```cangjie
public func runBenchmarks(): BenchReport
```

Function: Runs all benchmark test cases.

Return Value:

- [BenchReport](#class-benchreport) - The result of benchmark test execution.

### func runBenchmarks(Configuration)

```cangjie
public func runBenchmarks(configuration: Configuration): BenchReport
```

Function: Runs all benchmark test cases with configuration information.

Parameters:

- configuration : [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration) - The runtime configuration information.

Return Value:

- [BenchReport](#class-benchreport) - The result of benchmark test execution.

### func runTests()

```cangjie
public func runTests(): TestReport
```

Function: Runs the test suite.

Return Value:

- [TestReport](#class-testreport) - The result of test suite execution.

### func runTests(Configuration)

```cangjie
public func runTests(configuration: Configuration): TestReport
```

Function: Runs the test suite with configuration information.

Parameters:

- configuration : [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration) - The runtime configuration information.

Return Value:

- [TestReport](#class-testreport) - The result of test suite execution.

### static func builder(String)

```cangjie
public static func builder(name: String): TestSuiteBuilder
```

Function: Creates a test suite builder.

Parameters:

- name : [String](../../core/core_package_api/core_package_structs.md#struct-string) - The name of the test suite.

Return Value:

- [TestSuiteBuilder](#class-testsuitebuilder) - The test suite builder.

### static func builder(TestSuite)

```cangjie
public static func builder(suite: TestSuite): TestSuiteBuilder
```

Function: Creates a test suite builder.Parameters:

- suite : [TestSuite](#class-testsuite) - Test suite.

Return Value:

- [TestSuiteBuilder](#class-testsuitebuilder) - Test suite builder.

## class TestSuiteBuilder

```cangjie
public class TestSuiteBuilder {}
```

Function: Provides a test suite builder for configuring test suite methods.

### func add(Benchmark)

```cangjie
public func add(benchmark: Benchmark): TestSuiteBuilder
```

Function: Adds a benchmark test case to the test suite.

Parameters:

- benchmark : [Benchmark](#class-benchmark) - Benchmark test case.

Return Value:

- [TestGroupBuilder](#class-testgroupbuilder) - Test group builder.

### func add(UnitTestCase)

```cangjie
public func add(test: UnitTestCase): TestSuiteBuilder
```

Function: Adds a unit test case to the test suite.

Parameters:

- test : [UnitTestCase](#class-unittestcase) - Unit test case.

Return Value:

- [TestGroupBuilder](#class-testgroupbuilder) - Test group builder.

### func afterAll(() -> Unit)

```cangjie
public func afterAll(body: () -> Unit): TestSuiteBuilder
```

Function: Adds a lifecycle management closure to be executed after all test cases complete.

Parameters:

- body : () -> Unit - Execution body.

Return Value:

- [TestGroupBuilder](#class-testgroupbuilder) - Test group builder.

### func afterEach(() -> Unit)

```cangjie
public func afterEach(body: () -> Unit): TestSuiteBuilder
```

Function: Adds a lifecycle management closure to be executed after each test case completes.

Parameters:

- body : () -> Unit - Execution body.

Return Value:

- [TestGroupBuilder](#class-testgroupbuilder) - Test group builder.

### func afterEach((String) -> Unit)

```cangjie
public func afterEach(body: (String) -> Unit): TestSuiteBuilder
```

Function: Adds a lifecycle management closure to be executed after each test case completes.

Parameters:

- body : (String) -> Unit - Execution body.

Return Value:

- [TestGroupBuilder](#class-testgroupbuilder) - Test group builder.

### func beforeAll(() -> Unit)

```cangjie
public func beforeAll(body: () -> Unit): TestSuiteBuilder
```

Function: Adds a lifecycle management closure to be executed before all test cases run.

Parameters:

- body : () -> Unit - Execution body.

Return Value:

- [TestGroupBuilder](#class-testgroupbuilder) - Test group builder.

### func beforeEach(() -> Unit)

```cangjie
public func beforeEach(body: () -> Unit): TestSuiteBuilder
```

Function: Adds a lifecycle management closure to be executed before each test case runs.

Parameters:

- body : () -> Unit - Execution body.

Return Value:

- [TestGroupBuilder](#class-testgroupbuilder) - Test group builder.

### func beforeEach((String) -> Unit)

```cangjie
public func beforeEach(body: (String) -> Unit): TestSuiteBuilder
```

Function: Adds a lifecycle management closure to be executed before each test case runs.

Parameters:

- body : (String) -> Unit - Execution body.

Return Value:

- [TestGroupBuilder](#class-testgroupbuilder) - Test group builder.

### func template(TestSuite)

```cangjie
public func template(template: TestSuite): TestSuiteBuilder
```

Function: Sets a template for the test suite.

Parameters:

- template : TestSuite - Test suite to be used as template.

Return Value:

- [TestGroupBuilder](#class-testgroupbuilder) - Test group builder.

### func build()

```cangjie
public func build(): TestSuite
```

Function: Constructs the test suite after configuration.

Return Value:

- [TestSuite](#class-testsuite) - Test suite.

### func configure(Configuration)

```cangjie
public func configure(configuration: Configuration): TestSuiteBuilder
```

Function: Adds configuration information to the test suite.

Parameters:

- configuration : [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration) - Test configuration information.

Return Value:

- [TestGroupBuilder](#class-testgroupbuilder) - Test group builder.

### func setName(String)

```cangjie
public func setName(name: String): TestSuiteBuilder
```

Function: Sets the name for the test suite.

Parameters:

- name : [String](../../core/core_package_api/core_package_structs.md#struct-string) - Test suite name.

Return Value:

- [TestGroupBuilder](#class-testgroupbuilder) - Test group builder.

## class UnitTestCase

```cangjie
public class UnitTestCase {}
```

Function: Provides methods for creating and executing unit test cases.

### prop name

```cangjie
public prop name: String
```

Function: Gets the unit test name.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string).

### func run()

```cangjie
public func run(): TestReport
```

Function: Executes the unit test case.

Return Value:

- [TestReport](#class-testreport) - Unit test execution result report.

### static func create(String, Configuration, () -> Unit)

```cangjie
public static func create(
    name: String,
    configuration!: Configuration = Configuration(),
    body!: () -> Unit
): UnitTestCase
```

Function: Creates a unit test case.

Parameters:

- name : [String](../../core/core_package_api/core_package_structs.md#struct-string) - Test case name.
- configuration!: [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration) - Test case configuration information.
- body!: () -> Unit - Test case execution body.

Return Value:

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

Function: Creates a parameterized unit test case.

Parameters:

- name : [String](../../core/core_package_api/core_package_structs.md#struct-string) - Test case name.
- strategy : [DataStrategy](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-datastrategy) - Parameter data strategy.
- configuration!: [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration) - Test case configuration information.
- body!: () -> Unit - Test case execution body.

Return Value:

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

Function: Creates a parameterized unit test case.

Parameters:

- name : [String](../../core/core_package_api/core_package_structs.md#struct-string) - Test case name.
- strategy : [DataStrategyProcessor](#class-datastrategyprocessort) - Parameter data processor.
- configuration!: [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration) - Test case configuration information.
- body!: () -> Unit - Test case execution body.Return Value:

- [UnitTestCase](#class-unittestcase) - Unit test case object.

## class XmlReporter

```cangjie
public class XmlReporter <: Reporter<TestReport, Unit> {
    public XmlReporter(let directory: Path)
}
```

Function: Prints unit test case result data to XML files.

Parent Type:

- [Reporter](unittest_package_interfaces.md#interface-reporter)\<[TestReport](#class-testreport), [Unit](../../core/core_package_api/core_package_intrinsics.md#unit)>

### XmlReporter(Path)

```cangjie
public XmlReporter(let directory: Path)
```

Function: XmlReporter constructor.

Parameters:

- directory: [Path](../../fs/fs_package_api/fs_package_structs.md#struct-path) - Output file generation path.