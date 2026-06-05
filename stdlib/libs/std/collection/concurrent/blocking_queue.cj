/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.collection.concurrent

import std.sync.*
import std.time.*

@Deprecated[message: "Use LinkedBlockingQueue instead."]
public type BlockingQueue<E> = LinkedBlockingQueue<E>

/**
 * BlockingQueue is a concurrent queue with a blocking mechanism and supports a user-specified upper bound of capacity.
 */
public class LinkedBlockingQueue<E> {
    public let capacity: Int64 // the capacity of the queue	 
    private let takeMonitor = Monitor() // Monitor for blocking consumers when the queue is empty
    private let putMonitor = Monitor() // Monitor for blocking producers when the queue is full
    private let putQsize = AtomicInt64(0) // Number of elements that are enqueuing.
    private let takeQsize = AtomicInt64(0) // Number of elements that are being dequeued.
    private let front: AtomicReference<Block<E>> // head of BlockingQueue.
    private let rear: AtomicReference<Block<E>> // tail of BlockingQueue.
    private let count = AtomicInt64(0)

    public init(capacity: Int64) {
        if (capacity <= 0) {
            throw IllegalArgumentException("Invalid size of BlockingQueue: ${capacity}.")
        }

        this.capacity = capacity
        let block = Block<E>(0)
        front = AtomicReference<Block<E>>(block)
        rear = AtomicReference<Block<E>>(block)
    }

    public init() {
        this(0x7FFF_FFFF_FFFF_FFFF) // Int64.Max
    }

    @Deprecated[message: "Use the other version of `init` instead."]
    public init(capacity: Int64, elements: Array<E>) {
        if (capacity <= 0) {
            throw IllegalArgumentException("Invalid size of BlockingQueue: ${capacity}.")
        }

        if (capacity < elements.size) {
            throw IllegalArgumentException("Size of BlockingQueue should be equal or greater than ${elements.size}.")
        }

        this.capacity = capacity
        let block = Block<E>(0)
        front = AtomicReference<Block<E>>(block)
        rear = AtomicReference<Block<E>>(block)

        for (e in elements) {
            let _ = tryEnqueue(e)
        }
    }

    @Deprecated[message: "Use the other version of `init` instead."]
    public init(capacity: Int64, elements: Collection<E>) {
        if (capacity <= 0) {
            throw IllegalArgumentException("Invalid size of BlockingQueue: ${capacity}.")
        }

        if (capacity < elements.size) {
            throw IllegalArgumentException("Size of BlockingQueue should be equal or greater than ${elements.size}.")
        }

        this.capacity = capacity
        let block = Block<E>(0)
        front = AtomicReference<Block<E>>(block)
        rear = AtomicReference<Block<E>>(block)

        for (e in elements) {
            let _ = tryEnqueue(e)
        }
    }

    /**
     * Returns the number of elements in the BlockingQueue.
     *
     * It ensures to return the accurate number of elements in the BlockingQueue in sequential.
     * Note that getting 'size' prop is not atomic!
     * So, if elements are added or removed during execution of getting 'size',
     * the 'size' may be inaccurate.
     */
    public prop size: Int64 {
        get() {
            return count.load()
        }
    }

    /**
     * Blocking method to send the element @p element into the tail of the queue.
     * If there is no free space in the queue, the thread calling such method will be blocked,
     * and waiting for another thread calling 'dequeue' method to await.
     *
     * @param element: the element to send into the queue.
     *
     * A successful 'enqueue' will await the threads blocked by calling 'dequeue'.
     */
    @Deprecated[message: "Use member function `public func add(element: E): Unit` instead."]
    public func enqueue(element: E): Unit {
        add(element)
    }

    public func add(element: E): Unit {
        var prevCount: Int64 = -1
        putMonitor.lock()
        try {
            while (true) {
                if (count.load() != capacity) {
                    break
                }
                putQsize.fetchAdd(1)
                try {
                    if (count.load() == capacity) {
                        putMonitor.wait()
                    }
                } finally {
                    putQsize.fetchSub(1)
                }
            }
            enqueueUnsafe(element)
            prevCount = count.fetchAdd(1)
            if (prevCount + 1 < capacity && putQsize.load() > 0) {
                putMonitor.notify()
            }
        } finally {
            putMonitor.unlock()
        }
        if (prevCount == 0 && takeQsize.load() > 0) {
            signalNotEmpty()
        }
    }

    /**
     * Blocking method to send the element @p element to the tail of the queue,
     * waiting up to @p timeout if the BlockingQueue is full.
     *
     * @param element: the element to send into the queue.
     * @param timeout: the waiting time.
     *
     * @return:
     * - true: if @p element is successfully pushed at the tail of the queue.
     * - false: if the waiting time exceeds @p timeout.
     */
    @Deprecated[message: "Use member function `public func add(element: E, timeout: Duration): Bool` instead."]
    public func enqueue(element: E, timeout: Duration): Bool {
        return add(element, timeout)
    }

    public func add(element: E, timeout: Duration): Bool {
        var prevCount: Int64 = -1
        putMonitor.lock()
        try {
            var remaining = timeout
            while (true) {
                if (count.load() != capacity) {
                    break
                }
                if (remaining <= Duration.Zero) {
                    return false
                }
                putQsize.fetchAdd(1)
                try {
                    if (count.load() == capacity) {
                        let startTime = MonoTime.now()
                        let _ = putMonitor.wait(timeout: remaining)
                        let endTime = MonoTime.now()
                        remaining -= endTime - startTime
                    }
                } finally {
                    putQsize.fetchSub(1)
                }
            }
            enqueueUnsafe(element)
            prevCount = count.fetchAdd(1)
            if (prevCount + 1 < capacity && putQsize.load() > 0) {
                putMonitor.notify()
            }
        } finally {
            putMonitor.unlock()
        }
        if (prevCount == 0 && takeQsize.load() > 0) {
            signalNotEmpty()
        }
        return true
    }

    /**
     * Blocking method to get and remove the element at the head of the queue.
     * If the queue is empty, the thread calling such method will be blocked,
     * and waiting for another thread calling 'enqueue' method to await.
     *
     * A successful 'dequeue' will await blocked threads calling 'enqueue'.
     *
     * @return:
     * - e: e is the element at the head of the queue.
     */
    @Deprecated[message: "Use member function `public func remove(): E` instead."]
    public func dequeue(): E {
        return remove()
    }

    public func remove(): E {
        var prevCount: Int64 = -1
        var value: E
        takeMonitor.lock()
        try {
            while (true) {
                if (count.load() != 0) {
                    break
                }
                takeQsize.fetchAdd(1)
                try {
                    if (count.load() == 0) {
                        takeMonitor.wait()
                    }
                } finally {
                    takeQsize.fetchSub(1)
                }
            }
            value = dequeueUnsafe()
            prevCount = count.fetchSub(1)
            if (prevCount > 1 && takeQsize.load() > 0) {
                takeMonitor.notify()
            }
        } finally {
            takeMonitor.unlock()
        }
        if (prevCount == capacity && putQsize.load() > 0) {
            signalNotFull()
        }
        return value
    }

    /**
     * Blocking method to get and remove the head of the queue,
     * waiting up to @p timeout if the BlockingQueue is empty.
     *
     * @param timeout: the waiting time.
     *
     * @return:
     * - Some(v): if gets and removes the element at the head of the queue successfully.
     * - None: if the waiting time exceeds @p timeout.
     */
    @Deprecated[message: "Use member function `public func remove(timeout: Duration): Option<E>` instead."]
    public func dequeue(timeout: Duration): Option<E> {
        return remove(timeout)
    }

    public func remove(timeout: Duration): Option<E> {
        var prevCount: Int64 = -1
        var value: Option<E> = None
        takeMonitor.lock()
        try {
            var remaining = timeout
            while (true) {
                if (count.load() != 0) {
                    break
                }
                if (remaining <= Duration.Zero) {
                    return None<E>
                }
                takeQsize.fetchAdd(1)
                try {
                    if (count.load() == 0) {
                        let startTime = MonoTime.now()
                        let _ = takeMonitor.wait(timeout: remaining)
                        let endTime = MonoTime.now()
                        remaining -= endTime - startTime
                    }
                } finally {
                    takeQsize.fetchSub(1)
                }
            }
            value = Some(dequeueUnsafe())
            prevCount = count.fetchSub(1)
            if (prevCount > 1 && takeQsize.load() > 0) {
                takeMonitor.notify()
            }
        } finally {
            takeMonitor.unlock()
        }
        if (prevCount == capacity && putQsize.load() > 0) {
            signalNotFull()
        }
        return value
    }

    /**
     * Gets the head of the queue, but does not remove it.
     * Such method is non-blocking.
     *
     * @return:
     * - Some(v): if we successfully gets the element at the head of the queue.
     * - None: if the queue is empty, and we fails to get the head of the queue.
     */
    @Deprecated[message: "Use member function `public func peek(): Option<E>` instead."]
    public func head(): Option<E> {
        return peek()
    }

    public func peek(): Option<E> {
        while (true) {
            let headBlock = front.load()
            match (headBlock.front()) {
                case ELEM(e) => return Some(e)
                case NoEntry => break
                case BlockDone =>
                    if (!nextBlock<E>(headBlock, front, rear)) {
                        break
                    }
            }
        }
        return None<E>
    }

    /**
     * Non-blocking method to send the element @p element to the tail of the queue.
     * A successful 'tryEnqueue' will await blocked threads calling 'dequeue'.
     *
     * @param element: the element to send into the queue.
     *
     * @return:
     * - true: if @p element is successfully pushed at the tail of the queue.
     * - false: if the queue is full.
     */
    @Deprecated[message: "Use member function `public func tryAdd(element: E): Bool` instead."]
    public func tryEnqueue(element: E): Bool {
        return tryAdd(element)
    }

    public func tryAdd(element: E): Bool {
        if (count.load() == capacity) {
            return false
        }
        var prevCount: Int64 = -1
        putMonitor.lock()
        try {
            if (count.load() == capacity) {
                return false
            }
            enqueueUnsafe(element)
            prevCount = count.fetchAdd(1)
            if (prevCount + 1 < capacity && putQsize.load() > 0) {
                putMonitor.notify()
            }
        } finally {
            putMonitor.unlock()
        }
        if (prevCount == 0 && takeQsize.load() > 0) {
            signalNotEmpty()
        }
        return true
    }

    /**
     * Non-blocking method to get and remove the head of the queue.
     * A successful 'tryDequeue' will await blocked threads calling 'enqueue'.
     *
     * @return:
     * - Some(v): if gets and removes the element at the head of the queue successfully.
     * - None: if the queue is empty.
     */
    @Deprecated[message: "Use member function `public func tryRemove(): Option<E>` instead."]
    public func tryDequeue(): Option<E> {
        return tryRemove()
    }

    public func tryRemove(): Option<E> {
        if (count.load() == 0) {
            return None<E>
        }
        var value: Option<E> = None
        var prevCount: Int64 = -1
        takeMonitor.lock()
        try {
            if (count.load() == 0) {
                return None<E>
            }
            value = Some(dequeueUnsafe())
            prevCount = count.fetchSub(1)
            if (prevCount > 1 && takeQsize.load() > 0) {
                takeMonitor.notify()
            }
        } finally {
            takeMonitor.unlock()
        }
        if (prevCount == capacity && putQsize.load() > 0) {
            signalNotFull()
        }
        return value
    }

    private func enqueueUnsafe(element: E): Unit {
        while (true) {
            let tailBlock = rear.load()
            let (_, tailAllocated) = tailBlock.getAllocated()
            match (tailBlock.pushAt(element, tailAllocated)) {
                case SUCCEED => return
                case BlockDone => newBlock<E>(tailBlock, rear)
                case CONFLICT => ()
            }
        }
    }

    private func dequeueUnsafe(): E {
        while (true) {
            let headBlock = front.load()
            match (headBlock.pop()) {
                case ELEM(e) => return e
                case NoEntry => ()
                case BlockDone =>
                    if (!nextBlock<E>(headBlock, front, rear)) {
                        break
                    }
            }
        }
        throw Exception("Unreachable code.")
    }

    private func signalNotEmpty(): Unit {
        takeMonitor.lock()
        try {
            takeMonitor.notify()
        } finally {
            takeMonitor.unlock()
        }
    }

    private func signalNotFull(): Unit {
        putMonitor.lock()
        try {
            putMonitor.notify()
        } finally {
            putMonitor.unlock()
        }
    }
}
