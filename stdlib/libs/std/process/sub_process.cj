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

/**
 * SubProcess
 *
 */
@When[os != "iOS"]
public class SubProcess <: Process {
    var _stdIn: OutputStream
    // Non-iOS exposes streams from fields initialized by the constructor.
    var _stdOut: InputStream
    var _stdErr: InputStream

    init(
        pid: Int64,
        name: ?String,
        command: ?String,
        arguments: ?Array<String>,
        commandLine: ?Array<String>,
        // Non-iOS stores directory and environment metadata directly on Process.
        workingDirectory: ?Path,
        environment: ?Map<String, String>,
        stdIn: OutputStream,
        stdOut: InputStream,
        stdErr: InputStream
    ) {
        super(pid, name, command, arguments, commandLine, workingDirectory, environment)
        // Non-iOS stores stream objects directly on the process wrapper.
        this._stdIn = stdIn
        this._stdOut = stdOut
        this._stdErr = stdErr
    }

    @When[os == "Windows"]
    ~init() {
        closeProcessHandleIfNeeded(this._handle)
    }

    public prop stdInPipe: OutputStream {
        get() {
            this._stdIn
        }
    }
    public prop stdOutPipe: InputStream {
        get() {
            this._stdOut
        }
    }
    public prop stdErrPipe: InputStream {
        get() {
            this._stdErr
        }
    }

    @Deprecated[message: "Use `public prop stdErrPipe: InputStream` instead."]
    public prop stdErr: InputStream {
        get() {
            this._stdErr
        }
    }

    @Deprecated[message: "Use `public prop stdOutPipe: InputStream` instead."]
    public prop stdOut: InputStream {
        get() {
            this._stdOut
        }
    }

    @Deprecated[message: "Use `public prop stdInPipe: OutputStream` instead."]
    public prop stdIn: OutputStream {
        get() {
            this._stdIn
        }
    }

    public func wait(timeout!: ?Duration = None): Int64 {
        subProcessWait(this, timeout)
    }

    public func waitOutput(): (Int64, Array<Byte>, Array<Byte>) {
        subProcessWaitOutput(this)
    }

    func closeStdStream(): Unit {
        subProcessCloseStdStream(this)
    }
}

@When[os == "iOS"]
@Deprecated
public class SubProcess <: Process {
    var _stdIn: OutputStream
    // iOS keeps pipe storage behind native accessors.
    var _stdOut: InputStream
    var _stdErr: InputStream

    init(
        pid: Int64,
        name: ?String,
        command: ?String,
        arguments: ?Array<String>,
        commandLine: ?Array<String>,
        workingDirectory: ?Path,
        environment: ?Map<String, String>,
        stdIn: OutputStream,
        stdOut: InputStream,
        stdErr: InputStream
    ) {
        super(pid, name, command, arguments, commandLine, workingDirectory, environment)
        // iOS stores stream objects through native accessors for the deprecated wrapper.
        setSubProcessStreams(this, stdIn, stdOut, stdErr)
    }

    @When[os == "Windows"]
    ~init() {
        closeProcessHandleIfNeeded(this._handle)
    }

    public prop stdInPipe: OutputStream {
        get() {
            subProcessStdInPipe(this)
        }
    }
    public prop stdOutPipe: InputStream {
        get() {
            subProcessStdOutPipe(this)
        }
    }
    public prop stdErrPipe: InputStream {
        get() {
            subProcessStdErrPipe(this)
        }
    }

    @Deprecated[message: "Use `public prop stdErrPipe: InputStream` instead."]
    public prop stdErr: InputStream {
        get() {
            subProcessStdErrPipe(this)
        }
    }

    @Deprecated[message: "Use `public prop stdOutPipe: InputStream` instead."]
    public prop stdOut: InputStream {
        get() {
            subProcessStdOutPipe(this)
        }
    }

    @Deprecated[message: "Use `public prop stdInPipe: OutputStream` instead."]
    public prop stdIn: OutputStream {
        get() {
            subProcessStdInPipe(this)
        }
    }

    public func wait(timeout!: ?Duration = None): Int64 {
        return subProcessWait(this, timeout)
    }

    public func waitOutput(): (Int64, Array<Byte>, Array<Byte>) {
        return subProcessWaitOutput(this)
    }

    func closeStdStream(): Unit {
        subProcessCloseStdStream(this)
    }
}

private func setSubProcessStreams(
    process: SubProcess,
    stdIn: OutputStream,
    stdOut: InputStream,
    stdErr: InputStream
): Unit {
    process._stdIn = stdIn
    process._stdOut = stdOut
    process._stdErr = stdErr
}

private func subProcessStdInPipe(process: SubProcess): OutputStream {
    process._stdIn
}

private func subProcessStdOutPipe(process: SubProcess): InputStream {
    process._stdOut
}

private func subProcessStdErrPipe(process: SubProcess): InputStream {
    process._stdErr
}

private func subProcessWait(process: SubProcess, timeout: ?Duration): Int64 {
    let exitCode: Int64 = getWaitExitCode(timeout ?? Duration.Zero, Int32(process.pid), process._handle)
    process.closeStdStream()
    return exitCode
}

private func subProcessWaitOutput(process: SubProcess): (Int64, Array<Byte>, Array<Byte>) {
    let outStreamFuture: Future<Array<Byte>> = spawn {
        => try {
            let outByteArrStream: ByteBuffer = readToByteBuffer(process._stdOut)
            return readToEnd(outByteArrStream)
        } catch (_: ProcessException) {
            throw ProcessException("OutputStream is invalid, not allow to read.")
        }
    }

    let errStreamFuture: Future<Array<Byte>> = spawn {
        => try {
            let errByteArrStream: ByteBuffer = readToByteBuffer(process._stdErr)
            return readToEnd(errByteArrStream)
        } catch (_: ProcessException) {
            throw ProcessException("ErrorStream is invalid, not allow to read.")
        }
    }

    let outArr: Array<Byte> = outStreamFuture.get()
    let errArr: Array<Byte> = errStreamFuture.get()
    let exitCode: Int64 = getWaitExitCode(Duration.Zero, Int32(process.pid), process._handle)

    process.closeStdStream()
    return (exitCode, outArr, errArr)
}

private func subProcessCloseStdStream(process: SubProcess): Unit {
    if (let Some(stdInStream) <- (process._stdIn as ProcessOutputStream)) {
        if (let Some(stdInPipeOutputStream) <- (stdInStream.outputStream as PipeOutputStream)) {
            try {
                stdInPipeOutputStream.close()
            } finally {
                stdInStream.outputStream = NullProcessStream()
            }
        }
    }

    if (let Some(stdOutStream) <- (process._stdOut as ProcessInputStream)) {
        if (let Some(stdOutPipeInputStream) <- (stdOutStream.inputStream as PipeInputStream)) {
            try {
                stdOutPipeInputStream.close()
            } finally {
                stdOutStream.inputStream = NullProcessStream()
            }
        }
    }

    if (let Some(stdErrStream) <- (process._stdErr as ProcessInputStream)) {
        if (let Some(stdErrPipeInputStream) <- (stdErrStream.inputStream as PipeInputStream)) {
            try {
                stdErrPipeInputStream.close()
            } finally {
                stdErrStream.inputStream = NullProcessStream()
            }
        }
    }
}

@When[os == "Windows"]
func getWaitExitCode(timeout: Duration, pid: Int32, handle: IntNative): Int64 {
    let exitCode: Int64
    if (timeout > Duration.Zero) {
        let future: Future<CPointer<ExitInfo>> = spawn {
            => return unsafe { CJ_OS_WaitSubProcessExit(handle) }
        }
        var waitExitInfo_cp: CPointer<ExitInfo> = CPointer<ExitInfo>()
        try {
            waitExitInfo_cp = if (timeout >= MAX_TIMEOUT_DURATION) {
                future.get(MAX_TIMEOUT_DURATION)
            } else {
                future.get(timeout)
            }
            return parseExitInfoPointer(waitExitInfo_cp, pid)
        } finally {
            if (!waitExitInfo_cp.isNull()) {
                unsafe { LibC.free(waitExitInfo_cp) }
            }
        }
    }

    var waitExitInfo_cp: CPointer<ExitInfo> = CPointer<ExitInfo>()
    try {
        waitExitInfo_cp = unsafe { CJ_OS_WaitSubProcessExit(handle) }
        return parseExitInfoPointer(waitExitInfo_cp, pid)
    } finally {
        if (!waitExitInfo_cp.isNull()) {
            unsafe { LibC.free(waitExitInfo_cp) }
        }
    }
}

@When[os == "Windows"]
func parseExitInfoPointer(waitExitInfo_cp: CPointer<ExitInfo>, pid: Int32): Int64 {
    if (waitExitInfo_cp.isNull()) {
        throw ProcessException("Wait subProcess exception, pid: ${pid} not exist.")
    }
    let waitExitInfo: ExitInfo = unsafe { waitExitInfo_cp.read() }
    if (waitExitInfo.error) {
        throw ProcessException("Wait subProcess exception, pid: ${pid} not exist.")
    }
    return waitExitInfo.exitCode
}

@When[os != "Windows"]
func getWaitExitCode(timeout: Duration, pid: Int32, _: IntNative): Int64 {
    return if (timeout > Duration.Zero) {
        let future: Future<Int64> = spawn {
            => return unsafe { CJ_OS_WaitSubProcessExit(pid) }
        }

        if (timeout >= MAX_TIMEOUT_DURATION) {
            future.get(MAX_TIMEOUT_DURATION)
        } else {
            future.get(timeout)
        }
    } else {
        unsafe { CJ_OS_WaitSubProcessExit(pid) }
    }
}
