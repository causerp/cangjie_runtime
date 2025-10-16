/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest.mock

import std.collection.HashMap

public class SyntheticField<T> {
    SyntheticField(let description: SyntheticFieldDescription) {}

    public static func create(initialValue!: T): SyntheticField<T> {
        SyntheticField(SyntheticFieldDescription(initialValue))
    }
}

class SyntheticFieldDescription {
    let id = _FRAMEWORK.generateUniqueId()

    SyntheticFieldDescription(
        let initialValue: Any
    ) {}
}

class FieldStorage {
    private let explicitFields = HashMap<UInt64, Box<Any>>()
    private let autoFields = HashMap<AutoFieldId, Box<Any>>()

    func getExplicitFieldValue(fieldDescription: SyntheticFieldDescription): Any {
        getOrCreateExplicitFieldBox(fieldDescription).value
    }

    func setExplicitFieldValue(fieldDescription: SyntheticFieldDescription, value: Any): Unit {
        getOrCreateExplicitFieldBox(fieldDescription).value = value
    }

    private func getOrCreateExplicitFieldBox(fieldDescription: SyntheticFieldDescription): Box<Any> {
        match (explicitFields.get(fieldDescription.id)) {
            case Some(existingStorage) => existingStorage
            case None =>
                let newStorage = Box<Any>(fieldDescription.initialValue)
                explicitFields[fieldDescription.id] = newStorage
                newStorage
        }
    }

    func getAutoFieldValue(id: AutoFieldId): ?Any {
        autoFields.get(id)?.value
    }

    func setAutoFieldValue(id: AutoFieldId, value: Any): Unit {
        match (autoFields.get(id)) {
            case Some(existingStorage) =>
                existingStorage.value = value
            case None =>
                let newStorage = Box<Any>(value)
                autoFields[id] = newStorage
        }
    }
}

struct AutoFieldId <: Hashable & Equatable<AutoFieldId> {
    AutoFieldId(
        private let mockObjectId: UInt64,
        private let memberName: String
    ) {}

    init(mockObject: MockObject, memberName: String) {
        this(mockObject.id, memberName)
    }

    @OverflowWrapping
    public func hashCode(): Int64 {
        return Int64(mockObjectId) + 31 * memberName.hashCode()
    }

    public operator func ==(that: AutoFieldId): Bool {
        return this.mockObjectId == that.mockObjectId && this.memberName == that.memberName
    }

    public operator func !=(that: AutoFieldId): Bool {
        return this.mockObjectId != that.mockObjectId || this.memberName != that.memberName
    }
}

class FieldsErrorReport <: FailureReport {
    func errorReadingField(invocation: Invocation) {
        let funcInfo = invocation.call.funcInfo
        if (!funcInfo.isGetter) {
            internalError("Must be a field or property getter")
        }
        if (funcInfo.hasSetter) {
            valueNotSet(invocation)
        } else {
            mustUseStubs(invocation)
        }
    }

    func valueNotSet(invocation: Invocation): PrettyException {
        let text = build {
            errorHeader("Unhandled invocation")
            line {
                renderInvocationWithLocation(invocation)
            }
            line {
                text("Trying to read value of")
                renderDeclarationNameAndKind(invocation.call.funcInfo, getterSetterPrefix: false)
                text("before it was set")
            }
        }
        return UnhandledCallException(text)
    }

    func mustUseStubs(invocation: Invocation): PrettyException {
        let text = build {
            errorHeader("Unhandled invocation")
            line {
                renderInvocationWithLocation(invocation)
            }
            line {
                text("Trying to read value of readonly")
                renderDeclarationNameAndKind(invocation.call.funcInfo, getterSetterPrefix: false)
            }
            line {
                text("Use stubs to define the value.")
            }
        }
        return UnhandledCallException(text)
    }
}
