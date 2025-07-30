/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.ast

public struct Position <: ToBytes {
    /* Fields */
    public let fileID: UInt32
    public let line: Int32
    public let column: Int32

    /* Constructors */

    /** Create an empty position. */
    public init() {
        fileID = 0
        line = 0
        column = 0
    }

    /** Create a new position which is formed by fileID, line, column. */
    public init(fileID: UInt32, line: Int32, column: Int32) {
        this.fileID = fileID
        this.line = line
        this.column = column
    }

    /* Methods */

    /** Returns true if and only if this position line and column equal to 0. */
    public func isEmpty(): Bool {
        return line == 0 && column == 0
    }

    /** Returns true if and only if the two positions are identical. */
    public operator func ==(r: Position): Bool {
        return this.fileID == r.fileID && this.line == r.line && this.column == r.column
    }

    /** Returns true if and only if the two positions are not identical. */
    public operator func !=(r: Position): Bool {
        return !(this == r)
    }

    /** Print the information of this position. */
    public func dump(): Unit {
        print("fileID: ${fileID}, line: ${line}, column: ${column}\n")
    }

    public func toBytes(): Array<UInt8> {
        var b1: Array<UInt8> = castUInt32ToBytes(this.fileID)
        var b2: Array<UInt8> = castInt32ToBytes(this.line)
        var b12: Array<UInt8> = concatBytes(b1, b2)
        var b3: Array<UInt8> = castInt32ToBytes(this.column)
        return concatBytes(b12, b3)
    }

    func toBytes(arr: Array<UInt8>, start1: Int64) {
        var start = start1
        start = castUInt32ToBytes(arr, start, this.fileID)
        start = castInt32ToBytes(arr, start, this.line)
        start = castInt32ToBytes(arr, start, this.column)
        return start
    }

    func getSize() {
        let size_fileID = 4
        let size_line = 4
        let size_column = 4
        return size_fileID + size_line + size_column
    }
}

func getMacroPosition(macroObjPtr: CPointer<Unit>) {
    var fileID: UInt32 = 0
    var line: Int32 = 0
    var column: Int32 = 0
    try (fileIDPtr = LibC.malloc<UInt32>().asResource(), linePtr = LibC.malloc<Int32>().asResource(), columnPtr = LibC.
        malloc<Int32>().asResource()) {
        unsafe {
            CJ_GetMacroPosition(macroObjPtr, fileIDPtr.value, linePtr.value, columnPtr.value)
            fileID = fileIDPtr.value.read(0)
            line = linePtr.value.read(0)
            column = columnPtr.value.read(0)
        }
    }
    return (fileID, line, column)
}
