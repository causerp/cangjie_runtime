/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
protected package std.deriving.api

import std.ast.*
import std.collection.*
import std.unicode.*

/**
 * Represents a qualified name consisting of one or more identifiers (components)
 * separated with dots. It doesn't include generics.
 */
public struct QualifiedName <: ToString & Equatable<QualifiedName> & Hashable {
    private QualifiedName(
        public let name: String,
        public let tokens: Array<Token>
    ) {
        if (tokens.isEmpty()) {
            throw IllegalArgumentException("Qualified name shouldn't be empty")
        }
    }

    public init(tokens: Array<Token>) {
        this(tokens |> join, tokens)

        if (let Some(bad) <- (tokens |> filter<Token> { t => t.kind != TokenKind.IDENTIFIER } |> first)) {
            throw IllegalArgumentException("All tokens should be identifiers, found: ${bad.value} (kind: ${bad.kind})")
        }
    }

    public init(
        name: String
    ) {
        this(name.lazySplit("."))
        validate(name)
    }

    private init(name: Iterable<String>) {
        tokens = name |> map<String, Token> { part =>
            Token(TokenKind.IDENTIFIER, part)
        } |> collectArray
        this.name = tokens |> join
    }

    public init(qType: QualifiedType) {
        tokens = QualifiedType.toNameImpl(qType)
        name = tokens |> join
    }

    public init(simpleName: Identifier) {
        tokens = [simpleName.token]
        name = simpleName.value
    }

    static func createUnchecked(tokens: Array<Token>) {
        return QualifiedName(tokens |> join, tokens)
    }

    /**
     * Last component or the whole name if there are no dots
     */
    public prop simpleName: Token {
        get() {
            tokens[tokens.size - 1]
        }
    }

    /**
     * Creates a "qualified instance" from the simple name.
     * This is only used to woraround problem of missing fully qualified
     * references in Cangjie
     */
    public func toSimpleNameQN(): QualifiedName {
        QualifiedName(simpleName)
    }

    /**
     * Qualified name components
     */
    public prop components: Array<String> {
        get() {
            tokens |> map<Token, String> { t => t.value } |> collectArray
        }
    }

    public operator func +(other: QualifiedName): QualifiedName {
        let sum = tokens |> concat(other.tokens) |> collectArray
        return QualifiedName.createUnchecked(sum)
    }

    public operator func +(other: String): QualifiedName {
        this + QualifiedName(other)
    }

    public operator func +(other: Token): QualifiedName {
        let sum = tokens |> concat([other]) |> collectArray
        return QualifiedName.createUnchecked(sum)
    }

    public operator func +(other: Identifier): QualifiedName {
        return this + other.token
    }

    public override func toString(): String {
        name
    }

    public override operator func ==(other: QualifiedName) {
        name == other.name
    }

    public override operator func !=(other: QualifiedName) {
        name != other.name
    }

    public override func hashCode(): Int64 {
        name.hashCode()
    }

    private static func join(tokens: Iterable<Token>): String {
        tokens |> map<Token, ToString> { t => t.value } |> collectString(delimiter: ".")
    }

    private static func validate(name: String): Unit {
        if (name.isEmpty()) {
            throw IllegalArgumentException("name shouldn't be empty")
        }
        var empty = true
        for (rune in name.runes()) {
            if (rune == r'.') {
                if (empty) {
                    break
                }
                empty = true
            } else if (rune.isWhiteSpace()) {
                throw IllegalArgumentException("Whitespaces in qualified names are not allowed")
            } else {
                empty = false
            }
        }
        if (empty) {
            throw IllegalArgumentException("Qualified name shouldn't contain empty components")
        }
    }
}

extend QualifiedName {
    public func toType(genericArgs: Array<TypeNode>): TypeNode {
        let it = tokens.iterator()
        let first = refTypeFor(it.next().getOrThrow())
        match (it.next()) {
            case Some(second) =>
                let tail = toTypeLoop(concat(first, second), it)
                tail.appendGenerics(genericArgs)
                return tail
            case None =>
                first.appendGenerics(genericArgs)
                return first
        }
    }

    private static func toTypeLoop(head: QualifiedType, tail: Iterator<Token>): QualifiedType {
        tail |> fold<Token, QualifiedType>(head) { base, component =>
            concat(base, component)
        }
    }

    private static func concat(base: TypeNode, next: Token): QualifiedType {
        let q = QualifiedType()
        q.baseType = base
        q.identifier = next
        return q
    }

    private static func refTypeFor(id: Token): RefType {
        let ref = RefType()
        ref.identifier = id
        return ref
    }
}

extend QualifiedType {
    static func toNameImpl(head: QualifiedType): Array<Token> {
        let components = ArrayList<Token>()
        var current = head
        while (true) {
            components.add(current.identifier)
            match (current.baseType) {
                case q: QualifiedType => current = q
                case s: RefType =>
                    components.add(s.identifier)
                    break
                case t: ThisType =>
                    components.add(t.keyword)
                    break
                case _ => throw IllegalArgumentException("Unsupported qualified type")
            }
        }

        components.reverse()
        return components.toArray()
    }
}
