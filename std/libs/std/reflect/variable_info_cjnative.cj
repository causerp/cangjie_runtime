/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.reflect

/**
 * Contains the reflective information about instance variables.
 */
public class InstanceVariableInfo <: Equatable<InstanceVariableInfo> & Hashable & ToString {
    let _info: CPointer<Unit>
    // variable of struct cannot setValue
    let _isStruct: Bool
    var _mutable: Option<Bool> = None
    var _name: Option<String> = None
    var _typeInfo: Option<TypeInfo> = None
    var _modifiers: Option<Collection<ModifierInfo>> = None
    var _annotations: Option<Collection<Annotation>> = None
    var _declaringTypeInfo: CPointer<Unit>

    init(cp: CPointer<Unit>, declaringTypeInfo: CPointer<Unit>, isStruct!: Bool = false) {
        _info = cp
        _declaringTypeInfo = declaringTypeInfo
        _isStruct = isStruct
    }

    /**
     * Returns the name of instance variable.
     */
    public prop name: String {
        get() {
            match (_name) {
                case Some(res) => res
                case None =>
                    let pointer = getInstanceFieldName(_info, _declaringTypeInfo)
                    if (pointer.isNull()) {
                        throw IllegalStateException("getFieldName Null Pointer!")
                    }
                    let variableName = CString(pointer).toString()
                    _name = variableName
                    variableName
            }
        }
    }

    /**
     * Returns the return type of instance variable.
     */
    public prop typeInfo: TypeInfo {
        get() {
            match (_typeInfo) {
                case Some(res) => res
                case None =>
                    let pointer = getInstanceFieldType(_info, _declaringTypeInfo)
                    let ti = TypeInfo.getOrCreate(pointer)
                    _typeInfo = ti
                    ti
            }
        }
    }

    /**
     * Returns the collection of modifiers of instance variable.
     */
    public prop modifiers: Collection<ModifierInfo> {
        get() {
            match (_modifiers) {
                case Some(res) => res
                case None =>
                    let infos = ModifierInfo.byMask(getInstanceFieldModifier(_info))
                    _modifiers = infos
                    infos
            }
        }
    }

    /**
     * Returns the collection of annotations of instance variable.
     */
    public prop annotations: Collection<Annotation> {
        get() {
            match (_annotations) {
                case Some(res) => res
                case None =>
                    let infos = match (getInstanceFieldAnnotations(_info, TypeInfo.of<Array<Object>>()._info)) {
                        case arr: Array<Annotation> => arr
                        case _ => Array<Annotation>()
                    }
                    _annotations = infos
                    infos
            }
        }
    }

    /**
     * Returns true if instance variable is 'mut' and typeInfo is not struct
     */
    public func isMutable(): Bool {
        match (_mutable) {
            case Some(res) => res
            case None =>
                let mutable = ModifierInfo.isMutable(getInstanceFieldModifier(_info)) && !(typeInfo is StructTypeInfo) &&
                    !(getFieldDeclaringClassType(_declaringTypeInfo) is StructTypeInfo)
                _mutable = mutable
                mutable
        }
    }

    /**
     * Returns the instance variable's value for incoming instance.
     *
     * @throw IllegalTypeException, if the input instance type is different from the instance which this InstanceVariableInfo belong to.
     */
    public func getValue(instance: Any): Any {
        checkDeclaringClassType(instance)
        getInstanceFieldValue(_info, _declaringTypeInfo, instance)
    }

    /**
     * Updates the instance variable's value with incoming new value for incoming instance.
     *
     * @param instance which the member variable belongs.
     * @param newValue new value to set.
     *
     * @throw IllegalSetException, if the instance variable is immutable.
     * @throw IllegalTypeException, if the input newValue type is different from the instance variable type.
     * @throw UnsupportedException, if this variable is struct
     * @throw IllegalTypeException, if the input instance type is different from the instance which this InstanceVariableInfo belong to.
     */
    public func setValue(instance: Any, newValue: Any): Unit {
        if (!this.isMutable()) {
            throw IllegalSetException("Attempt to modify immutable variable '${name}'.")
        }
        if (_isStruct) {
            throw IllegalSetException("Attempt to modify immutable variable '${name}'.")
        }
        checkDeclaringClassType(instance)
        checkValueType(newValue, typeInfo)
        setInstanceFieldValue(_info, _declaringTypeInfo, instance, newValue)
    }

    func checkDeclaringClassType(instance: Any): Unit {
        let declaringClassTypeInfo = getFieldDeclaringClassType(_declaringTypeInfo)
        let instanceTypeInfo = TypeInfo.of(instance)
        if (declaringClassTypeInfo != instanceTypeInfo) {
            throw IllegalTypeException(
                "The input instance should be \"${declaringClassTypeInfo}\", but now it`s \"${instanceTypeInfo}\"")
        }
    }

    /**
     * Searches the instance variable's annotation by incoming name.
     */
    public func findAnnotation<T>(): Option<T> where T <: Annotation {
        findAnnotation<T>(annotations)
    }

    public operator func ==(that: InstanceVariableInfo): Bool {
        this._info == that._info
    }

    public operator func !=(that: InstanceVariableInfo): Bool {
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
        sb.append(name)
        sb.append(": ")
        sb.append(typeInfo)
        sb.toString()
    }
}

/**
 * Contains the reflective information about static variables.
 */
public class StaticVariableInfo <: Equatable<StaticVariableInfo> & Hashable & ToString {
    let _info: CPointer<Unit>
    // variable of struct cannot setValue
    let _isStruct: Bool
    var _mutable: Option<Bool> = None
    var _name: Option<String> = None
    var _typeInfo: Option<TypeInfo> = None
    var _modifiers: Option<Collection<ModifierInfo>> = None
    var _annotations: Option<Collection<Annotation>> = None
    var _declaringTypeInfo: CPointer<Unit>

    init(cp: CPointer<Unit>, declaringTypeInfo: CPointer<Unit>) {
        _info = cp
        _isStruct = getFieldDeclaringClassType(declaringTypeInfo) is StructTypeInfo
        _declaringTypeInfo = declaringTypeInfo
    }

    /**
     * Returns the name of static variable.
     */
    public prop name: String {
        get() {
            match (_name) {
                case Some(res) => res
                case None =>
                    let pointer = getStaticFieldName(_info)
                    if (pointer.isNull()) {
                        throw IllegalStateException("GetStaticFieldName failed: null pointer!")
                    }
                    let variableName = CString(pointer).toString()
                    _name = variableName
                    variableName
            }
        }
    }

    /**
     * Returns the return type of static variable.
     */
    public prop typeInfo: TypeInfo {
        get() {
            match (_typeInfo) {
                case Some(res) => res
                case None =>
                    let pointer = getStaticFieldType(_info)
                    let ti = TypeInfo.getOrCreate(pointer)
                    _typeInfo = ti
                    ti
            }
        }
    }

    /**
     * Returns the collection of modifiers of static variable.
     */
    public prop modifiers: Collection<ModifierInfo> {
        get() {
            match (_modifiers) {
                case Some(res) => res
                case None =>
                    let infos = ModifierInfo.byMask(getStaticFieldModifier(_info))
                    _modifiers = infos
                    infos
            }
        }
    }

    /**
     * Returns the collection of annotations of static variable.
     */
    public prop annotations: Collection<Annotation> {
        get() {
            match (_annotations) {
                case Some(res) => res
                case None =>
                    let infos = match (getStaticFieldAnnotations(_info, TypeInfo.of<Array<Object>>()._info)) {
                        case arr: Array<Annotation> => arr
                        case _ => Array<Annotation>()
                    }
                    _annotations = infos
                    infos
            }
        }
    }

    /**
     * Returns true if static variable is 'mut' and typeInfo is not struct
     */
    public func isMutable(): Bool {
        match (_mutable) {
            case Some(res) => res
            case None =>
                let mutable = ModifierInfo.isMutable(getStaticFieldModifier(_info)) && !(typeInfo is StructTypeInfo) &&
                    !(getFieldDeclaringClassType(_declaringTypeInfo) is StructTypeInfo)
                _mutable = mutable
                mutable
        }
    }

    /**
     * Returns the static variable's value.
     */
    public func getValue(): Any {
        getStaticFieldValue(_info)
    }

    /**
     * Updates the static variable's value with incoming new value.
     *
     * @param newValue new value to set.
     *
     * @throw IllegalSetException, if the static variable is immutable.
     * @throw UnsupportedException, if this variable is struct
     * @throw IllegalTypeException, if the input newValue type is different from the static variable type.
     */
    public func setValue(newValue: Any): Unit {
        if (!isMutable()) {
            throw IllegalSetException("Attempt to modify immutable variable '${name}'.")
        }
        if (_isStruct) {
            throw UnsupportedException("Attempt to modify immutable variable '${name}'.")
        }
        checkValueType(newValue, typeInfo)
        setStaticFieldValue(_info, newValue)
    }

    /**
     * Searches the static variable's annotation by incoming name.
     */
    public func findAnnotation<T>(): Option<T> where T <: Annotation {
        findAnnotation<T>(annotations)
    }

    public operator func ==(that: StaticVariableInfo): Bool {
        this._info == that._info
    }

    public operator func !=(that: StaticVariableInfo): Bool {
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
        sb.append(name)
        sb.append(": ")
        sb.append(typeInfo)
        sb.toString()
    }
}

/**
 * Contains the reflective information about global variables.
 */
public class GlobalVariableInfo <: Equatable<GlobalVariableInfo> & Hashable & ToString {
    let _info: CPointer<Unit>
    var _mutable: Option<Bool> = None
    var _name: Option<String> = None
    var _typeInfo: Option<TypeInfo> = None
    var _annotations: Option<Collection<Annotation>> = None

    init(cp: CPointer<Unit>) {
        _info = cp
    }

    /**
     * Returns the name of global variable.
     */
    public prop name: String {
        get() {
            match (_name) {
                case Some(res) => res
                case None =>
                    let pointer = getStaticFieldName(_info)
                    if (pointer.isNull()) {
                        throw IllegalStateException("getFieldName Null Pointer!")
                    }
                    let variableName = CString(pointer).toString()
                    _name = variableName
                    variableName
            }
        }
    }

    // variable type
    public prop typeInfo: TypeInfo {
        get() {
            match (_typeInfo) {
                case Some(res) => res
                case None =>
                    let pointer = getStaticFieldType(_info)
                    let ti = TypeInfo.getOrCreate(pointer)
                    _typeInfo = ti
                    ti
            }
        }
    }

    // Annotation, when there is no data, size is 0. Note that this api does not guarantee a constant traversal order.
    public prop annotations: Collection<Annotation> {
        get() {
            match (_annotations) {
                case Some(res) => res
                case None =>
                    let infos = match (getStaticFieldAnnotations(_info, TypeInfo.of<Array<Object>>()._info)) {
                        case arr: Array<Annotation> => arr
                        case _ => Array<Annotation>()
                    }
                    _annotations = infos
                    infos
            }
        }
    }

    // Whether it is a variable modified by var and typeInfo is not struct. Calling setValue on a variable modified by let will throw an exception.
    public func isMutable(): Bool {
        match (_mutable) {
            case Some(res) => res
            case None =>
                let mutable = ModifierInfo.isMutable(getStaticFieldModifier(_info)) && !(typeInfo is StructTypeInfo)
                _mutable = mutable
                mutable
        }
    }

    // get variable value
    public func getValue(): Any {
        getStaticFieldValue(_info)
    }

    /**
     * Updates the global variable's value with incoming new value.
     *
     * @param newValue new value to set.
     *
     * @throw IllegalSetException, if the global variable is immutable.
     * @throw IllegalTypeException, if the input newValue type is different from the global variable type.
     */
    public func setValue(newValue: Any): Unit {
        if (!isMutable()) {
            throw IllegalSetException("Attempt to modify immutable variable '${name}'.")
        }
        checkValueType(newValue, typeInfo)
        setStaticFieldValue(_info, newValue)
    }

    /**
     * Searches the global variable's annotation by incoming name.
     */
    public func findAnnotation<T>(): Option<T> where T <: Annotation {
        findAnnotation<T>(annotations)
    }

    public operator func ==(that: GlobalVariableInfo): Bool {
        this._info == that._info
    }

    public operator func !=(that: GlobalVariableInfo): Bool {
        !(this == that)
    }

    public func hashCode(): Int64 {
        this._info.toUIntNative().hashCode()
    }

    public func toString(): String {
        let sb = StringBuilder()
        sb.append(name)
        sb.append(": ")
        sb.append(typeInfo)
        sb.toString()
    }
}

func getFieldDeclaringClassType(declaringTypeInfo: CPointer<Unit>): TypeInfo {
    TypeInfo.getOrCreate(declaringTypeInfo)
}
