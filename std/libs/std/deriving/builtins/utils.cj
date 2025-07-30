/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
protected package std.deriving.builtins

import std.deriving.api.*
import std.ast.*
import std.collection.*

func destructEnumCase(enumCase: TargetEnumCase, prefix: String): Tokens {
    let constructorId = enumCase.constructor.identifier
    let presentPositions = enumCase.fields |> map<TargetEnumField, Int64> { f => f.position } |> collectHashSet

    if (enumCase.totalArgumentsCount == 0) {
        return quote($constructorId)
    }

    return (0..enumCase.totalArgumentsCount) |> map<Int64, Tokens> { f =>
        match (presentPositions.contains(f)) {
            case true => Tokens(Token(TokenKind.IDENTIFIER, "${prefix}${f}"))
            case _ => Tokens(Token(TokenKind.WILDCARD, "_"))
        }
    } |> joinTokens(prefix: quote($constructorId\(), delimiter: quote(,), postfix: quote(\)))
}

func enumFallback(target: DerivingTarget): Tokens {
    match (isEnumHasEllipsis(target)) {
        case true => quote(
            case _ => throw Exception("Should never happen")
        )
        case _ => quote()
    }
}

func isEnumHasEllipsis(target: DerivingTarget): Bool {
    match (target.declaration) {
        case en: EnumDecl => en.ellipsis.kind == TokenKind.ELLIPSIS
        case _ => false
    }
}

