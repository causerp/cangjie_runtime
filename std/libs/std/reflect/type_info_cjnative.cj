/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.reflect

import std.collection.*
import std.sync.*

// Every operation that can create TypeInfo should take this lock
let TYPE_INFO_CREATE_LOCK = Mutex()

class TypeTemplate {
    protected let _info: CPointer<Unit>
    init(info: CPointer<Unit>) {
        _info = info
    }

    static func get(typeinfoName: String): TypeTemplate {
        let name = if (typeinfoName.contains(".")) {
            unsafe { LibC.mallocCString(typeinfoName) }
        } else {
            unsafe { LibC.mallocCString("std.core." + typeinfoName) }
        }
        let info = getTypeTemplate(name.getChars())
        unsafe { LibC.free(name) }
        TypeTemplate(info)
    }

    prop info: CPointer<Unit> {
        get() {
            _info
        }
    }
}

class TypeTemplateParser {
    var templates = ArrayList<String>()
    var data = ArrayList<ArrayList<String>>()
    var map = HashMap<String, CPointer<Unit>>()
    func parse(string: String): TypeInfo {
        let name = unsafe { string.rawData() }
        parseGenericString(name, 0, name.size)
        templates.reverse()
        for (i in 0..templates.size) {
            let tt = templates[i]
            let template = TypeTemplate.get(tt)
            if (template._info.isNull() || data.size <= i) {
                throw InfoNotFoundException("TypeInfo `${string}` not found.")
            }
            let genericParams = ArrayList<CPointer<Unit>>(data[i].size) {
                j =>
                let typeStr = data[i][j]
                if (typeStr.contains("<")) {
                    map.get(typeStr) ?? throw InfoNotFoundException("TypeInfo `${typeStr}` not found.")
                } else {
                    TypeInfo.get(typeStr)._info
                }
            }
            let info = getOrCreateTypeInfoForReflect(template.info, genericParams.toArray())
            if (info.isNull()) {
                throw InfoNotFoundException("Cannot find ${tt}.")
            }
            let qualifiedName = tt + "<" + String.join(data[i].toArray(), delimiter: ",") + ">"
            map.add(qualifiedName, info)

            if (i == templates.size - 1) {
                return TypeInfo.getOrCreate(info)
            }
        }
        throw InfoNotFoundException("Cannot find ${name.toString()}")
    }

    func parseGenericString(name: Array<Byte>, begin: Int64, end: Int64): Int64 {
        if (begin >= end) {
            return end
        }
        var strs: ArrayList<String> = ArrayList<String>()
        var start = begin
        var count = 0
        var idx = begin
        while (idx < end) {
            if (name[idx] == b'<') {
                count += 1
                templates.add(String.fromUtf8(name[start..idx]).trimAscii())
                idx = parseGenericString(name, idx + 1, end)
            } else if (name[idx] == b'>') {
                strs.add(String.fromUtf8(name[start..idx]).trimAscii())
                data.add(strs)
                return idx
            } else if (name[idx] == b',') {
                strs.add(String.fromUtf8(name[start..idx]).trimAscii())
                start = idx + 1
            }
            idx += 1
        }
        return end
    }
}

/**
 * Contains the reflective information that is common for classes, interfaces, structs and primitive types.
 */
sealed abstract class TypeInfo <: Equatable<TypeInfo> & Hashable & ToString {
    private static let CACHE = HashMap<String, TypeInfo>()

    // this is a pointer to type metadata
    protected let _info: CPointer<Unit>
    var _qualifiedName: Option<String> = None
    var _name: Option<String> = None

    var _instanceFunctions: Option<Collection<InstanceFunctionInfo>> = None
    var _staticFunctions: Option<Collection<StaticFunctionInfo>> = None

    var _instanceProperties: Option<Collection<InstancePropertyInfo>> = None
    var _staticProperties: Option<Collection<StaticPropertyInfo>> = None

    var _annotations: Option<Collection<Annotation>> = None
    var _superInterfaces: Option<Collection<InterfaceTypeInfo>> = None
    var _modifiers: Option<Collection<ModifierInfo>> = None
    var typeTemplate: TypeTemplate = TypeTemplate(CPointer<Unit>())
    var genericParams: Array<TypeInfo> = Array<TypeInfo>()
    init(cp: CPointer<Unit>) {
        _info = cp
    }

    /**
     * Creates the certain type info by generic type T.
     */
    public static func of<T>(): TypeInfo {
        getOrCreate(getTypeByMangledName<T>())
    }

    /**
     * Creates the certain type info for incoming instance with 'Any' type.
     */
    public static func of(a: Any): TypeInfo {
        getOrCreate(getTypeForAny(a))
    }

    /**
     * Creates the class type info for incoming instance with 'Object' type.
     */
    @Deprecated[message: "Use 'ClassTypeInfo.get(Object)' instead."]
    public static func of(a: Object): ClassTypeInfo {
        (getOrCreate(getObjClass(a)) as ClassTypeInfo) ?? throw InfoNotFoundException("TypeInfo not found!")
    }

    /**
     * Searches and creates the certain type info by incoming qualified name.
     * If no corresponding type information for incoming qualified name is found, the exception is thrown.
     */
    public static func get(qualifiedName: String): TypeInfo {
        synchronized(TYPE_INFO_CREATE_LOCK) {
            match (CACHE.get(qualifiedName)) {
                case Some(ti) => ti
                case None =>
                    let name = normalize(qualifiedName)
                    if (!name.contains("<")) {
                        let (realName, typeInfoPointer) = getInfoPointerByQualifiedName(name)
                        let newQualifiedName = realName.replace("std.core.", "")
                        createTypeInfo(typeInfoPointer, newQualifiedName)
                    } else {
                        TypeTemplateParser().parse(name.replace("std.core.", ""))
                    }
            }
        }
    }

    private static func normalize(qualifiedName: String): String {
        let (isPrimitive, _, _) = checkPrimitive(qualifiedName)
        let hasPrefix = qualifiedName.contains(".")
        let isGeneric = qualifiedName.contains("<")

        // 1. primitive type should use mangled name to find type
        // 2. qualifiedName in std.core should omits prefix, but runtime need it, must complete qualifiedName here
        let stripedName = qualifiedName.replace(" ", "")
        match ((isPrimitive, hasPrefix, isGeneric)) {
            case (true, _, _) => unsafe { stripedName }
            case (_, _, true) => unsafe { parseGeneric(stripedName) }
            case (_, false, _) => unsafe { "std.core.${stripedName}" }
            case _ => unsafe { stripedName }
        }
    }

    private static func getInfoPointerByQualifiedName(qualifiedName: String): (String, CPointer<Unit>) {
        unsafe {
            let cstring = LibC.mallocCString(qualifiedName)
            let typeInfoPointer = getTypeByQualifiedName(cstring.getChars())
            LibC.free(cstring)
            if (typeInfoPointer.isNull()) {
                throw InfoNotFoundException("TypeInfo '${qualifiedName.replace("std.core.", "")}' not found")
            }
            (qualifiedName, typeInfoPointer)
        }
    }

    // tuple and function type currently not supported
    // eg: Array<(()-> Unit, (Int64, String) -> Unit)>
    private static func parseGeneric(qualifiedName: String): String {
        var dotNum = 0
        var lastParseIdx = 0
        let sb = StringBuilder()
        var idx = 0
        while (idx < qualifiedName.size) {
            match (qualifiedName[idx]) {
                case '.' => dotNum++
                case '<' =>
                    let isPrimitive = checkPrimitive(qualifiedName[lastParseIdx..idx])[0]
                    if (dotNum == 0 && !isPrimitive && qualifiedName[lastParseIdx..idx] != "Tuple") {
                        sb.append("std.core.")
                    }
                    sb.append(qualifiedName[lastParseIdx..=idx])
                    dotNum = 0
                    lastParseIdx = idx + 1
                case '>' =>
                    let isPrimitive = checkPrimitive(qualifiedName[lastParseIdx..idx])[0]
                    if (dotNum == 0 && qualifiedName[idx - 1] != b'>' && !isPrimitive &&
                        qualifiedName[lastParseIdx..idx] != "Tuple") {
                        sb.append("std.core.")
                    }
                    sb.append(qualifiedName[lastParseIdx..=idx])
                    dotNum = 0
                    lastParseIdx = idx + 1
                case ',' =>
                    let isPrimitive = checkPrimitive(qualifiedName[lastParseIdx..idx])[0]
                    if (dotNum == 0 && !isPrimitive && qualifiedName[lastParseIdx..idx] != "Tuple") {
                        sb.append("std.core.")
                    }
                    sb.append(qualifiedName[lastParseIdx..idx])
                    sb.append(",")
                    if (idx < qualifiedName.size - 1 && qualifiedName[idx + 1] == b' ') {
                        idx++
                    }
                    dotNum = 0
                    lastParseIdx = idx + 1
                case _ => ()
            }
            idx++
        }
        sb.toString()
    }

    static func getOrCreate(typeInfoPointer: CPointer<Unit>): TypeInfo {
        if (typeInfoPointer.isNull()) {
            throw InfoNotFoundException("TypeInfo not found!")
        }
        synchronized(TYPE_INFO_CREATE_LOCK) {
            var qualifiedName = getQualifiedName(typeInfoPointer)
            qualifiedName = qualifiedName.replace("std.core.", "")
            match (CACHE.get(qualifiedName)) {
                case Some(ti) => ti
                case None => createTypeInfo(typeInfoPointer, qualifiedName)
            }
        }
    }

    // judge the real type by mangled name, after ug, mangeledName = qualifiedName
    static func createTypeInfo(typeInfoPointer: CPointer<Unit>, qualifiedName: String) {
        let isPrimitive = isPrimitive(typeInfoPointer)
        if (isPrimitive) {
            let typeInfo = PrimitiveTypeInfo(typeInfoPointer, qualifiedName)
            CACHE.add(qualifiedName, typeInfo)
            return typeInfo
        }

        let mangledName = getQualifiedName(typeInfoPointer)
        if (mangledName.isEmpty()) {
            throw ReflectException("Unexpected empty mangledName")
        }

        // match first character in mangled name
        let typeInfo = if (isInterface(typeInfoPointer)) {
            InterfaceTypeInfo(typeInfoPointer)
        } else if (isClass(typeInfoPointer)) {
            ClassTypeInfo(typeInfoPointer)
        } else if (isStruct(typeInfoPointer)) {
            StructTypeInfo(typeInfoPointer)
        } else if (isGeneric(typeInfoPointer)) {
            GenericTypeInfo(typeInfoPointer)
        } else {
            throw ReflectException("Type \"${mangledName}\" is not supported")
        }

        typeInfo._qualifiedName = mangledName
        CACHE.add(mangledName, typeInfo)
        typeInfo
    }

    /**
     * Returns the simple name of type info.
     */
    public prop name: String {
        get() {
            match (_name) {
                case Some(res) => res
                case None =>
                    let typeName = getTypeNameByQualifiedName(qualifiedName)
                    _name = typeName
                    typeName
            }
        }
    }

    /**
     * Returns the qualified name of type info.
     */
    public prop qualifiedName: String {
        get() {
            match (_qualifiedName) {
                case Some(res) => res
                case None =>
                    let name = getQualifiedName(_info)
                    _qualifiedName = name.replace(":", ".")
                    name
            }
        }
    }

    // return qualifiedName with space from runtime
    private static func getQualifiedName(pointer: CPointer<Unit>): String {
        let namePointer = getTypeName(pointer)
        return if (let qualifiedName <- CString(namePointer).toString()) {
            var formatted = ArrayList<Byte>()
            for (ch in qualifiedName.toArray()) {
                formatted.add(if (ch == b':') {
                    b'.'
                } else {
                    ch
                })
                if (ch == b',') {
                    formatted.add(b' ')
                }
            }
            String.fromUtf8(formatted.toArray()).replace("std.core.", "")
        } else {
            throw ReflectException("Unexpected empty qualifiedName.")
        }
    }

    /**
     * Returns the collection of public instance functions of type info.
     */
    public prop instanceFunctions: Collection<InstanceFunctionInfo> {
        get() {
            if (_instanceFunctions.isNone()) {
                getInstanceFunctions()
            }
            _instanceFunctions.getOrThrow()
        }
    }

    /**
     * Returns the list of public static functions of type info.
     */
    public prop staticFunctions: Collection<StaticFunctionInfo> {
        get() {
            if (_staticFunctions.isNone()) {
                getStaticFunctions()
            }
            _staticFunctions.getOrThrow()
        }
    }

    /**
     * Returns the collection of public instance properties of type info.
     */
    public prop instanceProperties: Collection<InstancePropertyInfo> {
        get() {
            if (_instanceProperties.isNone()) {
                getInstanceFunctions()
            }
            _instanceProperties.getOrThrow()
        }
    }

    /**
     * Returns the collection of public static properties of type info.
     */
    public prop staticProperties: Collection<StaticPropertyInfo> {
        get() {
            if (_staticProperties.isNone()) {
                getStaticFunctions()
            }
            _staticProperties.getOrThrow()
        }
    }

    /**
     * Returns the collection of annotations of type info.
     */
    public prop annotations: Collection<Annotation> {
        get() {
            match (_annotations) {
                case Some(res) => res
                case None =>
                    let infos = match (getTypeInfoAnnotations(_info, TypeInfo.of<Array<Object>>()._info)) {
                        case arr: Array<Annotation> => arr
                        case _ => Array<Annotation>()
                    }
                    _annotations = infos
                    infos
            }
        }
    }

    /**
     * Returns the collection of super interfaces of type info.
     */
    public prop superInterfaces: Collection<InterfaceTypeInfo> {
        get() {
            match (_superInterfaces) {
                case Some(res) => res
                case None =>
                    let num = getNumOfInterface(_info)
                    let interfaceList = ArrayList<InterfaceTypeInfo>()
                    for (index in 0..num) {
                        let pointer = getInterface(_info, UInt32(index))
                        if (pointer == _info) {
                            continue
                        }
                        interfaceList.add(
                            (getOrCreate(pointer) as InterfaceTypeInfo) ?? throw MisMatchException(
                                "Super interface info of '${qualifiedName}' can not cast to InterfaceTypeInfo."))
                    }
                    let anyType = (TypeInfo.of<Any>() as InterfaceTypeInfo).getOrThrow()
                    var hasAny = false
                    for (ti in interfaceList) {
                        if (ti == anyType) {
                            hasAny = true
                        }
                    }
                    if (!hasAny) {
                        interfaceList.add(anyType)
                    }
                    let infos = interfaceList.toArray()
                    _superInterfaces = infos
                    infos
            }
        }
    }

    /**
     * Returns the collection of modifiers of type info.
     */
    public prop modifiers: Collection<ModifierInfo> {
        get() {
            match (_modifiers) {
                case Some(res) => res
                case None =>
                    let infos = ModifierInfo.byMask(getTypeInfoModifier(_info))
                    _modifiers = infos
                    infos
            }
        }
    }

    /**
     * Returns true, if current type info is subtype of incoming type info, false otherwise.
     */
    public func isSubtypeOf(supertype: TypeInfo): Bool {
        // Any is super type of all types
        if (supertype.qualifiedName == "Any") {
            return true
        }
        isSubType(_info, supertype._info)
    }

    /**
     * Searches the type info's public instance function by incoming name and parameter types.
     */
    public func getInstanceFunction(name: String, parameterTypes: Array<TypeInfo>): InstanceFunctionInfo {
        getByNameAndParamTypes(instanceFunctions, name, parameterTypes, "Instance func '${name}' not found.") {
            instanceFunction => (instanceFunction.name, instanceFunction.parameters)
        }
    }

    public func getInstanceFunctions(name: String): Array<InstanceFunctionInfo> {
        var fns: ArrayList<InstanceFunctionInfo> = ArrayList<InstanceFunctionInfo>()
        for (fn in instanceFunctions where fn.name == name) {
            fns.add(fn)
        }
        fns.toArray()
    }

    /**
     * Searches the type info's public static function by incoming name and parameter types.
     */
    public func getStaticFunction(name: String, parameterTypes: Array<TypeInfo>): StaticFunctionInfo {
        getByNameAndParamTypes(staticFunctions, name, parameterTypes, "Static func '${name}' not found.") {
            staticFunction => (staticFunction.name, staticFunction.parameters)
        }
    }

    public func getStaticFunctions(name: String): Array<StaticFunctionInfo> {
        var fns: ArrayList<StaticFunctionInfo> = ArrayList<StaticFunctionInfo>()
        for (fn in staticFunctions where fn.name == name) {
            fns.add(fn)
        }
        fns.toArray()
    }

    /**
     * Searches the type info's public instance property by incoming name and signature.
     */
    public func getInstanceProperty(name: String): InstancePropertyInfo {
        getByName(instanceProperties, name, "Instance property '${name}' not found.") {
            instanceProperty => instanceProperty.name
        }
    }

    /**
     * Searches the type info's public static property by incoming name and signature.
     */
    public func getStaticProperty(name: String): StaticPropertyInfo {
        getByName(staticProperties, name, "Static property '${name}' not found.") {
            staticProperty => staticProperty.name
        }
    }

    /**
     * Searches the type info's annotation by incoming name.
     */
    public func findAnnotation<T>(): Option<T> {
        findAnnotation(annotations)
    }

    public operator func ==(that: TypeInfo): Bool {
        this.qualifiedName == that.qualifiedName
    }

    public operator func !=(that: TypeInfo): Bool {
        this.qualifiedName != that.qualifiedName
    }

    public func hashCode(): Int64 {
        this._info.toUIntNative().hashCode()
    }

    public func toString(): String {
        this.qualifiedName
    }

    func getInstanceFunctions() {
        let num = getNumOfInstanceMethodInfos(_info)
        let constructors = ArrayList<ConstructorInfo>()
        let instanceFuncs = ArrayList<InstanceFunctionInfo>()
        let instanceProps = HashMap<String, InstancePropertyInfo>()
        for (index in 0..Int64(num)) {
            let pointer = getInstanceMethodInfo(_info, UInt32(index))
            if (pointer.isNull()) {
                throw InfoNotFoundException("TypeInfo find instance functions failed!")
            }
            let name = getFuncName(pointer)
            if (name.isEmpty()) {
                throw ReflectException("Unexpected empty instance func name.")
            }
            // prop func starts with $
            // need filter $toAny , which is generated by compiler
            // NOTE: only exist in instance func of struct
            if (name[0] == b'$') {
                let isGetter = match (name[name.size - 3..]) {
                    case "get" => true
                    case "set" => false
                    case _ => continue
                }
                let propName = name[1..name.size - 3]
                if (instanceProps.contains(propName)) {
                    let propInfo = instanceProps[propName]
                    propInfo.setFunc(isGetter, pointer)
                } else {
                    let propInfo = InstancePropertyInfo(propName, _info)
                    propInfo.setFunc(isGetter, pointer)
                    instanceProps.add(propName, propInfo)
                }
            } else if (name == constructorName) {
                let constructor = ConstructorInfo(pointer, _info)
                constructors.add(constructor)
            } else {
                let instanceFunc = InstanceFunctionInfo(pointer, _info)
                instanceFunc._name = name
                instanceFuncs.add(instanceFunc)
            }
        }
        _instanceFunctions = instanceFuncs.toArray()
        _instanceProperties = instanceProps.values()
        match (this) {
            case classType: ClassTypeInfo => classType._constructors = constructors.toArray()
            case structType: StructTypeInfo => structType._constructors = constructors.toArray()
            case _ => ()
        }
    }

    func getStaticFunctions() {
        let num = getNumOfStaticMethodInfos(_info)
        let staticFuncs = ArrayList<StaticFunctionInfo>()
        let staticProps = HashMap<String, StaticPropertyInfo>()
        for (index in 0..Int64(num)) {
            let pointer = getStaticMethodInfo(_info, UInt32(index))
            if (pointer.isNull()) {
                throw InfoNotFoundException("TypeInfo find static functions failed!")
            }
            let name = getFuncName(pointer)
            if (name.isEmpty()) {
                throw ReflectException("Unexpected empty static func name.")
            }
            // prop func starts with $
            if (name.startsWith("$")) {
                let isGetter = match (name[name.size - 3..]) {
                    case "get" => true
                    case "set" => false
                    case _ => continue
                }
                let propName = name[1..name.size - 3]
                if (staticProps.contains(propName)) {
                    let propInfo = staticProps[propName]
                    propInfo.setFunc(isGetter, pointer)
                } else {
                    let propInfo = StaticPropertyInfo(propName, _info)
                    propInfo.setFunc(isGetter, pointer)
                    staticProps.add(propName, propInfo)
                }
            } else {
                let staticFunc = StaticFunctionInfo(pointer, _info)
                staticFunc._name = name
                staticFuncs.add(staticFunc)
            }
        }
        _staticProperties = staticProps.values()
        _staticFunctions = staticFuncs.toArray()
    }
}

extend<T> CPointer<T> {
    operator func ==(that: CPointer<T>): Bool {
        this.toUIntNative() == that.toUIntNative()
    }
}
