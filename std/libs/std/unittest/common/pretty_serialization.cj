/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest.common

import std.collection.ArrayList

extend Color <: Serializable<Color> {
    public func serializeInternal(): DataModel {
        let code = match (this) {
            case RED => 0
            case GREEN => 1
            case YELLOW => 2
            case BLUE => 3
            case CYAN => 4
            case MAGENTA => 5
            case GRAY => 6
            case DEFAULT_COLOR => 7
        }
        return DataModelInt(code)
    }

    public static func deserialize(dm: DataModel): Color {
        let code = match (dm) {
            case dmi: DataModelInt => dmi.getValue()
            case _ => throw DataModelException("this data is not DataModelInt")
        }
        match (code) {
            case 0 => RED
            case 1 => GREEN
            case 2 => YELLOW
            case 3 => BLUE
            case 4 => CYAN
            case 5 => MAGENTA
            case 6 => GRAY
            case 7 => DEFAULT_COLOR
            case _ => throw Exception("Invalid serialized color.")
        }
    }
}

extend PrettyPrintableTextChunk <: Serializable<PrettyPrintableTextChunk> {
    public func serializeInternal(): DataModel {
        match (this) {
            case PPTextPiece(text) =>
                DataModelStruct()
                    .add(field<Int8>("code", 0))
                    .add(field<String>("text", text))
            case PPColorSwitch(color) =>
                DataModelStruct()
                    .add(field<Int8>("code", 1))
                    .add(field<Color>("color", color))
            case PPNewLine =>
                DataModelStruct()
                    .add(field<Int8>("code", 2))
        }
    }

    public static func deserialize(dm: DataModel): PrettyPrintableTextChunk {
        let dms = match (dm) {
            case dms: DataModelStruct => dms
            case _ => throw DataModelException("this data is not DataModelStruct")
        }
        match (Int8.deserialize(dms.get("code"))) {
            case 0 => PPTextPiece(String.deserialize(dms.get("text")))
            case 1 => PPColorSwitch(Color.deserialize(dms.get("color")))
            case 2 => PPNewLine
            case _ => throw Exception("Invalid serialized text chunk.")
        }
    }
}

extend PrettyText <: Serializable<PrettyText> {
    public func serializeInternal(): DataModel {
        this.data.serializeInternal()
    }

    public static func deserialize(dm: DataModel): PrettyText {
        match (dm) {
            case dms: DataModelSeq =>
                PrettyText(ArrayList<PrettyPrintableTextChunk>.deserialize(dms))
            case _ => throw DataModelException("this data is not DataModelSeq")
        }
    }
}
