/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.reflect

import std.collection.*

public class GenericTypeInfo <: TypeInfo & Equatable<GenericTypeInfo> {
    public operator func ==(that: GenericTypeInfo): Bool {
        return this.name == that.name
    }
    init(cp: CPointer<Unit>) {
        super(cp)
    }
}

/**
 * Contains the reflective information about instance functions.
 */
public class InstanceFunctionInfo <: Equatable<InstanceFunctionInfo> & Hashable & ToString {
    let _info: CPointer<Unit>
    var _name: Option<String> = None
    var _parameters: Option<ArrayList<ParameterInfo>> = None
    var _returnType: Option<TypeInfo> = None
    var _modifiers: Option<Collection<ModifierInfo>> = None
    var _annotations: Option<Collection<Annotation>> = None
    var _genericParams: Option<Collection<GenericTypeInfo>> = None
    var _declaringTypeInfo: CPointer<Unit>
    init(cp: CPointer<Unit>, info: CPointer<Unit>) {
        _info = cp
        _declaringTypeInfo = info
    }

    public prop genericParams: Collection<GenericTypeInfo> {
        get() {
            match (_genericParams) {
                case Some(params) => params
                case None =>
                    let genericParametersNum = getNumOfGenericParameters(_info)
                    if (genericParametersNum == 0) {
                        _genericParams = Option<Collection<GenericTypeInfo>>.None
                        return ArrayList<GenericTypeInfo>()
                    }

                    let params = ArrayList<GenericTypeInfo>(
                        Int64(genericParametersNum),
                        {
                            index =>
                            let pointer = getGenericParameterInfo(_info, UInt32(index))
                            if (pointer.isNull()) {
                                throw InfoNotFoundException("Get parameters failed!")
                            }

                            GenericTypeInfo(pointer)
                        }
                    )

                    _genericParams = Some(params)
                    params
            }
        }
    }

    /**
     * Returns the name of instance function.
     */
    public prop name: String {
        get() {
            match (_name) {
                case Some(res) => res
                case None =>
                    let name = getFuncName(_info)
                    _name = name
                    name
            }
        }
    }

    /**
     * Returns the list of parameters of instance function.
     */
    public prop parameters: ReadOnlyList<ParameterInfo> {
        get() {
            match (_parameters) {
                case Some(res) => res
                case None =>
                    let infos = getParameters(_info)
                    _parameters = infos
                    infos
            }
        }
    }

    /**
     * Returns the return type of instance function.
     */
    public prop returnType: TypeInfo {
        get() {
            match (_returnType) {
                case Some(res) => res
                case None =>
                    let pointer = getMethodReturnType(_info)
                    let info = TypeInfo.getOrCreate(pointer)
                    _returnType = info
                    info
            }
        }
    }

    /**
     * Returns the collection of modifiers of instance function.
     */
    public prop modifiers: Collection<ModifierInfo> {
        get() {
            match (_modifiers) {
                case Some(res) => res
                case None =>
                    let infos = ModifierInfo.byMask(getMethodModifier(_info))
                    _modifiers = infos
                    infos
            }
        }
    }

    /**
     * Returns the collection of annotations of instance function.
     */
    public prop annotations: Collection<Annotation> {
        get() {
            match (_annotations) {
                case Some(res) => res
                case None =>
                    let infos = match (getMethodAnnotations(_info, TypeInfo.of<Array<Object>>()._info)) {
                        case arr: Array<Annotation> => arr
                        case _ => Array<Annotation>()
                    }
                    _annotations = infos
                    infos
            }
        }
    }

    /**
     * Returns true if instance function is 'public', false otherwise.
     */
    public func isOpen(): Bool {
        containsModifier(modifiers, ModifierInfo.Open)
    }

    /**
     * Returns true if instance function is 'abstract', false otherwise.
     */
    public func isAbstract(): Bool {
        containsModifier(modifiers, ModifierInfo.Abstract)
    }

    /**
     * Makes a call of public instance function with incoming args for incoming instance.
     *
     * @param args parameter list.
     *
     * @throw IllegalArgumentException, if the number of input parameters is different from the number of invoked function parameters.
     * @throw IllegalTypeException, if the input parameter type does not match the required parameter type.
     * @throw InvocationTargetException, if an exception is thrown when the function is abstract.
     */
    public func apply(instance: Any, args: Array<Any>): Any {
        let nullEntryPointer = methodEntryPointIsNull(_info)
        if (isAbstract() && nullEntryPointer) {
            throw InvocationTargetException("The abstract function cannot be applied.")
        }

        try {
            if (genericParams.size > 0) {
                throw InvocationTargetException("The generic function cannot be applied without `genericTypeArgs`.")
            }
        } catch (_: InfoNotFoundException) {
            throw InvocationTargetException("The generic function cannot be applied without `genericTypeArgs`.")
        }

        checkArgsSizeAndType(parameters, args)
        checkMethodDeclaringClassType(instance, _declaringTypeInfo)

        applyCJInstanceMethod(_info, instance, args)
    }

    public func apply(instance: Any, genericTypeArgs: Array<TypeInfo>, args: Array<Any>): Any {
        if (genericParams.size == 0) {
            throw InvocationTargetException("The function cannot be applied with `genericTypeArgs`.")
        }

        let nullEntryPointer = methodEntryPointIsNull(_info)
        if (isAbstract() && nullEntryPointer) {
            throw InvocationTargetException("The abstract function cannot be applied.")
        }

        checkParamaterSize(genericParams, parameters.size, genericTypeArgs, args)
        checkMethodDeclaringClassType(instance, _declaringTypeInfo)

        let gArgs = ArrayList<CPointer<Unit>>(Int64(genericTypeArgs.size)) {index => genericTypeArgs[index]._info}
        if (!checkMethodActualArgs(_info, gArgs.toArray(), args)) {
            throw IllegalTypeException(
                "The input parameter does not match the type of the input parameter required by the function.")
        }

        applyCJGenericInstanceMethod(_info, instance, gArgs.toArray(), args)
    }

    /**
     * Searches the instance function's annotation by incoming name.
     */
    public func findAnnotation<T>(): Option<T> where T <: Annotation {
        findAnnotation<T>(annotations)
    }

    public operator func ==(that: InstanceFunctionInfo): Bool {
        this._info == that._info
    }

    public operator func !=(that: InstanceFunctionInfo): Bool {
        !(this == that)
    }

    public func hashCode(): Int64 {
        this._info.toUIntNative().hashCode()
    }

    public func toString(): String {
        let sb = StringBuilder()
        for (m in modifiers) {
            sb.append(m)
            sb.append(" ")
        }
        sb.append("func ")
        sb.append(name)
        sb.append("(")
        for (index in 0..parameters.size) {
            sb.append(parameters[index])
            if (index < parameters.size - 1) {
                sb.append(", ")
            }
        }
        sb.append("): ")
        sb.append(returnType)
        sb.toString()
    }
}

/**
 * Contains the reflective information about static functions.
 */
public class StaticFunctionInfo <: Equatable<StaticFunctionInfo> & Hashable & ToString {
    let _info: CPointer<Unit>
    var _name: Option<String> = None
    var _parameters: Option<ArrayList<ParameterInfo>> = None
    var _genericParams: Option<Collection<GenericTypeInfo>> = None
    var _returnType: Option<TypeInfo> = None
    var _modifiers: Option<Collection<ModifierInfo>> = None
    var _annotations: Option<Collection<Annotation>> = None
    var _declaringTypeInfo: CPointer<Unit>
    init(cp: CPointer<Unit>, declaringTypeInfo: CPointer<Unit>) {
        _info = cp
        _declaringTypeInfo = declaringTypeInfo
    }

    public prop genericParams: Collection<GenericTypeInfo> {
        get() {
            match (_genericParams) {
                case Some(params) => params
                case None =>
                    let genericParametersNum = getNumOfGenericParameters(_info)
                    if (genericParametersNum == 0) {
                        _genericParams = Option<Collection<GenericTypeInfo>>.None
                        return ArrayList<GenericTypeInfo>()
                    }

                    let params = ArrayList<GenericTypeInfo>(
                        Int64(genericParametersNum),
                        {
                            index =>
                            let pointer = getGenericParameterInfo(_info, UInt32(index))
                            if (pointer.isNull()) {
                                throw InfoNotFoundException("Get parameters failed!")
                            }

                            GenericTypeInfo(pointer)
                        }
                    )

                    _genericParams = Some(params)
                    params
            }
        }
    }

    /**
     * Returns the name of static function.
     */
    public prop name: String {
        get() {
            match (_name) {
                case Some(res) => res
                case None =>
                    let name = getFuncName(_info)
                    _name = name
                    name
            }
        }
    }

    /**
     * Returns the list of parameters of static function.
     */
    public prop parameters: ReadOnlyList<ParameterInfo> {
        get() {
            match (_parameters) {
                case Some(res) => res
                case None =>
                    let infos = getParameters(_info)
                    _parameters = infos
                    infos
            }
        }
    }

    /**
     * Returns the return type of static function.
     */
    public prop returnType: TypeInfo {
        get() {
            match (_returnType) {
                case Some(res) => res
                case None =>
                    let pointer = getMethodReturnType(_info)
                    let info = TypeInfo.getOrCreate(pointer)
                    _returnType = info
                    info
            }
        }
    }

    /**
     * Returns the collection of modifiers of static function.
     */
    public prop modifiers: Collection<ModifierInfo> {
        get() {
            match (_modifiers) {
                case Some(res) => res
                case None =>
                    let infos = ModifierInfo.byMask(getMethodModifier(_info))
                    _modifiers = infos
                    infos
            }
        }
    }

    /**
     * Returns the collection of annotations of static function.
     */
    public prop annotations: Collection<Annotation> {
        get() {
            match (_annotations) {
                case Some(res) => res
                case None =>
                    let infos = match (getMethodAnnotations(_info, TypeInfo.of<Array<Object>>()._info)) {
                        case arr: Array<Annotation> => arr
                        case _ => Array<Annotation>()
                    }
                    _annotations = infos
                    infos
            }
        }
    }

    /**
     * Makes a call of static function with incoming args.
     *
     * @param args parameter list.
     *
     * @throw IllegalArgumentException, if the number of input parameters is different from the number of invoked function parameters.
     * @throw IllegalTypeException, if the input parameter type does not match the required parameter type.
     */
    public func apply(thisType: TypeInfo, args: Array<Any>): Any {
        try {
            if (genericParams.size > 0) {
                throw InvocationTargetException("The generic function cannot be applied without `genericTypeArgs`.")
            }
        } catch (_: InfoNotFoundException) {
            throw InvocationTargetException("The generic function cannot be applied without `genericTypeArgs`.")
        }

        if (methodEntryPointIsNull(_info)) {
            throw InfoNotFoundException("Failed to find the method entry.")
        }

        let name = TypeInfo.getOrCreate(_declaringTypeInfo).qualifiedName
        if (thisType.qualifiedName != name) {
            throw IllegalArgumentException("Wrong typeInfo, excepted ${thisType.qualifiedName} but ${name} got.")
        }

        checkArgsSizeAndType(parameters, args)
        applyCJStaticMethod(_info, args, thisType._info)
    }

    public func apply(thisType: TypeInfo, genericTypeArgs: Array<TypeInfo>, args: Array<Any>): Any {
        if (genericParams.size == 0) {
            throw InvocationTargetException("The function cannot be applied with `genericTypeArgs`.")
        }

        if (methodEntryPointIsNull(_info)) {
            throw InfoNotFoundException("Failed to find the method entry.")
        }

        let name = TypeInfo.getOrCreate(_declaringTypeInfo).qualifiedName
        if (thisType.qualifiedName != name) {
            throw IllegalArgumentException("Wrong typeInfo, excepted ${thisType.qualifiedName} but ${name} got.")
        }

        checkParamaterSize(genericParams, parameters.size, genericTypeArgs, args)

        let gArgs = ArrayList<CPointer<Unit>>(Int64(genericTypeArgs.size)) {index => genericTypeArgs[index]._info}
        if (!checkMethodActualArgs(_info, gArgs.toArray(), args)) {
            throw IllegalTypeException(
                "The input parameter does not match the type of the input parameter required by the function.")
        }

        applyCJGenericStaticMethod(_info, gArgs.toArray(), args, thisType._info)
    }

    /**
     * Searches the static function's annotation by incoming name.
     */
    public func findAnnotation<T>(): Option<T> where T <: Annotation {
        findAnnotation<T>(annotations)
    }

    public operator func ==(that: StaticFunctionInfo): Bool {
        this._info == that._info
    }

    public operator func !=(that: StaticFunctionInfo): Bool {
        !(this == that)
    }

    public func hashCode(): Int64 {
        this._info.toUIntNative().hashCode()
    }

    public func toString(): String {
        let sb = StringBuilder()
        for (m in modifiers) {
            sb.append(m)
            sb.append(" ")
        }
        sb.append("func ")
        sb.append(name)
        sb.append("(")
        for (index in 0..parameters.size) {
            sb.append(parameters[index])
            if (index < parameters.size - 1) {
                sb.append(", ")
            }
        }
        sb.append("): ")
        sb.append(returnType)
        sb.toString()
    }
}

/**
 * Contains the reflective information about instance properties.
 */
public class InstancePropertyInfo <: Equatable<InstancePropertyInfo> & Hashable & ToString {
    let _name: String
    // must have value
    var _getterInfo: Option<InstanceFunctionInfo> = None
    var _setterInfo: Option<InstanceFunctionInfo> = None
    var _typeInfo: Option<TypeInfo> = None
    var _modifiers: Option<Collection<ModifierInfo>> = None
    var _annotations: Option<Collection<Annotation>> = None
    var _declaringTypeInfo: CPointer<Unit>

    init(name: String, declaringTypeInfo: CPointer<Unit>) {
        _name = name
        _declaringTypeInfo = declaringTypeInfo
    }

    /**
     * Returns the name of instance property.
     */
    public prop name: String {
        get() {
            _name
        }
    }

    /**
     * Returns the return type of instance property.
     */
    public prop typeInfo: TypeInfo {
        get() {
            match (_typeInfo) {
                case Some(res) => res
                case None =>
                    _typeInfo = _getterInfo?.returnType
                    _typeInfo.getOrThrow()
            }
        }
    }

    /**
     * Returns the collection of modifiers of instance property.
     */
    public prop modifiers: Collection<ModifierInfo> {
        get() {
            match (_modifiers) {
                case Some(res) => res
                case None =>
                    let infos = if (isMutable()) {
                        let array = ArrayList<ModifierInfo>((_getterInfo?.modifiers).getOrThrow())
                        array.add(ModifierInfo.Mut)
                        array.toArray()
                    } else {
                        (_getterInfo?.modifiers).getOrThrow()
                    }
                    _modifiers = infos
                    infos
            }
        }
    }

    /**
     * Returns the collection of annotations of instance property.
     */
    public prop annotations: Collection<Annotation> {
        get() {
            match (_annotations) {
                case Some(res) => res
                case None =>
                    let infos = match (getMethodAnnotations(_getterInfo.getOrThrow()._info,
                        TypeInfo.of<Array<Object>>()._info)) {
                        case arr: Array<Annotation> => arr
                        case _ => Array<Annotation>()
                    }
                    _annotations = infos
                    infos
            }
        }
    }

    /**
     * Returns true if instance property is 'public', false otherwise.
     */
    public func isOpen(): Bool {
        containsModifier(modifiers, ModifierInfo.Open)
    }

    /**
     * Returns true if instance property is 'abstract', false otherwise.
     */
    public func isAbstract(): Bool {
        containsModifier(modifiers, ModifierInfo.Abstract)
    }

    /**
     * Returns true if instance property is 'mut' and typeInfo is not struct
     */
    public func isMutable(): Bool {
        _setterInfo.isSome() && !(typeInfo is StructTypeInfo)
    }

    /**
     * Returns the instance property's value for incoming instance.
     */
    public func getValue(instance: Any): Any {
        if (isAbstract()) {
            throw UnsupportedException("abstract prop cannot get value")
        }
        // instance type is checked in apply
        match (_getterInfo) {
            case Some(v) => v.apply(instance, Array<Any>())
            case None => throw InfoNotFoundException("setter not found for prop '${name}'")
        }
    }

    /**
     * Updates the instance property's value with incoming new value for incoming instance.
     */
    public func setValue(instance: Any, newValue: Any): Unit {
        if (isAbstract()) {
            throw IllegalSetException("Attempt to modify abstract variable '${name}'")
        }
        if (!isMutable()) {
            throw IllegalSetException("Attempt to modify immutable property '${name}'")
        }

        // instance type is checked in apply
        match (_setterInfo) {
            case Some(v) => v.apply(instance, Array<Any>(1, repeat: newValue))
            case None => throw IllegalSetException("Attempt to modify immutable property '${name}'")
        }
    }

    /**
     * Searches the instance property's annotation by incoming name.
     */
    public func findAnnotation<T>(): Option<T> where T <: Annotation {
        findAnnotation<T>(annotations)
    }

    public operator func ==(that: InstancePropertyInfo): Bool {
        this._getterInfo.getOrThrow()._info == that._getterInfo.getOrThrow()._info
    }

    public operator func !=(that: InstancePropertyInfo): Bool {
        !(this == that)
    }

    public func hashCode(): Int64 {
        this._getterInfo.getOrThrow()._info.toUIntNative().hashCode()
    }

    public func toString(): String {
        let sb = StringBuilder()
        for (m in modifiers) {
            sb.append(m)
            sb.append(" ")
        }
        sb.append("prop ")
        sb.append(name)
        sb.append(": ")
        sb.append(typeInfo)
        sb.toString()
    }

    func setFunc(isGetter: Bool, pointer: CPointer<Unit>) {
        if (isGetter) {
            _getterInfo = InstanceFunctionInfo(pointer, _declaringTypeInfo)
        } else {
            _setterInfo = InstanceFunctionInfo(pointer, _declaringTypeInfo)
        }
    }
}

/**
 * Contains the reflective information about static properties.
 */
public class StaticPropertyInfo <: Equatable<StaticPropertyInfo> & Hashable & ToString {
    let _name: String
    // must have value
    var _getterInfo: Option<StaticFunctionInfo> = None
    var _setterInfo: Option<StaticFunctionInfo> = None
    var _typeInfo: Option<TypeInfo> = None
    var _modifiers: Option<Collection<ModifierInfo>> = None
    var _annotations: Option<Collection<Annotation>> = None
    var _declaringTypeInfo: CPointer<Unit>
    init(name: String, declaringTypeInfo: CPointer<Unit>) {
        _name = name
        _declaringTypeInfo = declaringTypeInfo
    }

    /**
     * Returns the name of static property.
     */
    public prop name: String {
        get() {
            _name
        }
    }

    /**
     * Returns the return type of static property.
     */
    public prop typeInfo: TypeInfo {
        get() {
            match (_typeInfo) {
                case Some(res) => res
                case None =>
                    _typeInfo = _getterInfo?.returnType
                    _typeInfo.getOrThrow()
            }
        }
    }

    /**
     * Returns the collection of modifiers of static property.
     */
    public prop modifiers: Collection<ModifierInfo> {
        get() {
            match (_modifiers) {
                case Some(res) => res
                case None =>
                    let infos = if (isMutable()) {
                        let array = ArrayList<ModifierInfo>((_getterInfo?.modifiers).getOrThrow())
                        array.add(ModifierInfo.Mut)
                        array.toArray()
                    } else {
                        (_getterInfo?.modifiers).getOrThrow()
                    }
                    _modifiers = infos
                    infos
            }
        }
    }

    /**
     * Returns the collection of annotations of static property.
     */
    public prop annotations: Collection<Annotation> {
        get() {
            match (_annotations) {
                case Some(res) => res
                case None =>
                    let infos = match (getMethodAnnotations(_getterInfo.getOrThrow()._info,
                        TypeInfo.of<Array<Object>>()._info)) {
                        case arr: Array<Annotation> => arr
                        case _ => Array<Annotation>()
                    }
                    _annotations = infos
                    infos
            }
        }
    }

    /**
     * Returns true if static property is 'mut' and typeInfo is not struct
     */
    public func isMutable(): Bool {
        _setterInfo.isSome() && !(typeInfo is StructTypeInfo)
    }

    /**
     * Returns the instance property's value for incoming instance.
     */
    public func getValue(): Any {
        match (_getterInfo) {
            case Some(v) => v.apply(TypeInfo.getOrCreate(_declaringTypeInfo), Array<Any>())
            case None => throw InfoNotFoundException("setter not found for prop '${name}'")
        }
    }

    /**
     * Updates the instance property's value with incoming new value for incoming instance.
     */
    public func setValue(newValue: Any): Unit {
        if (!isMutable()) {
            throw IllegalSetException("Attempt to modify immutable property '${name}'")
        }
        match (_setterInfo) {
            case Some(v) => v.apply(TypeInfo.getOrCreate(_declaringTypeInfo), Array<Any>(1, repeat: newValue))
            case None => throw IllegalSetException("Attempt to modify immutable property '${name}'")
        }
    }

    /**
     * Searches the static property's annotation by incoming name.
     */
    public func findAnnotation<T>(): Option<T> where T <: Annotation {
        findAnnotation<T>(annotations)
    }

    public operator func ==(that: StaticPropertyInfo): Bool {
        this._getterInfo.getOrThrow()._info == that._getterInfo.getOrThrow()._info
    }

    public operator func !=(that: StaticPropertyInfo): Bool {
        !(this == that)
    }

    public func hashCode(): Int64 {
        this._getterInfo.getOrThrow()._info.toUIntNative().hashCode()
    }

    public func toString(): String {
        let sb = StringBuilder()
        for (m in modifiers) {
            sb.append(m)
            sb.append(" ")
        }
        sb.append("prop ")
        sb.append(name)
        sb.append(": ")
        sb.append(typeInfo)
        sb.toString()
    }

    func setFunc(isGetter: Bool, pointer: CPointer<Unit>) {
        if (isGetter) {
            _getterInfo = StaticFunctionInfo(pointer, _declaringTypeInfo)
        } else {
            _setterInfo = StaticFunctionInfo(pointer, _declaringTypeInfo)
        }
    }
}

/**
 * Contains the reflective information about constructors.
 */
public class ConstructorInfo <: Equatable<ConstructorInfo> & Hashable & ToString {
    let _info: CPointer<Unit>
    var _parameters: Option<ArrayList<ParameterInfo>> = None
    var _annotations: Option<Collection<Annotation>> = None
    private var _isAbstract: Option<Bool> = None
    var _declaringTypeInfo: CPointer<Unit>
    init(infoPointer: CPointer<Unit>, declaringTypeInfo: CPointer<Unit>) {
        _info = infoPointer
        _declaringTypeInfo = declaringTypeInfo
    }

    /**
     * Returns the list of parameters of constructor.
     */
    public prop parameters: ReadOnlyList<ParameterInfo> {
        get() {
            match (_parameters) {
                case Some(res) => res
                case None =>
                    let infos = getParameters(_info)
                    _parameters = infos
                    infos
            }
        }
    }

    /**
     * Returns the collection of annotations of constructor.
     */
    public prop annotations: Collection<Annotation> {
        get() {
            match (_annotations) {
                case Some(res) => res
                case None =>
                    let infos = match (getMethodAnnotations(_info, TypeInfo.of<Array<Object>>()._info)) {
                        case arr: Array<Annotation> => arr
                        case _ => Array<Annotation>()
                    }
                    _annotations = infos
                    infos
            }
        }
    }

    private prop isAbstract: Bool {
        get() {
            match (_isAbstract) {
                case Some(res) => res
                case None =>
                    let isDeclaringClassAbstract = ModifierInfo.isAbstract(getMethodModifier(_info)) ||
                        ModifierInfo.isAbstract(getTypeInfoModifier(_declaringTypeInfo))

                    _isAbstract = isDeclaringClassAbstract
                    isDeclaringClassAbstract
            }
        }
    }

    /**
     * Makes a call of constructor with incoming args.
     *
     * @param args parameter list.
     *
     * @throw IllegalArgumentException, if the number of input parameters is different from the number of invoked function parameters.
     * @throw IllegalTypeException, if the input parameter type does not match the required parameter type.
     * @throw InvocationTargetException, if the constructor is abstract
     */
    public func apply(args: Array<Any>): Any {
        let nullEntryPointer = methodEntryPointIsNull(_info)
        if (isAbstract || nullEntryPointer) {
            throw InvocationTargetException("Abstract constructor cannot apply.")
        }

        checkArgsSizeAndType(parameters, args)
        applyCJStaticMethod(_info, args, CPointer<Unit>())
    }

    /**
     * Searches the constructor's annotation by incoming name.
     */
    public func findAnnotation<T>(): Option<T> where T <: Annotation {
        findAnnotation<T>(annotations)
    }

    public operator func ==(that: ConstructorInfo): Bool {
        this._info == that._info
    }

    public operator func !=(that: ConstructorInfo): Bool {
        !(this == that)
    }

    public func hashCode(): Int64 {
        this._info.toUIntNative().hashCode()
    }

    public func toString(): String {
        let sb = StringBuilder(constructorName)
        sb.append("(")
        for (index in 0..parameters.size) {
            sb.append(parameters[index])
            if (index < parameters.size - 1) {
                sb.append(", ")
            }
        }
        sb.append(")")
        sb.toString()
    }
}

/**
 * Contains the reflective information about global functions.
 */
public class GlobalFunctionInfo <: Equatable<GlobalFunctionInfo> & Hashable & ToString {
    let _info: CPointer<Unit>
    var _name: ?String = None
    var _parameters: Option<ArrayList<ParameterInfo>> = None
    var _genericParams = Option<Collection<GenericTypeInfo>>.None
    var _returnType: Option<TypeInfo> = None
    var _annotations: Option<Collection<Annotation>> = None

    init(cp: CPointer<Unit>) {
        _info = cp
    }

    public prop genericParams: Collection<GenericTypeInfo> {
        get() {
            match (_genericParams) {
                case Some(params) => params
                case None =>
                    let genericParametersNum = getNumOfGenericParameters(_info)
                    if (genericParametersNum == 0) {
                        _genericParams = Option<Collection<GenericTypeInfo>>.None
                        return ArrayList<GenericTypeInfo>()
                    }
                    let params = ArrayList<GenericTypeInfo>(
                        Int64(genericParametersNum),
                        {
                            index =>
                            let pointer = getGenericParameterInfo(_info, UInt32(index))
                            if (pointer.isNull()) {
                                throw InfoNotFoundException("Get parameters failed!")
                            }
                            GenericTypeInfo(pointer)
                        }
                    )
                    _genericParams = Some(params)
                    params
            }
        }
    }

    // Function name, overloaded functions have the same function name
    public prop name: String {
        get() {
            match (_name) {
                case Some(res) => res
                case None =>
                    let name = getFuncName(_info)
                    _name = name
                    name
            }
        }
    }

    /**
     * Returns the list of parameters of global function.
     */
    public prop parameters: ReadOnlyList<ParameterInfo> {
        get() {
            match (_parameters) {
                case Some(res) => res
                case None =>
                    let infos = getParameters(_info)
                    _parameters = infos
                    infos
            }
        }
    }

    /**
     * Returns the return type of global function.
     */
    public prop returnType: TypeInfo {
        get() {
            match (_returnType) {
                case Some(res) => res
                case None =>
                    let pointer = getMethodReturnType(_info)
                    let info = TypeInfo.getOrCreate(pointer)
                    _returnType = info
                    info
            }
        }
    }

    // Annotation, when there is no data, size is 0. Note that this api does not guarantee a constant traversal order.
    public prop annotations: Collection<Annotation> {
        get() {
            match (_annotations) {
                case Some(res) => res
                case None =>
                    let infos = match (getMethodAnnotations(_info, TypeInfo.of<Array<Object>>()._info)) {
                        case arr: Array<Annotation> => arr
                        case _ => Array<Annotation>()
                    }
                    _annotations = infos
                    infos
            }
        }
    }

    /**
     * Makes a call of global function with incoming args.
     *
     * @param args parameter list.
     *
     * @throw IllegalArgumentException, if the number of input parameters is different from the number of invoked function parameters.
     * @throw IllegalTypeException, if the input parameter type does not match the required parameter type.
     * @throw InvocationTargetException, if then generic parameter check failed.
     */
    public func apply(args: Array<Any>): Any {
        try {
            if (genericParams.size > 0) {
                throw InvocationTargetException("The generic function cannot be applied without `genericTypeArgs`.")
            }
        } catch (_: InfoNotFoundException) {
            throw InvocationTargetException("The generic function cannot be applied without `genericTypeArgs`.")
        }

        checkArgsSizeAndType(parameters, args)
        applyCJStaticMethod(_info, args, CPointer<Unit>())
    }

    public func apply(genericTypeArgs: Array<TypeInfo>, args: Array<Any>): Any {
        if (genericParams.size == 0) {
            throw InvocationTargetException("The function cannot be applied with `genericTypeArgs`.")
        }

        checkParamaterSize(genericParams, parameters.size, genericTypeArgs, args)

        let gArgs = ArrayList<CPointer<Unit>>(Int64(genericTypeArgs.size)) {index => genericTypeArgs[index]._info}
        if (!checkMethodActualArgs(_info, gArgs.toArray(), args)) {
            throw IllegalTypeException(
                "The input parameter does not match the type of the input parameter required by the function.")
        }

        applyCJGenericStaticMethod(_info, gArgs.toArray(), args, CPointer<Unit>())
    }

    // Get the annotation by name, return None if not found
    public func findAnnotation<T>(): Option<T> where T <: Annotation {
        findAnnotation<T>(annotations)
    }

    public operator func ==(that: GlobalFunctionInfo): Bool {
        this._info == that._info
    }

    public operator func !=(that: GlobalFunctionInfo): Bool {
        !(this == that)
    }

    public func hashCode(): Int64 {
        this._info.toUIntNative().hashCode()
    }

    public func toString(): String {
        let sb = StringBuilder()
        sb.append("func ")
        sb.append(name)
        sb.append("(")
        for (index in 0..parameters.size) {
            sb.append(parameters[index])
            if (index < parameters.size - 1) {
                sb.append(", ")
            }
        }
        sb.append("): ")
        sb.append(returnType)
        sb.toString()
    }
}

func getFuncName(parentPointer: CPointer<Unit>): String {
    let pointer = getMethodName(parentPointer)
    if (pointer.isNull()) {
        throw InfoNotFoundException("get function name failed!")
    }
    CString(pointer).toString()
}

func getParameters(cp: CPointer<Unit>): ArrayList<ParameterInfo> {
    let actualParametersNum = getNumOfActualParameters(cp)
    ArrayList<ParameterInfo>(
        Int64(actualParametersNum),
        {
            index =>
            let pointer = getActualParameterInfo(cp, UInt32(index))
            if (pointer.isNull()) {
                throw InfoNotFoundException("Get parameters failed!")
            }
            ParameterInfo(pointer)
        }
    )
}

func checkMethodDeclaringClassType(instance: Any, declaringTypeInfo: CPointer<Unit>): Unit {
    let declaringClassTypeInfo = TypeInfo.getOrCreate(declaringTypeInfo)
    let instanceTypeInfo = TypeInfo.of(instance)
    if (declaringClassTypeInfo != instanceTypeInfo) {
        throw IllegalTypeException(
            "The input instance should be \"${declaringClassTypeInfo}\", but now it`s \"${instanceTypeInfo}\"")
    }
}

func checkParamaterSize(genericParams: Collection<GenericTypeInfo>, actualParamSize: Int64,
    genericTypeParameters: Collection<TypeInfo>, args: Array<Any>): Unit {
    if (genericTypeParameters.size != genericParams.size) {
        throw IllegalArgumentException("The input generic parameter item does not comply with the required quantity.")
    }

    if (args.size != actualParamSize) {
        throw IllegalArgumentException("The input parameter item does not comply with the required quantity.")
    }
}
