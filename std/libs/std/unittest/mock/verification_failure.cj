/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest.mock

import std.unittest.common.PrettyText

enum VerificationFailedReason {
    | TooFewInvocations(VerifyStatement, Cardinality, Int64)
    | TooManyInvocations(VerifyStatement, Cardinality, Int64)
    | UnmatchedStatements(Array<VerifyStatement>)
    | UnmatchedInvocations(Array<Invocation>)
    | UnexpectedInvocation(VerifyStatement, Invocation)
    | NonDisjointStatements(VerifyStatement, VerifyStatement, Invocation)
    | UnwantedInteractions(Array<Invocation>)
}

class VerificationFailureReport <: FailureReport {
    VerificationFailureReport(
        logSnapshot: LogSnapshot,
        nameRegistry: MockNameRegistry
    ) {
        super(logSnapshot, nameRegistry)
    }

    func fail(reason: VerificationFailedReason): Nothing {
        throw VerificationFailedException(renderVerificationFailure(reason))
    }

    private func renderVerificationFailure(reason: VerificationFailedReason): PrettyText {
        build {
            errorHeader("Verification failed")
            indent {
                renderReason(reason)
            }
        }
    }

    private func renderTooManyInvocations(
        statement: VerifyStatement,
        requiredCardinality: Cardinality,
        actualInvocations: Int64
    ) {
        line {
            text("Too many invocations for")
            renderStatement(statement)
        }
        indent {
            renderRequiredActual(actualInvocations) {
                renderCardinalityMax(requiredCardinality)
            }
            renderMatchingInvocations(statement.invocationMatcher)
        }
    }

    private func renderTooFewInvocations(
        statement: VerifyStatement,
        requiredCardinality: Cardinality,
        actualInvocations: Int64
    ) {
        line {
            text("Too few invocations for")
            renderStatement(statement)
        }
        indent {
            renderRequiredActual(actualInvocations) {
                renderCardinalityMin(requiredCardinality)
            }
            renderMatchingInvocations(statement.invocationMatcher)
        }
    }

    private func renderUnexpectedInvocation(statement: VerifyStatement, invocation: Invocation) {
        line("Unexpected invocation.")
        line {
            text("Expected:")
            renderMatcher(statement.invocationMatcher, atString: "expected by statement at")
        }
        line {
            text("Actual:")
            renderInvocationWithLocation(invocation, atString: "invoked at")
        }
        match (statement.invocationMatcher.tryMatch(invocation)) {
            case Ok => illegalInput("Inconsistent argument matchers.")
            case ReceiverMismatch => ()
            case FuncMismatch =>
                if (let Some(methodName) <- sameName(invocation, statement)) {
                    line {
                        error("Wrong overloaded version")
                        text("of method")
                        userCode(methodName)
                        text("was invoked.")
                    }
                }
            case ArgumentMismatch(indices) =>
                errorLine("Argument mismatch:")
                indent {
                    reportArgumentMismatch(statement.invocationMatcher, indices)
                }
            case TypeArgMismatch(_) =>
                errorLine("Type arguments mismatch")
        }
    }

    private func renderUnmatchedInvocations(invocations: Array<Invocation>) {
        line("The following invocations were not matched by any statement:")
        indent {
            for (invocation in invocations) {
                listEntry { renderInvocationWithLocation(invocation) }
            }
        }
    }

    private func renderUnmatchedStatements(statements: Array<VerifyStatement>) {
        line("The following statements were not matched by any invocations:")
        indent {
            for (statement in statements) {
                listEntry { renderMatcher(statement.invocationMatcher, atString: "declared at") }
            }
        }
    }

    private func renderNonDisjointStatements(
        statement1: VerifyStatement,
        statement2: VerifyStatement,
        invocation: Invocation
    ) {
        line("The following invocation:")
        indent {
            line { renderInvocationWithLocation(invocation) }
        }
        line("Was matched by several statements:")
        indent {
            line { renderMatcher(statement1.invocationMatcher, atString: "declared at") }
            line { renderMatcher(statement2.invocationMatcher, atString: "declared at") }
        }
        line("Provide disjoint statements to avoid ambiguous verification results.")
    }

    private func renderUnwantedInteractions(invocations: Array<Invocation>) {
        line("Unwanted interactions:")
        indent {
            for (invocation in invocations) {
                listEntry { renderInvocationWithLocation(invocation) }
            }
        }
    }

    private func renderReason(reason: VerificationFailedReason): Unit {
        match (reason) {
            case TooManyInvocations(statement, requiredCardinality, actualInvocations) =>
                renderTooManyInvocations(statement, requiredCardinality, actualInvocations)

            case TooFewInvocations(statement, requiredCardinality, actualInvocations) =>
                renderTooFewInvocations(statement, requiredCardinality, actualInvocations)

            case UnmatchedInvocations(invocations) =>
                renderUnmatchedInvocations(invocations)

            case UnmatchedStatements(statements) =>
                renderUnmatchedStatements(statements)

            case NonDisjointStatements(statement1, statement2, invocation) =>
                renderNonDisjointStatements(statement1, statement2, invocation)

            case UnexpectedInvocation(statement, invocation) =>
                renderUnexpectedInvocation(statement, invocation)

            case UnwantedInteractions(invocations) =>
                renderUnwantedInteractions(invocations)
        }
    }

    private func sameName(invocation: Invocation, statement: VerifyStatement): ?String {
        match ((
            statement.invocationMatcher.stubId.funcInfo.kind,
            invocation.call.funcInfo.kind
        )) {
            case (Method(statementName), Method(invocationName))
                where statementName == invocationName => statementName
            case _ => None
        }
    }
}
