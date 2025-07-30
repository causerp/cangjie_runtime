/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest

import std.math.round
import std.regex.Regex
import std.convert.Parsable
import std.runtime.ProcessorInfo

let OP_PRALLEL_NAME = KeyParallel().name
let OP_PARALLEL = "--${OP_PRALLEL_NAME}"
let PARALLEL_KEY = kebabCaseToCamelCase(OP_PRALLEL_NAME)
let N_CORES_MULTIPLICATION_PATTERN: Regex = Regex("(\\d+(\\.\\d+)?)nCores")
let DEFAULT_CORES: Int64 = ProcessorInfo.processorCount
let MAX_N_PROCESSES = 1000

enum ParallelInfo {
    | NoParallel
    | Parallel(Int64)

    static func fromDefaultConfiguration(): ParallelInfo {
        let result = if (let Some(nCores) <- defaultConfiguration().get<Int64>(KeyParallel.parallel)) {
            if (nCores < 1) {
                reportError(nCores.toString())
            }
            Parallel(crop(nCores))
        } else if (let Some(predefined) <- defaultConfiguration().get<String>(KeyParallel.parallel)) {
            match ((predefined, parseMultiplicationPattern(predefined))) {
                case ("nCores", _) => Parallel(ProcessorInfo.processorCount)
                case (_, Some(multiplier)) =>
                    if (multiplier > 0.0) {
                        let nCores = Int64(round(multiplier * Float64(ProcessorInfo.processorCount)))
                        Parallel(crop(nCores))
                    } else {
                        reportError(predefined)
                    }
                case _ => reportError(predefined)
            }
        } else if (let Some(true) <- defaultConfiguration().get<Bool>(KeyParallel.parallel)) {
            Parallel(DEFAULT_CORES)
        } else {
            NoParallel
        }

        if (let Parallel(nCores) <- result) {
            if (nCores > 1) {
                if (let Some(true) <- defaultConfiguration().get<Bool>(KeyBench.bench)) {
                    throw UnittestCliOptionsFormatException(
                        "It is not allowed to use both ${OP_PARALLEL} and ${OP_BENCH} at once")
                }
            }
        }

        result
    }

    private static func crop(value: Int64): Int64 {
        max(1, min(MAX_N_PROCESSES, value))
    }

    private static func reportError(actual: String): Nothing {
        throw UnittestCliOptionsFormatException(
            OP_PARALLEL, actual: actual,
            expected:
                "Parameter format can be one of the following: positive integer number, " +
                "'nCores', N'nCores' (N is positive fractional number)."
        )
    }

    private static func parseMultiplicationPattern(raw: String): ?Float64 {
        if (let Some(data) <- N_CORES_MULTIPLICATION_PATTERN.matcher(raw).fullMatch()) {
            Float64.parse(data.matchString(1))
        } else {
            None
        }
    }

    prop nWorkers: Int64 {
        get() {
            match (this) {
                case NoParallel => 1
                case Parallel(n) => n
            }
        }
    }
}
