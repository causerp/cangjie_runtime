/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.reflect

/**
 * Contains the reflective information about parameters.
 */
public class ParameterInfo <: Equatable<ParameterInfo> & Hashable & ToString {
    let _info: CPointer<Unit>
    var _index: Option<Int64> = None
    var _name: Option<String> = None
    var _typeInfo: Option<TypeInfo> = None
    var _annotations: Option<Collection<Annotation>> = None

    init(cp: CPointer<Unit>) {
        _info = cp
    }

    /**
     * Returns the index of parameter.
     */
    public prop index: Int64 {
        get() {
            match (_index) {
                case Some(res) => res
                case None =>
                    var parameterIndex = Int64(getParameterIndex(_info))
                    _index = parameterIndex
                    parameterIndex
            }
        }
    }

    /**
     * Returns the name of parameter.
     */
    public prop name: String {
        get() {
            match (_name) {
                case Some(res) => res
                case None =>
                    let pointer = getParameterName(_info)
                    if (pointer.isNull()) {
                        throw InfoNotFoundException("Get parameter name failed!")
                    }
                    let parameterName = CString(pointer).toString()
                    _name = parameterName
                    parameterName
            }
        }
    }

    /**
     * Returns the return type of parameter.
     */
    public prop typeInfo: TypeInfo {
        get() {
            match (_typeInfo) {
                case Some(res) => res
                case None =>
                    let pointer = getParameterType(_info)
                    let ti = TypeInfo.getOrCreate(pointer)
                    _typeInfo = ti
                    ti
            }
        }
    }

    /**
     * Returns the collection of annotations of parameter.
     */
    public prop annotations: Collection<Annotation> {
        get() {
            match (_annotations) {
                case Some(res) => res
                case None =>
                    let infos = match (getParameterAnnotations(_info, TypeInfo.of<Array<Object>>()._info)) {
                        case arr: Array<Annotation> => arr
                        case _ => Array<Annotation>()
                    }
                    _annotations = infos
                    infos
            }
        }
    }

    /**
     * Searches the parameter's annotation by incoming name.
     */
    public func findAnnotation<T>(): Option<T> where T <: Annotation {
        findAnnotation<T>(annotations)
    }

    public operator func ==(that: ParameterInfo): Bool {
        this._info == that._info
    }

    public operator func !=(that: ParameterInfo): Bool {
        !(this == that)
    }

    public func hashCode(): Int64 {
        this._info.toUIntNative().hashCode()
    }

    public func toString(): String {
        typeInfo.toString()
    }
}
