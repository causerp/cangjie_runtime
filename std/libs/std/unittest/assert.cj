/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest

import std.unittest.diff.AssertPrintable
import std.unittest.common.*

/**
 * Checks two values for equality and will throw an exception if the check fails.
 *
 * @param leftStr string representation of expected.
 * @param rightStr string representation of actual.
 * @param expected expected value.
 * @param actual actual value.
 * @param optParentCtx context where fail message is stored

 * @throws AssertException If <expected> and <actual> are not equal.
 */
public func assertEqual<T>(leftStr: String, rightStr: String, expected: T, actual: T,
    optParentCtx!: ?AssertionCtx = None): Unit where T <: Equatable<T> {
    if (let Some(parentCtx) <- optParentCtx) {
        if (expected != actual) {
            let cr = buildCheckResult(leftStr, rightStr, expected, actual, Assert)
            parentCtx._errors.add(Leaf(cr))
            throw AssertException("", cr)
        }
    } else {
        if (expected != actual) {
            let cr = buildCheckResult(leftStr, rightStr, expected, actual, Assert)
            Framework.withCurrentContext{ ctx => ctx.checkFailed(cr) }
            throw AssertException("", cr)
        } else {
            Framework.withCurrentContext{ ctx => ctx.checkPassed() }
        }
    }
}

/**
 * Same as assertEqual but will not throw an exception immediately.
 *
 * @param leftStr string representation of expected.
 * @param rightStr string representation of actual.
 * @param expected expected value.
 * @param actual actual value.
 * @param optParentCtx context where fail message is stored
 */
public func expectEqual<T>(leftStr: String, rightStr: String, expected: T, actual: T,
    optParentCtx!: ?AssertionCtx = None): Unit where T <: Equatable<T> {
    if (let Some(parentCtx) <- optParentCtx) {
        if (expected != actual) {
            let cr = buildCheckResult(leftStr, rightStr, expected, actual, Expect)
            parentCtx._errors.add(Leaf(cr))
        }
    } else {
        if (expected != actual) {
            let cr = buildCheckResult(leftStr, rightStr, expected, actual, Expect)
            Framework.withCurrentContext{ ctx => ctx.checkFailed(cr) }
        } else {
            Framework.withCurrentContext{ ctx => ctx.checkPassed() }
        }
    }
}

func buildCheckResult<T>(
    leftStr: String, rightStr: String, expected: T, actual: T, checkResultKind: CheckResultKind
): AssertExpectCheckResult {
    match (expected) {
        case te: AssertPrintable<T> =>
            let message = PrettyText()
            te.pprintForAssertion(message, actual, leftStr, rightStr, 1)
            DiffCheckResult(checkResultKind, message)
        case _ =>
            PlainCompareCheckResult(
                checkResultKind, leftStr, rightStr, toStringOrPlaceholder(expected), toStringOrPlaceholder(actual)
            )
    }
}
