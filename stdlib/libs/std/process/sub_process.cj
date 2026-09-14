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
import std.time.*

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

    // Wait-state cache: once the child has been reaped, the exit status is kept
    // on the object so any later wait() returns the same result instead of
    // failing with ECHILD. This is what makes wait() idempotent and makes a
    // timed-out wait() recoverable.
    // Contract: concurrent wait()/waitOutput() calls on the same SubProcess are
    // NOT supported. The cache is unsynchronized and only one caller can reap the
    // child, so a racing caller may observe ECHILD and get -1. Callers that need
    // concurrency must serialize the calls themselves.
    var _waitReaped: Bool = false
    var _waitExitCode: Int64 = -1

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

    // See the non-iOS SubProcess for the wait-state cache contract.
    var _waitReaped: Bool = false
    var _waitExitCode: Int64 = -1

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
    let exitCode: Int64 = getWaitExitCode(process, timeout ?? Duration.Zero)
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
    let exitCode: Int64 = getWaitExitCode(process, Duration.Zero)

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
func getWaitExitCode(process: SubProcess, timeout: Duration): Int64 {
    if (process._waitReaped) {
        return process._waitExitCode
    }
    let pid: Int32 = Int32(process.pid)
    var exitCode: Int64 = -1
    if (timeout > Duration.Zero) {
        // Bounded wait executed in the calling thread via
        // WaitForSingleObject(handle, timeoutMs). No background reaper thread is
        // spawned and no ExitInfo is allocated, so a timed-out wait leaves no
        // residual thread behind and leaks nothing; a later wait() still reads
        // the real exit code because the process handle stays open.
        let timeoutMs: UInt32 = timeoutToMilliseconds(timeout)
        let ret: Int32 = unsafe { CJ_OS_WaitSubProcessExitTimeout(process._handle, timeoutMs, inout exitCode) }
        if (ret == 0) {
            throw TimeoutException("wait subProcess(${pid}) timeout.")
        }
        if (ret == -1) {
            // Keep the existing wait() error contract: a native wait failure
            // returns -1 rather than introducing a new ProcessException.
            return -1
        }
    } else {
        var waitExitInfo_cp: CPointer<ExitInfo> = CPointer<ExitInfo>()
        try {
            waitExitInfo_cp = unsafe { CJ_OS_WaitSubProcessExit(process._handle) }
            exitCode = parseExitInfoPointer(waitExitInfo_cp, pid)
        } finally {
            if (!waitExitInfo_cp.isNull()) {
                unsafe { LibC.free(waitExitInfo_cp) }
            }
        }
    }
    process._waitExitCode = exitCode
    process._waitReaped = true
    return exitCode
}

@When[os == "Windows"]
func timeoutToMilliseconds(timeout: Duration): UInt32 {
    // UInt32.Max is INFINITE for WaitForSingleObject; clamp huge timeouts to it
    // so the millisecond conversion can never overflow.
    let duration: Duration = if (timeout >= MAX_TIMEOUT_DURATION) { MAX_TIMEOUT_DURATION } else { timeout }
    let millis: Int64 = duration.toMilliseconds()
    if (millis >= Int64(UInt32.Max)) {
        return UInt32.Max
    }
    if (millis <= 0) {
        return 0
    }
    return UInt32(millis)
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
func getWaitExitCode(process: SubProcess, timeout: Duration): Int64 {
    // Idempotent fast path: the child was already reaped by an earlier wait.
    if (process._waitReaped) {
        return process._waitExitCode
    }
    let pid: Int32 = Int32(process.pid)
    if (timeout <= Duration.Zero) {
        // Blocking wait executed in the calling thread. No background reaper is
        // spawned, so a later wait() can never be poisoned by a stray ECHILD.
        let exitCode: Int64 = unsafe { CJ_OS_WaitSubProcessExit(pid) }
        if (exitCode != -1) {
            process._waitExitCode = exitCode
            process._waitReaped = true
        }
        return exitCode
    }
    // timeout > Duration.Zero: poll with waitpid(pid, &status, WNOHANG). Each
    // poll either reaps the child (then the exit status is cached) or times out
    // cleanly. A timed-out wait leaves no residual thread behind, so a later
    // wait() still finds the (possibly zombie) child and returns its real exit
    // status instead of -1 (ECHILD).
    let waitDuration: Duration = if (timeout >= MAX_TIMEOUT_DURATION) { MAX_TIMEOUT_DURATION } else { timeout }
    let deadline: MonoTime = MonoTime.now() + waitDuration
    while (true) {
        var exitCode: Int64 = -1
        let ret: Int32 = unsafe { CJ_OS_WaitSubProcessExitNonBlocking(pid, inout exitCode) }
        if (ret == 1) {
            process._waitExitCode = exitCode
            process._waitReaped = true
            return exitCode
        }
        if (ret == 0) {
            if (MonoTime.now() >= deadline) {
                throw TimeoutException("wait subProcess(${pid}) timeout.")
            }
            sleep(WAIT_POLL_INTERVAL)
            continue
        }
        // ret == -1: the child is not waitable (ECHILD or other error).
        return -1
    }
    // Unreachable: the loop above exits only via return/throw.
    return -1
}
