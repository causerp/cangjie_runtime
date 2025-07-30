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

func patternExpr(p: Pattern, t: TypeNode, scope: Scope): Unit {
    func patternIter(patterns: Iterable<Pattern>, types: Iterable<TypeNode>, scope: Scope): Unit {
        let p = patterns.iterator()
        let t = types.iterator()

        while (let (Some(p), Some(t)) <- (p.next(), t.next())) {
            patternExpr(p, t, scope)
        }
    }

    func tuplePattern(p: TuplePattern, t: TupleType, scope: Scope): Unit {
        if (p.patterns.size != t.types.size) {
            return
        }

        patternIter(p.patterns, t.types, scope)
    }

    func varPattern(v: VarPattern, t: TypeNode, scope: Scope): Unit {
        scope.append(Identifier(v.identifier), t)
    }

    func typePattern(v: TypePattern, scope: Scope): Unit {
        patternExpr(v.pattern, v.patternType, scope)
    }

    func enumPattern(e: EnumPattern, typeNode: TypeNode, scope: Scope): Unit {
        let t: ?Array<TypeNode> = match (e.constructor) {
            case ref: RefExpr where isSome(ref) => [optionType(typeNode)]
            case _ => None
        }

        if (let Some(t) <- t) {
            patternIter(e.patterns, t, scope)
        }
    }

    func varOrEnumPattern(e: VarOrEnumPattern, typeNode: TypeNode, scope: Scope): Unit {
        if (isNone(e.identifier) && scope.lookup(e.identifier).resolvedType.isNone()) {
            return
        }

        // requires full resolve and reflect
        // lucky we are

        scope.append(Identifier(e.identifier), typeNode)
    }

    match (p) {
        case tp: TuplePattern =>
            let tupleType = t as TupleType ?? return;
            tuplePattern(tp, tupleType, scope)
        case v: VarPattern => varPattern(v, t, scope)
        case tp: TypePattern => typePattern(tp, scope)
        case e: EnumPattern => enumPattern(e, t, scope)
        case v: VarOrEnumPattern => varOrEnumPattern(v, t, scope)
        case _ => return
    }
}

func optionType(t: TypeNode): TypeNode {
    match (t) {
        case ref: RefType where ref.identifier.value == "Option" => ref.typeArguments[0]
        case par: ParenType => optionType(par.parenthesizedType)
        case _ => t // wrap to option
    }
}

