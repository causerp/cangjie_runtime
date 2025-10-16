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

class EquatableDeriving <: Deriving {
    private static let EQUATABLE_NAME = QualifiedName("std.core.Equatable")
    private static let EQUATABLE_INFO = DerivingInterfaceInfo(
        EQUATABLE_NAME, [], GenericsInjector.singleRecursive()
    )

    public override prop name: String {
        get() { "Equatable"}
    }

    public override prop description: String {
        get() { "Equatable"}
    }

    public override prop supportedInterfaces: Array<QualifiedName> {
        get() { [EQUATABLE_NAME]}
    }

    public override func queryInterfaceInfo(interfaceName: QualifiedName): DerivingInterfaceInfo {
        if (interfaceName != EQUATABLE_NAME) {
            throw IllegalArgumentException("Interface ${interfaceName} is not supported")
        }
        return EQUATABLE_INFO
    }

    public override func derive(
        _: Tokens,
        target: DerivingTarget,
        _: Logger
    ): Tokens {
        let namedMembersCondition = target.namedFields |> map { f: TargetNamedAttribute =>
            let member = f.identifier.token
            quote(this.$member == other.$member)
        } |> collectArray

        let caseKeyword = Token(TokenKind.CASE, "case")
        let fallbackCase = if (target.enumCases.size != 1 || isEnumHasEllipsis(target)) {
            quote($caseKeyword _ => false)
        } else {
            quote()
        }

        let condition = if (target.enumCases.isEmpty()) {
            namedMembersCondition |> joinTokens(delimiter: quote(&&), ifEmpty: quote(true))
        } else {
            target.enumCases |> map<TargetEnumCase, Tokens> { enumCase =>
                let left = destructEnumCase(enumCase, "left")
                let right = destructEnumCase(enumCase, "right")
                let condition = enumCasesCompare(enumCase) |>
                    concat(namedMembersCondition) |>
                    joinTokens(delimiter: quote(&&), ifEmpty: quote(true))

                quote(
                    $caseKeyword ($left, $right) => $condition
                )
            } |> joinTokens(
                prefix: quote(match ((this, other)) {),
                postfix: quote(
                        $fallbackCase
                    })
            )
        }

        let otherName = if (namedMembersCondition.isEmpty() && target.enumCases.isEmpty()) {
            Token(TokenKind.WILDCARD, "_")
        } else {
            Token(TokenKind.IDENTIFIER, "other")
        }

        let targetType = target.toType()
        let e = target.createExtendSkeleton()
        e.body.decls.add(FuncDecl(quote(
            public operator func ==($otherName: $targetType): Bool {
                return $condition
            }
        )))
        e.body.decls.add(FuncDecl(quote(
            public operator func !=(other: $targetType): Bool {
                !(this == other)
            }
        )))

        e.appendAllConstraints(this, target, EQUATABLE_NAME)

        return e.toTokens()
    }

    private static func enumCasesCompare(enumCase: TargetEnumCase): Iterable<Tokens> {
        if (enumCase.totalArgumentsCount == 0) {
            return []
        }

        return enumCase.fields |> map<TargetEnumField, Tokens> { f =>
            let left = Token(TokenKind.IDENTIFIER, "left${f.position}")
            let right = Token(TokenKind.IDENTIFIER, "right${f.position}")
            quote($left == $right)
        }
    }

    static init() {
        registerDeriving(EquatableDeriving())
    }
}
