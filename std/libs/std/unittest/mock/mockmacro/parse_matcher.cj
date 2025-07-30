/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
macro package std.unittest.mock.mockmacro

import std.ast.*

class Matcher {
    Matcher(
        let originalTokens: Tokens,
        let fullMatcherCall: Tokens,
        let descriptionString: String,
        let paramName: Option<Token>
    ) {}
}

func parseMatcherFromArg(arg: Argument): ParseResult<Matcher> {
    var optionName = try {
        Some(arg.identifier)
    } catch (e: ASTException) {
        None<Token>
    }
    parseMatcherExpression(arg.expr, paramName: optionName)
}

func parseMatcherExpression(e: Expr, paramName!: Option<Token> = None): ParseResult<Matcher> {
    let tokens = try {
        e.toTokens()
    } catch (e: Exception) {
        return ParseResult.Error([SyntaxError.parser()])
    }

    func error(): ParseResult<Matcher> {
        return ParseResult.Error([SyntaxError.matcher(tokens)])
    }

    let description = descriptionString(tokens)
    let shortMatcherCall: Tokens = match (e) {
        case callExpr: CallExpr =>
            parseMatcherCallExpr(callExpr) ?? return error()
        case exprWithLambda: TrailingClosureExpr =>
            let exprWithoutLambda = exprWithLambda.expr
            let lambda = exprWithLambda.lambdaExpr
            let callWithoutLambda = if (exprWithoutLambda is CallExpr) {
                exprWithoutLambda as CallExpr
            } else {
                parseExpr(quote($exprWithoutLambda ())) as CallExpr
            }
            match (parseMatcherCallExpr(callWithoutLambda.getOrThrow())) {
                case Some(tokens) => quote($tokens $lambda)
                case None => return error()
            }
        case litConst: LitConstExpr =>
            return Success(Matcher(tokens, quote(Matchers.eq($litConst)), "eq(${description})", paramName))
        case refExpr: RefExpr =>
            quote(default($refExpr))
        case parenExpr: ParenExpr =>
            return parseMatcherExpression(parenExpr.parenthesizedExpr, paramName: paramName)
        case _ => return error()
    }
    Success(Matcher(tokens, quote(Matchers.$shortMatcherCall), description, paramName))
}

func parseMatcherCallExpr(callExpr: CallExpr): ?Tokens {
    let callee = callExpr.callFunc
    match (callee) {
        case exprBeforeParen: MemberAccess =>
            let exprBeforeDot = exprBeforeParen.baseExpr
            if (!isMatchersRef(exprBeforeDot)) {
                return None
            }
            let funcIdentifier = exprBeforeParen.field
            let args = callExpr.arguments.toTokens()
            quote($funcIdentifier($args))
        case _: RefExpr =>
            callExpr.toTokens()
        case _ => None
    }
}

func isMatchersRef(e: Expr): Bool {
    match (e) {
        case ref: RefExpr where ref.identifier.value == "Matchers" => true
        case _ => false
    }
}
