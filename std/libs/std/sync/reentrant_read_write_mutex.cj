/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.sync

@Deprecated
public enum ReadWriteMutexMode {
    | Unfair
    | Fair
}

@Deprecated[message: "Use `public class ReadWriteLock` instead."]
public class ReentrantReadWriteMutex {
    private let readMutex_: ReentrantReadMutex
    private let writeMutex_: ReentrantWriteMutex

    public init(mode!: ReadWriteMutexMode = ReadWriteMutexMode.Unfair) {
        let isFair: Bool = match (mode) {
            case Unfair => false
            case Fair => true
        }
        let rwMutexImpl = ReadWriteLockImpl(isFair: isFair)
        readMutex_ = ReentrantReadMutex(rwMutexImpl)
        writeMutex_ = ReentrantWriteMutex(rwMutexImpl)
    }

    public prop readMutex: ReentrantReadMutex {
        get() {
            return readMutex_
        }
    }

    public prop writeMutex: ReentrantWriteMutex {
        get() {
            return writeMutex_
        }
    }
}

@Deprecated[message: "Use `public interface Lock` instead."]
public class ReentrantReadMutex <: ReentrantMutex {
    private let rwMutex: ReadWriteLockImpl

    init(rwMutex: ReadWriteLockImpl) {
        this.rwMutex = rwMutex
    }
    /**
     * Acquire the read-mutex.
     * Under fair mode,
     *   non-reentrantly hold the lock if there are no other threads holding or waiting for the write-mutex;
     *   otherwise, blocked.
     * Under nonfair mode,
     *   block if there are other threads holding the write-mutex;
     *   hold the mutex if there are no waiting writer threads;
     *   otherwise, holding the mutex or being blocked is decided by the implementation.
     * Multiple threads can hold the read-mutex concurrently, and one thread can acquire recursively.
     * If one thread holds the write-mutex, it can also hold the read-mutex.
     */
    public func lock(): Unit {
        rwMutex.readLock()
    }

    /**
     * Try to acquire the read-mutex.
     * Return true if it succeeds to hold the read-mutex;
     * otherwise, return false.
     * This method does not obey the fairness constraints.
     */
    public func tryLock(): Bool {
        return rwMutex.tryReadLock()
    }

    /**
     * Release the read-mutex.
     * This method should be invoked N times to fully unlock the mutex.
     * If fully released, waiting writer threads are notified to acquire the write-mutex.
     * Throws ISSE("Mutex is not hold by the current thread") if the current thread does not hold this read-mutex.
     */
    public func unlock(): Unit {
        rwMutex.readUnlock()
    }
}

@Deprecated[message: "Use `public interface UniqueLock` instead."]
public class ReentrantWriteMutex <: ReentrantMutex {
    private let rwMutex: ReadWriteLockImpl

    init(rwMutex: ReadWriteLockImpl) {
        this.rwMutex = rwMutex
    }
    /**
     * Acquire the write-mutex.
     * Only one thread can hold the write-mutex, and it can acquire recursively.
     * Blocked if there are other threads holding the read-mutex or write-mutex.
     * Throws ISSE("Read-mutex is hold by the current thread") if the current thread holds the read-mutex.
     */
    public func lock(): Unit {
        rwMutex.writeLock()
    }

    /**
     * Try to acquire the write-mutex.
     * Return true if it succeeds to hold the write-mutex;
     * otherwise, return false.
     * This method does not obey the fairness constraints.
     */
    public func tryLock(): Bool {
        return rwMutex.tryWriteLock()
    }

    /**
     * Release the write-mutex.
     * This method should be invoked N times to fully unlock the mutex.
     * Under fair mode,
     *   if fully released, waiting reader threads are notified first to acquire the write-mutex.
     * Under nonfair mode,
     *   if fully released, notifying waiting reader or writer threads are decided by the implementation.
     * Throws ISSE("Mutex is not hold by the current thread") if the current thread does not hold this write-mutex.
     */
    public func unlock(): Unit {
        rwMutex.writeUnlock()
    }
}

class ReadWriteLockImpl {
    let isFair: Bool
    let state = AtomicUInt64(0) // | shared reader count | write count |
                                //          32bit             32bit
    private static let SHARE_UNIT: UInt64 = 1 << 32
    private static let WRITE_UNIT: UInt64 = 1
    private static let NO_THREAD = -1

    init(isFair!: Bool) {
        this.isFair = isFair
    }

    //----------------------------------------------------------
    // Auxiliary functions to read/write the `state`
    //----------------------------------------------------------
    private static func decodeWriteCount(state: UInt64): Int64 {
        return Int64(state & 0xFFFFFFFF)
    }

    private static func decodeShareCount(state: UInt64): Int64 {
        return Int64(state >> 32)
    }

    func getWriteCount(): Int64 {
        return decodeWriteCount(state.load())
    }

    private func incWriteCount(writeCount!: Int64 = 1): Unit {
        state.fetchAdd(WRITE_UNIT * UInt64(writeCount))
    }

    private func decWriteCount(writeCount!: Int64 = 1): Unit {
        state.fetchSub(WRITE_UNIT * UInt64(writeCount))
    }

    private func getShareCount(): Int64 {
        return decodeShareCount(state.load())
    }

    private func incShareCount(): Unit {
        state.fetchAdd(SHARE_UNIT)
    }

    private func decShareCount(): Unit {
        state.fetchSub(SHARE_UNIT)
    }

    //----------------------------------------------------------
    // Extra fields for "exclusive writer" state
    //----------------------------------------------------------
    private let writeOwner = AtomicInt64(0)

    //----------------------------------------------------------
    // Extra fields for "waiting writer" state
    //----------------------------------------------------------
    private let waitingWriters = AtomicInt64(0)

    //----------------------------------------------------------
    // Extra fields and functions for "shared" state
    //----------------------------------------------------------
    private let threadReadCount = ThreadLocal<Int64>()

    private func getThreadReadCount(): Int64 {
        match (threadReadCount.get()) {
            case Some(v) => return v
            case None => return 0
        }
    }

    private func incThreadReadCount(): Unit {
        match (threadReadCount.get()) {
            case Some(v) => threadReadCount.set(v + 1)
            case None => threadReadCount.set(1)
        }
    }

    private func decThreadReadCount(): Unit {
        match (threadReadCount.get()) {
            case Some(v) =>
                if (v < 1) {
                    eprintln("Invalid thread read count.")
                }
                threadReadCount.set(v - 1)
            case None => eprintln("Invalid thread read count. Thread does not acquire mutex.")
        }
    }

    // Two wait queues for readers and writers
    private let readerSyncList = SyncList()
    private let writerSyncList = SyncList()

    func readLock(): Unit {
        let currThread = Thread.currentThread.id
        // Case 1: write-mutex is held by the current thread
        if (writeOwner.load() == currThread) {
            let currState = state.load()
            // Expected state: | share count | write count > 0 |
            if (decodeWriteCount(currState) < 1) {
                throw IllegalSynchronizationStateException("Inconsistent state.")
            }
            // Increase shared counter
            incShareCount()
            incThreadReadCount()
            return
        }
        // Case 2: if the current thread has held the read-mutex
        if (getThreadReadCount() > 0) {
            let currState = state.load()
            // Expected state: | share count > 0 | write count == 0 |
            if (decodeShareCount(currState) <= 0 || decodeWriteCount(currState) != 0) {
                throw IllegalSynchronizationStateException("Inconsistent state.")
            }
            // Increase shared counter
            incShareCount()
            incThreadReadCount()
            return
        }
        while (true) {
            let currState = state.load()
            // Case 3: write-mutex is held by another thread
            if (decodeWriteCount(currState) > 0) {
                // Before waiting, we should make a double check
                // to avoid that a writer releases its mutex but does not notify this thread.
                // The guarantee is achieved by that
                // a writer always "decreases the write-counter" first, and then "notifies readers",
                // where `waitIf` and `notify` are atomic.
                readerSyncList.waitIf({=> getWriteCount() > 0})
            } else if (isFair && waitingWriters.load() > 0) { // Case 4: there are waiting writers
                // Again, we should make the double check before waiting.
                readerSyncList.waitIf({=> waitingWriters.load() > 0})
            } else { // Case 5: try to hold the read-mutex
                // Excpected state: | share count | write count == 0 |
                if (decodeWriteCount(currState) != 0) {
                    throw IllegalSynchronizationStateException("Inconsistent state.")
                }
                if (state.compareAndSwap(currState, currState + SHARE_UNIT)) { // Succeed
                    incThreadReadCount()
                    return
                }
                // Fail; Do nothing; retry
            }
        }
    }

    func tryReadLock(): Bool {
        let currThread = Thread.currentThread.id
        // Case 1: write-mutex is held by the current thread
        if (writeOwner.load() == currThread) {
            // state: | share count | write count |
            // Increase counters
            incShareCount()
            incThreadReadCount()
            return true
        }
        while (true) {
            let currState = state.load()
            // Case 2: write-mutex is held by another thread
            if (decodeWriteCount(currState) > 0) {
                return false
            } else { // Case 3: try to hold the read-lock.
                // Notice that `tryLock` does not obey the fairness constraint.
                // Expected state: | share count | write count == 0 |
                if (decodeWriteCount(currState) != 0) {
                    throw IllegalSynchronizationStateException("Inconsistent state.")
                }
                if (state.compareAndSwap(currState, currState + SHARE_UNIT)) { // Succeed
                    incThreadReadCount()
                    return true
                } else { // Fail
                    // Do nothing; retry
                }
            }
        }
        // Unreachable
        return false
    }

    func readUnlock(): Unit {
        let currThread = Thread.currentThread.id
        // Case 1: The current thread does not hold the read-mutex
        if (getThreadReadCount() < 1) {
            throw IllegalSynchronizationStateException("Read-Lock is not locked by current thread.")
        } else if (writeOwner.load() == currThread) { // Case 2: it has held the write-mutex
            let currState = state.load()
            // Expected state: | share count > 0 | write count > 0 |
            if (decodeShareCount(currState) <= 0 || decodeWriteCount(currState) <= 0) {
                throw IllegalSynchronizationStateException("Inconsistent state.")
            }
            // Decrease counts
            decShareCount()
            decThreadReadCount()
        } else { // Case 3: decrease the share count
            decThreadReadCount()
            while (true) {
                // Expected state: | share count > 0 | 0 |
                let currState = state.load()
                if (decodeShareCount(currState) <= 0 || decodeWriteCount(currState) != 0) {
                    throw IllegalSynchronizationStateException("Inconsistent state.")
                }
                if (!state.compareAndSwap(currState, currState - SHARE_UNIT)) { // Fail
                    continue
                }
                // Succeed
                if (currState == SHARE_UNIT) { // Case 4: the last reader
                    // Notify waiting writers
                    writerSyncList.notifyOne()
                }
                return
            }
        }
    }

    func writeLock(writeCount!: Int64 = 1): Unit {
        let currThread = Thread.currentThread.id
        // Case 1: write-mutex is held by the current thread
        if (writeOwner.load() == currThread) {
            let currState = state.load()
            // Expected state: | share count | write count > 0 |
            if (decodeWriteCount(currState) <= 0) {
                throw IllegalSynchronizationStateException("Inconsistent state.")
            }
            // Increase write counter
            incWriteCount(writeCount: writeCount)
            return
        }
        // Case 2: read-mutex is held by the current thread
        if (getThreadReadCount() != 0) {
            throw IllegalSynchronizationStateException("Read-Lock is hold by the current thread.")
        }
        while (true) {
            let currState = state.load()
            // Case 3: write-mutex is held by another thread
            if (decodeWriteCount(currState) > 0) {
                // There is no need to increase `waitingWriters`
                // because incoming readers are unable to hold the mutex.
                writerSyncList.waitIf({=> getWriteCount() > 0})
            } else if (decodeShareCount(currState) > 0) { // Case 4: read-mutex is held
                // Increase `waitingWriters` to prevent incoming readers holding the mutex
                waitingWriters.fetchAdd(1)
                writerSyncList.waitIf({=> getShareCount() > 0})
                waitingWriters.fetchSub(1)
            } else { // Case 5: try to hold the write-mutex
                // Excpeted state: | share count == 0 | write count == 0 |
                if (currState != 0) {
                    throw IllegalSynchronizationStateException("Inconsistent state.")
                }
                if (state.compareAndSwap(currState, WRITE_UNIT * UInt64(writeCount))) { // Succeed
                    writeOwner.store(currThread)
                    return
                } else { // Fail;
                    // Do nothing; retry
                }
            }
        }
    }

    func tryWriteLock(): Bool {
        let currThread = Thread.currentThread.id
        // Case 1: write-mutex is held by the current thread
        if (writeOwner.load() == currThread) {
            let currState = state.load()
            // state: | share count | write count > 0 |
            if (decodeWriteCount(currState) <= 0) {
                throw IllegalSynchronizationStateException("Inconsistent state.")
            }
            // Increase write count
            incWriteCount()
            return true
        }
        while (true) {
            let currState = state.load()
            if (decodeWriteCount(currState) > 0) { // Case 2: write-mutex is held
                return false
            } else if (decodeShareCount(currState) > 0) { // Case 3: read-mutex is held
                return false
            } else { // Case 4: try to hold the write-mutex
                // Expected state: | share count == 0 | write count 0 |
                if (currState != 0) {
                    throw IllegalSynchronizationStateException("Inconsistent state.")
                }
                if (state.compareAndSwap(currState, WRITE_UNIT)) { // Succeed
                    writeOwner.store(currThread)
                    return true
                } else { // Fail;
                    // Do nothing; retry
                }
            }
        }
        // Unreachable
        return false
    }

    func checkWriteLockStatus(): Unit {
        let currThread = Thread.currentThread.id
        if (writeOwner.load() != currThread) {
            throw IllegalSynchronizationStateException("Write-Lock is not locked by current thread.")
        }
    }

    func writeUnlock(): Unit {
        // Case 1: the current does not hold write-mutex
        checkWriteLockStatus()
        writeUnlock(writeCount: 1)
    }

    func writeUnlock(writeCount!: Int64): Unit {
        let currState = state.load()
        // state: | shared counts | write count |
        if (decodeWriteCount(currState) == writeCount) { // Case 2: release the last write-mutex
            if (decodeShareCount(currState) > 0) { // Case 2.1: also hold read-mutex
                writeOwner.store(NO_THREAD)
                decWriteCount(writeCount: writeCount)
                readerSyncList.notifyAll()
                return
            }
            // Case 2.2: does not hold read-mutex
            writeOwner.store(NO_THREAD)
            decWriteCount(writeCount: writeCount)
            // At this point, the state variable is cleared. So,
            //  - some threads may hold the mutex;
            //  - some thread may be pushed to the wait queue.
            // But it's still safe to notify wait queues because all waken thread
            // will try to acquire the mutex again, and they will not break the mutex constraints.
            // Under fair mode, notify readers first
            if (isFair) {
                // If there is no waiting readers, notify waiting writers
                if (!readerSyncList.notifyAll()) {
                    writerSyncList.notifyOne()
                }
                return
            }
            // Under unfair mode, notify writers first
            // If there is no waiting readers, notify waiting readers
            if (!writerSyncList.notifyOne()) {
                readerSyncList.notifyAll()
            }
        } else { // Case 3: still hold write-mutex
            decWriteCount(writeCount: writeCount)
        }
    }
}
