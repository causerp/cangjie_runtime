package std.unittest

import std.sort.*
import std.convert.*
import std.math.*
import std.runtime.*
import std.time.*
import std.collection.*
/**
 * Interface for all kinds of data that can be collected and analyzed during benchmarking.
 */ 
public interface Measurement {

    @Frozen
    func setup(): Unit {} 

    /**
     * @return representation of the measurement data that will be used for statistical analisys
     * and should be suitable for substraction.
     */
    @Frozen
    func measure(): Float64 { 0.0 }

    /**
     * Conversion table for measured values, contains value multipliers mapped to measurement unit representation.
     */
    prop conversionTable: MeasurementUnitTable {
        get() { [(1.0, "")] }
    }

    /**
     * Name for this type of measurement. Helps to distinguish between different types of Measurement.
     */
    prop name: String {
        get() { "Measurement" }
    }

    /**
     * Simple description of the measurement to be displayed in some reports
     */
    prop textDescription: String {
        get() { "Measures ${name}" }
    }

    @Frozen
    prop info: MeasurementInfo {
        get() {
            MeasurementInfo(
                conversionTable, name, textDescription
            )
        }
    }
}

/**
* Aggregated description of the measurement to be displayed in some reports
*/
public struct MeasurementInfo {
    MeasurementInfo(
        let conversionTable: MeasurementUnitTable,
        let name: String,
        let textDescription: String
    ) {}
}

/**
 * Conversion table for <value>, contains <value> multiplier and its measurement unit. 
 */
public type MeasurementUnitTable = Array<(Float64, String)>

let RADIX_UNIT_TABLE: MeasurementUnitTable = [
    TimeUnit.Nanos.conversionRow(),
    TimeUnit.Micros.conversionRow(),
    TimeUnit.Millis.conversionRow(),
    TimeUnit.Seconds.conversionRow()
]

// TODO: use that for printing test duration as well 
func printDuration(dur: Duration): String {
    let duration = Float64(dur.toNanoseconds())
    TimeNow().conversionTable.toString(duration)
}


extend MeasurementUnitTable {
    private func adjustMeasurementPrecision(value: Float64): String {
        // calculate how much precision do we need to print 4 most significant digits
        // with at most 3 digits after the dot
        let precision = 3 - Int64(log10(clamp(value, 0.0001, 1000.0)))
        if (precision <= 5) {
            "${value.format(".${precision}")}"
        } else {
            "${value.format(".2G")}"
        }
    }

    /**
     * Representation of measured `value` in suitable measurement unit. 
     */
    func toString(value: Float64): String {
        let (boundary, unit) = suitablePair(value)
        toString(value, boundary: boundary, unit: unit)
    }

    /**
     * Representation of measured `value` in suitable measurement `unit` in `boundary`. 
     */
    func toString(value: Float64, boundary!: Float64, unit!: String): String {
        if (value.isInf() || value.isNaN()) {
            return value.toString()
        }

        let part = value / boundary
        let formattedPart = adjustMeasurementPrecision(part)
        if (unit.isEmpty()) {
            formattedPart
        } else {
            "${formattedPart} ${unit}"
        }
    }

    func suitablePair(value: Float64): (Float64, String) {
        this.sortBy(comparator: { a, b =>
            let (aMultiplier, _) = a
            let (bMultiplier, _) = b
            aMultiplier.compare(bMultiplier)
        })

        if (this.isEmpty()) {
            (1.0, "")
        } else {
            var result = (this[0][0], this[0][1])
            for ((b, n) in this) {
                let part = value / b
                if (part < 0.5) {
                    break
                }
                result = (b, n)
            }
            result
        }
    }

    func minToNonAdjustedPair(value: Float64): (Float64, String) {
        let (minK, minUnit) = if (this.isEmpty()) {
            (1.0, "")
        } else {
            var (_minK, _minUnit) = this[0]
            for ((k, unit) in this) {
                if (k < _minK) {
                    _minK = k
                    _minUnit = unit
                }
            }
            (_minK, _minUnit)
        }
        (value / minK, minUnit)
    }
}

/**
 * Measures how much time takes to execute a function.
 */
public struct TimeNow <: Measurement {
    var unit: ?TimeUnit = None
    /**
     * @param unit Allows to specify a unit of time that will be used for printing results.
     */
    @Frozen
    public init(unit: ?TimeUnit) {
        this.unit = unit
    }
    /**
     * Chooses output precision automatically for each case.
     */
    @Frozen
    public init() {}

    @Frozen
    public func measure(): Float64 {
        Float64(DateTime.now().toUnixTimeStamp().toNanoseconds())
    }

    public prop conversionTable: MeasurementUnitTable {
        get() {
            match (unit) {
                case Some(u) => [(u.inNanos(), u.toString())]
                case None => RADIX_UNIT_TABLE
            }
         }
    }

    public prop name: String {
        get() {
            let unitStr = match (unit) {
                case None => ""
                case Some(u) => "(${u})"
            } 
            "Duration${unitStr}" 
        }
    }

    public prop textDescription: String {
        get() {
            "Measures execution time using std.time.DateTime"
        }
    }

}

/**
 * Used to explicitly specify the time unit used when `TimeNow` prints time.
 */
public enum TimeUnit <: ToString {
    | Nanos
    | Micros
    | Millis
    | Seconds

    public func toString(): String {
        match (this) {
            case Nanos => "ns"
            case Micros => "us"
            case Millis => "ms"
            case Seconds => "s"
        }
    }

    func inNanos(): Float64 {
        match (this) {
            case Nanos => 1.0
            case Micros => 1e3
            case Millis => 1e6
            case Seconds => 1e9
        }
    }

    func conversionRow(): (Float64, String) {
        (inNanos(), toString())
    }
}


@When[arch=="x86_64"]
foreign func GetRdtsc(): UInt64
@When[arch=="x86_64"]
foreign func GetRdtscp(): UInt64

// corresponds to HW_REF_CPU_CYCLES Perf measurements
@When[arch=="x86_64"]
public struct CpuCycles <: Measurement {

    @Frozen
    public func measure(): Float64 { 
        unsafe { Float64(GetRdtscp()) }
    }

    public func setup() {}

    public prop conversionTable: MeasurementUnitTable {
        get() { [(1.0, "cycles")] }
    }

    public prop name: String {
        get() { "CpuCycles" }
    }

    public prop textDescription: String {
        get() {
            "Measures how many CPU cycles are taken by function execution using baremetal x86 RDTSCP instruction"
        }
    }
}

@When[os=="Linux"]
foreign func InitPerf(counter: IntNative): IntNative

@When[os=="Linux"]
foreign func ReadPerf(): UInt64

// todo check if it can work on ohos, and harmonyos
@When[os=="Linux"]
public struct Perf <: Measurement {
    public Perf(var counter: PerfCounter) {}

    public init() {
        this(PerfCounter.HW_INSTRUCTIONS)
    }

    public func setup() {
        let rc = unsafe { InitPerf(counter.asRaw()) }
        match (rc) {
            case 0 => return
            case 13 => // EACCESS
                throw Exception("""
Not enough permissions to access performance counters. You need to reduce required permission by 
setting `kernel.perf_event_paranoid` system configuration parameter to value 1 or less. 
On systemd distributions it can be done with: 
    sudo sysctl kernel.perf_event_paranoid=1
""")
            case 2|19|95 => // ENOENT|ENODEV|EOPNOTSUPP
                throw Exception("${counter} performance counter is unsupported by current CPU or linux kernel. errno=${rc}")
            case _ => throw Exception("Initialization for ${counter} performance counter failed. perf_event_open syscall returned errno=${rc}")
        }
    }

    @Frozen
    public func measure(): Float64 { 
        let result = unsafe { ReadPerf() }
        if (result == UInt64.Max) {
            throw Exception("Error while reading performance counter descriptor")
        }
        Float64(result)
    }

    public prop conversionTable: MeasurementUnitTable {
        get() { [(1.0, counter.unit())] }
    }

    public prop name: String {
        get() { "Perf(${counter.unit()})" }
    }

    public prop textDescription: String {
        get() { 
            "Measures how many ${counter.description()} has happened during the execution using linux perf facility with ${counter} counter.\n"+
            "For more details about specific counter see documentation for perf_event_open linux syscall" 
        }
    }
}


// Detailed cache counters are not supported yet
@When[os=="Linux"]
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


    func asRaw(): IntNative {
        match (this) {
            case HW_CPU_CYCLES => 0
            case HW_INSTRUCTIONS => 1 
            case HW_CACHE_REFERENCES => 2
            case HW_CACHE_MISSES => 3
            case HW_BRANCH_INSTRUCTIONS => 4
            case HW_BRANCH_MISSES => 5
            case HW_BUS_CYCLES => 6
            case HW_STALLED_CYCLES_FRONTEND => 7
            case HW_STALLED_CYCLES_BACKEND => 8
            case HW_REF_CPU_CYCLES => 9
            case SW_CPU_CLOCK => 10
            case SW_TASK_CLOCK => 11
            case SW_PAGE_FAULTS => 12
            case SW_CONTEXT_SWITCHES => 13
            case SW_CPU_MIGRATIONS => 14
            case SW_PAGE_FAULTS_MIN => 15
            case SW_PAGE_FAULTS_MAJ => 16
            case SW_EMULATION_FAULTS => 17
        }
    }

    func unit(): String {
        match (this) {
            case HW_CPU_CYCLES => "cycles"
            case HW_INSTRUCTIONS => "instr"
            case HW_CACHE_REFERENCES => "cache"
            case HW_CACHE_MISSES => "cmiss"
            case HW_BRANCH_INSTRUCTIONS => "branch"
            case HW_BRANCH_MISSES => "bmiss"
            case HW_BUS_CYCLES => "bcycles"
            case HW_STALLED_CYCLES_FRONTEND => "stalledf"
            case HW_STALLED_CYCLES_BACKEND => "stalledb"
            case HW_REF_CPU_CYCLES => "rcycles"
            case SW_CPU_CLOCK => "clock"
            case SW_TASK_CLOCK => "tclock"
            case SW_PAGE_FAULTS => "pf"
            case SW_CONTEXT_SWITCHES => "cswitch"
            case SW_CPU_MIGRATIONS => "cpumig"
            case SW_PAGE_FAULTS_MIN => "pfmin"
            case SW_PAGE_FAULTS_MAJ => "pfmaj"
            case SW_EMULATION_FAULTS => "emu"
        }
    }

    public func toString(): String {
        match (this) {
            case HW_CPU_CYCLES => "PERF_COUNT_HW_CPU_CYCLES"
            case HW_INSTRUCTIONS => "PERF_COUNT_HW_INSTRUCTIONS"
            case HW_CACHE_REFERENCES => "PERF_COUNT_HW_CACHE_REFERENCES"
            case HW_CACHE_MISSES => "PERF_COUNT_HW_CACHE_MISSES"
            case HW_BRANCH_INSTRUCTIONS => "PERF_COUNT_HW_BRANCH_INSTRUCTIONS"
            case HW_BRANCH_MISSES => "PERF_COUNT_HW_BRANCH_MISSES"
            case HW_BUS_CYCLES => "PERF_COUNT_HW_BUS_CYCLES"
            case HW_STALLED_CYCLES_FRONTEND => "PERF_COUNT_HW_STALLED_CYCLES_FRONTEND"
            case HW_STALLED_CYCLES_BACKEND => "PERF_COUNT_HW_STALLED_CYCLES_BACKEND"
            case HW_REF_CPU_CYCLES => "PERF_COUNT_HW_REF_CPU_CYCLES"
            case SW_CPU_CLOCK => "PERF_COUNT_SW_CPU_CLOCK"
            case SW_TASK_CLOCK => "PERF_COUNT_SW_TASK_CLOCK"
            case SW_PAGE_FAULTS => "PERF_COUNT_SW_PAGE_FAULTS"
            case SW_CONTEXT_SWITCHES => "PERF_COUNT_SW_CONTEXT_SWITCHES"
            case SW_CPU_MIGRATIONS => "PERF_COUNT_SW_CPU_MIGRATIONS"
            case SW_PAGE_FAULTS_MIN => "PERF_COUNT_SW_PAGE_FAULTS_MIN"
            case SW_PAGE_FAULTS_MAJ => "PERF_COUNT_SW_PAGE_FAULTS_MAJ"
            case SW_EMULATION_FAULTS => "PERF_COUNT_SW_EMULATION_FAULTS"
        }
    }

    func description(): String {
        match (this) {
            case HW_CPU_CYCLES => "raw CPU cycles"
            case HW_INSTRUCTIONS => "retired CPU instructions"
            case HW_CACHE_REFERENCES => "cache accesses"
            case HW_CACHE_MISSES => "cache misses"
            case HW_BRANCH_INSTRUCTIONS => "retired branch CPU instructions"
            case HW_BRANCH_MISSES => "branch prediction failures"
            case HW_BUS_CYCLES => "bus cycles"
            case HW_STALLED_CYCLES_FRONTEND => "CPU cycles was wasted on waiting in fronted phase of CPU pipeline"
            case HW_STALLED_CYCLES_BACKEND => "CPU cycles was wasted on waiting in backend phase of CPU pipeline"
            case HW_REF_CPU_CYCLES => "frequency independent CPU cycles"
            case SW_CPU_CLOCK => "per-CPU clock time"
            case SW_TASK_CLOCK => "per task CPU clock time"
            case SW_PAGE_FAULTS => "page faults"
            case SW_CONTEXT_SWITCHES => "OS context switches"
            case SW_CPU_MIGRATIONS => "task migrations between CPUs"
            case SW_PAGE_FAULTS_MIN => "minor page faults"
            case SW_PAGE_FAULTS_MAJ => "major page faults"
            case SW_EMULATION_FAULTS => "unsupported instructions that required kernel emulation"
        }
    }
}
 
let MEMORY_UNIT_TABLE: MeasurementUnitTable = [
    (1.0, "Bytes"),
    (Float64(2**10), "KiB"),
    (Float64(2**20), "MiB"),
    (Float64(2**30), "GiB")
]

// Measures various statistics of Cangjie Runtime
@When[backend == "cjnative"]
public struct Runtime <: Measurement {

    static var lastAccountedResult = 0.0
    static var unaccounted = 0.0

    public Runtime(let variant: RuntimeInfo) {}
    
    public func setup() {  
        // some measurements significantly interfere with explicitGC strategy
        // so we ensure that information from internal GC invocations will not be lost
        if (lastAccountedResult != 0.0 && measuresGC()) {
            unaccounted = measureRaw() - lastAccountedResult
        }
    }

    func measureRaw(): Float64 {
        match (variant) {
            case GCCount => Float64(getGCCount())
            case GCTime => Float64(getGCTime()) * 1000.0
            case AllocatedMemory =>
                let result = Float64(getAllocatedHeapSize() + getGCFreedSize())
                // make it monotonic because if gc is running, the above two calls
                // can produce unsychronized results which temporarily produce lower results.
                max(result, lastAccountedResult)
        }
    }

    @Frozen
    public func measure(): Float64 { 
        lastAccountedResult = measureRaw()

        if (unaccounted != 0.0) {
            let x = unaccounted
            unaccounted = 0.0
            Float64(lastAccountedResult) - x
        } else {
            Float64(lastAccountedResult)
        }
    }

    public prop conversionTable: MeasurementUnitTable {
        get() { 
            match (variant) {
                case AllocatedMemory => MEMORY_UNIT_TABLE
                case GCTime => RADIX_UNIT_TABLE
                case _ => [(1.0,"")]
            }
        }
    }

    public prop name: String {
        get() { "Runtime(${variant.shortName()})" }
    }

    public prop textDescription: String {
        get() { "Measures ${variant.description()}" }
    }

    func measuresGC(): Bool {
        match (variant) {
            case GCCount | GCTime => true
            case _ => false
        }
    }
}


// Measures various metrics provided by Cangjie runtime.
@When[backend == "cjnative"]
public enum RuntimeInfo {
    // Measures average number of GC invocations
    | GCCount
    // Measures how much each benchmark invocation increases GC duration.
    | GCTime
    // Measures how much memory was allocated
    | AllocatedMemory

    func shortName(): String {
        match (this) {
            case GCCount => "GCCount"
            case GCTime => "GCTime"
            case AllocatedMemory => "AllocatedMemory"
        }
    }

    func description(): String {
        match (this) {
            case GCCount => "average number of GC invocations per iteration"
            case GCTime => "how much time GC was executed per iteration"
            case AllocatedMemory => "allocated memory"
        }
    }
}
