/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
macro package std.unittest.mock.mockmacro

import std.ast.*

public macro On(tokens: Tokens): Tokens {
    parseAndGenerate(tokens) { stubCall, description =>
        match (stubCall.kind) {
            case Function => generateStubFunction(stubCall, description)
            case Getter => generateStubGetter(stubCall, description)
            case Setter(getterCall) => generateStubSetter(stubCall, getterCall, description)
        }
    }
}

public macro Called(tokens: Tokens): Tokens {
    parseAndGenerate(tokens) { stubCall, description =>
        generateVerifyStatement(stubCall, description)
    }
}

func parseAndGenerate(tokens: Tokens, generate: (Stub, Token) -> Tokens): Tokens {
    if (tokens.size == 0) {
        reportSyntaxErrors(SyntaxError.parser())
    }
    let description = rawStringLiteral(descriptionString(tokens))
    let preprocessed = preprocess(tokens)
    let parsedStub = try {
        parseStubCall(
            tokens,
            ensureSingleExpr(preprocessed) ?? reportSyntaxErrors(SyntaxError.stub(tokens))
        )
    } catch (e: Exception) {
        reportSyntaxErrors(SyntaxError.stub(tokens))
    }
    match (parsedStub) {
        case Success(stubCall) => return generate(stubCall, description)
        case Error(errors) => reportSyntaxErrors(errors)
    }
}

func ensureSingleExpr(input: Tokens): ?Expr {
    let fakeCall = quote(fakeCall($input))
    let parsedFakeCall = (parseExpr(fakeCall) as CallExpr) ?? return None

    match (parsedFakeCall.arguments) {
        case args where args.size == 1 => return args[0].expr
        case _ => return None
    }
}
