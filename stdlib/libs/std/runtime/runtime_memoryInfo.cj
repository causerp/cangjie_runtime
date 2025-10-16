/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.runtime

@When[backend == "cjnative"]
import std.fs.*

@Intrinsic
func getMaxCjHeapSize(): UIntNative

@Intrinsic
func getAllocatedCjHeapSize(): UIntNative

@Intrinsic
func getRealHeapSize(): UIntNative

@When[backend == "cjnative"]
@Intrinsic
func dumpCjHeapData(fd: Int32): Bool

@When[backend == "cjnative"]
@Frozen
@Intrinsic
public func blackBox<T>(input: T): T
 
class MemoryInfoException <: Exception {
    init(message: String) {
        super(message)
    }

    protected func getClassName(): String {
        return "MemoryInfoException"
    }
}

@Deprecated[message: "All static Properties are converted to public functions."]
public struct MemoryInfo {
    /**
     * Get the maximum heap size that can be used.
     */
    public static prop maxHeapSize: Int64 {
        get() {
            Int64(getMaxHeapSize())
        }
    }

    /**
     * Get the heap size that is allocated.
     */
    public static prop allocatedHeapSize: Int64 {
        get() {
            Int64(getAllocatedHeapSize())
        }
    }

    /**
     * Get the physical memory that is used by heap.
     */
    public static prop heapPhysicalMemory: Int64 {
        get() {
            getUsedHeapSize()
        }
    }
}

public func getMaxHeapSize(): Int64 {
    return Int64(getMaxCjHeapSize())
}

public func getAllocatedHeapSize(): Int64 {
    return Int64(getAllocatedCjHeapSize())
}

public func getUsedHeapSize(): Int64 {
    var ret = Int64(getRealHeapSize())
    match {
        case ret >= 0 => return ret
        case ret == -1 => throw MemoryInfoException("Failed to open the smaps file.")
        case ret == -2 => throw MemoryInfoException("Failed to get vaild value.")
        case _ => throw MemoryInfoException("Failed to get vaild errorcode.")
    }
}

@When[backend == "cjnative"]
public func dumpHeapData(path: Path): Unit {
    try (file = File(path, ReadWrite)) {
        let success = dumpCjHeapData(Int32(file.fileDescriptor.fileHandle))
        if (!success) {
            throw MemoryInfoException("Failed to dump heap data.")
        }
    }
    return
}
