/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest

/*
 * Fails the test case.
 */
public func failExpect(message: String): Unit {
    let checkResult = FailCheckResult(Expect, message)
    Framework.withCurrentContext{ ctx => ctx.checkFailed(checkResult) }
}

/*
 * Immediately fails the test case.
 */
public func fail(message: String): Nothing {
    let checkResult = FailCheckResult(Assert, message)
    Framework.withCurrentContext{ ctx => ctx.checkFailed(checkResult) }
    throw AssertException(message, checkResult)
}

/*
 * Immediately fails the test with message that was caught exception differs from expeted.
 */
public func assertCaughtUnexpectedE(
    message: String,
    expectedExceptions: String,
    caughtException: String,
    optParentCtx!: ?AssertionCtx = None
): Nothing {
    let checkResult = AssertThrowsCheckResult(Assert, message, expectedExceptions, caughtException)
    if (let Some(parentCtx) <- optParentCtx) {
        parentCtx.fail(checkResult)
    } else {
        Framework.withCurrentContext{ ctx => ctx.checkFailed(checkResult) }
        throw AssertException(message, checkResult)
    }
}

/*
 * Fails the test with message that was caught exception differs from expeted.
 */
public func expectCaughtUnexpectedE(
    message: String,
    expectedExceptions: String,
    caughtException: String,
    optParentCtx!: ?AssertionCtx = None
): Unit {
    let checkResult = AssertThrowsCheckResult(Expect, message, expectedExceptions, caughtException)
    if (let Some(parentCtx) <- optParentCtx) {
        parentCtx.failExpect(checkResult)
    } else {
        Framework.withCurrentContext{ ctx => ctx.checkFailed(checkResult) }
    }
}
