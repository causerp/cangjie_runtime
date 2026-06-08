/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.reflect

func getInstanceFieldNameString(info: CPointer<Unit>, declaringTypeInfo: CPointer<Unit>): String {
    let pointer = getInstanceFieldName(info, declaringTypeInfo)
    if (pointer.isNull()) {
        throw IllegalStateException("getFieldName Null Pointer!")
    }
    CString(pointer).toString()
}

func getStaticFieldNameString(info: CPointer<Unit>, message: String): String {
    let pointer = getStaticFieldName(info)
    if (pointer.isNull()) {
        throw IllegalStateException(message)
    }
    CString(pointer).toString()
}

func getInstanceFieldTypeInfo(info: CPointer<Unit>, declaringTypeInfo: CPointer<Unit>): TypeInfo {
    TypeInfo.getOrCreate(getInstanceFieldType(info, declaringTypeInfo))
}

func getStaticFieldTypeInfo(info: CPointer<Unit>): TypeInfo {
    TypeInfo.getOrCreate(getStaticFieldType(info))
}

func getInstanceFieldAnnotationInfos(info: CPointer<Unit>): Collection<Annotation> {
    match (getInstanceFieldAnnotations(info, TypeInfo.of<Array<Object>>()._info)) {
        case arr: Array<Annotation> => arr
        case _ => Array<Annotation>()
    }
}

func getStaticFieldAnnotationInfos(info: CPointer<Unit>): Collection<Annotation> {
    match (getStaticFieldAnnotations(info, TypeInfo.of<Array<Object>>()._info)) {
        case arr: Array<Annotation> => arr
        case _ => Array<Annotation>()
    }
}

/**
 * Contains the reflective information about instance variables.
 */
public class InstanceVariableInfo <: Equatable<InstanceVariableInfo> & Hashable & ToString {
    let _info: CPointer<Unit>
    let _isStruct: Bool // reserve for abi compatible
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
            getCachedReflectInfo(_name, {=> getInstanceFieldNameString(_info, _declaringTypeInfo)}) {
                variableName: String => _name = variableName
            }
        }
    }

    /**
     * Returns the return type of instance variable.
     */
    public prop typeInfo: TypeInfo {
        get() {
            getCachedReflectInfo(_typeInfo, {=> getInstanceFieldTypeInfo(_info, _declaringTypeInfo)}) {
                ti: TypeInfo => _typeInfo = ti
            }
        }
    }

    /**
     * Returns the collection of modifiers of instance variable.
     */
    public prop modifiers: Collection<ModifierInfo> {
        get() {
            getCachedReflectInfo(_modifiers, {=> ModifierInfo.byMask(getInstanceFieldModifier(_info))}) {
                infos: Collection<ModifierInfo> => _modifiers = infos
            }
        }
    }

    /**
     * Returns the collection of annotations of instance variable.
     */
    public prop annotations: Collection<Annotation> {
        get() {
            getCachedReflectInfo(_annotations, {=> getInstanceFieldAnnotationInfos(_info)}) {
                infos: Collection<Annotation> => _annotations = infos
            }
        }
    }

    /**
     * Returns true if instance variable is 'mut'
     */
    public func isMutable(): Bool {
        getCachedReflectInfo(_mutable, {=> ModifierInfo.isMutable(getInstanceFieldModifier(_info))}) {
            mutable: Bool => _mutable = mutable
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
     * @throw IllegalTypeException, if the input instance type is different from the instance which this InstanceVariableInfo belong to.
     */
    public func setValue(instance: Any, newValue: Any): Unit {
        if (!this.isMutable()) {
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
    public func findAnnotation<T>(): ?T where T <: Annotation {
        findAnnotation<T>(annotations)
    }

    public func findAllAnnotations<T>(): Array<T> where T <: Annotation {
        findAllAnnotations<T>(annotations)
    }

    public func getAllAnnotations(): Array<Annotation> {
        annotations.toArray()
    }

    public operator func ==(other: InstanceVariableInfo): Bool {
        this._info == other._info
    }

    public operator func !=(other: InstanceVariableInfo): Bool {
        !(this == other)
    }

    public func hashCode(): Int64 {
        this._info.toUIntNative().hashCode()
    }

    public func toString(): String {
        variableToString(modifiers, name, typeInfo)
    }
}

/**
 * Contains the reflective information about static variables.
 */
public class StaticVariableInfo <: Equatable<StaticVariableInfo> & Hashable & ToString {
    let _info: CPointer<Unit>
    let _isStruct: Bool // reserve for abi compatible
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
            getCachedReflectInfo(_name, {=> getStaticFieldNameString(_info, "GetStaticFieldName failed: null pointer!")}) {
                variableName: String => _name = variableName
            }
        }
    }

    /**
     * Returns the return type of static variable.
     */
    public prop typeInfo: TypeInfo {
        get() {
            getCachedReflectInfo(_typeInfo, {=> getStaticFieldTypeInfo(_info)}) {
                ti: TypeInfo => _typeInfo = ti
            }
        }
    }

    /**
     * Returns the collection of modifiers of static variable.
     */
    public prop modifiers: Collection<ModifierInfo> {
        get() {
            getCachedReflectInfo(_modifiers, {=> ModifierInfo.byMask(getStaticFieldModifier(_info))}) {
                infos: Collection<ModifierInfo> => _modifiers = infos
            }
        }
    }

    /**
     * Returns the collection of annotations of static variable.
     */
    public prop annotations: Collection<Annotation> {
        get() {
            getCachedReflectInfo(_annotations, {=> getStaticFieldAnnotationInfos(_info)}) {
                infos: Collection<Annotation> => _annotations = infos
            }
        }
    }

    /**
     * Returns true if static variable is 'mut'
     */
    public func isMutable(): Bool {
        getCachedReflectInfo(_mutable, {=> ModifierInfo.isMutable(getStaticFieldModifier(_info))}) {
            mutable: Bool => _mutable = mutable
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
     * @throw IllegalTypeException, if the input newValue type is different from the static variable type.
     */
    public func setValue(newValue: Any): Unit {
        if (!isMutable()) {
            throw IllegalSetException("Attempt to modify immutable variable '${name}'.")
        }
        checkValueType(newValue, typeInfo)
        setStaticFieldValue(_info, newValue)
    }

    /**
     * Searches the static variable's annotation by incoming name.
     */
    public func findAnnotation<T>(): ?T where T <: Annotation {
        findAnnotation<T>(annotations)
    }

    public func getAllAnnotations(): Array<Annotation> {
        annotations.toArray()
    }

    public func findAllAnnotations<T>(): Array<T> where T <: Annotation {
        findAllAnnotations<T>(annotations)
    }

    public operator func ==(other: StaticVariableInfo): Bool {
        this._info == other._info
    }

    public operator func !=(other: StaticVariableInfo): Bool {
        !(this == other)
    }

    public func toString(): String {
        variableToString(modifiers, name, typeInfo)
    }

    public func hashCode(): Int64 {
        this._info.toUIntNative().hashCode()
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
            getCachedReflectInfo(_name, {=> getStaticFieldNameString(_info, "GetFieldName Null Pointer!")}) {
                variableName: String => _name = variableName
            }
        }
    }

    // variable type
    public prop typeInfo: TypeInfo {
        get() {
            getCachedReflectInfo(_typeInfo, {=> getStaticFieldTypeInfo(_info)}) {
                ti: TypeInfo => _typeInfo = ti
            }
        }
    }

    // Annotation, when there is no data, size is 0. Note that this api does not guarantee a constant traversal order.
    public prop annotations: Collection<Annotation> {
        get() {
            getCachedReflectInfo(_annotations, {=> getStaticFieldAnnotationInfos(_info)}) {
                infos: Collection<Annotation> => _annotations = infos
            }
        }
    }

    // Whether it is a variable modified by var. Calling setValue on a variable modified by let will throw an exception.
    public func isMutable(): Bool {
        getCachedReflectInfo(_mutable, {=> ModifierInfo.isMutable(getStaticFieldModifier(_info))}) {
            mutable: Bool => _mutable = mutable
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
    public func findAnnotation<T>(): ?T where T <: Annotation {
        findAnnotation<T>(this.annotations)
    }

    public func findAllAnnotations<T>(): Array<T> where T <: Annotation {
        findAllAnnotations<T>(this.annotations)
    }

    public func getAllAnnotations(): Array<Annotation> {
        this.annotations.toArray()
    }

    public operator func ==(other: GlobalVariableInfo): Bool {
        this._info == other._info
    }

    public operator func !=(other: GlobalVariableInfo): Bool {
        !(this == other)
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

func variableToString(modifiers: Collection<ModifierInfo>, name: String, typeInfo: TypeInfo): String {
    let sb = StringBuilder()
    appendModifiers(sb, modifiers)
    sb.append(name)
    sb.append(": ")
    sb.append(typeInfo)
    sb.toString()
}

func getInstanceVariableInfos(info: CPointer<Unit>, typeName: String, isStruct: Bool): Array<InstanceVariableInfo> {
    let num = getNumOfInstanceFieldInfos(info)
    return Array<InstanceVariableInfo>(
        Int64(num),
        {
            index =>
                let pointer = getInstanceFieldInfo(info, UInt32(index))
                if (pointer.isNull()) {
                    throw InfoNotFoundException("${typeName} find instanceVariables failed!")
                }
                InstanceVariableInfo(pointer, info, isStruct: isStruct)
        }
    )
}

func getStaticVariableInfos(info: CPointer<Unit>, typeName: String): Array<StaticVariableInfo> {
    let num = getNumOfStaticFieldInfos(info)
    return Array<StaticVariableInfo>(
        Int64(num),
        {
            index =>
                let pointer = getStaticFieldInfo(info, UInt32(index))
                if (pointer.isNull()) {
                    throw InfoNotFoundException("${typeName} find staticVariables failed!")
                }
                StaticVariableInfo(pointer, info)
        }
    )
}
