/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
protected package std.deriving.api

import std.ast.*

public struct Identifier <: ToString & Equatable<Identifier> & Hashable & ToTokens {
    public Identifier(
        public let token: Token
    ) {
        if (token.kind != TokenKind.IDENTIFIER) {
            throw IllegalArgumentException("Expected identifier")
        }
    }

    public init(str: String) {
        this(Token(TokenKind.IDENTIFIER, str))
    }

    public prop value: String {
        get() { token.value }
    }

    public func toString(): String {
        value
    }

    public operator func ==(other: Identifier): Bool {
        value == other.value
    }

    public operator func !=(other: Identifier): Bool {
        value != other.value
    }

    public func hashCode(): Int64 {
        value.hashCode()
    }

    public func toTokens(): Tokens {
        Tokens(token)
    }
}
