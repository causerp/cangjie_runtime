/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
protected package std.deriving.impl

import std.deriving.api.Identifier
import std.ast.*
import std.collection.*

func collectHashMap<K, V>(it: Iterable<(K, V)>): HashMap<Identifier, V> where K <: Decl {
    let map = HashMap<Identifier, V>()

    for ((decl, value) in it) {
        map.add(Identifier(decl.identifier), value)
    }

    return map
}

func associateBy<T>(key: (T) -> Identifier): (Iterable<T>) -> HashMap<Identifier, T> {{ it =>
    let map = HashMap<Identifier, T>()

    for (decl in it) {
        map.add(key(decl), decl)
    }

    return map
}}

func filterIsInstance<F, T>(it: Iterable<F>): Iterable<T> {
    it |> mapNotNone<F, T> { it => it as T }
}

func mapNotNone<F, T>(mapper: (F) -> ?T): (Iterable<F>) -> Iterable<T> {{ it: Iterable<F> =>
    MapNotNoneIterable(it, mapper)
}}

struct MapNotNoneIterable<F, T> <: Iterable<T> {
    MapNotNoneIterable(
        private let source: Iterable<F>,
        private let mapper: (F) -> ?T
    ) {}

    public func iterator(): Iterator<T> {
        MapNotNoneIterator(source.iterator(), mapper)
    }
}

class MapNotNoneIterator<F, T> <: Iterator<T> {
    MapNotNoneIterator(
        private let source: Iterator<F>,
        private let mapper: (F) -> ?T
    ) {}

    public func next(): ?T {
        while (let Some(input) <- source.next()) {
            if (let Some(result) <- mapper(input)) {
                return Some(result)
            }
        }
        return None
    }
}

func collectTokens(iterator: Iterable<Token>): Tokens {
    Tokens(iterator |> collectArray)
}
