/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
macro package std.unittest.mock.mockmacro

import std.ast.*
import std.collection.*

func generateStubFunction(stubCall: Stub, callDescription: Token): Tokens {
    let invocation = generateInvocation(stubCall)
    let matcherDecls = generateMatcherDecls(stubCall)
    let matchersArray = generateMatchersArray(stubCall)
    let prefixRefName = if (let Some(ref) <- stubCall.prefixReference) {
        singleQuoteStringLiteral(ref.value).toTokens()
    } else {
        quote(Option<String>.None)
    }
    let lineNumber = generateLineNumber(stubCall)
    let funcName = singleQuoteStringLiteral(stubCall.declarationName)

    quote({ =>
        $matcherDecls
        let stubCall = @EnsurePreparedToMock { => return ($invocation) }
        ConfigureMock.stubFunction(stubCall, $matchersArray, $prefixRefName, $funcName, $callDescription, $lineNumber)
    }())
}

func generateStubGetter(stubCall: Stub, callDescription: Token): Tokens {
    let invocation = generateInvocation(stubCall)
    let prefixRefName = if (let Some(ref) <- stubCall.prefixReference) {
        singleQuoteStringLiteral(ref.value).toTokens()
    } else {
        quote(Option<String>.None)
    }
    let lineNumber = generateLineNumber(stubCall)
    let propOrFieldName = singleQuoteStringLiteral(stubCall.declarationName)

    quote({ =>
        let stubCall = @EnsurePreparedToMock { => return ($invocation) }
        ConfigureMock.stubGetter(stubCall, $prefixRefName, $propOrFieldName, $callDescription, $lineNumber)
    }())
}

func generateStubSetter(stubCall: Stub, getterCall: Tokens, callDescription: Token): Tokens {
    let invocation = generateInvocation(stubCall)
    let matcherDecls = generateMatcherDecls(stubCall)
    let matcherRef = matcherRef(0)
    let prefixRefName = if (let Some(ref) <- stubCall.prefixReference) {
        singleQuoteStringLiteral(ref.value).toTokens()
    } else {
        quote(Option<String>.None)
    }
    let lineNumber = generateLineNumber(stubCall)
    let propOrFieldName = singleQuoteStringLiteral(stubCall.declarationName)

    quote({ =>
        $matcherDecls
        let stubCall = @EnsurePreparedToMock { => return ($invocation) }
        ConfigureMock.stubSetter(stubCall, { => $getterCall }, $matcherRef, $prefixRefName, $propOrFieldName, $callDescription, $lineNumber)
    }())
}

func generateVerifyStatement(stubCall: Stub, callDescription: Token): Tokens {
    let invocation = generateInvocation(stubCall)
    let matcherDecls = generateMatcherDecls(stubCall)
    let matchersArray = generateMatchersArray(stubCall)
    let prefixRefName = if (let Some(ref) <- stubCall.prefixReference) {
        singleQuoteStringLiteral(ref.value).toTokens()
    } else {
        quote(Option<String>.None)
    }
    let lineNumber = generateLineNumber(stubCall)
    let declarationName = singleQuoteStringLiteral(stubCall.declarationName)

    let result = quote({ =>
        $matcherDecls
        let stubCall = @EnsurePreparedToMock { => return ($invocation) }
        VerifyStatement.fromStub(stubCall, $matchersArray, $prefixRefName, $declarationName, $callDescription, $lineNumber)
    }())

    return result
}

func generateInvocation(stubCall: Stub): Tokens {
    let result = Tokens()
    let it = stubCall.originalCall.toTokens().iterator()
    while (true) {
        match (it.next()) {
            case None => break
            case Some(tok) =>
                let matcherStartingHere = (stubCall.matchers |>
                    enumerate |>
                    filter {
                        matcherWithIndex: (Int64, Matcher) =>
                            matcherWithIndex[1].originalTokens[0].pos == tok.pos
                    }).next()
                match (matcherStartingHere) {
                    case Some((index, matcher)) =>
                        for (_ in 0..matcher.originalTokens.size - 1) {
                            it.next()
                        }
                        result.append(matcherRef(index))
                        result.append(quote(.value()))
                    case _ =>
                        result.append(tok)
                }
        }
    }
    return result
}

func generateMatcherDecls(stubCall: Stub): Tokens {
    let result = Tokens()
    for ((index, matcher) in stubCall.matchers |> enumerate) {
        let matcherRef = matcherRef(index)
        let matcherValue = matcher.fullMatcherCall
        result.append(
            quote(let $matcherRef = $matcherValue)
        )
        if (index != stubCall.matchers.size - 1) {
            result.append(Token(TokenKind.NL))
        }
    }
    return result
}

func matcherRef(index: Int64): Token {
    return Token(TokenKind.IDENTIFIER, "matcher${index}")
}

func generateLineNumber(stubCall: Stub): Token {
    let number = stubCall.originalCall.toTokens().get(0).pos.line
    return Token(TokenKind.INTEGER_LITERAL, number.toString())
}

func generateMatchersArray(stubCall: Stub): Tokens {
    var matchersArray = Tokens()
    for ((index, matcher) in stubCall.matchers |> enumerate) {
        matchersArray.append(matcherWithDescriptionAndParamName(matcher, index))
        if (index != stubCall.matchers.size - 1) {
            matchersArray.append(quote(,))
        }
    }
    return quote([$matchersArray])
}

func matcherWithDescriptionAndParamName(matcher: Matcher, index: Int64) {
    let description = rawStringLiteral(matcher.descriptionString)
    let matcherRef = matcherRef(index)
    let paramName = matcher.paramName
    var result = quote($matcherRef.withDescription($description))
    if (let Some(name) <- paramName) {
        let nameToken = singleQuoteStringLiteral(name.value)
        result += quote(.forParameter($nameToken))
    }
    return result
}
