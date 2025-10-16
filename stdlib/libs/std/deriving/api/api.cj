/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
protected package std.deriving.api

import std.ast.*
import std.collection.*

/**
 * Deriving settings collected from annotations applied to the target type.
 */
public struct DerivingSettings {
    public DerivingSettings(
        public let interfaces: Array<DerivingInterfaceSettings>,
        public let excludedFields: Array<TargetNamedAttribute>,
        public let casesOrder: Array<TargetEnumCase>,
        public let fieldsOrder: Array<Identifier>,
        public let includedProperties: Array<PropDecl>
    ) {}

    public prop interfaceNames: Array<QualifiedName> {
        get() { interfaces |> map { it: DerivingInterfaceSettings => it.name } |> collectArray }
    }
}

public struct TargetEnumCase {
    public TargetEnumCase(
        public let name: String,
        public let constructor: Constructor,
        public let fields: Array<TargetEnumField>
    ) {}
}

public struct TargetEnumField {
    public TargetEnumField(
        public let position: Int64,
        public let fieldType: TypeNode
    ) {}
}

public enum TargetNamedAttribute {
    | FieldAttribute(VarDecl)
    | ConstructorFieldAttribute(FuncParam)
    | PropertyAttribute(PropDecl)
}

/**
 * Contains effective target information.
 * Fields are already filtered based on exclusions
 * Properties contains only manually included.
 * The provided decl is not supposed to be modified
 */
public struct DerivingTarget {
    public DerivingTarget(
        public let declaration: Decl,
        public let namedFields: Array<TargetNamedAttribute>,
        public let enumCases: Array<TargetEnumCase>,
        public let settings: DerivingSettings
    ) {}

    public prop interfaces: Array<DerivingInterfaceSettings> {
        get() { settings.interfaces }
    }

    public prop interfaceNames: Array<QualifiedName> {
        get() { settings.interfaceNames }
    }

    public func findIntefaceSettings(name: QualifiedName): ?DerivingInterfaceSettings {
        interfaces.iterator()
            .filter { it => it.name == name }
            .first()
    }
}

public struct DerivingInterfaceSettings {
    public DerivingInterfaceSettings(
        public let name: QualifiedName,
        public let generics: Array<DerivingGenericSettings>
    ) {}
}
