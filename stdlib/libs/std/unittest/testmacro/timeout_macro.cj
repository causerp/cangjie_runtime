/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
macro package std.unittest.testmacro

import std.ast.*

/**
 * This macro can be defined at test case and enables timeout for it.
 * This macro can be defined at test class and enables timeout for every corresponding test case by default.
 * Timeout specified for the test case overlaps timeout specified for enclosing test class.
 *
 * This macro has a parameter that should be an expresion of type std.core.Duration.
 * If test case do not finish in the specified time, it is terminated.
 *
 * @since 0.17.3
 * @see Test
 * @see TestCase
 * @see TestCases
 * @see Duration
 *
 * @throws MacroException if input is not ClassDecl or FuncDecl.
 */
public macro Timeout(attrs: Tokens, input: Tokens): Tokens {
    return topLevelMacroDriver(TIMEOUT_MACRO, input, attrs, { it => insideParentContext(it.macroIdentifier) })
}
