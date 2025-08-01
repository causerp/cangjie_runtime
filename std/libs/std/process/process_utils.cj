/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.process

import std.collection.*
import std.fs.*
import std.io.*

const STDIN_FD: IntNative = 0
const STDOUT_FD: IntNative = 1
const STDERR_FD: IntNative = 2
@When[os == "Windows"]
const INVALID_HANDLE: IntNative = 0

@When[os == "Windows"]
func isHandleValid(fileHandle: IntNative): Bool {
    return fileHandle != -1
}

@When[os == "Windows"]
func getStdHandle(fd: IntNative): IntNative {
    return unsafe { CJ_OS_GetStdHandle(fd) }
}

@When[os == "Windows"]
func getStdInHandle(): IntNative {
    return getStdHandle(STDIN_FD)
}

@When[os == "Windows"]
func getStdOutHandle(): IntNative {
    return getStdHandle(STDOUT_FD)
}

@When[os == "Windows"]
func getStdErrHandle(): IntNative {
    return getStdHandle(STDERR_FD)
}

@When[os == "Windows"]
func getNulFileHandle(): Option<IntNative> {
    let handle = unsafe { CJ_OS_GetNulFileHandle() }
    if (handle == 0) {
        return Option.None
    }
    return handle
}

@When[os == "Windows"]
func getNameFromCommand(cmd: ?String): Option<String> {
    let name: ?String = match (cmd) {
        case Some(v) =>
            if (v.contains("/")) {
                let arr = v.split("/", removeEmpty: true)
                Some(arr[arr.size - 1])
            } else if (v.contains("\\")) {
                let arr = v.split("\\", removeEmpty: true)
                Some(arr[arr.size - 1])
            } else {
                Some(v)
            }
        case _ => None
    }
    return name
}

@When[os != "Windows"]
const INVALID_HANDLE: IntNative = -1

@When[os != "Windows"]
func getNulFileHandle(): Option<IntNative> {
    var nullFileHandle: Option<IntNative>
    return try {
        File("/dev/null", ReadWrite).fileDescriptor.fileHandle
    } catch (_: FSException) {
        None
    }
}

@When[os != "Windows"]
func isHandleValid(fileHandle: IntNative): Bool {
    return fileHandle >= 0
}

@When[os != "Windows"]
func getStdInHandle(): IntNative {
    return STDIN_FD
}

@When[os != "Windows"]
func getStdOutHandle(): IntNative {
    return STDOUT_FD
}

@When[os != "Windows"]
func getStdErrHandle(): IntNative {
    return STDERR_FD
}

@When[os != "Windows"]
func getNameFromCommand(cmd: ?String): Option<String> {
    let name: ?String = match (cmd) {
        case Some(v) =>
            if (v.contains("/")) {
                let arr = v.split("/", removeEmpty: true)
                arr[arr.size - 1]
            } else {
                v
            }
        case _ => None
    }
    return name
}

func cStringToOption(cstring: CString): ?String {
    if (cstring.isNull()) {
        return None
    }

    return cstring.toString()
}

/**
 * cpointerToArray
 *
 * @param cpointer: CPointer<CString>
 * @return Array<String>
 */
func cpointerToArray(cpointer: CPointer<CString>): ?Array<String> {
    if (cpointer.isNull()) {
        return None
    }

    var arrList: ArrayList<String> = ArrayList<String>()
    var cp_index: Int64 = 0
    var val: CString = unsafe { cpointer.read(cp_index) }
    while (!val.isNull()) {
        arrList.add(val.toString())
        cp_index++
        val = unsafe { cpointer.read(cp_index) }
    }
    return arrList.toArray()
}

/**
 * getEnvirments
 *
 * @param envCpointer: CPointer<CString>
 * @return HashMap<String, String>
 */
func getEnvirments(envCpointer: CPointer<CString>): ?Map<String, String> {
    if (envCpointer.isNull()) {
        return None
    }

    var envsMap: HashMap<String, String> = HashMap<String, String>()
    var cp_index: Int64 = 0
    var envItem_c: CString = unsafe { envCpointer.read(cp_index) }
    while (!envItem_c.isNull()) {
        let envItem: String = envItem_c.toString()
        let spiltIndex: Int64 = envItem.indexOf("=") ?? -1
        if (spiltIndex > -1) {
            let envKey = envItem[..spiltIndex]
            let envVal = envItem[spiltIndex + 1..]
            envsMap.add(envKey, envVal)
        }
        cp_index++
        envItem_c = unsafe { envCpointer.read(cp_index) }
    }

    return envsMap
}

func readToByteBuffer(inputStream: InputStream): ByteBuffer {
    let tempSize: Int64 = 4096 // 4KB
    var buffer: ByteBuffer = ByteBuffer(tempSize)
    let tempArr: Array<UInt8> = Array<UInt8>(tempSize, repeat: 0)
    while (true) {
        let readLen = inputStream.read(tempArr)
        if (readLen <= 0) {
            break
        } else if (readLen == tempSize) {
            buffer.write(tempArr)
        } else {
            buffer.write(tempArr.slice(0, readLen))
        }
    }

    return buffer
}

func collectCStringArray(it: Iterable<CString>): Array<CString> {
    let collector: ArrayList<CString> = ArrayList<CString>()
    try {
        for (item in it) {
            collector.add(item)
        }
    } catch (e: Exception) {
        for (element in collector) {
            unsafe {
                LibC.free(element)
            }
        }
        throw e
    }
    return collector.toArray()
}
