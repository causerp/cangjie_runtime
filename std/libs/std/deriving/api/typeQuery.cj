/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
protected package std.deriving.api

import std.ast.*

public interface GenericsInjector {
    /**
     * Add generic arguments to an interface qualified name. Constrained type could be a target class itself
     * or it's generic parameter.
     */
    func injectGenerics(
        iface: QualifiedName,
        constrainedType: TypeNode,
        target: DerivingTarget): TypeNode

    func constraintsFor(
        iface: QualifiedName,
        generic: GenericDecl,
        target: DerivingTarget
    ): Array<GenericConstraint> {
        let upperBound = injectGenerics(iface, generic.toType(), target)
        let constraint = GenericConstraint()
        constraint.typeArgument = generic.toType()
        constraint.upperBound = Token(TokenKind.UPPERBOUND, "<:")
        constraint.upperBounds.add(upperBound)
        return [constraint]
    }

    static func noGenerics(): GenericsInjector  { DefaultGenreicInjector() }
    static func singleRecursive(): GenericsInjector { RecursiveGenericInjector() }
}

public struct DerivingInterfaceInfo {
    public DerivingInterfaceInfo(
        public let name: QualifiedName,
        public let superTypes: Array<QualifiedName>,
        public let genericsInjector: GenericsInjector
    ) {}
}

struct DefaultGenreicInjector <: GenericsInjector {
    public func injectGenerics(
        input: QualifiedName,
        _: TypeNode,
        _: DerivingTarget): TypeNode {
            return input.toType()
    }
}

struct RecursiveGenericInjector <: GenericsInjector {
    public func injectGenerics(
        iface: QualifiedName,
        constrainedType: TypeNode,
        _: DerivingTarget): TypeNode {
            return iface.toType(constrainedType)
    }
}
