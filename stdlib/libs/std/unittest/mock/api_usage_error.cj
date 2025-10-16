/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest.mock

enum StubMisconfigurationReason {
    | ActionNotSpecified
    | CardinalityAlreadySet
    | ActionAlreadySet
    | CannotModifyActive
    | OnlySpyCanCallOriginal(String)
}

class StubMisconfiguration <: FailureReport {
    StubMisconfiguration() {
        super()
    }

    func fail(stub: StubChain, reason: StubMisconfigurationReason): Nothing {
        throw MockFrameworkException(
            build {
                errorHeader("Misconfiguration failure")
                match (reason) {
                    case ActionNotSpecified =>
                        line {
                            renderStub(stub)
                            text("was not configured. Specify an action for this stub.")
                        }
                    case CardinalityAlreadySet =>
                        line {
                            text("Cardinality was already specified for")
                            renderStub(stub)
                        }
                    case ActionAlreadySet =>
                        line {
                            text("Action was already specified for")
                            renderStub(stub)
                        }
                    case CannotModifyActive =>
                        line {
                            text("Stub cannot be modified")
                            renderStub(stub)
                        }
                    case OnlySpyCanCallOriginal(actionName) =>
                        line {
                            text("Action ")
                            userCode(actionName)
                            text("is only available for spy objects")
                        }
                        line {
                            userCode(stub.invocationMatcher.description.prefixRefName)
                            text("is not a spy object")
                        }
                }
                stubConfigurationHint(reason)
            }
        )
    }

    func stubConfigurationHint(reason: StubMisconfigurationReason) {
        match (reason) {
            case OnlySpyCanCallOriginal(_) => return // hint doesn't make anything clearer in this case
            case _ => ()
        }
        line("Hint:")
        indent {
            line("Stubs created using @On macro must be configured before any calls on mock objects are made.")
            line("Stubs can not be reconfigured after any calls on mock objects were made.")
            line("However it is possible to add new stubs that may override previously created ones.")
        }
    }
}

class StubModeViolation <: FailureReport {
    StubModeViolation() {
        super()
    }

    func stubForbidden(stubDescription: StubDescription, sessionName: String): Nothing {
        throw MockFrameworkException(
            build {
                errorHeader("Stub not allowed")
                line {
                    renderStubDescription(stubDescription, prefixString: "stub", atString: "declared at")
                    text("is not allowed in")
                    userCode(sessionName)
                }
                line {
                    text("Consider creating stubs inside test case body instead")
                }
            }
        )
    }

    func statefulStubAction(actionName: String, stubChain: StubChain): Nothing {
        throw MockFrameworkException(
            build {
                errorHeader("Non-trivial stub not allowed")
                line {
                    renderStub(stubChain)
                    text("cannot specify action")
                    userCode(actionName)
                    text("in")
                    userCode(stubChain.parentSession.name)
                }
                line {
                    text("Consider moving this stub into test case body")
                }
                line {
                    text("Hint: stubs shared between test cases must be stateless. Actions such as")
                    userCode("returns")
                    append(", ")
                    userCode("callsOriginal")
                    append(", ")
                    userCode("throws")
                    text("are considered stateless")
                }
            }
        )
    }

    func cardinalitySpecifierNotAllowed(stubChain: StubChain): Nothing {
        throw MockFrameworkException(
            build {
                errorHeader("Non-trivial stub not allowed")
                line {
                    renderStub(stubChain)
                    text("cannot specify non-trivial cardinality in")
                    userCode(stubChain.parentSession.name)
                }
                line {
                    text("Consider moving this stub into test case body")
                }
            }
        )
    }
}

enum VerifyMisconfigurationReason {
    StatementUsedTwice(VerifyStatement)
    | StatementNotUsed(VerifyStatement)
    | ArgumentCaptureNotAllowed(VerifyStatement, ArgumentMatcher)
    | CardinalityCannotBeReassigned(VerifyStatement)
    | EmptyVerifyBlock
}

class VerifyMisconfiguration <: FailureReport {
    func fail(reason: VerifyMisconfigurationReason): Nothing {
        let message = build {
            render(reason)
        }
        throw MockFrameworkException(message)
    }

    private func render(reason: VerifyMisconfigurationReason) {
        errorHeader("Misconfiguration failure")
        match (reason) {
            case StatementUsedTwice(statement) =>
                line {
                    text("Verify statement can only be used once:")
                    renderStatement(statement)
                }
            case StatementNotUsed(statement) =>
                line {
                    text("Statement was never used:")
                    renderStatement(statement)
                }
                line {
                    text("Verify statement must be used inside")
                    userCode("Verify")
                    text("block.")
                    text("Use")
                    userCode("verifier.checkThat")
                    text("to add statements dynamically.")
                }
            case ArgumentCaptureNotAllowed(statement, matcher) =>
                line("Argument matchers that capture arguments are not allowed inside @Called macro.")
                if (let Some(description) <- matcher.getDescription()) {
                    line {
                        text("Cannot use")
                        userCode(description)
                        text("as part of")
                        renderStatement(statement)
                    }
                }
            case EmptyVerifyBlock => line("Empty verify blocks are not allowed.")
            case CardinalityCannotBeReassigned(statement) =>
                line {
                    text("Cardinality should be set at most once before using verify statement:")
                    renderStatement(statement)
                }
        }
    }
}
