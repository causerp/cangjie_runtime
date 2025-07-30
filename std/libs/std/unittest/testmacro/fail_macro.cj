/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
macro package std.unittest.testmacro

import std.ast.*

/*
 * The macro immediately fails the test.
 */
public macro Fail(message: Tokens): Tokens {
    match (message.size == 0) {
        case true => throw MacroException("@Fail: Fail message should be specified.")
        case false where insideParentContext("CustomAssertion") => quote($macroCtxVarname.fail($message))
        case _ => quote(fail($message))
    }
}

/*
 * The macro NOT immediately fails the test.
 */
public macro FailExpect(message: Tokens): Tokens {
    match (message.size == 0) {
        case true => throw MacroException("@FailExpect: Fail message should be specified.")
        case false where insideParentContext("CustomAssertion") => quote($macroCtxVarname.failExpect($message))
        case _ => quote(failExpect($message))
    }
}
