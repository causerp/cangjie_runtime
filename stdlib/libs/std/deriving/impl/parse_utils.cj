/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
protected package std.deriving.impl

import std.deriving.api.*
import std.ast.*

class PushbackTokensIterator {
    PushbackTokensIterator(private let tokens: Tokens) {}

    private var index = 0

    func next(): ?Token {
        let index = index
        if (index < 0 || index >= tokens.size) {
            return None
        }
        this.index = index + 1
        return tokens[index]
    }

    func peek(): ?Token {
        let index = index
        if (index < 0 || index >= tokens.size) {
            return None
        }
        return tokens[index]
    }

    func seeing(kind: TokenKind): Bool {
        match (peek()) {
            case Some(t) where t.kind == kind => true
            case _ => false
        }
    }

    func pushback(): Unit {
        if (index <= 0) {
            throw IllegalStateException("Iterator is already at the beginning")
        }
        index--
    }

    func last(): ?Token {
        let lastIndex = tokens.size - 1
        if (lastIndex < 0) {
            return None
        }
        return tokens[lastIndex]
    }

    func mark(): Mark {
        return Mark(index)
    }

    func rewindTo(mark: Mark) {
        unsafe { rewindTo(mark.markedAt) }
    }

    unsafe func rewindTo(index: Int64) {
        if (index < 0 || index >= tokens.size) {
            throw IndexOutOfBoundsException()
        }
        this.index = index
    }

    func slice(start: Mark, until: Mark): Tokens {
        tokens[start.markedAt..until.markedAt]
    }
}

struct Mark {
    Mark(let markedAt: Int64) {
        if (markedAt < 0) {
            throw IllegalArgumentException("Mark position shouldn't be negative")
        }
    }
}
