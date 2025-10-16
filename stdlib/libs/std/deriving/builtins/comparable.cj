/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
protected package std.deriving.builtins

import std.deriving.api.*
import std.ast.*
import std.collection.*

class ComparableDeriving <: Deriving {
    private static let COMPARABLE_NAME = QualifiedName("std.core.Comparable")
    private static let COMPARABLE_INFO = DerivingInterfaceInfo(
        COMPARABLE_NAME,
        [QualifiedName("std.core.Equatable")],
        GenericsInjector.singleRecursive())

    public override prop name: String {
        get() { "Comparable"}
    }

    public override prop description: String {
        get() { "Comparable"}
    }

    public override prop supportedInterfaces: Array<QualifiedName> {
        get() { [COMPARABLE_NAME]}
    }

    public override func queryInterfaceInfo(
        interfaceName: QualifiedName
    ): DerivingInterfaceInfo {
        if (interfaceName != COMPARABLE_NAME) {
            throw IllegalArgumentException("Interface ${interfaceName} is not supported")
        }
        return COMPARABLE_INFO
    }

    private static let enumCaseShared = Token(TokenKind.CASE, "case")

    public override func derive(
        _: Tokens,
        target: DerivingTarget,
        _: Logger
    ): Tokens {
        let compareToFunc = compareFuncBody(target)
        let ext = target.createExtendSkeleton()
        ext.appendAllConstraints(this, target, COMPARABLE_NAME)
        ext.appendFunction(compareToFunc)
        if (target.enumCases.size > 1) {
            ext.appendFunction(orderingFunc(target))
        }

        let targetType = target.toType()
        ext.appendFunction(quote(
            public operator func <(other: $targetType): Bool {
                match (compare(other)) {
                    case LT => true
                    case _ => false
                }
            }
        ))
        ext.appendFunction(quote(
            public operator func <=(other: $targetType): Bool {
                match (compare(other)) {
                    case LT | EQ => true
                    case _ => false
                }
            }
        ))
        ext.appendFunction(quote(
            public operator func >(other: $targetType): Bool {
                match (compare(other)) {
                    case GT => true
                    case _ => false
                }
            }
        ))
        ext.appendFunction(quote(
            public operator func >=(other: $targetType): Bool {
                match (compare(other)) {
                    case GT | EQ => true
                    case _ => false
                }
            }
        ))

        return ext.toTokens()
    }

    private func compareFuncBody(target: DerivingTarget): FuncDecl {
        let namedComparing = target.namedFields |>
            map { field: TargetNamedAttribute =>
                let idTok = field.identifier.token
                quote(
                    match (this.$idTok.compare(other.$idTok)) {
                        case EQ => ()
                        case notEq => return notEq
                    }
                )
            } |>
            joinTokens(delimiter: Tokens(Token(TokenKind.NL, "\n")))

        let enumCaseFallback = if (target.enumCases.size != 1 || isEnumHasEllipsis(target)) {
            quote($enumCaseShared _ => ())
        } else {
            quote()
        }

        let casesComparing = target.enumCases |>
            map<TargetEnumCase, Tokens>(enumCaseCompare) |>
            joinTokens(
                prefix: quote(match ((this, other)) {),
                postfix: quote(
                    $enumCaseFallback
                }),
                delimiter: Tokens(Token(TokenKind.NL, "\n")),
                ifEmpty: quote()
            )

        let enumFallbackFunc = if (target.enumCases.size < 2) { quote() } else {
            quote(
                match (this.derivingOrdinal().compare(other.derivingOrdinal())) {
                    case EQ => ()
                    case notEq => return notEq
                }
            )
        }

        let targetType = target.toType()
        let compareFuncBody = quote(
            public func compare(other: $targetType): Ordering {
                $casesComparing
                $enumFallbackFunc
                $namedComparing
                return Ordering.EQ
            }
        )

        return (parseDecl(compareFuncBody) as FuncDecl).getOrThrow()
    }

    private static func enumCaseCompare(enumCase: TargetEnumCase): Tokens {
        let destructuringLeft = enumDestructuring(enumCase, "left")
        let destructuringRight = enumDestructuring(enumCase, "right")

        let caseId = enumCase.constructor.identifier
        let comparing = enumCase.fields |> map { field: TargetEnumField =>
            let left = enumFieldName(field, "left")
            let right = enumFieldName(field, "right")

            quote(
                match ($left.compare($right)) {
                    case EQ => ()
                    case other => return other
                }
            )
        } |> joinTokens(delimiter: Tokens(Token(TokenKind.NL, "\n")),
                ifEmpty: quote(\(\)))

        quote(
            $enumCaseShared ($caseId $destructuringLeft, $caseId $destructuringRight) =>
                $comparing
        )
    }

    private static func orderingFunc(cases: DerivingTarget): Tokens {
        let branches = cases.enumCases |>
            enumerate |>
            map { it: (Int64, TargetEnumCase) =>
                let id = it[1].constructor.identifier
                let wildcards = it[1].components |> map { _ => quote(_) } |>
                    joinTokens(delimiter: quote(,),
                        prefix: quote(\(),
                        postfix: quote(\)),
                        ifEmpty: quote())
                let ordinal = Token(TokenKind.INTEGER_LITERAL, it[0].toString())

                quote(
                    case $id $wildcards => $ordinal
                )
            } |> joinTokens()

        return quote(
            private func derivingOrdinal(): Int64 {
                match (this) {
                    $branches
                    $(enumFallback(cases))
                }
            }
        )
    }

    private static func enumFieldName(
        field: TargetEnumField,
        prefix: String
    ): Token {
        Token(TokenKind.IDENTIFIER, "${prefix}${field.position}")
    }

    private static func enumDestructuring(
        enumCase: TargetEnumCase,
        prefix: String
    ): Tokens {
        enumCase.components |> map { field: ?TargetEnumField =>
            match (field) {
                case Some(field) => Tokens(enumFieldName(field, prefix))
                case None => quote(_)
            }
        } |> joinTokens(delimiter: quote(,),
                prefix: quote(\(),
                postfix: quote(\)),
                ifEmpty: quote())
    }

    static init() {
        registerDeriving(ComparableDeriving())
    }
}
