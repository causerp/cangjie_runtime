/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.ast

import std.collection.ArrayList

public open class Pattern <: Node {
    init() {
        super()
    }
    public open func toTokens(): Tokens {
        Tokens()
    }
    public open func traverse(v: Visitor): Unit {
        v.visit(this)
    }
    protected open func dump(_: UInt16): String {
        ""
    }
}

public class ConstPattern <: Pattern {
    init(litConstExpr: LitConstExpr) {
        litConstExpr_ = litConstExpr
    }
    public init(inputs: Tokens) {
        try {
            match (parsePattern(inputs) as ConstPattern) {
                case Some(v) =>
                    this.begin_ = v.beginPos
                    this.end_ = v.endPos
                    this.litConstExpr_ = v.litConstExpr_
                case None => throw ASTException("Cannot construct the 'ConstPattern' node.")
            }
        } catch (e: ParseASTException) {
            if (e.message == String.empty) {
                throw ASTException("Cannot construct the 'ConstPattern' node.")
            } else {
                throw ASTException(e.message)
            }
        }
    }
    public init() {}
    private var litConstExpr_: LitConstExpr = LitConstExpr()
    public mut prop litConstExpr: LitConstExpr {
        get() {
            litConstExpr_
        }
        set(v) {
            litConstExpr_ = v
        }
    }
    public func toTokens(): Tokens {
        Tokens().append(litConstExpr_)
    }

    public func traverse(v: Visitor): Unit {
        v.visit(this)
        if (v.needBreakTraverse()) {
            return
        }
        litConstExpr_.traverse(v)
        return
    }

    protected func dump(indent: UInt16): String {
        var ret: String = "ConstPattern {\n"
        currentIndent = indent
        if (indent != 0 || beginNode) {
            currentIndent++
        }
        ret += getIndent(currentIndent) + "-litConstExpr: "
        ret += litConstExpr_.dump(currentIndent)
        ret += getIndent(indent) + "}\n"
        ret
    }
}

public class WildcardPattern <: Pattern {
    public init(keyword: Tokens) {
        if (keyword.size == 0) {
            throw ASTException("Cannot construct the 'WildcardPattern' node. (Empty Input)")
        }
        keyWord_ = keyword[0]
        checkTokenType(keyWord_, WILDCARD)
        this.begin_ = keyWord_.pos
        this.end_ = Position(begin_.fileID, begin_.line, begin_.column + Int32(keyWord_.value.size))
    }
    public init() {}
    private var keyWord_: Token = Token(TokenKind.WILDCARD)
    public mut prop wildcard: Token {
        get() {
            keyWord_
        }
        set(v) {
            checkTokenType(v, WILDCARD)
            keyWord_ = v
        }
    }
    public func toTokens(): Tokens {
        Tokens().append(keyWord_)
    }

    public func traverse(v: Visitor): Unit {
        v.visit(this)
        return
    }

    protected func dump(indent: UInt16): String {
        var ret: String = "WildcardPattern {\n"
        currentIndent = indent
        if (indent != 0 || beginNode) {
            currentIndent++
        }
        ret += getTokenIndent("-wildcard", keyWord_, currentIndent)
        ret += getIndent(indent) + "}\n"
        ret
    }
}

public class VarPattern <: Pattern {
    public init(identifier: Token) {
        identifier_ = identifier
        checkTokenType(identifier_, IDENTIFIER)
        this.begin_ = identifier_.pos
        this.end_ = Position(begin_.fileID, begin_.line, begin_.column + Int32(identifier_.value.size))
    }
    public init() {}
    private var identifier_: Token = Token(TokenKind.IDENTIFIER, "")
    public mut prop identifier: Token {
        get() {
            identifier_
        }
        set(v) {
            checkTokenType(v, IDENTIFIER)
            identifier_ = v
        }
    }
    public func toTokens(): Tokens {
        Tokens().append(identifier_)
    }

    public func traverse(v: Visitor): Unit {
        v.visit(this)
        return
    }

    protected func dump(indent: UInt16): String {
        var ret: String = "VarPattern {\n"
        currentIndent = indent
        if (indent != 0 || beginNode) {
            currentIndent++
        }
        ret += getTokenIndent("-identifier", identifier_, currentIndent)
        ret += getIndent(indent) + "}\n"
        ret
    }
}

public class VarOrEnumPattern <: Pattern {
    public init(identifier: Token) {
        identifier_ = identifier
        checkTokenType(identifier_, IDENTIFIER)
        this.begin_ = identifier_.pos
        this.end_ = Position(begin_.fileID, begin_.line, begin_.column + Int32(identifier_.value.size))
    }
    public init() {}
    private var identifier_ = Token(TokenKind.IDENTIFIER, "")
    public mut prop identifier: Token {
        get() {
            identifier_
        }
        set(v) {
            checkTokenType(v, IDENTIFIER)
            identifier_ = v
        }
    }
    public func toTokens(): Tokens {
        Tokens().append(identifier_)
    }

    public func traverse(v: Visitor): Unit {
        v.visit(this)
        return
    }

    protected func dump(indent: UInt16): String {
        var ret: String = "VarOrEnumPattern {\n"
        currentIndent = indent
        if (indent != 0 || beginNode) {
            currentIndent++
        }
        ret += getTokenIndent("-identifier", identifier_, currentIndent)
        ret += getIndent(indent) + "}\n"
        ret
    }
}

public class ExceptTypePattern <: Pattern {
    init(pattern: Pattern, colon: Token, types: ArrayList<TypeNode>, bitOr: Tokens) {
        pattern_ = pattern
        colon_ = colon
        types_ = types
        bitOr_ = bitOr
    }
    public init() {}
    public init(inputs: Tokens) {
        try {
            let tokens = Tokens()
            tokens.append(quote(try {} catch)).append(Token(LPAREN)).append(inputs).append(Token(RPAREN)).append(
                Token(LCURL)).append(Token(RCURL));
            let tryExpr = (parseExpr(tokens) as TryExpr).getOrThrow().catchPatterns[0]
            var exceptTypePa = (tryExpr as ExceptTypePattern).getOrThrow()
            match (exceptTypePa as ExceptTypePattern) {
                case Some(v) =>
                    this.begin_ = v.beginPos
                    this.end_ = v.endPos
                    this.pattern_ = v.pattern_
                    this.colon_ = v.colon_
                    this.types_ = v.types_
                    this.bitOr_ = v.bitOr_
                case None => throw ASTException("Cannot construct the 'ExceptTypePattern' node.")
            }
        } catch (e: ParseASTException | NoneValueException) {
            if (e.message == String.empty) {
                throw ASTException("Cannot construct the 'ExceptTypePattern' node.")
            } else {
                throw ASTException(e.message)
            }
        }
    }
    private var pattern_: Pattern = Pattern()
    private var colon_: Token = Token(TokenKind.COLON)
    private var types_: ArrayList<TypeNode> = ArrayList<TypeNode>()
    private var bitOr_: Tokens = Tokens()
    public mut prop pattern: Pattern {
        get() {
            pattern_
        }
        set(v) {
            pattern_ = v
        }
    }
    public mut prop colon: Token {
        get() {
            colon_
        }
        set(v) {
            checkTokenType(v, COLON)
            colon_ = v
        }
    }
    public mut prop types: ArrayList<TypeNode> {
        get() {
            types_
        }
        set(v) {
            types_ = v
        }
    }
    public func toTokens(): Tokens {
        var ret = Tokens().append(pattern_).append(colon_)
        if (bitOr_.size == 0) {
            bitOr_ = Tokens(Array(types_.size - 1, repeat: Token(TokenKind.BITOR)))
        }
        for (i in 0..types_.size - 1) {
            ret.append(types_[i]).append(bitOr_[i])
        }
        ret.append(types_[types_.size - 1])
    }

    public func traverse(v: Visitor): Unit {
        v.visit(this)
        if (v.needBreakTraverse()) {
            return
        }
        pattern_.traverse(v)
        for (ty in types_) {
            ty.traverse(v)
        }
        return
    }

    protected func dump(indent: UInt16): String {
        var ret: String = "ExceptTypePattern {\n"
        currentIndent = indent
        if (indent != 0 || beginNode) {
            currentIndent++
        }
        ret += getIndent(currentIndent) + "-pattern: "
        ret += pattern_.dump(currentIndent)
        ret += getTokenIndent("-colon", colon_, currentIndent)
        for (i in 0..types_.size) {
            ret += getIndent(currentIndent) + "-types: ${i}, "
            ret += types_[i].dump(currentIndent)
        }
        ret += getIndent(indent) + "}\n"
        ret
    }
}

public class TypePattern <: Pattern {
    init(pattern: Pattern, colon: Token, ty: TypeNode) {
        pattern_ = pattern
        colon_ = colon
        type_ = ty
    }
    public init() {}
    public init(inputs: Tokens) {
        try {
            match (parsePattern(inputs) as TypePattern) {
                case Some(v) =>
                    this.begin_ = v.beginPos
                    this.end_ = v.endPos
                    this.pattern_ = v.pattern_
                    this.colon_ = v.colon_
                    this.type_ = v.type_
                case None => throw ASTException("Cannot construct the 'TypePattern' node.")
            }
        } catch (e: ParseASTException) {
            if (e.message == String.empty) {
                throw ASTException("Cannot construct the 'TypePattern' node.")
            } else {
                throw ASTException(e.message)
            }
        }
    }
    private var pattern_: Pattern = Pattern()
    private var colon_: Token = Token(TokenKind.COLON)
    private var type_: TypeNode = TypeNode()
    public mut prop pattern: Pattern {
        get() {
            pattern_
        }
        set(v) {
            pattern_ = v
        }
    }
    public mut prop colon: Token {
        get() {
            colon_
        }
        set(v) {
            checkTokenType(v, COLON)
            colon_ = v
        }
    }
    public mut prop patternType: TypeNode {
        get() {
            type_
        }
        set(v) {
            type_ = v
        }
    }
    public func toTokens(): Tokens {
        Tokens().append(pattern_).append(colon_).append(type_)
    }

    public func traverse(v: Visitor): Unit {
        v.visit(this)
        if (v.needBreakTraverse()) {
            return
        }
        pattern_.traverse(v)
        type_.traverse(v)
        return
    }

    protected func dump(indent: UInt16): String {
        var ret: String = "TypePattern {\n"
        currentIndent = indent
        if (indent != 0 || beginNode) {
            currentIndent++
        }
        ret += getIndent(currentIndent) + "-pattern: "
        ret += pattern_.dump(currentIndent)
        ret += getTokenIndent("-colon", colon_, currentIndent)
        ret += getIndent(currentIndent) + "-patternType: "
        ret += type_.dump(currentIndent)
        ret += getIndent(indent) + "}\n"
        ret
    }
}

public class EnumPattern <: Pattern {
    init(constructor: Expr, lParen: Token, patterns: ArrayList<Pattern>, commas: Tokens, rParen: Token) {
        constructor_ = constructor
        lParen_ = lParen
        patterns_ = patterns
        commas_ = commas
        rParen_ = rParen
    }
    public init() {}
    public init(inputs: Tokens) {
        try {
            match (parsePattern(inputs) as EnumPattern) {
                case Some(v) =>
                    this.begin_ = v.beginPos
                    this.end_ = v.endPos
                    this.constructor_ = v.constructor_
                    this.lParen_ = checkValid(v.lParen_)
                    this.patterns_ = v.patterns_
                    this.commas_ = v.commas_
                    this.rParen_ = checkValid(v.rParen_)
                case None => throw ASTException("Cannot construct the 'EnumPattern' node.")
            }
        } catch (e: ParseASTException) {
            if (e.message == String.empty) {
                throw ASTException("Cannot construct the 'EnumPattern' node.")
            } else {
                throw ASTException(e.message)
            }
        }
    }
    private var constructor_: Expr = Expr()
    private var lParen_: Token = Token(TokenKind.LPAREN)
    private var patterns_: ArrayList<Pattern> = ArrayList<Pattern>()
    private var commas_: Tokens = Tokens()
    private var rParen_: Token = Token(TokenKind.RPAREN)
    public mut prop constructor: Expr {
        get() {
            constructor_
        }
        set(v) {
            constructor_ = v
        }
    }
    public mut prop lParen: Token {
        get() {
            lParen_
        }
        set(v) {
            checkTokenType(v, LPAREN)
            lParen_ = v
        }
    }
    public mut prop patterns: ArrayList<Pattern> {
        get() {
            patterns_
        }
        set(v) {
            patterns_ = v
        }
    }
    public mut prop commas: Tokens {
        get() {
            commas_
        }
        set(v) {
            checkTokensType(v, COMMA)
            commas_ = v
        }
    }
    public mut prop rParen: Token {
        get() {
            rParen_
        }
        set(v) {
            checkTokenType(v, RPAREN)
            rParen_ = v
        }
    }
    public func toTokens(): Tokens {
        var ret = Tokens().append(constructor_)
        if (!patterns_.isEmpty()) {
            ret.append(lParen_)
            for (i in 0..patterns_.size - 1) {
                let comma = if (i >= commas.size) {
                    Token(COMMA)
                } else {
                    commas[i]
                }
                ret.append(patterns_[i]).append(comma)
            }
            ret.append(patterns_[patterns_.size - 1]).append(rParen_)
        }
        ret
    }
    public func traverse(v: Visitor): Unit {
        v.visit(this)
        if (v.needBreakTraverse()) {
            return
        }
        constructor_.traverse(v)
        for (p in patterns_) {
            p.traverse(v)
        }
        return
    }

    protected func dump(indent: UInt16): String {
        var ret: String = "EnumPattern {\n"
        currentIndent = indent
        if (indent != 0 || beginNode) {
            currentIndent++
        }
        ret += getIndent(currentIndent) + "-constructor: "
        ret += constructor_.dump(currentIndent)
        for (i in 0..patterns_.size) {
            ret += getIndent(currentIndent) + "-patterns: ${i}, "
            ret += patterns_[i].dump(currentIndent)
        }
        ret += getIndent(indent) + "}\n"
        ret
    }
}

public class TuplePattern <: Pattern {
    init(lParen: Token, patterns: ArrayList<Pattern>, commas: Tokens, rParen: Token) {
        lParen_ = lParen
        patterns_ = patterns
        commas_ = commas
        rParen_ = rParen
    }
    public init() {}
    public init(inputs: Tokens) {
        try {
            match (parsePattern(inputs) as TuplePattern) {
                case Some(v) =>
                    this.begin_ = v.beginPos
                    this.end_ = v.endPos
                    this.lParen_ = v.lParen_
                    this.patterns_ = v.patterns_
                    this.commas_ = v.commas_
                    this.rParen_ = v.rParen_
                case None => throw ASTException("Cannot construct the 'TuplePattern' node.")
            }
        } catch (e: ParseASTException) {
            if (e.message == String.empty) {
                throw ASTException("Cannot construct the 'TuplePattern' node.")
            } else {
                throw ASTException(e.message)
            }
        }
    }

    private var lParen_: Token = Token(TokenKind.LPAREN)
    private var patterns_: ArrayList<Pattern> = ArrayList<Pattern>()
    private var commas_: Tokens = Tokens()
    private var rParen_: Token = Token(TokenKind.RPAREN)
    public mut prop lParen: Token {
        get() {
            lParen_
        }
        set(v) {
            checkTokenType(v, LPAREN)
            lParen_ = v
        }
    }
    public mut prop patterns: ArrayList<Pattern> {
        get() {
            patterns_
        }
        set(v) {
            patterns_ = v
        }
    }
    public mut prop commas: Tokens {
        get() {
            commas_
        }
        set(v) {
            checkTokensType(v, COMMA)
            commas_ = v
        }
    }
    public mut prop rParen: Token {
        get() {
            rParen_
        }
        set(v) {
            checkTokenType(v, RPAREN)
            rParen_ = v
        }
    }
    public func toTokens(): Tokens {
        var ret = Tokens().append(lParen_)
        if (!patterns_.isEmpty()) {
            for (i in 0..patterns_.size - 1) {
                let comma = if (i >= commas.size) {
                    Token(COMMA)
                } else {
                    commas[i]
                }
                ret.append(patterns_[i]).append(comma)
            }
            ret.append(patterns_[patterns_.size - 1])
        }
        ret.append(rParen_)
    }

    public func traverse(v: Visitor): Unit {
        v.visit(this)
        if (v.needBreakTraverse()) {
            return
        }
        for (p in patterns_) {
            p.traverse(v)
        }
        return
    }

    protected func dump(indent: UInt16): String {
        var ret: String = "TuplePattern {\n"
        currentIndent = indent
        if (indent != 0 || beginNode) {
            currentIndent++
        }
        for (i in 0..patterns_.size) {
            ret += getIndent(currentIndent) + "-patterns: ${i}, "
            ret += patterns_[i].dump(currentIndent)
        }
        ret += getIndent(indent) + "}\n"
        ret
    }
}
