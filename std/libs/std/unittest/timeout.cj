/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest

import std.regex.Regex
import std.convert.Parsable

let OP_TIMEOUT_EACH_NAME = camelCaseToKebabCase(KeyTimeoutEach().name)
let OP_TIMEOUT_EACH = "--${OP_TIMEOUT_EACH_NAME}"
let TIMEOUT_EACH_KEY = kebabCaseToCamelCase(OP_TIMEOUT_EACH_NAME)
let VALUE_TIMEOUT_PATTERN: Regex = Regex("(\\d+(\\.\\d+)?)(millis|s|m|h)")

extend Configuration {
    prop timeout: ?Duration {
        get() {
            get(KeyTimeout.timeout)
        }
    }
}

func fillTimeoutKey(configuration: Configuration): Unit {
    if (let Some(timeout) <- configuration.get(KeyTimeoutEach.timeoutEach)) {
        if (let Some(parsed) <- parseTimeout(timeout)) {
            configuration.set(KeyTimeout.timeout, parsed)
        } else {
            throw UnittestCliOptionsFormatException(
                OP_TIMEOUT_EACH,
                actual: timeout,
                expected: "NUMBER(millis|s|m|h) format is expected. Example: 3s."
            )
        }
    }
}

private func parseTimeout(raw: String): ?Duration {
    if (let Some(data) <- VALUE_TIMEOUT_PATTERN.matcher(raw).fullMatch()) {
        let value = Float64.parse(data.matchString(1))
        let duration = match (data.matchString(3)) {
            case "millis" => Duration.millisecond
            case "s" => Duration.second
            case "m" => Duration.minute
            case "h" => Duration.hour
            case _ => throw Exception("unreachable")
        }
        duration * value
    } else {
        None
    }
}
