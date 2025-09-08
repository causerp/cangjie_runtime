# Structs

## struct BatchInputProvider\<T>

```cangjie
public struct BatchInputProvider<T> <: BenchInputProvider<T> {
    public BatchInputProvider(let builder: () -> T)
}
```

Function: An input provider that generates the entire batch of benchmark inputs in a buffer before execution.

Parent Types:

- [BenchInputProvider](unittest_package_interfaces.md#interface-benchinputprovider)\<T>

### BatchInputProvider(() -> T)

```cangjie
public BatchInputProvider(let builder: () -> T)
```

Function: Constructor for BatchInputProvider.

Parameters:

- builder: () -> T - A closure for generating benchmark test inputs.

### func get(Int64)

```cangjie
public mut func get(idx: Int64): T
```

Function: Retrieves an element. The execution time of this function is included in benchmark measurements but later excluded from results as part of framework overhead calculation.

Parameters:

- idx: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The index value of the element.

Return Value:

- T - The element value.

### func reset(Int64)

```cangjie
public mut func reset(max: Int64)
```

Function: Called before benchmark measurements. After calling this function, subsequent `get(i)` calls must successfully retrieve `i` within [0, max).

Parameters:

- max: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The maximum value.

## struct BatchSizeOneInputProvider\<T>

```cangjie
public struct BatchSizeOneInputProvider<T> <: BenchInputProvider<T>{
    public BatchSizeOneInputProvider(let builder: () -> T)
}
```

Function: A benchmark input provider that generates inputs before each benchmark execution. 
The difference from `GenerateEachInputProvider` is that when batch size is 1, we can measure.
Each benchmark call is independent, so input generation is never included in measurements.
Should be used when `GenerateEachInputProvider` yields poor quality results. This may occur when input generation takes significantly more time than the actual benchmark, or when input generation execution time is highly unstable.

Parent Types:

- [BenchInputProvider](unittest_package_interfaces.md#interface-benchinputprovider)\<T>

### BatchSizeOneInputProvider(() -> T)

```cangjie
public BatchSizeOneInputProvider(let builder: () -> T)
```

Function: Constructor for BatchSizeOneInputProvider.

Parameters:

- builder: () -> T - A lambda for generating benchmark test inputs.

### func get(Int64)

```cangjie
public mut func get(idx: Int64): T
```

Function: Retrieves an element. The execution time of this function is included in benchmark measurements but later excluded from results as part of framework overhead calculation.

Parameters:

- idx: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The index value of the element.

Return Value:

- T - The element value.

### func reset(Int64)

```cangjie
public mut func reset(max: Int64)
```

Function: Called before benchmark measurements. After calling this function, subsequent `get(i)` calls must successfully retrieve `i` within [0, max).

Parameters:

- max: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The maximum value.

## struct CpuCycles

```cangjie
public struct CpuCycles <: Measurement {}
```

Function: Measures CPU cycle count using the native `rdtscp` instruction. Only available on x86 platforms.

Parent Types:

- [Measurement](unittest_package_interfaces.md#interface-measurement)

### prop conversionTable

```cangjie
prop conversionTable: MeasurementUnitTable
```

Function: Provides a unit conversion table for the current time.
Example: `[(1.0, "cycles")]`.

Type: [MeasurementUnitTable](../unittest_package_api/unittest_package_types.md#type-measurementunittable).

### prop name

```cangjie
prop name: String
```

Function: Provides a unique display name for the current time unit, e.g.: `CpuCycles`.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string).

### prop textDescription

```cangjie
prop textDescription: String
```

Function: Simple text description of this measurement that will appear in certain reports.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string).

### func measure()

```cangjie
public func measure(): Float64
```

Function: Returns the number of CPU cycles executed.

Return Value:

- [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - The computed data for statistical analysis.

### func setup()

```cangjie
public func setup()
```

Function: Configuration action executed before measurement.

## struct GenerateEachInputProvider\<T>

```cangjie
public struct GenerateEachInputProvider<T> <: BenchInputProvider<T>{
    public GenerateEachInputProvider(let builder: () -> T)
}
```

Function: A benchmark input provider that generates inputs before each benchmark execution.
Generation time is included in benchmark measurements but later excluded from final results as part of framework overhead calculation.

Parent Types:

- [BenchInputProvider](unittest_package_interfaces.md#interface-benchinputprovider)\<T>

### GenerateEachInputProvider(() -> T)

```cangjie
public GenerateEachInputProvider(let builder: () -> T)
```

Function: Constructor for GenerateEachInputProvider.

Parameters:

- builder: () -> T - A closure for generating benchmark test inputs.

### func get(Int64)

```cangjie
public mut func get(idx: Int64): T
```

Function: Retrieves an element. The execution time of this function is included in benchmark measurements but later excluded from results as part of framework overhead calculation.

Parameters:

- idx: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The index value of the element.

Return Value:

- T - The element value.

### func reset(Int64)

```cangjie
public mut func reset(max: Int64)
```

Function: Called before benchmark measurements. After calling this function, subsequent `get(i)` calls must successfully retrieve `i` within [0, max).

Parameters:

- max: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The maximum value.

## struct ImmutableInputProvider\<T>

```cangjie
public struct ImmutableInputProvider<T> <: BenchInputProvider<T> {
    public ImmutableInputProvider(let data: T)
}
```

Function: The simplest input provider that simply copies data for each benchmark call. Suitable when the benchmark doesn't modify inputs. Used by default within the framework.

Parent Types:

- [BenchInputProvider](unittest_package_interfaces.md#interface-benchinputprovider)\<T>

### ImmutableInputProvider(T)

```cangjie
public ImmutableInputProvider(let data: T)
```

Function: Constructor for ImmutableInputProvider.

Parameters:

- data: T - The input for benchmark testing.

### func get(Int64)

```cangjie
public mut func get(idx: Int64): T
```

Function: Retrieves an element. The execution time of this function is included in benchmark measurements but later excluded from results as part of framework overhead calculation.

Parameters:

- idx: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The index value of the element.

Return Value:

- T - The element value.

### static func createOrExisting(T, Int64)

```cangjie
public static func createOrExisting(arg: T, x!:Int64=0): ImmutableInputProvider<T>
```

Function: Creates or retrieves an ImmutableInputProvider object.

Parameters:

- arg: T - The parameter to be copied by the provider.
- x!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - An additional parameter for implementing overloading.

Return Value:

- ImmutableInputProvider\<T> - The input provider.

### static func createOrExisting\<U>(U)

```cangjie
public static func createOrExisting<U>(arg: U): U where U <: BenchInputProvider<T>
```

Function: Creates or retrieves a subtype object of BenchInputProvider.

Parameters:

- arg: T - The parameter to be copied by the provider.

Return Value:

- U - The input provider.

## struct KeyBaseline

```cangjie
public struct KeyBaseline <: KeyFor<String> {}
```

Function: Used as a key for corresponding configuration items in [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration)

Example:

<!-- compile -->
```cangjie
let conf = Configuration()
conf.set(KeyBaseline.baseline, "baseline")
```

Parent Types:

- [KeyFor](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-keyfor)

### prop baseline

```cangjie
public static prop baseline: Baseline
```

Function: The key value for configuration items.

### prop name

```cangjie
public prop name: String
```

Function: The name of the key value for configuration items.

## struct KeyBaselinePath

```cangjie
public struct KeyBaselinePath <: KeyFor<String> {}
```

Function: Used as a key for corresponding configuration items in [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration)

Parent Types:

- [KeyFor](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-keyfor)

### prop baselinePath

```cangjie
public static prop baselinePath: BaselinePath
```

Function: The key value for configuration items.

### prop name

```cangjie
public prop name: String
```

Function: The name of the key value for configuration items.

## struct KeyBatchSize

```cangjie
public struct KeyBatchSize <: KeyFor<Int64> & KeyFor<Range<Int64>> {}
```

Function: Used as a key for corresponding configuration items in [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration)

Parent Types:

- [KeyFor](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-keyfor)

### prop batchSize

```cangjie
public static prop batchSize: BatchSize
```

Function: The key value for configuration items.

### prop name

```cangjie
public prop name: String
```

Function: The name of the key value for configuration items.

## struct KeyBench

```cangjie
public struct KeyBench <: KeyFor<Bool> {}
```

Function: Used as a key for corresponding configuration items in [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration)

Parent Types:

- [KeyFor](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-keyfor)

### prop bench

```cangjie
public static prop bench: Bench
```

Function: The key value for configuration items.

### prop name

```cangjie
public prop name: String
```

Function: The name of the key value for configuration items.## struct KeyCaptureOutput

```cangjie
public struct KeyCaptureOutput <: KeyFor<Bool> {}
```

Function: Used as the key for corresponding configuration items in [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration)

Parent Type:

- [KeyFor](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-keyfor)

### prop captureOutput

```cangjie
public static prop captureOutput: CaptureOutput
```

Function: The key value for the configuration item.

### prop name

```cangjie
public prop name: String
```

Function: The name of the configuration item's key value.

## struct KeyCoverageGuided

```cangjie
public struct KeyCoverageGuided <: KeyFor<Bool> {}
```

Function: Used as the key for corresponding configuration items in [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration)

Parent Type:

- [KeyFor](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-keyfor)

### prop coverageGuided

```cangjie
public static prop coverageGuided: CoverageGuided
```

Function: The key value for the configuration item.

### prop name

```cangjie
public prop name: String
```

Function: The name of the configuration item's key value.

## struct KeyCoverageGuidedBaselineScore

```cangjie
public struct KeyCoverageGuidedBaselineScore <: KeyFor<Int64> {}
```

Function: Used as the key for corresponding configuration items in [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration)

Parent Type:

- [KeyFor](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-keyfor)

### prop coverageGuidedBaselineScore

```cangjie
public static prop coverageGuidedBaselineScore: CoverageGuidedBaselineScore
```

Function: The key value for the configuration item.

### prop name

```cangjie
public prop name: String
```

Function: The name of the configuration item's key value.

## struct KeyCoverageGuidedInitialSeeds

```cangjie
public struct KeyCoverageGuidedInitialSeeds <: KeyFor<Int64> {}
```

Function: Used as the key for corresponding configuration items in [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration)

Parent Type:

- [KeyFor](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-keyfor)

### prop coverageGuidedInitialSeeds

```cangjie
public static prop coverageGuidedInitialSeeds: CoverageGuidedInitialSeeds
```

Function: The key value for the configuration item.

### prop name

```cangjie
public prop name: String
```

Function: The name of the configuration item's key value.

## struct KeyCoverageGuidedMaxCandidates

```cangjie
public struct KeyCoverageGuidedMaxCandidates <: KeyFor<Int64> {}
```

Function: Used as the key for corresponding configuration items in [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration)

Parent Type:

- [KeyFor](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-keyfor)

### prop coverageGuidedMaxCandidates

```cangjie
public static prop coverageGuidedMaxCandidates: CoverageGuidedMaxCandidates
```

Function: The key value for the configuration item.

### prop name

```cangjie
public prop name: String
```

Function: The name of the configuration item's key value.

## struct KeyCoverageGuidedNewCoverageBonus

```cangjie
public struct KeyCoverageGuidedNewCoverageBonus <: KeyFor<Int64> {}
```

Function: Used as the key for corresponding configuration items in [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration)

Parent Type:

- [KeyFor](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-keyfor)

### prop coverageGuidedNewCoverageBonus

```cangjie
public static prop coverageGuidedNewCoverageBonus: CoverageGuidedNewCoverageBonus
```

Function: The key value for the configuration item.

### prop name

```cangjie
public prop name: String
```

Function: The name of the configuration item's key value.

## struct KeyCoverageGuidedNewCoverageScore

```cangjie
public struct KeyCoverageGuidedNewCoverageScore <: KeyFor<Int64> {}
```

Function: Used as the key for corresponding configuration items in [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration)

Parent Type:

- [KeyFor](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-keyfor)

### prop coverageGuidedNewCoverageScore

```cangjie
public static prop coverageGuidedNewCoverageScore: CoverageGuidedNewCoverageScore
```

Function: The key value for the configuration item.

### prop name

```cangjie
public prop name: String
```

Function: The name of the configuration item's key value.

## struct KeyDeathAware

```cangjie
public struct KeyDeathAware <: KeyFor<Bool> {}
```

Function: Used as the key for corresponding configuration items in [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration)

Parent Type:

- [KeyFor](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-keyfor)

### prop deathAware

```cangjie
public static prop deathAware: DeathAware
```

Function: The key value for the configuration item.

### prop name

```cangjie
public prop name: String
```

Function: The name of the configuration item's key value.

## struct KeyDryRun

```cangjie
public struct KeyDryRun <: KeyFor<Bool> {}
```

Function: Used as the key for corresponding configuration items in [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration)

Parent Type:

- [KeyFor](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-keyfor)

### prop dryRun

```cangjie
public static prop dryRun: DryRun
```

Function: The key value for the configuration item.

### prop name

```cangjie
public prop name: String
```

Function: The name of the configuration item's key value.

## struct KeyExcludeTags

```cangjie
public struct KeyExcludeTags <: KeyFor<String> {}
```

Function: Used as the key for corresponding configuration items in [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration)

Parent Type:

- [KeyFor](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-keyfor)

### prop excludeTags

```cangjie
public static prop excludeTags: ExcludeTags
```

Function: The key value for the configuration item.

### prop name

```cangjie
public prop name: String
```

Function: The name of the configuration item's key value.

## struct KeyExplicitGC

```cangjie
public struct KeyExplicitGC <: KeyFor<ExplicitGcType> {}
```

Function: Used as the key for corresponding configuration items in [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration)

Parent Type:

- [KeyFor](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-keyfor)

### prop explicitGC

```cangjie
public static prop explicitGC: ExplicitGC
```

Function: The key value for the configuration item.

### prop name

```cangjie
public prop name: String
```

Function: The name of the configuration item's key value.

## struct KeyFilter

```cangjie
public struct KeyFilter <: KeyFor<String> {}
```

Function: Used as the key for corresponding configuration items in [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration)

Parent Type:

- [KeyFor](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-keyfor)

### prop filter

```cangjie
public static prop filter: Filter
```

Function: The key value for the configuration item.

### prop name

```cangjie
public prop name: String
```

Function: The name of the configuration item's key value.

## struct KeyFromTopLevel

```cangjie
public struct KeyFromTopLevel <: KeyFor<Bool> {}
```

Function: Used as the key for corresponding configuration items in [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration)

Parent Type:

- [KeyFor](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-keyfor)

### prop fromTopLevel

```cangjie
public static prop fromTopLevel: FromTopLevel
```

Function: The key value for the configuration item.

### prop name

```cangjie
public prop name: String
```

Function: The name of the configuration item's key value.

## struct KeyGenerationSteps

```cangjie
public struct KeyGenerationSteps <: KeyFor<Int64> {}
```

Function: Used as the key for corresponding configuration items in [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration)

Parent Type:

- [KeyFor](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-keyfor)

### prop generationSteps

```cangjie
public static prop generationSteps: GenerationSteps
```

Function: The key value for the configuration item.

### prop name

```cangjie
public prop name: String
```

Function: The name of the configuration item's key value.

## struct KeyHelp

```cangjie
public struct KeyHelp <: KeyFor<Bool> {}
```

Function: Used in configuration information to specify whether to print help information.

Parent Type:

- [KeyFor](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-keyfor)

### prop help

```cangjie
public static prop help: KeyHelp
```

Function: The key value for the configuration item.

### prop name

```cangjie
public prop name: String
```

Function: The name of the configuration item's key value.

## struct KeyIncludeTags

```cangjie
public struct KeyIncludeTags <: KeyFor<String> {}
```

Function: Used as the key for corresponding configuration items in [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration)

Parent Types:

- [KeyFor](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-keyfor)

### prop includeTags

```cangjie
public static prop includeTags: IncludeTags
```

Function: The key value of the configuration item.

### prop name

```cangjie
public prop name: String
```

Function: The name of the configuration item's key value.

## struct KeyInternalTestrunnerInputPath

```cangjie
public struct KeyInternalTestrunnerInputPath <: KeyFor<String> {}
```

Function: Used as the key for corresponding configuration items in [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration)

Parent Types:

- [KeyFor](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-keyfor)

### prop internalTestrunnerInputPath

```cangjie
public static prop internalTestrunnerInputPath: InternalTestrunnerInputPath
```

Function: The key value of the configuration item.

### prop name

```cangjie
public prop name: String
```

Function: The name of the configuration item's key value.

## struct KeyMeasurement

```cangjie
public struct KeyMeasurement <: KeyFor<Measurement> {}
```

Function: Used as the key for corresponding configuration items in [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration)

Parent Types:

- [KeyFor](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-keyfor)

### prop measurement

```cangjie
public static prop measurement: Measurement
```

Function: The key value of the configuration item.

### prop name

```cangjie
public prop name: String
```

Function: The name of the configuration item's key value.

## struct KeyMeasurementInfo

```cangjie
public struct KeyMeasurementInfo <: KeyFor<MeasurementInfo> {}
```

Function: Used as the key for corresponding configuration items in [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration)

Parent Types:

- [KeyFor](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-keyfor)

### prop measurementInfo

```cangjie
public static prop measurementInfo: MeasurementInfo
```

Function: The key value of the configuration item.

### prop name

```cangjie
public prop name: String
```

Function: The name of the configuration item's key value.

## struct KeyMinBatches

```cangjie
public struct KeyMinBatches <: KeyFor<Int64> {}
```

Function: Used as the key for corresponding configuration items in [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration)

Parent Types:

- [KeyFor](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-keyfor)

### prop minBatches

```cangjie
public static prop minBatches: MinBatches
```

Function: The key value of the configuration item.

### prop name

```cangjie
public prop name: String
```

Function: The name of the configuration item's key value.

## struct KeyMinDuration

```cangjie
public struct KeyMinDuration <: KeyFor<Duration> {}
```

Function: Used as the key for corresponding configuration items in [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration)

Parent Types:

- [KeyFor](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-keyfor)

### prop minDuration

```cangjie
public static prop minDuration: MinDuration
```

Function: The key value of the configuration item.

### prop name

```cangjie
public prop name: String
```

Function: The name of the configuration item's key value.

## struct KeyNoCaptureOutput

```cangjie
public struct KeyNoCaptureOutput <: KeyFor<Bool> {}
```

Function: Used as the key for corresponding configuration items in [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration)

Parent Types:

- [KeyFor](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-keyfor)

### prop noCaptureOutput

```cangjie
public static prop noCaptureOutput: NoCaptureOutput
```

Function: The key value of the configuration item.

### prop name

```cangjie
public prop name: String
```

Function: The name of the configuration item's key value.

## struct KeyNoColor

```cangjie
public struct KeyNoColor <: KeyFor<Bool> {}
```

Function: Used as the key for corresponding configuration items in [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration)

Parent Types:

- [KeyFor](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-keyfor)

### prop noColor

```cangjie
public static prop noColor: NoColor
```

Function: The key value of the configuration item.

### prop name

```cangjie
public prop name: String
```

Function: The name of the configuration item's key value.

## struct KeyOptimizeMocksForBench

```cangjie
public struct KeyOptimizeMocksForBench <: KeyFor<Bool> {}
```

Function: Used as the key for corresponding configuration items in [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration)

Parent Types:

- [KeyFor](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-keyfor)

### prop optimizeMocksForBench

```cangjie
public static prop optimizeMocksForBench: OptimizeMocksForBench
```

Function: The key value of the configuration item.

### prop name

```cangjie
public prop name: String
```

Function: The name of the configuration item's key value.

## struct KeyParallel

```cangjie
public struct KeyParallel <: KeyFor<Bool> & KeyFor<String> & KeyFor<Int64> {}
```

Function: Used as the key for corresponding configuration items in [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration)

Parent Types:

- [KeyFor](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-keyfor)

### prop parallel

```cangjie
public static prop parallel: Parallel
```

Function: The key value of the configuration item.

### prop name

```cangjie
public prop name: String
```

Function: The name of the configuration item's key value.

## struct KeyRandomSeed

```cangjie
public struct KeyRandomSeed <: KeyFor<Int64> {}
```

Function: Used as the key for corresponding configuration items in [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration)

Parent Types:

- [KeyFor](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-keyfor)

### prop randomSeed

```cangjie
public static prop randomSeed: RandomSeed
```

Function: The key value of the configuration item.

### prop name

```cangjie
public prop name: String
```

Function: The name of the configuration item's key value.

## struct KeyReductionSteps

```cangjie
public struct KeyReductionSteps <: KeyFor<Int64> {}
```

Function: Used as the key for corresponding configuration items in [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration)

Parent Types:

- [KeyFor](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-keyfor)

### prop reductionSteps

```cangjie
public static prop reductionSteps: ReductionSteps
```

Function: The key value of the configuration item.

### prop name

```cangjie
public prop name: String
```

Function: The name of the configuration item's key value.

## struct KeyReportFormat

```cangjie
public struct KeyReportFormat <: KeyFor<String> {}
```

Function: Used as the key for corresponding configuration items in [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration)

Parent Types:

- [KeyFor](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-keyfor)

### prop reportFormat

```cangjie
public static prop reportFormat: ReportFormat
```

Function: The key value of the configuration item.

### prop name

```cangjie
public prop name: String
```

Function: The name of the configuration item's key value.

## struct KeyReportPath

```cangjie
public struct KeyReportPath <: KeyFor<String> {}
```

Function: Used as the key for corresponding configuration items in [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration)

Parent Types:

- [KeyFor](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-keyfor)

### prop reportPath

```cangjie
public static prop reportPath: ReportPath
```

Function: The key value of the configuration item.

### prop name

```cangjie
public prop name: String
```

Function: The name of the configuration item's key value.

## struct KeyShowAllOutput

```cangjie
public struct KeyShowAllOutput <: KeyFor<Bool> {}
```

Function: Used as the key for corresponding configuration items in [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration)

Parent Types:

- [KeyFor](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-keyfor)

### prop showAllOutput

```cangjie
public static prop showAllOutput: ShowAllOutput
```

Function: The key value of the configuration item.

### prop name

```cangjie
public prop name: String
```

Function: The name of the configuration item's key value.
```## struct KeyShowTags

```cangjie
public struct KeyShowTags <: KeyFor<Bool> {}
```

Function: Used as a key for corresponding configuration items in [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration)

Parent Types:

- [KeyFor](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-keyfor)

### prop showTags

```cangjie
public static prop showTags: ShowTags
```

Function: The key value of the configuration item.

### prop name

```cangjie
public prop name: String
```

Function: The name of the configuration item's key value.

## struct KeySkip

```cangjie
public struct KeySkip <: KeyFor<Bool> {}
```

Function: Used as a key for corresponding configuration items in [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration)

Parent Types:

- [KeyFor](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-keyfor)

### prop skip

```cangjie
public static prop skip: Skip
```

Function: The key value of the configuration item.

### prop name

```cangjie
public prop name: String
```

Function: The name of the configuration item's key value.

## struct KeyTimeout

```cangjie
public struct KeyTimeout <: KeyFor<Duration> {}
```

Function: Used as a key for corresponding configuration items in [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration)

Parent Types:

- [KeyFor](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-keyfor)

### prop timeout

```cangjie
public static prop timeout: Timeout
```

Function: The key value of the configuration item.

### prop name

```cangjie
public prop name: String
```

Function: The name of the configuration item's key value.

## struct KeyTimeoutEach

```cangjie
public struct KeyTimeoutEach <: KeyFor<String> {}
```

Function: Used as a key for corresponding configuration items in [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration)

Parent Types:

- [KeyFor](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-keyfor)

### prop timeoutEach

```cangjie
public static prop timeoutEach: TimeoutEach
```

Function: The key value of the configuration item.

### prop name

```cangjie
public prop name: String
```

Function: The name of the configuration item's key value.

## struct KeyTimeoutHandler

```cangjie
public struct KeyTimeoutHandler <: KeyFor<(TestCaseInfo) -> Unit> {}
```

Function: Supports specifying a timeout handler in configuration information.

Example:

<!-- compile -->
```cangjie
let conf = Configuration()
conf.set(KeyTimeoutHandler.timeoutHandler, { info => /*...*/ })
```

Parent Types:

- [KeyFor](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-keyfor)

### prop timeoutHandler

```cangjie
public static prop timeoutHandler: KeyTimeoutHandler
```

Function: Timeout handler.

Type: [KeyTimeoutHandler](#struct-keytimeouthandler).

### prop name

```cangjie
public prop name: String
```

Function: The name of the timeout handler.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string).

## struct KeyVerbose

```cangjie
public struct KeyVerbose <: KeyFor<Bool> {}
```

Function: Used as a key for corresponding configuration items in [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration)

Parent Types:

- [KeyFor](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-keyfor)

### prop verbose

```cangjie
public static prop verbose: Verbose
```

Function: The key value of the configuration item.

### prop name

```cangjie
public prop name: String
```

Function: The name of the configuration item's key value.

## struct KeyWarmup

```cangjie
public struct KeyWarmup <: KeyFor<Int64> & KeyFor<Duration> {}
```

Function: Used as a key for corresponding configuration items in [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration)

Parent Types:

- [KeyFor](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-keyfor)

### prop warmup

```cangjie
public static prop warmup: Warmup
```

Function: The key value of the configuration item.

### prop name

```cangjie
public prop name: String
```

Function: The name of the configuration item's key value.

## struct MeasurementInfo

```cangjie
public struct MeasurementInfo {
    public let conversionTable: MeasurementUnitTable,
    public let name: String,
    public let textDescription: String
}
```

Function: A structure for storing measurement information.

### prop conversionTable

```cangjie
prop conversionTable: MeasurementUnitTable
```

Function: Used to construct representations of measured values in performance test reports.
Contains boundary pairs for measurement units.
Selects the most appropriate unit based on value boundaries.
For CSV format reports, always uses the lower bound to simplify result processing.
Default value is `[(1.0, "")]`.

Type: [MeasurementUnitTable](../unittest_package_api/unittest_package_types.md#type-measurementunittable).

### prop name

```cangjie
prop name: String
```

Function: The unique display name for the current `Measurement` type.
Helps distinguish between different measurement types in report tables.
Default value is `Measurement`.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string).

### prop textDescription

```cangjie
prop textDescription: String
```

Function: A simple text description of this measurement that will be displayed in certain reports.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string).

## struct Perf

```cangjie
public struct Perf <: Measurement {
    public init()
    public Perf(counter: PerfCounter)
}
```

Function: Measures various hardware and software CPU counters using the Linux system call `perf_event_open`. Only available on Linux.

Parent Types:

- [Measurement](unittest_package_interfaces.md#interface-measurement)

### prop conversionTable

```cangjie
prop conversionTable: MeasurementUnitTable
```

Function: Provides the conversion table for corresponding CPU counters.

Type: [MeasurementUnitTable](../unittest_package_api/unittest_package_types.md#type-measurementunittable).

### prop name

```cangjie
prop name: String
```

Function: Provides a unique display name for the current CPU counter, e.g., `Perf(cycles)`.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string).

### prop textDescription

```cangjie
prop textDescription: String
```

Function: A simple text description of this measurement that will be displayed in certain reports.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string).

### init()

```cangjie
public init()
```

Function: Default constructor using CPU cycle counters.

### Perf(PerfCounter)

```cangjie
public Perf(counter: PerfCounter)
```

Function: Constructor specifying the CPU counter to measure.

Parameters:

- counter: [PerfCounter](../unittest_package_api/unittest_package_enums.md#enum-perfcounter) - Specifies the counter.

### func measure()

```cangjie
public func measure(): Float64
```

Function: Returns the value of the specified CPU counter.

Return Value:

- [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - The computed data for statistical analysis.

### func setup()

```cangjie
func setup()
```

Function: Initialization routine for this CPU counter. Called before each benchmark step.

## struct RelativeDelta\<T>

```cangjie
public struct RelativeDelta<T> {
    public RelativeDelta(let absolute!: T, let relative!: T) {}
}
```

Function: For floating-point types, provides a relative delta data type for approximate equality calculations. The calculation formula is as follows.

$$|x - y| <= absolute + relative * max(abs(x), abs(y))$$

### RelativeDelta(T, T)

```cangjie
public RelativeDelta(let absolute!: T, let relative!: T)
```

Function: Main constructor for RelativeDelta.

Parameters:

- absolute!: T - The delta value for the absolute comparison part.
- relative!: T - The delta value for the relative comparison part.

## struct TestCaseInfo

```cangjie
public struct TestCaseInfo {
    public let groupName: String
    public let suiteName: String
    public let caseName: String
}
```

Function: Information about the currently running test case. Typically used in timeout handlers for dynamic APIs.

### let caseName

```cangjie
public let caseName: String
```

Function: Test case name.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string).

### let groupName

```cangjie
public let groupName: String
```

Function: Test group name for the case.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string).

### let suiteName

```cangjie
public let suiteName: String
```

Function: Test suite name for the case.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string).## struct TimeNow

```cangjie
public struct TimeNow <: Measurement {
    public init()
    public init(unit: ?TimeUnit)
}
```

Function: An implementation of [Measurement](../../unittest/unittest_package_api/unittest_package_interfaces.md#interface-measurement) for measuring the time taken to execute a function.

Parent Types:

- [Measurement](unittest_package_interfaces.md#interface-measurement)

### prop conversionTable

```cangjie
prop conversionTable: MeasurementUnitTable
```

Function: Provides the unit conversion table for current time.
Example: `[(1.0, "ns"), (1e3, "us"), (1e6, "ms"), (1e9, "s")]`.

Type: [MeasurementUnitTable](../unittest_package_api/unittest_package_types.md#type-measurementunittable).

### prop name

```cangjie
prop name: String
```

Function: Provides the unique display name for current time unit, e.g.: `Duration(ns)` or `Duration(s)`.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string).

### prop textDescription

```cangjie
prop textDescription: String
```

Function: A brief text description of this measurement that will be displayed in certain reports.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string).

### init()

```cangjie
public init()
```

Function: Default constructor that automatically selects the output format.

### init(?TimeUnit)

```cangjie
public init(unit: ?TimeUnit)
```

Function: The `unit` parameter specifies the time unit to be used when printing results.

Parameters:

- unit: ?[TimeUnit](unittest_package_enums.md#enum-timeunit) - The specified time unit.

### func measure()

```cangjie
public func measure(): Float64
```

Function: Obtains the current time for statistical analysis.

Return Value:

- [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - The calculated data for statistical analysis.