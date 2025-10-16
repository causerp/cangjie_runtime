/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

macro package std.unittest.testmacro

import std.ast.*

public macro BeforeAll(input: Tokens) {
    return topLevelMacroDriver(BEFORE_ALL_MACRO, input, Tokens(), { it => insideParentContext(it.macroIdentifier) })
}

public macro AfterAll(input: Tokens) {
    return topLevelMacroDriver(AFTER_ALL_MACRO, input, Tokens(), { it => insideParentContext(it.macroIdentifier) })
}

public macro BeforeEach(input: Tokens) {
    return topLevelMacroDriver(BEFORE_EACH_MACRO, input, Tokens(), { it => insideParentContext(it.macroIdentifier) })
}

public macro AfterEach(input: Tokens) {
    return topLevelMacroDriver(AFTER_EACH_MACRO, input, Tokens(), { it => insideParentContext(it.macroIdentifier) })
}
