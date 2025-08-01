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
 * Contains the reflective information about annotations.
 */
public type Annotation = Object

/**
 * Parses the input string as a TypeInfo array
 *
 * @param parameterTypes the parameter type part of the function type.
 * It does not contain the parameter name, default value, or outermost parenthesis.
 * @return TypeInfo array converted from a parameter type string.
 *
 * @throws IllegalArgumentException if the input string does not comply with the specifications
 */
public func parseParameterTypes(parameters: String): Array<TypeInfo> {
    let parameterTypes = parameters.trimAscii()
    if (parameterTypes.isEmpty()) {
        return Array<TypeInfo>()
    }
    let arr = ArrayList<TypeInfo>()
    var parentheses = 0
    var angleBrackets = 0
    var startChar = 0
    for (index in 0..parameterTypes.size - 1) {
        if (parentheses < 0 || angleBrackets < 0) {
            throw IllegalArgumentException("The value of parameterTypes does not comply with the specifications.")
        }
        match (parameterTypes[index]) {
            case '(' => parentheses++
            case ')' => parentheses--
            case '<' => angleBrackets++
            case '>' => angleBrackets--
            case _ => ()
        }
        if (parentheses != 0 || angleBrackets != 0 || parameterTypes[index] != b',') {
            continue
        }
        let str = parameterTypes[startChar..index]
        if (str.trimAscii().isEmpty()) {
            throw IllegalArgumentException("The value of parameterTypes does not comply with the specifications.")
        }
        arr.add(TypeInfo.get(str.trimAscii()))
        startChar = index + 1
    }
    arr.add(TypeInfo.get(parameterTypes[startChar..].trimAscii()))
    return arr.toArray()
}

func getByNameAndParamTypes<T>(source: Iterable<T>, name: String, parameterTypes: Array<TypeInfo>, message: String,
    nameAndParamsGetter: (T) -> (String, ReadOnlyList<ParameterInfo>)): T {
    for (item in source) {
        let (currName, currParams) = nameAndParamsGetter(item)
        if (currName != name) {
            continue
        }
        if (currParams.size != parameterTypes.size) {
            continue
        }
        var sameParamTypes = true
        for (paramIdx in 0..currParams.size) {
            let currParamType = currParams[paramIdx].typeInfo
            let otherParamType = parameterTypes[paramIdx]
            if (currParamType != otherParamType) {
                sameParamTypes = false
                break
            }
        }
        if (sameParamTypes) {
            return item
        }
    }
    throw InfoNotFoundException(message)
}

func getByName<T>(source: Iterable<T>, name: String, message: String, nameGetter: (T) -> String): T {
    for (item in source) {
        if (nameGetter(item) == name) {
            return item
        }
    }
    throw InfoNotFoundException(message)
}

func getTypeNameByQualifiedName(qualifiedName: String): String {
    var str = qualifiedName
    if (let Some(bracketIndex) <- qualifiedName.indexOf("<")) {
        str = qualifiedName[..bracketIndex]
    }
    var pointIndex = str.lastIndexOf(".") ?? -1
    return qualifiedName[pointIndex + 1..]
}

func checkArgsSizeAndType(parameters: ReadOnlyList<ParameterInfo>, args: Array<Any>): Unit {
    if (parameters.size != args.size) {
        throw IllegalArgumentException("The input parameter item does not comply with the required quantity.")
    }
    for (i in 0..args.size) {
        if (!TypeInfo.of(args[i]).isSubtypeOf(parameters[i].typeInfo)) {
            throw IllegalTypeException(
                "The input parameter does not match the type of the input parameter required by the function.")
        }
    }
}

func checkValueType(newValue: Any, typeInfo: TypeInfo): Unit {
    let valueTypeInfo = TypeInfo.of(newValue)
    if (!valueTypeInfo.isSubtypeOf(typeInfo)) {
        throw IllegalTypeException("The input newValue should be \"${typeInfo}\", but now it`s \"${valueTypeInfo}\"")
    }
}

func findAnnotation<T>(annotations: Collection<Annotation>): Option<T> {
    for (a in annotations) {
        match (a) {
            case annotation: T => return annotation
            case _ => ()
        }
    }
    None
}
