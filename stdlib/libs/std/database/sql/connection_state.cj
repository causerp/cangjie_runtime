/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.database.sql

public enum ConnectionState <: Equatable<ConnectionState> {

    /**
     * The connection to the data source is broken.
     * This can occur only after the connection has been opened.
     * A connection in this state may be closed and then re-opened.
     *
     * @since 0.40.1
     */
    | Broken
    /**
     * The connection is closed.
     *
     * @since 0.40.1
     */
    | Closed
    /**
     * The connection object is connecting to the data source.
     *
     * @since 0.40.1
     */
    | Connecting
    /**
     * The connection is connected.
     *
     * @since 0.40.1
     */
    | Connected

    public operator func ==(rhs: ConnectionState): Bool {
        match ((this, rhs)) {
            case (Broken, Broken) => true
            case (Closed, Closed) => true
            case (Connecting, Connecting) => true
            case (Connected, Connected) => true
            case _ => false
        }
    }

    public operator func !=(rhs: ConnectionState): Bool {
        return !(this == rhs)
    }
}
