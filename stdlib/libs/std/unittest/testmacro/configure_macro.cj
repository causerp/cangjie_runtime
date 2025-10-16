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
 * @Configure macro sets up configuration parameters for function or class
 * Usage: @Configure[param1: value1, param2: value2, param3: value3]
 * Each parameter name is a name of option defined in `@UnittestOption` macro or in unittest internals (case-sensitive).
 * Each value is any Cangjie expression supported by astlib.
 * In case if parameter is unknown (not registered via `@UnittestOption` or not defined in unittest internals)
 * the error about undeclared identifier will be thrown.
 * In case if type is invalid (e.g. not specified in `@UnittestOption`) the error about unsolvable types will be prined.
 * For a particular list of configuration options supported by different parts of the framework, please refer to those parts.
 * Macro can be repeated, in case of paramter duplication, up to type of value, last one will be selected.
 */
public macro Configure(args: Tokens, input: Tokens) {
    return topLevelMacroDriver(CONFIGURE_MACRO, input, args, { it => insideParentContext(it.macroIdentifier) })
}
