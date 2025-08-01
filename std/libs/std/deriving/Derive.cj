/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
macro package std.deriving

import std.deriving.api.*
import std.deriving.impl.deriveImpl
import std.ast.*
import std.collection.*

const DeriveName = "Derive"
const DeriveIncludeName = "DeriveInclude"
const DeriveExcludeName = "DeriveExclude"
const DeriveOrderName = "DeriveOrder"

public macro Derive(rawOptions: Tokens, input: Tokens): Tokens {
    let logger = LoggerImpl({ at, message, error =>
        diagReport(if (error) { DiagReportLevel.ERROR } else { DiagReportLevel.WARNING }, at, message, "")
    })

    let includes = getChildMessages(DeriveIncludeName).iterator()
        .filterMap { it => DeriveIncludeData.fromMessage(it) }
        .map { it => Identifier(it.includedId) } |> collectArray
    let excludes = getChildMessages(DeriveExcludeName).iterator()
        .filterMap { it => DeriveExcludeData.fromMessage(it) }
        .map { it => Identifier(it.excludedId) } |>
        collectArray
    let ordering = getChildMessages(DeriveOrderName).iterator()
        .filterMap { it => DeriveOrderData.fromMessage(it) }
        .map { it => it.members } |>
        flatten |>
        map<Token, Identifier> { it => Identifier(it) } |>
        collectArray

    match (parseDeclUnwrapSafe(input)) {
        case Ok(decl) => deriveImpl(rawOptions, input, decl, includes, excludes, ordering, logger)
        case Err(cause) => reportNonDeclInput(input, logger, cause)
    }
}

private func reportNonDeclInput(input: Tokens, logger: Logger, cause: Exception): Tokens {
    let declKeyword = findDeclKeyword(input)

    if (let Some(declKeyword) <- declKeyword) {
        if (declKeyword.kind == TokenKind.CLASS || declKeyword.kind == TokenKind.STRUCT ||
            declKeyword.kind == TokenKind.ENUM) {
            logger.error(findReportTarget(input), "Unable to derive ${declKeyword.value}: ${cause}")
            return input
        }
    }

    // here we could try to make a lax parse and try to proceed but it requires
    // much more effort
    logger.error(declKeyword ?? findReportTarget(input), "Deriving is only supported for classes, enums and structs: ${cause}")

    return input
}

private let DECL_KEYWORD_KINDS = [
    TokenKind.FUNC, TokenKind.CLASS, TokenKind.STRUCT,
    TokenKind.ENUM, TokenKind.MAIN, TokenKind.MACRO,
    TokenKind.PROP, TokenKind.VAR, TokenKind.LET
].iterator().map { a => a.toString() }

private func findDeclKeyword(input: Tokens): ?Token {
    input.iterator().filter { it => DECL_KEYWORD_KINDS.contains(it.kind.toString()) }.first()
}

private func findIdentifier(input: Tokens): ?Token {
    input.iterator().filter { it => it.kind == TokenKind.IDENTIFIER }.first()
}

private func findReportTarget(input: Tokens): Token {
   findIdentifier(input) ?? input.iterator().first() ?? Token()
}

struct LoggerImpl <: Logger {
    LoggerImpl(private let sink: (Tokens, String, Bool) -> Unit) {
    }

    public func log(at: Tokens, message: String, error!: Bool): Unit {
        sink(at, message, error)
    }
}
