# Interfaces

## interface BenchInputProvider

```cangjie
public interface BenchInputProvider<T> <: BenchmarkInputMarker {
    mut func get(idx: Int64): T
    mut func reset(max: Int64)
}
```

Functionality: When certain code needs to execute before performance testing or when input changes require re-execution of a code segment, this interface can be implemented. Additionally, implementations of [DataStrategy](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-datastrategy) should return implementations of this interface.

Users generally do not need to implement this interface themselves and can directly use the [@Strategy](../../unittest_testmacro/unittest_testmacro_package_api/unittest_testmacro_package_macros.md#strategy-macro) macro.

Parent Types:

- [BenchmarkInputMarker](#interface-benchmarkinputmarker)

### mut func get(Int64)

```cangjie
mut func get(idx: Int64): T
```

Functionality: Retrieves an element. The execution time of this function is included in the benchmark measurement but then excluded from the results as part of framework overhead calculations.

Parameters:

- idx: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The index value of the element.

Return Value:

- T - The element value.

### mut func reset(Int64)

```cangjie
mut func reset(max: Int64)
```

Functionality: Called before benchmark measurements. After calling this function, subsequent `get(i)` calls must successfully retrieve `i` within the range [0, max).

Parameters:

- max: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The maximum value.

## interface BenchmarkConfig

```cangjie
public interface BenchmarkConfig {
    func batchSize(b: Int64): Unit
    func batchSize(x: Range<Int64>): Unit
    func warmup(x: Int64): Unit
    func warmup(x: Duration): Unit
    func minDuration(x: Duration): Unit
    func explicitGC(x: ExplicitGcType): Unit
    func minBatches(x: Int64): Unit
}
```

Functionality: This interface provides function signatures for configuring performance test-related information in the [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration) macro.

### func batchSize(Int64)

```cangjie
func batchSize(b: Int64): Unit
```

Functionality: Implement this function to configure the batch size for the `@Configuration` macro.

Parameters:

- b: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The batch size value to configure.

### func batchSize(Range\<Int64>): Unit

```cangjie
func batchSize(x: Range<Int64>): Unit
```

Functionality: Implement this function to configure the batch size range for the `@Configuration` macro.

Parameters:

- x: [Range](../../core/core_package_api/core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet)<[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)> - The batch size range value to configure.

### func explicitGC(ExplicitGcType)

```cangjie
func explicitGC(x: ExplicitGcType): Unit
```

Functionality: Implement this function to configure the GC type for the `@Configuration` macro.

Parameters:

- x: [ExplicitGcType](../unittest_package_api/unittest_package_enums.md#enum-explicitgctype) - The GC type value to configure.

### func minBatches(Int64)

```cangjie
func minBatches(x: Int64): Unit
```

Functionality: Implement this function to configure the minimum number of batches for the `@Configuration` macro.

Parameters:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The minimum number of batches to configure.

### func minDuration(Duration)

```cangjie
func minDuration(x: Duration): Unit
```

Functionality: Implement this function to configure the minimum execution time for performance tests in the `@Configuration` macro.

Parameters:

- x: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The minimum execution time for performance tests to configure.

### func warmup(Int64)

```cangjie
func warmup(x: Int64): Unit
```

Functionality: Implement this function to configure the number of warmup executions for the `@Configuration` macro.

Parameters:

- x: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The number of warmup executions to configure.

### func warmup(Duration)

```cangjie
func warmup(x: Duration): Unit
```

Functionality: Implement this function to configure the warmup execution time for the `@Configuration` macro.

Parameters:

- x: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The warmup execution time to configure.

## interface BenchmarkInputMarker

```cangjie
public interface BenchmarkInputMarker
```

Functionality: This interface enables detection of `BenchInputProvider<T>` when `T` is unknown.

## interface Generator\<T>

```cangjie
public interface Generator<T> {
    func next(): T
}
```

Functionality: A generator produces values of type T.

### func next()

```cangjie
func next(): T
```

Functionality: Retrieves the generated value of type T.

Return Value:

- T - The generated value of type T.

## interface Measurement

```cangjie
public interface Measurement {
    prop conversionTable: MeasurementUnitTable
    prop name: String
    prop textDescription: String
    func setup(): Unit
    func measure(): Float64
}
```

Functionality: This interface specifies how to measure data during performance tests and how to display it in reports.
Instances implementing this interface can be passed as attributes to the `@Measure` macro.

### prop conversionTable

```cangjie
prop conversionTable: MeasurementUnitTable
```

Functionality: Used to construct the representation of measured values in performance test reports.
Contains boundary pairs for measurement units.
The most appropriate unit is selected based on value boundaries.
For CSV format reports, the lower boundary is always chosen to simplify result processing.
Default value is `[(1.0, "")]`.

Type: [MeasurementUnitTable](../unittest_package_api/unittest_package_types.md#type-measurementunittable).

### prop name

```cangjie
prop name: String
```

Functionality: The unique display name for the current `Measurement` type.
Helps distinguish different measurement types in report tables.
Default value is `Measurement`.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string).

### prop textDescription

```cangjie
prop textDescription: String
```

Functionality: A simple text description of this measurement that will be displayed in certain reports.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string).

### func measure()

```cangjie
func measure(): Float64
```

Functionality: The method used to measure runtime for statistical analysis.

Return Value:

- [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - The measured data.

### func setup()

```cangjie
func setup()
```

Functionality: The initialization routine for this measurement. Called before each benchmark step.

## interface Reporter

```cangjie
sealed interface Reporter <TReport, TReturn>
```

Functionality: Base reporter interface.

## interface TestClass

```cangjie
public interface TestClass {
    func asTestSuite(): TestSuite
}
```

Functionality: Provides methods for creating [TestSuite](./unittest_package_classes.md#class-testsuite).

### func asTestSuite()

```cangjie
func asTestSuite(): TestSuite
```

Functionality: Method for creating [TestSuite](./unittest_package_classes.md#class-testsuite).

Return Value:

- [TestSuite](./unittest_package_classes.md#class-testsuite) - The test suite object.