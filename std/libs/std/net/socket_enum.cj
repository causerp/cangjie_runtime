/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/**
 * @file The file declares the SocketNet and SocketKeepAliveConfig enumeration class.
 */
package std.net

/**
 * Transport Layer Protocol Kind
 */
public enum SocketNet <: ToString & Equatable<SocketNet> {
    | TCP
    | UDP
    | UNIX

    public func toString(): String {
        match (this) {
            case TCP => return "tcp"
            case UDP => return "udp"
            case UNIX => return "domain"
        }
    }

    public operator func ==(that: SocketNet): Bool {
        match ((this, that)) {
            case (TCP, TCP) => true
            case (UDP, UDP) => true
            case (UNIX, UNIX) => true
            case _ => false
        }
    }

    public operator func !=(that: SocketNet): Bool {
        return !(this == that)
    }
}

enum SocketMode <: Equal<SocketMode> {
    | StreamingMode
    | DatagramMode
    | SequentialMode

    public override operator func ==(other: SocketMode): Bool {
        match ((this, other)) {
            case (StreamingMode, StreamingMode) => true
            case (DatagramMode, DatagramMode) => true
            case (SequentialMode, SequentialMode) => true
            case _ => false
        }
    }
}

extend Duration {
    func throwIfNegative(what: String): Duration {
        if (this < Duration.Zero) {
            throw IllegalArgumentException("${what} duration cannot be negative.")
        }
        if (this > MAX_TIMEOUT_DURATION) {
            return MAX_TIMEOUT_DURATION
        }
        return this
    }

    func bumpAtLeast(other: Duration): Duration {
        if (this < other) {
            return other
        }

        return this
    }

    func toNanosecondGranularity(): Duration {
        this.toNanoseconds() * Duration.nanosecond
    }
}
