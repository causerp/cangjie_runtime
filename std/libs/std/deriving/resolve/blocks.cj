/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
protected package std.deriving.resolve

import std.deriving.api.*
import std.ast.*
import std.collection.*

public func resolveFields(decl: ClassDecl): Array<(VarDecl, ?TypeNode)> {
    resolveFields(decl.body)
}

public func resolveFields(decl: StructDecl): Array<(VarDecl, ?TypeNode)> {
    resolveFields(decl.body)
}

func resolveFields(body: Body): Array<(VarDecl, ?TypeNode)> {
    let classScope = Scope(None, kind: ClassLikeScope)
    bodyDecl(body, classScope)

    body.declsUnwrapped() |>
        map<Decl, ?VarDecl> { d => d as VarDecl } |>
        filter<?VarDecl> { v => v.isSome() } |>
        map<?VarDecl, VarDecl> { d => d.getOrThrow() } |>
        map<VarDecl, (VarDecl, ?TypeNode)> { v =>
            (v, classScope.lookup(v.identifier).resolvedType)
        } |> collectArray
}

func blockType(block: Block, scope: Scope): TypeNode {
    let blockScope = Scope(scope) // not func scope
    flow(block.nodes, blockScope)
    return blockScope.scopeType
}

func callType(call: CallExpr, scope: Scope): ?TypeNode {
    match (constExprType(call.callFunc, scope)) {
        case Some(f: FuncType) => return f.returnType
        case _ => ()
    }

    match (call.callFunc) {
        case member: MemberAccess => memberAccess(member, scope)
        case ref: RefExpr where isSome(ref) =>
            let item = constExprType(call.arguments[0].expr, scope) ?? return None
            return myParseType(quote(Option<$item>))
        case _ => return None
    }
}

func spawnType(s: SpawnExpr, scope: Scope): ?TypeNode {
    let t = lambdaType(s.lambdaExpr, scope) ?? return None
    let funcType = t as FuncType ?? return None
    let resultType = funcType.returnType
    return myParseType(quote(Future<$resultType>))
}

func flow(nodes: Iterable<Node>, blockScope: Scope): Unit {
    var lastExprType: ?TypeNode = None

    for (node in nodes) {
        match (node) {
            case v: VarDecl => varDecl(v, blockScope)
            case f: FuncDecl => funcDecl(f, blockScope)
            case ctor: PrimaryCtorDecl => constructorDecl(ctor, blockScope)
            case e: Expr => lastExprType = constExprType(e, blockScope)
            case _ => ()
        }
    }

    if (let Some(t) <- lastExprType) {
        blockScope.appendScopeType(t)
    }
}

public func bodyDecl(body: Body, classScope: Scope): Unit {
    for (decl in body.declsUnwrapped()) {
        match (decl) {
            case v: VarDecl => varDecl(v, classScope)
            case p: PrimaryCtorDecl => constructorDecl(p, classScope)
            case p: PropDecl => propDecl(p, classScope)
            case _ => ()
        }
    }

    if (classScope.allInvalids.isEmpty()) {
        return
    }

    func isInit(f: FuncDecl): Bool {
        f.identifier.kind == TokenKind.INIT ||
            (f.identifier.kind == TokenKind.IDENTIFIER && f.identifier.value == "init")
    }

    for (decl in body.declsUnwrapped()) {
        match (decl) {
            case f: FuncDecl where f.isStatic() || isInit(f) => funcDecl(f, classScope)
            case p: PrimaryCtorDecl => constructorDecl(p, classScope)
            case p: PropDecl => propDecl(p, classScope)
            case _ => ()
        }
    }

    if (classScope.allInvalids.isEmpty()) {
        return
    }

    for (decl in body.declsUnwrapped()) {
        match (decl) {
            case v: VarDecl => varDecl(v, classScope)
            case p: PrimaryCtorDecl => constructorDecl(p, classScope)
            case f: FuncDecl where isInit(f) => funcDecl(f, classScope)
            case p: PropDecl => propDecl(p, classScope)
            case _ => ()
        }
    }
}

func constructorDecl(c: PrimaryCtorDecl, parent: Scope): Unit {
    let scope = Scope(parent, kind: FuncScope)
    scope.appendParams(c.funcParams)
    flow(c.block.nodes, scope)
}

func funcDecl(f: FuncDecl, parent: Scope): Unit {
    let returnType = if (f.colon.kind == TokenKind.COLON) {
        f.declType
    } else {
        let scope = Scope(parent, kind: FuncScope)
        scope.appendParams(f.funcParams)
        flow(f.block.nodes, scope)
        scope.scopeType
    }

    let funcType = FuncType()
    funcType.returnType = returnType
    funcType.types = f.funcParams |>
        map<FuncParam, TypeNode> { p => p.paramType } |>
        collectArrayList
    parent.append(Identifier(f.identifier), funcType)
}

extend Scope {
    func appendParams(funcParams: Iterable<FuncParam>): Unit {
        let parent = root
        for (p in funcParams) {
            append(p, parent)
        }
    }

    private func append(p: FuncParam, parent: ?Scope): Unit {
        if (p.identifier.kind == TokenKind.IDENTIFIER) {
            let id = Identifier(p.identifier)
            append(id, p.paramType)
            if (p.isMemberParam()) {
                if (let Some(parent) <- parent) {
                    parent.append(id, p.paramType)
                }
            }
        }
    }
}

func varDecl(a: VarDecl, scope: Scope): Unit {
    if (a.identifier.kind != TokenKind.IDENTIFIER) {
        return
    }

    let varType: ?TypeNode = if (a.hasType) {
        a.declType
    } else if (a.hasExpr) {
        if (let Some(t) <- constExprType(a.expr, scope)) {
            t
        } else {
            None
        }
    } else {
        None
    }

    let id = Identifier(a.identifier)
    if (let Some(varType) <- varType) {
        scope.append(id, varType)
    } else {
        scope.append(id)
    }
}

func propDecl(p: PropDecl, scope: Scope): Unit {
    if (let Some(root) <- scope.root) {
        root.append(Identifier(p.identifier), p.declType)
    }

    if (p.modifiers |> none<Modifier> { m => m.keyword.kind == TokenKind.MUT }) {
        return
    }

    let setter: ?FuncDecl = try { p.setter } catch (_) { None }
    if (let Some(setter) <- setter) {
        propSetter(p, setter, scope)
    }
}

func propSetter(p: PropDecl, setter: FuncDecl, scope: Scope): Unit {
    let newScope = Scope(scope, kind: FuncScope)
    if (setter.funcParams.size != 1) {
        return
    }

    let param = setter.funcParams[0].identifier
    newScope.append(Identifier(param), p.declType)
    flow(setter.block.nodes, newScope)
}

func assign(assign: AssignExpr, scope: Scope): Unit {
    let target = assign.leftExpr
    if (target is WildcardExpr) {
        return
    }

    let expressionType = constExprType(assign.rightExpr, scope) ?? return;

    if (let Some(result) <- assign.leftExpr.isFieldAccess(scope)) {
        if (let Some(targetScope) <- result.scope) {
            targetScope.append(result.id, expressionType)
        } else {
            scope.append(result.id, expressionType)
        }
    }
}

func memberAccess(member: MemberAccess, scope: Scope): ?TypeNode {
    if (let Some(item) <- extractOptionType(member)) {
        return item
    }
    if (let Some(result) <- member.isFieldAccess(scope)) {
        return result.resolvedType
    }

    return None
}

func memberAccess(ref: RefExpr, scope: Scope): ?TypeNode {
    match (scope.lookup(ref.identifier)) {
        case Unresolved(_) => None
        case InvalidType(_, _) => None
        case ResolvedType(_, resolvedType, _) => resolvedType
    }
}

func extractOptionType(member: MemberAccess): ?TypeNode {
    match (member.baseExpr) {
        case ref: RefExpr where isOption(ref) &&
            !ref.typeArguments.isEmpty() =>
            let itemType = ref.typeArguments[0]
            let t = myParseType(quote(Option<$itemType>))

            if (isSome(member.field)) {
                funcReturning(t)
            } else if (isNone(member.field)) {
                t
            } else {
                None
            }
        case _ => None
    }
}

func funcReturning(t: TypeNode): FuncType {
    let f = FuncType()
    f.returnType = t
    return f
}

func isSome(ref: RefExpr): Bool {
    ref.typeArguments.isEmpty() &&
        ref.identifier.kind == TokenKind.IDENTIFIER &&
        ref.identifier.value == "Some"
}

func isSome(t: Token): Bool {
    t.kind == TokenKind.IDENTIFIER && t.value == "Some"
}

func isNone(t: Token): Bool {
    t.kind == TokenKind.IDENTIFIER && t.value == "None"
}

func isOption(ref: RefExpr): Bool {
    ref.identifier.kind == TokenKind.IDENTIFIER &&
    ref.identifier.value == "Option"
}
