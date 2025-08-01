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

/**
 * Represent parsed option passed to the @Derive macro for specific interface. It is parsed but not analyzed/resolved.
 */
public struct DeriveInterfaceOption <: ToTokens & ToString {
    public DeriveInterfaceOption(
        public let interfaceName: Identifier,
        public let resolvedInterface: QualifiedName,
        public let parsedConstraints: ?ParsedExplicitConstraints
    ) {}

    init(
        interfaceName: Identifier,
        resolvedInterface: QualifiedName
    ) {
        this(interfaceName, resolvedInterface, None)
    }

    public init(
        interfaceName: Identifier,
        resolvedInterface: QualifiedName,
        whereKeyword: Token,
        excplicitConstraints: Array<ParsedGenericConstraint>
    ) {
        this(interfaceName, resolvedInterface, ParsedExplicitConstraints(whereKeyword, excplicitConstraints))
    }

    public prop constraints: Array<ParsedGenericConstraint> {
        get() { parsedConstraints?.explicitConstraints ?? [] }
    }

    public func toTokens(): Tokens {
        let tkns = Tokens(interfaceName.token)
        if (let Some(ec) <- parsedConstraints) {
            tkns.append(ec.toTokens())
        }
        return tkns
    }

    public func toString(): String {
        toTokens().toString()
    }
}

public struct ParsedExplicitConstraints <: ToString & ToTokens {
    public ParsedExplicitConstraints(
        public let whereKeyword: Token,
        public let explicitConstraints: Array<ParsedGenericConstraint>
    ) {}

    public func toTokens(): Tokens {
        let tkns = Tokens(whereKeyword)
        for ((index, ec) in explicitConstraints |> enumerate) {
            if (index > 0) {
                tkns.append(Token(TokenKind.COMMA, ","))
            }
            tkns.append(ec.toAst())
        }
        return tkns
    }

    public func toString(): String {
        return toTokens().toString()
    }
}

public struct ParsedGenericConstraint <: ToString & ToTokens {
    public ParsedGenericConstraint(
        public let genericParameter: Identifier,
        public let upperBounds: Array<TypeNode>
    ) {}

    public func toDerivingGeneric(decl: GenericDecl): DerivingGenericSettings {
        if (genericParameter != decl.identifier) {
            throw IllegalArgumentException("The generic parameter name should match")
        }

        return DerivingGenericSettings(decl, upperBounds)
    }

    public func toAst(): GenericConstraint {
        toDerivingGeneric(GenericDecl(genericParameter)).toNode()
    }

    public func toTokens(): Tokens {
        toAst().toTokens()
    }

    public func toString(): String {
        toTokens().toString()
    }
}

public func parseDeriveOptions(input: Tokens, logger: Logger): Array<DeriveInterfaceOption> {
    return DeriveInputParser.params(input, logger)
}

public struct DeriveInputParser {
    private DeriveInputParser(private let it: PushbackTokensIterator, private let logger: Logger) {
    }

    public static func params(input: Tokens, logger: Logger): Array<DeriveInterfaceOption> {
        params(PushbackTokensIterator(repalceWrongTokens(input)), logger)
    }

    static func params(input: PushbackTokensIterator, logger: Logger): Array<DeriveInterfaceOption> {
        DeriveInputParser(input, logger).parseParams()
    }

    private func parseParams(): Array<DeriveInterfaceOption> {
        let result = ArrayList<DeriveInterfaceOption>()
        while (let Some(first) <- it.next()) {
            if (first.kind != TokenKind.IDENTIFIER) {
                logger.error(first, "Expected interface name, got ${first.value}")
                paramsRecover(first)
                continue
            }

            if (let Some(param) <- parseNextParam(first)) {
                result.add(param)
            }

            consumeComma()
        }

        return result.toArray()
    }

    private func consumeComma(): Unit {
        let shouldBeComma = it.next() ?? return;
        if (shouldBeComma.kind == TokenKind.COMMA) { return }

        logger.error(shouldBeComma, "Expected comma got ${shouldBeComma.value} (${shouldBeComma.kind})")
        if (shouldBeComma.kind == TokenKind.IDENTIFIER) {
            it.pushback()
        } else {
            paramsRecover(shouldBeComma)
        }
    }

    private func paramsRecover(first: Token): Unit {
        if (first.kind == TokenKind.WHERE) {
            parseConstraint(first)
        } else if (first.kind == TokenKind.UPPERBOUND) {
            parseUpperBounds()
        } else if (first.kind == TokenKind.LT) {
            it.pushback()
            parseRef(Token(TokenKind.IDENTIFIER, "unknown"))
        }
    }

    private func parseInterfaceRef(first: Token): Array<Token> {
        let result = ArrayList<Token>()
        result.add(first)

        while (it.seeing(TokenKind.DOT)) {
            let dot = it.next().getOrThrow()
            if (!it.seeing(TokenKind.IDENTIFIER)) {
                let errorAt = Tokens(dot)
                if (let Some(next) <- it.peek()) {
                    errorAt.append(next)
                }

                logger.error(errorAt, "Expected interface name")
                recoverAfterBrokenInterfaceName()
                break
            }
            let id = it.next().getOrThrow()
            result.add(id)
        }

        return result.toArray()
    }

    private func recoverAfterBrokenInterfaceName() {
        // skip until generic constraints or the next interface name beginning
        while (let Some(next) <- it.next()) {
            if (next.kind == TokenKind.WHERE || next.kind == TokenKind.COMMA) {
                break
            }
        }
    }

    private func parseNextParam(first: Token): ?DeriveInterfaceOption {
        let interfaceRef = parseInterfaceRef(first)
        let interfaceName = Identifier(interfaceRef.iterator().last() ?? return None)
        let resolved = if (interfaceRef.size == 1) {
            resolveInterface(interfaceName)
        } else {
            QualifiedName(interfaceRef)
        }

        if (!it.seeing(TokenKind.WHERE)) {
            return DeriveInterfaceOption(interfaceName, resolved)
        }

        let whereTok = it.next().getOrThrow()
        let constraints = ArrayList<ParsedGenericConstraint>()

        match (parseConstraint(whereTok)) {
            case Some(c) where c.upperBounds.size > 0 => constraints.add(c)
            case Some(c) =>
                logger.error(c.genericParameter.token, "Generic parameter requires upper bounds")
                return DeriveInterfaceOption(interfaceName, resolved, whereTok, [])
            case None =>
                return DeriveInterfaceOption(interfaceName, resolved)
        }

        while (it.seeing(TokenKind.COMMA)) {
            let atComma = it.mark()
            let next = parseConstraint(it.next().getOrThrow()) ?? break
            if (next.upperBounds.isEmpty()) {
                it.rewindTo(atComma)
                break
            }
            constraints.add(next)
        }

        if (constraints.isEmpty()) {
            logger.error(whereTok, "Missing generic constraints")
        }

        return DeriveInterfaceOption(interfaceName,
            resolved,
            whereTok, constraints.toArray())
    }

    private func parseConstraint(lastTok: Token): ?ParsedGenericConstraint {
        match (it.next()) {
            case None =>
                logger.error(lastTok, "Expected generic param or interface name")
                return None
            case Some(t) where t.kind != TokenKind.IDENTIFIER =>
                logger.error(t, "Expected generic param or interface name")
                paramsRecover(t)
                return None
            case Some(id) =>
                if (it.seeing(TokenKind.COMMA) || it.seeing(TokenKind.WHERE) || it.peek().isNone()) {
                    return ParsedGenericConstraint(Identifier(id), [])
                }
                if (!it.seeing(TokenKind.UPPERBOUND)) {
                    expectedUpperBoundError(id)
                    return None
                }
                it.next()
                let upperBounds = parseUpperBounds()
                return ParsedGenericConstraint(Identifier(id), upperBounds)
        }
    }

    private func expectedUpperBoundError(id: Token): Unit {
        var reported = false
        if (it.seeing(TokenKind.LT)) {
            let start = it.mark()
            parseRef(id)
            it.pushback()
            if (it.next().getOrThrow().kind == TokenKind.GT) {
                let end = it.mark()
                logger.error(it.slice(start, end), "Generic constraint should be applied to a generic parameter without parameters")
                reported = true
            } else {
                it.rewindTo(start)
            }
        }

        if (!reported) {
            logger.error(it.peek() ?? id, "Expected upper bound operator '<:'")
        }

        // recovery
        while (let Some(next) <- it.next()) {
            if (next.kind == TokenKind.COMMA) {
                break
            }
            if (next.kind == TokenKind.UPPERBOUND) {
                parseUpperBounds()
            }
        }
    }

    private func parseUpperBounds(): Array<TypeNode> {
        let result = ArrayList<TypeNode>()
        result.add(parseType() ?? return [])
        while (it.seeing(TokenKind.BITAND)) {
            it.next()
            result.add(parseType() ?? break)
        }
        return result.toArray()
    }

    private func createFuncType(
        params: ArrayList<TypeNode>,
        returnType: TypeNode,
        arrow: ?Token,
        lParen: ?Token,
        rParen: ?Token
    ): FuncType {
        let f = FuncType()
        f.types = params
        f.returnType = returnType
        if (let Some(arrow) <- arrow) {
            f.arrow = arrow
        }
        if (let Some(lParen) <- lParen) {
            f.lParen = lParen
        }
        if (let Some(rParen) <- rParen) {
            f.rParen = rParen
        }
        return f
    }

    private func createTupleType(
        components: ArrayList<TypeNode>,
        lParen: ?Token,
        rParen: ?Token
    ): TypeNode {
        if (components.size == 1) {
            return components[0]
        }
        let t = TupleType()
        t.types = components
        if (let Some(lParen) <- lParen) {
            t.lParen = lParen
        }
        if (let Some(rParen) <- rParen) {
            t.rParen = rParen
        }
        return t
    }

    private func createPrefixOptionType(node: TypeNode): TypeNode {
        let quest = PrefixType()
        quest.baseType = node
        quest.prefixOps = quote(?)
        return quest
    }

    private func parseSeq(close!: TokenKind): (ArrayList<TypeNode>, ?Token) {
        let result = ArrayList<TypeNode>()
        var endFound: ?Token = None
        while (true) {
            let first = it.peek() ?? break
            if (first.kind == close) {
                endFound = first
                it.next()
                break
            }
            result.add(parseType() ?? break)
            if (it.seeing(TokenKind.COMMA)) {
                it.next()
            }
        }
        return (result, endFound)
    }

    private func parseRef(id: Token): RefType {
        let ref = RefType()
        ref.identifier = id
        if (it.seeing(TokenKind.LT)) {
            // generics
            let opening = it.next()
            let (args, ending) = parseSeq(close: TokenKind.GT)
            ref.typeArguments = args
            ref.lAngle = opening ?? Token(TokenKind.LT, "<")
            ref.rAngle = ending ?? Token(TokenKind.GT, ">")
        }
        return ref
    }

    private func parseRef(): ?RefType {
        if (let Some(id) <- it.next()) {
            if (id.kind != TokenKind.IDENTIFIER) {
                logger.error(id, "Expected type identifier")
                return None
            }
            return parseRef(id)
        }
        reportEof("Expected type identifier but got end")
        return None
    }

    // ~ std.ast.parseTypeFragment
    private func parseType(): ?TypeNode {
        match (it.next()) {
            case Some(lParen) where lParen.kind == TokenKind.LPAREN =>
                return parseFuncOrTupleType(lParen)
            case Some(t) where t.kind == TokenKind.QUEST =>
                return createPrefixOptionType(parseType() ?? return None)
            case Some(t) where t.kind == TokenKind.COALESCING =>
                return createPrefixOptionType(createPrefixOptionType(parseType() ?? return None))
            case Some(id) where id.kind == TokenKind.IDENTIFIER =>
                return parseQualifiedType(id)
            case Some(p) where isPrimitiveKind(p.kind) =>
                let t = PrimitiveType()
                t.keyword = p
                return t
            case Some(other) =>
                logger.error(other, "Unexpected token while parsing type")
                return None
            case None =>
                reportEof("Expected type but got end")
                return None
        }
    }

    private func reportEof(message: String): Unit {
        let at = it.last() ?? throw Exception("Failed to parse type: no tokens passed")
        logger.error(at, message)
    }

    private func parseFuncOrTupleType(lParen: Token): ?TypeNode {
        let (seq, rParen) = parseSeq(close: TokenKind.RPAREN)
        if (it.seeing(TokenKind.ARROW)) {
            // function type
            let arrow = it.next()
            let returnType = parseType() ?? return None
            return createFuncType(seq, returnType, arrow, lParen, rParen)
        }
        if (seq.isEmpty()) {
            logger.error(lParen, "Expected -> on function type")
        }

        return createTupleType(seq, lParen, rParen)
    }

    private func parseQualifiedType(firstId: Token): ?TypeNode {
        var current: TypeNode = parseRef(firstId)
        while (it.seeing(TokenKind.DOT)) {
            let q = QualifiedType()
            q.dot = it.next().getOrThrow()
            q.baseType = current
            if (it.peek().isNone()) {
                logger.error(q.dot, "Expected type after dot")
                return current
            }
            let next = parseRef() ?? break
            q.identifier = next.identifier
            q.typeArguments = next.typeArguments
            current = q
        }
        // note: we don't need to handle generics here because it's already done in parseRef
        return current
    }

    private static func isPrimitiveKind(kind: TokenKind): Bool {
        match (kind) {
            case TokenKind.INT64 |
                TokenKind.INT32 |
                TokenKind.INT16 |
                TokenKind.INT8 |
                TokenKind.UINT64 |
                TokenKind.UINT32 |
                TokenKind.UINT16 |
                TokenKind.UINT8 |
                TokenKind.UNIT |
                TokenKind.NOTHING |
                TokenKind.FLOAT16 |
                TokenKind.FLOAT32 |
                TokenKind.FLOAT64
                 => true
            case _ => false
        }
    }

    private static func repalceWrongTokens(input: Tokens): Tokens {
        input |> flatMap { tkn: Token =>
            match (tkn.kind) {
                case TokenKind.RSHIFT => [
                    Token(TokenKind.GT, ">").addPosition(tkn.pos.fileID, tkn.pos.line, tkn.pos.column),
                    Token(TokenKind.GT, ">").addPosition(tkn.pos.fileID, tkn.pos.line, tkn.pos.column + 1)
                ]
                case TokenKind.LSHIFT => [
                    Token(TokenKind.LT, "<").addPosition(tkn.pos.fileID, tkn.pos.line, tkn.pos.column),
                    Token(TokenKind.LT, "<").addPosition(tkn.pos.fileID, tkn.pos.line, tkn.pos.column + 1)
                ]
                case _ => [tkn]
            }
        } |> collectTokens
    }
}
