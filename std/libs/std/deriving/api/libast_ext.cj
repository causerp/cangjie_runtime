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

public interface AstExt {
    func appendSuperTypes(types: Iterable<TypeNode>): Unit
    func appendConstraints(constraints: Iterable<GenericConstraint>): Unit
    func appendFunction(f: FuncDecl): Unit
    func appendFunction(q: Tokens): FuncDecl
}

public interface DeclExt {
    mut prop modifiers: ArrayList<Modifier>

    func hasModifier(kind: TokenKind): Bool {
        modifiers.iterator().any { mod => mod.keyword.kind == kind }
    }

    func hasModifier(predicate: (TokenKind) -> Bool): Bool {
        modifiers.iterator().any { mod => predicate(mod.keyword.kind) }
    }

    func isStatic(): Bool {
        hasModifier(TokenKind.STATIC)
    }

    func isPrivate(): Bool {
        hasModifier(TokenKind.PRIVATE)
    }

    func unwrap(): Decl
}

public interface BodyExt {
    func declsUnwrapped(): Iterator<Decl>
}

public interface FuncParamExt {
    func unwrapParam(): FuncParam
}

public interface FunctionExt {
    func funcParamsUnwrapped(): Iterator<FuncParam>
}

extend Decl <: DeclExt {
    public func unwrap(): Decl {
        match (this) {
            case makro: MacroExpandDecl => try { makro.macroInputDecl } catch (_) { this }
            case makro: MacroExpandParam => try { makro.macroInputDecl } catch (_) { this }
            case makro: MacroExpandExpr => this // there is no accessor for the underlying decl
            case _ => this
        }
    }
}

extend Body <: BodyExt {
    public func declsUnwrapped(): Iterator<Decl> {
        decls.iterator().map(unwrapChild)
    }

    private static func unwrapChild(decl: Decl): Decl {
        decl.unwrap()
    }
}

extend FuncParam <: FuncParamExt {
    public func unwrapParam(): FuncParam {
        match (this) {
            case makro: MacroExpandParam => (makro.macroInputDecl as FuncParam) ?? this
            case _ => this
        }
    }
}

extend FuncDecl <: FunctionExt {
    public func funcParamsUnwrapped(): Iterator<FuncParam> {
        funcParams.iterator().map { p => p.unwrapParam() }
    }
}

extend PrimaryCtorDecl <: FunctionExt {
    public func funcParamsUnwrapped(): Iterator<FuncParam> {
        funcParams.iterator().map { p => p.unwrapParam() }
    }
}

extend ExtendDecl <: AstExt {
    public func appendFunction(f: FuncDecl): Unit {
        body.decls.add(f)
    }

    public func appendFunction(q: Tokens): FuncDecl {
        let f = FuncDecl(q)
        appendFunction(f)
        return f
    }

    public func appendSuperTypes(types: Iterable<TypeNode>): Unit {
        let iter = types.iterator()
        if (let Some(first) <- iter.next()) {
            ensureUpperBoundKeyword()
            superTypes.add(first)
        }

        while (let Some(next) <- iter.next()) {
            superTypes.add(next)
        }
    }

    /**
     * Append constraints to the extend block possibly mutating the first constraint
     * injecting "where" keyword if needed.
     */
    public func appendConstraints(constraints: Iterable<GenericConstraint>): Unit {
        let iter = constraints.iterator()
        if (let Some(first) <- iter.next()) {
            ensureWhereKeyword(first)
            genericConstraint.add(first)
        } else {
            return
        }

        while (let Some(next) <- iter.next()) {
            this.genericConstraint.add(next)
        }
    }

    private func ensureWhereKeyword(first: GenericConstraint): Unit {
        if (genericConstraint.isEmpty()) {
            ensureWhereKeywordAt(first)
        }
    }

    private static func ensureWhereKeywordAt(g: GenericConstraint): Unit {
        if (g.keyword.kind != TokenKind.WHERE) {
            g.keyword = Token(TokenKind.WHERE, "where")
        }
    }

    private func ensureUpperBoundKeyword(): Unit {
        if (this.upperBound.kind != TokenKind.UPPERBOUND) {
            this.upperBound = Token(TokenKind.UPPERBOUND, "<:")
        }
    }
}

public func joinTokens(
    prefix!: ToTokens = Tokens(),
    postfix!: ToTokens = Tokens(),
    delimiter!: ToTokens = Tokens(),
    ifEmpty!: ToTokens = prefix.toTokens() + postfix.toTokens()
): (Iterable<Tokens>) -> Tokens {{ it: Iterable<Tokens> =>
    let result = Tokens()

    result.append(prefix.toTokens())
    let iter = it.iterator()

    if (let Some(first) <- iter.next()) {
        result.append(first)
    } else {
        return ifEmpty.toTokens()
    }

    if (let Some(more) <- iter.next()) {
        let delimiter = delimiter.toTokens()
        result.append(delimiter)
        result.append(more)

        while (let Some(next) <- iter.next()) {
            result.append(delimiter)
            result.append(next)
        }
    }

    result.append(postfix.toTokens())

    return result
}}
