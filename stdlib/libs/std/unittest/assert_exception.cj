/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/**
 * @file The file declares the class AssertException.
 *
 */
package std.unittest

/**
 * The AssertException.
 *
 */
public class AssertException <: Exception {
    let cause: ?CheckResult

    public init() {
        super()
        this.cause = None
    }

    init(message: String, cause: CheckResult) {
        super(message)
        this.cause = cause
    }

    public init(message: String) {
        super(message)
        this.cause = None
    }

    protected override func getClassName(): String {
        return "AssertException"
    }
}

/**
 * The AssertIntermediateException.
 *
 */
public class AssertIntermediateException <: Exception {
    let diagram: PowerAssertDiagram

    public let expression: String
    public let originalException: Exception

    init(exception: Exception, expression: String, message: String, diagram: PowerAssertDiagram) {
        super(message)
        this.originalException = exception
        this.expression = expression
        this.diagram = diagram
    }

    public func getOriginalStackTrace(): String {
        let traceElementArray = originalException.getStackTrace()
        var result = "Thrown exception while computing assert expression:\n" + originalException.toString() + "\n"
        for (element in traceElementArray) {
            var packageName = element.declaringClass
            var packageDelimiter = if (packageName.isEmpty()) { "" } else { "." }
            var methodName = element.methodName
            var fileName = element.fileName
            var lineNumber = element.lineNumber.toString()
            result += "\t at ${packageName}${packageDelimiter}${methodName}(${fileName}:${lineNumber})\n"
        }
        return result
    }

    protected override func getClassName(): String {
        return "AssertIntermediateException"
    }
}
