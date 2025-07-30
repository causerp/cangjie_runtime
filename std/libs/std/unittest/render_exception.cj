/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest

import std.unittest.common.PrettyText
import std.unittest.mock.PrettyException

func renderException(exception: Exception, preamble: ?PrettyText): PrettyText {
    let text = PrettyText()
    if (let Some(preamble) <- preamble) {
        text.append(preamble)
    }
    if (let Some(prettyError) <- (exception as PrettyException)) {
        text.append(prettyError)
    } else {
        text.append(exceptionToString(exception))
    }
    text
}

func exceptionToString(e: Exception): String {
    let traceElementArray: Array<StackTraceElement> = e.getStackTrace()
    var msg = StringBuilder("An exception has occurred:${e}\n")
    let indexAfterLast = indexOfFirstIrrelevantEntry(traceElementArray)
    for (index in 0..indexAfterLast) {
        let element = traceElementArray[index]
        let declaringClass = element.declaringClass
        let fileName = element.fileName
        let lineNumber = element.lineNumber.toString()
        msg.append("\tat ${declaringClass}.${methodName(element)}(${fileName}:${lineNumber})")
        if (index != indexAfterLast - 1) {
            msg.append("\n")
        }
    }
    return msg.toString()
}

func indexOfFirstIrrelevantEntry(elements: Array<StackTraceElement>): Int64 {
    var index = elements.size - 1
    while (index > 0) {
        let element = elements[index]
        if (index == elements.size - 1 && isEntryPoint(element)) {
            index--
            continue
        }
        let frameInsideUnittest = elements[index].declaringClass.startsWith("std.unittest")
        if (frameInsideUnittest) {
            index--
            continue
        }
        let hasAnyFramesInsideUnittest = index != (elements.size - 1)
        if (hasAnyFramesInsideUnittest) {
            if (isLambda(element)) {
                // this wrapping lambda is the last irrelevant entry
                return index
            } else {
                return index + 1
            }
        } else {
            return elements.size
        }
    }
    return elements.size
}

@When[backend == "cjnative"]
func isEntryPoint(_: StackTraceElement): Bool {
    false
}

@When[backend == "cjnative"]
func isLambda(element: StackTraceElement): Bool {
    element.methodName.startsWith("lambda.")
}

@When[backend == "cjnative"]
func methodName(element: StackTraceElement): String {
    element.methodName.replace("::", ".")
}
