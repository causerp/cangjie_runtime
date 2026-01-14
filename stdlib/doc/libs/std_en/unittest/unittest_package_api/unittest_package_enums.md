# Enums

## enum ExplicitGcType

```cangjie
public enum ExplicitGcType <: ToString {
    | Disabled
    | Heavy
    | Light
}
```

Function: Used to specify the `explicitGC` configuration parameter for the `@Configure` macro. Represents three different modes of [GC](../../runtime/runtime_package_api/runtime_package_funcs.md#func-gcbool) execution.

Parent Type:

- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

### Disabled

```cangjie
Disabled
```

Function: [GC](../../runtime/runtime_package_api/runtime_package_funcs.md#func-gcbool) will not be explicitly invoked by the framework.

### Heavy

```cangjie
Heavy
```

Function: [std.runtime.GC](../../runtime/runtime_package_api/runtime_package_funcs.md#func-gcbool)(heavy: true) will be explicitly invoked by the framework during performance test execution.

### Light

```cangjie
Light
```

Function: [std.runtime.GC](../../runtime/runtime_package_api/runtime_package_funcs.md#func-gcbool)(heavy: false) will be explicitly invoked by the framework during Benchmark function execution. This is the default setting.

### func toString()

```cangjie
public func toString(): String
```

Function: String representation of the three different [GC](../../runtime/runtime_package_api/runtime_package_funcs.md#func-gcbool) execution modes.

Returns:

- [String](../../../std_en/core/core_package_api/core_package_structs.md#struct-string) - String representation of the three different GC execution modes.

Example:

<!-- run -->
```cangjie
import std.unittest.*
import std.unittest.testmacro.*
import std.time.*
import std.runtime.*
import std.collection.*

var counter: Float64 = 0.0
var prevGC = 0
var o = Object()

class TestNoGcRunning <: Measurement {
    static var callCounter = 0
    let result: Float64 = 0.0

    public func setup() {
        @Assert(!isGCRunning())
    }

    public func measure(): Float64 {
        counter
    }
}


@Test
@Configure[explicitGC: Light]
class BenchGCLight {
    @BeforeAll
    func before() {
        prevGC = getGCCount()
    } 

    @Bench
    func foo() {
        for (i in 0..1000000) {
            o = ArrayList<Int64>(8)
        }
        counter += 1.0
    }

    @AfterAll
    func after() {
        let diff = getGCCount() - prevGC
        @Assert(diff >= 35) 
        @Assert(diff <= 60)
    }
}

@Test
@Configure[explicitGC: Heavy]
class BenchGCWait {
    @BeforeAll
    func before() {
        prevGC = getGCCount()
    } 

    @Bench
    func foo() {
        for (i in 0..1000000) {
            o = ArrayList<Int64>(8)
        }
        counter += 1.0
    }

    @AfterAll
    func after() {
        let diff = getGCCount() - prevGC
        @Assert(diff >= 45)
    }
}

```

## enum TimeUnit

```cangjie
public enum TimeUnit <: ToString {
    | Micros
    | Millis
    | Nanos
    | Seconds
}
```

Function: Time units that can be used in the [TimeNow](./unittest_package_structs.md#struct-timenow) constructor.

### Micros

```cangjie
Micros
```

Function: Unit in microseconds.

### Millis

```cangjie
Millis
```

Function: Unit in milliseconds.

### Nanos

```cangjie
Nanos
```

Function: Unit in nanoseconds.

### Seconds

```cangjie
Seconds
```

Function: Unit in seconds.

### func toString()

```cangjie
public func toString(): String
```

Function: Converts time to string representation.

Returns:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - String composed of four different time representations.

Example:

<!-- run -->
```cangjie
import std.time.*
import std.sync.*

@Test
@Measure[TimeNow(TimeUnit.Micros)]
class Test_Configure_Running_Case_01 {
    var count1 = AtomicInt64(0)
    var count2 = AtomicInt64(0)

    @AfterAll
    func afterAll(): Unit {
        @Assert(count1.load() >= 26)
        @Assert(count2.load() >= 101)
    }

    @Bench
    func case01(): Unit {
        sleep(0.95 * Duration.millisecond)
        count1.fetchAdd(1)
    }

    @Bench
    @Configure[batchSize: 10, minBatches: 10]
    func case02(): Unit {
        sleep(0.25 * Duration.millisecond)
        count2.fetchAdd(1)
    }
}

```

## enum PerfCounter

```cangjie
public enum PerfCounter <: ToString {
    | HW_CPU_CYCLES
    | HW_INSTRUCTIONS
    | HW_CACHE_REFERENCES
    | HW_CACHE_MISSES
    | HW_BRANCH_INSTRUCTIONS
    | HW_BRANCH_MISSES
    | HW_BUS_CYCLES
    | HW_STALLED_CYCLES_FRONTEND
    | HW_STALLED_CYCLES_BACKEND
    | HW_REF_CPU_CYCLES
    | SW_CPU_CLOCK
    | SW_TASK_CLOCK
    | SW_PAGE_FAULTS
    | SW_CONTEXT_SWITCHES
    | SW_CPU_MIGRATIONS
    | SW_PAGE_FAULTS_MIN
    | SW_PAGE_FAULTS_MAJ
    | SW_EMULATION_FAULTS
}
```

Function: Enumerates CPU counters supported by the [Perf](./unittest_package_structs.md#struct-perf) constructor.

For detailed information about specific CPU counters, refer to the documentation of the [perf_event_open](https://man7.org/linux/man-pages/man2/perf_event_open.2.html) system call in the Linux kernel.

Parent Type:

- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

### HW_CPU_CYCLES

```cangjie
HW_CPU_CYCLES
```

Function: Total CPU cycles.

### HW_INSTRUCTIONS

```cangjie
HW_INSTRUCTIONS
```

Function: Number of retired CPU instructions.

### HW_CACHE_REFERENCES

```cangjie
HW_CACHE_REFERENCES
```

Function: Number of cache accesses.

### HW_CACHE_MISSES

```cangjie
HW_CACHE_MISSES
```

Function: Number of cache misses.

### HW_BRANCH_INSTRUCTIONS

```cangjie
HW_BRANCH_INSTRUCTIONS
```

Function: Number of retired branch CPU instructions.

### HW_BRANCH_MISSES

```cangjie
HW_BRANCH_MISSES
```

Function: Number of branch prediction misses.

### HW_BUS_CYCLES

```cangjie
HW_BUS_CYCLES
```

Function: Number of bus cycles.

### HW_STALLED_CYCLES_FRONTEND

```cangjie
HW_STALLED_CYCLES_FRONTEND
```

Function: Number of CPU cycles wasted while waiting in the frontend stage of the CPU pipeline.

### HW_STALLED_CYCLES_BACKEND

```cangjie
HW_STALLED_CYCLES_BACKEND
```

Function: Number of CPU cycles wasted while waiting in the backend stage of the CPU pipeline.

### HW_REF_CPU_CYCLES

```cangjie
HW_REF_CPU_CYCLES
```

Function: Number of CPU cycles independent of frequency.

### SW_CPU_CLOCK

```cangjie
SW_CPU_CLOCK
```

Function: CPU clock time per CPU.

### SW_TASK_CLOCK

```cangjie
SW_TASK_CLOCK
```

Function: CPU clock time per task.

### SW_PAGE_FAULTS

```cangjie
SW_PAGE_FAULTS
```

Function: Number of page faults.

### SW_CONTEXT_SWITCHES

```cangjie
SW_CONTEXT_SWITCHES
```

Function: Number of operating system context switches.

### SW_CPU_MIGRATIONS

```cangjie
SW_CPU_MIGRATIONS
```

Function: Number of task migrations between CPUs.

### SW_PAGE_FAULTS_MIN

```cangjie
SW_PAGE_FAULTS_MIN
```

Function: Number of minor page faults.

### SW_PAGE_FAULTS_MAJ

```cangjie
SW_PAGE_FAULTS_MAJ
```

Function: Number of major page faults.

### SW_EMULATION_FAULTS

```cangjie
SW_EMULATION_FAULTS
```

Function: Number of unsupported instructions requiring kernel emulation.

### func toString()

```cangjie
public func toString(): String
```

Function: Converts counter to string representation.

Returns:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - String representation of the processor counter.

Example:

<!-- run -->
```cangjie
import std.unittest.*
import std.unittest.testmacro.*
import std.time.*

var counter: Float64 = 0.0

let perf0 = Perf(PerfCounter.HW_CPU_CYCLES)
let perf1 = Perf(PerfCounter.HW_INSTRUCTIONS)
let perf2 = Perf(PerfCounter.HW_CACHE_REFERENCES)
let perf3 = Perf(PerfCounter.HW_CACHE_MISSES)
let perf4 = Perf(PerfCounter.HW_BRANCH_INSTRUCTIONS)
let perf5 = Perf(PerfCounter.HW_BRANCH_MISSES)
let perf6 = Perf(PerfCounter.HW_BUS_CYCLES)
let perf8 = Perf(PerfCounter.HW_STALLED_CYCLES_BACKEND)
let perf9 = Perf(PerfCounter.HW_REF_CPU_CYCLES)
let perf10 = Perf(PerfCounter.SW_CPU_CLOCK)
let perf11 = Perf(PerfCounter.SW_TASK_CLOCK)
let perf12 = Perf(PerfCounter.SW_PAGE_FAULTS)
let perf13 = Perf(PerfCounter.SW_CONTEXT_SWITCHES)
let perf14 = Perf(PerfCounter.SW_CPU_MIGRATIONS)
let perf15 = Perf(PerfCounter.SW_PAGE_FAULTS_MIN)
let perf16 = Perf(PerfCounter.SW_PAGE_FAULTS_MAJ)
let perf17 = Perf(PerfCounter.SW_EMULATION_FAULTS)

@Test
@Measure[perf0, perf1, perf2, perf3, perf4, perf5, perf6, perf8, perf9, perf10, perf11, perf12, perf13, perf14, perf15, perf16, perf17]
class Test_CPU_01 {
    @BeforeEach
    func beforeEach() {
        counter = 0.0
    }
    
    @Bench
    func foo() {
        counter += 1.0
    }
}

```