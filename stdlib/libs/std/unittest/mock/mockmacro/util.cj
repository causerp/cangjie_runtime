/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
macro package std.unittest.mock.mockmacro

import std.ast.*
import std.collection.enumerate

// NOTE: this was copied with some changes from power assert macro utils
// this doesn't cover all the issues
func descriptionString(tokens: Tokens): String {
    var result = ""
    var wasSamePosition = false // temporary workaround for a bug in AST API

    for ((i, token) in tokens |> enumerate) {
        if (let NL <- token.kind) {
            continue
        }
        if (i != 0) {
            let previousToken = tokens[i - 1]
            var shouldPutSpace = false
            let sameLine = token.pos.line == previousToken.pos.line
            if (sameLine) {
                var previousTokenEnd = tokenEnd(previousToken)
                let tokenEnd = tokenEnd(token)
                if (wasSamePosition) {
                    previousTokenEnd += 1
                }
                if (previousTokenEnd > token.pos.column && previousTokenEnd <= tokenEnd) {
                    shouldPutSpace = false
                }
                if (previousTokenEnd > tokenEnd) {
                    shouldPutSpace = true
                }
                if (previousTokenEnd < token.pos.column) {
                    shouldPutSpace = true
                }
            } else {
                shouldPutSpace = true
            }
            if (shouldPutSpace) {
                result += " "
            }
            wasSamePosition = token.pos == previousToken.pos
        }
        result += Tokens(token).toString()
    }
    if (result.contains("\"#")) {
        return "<?>"
    }
    return result.replace("\n", "")
}

func tokenLen(token: Token): Int32 {
    let valueSize = Int32(token.value.size)
    match (token.kind) {
        case STRING_LITERAL | SINGLE_QUOTED_STRING_LITERAL => valueSize + 2
        case _ => valueSize
    }
}

func tokenEnd(token: Token): Int32 {
    return token.pos.column + tokenLen(token)
}

func singleQuoteStringLiteral(str: String): Token {
    return Token(TokenKind.STRING_LITERAL, str)
}

func rawStringLiteral(str: String): Token {
    return Token(TokenKind.MULTILINE_RAW_STRING, str)
}
