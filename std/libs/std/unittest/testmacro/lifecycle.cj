/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

macro package std.unittest.testmacro

import std.ast.*
import std.collection.*

struct LifecycleStage <: Hashable & Equatable<LifecycleStage> {
    let deprecatedFuncName: String

    LifecycleStage(
        let stageName: String,
        let macroKey: MacroKey,
        let allowsStringParameter!: Bool
    ) {
        deprecatedFuncName = stageName
    }

    public func hashCode(): Int64 {
        return stageName.hashCode()
    }

    public operator func ==(that: LifecycleStage): Bool {
        return this.stageName == that.stageName
    }

    public operator func !=(that: LifecycleStage): Bool {
        return this.stageName != that.stageName
    }
}

let lifecycleStages: Array<LifecycleStage> = [
    LifecycleStage("beforeAll", BEFORE_ALL_MACRO, allowsStringParameter: false),
    LifecycleStage("beforeEach", BEFORE_EACH_MACRO, allowsStringParameter: true),
    LifecycleStage("afterEach", AFTER_EACH_MACRO, allowsStringParameter: true),
    LifecycleStage("afterAll", AFTER_ALL_MACRO, allowsStringParameter: false)
]

let _ = { =>
    for (ls in lifecycleStages) {
        VERIFIERS[ls.macroKey] = LifecycleStages.lifecycleVerifier(ls)
    }
}()

class LifecycleStages {
    static func lifecycleVerifier(ls: LifecycleStage): Verifier {
        { _: MacroAttrs, decl: Decl, errors: MacroErrors =>
            if (let Some(funcDecl) <- (decl as FuncDecl)) {
                verifyLifecycleFunction(funcDecl, ls, errors)
            }
        }
    }

    static func registerLifecycleStages(bodyDecls: ArrayList<Decl>, tb: TokensBuilder): Unit {
        let funcsByStage = HashMap<LifecycleStage, ArrayList<FuncDecl>>()
        for (ls in lifecycleStages) {
            funcsByStage[ls] = ArrayList<FuncDecl>()
        }

        for (decl in bodyDecls) {
            let funcDecl = decl as FuncDecl ?? continue
            for (ls in lifecycleStages) {
                // funcs annotated as several stages are allowed
                if (funcDecl.has(ls.macroKey)) {
                    funcsByStage[ls].add(funcDecl)
                }
            }

            if (let Some(deprecatedLifecycleStage) <- funcDecl.getDeprecatedLifecycleStage()) {
                funcsByStage[deprecatedLifecycleStage].add(funcDecl)
                reportDeprecation(deprecatedLifecycleStage)
            }
        }

        for ((ls, annotatedFuncs) in funcsByStage where !annotatedFuncs.isEmpty()) {
            registerLifecycleStage(ls, annotatedFuncs, tb)
        }
    }

    private static func registerLifecycleStage(ls: LifecycleStage, annotatedFuncs: ArrayList<FuncDecl>,
        tb: TokensBuilder) {
        let buildFunctionName = Token(IDENTIFIER, ls.stageName)
        tb.append(quote(suiteBuilder.$buildFunctionName))
        let caseName = Token(IDENTIFIER, "__testCaseName")
        tb.curlyBraces { tb =>
            let argUsed = annotatedFuncs |> any { it: FuncDecl => !it.funcParams.isEmpty() }
            if (argUsed) {
                tb.append(quote($caseName: String => ))
            } else {
                tb.append(quote( =>))
            }

            for (annotatedFunc in annotatedFuncs) {
                let funcToCall = annotatedFunc.identifier
                let param = annotatedFunc.funcParams.iterator().next()
                match (param) {
                    case None => tb.append(quote($funcToCall())).append(NL)
                    case Some(param) where param.isNamed =>
                        let paramName = param.identifier
                        tb.append(quote($funcToCall($paramName: $caseName))).append(NL)
                    case Some(param) =>
                        tb.append(quote($funcToCall($caseName))).append(NL)
                }
                tb.append(NL)
            }
        }
    }

    private static func verifyLifecycleFunction(funcDecl: FuncDecl, ls: LifecycleStage, errors: MacroErrors) {
        if (funcDecl.isGenericDecl) {
            errors.add("${ls.macroKey} function cannot be generic.")
        }
        if (funcDecl.funcParams.isEmpty()) {
            return
        }
        if (!ls.allowsStringParameter) {
            errors.add("${ls.macroKey} function cannot have parameters.")
            return
        }
        if (funcDecl.funcParams.size != 1) {
            errors.add("${ls.macroKey} function can only have a single String parameter.")
            return
        }
        match (funcDecl.funcParams[0].paramType) {
            case paramType: RefType where paramType.identifier.value == "String" && paramType.typeArguments.isEmpty() => ()
            case _ => errors.add("Parameter of ${ls.macroKey} function must be of type String.")
        }
    }

    static func transformFunction(funcDecl: FuncDecl, tb: TokensBuilder): Unit {
        if (funcDecl.getDeprecatedLifecycleStage().isNone()) {
            tb.append(funcDecl).append(NL)
            return
        }

        for (token in funcDecl.toTokens()) {
            if (token.kind != TokenKind.OVERRIDE) {
                tb.append(token)
            }
        }
    }

    private static func reportDeprecation(ls: LifecycleStage) {
        let message = "Warning: overriding func '${ls.deprecatedFuncName}' is deprecated and will be disallowed in a subsequent release. " +
            "Use ${ls.macroKey} macro instead."
        println(message)
    }
}

extend FuncDecl {
    func getDeprecatedLifecycleStage(): ?LifecycleStage {
        if (!funcParams.isEmpty()) {
            return None
        }

        var result: ?LifecycleStage = None
        for (ls in lifecycleStages) {
            if (this.has(ls.macroKey)) {
                return None
            }

            if (ls.deprecatedFuncName == this.identifier.value) {
                result = ls
            }
        }

        return result
    }
}

extend FuncParam {
    prop isNamed: Bool {
        get() {
            not.kind != TokenKind.ILLEGAL
        }
    }
}
