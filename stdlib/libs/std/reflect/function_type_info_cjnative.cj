/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.reflect

import std.collection.ReadOnlyList
import std.collection.ArrayList

/**
 * Reflective information about function types.
 */
public class FunctionTypeInfo <: TypeInfo {
    var _parameters: ?ReadOnlyList<TypeInfo> = None<ReadOnlyList<TypeInfo>>
    var _returnType: ?TypeInfo = None<TypeInfo>
    var _signatureTypes: ?ReadOnlyList<TypeInfo> = None<ReadOnlyList<TypeInfo>>

    init(cp: CPointer<Unit>) {
        super(cp)
    }

    /**
     * Returns the parameter types of this function type.
     *
     * @return parameter type list in declaration order.
     */
    public prop parameters: ReadOnlyList<TypeInfo> {
        get() {
            if (let Some(params) <- _parameters) {
                return params
            }

            let signatureTypes = getSignatureTypes()
            let nums = signatureTypes.size - 1 // first type is return type, rest are parameter types
            if (nums <= 0) {
                let empty = ArrayList<TypeInfo>()
                _parameters = empty
                return empty
            }

            let params = ArrayList<TypeInfo>(nums) {
                idx => signatureTypes[idx + 1]
            }
            _parameters = params
            params
        }
    }

    /**
     * Returns the return type of this function type.
     *
     * @throws InfoNotFoundException if signature metadata is missing.
     */
    public prop returnType: TypeInfo {
        get() {
            return if (let Some(ti) <- _returnType) {
                ti
            } else {
                let signatureTypes = getSignatureTypes()
                if (signatureTypes.size == 0) {
                    throw InfoNotFoundException("Failed to get function return type: signature types are empty.")
                }
                let info = signatureTypes[0]
                _returnType = info
                info
            }
        }
    }

    private func getSignatureTypes(): ReadOnlyList<TypeInfo> {
        if (let Some(types) <- _signatureTypes) {
            return types
        }

        let total: Int64 = Int64(getNumOfFunctionSignatureTypes(_info))
        if (total == 0) {
            let empty = ArrayList<TypeInfo>()
            _signatureTypes = empty
            return empty
        }

        let arr = getFunctionSignatureTypes(_info)
        let types = ArrayList<TypeInfo>(total) {
            idx =>
                let slot = unsafe { CPointer<Byte>(arr) + 8 * idx } // TypeInfo pointer occupies 8 bytes
                let ti = unsafe { CPointer<CPointer<Unit>>(slot).read() }
                TypeInfo.getOrCreate(ti)
        }
        _signatureTypes = types
        types
    }

    /**
     * Returns function type info for the runtime type of the given instance.
     *
     * @param instance function instance to inspect.
     * @return function type info for the instance type.
     * @throws IllegalTypeException if the instance is not a function type.
     */
    public static redef func of(instance: Any): FunctionTypeInfo {
        match (TypeInfo.of(instance)) {
            case ti: FunctionTypeInfo => ti
            case other => throw IllegalTypeException(
                "Expected a function type instance, but got `${other.qualifiedName}`.")
        }
    }

    /**
     * Returns function type info for the generic type T.
     *
     * @return function type info for T.
     * @throws IllegalTypeException if T is not a function type.
     */
    public static redef func of<T>(): FunctionTypeInfo {
        match (TypeInfo.of<T>()) {
            case ti: FunctionTypeInfo => ti
            case other => throw IllegalTypeException(
                "Expected function type for `T`, but got `${other.qualifiedName}`.")
        }
    }

    /**
     * Applies a function instance with the given arguments.
     *
     * @param instance function instance to invoke.
     * @param args argument values.
     * @return the return value of the function.
     * @throws IllegalTypeException if instance type or argument types mismatch.
     * @throws IllegalArgumentException if argument count mismatches.
     */
    public func apply(instance: Any, args: Array<Any>): Any {
        let instanceType = TypeInfo.of(instance)
        if (instanceType != this) {
            throw IllegalTypeException("Expected function type `${this}`, but got `${instanceType}`.")
        }
        checkArgsSizeAndType(parameters, args)
        applyCJInstanceMethod(CPointer<Unit>(), instance, args)
    }
}
