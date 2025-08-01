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

class Stub {
    Stub(
        let originalCall: Expr,
        let matchers: Array<Matcher>,
        /*
         * Object ref token for mocks on members of classes/interfaces,
         * Type ref token for mocks on static declarations,
         * `None` for top-level declarations
         */
        let prefixReference: Option<Token>,
        let declarationName: String,
        let kind: StubKind
    ) {}
}

enum StubKind {
    Function | Getter | Setter(Tokens)
}

func parseStubCall(inputTokens: Tokens, stubExpr: Expr): ParseResult<Stub> {
    match (stubExpr) {
        case callExpr: CallExpr =>
            let (baseExpr, fieldValue): (Option<Expr>, String) = match (callExpr.callFunc) {
                case ma: MemberAccess => (ma.baseExpr, ma.field.value)
                case re: RefExpr => (Option<Expr>.None, re.identifier.value)
                case _ => return ParseResult.Error([SyntaxError.stub(inputTokens)])
            }

            let matchers = ArrayList<ParseResult<Matcher>>()
            let args = callExpr.arguments
            for (arg in args) {
                matchers.add(parseMatcherFromArg(arg))
            }
            createStubCall(
                baseExpr, stubExpr, matchers.toArray(),
                fieldValue
            )

        case binaryExpr: BinaryExpr =>
            let argMatcher = parseMatcherExpression(binaryExpr.rightExpr)
            createStubCall(
                binaryExpr.leftExpr, stubExpr, [argMatcher],
                "binary operator ${binaryExpr.op.kind.toString()}"
            )

        case unaryExpr: UnaryExpr =>
            createStubCall(
                unaryExpr.expr, stubExpr, [],
                "unary operator ${unaryExpr.op.kind.toString()}"
            )

        case subscriptExpr: SubscriptExpr =>
            createStubCall(
                subscriptExpr.baseExpr,
                stubExpr,
                subscriptExpr.indexList |>
                    map { expr: Expr => parseMatcherExpression(expr) } |>
                    collectArray,
                "operator []"
            )

        case assignExpr: AssignExpr =>
            match (assignExpr.leftExpr) {
                case propertyAccess: MemberAccess =>
                    createStubCall(
                        propertyAccess.baseExpr,
                        stubExpr, [parseMatcherExpression(assignExpr.rightExpr)],
                        propertyAccess.field.value,
                        kind: Setter(propertyAccess.toTokens())
                    )

                case subscriptExpr: SubscriptExpr =>
                    let matchers = ArrayList<ParseResult<Matcher>>()
                    matchers.add(
                        all: subscriptExpr.indexList |>
                            map { expr: Expr => parseMatcherExpression(expr) } |>
                            collectArray
                    )
                    matchers.add(
                        parseMatcherExpression(assignExpr.rightExpr)
                    )
                    createStubCall(
                        subscriptExpr.baseExpr, stubExpr, matchers.toArray(),
                        "operator []="
                    )

                case refExpr: RefExpr =>
                    createStubCall(
                        Option<Expr>.None,
                        stubExpr, [parseMatcherExpression(assignExpr.rightExpr)],
                        refExpr.identifier.value,
                        kind: Setter(refExpr.toTokens())
                    )

                case _ => ParseResult.Error([SyntaxError.stub(inputTokens)])
            }

        case propertyAccess: MemberAccess =>
            createStubCall(
                propertyAccess.baseExpr, stubExpr, [],
                propertyAccess.field.value,
                kind: Getter
            )

        case refExpr: RefExpr =>
            createStubCall(
                Option<Expr>.None, stubExpr, [],
                refExpr.identifier.value,
                kind: Getter
            )

        case _ => ParseResult.Error([SyntaxError.stub(inputTokens)])
    }
}

func createStubCall(
    prefixExpr: Option<Expr>,
    callExpr: Expr,
    parsedMatchers: Array<ParseResult<Matcher>>,
    declarationName: String,
    kind!: StubKind = Function
): ParseResult<Stub> {
    let errors = ArrayList<SyntaxError>()
    let matchers = accumulateErrors(parsedMatchers)
    if (let Error(syntaxErrors) <- matchers) {
        errors.add(all: syntaxErrors)
    }
    if (!errors.isEmpty()) {
        return ParseResult.Error(errors.toArray())
    }
    if (let Success(matchers) <- matchers) {
        return ParseResult.Success(Stub(callExpr, matchers, asPrefixRef(prefixExpr), declarationName, kind))
    } else {
        throw Exception("Can't have empty error list")
    }
}

func asPrefixRef(prefixExpr: Option<Expr>): Option<Token> {
    let refExpr = if (let Some(prefix) <- prefixExpr) {
        prefix as RefExpr
    } else {
        Option<RefExpr>.None
    }
    return match (refExpr) {
        case Some(v) => v.identifier
        case None => None
    }
}
