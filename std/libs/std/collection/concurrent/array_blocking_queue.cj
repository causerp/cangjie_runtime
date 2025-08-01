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

/**
 * In ArrayBlockingQueue, 'state' array is defined as a C array.
 * state_init is a foreign function to assign 0 to all elements in 'state'.
 * state_load, state_store and state_compareAndSwap are foreign functions to operate array 'state'.
 */
@FastNative
foreign func CjStdSyncStateInit(capacity: Int64): CPointer<UInt8>

@FastNative
foreign func CjStdSyncStateLoad(ptr: CPointer<UInt8>, index: Int64): UInt8

@FastNative
foreign func CjStdSyncStateStore(ptr: CPointer<UInt8>, index: Int64, state: UInt8): Unit

@FastNative
foreign func CjStdSyncStateCas(ptr: CPointer<UInt8>, index: Int64, expectedState: UInt8, desiredState: UInt8): Bool

const STATE_BITS: UInt8 = 3
const ROUND_BIT: UInt8 = 2

/**
 * Each index of the array in ArrayBlockingQueue has three types of states:
 * - WRITEABLE: such place can be operated by 'enqueue';
 * - READABLE: such place can be operated by 'dequeue';
 * - LOCK: such place cannot be operated by 'enqueue' and 'dequeue'.
 */
const WRITEABLE: UInt8 = 0
const READABLE: UInt8 = 1
const LOCK: UInt8 = 2
const WRITEABLE_EVEN: UInt8 = WRITEABLE
const WRITEABLE_ODD: UInt8 = (1 << ROUND_BIT) | WRITEABLE
const READABLE_EVEN: UInt8 = READABLE
const READABLE_ODD: UInt8 = (1 << ROUND_BIT) | READABLE
const LOCK_EVEN: UInt8 = LOCK
const LOCK_ODD: UInt8 = (1 << ROUND_BIT) | LOCK

/**
 * ArrayBlockingQueue is a concurrent queue with a blocking mechanism and supports a user-specified upper bound of capacity.
 * It is backed by an array.
 */
public class ArrayBlockingQueue<E> {
    public let capacity: Int64 // the capacity of the queue
    let buffer: Array<E> // buffer to store the elements in the queue
    let state: CPointer<UInt8> // the state of the corresponding place in the buffer

    let allocated: AtomicUInt64 = AtomicUInt64(0) // index in buffer for the next producer
    let reserved: AtomicUInt64 = AtomicUInt64(0) // index in buffer for the next consumer
    let sendQSize = AtomicUInt64(0) // Number of elements that are enqueuing
    let receiveQSize = AtomicUInt64(0) // Number of elements that are being dequeued
    let sendMonitor = Monitor() // Monitor for blocking the fail receivers
    let receiveMonitor = Monitor() // Monitor for blocking the fail senders

    let unsignedCapacity: UInt64 // the unsigned version of the capacity

    public init(capacity: Int64) {
        if (capacity <= 0) {
            throw IllegalArgumentException("Invalid size of ArrayBlockingQueue: ${capacity}.")
        }

        this.capacity = capacity
        buffer = Array(capacity, repeat: unsafe { zeroValue<E>() })
        state = unsafe { CjStdSyncStateInit(capacity) }
        if (state.isNull()) {
            throw IllegalMemoryException("Failed to malloc memory of ${capacity}.")
        }

        unsignedCapacity = UInt64(capacity)
    }

    @Deprecated[message: "Use the other version of `init` instead."]
    public init(capacity: Int64, elements: Collection<E>) {
        if (capacity < elements.size) {
            throw IllegalArgumentException(
                "Size of ArrayBlockingQueue should be equal or greater than ${elements.size}.")
        }

        if (capacity <= 0) {
            throw IllegalArgumentException("Invalid size of ArrayBlockingQueue: ${capacity}.")
        }

        this.capacity = capacity
        buffer = Array(capacity, repeat: unsafe { zeroValue<E>() })
        state = unsafe { CjStdSyncStateInit(capacity) }
        if (state.isNull()) {
            throw IllegalMemoryException("Failed to malloc memory of ${capacity}.")
        }

        unsignedCapacity = UInt64(capacity)

        for (e in elements) {
            tryEnqueue(e)
        }
    }

    ~init() {
        unsafe { LibC.free(state) }
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
            let front = reserved.load()
            let rear = allocated.load()
            return Int64(rear - front)
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
        while (!tryAdd(element)) {
            receiveMonitor.lock()
            sendQSize.fetchAdd(1)
            if (isFull()) {
                receiveMonitor.wait()
            }
            sendQSize.fetchSub(1)
            receiveMonitor.unlock()
        }
    }

    /**
     * Blocking method to send the element @p element to the tail of the queue,
     * waiting up to @p timeout if the ArrayBlockingQueue is full.
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
        add(element, timeout)
    }

    public func add(element: E, timeout: Duration): Bool {
        var total = timeout
        while (true) {
            if (tryAdd(element)) {
                return true
            }

            receiveMonitor.lock()
            let startTime = MonoTime.now()
            if (total <= Duration.Zero) {
                receiveMonitor.unlock()
                break
            }

            sendQSize.fetchAdd(1)
            receiveMonitor.wait(timeout: total)
            sendQSize.fetchSub(1)
            let endTime = MonoTime.now()
            total -= endTime - startTime
            receiveMonitor.unlock()
        }
        return false
    }

    /**
     * Blocking method to get and remove the element at the head of the queue.
     * If the queue is empty, the thread calling such method will be blocked,
     * and waiting for another thread calling 'enqueue' method to await.
     *
     * A successful 'dequeue' will await blocked threads calling 'enqueue'.
     */
    @Deprecated[message: "Use member function `public func remove(): E` instead."]
    public func dequeue(): E {
        remove()
    }

    public func remove(): E {
        while (true) {
            if (let Some(e) <- tryRemove()) {
                return e
            }

            sendMonitor.lock()
            receiveQSize.fetchAdd(1)
            if (size == 0) {
                sendMonitor.wait()
            }
            receiveQSize.fetchSub(1)
            sendMonitor.unlock()
        }
        throw Exception("Unreachable code.")
    }

    /**
     * Blocking method to get and remove the head of the queue,
     * waiting up to @p timeout if the ArrayBlockingQueue is empty.
     *
     * @param timeout: the waiting time.
     *
     * @return:
     * - Some(v): if gets and removes the element at the head of the queue successfully.
     * - None: if the waiting time exceeds @p timeout.
     */
    @Deprecated[message: "Use member function `public func remove(timeout: Duration): Option<E>` instead."]
    public func dequeue(timeout: Duration): Option<E> {
        remove(timeout)
    }

    public func remove(timeout: Duration): Option<E> {
        var total = timeout
        while (true) {
            if (let Some(e) <- tryRemove()) {
                return Some(e)
            }

            sendMonitor.lock()
            let startTime = MonoTime.now()
            if (total <= Duration.Zero) {
                sendMonitor.unlock()
                break
            }

            receiveQSize.fetchAdd(1)
            sendMonitor.wait(timeout: total)
            receiveQSize.fetchSub(1)
            let endTime = MonoTime.now()
            total -= endTime - startTime
            sendMonitor.unlock()
        }
        return None<E>
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
        peek()
    }

    public func peek(): Option<E> {
        while (true) {
            let roundIndex = reserved.load() // LP: if returns 'None<E>'
            let index = getIndex(roundIndex)
            let roundState = unsafe { CjStdSyncStateLoad(state, index) }
            let roundBit = roundState >> ROUND_BIT

            if ((roundState & STATE_BITS) == READABLE) {
                if (unsafe { CjStdSyncStateCas(state, index, roundState, lockState(roundBit)) }) {
                    if (reserved.load() == roundIndex) { // LP: if returns 'Some(e)'
                        let e = buffer[index]
                        unsafe { CjStdSyncStateStore(state, index, roundState) }
                        return Some(e)
                    } else {
                        unsafe { CjStdSyncStateStore(state, index, roundState) }
                    }
                }
            } else if (roundIndex >= allocated.load()) {
                return None<E>
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
        tryAdd(element)
    }

    @OverflowWrapping
    public func tryAdd(element: E): Bool {
        while (true) {
            let roundIndex = allocated.load() // LP: if returns 'false'
            let round = getRound(roundIndex)
            let index = getIndex(roundIndex)
            let roundState = unsafe { CjStdSyncStateLoad(state, index) }
            let roundBit = roundState >> ROUND_BIT

            if (matchState(round, roundBit, roundState & STATE_BITS, WRITEABLE)) {
                if (!allocated.compareAndSwap(roundIndex, roundIndex + 1)) { // LP: if returns true
                    continue
                }

                buffer[index] = element
                unsafe { CjStdSyncStateStore(state, index, readableState(roundBit)) }

                if (receiveQSize.load() != 0) {
                    sendMonitor.lock()
                    sendMonitor.notify()
                    sendMonitor.unlock()
                }
                return true
            } else if (roundIndex >= reserved.load() + unsignedCapacity) {
                return false // buffer full
            }
        }
        return false
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
        tryRemove()
    }

    @OverflowWrapping
    public func tryRemove(): Option<E> {
        while (true) {
            let roundIndex = reserved.load() // LP: if returns 'None<E>'
            let round = getRound(roundIndex)
            let index = getIndex(roundIndex)
            let roundState = unsafe { CjStdSyncStateLoad(state, index) }
            let roundBit = roundState >> ROUND_BIT

            if (matchState(round, roundBit, roundState & STATE_BITS, READABLE)) {
                if (!reserved.compareAndSwap(roundIndex, roundIndex + 1)) { // LP: if returns 'Some(e)'
                    continue
                }

                let e = buffer[index]
                buffer[index] = unsafe { zeroValue<E>() }
                while (!unsafe { CjStdSyncStateCas(state, index, roundState, writeableState(roundBit)) }) {}

                if (sendQSize.load() != 0) {
                    receiveMonitor.lock()
                    receiveMonitor.notify()
                    receiveMonitor.unlock()
                }
                return Some(e)
            } else if (roundIndex >= allocated.load()) {
                return None<E> // buffer empty
            }
        }
        return None<E>
    }

    @OverflowWrapping
    private func isFull(): Bool {
        if (allocated.load() >= reserved.load() + unsignedCapacity) {
            return true
        }
        return false
    }

    private func getRound(roundIndex: UInt64): UInt64 {
        return roundIndex / unsignedCapacity
    }

    private func getIndex(roundIndex: UInt64): Int64 {
        return Int64(roundIndex % unsignedCapacity)
    }
}

func readableState(roundBit: UInt8): UInt8 {
    return if (roundBit == 1) {
        READABLE_ODD
    } else {
        READABLE_EVEN
    }
}

func writeableState(roundBit: UInt8): UInt8 {
    return if (roundBit == 1) {
        WRITEABLE_EVEN
    } else {
        WRITEABLE_ODD
    }
}

func lockState(roundBit: UInt8): UInt8 {
    return if (roundBit == 1) {
        LOCK_ODD
    } else {
        LOCK_EVEN
    }
}

/**
 * Justify whether the round and the state are matching the expectations.
 */
func matchState(round: UInt64, roundBit: UInt8, state: UInt8, expectState: UInt8) {
    if (UInt8(round & 1) == roundBit && state == expectState) {
        return true
    }
    return false
}
