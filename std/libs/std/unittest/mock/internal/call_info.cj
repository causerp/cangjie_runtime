/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
protected package std.unittest.mock.internal

public struct Call {
    public let typeArgs: Array<String> // call's type arguments
    public let receiver: Option<(Object, Array<String>)> // receiver reference and its type arguments

    public Call(
        _receiver: Option<Object>,
        _typeArgs: Array<ToString>, // merged type arguments for a call and for the outer declaration
        public let args: Array<Any>,
        public let funcInfo: FuncInfo
    ) {
        let callTypeArgsSize = funcInfo.typeParams.size
        let outerDeclTypeArgsSize = _typeArgs.size - callTypeArgsSize

        typeArgs = Array(callTypeArgsSize) { i => _typeArgs[i + outerDeclTypeArgsSize].toString() }
        receiver = match(_receiver) {
            case Some(r) => (r, Array(outerDeclTypeArgsSize) { i => _typeArgs[i].toString() })
            case _ => Option<(Object, Array<String>)>.None
        }
    }
}

public struct FuncInfo {
    public FuncInfo(
        public let id: DeclId,
        public let params: Array<ParameterInfo>,
        public let typeParams: Array<String>,
        public let location: (String, Int64, Int64),
        public let hasImplementation: Bool,
        public let outerDeclId: Option<DeclId>,
        public let hasDefaultValue: Bool,
        public let returnTypeName: String,
        public let isAccessible: Bool,
        public let kind: DeclKind
    ) {}
}

public enum DeclKind {
    | Method( /*name:*/ String)
    | FieldGetter( /*fieldName: */ String, /*hasSetter: */ Bool)
    | FieldSetter( /*fieldName:*/ String)
    | PropertyGetter( /*propertyName:*/ String, /*hasSetter:*/ Bool)
    | PropertySetter( /*propertyName:*/ String)
    | TopLevelFunction( /*name:*/ String)
    | StaticMethod( /*name:*/ String)
    | StaticPropertyGetter( /*name:*/ String)
    | StaticPropertySetter( /*name:*/ String)
    | StaticFieldGetter( /*name:*/ String)
    | StaticFieldSetter( /*name:*/ String)
    | TopLevelVariableGetter( /*name:*/ String)
    | TopLevelVariableSetter( /*name:*/ String)
}

public struct ParameterInfo {
    public ParameterInfo(
        public let name: String,
        public let position: Int64,
        public let isNamed: Bool,
        public let hasDefaultValue: Bool
    ) {}
}

public struct DeclId <: Equatable<DeclId> & Hashable {
    public DeclId(
        public let mangledName: String,
        public let shortName: String
    ) {}

    public operator func ==(that: DeclId): Bool {
        this.mangledName == that.mangledName
    }

    public operator func !=(that: DeclId): Bool {
        this.mangledName != that.mangledName
    }

    public func hashCode(): Int64 {
        mangledName.hashCode()
    }
}
