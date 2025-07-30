/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.reflect

/**
 * Contains reflective information about primitive types.
 */
public class PrimitiveTypeInfo <: TypeInfo {
    static let PRIMITIVES = [NOTHING_QN, UNIT_QN, CHAR_QN, BOOL_QN, INT8_QN, INT16_QN, INT32_QN, INT64_QN, INT_NATIVE_QN,
        U_INT8_QN, U_INT16_QN, U_INT32_QN, U_INT64_QN, U_INT_NATIVE_QN, FLOAT16_QN, FLOAT32_QN, FLOAT64_QN].toArray()

    static let ARRAY_OBJECT = Array<Object>()

    init(cp: CPointer<Unit>, name: String) {
        super(cp)
        this._qualifiedName = name
        this._name = name
        this._instanceFunctions = Some(Array())
        this._staticFunctions = Some(Array())
        this._instanceProperties = Some(Array())
        this._staticProperties = Some(Array())
        this._superInterfaces = Some([(TypeInfo.of<Any>() as InterfaceTypeInfo).getOrThrow()])
        this._modifiers = Some(Array())
        this._annotations = Some(Array())
    }

    public static redef func get(qualifiedName: String): PrimitiveTypeInfo {
        match (TypeInfo.get(qualifiedName)) {
            case typ: PrimitiveTypeInfo => return typ
            case _ => throw IllegalTypeException("The type of '${qualifiedName}' is not a Primitive Type.")
        }
    }

    public static redef func of(a: Any): PrimitiveTypeInfo {
        match (TypeInfo.of(a)) {
            case typ: PrimitiveTypeInfo => return typ
            case _ => throw IllegalTypeException("The type of parameter 'a' is not a Primitive Type.")
        }
    }

    public static redef func of<T>(): PrimitiveTypeInfo {
        match (TypeInfo.of<T>()) {
            case typ: PrimitiveTypeInfo => return typ
            case _ => throw IllegalTypeException("The type of generic type 'T' is not a Primitive Type.")
        }
    }
}

// the return value is (isPrimitive, mangledName, qualifiedName)
func checkPrimitive(name: String): (Bool, String, String) {
    for (i in 0..PrimitiveTypeInfo.PRIMITIVES.size where name == PrimitiveTypeInfo.PRIMITIVES[i]) {
        return (true, name, PrimitiveTypeInfo.PRIMITIVES[i])
    }
    (false, "", "")
}
