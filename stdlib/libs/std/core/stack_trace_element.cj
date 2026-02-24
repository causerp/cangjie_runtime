/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.core

public open class StackTraceElement <: ToString {
    public let declaringClass: String
    public let methodName: String
    public let fileName: String
    public let lineNumber: Int64

    public init(declaringClass: String, methodName: String, fileName: String, lineNumber: Int64) {
        this.declaringClass = declaringClass
        this.methodName = methodName
        this.fileName = fileName
        this.lineNumber = lineNumber
    }

    /**
     * Converts the call point information to a string representation
     * 
     * @return Returns a formatted string containing class name, method name, file name and line number information
     */
    public func toString(): String { 
        if (declaringClass.isEmpty() && methodName.isEmpty()) {
            return("${fileName}:${lineNumber}")
        } else {
            let packageDelimiter: String = if (declaringClass.isEmpty()) { "" } else { "." }
            return(
                "${declaringClass}${packageDelimiter}${methodName}(${fileName}:${lineNumber})")
        }
    }

    func equals(other: StackTraceElement): Bool {
        return this.declaringClass == other.declaringClass &&
            this.methodName == other.methodName &&
            this.fileName == other.fileName &&
            this.lineNumber == other.lineNumber
    }
}
