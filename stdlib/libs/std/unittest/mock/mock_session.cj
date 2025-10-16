/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest.mock

import std.collection.*

/**
 * Controls what kind of stubs are allowed inside a given *MockSession*.
 * Forbidden - no stubs allowed.
 * Stateless - only stateless are allowed (inherently stateful actions like returnsConsequitively and cardinality specifiers are disallowed).
 * Verifiable - any stub is allowed.
 *
 * Expectations can only be verified for stubs created in *Verifiable* sessions.
 */
public enum MockSessionKind {
    | Forbidden
    | Stateless
    | Verifiable
}

/**
 * All stubs are only active during a session they were defined in.
 * Expectations specified by the stubs will be verified when the session is closed.
 * Test framework is responsibe for opening and closing the session implcitly.
 */
class MockSession {
    MockSession(
        let name: String,
        let sessionKind: MockSessionKind
    ) {}

    let invocationLog = MutableLog()
    let chainsByStubId = HashMap<StubId, ArrayList<StubChain>>()
    let statements = ArrayList<VerifyStatement>()
    let objectRegistry = HashMap<UInt64, MockObject>()
    let fieldStorage = FieldStorage()
}

class MockObject {
    MockObject(
        let id: UInt64,
        let ref: Object,
        let kind: MockKind,
        let modes: Array<StubMode>,
        let sessionName: ?String
    ) {}
}

enum MockKind {
    Mock | Spy
}
