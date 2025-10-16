/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
protected package std.deriving.resolve

import std.ast.*

func myReduce<T>(combine: (T, T) -> T): (Iterable<T>) -> ?T {{ items =>
    let iterator = items.iterator()
    var current = iterator.next() ?? return None
    while (let Some(next) <- iterator.next()) {
        current = combine(next, current)
    }
    return current
}}

func unopt<T>(opt: Option<Option<T>>): Option<T> {
    opt ?? None
}

func myParseType(tokens: Tokens): TypeNode {
    let v = match (parseDecl(quote(let x: $tokens))) {
        case v: VarDecl => v
        case _ => throw Exception()
    }

    return v.declType
}
