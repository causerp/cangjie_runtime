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
 * This is a library for class JsonNull, JsonBool, JsonInt, JsonFloat, JsonString, JsonArray, JsonObject.
 */
package std.unittest.common

import std.collection.*

/*
 * Space for JSON output.
 */
const SPACE: Rune = r' '

/*
 * Size of indentation in JSON format.
 */
const INDENT_SIZE: Int64 = 2

/**
 * JsonNull class used for encapsulate JSON data: null.
 */
protected class JsonNull <: JsonValue {

    /**
     * Determine the JSON type to which the JsonNull belongs.
     *
     * @return type of the JsonNull is JsNull.
     *
     * @since 0.17.4
     */
    public func kind(): JsonKind {
        return JsNull
    }

    /**
     * Convert JsonNull to String.
     *
     * @return json-converted String is "".
     *
     * @since 0.17.4
     */
    public func toString(): String {
        return "null"
    }

    /**
     * Convert JsonNull to json-String.
     *
     * @return json-converted prettified String is "".
     *
     * @since 0.21.1
     */
    public func toJsonString(): String {
        return toString()
    }
}

/**
 * JsonBool class used for encapsulate JSON data: true or false.
 */
protected class JsonBool <: JsonValue {
    /* Json data of the JsonBool(Bool). */
    private var value: Bool

    /**
     * Create a new JsonBool object.
     * Construction with parameters.
     *
     * @param bv The json data of JsonBool.
     *
     * @since 0.17.4
     */
    public init(bv: Bool) {
        this.value = bv
    }

    /**
     * Get the value data of the JsonBool.
     *
     * @return value of the JsonBool.
     *
     * @since 0.17.4
     */
    public func getValue(): Bool {
        return value
    }

    /**
     * Determine the JSON type to which the JsonBool belongs.
     *
     * @return type of the JsonBool is JsBool.
     *
     * @since 0.17.4
     */
    public func kind(): JsonKind {
        return JsBool
    }

    /**
     * Convert JsonBool to String.
     *
     * @return json-converted String is value string data: true or false.
     *
     * @since 0.17.4
     */
    public func toString(): String {
        return value.toString()
    }

    /**
     * Convert JsonBool to json-String.
     *
     * @return json-converted prettified String is value string data: true or false.
     *
     * @since 0.21.1
     */
    public func toJsonString(): String {
        return toString()
    }
}

/**
 * JsonInt class used for encapsulate JSON data: number(integer).
 */
protected class JsonInt <: JsonValue {
    /* Json data of the JsonInt(Int64). */
    private var value: Int64

    /**
     * Create a new JsonInt object.
     * Construction with parameters.
     *
     * @param iv The json data of JsonInt.
     *
     * @since 0.17.4
     */
    public init(iv: Int64) {
        this.value = iv
    }

    /**
     * Get the value data of the JsonInt.
     *
     * @return value of the JsonInt.
     *
     * @since 0.17.4
     */
    public func getValue(): Int64 {
        return value
    }

    /**
     * Determine the JSON type to which the JsonInt belongs.
     *
     * @return type of the JsonInt is JsInt.
     *
     * @since 0.17.4
     */
    public func kind(): JsonKind {
        return JsInt
    }

    /**
     * Convert JsonInt to String.
     *
     * @return json-converted String is value string data.
     *
     * @since 0.17.4
     */
    public func toString(): String {
        return value.toString()
    }

    /**
     * Convert JsonInt to json-String.
     *
     * @return json-converted prettified String is value string data.
     *
     * @since 0.21.1
     */
    public func toJsonString(): String {
        return toString()
    }
}

/**
 * JsonFloat class used for encapsulate JSON data: number(float).
 */
protected class JsonFloat <: JsonValue {
    /* Json data of the JsonFloat(Float64). */
    private var value: Float64

    /**
     * Create a new JsonFloat object.
     * Construction with parameters.
     *
     * @param fv The json data of JsonFloat.
     *
     * @since 0.17.4
     */
    public init(fv: Float64) {
        this.value = fv
    }

    /**
     * Create a new JsonFloat object.
     * Construction with parameters.
     *
     * @param v The json data of JsonInt.
     *
     * @since 0.17.4
     */
    public init(v: Int64) {
        this.value = Float64(v)
    }

    /**
     * Get the value data of the JsonFloat.
     *
     * @return value of the JsonFloat.
     *
     * @since 0.17.4
     */
    public func getValue(): Float64 {
        return value
    }

    /**
     * Determine the JSON type to which the JsonFloat belongs.
     *
     * @return type of the JsonFloat is JsFloat.
     *
     * @since 0.17.4
     */
    public func kind(): JsonKind {
        return JsFloat
    }

    /**
     * Convert JsonFloat to String.
     *
     * @return json-converted String is value string data.
     *
     * @since 0.17.4
     */
    public func toString(): String {
        return value.toString()
    }

    /**
     * Convert JsonFloat to json-String.
     *
     * @return json-converted prettified String is value string data.
     *
     * @since 0.21.1
     */
    public func toJsonString(): String {
        return toString()
    }
}

/**
 * JsonString class used for encapsulate JSON data: string.
 */
protected class JsonString <: JsonValue {
    /* Json data of the JsonString(String). */
    var value: String

    /**
     * Create a new JsonString object.
     * Construction with parameters.
     *
     * @param sv The json data of JsonString.
     *
     * @since 0.17.4
     */
    public init(sv: String) {
        this.value = sv
    }

    /**
     * Get the value data of the JsonString.
     *
     * @return value of the JsonString.
     *
     * @since 0.17.4
     */
    public func getValue(): String {
        return value
    }

    /**
     * Determine the JSON type to which the JsonString belongs.
     *
     * @return type of the JsonString is JsString.
     *
     * @since 0.17.4
     */
    public func kind(): JsonKind {
        return JsString
    }

    /**
     * Convert JsonString to String.
     *
     * @return json-converted String is value string data.
     *
     * @since 0.17.4
     */
    public func toString(): String {
        let buff = WriteBuffer(value.size + 2)
        jsonWriteWithoutFormat(this, buff)
        return unsafe { String.fromUtf8Unchecked(buff.getAndClear()) }
    }

    /**
     * Convert JsonString to json-String.
     *
     * @return json-converted prettified String is value string data.
     *
     * @since 0.21.1
     */
    public func toJsonString(): String {
        let buff = WriteBuffer(value.size + 2)
        jsonWriteWithoutFormat(this, buff)
        return unsafe { String.fromUtf8Unchecked(buff.getAndClear()) }
    }
}

/**
 * JsonArray class used for encapsulate JSON data: array.
 */
protected class JsonArray <: JsonValue {
    /* Json data of the JsonArray(ArrayList<JsonValue>). */
    private var items: ArrayList<JsonValue>

    /**
     * Create a new JsonArray object.
     * Construction without parameters.
     *
     * @since 0.17.4
     */
    init(capacity: Int64) {
        items = ArrayList<JsonValue>(capacity)
    }

    public init() {
        items = ArrayList<JsonValue>()
    }
    /**
     * Create a new JsonArray object.
     * Construction with parameters.
     *
     * @param list type ArrayList<JsonValue>, the json data of JsonArray.
     *
     * @since 0.17.4
     */
    public init(list: ArrayList<JsonValue>) {
        items = list
    }

    /**
     * Create a new JsonArray object.
     * Construction with parameters.
     *
     * @param list type Array<JsonValue>,The json data of JsonArray.
     *
     * @since 0.17.4
     */
    public init(list: Array<JsonValue>) {
        items = ArrayList<JsonValue>(list)
    }

    /**
     * Determine the JSON type to which the JsonArray belongs.
     *
     * @return type of the JsonArray is JsArray.
     *
     * @since 0.17.4
     */
    public func kind(): JsonKind {
        return JsArray
    }

    /**
     * Convert JsonArray to Json-String.
     *
     * @return json-converted String is items string data.
     *
     * @since 0.17.4
     *
     * @throws JsonException if there exists JsonValue which cannot be converted to String.
     */
    public func toJsonString(): String {
        return toJsonString(0)
    }

    /**
     * Convert JsonArray to Json-String.
     *
     * @param depth of indentation in JSON format.
     * @return json-converted String is items string data.
     *
     * @since 0.17.4
     *
     * @throws JsonException if there exists JsonValue which cannot be converted to String.
     */
    public func toJsonString(depth: Int64, bracketInNewLine!: Bool = false, indent!: String = "  "): String {
        if (depth < 0) {
            throw IllegalArgumentException("Depth cannot be negative.")
        }
        if (!indent.IsContainOnlySpaceAndTab()) {
            throw IllegalArgumentException("Indent must be an empty string or any combination of spaces and tabs.")
        }
        let buff = WriteBuffer(asumecapacity(this))
        jsonWriteArray(this, buff, depth, bracketInNewLine, indent)
        return unsafe { String.fromUtf8Unchecked(buff.getAndClear()) }
    }

    /**
     * Convert JsonArray to String.
     *
     * @return json-converted String is items string data.
     *
     * @since 0.21.1
     *
     * @throws JsonException if there exists JsonValue which cannot be converted to String.
     */
    public func toString(): String {
        let buff = WriteBuffer(asumecapacity(this))
        jsonWriteWithoutFormat(this, buff)
        return unsafe { String.fromUtf8Unchecked(buff.getAndClear()) }
    }

    /**
     * Get the size of JsonArray.
     *
     * @return the size of items.
     *
     * @since 0.17.4
     */
    public func size(): Int64 {
        return items.size
    }

    /**
     * Add the Data to JsonArray.
     *
     * @param jv JsonValue data to be added.
     *
     * @since 0.17.4
     */
    public func add(jv: JsonValue): JsonArray {
        items.add(jv)
        return this
    }

    /**
     * Obtains the option version of JsonValue data of JsonArray at a specified location.
     *
     * @param index Index position.
     * @return get the option version of element of the index.
     *
     * @since 0.17.4
     */
    public func get(index: Int64): Option<JsonValue> {
        return items.get(index)
    }

    /**
     * Obtains JsonValue data of JsonArray at a specified location.
     *
     * @param index Index position.
     * @return get the element of the index.
     *
     * @since 0.17.4
     *
     * @throws JsonException if index of JsonArray does not exist.
     */
    public operator func [](index: Int64): JsonValue {
        return match (items.get(index)) {
            case Some(v) => v
            case None => throw JsonException("The index ${index} of JsonArray does not exist.")
        }
    }

    /**
     * Get the items data of JsonArray.
     *
     * @return the items of JsonArray.
     *
     * @since 0.17.4
     */
    public func getItems(): ArrayList<JsonValue> {
        return items
    }
}

/**
 * JsonObject class used for encapsulate JSON data: object.
 */
protected class JsonObject <: JsonValue {
    /* Json data of the JsonObject(HashMap<String,JsonValue>). */
    private var fields: HashMap<String, JsonValue>

    /**
     * Create a new JsonObject object.
     * Construction without parameters.
     *
     * @since 0.17.4
     */
    public init() {
        fields = HashMap<String, JsonValue>()
    }

    init(capacity: Int64) {
        fields = HashMap<String, JsonValue>(capacity)
    }

    /**
     * Create a new JsonObject object.
     * Construction with parameters.
     *
     * @param map The json data of JsonObject.
     *
     * @since 0.17.4
     */
    public init(map: HashMap<String, JsonValue>) {
        fields = map
    }

    /**
     * Determine the JSON type to which the JsonObject belongs.
     *
     * @return type of the JsonObject is JsObject.
     *
     * @since 0.17.4
     */
    public func kind(): JsonKind {
        return JsObject
    }

    /**
     * Convert JsonObject to Json-String.
     *
     * @return json-converted String is fields string data.
     *
     * @since 0.17.4
     *
     * @throws JsonException if there exists JsonValue which cannot be converted to String.
     */
    public func toJsonString(): String {
        return toJsonString(0)
    }

    /**
     * Convert JsonObject to Json-String.
     *
     * @param depth of indentation in JSON format.
     * @return json-converted String is fields string data.
     *
     * @since 0.17.4
     *
     * @throws JsonException if there exists JsonValue which cannot be converted to String.
     */
    public func toJsonString(depth: Int64, bracketInNewLine!: Bool = false, indent!: String = "  "): String {
        if (depth < 0) {
            throw IllegalArgumentException("Depth cannot be negative.")
        }
        if (!indent.IsContainOnlySpaceAndTab()) {
            throw IllegalArgumentException("Indent must be an empty string or any combination of spaces and tabs.")
        }
        let buff = WriteBuffer(asumecapacity(this))
        jsonWriteObject(this, buff, depth, bracketInNewLine, indent)
        return unsafe { String.fromUtf8Unchecked(buff.getAndClear()) }
    }

    /**
     * Convert JsonObject to String.
     *
     * @return json-converted String is fields string data.
     *
     * @since 0.21.1
     *
     * @throws JsonException if there exists JsonValue which cannot be converted to String.
     */
    public func toString(): String {
        let buff = WriteBuffer(asumecapacity(this))
        jsonWriteWithoutFormat(this, buff)
        return unsafe { String.fromUtf8Unchecked(buff.getAndClear()) }
    }

    /**
     * Get the size of JsonObject.
     *
     * @return the size of fields.
     *
     * @since 0.17.4
     */
    public func size(): Int64 {
        return fields.size
    }

    /**
     * Check whether the JsonObject contains a key.
     *
     * @param key Key position.
     * @return check whether the fields contains the key.
     *
     * @since 0.17.4
     */
    public func containsKey(key: String): Bool {
        return fields.contains(key)
    }

    /**
     * Put the Data to JsonObject.
     *
     * @param key Key position.
     * @param v JsonValue data.
     *
     * @since 0.17.4
     */
    public func put(key: String, v: JsonValue): Unit {
        fields.add(key, v)
    }

    /**
     * Obtains the option version of JsonValue data of JsonObject at a specified location.
     *
     * @param key Key position.
     * @return get option version of data corresponding to the key.
     *
     * @since 0.17.4
     */
    public func get(key: String): Option<JsonValue> {
        return fields.get(key)
    }

    /**
     * Obtains JsonValue data of JsonObject at a specified location.
     *
     * @param key Key position.
     * @return get data corresponding to the key.
     *
     * @since 0.17.4
     *
     * @throws JsonException if key of JsonObject does not exist.
     */
    public operator func [](key: String): JsonValue {
        return match (fields.get(key)) {
            case Some(v) => v
            case None => throw JsonException("The Value of JsonObject does not exist")
        }
    }

    /**
     * Get the fields data of JsonObject.
     *
     * @return the fields of JsonObject.
     *
     * @since 0.17.4
     */
    public func getFields(): HashMap<String, JsonValue> {
        return fields
    }
}

extend String {
    func IsContainOnlySpaceAndTab() {
        for (i in this) {
            if (i != b' ' && i != b'\t') {
                return false
            }
        }
        return true
    }
}
