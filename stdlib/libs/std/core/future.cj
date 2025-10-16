/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.core

@Intrinsic
func futureInit<T>(future: Future<T>): Unit

@Intrinsic
func futureIsComplete<T>(future: Future<T>): Bool

@Intrinsic
func futureWait<T>(future: Future<T>, timeout: Int64): Unit

@Intrinsic
func futureNotifyAll<T>(future: Future<T>): Unit

@FastNative
foreign func CJ_CORE_PrintOomHint(): Unit

let INT64_MAX: Int64 = 0x7fff_ffff_ffff_ffffi64

private open class FutureResult {}

private class FutureResInit <: FutureResult {}

private class FutureOk<T> <: FutureResult {
    var value: T
    init(v: T) {
        value = v
    }
}

private class FutureErr <: FutureResult {
    static let cachedResult = FutureErr(globalOutOfMemoryError)
    var err: Error
    init(e: Error) {
        err = e
    }
}

private class FutureExcept <: FutureResult {
    var except: Exception
    init(e: Exception) {
        except = e
    }
}

public class Future<T> {
    // `_thread` must be the first field,
    // it will be accessed when spawning a runtime cj thread.
    private let _thread: Thread = Thread()
    private var result: FutureResult = FutureResInit()
    private var executeFn: () -> T

    private init(fn: () -> T) {
        this.executeFn = fn
        unsafe { futureInit(this) }
    }

    public prop thread: Thread {
        get() {
            _thread
        }
    }

    /**
     * Blocking the current thread,
     * waiting for the result of the thread corresponding to this Future<T> object.
     * @throws Exception or Error if an exception occurs in the corresponding thread.
     */
    public func get(): T {
        let isComplete = unsafe { futureIsComplete(this) }
        if (!isComplete) {
            unsafe { futureWait(this, Int64.Max) }
        }
        match (result) {
            case v: FutureOk<T> => return v.value
            case e: FutureExcept => throw e.except
            case e: FutureErr => throw e.err
            case _ => return get()
        }
    }

    /**
     * Non-blocking method that immediately returns None if thread has not finished execution.
     * Returns the computed result otherwise.
     * @throws Exception or Error if an exception occurs in the corresponding thread.
     */
    public func tryGet(): Option<T> {
        let isComplete = unsafe { futureIsComplete(this) }
        if (!isComplete) {
            return Option<T>.None
        }
        match (result) {
            case v: FutureOk<T> => return v.value
            case e: FutureExcept => throw e.except
            case e: FutureErr => throw e.err
            case _ => return get()
        }
    }

    /**
     * Blocking the current thread,
     * waiting for the result of the thread corresponding to this Future<T> object.
     * If the corresponding thread has not completed execution within `ns` nanoseconds,
     * the method will return `Option<T>.None`.
     * If `ns <= 0`, same as `get()`.
     * @throws Exception or Error if an exception occurs in the corresponding thread.
     */
    public func get(timeout: Duration): T {
        if (timeout <= Duration.Zero) {
            return get()
        }
        let isComplete = unsafe { futureIsComplete(this) }
        if (!isComplete) {
            // Wait for `ns` nanoseconds
            unsafe { futureWait(this, timeout.toNanoseconds()) }
            // Check whether the future is complete
            let isCompleteAfterWait = unsafe { futureIsComplete(this) }
            if (!isCompleteAfterWait) {
                throw TimeoutException()
            }
        }
        match (result) {
            case v: FutureOk<T> => return v.value
            case e: FutureExcept => throw e.except
            case e: FutureErr => throw e.err
            case _ => return get()
        }
    }

    /**
     * Mark the current future as cancelled.
     * Send a termination request to its executing thread.
     */
    public func cancel(): Unit {
        this._thread.setCancellationRequest()
    }

    /**
     * Execute the task (thread) and set its result.
     * This method is the entry function of a new thread with a future,
     * and it will be used by CodeGen directly and passed to Cangjie runtime.
     ** BE AWARE OF: **
     * This method is tied to the runtime implementation details,
     * and if you want to make any changes, you should consider
     * whether you need to update the runtime implementation as well.
     */
    func execute(): Unit {
        // Wait until `_thread` object is assigned with its CJThread handle,
        this._thread.waitForCJThreadHandle()
        // then, bind the object.
        setThreadObject(this._thread)
        try {
            this.result = FutureOk<T>(executeFn())
        } catch (ex: Exception) {
            this.result = FutureExcept(ex)
            handleException(ex)
        } catch (er: OutOfMemoryError) {
            this.result = FutureErr.cachedResult
            unsafe { CJ_CORE_PrintOomHint() }
        } catch (er: Error) {
            this.result = FutureErr(er)
            er.printStackTrace()
        } finally {
            unsafe { futureNotifyAll(this) }
        }
        this._thread.clearRuntimeCJThreadHandle()
        return
    }

    // ** BE AWARE OF: **
    // This method is tied to the runtime implementation details,
    // and if you want to make any changes, you should consider
    // whether you need to update the runtime implementation as well..
    static func executeClosure(fn: () -> T): Unit {
        try {
            fn()
        } catch (ex: Exception) {
            handleException(ex)
        } catch (_: OutOfMemoryError) {
            eprintln("An exception has occurred:")
            eprintln("    Out of memory")
        } catch (er: Error) {
            er.printStackTrace()
        }
        return
    }
}

/**
 * The optional argument type of the `spawn` expression.
 * Specific derived types of `ThreadContext` could affect the behavior of the thread at runtime.
 * Only for `MainThreadContext` by now.
 */
public interface ThreadContext {
    func end(): Unit
    func hasEnded(): Bool
}
