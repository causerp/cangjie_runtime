/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/**
 * @file The file declares the macro Bench.
 */
macro package std.unittest.testmacro

import std.ast.*

public macro Bench(input: Tokens): Tokens {
    return topLevelMacroDriver(BENCH_MACRO, input, Tokens(), { it => insideParentContext(it.macroIdentifier) })
}

/**
 *
 * The macro @Bench can only be used on a  `func` declared with the @Testcase macro inside a test class.
 * The `times` parameter in macro @Bench[times] can be used to specify the minimal benchmark iteration count, and
 * `times` muse be non-negative integer.
 * @since 0.17.3
 * @see Test
 *
 * @throws MacroException if attr is not digital or input is not FuncDecl.
 */
public macro Bench(attr: Tokens, input: Tokens): Tokens {
    /* for backwards compatibility */
    if (attr.size == 1 && attr.get(0).kind == TokenKind.INTEGER_LITERAL) {
        return topLevelMacroDriver(BENCH_MACRO, input, Tokens(), { it => insideParentContext(it.macroIdentifier) })
    } else {
        return topLevelMacroDriver(BENCH_MACRO, input, attr, { it => insideParentContext(it.macroIdentifier) })
    }
}
