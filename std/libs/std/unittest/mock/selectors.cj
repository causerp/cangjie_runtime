/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest.mock

/**
 * Part of stub chain. Specifies cardinality of an action that comes immediately before it in the stub chain.
 *
 * Cardinality can imply verification to be done by the framework:
 *     Stubs invoked more times than specified will throw ExpectationFailedException immediately.
 *     For stubs that were not invoked enough times framework will throw ExpectationFailedException after code under test finished executing.
 */
public class CardinalitySelector<A> where A <: ActionSelector {
    CardinalitySelector(
        let sc: Scenario,
        let factory: (Scenario) -> A
    ) {}

    /**
     * Specifies that the stub can be invoked any number of times.
     * There are no expectations for this stub.
     */
    public func anyTimes(): Unit {
        sc.setCardinality(Cardinality.atLeastTimes(0))
    }

    /**
     * Specifies that the stub must be invoked exactly one time.
     * @return continuation representing additional actions to be performed when conditions were satisfied.
     */
    public func once(): Continuation<A> {
        sc.setCardinality(Cardinality.once())
        Continuation<A>(sc, factory)
    }

    /**
     * Specifies that the stub must be invoked at least one time.
     */
    public func atLeastOnce(): Unit {
        sc.setCardinality(Cardinality.atLeastOnce())
    }

    /**
     * Specifies that the stub must be invoked an exact number of times.
     * @param expectedTimes number of times stub must be invoked.
     * @return continuation representing additional actions to be performed when conditions were satisfied.
     */
    public func times(expectedTimes: Int64): Continuation<A> {
        sc.setCardinality(Cardinality.times(expectedTimes))
        Continuation<A>(sc, factory)
    }

    /**
     * Specifies that the stub must be invoked [min..max] times.
     * @param min minimum number of times the stub must be invoked.
     * @param max maximum number of times the stub must be invoked.
     * @return continuation representing additional actions to be performed when conditions were satisfied.
     */
    public func times(min!: Int64, max!: Int64): Unit {
        sc.setCardinality(Cardinality.times(min: min, max: max))
    }

    /**
     * Specifies that the stub must be invoked at least certain number of times.
     * @param minTimesExpected minimum number of times the stub must be called.
     */
    public func atLeastTimes(minTimesExpected: Int64): Unit {
        sc.setCardinality(Cardinality.atLeastTimes(minTimesExpected))
    }
}

/**
 * Part of the stub chain. Allows to specify additional action will be performed
 *     by the stub when previous actions cardinality will be satisfied.
 * Specifying continuation only makes sense if it is followed by an action.
 * MockFrameworkException will be thrown if there are any unfinished stub chains.
 * No guarantees are given on exact point this exception will be thrown.
 */
public class Continuation<A> where A <: ActionSelector {
    Continuation(
        let previousSc: Scenario,
        let factory: (Scenario) -> A
    ) {}

    /**
     * @return an ActionSelector for an action to be performed when previous actions in the chain are completed.
     */
    public func then(): A {
        let continuationSc = MockFramework.session {
            session: MockSession => previousSc.parentChain.addScenario(session)
        }
        factory(continuationSc)
    }
}
