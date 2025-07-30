/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.io

/**
 * The general class of exceptions produced by failed or interrupted I/O operations.
 */
public open class IOException <: Exception {
    public init() {
        super()
    }
    public init(message: String) {
        super(message)
    }
    protected override open func getClassName(): String {
        return "IOException"
    }
}
