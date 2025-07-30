/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
macro package std.unittest.mock.mockmacro

import std.ast.*
import std.collection.ArrayList

enum ParseResult<T> {
    Success(T) | Error(Array<SyntaxError>)
}

enum SyntaxErrorKind {
    WrongMatcherExpr | WrongStubExpr | WrongObjectReference | ParserFailed
}

struct SyntaxError {
    SyntaxError(
        let actualTokens: Tokens,
        let kind: SyntaxErrorKind
    ) {}

    static func matcher(tokens: Tokens) {
        SyntaxError(tokens, WrongMatcherExpr)
    }

    static func stub(tokens: Tokens) {
        SyntaxError(tokens, WrongStubExpr)
    }

    static func mockObject(tokens: Tokens) {
        SyntaxError(tokens, WrongObjectReference)
    }

    static func parser() {
        SyntaxError(Tokens(), ParserFailed)
    }
}

func accumulateErrors<T>(parseResults: Iterable<ParseResult<T>>): ParseResult<Array<T>> {
    let results = ArrayList<T>()
    let errors = ArrayList<SyntaxError>()
    for (parseResult in parseResults) {
        match (parseResult) {
            case Success(t) => results.add(t)
            case Error(syntaxErrors) => errors.add(all: syntaxErrors)
        }
    }
    if (errors.isEmpty()) {
        return ParseResult.Success(results.toArray())
    } else {
        return ParseResult.Error(errors.toArray())
    }
}

func reportSyntaxErrors(errors: Array<SyntaxError>): Nothing {
    var message = "Encountered issues while processing macro:\n"
    for (error in errors) {
        let exprString = descriptionString(error.actualTokens)
        match (error.kind) {
            case ParserFailed => throw MalformedMacroException("Unable to parse macro.")
            case WrongMatcherExpr => message += "Invalid matcher expression: ${exprString}\n"
            case WrongStubExpr => message += "Invalid stub description expression: ${exprString}\n"
            case WrongObjectReference => message += "Reference to a mock object must be a single identifier. Invalid reference: ${exprString}\n"
        }
    }
    throw MalformedMacroException(message, errors)
}

class MalformedMacroException <: Exception {
    MalformedMacroException(
        message: String,
        let errors: Array<SyntaxError>
    ) {
        super(message)
    }
}
