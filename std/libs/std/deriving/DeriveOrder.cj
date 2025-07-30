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
import std.collection.*

public macro DeriveOrder(members: Tokens, input: Tokens): Tokens {
    assertParentContext(DeriveName)

    if (insideParentContext(DeriveOrderName)) {
        diagReport(DiagReportLevel.ERROR, Tokens(), "${DeriveOrderName} should be only applied once", "")
        return input
    }

    let logger = LoggerImpl({ at, message, error =>
        diagReport(if (error) { DiagReportLevel.ERROR } else { DiagReportLevel.WARNING }, at, message, "")
    })

    let names = parseNames(members, logger)

    DeriveOrderData(names).sendMessage()

    return input
}

private func parseNames(members: Tokens, logger: Logger): Array<Token> {
    let it = members |> filter { t => !canSkip(t.kind) }
    let result = ArrayList<Token>(members.size)

    while (let Some(id) <- it.next()) {
        if (id.kind != TokenKind.IDENTIFIER) {
            logger.error(id, "Expected field or property name, got ${id.kind}")
            continue
        }

        result.add(id)

        let comma = it.next() ?? break
        if (comma.kind == TokenKind.IDENTIFIER) {
            result.add(comma) // we do report an error in the following if
        }
        if (comma.kind != TokenKind.COMMA) {
            logger.error(comma, "Expected comma or nothing, got ${comma.kind}")
        }
    }

    return result.toArray()
}

private func canSkip(kind: TokenKind): Bool {
    kind == TokenKind.NL || kind == TokenKind.COMMENT
}

struct DeriveOrderData <: DerivingMacroMessage<DeriveOrderData> {
    DeriveOrderData(
        let members: Array<Token>
    ) {}

    public static prop Key: String {
        get() { DeriveOrderName }
    }

    public func sendMessage() {
        setItem(MEMBERS_KEY, Tokens(members))
    }

    public static func fromMessage(msg: MacroMessage): ?DeriveOrderData {
        if (!msg.hasItem(MEMBERS_KEY)) {
            return None
        }
        DeriveOrderData(msg.getTokens(MEMBERS_KEY).iterator() |> collectArray)
    }

    private static const MEMBERS_KEY = "members"
}

