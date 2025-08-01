/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.ast

import std.collection.ArrayList

public func parsePattern(input: Tokens): Pattern {
    /* Get node info from flatbuffer */
    let node = unsafe {
        try {
            parse(input, {p: CPointer<UInt8> => return CJ_AST_ParsePattern(match (MACRO_OBJECT.get()) {
                case Some(ptr) => ptr
                case None => CPointer<Unit>()
            }, p, CPointer<Int64>())})
        } catch (e: Exception) {
            throw ParseASTException("\n" + e.message + "parsing pattern error.")
        }
    }
    /* Get decl info from flatbuffer */
    var astNode = generatePatternAST(node.GetRootAsPattern())
    return astNode
}

public func parsePatternFragment(input: Tokens, startFrom!: Int64 = 0): (Pattern, Int64) {
    let (node, count) = unsafe {
        try {
            parseFragment(
                input,
                startFrom,
                {p: CPointer<UInt8>, sizeRef: CPointer<Int64> => return CJ_AST_ParsePattern(match (MACRO_OBJECT.get()) {
                    case Some(ptr) => ptr
                    case None => CPointer<Unit>()
                }, p, sizeRef)}
            )
        } catch (e: Exception) {
            throw ParseASTException("\n" + e.message + "parsing pattern fragment error.")
        }
    }
    var astNode = generatePatternAST(node.GetRootAsPattern())
    return (astNode, count)
}

func generatePatternAST(patternNode: Option<NodeFormat_Pattern>): Pattern {
    var pattern = match (patternNode) {
        case Some(v) => v
        case None => throw ParseASTException("generatePatternAST: get pattern")
    }
    var nodeBase = match (pattern.GetBase()) {
        case Some(v) => v
        case None => throw ParseASTException("generatePatternAST: get nodeBase")
    }
    var astKind: String = nodeBase.GetAstKind()
    var astNode = match (astKind) {
        case "var_pattern" => createVarPattern(pattern)
        case "const_pattern" => createConstPattern(pattern)
        case "tuple_pattern" => createTuplePattern(pattern)
        case "enum_pattern" => createEnumPattern(pattern)
        case "var_or_enum_pattern" => createVarOrEnumPattern(pattern, nodeBase.GetBegin())
        case "type_pattern" => createTypePattern(pattern)
        case "except_type_pattern" => createExceptTypePattern(pattern)
        case "wildcard_pattern" => createWildcardPattern(pattern, nodeBase.GetBegin())
        case _ => throw ParseASTException("Unsupported parse the pattern node: ${astKind}.\n")
    }
    addPositionInfo(astNode, nodeBase)
    return astNode
}

func createVarPattern(pattern: NodeFormat_Pattern): VarPattern {
    var varPattern = match (pattern.GetPatternAsVarPattern()) {
        case Some(v) => v
        case None => throw ParseASTException("In createVarPattern function: get varPattern")
    }
    var varDecl = match (varPattern.GetVarDecl()) {
        case Some(v) => v
        case None => throw ParseASTException("In createVarPattern function: get varDecl")
    }
    var declBase = match (varDecl.GetBase()) {
        case Some(v) => v
        case None => throw ParseASTException("In createVarPattern function: get declBase")
    }
    var indentifier = Token(TokenKind.IDENTIFIER, declBase.GetIdentifier()).addPosition(declBase.GetIdentifierPos())
    return VarPattern(indentifier)
}

func createConstPattern(pattern: NodeFormat_Pattern): ConstPattern {
    var constPattern = match (pattern.GetPatternAsConstPattern()) {
        case Some(v) => v
        case None => throw ParseASTException("In createConstPattern function: get constPattern")
    }
    var exprNode = generateExprAST(constPattern.GetLiteral())
    var litConstExpr = match (exprNode as LitConstExpr) {
        case Some(v) => v
        case None => throw ParseASTException("In createConstPattern function: get litConstExpr")
    }
    return ConstPattern(litConstExpr)
}

func createWildcardPattern(_: NodeFormat_Pattern, pos: NodeFormat_Position): WildcardPattern {
    var keyWord = Tokens().append(Token(TokenKind.WILDCARD).addPosition(pos))
    return WildcardPattern(keyWord)
}

func createVarOrEnumPattern(pattern: NodeFormat_Pattern, pos: NodeFormat_Position): VarOrEnumPattern {
    var varOrEnumPattern = match (pattern.GetPatternAsVarOrEnumPattern()) {
        case Some(v) => v
        case None => throw ParseASTException("In createVarOrEnumPattern function: get varOrEnumPattern")
    }
    var identifier = Token(TokenKind.IDENTIFIER, varOrEnumPattern.GetIdentifier()).addPosition(pos)
    /* Need to support? generatePatternAST(varOrEnumPattern.GetPattern()) */
    return VarOrEnumPattern(identifier)
}

func createExceptTypePattern(pattern: NodeFormat_Pattern): ExceptTypePattern {
    var exceptTypePattern = match (pattern.GetPatternAsExceptTypePattern()) {
        case Some(v) => v
        case None => throw ParseASTException("In createExceptTypePattern function: get exceptTypePattern")
    }
    var p = generatePatternAST(exceptTypePattern.GetPattern())
    var colon: Token = Token(TokenKind.COLON).addPosition(exceptTypePattern.GetColonPos())
    var types: ArrayList<TypeNode> = ArrayList<TypeNode>()
    for (tp in exceptTypePattern.GetTypes()) {
        types.add(generateTypeAST(tp))
    }
    var bitOr = Tokens()
    for (pos in exceptTypePattern.GetBitOrPosVec()) {
        bitOr.append(Token(TokenKind.BITOR).addPosition(pos))
    }
    return ExceptTypePattern(p, colon, types, bitOr)
}

func createTypePattern(pattern: NodeFormat_Pattern): TypePattern {
    var typePattern = match (pattern.GetPatternAsTypePattern()) {
        case Some(v) => v
        case None => throw ParseASTException("In createTypePattern function: get typePattern")
    }
    var p = generatePatternAST(typePattern.GetPattern())
    var colon: Token = Token(TokenKind.COLON).addPosition(typePattern.GetColonPos())
    var ty: TypeNode = generateTypeAST(typePattern.GetType())
    return TypePattern(p, colon, ty)
}

func createEnumPattern(pattern: NodeFormat_Pattern): EnumPattern {
    var enumPattern = match (pattern.GetPatternAsEnumPattern()) {
        case Some(v) => v
        case None => throw ParseASTException("In createEnumPattern function: get enumPattern")
    }
    var exprNode = match (enumPattern.GetRef()) {
        case Some(v) => generateExprAST(v)
        case None => throw ParseASTException("EnumPattern's constructor is not a RefExpr")
    }
    var lParen: Token = Token(TokenKind.LPAREN).addPosition(enumPattern.GetLeftParenPos())
    var patterns: ArrayList<Pattern> = ArrayList<Pattern>()
    for (p in enumPattern.GetPatterns()) {
        patterns.add(generatePatternAST(p))
    }
    let commas = Tokens()
    for (commaPos in enumPattern.GetCommaPosVec()) {
        commas.append(Token(TokenKind.COMMA).addPosition(commaPos))
    }
    var rParen: Token = Token(TokenKind.RPAREN).addPosition(enumPattern.GetRightParenPos())
    return EnumPattern(exprNode, lParen, patterns, commas, rParen)
}

func createTuplePattern(pattern: NodeFormat_Pattern): TuplePattern {
    var tuplePattern = match (pattern.GetPatternAsTuplePattern()) {
        case Some(v) => v
        case None => throw ParseASTException("In createTuplePattern function: get tuplePattern")
    }
    var lParen: Token = Token(TokenKind.LPAREN).addPosition(tuplePattern.GetLeftParenPos())
    var patterns: ArrayList<Pattern> = ArrayList<Pattern>()
    for (p in tuplePattern.GetPatterns()) {
        patterns.add(generatePatternAST(p))
    }
    let commas = Tokens()
    for (commaPos in tuplePattern.GetCommaPosVec()) {
        commas.append(Token(TokenKind.COMMA).addPosition(commaPos))
    }
    var rParen: Token = Token(TokenKind.RPAREN).addPosition(tuplePattern.GetRightParenPos())
    return TuplePattern(lParen, patterns, commas, rParen)
}
