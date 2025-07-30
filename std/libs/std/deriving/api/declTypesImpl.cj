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

extend DerivingTarget {
    public prop isNonFinal: Bool {
        get() {
            ifClass { clazz =>
                clazz.hasModifier { kind =>
                    kind == TokenKind.OPEN ||
                    kind == TokenKind.ABSTRACT ||
                    kind == TokenKind.SEALED
                }
            }
        }
    }

    public prop isFinal: Bool {
        get() { !isNonFinal }
    }

    public prop isSealedClass: Bool {
        get() {
            ifClass { clazz =>
                clazz.hasModifier(TokenKind.SEALED)
            }
        }
    }

    public prop isAbstractClass: Bool {
        get() {
            ifClass { clazz =>
                clazz.hasModifier(TokenKind.ABSTRACT)
            }
        }
    }

    public prop allGenerics: Array<GenericDecl> {
        get() {
            let generics = generics() ?? return []
            generics.parameters |>
                filter { t: Token => t.kind == TokenKind.IDENTIFIER } |>
                map { t: Token => GenericDecl(t) } |>
                collectArray
        }
    }

    public prop hasAnyGenerics: Bool {
        get() {
            let generics = generics() ?? return false
            if (generics.parameters.iterator().next().isSome()) {
                return true
            }
            return false
        }
    }

    public prop superTypes: Array<TypeNode> {
        get() {
            match (declaration) {
                case clazz: ClassDecl => clazz.superTypes.toArray()
                case str: StructDecl => str.superTypes.toArray()
                case e: EnumDecl => e.superTypes.toArray()
                case _ => []
            }
        }
    }

    public prop superTypeNames: Array<QualifiedName> {
        get() {
            superTypes |> map<TypeNode, ?QualifiedName> { superType =>
                match (superType) {
                    case ref: RefType => Some(QualifiedName(ref.identifier))
                    case q: QualifiedType => Some(QualifiedName(q))
                    case _ => Option<QualifiedName>.None
                }
            } |>
            filter { it: ?QualifiedName => it.isSome() } |>
            map { it: ?QualifiedName => it.getOrThrow() } |>
            collectArray
        }
    }

    public func toType(): TypeNode {
        let result = RefType(Tokens(declaration.identifier))
        result.typeArguments = allGenerics |> map<GenericDecl, TypeNode> { g =>
            g.toType()
        } |> collectArrayList
        return result
    }

    func ifClass(predicate: (ClassDecl) -> Bool): Bool {
        match (declaration) {
            case clazz: ClassDecl => predicate(clazz)
            case _ => false
        }
    }

    func generics(): ?GenericParam {
        if (declaration.isGenericDecl) { declaration.genericParam } else { return None }
    }
}

extend TargetNamedAttribute {
    public prop decl: Decl {
        get() {
            match (this) {
                case FieldAttribute(v) => v
                case ConstructorFieldAttribute(f) => f
                case PropertyAttribute(p) => p
            }
        }
    }

    public prop identifier: Identifier {
        get() {
            Identifier(decl.identifier)
        }
    }

    public prop typeNode: ?TypeNode {
        get() {
            match (this) {
                case FieldAttribute(v) where v.colon.kind == TokenKind.COLON => v.declType
                case ConstructorFieldAttribute(c) => c.paramType
                case PropertyAttribute(p) => p.declType
                case _ => None
            }
        }
    }
}

extend TargetNamedAttribute <: ToString {
    public func toString(): String {
        identifier.value
    }
}

extend TargetEnumCase {
    public prop totalArgumentsCount: Int64 {
        get() { constructor.typeArguments.size }
    }

    public prop components: Array<?TargetEnumField> {
        get() {
            let result = Array<?TargetEnumField>(totalArgumentsCount, repeat: None)
            for (field in fields) {
                result[field.position] = field
            }
            return result
        }
    }
}

extend GenericDecl {
    public func toType(): RefType {
        RefType(identifier.toTokens())
    }
}

extend Identifier {
    public func toType(): RefType {
        RefType(toTokens())
    }
}
