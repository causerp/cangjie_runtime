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
import std.sync.*

const RTN_CODE_MIN_VAL: Int64 = -0x0000_0000_8000_0000 //-2147483648
const RTN_CODE_MAX_VAL: Int64 = 0x0000_0000_7fff_ffff //2147483647

const NULL_BYTE = "\0"
let mtx: Mutex = Mutex()

@When[backend == "cjnative"]
func getCommandLineArgsFromRuntime(): CPointer<CPointer<UInt8>> {
    unsafe {
        let argv = CJ_MRT_GetCommandLineArgs()
        return if (argv.isNull()) {
            argv
        } else {
            argv + 1
        }
    }
}

/**
 * CurrentProcess provide the base func for current process.
 */
@Deprecated[message: "Use related global functions in the std.env instead."]
public class CurrentProcess <: Process {
    let _stdIn: InputStream = ProcessInputStream(FileDescriptor(getStdInHandle()))
    let _stdOut: OutputStream = ProcessOutputStream(FileDescriptor(getStdOutHandle()))
    let _stdErr: OutputStream = ProcessOutputStream(FileDescriptor(getStdErrHandle()))

    init(pid: Int64, name: ?String, command: ?String, arguments: ?Array<String>, commandLine: ?Array<String>,
        workingDirectory: ?Path, environment: ?Map<String, String>) {
        super(pid, name, command, arguments, commandLine, workingDirectory, environment)
    }

    @When[os == "Windows"]
    ~init() {
        if (this._handle != INVALID_HANDLE) {
            unsafe { CJ_OS_CloseProcessHandle(this._handle) }
        }
    }

    public prop stdErr: OutputStream {
        get() {
            this._stdErr
        }
    }

    public prop stdOut: OutputStream {
        get() {
            this._stdOut
        }
    }

    public prop stdIn: InputStream {
        get() {
            this._stdIn
        }
    }

    public prop arguments: Array<String> {
        get() {
            this.getArgs()
        }
    }

    public prop homeDirectory: Path {
        get() {
            var homeDir: CString = unsafe { CJ_OS_HomeDir() } // Note: no need to free.
            var dir: Path = Path(homeDir.toString())
            return dir
        }
    }

    public prop tempDirectory: Path {
        get() {
            var e: Option<String> = getTempDir(this.getEnv("TMPDIR"), this.getEnv("TMP"), this.getEnv("TEMP"),
                this.getEnv("TEMPDIR"))
            return Path(e ?? "/tmp")
        }
    }

    func transOp(opt1: Option<String>, opt2: Option<String>): Option<String> {
        match (opt1) {
            case Some(_) => opt1
            case None => opt2
        }
    }

    func getTempDir(opt1: Option<String>, opt2: Option<String>, opt3: Option<String>, opt4: Option<String>): Option<String> {
        transOp(transOp(transOp(opt1, opt2), opt3), opt4)
    }

    public func getEnv(key: String): Option<String> {
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

    public func setEnv(k: String, v: String): Unit {
        if (k.contains(NULL_BYTE) || v.contains(NULL_BYTE)) {
            throw IllegalArgumentException("The path cannot contain null character!")
        }

        unsafe {
            try (ck = LibC.mallocCString(k).asResource(), cv = LibC.mallocCString(v).asResource()) {
                synchronized(mtx) {
                    nativeSetEnv(ck.value, cv.value, Int32(1))
                }
            }
        }
    }

    public func removeEnv(k: String): Unit {
        if (k.contains(NULL_BYTE)) {
            throw IllegalArgumentException("The path cannot contain null character!")
        }

        unsafe {
            try (ck = LibC.mallocCString(k).asResource()) {
                synchronized(mtx) {
                    nativeRemoveEnv(ck.value)
                }
            }
        }
    }

    func getArgs(): Array<String> {
        let argv = getCommandLineArgsFromRuntime()
        if (argv.isNull()) {
            return Array<String>()
        }

        var argc: Int64 = 0
        while (true) {
            let cstr: CPointer<UInt8> = unsafe { argv.read(argc) }
            if (cstr.isNull()) {
                break
            }
            argc++
        }

        let args: Array<String> = Array<String>(argc, repeat: String())
        for (argIndex in 0..argc) {
            let cstr: CPointer<UInt8> = unsafe { argv.read(argIndex) }

            let cstrLen: Int64 = unsafe { Int64(strlen(cstr)) }
            let arg: Array<UInt8> = Array<UInt8>(cstrLen, repeat: 0)
            for (charIndex in 0..cstrLen) {
                arg[charIndex] = unsafe { UInt8(cstr.read(charIndex)) }
            }
            args[argIndex] = String.fromUtf8(arg)
        }
        return args
    }

    /**
     * Sets the function to be called before the program ends normally.
     * Function description: atexit() is used to set a function to be called before the program ends normally. When the program returns from main by calling exit(),
     * The function specified by the function parameter is called before exit() ends the program.
     * Do not use the atexit function of the C language. Otherwise, unexpected problems may arise.
     *
     * @param callback Called Before Normal Exit.
     *
     * since 0.24.3
     */
    public func atExit(callback: () -> Unit): Unit {
        CJ_CORE_AddAtexitCallback(callback)
    }

    /**
     * exit() is used to terminate the execution of the current progetStdoutStreamcess and return the status parameter to the parent Process.
     * All buffer data of the Process is automatically written back and the files that are not closed are closed
     *
     * @param code Register the function to be executed before the Process exits.
     */
    public func exit(code: Int64): Nothing {
        var c: Int64 = code
        if (c < RTN_CODE_MIN_VAL) {
            c = RTN_CODE_MIN_VAL
        }
        if (c > RTN_CODE_MAX_VAL) {
            c = RTN_CODE_MAX_VAL
        }
        CJ_CORE_ExecAtexitCallbacks()
        processExit(Int32(c))
    }

    /**
     * Override Process func, support callback functions when currentProcess terminate.
     *
     * @param pid - process id, need to terminate
     * @param force - true terminated forcibly
     *                false terminated normally
     *
     * @throws ProcessException - if the pid invaild
     * @return Unit
     */
    protected func terminateAliveProcess(pid: Int32, force: Bool): Unit {
        let status: Int8 = unsafe { CJ_OS_GetProcessAliveStatus(Int32(pid), this._startTime) }
        // check the process still running, make sure not kill the wrong process.
        if (status == PROCESS_STATUS_ALIVE) {
            CJ_CORE_ExecAtexitCallbacks()
            unsafe { CJ_OS_Terminate(Int32(pid), force) }
            return
        }

        if (status == PROCESS_STATUS_PID_REUSED) {
            throw ProcessException("Process pid \"${pid}\" has been reused, not allow kill the new process.")
        }

        throw ProcessException("Process pid \"${pid}\" not exist, not allow kill process.")
    }
}

@When[backend == "cjnative"]
func processExit(exitCode: Int32): Nothing {
    unsafe {
        FiniCJRuntime()
        exit(exitCode)
    }

    throw ProcessException("Process is already closed.")
}
