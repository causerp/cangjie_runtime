/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
protected package std.deriving.builtins

import std.deriving.api.*
import std.deriving.resolve.Types
import std.ast.*
import std.collection.*

class ToStringDeriving <: Deriving {
    public override prop name: String {
        get() { "ToString"}
    }

    public override prop description: String {
        get() { "ToString"}
    }

    public override prop supportedInterfaces: Array<QualifiedName> {
        get() { [toStringInfo.name]}
    }

    public override func queryInterfaceInfo(interfaceName: QualifiedName): DerivingInterfaceInfo {
        if (interfaceName != toStringInfo.name) {
            throw IllegalArgumentException("Unsupported interface ${interfaceName}")
        }

        return toStringInfo
    }

    private static let toStringInfo = DerivingInterfaceInfo(
        QualifiedName("std.core.ToString"), [], GenericsInjector.noGenerics())

    public override func derive(
        _: Tokens,
        target: DerivingTarget,
        _: Logger
    ): Tokens {
        let targetTypeNameLiteral = Token(TokenKind.STRING_LITERAL, target.declaration.identifier.value)
        let stringBuilderHead = quote(
            let sb = StringBuilder()
            sb.append($targetTypeNameLiteral)
        )
        let sbToString = quote(
            return sb.toString()
        )
        let generatedAppends = match {
            case target.enumCases.isEmpty() &&
                target.namedFields.isEmpty() =>
                    let literalWithPars = Token(TokenKind.STRING_LITERAL, "${target.declaration.identifier.value}()")
                    quote(
                        return $literalWithPars
                    )
            case target.enumCases.isEmpty() =>
                stringBuilderHead +
                (namedAppendsFor(target) |> joinAppends(ifEmpty: quote(
                    sb.append("()")
                ))) + sbToString
            case _ =>
                stringBuilderHead + (target.enumCases |>
                    map { c: TargetEnumCase => enumCaseAppends(c, target) } |>
                    joinTokens(
                        delimiter: Tokens(Token(TokenKind.NL, "\n")),
                        prefix: quote(
                            match (this) {
                        ), postfix: quote(
                                $(enumFallback(target))
                            }
                        ), ifEmpty: quote()
                    )) + sbToString
        }

        let toStringFunc = FuncDecl(quote(
            public func toString(): String {
                $generatedAppends
            }
        ))

        let ext = target.createExtendSkeleton()
        ext.appendAllConstraints(this, target, toStringInfo.name)

        ext.body.decls.add(toStringFunc)

        return ext.toTokens()
    }

    private func namedAppendsFor(target: DerivingTarget): Iterator<Tokens> {
        target.namedFields |> map { field: TargetNamedAttribute =>
            let idToken = field.identifier.token
            let idLiteral = Token(TokenKind.STRING_LITERAL, idToken.value)
            quote(
                sb.append($idLiteral)
                sb.append(": ")
                sb.append(this.$idToken.toString())
            )
        }
    }

    private func enumCaseAppends(enumCase: TargetEnumCase, target: DerivingTarget): Tokens {
        func varNameFor(field: TargetEnumField): Token {
            let prefix = match {
                case Types.isString(field.fieldType) => "str"
                case Types.isIntType(field.fieldType) => "i"
                case Types.isFloatType(field.fieldType) => "fl"
                case _ => "field"
            }
            Token(TokenKind.IDENTIFIER, "${prefix}${field.position}")
        }

        let destructuring = enumCase.components |> map { field: ?TargetEnumField =>
            match (field) {
                case Some(field) => Tokens(varNameFor(field))
                case None => quote(_)
            }
        } |> joinTokens(delimiter: quote(,), prefix: quote(\(), postfix: quote(\)), ifEmpty: quote())

        let caseId = enumCase.constructor.identifier
        let formatting = enumCase.fields |> map { field: TargetEnumField =>
            let boundVar = varNameFor(field)
            quote(
                sb.append($boundVar.toString())
            )
        } |> concat(namedAppendsFor(target)) |>
            joinAppends(
                ifEmpty: if (enumCase.totalArgumentsCount == 0) {
                    quote(\(\))
                } else {
                    quote(sb.append("()"))
                }
            )

        let caseIdStr = Token(TokenKind.STRING_LITERAL, "." + caseId.value)
        quote(
            case $caseId $destructuring =>
                sb.append($caseIdStr)
                $formatting
        )
    }

    private static func joinAppends(ifEmpty!: Tokens): (Iterable<Tokens>) -> Tokens {{ iter =>
        iter |> joinTokens(
            prefix: quote(
                sb.append("(")
            ),
            postfix: quote(
                sb.append(")")
            ),
            delimiter: quote(
                sb.append(", ")
            ),
            ifEmpty: ifEmpty
        )
    }}

    static init() {
        registerDeriving(ToStringDeriving())
    }
}
