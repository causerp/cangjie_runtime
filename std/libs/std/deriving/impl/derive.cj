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

public func deriveImpl(
    rawOptions: Tokens,
    input: Tokens,
    decl: Decl,
    includes: Array<Identifier>,
    excludes: Array<Identifier>,
    ordering: Array<Identifier>,
    logger: Logger
): Tokens {
    let options = parseDeriveOptions(rawOptions, logger)

    let inputNames = options |>
        map<DeriveInterfaceOption, QualifiedName> { info =>
            info.resolvedInterface
        } |> collectArray

    let allInterfaces = collectInterfaceNames(inputNames)
    let inputOptions = InputOptions(
        options,
        inputNames,
        allInterfaces,
        decl,
        includes,
        excludes,
        ordering
    )

    let (derivings, unresolved) = allInterfaces |> findDerivings
    let diagnosticsExtends = ArrayList<ExtendDecl>()
    var result = Tokens()

    if (let Some(output) <- settingsFor(inputOptions, logger)) {
        diagnosticsExtends.add(all: diagnose(inputOptions, output.target, logger))
        runDerivings(input, derivings, result, options, output, logger)
    }

    for (name in unresolved) {
        logger.error(name.simpleName, "Deriving for ${name} is not supported")
    }

    let NL = Token(TokenKind.NL, "\n")
    input + NL + result +
        (diagnosticsExtends |>
            map<ExtendDecl, Tokens> { e => e.toTokens() } |>
            joinTokens(delimiter: Token(TokenKind.NL, "\n"))
        )
}

private func runDerivings(
    input: Tokens,
    derivings: Array<(Deriving, Array<QualifiedName>)>,
    result: Tokens,
    options: Array<DeriveInterfaceOption>,
    output: SettingsOutput,
    logger: Logger
): Unit {
    for ((deriving, interfaces) in derivings) {
        try {
            result.append(deriving.derive(input, output.target, logger))
        } catch (cause: Exception) {
            reportError(cause, interfaces, options, logger)
        }
    }
}

private func reportError(
    cause: Exception,
    interfaces: Array<QualifiedName>,
    options: Array<DeriveInterfaceOption>,
    logger: Logger
) {
    cause.printStackTrace()
    for (o in options) {
        if (interfaces |> any { it: QualifiedName => Identifier(it.simpleName) == o.interfaceName }) {
            logger.error(o.interfaceName.token, "Deriving failed for ${o.interfaceName}: ${cause.toString()}")
        }
    }
}

private func collectInterfaceNames(inputNames: Array<QualifiedName>): Array<QualifiedName> {
    let foundNames = HashSet<QualifiedName>(inputNames)
    let nextStage = HashSet<QualifiedName>(inputNames)

    func handle(deriving: Deriving, names: Array<QualifiedName>): Iterable<QualifiedName> {
        names |> map<QualifiedName, Iterable<QualifiedName>> { name =>
            deriving.queryInterfaceInfo(name).superTypes
        } |> flatten |> filter<QualifiedName> { name => foundNames.add(name) }
    }

    do {
        let (derivings, _) = nextStage.toArray() |> findDerivings
        let addedNames = derivings |> map { pair: (Deriving, Array<QualifiedName>) =>
            handle(pair[0], pair[1])
        } |> flatten |> collectArray

        nextStage.clear()
        nextStage.add(all: addedNames)
    } while (!nextStage.isEmpty())

    return foundNames.toArray()
}
