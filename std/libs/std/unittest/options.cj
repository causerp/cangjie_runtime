/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest

import std.random.Random
import std.unittest.prop_test.RandomSource

public struct KeyHelp <: KeyFor<Bool> {
    public static prop help: KeyHelp {
        get() {
            KeyHelp()
        }
    }

    public prop name: String {
        get() {
            "help"
        }
    }
}

public struct KeyNoColor <: KeyFor<Bool> {
    public static prop noColor: KeyNoColor {
        get() {
            KeyNoColor()
        }
    }

    public prop name: String {
        get() {
            "noColor"
        }
    }
}

public struct KeyFromTopLevel <: KeyFor<Bool> {
    public static prop fromTopLevel: KeyFromTopLevel {
        get() {
            KeyFromTopLevel()
        }
    }

    public prop name: String {
        get() {
            "fromTopLevel"
        }
    }
}

public struct KeyRandomSeed <: KeyFor<Int64> {
    public static prop randomSeed: KeyRandomSeed {
        get() {
            KeyRandomSeed()
        }
    }

    public prop name: String {
        get() {
            "randomSeed"
        }
    }
}

public struct KeyWarmup <: KeyFor<Int64> & KeyFor<Duration> {
    public static prop warmup: KeyWarmup {
        get() {
            KeyWarmup()
        }
    }

    public prop name: String {
        get() {
            "warmup"
        }
    }
}

public struct KeyMinDuration <: KeyFor<Duration> {
    public static prop minDuration: KeyMinDuration {
        get() {
            KeyMinDuration()
        }
    }

    public prop name: String {
        get() {
            "minDuration"
        }
    }
}

public struct KeyExplicitGC <: KeyFor<ExplicitGcType> {
    public static prop explicitGC: KeyExplicitGC {
        get() {
            KeyExplicitGC()
        }
    }

    public prop name: String {
        get() {
            "explicitGC"
        }
    }
}

public struct KeyMinBatches <: KeyFor<Int64> {
    public static prop minBatches: KeyMinBatches {
        get() {
            KeyMinBatches()
        }
    }

    public prop name: String {
        get() {
            "minBatches"
        }
    }
}

public struct KeyBatchSize <: KeyFor<Int64> & KeyFor<Range<Int64>> {
    public static prop batchSize: KeyBatchSize {
        get() {
            KeyBatchSize()
        }
    }

    public prop name: String {
        get() {
            "batchSize"
        }
    }
}

public struct KeyParallel <: KeyFor<Bool> & KeyFor<String> & KeyFor<Int64> {
    public static prop parallel: KeyParallel {
        get() {
            KeyParallel()
        }
    }

    public prop name: String {
        get() {
            "parallel"
        }
    }
}

public struct KeyGenerationSteps <: KeyFor<Int64> {
    public static prop generationSteps: KeyGenerationSteps {
        get() {
            KeyGenerationSteps()
        }
    }

    public prop name: String {
        get() {
            "generationSteps"
        }
    }
}

public struct KeyReductionSteps <: KeyFor<Int64> {
    public static prop reductionSteps: KeyReductionSteps {
        get() {
            KeyReductionSteps()
        }
    }

    public prop name: String {
        get() {
            "reductionSteps"
        }
    }
}

public struct KeySkip <: KeyFor<Bool> {
    public static prop skip: KeySkip {
        get() {
            KeySkip()
        }
    }

    public prop name: String {
        get() {
            "skip"
        }
    }
}

public struct KeyCoverageGuided <: KeyFor<Bool> {
    public static prop coverageGuided: KeyCoverageGuided {
        get() {
            KeyCoverageGuided()
        }
    }

    public prop name: String {
        get() {
            "coverageGuided"
        }
    }
}

public struct KeyCoverageGuidedInitialSeeds <: KeyFor<Int64> {
    public static prop coverageGuidedInitialSeeds: KeyCoverageGuidedInitialSeeds {
        get() {
            KeyCoverageGuidedInitialSeeds()
        }
    }

    public prop name: String {
        get() {
            "coverageGuidedInitialSeeds"
        }
    }
}

public struct KeyCoverageGuidedMaxCandidates <: KeyFor<Int64> {
    public static prop coverageGuidedMaxCandidates: KeyCoverageGuidedMaxCandidates {
        get() {
            KeyCoverageGuidedMaxCandidates()
        }
    }

    public prop name: String {
        get() {
            "coverageGuidedMaxCandidates"
        }
    }
}

public struct KeyCoverageGuidedBaselineScore <: KeyFor<Int64> {
    public static prop coverageGuidedBaselineScore: KeyCoverageGuidedBaselineScore {
        get() {
            KeyCoverageGuidedBaselineScore()
        }
    }

    public prop name: String {
        get() {
            "coverageGuidedBaselineScore"
        }
    }
}

public struct KeyCoverageGuidedNewCoverageScore <: KeyFor<Int64> {
    public static prop coverageGuidedNewCoverageScore: KeyCoverageGuidedNewCoverageScore {
        get() {
            KeyCoverageGuidedNewCoverageScore()
        }
    }

    public prop name: String {
        get() {
            "coverageGuidedNewCoverageScore"
        }
    }
}

public struct KeyCoverageGuidedNewCoverageBonus <: KeyFor<Int64> {
    public static prop coverageGuidedNewCoverageBonus: KeyCoverageGuidedNewCoverageBonus {
        get() {
            KeyCoverageGuidedNewCoverageBonus()
        }
    }

    public prop name: String {
        get() {
            "coverageGuidedNewCoverageBonus"
        }
    }
}

public struct KeyBench <: KeyFor<Bool> {
    public static prop bench: KeyBench {
        get() {
            KeyBench()
        }
    }

    public prop name: String {
        get() {
            "bench"
        }
    }
}

public struct KeyTimeout <: KeyFor<Duration> {
    public static prop timeout: KeyTimeout {
        get() {
            KeyTimeout()
        }
    }

    public prop name: String {
        get() {
            "timeout"
        }
    }
}

public struct KeyTimeoutEach <: KeyFor<String> {
    public static prop timeoutEach: KeyTimeoutEach {
        get() {
            KeyTimeoutEach()
        }
    }

    public prop name: String {
        get() {
            "timeoutEach"
        }
    }
}

public struct KeyCaptureOutput <: KeyFor<Bool> {
    public static prop captureOutput: KeyCaptureOutput {
        get() {
            KeyCaptureOutput()
        }
    }

    public prop name: String {
        get() {
            "captureOutput"
        }
    }
}

public struct KeyNoCaptureOutput <: KeyFor<Bool> {
    public static prop noCaptureOutput: KeyNoCaptureOutput {
        get() {
            KeyNoCaptureOutput()
        }
    }

    public prop name: String {
        get() {
            "noCaptureOutput"
        }
    }
}

public struct KeyShowAllOutput <: KeyFor<Bool> {
    public static prop showAllOutput: KeyShowAllOutput {
        get() {
            KeyShowAllOutput()
        }
    }

    public prop name: String {
        get() {
            "showAllOutput"
        }
    }
}

public struct KeyVerbose <: KeyFor<Bool> {
    public static prop verbose: KeyVerbose {
        get() {
            KeyVerbose()
        }
    }

    public prop name: String {
        get() {
            "verbose"
        }
    }
}

public struct KeyMeasurement <: KeyFor<Measurement> {
    public static prop measurement: KeyMeasurement {
        get() {
            KeyMeasurement()
        }
    }

    public prop name: String {
        get() {
            "measurement"
        }
    }
}

public struct KeyMeasurementInfo <: KeyFor<MeasurementInfo> {
    public static prop measurementInfo: KeyMeasurementInfo {
        get() {
            KeyMeasurementInfo()
        }
    }

    public prop name: String {
        get() {
            "measurementInfo"
        }
    }
}

public struct KeyInternalTestrunnerInputPath <: KeyFor<String> {
    public static prop internalTestrunnerInputPath: KeyInternalTestrunnerInputPath {
        get() {
            KeyInternalTestrunnerInputPath()
        }
    }

    public prop name: String {
        get() {
            "internalTestrunnerInputPath"
        }
    }
}

public struct KeyDeathAware <: KeyFor<Bool> {
    public static prop deathAware: KeyDeathAware {
        get() {
            KeyDeathAware()
        }
    }

    public prop name: String {
        get() {
            "deathAware"
        }
    }
}

public struct KeyBaseline <: KeyFor<String> {
    public static prop baseline: KeyBaseline {
        get() {
            KeyBaseline()
        }
    }

    public prop name: String {
        get() {
            "baseline"
        }
    }
}

public struct KeyFilter <: KeyFor<String> {
    public static prop filter: KeyFilter {
        get() {
            KeyFilter()
        }
    }

    public prop name: String {
        get() {
            "filter"
        }
    }
}

public struct KeyIncludeTags <: KeyFor<String> {
    public static prop includeTags: KeyIncludeTags {
        get() {
            KeyIncludeTags()
        }
    }

    public prop name: String {
        get() {
            "includeTags"
        }
    }
}

public struct KeyExcludeTags <: KeyFor<String> {
    public static prop excludeTags: KeyExcludeTags {
        get() {
            KeyExcludeTags()
        }
    }

    public prop name: String {
        get() {
            "excludeTags"
        }
    }
}

public struct KeyReportPath <: KeyFor<String> {
    public static prop reportPath: KeyReportPath {
        get() {
            KeyReportPath()
        }
    }

    public prop name: String {
        get() {
            "reportPath"
        }
    }
}

public struct KeyReportFormat <: KeyFor<String> {
    public static prop reportFormat: KeyReportFormat {
        get() {
            KeyReportFormat()
        }
    }

    public prop name: String {
        get() {
            "reportFormat"
        }
    }
}

public struct KeyBaselinePath <: KeyFor<String> {
    public static prop baselinePath: KeyBaselinePath {
        get() {
            KeyBaselinePath()
        }
    }

    public prop name: String {
        get() {
            "baselinePath"
        }
    }
}

struct KeyInternalWorkerId <: KeyFor<Int64> {
    public static prop internalWorkerId: KeyInternalWorkerId {
        get() {
            KeyInternalWorkerId()
        }
    }

    public prop name: String {
        get() {
            "internalWorkerId"
        }
    }
}

struct KeyInternalNWorkers <: KeyFor<Int64> {
    public static prop internalNWorkers: KeyInternalNWorkers {
        get() {
            KeyInternalNWorkers()
        }
    }

    public prop name: String {
        get() {
            "internalNWorkers"
        }
    }
}

struct KeyInternalWorkerSkipNTests <: KeyFor<Int64> {
    public static prop internalWorkerSkipNTests: KeyInternalWorkerSkipNTests {
        get() {
            KeyInternalWorkerSkipNTests()
        }
    }

    public prop name: String {
        get() {
            "internalWorkerSkipNTests"
        }
    }
}

struct KeyInternalMainProcessPort <: KeyFor<UInt16> {
    public static prop internalMainProcessPort: KeyInternalMainProcessPort {
        get() {
            KeyInternalMainProcessPort()
        }
    }

    public prop name: String {
        get() {
            "internalMainProcessPort"
        }
    }
}

public struct KeyDryRun <: KeyFor<Bool> {
    public static prop dryRun: KeyDryRun {
        get() {
            KeyDryRun()
        }
    }

    public prop name: String {
        get() {
            "dryRun"
        }
    }
}

/**
 * Disables dynamic progress output if passed.
 * type: `Bool`.
 */
struct KeyNoProgress <: KeyFor<Bool> {
    public static prop noProgress: KeyNoProgress {
        get() {
            KeyNoProgress()
        }
    }

    public prop name: String {
        get() {
            "noProgress"
        }
    }
}

/**
 * Has lower precedence than [KeyNoProgress].
 * type: `Bool`.
 */
struct KeyProgressBrief <: KeyFor<Bool> {
    public static prop progressBrief: KeyProgressBrief {
        get() {
            KeyProgressBrief()
        }
    }

    public prop name: String {
        get() {
            "progressBrief"
        }
    }
}

/**
 * Limits the entries amount displaying in the dynamic progress output.
 * Has lower precedence than [KeyProgressBrief].
 * type: `Bool`.
 */
struct KeyProgressEntriesLimit <: KeyFor<Int64> {
    public static prop progressEntriesLimit: KeyProgressEntriesLimit {
        get() {
            KeyProgressEntriesLimit()
        }
    }

    public prop name: String {
        get() {
            "progressEntriesLimit"
        }
    }
}
