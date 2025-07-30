/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.net

public struct AddressFamily <: ToString & Equatable<AddressFamily> {

    // UNSPEC
    public static const UNSPEC: AddressFamily = AddressFamily("UNSPEC", 0)

    // UNIX
    public static const UNIX: AddressFamily = AddressFamily("UNIX", 1)

    // INET
    public static const INET: AddressFamily = AddressFamily("INET", 2)

    // INET6
    @When[os != "Windows" && os != "macOS"]
    public static const INET6: AddressFamily = AddressFamily("INET6", 10)

    @When[os == "Windows"]
    public static const INET6: AddressFamily = AddressFamily("INET6", 23)

    @When[os == "macOS"]
    public static const INET6: AddressFamily = AddressFamily("INET6", 30)

    // NETLINK
    @When[os != "Windows" && os != "macOS"]
    public static const NETLINK: AddressFamily = AddressFamily("NETLINK", 16)

    // name
    public let name: String

    // value
    public let value: UInt16

    // init
    public const init(name: String, value: UInt16) {
        this.name = name
        this.value = value
    }

    public operator func ==(rhs: AddressFamily): Bool {
        this.value == rhs.value
    }
    public operator func !=(rhs: AddressFamily): Bool {
        this.value != rhs.value
    }

    public func toString(): String {
        return name
    }
}
