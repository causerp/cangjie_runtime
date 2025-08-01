/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest.mock

import std.collection.ArrayList

/**
 * Entry point for Verification API.
 * Allows perform checks on invocation log that is tracked for mock and spy objects.
 * Invocation log is kept since the start of a @TestCase function and is cleared after.
 * Calling verification functions (*that*, *ordered*, *unordered*) will not change the state of invocation log.
 * To clear the log manually use *clearInvocationLog* function.
 */
public class Verify {
    /**
     * Verifies that a single *VerifyStatement* is true. Calls not matching this statement will be ignored.
     * @param VerifyStatement to check.
     * @throws VerificationFailedException if verification fails.
     */
    public static func that(statement: VerifyStatement): Unit {
        unordered(Partial, [statement])
    }

    /**
     * Performs *unordered* verification.
     * Checks that invocations match statements irrespective of the order statements were declared in.
     * *VerifyStatement*s are provided via *collectStatements* callback.
     * Statements in *unordered* section must be disjoint (effectively a single invocation matching several statements will be considered an error).
     * *atLeastOnce* cardinality is assumed for *VerifyStatements* if not specified explicitly.
     * A single invocation matching several *VerifyStatement*s is considered a failure.
     * Exhaustiveness of verification is controlled by *exhaustive* parameter.
     * Partial verification allows uninteresting function calls to be omitted: only calls matching *VerifyStatement*s provided in *collectStatements* block will be considered.
     * Exhaustive verification requires that any invocation on any of mock objects mentioned in the *collectStatements* block is listed in the block.
     *
     * @param exhaustive if verification should be exhaustive.
     * @param collectStatement callback allowing to collect verification statements for this verification session.
     * @throws VerificationFailedException if verification fails.
     */
    public static func unordered(
        exhaustive: Exhaustiveness,
        collectStatements: (UnorderedVerifier) -> Unit
    ): Unit {
        let verifier = UnorderedVerifier()
        collectStatements(verifier)
        unordered(exhaustive, verifier.statements.toArray())
    }

    /**
     * Performs *unordered* exhaustive verification.
     *
     * @param collectStatement callback allowing to collect verification statements for this verification session.
     * @throws VerificationFailedException if verification fails.
     */
    public static func unordered(collectStatements: (UnorderedVerifier) -> Unit): Unit {
        unordered(Exhaustive, collectStatements)
    }

    /**
     * Performs *unordered* exhaustive verification.
     *
     * @param exhaustive if verification should be exhaustive.
     * @param statements to be verified.
     * @throws VerificationFailedException if verification fails.
     */
    public static func unordered(statements: Array<VerifyStatement>): Unit {
        unordered(Exhaustive, statements)
    }

    /**
     * Performs *unordered* exhaustive verification.
     *
     * @param statements to be verified.
     * @throws VerificationFailedException if verification fails.
     */
    public static func unordered(
        exhaustive: Exhaustiveness,
        statements: Array<VerifyStatement>
    ): Unit {
        performVerification(statements, Unordered, exhaustive)
    }

    /**
     * Performs *ordered* verification.
     * Checks that invocations match statements in the same exact order that statements were declared in.
     * *VerifyStatement*s are provided via *collectStatements* callback.
     * Consequitve statements in *ordered* section must be dijsoint. An invocation matching several consequitve statements will be considered an error.
     * *once* cardinality is assumed for *VerifyStatements* if not specified explicitly.
     * Ordered verification is always exhaustive: all invocations on mock object mention in *ordered* section must be listed.
     *
     * @param collectStatement callback allowing to collect verification statements for this verification session.
     * @throws VerificationFailedException if verification fails.
     */
    public static func ordered(collectStatements: (OrderedVerifier) -> Unit): Unit {
        let verifier = OrderedVerifier()
        collectStatements(verifier)
        ordered(verifier.statements.toArray())
    }

    /**
     * Performs *ordered* verification.
     *
     * @param statements to be verified.
     * @throws VerificationFailedException if verification fails.
     */
    public static func ordered(statements: Array<VerifyStatement>): Unit {
        performVerification(statements, Ordered, Exhaustive)
    }

    /**
     * Clears invocation log for the purposes of verification.
     * Expectations set during stub configugation will not be affected by this call.
     */
    public static func clearInvocationLog(): Unit {
        MockFramework.session {
            session: MockSession => session.invocationLog.clear()
        }
    }

    /**
     * Verifies no invocations were made on *mockObjects*.
     *
     * @param mocks objects that must not have any associated records in the invocation log.
     * @throws VerificationFailedException if verification fails.
     * @throws MockFrameworkException in the following cases:
     *     1. *mockObjects* is empty
     *     2. *mockObjects* contains references to objects that are not mocks or spies.
     *     3. *mockObjects* contains duplicate references.
     */
    public static func noInteractions(mockObjects: Array<Object>): Unit {
        verifyNoInteractions(mockObjects)
    }
}

/**
 * Collects statements for *unordered* verification.
 */
public class UnorderedVerifier {
    let statements = ArrayList<VerifyStatement>()

    // not accessible from usercode
    UnorderedVerifier() {}

    /**
     * Adds statement to this verification session.
     *
     * @param statement to be added.
     * @returns self.
     */
    public func checkThat(statement: VerifyStatement): UnorderedVerifier {
        statements.add(statement)
        return this
    }
}

/**
 * Collects statements for *ordered* verification.
 */
public class OrderedVerifier {
    let statements = ArrayList<VerifyStatement>()

    // not accessible from usercode
    OrderedVerifier() {}

    /**
     * Adds statement to this verification session.
     *
     * @param statement to be added.
     * @returns self.
     */
    public func checkThat(statement: VerifyStatement): OrderedVerifier {
        statements.add(statement)
        return this
    }
}

/**
 * Represents a condition to be checked against an invocation log.
 * It is defined by stub description - mock or spy object, some callable on that object and matchers for its arguments,
 *    and cardinality - how many times the stub must have been invoked to satisfy the condition.
 * Cardinality can only be set at most once for each statement.
 * If cardinality was not set explicitly default cardinality will be assumed based on verification type.
 * Cardinality cannot be reassigned after a statement was submitted to a verification session.
 */
public class VerifyStatement {
    private var _cardinality = Option<Cardinality>.None
    var isUsed = false

    prop cardinality: Cardinality {
        get() {
            _cardinality ?? internalError(InconsistentState("Cardinality not set before using verify statement"))
        }
    }

    VerifyStatement(
        let invocationMatcher: InvocationMatcher
    ) {}

    /**
     * Constructs a *VerifyStatement*.
     * Do NOT call this directly. Use @Called macro to constuct *VerifyStatement*s.
     * API stability is not guaranteed for this function.
     */
    public static func fromStub<R>(
        stubCall: () -> R,
        matchers: Array<ArgumentMatcher>,
        objName: Option<String>,
        declarationName: String,
        callDescription: String,
        lineNumber: Int64
    ): VerifyStatement {
        let recordingInfo = RecordingInfo(VerifyStatementStub, objName, declarationName)
        let recordedCall = MockFramework.recordCall(recordingInfo, stubCall)
        let invocationMatcher = InvocationMatcher(
            matchers,
            recordedCall.typeArgs,
            recordedCall.stubId,
            StubDescription(
                callDescription,
                objName,
                recordedCall.location.forceLineNumber(lineNumber)
            )
        )
        let statement = VerifyStatement(invocationMatcher)
        checkMatchersConsistency(statement)
        MockFramework.session { session: MockSession =>
            session.statements.add(statement)
        }
        statement
    }

    func prepareForVerification(orderedness: Orderedness) {
        match (isUsed) {
            case true => VerifyMisconfiguration().fail(StatementUsedTwice(this))
            case false => isUsed = true
        }
        match ((_cardinality, orderedness)) {
            case (None, Unordered) => _cardinality = Some(Cardinality.atLeastOnce())
            case (None, Ordered) => _cardinality = Some(Cardinality.once())
            case _ => ()
        }
    }

    func setCardinality(newCardinality: Cardinality): VerifyStatement {
        match (_cardinality) {
            case None => _cardinality = Some(newCardinality)
            case Some(_) => VerifyMisconfiguration().fail(CardinalityCannotBeReassigned(this))
        }
        this
    }

    /**
     * Specifies that this statement must match exactly once invocation.
     *
     * @returns self.
     * @throws MockFrameworkException if cardinality was already set and/or statement was already submitted to a verification session.
     */
    public func once(): VerifyStatement { setCardinality(Cardinality.once()) }

    /**
     * Specifies that this statement must match one or more invocations.
     *
     * @returns self.
     * @throws MockFrameworkException if cardinality was already set and/or statement was already submitted to a verification session.
     */
    public func atLeastOnce(): VerifyStatement { setCardinality(Cardinality.atLeastOnce()) }

    /**
     * Specifies that this statement must match *expectedTimes* or more invocation.
     *
     * @param expectedTimes exact number of invocations to be matched.
     * @returns self.
     * @throws MockFrameworkException if cardinality was already set and/or statement was already submitted to a verification session.
     */
    public func times(expectedTimes: Int64): VerifyStatement { setCardinality(Cardinality.times(expectedTimes)) }

    /**
     * Specifies that this statement must match at least *min* and at most *max* invocations.
     *
     * @param min minimum number of invocations to be matched.
     * @param max maximum number of invocations to be matched.
     * @returns self.
     * @throws MockFrameworkException if cardinality was already set and/or statement was already submitted to a verification session.
     */
    public func times(min!: Int64, max!: Int64): VerifyStatement {
        setCardinality(Cardinality.times(min: min, max: max))
    }

    /**
     * Specifies that this statement must match at least *minTimesExpected* invocations.
     *
     * @param minTimesExpected minimum number of invocations to be matched.
     * @returns self.
     * @throws MockFrameworkException if cardinality was already set and/or statement was already submitted to a verification session.
     */
    public func atLeastTimes(minTimesExpected: Int64): VerifyStatement {
        setCardinality(Cardinality.atLeastTimes(minTimesExpected))
    }

    /**
     * Specifies that this statement must not match any invocations.
     *
     * @returns self.
     * @throws MockFrameworkException if cardinality was already set and/or statement was already submitted to a verification session.
     */
    public func never(): VerifyStatement { setCardinality(Cardinality.never()) }
}
