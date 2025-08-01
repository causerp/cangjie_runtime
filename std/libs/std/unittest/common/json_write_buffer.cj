/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest.common

@FastNative
foreign func memcpy_s(dest: CPointer<UInt8>, destMax: UIntNative, src: CPointer<UInt8>, count: UIntNative): Int32

@FastNative
foreign func strlen(src: CPointer<UInt8>): UIntNative

@FastNative
foreign func CJ_CORE_Float64ToCPointer(num: Float64): CPointer<UInt8>

let BOOL_TRUE_STRING = "true".toArray()
let BOOL_FALSE_STRING = "false".toArray()
let NULL_STRING = "null".toArray()
const MIN_CAPACITY = 16
const BLANK: Byte = ' '
/*
 * This is a stringbuilder customized for json serialization.
 * Compared with stringbuilder, it has the following optimization points:
 *  1. Constructor with capacity, and func asumecapacity(jv: JsonVaule) is used to
 *     estimate the capacity in advance. Although this is not accurate,
 *     it can reduce a large amount of memory application and copy during
 *     long jsonvalue serialization.
 *  2. The cache(_buffer) is initialized with blank character. when adding blanks,
 *     only need to move the pointer.
 *  3. append(str: String), faster then StringBuilder.
 *  4. func removetail(), faster then StringBuilder.
 */
class WriteBuffer {
    private var _buffer: Array<Byte>
    private var _size: Int64 = 0

    /*
     * buff must be filled with blank
     */
    init(capacity: Int64) {
        let cap = if (capacity > MIN_CAPACITY) {
            capacity
        } else {
            MIN_CAPACITY
        }
        _buffer = Array<Byte>(cap, repeat: BLANK)
    }

    public prop size: Int64 {
        get() {
            return _size
        }
    }

    /*
     * buff must be filled with blank
     */
    func checkAndExpend(addition: Int64): Unit {
        let minCapacity = _size + addition
        let oldCapacity: Int64 = _buffer.size
        if (minCapacity < oldCapacity) {
            return
        }

        var newCapacity: Int64 = oldCapacity + (oldCapacity >> 1)
        if (newCapacity < minCapacity) {
            newCapacity = minCapacity
        }
        let newArr: Array<Byte> = Array<Byte>(newCapacity, repeat: BLANK)
        _buffer.copyTo(newArr, 0, 0, _size)
        _buffer = newArr
    }

    func append(arr: Array<Byte>): WriteBuffer {
        checkAndExpend(arr.size)

        if (arr.size < 32) {
            for (index in 0..arr.size) {
                _buffer[_size] = arr[index]
                _size++
            }
        } else {
            arr.copyTo(_buffer, 0, _size, arr.size)
            _size += arr.size
        }
        return this
    }

    func append(str: String): WriteBuffer {
        append(unsafe { str.rawData() })
        return this
    }

    func append(byte: Byte): WriteBuffer {
        checkAndExpend(1)
        _buffer[_size] = byte
        _size++
        return this
    }

    func append(n: Int64): WriteBuffer {
        let str = n.toString()
        checkAndExpend(str.size)
        append(unsafe { str.rawData() })
        return this
    }

    func append(fl: Float64): WriteBuffer {
        unsafe {
            let p: CPointer<UInt8> = CJ_CORE_Float64ToCPointer(fl)
            if (p.isNull()) {
                return this
            }
            let cpSize = Int64(strlen(p))
            checkAndExpend(cpSize)
            let dest = acquireArrayRawData(_buffer)
            memcpy_s(dest.pointer + _size, UIntNative(_buffer.size - _size), p, UIntNative(cpSize))
            releaseArrayRawData(dest)
            LibC.free(p)
            _size += cpSize
        }

        // the result of CJ_CORE_Float64ToCPointer have at least 6 decimal points
        // there is no out-of-bounds risk
        while (_buffer[_size - 1] == b'0') {
            _size--
        }
        if (_buffer[_size - 1] == b'.') {
            _size--
        }
        return this
    }

    func append(b: Bool): WriteBuffer {
        if (b) {
            append(BOOL_TRUE_STRING)
        } else {
            append(BOOL_FALSE_STRING)
        }
    }

    func appendBlank(n: Int64): WriteBuffer {
        checkAndExpend(n)
        _size += n
        return this
    }

    func removetail(): WriteBuffer {
        if (_size > 0) {
            _size--
        }
        return this
    }

    func appendEscape(str: String) {
        let escapenum = stringEscapeCharNumGet(str)
        if (escapenum == str.size) {
            append(str)
            return this
        } else {
            checkAndExpend(escapenum)
            let len = replaceEscapeChar(str, _buffer, from: _size)
            _size += len

            return this
        }
    }

    func getAndClear(): Array<Byte> {
        let ret = _buffer[0.._size]
        _buffer = Array<Byte>(0, repeat: BLANK)
        _size = 0
        return ret
    }
}

func jsonWriteWithoutFormat(json: JsonValue, buff: WriteBuffer): Unit {
    match (json) {
        case jo: JsonObject =>
            if (jo.size() == 0) {
                buff.append("{}".toArray())
                return
            }
            buff.append(b'{')
            for ((strKey, jv) in jo.getFields()) {
                buff.append(b'\"').appendEscape(strKey).append("\":".toArray())
                jsonWriteWithoutFormat(jv, buff)
                buff.append(b',')
            }
            buff.removetail()
            buff.append(b'}')
        case ja: JsonArray =>
            if (ja.size() == 0) {
                buff.append("[]".toArray())
                return
            }
            buff.append(b'[')
            for (item in ja.getItems()) {
                jsonWriteWithoutFormat(item, buff)
                buff.append(b',')
            }
            buff.removetail()
            buff.append(b']')
        case js: JsonString =>
            buff.append(b'\"').appendEscape(js.getValue()).append(b'\"')
        case jb: JsonBool =>
            buff.append(jb.getValue())
        case ji: JsonInt =>
            buff.append(ji.getValue())
        case jf: JsonFloat =>
            buff.append(jf.getValue())
        case _ =>
            buff.append(NULL_STRING)
        case _ => throw IllegalStateException()
    }
}

func jsonWriteObject(json: JsonObject, buff: WriteBuffer, depth: Int64, bracketInNewLine: Bool, indent: String): Unit {
    if (bracketInNewLine) {
        for (_ in 0..depth) {
            buff.append(indent)
        }
    }

    if (json.size() == 0) {
        buff.append("{}".toArray())
        return
    }

    buff.append(b'{')
    let new_depth = depth + 1
    for ((key, jv) in json.getFields()) {
        buff.append(b'\n')
        for (_ in 0..new_depth) {
            buff.append(indent)
        }
        buff.append(b'\"').appendEscape(key).append(b'\"').append(b':').appendBlank(1)
        match (jv) {
            case jo: JsonObject => jsonWriteObject(jo, buff, new_depth, false, indent)
            case ja: JsonArray => jsonWriteArray(ja, buff, new_depth, false, indent)
            case _ => jsonWriteWithoutFormat(jv, buff)
        }
        buff.append(b',')
    }
    buff.removetail()
    buff.append(b'\n')
    for (_ in 0..depth) {
        buff.append(indent)
    }
    buff.append(b'}')
}

func jsonWriteArray(json: JsonArray, buff: WriteBuffer, depth: Int64, bracketInNewLine: Bool, indent: String): Unit {
    if (bracketInNewLine) {
        for (_ in 0..depth) {
            buff.append(indent)
        }
    }

    if (json.size() == 0) {
        buff.append("[]".toArray())
        return
    }

    buff.append(b'[')
    let new_depth = depth + 1
    for (v in json.getItems()) {
        buff.append(b'\n')
        for (_ in 0..new_depth) {
            buff.append(indent)
        }
        match (v) {
            case jo: JsonObject => jsonWriteObject(jo, buff, new_depth, false, indent)
            case ja: JsonArray => jsonWriteArray(ja, buff, new_depth, false, indent)
            case _ => jsonWriteWithoutFormat(v, buff)
        }
        buff.append(b',')
    }
    buff.removetail()
    buff.append(b'\n')
    for (_ in 0..depth) {
        buff.append(indent)
    }
    buff.append(b']')
}

func asumecapacity(json: JsonValue): Int64 {
    match (json) {
        case jo: JsonObject =>
            var sum = 2
            for ((k, v) in jo.getFields()) {
                sum = sum + k.size + 4 // + "key": value,
                sum += asumecapacity(v)
            }
            return sum
        case ja: JsonArray =>
            var sum = 2
            for (v in ja.getItems()) {
                sum = sum + asumecapacity(v) + 1
            }
            return sum
        case js: JsonString =>
            return js.value.size + 2 // "value"
        case _: JsonBool =>
            return 5 // max of "false" and "true"
        case _: JsonInt =>
            return 22 // max len is 22
        case _: JsonFloat =>
            return 200 // not precision
        case _: JsonNull =>
            return 4 // len of "null" is 4
        case _ => throw IllegalStateException()
    }
}
