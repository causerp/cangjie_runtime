/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.reflect

import std.collection.*

/**
 * Contains reflective information about interfaces.
 */
public class InterfaceTypeInfo <: TypeInfo {
    var _sealedSubtypes: Option<Collection<TypeInfo>> = None

    init(cp: CPointer<Unit>) {
        super(cp)
    }

    public redef static func get(qualifiedName: String): InterfaceTypeInfo {
        match (TypeInfo.get(qualifiedName)) {
            case typ: InterfaceTypeInfo => return typ
            case _ => throw IllegalTypeException("The type of '${qualifiedName}' is not an Interface Type")
        }
    }

    public redef static func of(a: Any): InterfaceTypeInfo {
        match (TypeInfo.of(a)) {
            case typ: InterfaceTypeInfo => return typ
            case _ => throw IllegalTypeException("The type of parameter 'a' is not an Interface Type")
        }
    }

    public redef static func of<T>(): InterfaceTypeInfo {
        match (TypeInfo.of<T>()) {
            case typ: InterfaceTypeInfo => return typ
            case _ => throw IllegalTypeException("The type of generic type 'T' is not an Interface Type")
        }
    }

    /**
     * Returns the collection of sealed subtypes of type info.
     */
    public prop sealedSubtypes: Collection<TypeInfo> {
        get() {
            match (_sealedSubtypes) {
                case Some(res) => res
                case None =>
                    let res = if (!isSealed()) {
                        Array<TypeInfo>()
                    } else {
                        findSubtypeFromPackage<TypeInfo>(this)
                    }
                    _sealedSubtypes = res
                    res
            }
        }
    }

    public func isSealed(): Bool {
        containsModifier(modifiers, ModifierInfo.Sealed)
    }
}

func findSubtypeFromPackage<T>(curType: TypeInfo): Array<T> where T <: TypeInfo {
    func getSubtypes<T>(typeInfos: Collection<TypeInfo>): ArrayList<T> {
        let subtypes = ArrayList<T>()
        for (ti in typeInfos) {
            if (ti.name == "Nothing") {
                continue
            }

            if (ti.isSubtypeOf(curType)) {
                subtypes.add((ti as T).getOrThrow())
            }
        }
        subtypes
    }

    let qualifiedName = curType.qualifiedName
    // since primitive type is not sealed, if qualifiedName doesn`t contain r'.',
    // it must be type in std.core
    let curPackage = match (qualifiedName.lastIndexOf(b'.')) {
        case Some(v) => qualifiedName[..v]
        case None => "std.core"
    }

    try {
        let info = PackageInfo.get(curPackage)
        let subtypes = getSubtypes<T>(info.typeInfos)
        subtypes.add(all: getSubtypes<T>(info.noPublicInfos))
        subtypes.toArray()
    } catch (_: InfoNotFoundException | ReflectException) {
        Array<T>()
    }
}
