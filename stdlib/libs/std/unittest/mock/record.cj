/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest.mock

import std.unittest.mock.internal.*

class RecordingHandler {
    RecordingHandler(
        let info: RecordingInfo
    ) {}

    private var data: ?RecordedCall = None

    func record(call: Call, object: Option<MockObject>) {
        let isStatic = match (call.funcInfo.kind) {
            case DeclKind.TopLevelFunction(_) => true
            case DeclKind.StaticMethod(_) => true
            case DeclKind.StaticPropertyGetter(_) => true
            case DeclKind.StaticPropertySetter(_) => true
            case DeclKind.StaticFieldGetter(_) => true
            case DeclKind.StaticFieldSetter(_) => true
            case DeclKind.TopLevelVariableGetter(name) => true
            case DeclKind.TopLevelVariableSetter(name) => true
            case _ => false
        }

        match (data) {
            case None => data = RecordedCall(
                object, StubId(call.funcInfo, object?.id ?? 0), locationFromTrace(), call.typeArgs)
            case Some(_) => RecordingFailureReport().fail(info, UnmockableCallable)
        }
    }

    func getRecorded(): RecordedCall {
        return data ?? RecordingFailureReport().fail(info, NotAMock, UnmockableCallable)
    }
}

struct RecordedCall {
    RecordedCall(
        let object: Option<MockObject>,
        let stubId: StubId,
        let location: Location,
        let typeArgs: Array<String>
    ) {}
}

enum RecordingTarget {
    MethodStub | VerifyStatementStub
}

struct RecordingInfo {
    RecordingInfo(
        let target: RecordingTarget,
        let prefixRefName: Option<String>,
        let declarationName: String
    ) {}
}

enum RecordingFailureReason {
    NotAMock | UnmockableCallable
}

class RecordingFailureReport <: FailureReport {
    func fail(info: RecordingInfo, possibleReasons: Array<RecordingFailureReason>): Nothing {
        let message = build {
            match (info.target) {
                case VerifyStatementStub => errorHeader("Failed to create VerifyStatement")
                case MethodStub => errorHeader("Failed to create stub")
            }
            line("Possible reasons:")
            indent {
                for (reason in possibleReasons) {
                    line {
                        match (reason) {
                            case NotAMock =>
                                let objName = info.prefixRefName ??
                                    internalError("Object name should be set for `NotAMock` error")
                                userCode(objName)
                                text("is not a mock object.")
                            case UnmockableCallable =>
                                userCode(info.declarationName)
                                text("cannot be stubbed.")
                        }
                    }
                }
            }
        }
        throw MockFrameworkException(message)
    }
}
