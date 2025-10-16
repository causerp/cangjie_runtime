/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
protected package std.deriving.api

import std.ast.*
import std.collection.ArrayList

public interface Logger {
    func warning(at: Tokens, message: String): Unit {
        log(at, message, error: false)
    }

    func warning(at: Token, message: String): Unit {
        warning(Tokens(at), message)
    }

    func error(at: Tokens, message: String): Unit {
        log(at, message, error: true)
    }

    func error(at: Token, message: String): Unit {
        error(Tokens(at), message)
    }

    func log(at: Tokens, message: String, error!: Bool): Unit
}

public class CollectingLogger <: Logger {
    private let elements = ArrayList<String>()

    public override func log(at: Tokens, message: String, error!: Bool): Unit {
        let label = if (error) { "[ERROR]" } else { "[WARNING]" }
        elements.add("${label} ${message}: ${at.toString()}")
    }

    public func collect(): Array<String> {
        elements.toArray()
    }

    public func clear(): Unit {
        elements.clear()
    }
}
