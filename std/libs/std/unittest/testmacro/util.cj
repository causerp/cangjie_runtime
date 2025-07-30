/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
macro package std.unittest.testmacro

import std.ast.*
import std.collection.ArrayList

extend Array<TokenKind> {
    func containsKind(target: TokenKind): Bool {
        for (kind in this where kind == target) {
            return true
        }
        false
    }
}

extend<T> ArrayList<T> {
    func find(predicate: (T) -> Bool): ?T {
        for (x in this where predicate(x)) {
            return x
        }
        None
    }

    func contains(predicate: (T) -> Bool): Bool {
        this.find(predicate).isSome()
    }
}

extend Tokens {
    func contains(predicate: (Token) -> Bool): Bool {
        for (token in this where predicate(token)) {
            return true
        }
        false
    }
}

extend FuncDecl {
    func isAbstract(): Bool {
        // Abuse the fact that ASTlib fakes curly braces that way.
        this.block.lBrace == this.block.rBrace
    }
}
