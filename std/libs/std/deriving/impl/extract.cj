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
import std.collection.*

extend Decl {
    func generics(): Array<GenericDecl> {
        if (!isGenericDecl) {
            return []
        }

        return genericParam.parameters |> filter<Token> { t => t.kind == TokenKind.IDENTIFIER } |>
            map<Token, GenericDecl> { it =>
                GenericDecl(it)
            } |> collectArray
    }

    /*
     * Returns all named fields and property decls including constructor parameters
     * and possibly static
     */
    func allNamedDecls(): Iterator<Decl> {
        match (this) {
            case c: ClassDecl => c.allNamedDeclsImpl()
            case c: StructDecl => c.allNamedDeclsImpl()
            case en: EnumDecl => en.decls.iterator().filter { it => it is PropDecl }
            case _ => Array<Decl>().iterator()
        }
    }
}

interface ClassLikeDecl {
    mut prop body: Body

    func allFields(): Array<TargetNamedAttribute> {
        allNamedDeclsImpl().filter { member =>
            match (member) {
                case v: VarDecl where !v.isStatic() => true
                case fp: FuncParam => true
                case p: PropDecl where !p.isStatic() => true
                case _ => false
            }
        }.map { member =>
            match (member) {
                case v: VarDecl => TargetNamedAttribute.FieldAttribute(v)
                case fp: FuncParam => ConstructorFieldAttribute(fp)
                case p: PropDecl => PropertyAttribute(p)
                case _ => throw Exception()
            }
        } |> collectArray
    }

    func allNamedDeclsImpl(): Iterator<Decl> {
        body.declsUnwrapped().iterator().flatMap { member: Decl =>
            match (member) {
                case ctor: PrimaryCtorDecl => unwrapParams(ctor)
                case other where hasIdentifier(other) => [other].iterator()
                case _ => Array<Decl>().iterator()
            }
        }
    }

    func allProperties(): Array<PropDecl> {
        body.declsUnwrapped() |> filterIsInstance<Decl, PropDecl> |> collectArray
    }

    func allGenerics(): Array<GenericDecl>
}

private func unwrapParams(ctor: PrimaryCtorDecl): Iterator<Decl> {
    ctor.funcParamsUnwrapped()
        .filter { p => p.isMemberParam() }
        .map { f => f }
}

private func hasIdentifier(decl: Decl): Bool {
    let id = decl.identifier
    id.kind == TokenKind.IDENTIFIER && !id.value.isEmpty()
}

extend ClassDecl <: ClassLikeDecl {
    public func allGenerics(): Array<GenericDecl> {
        generics()
    }
}

extend StructDecl <: ClassLikeDecl {
    public func allGenerics(): Array<GenericDecl> {
        generics()
    }
}

extend EnumDecl {
    func allCases(): Array<TargetEnumCase> {
        constructors |> map { ctor: Constructor =>
            TargetEnumCase(ctor.identifier.value, ctor, argsToField(ctor.typeArguments))
        } |> collectArray
    }

    func allProperties(): Array<PropDecl> {
        decls |> filterIsInstance<Decl, PropDecl> |> collectArray
    }

    private static func argsToField(args: Iterable<TypeNode>): Array<TargetEnumField> {
        args |> enumerate |> map<(Int64, TypeNode), TargetEnumField> { pair =>
            let (index, node) = pair
            TargetEnumField(index, node)
        } |> collectArray
    }
}

func mapInterfaceSettings(
    genericDecls: Array<GenericDecl>,
    options: Array<DeriveInterfaceOption>,
    logger: Logger
): Array<DerivingInterfaceSettings> {
    options |> map { iface: DeriveInterfaceOption =>
        let generics = iface.constraints |> mapNotNone { c: ParsedGenericConstraint =>
            let decl = genericDecls.iterator().filter { it => it.identifier == c.genericParameter }.first()

            match (decl) {
                case Some(decl) => c.toDerivingGeneric(decl)
                case None =>
                    logger.error(c.genericParameter.token, "Generic parameter not found")
                    Option<DerivingGenericSettings>.None
            }
        } |> collectArray

        DerivingInterfaceSettings(iface.resolvedInterface, generics)
    } |> collectArray
}
