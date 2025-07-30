/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.net

/**
 * TCP KeepAlive Options
 */
public struct SocketKeepAliveConfig <: ToString & Equatable<SocketKeepAliveConfig> {
    /**
     * If no data is exchanged within the `idle` period, the probe is performed.
     */
    public let idle: Duration

    /**
     * The interval for sending probe packets is `interval`.
     */
    public let interval: Duration

    /**
     * Number of probe packets are sent before the connection is considered invalid.
     */
    public let count: UInt32

    /**
     * Creates a socket keep alive config instance.
     * Please note that the actual time granularity could be different depending on the operating system
     * so could be bumped or rounded if needed correspondingly.
     *
     * @throws IllegalArgumentException if the specified idle or interval duration is negative.
     */
    public init(
        idle!: Duration = Duration.second * 45,
        interval!: Duration = Duration.second * 5,
        count!: UInt32 = 5
    ) {
        this.idle = idle.throwIfNegative("Idle")
        this.interval = interval.throwIfNegative("Interval")
        this.count = count
    }

    public override func toString(): String {
        "SocketKeepAliveConfig(idle: ${idle}, interval: ${interval}, count: ${count})"
    }

    public override operator func ==(other: SocketKeepAliveConfig): Bool {
        idle == other.idle && interval == other.interval && count == other.count
    }

    public override operator func !=(other: SocketKeepAliveConfig): Bool {
        !(this == other)
    }
}
