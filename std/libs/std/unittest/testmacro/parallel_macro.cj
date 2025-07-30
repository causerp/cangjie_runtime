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
 * This macro can be defined at test class and means that:
 * - All test cases are independent and can be run in parallel in separate processes.
 * - beaforeAll() initialization and afterAll() cleanup are reentrant and can be run in parallel in separate processes.
 *
 * @since 0.17.3
 * @see Test
 * @see TestCase
 * @see TestCases
 *
 * @throws MacroException if input is not ClassDecl or FuncDecl.
 */
public macro Parallel(input: Tokens): Tokens {
    return topLevelMacroDriver(PARALLEL_MACRO, input, Tokens(), { it => insideParentContext(it.macroIdentifier) })
}
