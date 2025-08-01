/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.env

import std.collection.*
import std.fs.*
import std.io.*
import std.sync.*

const STDIN_FD: IntNative = 0
const STDOUT_FD: IntNative = 1
const STDERR_FD: IntNative = 2
const RTN_CODE_MIN_VAL: Int64 = -0x0000_0000_8000_0000 //-2147483648
const RTN_CODE_MAX_VAL: Int64 = 0x0000_0000_7fff_ffff //2147483647
const NULL_BYTE = "\0"
let mtx: Mutex = Mutex()
let outConsole: ConsoleWriter = ConsoleWriter(Int32(STDOUT_FD))
let errConsole: ConsoleWriter = ConsoleWriter(Int32(STDERR_FD))
let inConsole: ConsoleReader = ConsoleReader()

public func getProcessId(): Int64 {
    let currentPid: Int32 = unsafe { CJ_OS_GetCurrentPid() }
    return Int64(currentPid)
}

public func getCommand(): String {
    match (getCurrentProcessInfo()[0]) {
        case Some(command) => command
        case _ => throw EnvException("Can not get process command.")
    }
}

public func getCommandLine(): Array<String> {
    match (getCurrentProcessInfo()[2]) {
        case Some(commandLine) => commandLine
        case _ => throw EnvException("Can not get process commandLine.")
    }
}

public func getWorkingDirectory(): Path {
    match (getCurrentProcessInfo()[1]) {
        case Some(workDirPath) => workDirPath
        case _ => throw EnvException("Can not get process workingDirectory.")
    }
}

public func getHomeDirectory(): Path {
    homeDirectory()
}

public func getTempDirectory(): Path {
    tempDirectory()
}

public func getVariable(key: String): ?String {
    if (key.contains(NULL_BYTE)) {
        throw IllegalArgumentException("The path cannot contain null character!")
    }

    unsafe {
        let ck: CString = LibC.mallocCString(key)
        try {
            return synchronized(mtx) {
                nativeGetEnv(ck) // Note: No need to free.
            }
        } finally {
            LibC.free(ck)
        }
    }
}

public func getVariables(): Array<(String, String)> {
    match (getCurrentProcessInfo()[3]) {
        case Some(environments) => environments
        case _ => throw EnvException("Can not get process environment.")
    }
}

public func setVariable(key: String, value: String): Unit {
    if (key.contains(NULL_BYTE) || value.contains(NULL_BYTE)) {
        throw IllegalArgumentException("The path cannot contain null character!")
    }

    unsafe {
        try (ck = LibC.mallocCString(key).asResource(), cv = LibC.mallocCString(value).asResource()) {
            synchronized(mtx) {
                nativeSetEnv(ck.value, cv.value, Int32(1))
            }
        }
    }
}

public func removeVariable(key: String): Unit {
    if (key.contains(NULL_BYTE)) {
        throw IllegalArgumentException("The path cannot contain null character!")
    }

    unsafe {
        try (ck = LibC.mallocCString(key).asResource()) {
            synchronized(mtx) {
                nativeRemoveEnv(ck.value)
            }
        }
    }
}

public func getStdErr(): ConsoleWriter {
    errConsole
}

public func getStdIn(): ConsoleReader {
    inConsole
}

public func getStdOut(): ConsoleWriter {
    outConsole
}

public func atExit(callback: () -> Unit): Unit {
    CJ_CORE_AddAtexitCallback(callback)
}

public func exit(code: Int64): Nothing {
    let c: Int64 = if (code < RTN_CODE_MIN_VAL) {
        RTN_CODE_MIN_VAL
    } else if (code > RTN_CODE_MAX_VAL) {
        RTN_CODE_MAX_VAL
    } else {
        code
    }

    CJ_CORE_ExecAtexitCallbacks()
    processExit(Int32(c))
}

func getCurrentProcessInfo(): (Option<String>, Option<Path>, Option<Array<String>>, Option<Array<(String, String)>>) {
    let currentPid: Int32 = unsafe { CJ_OS_GetCurrentPid() }

    var processInfoC: CPointer<ProcessInfo> = synchronized(mtx) {
        unsafe { CJ_OS_GetProcessInfoByPid(currentPid) }
    }
    if (processInfoC.isNull()) {
        throw EnvException("Initialize current process failed.")
    }

    try {
        let processInfo: ProcessInfo = unsafe { processInfoC.read() }
        return getProcessInfo(processInfo)
    } finally {
        unsafe { CJ_OS_FreeProcessInfo(processInfoC) }
    }
}

func getProcessInfo(processInfo: ProcessInfo): (Option<String>, Option<Path>, Option<Array<String>>, Option<Array<(String, 
    String)>>) {
    let command: ?String = cStringToOption(processInfo.command)
    let workDir: ?String = cStringToOption(processInfo.workingDirectory)
    let workDirPath: ?Path = workDir.map {dir => Path(dir)}
    let commandLine: ?Array<String> = cpointerToArray(processInfo.commandLine)
    let environments: ?Array<(String, String)> = getEnvirments(processInfo.environment)
    return (command, workDirPath, commandLine, environments)
}

func cStringToOption(cstring: CString): ?String {
    if (cstring.isNull()) {
        return None
    }
    return cstring.toString()
}

func cpointerToArray(cpointer: CPointer<CString>): ?Array<String> {
    if (cpointer.isNull()) {
        return None
    }

    let arrList: ArrayList<String> = ArrayList<String>()
    var index: Int64 = 0
    var val: CString = unsafe { cpointer.read(index) }
    while (!val.isNull()) {
        arrList.add(val.toString())
        index++
        val = unsafe { cpointer.read(index) }
    }
    return arrList.toArray()
}

func getEnvirments(env: CPointer<CString>): ?Array<(String, String)> {
    if (env.isNull()) {
        return None
    }

    var envsList: ArrayList<(String, String)> = ArrayList<(String, String)>()
    var index: Int64 = 0
    var envStr: CString = unsafe { env.read(index) }

    while (!envStr.isNull()) {
        let envItem: String = envStr.toString()
        let spiltIndex: Int64 = envItem.indexOf("=") ?? -1
        if (spiltIndex > -1) {
            let envKey = envItem[..spiltIndex]
            let envVal = envItem[spiltIndex + 1..]
            envsList.add((envKey, envVal))
        }
        index++
        envStr = unsafe { env.read(index) }
    }

    return envsList.toArray()
}

func homeDirectory(): Path {
    let homeDir: CString = unsafe { CJ_OS_HomeDir() } // Note: no need to free.
    Path(homeDir.toString())
}

func tempDirectory(): Path {
    let tmpDirs: Array<?String> = [getVariable("TMPDIR"), getVariable("TMP"), getVariable("TEMP"),
        getVariable("TEMPDIR")]

    for (each in tmpDirs where each.isSome()) {
        return Path(each.getOrThrow())
    }

    Path("/tmp")
}

@When[os == "Windows"]
func nativeGetEnv(name: CString): Option<String> {
    let res: CString = unsafe { CJ_OS_GetEnvVal(name) } // No need to free
    if (res.isNull()) {
        return None
    }

    try {
        return res.toString()
    } finally {
        unsafe { LibC.free(res) }
    }
}

@When[os != "Windows"]
func nativeGetEnv(name: CString): Option<String> {
    let res: CString = unsafe { getenv(name) } // No need to free

    return if (res.isNull()) {
        None
    } else {
        res.toString()
    }
}

@When[os != "Windows"]
func nativeSetEnv(name: CString, value: CString, overwrite: Int32): Int32 {
    unsafe { setenv(name, value, overwrite) }
}

@When[os == "Windows"]
func nativeSetEnv(name: CString, value: CString, _: Int32): Int32 {
    let envstr: CString = unsafe { LibC.mallocCString(name.toString() + "=" + value.toString()) }
    let ret = unsafe { CJ_OS_SetEnvEntry(envstr) }
    unsafe { LibC.free(envstr) }
    ret
}

@When[os == "Windows"]
func getStdErrHandle(): IntNative {
    getStdHandle(STDERR_FD)
}

@When[os != "Windows"]
func getStdErrHandle(): IntNative {
    STDERR_FD
}

@When[os != "Windows"]
func nativeRemoveEnv(name: CString): Int32 {
    unsafe { unsetenv(name) }
}

@When[os == "Windows"]
func nativeRemoveEnv(name: CString): Int32 {
    let envstr: CString = unsafe { LibC.mallocCString(name.toString() + "=") }
    let ret = unsafe { CJ_OS_SetEnvEntry(envstr) }
    unsafe { LibC.free(envstr) }
    ret
}

@When[os == "Windows"]
func getStdOutHandle(): IntNative {
    getStdHandle(STDOUT_FD)
}

@When[os != "Windows"]
func getStdOutHandle(): IntNative {
    STDOUT_FD
}

@When[os == "Windows"]
func getStdInHandle(): IntNative {
    getStdHandle(STDIN_FD)
}

@When[os != "Windows"]
func getStdInHandle(): IntNative {
    STDIN_FD
}

@When[os == "Windows"]
func getStdHandle(fd: IntNative): IntNative {
    unsafe { CJ_OS_GetStdHandle(fd) }
}

@When[backend == "cjnative"]
func processExit(exitCode: Int32): Nothing {
    unsafe {
        FiniCJRuntime()
        exit(exitCode)
    }
    throw EnvException("Process is already closed.")
}
