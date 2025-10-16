/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.runtime

@When[backend == "cjnative"]
import {std.io.*, std.process.*, std.fs.*, std.env.*, std.sync.Mutex}

const TRACE_TYPE_SCHEDULE_VALUE: UInt16 = 0x0100
const TRACE_TYPE_RUNTIME_VALUE: UInt16 = 0x0200
const TRACE_TYPE_ALL_VALUE: UInt16 = 0xff00

/*
 * TraceType  is used to enable trace for collecting different types of event sets.
 */
@When[backend == "cjnative" && (os == "Windows" || os == "Linux")]
struct TraceType {
    var data: UInt16

    private init(traceType: UInt16) {
        this.data = traceType
    }

    public static let schedule: TraceType = TraceType(TRACE_TYPE_SCHEDULE_VALUE)
    public static let runtime: TraceType = TraceType(TRACE_TYPE_RUNTIME_VALUE)
    public static let all: TraceType = TraceType(TRACE_TYPE_ALL_VALUE)
    public operator func |(traceType: TraceType): TraceType {
        TraceType(this.data | traceType.data)
    }
}

@When[backend == "cjnative" && (os == "Windows" || os == "Linux")]
foreign {
    func CJ_ScheduleStartTrace(traceOpenType: UInt16): Bool

    func CJ_ScheduleStopTrace(): Bool

    func CJ_ScheduleDumpTrace(len: CPointer<Int32>): CPointer<UInt8>
}

@When[backend == "cjnative" && (os == "Windows" || os == "Linux")]
struct Trace {
    private static let traceLock: Mutex = Mutex()
    private init() {}

    /**
     * function for dump trace.
     */
    public unsafe static func dump(out: OutputStream): Unit {
        let lenPtr = LibC.malloc<Int32>(count: 1)
        if (lenPtr.isNull()) {
            throw IllegalMemoryException("Failed to malloc memory for len.")
        }

        try {
            while (true) {
                let dataPtr = CJ_ScheduleDumpTrace(lenPtr)
                if (dataPtr.isNull()) {
                    break
                }
                var data = Array<UInt8>(Int64(lenPtr.read()), {i => dataPtr.read(i)})
                out.write(data)
            }
        } finally {
            LibC.free(lenPtr)
        }
    }

    /**
     * function for start trace.
     */
    public static func start(traceOpenType: TraceType, out: OutputStream): Bool {
        synchronized(traceLock) {
            let result = unsafe { CJ_ScheduleStartTrace(traceOpenType.data) }
            if (!result) {
                return false
            }
            spawn {
                unsafe { dump(out) }
            }
            return true
        }
    }

    /**
     * function for stop trace.
     */
    public static func stop(): Bool {
        synchronized(traceLock) {
            unsafe { return CJ_ScheduleStopTrace() }
        }
    }
}

@When[backend == "cjnative" && (os == "Windows" || os == "Linux")]
func traceStartByConfig(): Bool {
    let cjTracePath = if (let Some(env) <- getVariable("cjTracePath")) {
        env
    } else {
        return false
    }

    try {
        let file = File(cjTracePath, Write)
        return Trace.start(TraceType.all, file)
    } catch (e: Exception) {
        return false
    }
}

@When[backend == "cjnative" && (os == "Windows" || os == "Linux")]
var g_traceStartByConfigFlag: Bool = traceStartByConfig()

@When[backend == "cjnative" && (os == "Windows" || os == "Linux")]
func traceStopByConfig(): Unit {
    if (g_traceStartByConfigFlag) {
        Trace.stop()
    }
}

@When[backend == "cjnative" && (os == "Windows" || os == "Linux")]
var _ = atExit(traceStopByConfig)
