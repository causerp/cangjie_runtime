/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest

import std.fs.*
import std.convert.Formattable

enum BenchReportFormat <: ReportFormat {
    | CSV(Path)
    | CSV_RAW(Path)
    | Html(Path)

    public static redef prop isBench: Bool {
        get() { true }
    }

    public static redef func default(path: Path): ReportFormat {
        CSV(path)
    }

    public static redef func fromString(format: String, path: Path): ReportFormat {
        match (format.toAsciiUpper()) {
            case "CSV" => CSV(path)
            case "HTML" => Html(path)
            case "CSV_RAW" | "CSV-RAW" => CSV_RAW(path)
            case _ => throw UnittestCliOptionsFormatException("Unsupported benchmark report format: ${format}")
        }
    }

    public func report(result: TestGroupResult): Unit {
        let (dir, isRaw) = match (this) {
            case CSV_RAW(path) => (path.join("benchmarks"), true)
            case CSV(path) => (path.join("benchmarks"), false)
            case Html(path) => return result.reportHtml(path.join("benchmarks"))
        }
        result.reportCsv(dir, raw: isRaw)
    }
}

extend TestGroupResult {
    func reportCsv(dir: Path, raw!: Bool): Unit {
        Directory.ensureExists(dir)
        this.visitAll<TestSuiteResult>{ suiteResult => 
            let fileName = suiteResult.suiteId.reportFileName(isBench: true, extension: "csv")
            let csvBytes = suiteResult.reportBenchCsv(raw: raw).toString().toArray()
            if (!csvBytes.isEmpty()) {
                File.writeTo(
                    dir.join(fileName),
                    csvBytes
                )
            }
        }
    }
}

extend TestSuiteResult {
    func reportBenchCsv(raw!: Bool): ToString {
        let header = match (raw) {
            case true => "Case,Args,BatchSize,Duration,Unit,Measurement\n"
            case false => "Case,Args,Median,Err,Err%,Mean,Unit,Measurement\n"
        }
        let sb = StringBuilder(header)
        let reportSizeBefore = sb.size

        this.visitAll<TestCaseResult> { caseResult =>
            let conversionTable = caseResult.renderOptions.measurementInfo?.conversionTable ?? TimeNow().conversionTable
            let measurementName = caseResult.renderOptions.measurementInfo?.name ?? TimeNow().name

            caseResult.visitPassedBenches { resultPiece =>
                let caseName = resultPiece.caseId.caseName
                let args = resultPiece.arg.textDescription?.toString()

                match (raw) {
                    case true =>
                        for ((batchSize, value) in resultPiece.result.data) {
                            let (adjustedValue, unit) = conversionTable.minToNonAdjustedPair(value)
                            sb.appendCsvCell(caseName)
                            sb.appendCsvCell(args)
                            sb.appendCsvCell(Int64(batchSize))
                            sb.appendCsvCell(adjustedValue)
                            sb.appendCsvCell(unit)
                            sb.appendCsvCell(measurementName, last: true)
                        }
                    case false =>
                        sb.appendCsvCell(caseName)
                        sb.appendCsvCell(args)
                        appendStatistics(sb, resultPiece.result, conversionTable, measurementName)
                }
            }
        }

        match (reportSizeBefore == sb.size) {
            case true => ""
            case false => sb
        }
    }
}

private func appendStatistics(
    sb: StringBuilder,
    benchStats: BenchmarkResult,
    table: MeasurementUnitTable,
    measurementName: String
) {
    var (result, unit) = table.minToNonAdjustedPair(benchStats.mainResult)

    let isEmptyBench = benchStats.errorEst == 0.0 && result == 0.0

    // to get more stable output when result is basically zero
    if (result < 0.001) {
        result = 0.0
    }

    let error = if (isEmptyBench) {
        None<ToString>
    } else {
        table.minToNonAdjustedPair(benchStats.errorEst)[0]
    }

    let errorPercent = if (isEmptyBench) {
        None<ToString>
    } else {
        (benchStats.errorEst / result * 100.0).format(".1")
    }

    sb.appendCsvCell(result)
    sb.appendCsvCell(error)
    sb.appendCsvCell(errorPercent)
    sb.appendCsvCell(max(table.minToNonAdjustedPair(benchStats.mean)[0], 0.0))
    sb.appendCsvCell(unit)
    sb.appendCsvCell(measurementName, last: true)
}

extend StringBuilder {
    func appendCsvCell<T>(cellData: ?T, last!: Bool = false) where T <: ToString {
        let cell = if (let Some(data) <- cellData) {
            "\"${data}\""
        } else {
            ""
        }

        let terminal = match (last) {
            case true => '\n'
            case false => ','
        }

        append(cell)
        append(terminal)
    }
}
