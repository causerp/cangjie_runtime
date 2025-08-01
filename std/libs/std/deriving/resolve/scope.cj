/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
protected package std.deriving.resolve

import std.deriving.api.Identifier
import std.ast.*
import std.collection.*

public enum ScopeResolveResult {
    | Unresolved(Identifier)
    | InvalidType(Identifier, Scope)
    | ResolvedType(Identifier, TypeNode, Scope)

    public prop resolvedType: ?TypeNode {
        get() { match (this) {
            case ResolvedType(_, t, _) => t
            case _ => None
        }}
    }

    public prop scope: ?Scope {
        get() {
            match (this) {
                case InvalidType(_, scope) => scope
                case ResolvedType(_, _, scope) => scope
                case Unresolved(_) => None
            }
        }
    }

    public prop id: Identifier {
        get() {
            match (this) {
                case InvalidType(id, _) => id
                case ResolvedType(id, _, _) => id
                case Unresolved(id) => id
            }
        }
    }
}

public enum ScopeKind {
    | FuncScope
    | ClassLikeScope
    | OtherScope
}

public class Scope <: Equatable<Scope> & ToString {
    private static var counter = 0
    private let memebers = HashMap<Identifier, TypeNode>()
    private let invalids = HashSet<Identifier>()
    private var scopeType_: ?TypeNode = None
    private let id: Int64

    public Scope(
        public let parent: ?Scope,
        public let kind!: ScopeKind = OtherScope
    ) {
        id = counter
        counter++
    }

    public func lookup(name: Identifier): ScopeResolveResult {
        match (memebers.get(name)) {
            case Some(resolved) => ResolvedType(name, resolved, this)
            case None where invalids.contains(name) => InvalidType(name, this)
            case None => match (parent) {
                case Some(parent) => parent.lookup(name)
                case None => Unresolved(name)
            }
        }
    }

    public func lookup(name: Token): ScopeResolveResult {
        return lookup(Identifier(name))
    }

    public func lookup(name: String): ScopeResolveResult {
        return lookup(Identifier(name))
    }

    public func append(name: Identifier): Unit {
        if (!memebers.contains(name)) {
            invalids.add(name)
        }
    }

    public func append(name: Identifier, t: TypeNode): Unit {
        memebers.addIfAbsent(name, t)
        invalids.remove(name)
    }

    public func appendScopeType(t: TypeNode): Unit {
        if (scopeType_.isNone()) {
            scopeType_ = t
            return
        }

        scopeType_ = unionApprox(scopeType_, t)
    }

    public prop root: ?Scope {
        get() {
            var scope = this
            while (!scope.isRoot) {
                scope = scope.parent ?? return None
            }
            return scope
        }
    }

    public prop funcScope: ?Scope {
        get() {
            var scope = this
            while (!scope.isFuncScope) {
                scope = scope.parent ?? return None
            }
            return scope
        }
    }

    public prop isRoot: Bool {
        get() { match (kind) {
            case ClassLikeScope => true
            case _ => false
        } }
    }

    public prop allInvalids: Array<Identifier> {
        get() {
            invalids |> collectArray
        }
    }

    prop isFuncScope: Bool {
        get() {
            match (kind) {
                case FuncScope => true
                case _ => false
            }
        }
    }

    public prop scopeType: TypeNode {
        get() { scopeType_ ?? Types.UnitType }
    }

    public override operator func ==(other: Scope): Bool {
        refEq(this, other)
    }

    public override operator func !=(other: Scope): Bool {
        !refEq(this, other)
    }

    public override func toString(): String {
        let items = allItems() |> map<(Identifier, TypeNode), ToString> { pair =>
            "${pair[0]}:${pair[1].toTokens()}"
        } |> collectString(delimiter: ", ")

        return "Scope(${id}, ${items})"
    }

    func parents(): Iterable<Scope> {
        let result = ArrayList<Scope>()
        var scope = this
        while (true) {
            result.add(scope)
            scope = scope.parent ?? break
        }
        return result
    }

    func allItems(): Iterable<(Identifier, TypeNode)> {
        parents() |> map<Scope, Iterable<(Identifier, TypeNode)>> { scope =>
            scope.memebers
        } |> flatten
    }
}
