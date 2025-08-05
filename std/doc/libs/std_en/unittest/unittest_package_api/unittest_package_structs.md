# Structures

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

Function: BatchInputProvider constructor.

Parameters:

- builder: () -> T - A closure for generating benchmark test inputs.

### mut func get(Int64)

```cangjie
public mut func get(idx: Int64): T
```

Function: Retrieves an element. The execution time of this function is included in the benchmark measurement and then excluded from the results as part of framework overhead calculation.

Parameters:

- idx : [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The index value of the element.

Return Value:

- T - The element value.

### mut func reset(Int64)

```cangjie
public mut func reset(max: Int64)
```

Function: Called before benchmark measurement. After calling this function, subsequent `get(i)` calls must successfully retrieve `i` in the range [0, max).

Parameters:

- max : [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The maximum value.

## struct BatchSizeOneInputProvider\<T>

```cangjie
public struct BatchSizeOneInputProvider<T> <: BenchInputProvider<T>{
    public BatchSizeOneInputProvider(let builder: () -> T)
}
```

Function: A benchmark input provider that generates inputs before each benchmark execution. 
The difference from `GenerateEachInputProvider` is that we can measure when the batch size is 1.
Each benchmark call is independent, so input generation is never included in the measurement.
Should be used if `GenerateEachInputProvider` yields poor quality results. This might occur when input generation takes significantly more time than the actual benchmark, or if the execution time of input generation is highly unstable.

Parent Types:

- [BenchInputProvider](unittest_package_interfaces.md#interface-benchinputprovider)\<T>

### BatchSizeOneInputProvider(() -> T)

```cangjie
public BatchSizeOneInputProvider(let builder: () -> T)
```

Function: BatchSizeOneInputProvider constructor.

Parameters:

- builder: () -> T - A lambda for generating benchmark test inputs.

### mut func get(Int64)

```cangjie
public mut func get(idx: Int64): T
```

Function: Retrieves an element. The execution time of this function is included in the benchmark measurement and then excluded from the results as part of framework overhead calculation.

Parameters:

- idx : [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The index value of the element.

Return Value:

- T - The element value.

### mut func reset(Int64)

```cangjie
public mut func reset(max: Int64)
```

Function: Called before benchmark measurement. After calling this function, subsequent `get(i)` calls must successfully retrieve `i` in the range [0, max).

Parameters:

- max: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The maximum value.

## struct CpuCycles

```cangjie
public struct CpuCycles <: Measurement {}
```

Function: Measures the number of CPU cycles using the native `rdtscp` instruction. Only available on x86 platforms.

Parent Types:

- [Measurement](unittest_package_interfaces.md#interface-measurement)

### prop conversionTable

```cangjie
prop conversionTable: MeasurementUnitTable
```

Function: Provides a unit conversion table for the current time.
For example: `[(1.0, "cycles")]`.

Type: [MeasurementUnitTable](../unittest_package_api/unittest_package_types.md#type-measurementunittable).

### prop name

```cangjie
prop name: String
```

Function: Provides a unique display name for the current time unit, e.g., `CpuCycles`.

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
The generation time is included in the benchmark measurement and then excluded from the final results as part of framework overhead calculation.

Parent Types:

- [BenchInputProvider](unittest_package_interfaces.md#interface-benchinputprovider)\<T>

### GenerateEachInputProvider(() -> T)

```cangjie
public GenerateEachInputProvider(let builder: () -> T)
```

Function: GenerateEachInputProvider constructor.

Parameters:

- builder: () -> T - A closure for generating benchmark test inputs.

### mut func get(Int64)

```cangjie
public mut func get(idx: Int64): T
```

Function: Retrieves an element. The execution time of this function is included in the benchmark measurement and then excluded from the results as part of framework overhead calculation.

Parameters:

- idx : [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The index value of the element.

Return Value:

- T - The element value.

### mut func reset(Int64)

```cangjie
public mut func reset(max: Int64)
```

Function: Called before benchmark measurement. After calling this function, subsequent `get(i)` calls must successfully retrieve `i` in the range [0, max).

Parameters:

- max : [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The maximum value.

## struct ImmutableInputProvider\<T>

```cangjie
public struct ImmutableInputProvider<T> <: BenchInputProvider<T> {
    public ImmutableInputProvider(let data: T)
}
```

Function: The simplest input provider, which simply copies data for each benchmark call. Suitable when the benchmark does not modify the input. It is used by default within the framework.

Parent Types:

- [BenchInputProvider](unittest_package_interfaces.md#interface-benchinputprovider)\<T>

### ImmutableInputProvider(T)

```cangjie
public ImmutableInputProvider(let data: T)
```

Function: ImmutableInputProvider constructor.

Parameters:

- data: T - The input for the benchmark test.

### mut func get(Int64)

```cangjie
public mut func get(idx: Int64): T
```

Function: Retrieves an element. The execution time of this function is included in the benchmark measurement and then excluded from the results as part of framework overhead calculation.

Parameters:

- idx : [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The index value of the element.

Return Value:

- T - The element value.

### static func createOrExisting(T, Int64)

```cangjie
public static func createOrExisting(arg: T, x!:Int64=0): ImmutableInputProvider<T>
```

Function: Creates or retrieves an ImmutableInputProvider object.

Parameters:

- arg : T - The parameter to be copied by the provider.
- x!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - An additional parameter for implementing overloading.

Return Value:

- ImmutableInputProvider\<T> - The input provider.

### static func createOrExisting\<U>(U): U where U <: BenchInputProvider\<T>

```cangjie
public static func createOrExisting<U>(arg: U): U where U <: BenchInputProvider<T>
```

Function: Creates or retrieves a subtype object of BenchInputProvider.

Parameters:

- arg : T - The parameter to be copied by the provider.

Return Value:

- U where U <: BenchInputProvider\<T> - The input provider.

## struct Perf

```cangjie
public struct Perf <: Measurement {
    public init()
    public init(counter: PerfCounter)
}
```

Function: Measures various hardware and software CPU counters using the Linux system call `perf_event_open`. Only available on Linux.

Parent Type:

- [Measurement](unittest_package_interfaces.md#interface-measurement)

### prop conversionTable

```cangjie
prop conversionTable: MeasurementUnitTable
```

Function: Provides a conversion table for corresponding CPU counters.

Type: [MeasurementUnitTable](../unittest_package_api/unittest_package_types.md#type-measurementunittable).

### prop name

```cangjie
prop name: String
```

Function: Provides a unique display name for the current CPU counter, e.g., `Perf(cycles)`.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string).

### init()

```cangjie
public init()
```

Function: Default constructor using CPU cycle counters.

### init(PerfCounter)

```cangjie
public init(counter: PerfCounter)
```

Function: Constructor specifying the CPU counter to measure.

Parameters:

- counter: [PerfCounter](unittest_package_enums.md#enum-perfcounter)

### func measure()

```cangjie
public func measure(): Float64
```

Function: Returns the value of the specified CPU counter.

Return Value:

- [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - Computed data for statistical analysis.

### func setup()

```cangjie
func setup()
```

Function: Initialization routine for this CPU counter. Called before each benchmark step.

## struct TimeNow

```cangjie
public struct TimeNow <: Measurement {
    public init()
    public init(unit: ?TimeUnit)
}
```

Function: Implementation of [Measurement](../../unittest/unittest_package_api/unittest_package_interfaces.md#interface-measurement) for measuring the time taken to execute a function.

Parent Type:

- [Measurement](unittest_package_interfaces.md#interface-measurement)

### prop conversionTable

```cangjie
prop conversionTable: MeasurementUnitTable
```

Function: Provides a unit conversion table for the current time.
Example: `[(1.0, "ns"), (1e3, "us"), (1e6, "ms"), (1e9, "s")]`.

Type: [MeasurementUnitTable](../unittest_package_api/unittest_package_types.md#type-measurementunittable).

### prop name

```cangjie
prop name: String
```

Function: Provides a unique display name for the current time unit, e.g., `Duration(ns)` or `Duration(s)`.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string).

### prop textDescription

```cangjie
prop textDescription: String
```

Function: A brief text description of this measurement that will appear in certain reports.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string).

### init()

```cangjie
public init()
```

Function: Default constructor with automatic output format selection.

### init(?TimeUnit)

```cangjie
public init(unit: ?TimeUnit)
```

Function: The `unit` parameter specifies the time unit to be used when printing results.

Parameters:

- unit: ?[TimeUnit](unittest_package_enums.md#enum-timeunit) - Specified time unit.

### func measure()

```cangjie
public func measure(): Float64
```

Function: Retrieves the current time for statistical analysis.

Return Value:

- [Float64](../../core/core_package_api/core_package_intrinsics.md#float64) - Computed data for statistical analysis.
```