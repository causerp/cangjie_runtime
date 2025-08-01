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

func parseNamedCommaSeparatedExpressions(params: Tokens): Array<(Token, Expr)> {
    let paramSpec = parseExpr(quote(foo($params)))
    let callExpr = (paramSpec as CallExpr).getOrThrow()
    var callInfo: ArrayList<(Token, Expr)> = ArrayList<(Token, Expr)>()
    for (arg in callExpr.arguments) {
        callInfo.add((arg.identifier, arg.expr))
    }
    collectArray(callInfo)
}

/**
 * Parse parameters in the form @Configure[generationSteps: <number>, randomSeed: <number>, reductionSteps: <number>]
 */
func parseConfigurationMacro(params: Tokens): Array<(Token, Expr)> {
    try {
        parseNamedCommaSeparatedExpressions(params)
    } catch (_: Exception) {
        throw MacroException(
            "Illegal parameters for @Configure: ${params}," +
            "parameters should use the form @Configure[arg1: value1, arg2: value2, arg3: value3]"
        )
    }
}

func parseMeasurements(params: ArrayList<Tokens>): Array<Expr> {
    let measurements = ArrayList<Expr>()
    for (measureEntry in params) {
        var hasMeasurement = false
        try {
            for (measurement in parseCommaSeparatedExpressions(measureEntry)) {
                measurements.add(measurement)
                hasMeasurement = true
            }
        } catch (_: Exception) {
            throw MacroException("Illegal usage of @Measure: ${measureEntry}," +
            "parameters should use the form @Measure[Measurement1, Measurement2, Measurement3]," +
            "where Measurement<1,2,3> are instances of Measurement such as TimeNow()")
        }
        if (!hasMeasurement) {
            throw MacroException("Illegal usage of @Measure: expected minimum 1 argument")
        }
    }
    measurements.toArray()
}

func skipNl(tokens: Tokens, pos: Int64): Int64 {
    var next = pos
    while (next < tokens.size && tokens[next].kind == NL) {
        next += 1
    }
    next
}

/**
 * Parse macro arguments in the form @Test[x in value1, y in value2, z in value3]
 */
func parseDSLMacro(params_: ?Tokens): Array<(String, Tokens)> {
    let params = params_ ?? return []
    try {
        parseDSL(params)
    } catch (ex: Exception) {
        throw MacroException(
            "Illegal parameters for @Test: ${params}," +
            "parameters should use the form @Test[arg1 in (0..12), arg2 in [1,2,3,4], arg3 in random<Int64>()], error details:" +
            ex.message
        )
    }
}

func parseDSL(params: Tokens): Array<(String, Tokens)> {
    var i = 0
    let result = ArrayList<(String, Tokens)>()
    var leftPart: Expr = Block()
    var rightPart: Expr = Block()
    while (i < params.size) {
        (leftPart, i) = parseExprFragment(params, startFrom: i)
        if (params.get(i).kind != IN) {
            throw Exception("Expected 'in' keyword.")
        }
        (rightPart, i) = parseExprFragment(params, startFrom: i + 1)
        if (i < params.size && params[i].kind != COMMA) {
            throw Exception("Expected comma.")
        }
        i = skipNl(params, i + 1)
        match (leftPart) {
            case left: MemberAccess where (left.baseExpr as RefExpr)?.identifier.value == Some("config") =>
                // desugar config syntax into existing syntax
                let paramName = Token(STRING_LITERAL, left.field.value)
                result.add(("_", quote(
                    DataStrategyProcessor.start($rightPart, $paramName)
                        .mapWithConfig<Unit>{ x, config: Configuration =>
                            $left (x)
                        }
                )))
            case left: RefExpr where left.typeArguments.isEmpty() => result.add((left.identifier.value, rightPart.toTokens()))
            case _ => throw Exception("Left part of the parameter must consist of a single identifier or expression in a form of `config.<identifier>` ")
        }
    }
    result.toArray()
}

/**
 * Create option fully qualified name.
 * for example if identifier = `zxc`
 * then FQ name = `KeyZxc.zxc`
 */
private func createOptionFQName(identifier: Token): Tokens {
    let nameStr = identifier.value

    let structName = Token(TokenKind.IDENTIFIER, "Key" + nameStr[0..1].toAsciiUpper() + nameStr[1..])
    return quote($structName.$identifier)
}

/**
 * Taken the output of parseConfigurationMacro, build code that constructs a Configuration object in
 * a vaiable named `variableName`, append the code to the builder `builder`
 * @param raw the result of parseConfigurationMacro
 * @param parentConfiguration the parent configuration object expression
 * @param variableName the name of the variable to put the new configuration to
 * @param builder a TokensBuilder object to append the code to (if any), defaults to an empty builder
 * @return builder
 */
func buildConfiguration(
    raw: Array<(Token, Expr)>,
    variableName: Token,
    builder: TokensBuilder
): TokensBuilder {
    builder.append(quote(let $variableName = Configuration())).append(NL)
    for ((identifier, value) in raw) {
        let keyFQName = createOptionFQName(identifier)
        builder.append(quote($variableName.set($keyFQName, $value))).append(NL)
    }
    return builder
}

/**
 * Taken the output of parseDSLMacro, build code that constructs a DataStrategy object in
 * a vaiable named `variableName`, append the code to the builder `builder`
 * @param raw the result of parseDSLMacro
 * @param argNames the names of the function parameters we're building strategy for
 * @param argTypes the types of the function parameters we're building strategy for
 * @param variableName the variable to put resulting strategy to
 * @param builder the builder to write the code to, or new empty builder if none is provided
 * @return builder
 * @throws MacroException if the number of arguments is bigger than 5
 * @throws MacroException if the strategy code does not contain some function parameter from `argNames`
 * @throws MacroException if argNames and argTypes have different sizes
 */
func buildDataStrategy(
    raw: ArrayList<(String, Tokens)>,
    argNames: Array<String>,
    argTypes: Array<Tokens>,
    variableName: Token,
    resultingType!: Tokens = Tokens(),
    builder!: TokensBuilder = TokensBuilder()
): TokensBuilder {
    if (resultingType.size == 0) {
        builder.append(quote(let $variableName = ))
    } else {
        builder.append(quote(let $variableName : $resultingType =))
    }

    buildDataStrategyForArgs(
        raw,
        argNames,
        argTypes,
        builder: builder
    )

    // append possible config strategies
    for ((name, strat) in raw where name == "_") {
        builder.append(quote(
            .productWithUnit($strat)
        ))
    }

    builder
}

func buildDataStrategyForArgs(
    raw: ArrayList<(String, Tokens)>,
    argNames: Array<String>,
    argTypes: Array<Tokens>,
    builder!: TokensBuilder = TokensBuilder()
): TokensBuilder {
    if (argNames.size != argTypes.size) {
        throw MacroException("Argument names and argument types must have the same size")
    }
    let argMap = HashMap<String, Tokens>(raw)

    let strategies = Array(argNames.size) { ix: Int64 =>
        let strat = argMap.get(argNames[ix]) ??
            throw MacroException("No strategy provided for argument ${argNames[ix]}: ${argTypes[ix].toTokens()}")
        strat
    }

    if (strategies.size == 0) {
        builder.append(quote( DataStrategyProcessor<Unit>.start( { => [()] } ,"" ) )).append(NL)
        return builder
    }


    builder.append(
        quote( DataStrategyProcessor<$(argTypes[0])>.start( { => $(strategies[0]) } ,$(argNames[0]) ) )
    ).append(NL)
    for (i in 1..strategies.size) {
        builder.append(quote(.product(
                DataStrategyProcessor<$(argTypes[i])>.start( { => $(strategies[i]) } ,$(argNames[i]) )
            )) ).append(NL)
    }

    return builder
}
