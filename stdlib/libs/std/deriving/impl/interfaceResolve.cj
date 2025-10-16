/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
protected package std.deriving.impl

import std.deriving.api.*
import std.ast.Token

private let Core = QualifiedName("std.core")

func resolveInterface(name: Identifier): QualifiedName {
    // we don't have resolve yet so we try to guess or always assume the core package

    let results = interfacesBySimpleName(name.value)
    if (results.size == 1) {
        let qualifiedName = results[0]

        // we reconstruct the qualified name replacing the simple name part
        // because we want to keep the original token stored in the "name: Identifier"
        return qualifiedName.replaceSimpleName(name.token)
    }

    Core + name
}

extend QualifiedName {
    func replaceSimpleName(name: Token) {
        let components = tokens.clone()
        let lastIndex = components.size - 1
        components[lastIndex] = name
        return QualifiedName(components)
    }
}
