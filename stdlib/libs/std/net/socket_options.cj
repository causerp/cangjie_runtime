/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.net

public struct SocketOptions {
    private init() {
    }

    @Deprecated[message: "Use `public static const SOCKET: Int32` in `public struct OptionLevel` instead."]
    public static const SOL_SOCKET: Int32 = SOL_SOCKET

    @Deprecated[message: "Use `public static const TCP: Int32` in `public struct OptionLevel` instead."]
    public static const IPPROTO_TCP: Int32 = IPPROTO_TCP

    @Deprecated[message: "Use `public static const UDP: Int32` in `public struct OptionLevel` instead."]
    public static const IPPROTO_UDP: Int32 = IPPROTO_UDP

    public static const SO_KEEPALIVE: Int32 = SOCK_KEEPALIVE
    public static const TCP_NODELAY: Int32 = SOCK_TCP_NODELAY
    public static const TCP_QUICKACK: Int32 = SOCK_TCP_QUICKACK

    public static const SO_LINGER: Int32 = SOCK_LINGER
    public static const SO_SNDBUF: Int32 = SOCK_SNDBUF
    public static const SO_RCVBUF: Int32 = SOCK_RCVBUF

    public static const SO_REUSEADDR: Int32 = SOCK_REUSEADDR
    public static const SO_REUSEPORT: Int32 = SOCK_REUSEPORT
    public static const SO_BINDTODEVICE: Int32 = SOCK_BINDTODEVICE
}
