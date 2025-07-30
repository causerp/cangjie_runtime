/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/**
 * @file The file declares the macro Test.
 */
macro package std.unittest.testmacro

import std.ast.*

/**
 * The macro can be only defined at class or top-level func.
 * The macro expand to TestCase and Parses attributes passed by  macros.
 * It will delegate CasesFilterChain to integrate them.
 *
 * @since 0.17.3
 * @see Test
 * @see TestCase
 * @see CasesFilterChain
 *
 * @throws MacroException if input is not ClassDecl or FuncDecl.
 * @throws IllegalArgumentException if input is ClassDecl and found PrimaryCtorDecl in class body,
 * and the block of PrimaryCtorDecl body returns a None value.
 */
public macro Test(input: Tokens): Tokens {
    return topLevelMacroDriver(TEST_MACRO, input, Tokens(), { it => insideParentContext(it.macroIdentifier) })
}

public macro Test(dsl: Tokens, input: Tokens): Tokens {
    return topLevelMacroDriver(TEST_MACRO, input, dsl, { it => insideParentContext(it.macroIdentifier) })
}
