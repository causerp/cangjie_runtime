# Interfaces

## interface BenchInputProvider

```cangjie
public interface BenchInputProvider<T> <: BenchmarkInputMarker {
    mut func get(idx: Int64): T
    mut func reset(max: Int64)
}
```

Purpose: This interface should be implemented when certain code needs to execute before benchmark execution, or when a code segment needs to re-execute upon input changes. The implementation type of [DataStrategy](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-datastrategy) should return an implementation of this interface.

Users generally don't need to implement this interface directly, as they can use the [@Strategy](../../unittest_testmacro/unittest_testmacro_package_api/unittest_testmacro_package_macros.md#strategy-macro) macro.

Parent Type:

- [BenchmarkInputMarker](#interface-benchmarkinputmarker)

### func get(Int64)

```cangjie
mut func get(idx: Int64): T
```

Purpose: Retrieves an element. The execution time of this function is included in benchmark measurements but excluded from results as part of framework overhead calculations.

Parameters:

- idx: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The index value of the element.

Return Value:

- T - The element value.

### func reset(Int64)

```cangjie
mut func reset(max: Int64)
```

Purpose: Called before benchmark measurements. After calling this function, subsequent `get(i)` calls must successfully retrieve `i` within [0, max).

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

Purpose: This interface provides function signatures for configuring benchmark-related information in the [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration) macro.

### func batchSize(Int64)

```cangjie
func batchSize(b: Int64): Unit
```

Purpose: Implement this function to configure batch size for the `@Configuration` macro.

Parameters:

- b: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The batch size value to configure.

### func batchSize(Range\<Int64>): Unit

```cangjie
func batchSize(x: Range<Int64>): Unit
```

Purpose: Implement this function to configure batch size range for the `@Configuration` macro.

Parameters:

- x: [Range](../../core/core_package_api/core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet)<[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)> - The batch size range to configure.

### func explicitGC(ExplicitGcType)

```cangjie
func explicitGC(x: ExplicitGcType): Unit
```

Purpose: Implement this function to configure GC type for the `@Configuration` macro.

Parameters:

- x: [ExplicitGcType](../unittest_package_api/unittest_package_enums.md#enum-explicitgctype) - The GC type value to configure.

### func minBatches(Int64)

```cangjie
func minBatches(x: Int64): Unit
```

Purpose: Implement this function to configure the minimum number of batches for the `@Configuration` macro.

Parameters:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The minimum number of batches to configure.

### func minDuration(Duration)

```cangjie
func minDuration(x: Duration): Unit
```

Purpose: Implement this function to configure the minimum execution time for benchmarks in the `@Configuration` macro.

Parameters:

- x: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The minimum benchmark execution time to configure.

### func warmup(Int64)

```cangjie
func warmup(x: Int64): Unit
```

Purpose: Implement this function to configure warmup iteration count for the `@Configuration` macro.

Parameters:

- x: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The warmup iteration count to configure.

### func warmup(Duration)

```cangjie
func warmup(x: Duration): Unit
```

Purpose: Implement this function to configure warmup duration for the `@Configuration` macro.

Parameters:

- x: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The warmup duration to configure.

### extend Configuration <: BenchmarkConfig

```cangjie
extend Configuration <: BenchmarkConfig {}
```

Purpose: Extends the [Configuration](#class-configuration) with the [BenchmarkConfig](../../unittest/unittest_package_api/unittest_package_interfaces.md#interface-benchmarkconfig) interface.

Parent Type:

- [BenchmarkConfig](../../unittest/unittest_package_api/unittest_package_interfaces.md#interface-benchmarkconfig)

#### func batchSize(Int64)

```cangjie
public func batchSize(b: Int64)
```

Purpose: Configures the number of executions per batch during benchmarking.

Parameters:

- b: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The execution count.

#### func batchSize(Range\<Int64>)

```cangjie
public func batchSize(x: Range<Int64>)
```

Purpose: Configures the execution count range per batch during benchmarking.

Parameters:

- b: [Range](../../core/core_package_api/core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet)\<Int64> - The execution count range.

#### func explicitGC(ExplicitGcType)

```cangjie
public func explicitGC(x: ExplicitGcType)
```

Purpose: Configures GC execution method during benchmarking.

Parameters:

- x: [ExplicitGcType](../../unittest/unittest_package_api/unittest_package_enums.md#enum-explicitgctype) - The GC execution method.

#### func minBatches(Int64)

```cangjie
public func minBatches(x: Int64)
```

Purpose: Configures the minimum number of batches during benchmarking.

Parameters:

- x: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The minimum number of batches.

#### func minDuration(Duration)

```cangjie
public func minDuration(x: Duration)
```

Purpose: Configures the minimum execution duration during benchmarking.

Parameters:

- x: [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - The minimum execution duration.

#### func warmup(Int64)

```cangjie
public func warmup(x: Int64)
```

Purpose: Configures warmup seconds during benchmarking.

Parameters:

- x: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The warmup seconds.

#### func warmup(Duration)

```cangjie
public func warmup(x: Duration)
```

Purpose: Configures warmup duration during benchmarking.

Parameters:

- x: [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - The warmup duration.

## interface BenchmarkInputMarker

```cangjie
public interface BenchmarkInputMarker
```

Purpose: This interface enables detection of `BenchInputProvider<T>` when `T` is unknown.

## interface Measurement

```cangjie
public interface Measurement {
    prop conversionTable: MeasurementUnitTable
    prop name: String
    prop textDescription: String
    func setup(): Unit
    func measure(): Float64
    prop info: MeasurementInfo
}
```

Purpose: This interface specifies how to measure data during benchmarking and how to display it in reports.
Instances implementing this interface can be passed as attributes to the `@Measure` macro.

### prop conversionTable

```cangjie
prop conversionTable: MeasurementUnitTable
```

Purpose: Used to construct measurement value representations in benchmark reports.
Contains boundary pairs for measurement units.
The most appropriate unit is selected based on value boundaries.
For CSV format reports, the lower bound is always selected to simplify result processing.
Default value is `[(1.0, "")]`.

Type: [MeasurementUnitTable](../unittest_package_api/unittest_package_types.md#type-measurementunittable).

### prop name

```cangjie
prop name: String
```

Purpose: The unique display name for the current `Measurement` type.
Helps distinguish different measurement types in report tables.
Default value is `Measurement`.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string).

### prop textDescription

```cangjie
prop textDescription: String
```

Purpose: Simple text description of this measurement that will appear in certain reports.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string).

### func measure()

```cangjie
func measure(): Float64
```

Purpose: Method for measuring execution time that will be used for statistical analysis.

Return Value:

- [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - The measured data.

### func setup()

```cangjie
func setup()
```

Purpose: Initialization routine for this measurement. Called before each benchmark step.

### prop info

Purpose: Summary information for specific measurements.

Type: [MeasurementInfo](../unittest_package_api/unittest_package_structs.md#struct-measurementinfo)

## interface NearEquatable\<CT, D>

```cangjie
public interface NearEquatable<CT, D> {
    func isNear(obj: CT, delta!: D): Bool
} 
```

Purpose: Determines whether an object is approximately equal based on a given delta.

### func isNear(CT, D)

```cangjie
public func isNear(obj: CT, delta!: D): Bool
```

Purpose: Determines whether an object is approximately equal based on a given delta.

Parameters:

- obj: CT - The object being compared.
- delta!: D - The delta for approximate equality comparison.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether the objects are approximately equal.

### extend Float16 <: NearEquatable\<Float16, Float16>

Purpose: Extends the [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) type with the [NearEquatable](#interface-nearequatablect-d) interface.

#### func isNear(Float16, Float16)

```cangjie
public func isNear(obj: Float16, delta!: Float16): Bool
```

Purpose: Determines whether an object is approximately equal based on a given delta.

Parameters:

- obj: [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) - The object being compared.
- delta!: [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) - The delta for approximate equality comparison.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether the objects are approximately equal.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if delta is negative or NaN.

### extend Float16 <: NearEquatable\<Float16, RelativeDelta\<Float16>>

Purpose: Extends the [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) type with the [NearEquatable](#interface-nearequatablect-d) interface using [RelativeDelta](../unittest_package_api/unittest_package_structs.md#struct-relativedeltat) for approximate calculations.

#### func isNear(Float16, RelativeDelta\<Float16>)

```cangjie
public func isNear(obj: Float16, delta!: RelativeDelta<Float16>): Bool
```

Purpose: Determines whether an object is approximately equal based on a given delta.

Parameters:

- obj: [Float16](../../core/core_package_api/core_package_intrinsics.md#float16) - The object being compared.
- delta!: [RelativeDelta](../unittest_package_api/unittest_package_structs.md#struct-relativedeltat)\<[Float16](../../core/core_package_api/core_package_intrinsics.md#float16)> - The delta for approximate equality comparison.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether the objects are approximately equal.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if delta is negative or NaN.

### extend Float32 <: NearEquatable\<Float32, Float32>

Purpose: Extends the [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) type with the [NearEquatable](#interface-nearequatablect-d) interface.

#### func isNear(Float32, Float32)

```cangjie
public func isNear(obj: Float32, delta!: Float32): Bool
```

Purpose: Determines whether an object is approximately equal based on a given delta.

Parameters:

- obj: [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) - The object being compared.
- delta!: [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) - The delta for approximate equality comparison.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether the objects are approximately equal.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if delta is negative or NaN.

### extend Float32 <: NearEquatable\<Float32, RelativeDelta\<Float32>>

Purpose: Extends the [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) type with the [NearEquatable](#interface-nearequatablect-d) interface using [RelativeDelta](../unittest_package_api/unittest_package_structs.md#struct-relativedeltat) for approximate calculations.

#### func isNear(Float32, RelativeDelta\<Float32>)

```cangjie
public func isNear(obj: Float32, delta!: RelativeDelta<Float32>): Bool
```

Purpose: Determines whether an object is approximately equal based on a given delta.

Parameters:

- obj: [Float32](../../core/core_package_api/core_package_intrinsics.md#float32) - The object being compared.
- delta!: [RelativeDelta](../unittest_package_api/unittest_package_structs.md#struct-relativedeltat)\<[Float32](../../core/core_package_api/core_package_intrinsics.md#float32)> - The delta for approximate equality comparison.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether the objects are approximately equal.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if delta is negative or NaN.

### extend Float64 <: NearEquatable\<Float64, Float64>

Purpose: Extends the [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) type with the [NearEquatable](#interface-nearequatablect-d) interface.

#### func isNear(Float64, Float64)

```cangjie
public func isNear(obj: Float64, delta!: Float64): Bool
```

Purpose: Determines whether an object is approximately equal based on a given delta.

Parameters:

- obj: [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - The object being compared.
- delta!: [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - The delta for approximate equality comparison.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether the objects are approximately equal.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if delta is negative or NaN.

### extend Float64 <: NearEquatable\<Float64, RelativeDelta\<Float64>>

Purpose: Extends the [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) type with the [NearEquatable](#interface-nearequatablect-d) interface using [RelativeDelta](../unittest_package_api/unittest_package_structs.md#struct-relativedeltat) for approximate calculations.

#### func isNear(Float64, RelativeDelta\<Float64>)

```cangjie
public func isNear(obj: Float64, delta!: RelativeDelta<Float64>): Bool
```

Purpose: Determines whether an object is approximately equal based on a given delta.

Parameters:

- obj: [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - The object being compared.
- delta!: [RelativeDelta](../unittest_package_api/unittest_package_structs.md#struct-relativedeltat)\<[Float64](../../core/core_package_api/core_package_intrinsics.md#float64)> - The delta for approximate equality comparison.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether the objects are approximately equal.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if delta is negative or NaN.## interface Reporter

```cangjie
sealed interface Reporter <TReport, TReturn>
```

Function: Base interface for reporters.

## interface TestClass

```cangjie
public interface TestClass {
    func asTestSuite(): TestSuite
}
```

Function: Provides a method to create [TestSuite](./unittest_package_classes.md#class-testsuite).

### func asTestSuite()

```cangjie
func asTestSuite(): TestSuite
```

Function: Method to create [TestSuite](./unittest_package_classes.md#class-testsuite).

Return value:

- [TestSuite](./unittest_package_classes.md#class-testsuite) - The test suite object.