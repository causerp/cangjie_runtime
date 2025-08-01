/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.reflect

// Array strip baseptr for intrinsic function: include/cangjie/CodeGen/CGUtils.h: REFLECT_INTRINSIC_FUNC

// TypeInfo
@Intrinsic
func isInterface(ti: CPointer<Unit>): Bool

@Intrinsic
func isStruct(ti: CPointer<Unit>): Bool

@Intrinsic
func isPrimitive(ti: CPointer<Unit>): Bool

@Intrinsic
func isClass(ti: CPointer<Unit>): Bool

@Intrinsic
func isGeneric(ti: CPointer<Unit>): Bool

@Intrinsic
func getOrCreateTypeInfoForReflect(typeTemplate: CPointer<Unit>, typeArgs: Array<CPointer<Unit>>): CPointer<Unit>

@Intrinsic
func getTypeTemplate(name: CPointer<UInt8>): CPointer<Unit>

@Intrinsic
func checkMethodActualArgs(methodInfo: CPointer<Unit>, genericTypeArgs: Array<CPointer<Unit>>, args: Array<Any>): Bool

@Intrinsic
func methodEntryPointIsNull(methodInfo: CPointer<Unit>): Bool

@Intrinsic
func isReflectUnsupportedType(ti: CPointer<Unit>): Bool

@Intrinsic
func getTypeForAny(obj: Any): CPointer<Unit>

@Intrinsic
func getTypeByMangledName<T>(): CPointer<Unit>

@Intrinsic
func getTypeName(obj: CPointer<Unit>): CPointer<UInt8>

@Intrinsic
func getTypeByQualifiedName(qualifiedName: CPointer<UInt8>): CPointer<Unit>

@Intrinsic
func getTypeQualifiedNameLength(ti: CPointer<Unit>): UInt32

@Intrinsic
func getTypeQualifiedName(ti: CPointer<Unit>, name: CPointer<UInt8>): Unit

@Intrinsic
func getNumOfInterface(ti: CPointer<Unit>): UInt32

@Intrinsic
func getInterface(ti: CPointer<Unit>, index: UInt32): CPointer<Unit>

@Intrinsic
func isSubType(ti: CPointer<Unit>, superTypeclassInfo: CPointer<Unit>): Bool
// return modifier flags, parsed in enum ModifierInfo
@Intrinsic
func getTypeInfoModifier(ti: CPointer<Unit>): UInt32

@Intrinsic
func getTypeInfoAnnotations(ti: CPointer<Unit>, arrayTi: CPointer<Unit>): Any

// ClassTypeInfo
@Intrinsic
func getObjClass(obj: Object): CPointer<Unit>

@Intrinsic
func getSuperTypeInfo(ti: CPointer<Unit>): CPointer<Unit>

// InstanceFunctionInfo & StaticFunctionInfo
@Intrinsic
func getNumOfInstanceMethodInfos(ti: CPointer<Unit>): UInt32

@Intrinsic
func getInstanceMethodInfo(ti: CPointer<Unit>, index: UInt32): CPointer<Unit>

@Intrinsic
func getNumOfStaticMethodInfos(ti: CPointer<Unit>): UInt32

@Intrinsic
func getStaticMethodInfo(ti: CPointer<Unit>, index: UInt32): CPointer<Unit>

@Intrinsic
func getMethodName(methodInfo: CPointer<Unit>): CPointer<UInt8>

@Intrinsic
func getParameterInfo(methodInfo: CPointer<Unit>, index: UInt32): CPointer<Unit>

@Intrinsic
func getMethodReturnType(methodInfo: CPointer<Unit>): CPointer<Unit>

@Intrinsic
func getMethodModifier(methodInfo: CPointer<Unit>): UInt32

@Intrinsic
func getMethodAnnotations(methodInfo: CPointer<Unit>, arrayTi: CPointer<Unit>): Any

@Intrinsic
func getNumOfActualParameters(methodInfo: CPointer<Unit>): UInt32

@Intrinsic
func getNumOfGenericParameters(methodInfo: CPointer<Unit>): UInt32

@Intrinsic
func getActualParameterInfo(methodInfo: CPointer<Unit>, idx: UInt32): CPointer<Unit>

@Intrinsic
func getGenericParameterInfo(methodInfo: CPointer<Unit>, idx: UInt32): CPointer<Unit>
// InstanceVariableInfo & StaticVariableInfo
@Intrinsic
func getNumOfInstanceFieldInfos(ti: CPointer<Unit>): UInt32

@Intrinsic
func getInstanceFieldInfo(ti: CPointer<Unit>, index: UInt32): CPointer<Unit>

@Intrinsic
func getNumOfStaticFieldInfos(ti: CPointer<Unit>): UInt32

@Intrinsic
func getStaticFieldInfo(ti: CPointer<Unit>, index: UInt32): CPointer<Unit>

@Intrinsic
func getStaticFieldName(fieldInfo: CPointer<Unit>): CPointer<UInt8>

@Intrinsic
func getStaticFieldType(fieldInfo: CPointer<Unit>): CPointer<Unit>

@Intrinsic
func getStaticFieldAnnotations(fieldInfo: CPointer<Unit>, arrayTi: CPointer<Unit>): Any

@Intrinsic
func getInstanceFieldName(fieldInfo: CPointer<Unit>, declaringTypeInfo: CPointer<Unit>): CPointer<UInt8>

@Intrinsic
func getInstanceFieldType(fieldInfo: CPointer<Unit>, declaringTypeInfo: CPointer<Unit>): CPointer<Unit>

@Intrinsic
func getInstanceFieldModifier(fieldInfo: CPointer<Unit>): UInt32

@Intrinsic
func getStaticFieldModifier(fieldInfo: CPointer<Unit>): UInt32

@Intrinsic
func getInstanceFieldAnnotations(fieldInfo: CPointer<Unit>, arrayTi: CPointer<Unit>): Any

@Intrinsic
func getInstanceFieldValue(fieldInfo: CPointer<Unit>, declaringTypeInfo: CPointer<Unit>, instance: Any): Any

@Intrinsic
func setInstanceFieldValue(fieldInfo: CPointer<Unit>, declaringTypeInfo: CPointer<Unit>, instance: Any, value: Any): Unit

@Intrinsic
func getStaticFieldValue(fieldInfo: CPointer<Unit>): Any

@Intrinsic
func setStaticFieldValue(fieldInfo: CPointer<Unit>, value: Any): Unit

// ParameterInfo
@Intrinsic
func getParameterIndex(parameterInfo: CPointer<Unit>): UInt32

@Intrinsic
func getParameterName(parameterInfo: CPointer<Unit>): CPointer<UInt8>

@Intrinsic
func getParameterType(parameterInfo: CPointer<Unit>): CPointer<Unit>

@Intrinsic
func getParameterAnnotations(parameterInfo: CPointer<Unit>, arrayTi: CPointer<Unit>): Any

// ConstructorInfo
@Intrinsic
func applyCJInstanceMethod(methodInfo: CPointer<Unit>, instance: Any, args: Array<Any>): Any

@Intrinsic
func applyCJStaticMethod(methodInfo: CPointer<Unit>, args: Array<Any>, thisType: CPointer<Unit>): Any

@Intrinsic
func applyCJGenericInstanceMethod(methodInfo: CPointer<Unit>, instance: Any, genericTypeArgs: Array<CPointer<Unit>>,
    args: Array<Any>): Any

@Intrinsic
func applyCJGenericStaticMethod(methodInfo: CPointer<Unit>, genericTypeArgs: Array<CPointer<Unit>>, args: Array<Any>,
    thisType: CPointer<Unit>): Any

// for dynamic load
// success return 0, fail return -1
@Intrinsic
func getRelatedPackageInfo(packageInfo: CPointer<Unit>): CPointer<Unit>

@Intrinsic
func getPackageName(packageInfo: CPointer<Unit>): CPointer<UInt8>

@Intrinsic
func getPackageNumOfTypeInfos(packageInfo: CPointer<Unit>): UInt32

@Intrinsic
func getPackageTypeInfo(packageInfo: CPointer<Unit>, index: UInt32): CPointer<Unit>

@Intrinsic
func getPackageNumOfGlobalMethodInfos(packageInfo: CPointer<Unit>): UInt32

@Intrinsic
func getPackageGlobalMethodInfo(packageInfo: CPointer<Unit>, index: UInt32): CPointer<Unit>

@Intrinsic
func getPackageNumOfGlobalFieldInfos(packageInfo: CPointer<Unit>): UInt32

@Intrinsic
func getPackageGlobalFieldInfo(packageInfo: CPointer<Unit>, index: UInt32): CPointer<Unit>

@Intrinsic
func loadPackage(path: CPointer<UInt8>): CPointer<Unit>

@Intrinsic
func getPackageByQualifiedName(qualifiedName: CPointer<UInt8>): CPointer<Unit>

@Intrinsic
func getPackageVersion(packageInfo: CPointer<Unit>): CPointer<UInt8>

@Intrinsic
func getSubPackages(packageInfo: CPointer<Unit>, arrayTi: CPointer<Unit>): Any
