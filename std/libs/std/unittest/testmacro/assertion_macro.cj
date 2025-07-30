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

private let ctxClassname: Token = Token(IDENTIFIER, "AssertionCtx")
let macroCtxVarname: Token = Token(IDENTIFIER, "__ctx_access_variable_name")

/**
 *
 * The macro only add inner macro @Attribute to outer macro Test.
 * It can use for-in expressionn to make Multiple Invocations.
 * The macro can be only defined at func.
 * @since 0.17.3
 * @see Test
 */
public macro Expect(input: Tokens): Tokens {
    if (insideParentContext("CustomAssertion")) {
        return assertionCallExpr(input, true, true)
    }
    return assertionCallExpr(input, true, false)
}

public macro Assert(input: Tokens): Tokens {
    if (insideParentContext("CustomAssertion")) {
        return assertionCallExpr(input, false, true)
    }
    return assertionCallExpr(input, false, false)
}

// Should @PowerAssert be befriend with custom assertions in similar way?
private func assertionCallExpr(input: Tokens, isExpect: Bool, insideCustom: Bool): Tokens {
    let (macroname, name) = if (isExpect) { ("@Expect", "expectEqual") } else { ("@Assert", "assertEqual") }
    let optParentCtx = if (insideCustom) { quote(optParentCtx: $macroCtxVarname) } else { quote() }
    let callId = Token(IDENTIFIER, name)
    match (parseCommaSeparatedExpressions(input)) {
        case args where args.size == 1 =>
            let left = args[0].toTokens().toString().asCodeInStringLiteral()
            return quote($callId($left,"true",$input,true, $optParentCtx))
        case args where args.size == 2 =>
            let left = args[0].toTokens().toString().asCodeInStringLiteral()
            let right = args[1].toTokens().toString().asCodeInStringLiteral()
            return quote($callId($left,$right,$input, $optParentCtx))
        case _ => throw MacroException("Invalid syntax for ${macroname}: use either ${macroname}(a, b) or ${macroname}(b)")
    }
}

public macro Expect(assertion: Tokens, body: Tokens): Tokens {
    if (insideParentContext("CustomAssertion")) {
        return customAssertionCallExpr(assertion, body, true, true)
    }
    return customAssertionCallExpr(assertion, body, true, false)
}

public macro Assert(assertion: Tokens, body: Tokens): Tokens {
    if (insideParentContext("CustomAssertion")) {
        return customAssertionCallExpr(assertion, body, false, true)
    }
    return customAssertionCallExpr(assertion, body, false, false)
}

/**
 * This macro marks top-level function which is used as custom assertion in @Assert and @Expect macroses
 *
 * FIRST function argument should be of type AssertionCtx
 */
public macro CustomAssertion(body: Tokens) {
    return topLevelMacroDriver(ASSERTION_MACRO, body, Tokens(), { it => insideParentContext(it.macroIdentifier) })
}

func emitCustomAssertionBuilder(decl: Decl): Tokens {
    let funcDecl = verifyCustomAssertionDecl(decl)
    let tb = TokensBuilder()
    tb.append(buildAssertionFunction(funcDecl)).append(NL)
    return tb.toTokens()
}

private func customAssertionCallExpr(assertion: Tokens, body: Tokens, isExpect: Bool, insideCustom: Bool): Tokens {
    let optParentCtx = if (insideCustom) { quote(optParentCtx: $macroCtxVarname) } else { quote() }
    let (macroname, name) = if (isExpect) { ("@Expect", "invokeCustomExpect") } else { ("@Assert", "invokeCustomAssert") }

    let _ = try {
        RefType(assertion)
    } catch (e: ASTException) {
        throw MacroException("${macroname} macro only accepts 'RefType' as an argument")
    }

    let callId = Token(IDENTIFIER, name)
    let args = parseCommaSeparatedExpressions(body) |>
        map { expr: Expr => expr.toTokens().toString() } |> collectArray

    return quote(
        $callId(
            $args,
            $(assertion.toString()),
            { __context: $ctxClassname => return $assertion(__context, $body)},
            $optParentCtx
        )
    )
}

private func verifyCustomAssertionDecl(decl: Decl): FuncDecl {
    let funcDecl = (decl as FuncDecl) ??
        throw MacroException("@CustomAssertion macro must be put onto the top-level functions")

    let argmesg: String = "@CustomAssertion function ${funcDecl.identifier.value} should have ${ctxClassname.value} class as it's first argument"
    if (funcDecl.funcParams.size == 0) {
        throw MacroException(argmesg)
    }
    let firstArgType = (funcDecl.funcParams[0].paramType as RefType)?.identifier.value
    if (firstArgType != ctxClassname.value) {
        throw MacroException(argmesg)
    }

    return funcDecl
}

private func buildAssertionFunction(funcDecl: FuncDecl) {
    let ctx = funcDecl.funcParams[0]
    let varname = ctx.identifier
    let args = funcDecl.funcParams |> skip(1) |> map {it: FuncParam => it.identifier.value } |> collectArray
    funcDecl.block.nodes.add(all: [
        VarDecl(quote(let $macroCtxVarname = $varname)),
        parseExpr(quote($varname.setArgsAliases($args)))
    ], at: 0)
    quote(
        $funcDecl
    )
}
