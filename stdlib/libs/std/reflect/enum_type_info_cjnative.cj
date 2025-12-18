/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.reflect

import std.collection.*

/**
 * Reflective information about an enum type.
 *
 * This class exposes constructors, construction, and deconstruction helpers for enums.
 */
public class EnumTypeInfo <: TypeInfo {
    var _constructors: Option<Collection<EnumConstructorInfo>> = None
    var _constructorsByTypeInfo: Option<HashMap<UIntNative, EnumConstructorInfo>> = None

    init(cp: CPointer<Unit>) {
        super(cp)
    }

    /**
     * Returns all enum constructors defined on this enum type.
     *
     * @throws InfoNotFoundException if constructor metadata is missing in runtime.
     */
    public prop constructors: Collection<EnumConstructorInfo> {
        get() {
            match (_constructors) {
                case Some(res) => res
                case None =>
                    let infoList = ArrayList<EnumConstructorInfo>()
                    let num = getNumOfEnumConstructorInfos(_info)
                    for (index in 0..Int64(num)) {
                        let ctorInfo = getEnumConstructorInfo(_info, UInt32(index))
                        if (ctorInfo.isNull()) {
                            throw InfoNotFoundException(
                                "Failed to get enum constructors for type `${qualifiedName}`: constructor info at index ${index} is null.")
                        }
                        let name: CString = CString(getEnumConstructorName(ctorInfo))
                        infoList.add(EnumConstructorInfo(ctorInfo, _info, ctorName: name))
                    }
                    let infos = infoList.toArray()
                    let infoMap = HashMap<UIntNative, EnumConstructorInfo>(infos.size) {
                        idx =>
                            let ctor = infos[idx]
                            (ctor._info.toUIntNative(), ctor)
                    }
                    _constructors = infos
                    _constructorsByTypeInfo = infoMap
                    infos
            }
        }
    }

    /**
     * Finds enum type information by qualified type name.
     *
     * @param qualifiedName fully qualified enum type name (e.g. "default.E").
     * @return enum type info for the given name.
     * @throws IllegalTypeException if the name is not an enum type or not found.
     */
    public static redef func get(qualifiedName: String): EnumTypeInfo {
        try {
            match (TypeInfo.get(qualifiedName)) {
                case ti: EnumTypeInfo => return ti
                case other => throw IllegalTypeException(
                    "Expected enum type `${qualifiedName}`, but got `${other.qualifiedName}`.")
            }
        } catch (e: InfoNotFoundException) {
            throw IllegalTypeException(
                "Expected an enum type name (e.g. `default.E`), but got `${qualifiedName}`. Use EnumConstructorInfo.get for constructor names.")
        }
    }

    /**
     * Returns enum type info for an enum instance (or its case type).
     *
     * @param instance enum value or enum case instance.
     * @return enum type info for the declaring enum.
     * @throws IllegalTypeException if instance is not an enum value or case.
     */
    public static redef func of(instance: Any): EnumTypeInfo {
        let ti = TypeInfo.of(instance)
        match (ti) {
            case eti: EnumTypeInfo => match (getEnumSuperTypeInfo(eti)) {
                case Some(superInfo) => return superInfo
                case None => return eti
            }
            case other => throw IllegalTypeException(
                "Parameter `instance` must be an Enum type instance (expected enum or enum case type), but got `${other.qualifiedName}`.")
        }
    }

    /**
     * Returns enum type info for a generic enum type (or its case type).
     *
     * @return enum type info for the declaring enum.
     * @throws IllegalTypeException if T is not an enum type or case type.
     */
    public static redef func of<T>(): EnumTypeInfo {
        let ti = TypeInfo.of<T>()
        match (ti) {
            case eti: EnumTypeInfo => match (getEnumSuperTypeInfo(eti)) {
                case Some(superInfo) => return superInfo
                case None => return eti
            }
            case other => throw IllegalTypeException(
                "Generic type `T` must be an Enum type, but got `${other.qualifiedName}`.")
        }
    }

    /**
     * Constructs an enum instance by constructor signature and arguments.
     *
     * @param constructor constructor signature (e.g. "M1<Int32>") or an enum-qualified suffix
     *        (e.g. "E.M1<Int32>").
     * @param args argument values for the constructor parameters.
     * @return constructed enum instance.
     * @throws InvocationTargetException if argument count or types do not match.
     */
    public func construct(constructor: String, args: Array<Any>): Any {
        let ctor = getConstructorBySignature(constructor)
        try {
            ctor.apply(args)
        } catch (e: IllegalArgumentException | IllegalTypeException) {
            throw InvocationTargetException(
                "Failed to construct enum `${qualifiedName}` with constructor `${ctor.signature}`: ${e.message}.")
        }
    }

    /**
     * Destructs an enum instance into its constructor info and associated values.
     *
     * @param instance enum value or enum case instance.
     * @return pair of constructor info and associated values in declaration order.
     * @throws IllegalTypeException if instance is not compatible with this enum.
     */
    public func destruct(instance: Any): (EnumConstructorInfo, ReadOnlyList<Any>) {
        let ti = TypeInfo.of(instance)
        if (!ti.isSubtypeOf(this)) {
            throw IllegalTypeException(
                "Failed to destruct enum `${qualifiedName}`: expected an instance of `${qualifiedName}` (or its case type), but got `${ti.qualifiedName}`.")
        }

        let ctorInfo = getEnumConstructorInfoFromAny(instance)
        if (ctorInfo.isNull()) {
            throw IllegalTypeException(
                "Failed to destruct enum `${qualifiedName}`: enum constructor info is null.")
        }
        let ctor = getCachedConstructor(ctorInfo) ?? EnumConstructorInfo(ctorInfo, _info,
            ctorName: CString(getEnumConstructorName(ctorInfo)))

        let arrOpt = getAssociatedValues(instance, TypeInfo.of<Array<Any>>()._info) as Array<Any>
        let arr = arrOpt.getOrThrow()
        (ctor, ArrayList<Any>(arr))
    }

    /**
     * Finds a constructor by name and optional argument count.
     *
     * @param constructor constructor name without parameters (e.g. "M1").
     * @param argsCount optional parameter count filter; 0 means no filtering.
     * @return matching constructor info.
     * @throws InfoNotFoundException if no matching constructor is found.
     */
    public func getConstructor(constructor: String, argsCount!: Int64 = 0): EnumConstructorInfo {
        let name = constructor.trimAscii()

        if (argsCount == 0) {
            // for option-like Enum, constructorName may be prefixed with "N$_"
            for (ctor in constructors where ctor.parameters.size == 0 && (ctor.constructorName == name ||
                ctor.constructorName == "N$_" + name)) {
                return ctor
            }
        } else {
            for (ctor in constructors where ctor.constructorName == name && ctor.parameters.size == argsCount) {
                return ctor
            }
        }

        throw InfoNotFoundException("Enum constructor `${constructor}` not found in `${qualifiedName}`.")
    }

    func getConstructorBySignature(signature: String): EnumConstructorInfo {
        let sig = normalizeConstructorSignature(signature) // M1<String>
        for (ctor in constructors) {
            let ctorSignature = normalizeConstructorSignature(ctor.signature) // M1<String>
            let ctorQualifiedName = normalizeConstructorSignature(ctor.qualifiedName) // default.E.M1<String>
            if (ctorSignature == sig || ctorQualifiedName.endsWith("." + sig)) {
                return ctor
            }
        }
        throw InfoNotFoundException("Enum constructor `${signature}` not found in `${qualifiedName}`.")
    }

    func getCachedConstructor(ctorInfo: CPointer<Unit>): ?EnumConstructorInfo {
        match (_constructorsByTypeInfo) {
            case Some(map) =>
                if (ctorInfo.isNull()) {
                    None
                } else {
                    let ctorTypeInfo = unsafe { CPointer<CPointer<Unit>>(CPointer<Byte>(ctorInfo) + 8).read() } // 8: offset of TypeInfo pointer
                    map.get(ctorTypeInfo.toUIntNative())
                }
            case None => None
        }
    }
}

/**
 * Reflective information about a specific enum constructor.
 *
 * Provides constructor signature data, annotations, and invocation helpers.
 */
public class EnumConstructorInfo <: Equatable<EnumConstructorInfo> & Hashable & ToString {
    let _info: CPointer<Unit>
    let _enumTypeInfoPointer: CPointer<Unit>
    var _name: ?String = None
    var _qualifiedName: ?String = None
    var _parameters: ?ReadOnlyList<TypeInfo> = None
    var _annotations: ?Collection<Annotation> = None
    var _constructorName: ?String = None

    init(cp: CPointer<Unit>, enumTypeInfoPointer: CPointer<Unit>, ctorName!: ?CString = None) {
        _info = unsafe { CPointer<CPointer<Unit>>(CPointer<Byte>(cp) + 8).read() }
        _enumTypeInfoPointer = enumTypeInfoPointer
        if (let Some(name) <- ctorName) {
            // for option-like Enum, constructorName may be prefixed with "N$_"
            _constructorName = name.toString().removePrefix("N$_")
        }
    }

    /**
     * Returns annotations declared on the enum constructor type.
     *
     * @return annotation collection, empty if none are present.
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
     * Returns the declaring enum type.
     *
     * @throws MisMatchException if the declaring type is not an enum.
     */
    public prop enumTypeInfo: EnumTypeInfo {
        get() {
            (TypeInfo.getOrCreate(_enumTypeInfoPointer) as EnumTypeInfo) ?? throw MisMatchException(
                "Declaring type is not an Enum type.")
        }
    }

    /**
     * Returns the constructor name without parameters.
     *
     * @return constructor name without generic parameter list.
     */
    public prop name: String {
        get() {
            match (_name) {
                case Some(res) => res
                case None =>
                    let res = constructorName
                    _name = res
                    res
            }
        }
    }

    /**
     * Returns the qualified name for this constructor, including parameters.
     *
     * Example: "default.E.M1<Int32>".
     */
    public prop qualifiedName: String {
        get() {
            match (_qualifiedName) {
                case Some(res) => res
                case None =>
                    let sb = StringBuilder()
                    sb.append(enumTypeInfo.qualifiedName)
                    sb.append(".")
                    sb.append(signature)
                    let n = sb.toString()
                    _qualifiedName = n
                    n
            }
        }
    }

    /**
     * Returns the parameter types of this constructor.
     *
     * @return type list in parameter order.
     */
    public prop parameters: ReadOnlyList<TypeInfo> {
        get() {
            match (_parameters) {
                case Some(res) => res
                case None =>
                    let types = computeParameters()
                    _parameters = types
                    types
            }
        }
    }

    /**
     * Finds constructor info by qualified constructor name.
     *
     * @param qualifiedName qualified constructor name (e.g. "default.E.M1<Int32>").
     * @return constructor info for the qualified name.
     * @throws IllegalTypeException if the constructor cannot be resolved.
     */
    public static func get(qualifiedName: String): EnumConstructorInfo {
        let lastDot = findLastTopLevelDot(qualifiedName)
        if (lastDot < 0) {
            throw IllegalTypeException("Enum constructor `${qualifiedName}` not found.")
        }
        let enumQualifiedName = qualifiedName[..lastDot]
        let signature = qualifiedName[lastDot + 1..]
        try {
            let enumInfo = EnumTypeInfo.get(enumQualifiedName)
            enumInfo.getConstructorBySignature(signature)
        } catch (e: Exception) {
            throw IllegalTypeException("Enum constructor `${qualifiedName}` not found: ${e.message}.")
        } 
    }

    /**
     * Returns constructor info for a given enum instance.
     *
     * @param instance enum value or enum case instance.
     * @return constructor info for the instance.
     * @throws IllegalTypeException if instance is not an enum value or case.
     */
    public static func of(instance: Any): EnumConstructorInfo {
        let ctorInfo = getEnumConstructorInfoFromAny(instance)
        if (ctorInfo.isNull()) {
            let instanceType = TypeInfo.of(instance)
            throw IllegalTypeException(
                "Failed to resolve enum constructor for instance type `${instanceType.qualifiedName}`.")
        }
        let enumInfo = EnumTypeInfo.of(instance)
        if (let Some(cached) <- enumInfo.getCachedConstructor(ctorInfo)) {
            return cached
        }
        let name: CString = CString(getEnumConstructorName(ctorInfo))
        EnumConstructorInfo(ctorInfo, enumInfo._info, ctorName: name)
    }

    /**
     * Applies this constructor to create an enum instance.
     *
     * @param args argument values for the constructor parameters.
     * @return constructed enum instance.
     * @throws InvocationTargetException if argument count mismatches parameters.  * @throws InvocationTargetException if any argument type mismatches parameter types.
     */
    public func apply(args: Array<Any>): Any {
        try {
            checkArgs(args)
        } catch (e: IllegalArgumentException | IllegalTypeException) {
            throw InvocationTargetException(
                "Failed to construct enum `${enumTypeInfo.qualifiedName}` with constructor `${signature}`: ${e.message}.")
        }
        newAndInitEnumTupleObject(_info, args)
    }

    /**
     * Returns associated values for an instance of this constructor.
     *
     * @param instance enum value or enum case instance.
     * @return associated values in declaration order.
     * @throws IllegalTypeException if the instance is not from this enum or was constructed by a different constructor.
     */
    public func getAssociatedvalues(instance: Any): ReadOnlyList<Any> {
        let instanceType = TypeInfo.of(instance)
        if (!instanceType.isSubtypeOf(enumTypeInfo)) {
            throw IllegalTypeException(
                "The instance type `${instanceType.qualifiedName}` does not belong to enum `${enumTypeInfo.qualifiedName}`.")
        }
        let (ctor, values) = enumTypeInfo.destruct(instance)
        if (ctor != this) {
            throw IllegalTypeException("The constructor `${name}` does not match the instance.")
        }
        values
    }

    /**
     * Returns all annotations of type T on this constructor.
     *
     * @return array of annotations of type T.
     */
    public func findAllAnnotations<T>(): Array<T> where T <: Annotation {
        findAllAnnotations<T>(annotations)
    }

    /**
     * Returns a single annotation of type T if it is unique.
     *
     * @return the annotation if exactly one exists; otherwise None.
     */
    public func findAllAnnotation<T>(): ?T where T <: Annotation {
        findAnnotation<T>(annotations)
    }

    /**
     * Returns all annotations on this constructor.
     *
     * @return array of all annotations.
     */
    public func getAllAnnotations(): Array<Annotation> {
        annotations.toArray()
    }

    /**
     * Hashes based on underlying runtime type info pointer.
     */
    public func hashCode(): Int64 {
        _info.toUIntNative().hashCode()
    }

    /**
     * Compares by underlying runtime type info pointer.
     */
    public operator func ==(other: EnumConstructorInfo): Bool {
        _info == other._info
    }

    /**
     * Returns the qualified name of this constructor.
     */
    public func toString(): String {
        qualifiedName
    }

    prop constructorName: String {
        get() {
            match (_constructorName) {
                case Some(res) => res
                case None =>
                    // for option-like Enum, strip "N$_" prefix
                    let res = CString(getEnumConstructorName(_info)).toString().removePrefix("N$_")
                    _constructorName = res
                    res
            }
        }
    }

    prop signature: String {
        get() {
            buildSignature(constructorName, parameters)
        }
    }

    func checkArgs(args: Array<Any>): Unit {
        if (args.size != parameters.size) {
            throw IllegalArgumentException(
                "Invalid number of arguments, expected ${parameters.size} but got ${args.size}.")
        }

        for (i in 0..args.size where !TypeInfo.of(args[i]).isSubtypeOf(parameters[i])) {
            throw IllegalTypeException(
                "Argument index ${i} expected ${parameters[i].qualifiedName} but got ${TypeInfo.of(args[i]).qualifiedName}.")
        }
    }

    func computeParameters(): ArrayList<TypeInfo> {
        let total: Int64 = Int64(getNumOfFieldTypes(_info))
        let arr: CPointer<Unit> = getFieldTypes(_info)
        ArrayList<TypeInfo>(total) {
            idx =>
                let rawIdx = idx
                let info = unsafe { CPointer<Byte>(arr) + 8 * rawIdx } /* TypeInfo pointer occupies 8 bytes */
                let ti = unsafe { CPointer<CPointer<Unit>>(info).read() }
                TypeInfo.getOrCreate(ti)
        }
    }

    func buildSignature(name: String, params: ReadOnlyList<TypeInfo>): String {
        if (params.size == 0) {
            return name
        }
        let sb = StringBuilder()
        sb.append(name)
        sb.append("<")
        for (idx in 0..params.size) {
            sb.append(params[idx].qualifiedName)
            if (idx < params.size - 1) {
                sb.append(", ")
            }
        }
        sb.append(">")
        sb.toString()
    }
}

func getEnumSuperTypeInfo(ti: EnumTypeInfo): ?EnumTypeInfo {
    let superPointer = getSuperTypeInfo(ti._info)
    if (superPointer.isNull()) {
        return None
    }
    match (TypeInfo.getOrCreate(superPointer)) {
        case eti: EnumTypeInfo => return Some(eti)
        case _ => return None
    }
}

func parseConstructorName(raw: String): String {
    var name = raw
    if (let Some(idx) <- name.indexOf("<")) {
        name = name[..idx]
    }
    let dot = name.lastIndexOf(".") ?? -1
    name[dot + 1..]
}

func normalizeConstructorSignature(raw: String): String {
    raw.trimAscii().replace(" ", "")
}

func findLastTopLevelDot(name: String): Int64 {
    var angle = 0
    var idx: Int64 = name.size - 1
    while (idx >= 0) {
        match (name[idx]) {
            case '>' => angle++
            case '<' => angle--
            case '.' =>
                if (angle == 0) {
                    return idx
                }
            case _ => ()
        }
        idx -= 1
    }
    -1
}
