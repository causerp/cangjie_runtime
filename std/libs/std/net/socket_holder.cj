/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.net

import std.sync.*

enum InternalHolderState<NS> {
    | NotCreated(() -> NS)
    | Ready(NS)
    | Disposed
}

enum HolderState <: Equatable<HolderState> {
    | SocketNotCreated
    | SocketPrepared
    | SocketClosing
    | SocketDisposed

    public override operator func ==(other: HolderState): Bool {
        match ((this, other)) {
            case (SocketNotCreated, SocketNotCreated) => true
            case (SocketPrepared, SocketPrepared) => true
            case (SocketClosing, SocketClosing) => true
            case (SocketDisposed, SocketDisposed) => true
            case _ => false
        }
    }

    public override operator func !=(other: HolderState): Bool {
        !(this == other)
    }
}

/**
 * This class contains the native socket and does manage it's creation and removal
 * controlling lifetime.
 */
class SocketHolder<NS> <: Resource where NS <: PlatformSocket<NS> {
    private let socketCreationLock = NonReentrantWriteLock()

    // number of sessions started with the socket
    // incremented by startUsing(), startReading() and startWriting()
    private let useCounter = AtomicUInt32(0)

    // holds a native socket, disposed state or a lambda creating a socket
    // this should be only accessed under "counter" guard != 0
    private var state_: InternalHolderState<NS>

    SocketHolder(create: () -> NS) {
        state_ = NotCreated(create)
    }

    init(acceptedSocket!: NS) {
        state_ = Ready(acceptedSocket)
        useCounter.store(SocketState.JustAccepted.value)
    }

    prop state: SocketState {
        get() {
            SocketState(useCounter.load())
        }
        // this property has no setter and this is intentionally
        // the state should be updated using compareAndSwap only in a loop
    }

    func markConnected(): Unit {
        while (true) {
            let before = SocketState(useCounter.load())
            if (before.connected) {
                SocketException.alreadyConnected()
            }
            var new = before
            new.connected = true
            if (useCounter.compareAndSwap(before.value, new.value)) {
                break
            }
        }
    }

    private func markCreated() {
        while (true) {
            let before = SocketState(useCounter.load())
            if (before.nativeState != HolderState.SocketNotCreated) {
                return
            }
            var new = before
            new.nativeState = HolderState.SocketPrepared
            if (useCounter.compareAndSwap(before.value, new.value)) {
                break
            }
        }
    }

    func unmarkConnected() {
        while (true) {
            let before = SocketState(useCounter.load())
            if (!before.connected) {
                break
            }

            var new = before
            new.connected = false
            if (useCounter.compareAndSwap(before.value, new.value)) {
                break
            }
        }
    }

    func markBound(): Unit {
        while (true) {
            let before = SocketState(useCounter.load())
            if (before.bound) {
                throw IllegalStateException("Socket was already bound")
            }
            var new = before
            new.bound = true
            if (useCounter.compareAndSwap(before.value, new.value)) {
                break
            }
        }
    }

    func markFailed(): Unit {
        while (true) {
            let before = SocketState(useCounter.load())
            var new = before
            new.failed = true
            if (before.failed || useCounter.compareAndSwap(before.value, new.value)) {
                break
            }
        }
    }

    public override func isClosed(): Bool {
        SocketState(useCounter.load()).disposedOrShuttingDown
    }

    public override func close(): Unit {
        tryClose()
    }

    /**
     * Access the socket instance for a neutral non I/O operations (e.g. socket options).
     * Such neutral operations may run concurrently with other use{} invocations and also
     * with read{} and write{} invocations.
     *
     * It is guaranteed that the socket will not be disposed while we are running inside of
     * the block lambda.
     *
     * The provided socket instance shouldn't be captured outside of lambda otherise
     * an undefined behaviour may occur including crash or random data corruption.
     */
    func use<R>(block: (NS, SocketState) -> R): ?R {
        let (socket, state) = startUsingSocket() ?? return None
        try {
            block(socket, state)
        } finally {
            leave()
        }
    }

    @OverflowWrapping
    private func startUsingSocket(): ?(NS, SocketState) {
        var state: SocketState

        do {
            let before = SocketState(useCounter.load())
            if (before.disposedOrShuttingDown) {
                return None
            }

            state = before
            state.useCounter++

            if (useCounter.compareAndSwap(before.value, state.value)) {
                break
            }
        } while (true)

        if (let Ready(socket) <- state_) {
            return (socket, state)
        }

        return createSocketUsingSession(state)
    }

    private func createSocketUsingSession(state: SocketState): ?(NS, SocketState) {
        let socket = try {
            ensureSocket()
        } catch (e: Exception) {
            leave()
            throw e
        }

        return match (socket) {
            case Some(socket) => (socket, state)
            case None =>
                leave()
                return None
        }
    }

    /**
     * Access the socket instance for read I/O operations. A read operation may run
     * concurrently with a write operation or with use {} but not with another read{} invocation.
     *
     * It is guaranteed that the socket will not be disposed while we are running inside of
     * the block lambda.
     *
     * The provided socket instance shouldn't be captured outside of lambda otherise
     * an undefined behaviour may occur including crash or random data corruption.
     */
    func read<R>(block: (NS, SocketState) -> R): ?R {
        let (socket, state) = startReading() ?? return None
        try {
            block(socket, state)
        } finally {
            leaveRead()
        }
    }

    @OverflowWrapping
    private func startReading(): ?(NS, SocketState) {
        var state: SocketState

        do {
            let before = SocketState(useCounter.load())
            if (before.disposedOrShuttingDown) {
                return None
            }
            if (before.hasReaders) {
                throwAlreadyReading()
            }

            state = before
            state.useCounter++
            state.hasReaders = true

            if (useCounter.compareAndSwap(before.value, state.value)) {
                break
            }
        } while (true)

        if (let Ready(socket) <- state_) {
            return (socket, state)
        }

        return createSocketReadSession(state)
    }

    private func createSocketReadSession(state: SocketState): ?(NS, SocketState) {
        let socket = try {
            ensureSocket()
        } catch (e: Exception) {
            leaveRead()
            throw e
        }

        return match (socket) {
            case Some(socket) => (socket, state)
            case None =>
                leaveRead()
                return None
        }
    }

    private static func throwAlreadyReading(): Nothing {
        throw IllegalStateException("Socket is already reading: concurrent read is not allowed")
    }

    /**
     * Access the socket instance for write I/O operations. A write operation may run
     * concurrently with a read operation or with use {} but not with another write{} invocation.
     *
     * It is guaranteed that the socket will not be disposed while we are running inside of
     * the block lambda.
     *
     * The provided socket instance shouldn't be captured outside of lambda otherise
     * an undefined behaviour may occur including crash or random data corruption.
     */
    func write<R>(block: (NS, SocketState) -> R): ?R {
        let (socket, state) = startWriting() ?? return None
        try {
            block(socket, state)
        } finally {
            leaveWrite()
        }
    }

    @OverflowWrapping
    private func startWriting(): ?(NS, SocketState) {
        var state: SocketState

        do {
            let before = SocketState(useCounter.load())
            if (before.disposedOrShuttingDown) {
                return None
            }
            if (before.hasWriters) {
                throwAlreadyWriting()
            }

            state = before
            state.useCounter++
            state.hasWriters = true

            if (useCounter.compareAndSwap(before.value, state.value)) {
                break
            }
        } while (true)

        if (let Ready(socket) <- state_) {
            return (socket, state)
        }

        return createSocketWriteSession(state)
    }

    private func createSocketWriteSession(state: SocketState): ?(NS, SocketState) {
        let socket = try {
            ensureSocket()
        } catch (e: Exception) {
            leaveWrite()
            throw e
        }

        return match (socket) {
            case Some(socket) => (socket, state)
            case None =>
                leaveWrite()
                return None
        }
    }

    private static func throwAlreadyWriting(): Nothing {
        throw IllegalStateException("Socket is already writing: concurrent write is not allowed")
    }

    // this should be only invoked after incrementing useCounter
    private func ensureSocket(): ?NS {
        // here the counter is already incremented so we can safely touch the state
        // with no risk of concurrent disposal
        // on the other hand concurrent shutdown or creation is still possible

        return match (state_) {
            case NotCreated(_) => tryCreate()
            case Ready(s) => s
            case Disposed =>
                // close has been invoked during creation
                return None
        }
    }

    private func tryCreate(): ?NS {
        socketCreationLock.lock()
        try {
            // double-check is required here
            // because reading outside of the lock could be too weak
            match (state_) {
                case NotCreated(create) =>
                    let s: NS = create()
                    if (state.disposedOrShuttingDown) {
                        state_ = Disposed
                        // close has been invoked during creation
                        unsafe { s.dispose() }
                        return None
                    }

                    state_ = Ready(s)
                    markCreated()
                    return s
                case Ready(s) => return s
                case Disposed =>
                    // close has been invoked during creation
                    // and anoter coroutine handled it in the NotCreated case
                    return None
            }
        } finally {
            socketCreationLock.unlock()
        }
    }

    @OverflowWrapping
    private func leaveRead(): Unit {
        var doDispose: Bool = false

        while (true) {
            let before = SocketState(useCounter.load())
            if (before.useCounter == 0) {
                throwLeaveWithoutEnter()
            }

            var new: SocketState
            if (before.disposedOrShuttingDown && before.useCounter == 1) {
                doDispose = true
                new = SocketState.Terminal
            } else {
                doDispose = false
                new = before
                new.useCounter--
                new.hasReaders = false
            }

            if (useCounter.compareAndSwap(before.value, new.value)) {
                break
            }
        }

        if (doDispose) {
            // we had replaced -1 to Int64.Min
            // so we are the last one
            dispose()
        }
    }

    // this should be only invoked from WriteSession.close()
    @OverflowWrapping
    private func leaveWrite(): Unit {
        var doDispose: Bool = false

        while (true) {
            let before = SocketState(useCounter.load())
            if (before.useCounter == 0) {
                throwLeaveWithoutEnter()
            }

            var new: SocketState
            if (before.disposedOrShuttingDown && before.useCounter == 1) {
                doDispose = true
                new = SocketState.Terminal
            } else {
                doDispose = false
                new = before
                new.useCounter--
                new.hasWriters = false
            }

            if (useCounter.compareAndSwap(before.value, new.value)) {
                break
            }
        }

        if (doDispose) {
            // we had replaced -1 to Int64.Min
            // so we are the last one
            dispose()
        }
    }

    @OverflowWrapping
    private func leave(): Unit {
        var doDispose: Bool = false

        while (true) {
            let before = SocketState(useCounter.load())
            if (before.useCounter == 0) {
                throwLeaveWithoutEnter()
            }

            var new: SocketState
            if (before.disposedOrShuttingDown && before.useCounter == 1) {
                doDispose = true
                new = SocketState.Terminal
            } else {
                doDispose = false
                new = before
                new.useCounter--
            }

            if (useCounter.compareAndSwap(before.value, new.value)) {
                break
            }
        }

        if (doDispose) {
            // we had replaced 1 to the terminal state
            // so we are the last one
            dispose()
        }
    }

    private static func throwLeaveWithoutEnter(): Nothing {
        throw IllegalStateException("leave() invoked without tryEnterXXX() invocation")
    }

    @OverflowWrapping
    private func tryClose(): Unit {
        var terminated = false

        while (true) {
            let before = SocketState(useCounter.load())
            if (before.disposedOrShuttingDown) {
                // we are already disposed or shutting down
                // do not "help" disposing: let other threads complete it
                return
            }

            var new: SocketState
            if (before.useCounter == 0) {
                terminated = true
                new = SocketState.Terminal
            } else {
                terminated = false
                new = before
                new.nativeState = SocketClosing

                // we need this additional +1 to prevent concurrent tasks from disposing it
                // while we are doing shutdonw() below
                new.useCounter++
            }

            if (useCounter.compareAndSwap(before.value, new.value)) {
                break
            }
        }

        if (terminated) {
            dispose()
        } else {
            doShutdown()
        }
    }

    private func doShutdown() {
        // despite we are racing with other coroutines here
        // we have just increased the counter so noone can dispose
        // or write state_ value therefore we can read it's value with no risk
        // we are reading AFTER reading/CAS atomic providing happens-before guard

        // The other possibility is that we are doing close() right during
        // the lazy initialization

        try {
            if (let Ready(s) <- state_) {
                s.shutdown()
            }
        } finally {
            // we have counter incremented in tryClose()
            leave()
        }
    }

    private func dispose() {
        // we have already switched to the dead state: we are the last thread
        // accessing the state so no concurrent tasks are running
        // we can dispose the socket and read/write state_ with no risk
        if (let Some(s) <- doStealExclusive()) {
            unsafe { s.dispose() }
        }
    }

    private func doStealExclusive(): ?NS {
        // we can invoke this only when we are sure that we are the only
        // the last thread accessing state_
        match (state_) {
            case Ready(s) =>
                this.state_ = Disposed
                s
            case NotCreated(_) =>
                this.state_ = Disposed
                None
            case Disposed => None
        }
    }
}
