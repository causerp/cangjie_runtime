/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.concurrent

import std.collection.ArrayList
import std.collection.concurrent.LinkedBlockingQueue
import std.sync.{AtomicUInt64, Mutex}

class ThreadGroupIterator<T> <: Iterator<T> {
    public ThreadGroupIterator(let group: ThreadGroup<T>) {}

    public override func next(): Option<T> {
        return group.nextResult()
    }
}

enum Result<T> {
    | Ok(T)
    | Ex(Exception)
    | Err(Error)
}

/**
 * A group of tasks launched within a threadScope.
 *
 * Each launched task contributes one result. Iterating the group waits for
 * those results and yields them in completion order.
 *
 * ThreadGroup<T> is scoped and is not safe for concurrent iteration.
 */
public class ThreadGroup<T> <: Iterable<T> {
    private let futures = ArrayList<Future<Unit>>()
    private let completed = LinkedBlockingQueue<Result<T>>()
    private let unconsumed: AtomicUInt64 = AtomicUInt64(0)
    private let mtx = Mutex()
    private var cancelled = false

    init() {}

    /**
     * Launches task in a new Cangjie thread and records its result.
     *
     * Exceptions and errors raised by task are captured and re-thrown when the
     * result is consumed during iteration.
     *
     * @param task the work to run on the new thread, producing one result.
     */
    public func launch(task: () -> T): Unit {
        synchronized(mtx) {
            unconsumed.fetchAdd(1)
            let future = spawn {
                try {
                    completed.add(Ok(task()))
                } catch (e: Exception) {
                    completed.add(Ex(e))
                } catch (e: Error) {
                    completed.add(Err(e))
                }
            }
            futures.add(future)
            if (cancelled) {
                future.cancel()
            }
        }
    }

    /**
     * Requests cancellation for every task launched by this group, and causes
     * subsequently launched tasks to be cancelled as well.
     */
    public func cancelAll(): Unit {
        synchronized(mtx) {
            cancelled = true
            for (future in futures) {
                future.cancel()
            }
        }
    }

    /**
     * Returns an iterator that waits for and consumes task results.
     *
     * The returned iterator's next() re-throws the exception or error of a
     * consumed task if that task failed.
     */
    public func iterator(): Iterator<T> {
        ThreadGroupIterator<T>(this)
    }

    func waitForAll() {
        for (_ in this) {}
    }

    func silentWaitForAll() {
        while (unconsumed.load() != 0) {
            completed.remove()
            unconsumed.fetchSub(1)
        }
    }

    func nextResult(): Option<T> {
        if (unconsumed.load() == 0) {
            return None
        }

        let result = completed.remove()
        unconsumed.fetchSub(1)

        match (result) {
            case Ok(v) => return v
            case Ex(e) => throw e
            case Err(e) => throw e
        }
    }
}

/**
 * Runs fn with a scoped ThreadGroup<T>.
 *
 * Before returning, this function waits for all tasks launched by the group.
 * Unconsumed task values are discarded. If fn fails, or if an unconsumed task
 * result fails, all launched tasks are cancelled and the first failure is rethrown.
 *
 * Do not let the ThreadGroup<T> escape the scope.
 *
 * @param fn the body to run with the scoped group; it may launch tasks on the group.
 * @return The return value of fn.
 * @throws Exception or Error if fn fails or an unconsumed task result fails.
 */
public func threadScope<T, R>(fn: (ThreadGroup<T>) -> R): R {
    let group = ThreadGroup<T>()
    try {
        let result = fn(group)
        group.waitForAll()
        return result
    } catch (e: Exception) {
        group.cancelAll()
        group.silentWaitForAll()
        throw e
    } catch (e: Error) {
        group.cancelAll()
        group.silentWaitForAll()
        throw e
    }
}
