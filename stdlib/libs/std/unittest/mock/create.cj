/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest.mock

import std.unittest.mock.internal.*
/*
 * Specifies additional default behaviour for mock objects.
 * Explicit stubs always override default behaviour.
 */
public enum StubMode {
    /**
     * Mock object will return default values for common 'simple' types.
     * Use to simplify mock object setup.
     * These values are 'negative' or 'empty'
     * Supported types are: Unit, number types, option types, Bool, String, Array, ArrayList, HashSet, HashMap.
     */
    | ReturnsDefaults
    /**
     * Mock object will treat its mutable properties and fields as if they are mutable fields.
     * Similar to using SyntheticField directly but less verbose.
     * Reading an unitialized field will result in an error.
     */
    | SyntheticFields
}

/**
 * Creates a mock object of type T. This object does not have any behaviour specified for its members by default.
 * Behaviour for mock object can be specified using @On macro.
 *
 * @returns mock object of type T.
 */
@Frozen
public func mock<T>(): T {
    return create<T>(Mock, []) { handler: CallHandlerImpl => unsafe { createMock<T>(handler) }}
}

/**
 * Creates a mock object of type T. This object does not have any behaviour specified for its members by default.
 * Behaviour for mock object can be specified using @On macro.
 *
 * @param modes - stub modes altering mock object default behaviour.
 * @returns mock object of type T.
 */
@Frozen
public func mock<T>(modes: Array<StubMode>): T {
    return create<T>(Mock, modes) { handler: CallHandlerImpl => unsafe { createMock<T>(handler) }}
}

/**
 * Creates a spy object of type T. Spy object wraps a passed in instance and delegates all calls to that instance by default.
 * Behaviour for members of the spy object can be overridden using @On macro.
 *
 * @param objectToSpyOn instance to spy on.
 * @returns spy object that spies on passed in instance of type T.
 */
@Frozen
public func spy<T>(objectToSpyOn: T): T {
    return create<T>(Spy, []) { handler: CallHandlerImpl => unsafe { createSpy<T>(handler, objectToSpyOn) }}
}

func create<T>(kind: MockKind, modes: Array<StubMode>, constructor: (CallHandlerImpl) -> T): T {
    MockFramework.session { session: MockSession =>
        let id = _FRAMEWORK.generateUniqueId()
        let createdAtSessionName = session.name
        let handler = CallHandlerImpl(id, createdAtSessionName)
        let objAsT = constructor(handler)
        let ref = (objAsT as Object) ?? internalError("Mock object does not inherit Object superclass")
        _FRAMEWORK.registerObject(MockObject(id, ref, kind, modes, createdAtSessionName))
        objAsT
    }
}
