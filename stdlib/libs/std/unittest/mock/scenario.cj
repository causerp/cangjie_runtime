/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest.mock

import std.collection.ArrayList

enum Action {
    | Return(() -> Any)
    | Throw(() -> Exception)
    | CallOriginal
    | Fail
    | GetField(SyntheticFieldDescription)
    | SetField(SyntheticFieldDescription)
}

struct ScenarioConfiguration {
    ScenarioConfiguration(
        let action: Action,
        let cardinality: Cardinality
    ) {}
}

enum ScenarioStatus {
    | Created(Option<Action>, Option<Cardinality>)
    | Active(ScenarioConfiguration, Box<Int64>)
}

class Scenario {
    private var status: ScenarioStatus

    Scenario(let parentChain: StubChain) {
        status = Created(None, None)
    }

    func setAction(selectedAction: Action) {
        match (status) {
            case Created(None, cardinality) =>
                status = Created(selectedAction, cardinality)
            case _ => StubMisconfiguration().fail(parentChain, ActionAlreadySet)
        }
    }

    func setCardinality(cardinality: Cardinality) {
        match ((cardinality.min, cardinality.max)) {
            case (0, None) => ()
            case _ => requireVerifiableSession()
        }

        match (status) {
            case Created(None, _) =>
                internalError(InconsistentState("Choosing cardinality before selecting an action"))
            case Created(action, None) =>
                status = Created(action, cardinality)
            case _ => StubMisconfiguration().fail(parentChain, CardinalityAlreadySet)
        }
    }

    func tryRegisterInvocation(): Bool {
        match (status) {
            case Active(config, count) =>
                let newCount = count.value + 1
                match (config.cardinality.check(newCount)) {
                    case More => false
                    case _ =>
                        count.value = newCount
                        true
                }
            case _ => mustBeActive()
        }
    }

    func activate() {
        match (status) {
            case Created(None, _) =>
                StubMisconfiguration().fail(parentChain, ActionNotSpecified)
            case Created(Some(action), cardinality) =>
                status = Active(ScenarioConfiguration(action, cardinality ?? defaultCardinality(action)), Box(0))
            case _ => internalError(InconsistentState("Already active"))
        }
    }

    prop invocationCount: Int64 {
        get() {
            match (status) {
                case Active(_, count) => count.value
                case _ => mustBeActive()
            }
        }
    }

    prop action: Action {
        get() {
            match (status) {
                case Active(config, _) => config.action
                case _ => mustBeActive()
            }
        }
    }

    prop cardinality: Cardinality {
        get() {
            match (status) {
                case Active(config, _) => config.cardinality
                case _ => mustBeActive()
            }
        }
    }

    private func defaultCardinality(action: Action) {
        if (let Fail <- action) {
            return Cardinality.times(0)
        }

        if (parentChain.isVerifiable()) {
            Cardinality.atLeastOnce()
        } else {
            Cardinality.atLeastTimes(0)
        }
    }

    private func requireVerifiableSession() {
        if (!parentChain.isVerifiable()) {
            StubModeViolation().cardinalitySpecifierNotAllowed(parentChain)
        }
    }

    private func mustBeActive(): Nothing {
        internalError(InconsistentState("Scenario must be active"))
    }
}

class StubChain {
    private var wasActivated: Bool = false

    StubChain(
        let invocationMatcher: InvocationMatcher,
        let objectKind: MockKind,
        let parentSession: MockSession
    ) {}

    let scenarios: ArrayList<Scenario> = ArrayList()

    // we're implicitly modifying session state here, session parameter for documentation purposes
    func addScenario(_: MockSession): Scenario {
        if (wasActivated) {
            StubMisconfiguration().fail(this, CannotModifyActive)
        }

        let newScenario = Scenario(this)
        scenarios.add(newScenario)
        return newScenario
    }

    func ensureActivated() {
        if (!wasActivated) {
            for (sc in scenarios) {
                sc.activate()
            }
            wasActivated = true
        }
    }

    func isVerifiable(): Bool {
        match (parentSession.sessionKind) {
            case Verifiable => true
            case Stateless => false
            case Forbidden => internalError("Should not be able to create stub chain in this mode")
        }
    }
}
