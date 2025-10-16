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

class HashableDeriving <: Deriving {
    private static let HASHABLE_NAME = QualifiedName("std.core.Hashable")
    private static let HASHABLE_INFO = DerivingInterfaceInfo(
        HASHABLE_NAME, [], GenericsInjector.noGenerics()
    )

    public override prop name: String {
        get() { "Hashable"}
    }

    public override prop description: String {
        get() { "Hashable"}
    }

    public override prop supportedInterfaces: Array<QualifiedName> {
        get() { [HASHABLE_NAME] }
    }

    public override func queryInterfaceInfo(interfaceName: QualifiedName): DerivingInterfaceInfo {
        if (interfaceName != HASHABLE_NAME) {
            throw IllegalArgumentException("Interface ${interfaceName} is not supported")
        }
        return HASHABLE_INFO
    }

    public override func derive(
        _: Tokens,
        target: DerivingTarget,
        _: Logger
    ): Tokens {
        let namedMembersCondition = target.namedFields |> map { f: TargetNamedAttribute =>
            let member = f.identifier.token
            quote(
                hasher = hh(hasher, this.$member)
            )
        } |> joinTokens()

        let casesMatch = casesMatch(target)

        let e = target.createExtendSkeleton()
        e.body.decls.add(FuncDecl(quote(
            public func hashCode(): Int64 {
                var hasher = DefaultHasher()
                $casesMatch
                $namedMembersCondition
                return hasher.finish()
            }
        )))
        e.appendFunction(quote(
            private func hh<T>(hasher: DefaultHasher, item: T): DefaultHasher where T <: Hashable {
                var hasher2 = hasher
                hasher2.write(item.hashCode())
                return hasher2
            }
        ))
        e.appendFunction(quote(
            private func hh<T>(hasher: DefaultHasher, item: Int64): DefaultHasher {
                var hasher2 = hasher
                hasher2.write(item)
                return hasher2
            }
        ))
        e.appendFunction(quote(
            private func hh<T>(hasher: DefaultHasher, item: String): DefaultHasher {
                var hasher2 = hasher
                hasher2.write(item)
                return hasher2
            }
        ))

        e.appendAllConstraints(this, target, HASHABLE_NAME)

        return e.toTokens()
    }

    private func casesMatch(target: DerivingTarget): Tokens {
        target.enumCases |> enumerate |>
            map { pair: (Int64, TargetEnumCase) =>
                let enumCase = pair[1]
                let d = destructEnumCase(enumCase, "v")
                let caseHash = enumCaseHash(enumCase) |> joinTokens()
                let indexLiteral = Token(TokenKind.INTEGER_LITERAL, pair[0].toString())

                quote(
                    case $d =>
                        hasher.write($indexLiteral)
                        $caseHash
                )
            } |> joinTokens(
                prefix: quote(match (this) {),
                postfix: quote(
                    $(enumFallback(target))
                }),
                ifEmpty: quote()
            )
    }

    private static func enumCaseHash(enumCase: TargetEnumCase): Iterable<Tokens> {
        if (enumCase.totalArgumentsCount == 0) {
            return []
        }

        return enumCase.fields |> map<TargetEnumField, Tokens> { f =>
            let member = Token(TokenKind.IDENTIFIER, "v${f.position}")
            quote(
                hasher = hh(hasher, $member)
            )
        }
    }

    static init() {
        registerDeriving(HashableDeriving())
    }
}
