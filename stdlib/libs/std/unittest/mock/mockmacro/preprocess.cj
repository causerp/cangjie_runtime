/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
macro package std.unittest.mock.mockmacro

import std.ast.*

let tks = quote(any())

func preprocess(userInput: Tokens): Tokens {
    var result = Tokens()
    for (tok in userInput) {
        match (tok.kind) {
            case WILDCARD => result.append(quote($tks))
            case _ => result.append(tok)
        }
    }
    return result
}
