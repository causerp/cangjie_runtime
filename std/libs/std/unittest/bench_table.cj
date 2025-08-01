/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest

import std.unittest.common.Color
import std.collection.*
import std.convert.Formattable

func percentToColor(p: Float64): Color {
    if (p > 1.0) {
        RED
    } else if (p < -1.0) {
        GREEN
    } else {
        DEFAULT_COLOR
    }
}

let plusMinus = if (isConsoleUtf8) { "±" } else { "+/-" }

private enum Baseline {
    | PreviousReport
    | TestCaseBaseline(Float64)
    | NotFound
}

private class BenchTableProperties {
    BenchTableProperties(
        var hasArgsColumn!: Bool = false,
        var hasCasesBaseline!: Bool = false,
        var hasMeasurementColumn!: Bool = false,
        var hasRatioColumn!: Bool = false,
        var shouldPrintMeasurement!: Bool = true,
        var conversionTable!: MeasurementUnitTable = TimeNow().conversionTable,
        var measurementName!: String = TimeNow().name,
        var baseline!: Baseline = Baseline.PreviousReport,
        protected let baselineReport!: HashMap<String, Float64> = HashMap()
    ) {}
}

interface BenchTable {
    static func build(suiteResult: TestSuiteResult, baselineReport: HashMap<String, Float64>): ?BenchTable {
        BenchTableImpl.build(suiteResult, baselineReport)
    }

    func doBuild(): PrettyTable

    prop hasBaselineHeader: Bool
}

private open class BenchTableImpl <: BenchTable {
    protected let subgroups: ArrayList<BenchTableImpl> = ArrayList()

    protected BenchTableImpl(
        protected let props!: BenchTableProperties = BenchTableProperties(),
        protected let table!: PrettyTable = PrettyTable()
    ) {}

    public open prop hasBaselineHeader: Bool {
        get() { props.hasRatioColumn && !props.hasCasesBaseline }
    }

    public open func putResultToBaselineReport(key: String, value: Float64) {
        props.baselineReport[key] = value
    }

    public open func getResultFromBaselineReport(key: String): Option<Float64> {
        props.baselineReport.get(key)
    }

    public static func build(suiteResult: TestSuiteResult, baselineReport: HashMap<String, Float64>): ?BenchTable {
        let table = BenchTableImpl(props: BenchTableProperties(baselineReport: baselineReport))
        BenchMeasurementGroup.fill(table, suiteResult)
        if (table.isEmpty()) {
            return None
        }

        return table
    }

    protected open func isEmpty(): Bool {
        subgroups.isEmpty() || (subgroups |> all { group: BenchTableImpl => group.isEmpty() })
    }

    func initTableStructure(): Unit {
        table.addColumn("Case")
        table.alignColumnLeft(0)
        if (props.hasArgsColumn) {
            table.addColumn("Args")
            table.alignColumnLeft(1)
        }
        if (props.hasMeasurementColumn) {
            table.addColumn("Measurement")
            let measurementColumnIdx = if (props.hasArgsColumn) { 2 } else { 1 }
            table.alignColumnLeft(measurementColumnIdx)
        }

        table.addColumns(["Median", "Err", "Err%", "Mean", "Ratio"])
    }

    public func doBuild(): PrettyTable {
        initTableStructure()
        doTableBuild()

        if (!props.hasRatioColumn) {
            table.removeLastColumn()
        }
        table
    }

    protected open func doTableBuild(): Unit {
        var first = true
        for (sg in subgroups) {
            if (sg.isEmpty()) {
                continue
            }

            if (!first) {
                table.addEmptyRow()
            }

            sg.doTableBuild()
            first = false
        }
    }

    protected func addSubgroup(subgroup: BenchTableImpl) {
        this.subgroups.add(subgroup)
    }
}

private abstract class BenchTableGroup <: BenchTableImpl {
    BenchTableGroup(let parent: BenchTableImpl) {
        super(table: parent.table, props: parent.props)
    }

    public open func putResultToBaselineReport(key: String, value: Float64) {
        parent.putResultToBaselineReport(key, value)
    }

    public open func getResultFromBaselineReport(key: String): Option<Float64> {
        parent.getResultFromBaselineReport(key)
    }
}

private class BenchMeasurementGroup <: BenchTableGroup {
    BenchMeasurementGroup(
        parent: BenchTableImpl,
        let conversionTable: MeasurementUnitTable,
        let measurementName: String,
        let results: Iterable<TestCaseResult>
    ) {
        super(parent)
        BenchBaselineGroup.fill(this, results)
    }

    protected func doTableBuild() {
        props.shouldPrintMeasurement = true
        props.conversionTable = conversionTable
        props.measurementName = measurementName
        super.doTableBuild()
    }

    static func fill(parent: BenchTableImpl, suiteResult: TestSuiteResult) {
        let measurementToCases = HashMap<String, ArrayList<TestCaseResult>>()
        let measurementToConversionTable = HashMap<String, MeasurementUnitTable>()
        suiteResult.visitAll<TestCaseResult> {
            caseResult =>
            if (caseResult.subResults |>
                all<RunStepResult> {
                r => match (r.info) {
                    case Bench(_) => false;
                    case _ => true
                }
            }) {
                return
            }

            let measurement = caseResult.renderOptions.measurementInfo?.name ?? TimeNow().name
            measurementToCases.getOrInsert(measurement, ArrayList()).add(caseResult)
            measurementToConversionTable[measurement] = caseResult.renderOptions.measurementInfo?.conversionTable ?? TimeNow()
                .conversionTable
        }

        if (measurementToCases.size > 1) {
            parent.props.hasMeasurementColumn = true
        }

        for ((measurement, cases) in measurementToCases) {
            parent.addSubgroup(
                BenchMeasurementGroup(parent, measurementToConversionTable[measurement], measurement, cases))
        }
    }
}

private class BenchBaselineGroup <: BenchTableGroup {
    BenchBaselineGroup(parent: BenchTableImpl, results: Iterable<(TestCaseId, ArrayList<BenchStepEntry>)>,
        let baseline!: Baseline) {
        super(parent)

        var first = true
        props.baseline = baseline
        for ((caseId, steps) in results) {
            BenchCaseRow.build(this, caseId, steps, first)
            first = false
        }
    }

    /**
     * Required to distinguish between the benches measured with equal measurements in baseline report (comparing with previous run).
     */
    private let baselineReportIndices = HashMap<String, Int64>()

    public override func putResultToBaselineReport(key: String, value: Float64) {
        let idx = baselineReportIndices.get(key) ?? 0
        props.baselineReport["${key}[${idx}]"] = value
        baselineReportIndices[key] = idx + 1
    }

    public override func getResultFromBaselineReport(key: String): Option<Float64> {
        let idx = baselineReportIndices.get(key) ?? 0
        props.baselineReport.get("${key}[${idx}]")
    }

    protected func doTableBuild() {
        props.baseline = baseline
        for (sg in subgroups) {
            sg.doTableBuild()
        }
    }

    static func fill(parent: BenchTableImpl, results: Iterable<TestCaseResult>) {
        let baselineToCases = HashMap<TestCaseId, ArrayList<TestCaseResult>>()
        let caseToBaseline = HashMap<TestCaseId, TestCaseId>()
        let measurementsByCase = HashMap<TestCaseId, ArrayList<BenchStepEntry>>()

        let fillMeasurements = { resultPiece: BenchStepEntry =>
            let caseId = resultPiece.caseId
            if (resultPiece.arg.textDescription.isSome()) {
                parent.props.hasArgsColumn = true
            }
            measurementsByCase.getOrInsert(caseId, ArrayList()).add(resultPiece)
        }

        for (caseResult in results) {
            if (let Some(baselineName) <- caseResult.renderOptions.baselineString) {
                let baselineId = TestCaseId(caseResult.caseId.suiteId, baselineName, isBench: true)
                baselineToCases.getOrInsert(baselineId, ArrayList()).add(caseResult)
                caseToBaseline[caseResult.caseId] = baselineId
                parent.props.hasRatioColumn = true
            }
            caseResult.visitPassedBenches(fillMeasurements)
        }

        if (!caseToBaseline.isEmpty()) {
            parent.props.hasCasesBaseline = true
        }

        let (standaloneBenches, baselineNotFoundBenches, batchedBenches) = groupCases(
            measurementsByCase,
            { id: TestCaseId => caseToBaseline.get(id) },
            { id: TestCaseId => baselineToCases.contains(id) }
        )

        let zipCase: (Iterable<TestCaseId>) -> Iterable<(TestCaseId, ArrayList<BenchStepEntry>)> = { ids: Iterable<TestCaseId> =>
            ids |> map<TestCaseId, (TestCaseId, ArrayList<BenchStepEntry>)> { it => (it, measurementsByCase[it]) }
        }

        for ((baselineId, cases) in batchedBenches) {
            var baseline = Baseline.PreviousReport
            if (baselineToCases.contains(baselineId)) {
                let baselineMeasurements = measurementsByCase[baselineId][0] // take first run as baseline
                baseline = Baseline.TestCaseBaseline(baselineMeasurements.result.mainResult)
            }

            parent.addSubgroup(BenchBaselineGroup(parent, cases |> zipCase, baseline: baseline))
        }

        parent.addSubgroup(BenchBaselineGroup(parent, baselineNotFoundBenches |> zipCase, baseline: NotFound))
        parent.addSubgroup(BenchBaselineGroup(parent, standaloneBenches |> zipCase, baseline: PreviousReport))
    }

    private static func groupCases(
        measurementsByCase: HashMap<TestCaseId, ArrayList<BenchStepEntry>>,
        getBaseline: (TestCaseId) -> ?TestCaseId,
        isBaseline: (TestCaseId) -> Bool
    ) {
        let standaloneBenches = ArrayList<TestCaseId>()
        let baselineNotFoundBenches = ArrayList<TestCaseId>()
        // each batch consists of [<baseline>, *<cases that have this baseline>] or [<all parameters for one case>]
        // so each case can appear in the report at most twice: once as a baseline and once as non-baseline in a batch
        let batchedBenches = HashMap<TestCaseId, ArrayList<TestCaseId>>()

        for ((caseId, steps) in measurementsByCase) {
            let baselineId = getBaseline(caseId)
            let hasBaseline = baselineId.isSome()

            let isBaselineItself = isBaseline(caseId)
            if (!hasBaseline && !isBaselineItself) {
                if (steps.size > 1) {
                    batchedBenches.getOrInsert(caseId, ArrayList()).add(caseId)
                } else {
                    standaloneBenches.add(caseId)
                }
                continue
            }
            if (!hasBaseline)  { continue }

            if (!measurementsByCase.contains(baselineId.getOrThrow())) {
                baselineNotFoundBenches.add(caseId)
                continue
            }
            batchedBenches.getOrInsert(baselineId.getOrThrow(), ArrayList()).add(caseId)
        }

        for ((baselineId, cases) in batchedBenches) {
            cases.removeIf { it => it == baselineId }
            cases.add(baselineId, at: 0)
        }

        return (standaloneBenches, baselineNotFoundBenches, batchedBenches)
    }
}

private open class BenchCaseRow <: BenchTableGroup {
    BenchCaseRow(
        parent: BenchTableImpl,
        let caseId: TestCaseId,
        let argText: String,
        let median!: Float64,
        let err!: Float64,
        let errPercent!: Float64,
        let mean!: Float64,
        let isBaseline!: Bool,
        let isEmptyResult!: Bool = false // was not actually executed during benchmarking, so results make no sense.
    ) {
        super(parent)
    }

    // Constructor of empty bench case row
    init(parent: BenchTableImpl, caseId: TestCaseId, argText: String, isBaseline: Bool) {
        this(
            parent, caseId, argText,
            median: 0.0, err: 0.0, errPercent: 0.0, mean: 0.0,
            isBaseline: isBaseline, isEmptyResult: true
        )
    }

    protected func isEmpty(): Bool {
        false
    }

    private prop benchColor: Color {
        get() {
            // mark bench as warninig if it was optimizied and not measured properly.
            if (isEmptyResult) { YELLOW } else { DEFAULT_COLOR }
        }
    }

    protected func doTableBuild(): Unit {
        table.nextRow()
        table.addCell(caseId.caseName, color: benchColor)

        if (props.hasArgsColumn) {
            table.addCell(argText, color: benchColor)
        }

        if (props.hasMeasurementColumn) {
            if (props.shouldPrintMeasurement) {
                table.addCell(props.measurementName, color: benchColor)
                props.shouldPrintMeasurement = false
            } else {
                table.addCell("")
            }
        }

        let converter = props.conversionTable
        let (boundary, unit) = converter.suitablePair(median)
        table.addCell(converter.toString(median, boundary: boundary, unit: unit), color: benchColor)
        table.addCell(plusMinus + converter.toString(err, boundary: boundary, unit: unit), color: benchColor)
        table.addCell(plusMinus + errPercent.format(".1") + "%", color: benchColor)
        table.addCell(converter.toString(mean, boundary: boundary, unit: unit), color: benchColor)

        let key = caseId.toString() + argText + "_${props.measurementName}"

        if (isBaseline) {
            table.addCell("100%", color: benchColor)
        } else {
            match (props.baseline) {
                case NotFound => table.addCell("NotFound", color: YELLOW)
                case TestCaseBaseline(baselineMean) => addCompareCell(mean, baselineMean)
                case PreviousReport =>
                    match (getResultFromBaselineReport(key)) {
                        case None => table.addCell("-", color: benchColor)
                        case Some(previous) => addCompareCell(mean, previous)
                    }
            }
        }
        putResultToBaselineReport(key, mean)
    }

    static func build(parent: BenchTableImpl, caseId: TestCaseId, measurements: Iterable<BenchStepEntry>,
        firstIsBaseline: Bool) {
        var isFirst = true
        for (stepResult in measurements) {
            let benchStats = stepResult.result
            let result = benchStats.mainResult

            let isBaseline = match (parent.props.baseline) {
                case TestCaseBaseline(_) => isFirst && firstIsBaseline
                case _ => false
            }

            let isEmptyResult = benchStats.errorEst == 0.0 && result == 0.0
            let argText = stepResult.arg.textDescription?.toString() ?? "-"

            let caseRow = if (isEmptyResult) {
                BenchCaseRow(parent, caseId, argText, isBaseline)
            } else {
                let error = benchStats.errorEst
                let errorPercent = if (error == 0.0 && result == 0.0) { 0.0 } else { error / result * 100.0 }
                BenchCaseRow(
                    parent, caseId, argText, median: result, err: error, errPercent: errorPercent,
                    mean: max(benchStats.mean, 0.0), isBaseline: isBaseline
                )
            }
            parent.addSubgroup(caseRow)
            isFirst = false
        }
    }

    private func addCompareCell(result: Float64, baseline: Float64) {
        props.hasRatioColumn = true
        let ratio = if (isEmptyResult) { 0.0 } else { (result / baseline - 1.0) * 100.0 }
        table.addCell(ratio.format("+.1") + "%", color: if (isEmptyResult) { benchColor } else { percentToColor(ratio) })
    }
}
