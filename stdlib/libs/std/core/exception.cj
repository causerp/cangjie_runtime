/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.core

@Intrinsic
func fillInStackTrace(pc: RawArray<UInt64>, message: RawArray<UInt8>): RawArray<UInt64>

@Intrinsic
func decodeStackTrace(pc: UInt64, funcStart: UInt64, funcDesc: UInt64): StackTraceData

// This data structure is used to represent the StackTraceElement on the runtime.
// Get necessary datas by the intrinsic from runtime and construct StackTraceElement
// on frontend, i.e. func getStackTraceImpl(RawArray<UInt64>)
struct StackTraceData {
    let className: RawArray<UInt8> = EMPTY_UINT8_RAW_ARRAY
    let methodName: RawArray<UInt8> = EMPTY_UINT8_RAW_ARRAY
    let fileName: RawArray<UInt8> = EMPTY_UINT8_RAW_ARRAY
    let lineNumber: Int64 = 0
}

func getStackTraceImpl(pcArray: RawArray<UInt64>): Array<StackTraceElement> {
    // The size of pcArray is 3n+1 when some frames are folded, and the last frame is invalid.
    // In this case, discard the last frame.
    let frameSize = arraySize(pcArray) / 3
    let emptyElement = StackTraceElement("", "", "", 0)
    let stackTraceArray = Array<StackTraceElement>(frameSize, repeat: emptyElement)
    var eleSize: Int64 = 0
    for (i in 0..frameSize) {
        // PC and function start form one pair in pcArray
        let data = decodeStackTrace(arrayGet(pcArray, i * 3), arrayGet(pcArray, i * 3 + 1), arrayGet(pcArray, i * 3 + 2))
        // Ignore invalid stack trace data
        if (data.lineNumber == 0 && arraySize(data.fileName) == 0) {
            continue
        }
        if (data.lineNumber == -1) {
            continue
        }
        let stkEle = StackTraceElement(
            String(data.className),
            String(data.methodName),
            String(data.fileName),
            data.lineNumber
        )
        stackTraceArray[eleSize] = stkEle
        eleSize++
    }
    return stackTraceArray.clone(0..eleSize)
}

public open class Exception <: ToString {
    private var detailMessage: String = String.empty
    private var pcArray: RawArray<UInt64> = RawArray<UInt64>(1, repeat: 0)
    private var traceElementArray: Array<StackTraceElement> = []

    public init() {
        pcArray = fillInStackTrace(RawArray<UInt64>(1, repeat: 0), detailMessage.toArray().rawptr)
    }

    public init(message: String) {
        detailMessage = message
        pcArray = fillInStackTrace(RawArray<UInt64>(1, repeat: 0), detailMessage.toArray().rawptr)
    }

    protected open func getClassName(): String {
        return "Exception"
    }

    public open prop message: String {
        get() {
            return detailMessage
        }
    }

    public open func toString(): String {
        let className: String = getClassName()
        let message: String = this.message
        if (message.isEmpty()) {
            return className
        }
        return "${className}: ${message}"
    }

    public func printStackTrace(): Unit {
        eprintln("An exception has occurred:")
        eprintln(toString())
        traceElementArray = getStackTrace()
        for (element in traceElementArray) {
            if (element.declaringClass.isEmpty() && element.methodName.isEmpty()) { // simple stack trace format
                eprintln("\t at ${element.fileName}:${element.lineNumber}")
            } else {
                let packageDelimiter: String = if (element.declaringClass.isEmpty()) { "" } else { "." }
                eprintln(
                    "\t at ${element.declaringClass}${packageDelimiter}${element.methodName}(${element.fileName}:${element.lineNumber})")
            }
        }
    }

    public func getStackTrace(): Array<StackTraceElement> {
        getStackTraceImpl(pcArray)
    }
}
