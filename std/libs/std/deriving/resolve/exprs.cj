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
import std.convert.Parsable

public func expressionType(expression: Expr): ?TypeNode {
    constExprType(expression, Scope(None))
}

func constExprTypeOpt(expr: ?Expr, scope: Scope): ?TypeNode {
    match (expr) {
        case Some(expr) => constExprType(expr, scope)
        case None => None
    }
}

public func constExprType(expr: Expr, scope: Scope): ?TypeNode {
    match (expr) {
        case _: IsExpr => Types.BoolType
        case asExpr: AsExpr => asExpr.shiftType
        case par: ParenExpr => constExprType(par.parenthesizedExpr, scope)
        case lit: LitConstExpr => literalType(lit)
        case block: Block => blockType(block, scope)
        case ifExpr: IfExpr => ifType(ifExpr, scope)
        case matchExpr: MatchExpr => matchType(matchExpr, scope)
        case conv: TypeConvExpr => conv.targetType
        case pr: PrimitiveTypeExpr => typeByKeyword(pr.keyword)
        case array: ArrayLiteral => arrayType(array, scope)
        case tuple: TupleLiteral => tupleType(tuple, scope)
        case range: RangeExpr => rangeType(range, scope)
        case sub: SubscriptExpr => subscriptExpr(sub, scope)
        case t: TryExpr =>
            if (t.resourceSpec.isEmpty()) {
                blockType(t.tryBlock, scope)
            } else {
                Types.UnitType
            }
        case _: QuoteExpr => Types.TokensType
        case _: QuoteToken => Types.TokensType
        case v: VArrayExpr => v.vArrayType
        case call: CallExpr => callType(call, scope)
        case member: MemberAccess => memberAccess(member, scope)
        case ref: RefExpr => memberAccess(ref, scope)
        case th: ThrowExpr => Types.NothingType
        case r: ReturnExpr =>
            visitReturn(scope, r)
            Types.NothingType
        case _: ForInExpr => Types.UnitType
        case _: WhileExpr => Types.UnitType
        case _: DoWhileExpr => Types.UnitType
        case s: SpawnExpr => spawnType(s, scope)
        case b: BinaryExpr => binaryType(b, scope)
        case u: UnaryExpr => unaryType(u, scope)
        case j: JumpExpr => Types.NothingType
        case _: IncOrDecExpr => Types.UnitType
        case a: AssignExpr =>
            assign(a, scope)
            Types.UnitType
        case l: LambdaExpr => lambdaType(l, scope)
        case s: SynchronizedExpr => blockType(s.block, scope)
        case _ => None
    }
}

private func visitReturn(scope: Scope, r: ReturnExpr): Unit {
    if (let Some(f) <- scope.funcScope) {
        let retExpr = try { r.expr } catch (_: Exception) { parseExpr(quote(())) }
        if (let Some(retType) <- constExprType(retExpr, scope)) {
            f.appendScopeType(retType)
        }
    }
}

func lambdaType(expr: LambdaExpr, scope: Scope): ?TypeNode {
    let newScope = Scope(scope, kind: FuncScope)
    newScope.appendParams(expr.funcParams)
    let f = FuncType()
    f.types = expr.funcParams |>
        map<FuncParam, TypeNode> { p => p.paramType } |>
        collectArrayList
    flow(expr.nodes, newScope)
    f.returnType = newScope.scopeType
    return f
}

private func literalType(expr: LitConstExpr): ?TypeNode {
    match (expr.literal.kind) {
        case TokenKind.INTEGER_LITERAL => integerLiteralType(expr.literal.value)
        case TokenKind.FLOAT_LITERAL => floatLiteralType(expr.literal.value)
        case TokenKind.STRING_LITERAL |
            TokenKind.SINGLE_QUOTED_STRING_LITERAL |
            TokenKind.MULTILINE_STRING |
            TokenKind.MULTILINE_RAW_STRING => Types.StringType
        case TokenKind.RUNE_BYTE_LITERAL => Types.ByteType
        case TokenKind.BOOL_LITERAL => Types.BoolType
        case TokenKind.RUNE_LITERAL => Types.CharType
        case TokenKind.UNIT_LITERAL => Types.UnitType
        // JString?
        case _ => None
    }
}

private func integerLiteralType(value: String): TypeNode {
    if (value.endsWith("i8")) {
        return PrimitiveType(quote(Int8))
    }
    if (value.endsWith("u8")) {
        return PrimitiveType(quote(UInt8))
    }
    if (value.endsWith("i16")) {
        return PrimitiveType(quote(Int16))
    }
    if (value.endsWith("u16")) {
        return PrimitiveType(quote(UInt16))
    }
    if (value.endsWith("i32")) {
        return PrimitiveType(quote(Int32))
    }
    if (value.endsWith("u32")) {
        return PrimitiveType(quote(UInt32))
    }
    if (value.endsWith("i64")) {
        return Types.Int64Type
    }
    if (value.endsWith("u64")) {
        return PrimitiveType(quote(UInt64))
    }
    return Types.Int64Type
}

private func floatLiteralType(value: String): TypeNode {
    if (value.endsWith("f32")) {
        return PrimitiveType(quote(Float32))
    }
    if (value.endsWith("f16")) {
        return PrimitiveType(quote(Float16))
    }
    if (value.endsWith("f64")) {
        return Types.Float64Type
    }
    return Types.Float64Type
}

extend LitConstExpr {
    func toInt(): ?Int64 {
        if (literal.kind == TokenKind.INTEGER_LITERAL) {
            return Int64.parse(literal.value)
        }

        return None
    }
}

private func tupleType(tuple: TupleLiteral, scope: Scope): ?TypeNode {
    let componentTypes = tuple.elements |>
        map<Expr, ?TypeNode> { e => constExprType(e, scope) } |>
        collectArray

    if (componentTypes |> any<?TypeNode> { it => it.isNone() }) {
        return None
    }

    let tt = TupleType()

    tt.types = componentTypes |>
        map<?TypeNode, TypeNode> { it => it.getOrThrow() } |>
        collectArrayList

    return tt
}

private func binaryType(op: BinaryExpr, scope: Scope): ?TypeNode {
    let leftType = constExprType(op.leftExpr, scope) ?? return None
    let rightType = constExprType(op.rightExpr, scope) ?? return None

    if (!(Types.isSame(leftType, rightType))) {
        return None
    }

    if (Types.isIntType(leftType) || Types.isFloatType(leftType)) {
        return leftType
    }

    return None
}

private func unaryType(op: UnaryExpr, scope: Scope): ?TypeNode {
    let t = constExprType(op.expr, scope) ?? return None
    if (Types.isIntType(t) || Types.isFloatType(t)) {
        return t
    }

    return None
}

private func arrayType(array: ArrayLiteral, scope: Scope): ?TypeNode {
    let elementType = array.elements |>
        map<Expr, ?TypeNode> { element => constExprType(element, scope) } |>
        filter<?TypeNode> { it => it.isSome() } |>
        map<?TypeNode, TypeNode> { it => it.getOrThrow() } |>
        myReduce<TypeNode> { a, b =>
            unionApprox(a, b)
        }

    if (let Some(elementType) <- elementType) {
        return myParseType(quote(Array<$elementType>))
    }

    return None
}

private func subscriptExpr(s: SubscriptExpr, scope: Scope): ?TypeNode {
    let baseType = constExprType(s.baseExpr, scope) ?? return None

    if (let Some(componentType) <- Types.isArray(baseType)) {
        return componentType
    }
    if (let Some(tuple) <- (baseType as TupleType)) {
        if (let Some(Some(index)) <- (s.indexList[0] as LitConstExpr)?.toInt()) {
            return tuple.types.get(index)
        }
    }
    if (Types.isString(baseType)) {
        return Types.ByteType
    }

    return None
}

private func rangeType(range: RangeExpr, scope: Scope): ?TypeNode {
    let start: ?Expr = try { range.start } catch (_) { None }
    let end: ?Expr = try { range.end } catch (_) { None }

    let startType = constExprTypeOpt(start, scope)
    let endType = constExprTypeOpt(end, scope)

    if (let Some(compType) <- unionApprox(startType, endType)) {
        return myParseType(quote(Range<$compType>))
    }

    return None
}

private func ifType(ifExpr: IfExpr, parent: Scope): ?TypeNode {
    func letPattern(l: LetPatternExpr): Scope {
        let newScope = Scope(parent)
        let t = constExprType(l.expr, parent) ?? return parent
        patternExpr(l.pattern, t, newScope)
        return newScope
    }

    let scope = if (let Some(pattern) <- (ifExpr.condition as LetPatternExpr)) {
        letPattern(pattern)
    } else {
        parent
    }

    let ifBlockType = blockType(ifExpr.ifBlock, scope)
    if (ifExpr.keywordE.kind != TokenKind.ELSE) {
        return Types.UnitType
    }

    let elseType = constExprType(ifExpr.elseExpr, scope) ?? return Types.UnitType

    if (Types.isUnit(ifBlockType) || Types.isUnit(elseType)) {
        return Types.UnitType
    }

    return unionApprox(ifBlockType, elseType)
}

private func matchType(matchExpr: MatchExpr, scope: Scope): ?TypeNode {
    let selectorType: ?TypeNode = try {
        constExprType(matchExpr.selector, scope)
    } catch (_) {
        None
    }

    func caseType(c: MatchCase): ?TypeNode {
        let caseScope = Scope(scope)
        if (let Some(selectorType) <- selectorType) {
            for (p in c.patterns) {
                patternExpr(p, selectorType, caseScope)
            }
        }

        blockType(c.block, caseScope)
    }

    matchExpr.matchCases |> map<MatchCase, ?TypeNode>(caseType) |>
        myReduce<?TypeNode>(unionApprox) |> unopt
}

extend VarDecl {
    prop hasExpr: Bool {
        get() {
            assign.kind == TokenKind.ASSIGN
        }
    }

    prop hasType: Bool {
        get() {
            colon.kind == TokenKind.COLON
        }
    }
}

extend Expr {
    func isFieldAccess(scope: Scope): ?ScopeResolveResult {
        match (this) {
            case member: MemberAccess => isFieldAccess1(member, scope)
            case ref: RefExpr => isFieldAccess1(ref, scope)
            case par: ParenExpr => par.parenthesizedExpr.isFieldAccess(scope)
            case _ => None
        }
    }

    private static func isFieldAccess1(lvalue: MemberAccess, scope: Scope): ?ScopeResolveResult {
        if (lvalue.baseExpr.isThisRef()) {
            let id = Identifier(lvalue.field)
            return scope.root?.lookup(id)
        }

        return None
    }

    private static func isFieldAccess1(lvalue: RefExpr, scope: Scope): ?ScopeResolveResult {
        if (lvalue.identifier.kind != TokenKind.IDENTIFIER) {
            return None
        }

        let id = Identifier(lvalue.identifier)
        let result = scope.lookup(id)
        if (result.scope?.isRoot == true) {
            return result
        }

        return None
    }

    func isThisRef(): Bool {
        match (this) {
            case ref: RefExpr => isThisRef1(ref)
            case par: ParenExpr => par.parenthesizedExpr.isThisRef()
            case _ => false
        }
    }

    static func isThisRef1(ref: RefExpr): Bool {
        ref.identifier.kind == TokenKind.THIS
    }
}
