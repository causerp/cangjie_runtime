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

public struct InputOptions {
    public InputOptions(
        public let origin: Array<DeriveInterfaceOption>,
        public let inputNames: Array<QualifiedName>,
        public let allInterfaceNames: Array<QualifiedName>,
        public let decl: Decl,
        public let included: Array<Identifier>,
        public let excluded: Array<Identifier>,
        public let ordering: Array<Identifier>
    ) {}
}

public struct SettingsOutput {
    public SettingsOutput(
        public let settings: DerivingSettings,
        public let target: DerivingTarget
    ) {}
}

public func settingsFor(
    inputOptions: InputOptions,
    logger: Logger
): ?SettingsOutput {
    match (inputOptions.decl) {
        case clazz: ClassDecl => settingsForClassLike(inputOptions, clazz, logger)
        case str: StructDecl => settingsForClassLike(inputOptions, str, logger)
        case en: EnumDecl => settingsForEnum(inputOptions, en, logger)
        case _ =>
            logger.error(inputOptions.decl.keyword, "Deriving is only supported for classes, enums and structs")
            return None
    }
}
