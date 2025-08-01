/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
protected package std.deriving.resolve

import std.ast.*
import std.collection.*

public struct Types {
    private init() {}

    public static let SuppressUnusedInit = Types()

    public static let AnyType: TypeNode = myParseType(quote(Any))
    public static let NothingType: TypeNode = myParseType(quote(Nothing))
    public static let UnitType: TypeNode = PrimitiveType(quote(Unit))
    public static let BoolType: TypeNode = PrimitiveType(quote(Bool))
    public static let TokensType: TypeNode = myParseType(quote(ast.Tokens))
    public static let ByteType: TypeNode = PrimitiveType(quote(UInt8))
    public static let Int64Type: TypeNode = PrimitiveType(quote(Int64))
    public static let Float64Type: TypeNode = PrimitiveType(quote(Float64))
    public static let StringType: TypeNode = myParseType(quote(String))
    public static let ByteArrayType: TypeNode = myParseType(quote(Array<UInt8>))
    public static let CharType: TypeNode = PrimitiveType(quote(Rune))

    public static func isSame(a: TypeNode, b: TypeNode): Bool {
        if (refEq(a, b)) {
            return true
        }

        match ((a, b)) {
            case (a: PrimitiveType, b: PrimitiveType) => isSame(a, b)
            case (a: RefType, b: RefType) => isSame(a, b)
            case (a: TupleType, b: TupleType) => isSame(a, b)
            case _ => a.toTokens().toString() == b.toTokens().toString()
        }
    }

    private static func isSame(a: PrimitiveType, b: PrimitiveType): Bool {
        a.keyword.kind == b.keyword.kind
    }

    private static func isSame(a: RefType, b: RefType): Bool {
        a.identifier.value == b.identifier.value &&
            (a.typeArguments |> zip(b.typeArguments) |> all<(TypeNode, TypeNode)> { tt =>
                let (a, b) = tt
                isSame(a, b)
            } )
    }

    private static func isSame(a: TupleType, b: TupleType): Bool {
        if (a.types.size != b.types.size) {
            return false
        }

        return a.types |> zip(b.types) |> all<(TypeNode, TypeNode)> { pair => isSame(pair[0], pair[1])}
    }

    public static func isUnit(typeNode: TypeNode): Bool {
        if (let Some(primitive) <- (typeNode as PrimitiveType)) {
            return primitive.keyword.kind == TokenKind.UNIT
        }

        return false
    }

    public static func isNothing(typeNode: TypeNode): Bool {
        if (let Some(primitive) <- (typeNode as PrimitiveType)) {
            return primitive.keyword.kind == TokenKind.NOTHING
        }

        return false
    }

    // returns component type if array
    public static func isArray(node: TypeNode): ?TypeNode {
        match (node) {
            case par: ParenType => isArray(par.parenthesizedType)
            case ref: RefType where isArray(ref) => ref.typeArguments[0]
            case _ => None
        }
    }

    public static func isIntType(typeNode: TypeNode): Bool {
        if (let Some(primitive) <- (typeNode as PrimitiveType)) {
            return match (primitive.keyword.kind) {
                case TokenKind.INT8 |
                    TokenKind.INT16 |
                    TokenKind.INT32 |
                    TokenKind.INT64 |
                    TokenKind.UINT8 |
                    TokenKind.UINT16 |
                    TokenKind.UINT32 |
                    TokenKind.UINT64 |
                    TokenKind.INTNATIVE |
                    TokenKind.UINTNATIVE => true
                case _ => false
            }
        }

        return false
    }

    public static func isFloatType(typeNode: TypeNode): Bool {
        if (let Some(primitive) <- (typeNode as PrimitiveType)) {
            return match (primitive.keyword.kind) {
                case TokenKind.FLOAT16 |
                    TokenKind.FLOAT32 |
                    TokenKind.FLOAT64 => true
                case _ => false
            }
        }

        return false
    }

    public static func isString(typeNode: TypeNode): Bool {
        if (let Some(ref) <- (typeNode as RefType)) {
            if (ref.identifier.value == "String") {
                return true
            }
        }

        return false
    }

    private static func isArray(ref: RefType): Bool {
        ref.identifier.value == "Array"
    }
}

public func unionApprox(a: TypeNode, b: TypeNode): TypeNode {
    if (refEq(a, b)) {
        return a
    }

    if (Types.isSame(a, b)) {
        return a
    }

    if (Types.isNothing(a)) {
        return b
    }
    if (Types.isNothing(b)) {
        return a
    }

    return Types.AnyType
}

public func unionApprox(a: ?TypeNode, b: ?TypeNode): ?TypeNode {
    match ((a, b)) {
        case (Some(a), Some(b)) => unionApprox(a, b)
        case _ => a ?? b
    }
}

func typeByKeyword(keyword: Token): TypeNode {
    let t = PrimitiveType()
    t.keyword = keyword
    return t
}
