/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest.mock

import std.unittest.common.*

public abstract class PrettyException <: Exception & PrettyPrintable {
    PrettyException(
        private let text: PrettyText
    ) {
        super(text.toString())
    }

    public func pprint(to: PrettyPrinter): PrettyPrinter {
        text.pprint(to)
    }
}

/**
 * An error in mock framework implementation. User should not expect this exception to be thrown.
 */
public class MockFrameworkInternalError <: PrettyException {
    MockFrameworkInternalError(
        text: PrettyText
    ) {
        super(text)
    }
}

/**
 * Erroneous or inconsistent use of mock framework API.
 */
public class MockFrameworkException <: PrettyException {
    MockFrameworkException(
        text: PrettyText
    ) {
        super(text)
    }
}

/**
 * One or more expectation set during mock configuration were violated during test execution.
 */
public open class ExpectationFailedException <: PrettyException {
    ExpectationFailedException(
        text: PrettyText
    ) {
        super(text)
    }
}

/**
 * Indicates that a stub was never triggered by the code under test.
 */
public class UnnecessaryStubbingException <: PrettyException {
    UnnecessaryStubbingException(
        text: PrettyText
    ) {
        super(text)
    }
}

/**
 * No stubs that match this invocation were provided.
 */
public class UnstubbedInvocationException <: PrettyException {
    UnstubbedInvocationException(
        text: PrettyText
    ) {
        super(text)
    }
}

/**
 * None of the provided stubs handled the call.
 */
public class UnhandledCallException <: PrettyException {
    UnhandledCallException(
        text: PrettyText
    ) {
        super(text)
    }
}

public class VerificationFailedException <: PrettyException {
    VerificationFailedException(
        text: PrettyText
    ) {
        super(text)
    }
}
