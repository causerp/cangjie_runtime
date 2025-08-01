/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest

import std.unittest.common.*

enum CheckResultKind <: Serializable<CheckResultKind> {
    Assert | Expect

    public func serializeInternal(): DataModel {
        match (this) {
            case Assert => false.serializeInternal()
            case Expect => true.serializeInternal()
        }
    }

    public static func deserialize(dm: DataModel): CheckResultKind {
        if (Bool.deserialize(dm)) {
            Expect
        } else {
            Assert
        }
    }
}

// all check results are failures
// we generally only keep track of the number of successful check
// but we do not store the data
abstract class CheckResult <: Serializable<CheckResult> {
    public static func deserialize(dm: DataModel): CheckResult {
        let dms = dm.asStruct()
        UnattachedCheckResult.tryToDeserialize(dms) ?? PlainCompareCheckResult.tryToDeserialize(dms) ??
            FailCheckResult.tryToDeserialize(dms) ?? AssertThrowsCheckResult.tryToDeserialize(dms) ??
            PowerAssertCheckResult.tryToDeserialize(dms) ?? PowerAssertExceptionCheckResult.tryToDeserialize(dms) ??
            DiffCheckResult.tryToDeserialize(dms) ?? CustomCheckResult.tryToDeserialize(dms) ??
            ExceptionThrownCheckResult.tryToDeserialize(dms) ?? MockFrameworkCheckResult.tryToDeserialize(dms) ??
            NoParametersProvidedResult.tryToDeserialize(dms) ?? CrashedCheckResult.tryToDeserialize(dms) ??
            TimeoutCheckResult.tryToDeserialize(dms) ?? throw Exception("Can not deserialize Invalid check result")
    }
}

class UnattachedCheckResult <: CheckResult {
    UnattachedCheckResult(let inner: CheckResult) {}
    public func serializeInternal(): DataModel {
        DataModelStruct().add(field<CheckResult>("unattached", inner))
    }

    public static func tryToDeserialize(dms: DataModelStruct): ?UnattachedCheckResult {
        UnattachedCheckResult(CheckResult.deserialize(dms.tryGet("unattached") ?? return None))
    }
}

abstract class AssertExpectCheckResult <: CheckResult {
    AssertExpectCheckResult(let kind: CheckResultKind) {}
}

abstract class ErrorCheckResult <: CheckResult {}

class PlainCompareCheckResult <: AssertExpectCheckResult {
    PlainCompareCheckResult(
        kind: CheckResultKind,
        let leftExpr: String,
        let rightExpr: String,
        let leftValue: String,
        let rightValue: String
    ) {
        super(kind)
    }

    public func serializeInternal(): DataModel {
        DataModelStruct()
            .add(field<CheckResultKind>("kind", kind))
            .add(field<String>("leftExpr", leftExpr))
            .add(field<String>("rightExpr", rightExpr))
            .add(field<String>("leftValue", leftValue))
            .add(field<String>("rightValue", rightValue))
    }

    public static func tryToDeserialize(dms: DataModelStruct): ?PlainCompareCheckResult {
        return PlainCompareCheckResult(
            CheckResultKind.deserialize(dms.tryGet("kind") ?? return None),
            String.deserialize(dms.tryGet("leftExpr") ?? return None),
            String.deserialize(dms.tryGet("rightExpr") ?? return None),
            String.deserialize(dms.tryGet("leftValue") ?? return None),
            String.deserialize(dms.tryGet("rightValue") ?? return None)
        )
    }
}

class FailCheckResult <: AssertExpectCheckResult {
    FailCheckResult(kind: CheckResultKind, let failMessage: String) {
        super(kind)
    }

    public func serializeInternal(): DataModel {
        DataModelStruct().add(field<String>("failMessage", failMessage)).add(field<CheckResultKind>("kind", kind))
    }

    public static func tryToDeserialize(dms: DataModelStruct): ?FailCheckResult {
        return FailCheckResult(
            CheckResultKind.deserialize(dms.tryGet("kind") ?? return None),
            String.deserialize(dms.tryGet("failMessage") ?? return None)
        )
    }
}

class AssertThrowsCheckResult <: AssertExpectCheckResult {
    AssertThrowsCheckResult(
        kind: CheckResultKind,
        let message: String,
        let expectedExceptions: String,
        let caughtException: String
    ) {
        super(kind)
    }

    public func serializeInternal(): DataModel {
        DataModelStruct()
            .add(field<CheckResultKind>("kind", kind))
            .add(field<String>("expectedExceptions", expectedExceptions))
            .add(field<String>("message", message))
            .add(field<String>("caughtException", caughtException))
    }

    public static func tryToDeserialize(dms: DataModelStruct): Option<AssertThrowsCheckResult> {
        return AssertThrowsCheckResult(
            CheckResultKind.deserialize(dms.tryGet("kind") ?? return None),
            String.deserialize(dms.tryGet("message") ?? return None),
            String.deserialize(dms.tryGet("expectedExceptions") ?? return None),
            String.deserialize(dms.tryGet("caughtException") ?? return None)
        )
    }
}

class PowerAssertCheckResult <: AssertExpectCheckResult {
    PowerAssertCheckResult(
        let expr: String,
        let diagram: PowerAssertDiagram
    ) {
        super(Assert)
    }

    public func serializeInternal(): DataModel {
        DataModelStruct().add(field<String>("expr", expr)).add(field<PowerAssertDiagram>("diagram", diagram))
    }

    public static func tryToDeserialize(dms: DataModelStruct): ?PowerAssertCheckResult {
        return PowerAssertCheckResult(
            String.deserialize(dms.tryGet("expr") ?? return None),
            PowerAssertDiagram.deserialize(dms.tryGet("diagram") ?? return None)
        )
    }
}

class PowerAssertExceptionCheckResult <: AssertExpectCheckResult {
    PowerAssertExceptionCheckResult(
        let expression: String,
        let exception: String,
        let diagram: PowerAssertDiagram
    ) {
        super(Assert)
    }

    public func serializeInternal(): DataModel {
        DataModelStruct()
            .add(field<String>("expression", expression))
            .add(field<String>("exception", exception))
            .add(field<PowerAssertDiagram>("diagram", diagram))
    }

    public static func tryToDeserialize(dms: DataModelStruct): ?PowerAssertExceptionCheckResult {
        return PowerAssertExceptionCheckResult(
            String.deserialize(dms.tryGet("expression") ?? return None),
            String.deserialize(dms.tryGet("exception") ?? return None),
            PowerAssertDiagram.deserialize(dms.tryGet("diagram") ?? return None)
        )
    }
}

class DiffCheckResult <: AssertExpectCheckResult {
    DiffCheckResult(
        kind: CheckResultKind,
        let diffMessage: PrettyText
    ) {
        super(kind)
    }

    public func serializeInternal(): DataModel {
        DataModelStruct().add(field<PrettyText>("diffMessage", diffMessage)).add(field<CheckResultKind>("kind", kind))
    }

    public static func tryToDeserialize(dms: DataModelStruct): ?DiffCheckResult {
        DiffCheckResult(
            CheckResultKind.deserialize(dms.tryGet("kind") ?? return None),
            PrettyText.deserialize(dms.tryGet("diffMessage") ?? return None)
        )
    }
}

class CustomCheckResult <: AssertExpectCheckResult {
    CustomCheckResult(
        kind: CheckResultKind,
        let custom: PrettyText
    ) {
        super(kind)
    }

    public func serializeInternal(): DataModel {
        DataModelStruct().add(field<PrettyText>("custom", custom)).add(field<CheckResultKind>("kind", kind))
    }

    public static func tryToDeserialize(dms: DataModelStruct): ?DiffCheckResult {
        DiffCheckResult(
            CheckResultKind.deserialize(dms.tryGet("kind") ?? return None),
            PrettyText.deserialize(dms.tryGet("custom") ?? return None)
        )
    }
}

class ExceptionThrownCheckResult <: ErrorCheckResult {
    ExceptionThrownCheckResult(
        let errorMessage: PrettyText,
        let stackTrace: PrettyText
    ) {}

    public func serializeInternal(): DataModel {
        DataModelStruct()
            .add(field<PrettyText>("errorMessage", errorMessage))
            .add(field<PrettyText>("stackTrace", stackTrace))
    }

    public static func tryToDeserialize(dms: DataModelStruct): ?ExceptionThrownCheckResult {
        ExceptionThrownCheckResult(
            PrettyText.deserialize(dms.tryGet("errorMessage") ?? return None),
            PrettyText.deserialize(dms.tryGet("stackTrace") ?? return None)
        )
    }
}

class MockFrameworkCheckResult <: CheckResult {
    MockFrameworkCheckResult(
        let mockFrameworkMessage: PrettyText
    ) {}

    public func serializeInternal(): DataModel {
        DataModelStruct().add(field<PrettyText>("mockFrameworkMessage", mockFrameworkMessage))
    }

    public static func tryToDeserialize(dms: DataModelStruct): ?MockFrameworkCheckResult {
        MockFrameworkCheckResult(
            PrettyText.deserialize(dms.tryGet("mockFrameworkMessage") ?? return None),
        )
    }
}

class NoParametersProvidedResult <: CheckResult {
    NoParametersProvidedResult() {}
    public func serializeInternal(): DataModel {
        DataModelStruct().add(field<Int64>("noParameters", 0))
    }

    static func tryToDeserialize(dms: DataModelStruct): ?NoParametersProvidedResult {
        dms.tryGet("noParameters") ?? return None
        NoParametersProvidedResult()
    }
}

class CrashedCheckResult <: CheckResult {
    CrashedCheckResult(
        let exitCode: Int64
    ) {}

    public func serializeInternal(): DataModel {
        DataModelStruct().add(
            field<Int64>("exitCode", exitCode)
        )
    }

    static func tryToDeserialize(dms: DataModelStruct): ?CrashedCheckResult {
        CrashedCheckResult(
            Int64.deserialize(dms.tryGet("exitCode") ?? return None),
        )
    }
}

class TimeoutCheckResult <: CheckResult {
    TimeoutCheckResult() {}

    public func serializeInternal(): DataModel {
        DataModelStruct().add(field<Int64>("timeout", 0))
    }

    static func tryToDeserialize(dms: DataModelStruct): ?TimeoutCheckResult {
        dms.tryGet("timeout") ?? return None
        TimeoutCheckResult()
    }
}
