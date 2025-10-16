/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
macro package std.deriving

import std.deriving.api.*
import std.ast.*

interface DerivingMacroMessage<T> {
    static prop Key: String

    func sendMessage(): Unit
    static func fromMessage(msg: MacroMessage): ?T
}

/**
 * Does parse decl catching exceptions. When a declaration is marked with a user
 * defined annotation, it appears as a macro invocation so we have to unwrap it
 */
func parseDeclUnwrapSafe(input: Tokens): Result<Decl> {
    try {
        Ok(parseDecl(input).unwrap())
    } catch (cause: Exception) {
        Err(cause)
    }
}

enum Result<T> {
    | Ok(T)
    | Err(Exception)
}
