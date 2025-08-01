/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
macro package std.unittest.testmacro

import std.ast.*
import std.collection.*

// XXX: we cannot make this class inherit ToTokens because of a bug in the stdlib build
class TokensBuilder /* <: ToTokens */ {
    TokensBuilder(let data: ArrayList<Tokens>) {}
    init() { data = ArrayList() }

    func append(tokens: TokensBuilder): TokensBuilder {
        data.add(all: tokens.data)
        return this
    }

    func append(kind: TokenKind): TokensBuilder {
        data.add(Tokens(Token(kind)))
        return this
    }

    func append<TT>(tokens: TT): TokensBuilder where TT <: ToTokens {
        match (tokens) {
            case tb: TokensBuilder => return append(tb)
            case _ => ()
        }

        let raw = tokens.toTokens()
        data.add(raw)
        return this
    }

    func curlyBraces(body: (TokensBuilder) -> Unit): TokensBuilder {
        append(LCURL).append(NL)
        body(this)
        append(RCURL).append(NL)
    }

    func scope(body: (TokensBuilder) -> Unit) {
        append(NL).append(quote({ => ))
        body(this)
        append(NL).append(quote(}())).append(NL)
    }

    public func toTokens(): Tokens {
        let bigList = ArrayList<Token>()
        for (tt in data) {
            for (t in tt) {
                bigList.add(t)
            }
        }
        Tokens(bigList)
    }
}

extend Tokens {
    func startsWith(prefix: Tokens): Bool {
        let thisIt = this.iterator()
        let thatIt = prefix.iterator()
        while (true) {
            match ((thisIt.next(), thatIt.next())) {
                case (Some(t0), Some(t1)) where t0.kind == t1.kind && t0.value == t1.value =>
                    continue
                case (_, None) => return true
                case (None, _) => return false
                case _ => break
            }
        }
        return false
    }
}

extend<T> Option<T> where T <: ToTokens {
    func toTokens(): Tokens {
        match (this) {
            case None => quote(None)
            case Some(tokens) => quote($tokens)
        }
    }
}

func nestedTuple<T>(things: Array<T>): Tokens where T <: ToTokens {
    if (things.size == 0) {
        return Tokens()
    }
    if (things.size == 1) {
        return things[0].toTokens()
    }

    func buildTuple(tb: TokensBuilder, i: Int64): Unit {
        let item = things[i]
        if (i == 0) {
            tb.append(things[i])
            return
        }

        tb.append(TokenKind.LPAREN)
        buildTuple(tb, i - 1)
        tb.append(TokenKind.COMMA)
        tb.append(things[i])
        tb.append(TokenKind.RPAREN)
    }

    let tb = TokensBuilder()

    buildTuple(tb, things.size - 1)

    return tb.toTokens()
}

func commaSeparated<T>(things: Iterable<T>): Tokens where T <: ToTokens {
    let tb = TokensBuilder()
    let it = things.iterator()
    let first = it.next()
    match (first) {
        case None => return tb.toTokens()
        case Some(t) => tb.append(t)
    }
    for (e in it) {
        tb.append(COMMA).append(e)
    }
    return tb.toTokens()
}

func arrayLiteral<T>(array: Iterable<T>): Tokens where T <: ToTokens {
    return quote([$(commaSeparated(array))])
}

func tupleLiteral<T>(array: Iterable<T>): Tokens where T <: ToTokens {
    return quote(($(commaSeparated(array))))
}

func parseCommaSeparatedExpressions(input: Tokens): Array<Expr> {
    let parsedFakeCall = (parseExpr(quote(dummy($input))) as CallExpr).getOrThrow()
    return parsedFakeCall.arguments |> map { arg: Argument => arg.expr } |> collectArray
}

func getGenericParams(decl: Decl): Tokens {
    return try {
        decl.genericParam.parameters
    } catch (e: Exception) {
        Tokens()
    }
}

func parseTypes(tokens: Tokens): ArrayList<TypeNode> {
    let types = ArrayList<TypeNode>()

    var start = 0
    while (start <= tokens.size) {
        try {
            let (ty, end) = parseTypeFragment(tokens, startFrom: start)
            types.add(ty)
            start = end + 1

            if (start > tokens.size) {
                break
            }
            if (tokens.get(end).kind != TokenKind.COMMA) {
                throw Exception("Types should be separated with comma [${tokens}].")
            }
        } catch (e: ParseASTException) {
            throw IllegalArgumentException("List of types can not be parsed [${tokens}].")
        }
    }

    return types
}
