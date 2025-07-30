/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
macro package std.unittest.testmacro

import std.ast.*

public macro TestBuilder(input: Tokens): Tokens {
    return topLevelMacroDriver(TEST_BUILDER_MACRO, input, Tokens(), { it => insideParentContext(it.macroIdentifier) })
}

func emitTestBuilder(decl: Decl, originalTokens: Tokens): Tokens {
    let funcDecl = verifyDeclShape(decl)
    let tb = TokensBuilder()
    tb.append(originalTokens).append(NL)
    tb.append(buildRegistrationFunction(funcDecl)).append(NL)
    return tb.toTokens()
}

private func buildRegistrationFunction(funcDecl: FuncDecl): Tokens {
    let registerFuncName = Token(IDENTIFIER, "register_${funcDecl.identifier.value}")
    let extensionInterface = Token(IDENTIFIER, "TestPackageExtension_" + funcDecl.identifier.value)
    let suiteBuilder = generateBuildSuite(funcDecl)
    quote(
        interface $extensionInterface {
            func $registerFuncName(): Unit
        }
        extend TestPackage <: $extensionInterface {
            @Attribute[TEST_REGISTER]
            public func $registerFuncName() {
                registerSuite({ =>
                    $suiteBuilder
                })
            }
        }
    )
}

private func generateBuildSuite(funcDecl: FuncDecl): Tokens {
    let rawConfiguration = loadFuncConfiguration(funcDecl)
    let funcIdent = funcDecl.identifier
    if (rawConfiguration.isEmpty()) {
        return quote($funcIdent())
    }
    let tb = TokensBuilder()
    let configurationVariableName = Token(IDENTIFIER, "__configuration")
    buildConfiguration(rawConfiguration, configurationVariableName, tb)
    tb.append(quote(TestSuite.builder($funcIdent()).configure($configurationVariableName).build()))
    tb.toTokens()
}

private let wrongTargetMessage = "@TestBuilder macro must be put on a function without parameters."

// NOTE: sadly cannot verify that function is top level
private func verifyDeclShape(decl: Decl): FuncDecl {
    let funcDecl = (decl as FuncDecl) ?? throw MacroException(wrongTargetMessage)
    if (!funcDecl.funcParams.isEmpty()) {
        throw MacroException(wrongTargetMessage)
    }
    let returnType = try {
        funcDecl.declType
    } catch (e: ASTException) {
        throw MacroException("@TestBuilder function must have return type explicitly specified.")
    }
    if ((returnType as RefType)?.identifier.value != "TestSuite") {
        throw MacroException("@TestBuilder function must return 'TestSuite'.")
    }
    return funcDecl
}
