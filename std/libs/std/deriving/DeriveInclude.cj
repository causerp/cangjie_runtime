/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
macro package std.deriving

import std.deriving.api.*
import std.deriving.impl.*
import std.ast.*

public macro DeriveInclude(input: Tokens): Tokens {
    assertParentContext(DeriveName)

    if (insideParentContext(DeriveIncludeName)) {
        diagReport(ERROR, Tokens(), "DeriveInclude should be only applied once", "")
        return input
    }

    match (parseDeclUnwrapSafe(input)) {
        case Ok(p: PropDecl) where p.isStatic() =>
            diagReport(DiagReportLevel.ERROR, Tokens(p.identifier),
                "DeriveInclude can't be applied on a static property", "")
        case Ok(p: PropDecl) =>
            DeriveIncludeData(p.identifier).sendMessage()
        case Ok(other) =>
            diagReport(DiagReportLevel.ERROR, Tokens(other.identifier),
                "DeriveInclude should be applied on a property", "")
        case Err(cause) =>
            diagReport(ERROR, Tokens(), "Failed to parse decl", cause.toString())
    }

    return input
}

struct DeriveIncludeData <: DerivingMacroMessage<DeriveIncludeData> {
    DeriveIncludeData(
        let includedId: Token
    ) {}

    public static prop Key: String {
        get() { DeriveIncludeName }
    }

    public func sendMessage() {
        setItem(INCLUDED_ID_KEY, Tokens(includedId))
    }

    public static func fromMessage(msg: MacroMessage): ?DeriveIncludeData {
        if (!msg.hasItem(INCLUDED_ID_KEY)) {
            return None
        }

        DeriveIncludeData(msg.getTokens(INCLUDED_ID_KEY)[0])
    }

    private static const INCLUDED_ID_KEY = "includedId"
}

