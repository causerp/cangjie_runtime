/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest

import std.unittest.common.*

/**
 * TestCode is the result of the running case.
 * @since 0.17.3
 */
enum TestCode <: ToString & PrettyPrintable & Equatable<TestCode> {
    | PASS // passed tests
    | SKIP // @Skip'ed, filtered out by --filter and --tags tests
    | TIMEOUT
    | FAIL // checks failed
    | ERROR // execution aborted by exception or crash
    | NORUN // dry execution

    public func toString(): String {
        match (this) {
            case PASS => "PASS"
            case SKIP => "SKIP"
            case TIMEOUT => "TIMEOUT"
            case FAIL => "FAIL"
            case ERROR => "ERROR"
            case NORUN => "NORUN"
        }
    }

    func mostSevereWith(other: TestCode): TestCode {
        if (this.severity() > other.severity()) {
            this
        } else {
            other
        }
    }

    private func severity(): Int64 {
        match (this) {
            case PASS => 0
            case SKIP => 1
            case TIMEOUT => 2
            case FAIL => 3
            case ERROR => 4
            case NORUN => 5 // it can be potentially compared only with skip
        }
    }

    func isFailure(): Bool {
        match (this) {
            case PASS | SKIP | NORUN => false
            case _ => true
        }
    }

    func toStringTense(): String {
        match (this) {
            case PASS => "PASSED"
            case SKIP => "SKIPPED"
            case TIMEOUT => "TIMEOUT"
            case FAIL => "FAILED"
            case ERROR => "ERROR"
            case NORUN => "NORUN"
        }
    }

    public operator func ==(right: TestCode): Bool {
        match ((this, right)) {
            case (PASS, PASS) => return true
            case (SKIP, SKIP) => return true
            case (TIMEOUT, TIMEOUT) => return true
            case (FAIL, FAIL) => return true
            case (ERROR, ERROR) => return true
            case (NORUN, NORUN) => return true
            case _ => return false
        }
    }

    public operator func !=(right: TestCode): Bool {
        !(this == right)
    }

    public func pprint(pp: PrettyPrinter): PrettyPrinter {
        let color = match (this) {
            case PASS | SKIP | NORUN => Color.GREEN
            case FAIL => Color.RED
            case TIMEOUT | ERROR => return pp.append(toStringTense())
        }
        pp.colored(color) { pp.append(toStringTense()) }
    }
}
