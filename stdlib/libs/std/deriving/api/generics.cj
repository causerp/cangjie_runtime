/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
protected package std.deriving.api

import std.ast.*
import std.collection.ArrayList

public struct DerivingGenericSettings <: ToString & ToTokens {
    public DerivingGenericSettings(
        public let generic: GenericDecl,
        public let upperBounds: Array<TypeNode>
    ) {}

    public prop hasUpperBounds: Bool {
        get() { upperBounds.size > 0 }
    }

    public func toNode(): GenericConstraint {
        let node = GenericConstraint()
        node.typeArgument = generic.toType()
        node.upperBounds = ArrayList(upperBounds)
        return node
    }

    public func toTokens(): Tokens {
        toNode().toTokens()
    }

    public func toString(): String {
        toTokens().toString()
    }
}

public struct GenericDecl <: Equatable<GenericDecl> & Hashable & ToString {
    public GenericDecl(
        public let identifier: Identifier
    ) {}

    public init(identifier: Token) {
        this(Identifier(identifier))
    }

    public override operator func ==(other: GenericDecl): Bool {
        identifier.value == other.identifier.value
    }

    public override operator func !=(other: GenericDecl): Bool {
        identifier.value != other.identifier.value
    }

    public override func toString(): String {
        identifier.value
    }

    public override func hashCode(): Int64 {
        identifier.value.hashCode()
    }
}

interface AppendGenerics {
    func appendGenerics(args: Array<TypeNode>): Unit
}

extend RefType <: AppendGenerics {
    public func appendGenerics(args: Array<TypeNode>): Unit {
        lAngle = Token(TokenKind.LT, "<")
        rAngle = Token(TokenKind.GT, ">")
        typeArguments.add(all: args)
    }
}

extend QualifiedType <: AppendGenerics {
    public func appendGenerics(args: Array<TypeNode>): Unit {
        lAngle = Token(TokenKind.LT, "<")
        rAngle = Token(TokenKind.GT, ">")
        typeArguments.add(all: args)
    }
}
