/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest.mock

import std.unittest.common.PrettyText

enum InternalError {
    InconsistentState(String)
    | AssertionFailed(String)
    | Unimplemented(String)
}

// conceptually illegal input is a state that can be attained via (incorrect) use of the public api
// internal error is something that indicates a bug in the implementation
func internalError(e: InternalError): Nothing {
    let report = FailureReport()
    let message = report.build {
        report.errorLine("Mock framework internal error")
        match (e) {
            case InconsistentState(info) => report.line(info)
            case AssertionFailed(info) => report.line(info)
            case Unimplemented(featureName) => report.line("Feature '${featureName}' is not yet implemented")
        }
    }
    throw MockFrameworkInternalError(message)
}

func internalError(assertion: String): Nothing {
    internalError(AssertionFailed(assertion))
}

func illegalInput(text: String): Nothing {
    throw MockFrameworkException(PrettyText(text))
}
