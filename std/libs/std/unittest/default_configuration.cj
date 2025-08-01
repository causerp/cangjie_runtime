/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest

import std.sync.AtomicOptionReference
import std.process.Process
import std.unicode.*
import std.unittest.common.*
import std.random.Random
import std.unittest.prop_test.*
import std.unittest.common.KeyTags

func fillAbsentValues(config: Configuration) {
    config.setIfAbsent(KeyGenerationSteps.generationSteps, 200)
    config.setIfAbsent(KeyReductionSteps.reductionSteps, 200)
    config.setIfAbsent(KeyWarmup.warmup, Duration.second)
    config.setIfAbsent(KeyBatchSize.batchSize, 1..MAX_BATCH_SIZE)
    config.setIfAbsent(KeyMinDuration.minDuration, Duration.second * 5)
    config.setIfAbsent(KeyMinBatches.minBatches, 10)
    config.setIfAbsent(KeyExplicitGC.explicitGC, ExplicitGcType.Light)
    config.setIfAbsent(KeyMeasurementInfo.measurementInfo, TimeNow().info)
}

func kebabCaseToCamelCase(str: String) {
    let sb: StringBuilder = StringBuilder()
    let split = str.lazySplit("-", removeEmpty: true)
    match (split.next()) {
        case None => return ""
        case Some(fragment) => sb.append(fragment)
    }
    for (fragment in split) {
        sb.append(fragment.toAsciiTitle())
    }
    return sb.toString()
}

func camelCaseToKebabCase(str: String): String {
    let sb = StringBuilder()
    for (c in str.runes()) {
        if (c.isUpperCase()) {
            sb.append('-')
            sb.append(c.toLowerCase())
        } else {
            sb.append(c)
        }
    }

    return sb.toString()
}

func setValueWithGuessedType(configuration: Configuration, key: String, value: String) {
    try {
        let jsv = JsonValue.fromStr(value)
        match (jsv.kind()) {
            case JsBool => configuration.setByName(key, jsv.asBool().getValue())
            case JsInt => configuration.guessInteger(key, jsv.asInt().getValue())
            case JsFloat => configuration.guessFloat(key, jsv.asFloat().getValue())
            case JsString => configuration.setByName(key, jsv.asString().getValue())
            // else just use String
            case _ => configuration.setByName(key, value)
        }
    } catch (ex: JsonException) {
        // ignore the error, just use String
        configuration.setByName(key, value)
    }
}

func buildDefaultConfiguration(): Configuration {
    let programArgs = Process.current.arguments
    let result = Configuration()

    for (arg in programArgs) {
        if (arg.startsWith("--")) {
            let kv = arg[2..].split("=", 2, removeEmpty: true)
            if (kv.size < 1 || kv.size > 2) {
                continue
            }
            let k = kebabCaseToCamelCase(kv[0])
            let v = if (kv.size == 2) { kv[1] } else { "true" }

            if (k == "jsonConfiguration") {
                setValuesFromJsonConfiguration(result, v)
            } else {
                setValueWithGuessedType(result, k, v)
            }
        }
    }

    fillTimeoutKey(result)
    fillAbsentValues(result)

    return result
}

var defaultConfigurationCached: AtomicOptionReference<Configuration> = AtomicOptionReference<Configuration>()

/**
 * Create default configuration by reading command-line arguments.
 * Any command-line argument given to the test will be turned into a field in configuration according to the rules:
 * - kebab-case arguments such as --random-seed are turned into camelCase parameters: randomSeed
 * - arguments with no values are turned into bool values: --no-color becomes noColor of type Bool and value true
 * - the rest are converted according to the following rules, in this order:
 *    - `true` and `false` values are Bool: --feel-good=true becomes field feelGood of type Bool and value true
 *    - integer number literals are Int64: --random-seed=3 becomes field randomSeed of type Int64 and value 3
 *    - float number literals are Float64: --value-pi=3.14 becomes field valuePi of type Float64 and value 3.14
 *    - any other values are considered Strings
 */
public func defaultConfiguration(): Configuration {
    // the idea behind this function is the following: we don't want a lock, because
    // it's too heavy, but we also want to avoid running buildDefaultConfiguration()
    // too many times (several is fine), so we implement double checking using CAS on AtomicOptionReference
    match (defaultConfigurationCached.load()) {
        // it is already set, return it
        case Some(c) => return c
        // it is not set, try setting it
        case None =>
            unittestOptionsRegistryClosed = true
            let newValue = buildDefaultConfiguration()
            // we have a race here, someone could have already assigned the value, so we need to do CAS
            if (defaultConfigurationCached.compareAndSwap(None, newValue)) {
                // CAS was successful, we can just return new value
                return newValue
            } else {
                // CAS is not successful, someone has assigned the value before us, try again
                // this can only recurse one time, so should be fine
                return defaultConfiguration()
            }
    }
}

// this func mutate configuration
func setValuesFromJsonConfiguration(configuration: Configuration, rawJson: String) {
    let jsonObject = JsonValue.fromStr(rawJson).asObject()
    for ((key, jsonValue) in jsonObject.getFields()) {
        let camelKey = kebabCaseToCamelCase(key)
        match (jsonValue) {
            case bool: JsonBool => configuration.setIfAbsentByName(camelKey, bool.getValue())
            case int: JsonInt => configuration.setIfAbsentByName(camelKey, int.getValue())
            case float: JsonFloat => configuration.setIfAbsentByName(camelKey, float.getValue())
            case string: JsonString => configuration.setIfAbsentByName(camelKey, string.getValue())
            case _ => throw UnittestCliOptionsFormatException("Unparsable configuration value ${jsonValue}")
        }
    }
}

private enum Guesser {
    | Success
    | Fail(Exception)

    static func tryDefault(cb: () -> Unit): Guesser {
        try {
            cb()
            return Success
        } catch (e: Exception) {
            return Fail(e)
        }
    }

    func orTry(cb: () -> Unit): Guesser {
        match (this) {
            case Success => Success
            case Fail(_) =>
                try {
                    cb()
                    return Success
                } catch (_: Exception) {
                    return this // keep the first exception
                }
        }
    }

    func orFail(): Unit {
        match (this) {
            case Success => ()
            case Fail(exception) => throw exception
        }
    }
}

extend Configuration {
    func setIfAbsent<T>(key: KeyFor<T>, value: T): Unit {
        match (get<T>(key)) {
            case Some(_) => ()
            case None => set(key, value)
        }
    }

    func setIfAbsentByName<T>(name: String, value: T): Unit {
        match (getByName<T>(name)) {
            case Some(_) => ()
            case None => setByName(name, value)
        }
    }

    func guessInteger(name: String, value: Int64): Unit {
        Guesser.tryDefault { setByName(name, value) }
            .orTry { setByName(name, Int32(value)) }
            .orTry { setByName(name, Int16(value)) }
            .orTry { setByName(name, Int8(value)) }
            .orTry { setByName(name, UInt64(value)) }
            .orTry { setByName(name, UInt32(value)) }
            .orTry { setByName(name, UInt16(value)) }
            .orTry { setByName(name, UInt8(value)) }
            .orFail()
    }

    func guessFloat(name: String, value: Float64): Unit {
        Guesser.tryDefault { setByName(name, value) }
            .orTry { setByName(name, Float32(value)) }
            .orTry { setByName(name, Float16(value)) }
            .orFail()
    }
}

func typeValidator<T>(name: String): (Any) -> OptionValidity {
    { x: Any =>
        match (x) {
            case t: T => return OptionValidity.ValidOption(ConfigurationKey.create<T>(name))
            case _ => return OptionValidity.UnknownOptionType
        }
    }
}

func registerUnittestOption<T>(
    key: KeyFor<T>,
    description!: ?String = None,
    typeDescription!: ?(String, String) = None
): Unit {
    registerOptionValidator(key.name, typeValidator<T>(key.name))

    if (let Some(typeDescription) <- typeDescription) {
        setOrUpdateOptionInfo(key.name, description, typeDescription[0], typeDescription[1])
    }
}

let _ = { =>
    registerUnittestOption<Bool>(KeyHelp.help)
    registerUnittestOption<Bool>(KeyNoColor.noColor, typeDescription: ("Bool", "Print the output colorless"))
    registerUnittestOption<Int64>(KeyRandomSeed.randomSeed,
        typeDescription: ("Int64", "Seed for deterministic test reproduction"))
    registerUnittestOption<RandomSource>(KeyRandom.random)
    registerUnittestOption<Bool>(KeyParallel.parallel, description: "Specify parallelism of tests execution",
        typeDescription: ("Bool", "Run tests in parallel"))
    registerUnittestOption<Int64>(KeyParallel.parallel,
        typeDescription: ("Int64", "Run tests in parallel on %n processes"))
    registerUnittestOption<String>(KeyParallel.parallel,
        typeDescription: ("String", "Run tests in parallel on %n * actual number of cores, e.g. '--parallel=0.5nCores'"))
    registerUnittestOption<Int64>(KeyInternalWorkerId.internalWorkerId)
    registerUnittestOption<Int64>(KeyInternalNWorkers.internalNWorkers)
    registerUnittestOption<Int64>(KeyInternalWorkerSkipNTests.internalWorkerSkipNTests)
    registerUnittestOption<UInt16>(KeyInternalMainProcessPort.internalMainProcessPort)
    registerUnittestOption<String>(KeyInternalTestrunnerInputPath.internalTestrunnerInputPath)
    registerUnittestOption<Duration>(KeyTimeout.timeout)
    registerUnittestOption<String>(KeyTimeoutEach.timeoutEach,
        typeDescription: ("String",
            "Execution time limit for each test case ('millis' | 's' | 'm' | 'h'), e.g. '10s', '9millis'"))
    registerUnittestOption<Array<String>>(KeyTags.tags)
    registerUnittestOption<String>(KeyFilter.filter,
        typeDescription: ("String", "Running a filtered by name subset of tests, e.g. '--filter=*.*Test,*.*case*'"))
    registerUnittestOption<String>(KeyIncludeTags.includeTags,
        typeDescription: ("String", "Include only tests with tags e.g. '--include-tags=Unittest+Smoke'"))
    registerUnittestOption<String>(KeyExcludeTags.excludeTags,
        typeDescription: ("String", "Exclude tests with tags e.g. '--exclude-tags=Performance,Network'"))
    registerUnittestOption<Bool>(KeyCaptureOutput.captureOutput,
        typeDescription: ("Bool", "Disable immediate printing of test output, useful with --parallel"))
    registerUnittestOption<Bool>(KeyNoCaptureOutput.noCaptureOutput,
        typeDescription: ("Bool", "Immediately print test output"))
    registerUnittestOption<Bool>(KeyShowAllOutput.showAllOutput,
        typeDescription: ("Bool", "Print output even for passed tests"))
    registerUnittestOption<Bool>(KeyVerbose.verbose, typeDescription: ("Bool", "Print tests execution status"))
    registerUnittestOption<Bool>(KeySkip.skip)
    registerUnittestOption<Bool>(KeyDryRun.dryRun, typeDescription: ("Bool", "Print tests without execution"))
    registerUnittestOption<Bool>(KeyFromTopLevel.fromTopLevel)
    registerUnittestOption<Int64>(KeyGenerationSteps.generationSteps)
    registerUnittestOption<Int64>(KeyReductionSteps.reductionSteps)
    registerUnittestOption<Bool>(KeyCoverageGuided.coverageGuided)
    registerUnittestOption<Int64>(KeyCoverageGuidedInitialSeeds.coverageGuidedInitialSeeds)
    registerUnittestOption<Int64>(KeyCoverageGuidedMaxCandidates.coverageGuidedMaxCandidates)
    registerUnittestOption<Int64>(KeyCoverageGuidedBaselineScore.coverageGuidedBaselineScore)
    registerUnittestOption<Int64>(KeyCoverageGuidedNewCoverageScore.coverageGuidedNewCoverageScore)
    registerUnittestOption<Int64>(KeyCoverageGuidedNewCoverageBonus.coverageGuidedNewCoverageBonus)
    registerUnittestOption<Bool>(KeyDeathAware.deathAware,
        typeDescription: ("Bool", "Handle abnormal tests exits, e.g. `Process.current.exit(42)`"))
    registerUnittestOption<String>(KeyReportPath.reportPath,
        typeDescription: ("String", "Path where to create report file"))
    registerUnittestOption<String>(KeyReportFormat.reportFormat,
        typeDescription: ("String", "Report format ('xml' for tests), ('csv', 'csw-raw', 'html' for benchmarks)"))
    registerUnittestOption<Bool>(KeyBench.bench,
        typeDescription: ("Bool", "Run only benchmarks (tests marked with @Bench)"))
    registerUnittestOption<String>(KeyBaselinePath.baselinePath,
        typeDescription: ("String", "Path of previous benchmark report to which to compare"))
    registerUnittestOption<String>(KeyBaseline.baseline)
    registerUnittestOption<Int64>(KeyBatchSize.batchSize)
    registerUnittestOption<Range<Int64>>(KeyBatchSize.batchSize)
    registerUnittestOption<Int64>(KeyWarmup.warmup)
    registerUnittestOption<Duration>(KeyWarmup.warmup)
    registerUnittestOption<Duration>(KeyMinDuration.minDuration)
    registerUnittestOption<ExplicitGcType>(KeyExplicitGC.explicitGC)
    registerUnittestOption<Int64>(KeyMinBatches.minBatches)
    registerUnittestOption<Measurement>(KeyMeasurement.measurement)
    registerUnittestOption<MeasurementInfo>(KeyMeasurementInfo.measurementInfo)
    // Dynamic progress
    registerUnittestOption<Bool>(KeyNoProgress.noProgress, description: "Disable progress report",
        typeDescription: ("Bool", "Disable progress report"))
    registerUnittestOption<Bool>(KeyProgressBrief.progressBrief,
        description: "Display brief progress report (single-line) instead of detailed one. Has lower precedence than `--no-progress`",
        typeDescription: ("Bool", "Do display single-line progress report"))
    registerUnittestOption<Int64>(KeyProgressEntriesLimit.progressEntriesLimit,
        typeDescription: ("Int64", "Limit value. Value 0 means no limit. Default: 0"),
        description: "Limit the entries amount displayed in the progress report. Has lower precedence than `--progress-brief`")
}()
