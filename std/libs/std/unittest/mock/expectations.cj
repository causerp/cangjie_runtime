/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest.mock

import std.collection.*
import std.unittest.common.PrettyText

extend MockSession {
    func verifyExpectations(): Unit {
        let logSnapshot = invocationLog.fullLog()
        let failures = ArrayList<ExpectationFailedReason>()
        for (chain in chainsByStubId.values() |> flatten) {
            if (let Some(failureReason) <- chain.verifyExpectations()) {
                failures.add(failureReason)
            }
        }
        if (!failures.isEmpty()) {
            ExpectationFailedReport.fail(logSnapshot, failures)
        }
    }

    func checkForMisconfigurationIssues(): Unit {
        // force misconfiguration errors before any verification is performed
        // we could accumulate configuration errors here, but that doesn't seem to have any benefit for usability
        for (chain in chainsByStubId.values() |> flatten) {
            chain.ensureActivated()
        }

        for (statement in statements) {
            if (!statement.isUsed) {
                VerifyMisconfiguration().fail(StatementNotUsed(statement))
            }
        }
    }
}

extend StubChain {
    func verifyExpectations(): ?ExpectationFailedReason {
        let totalCardinality = getTotalCardinality()
        let totalInvocationCount = getTotalInvocationCount()
        match (totalCardinality.check(totalInvocationCount)) {
            case Less => TooFewInvocationsForStubChain(this, totalCardinality, totalInvocationCount)
            case _ => None
        }
    }

    func getTotalCardinality(): Cardinality {
        var minInvocations = 0
        var maxInvocations = Some(0)

        for (sc in scenarios) {
            minInvocations += sc.cardinality.min
            match ((maxInvocations, sc.cardinality.max)) {
                case (None, _) =>
                    maxInvocations = None
                case (_, None) =>
                    maxInvocations = None
                case (Some(curMax), Some(scMax)) =>
                    maxInvocations = curMax + scMax
            }
        }

        Cardinality(min: minInvocations, max: maxInvocations)
    }

    func getTotalInvocationCount() {
        var actualInvocations = 0
        for (sc in scenarios) {
            actualInvocations += sc.invocationCount
        }
        return actualInvocations
    }
}

enum ExpectationFailedReason {
    TooFewInvocationsForStubChain(StubChain, Cardinality, Int64)
}

class ExpectationFailedReport <: FailureReport {
    ExpectationFailedReport(
        log: LogSnapshot,
        nameRegistry: MockNameRegistry
    ) {
        super(log, nameRegistry)
    }

    static func fail(log: LogSnapshot, failures: ArrayList<ExpectationFailedReason>): Nothing {
        let nameRegistry = MockNameRegistry(
            failures |>
                map { reason: ExpectationFailedReason =>
                    match (reason) {
                        case TooFewInvocationsForStubChain(chain, _, _) => chain.invocationMatcher
                    }
                } |>
                collectArray
        )
        throw ExpectationFailedException(
            ExpectationFailedReport(log, nameRegistry).renderExpectationFailures(failures)
        )
    }

    func renderExpectationFailures(failures: ArrayList<ExpectationFailedReason>): PrettyText {
        let howManyExpectations = match (failures.size) {
            case 1 => "Expectation"
            case _ => "Expectations"
        }
        build {
            errorHeader("${howManyExpectations} failed")
            indent {
                for (reason in failures) {
                    renderExpectationFailedReason(reason)
                }
            }
        }
    }

    func renderExpectationFailedReason(reason: ExpectationFailedReason): Unit {
        match (reason) {
            case TooFewInvocationsForStubChain(thisChain, requiredCardinality, actualInvocations) =>
                line {
                    text("Too few invocations for")
                    renderStub(thisChain)
                }
                indent {
                    renderRequiredActual(actualInvocations) {
                        renderCardinalityMin(requiredCardinality)
                    }

                    let logEntries = findEntriesByStubId(thisChain.invocationMatcher.stubId)
                    let handledByThisChain = logEntries |>
                        filter { entry: LogEntry => entry.wasHandledBy(thisChain) } |>
                        collectArray
                    if (!handledByThisChain.isEmpty()) {
                        line("Invocations handled by this stub occured at:")
                        indent {
                            renderInvocationList(
                                handledByThisChain |>
                                map { entry: LogEntry => entry.invocation } |>
                                collectArray
                            )
                        }
                    }
                    let matchingNotHandledByThisChain = logEntries |>
                        filter { entry: LogEntry =>
                            !entry.wasHandledBy(thisChain) && thisChain.invocationMatcher.matches(entry.invocation)
                        } |> collectArray
                    if (!matchingNotHandledByThisChain.isEmpty()) {
                        line("Listing matching invocations not handled by this stub:")
                        indent {
                            renderInvocationListWithHandledByHints(matchingNotHandledByThisChain)
                        }
                    }
                    let notHandledByAnyChainsButSameStubId = logEntries |>
                        filter {
                            entry: LogEntry => match (entry.origin) {
                                case Stub(_) => false
                                case _ => !thisChain.invocationMatcher.matches(entry.invocation)
                            }
                        } |> collectArray
                    if (!notHandledByAnyChainsButSameStubId.isEmpty()) {
                        line("Listing non-matching invocations that were not handled by any stub:")
                        indent {
                            renderInvocationListWithHandledByHints(notHandledByAnyChainsButSameStubId)
                        }
                    }
                }
        }
    }

    func renderInvocationListWithHandledByHints(entries: Array<LogEntry>) {
        for (entry in entries) {
            listEntry { renderLocation(entry.invocation.location) }
            indent {
                line {
                    match (entry.origin) {
                        case Stub(otherChain) =>
                            text("was handled by")
                            renderStub(otherChain)
                        case Default =>
                            text("invoked original (default for")
                            userCode("spy")
                            text("object)")
                        case Failure(_) =>
                            internalError("Log entry has invalid handler information")
                    }
                }
            }
        }
    }

    func findEntriesByStubId(stubId: StubId): ArrayList<LogEntry> {
        let matchingEntries = ArrayList<LogEntry>()
        for (entry in invocationLog.entries) {
            if (entry.invocation.stubId == stubId) {
                matchingEntries.add(entry)
            }
        }
        return matchingEntries
    }
}
