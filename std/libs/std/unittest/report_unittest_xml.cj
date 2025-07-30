/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest

import std.collection.ArrayList
import std.fs.*
import std.unittest.common.PrettyText

class XmlBuilder <: ToString {
    private let element_ = XmlElementBuilder()
    private var version_: ToString = "1.0"
    private var encoding_: ?ToString = None

    public func version(v: ToString) {
        version_ = v
        this
    }

    public func encoding(format: ToString) {
        encoding_ = format
        this
    }

    public func element(name: ToString, childBuilder: (XmlElementBuilder) -> Unit): This {
        element_.name(name)
        childBuilder(element_)
        this
    }

    public func toString() {
        """
<?xml version="${version_}"${match (encoding_) { case Some(e) => " encoding=\"${e}\""; case _ => "" }}?>
${element_}
"""
    }
}

open class XmlElementBuilder <: ToString {
    private var name_: ToString = ""
    private var attributes_ = ArrayList<(ToString, ToString)>()
    private var children = ArrayList<XmlElementBuilder>()
    private var content_: ToString = ""

    XmlElementBuilder(let level!: UInt64 = 0) {}

    public mut prop attributes: ArrayList<(ToString, ToString)> {
        get() { attributes_ }
        set(value) { attributes_ = value }
    }

    public mut prop content: ToString {
        get() { content_ }
        set(value) { content_ = value }
    }

    public func name(name: ToString) {
        this.name_ = name
        this
    }

    public open func attribute(key: ToString, value: ToString): This {
        attributes.add((key, value.toString().toXmlEscapedString()))
        this
    }

    public open func optionalAttribute(key: ToString, value: ?String): This {
        if (let Some(value) <- value) {
            attribute(key, value)
        }
        this
    }

    public open func element(contentBuilder: () -> ToString): This {
        content = contentBuilder()
        this
    }

    public open func element(name: ToString, childBuilder: (XmlElementBuilder) -> Unit): This {
        let child = XmlElementBuilder(level: level + 1)
        name |> child.name
        child |> childBuilder
        child |> children.add
        this
    }

    private func buildAttributes(sb: StringBuilder) {
        for ((k, v) in attributes) {
            sb.append(" ${k}=\"${v}\"")
        }
    }

    private func buildContent(sb: StringBuilder) {
        let charsData = content.toString().toXmlEscapedString()
        match {
            case !charsData.isEmpty() => sb.append(charsData)
            case !children.isEmpty() =>
                sb.append(r'\n')
                for (child in children) {
                    sb.append(child)
                    sb.append(r'\n')
                }
                sb.append(indent())
            case _ => ()
        }
    }

    private func indent() {
        "\t" * Int64(level)
    }

    func build(sb: StringBuilder): Unit {
        let contentSb = StringBuilder()
        buildContent(contentSb)

        sb.append(indent())
        sb.append("<${name_}")
        buildAttributes(sb)

        match (contentSb.size == 0) {
            case true => sb.append("/>")
            case false =>
                sb.append(">")
                sb.append(contentSb)
                sb.append("</${name_}>")
        }
    }

    public open func toString(): String {
        let sb = StringBuilder()
        build(sb)
        sb.toString()
    }
}

extend String {
    func toXmlEscapedString() {
        this.replace("&", "&amp;")
        .replace("<", "&lt;")
        .replace(">", "&gt;")
        .replace("'", "&apos;")
        .replace("\"", "&quot;")
    }

    func toSafeFileName() {
        this.replace("<", ".")
            .replace(",", ".")
            .replace(">", "")
            .replace("/", "_")
            .replace(" ", "")
    }
}

interface ReportFormat {
    static prop isBench: Bool {
        get() { defaultConfiguration().bench }
    }

    /**
     * @returns report format instance specified in `str` parameter.
     * @throws UnittestCliOptionsFormatException if report format could not be created from `str`
     */
    static func fromString(format: String, path: Path): ReportFormat {
        match (isBench) {
            case true => BenchReportFormat.fromString(format, path)
            case false => UTestReportFormat.fromString(format, path)
        }
    }

    static func default(path: Path): ReportFormat {
        match (isBench) {
            case true => BenchReportFormat.default(path)
            case false => UTestReportFormat.default(path)
        }
    }

    static func fromDefaultConfiguration(): ?ReportFormat {
        let reportDir = getReportDirectory(KeyReportPath.reportPath)
        if (let Some(explicitFormat) <- defaultConfiguration().get(KeyReportFormat.reportFormat)) {
            let dir = reportDir ?? throw UnittestCliOptionsFormatException(
                "--report-path directory should be specified since --report-format is specified")
            return ReportFormat.fromString(explicitFormat, dir)
        }

        // return default format if report directory was specified
        ReportFormat.default(reportDir ?? return None)
    }

    func report(testInfo: TestGroupResult): Unit
}

enum UTestReportFormat <: ReportFormat {
    | XML(Path)

    public static redef func default(path: Path): ReportFormat {
        XML(path)
    }

    public static redef prop isBench: Bool {
        get() { false }
    }

    public static redef func fromString(format: String, path: Path): ReportFormat {
        match (format.toAsciiUpper()) {
            case "XML" => XML(path)
            case _ => throw UnittestCliOptionsFormatException("Unsupported test report format: ${format}")
        }
    }

    public func report(result: TestGroupResult): Unit {
        match (this) {
            case XML(path) => result.reportXml(path.join("tests"))
        }
    }
}

/**
 * @returns report directory path specified in default configuration.
 * Returns None if configuration value is not specified or the value is not a directory.
 */
func getReportDirectory<Key>(key: Key): ?Path where Key <: KeyFor<String> {
    let pathStr = defaultConfiguration().get<String>(key) ?? return None
    if (pathStr.isAsciiBlank()) {
        return None
    }

    // if passed output is not a valid directory, we silently don't do anything
    if (File.exists(pathStr)) { return None }
    Path(pathStr)
}

private func timeFormat(time: Duration): Float64 { Float64(time.toNanoseconds()) / 1_000_000_000.0 }

extend TestSuiteId {
    func asClassName() {
        "${groupName}.${suiteName}"
    }
}

private class XmlReport {
    var currentCaseId: TestCaseId
    var fakeId: TestCaseId
    XmlReport(let suiteResult: TestSuiteResult) {
        // NOTE: questionable entry name
        fakeId = TestCaseId(suiteResult.suiteId, "lifecycle", isBench: false)
        currentCaseId = fakeId
    }

    func buildTestSuite(): ToString {
        let builder = XmlBuilder().encoding("UTF-8")

        builder.element("testsuite") { testSuiteXml =>
            let details = suiteResult.details
            testSuiteXml
                .attribute("name", suiteResult.suiteId.asClassName())
                .attribute("tests", details.totalCount)
                .attribute("failures", details.failedCount)
                .attribute("errors", details.errorCount)
                .attribute("skipped", details.skippedCount)
                .attribute("time", timeFormat(details.duration))
                .attribute("timestamp", details.startTimestamp)

            suiteResult.visitPassedTests { tcr =>
                if (tcr.details.totalCount == 0) { return }
                buildTestEntry(tcr.subResults[0], tcr.caseId, testSuiteXml)
            }

            suiteResult.visitFailedSteps { subResult, caseId =>
                buildTestEntry(subResult, caseId, testSuiteXml)
            }
        }
    }

    private func buildTestEntry(result: RunStepResult, caseId: TestCaseId, elementBuilder: XmlElementBuilder) {
        let message = match (result.kind) {
            case CaseStep(descr) where result.hasFailures() => descr.intoErrorMessage()?.toString()
            case Lifecycle(x) => lifecycleStageFailedText(x).toString()
            case _ => None<String>
        }

        elementBuilder.element("testcase") { testCaseXml =>
            testCaseXml
                .attribute("name", caseId.caseName)
                .attribute("classname", caseId.suiteId.asClassName())
                .attribute("assertions", totalAssertions(result))
                .attribute("time", timeFormat(result.duration))

            match (result.statusCode()) {
                case SKIP => testCaseXml.element("skipped") { _ => }
                case FAIL => testCaseXml.element("failure") { it =>
                    it.optionalAttribute("message", message)
                    it.element { checkResultsAsString(result.checkResults) }
                }
                case TIMEOUT => testCaseXml.element("failure") { it =>
                    it.optionalAttribute("message", message)
                    it.attribute("type", "Timeout")
                    it.element { checkResultsAsString(result.checkResults) }
                }
                case ERROR => testCaseXml.element("error") { it =>
                    it.optionalAttribute("message", message)
                    it.element { checkResultsAsString(result.checkResults) }
                }
                case NORUN => ()
                case PASS => ()
            }
        }
    }

    private func totalAssertions(result: RunStepResult): Int64 {
        var total = result.checksPassed
        for (assertionFailure in result.checkResults) {
            if (assertionFailure is AssertExpectCheckResult) {
                total += 1
            }
        }
        total
    }

    private func checkResultsAsString(crs: Array<CheckResult>): String {
        let text = PrettyText()
        for (cr in crs) {
            cr.pprintWithFailedPrefix(text).newLine()
        }
        text.toString()
    }
}


extend TestGroupResult {
    func reportXml(dir: Path): Unit {
        Directory.ensureExists(dir)
        this.visitAll<TestSuiteResult> { suiteResult =>
            let fileName = suiteResult.suiteId.reportFileName(isBench: false, extension: "xml")
            let xmlBytes = XmlReport(suiteResult).buildTestSuite().toString().toArray()
            File.writeTo(
                dir.join(fileName),
                xmlBytes
            )
        }
    }
}

extend TestSuiteId {
    func reportFileName(isBench!: Bool, extension!: String): String {
        let prefix = if (isBench) { "bench" } else { "test" }
        "${prefix}-${this.groupName.toSafeFileName()}.${suiteName.toSafeFileName()}.${extension}"
    }
}
