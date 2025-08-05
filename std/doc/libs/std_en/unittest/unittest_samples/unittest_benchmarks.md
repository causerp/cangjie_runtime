# Benchmarking

## Getting Started with Benchmarking

The Cangjie unit testing framework provides robust support for creating flexible benchmarks.

To ensure reliable results, most of the heavy lifting is handled internally by the Cangjie unit testing framework, including:

- Managing warm-up
- Repeated executions
- Reducing noise and outliers caused by garbage collection (GC)
- Test framework overhead
- Providing statistical analysis results

A simple benchmark can be constructed by using the `@Bench` macro in the corresponding example.

<!-- run -->
```cangjie
@Test
class Foo {
    var x = 0
    @Bench
    func foo() {
        x += 1
    }
}
```

To run the benchmark, you can pass the `--bench` option to the test executable or, in a cjpm project, use the `cjpm bench` command.

## Parameterized Benchmarking

The benchmark API syntax is similar to unit testing and integrates as much as possible with existing unit testing features.  
The `@Bench` macro supports parameterized cases and data strategies, just like the `@TestCase` macro.  
Additionally, most other macros (e.g., `@BeforeEach`, `@AfterEach`, `@BeforeAll`, `@AfterAll`, `@Types`, `@Configure`) work the same way in benchmarks.

For example, a simple benchmark can be written for the default hash method. Note that the data is created outside the benchmark to ensure it is generated only once before the benchmark starts.

<!-- run -->
```cangjie
@Test
class Foo {
    var hash = 0
    let data = String(Array(1000, repeat: r'a'))

    @Bench
    func hashCode() {
        hash = data.hashCode()
    }
}
```

Next, to run this benchmark on different data, the most straightforward approach is as follows:

<!-- run -->
```cangjie
@Test
class Foo {
    var hash = 0
    let data_1 = String(Array(1000, repeat: r'a'))
    let data_2 = String(Array(10000, repeat: r'a'))

    @Bench[data in [ data_1, data_2 ]]
    func hashCode(data: String) {
        hash = data.hashCode()
    }
}
```

While this method works, you'll notice that the final report labels the input parameters as `data[0]` and `data[1]` because, for arbitrary input parameters, the framework doesn't know which property is most important in our benchmark. Additionally, this approach introduces unnecessary code redundancy. Moreover, there's a bigger potential issue: if the data type isn't a simple string but a more complex form, such as an array of strings, a large number of live objects will be allocated, most of which are only used for executing a specific benchmark.

<!-- run -->
```cangjie
@Test
class ArrayBenchmarks {
    var hash = 0
    let data_1 = Array(1000) {i => i.toString()}
    let data_2 = Array(10000) {i => i.toString()}

    @Bench[data in [ data_1, data_2 ]]
    func hashCode(data: Array<String>) {
        var hasher = DefaultHasher()
        for (e in data) {
            hasher.write(e)
        }
        hash = hasher.finish()
    }

    @Bench
    func createArray() {
        Array(10, repeat: 0)
    }
}

```

When benchmarking `createArray`, every GC trigger would involve traversing the elements of `data_1` and `data_2`, even though they are irrelevant to any test other than the `hashCode` benchmark. Especially when dealing with large objects, this can lead to unstable benchmarks, affecting the accuracy of the final results.

The aforementioned issues, as well as more complex ones, can be resolved by defining specific strategies and applying the `@Strategy` macro. This macro accepts the same domain-specific language (DSL) as the `@Bench` and `@TestCase` macros, generating a new strategy that maps inputs in a flattened manner. Thus, this example can be evolved as follows:

<!-- run -->
```cangjie
@Test
class ArrayBenchmarks {
    var hash = 0

    @Strategy[len in [ 1000, 10000 ]]
    func arrays(len: Int64): Array<String> {
        Array(10000) {i => i.toString()}
    }

    @Bench[data in arrays]
    func hashCodeArray(data: Array<String>) {
        var hasher = DefaultHasher()
        for (e in data) {
            hasher.write(e)
        }
        hash = hasher.finish()
    }

    @Strategy[len in [ 1000, 10000 ]]
    func strings(len: Int64): String {
        String(Array(len, repeat: r'a'))
    }

    @Bench[data in strings]
    func hashCodeString(data: String) {
        hash = data.hashCode()
    }
}
```

The output is as follows:

```text
TP: package, time elapsed: 18438985580 ns, RESULT:
    TCS: ArrayBenchmarks, time elapsed: 18438962951 ns, RESULT:
    | Case           | Args   |   Median |         Err |   Err% |     Mean |
    |:---------------|:-------|---------:|------------:|-------:|---------:|
    | hashCodeArray  | 1000   | 10.68 us |  ±0.0832 us |  ±0.8% | 10.57 us |
    | hashCodeArray  | 10000  | 104.3 us |   ±0.504 us |  ±0.5% | 103.8 us |
    |                |        |          |             |        |          |
    | hashCodeString | 1000   | 165.7 ns |   ±0.513 ns |  ±0.3% | 165.6 ns |
    | hashCodeString | 10000  | 1.576 us | ±0.00644 us |  ±0.4% | 1.563 us |
Summary: TOTAL: 2
    PASSED: 2, SKIPPED: 0, ERROR: 0
    FAILED: 0
```

Here, the framework treats the length as the initial input parameter. Before the benchmark starts, data is generated only for the specific benchmark, so it doesn't affect subsequent benchmarks. This reduces code redundancy, and the `[1000, 10000]` array can even be moved to a separate variable to further minimize redundancy. Additionally, since the data is processed internally by the framework, the compiler cannot directly access the exact parameter values for optimization.

Now, let's assume the input data cannot be modified by the benchmark to ensure each function call receives the same version of the data. This framework also supports benchmarks that allow modifying input data; see the [Setup Before Each Call](#setup-before-each-call) section for details.

## Achieving Reliable Results

This framework primarily aims to reduce the impact of various factors on execution time variance, ensuring reliable and reproducible results.  
The `Err%` column in the results table is the primary metric for assessing the reliability of test results. Generally, if `Err%` is below 3%, the results are considered reliable; if it exceeds 10%, further investigation is needed to identify the cause and reduce variance. This isn't a universal standard but serves as a preliminary guideline. In some benchmarks, execution time variations may be significant, leading to higher variance, but the mean tends to stabilize.

However, there are still external factors beyond our control that users must manage themselves. These include:

- Compiler optimization flags. Typically, unless you're testing the effects of specific optimizations, most optimizations should be enabled. It's recommended to enable at least the `-O2` option in the Cangjie compiler.
- Background CPU workloads. If the OS switches tasks during benchmarking, it may significantly affect the results. Thus, all CPU-intensive background tasks should be completed or paused before starting the benchmark. Alternatively, explicit CPU affinity can be set to ensure benchmarks and other CPU-intensive tasks run on different CPU cores.
- External I/O usage. Users might inadvertently benchmark the performance and latency of I/O operations rather than subsequent processing. It's advisable to benchmark the I/O or processing parts separately.
- Unnecessary optimizations. If testing a function's performance with specific parameter values, the compiler might treat these values as constants for optimization. Parameterized benchmarks can avoid this. Future updates will introduce "black-box" methods to better control such optimizations.
- Side effects. All framework analyses assume the benchmarked function is as pure as possible, meaning the code path during execution depends only on input parameters. Therefore, when writing benchmarks, ensure side effects (e.g., modifying global variables or test class fields) don't affect how the code executes during each benchmark iteration. Note that, by default, parameter values remain the same for each function call. If parameters are modified, subsequent calls will use the modified values. This is not recommended, as each call would require reconfiguration.
- Redundant static allocations. If many objects are allocated before benchmarking (either statically or in `@Before*` methods), ensure they are promptly released after the relevant benchmark ends. Otherwise, GC overhead may increase, as the GC still needs to traverse these unused but reachable objects, affecting the accuracy of subsequent benchmarks.

The framework strives to detect whether these factors influence benchmark results and issues warnings when appropriate. However, this serves only as a reminder, not a reliable solution. In other words, even if no warnings are generated, it doesn't guarantee these factors have been properly addressed. Additionally, in some cases, such as enabling compiler optimizations, it may be impossible to know exactly what users intend to benchmark.

## How the Framework Tests

The core algorithm of the framework can be represented by the following pseudocode:

<!-- compile-error -->
```cangjie

// Generated by the @Bench[arg in dataStrategy] macro on the someFunc(arg: Arg) function

let measurement = TimeNow()  // Or use other Measurement implementations provided via the @Measure macro
func measureBatchSomeFunc(
    parameter: ImmutableInputProvider<Arg>, // Or any other BenchInputProvider implementation returned by the strategy
    batchSize: Int64,
    maxBatchSize: Int64
): Float64 {

    parameter.reset(maxBatchSize)   // Reset BatchInputProvider if batch pre-generation of input data is needed

    measurement.setup()
    let start = measurement.measure()

    for(i in 0..maxBatchSize) {     // The loop always runs up to maxBatchSize, allowing us to exclude the loop's own overhead from the final results
        let arg = parameter.get(i)
        if (i < batchSize) {
            /*
            body of someFunc
            */
        }
    }

    measurement.measure() - start
}
Framework.addBenchmark(dataStrategy, Benchmark(measureBatchSomeFunc))

// Inside the framework

for (data in dataStrategy) {
    benchmark.runBench(data)
}

doStatisticalAnalisys(benchmark.results)

class Benchmark<T> {
    let results = ArrayList<(BatchSize, BatchResult)>
    Benchmark(let runBatch: (T, Int64, Int64) -> Float64) {}

    func runBench(data: T) {
        let estimation = warmup(data)

        let batchSizes = calcBatchSizes(estimation)
        for (i in batchSizes) {
            let resultBatch = runBatch(data, i, batchSizes.end)
            results.append(i, resultBatch)

            // Run GC based on the explicitGC configuration parameter
            explicitGC.invoke()
        }
    }

    func warmup(data: T) {
        // Perform warm-up based on the warmup configuration parameter
    }

    func calcBatchSizes(estimation: Duration) {
        // Select the most suitable batch counts and sizes based on warm-up estimates
    }

}
```

The main logic here is that the time difference between `measureBatchSomeFunc(data, i, maxBatchSize)` and `measureBatchSomeFunc(data, i+n, maxBatchSize)` is exactly the time taken to execute `someFunc` `n` times.

This means that by estimating this difference, we can precisely calculate the time required for a single execution of `someFunc`, excluding overhead from the test itself, batch loops, or fetching the next input data.

## Advanced Features

Certain benchmarks require special configurations to accurately judge expected results or gain deeper insights into test outcomes. This framework provides various APIs to cover as many complex use cases as possible.

### Detailed Reports

When benchmark results exhibit significant instability, aggregated statistical parameters alone are often insufficient for analysis. While printing all raw data provides detailed information, it can be overwhelming for manual analysis. To address this, we offer an HTML-based report containing various charts that display raw test data and its statistical analysis. To generate this report, use the `--report-format=html` option. The report includes a navigation page listing all executed test cases, with detailed reports for each case showing all parameters and test data. Each test data entry also includes a kernel density estimation plot of the probability distribution and a chart displaying all raw test data. Currently, the framework uses Gnuplot for chart generation, which must be installed separately.

For users with a statistical background, raw data can be exported in CSV format using the `--report-format=csv-raw` option for independent analysis.

### Custom Measurement Sources

By default, the framework measures time, which is usually sufficient. However, in some cases, other performance metrics may be needed for deeper investigation. To enable this, we provide the `Measurement` interface and support for several advanced measurement sources. These can be enabled by annotating a test source list with a special `@Measure` class.

<!-- run -->
```cangjie
@Test
@Measure[TimeNow(Nanos), CpuCycles(), Perf(), Perf(HW_CACHE_MISSES)]
class Bench {
    var x = 0
    @Bench
    func foo() {
        x += 1
    }
}
```

Out-of-the-box measurement tools provided by the framework include:

- `TimeNow`: Uses `DateTime.now` to measure real-time. Configurable with specific time units to ensure consistent reporting.
- `CpuCycles`: Measures bare-metal CPU instruction cycles. Available only on platforms with such instructions executable in user space.
- `Perf`: Uses Linux's `perf_event_open` system call to measure various hardware/software CPU counters.

### Setup Before Each Call

Suppose we want to benchmark the `ArrayList.sort` function. This function modifies its input data, leading to varying benchmark results because, after the first call, `sort` operates on an already sorted array. To address this, we need to regenerate the data before each function call. This is achieved by implementing the `BenchInputProvider` interface via data-returning functions annotated with `@Strategy`.

<!-- run -->
```cangjie
import std.unittest.*
import std.collection.*

@Test
class Foo {
    @Strategy[len in [ 1000, 10000 ]]
    func strings(len: Int64): GenerateEachInputProvider<ArrayList<Int64>> {
        GenerateEachInputProvider {=> ArrayList<Int64>()}
    }

    @Bench[data in strings]
    func sort(data: ArrayList<Int64>) {
        data.sort()
    }
}
```

The framework provides four implementations covering most possible use cases:- `ImmutableInputProvider`: Only copies the original data each time. When returning a regular strategy type (not implementing the `BenchInputProvider` interface), this implementation is used by default.

- `GenerateEachInputProvider`: Generates data each time before invoking the function under benchmark. This way, data is generated during testing, and the framework subtracts the generation overhead from the total test time. This method requires that the generation function should be as pure and stable as possible. Additionally, the time spent generating data should be less than the actual benchmark time; otherwise, the actual benchmark time may become inaccurate due to variations in the generation function. It is recommended to set this before each call, but if the aforementioned conditions are not met or if variance remains high, other methods should be considered.

- `BatchSizeOneInputProvider`: Generates data each time before invoking the function under benchmark. However, this method specifically requires a batch size of 1, and the framework does not include data generation time in the total test time. In this mode, the framework separately measures the execution time for each function benchmark. This mode lacks the advantage of batch execution, so its primary drawback is lower precision. Whether precision becomes an issue depends on hardware configuration, but generally, if the benchmark time is less than 1 microsecond, caution is advised; if it is less than 100 nanoseconds, this mode is strongly discouraged.

- `BatchInputProvider`: Generates multiple copies of data in a buffer before each batch begins. Theoretically, this leverages the advantage of batch execution. However, it also comes with several issues. First, it may lead to redundant allocations, which could introduce significant GC overhead if the batch size is large enough. Second, test results may slightly differ because previously generated data was immediately passed to the function under benchmark, whereas now the data is likely still in the cache. In this scenario, the first generated element might be evicted from the cache only after all data generation is complete.

### Advanced Configuration Parameters

Many benchmark-related configuration parameters can be set via the `@Configue` macro. Currently supported parameters include:

- `batchSize`: Specifies the precise range of batch sizes when there is a nonlinear relationship between batch size and execution time. By default, the framework automatically selects the batch size based on warmup results.
- `minBatches`: Specifies the minimum number of batches after workload splitting. By default, the framework selects the most appropriate value between 10 and 200 based on warmup results. Note that specifying excessively large values may lead to prolonged statistical analysis times.
- `warmup`: Specifies the warmup duration during which the framework invokes the function for benchmarking.
- `minDuration`: Specifies the target duration for the benchmark. The framework selects the batch size and batch count so that the total execution time of the benchmark phase slightly exceeds the target `minDuration`.
- `explicitGC`: Specifies how GC is performed between batches. By default, the framework triggers GC between batches to evenly distribute GC workload. Otherwise, for memory-intensive benchmarks, unpredictable GC fluctuations may affect test results. However, for benchmarks without memory allocation, this behavior may lead to inaccurate or unstable results. To disable this behavior, set the parameter to `Disable`.

Additionally, sometimes it may be necessary to iterate over multiple parameter values to verify their impact on results. To support this requirement, the framework provides a special syntax form for the data DSL: `config.<parameter> in <strategy>`.

<!-- run -->
```cangjie
@Test
class Foo {
    var x = 0
    @Bench[config.warmup in [ Duration.second * 0.1, Duration.second ]]
    func foo() {
        x += 1
    }
}
```

### Avoiding Unnecessary Optimizations

When benchmarking complex code, the code often includes parameters that can influence its behavior. Therefore, to perform a deterministic benchmark, you may need to specify concrete values for these parameters. Benchmark code might look like this:

<!-- run -->
```cangjie
@Bench
@Test
func foo(): Unit {
    /* complexCode(param: arg) */
}
```

However, it is possible that this function is not called this way in the actual program. In other words, the value of `param` is computed at runtime in the real program, whereas here we use a literal constant, allowing the compiler to exploit this information during optimization. The issue is that we want the benchmarked `complexCode` to accurately simulate its behavior in the real program. Thus, the solution is to use strategies to hide the exact values from the compiler.

<!-- run -->
```cangjie
@Bench[arg in [ 1 ]]
@Test
func foo(arg: Int64): Unit {
    /* complexCode(param: arg) */
}
```

Yet another problem remains. The return value of `complexCode` is unused. If the compiler detects that it can partially or entirely remove this function call, optimization will occur. To address this, the return value should be handled via a black box. This feature is still under development, so the current workaround is to store the return value in a global variable.

<!-- TODO: Black box -->