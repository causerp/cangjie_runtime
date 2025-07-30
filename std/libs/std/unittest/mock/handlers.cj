/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest.mock

enum SessionHandleResult {
    PerformScenario(Scenario) | Unhandled | InvocationLimitExceeded(StubChain)
}

extend MockSession {
    func handle(invocation: Invocation, unmatchedChains: UnmatchedChains): SessionHandleResult {
        let chains = chainsByStubId.get(invocation.stubId) ?? return Unhandled

        for (chain in chains) {
            chain.ensureActivated()
        }

        // chain priority is bottom to top
        for (index in (chains.size - 1)..=0 : -1) {
            let chain = chains[index]
            let matchStatus = chain.invocationMatcher.tryMatch(invocation)
            match (matchStatus) {
                case Ok => ()
                case _ =>
                    unmatchedChains.add((chain, matchStatus))
                    continue
            }
            // scenario priority is left to right
            for (sc in chain.scenarios) {
                match (sc.action) {
                    case Fail => return PerformScenario(sc) // explicitly configured to fail
                    case _ => ()
                }

                if (sc.tryRegisterInvocation()) {
                    chain.runListeners(invocation)
                    return PerformScenario(sc)
                }
            }
            // failed to register invocation => all scenarios reached maximum cardinality
            return InvocationLimitExceeded(chain)
        }
        return Unhandled
    }
}

extend StubChain {
    func runListeners(invocation: Invocation) {
        for (i in 0..invocation.call.args.size) {
            if (let Some(listeningMatcher) <- (invocationMatcher.positionalMatchers[i] as ListeningMatcher)) {
                listeningMatcher.valueListener?.supplyValue(invocation.call.args[i])
            }
        }
    }
}
