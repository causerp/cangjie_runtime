/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
protected package std.deriving.impl

import std.deriving.api.*
import std.deriving.resolve.*
import std.ast.*
import std.collection.*

public func diagnose(
    inputOptions: InputOptions,
    target: DerivingTarget,
    logger: Logger
): Array<ExtendDecl> {
    let results = ArrayList<ExtendDecl>()
    let resolvedList: Array<(VarDecl, ?TypeNode)> = match (target.declaration) {
        case c: ClassDecl => resolveFields(c)
        case str: StructDecl => resolveFields(str)
        case _ => []
    }

    let ctorParameterTypes = target.namedFields |> mapNotNone<TargetNamedAttribute, (Decl, ?TypeNode)> { f =>
        match (f.typeNode) {
            case Some(t) => (f.decl, t)
            case None => None
        }
    }

    if (target.isSealedClass) {
        logger.error(findSealedKeyword(target.declaration), "Sealed classes are not supported")
    }
    if (target.isNonFinal) {
        logger.error(findAbstractKeyword(target.declaration),
            "Non-final classes are not supported (open, abstract or sealed)")
    }

    let fieldTypes = resolvedList |> map<(VarDecl, ?TypeNode),  (Decl, ?TypeNode)> { it => it } |>
        concat<(Decl, ?TypeNode)>(ctorParameterTypes) |>
        collectHashMap

    for (interfaceName in inputOptions.allInterfaceNames) {
        let deriving = findDeriving(interfaceName) ?? continue
        diagnoseInterface(deriving, interfaceName, target, fieldTypes, results, logger)
    }

    if (!inputOptions.ordering.isEmpty()) {
        diagnoseOrdering(target, inputOptions, results, logger)
    }

    diagnoseConstraints(inputOptions, logger)

    return results.toArray()
}

private func findAbstractKeyword(decl: Decl): Token {
    decl.modifiers.iterator().filter { it =>
        it.keyword.kind == TokenKind.OPEN ||
        it.keyword.kind == TokenKind.ABSTRACT ||
        it.keyword.kind == TokenKind.SEALED
    }.first()?.keyword ?? decl.keyword
}

private func findSealedKeyword(decl: Decl): Token {
    decl.modifiers.iterator().filter { it =>
        it.keyword.kind == TokenKind.SEALED
    }.first()?.keyword ?? decl.keyword
}

private func diagnoseInterface(
    deriving: Deriving,
    interfaceName: QualifiedName,
    target: DerivingTarget,
    fieldTypes: HashMap<Identifier, ?TypeNode>,
    results: ArrayList<ExtendDecl>,
    logger: Logger
): Unit {
    let typeInfo = deriving.queryInterfaceInfo(interfaceName)
    let ifaceSimple = interfaceName.toSimpleNameQN()

    let errors = ArrayList<Tokens>()
    for (f in target.namedFields) {
        if (let Some(fieldType) <- fieldTypes[f.identifier]) {
            let expectedType = typeInfo.genericsInjector.injectGenerics(ifaceSimple, fieldType, target)
            let id = f.identifier.token
            errors.add(quote(
                let _: $expectedType = $id
            ))
        } else {
            logger.error(f.identifier.token,
                "Type for field '${f.identifier}' is unknown. Please specify its type explicitly.")
        }
    }

    diagnoseEnumCaseTypes(target, interfaceName, typeInfo, errors)

    if (!errors.isEmpty()) {
        let ext = target.createExtendSkeleton()
        let constraints = target.genericConstraints(typeInfo, target.findIntefaceSettings(interfaceName))
        ext.appendConstraints(constraints)
        appendErrors(ext.body, errors)
        results.add(ext)
    }
}

private func diagnoseEnumCaseTypes(
    target: DerivingTarget,
    interfaceName: QualifiedName,
    typeInfo: DerivingInterfaceInfo,
    errors: ArrayList<Tokens>
): Unit {
    var counter = 0
    for (c in target.enumCases) {
        for (t in c.constructor.typeArguments) {
            let checkFunctionName = Token(TokenKind.IDENTIFIER, "check_${c.name}_${counter}")
            let genericName = Token(TokenKind.IDENTIFIER, "T_${c.name}_${counter}")
            let genericDecl = GenericDecl(genericName)

            let simpleName = interfaceName.toSimpleNameQN()

            let upperBound = typeInfo.genericsInjector.injectGenerics(simpleName, t, target)
            let constraints = typeInfo.genericsInjector.constraintsFor(simpleName, genericDecl, target) |>
                map { g: GenericConstraint => g.toTokens() } |>
                joinTokens(delimiter: quote(&))

            counter++
            errors.add(quote(
                func $checkFunctionName<$genericName>(_: $t): $upperBound where $constraints { throw Exception() }
                let _ = $checkFunctionName<$t>
            ))
        }
    }
}

private func diagnoseConstraints(
    inputOptions: InputOptions,
    logger: Logger
): Unit {
    let generics = inputOptions.decl.generics() |> associateBy { it: GenericDecl => it.identifier }
    for (t in inputOptions.origin) {
        for (c in t.constraints) {
            if (!generics.contains(c.genericParameter)) {
                logger.error(c.genericParameter.token, "Generic parameter ${c.genericParameter} is missing")
            }
        }
    }
}

private func diagnoseOrdering(
    target: DerivingTarget,
    inputOptions: InputOptions,
    results: ArrayList<ExtendDecl>,
    logger: Logger
): Unit {
    let fieldsSet = target.namedFields |> map { f: TargetNamedAttribute => f.identifier } |> collectHashSet
    let excludedFields = inputOptions.excluded |> collectHashSet
    let errors = ArrayList<Tokens>()

    for (o in inputOptions.ordering) {
        if (excludedFields.contains(o)) {
            logger.error(o.token, "Field ${o.value} is excluded via @DeriveExclude")
            let t = o.token
            errors.add(quote(let _ = (()).$t))
        } else if (!fieldsSet.contains(o)) {
            match (findDecl(target, o)) {
                case Some(p: PropDecl) where p.isStatic() =>
                    // it would appear in the fieldsSet otherwise
                    logger.error(o.token, "Property ${o.value} is static, can't include it")
                case Some(_: PropDecl) =>
                    // it would appear in the fieldsSet otherwise
                    logger.error(o.token, "Property ${o.value} is not included, apply @DeriveInclude on it")
                case Some(f: VarDecl) where f.isStatic() =>
                    logger.error(o.token, "Field ${o.value} is static, can't include it")
                case Some(other) =>
                    logger.error(o.token, "'${o.value}' should be a field or property, got ${describeUnknown(other)}")
                case _ =>
                    let t = o.token
                    errors.add(quote(let _ = this.$t))
            }
        }
    }

    let missing = fieldsSet |> filter { f: Identifier => !inputOptions.ordering.contains(f) } |> collectArray
    if (!missing.isEmpty()) {
        let at = inputOptions.ordering |> map { t: Identifier => t.token } |> first
        let message = "Not all attributes included: ${missing}"
        match (at) {
            case Some(at) => logger.error(at, message)
            case None => throw MacroContextException(message) // we have no tokens to complain at
        }
    }

    for (duplicated in findDuplicates(inputOptions.ordering)) {
        logger.error(duplicated.token, "'${duplicated}' is duplicated in @DeriveOrder")
    }

    if (!errors.isEmpty()) {
        let ext = target.createExtendSkeleton()
        appendErrors(ext.body, errors)
        results.add(ext)
    }
}

private func findDecl(target: DerivingTarget, name: Identifier): ?Decl {
    target.declaration.allNamedDecls().filter { it => it.identifier.value == name.value }.first()
}

private func describeUnknown(decl: Decl): String {
    let keyword = decl.keyword
    if (keyword.kind != TokenKind.ILLEGAL && !keyword.value.isEmpty()) {
        return keyword.value
    }

    return decl.astKind
}

private func appendErrors(body: Body, errors: Collection<Tokens>) {
    if (!errors.isEmpty()) {
        let errorsBody = errors |> joinTokens(delimiter: Token(TokenKind.NL, "\n"))

        let functionName = Token(TokenKind.IDENTIFIER, "derivingChecks_")
        let functionName2 = Token(TokenKind.IDENTIFIER, "derivingChecks2_")
        let errorFunctionDecl = FuncDecl(quote(
            private func $functionName(): Unit {
                $errorsBody
                $functionName2()
            }
        ))
        let unusedHack = FuncDecl(quote(
            private func $functionName2(): Unit {
                $functionName()
            }
        ))

        body.decls.add(errorFunctionDecl)
        body.decls.add(unusedHack)
    }
}

private func findDuplicates(names: Iterable<Identifier>): Array<Identifier> {
    let visited = HashSet<Identifier>()
    let duplicates = ArrayList<Identifier>()

    for (name in names) {
        if (!visited.add(name)) {
            duplicates.add(name)
        }
    }

    return duplicates.toArray()
}
