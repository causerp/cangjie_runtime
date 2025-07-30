/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest.mock

import std.collection.*
import std.unittest.common.*
import std.unittest.mock.internal.*

open class FailureReport {
    private let textBuilder = PrettyText()
    private var lastSymbol: Rune = r'\n'

    FailureReport(
        protected let invocationLog: LogSnapshot,
        private let nameRegistry: MockNameRegistry
    ) {}

    init() {
        this(LogSnapshot.EMPTY, MockNameRegistry.EMPTY)
    }

    func build(body: () -> Unit): PrettyText {
        body()
        textBuilder
    }

    func renderStatement(statement: VerifyStatement) {
        renderMatcher(statement.invocationMatcher, prefixString: "statement", atString: "declared at")
    }

    func renderStub(stubChain: StubChain) {
        renderMatcher(stubChain.invocationMatcher, prefixString: "stub", atString: "declared at")
    }

    func renderMatcher(invocationMatcher: InvocationMatcher, atString!: String = "at", prefixString!: String = "") {
        renderStubDescription(invocationMatcher.description, atString: atString, prefixString: prefixString)
    }

    func renderStubDescription(description: StubDescription, atString!: String, prefixString!: String) {
        if (!prefixString.isEmpty()) {
            text(prefixString)
        }
        userCode(description.fullCall)
        text(atString)
        renderLocation(description.location)
    }

    func renderMatchingInvocations(invocationMatcher: InvocationMatcher) {
        let matchingInvocations = findMatchingInvocations(invocationMatcher)
        if (matchingInvocations.isEmpty()) {
            return
        }

        line("Matching invocations occured at:")
        textBuilder.indent {
            renderInvocationList(matchingInvocations)
        }
    }

    func findMatchingInvocations(invocationMatcher: InvocationMatcher) {
        let matchingInvocations = ArrayList<Invocation>()
        for (entry in invocationLog.entries) {
            let invocation = entry.invocation
            if (invocationMatcher.matches(invocation)) {
                matchingInvocations.add(invocation)
            }
        }
        return matchingInvocations
    }

    func renderInvocationList(invocations: Collection<Invocation>) {
        for (invocation in invocations) {
            listEntry { renderLocation(invocation.location) }
        }
    }

    func renderInvocationWithLocation(invocation: Invocation, atString!: String = "at"): Unit {
        renderInvocation(invocation)
        text(atString)
        renderLocation(invocation.location)
    }

    func renderInvocation(invocation: Invocation): Unit {
        let objectName = match (nameRegistry.get(invocation.stubId.receiverId)) {
            case Some(name) => name
            case _ => "<?>"
        }
        let funcInfo = invocation.call.funcInfo
        let name = funcInfo.presentableName
        match {
            case funcInfo.isGetter => userCode("${objectName}.${name}")
            case funcInfo.isSetter => userCode("${objectName}.${name} = ...")
            case _ =>
                let hasParams = invocation.call.funcInfo.params.size > 0
                let argsString = if (hasParams) { "(...)" } else { "()" }
                userCode("${objectName}.${name}${argsString}")
        }
    }

    func renderLocation(location: Location): Unit {
        userCode(location.fileNameAndLine())
    }

    func renderDeclarationNameAndKind(info: FuncInfo, getterSetterPrefix!: Bool) {
        let name = info.presentableName
        match (info.kind) {
            case FieldGetter(_, _) =>
                if (getterSetterPrefix) {
                    text("getter of")
                }
                text("field")
            case PropertyGetter(_, _) =>
                if (getterSetterPrefix) {
                    text("getter of")
                }
                text("property")
            case FieldSetter(_) =>
                if (getterSetterPrefix) {
                    text("setter of")
                }
                text("field")
            case PropertySetter(_) =>
                if (getterSetterPrefix) {
                    text("setter of")
                }
                text("property")
            case Method(_) => text("method")
            case TopLevelFunction(_) => text("top-level function")
            case StaticMethod(_) => text("static method")
            case StaticPropertyGetter(_) => text("static property getter")
            case StaticPropertySetter(_) => text("static property setter")
            case StaticFieldGetter(_) => text("static field getter")
            case StaticFieldSetter(_) => text("static field setter")
            case TopLevelVariableGetter(_) => text("top-level field getter")
            case TopLevelVariableSetter(_) => text("top-level field setter")
        }
        userCode(name)
    }

    func reportArgumentMismatch(invocationMatcher: InvocationMatcher, unmatchedArgumentIndices: Array<Int64>) {
        let longestName = max(invocationMatcher.stubId.funcInfo.params |> map { p: ParameterInfo => p.name.size }) ?? 0
        for ((argPosition, argMatcher) in invocationMatcher.positionalMatchers |> enumerate) {
            let wasMatched = !unmatchedArgumentIndices.contains(argPosition)
            let description = argMatcher.getDescription() ?? "<?>"
            let paramName = invocationMatcher.stubId.funcInfo.params.get(argPosition)?.name ?? "<?>"
            let spacesToAdd = longestName - paramName.size
            listEntry {
                if (wasMatched) {
                    success("[+]")
                    success(paramName)
                } else {
                    error("[-]")
                    error(paramName)
                }
                for (_ in 0..spacesToAdd + 1) {
                    space()
                }
                text("<~>")
                userCode(description)
            }
        }
    }

    func renderCardinalityMin(cardinality: Cardinality) {
        match ((cardinality.min, cardinality.max)) {
            case (min, Some(max)) where min == max =>
                text("exactly")
                timesStr(min)
            case (min, _) =>
                text("at least")
                timesStr(min)
        }
    }

    func renderCardinalityMax(cardinality: Cardinality) {
        match ((cardinality.min, cardinality.max)) {
            case (min, Some(max)) where min == max =>
                text("exactly")
                timesStr(min)
            case (_, Some(max)) =>
                text("at most")
                timesStr(max)
            case _ =>
                text("<no limit>")
        }
    }

    func renderRequiredActual(actualInvocations: Int64, renderCardinality: () -> Unit): Unit {
        listEntry {
            text("Required:")
            renderCardinality()
        }
        listEntry {
            text("Actual:")
            error(actualInvocations)
        }
    }

    func timesStr(i: Int64): Unit {
        if (i < 0) {
            internalError("Invalid argument: ${i}")
        }
        match (i) {
            case 1 =>
                userCode("once")
            case _ =>
                userCode(i)
                text("times")
        }
    }

    func indent(body: () -> Unit): Unit {
        textBuilder.indent {
            body()
        }
    }

    func line(str: String): Unit {
        text(str)
        nl()
    }

    func line(body: () -> Unit): Unit {
        body()
        nl()
    }

    func listEntry(body: () -> Unit) {
        body()
        nl(ensureDotAtTheEnd: false)
    }

    func nl(ensureDotAtTheEnd!: Bool = true) {
        if (ensureDotAtTheEnd && lastSymbol != r'.' && lastSymbol != r':') {
            append(".")
        }
        textBuilder.newLine()
        lastSymbol = r'\n'
    }

    func text(str: String) {
        ensureSpacing()
        append(str)
    }

    private func ensureSpacing() {
        if (lastSymbol != r' ' && lastSymbol != r'\n') {
            space()
        }
    }

    private func space() {
        append(" ")
    }

    func append(str: String): Unit {
        lastSymbol = str.lastRune() ?? return ()
        textBuilder.append(str)
    }

    func userCode(userCode: ToString): Unit {
        ensureSpacing()
        let str = userCode.toString()
        lastSymbol = str.lastRune() ?? return ()
        textBuilder.colored(Color.YELLOW, str)
    }

    func error(errorText: ToString): Unit {
        ensureSpacing()
        let str = errorText.toString()
        lastSymbol = str.lastRune() ?? return ()
        textBuilder.colored(Color.RED, str)
    }

    func success(successText: ToString): Unit {
        ensureSpacing()
        let str = successText.toString()
        lastSymbol = str.lastRune() ?? return ()
        textBuilder.colored(Color.GREEN, str)
    }

    func errorLine(text: String) {
        line { error(text) }
    }

    func errorHeader(text: String) {
        error(text)
        nl(ensureDotAtTheEnd: false)
    }

    func includeContent(content: PrettyPrintable): Unit {
        content.pprint(textBuilder)
    }
}

class MockNameRegistry {
    private let idToName = HashMap<UInt64, Option<String>>()

    MockNameRegistry(matchers: Array<InvocationMatcher>) {
        for (matcher in matchers) {
            submit(matcher)
        }
    }

    func submit(invocationMatcher: InvocationMatcher) {
        idToName.addIfAbsent(invocationMatcher.stubId.receiverId, invocationMatcher.description.prefixRefName)
    }

    func get(objId: UInt64): ?String {
        return idToName.get(objId) ?? Option<String>.None
    }

    static let EMPTY = MockNameRegistry()
}

extend String {
    func lastRune(): ?Rune {
        if (isEmpty()) {
            return None
        }

        let runes = toRuneArray()
        return runes[runes.size - 1]
    }
}
