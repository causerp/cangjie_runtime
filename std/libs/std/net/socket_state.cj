/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.net

/**
 * This struct represents a complex socket state including termination state,
 * presence of readers/writers, number of users, connected and bound flags.
 *
 * The idea is to encode all the state fields into a single number that can be
 * stored to an atomic variable and can be checked and updated atomically.
 */
struct SocketState {
    // the bit layout is as follows
    // 31 has writer
    // 30 has reader
    // 29 bound
    // 28 connected
    // 27 failed
    // 25-26 state code
    // 0-24  use counter
    private static const CONNECTED_MASK: UInt32 = 1u32 << 28
    private static const BOUND_MASK: UInt32 = 0b10u32 << 28
    private static const HAS_READER_MASK: UInt32 = 0b100u32 << 28
    private static const HAS_WRITER_MASK: UInt32 = 0b1000u32 << 28
    private static const FAILED_MASK: UInt32 = 1u32 << 27

    private static const COUNTER_MASK: UInt32 = 0x1FF_FFFFu32

    // 2 bits for state code
    // states are number in the proper order: it makes difference
    private static const NATIVE_STATE_MASK: UInt32 = 0x600_0000u32
    private static const NATIVE_STATE_SHIFT: UInt8 = 25
    private static const STATE_NOT_CREATED_CODE: UInt32 = 0
    private static const STATE_PREPARED_CODE: UInt32 = 1
    private static const STATE_CLOSING_CODE: UInt32 = 2
    private static const STATE_DISPOSED_CODE: UInt32 = 3

    static let Initial = SocketState()
    static let Terminal: SocketState
    static let JustAccepted: SocketState

    SocketState(var value: UInt32) {}

    private init() {
        this(0)
    }

    static init() {
        var s = SocketState()
        s.nativeState = SocketDisposed
        Terminal = s

        s = SocketState()
        s.nativeState = HolderState.SocketPrepared
        s.bound = true
        s.connected = true
        JustAccepted = s
    }

    /**
     * Number of currently running operations
     */
    mut prop useCounter: UInt32 {
        get() {
            value & COUNTER_MASK
        }
        set(newValue) {
            if ((newValue & !COUNTER_MASK) != 0) {
                incrementFailed()
            }
            value = (value & !COUNTER_MASK) | newValue
        }
    }

    private static func incrementFailed(): Nothing {
        throw OverflowException("Socket usage couter overflow")
    }

    /**
     * Numeric value of the current state, see STATE_XXX_CODE constants
     */
    private mut prop nativeStateNum: UInt32 {
        get() {
            (value & NATIVE_STATE_MASK) >> NATIVE_STATE_SHIFT
        }
        set(newValue) {
            value = (value & !NATIVE_STATE_MASK) | ((newValue << NATIVE_STATE_SHIFT) & NATIVE_STATE_MASK)
        }
    }

    prop disposedOrShuttingDown: Bool {
        get() {
            return nativeStateNum >= STATE_CLOSING_CODE
        }
    }

    mut prop nativeState: HolderState {
        get() {
            let nativeStateNum = nativeStateNum
            match {
                case nativeStateNum == STATE_NOT_CREATED_CODE => SocketNotCreated
                case nativeStateNum == STATE_PREPARED_CODE => SocketPrepared
                case nativeStateNum == STATE_CLOSING_CODE => SocketClosing
                case _ => SocketDisposed
            }
        }
        set(newState) {
            let newValue: UInt32 = match (newState) {
                case SocketNotCreated => STATE_NOT_CREATED_CODE
                case SocketPrepared => STATE_PREPARED_CODE
                case SocketClosing => STATE_CLOSING_CODE
                case SocketDisposed => STATE_DISPOSED_CODE
                // introducing more socket states will require changing NATIVE_STATE_MASK
                // and reconsidering native state bit layout
            }
            if (nativeStateNum > newValue) {
                throw IllegalArgumentException("Backward state transition is not allowed")
            }
            nativeStateNum = newValue
        }
    }

    mut prop connected: Bool {
        get() {
            check(CONNECTED_MASK)
        }
        set(new) {
            setBit(CONNECTED_MASK, new)
        }
    }

    mut prop bound: Bool {
        get() {
            check(BOUND_MASK)
        }
        set(new) {
            setBit(BOUND_MASK, new)
        }
    }

    mut prop hasReaders: Bool {
        get() {
            check(HAS_READER_MASK)
        }
        set(new) {
            setBit(HAS_READER_MASK, new)
        }
    }

    mut prop hasWriters: Bool {
        get() {
            check(HAS_WRITER_MASK)
        }
        set(new) {
            setBit(HAS_WRITER_MASK, new)
        }
    }

    mut prop failed: Bool {
        get() {
            check(FAILED_MASK)
        }
        set(new) {
            setBit(FAILED_MASK, new)
        }
    }

    func ensureNotClosed(): Unit {
        if (disposedOrShuttingDown) {
            SocketException.throwClosedException()
        }
    }

    func ensureConnected(): Unit {
        if (!connected) {
            SocketException.notYetConnected()
        }
    }

    func ensureNotConnected() {
        if (connected) {
            SocketException.alreadyConnected()
        }
    }

    func ensureBound(): Unit {
        if (!bound) {
            SocketException.notYetBound()
        }
    }

    func ensureBindInvoked(): Unit {
        if (!bound) {
            SocketException.notYetBoundNeedBind()
        }
    }

    func ensureNotBound(): Unit {
        if (bound) {
            SocketException.alreadyBound()
        }
    }

    private func check(mask: UInt32): Bool {
        (value & mask) != 0
    }

    private mut func setBit(mask: UInt32, newState: Bool) {
        if (newState) {
            value |= mask
        } else {
            value &= !mask
        }
    }
}
