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

public interface DerivingNode <: AstExt {
    func appendAllConstraints(
        deriving: Deriving,
        target: DerivingTarget,
        iface: QualifiedName
    ): Unit

    func appendAllConstraintsTo(
        deriving: DerivingTarget,
        ifaceInfo: DerivingInterfaceInfo,
        settings: ?DerivingInterfaceSettings
    ): Unit
}

extend DerivingTarget {
    public func createExtendSkeleton(): ExtendDecl {
        let generics = if (this.declaration.isGenericDecl) {
            declaration.genericParam.toTokens()
        } else {
            Tokens()
        }

        let targetType = toType()
        let e = parseDecl(quote(
            extend $generics $targetType {
            }
        )) as ExtendDecl ?? throw Exception()

        return e
    }

    func appendAllConstraintsTo(
        ext: ExtendDecl,
        deriving: Deriving,
        iface: QualifiedName
    ): Unit {
        let ifaceInfo = deriving.queryInterfaceInfo(iface)
        let settings = findIntefaceSettings(iface)
        appendAllConstraintsTo(ext, ifaceInfo, settings)
    }

    func appendAllConstraintsTo(
        ext: ExtendDecl,
        ifaceInfo: DerivingInterfaceInfo,
        settings: ?DerivingInterfaceSettings
    ): Unit {
        ext.appendSuperTypes([upperBoundForExtend(ifaceInfo)])
        ext.appendConstraints(genericConstraints(ifaceInfo, settings))
    }

    public func upperBoundForExtend(
        iface: DerivingInterfaceInfo
    ): TypeNode {
        iface.genericsInjector.injectGenerics(iface.name.toSimpleNameQN(), toType(), this)
    }

    public func genericConstraints(
        ifaceInfo: DerivingInterfaceInfo,
        settings: ?DerivingInterfaceSettings
    ): Iterable<GenericConstraint> {
        this.allGenerics |> flatMap<GenericDecl, GenericConstraint> { generic =>
            genericConstraints(generic, ifaceInfo.name, settings, ifaceInfo.genericsInjector)
        }
    }

    private func genericConstraints(
        generic: GenericDecl,
        iface: QualifiedName,
        ifaceSettings: ?DerivingInterfaceSettings,
        injector: GenericsInjector
    ): Iterable<GenericConstraint> {
        let explicit: ?DerivingGenericSettings = if (let Some(ifaceSettings) <- ifaceSettings) {
            ifaceSettings.generics |> filter { it: DerivingGenericSettings => it.generic == generic } |> first
        } else {
            None
        }

        let constraints = explicit ?? defaultGenericConstrtaints(generic, iface, injector)
        if (!constraints.hasUpperBounds) {
            return []
        }

        return [constraints.toNode()]
    }

    private func defaultGenericConstrtaints(
        generic: GenericDecl,
        iface: QualifiedName,
        injector: GenericsInjector
    ): DerivingGenericSettings {
        let upperBound = injector.injectGenerics(iface.toSimpleNameQN(), generic.toType(), this)
        return DerivingGenericSettings(generic, [upperBound])
    }
}

extend ExtendDecl <: DerivingNode {
    public func appendAllConstraints(
        deriving: Deriving,
        target: DerivingTarget,
        iface: QualifiedName
    ): Unit {
        target.appendAllConstraintsTo(this, deriving, iface)
    }

    public func appendAllConstraintsTo(
        target: DerivingTarget,
        ifaceInfo: DerivingInterfaceInfo,
        settings: ?DerivingInterfaceSettings
    ): Unit {
        target.appendAllConstraintsTo(this, ifaceInfo, settings)
    }
}
