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

class ShrinkDeriving <: Deriving {
    private static let SHRINK_NAME = QualifiedName("std.unittest.prop_test.Shrink")
    private static let SHRINK_INFO = DerivingInterfaceInfo(
        SHRINK_NAME, [], GenericsInjector.singleRecursive()
    )

    public override prop name: String {
        get() { "Shrink"}
    }

    public override prop description: String {
        get() { "Shrink"}
    }

    public override prop supportedInterfaces: Array<QualifiedName> {
        get() { [SHRINK_NAME] }
    }

    public override func queryInterfaceInfo(interfaceName: QualifiedName): DerivingInterfaceInfo {
        if (interfaceName != SHRINK_NAME) {
            throw IllegalArgumentException("Interface ${interfaceName} is not supported")
        }
        return SHRINK_INFO
    }

    public override func derive(
        _: Tokens,
        target: DerivingTarget,
        logger: Logger
    ): Tokens {
        let targetType = target.toType()

        func enumEmptyCtorShurnks() { target.enumCases |>
            filter { ecase: TargetEnumCase => ecase.fields.isEmpty() } |>
            map { ecase: TargetEnumCase => ecase.createCall(targetType) { it, _ => it } } |>
            map<ToTokens, ToTokens> { ctorCall => quote([$ctorCall]) } |>
            collectArray
        }

        let enumCtorArgTransform: (TypeNode, Int64)->ToTokens = { _: TypeNode, i: Int64 =>
            Token(IDENTIFIER, "__a${i}")
        }

        var shrinkerBody: ToTokens = matchBodyEnumShrink(target, enumCtorArgTransform) { enumCase =>
            let extraCtors = if (enumCase.constructor.typeArguments.isEmpty()) { Array<ToTokens>() } else { enumEmptyCtorShurnks() }
            constructorShrink(targetType, extraCtors) { transformArg: (ToTokens, Bool) -> ToTokens =>
                enumCase.createCall(targetType) { param: TypeNode, i: Int64 =>
                    transformArg(
                        enumCtorArgTransform(param, i),
                        enumCase.hasExcludedField(position: i)
                    )
                }
            }
        }

        match (target.primaryConstructor) {
            case Some(pc) =>
                shrinkerBody = constructorShrink(targetType, []) { transformArg: (ToTokens, Bool) -> ToTokens =>
                    pc.createCall(targetType) { param: FuncParam, _: Int64 =>
                        if (!param.isField && !target.hasField(name: param.identifier)) {
                            logger.error(
                                param.identifier,
                                "Primary constructor parameter '${param.identifier.toTokens()}' has to be field for Shrink deriving"
                            )
                        }
                        transformArg(param.identifier, target.hasExcludedField(name: param.identifier))
                    }
                }

            case _ where target.declaration is ClassDecl || target.declaration is StructDecl =>
                logger.error(target.declaration.identifier, "Primary constructor is required for Shrink deriving")
            case _ => ()
        }

        let e = target.createExtendSkeleton()
        e.body.decls.add(FuncDecl(quote(
            public func shrink(): Iterable<$(targetType)> {
                $(shrinkerBody)
            }
        )))

        e.appendAllConstraints(this, target, SHRINK_NAME)
        return e.toTokens()
    }


    static init() {
        registerDeriving(ShrinkDeriving())
    }
}

private func matchBodyEnumShrink(
    target: DerivingTarget,
    ctorArgTransform: (TypeNode, Int64)->ToTokens,
    constructorShrink: (TargetEnumCase) -> ToTokens
): ToTokens {
    if (target.enumCases.isEmpty()) { return quote([]) }
    let cases = Tokens()

    for (ecase in target.enumCases) {
        let ctorShrink = constructorShrink(ecase)
        let ctorPattern = ecase.createCall(target.toType(), ctorArgTransform)
        quote(case $ctorPattern => $ctorShrink) |> cases.append
        Token(NL, "\n") |> cases.append; ()
    }

    quote(
        match (this) {
            $cases
            $(enumFallback(target))
        }
    )
}

private func constructorShrink(
    ofType: TypeNode,
    extraCandidates: Iterable<ToTokens>,
    constructorCall: (transformArg: (ToTokens, Bool) -> (ToTokens)) -> ToTokens
): ToTokens {
    let block = Block()

    let args = ArrayList<ToTokens>()
    let argInterceptor: (ToTokens, Bool) -> ToTokens = { arg: ToTokens, isIgnored: Bool =>
        if (!isIgnored) {
            args.add(arg)
        }
        arg
    }

    let ctorCall = constructorCall(argInterceptor)

    let shrunkCtorExprs = args |> map<ToTokens, ToTokens>{ arg =>
        quote(LazySeq.of($(arg).shrink()).map<$(ofType)> { $(arg) => $ctorCall })
    }

    let seqIds = ArrayList<ToTokens>()
    var seqIdx = 0
    for (shrunkExpr in extraCandidates |> (shrunkCtorExprs |> concat)) {
        let seqId = Token(IDENTIFIER, "__s${seqIdx}")
        seqIdx++
        seqId |> seqIds.add

        quote(let $seqId: Iterable<$(ofType)> = $shrunkExpr) |> parseDecl |> block.nodes.add
    }

    if (seqIds.isEmpty()) {
        return quote([])
    }

    quote(ShrinkHelpers.mix<$(ofType)>($(seqIds |> commaSeparated))) |> parseExpr |> block.nodes.add
    block
}

extend DerivingTarget {
    func hasField(name!: Token): Bool {
        namedFields |> any<TargetNamedAttribute> { it => it.identifier.value == name.value }
    }
}

extend FuncParam {
    prop isField: Bool {
        get() {
            keyword != Token()
        }
    }
}
