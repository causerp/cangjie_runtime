/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/**
 * @file
 *
 * This is a library for ToJson interface.
 */
package std.unittest.common

import std.collection.*

/**
 * This interface used for conversions JsonValue.
 */
protected interface ToJson {
    /**
     * Convert DataModel to JsonValue.
     *
     * @return json-converted JsonValue.
     *
     * @since 0.20.2
     *
     * @throws JsonException if DataModel cannot be converted to JsonValue.
     */
    func toJson(): JsonValue

    /**
     * Parses JsonValue data into DataModel.
     *
     * @param jv JsonValue in JSON data format.
     * @return parsed DataModel.
     *
     * @since 0.20.2
     *
     * @throws JsonException if jv cannot be converted to DataModel.
     */
    static func fromJson(jv: JsonValue): DataModel
}

/**
 * Extended DataModel to add func toJson() and func fromJson().
 */
extend DataModel <: ToJson {
    /**
     * Parses JsonValue data into DataModel.
     *
     * @param jv JsonValue in JSON data format.
     * @return parsed DataModel.
     *
     * @since 0.17.4
     *
     * @throws JsonException if jv cannot be converted to DataModel.
     */
    public static func fromJson(jv: JsonValue): DataModel {
        match (jv) {
            case jb: JsonBool => DataModelBool(jb.getValue())
            case ji: JsonInt => DataModelInt(ji.getValue())
            case jf: JsonFloat => DataModelFloat(jf.getValue())
            case js: JsonString => DataModelString(js.getValue())
            case ja: JsonArray => buildDMSeq(ja)
            case jo: JsonObject => buildDMStruct(jo)
            case _: JsonNull => DataModelNull()
            case _ => throw IllegalStateException()
        }
    }

    /**
     * Parses JsonArray data into DataModelSeq.
     *
     * @throws JsonException if any item of ja cannot be converted to DataModel.
     */
    private static func buildDMSeq(ja: JsonArray): DataModelSeq {
        let dms: DataModelSeq = DataModelSeq()
        let list: ArrayList<DataModel> = dms.getItems()
        let ji = ja.getItems()
        for (i in 0..ji.size) {
            list.add(fromJson(ji[i]))
        }
        return dms
    }

    /**
     * Parses JsonObject data into DataModelStruct.
     *
     * @throws JsonException if any value in jo cannot be converted to DataModel.
     */
    private static func buildDMStruct(jo: JsonObject): DataModelStruct {
        let dms: DataModelStruct = DataModelStruct()
        let list: ArrayList<Field> = dms.getFields()
        let map: HashMap<String, JsonValue> = jo.getFields()
        for ((str, jv) in map) {
            var dm: DataModel = fromJson(jv)
            var field: Field = Field(str, dm)
            list.add(field)
        }
        return dms
    }

    /**
     * Convert DataModel to JsonValue.
     *
     * @return json-converted JsonValue.
     *
     * @since 0.20.2
     *
     * @throws JsonException if DataModel cannot be converted to JsonValue.
     */
    public func toJson(): JsonValue {
        match (this) {
            case _: DataModelNull => return JsonNull()
            case dmb: DataModelBool => return JsonBool(dmb.getValue())
            case dmi: DataModelInt => return JsonInt(dmi.getValue())
            case dmf: DataModelFloat => return JsonFloat(dmf.getValue())
            case dmstr: DataModelString => return JsonString(dmstr.getValue())
            case dmseq: DataModelSeq => return toJson(dmseq)
            case dms: DataModelStruct => return toJson(dms)
            case _ => throw JsonException("Unmatched DataModel type!")
        }
    }

    /**
     * Convert DataModelSeq to JsonArray.
     *
     * @throws JsonException if DataModel cannot be converted to JsonValue.
     */
    private func toJson(dmseq: DataModelSeq): JsonArray {
        let ji = dmseq.getItems()
        let jv: JsonArray = JsonArray(ji.size)
        for (i in 0..ji.size) {
            jv.add(ji[i].toJson())
        }
        return jv
    }

    /**
     * Convert DataModelStruct to JsonObject.
     *
     * @throws JsonException if DataModel cannot be converted to JsonValue.
     */
    private func toJson(dms: DataModelStruct): JsonObject {
        let ji = dms.getFields()
        let jo: JsonObject = JsonObject(ji.size)
        for (i in 0..ji.size) {
            let fie = ji[i]
            let value: JsonValue = fie.getData().toJson()
            jo.put(fie.getName(), value)
        }
        return jo
    }
}
