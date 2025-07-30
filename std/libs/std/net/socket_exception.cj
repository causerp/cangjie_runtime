/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/**
 * @file The file declares the SocketException class and SocketTimeoutException class.
 */

package std.net

import std.io.*

/**
 * The SocketException class is used to handle exceptions related to socket connection errors.
 */
public class SocketException <: IOException {
    public init() {
        super()
    }
    public init(message: String) {
        super(message)
    }
    protected override func getClassName(): String {
        return "SocketException"
    }

    static func throwClosedException(): Nothing {
        throw SocketException("Socket is already closed")
    }

    static func notYetConnected(): Nothing {
        throw SocketException("Socket is not connected")
    }

    static func notYetBound(): Nothing {
        throw SocketException("Socket is not bound")
    }

    static func notYetBoundNeedBind(): Nothing {
        throw SocketException("The socket is not bound: invoke bind() first.")
    }

    static func alreadyBound(): Nothing {
        throw SocketException("The socket is already bound")
    }

    static func alreadyConnected(): Nothing {
        throw SocketException("The socket is already connected")
    }
}

/**
 * The SocketTimeoutException class is used to handle exceptions related to socket connection timeout.
 */
public class SocketTimeoutException <: Exception {
    public init() {
        super()
    }
    public init(message: String) {
        super(message)
    }
    protected override func getClassName(): String {
        return "SocketTimeoutException"
    }
}
