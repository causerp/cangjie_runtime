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

public macro DeriveExclude(input: Tokens): Tokens {
    assertParentContext(DeriveName)

    if (insideParentContext(DeriveExcludeName)) {
        diagReport(ERROR, Tokens(), "${DeriveExcludeName} can be only applied once", "")
        return input
    }

    match (parseDeclUnwrapSafe(input)) {
        case Ok(p: VarDecl) where p.isStatic() =>
            diagReport(DiagReportLevel.ERROR, Tokens(p.identifier),
                "DeriveExclude can't be applied to a static field because static fields are always excluded", "")
        case Ok(p: VarDecl) =>
            DeriveExcludeData(p.identifier).sendMessage()
        case Ok(other) =>
            diagReport(DiagReportLevel.ERROR, Tokens(other.identifier),
                "DeriveExclude should be applied on a field", "")
        case Err(cause) =>
            diagReport(ERROR, Tokens(), "Failed to parse decl", cause.toString())
    }

    return input
}

struct DeriveExcludeData <: DerivingMacroMessage<DeriveExcludeData> {
    DeriveExcludeData(
        let excludedId: Token
    ) {}

    public static prop Key: String {
        get() { DeriveIncludeName }
    }

    public func sendMessage() {
        setItem(EXCLUDED_ID_KEY, Tokens(excludedId))
    }

    public static func fromMessage(msg: MacroMessage): ?DeriveExcludeData {
        if (!msg.hasItem(EXCLUDED_ID_KEY)) {
            return None
        }
        DeriveExcludeData(msg.getTokens(EXCLUDED_ID_KEY)[0])
    }

    private static const EXCLUDED_ID_KEY = "excludedId"
}

