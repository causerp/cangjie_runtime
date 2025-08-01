/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest

import std.collection.ArrayList

public class TestSuite {
    TestSuite(
        private let _name: String,
        let cases: Array<CaseOrBench>,
        let suiteConfiguration: Configuration,
        let beforeAlls: Array<() -> Unit>,
        let beforeEachs: Array<(String) -> Unit>,
        let afterEachs: Array<(String) -> Unit>,
        let afterAlls: Array<() -> Unit>,
        let template: ?TestSuite
    ) {
    }

    public prop name: String {
        get() { _name }
    }

    public func runTests(): TestReport {
        run(Configuration(), OnlyTests).asTestReport(Configuration())
    }

    public func runTests(configuration: Configuration): TestReport {
        run(configuration, OnlyTests).asTestReport(configuration)
    }

    public func runBenchmarks(): BenchReport {
        run(Configuration(), OnlyBenchmarks).asBenchReport(Configuration())
    }

    public func runBenchmarks(configuration: Configuration): BenchReport {
        run(configuration, OnlyBenchmarks).asBenchReport(configuration)
    }

    func run(configuration: Configuration, mode: ExecutionMode): TestGroupResult {
        fakeGroup(this).run(configuration, mode)
    }

    func execute(groupName: String, runConfiguration: Configuration, filterService: FilterService): TestSuiteResult {
        let id = TestSuiteId.fromTestSuite(groupName, this)
        TestSuiteExecutor(runConfiguration, id, this, filterService).execute()
    }

    public static func builder(name: String): TestSuiteBuilder {
        TestSuiteBuilder(name)
    }

    public static func builder(suite: TestSuite): TestSuiteBuilder {
        let builder = TestSuiteBuilder(suite.name)
        builder.beforeAlls.add(all: suite.beforeAlls)
        builder.beforeEachs.add(all: suite.beforeEachs)
        builder.afterEachs.add(all: suite.afterEachs)
        builder.afterAlls.add(all: suite.afterAlls)
        builder.tests.add(all: suite.cases)
        builder.configure(suite.suiteConfiguration)
        builder.template_ = suite.template
        builder
    }
}

public class TestGroup {
    TestGroup(
        private let _name: String,
        let suites: Array<TestSuite>,
        let groupConfiguration: Configuration
    ) {}

    public prop name: String {
        get() {
            _name
        }
    }

    public func runTests(): TestReport {
        run(Configuration(), OnlyTests).asTestReport(Configuration())
    }

    public func runTests(configuration: Configuration): TestReport {
        run(configuration, OnlyTests).asTestReport(configuration)
    }

    public func runBenchmarks(): BenchReport {
        run(Configuration(), OnlyBenchmarks).asBenchReport(Configuration())
    }

    public func runBenchmarks(configuration: Configuration): BenchReport {
        run(configuration, OnlyBenchmarks).asBenchReport(configuration)
    }

    func run(configuration: Configuration, mode: ExecutionMode): TestGroupResult {
        let groupId = this.name
        let runConfiguration = Configuration.merge(configuration, groupConfiguration)
        let filterService = FilterService(UserTestFilter.fromConfiguration(configuration), mode.asFilter())
        Framework.launch<TestGroupResult>(api: FromPublicApi, hasWorkersInSetup: false) {
            let groupResult = TestGroupResult(groupId, [])
            for (suite in suites) {
                let suiteResult = suite.execute(groupId, runConfiguration, filterService)
                groupResult.add(suiteResult)
            }
            groupResult.finish()
            groupResult
        }
    }
    public static func builder(name: String): TestGroupBuilder {
        TestGroupBuilder(name)
    }

    public static func builder(group: TestGroup): TestGroupBuilder {
        TestGroupBuilder(group.name)
    }
}

public class TestGroupBuilder {
    private let suites = ArrayList<TestSuite>()
    private var configuration = Configuration()

    TestGroupBuilder(
        private var name: String
    ) {}

    public func setName(name: String): TestGroupBuilder {
        this.name = name
        this
    }

    public func configure(configuration: Configuration): TestGroupBuilder {
        this.configuration = Configuration.merge(this.configuration, configuration)
        this
    }

    public func add(test: UnitTestCase): TestGroupBuilder {
        suites.add(fakeSuite(Case(test)))
        this
    }

    public func add(benchmark: Benchmark): TestGroupBuilder {
        suites.add(fakeSuite(Bench(benchmark)))
        this
    }

    public func add(suite: TestSuite): TestGroupBuilder {
        suites.add(suite)
        this
    }

    public func build(): TestGroup {
        TestGroup(name, suites.toArray(), configuration)
    }
}

public class TestSuiteBuilder {
    let beforeAlls = ArrayList<() -> Unit>()
    let beforeEachs = ArrayList<(String) -> Unit>()
    let afterEachs = ArrayList<(String) -> Unit>()
    let afterAlls = ArrayList<() -> Unit>()

    var configuration = Configuration()
    var tests = ArrayList<CaseOrBench>()

    var template_ = Option<TestSuite>.None

    TestSuiteBuilder(
        private var name: String
    ) {}

    public func setName(name: String): TestSuiteBuilder {
        this.name = name
        this
    }

    public func configure(configuration: Configuration): TestSuiteBuilder {
        this.configuration = Configuration.merge(this.configuration, configuration)
        this
    }

    public func beforeEach(body: (String) -> Unit): TestSuiteBuilder {
        beforeEachs.add(body)
        this
    }

    public func afterEach(body: (String) -> Unit): TestSuiteBuilder {
        afterEachs.add(body)
        this
    }

    public func beforeEach(body: () -> Unit): TestSuiteBuilder {
        beforeEachs.add({ _ => body() })
        this
    }

    public func afterEach(body: () -> Unit): TestSuiteBuilder {
        afterEachs.add({ _ => body() })
        this
    }

    public func beforeAll(body: () -> Unit): TestSuiteBuilder {
        beforeAlls.add(body)
        this
    }

    public func afterAll(body: () -> Unit): TestSuiteBuilder {
        afterAlls.add(body)
        this
    }

    public func add(test: UnitTestCase): TestSuiteBuilder {
        tests.add(Case(test))
        this
    }

    public func add(benchmark: Benchmark): TestSuiteBuilder {
        tests.add(Bench(benchmark))
        this
    }

    public func template(template: TestSuite): TestSuiteBuilder {
        template_ = Some(template)
        this
    }

    public func build(): TestSuite {
        TestSuite(
            name,
            tests.toArray(),
            configuration,
            beforeAlls.toArray(),
            beforeEachs.toArray(),
            afterEachs.toArray(),
            afterAlls.toArray(),
            template_
        )
    }
}

public class UnitTestCase {
    UnitTestCase(
        private let _name: String,
        let caseConfiguration: Configuration,
        let executor: Executor
    ) {}

    public prop name: String {
        get() {
            _name
        }
    }

    public func run(): TestReport {
        fakeGroup(fakeSuite(Case(this))).run(Configuration(), OnlyTests).asTestReport(caseConfiguration)
    }

    public static func createParameterized<T>(name: String, strategy: DataStrategy<T>,
        configuration!: Configuration = Configuration(), body!: (T) -> Unit): UnitTestCase {
        let processor = DataStrategyProcessor<T>.start(strategy, "args")
        createParameterized<T>(name, processor, configuration: configuration, body: body)
    }

    public static func createParameterized<T>(name: String, strategy: DataStrategyProcessor<T>,
        configuration!: Configuration = Configuration(), body!: (T) -> Unit): UnitTestCase {
        let executor = TestCaseExecutor(strategy, body)
        UnitTestCase(name, configuration, executor)
    }

    public static func create(name: String, configuration!: Configuration = Configuration(), body!: () -> Unit): UnitTestCase {
        createParameterized<Unit>(name, noArgsProcessor(), configuration: configuration, body: { _ => body() })
    }
}

public class Benchmark {
    Benchmark(
        private let _name: String,
        let benchmarkConfiguration: Configuration,
        let executor: Executor
    ) {}

    public prop name: String { get() { _name } }

    public func run(): BenchReport {
        fakeGroup(fakeSuite(Bench(this))).run(Configuration(), OnlyBenchmarks).asBenchReport(benchmarkConfiguration)
    }

    static func createWithExplicitLoop<T>(
        name: String,
        strategy: DataStrategyProcessor<T>,
        configuration: Configuration,
        optLambda: (T, Int64, Int64) -> Float64
    ): Benchmark {
        Benchmark(name, configuration, BenchExecutor<T>(strategy, optLambda))
    }

    // Creates parameterized benchmark with provided data strategy.
    //
    // Note: this api is inferior to @Bench macro because it uses lambda which can cause undesired overhead.
    // It should not be used for micro benchmarks.
    public static func createParameterized<T>(
        name: String,
        strategy: DataStrategy<T>,
        configuration!: Configuration = Configuration(),
        measurement!: Measurement = TimeNow(),
        body!: (T) -> Unit
    ): Benchmark {
        createParameterized(name, DataStrategyProcessor.start(strategy, "args"), configuration: configuration,
            measurement: measurement, body: body)
    }

    // Creates parameterized benchmark with provided data strategy processor.
    //
    // Note: this api is inferior to @Bench macro because it uses lambda which can cause undesired overhead.
    // It should not be used for micro benchmarks.
    public static func createParameterized<T>(
        name: String,
        strategy: DataStrategyProcessor<T>,
        configuration!: Configuration = Configuration(),
        measurement!: Measurement = TimeNow(),
        body!: (T) -> Unit
    ): Benchmark {
        configuration.set(KeyMeasurementInfo.measurementInfo, measurement.info)
        createWithExplicitLoop<T>(name, strategy, configuration, createBenchmarkLoop<T>(measurement, body))
    }

    // Creates parameterized benchmark from given lambda.
    //
    // Note: this api is inferior to @Bench macro because it uses lambda which can cause undesired overhead.
    // It should not be used for micro benchmarks.
    public static func create(
        name: String,
        configuration!: Configuration = Configuration(),
        measurement!: Measurement = TimeNow(),
        body!: () -> Unit
    ): Benchmark {
        createParameterized<Unit>(name, noArgsProcessor(), configuration: configuration, measurement: measurement,
            body: {_ => body()})
    }

    // macros generate lambdas that minimizes overhead
    // however users can use more convenient APIs for macrobenchmarks
    // this is how we transform one into the other
    private static func createBenchmarkLoop<T>(
        measurement: Measurement,
        singleRun: (T) -> Unit
    ): (T, Int64, Int64) -> Float64 {
        { value, count: Int64, max: Int64 =>
            let start = measurement.measure()
            for (i in 0..max) {
                if (i < count) {
                    singleRun(value)
                }
            }
            measurement.measure() - start
        }
    }
}

sealed abstract class Report {
    private let details: Details

    Report(
        let groupResult: TestGroupResult,
        let runConfiguration: Configuration
    ) {
        this.details = groupResult.details
    }

    public prop errorCount:   Int64 { get() { details.errorCount }}
    public prop caseCount:    Int64 { get() { details.totalCount }}
    public prop passedCount:  Int64 { get() { details.passedCount }}
    public prop failedCount:  Int64 { get() { details.failedCount }}
    public prop skippedCount: Int64 { get() { details.skippedCount }}
}

public class TestReport <: Report {
    TestReport(groupResult: TestGroupResult, runConfiguration: Configuration) {
        super(groupResult, runConfiguration)
    }

    public func reportTo<T>(reporter: Reporter<TestReport, T>): T {
        (doReport(reporter) as T).getOrThrow()
    }

    private func doReport<T>(reporter: Reporter<TestReport, T>): Any {
        match (reporter) {
            case printer: TextReporterBase<T> => return printer.printReport(this)
            case xmlReporter: XmlReporter => UTestReportFormat.XML(xmlReporter.directory).report(groupResult)
            case _ => throw Exception("Unkown reporter")
        }
    }
}

public class BenchReport <: Report {
    BenchReport(groupResult: TestGroupResult, runConfiguration: Configuration) {
        super(groupResult, runConfiguration)
    }

    public func reportTo<T>(reporter: Reporter<BenchReport, T>): T {
        (doReport(reporter) as T).getOrThrow()
    }

    private func doReport<T>(reporter: Reporter<BenchReport, T>): Any {
        match (reporter) {
            case printer: TextReporterBase<T> => printer.printReport(this)
            case csv: CsvReporter => BenchReportFormat.CSV(csv.directory).report(groupResult)
            case csvRaw: CsvRawReporter => BenchReportFormat.CSV_RAW(csvRaw.directory).report(groupResult)
            case rawStatsReporter: RawStatsReporter => rawStatsReporter.benchResultsAsMap(groupResult)
            case _ => throw Exception("Unkown reporter")
        }
    }
}

public interface TestClass {
    func asTestSuite(): TestSuite
}

// NOTE: this class is used internally by the compiler and is considered implementation details
public class TestPackage {
    private let builder: TestGroupBuilder

    public TestPackage(
        let name: String
    ) {
        this.builder = TestGroupBuilder(name)
    }

    public func registerCase(testCase: () -> UnitTestCase): Unit {
        builder.add(testCase())
    }

    public func registerSuite(suite: () -> TestSuite): Unit {
        builder.add(suite())
    }

    public func registerBench(bench: () -> Benchmark): Unit {
        builder.add(bench())
    }

    func build(): TestGroup {
        builder.build()
    }
}

enum ExecutionMode {
    OnlyTests | OnlyBenchmarks

    func asFilter(): FrameworkTestFilter {
        match (this) {
            case OnlyTests => BenchTestFilter(false)
            case OnlyBenchmarks => BenchTestFilter(true)
        }
    }
}

enum CaseOrBench {
    | Case(UnitTestCase)
    | Bench(Benchmark)

    prop caseConfiguration: Configuration {
        get() {
            match (this) {
                case Case(testCase) => testCase.caseConfiguration
                case Bench(benchmark) => benchmark.benchmarkConfiguration
            }
        }
    }

    prop name: String {
        get() {
            match (this) {
                case Case(testCase) => testCase.name
                case Bench(benchmark) => benchmark.name
            }
        }
    }

    prop isBench: Bool {
        get() {
            match (this) {
                case Case(_) => false
                case Bench(_) => true
            }
        }
    }

    prop executor: Executor {
        get() {
            match (this) {
                case Case(testCase) => testCase.executor
                case Bench(benchmark) => benchmark.executor
            }
        }
    }
}

private func fakeSuite(test: CaseOrBench): TestSuite {
    TestSuite("TestCase_${test.name}", [test], Configuration(),
        [], [], [], [], None
    )
}

private func fakeGroup(testSuite: TestSuite): TestGroup {
    TestGroup(
        "default",
        [testSuite], Configuration()
    )
}

extend TestGroupResult {
    func asBenchReport(runConfiguration: Configuration) {
        BenchReport(this, runConfiguration)
    }

    func asTestReport(runConfiguration: Configuration) {
        TestReport(this, runConfiguration)
    }
}

private let NO_ARGS_NAME = "<no args>"

private func noArgsProcessor(): DataStrategyProcessor<Unit> {
    DataStrategyProcessor<Unit>.start([()], "<no args>")
}

extend Array<InputParameter> {
    func isNoArg() {
        size == 1 && this[0].name == NO_ARGS_NAME
    }
}
