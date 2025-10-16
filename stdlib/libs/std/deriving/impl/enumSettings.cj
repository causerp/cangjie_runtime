/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
protected package std.deriving.impl

import std.deriving.api.*
import std.ast.*
import std.collection.*

func settingsForEnum(
    inputOptions: InputOptions,
    enumDecl: EnumDecl,
    logger: Logger
): SettingsOutput {
    let allCases = enumDecl.allCases()
    let allProperties = enumDecl.allProperties()

    let includedSet = inputOptions.included |> collectHashSet

    let includedProperties = allProperties |> filter { p: PropDecl =>
        includedSet.contains(Identifier(p.identifier))
    } |> collectArray

    let namedAttributesMap = HashMap(includedProperties |>
        map { p: PropDecl =>
            let att = TargetNamedAttribute.PropertyAttribute(p)
            (att.identifier, att)
        } |> collectArray)

    let namedAttributes = if (inputOptions.ordering.isEmpty()) {
        includedProperties |> map { p: PropDecl => namedAttributesMap[Identifier(p.identifier)] } |> collectArray
    } else { inputOptions.ordering |> map { id: Identifier => namedAttributesMap[id] } |> collectArray }

    let settings = DerivingSettings(
        mapInterfaceSettings(enumDecl.generics(), inputOptions.origin, logger),
        [],
        allCases,
        inputOptions.ordering,
        includedProperties
    )

    let target = DerivingTarget(
        inputOptions.decl,
        namedAttributes,
        allCases,
        settings
    )

    return SettingsOutput(settings, target)
}
