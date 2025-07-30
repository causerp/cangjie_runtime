/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/**
 * @file The file declares the macro Skip.
 */
macro package std.unittest.testmacro

import std.ast.*

/**
 *
 * The macro only add inner macro @Attribute to outer macro Test.
 * It can skip the func to execute.
 * @since 0.17.3
 * @see Test
 *
 * @throws MacroException if input is not ClassDecl or FuncDecl.
 */
public macro Skip(input: Tokens): Tokens {
    return topLevelMacroDriver(SKIP_MACRO, input, Tokens(), { it => insideParentContext(it.macroIdentifier) })
}

/**
 *
 * The macro only add inner macro @Attribute to outer macro Test.
 * It can skip the func to execute.
 * If attr is the true identifier, it is same with {@codeSkip()}.
 * If attr is other tokens, it is Ineffective.
 * @since 0.17.3
 * @see Test
 *
 * @throws MacroException if input is not ClassDecl or FuncDecl.
 */
public macro Skip(attr: Tokens, input: Tokens): Tokens {
    let tokens = match {
        case compareTokens(attr, true.toTokens()) => ()
        case compareTokens(attr, false.toTokens()) =>
            return input
        case _ => throw MacroException("@Skip can only be used with true or false")
    }
    return topLevelMacroDriver(SKIP_MACRO, input, Tokens(), { it => insideParentContext(it.macroIdentifier) })
}
