/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.core

@When[backend == "cjnative"]
@Intrinsic
func isThreadObjectInited(): Bool

@When[backend == "cjnative"]
@Intrinsic
func getThreadObject(): Thread

@FastNative
foreign func CJ_MRT_SetCJThreadName(handle: CPointer<Unit>, name: CPointer<UInt8>, len: Int64): Unit

@FastNative
foreign func CJ_MRT_GetCJThreadId(handle: CPointer<Unit>): Int64

@FastNative
foreign func CJ_MRT_GetCurrentCJThread(): CPointer<Unit>

const INVALID_ID: Int64 = -1

public class Thread {
    static let exceptionHandler = AtomicBox<Option<(Thread, Exception) -> Unit>>(None)

    private let _name = AtomicBox<String>("")
    private let _hasCancellation = AtomicBool(false)
    private let _id = AtomicInt64(INVALID_ID)
    var _threadLocalMap: Option<ThreadLocalMap> = None
    // The `_rtCJThreadHandle` is a pointer to the underlying CJ thread,
    // when the CJ thread terminates, it will reclaim the memory pointered to by this pointer.
    // So, we should avoid the concurrent "use-after-free" problem.
    // The problem may occur when a thread access the pointer via a future object.
    // ---------------------------------------------------
    //   Thread 1                            Target thread
    // future.thread.name = "..."         Terminates and frees memory
    // ---------------------------------------------------
    // The solution is that we manage "reference counts" of the pointer,
    // and make sure freeing the memory only after there is no reference counts.
    // Note that the concurrent access problem occurs only when spawning a thread with a future object.
    private var _rtCJThreadHandle = CPointer<Unit>()
    // When the count == -1, it means the target thread has been terminated.
    private let _rtCJThreadHandleRefCount = AtomicInt64(0)

    // Should only be called within core package
    init() {}

    /**
     * Set the CJThread handle and get the CJThread id.
     * Note tat this method will be imported implicitly and called when creating a thread with a future.
     */
    protected func setRuntimeCJThreadHandle(handle: CPointer<Unit>): Unit {
        _rtCJThreadHandle = handle
        let cjThreadId = unsafe { CJ_MRT_GetCJThreadId(handle) }
        _id.store(cjThreadId)
    }

    /**
     * Wait until CJThread handle is set properly.
     * This method will be called by the entry function (i.e., `Future.execute`)
     * when creating a thread with a future to avoid a potential data race,
     * where the new thread may exit and destroy CJThreadHandle before setting it.
     *         T1                                      T2
     *  let fut = Future();
     *  CJ_MRT_RuntimeNewTask(Future.execute)
     *  fut.thread.setRuntimeCJThreadHandle()
     *                                          waitForCJThreadHandle()
     *                                          ...
     *                                          exit
     */
    func waitForCJThreadHandle(): Unit {
        while (_id.load() == INVALID_ID) {
            // sleep(0) is equivalent to yielding the current thread
            intrinsicSleep(0)
        }
    }

    /**
     * Called by the thread entry function `Future.execute`.
     * Wait until the reference count == 0, and mark it as terminated.
     */
    func clearRuntimeCJThreadHandle(): Unit {
        while (true) {
            let old = _rtCJThreadHandleRefCount.load()
            if (old == 0 && _rtCJThreadHandleRefCount.compareAndSwap(0, -1)) {
                _rtCJThreadHandle = CPointer<Unit>()
                return
            }
        }
    }

    /**
     * If the thread is running,
     * hold the thread handle and increase the count to keep it available.
     */
    private func acquireCJThreadHandle(): CPointer<Unit> {
        while (true) {
            let old = _rtCJThreadHandleRefCount.load()
            if (old == -1) { // `-1` means the thread has been terminated
                return CPointer<Unit>()
            } else if (_rtCJThreadHandleRefCount.compareAndSwap(old, old + 1)) {
                // `_rtCJThreadHandle` is always not null
                if (_rtCJThreadHandle.isNull()) {
                    throw Error("Invalid CJThread handle")
                }
                return _rtCJThreadHandle
            }
        }
        throw Error("Never reached")
    }

    private func releaseCJThreadHandle(): Unit {
        _rtCJThreadHandleRefCount.fetchAdd(-1)
    }

    // If a Cangjie thread is created without a Future object,
    // its Thread object will be lazy-constructed.
    public static prop currentThread: Thread {
        get() {
            if (isThreadObjectInited()) {
                return getThreadObject()
            } else {
                let thread = Thread()
                // We should also set the runtime CJThread handle here
                let rtCJThreadHandle = unsafe { CJ_MRT_GetCurrentCJThread() }
                // `rtCJThreadHandle` is always not null.
                if (rtCJThreadHandle.isNull()) {
                    throw Error("Invalid CJThread handle")
                }
                thread.setRuntimeCJThreadHandle(rtCJThreadHandle)
                setThreadObject(thread)
                thread
            }
        }
    }

    public prop id: Int64 {
        get() {
            var cjThreadId = _id.load()
            // Since we assign `_rtCJThreadHandle` and `_id` at the same time,
            // `_id` is always invalid.
            if (cjThreadId == INVALID_ID) {
                throw Error("Invalid thread id")
            }
            return cjThreadId
        }
    }

    public mut prop name: String {
        get() {
            _name.load()
        }
        set(newName) {
            _name.store(newName)
            // Assign the name to the underlying CJ thread if possible.
            let handle = unsafe { acquireArrayRawData(name.rawData()) }
            let rtCJThreadHandle = acquireCJThreadHandle()
            if (!rtCJThreadHandle.isNull()) {
                unsafe {
                    CJ_MRT_SetCJThreadName(rtCJThreadHandle, handle.pointer, name.size)
                }
                releaseCJThreadHandle()
            }
            unsafe { releaseArrayRawData(handle) }
        }
    }

    /**
     * Check whether the current Cangjie thread has termination requests,
     * i.e., whether its future has been marked as cancelled.
     */
    public prop hasPendingCancellation: Bool {
        get() {
            _hasCancellation.load()
        }
    }

    func setCancellationRequest(): Unit {
        this._hasCancellation.store(true)
    }

    public static func handleUncaughtExceptionBy(exHandler: (Thread, Exception) -> Unit): Unit {
        Thread.exceptionHandler.store(exHandler)
    }
}
