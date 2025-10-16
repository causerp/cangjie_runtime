/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
macro package std.unittest.testmacro

import std.ast.*

public macro TestTemplate(input: Tokens): Tokens {
    return topLevelMacroDriver(TEST_TEMPLATE_MACRO, input, Tokens(), { it => insideParentContext(it.macroIdentifier) })
}

public macro TestTemplate(dsl: Tokens, input: Tokens): Tokens {
    return topLevelMacroDriver(TEST_TEMPLATE_MACRO, input, dsl, { it => insideParentContext(it.macroIdentifier) })
}
