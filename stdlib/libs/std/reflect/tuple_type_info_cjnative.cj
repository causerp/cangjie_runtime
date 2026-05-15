/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.reflect

import std.collection.{ReadOnlyList, ArrayList}

/**
 * Reflective information about tuple types.
 */
public class TupleTypeInfo <: TypeInfo {
    init(cp: CPointer<Unit>) {
        super(cp)
    }

    /**
     * Returns the element type infos of this tuple type in declaration order.
     */
    public prop elements: ReadOnlyList<TypeInfo> {
        get() {
            let count: Int64 = Int64(getNumOfFieldTypes(_info))
            let arr: CPointer<Unit> = getFieldTypes(_info)
            return ArrayList<TypeInfo>(count) {
                idx =>
                    let info = unsafe { CPointer<Byte>(arr) + 8 * idx } /* Tuple element type occupies 8 bytes */
                    let ti = unsafe { CPointer<CPointer<Unit>>(info).read() }
                    return TypeInfo.getOrCreate(ti)
            }
        }
    }

    /**
     * Returns the TupleTypeInfo of the runtime type of the given instance.
     *
     * @param instance the instance to inspect.
     * @return the tuple type info of the instance.
     * @throws IllegalTypeException if the instance is not a tuple type.
     */
    public static redef func of(instance: Any): TupleTypeInfo {
        let ti = TypeInfo.of(instance)
        match (ti) {
            case tupleInfo: TupleTypeInfo => tupleInfo
            case _ => throw IllegalTypeException("Expected `instance` to be a tuple type, but got ${ti.qualifiedName}.")
        }
    }

    /**
     * Returns the TupleTypeInfo of the given type T.
     *
     * @return the tuple type info of T.
     * @throws IllegalTypeException if T is not a tuple type.
     */
    public static redef func of<T>(): TupleTypeInfo {
        let ti = TypeInfo.of<T>()
        match (ti) {
            case tupleInfo: TupleTypeInfo => tupleInfo
            case _ => throw IllegalTypeException(
                "Expected generic type `T` to be a tuple type, but got ${ti.qualifiedName}.")
        }
    }

    /**
     * Constructs an instance of this tuple type with arguments in element order.
     *
     * @param args the arguments for each tuple element.
     * @return the constructed tuple instance.
     * @throws IllegalArgumentException if argument count mismatches element count.
     * @throws IllegalTypeException if any argument type mismatches its element type.
     */
    public func construct(args: Array<Any>): Any {
        let elementInfos = elements
        if (args.size != elementInfos.size) {
            throw IllegalArgumentException(
                "Tuple argument count mismatch for ${qualifiedName}: expected ${elementInfos.size}, got ${args.size}.")
        }
        for (i in 0..args.size) {
            let argType = TypeInfo.of(args[i])
            let expectedType = elementInfos[i]
            if (!argType.isSubtypeOf(expectedType)) {
                throw IllegalTypeException(
                    "Tuple argument type mismatch at index ${i}: expected ${expectedType.qualifiedName}, got ${argType.qualifiedName}.")
            }
        }
        newAndInitEnumTupleObject(_info, args)
    }

    /**
     * Destructs a tuple instance into a read-only list of element values.
     *
     * @param instance the tuple instance to destruct.
     * @return the element list in declaration order.
     * @throws IllegalTypeException if the instance type does not match this tuple type.
     */
    public func destruct(instance: Any): ReadOnlyList<Any> {
        let instanceType = TypeInfo.of(instance)
        if (instanceType != this) {
            throw IllegalTypeException(
                "Tuple instance type mismatch: expected ${qualifiedName}, got ${instanceType.qualifiedName}.")
        }
        let arr = getAssociatedValues(instance, TypeInfo.of<Array<Any>>()._info) as Array<Any>
        return ArrayList<Any>(arr.getOrThrow())
    }
}
