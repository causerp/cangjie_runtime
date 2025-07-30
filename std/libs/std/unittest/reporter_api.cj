/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest

import std.fs.Path
import std.collection.*
import std.unittest.common.PrettyPrinter

sealed interface Reporter<TReport, TReturn> {}

// NOTE: our predefined reporters
public class CsvReporter <: Reporter<BenchReport, Unit> {
    public CsvReporter(let directory: Path) {}
}

public class CsvRawReporter <: Reporter<BenchReport, Unit> {
    public CsvRawReporter(let directory: Path) {}
}

public class XmlReporter <: Reporter<TestReport, Unit> {
    public XmlReporter(let directory: Path) {}
}

public class ConsoleReporter <: Reporter<TestReport, Unit> & Reporter<BenchReport, Unit> {
    public ConsoleReporter(let colored!: Bool = true) {}
}

public class TextReporter<PP> <: Reporter<TestReport, PP> & Reporter<BenchReport, PP>
        where PP <: PrettyPrinter {
    public TextReporter(let into!: PP) {}
}

// this hidden interface is needed because check for TextReporter<PP> is impossible without satisfying
// PP <: PrettyPrinter, which cannot be satisfied in generic context
interface TextReporterBase<PP> <: Reporter<TestReport, PP> & Reporter<BenchReport, PP> {
    func printReport(report: Report): PP
}

extend <PP> TextReporter<PP> <: TextReporterBase<PP> where PP <: PrettyPrinter {
    public func printReport(report: Report): PP {
        let outputReporter = TestOutputReporter.fromDefaultConfiguration()
        TextReports.printDefaultReport(into, report.groupResult, outputReporter, report.runConfiguration)
        return into
    }
}

extend ConsoleReporter <: TextReporterBase<Unit> {
    public func printReport(report: Report): Unit {
        let pp = TerminalPrettyPrinter(colored)
        let outputReporter = TestOutputReporter.fromDefaultConfiguration()
        TextReports.printDefaultReport(pp, report.groupResult, outputReporter, report.runConfiguration)
    }
}

// NOTE: for our internal benchmarks
public class RawStatsReporter <: Reporter<BenchReport, HashMap<String, (Float64, Float64)>> {
    public RawStatsReporter() {}

    func benchResultsAsMap(result: TestGroupResult): HashMap<String, (Float64,Float64)> {
        let caseNameToMeasurement = HashMap<String, (Float64,Float64)>()
        result.visitAll<TestCaseResult> { cr =>
            for ((key, value) in getEntries(cr)) {
                caseNameToMeasurement[key] = value
            }
        }
        caseNameToMeasurement
    }

    private static func getEntries(tcr: TestCaseResult): ArrayList<(String, (Float64, Float64))> {
        let result = ArrayList<(String, (Float64, Float64))>()
        tcr.visitPassedBenches{ step =>
            let key = step.caseId.caseName + (step.arg.textDescription?.toString() ?? "")
            result.add((key, ((step.result.mainResult, step.result.errorEst))))
        }
        result
    }
}
