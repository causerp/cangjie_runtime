/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest

import std.unittest.common.*

struct TestSuiteId <: Serializable<TestSuiteId> & Hashable & Equatable<TestSuiteId> & ToString {
    TestSuiteId(
        let groupName: String,
        let suiteName: String
    ) {}

    public func serializeInternal(): DataModel {
        DataModelStruct()
            .add(field<String>("groupName", groupName))
            .add(field<String>("suiteName", suiteName))
    }

    public static func deserialize(dm: DataModel): TestSuiteId {
        let dms = dm.asStruct()

        TestSuiteId(
            String.deserialize(dms.get("groupName")),
            String.deserialize(dms.get("suiteName"))
        )
    }

    public operator func ==(other: TestSuiteId): Bool {
        this.groupName == other.groupName && this.suiteName == other.suiteName
    }

    public operator func !=(other: TestSuiteId): Bool {
        !(this == other)
    }

    public func hashCode(): Int64 {
        var hasher = DefaultHasher()
        hasher.write(groupName)
        hasher.write(suiteName)
        hasher.finish()
    }

    public func toString(): String {
        "TestSuiteId(${groupName}, ${suiteName})"
    }

    public static func fromTestSuite(groupName: String, testSuite: TestSuite): TestSuiteId {
        TestSuiteId(
            groupName,
            testSuite.name
        )
    }
}

struct TestCaseId <: Serializable<TestCaseId> & Hashable & Equatable<TestCaseId> & ToString {
    TestCaseId(
        let suiteId: TestSuiteId,
        let caseName: String,
        let isBench!: Bool // @TestCase func can also be @Bench, we need to distinguish between those
    ) {}

    public func serializeInternal(): DataModel {
        DataModelStruct()
            .add(field<TestSuiteId>("suiteId", suiteId))
            .add(field<String>("caseName", caseName))
            .add(field<Bool>("isBench", isBench))
    }

    public static func deserialize(dm: DataModel): TestCaseId {
        let dms = dm.asStruct()
        TestCaseId(
            TestSuiteId.deserialize(dms.get("suiteId")),
            String.deserialize(dms.get("caseName")),
            isBench: Bool.deserialize(dms.get("isBench"))
        )
    }

    public operator func ==(other: TestCaseId): Bool {
        this.caseName == other.caseName && this.suiteId == other.suiteId && this.isBench == other.isBench
    }

    public operator func !=(other: TestCaseId): Bool {
        !(this == other)
    }

    public func hashCode(): Int64 {
        var hasher = DefaultHasher()
        hasher.write(suiteId.hashCode())
        hasher.write(caseName)
        hasher.write(isBench)
        hasher.finish()
    }

    public func fqName(): String {
        "${suiteId.groupName.toSafeFileName()}.${suiteId.suiteName.toSafeFileName()}.${caseName.toSafeFileName()}"
    }

    public func toString(): String {
        "TestCaseId(${suiteId}, ${caseName})"
    }
}
