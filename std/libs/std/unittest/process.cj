/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest

import std.process.*
import std.sync.AtomicOptionReference
import std.fs.*
@When[os == "Windows"]
import std.convert.Parsable
import std.collection.*
import std.random.Random
import std.sync.ReentrantMutex

private let tempDir = TempDirectory()

struct WrappedProcess {
    WrappedProcess(
        private let process: SubProcess,
        private let stdOutFile: ?Path,
        private let stdErrFile: ?Path,
        private let exitCodeFile: ?Path
    ) {}

    private let status = AtomicOptionReference<CapturedProcessResult>()

    func wait(): Int64 {
        if (let Some(status) <- status.load()) {
            return status.exitCode
        }

        let realExitCode = process.wait()

        let stdOut = readCapturedFrom(stdOutFile)
        let stdErr = readCapturedFrom(stdErrFile)
        let capturedExitCode = readCapturedExitCode(exitCodeFile)

        // on Windows, realExitCode is likely always -1 because of how it's implemented in std.process
        // Unlike Unix, on Windows child processes are dying concurrently
        // and since std.process does take exit code by PID, it's impossible to detect the code
        // instead it always returns -1
        // so that's why we are preferring the captured on from file
        let exitCode = capturedExitCode ?? realExitCode

        let result = CapturedProcessResult(exitCode, stdOut, stdErr)
        this.status.compareAndSwap(None, Some(result))
        return exitCode
    }

    func terminate(): Unit {
        if (status.load().isSome()) {
            return
        }

        process.terminateSilent(force: true)
    }

    func stdout(): Array<Byte> {
        status.load()?.stdOut ?? []
    }

    func stderr(): Array<Byte> {
        status.load()?.stdErr ?? []
    }
}

private class CapturedProcessResult {
    CapturedProcessResult(
        let exitCode: Int64,
        let stdOut: Array<Byte>,
        let stdErr: Array<Byte>
    ) {}
}

// for tests only, Process.start can't be invoked from tests
func processStart(ctx: MainExecutionCtx): WrappedProcess {
    Process.start(ctx)
}

extend Process {
    static func start(ctx: MainExecutionCtx): WrappedProcess {
        let stdout = captureFor(ctx)
        let stderr = captureFor(ctx)
        let exitCodeFile = exitCodeFile()

        if (let Some(file) <- exitCodeFile) {
            removeFileSilent(file)
        }

        let cmd = ctx.executeCommand
        let (command, args) = interceptCommand(cmd.command, cmd.args.toArray(), exitCodeFile)

        let process = try {
            launch(
                command, args, environment: cmd.env,
                stdOut: redirectFor(stdout), stdErr: redirectFor(stderr)
            )
        } catch (cause: Exception) {
            stdout?.close() // std.process does consume these two
            stderr?.close() // so we only close them in the case of error
            throw cause
        }

        return WrappedProcess(process, stdout?.info.path, stderr?.info.path, exitCodeFile)
    }

    @When[os != "Windows"]
    private static func interceptCommand(
        command: String, args: Array<String>, exitCodeFile: ?Path): (String, Array<String>) {
        return (command, args)
    }

    @When[os == "Windows"]
    private static func interceptCommand(
        command: String, args: Array<String>, exitCodeFile: ?Path): (String, Array<String>) {
        // the code above is very fragile as cmd.exe has a lot of quirks
        // also note that invoking the command above manually from the terminal
        // may work in a different way because in this case it will be invoking
        // cmd.exe from another cmd.exe or pwsh.exe interpreting arguments in a different way
        let subArgs = ArrayList<String>()
        subArgs.add("/D") // disable AutoRun registry commands
        subArgs.add("/V:ON") // enable delayed evaluation for !ERRORLEVEL! to work
        subArgs.add("/C") // execute command: all remaining arguments are treated as command and its args
        subArgs.add(command)
        subArgs.add(all: args)
        subArgs.add(all: ["&", "set", "R=!ERRORLEVEL!", "&"]) // set, echo, & and others must be separate args
        if (let Some(path) <- exitCodeFile) {
            // the path shouldn't be quoted
            subArgs.add(all: ["echo", "!R!", ">", path.toString(), "&"])
        }
        subArgs.add(all: ["exit", "!R!"])

        return ("cmd.exe", subArgs.toArray())
    }

    // NOTE: we never use ProcessRedirect.Pipe because it can't be used
    // with current std.process due to implementation issues
    // causing coroutines scheduler stagnation
    private static func captureFor(ctx: MainExecutionCtx): ?File {
        match (ctx.outputReporter.capture) {
            case true => tempDir.createTempFile(prefix: "test-worker-", suffix: ".stdout")
            case _ => None
        }
    }

    private static func redirectFor(file: ?File): ProcessRedirect {
        match (file) {
            case Some(file) => FromFile(file)
            case None => Inherit
        }
    }

    @When[os != "Windows"]
    private static func exitCodeFile(): ?Path {
        return None
    }

    @When[os == "Windows"]
    private static func exitCodeFile(): ?Path {
        try {
            tempDir.createTempPath(prefix: "test-worker-", suffix: ".exit")
        } catch (cause: Exception) {
            throw Exception("Failed to create temp file in ${tempDir.path}: ${cause}")
        }
    }
}

extend SubProcess {
    func tryWait(): ?Int64 {
        try {
            interceptExitCode(wait())
        } catch (_) {
            None
        }
    }

    @When[os != "Windows"]
    private static func interceptExitCode(code: Int64): ?Int64 {
        Some(code)
    }

    @When[os == "Windows"]
    private static func interceptExitCode(code: Int64): ?Int64 {
        // Code -1 appears even if worker process returns zero (87 windows error code).
        // On Windows, exit code is always -1 if we invoked wait()
        // after the process actally completed and the corresponding pid
        // is no longer occupied
        match (code) {
            case -1 => None
            case exitCode => Some(exitCode)
        }
    }

    func terminateSilent(force!: Bool): Unit {
        if (isAlive()) {
            // on Linux it's always alive until we invoke waitpid()
            // however on Windows process dies concurrently
            // so we do have a race here and there is a chance to kill something
            // irrelevant but we have no better solution as it's better than nothing
            // this must be fixed in std.process and the only workaround is to
            // use isAlive() and catch exceptions
            try {
                terminate(force: force)
            } catch (cause: Exception) {
                eprintln("Failed to terminate worker process ${pid}: ${cause}")
            }
        }
    }
}

private func removeFileSilent(path: Path): Unit {
    try {
        remove(path)
    } catch (_) {
        // ignore, we don't care
    }
}

private func readCapturedFrom(path: ?Path): Array<Byte> {
    match (path) {
        case Some(path) where exists(path) =>
            try {
                File.readFrom(path)
            } catch (e: Exception) {
                "Failed to read capture file ${path}: ${e}".toArray()
            } finally {
                removeFileSilent(path)
            }
        case _ => Array<Byte>()
    }
}

@When[os != "Windows"]
private func readCapturedExitCode(path: ?Path): ?Int64 {
    return None
}

@When[os == "Windows"]
private func readCapturedExitCode(path: ?Path): ?Int64 {
    match (path) {
        case None => throw Exception("No captured exit code file created")
        case Some(path) =>
            var lastCause: ?Exception = None

            for (retry in 1..10) {
                try {
                    let code = Int64.parse(String.fromUtf8(File.readFrom(path)).trimAscii())
                    removeFileSilent(path)
                    return code
                } catch (cause: Exception) {
                    lastCause = cause
                }

                sleep(Duration.second * retry)
            }

            throw Exception("Faled to read exit code from file ${path}: ${lastCause}")
    }
}
