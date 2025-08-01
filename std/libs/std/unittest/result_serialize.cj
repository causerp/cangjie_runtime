/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest

import std.unittest.common.*
import std.time.DateTime
import std.collection.*

extend LStep <: Serializable<LStep> {
    public func serializeInternal(): DataModel {
        let i = match (this) {
            case BeforeAll => 0
            case BeforeEach => 1
            case AfterEach => 2
            case AfterAll => 3
        }
        i.serializeInternal()
    }

    public static func deserialize(dm: DataModel): LStep {
        match (Int64.deserialize(dm)) {
            case 0 => BeforeAll
            case 1 => BeforeEach
            case 2 => AfterEach
            case 3 => AfterAll
            case _ => throw Exception("invalid data")
        }
    }
}

extend StepKind <: Serializable<StepKind> {
    public func serializeInternal(): DataModel {
        let dms = DataModelStruct()
        match (this) {
            case CaseStep(descr) =>
                dms.add(field<?PrettyText>("args", descr.textDescription))
                    .add(field<?Int64>("seed", descr.randomSeed))
                    .add(field<Int64>("step", descr.stepIndex))
                    .add(field<Int64>("reduction", descr.reductionIndex))
            case Lifecycle(lStep) => dms.add(field<LStep>("lifecycle", lStep))
            case Skip => dms.add(field<String>("skip", ""))
            case NoRun => dms.add(field<String>("noRun", ""))
            case UserCode => dms.add(field<String>("userCode", ""))
        }
        dms
    }

    public static func deserialize(dm: DataModel): StepKind {
        let dms = dm.asStruct()
        if (let Some(step) <- dms.tryGet("step")) {
            return CaseStep(ArgumentDescription(
                Option<PrettyText>.deserialize(dms.get("args")),
                Int64.deserialize(step),
                Int64.deserialize(dms.get("reduction")),
                Option<Int64>.deserialize(dms.get("seed")),
            ))
        }
        if (let Some(lStep) <- dms.tryGet("lifecycle")) {
            return Lifecycle(LStep.deserialize(lStep))
        }
        if (let Some(_) <- dms.tryGet("userCode")) {
            return UserCode
        }
        if (let Some(_) <- dms.tryGet("skip")) {
            return Skip
        }
        if (let Some(_) <- dms.tryGet("noRun")) {
            return NoRun
        }
        throw Exception("invalid serialize step kind")
    }
}

extend StepInfo <: Serializable<StepInfo> {
    public func serializeInternal(): DataModel {
        let dms = DataModelStruct()
        match (this) {
            case Test(args) => dms.add(field<Int64>("test", args))
            case Bench(rawMeasurements) =>
                dms.add(field("bench", ArrayOfTuples<Float64,Float64>(rawMeasurements.data)))
            case Failure(checks) => dms.add(field<Array<CheckResult>>("failure", checks))
        }
        dms
    }

    public static func deserialize(dm: DataModel): StepInfo {
        let dms = dm.asStruct()
        if (let Some(testArgs) <- dms.tryGet("test")) {
            return Test(Int64.deserialize(testArgs))
        }
        if (let Some(bench) <- dms.tryGet("bench")) {
            return Bench(BenchmarkResult(ArrayList(ArrayOfTuples<Float64, Float64>.deserialize(bench).original())))
        }
        if (let Some(failure) <- dms.tryGet("failure")) {
            return Failure(Array<CheckResult>.deserialize(failure))
        }

        throw Exception("invalid serialize step kind")
    }
}

extend RunStepResult {
    func doSerialize(): DataModelStruct {
        return DataModelStruct()
            .add(field<StepKind>("stepKind", kind))
            .add(field<StepInfo>("info", info))
            .add(field<Int64>("startTime", startTimestamp.toUnixTimeStamp().toNanoseconds()))
            .add(field<Int64>("checksPassed", checksPassed))
            .add(field<Int64>("duration", duration.toNanoseconds()))
    }

    static func doDeserialize(dm: DataModel): RunStepResult {
        let dms = dm.asStruct()
        let result = RunStepResult(
            Int64.deserialize(dms.get("checksPassed")),
            DateTime.fromUnixTimeStamp(Int64.deserialize(dms.get("startTime")) * Duration.nanosecond),
            StepKind.deserialize(dms.get("stepKind")),
            StepInfo.deserialize(dms.get("info")),
            duration: Int64.deserialize(dms.get("duration")) * Duration.nanosecond,
        )
        result
    }
}

extend TestCaseResult {
    func doSerialize(): DataModelStruct {
        return serializeSubResults()
            .add(field<TestCaseId>("id", caseId))
            .add(field<RenderOptions>("renderOptions", renderOptions))
            .add(field<Bool>("finished", isFinished))
    }

    static func doDeserialize(dm: DataModel): TestCaseResult {
        let dms = dm.asStruct()
        let result = TestCaseResult(
            TestCaseId.deserialize(dms.get("id")),
            RenderOptions.deserialize(dms.get("renderOptions"))
        )
        for (subResult in ArrayList<Result>.deserialize(dms.get("subResults"))) {
            result.add((subResult as RunStepResult).getOrThrow())
        }
        if (Bool.deserialize(dms.get("finished"))) {
            result.finish()
        }
        result
    }
}

extend TestSuiteResult {
    func doSerialize(): DataModelStruct {
        return serializeSubResults()
            .add(field<TestSuiteId>("id", suiteId))
            .add(field<Bool>("finished", isFinished))
    }

    static func doDeserialize(dm: DataModel): TestSuiteResult {
        let dms = dm.asStruct()
        let result = TestSuiteResult(
            TestSuiteId.deserialize(dms.get("id")),
        )
        for (subResult in ArrayList<Result>.deserialize(dms.get("subResults"))) {
            result.add((subResult as TestCaseResult).getOrThrow())
        }
        if (Bool.deserialize(dms.get("finished"))) {
            result.finish()
        }
        result
    }
}

extend TestGroupResult {
    func doSerialize(): DataModelStruct {
        return serializeSubResults()
            .add(field<String>("groupName", groupName))
            .add(field<Bool>("finished", isFinished))
    }

    static func doDeserialize(dm: DataModel): TestGroupResult {
        let dms = dm.asStruct()
        let result = TestGroupResult(String.deserialize(dms.get("groupName")), [])
        for (subResult in Array<Result>.deserialize(dms.get("subResults"))) {
            let suiteResult = (subResult as TestSuiteResult).getOrThrow()
            result.add(suiteResult)
        }
        if (Bool.deserialize(dms.get("finished"))) {
            result.finish()
        }
        result
    }
}

private const RENDER_OPTIONS_BASELINE_KEY = "baseline"
// private const RENDER_OPTIONS_CONVERSION_TABLE_MULTIPLIER_KEY = "conversionTableMultiplier"
// private const RENDER_OPTIONS_CONVERSION_TABLE_UNIT_KEY = "conversionTableUnit"
// private const RENDER_OPTIONS_MEASUREMENT_NAME_KEY = "measurementName"

extend RenderOptions <: Serializable<RenderOptions> {
    public func serializeInternal(): DataModel {
        let dm = DataModelStruct()
            .add(field<?String>(KeyBaseline.baseline.name, baselineString))
        if (let Some(info) <- measurementInfo) {
            dm.add(field<ArrayOfTuples<Float64,String>>("conversionTable", ArrayOfTuples(info.conversionTable)))
                .add(field<?String>("name", info.name))
                .add(field<?String>("textDescription", info.textDescription))
        }

        dm
    }

    public static func deserialize(dm: DataModel): RenderOptions {
        var info = None<MeasurementInfo>
        if (let Some(conv) <- dm.asStruct().tryGet("conversionTable")) {
            info = MeasurementInfo(
                ArrayOfTuples<Float64, String>.deserialize(conv).original(),
                String.deserialize(dm.asStruct().get("name")),
                String.deserialize(dm.asStruct().get("textDescription"))
            )
        }
        RenderOptions(
            Option<String>.deserialize(dm.asStruct().get(KeyBaseline.baseline.name)),
            info
        )
    }
}

struct ArrayOfTuples<A, B> <: Serializable<ArrayOfTuples<A, B>> where A <: Serializable<A>, B <: Serializable<B> {
    ArrayOfTuples(
        let left: Array<A>,
        let right: Array<B>
    ) {}

    init(col: Collection<(A, B)>) {
        let data = col.toArray()
        left = Array(data.size) { i =>
            data[i][0]
        }
        right = Array(data.size) { i =>
            data[i][1]
        }
    }

    func original(): Array<(A, B)> {
        left |> zip(right) |> collectArray
    }

    public func serializeInternal(): DataModel {
        DataModelStruct()
            .add(field("left", left))
            .add(field("right", right))
    }

    public static func deserialize(dm: DataModel): ArrayOfTuples<A, B> {
        ArrayOfTuples(
            Array<A>.deserialize(dm.asStruct().get("left")),
            Array<B>.deserialize(dm.asStruct().get("right")),
        )
    }
}
