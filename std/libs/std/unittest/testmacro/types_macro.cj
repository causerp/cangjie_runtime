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

/**
 * Provide types for a generic test class or test function.
 * Parse parameters in the form @Types[T1 in <A, B, C>, T2 in <D, E>, ...]
 * where T1, T2 ... are generic type parameters of the annotated declaration, and A, B, C, D, E... are types.
 * The corresponding test will be run on each combination of all provided parameter types.
 * This macro must be used together with @Test, @TestCase or @Bench macro.
 * This macro is not repeatable, only one must be used for a single declaration.
 * The type argument specified using this macro must be the same as the generic type parameters of the annotated declaration.
 */
public macro Types(dsl: Tokens, input: Tokens) {
    return topLevelMacroDriver(TYPES_MACRO, input, dsl, {it => insideParentContext(it.macroIdentifier)})
}

/**
 * Parse parameters in the form @Types[T in <A, B, C>]
 */
func parseTypesMacro(params: Tokens): Array<(String, Array<Tokens>)> {
    let parser = DSLParser(Tokens(collectArray(params)))
    let result = ArrayList<(String, Array<Tokens>)>()

    try {
        while (true) {
            let id = parser.expectToken(IDENTIFIER)
            parser.expectToken(IN)
            parser.expectToken(TokenKind.LT)
            let toks = parser.parseBalancedDelimited(delimiter: TokenKind.COMMA, terminator: TokenKind.GT)
            result.add((id.value, toks))
            parser.expectToken(TokenKind.GT)
            if (!parser.completed() && parser.currentToken.kind == COMMA) {
                parser.nextToken()
                continue
            } else {
                break
            }
        }
    } catch (ex: Exception) {
        throw MacroException(
            "Illegal parameters for @Types: ${params}," +
                "parameters should use the form @Types[T in <A, B, C>, U in <D, E>], nested error:" + ex.message)
    }
    return result.toArray()
}

/**
 * Auxilliary function to walk all of the combinations of all the type variables
 * Calls body on each possible combination of type arguments
 *
 * @param left The type parameters to combine
 * @param typeSubst The map from parameter names to actual types (possibly many for each name)
 * @param acc Recursive accumulator
 * @param body Function to be called on each combination of argument types
 */
func walkTypeParameters(
    left: Array<Token>,
    typeSubst: HashMap<String, Array<Tokens>>,
    acc: ArrayList<Tokens>,
    body: (ArrayList<Tokens>) -> Unit
): Unit {
    if (left.isEmpty()) {
        // we have set up all parameters in acc
        body(acc)
        return
    }

    let vars = typeSubst.get(left[0].value) ?? throw MacroException(
        "Generic type parameter ${left[0].value} is not provided, did you forget to put a @Types macro?")
    for (v in vars) {
        // because we parse types manually, they can be empty in the parser
        if (v.size == 0) {
            throw MacroException("Empty type in @Types macro for parameter ${left[0].value}")
        }
        // to not use quadratic memory, we mutate the same accumulator by adding a new element of combination
        // and then removing it, simultaneously removing the corresponding parameter from `left`
        acc.push(v)
        walkTypeParameters(left[1..], typeSubst, acc, body)
        acc.pop()
    }
}

/**
 * Check that a given substitution typeSubst does not contain elements not in genericArgs.
 *
 * Note: this **does not** check that genericArgs does not contain something in typeSubst,
 *       that check is performed in walkTypeParameters function before calling this one
 */
func checkTypeSubstitution(
    genericArgs: Array<Token>,
    typeSubst: HashMap<String, Array<Tokens>>
) {
    for ((_, v) in typeSubst) {
        for (vts in v) {
            for (vt in vts) {
                if (vt.kind == IDENTIFIER && typeSubst.contains(vt.value)) {
                    throw MacroException(
                        "@Types macro does not support recursive types: " +
                        "type ${typesToString(vts)} is not allowed to use type parameter ${vt.value}")
                }
            }
        }
    }
    // if there are problems, the sizes should be different
    // otherwise we would've already got an error from walkTypeParameters
    if (genericArgs.size == typeSubst.size) {
        return
    }
    let mutableTypeSubst = typeSubst.clone()
    for (arg in genericArgs) {
        mutableTypeSubst.remove(arg.value)
    }
    if (mutableTypeSubst.size > 0) {
        let leftoverVars = mutableTypeSubst.keys() |> collectString<String>(delimiter: ", ")
        throw MacroException("@Types macro provides unknown type variables: ${leftoverVars}")
    }
}

/**
 * Tokens.toString() is ugly for types, if we know that something is a type,
 * we can try to print it more prettily
 */
func typesToString(types: Tokens) {
    let result = StringBuilder()
    for (token in types) {
        match (token.kind) {
            case TokenKind.COMMA => result.append(", ")
            case TokenKind.ARROW => result.append(" -> ")
            case _ => result.append(token.value)
        }
    }
    return result.toString()
}
