/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest.mock

import std.unittest.mock.internal.FuncInfo

extend FuncInfo {
    prop hasSetter: Bool {
        get() {
            match (kind) {
                case FieldGetter(_, hasIt) => hasIt
                case PropertyGetter(_, hasIt) => hasIt
                case Method(_) => internalError("Should not be called for method")
                case _ => true
            }
        }
    }

    prop isGetter: Bool {
        get() {
            match (kind) {
                case FieldGetter(_, _) => true
                case PropertyGetter(_, _) => true
                case _ => false
            }
        }
    }

    prop isSetter: Bool {
        get() {
            match (kind) {
                case FieldSetter(_) => true
                case PropertySetter(_) => true
                case _ => false
            }
        }
    }

    prop presentableName: String {
        get() {
            match (kind) {
                case FieldGetter(name, _) => name
                case PropertyGetter(name, _) => name
                case FieldSetter(name) => name
                case PropertySetter(name) => name
                case Method(name) => name
                case TopLevelFunction(name) => name
                case StaticMethod(name) => name
                case StaticPropertyGetter(name) => name
                case StaticPropertySetter(name) => name
                case StaticFieldGetter(name) => name
                case StaticFieldSetter(name) => name
                case TopLevelVariableGetter(name) => name
                case TopLevelVariableSetter(name) => name
            }
        }
    }
}
