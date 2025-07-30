/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/**
 * @file The file declares the macro Measure.
 */
macro package std.unittest.testmacro

import std.ast.*

/**
 *
 * The macro @Measure can only be used on a `class` or `top-level func` declared with the @Test macro.
 * Attributes format: @Measure[<Measurement1>, <Measurement2>, ...].
 * Accepted attributes: comma-separated non-empty list of Measurement instances.
 * @see Test
 * @see Bench
 *
 * @throws MacroException if attr is empty.
 */
public macro Measure(attr: Tokens, input: Tokens): Tokens {
    topLevelMacroDriver(MEASURE_MACRO, input, attr, { it => insideParentContext(it.macroIdentifier) })
}
