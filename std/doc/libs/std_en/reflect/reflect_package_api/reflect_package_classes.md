# Class

## class ClassTypeInfo

```cangjie
public class ClassTypeInfo <: TypeInfo
```

Function: Describes type information for `class` types.

Parent Type:

- [TypeInfo](#class-typeinfo)

### prop constructors

```cangjie
public prop constructors: Collection<ConstructorInfo>
```

Function: Retrieves all `public` constructor information for the `class` corresponding to this [ClassTypeInfo](reflect_package_classes.md#class-classtypeinfo), returning the corresponding collection.

> **Note:**
>
> - If the `class` type has no `public` constructors, returns an empty collection.
> - The collection does not guarantee a consistent iteration order.

Type: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[ConstructorInfo](reflect_package_classes.md#class-constructorinfo)>

Example:

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class Rectangular {
    public var myName = ""
    public init() {}
    public init(name: String) {
        myName = name
    }
}

main(): Unit {
    // Here ClassTypeInfo is obtained via Rectangular's qualified type name, but can also be obtained via instance
    let ty = ClassTypeInfo.get("test.Rectangular")
    // Get constructors
    for (i in ty.constructors) {
        println(i)
    }
    return
}
```

Output:

```text
init()
init(String)
```

### prop instanceVariables

```cangjie
public prop instanceVariables: Collection<InstanceVariableInfo>
```

Function: Retrieves all `public` instance variable information for the `class` corresponding to this [ClassTypeInfo](reflect_package_classes.md#class-classtypeinfo), returning the corresponding collection.

> **Note:**
>
> - If the `class` type has no `public` instance variables, returns an empty collection.
> - The collection does not guarantee a consistent iteration order.
> - The collection does not include any inherited `public` instance variables.

Type: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[InstanceVariableInfo](reflect_package_classes.md#class-instancevariableinfo)>

Example:

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class Rectangular {
    public var length = 4
    public var width = 5
    public var myName = ""
    public init() {}
}

main(): Unit {
    // Here ClassTypeInfo is obtained via Rectangular's qualified type name, but can also be obtained via instance
    let ty = ClassTypeInfo.get("test.Rectangular")
    // Get instanceVariables
    for (i in ty.instanceVariables) {
        println(i)
    }
    return
}
```

Output:

```text
length: Int64
width: Int64
myName: String
```

### prop sealedSubclasses

```cangjie
public prop sealedSubclasses: Collection<ClassTypeInfo>
```

Function: If the `class` type corresponding to this [ClassTypeInfo](reflect_package_classes.md#class-classtypeinfo) has `sealed` semantics, retrieves type information for all subclasses within the same package, returning the corresponding collection.

> **Note:**
>
> - If the `class` type does not have `sealed` semantics, returns an empty collection.
> - If the `class` type has `sealed` semantics, the returned collection will never be empty since the type itself is its own subclass.

Type: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[ClassTypeInfo](reflect_package_classes.md#class-classtypeinfo)>

### prop staticVariables

```cangjie
public prop staticVariables: Collection<StaticVariableInfo>
```

Function: Retrieves all `public` static variable information for the `class` corresponding to this [ClassTypeInfo](reflect_package_classes.md#class-classtypeinfo), returning the corresponding collection.

> **Note:**
>
> - If the `class` type has no `public` static variables, returns an empty collection.
> - The collection does not guarantee a consistent iteration order.
> - The collection does not include any inherited `public` static variables.

Type: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[StaticVariableInfo](reflect_package_classes.md#class-staticvariableinfo)>

### prop superClass

```cangjie
public prop superClass: Option<ClassTypeInfo>
```

Function: Retrieves the direct superclass of the `class` type corresponding to this type information.

> **Note:**
>
> Theoretically, only class [Object](../../core/core_package_api/core_package_classes.md#class-object) has no direct superclass.

Type: [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[ClassTypeInfo](reflect_package_classes.md#class-classtypeinfo)>

### func construct(Array\<Any>)

```cangjie
public func construct(args: Array<Any>): Any
```

Function: Searches for and invokes a matching constructor in the `class` type corresponding to this [ClassTypeInfo](reflect_package_classes.md#class-classtypeinfo) using the provided argument list, returning the invocation result.

Parameters:

- args: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Any](../../core/core_package_api/core_package_interfaces.md#interface-any)> - Argument list.

Returns:

- [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - An instance of the `class` type.

Exceptions:

- [IllegalTypeException](reflect_package_exceptions.md#class-illegaltypeexception) - Thrown if the `class` type has `abstract` semantics, as abstract classes cannot be instantiated.
- [MisMatchException](reflect_package_exceptions.md#class-mismatchexception) - Thrown if `args` fails to match any `public` constructor of the `class` type.
- [InvocationTargetException](reflect_package_exceptions.md#class-invocationtargetexception) - Any exception thrown within the invoked constructor will be wrapped as [InvocationTargetException](reflect_package_exceptions.md#class-invocationtargetexception) and rethrown.

Example:

<!-- run -->
```cangjie
package test

import std.reflect.*

public class Rectangular {
    public var length = 4
    public var width = 5
    public var myName = ""
    public init() {}
    public init(name: String) {
        myName = name
    }
    public init(name: String, length: Int64, width: Int64) {
        myName = name
        this.length = length
        this.width = width
    }
}

main(): Unit {
    // Here ClassTypeInfo is obtained via Rectangular's qualified type name, but can also be obtained via instance
    let ty = ClassTypeInfo.get("test.Rectangular")

    // Construct instances with different arguments
    ty.construct()
    ty.construct("Small rectangular")
    ty.construct("Big rectangular", 1, 1)
    return
}
```

### func getConstructor(Array\<TypeInfo>)

```cangjie
public func getConstructor(parameterTypes: Array<TypeInfo>): ConstructorInfo
```

Function: Attempts to retrieve information about a `public` constructor in the `class` type corresponding to this [ClassTypeInfo](reflect_package_classes.md#class-classtypeinfo) that matches the given parameter type information list.

Parameters:

- parameterTypes: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[TypeInfo](reflect_package_classes.md#class-typeinfo)> - Parameter type information list.

Returns:

- [ConstructorInfo](reflect_package_classes.md#class-constructorinfo) - Returns the matched `public` constructor information if successful.

Exceptions:

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - Thrown if no matching `public` constructor is found.

Example:

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class Rectangular {
    public var length = 4
    public var width = 5
    public var myName = ""
    public init() {}
    public init(name: String) {
        myName = name
    }
    public init(name: String, length: Int64, width: Int64) {
        myName = name
        this.length = length
        this.width = width
    }
}

main(): Unit {
    // Here ClassTypeInfo is obtained via Rectangular's qualified type name, but can also be obtained via instance
    let ty = ClassTypeInfo.get("test.Rectangular")

    // Get specified constructor information
    let ci01 = ty.getConstructor(StructTypeInfo.get("String"))
    println(ci01)

    // Get specified constructor information
    let ci02 = ty.getConstructor(StructTypeInfo.get("String"), PrimitiveTypeInfo.get("Int64"),
        PrimitiveTypeInfo.get("Int64"))
    println(ci02)
    return
}
```

Output:

```text
init(String)
init(String, Int64, Int64)
```

### func getInstanceVariable(String)

```cangjie
public func getInstanceVariable(name: String): InstanceVariableInfo
```

Function: Given a variable name, attempts to retrieve information about the matching instance variable in the `class` type corresponding to this [ClassTypeInfo](reflect_package_classes.md#class-classtypeinfo).

Parameters:

- name: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Variable name.

Returns:

- [InstanceVariableInfo](reflect_package_classes.md#class-instancevariableinfo) - Returns the matched instance variable information if successful.

Exceptions:

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - Thrown if no matching instance variable is found.
<!-- verify -->
```cangjie
package test

import std.reflect.*

public class Rectangular {
    public var length = 4
    public var width = 5
    public var myName = ""
    public init() {}
}

main(): Unit {
    // Here we obtain ClassTypeInfo through the qualified name of Rectangular type, 
    // or alternatively through an instance
    let ty = ClassTypeInfo.get("test.Rectangular")

    // Get instance member information
    let ivi = ty.getInstanceVariable("myName")
    println(ivi)
    return
}
```

Execution Result:

```text
myName: String
```

### func getStaticVariable(String)

```cangjie
public func getStaticVariable(name: String): StaticVariableInfo
```

Function: Given a variable name, attempts to retrieve information about the matching static member variable in the `class` type corresponding to this [ClassTypeInfo](reflect_package_classes.md#class-classtypeinfo).

Parameters:

- name: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The variable name.

Return Value:

- [StaticVariableInfo](reflect_package_classes.md#class-staticvariableinfo) - Returns information about the static member variable if successfully matched.

Exceptions:

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - Throws an exception if no corresponding static member variable is found.

Example:

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class Rectangular {
    public static var area: Int64 = 10
}

main(): Unit {
    // Here we obtain ClassTypeInfo through the qualified name of Rectangular type, 
    // or alternatively through an instance
    let ty = ClassTypeInfo.get("test.Rectangular")

    // Get static variable
    let sv = ty.getStaticVariable("area")
    println(sv)
    return
}
```

Execution Result:

```text
static area: Int64
```

### func isAbstract()

```cangjie
public func isAbstract(): Bool
```

Function: Determines whether the `class` type corresponding to this [ClassTypeInfo](reflect_package_classes.md#class-classtypeinfo) is abstract.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the `class` type corresponding to this [ClassTypeInfo](reflect_package_classes.md#class-classtypeinfo) is abstract, otherwise returns `false`.

### func isOpen()

```cangjie
public func isOpen(): Bool
```

Function: Determines whether the `class` type corresponding to this [ClassTypeInfo](reflect_package_classes.md#class-classtypeinfo) has `open` semantics.

> **Note:**
>
> Not only `class` type definitions modified by the `open` modifier have `open` semantics. For example: `abstract class` will have `open` semantics regardless of whether it is modified by the `open` modifier.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the `class` type corresponding to this [ClassTypeInfo](reflect_package_classes.md#class-classtypeinfo) has `open` semantics, otherwise returns `false`.

### func isSealed()

```cangjie
public func isSealed(): Bool
```

Function: Determines whether the `class` type corresponding to this [ClassTypeInfo](reflect_package_classes.md#class-classtypeinfo) has `sealed` semantics.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the `class` type corresponding to this [ClassTypeInfo](reflect_package_classes.md#class-classtypeinfo) has `sealed` semantics, otherwise returns `false`.

### static func get(String)

```cangjie
public redef static func get(qualifiedName: String): ClassTypeInfo
```

Function: Retrieves the [ClassTypeInfo](reflect_package_classes.md#class-classtypeinfo) corresponding to the type with the given qualified name.

Parameters:

- qualifiedName: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The qualified name of the type.

Return Value:

- [ClassTypeInfo](reflect_package_classes.md#class-classtypeinfo) - The type information corresponding to the type with the qualified name `qualifiedName`.

Exceptions:

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - Throws an exception if type information matching the given qualified name `qualifiedName` cannot be retrieved.
- [IllegalTypeException](./reflect_package_exceptions.md#class-illegaltypeexception) - Throws an exception if the retrieved type information is not [ClassTypeInfo](reflect_package_classes.md#class-classtypeinfo).

Example:

<!-- verify -->
```cangjie
import std.reflect.*

public class Rectangular {}

main(): Unit {
    let ty = ClassTypeInfo.get("default.Rectangular")
    println(ty)
    return
}
```

Execution Result:

```text
default.Rectangular
```

### static func of(Any)

```cangjie
public redef static func of(a: Any): ClassTypeInfo
```

Function: Retrieves the type information corresponding to the runtime type of the given instance of any type.

The runtime type refers to the type determined through dynamic binding during program execution, which is bound to the instance object. In inheritance scenarios, the runtime type may differ from the static type.

Parameters:

- a: [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - An instance of any type.

Return Value:

- [ClassTypeInfo](reflect_package_classes.md#class-classtypeinfo) - The type information corresponding to the runtime type of instance `a`.

Exceptions:

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - Throws an exception if the type information corresponding to the runtime type of instance `a` cannot be retrieved.
- [IllegalTypeException](./reflect_package_exceptions.md#class-illegaltypeexception) - Throws an exception if the retrieved type information is not [ClassTypeInfo](reflect_package_classes.md#class-ClassTypeInfo).

Example:

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class Rectangular {}

main(): Unit {
    var r = Rectangular()
    let ty = ClassTypeInfo.of(r)
    println(ty)
    return
}
```

Execution Result:

```text
test.Rectangular
```

### static func of(Object)

```cangjie
public static func of(a: Object): ClassTypeInfo
```

Function: Retrieves the `class` type information corresponding to the runtime type of the given `class` type instance.

Parameters:

- a: [Object](../../core/core_package_api/core_package_classes.md#class-object) - An instance of a `class` type.

Return Value:

- [ClassTypeInfo](reflect_package_classes.md#class-classtypeinfo) - The `class` type information corresponding to the runtime type of the `class` type instance `a`.

Exceptions:

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - Throws an exception if the `class` type information corresponding to the runtime type of instance `a` cannot be retrieved.

Example:

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class Rectangular {}

main(): Unit {
    var r = Rectangular()
    let ty = ClassTypeInfo.of(r)
    println(ty)
    return
}
```

Execution Result:

```text
test.Rectangular
```

### static func of\<T>()

```cangjie
public redef static func of<T>(): ClassTypeInfo
```

Function: Retrieves the type information corresponding to the given type `T`.

Return Value:

- [ClassTypeInfo](reflect_package_classes.md#class-classtypeinfo) - The type information corresponding to type `T`.

Exceptions:

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - Throws an exception if the type information corresponding to type T cannot be retrieved.
- [IllegalTypeException](./reflect_package_exceptions.md#class-illegaltypeexception) - Throws an exception if the retrieved type information is not [ClassTypeInfo](reflect_package_classes.md#class-classtypeinfo).

Example:

<!-- verify -->
```cangjie
import std.reflect.*

public class Rectangular {}

main(): Unit {
    let ty = ClassTypeInfo.of<Rectangular>()
    println(ty)
    return
}
```

Execution Result:

```text
default.Rectangular
```

## class ConstructorInfo

```cangjie
public class ConstructorInfo <: Equatable<ConstructorInfo> & Hashable & ToString
```

Function: Describes constructor information.

Parent Types:

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[ConstructorInfo](#class-constructorinfo)>
- [Hashable](../../core/core_package_api/core_package_interfaces.md#interface-hashable)
- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

### prop annotations

```cangjie
public prop annotations: Collection<Annotation>
```

Function: Retrieves all annotations applied to the constructor corresponding to this [ConstructorInfo](reflect_package_classes.md#class-constructorinfo), returning the associated collection.

> **Note:**
>
> - If no annotations are applied to the constructor represented by this ConstructorInfo, an empty collection is returned.
> - The collection does not guarantee a consistent iteration order.

Type: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[Annotation](../../ast/ast_package_api/ast_package_classes.md#class-annotation)>

### prop parameters

```cangjie
public prop parameters: ReadOnlyList<ParameterInfo>
```

Function: Retrieves the parameter type list of the constructor corresponding to this [ConstructorInfo](reflect_package_classes.md#class-constructorinfo).

> **Note:**
>
> Parameter order is not guaranteed; the actual parameter position can be determined using the `index` property of `ParameterInfo`.

Type: [ReadOnlyList](../../collection/collection_package_api/collection_package_interface.md#interface-readonlylistt)\<[ParameterInfo](reflect_package_classes.md#class-parameterinfo)>

Example:

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class Rectangular {
    public var length = 4
    public var width = 5
    public var myName = ""
    public init() {}
    public init(name: String) {
        myName = name
    }
    public init(name: String, length: Int64, width: Int64) {
        myName = name
        this.length = length
        this.width = width
    }
}

main(): Unit {
    // Here, ClassTypeInfo is obtained via the qualified name of Rectangular's type; it can also be obtained via an instance
    let ty = ClassTypeInfo.get("test.Rectangular")
    // Get constructors
    for (i in ty.constructors) {
        // Get parameters
        for (j in i.parameters) {
            println("${i} has input parameter ${j}")
        }
    }
    return
}
```

Execution Result:

```text
init(String) has input parameter String
init(String, Int64, Int64) has input parameter String
init(String, Int64, Int64) has input parameter Int64
init(String, Int64, Int64) has input parameter Int64
```

### func apply(Array\<Any>)

```cangjie
public func apply(args: Array<Any>): Any
```

Function: Invokes the constructor corresponding to this [ConstructorInfo](reflect_package_classes.md#class-constructorinfo) with the provided argument list and returns the invocation result.

Parameters:

- args: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Any](../../core/core_package_api/core_package_interfaces.md#interface-any)> - The argument list.

Return Value:

- [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - The instance constructed by this constructor.

Exceptions:

- [InvocationTargetException](reflect_package_exceptions.md#class-invocationtargetexception) - Thrown if the type to which this constructor belongs is an abstract class.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if the number of arguments in `args` does not match the number of parameters in the constructor's parameter list.
- [IllegalTypeException](reflect_package_exceptions.md#class-illegaltypeexception) - Thrown if the runtime type of any argument in `args` is not a subtype of the declared type of the corresponding parameter in the constructor.
- [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception) - If the invoked constructor throws an exception internally, it will be wrapped as an [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception) and rethrown.

### func findAnnotation\<T>() where T <: Annotation

```cangjie
public func findAnnotation<T>(): Option<T> where T <: Annotation
```

Function: Attempts to retrieve an annotation with the specified qualified name that is applied to the constructor corresponding to this [ConstructorInfo](reflect_package_classes.md#class-constructorinfo).

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - Returns the annotation if matched successfully; otherwise, returns `None`.

### func hashCode()

```cangjie
public func hashCode(): Int64
```

Function: Retrieves the hash value of this constructor information.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The hash value of this constructor information.

### func toString()

```cangjie
public func toString(): String
```

Function: Retrieves a string representation of this constructor information.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string representation of this constructor information.

### operator func !=(ConstructorInfo)

```cangjie
public operator func !=(that: ConstructorInfo): Bool
```

Function: Determines whether this constructor information is not equal to another given constructor information.

Parameters:

- that: [ConstructorInfo](reflect_package_classes.md#class-constructorinfo) - The other constructor information to compare for equality.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if this constructor information is not equal to `that`; otherwise, returns `false`.

### operator func ==(ConstructorInfo)

```cangjie
public operator func ==(that: ConstructorInfo): Bool
```

Function: Determines whether this constructor information is equal to another given constructor information.

Parameters:

- that: [ConstructorInfo](reflect_package_classes.md#class-constructorinfo) - The other constructor information to compare for equality.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if this constructor information is equal to `that`; otherwise, returns `false`.

## class GenericTypeInfo

```cangjie
public class GenericTypeInfo <: TypeInfo & Equatable<GenericTypeInfo>
```

Function: Describes generic type information.

Parent Types:

- [TypeInfo](./reflect_package_classes.md#class-typeinfo)
- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[GenericTypeInfo](./reflect_package_classes.md#class-generictypeinfo)>

### operator func ==(GenericTypeInfo)

```cangjie
public operator func ==(that: GenericTypeInfo): Bool
```

Function: Determines whether this generic type information is equal to another given generic type information.

Parameters:

- that: [GenericTypeInfo](reflect_package_classes.md#class-generictypeinfo) - The other generic type information to compare for equality.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if this generic type information is equal to `that`; otherwise, returns `false`.

## class GlobalFunctionInfo

```cangjie
public class GlobalFunctionInfo <: Equatable<GlobalFunctionInfo> & Hashable & ToString
```

Function: Describes global function information.

Parent Types:

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[GlobalFunctionInfo](#class-globalfunctioninfo)>
- [Hashable](../../core/core_package_api/core_package_interfaces.md#interface-hashable)
- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

### prop annotations

```cangjie
public prop annotations: Collection<Annotation>
```

Function: Retrieves all annotations applied to the global function corresponding to this [GlobalFunctionInfo](reflect_package_classes.md#class-globalfunctioninfo), returning the associated collection.

> **Note:**
>
> - If no annotations are applied to the global function represented by this GlobalFunctionInfo, an empty collection is returned.
> - The collection does not guarantee a consistent iteration order.

Type: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[Annotation](../../ast/ast_package_api/ast_package_classes.md#class-annotation)>

### prop genericParams

```cangjie
public prop genericParams: Collection<GenericTypeInfo>
```

Function: Retrieves the generic parameter information list of the instance member function corresponding to this [GlobalFunctionInfo](reflect_package_classes.md#class-globalfunctioninfo).

Type: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[GenericTypeInfo](reflect_package_classes.md#class-generictypeinfo)>

Exceptions:

- [InfoNotFoundException](./reflect_package_exceptions.md#class-infonotfoundexception) - Thrown if the [GlobalFunctionInfo](reflect_package_classes.md#class-globalfunctioninfo) has no generic parameters.

### prop name

```cangjie
public prop name: String
```

Function: Retrieves the name of the global function corresponding to this [GlobalFunctionInfo](reflect_package_classes.md#class-globalfunctioninfo).

> **Note:**
>
> All overloaded global functions will share the same name.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop parameters

```cangjie
public prop parameters: ReadOnlyList<ParameterInfo>
```

Function: Retrieves the parameter information list of the global function corresponding to this [GlobalFunctionInfo](reflect_package_classes.md#class-globalfunctioninfo).

> **Note:**
>
> Parameter order is not guaranteed; the actual parameter position can be determined using the `index` property of `ParameterInfo`.

Type: [ReadOnlyList](../../collection/collection_package_api/collection_package_interface.md#interface-readonlylistt)\<[ParameterInfo](reflect_package_classes.md#class-parameterinfo)>

### prop returnType

```cangjie
public prop returnType: TypeInfo
```

Function: Retrieves the return type information of the global function corresponding to this [GlobalFunctionInfo](reflect_package_classes.md#class-globalfunctioninfo).

Type: [TypeInfo](reflect_package_classes.md#class-typeinfo)

### func apply(Array\<Any>)

```cangjie
public func apply(args: Array<Any>): Any
```

Function: Invokes the global function corresponding to this [GlobalFunctionInfo](reflect_package_classes.md#class-globalfunctioninfo) with the provided argument list and returns the invocation result.

> **Note:**
>
> The types of `args` must exactly match the function's parameter types; otherwise, parameter validation will fail.

Parameters:

- args: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Any](../../core/core_package_api/core_package_interfaces.md#interface-any)> - The argument list.

Return Value:- [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - The invocation result of this global function.

Exceptions:

- [InvocationTargetException](../reflect_package_api/reflect_package_exceptions.md#class-invocationtargetexception) - Thrown if a function with generic parameters invokes this method.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if the number of arguments in the argument list `args` does not match the number of parameters in the formal parameter list of the global function corresponding to this `GlobalFunctionInfo`.
- [IllegalTypeException](reflect_package_exceptions.md#class-illegaltypeexception) - Thrown if the runtime type of any argument in `args` is not a subtype of the declared type of the corresponding parameter in the global function.
- [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception) - If the invoked global function throws an exception internally, it will be wrapped as an [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception) and rethrown.

### func apply(Array\<TypeInfo>, Array\<Any>)

```cangjie
public func apply(genericTypeArgs: Array<TypeInfo>, args: Array<Any>): Any
```

Function: Invokes the global generic function corresponding to this [GlobalFunctionInfo](reflect_package_classes.md#class-globalfunctioninfo), passing the generic type argument list and argument list, and returns the invocation result.

> **Note:**
>
> The types of `args` must exactly match the function's parameter types; otherwise, parameter validation will fail.

Parameters:

- genericTypeArgs: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[TypeInfo](./reflect_package_classes.md#class-typeinfo)> - The generic type argument list.
- args: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Any](../../core/core_package_api/core_package_interfaces.md#interface-any)> - The argument list.

Return Value:

- [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - The invocation result of this global function.

Exceptions:

- [InvocationTargetException](../reflect_package_api/reflect_package_exceptions.md#class-invocationtargetexception) - Thrown if a non-generic function invokes this method.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if the number of arguments in `args` does not match the number of parameters in the global function corresponding to this `GlobalFunctionInfo`.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if the number of parameters in `genericTypeArgs` does not match the number of generic parameters in the global function's `genericParams` list.
- [IllegalTypeException](reflect_package_exceptions.md#class-illegaltypeexception) - Thrown if the runtime type of any argument in `args` is not a subtype of the declared type of the corresponding parameter in the global function.
- [IllegalTypeException](reflect_package_exceptions.md#class-illegaltypeexception) - Thrown if `args` and `genericTypeArgs` do not satisfy the type constraints of the global function's parameters.
- [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception) - If the invoked global function throws an exception internally, it will be wrapped as an [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception) and rethrown.

### func findAnnotation\<T>() where T <: Annotation

```cangjie
public func findAnnotation<T>(): Option<T> where T <: Annotation
```

Function: Attempts to retrieve an annotation with the given qualified name that is applied to the global function corresponding to this [GlobalFunctionInfo](reflect_package_classes.md#class-globalfunctioninfo).

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - Returns the annotation if matched successfully; otherwise, returns `None`.

### func hashCode()

```cangjie
public func hashCode(): Int64
```

Function: Retrieves the hash value of this global function information.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The hash value of this global function information.

### func toString()

```cangjie
public func toString(): String
```

Function: Retrieves a string representation of this global function information.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string representation of this global function information.

### operator func ==(GlobalFunctionInfo)

```cangjie
public operator func ==(that: GlobalFunctionInfo): Bool
```

Function: Determines whether this global function information is equal to another given global function information.

Parameters:

- that: [GlobalFunctionInfo](reflect_package_classes.md#class-globalfunctioninfo) - The other global function information to compare for equality.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if this global function information is equal to `that`; otherwise, returns `false`.

### operator func !=(GlobalFunctionInfo)

```cangjie
public operator func !=(that: GlobalFunctionInfo): Bool
```

Function: Determines whether this global function information is not equal to another given global function information.

Parameters:

- that: [GlobalFunctionInfo](reflect_package_classes.md#class-globalfunctioninfo) - The other global function information to compare for inequality.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if this global function information is not equal to `that`; otherwise, returns `false`.

## class GlobalVariableInfo

```cangjie
public class GlobalVariableInfo <: Equatable<GlobalVariableInfo> & Hashable & ToString
```

Function: Describes global variable information.

Parent Types:

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[GlobalVariableInfo](#class-globalvariableinfo)>
- [Hashable](../../core/core_package_api/core_package_interfaces.md#interface-hashable)
- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

### prop annotations

```cangjie
public prop annotations: Collection<Annotation>
```

Function: Retrieves all annotations applied to the global variable corresponding to this [GlobalVariableInfo](reflect_package_classes.md#class-globalvariableinfo), returning the collection.

> **Note:**
>
> - If no annotations are applied to the global variable, an empty collection is returned.
> - The collection does not guarantee a consistent iteration order.

Type: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[Annotation](../../ast/ast_package_api/ast_package_classes.md#class-annotation)>

### prop name

```cangjie
public prop name: String
```

Function: Retrieves the name of the global variable corresponding to this [GlobalVariableInfo](reflect_package_classes.md#class-globalvariableinfo).

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop typeInfo

```cangjie
public prop typeInfo: TypeInfo
```

Function: Retrieves the type information of the declared type of the global variable corresponding to this [GlobalVariableInfo](reflect_package_classes.md#class-globalvariableinfo).

Type: [TypeInfo](reflect_package_classes.md#class-typeinfo)

### func findAnnotation\<T>() where T <: Annotation

```cangjie
public func findAnnotation<T>(): Option<T> where T <: Annotation
```

Function: Attempts to retrieve an annotation with the given qualified name that is applied to the global variable corresponding to this [GlobalVariableInfo](reflect_package_classes.md#class-globalvariableinfo).

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - Returns the annotation if matched successfully; otherwise, returns `None`.

### func getValue()

```cangjie
public func getValue(): Any
```

Function: Retrieves the value of the global variable corresponding to this [GlobalVariableInfo](reflect_package_classes.md#class-globalvariableinfo).

Return Value:

- [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - The value of the global variable.

### func hashCode()

```cangjie
public func hashCode(): Int64
```

Function: Retrieves the hash value of this global variable information.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The hash value of this global variable information.

### func isMutable()

```cangjie
public func isMutable(): Bool
```

Function: Determines whether the global variable corresponding to this [GlobalVariableInfo](reflect_package_classes.md#class-globalvariableinfo) is mutable.

> **Note:**
>
> - If the instance member variable is modified by `var`, the global variable is mutable.
> - If the instance member variable is modified by `let`, the global variable is immutable.
> - Any global variable of type `struct` is immutable.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the global variable is mutable; otherwise, returns `false`.

### func setValue(Any)

```cangjie
public func setValue(newValue: Any): Unit
```

Function: Sets the value of the global variable corresponding to this [GlobalVariableInfo](reflect_package_classes.md#class-globalvariableinfo).

Parameters:

- newValue: [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - The new value.

Exceptions:

- [IllegalSetException](reflect_package_exceptions.md#class-illegalsetexception) - Thrown if the global variable corresponding to this information is immutable.
- [IllegalTypeException](reflect_package_exceptions.md#class-illegaltypeexception) - Thrown if the runtime type of `newValue` is not a subtype of the declared type of the global variable.

### func toString()

```cangjie
public func toString(): String
```

Function: Retrieves a string representation of this global variable information.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string representation of this global variable information.

### operator func ==(GlobalVariableInfo)

```cangjie
public operator func ==(that: GlobalVariableInfo): Bool
```

Function: Determines whether this global variable information is equal to another given global variable information.

Parameters:

- that: [GlobalVariableInfo](reflect_package_classes.md#class-globalvariableinfo) - The other global variable information to compare for equality.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if this global variable information is equal to `that`; otherwise, returns `false`.

### operator func !=(GlobalVariableInfo)

```cangjie
public operator func !=(that: GlobalVariableInfo): Bool
```

Function: Determines whether this global variable information is not equal to another given global variable information.

Parameters:

- that: [GlobalVariableInfo](reflect_package_classes.md#class-globalvariableinfo) - The other global variable information to compare for inequality.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if this global variable information is not equal to `that`; otherwise, returns `false`.

## class InstanceFunctionInfo

```cangjie
public class InstanceFunctionInfo <: Equatable<InstanceFunctionInfo> & Hashable & ToString
```

Function: Describes instance member function information.

Parent Types:

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[InstanceFunctionInfo](#class-instancefunctioninfo)>
- [Hashable](../../core/core_package_api/core_package_interfaces.md#interface-hashable)
- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

### prop annotations

```cangjie
public prop annotations: Collection<Annotation>
```

Function: Retrieves all annotations applied to the instance member function corresponding to this [InstanceFunctionInfo](reflect_package_classes.md#class-instancefunctioninfo), returning the collection.

> **Note:**
>
> - If no annotations are applied to the instance member function, an empty collection is returned.
> - The collection does not guarantee a consistent iteration order.

Type: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[Annotation](../../ast/ast_package_api/ast_package_classes.md#class-annotation)>### prop genericParams

```cangjie
public prop genericParams: Collection<GenericTypeInfo>
```

Function: Retrieves the list of generic parameter information for the corresponding instance member function of this [InstanceFunctionInfo](reflect_package_classes.md#class-instancefunctioninfo).

Type: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[GenericTypeInfo](reflect_package_classes.md#class-generictypeinfo)>

Exceptions:

- [InfoNotFoundException](./reflect_package_exceptions.md#class-infonotfoundexception) - Thrown when [GlobalFunctionInfo](reflect_package_classes.md#class-globalfunctioninfo) has no generic parameters.

### prop modifiers

```cangjie
public prop modifiers: Collection<ModifierInfo>
```

Function: Retrieves all modifier information for the corresponding instance member function of this [InstanceFunctionInfo](reflect_package_classes.md#class-instancefunctioninfo), returning the associated collection.

> **Note:**
>
> - If the instance member function has no modifiers, an empty collection is returned.
> - The collection does not guarantee a consistent iteration order.
> - Even if not explicitly modified by a certain modifier, if it possesses the semantics of that modifier, the modifier information will be included in this collection.

Type: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[ModifierInfo](reflect_package_enums.md#enum-modifierinfo)>

### prop name

```cangjie
public prop name: String
```

Function: Retrieves the name of the corresponding instance member function of this [InstanceFunctionInfo](reflect_package_classes.md#class-instancefunctioninfo).

> **Note:**
>
> - All overloaded instance member functions will share the same name.
> - The name of operator overload functions is the symbol of the operator itself, such as "`+`", "`*`", "`[]`".

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop parameters

```cangjie
public prop parameters: ReadOnlyList<ParameterInfo>
```

Function: Retrieves the parameter information list for the corresponding instance member function of this [InstanceFunctionInfo](reflect_package_classes.md#class-instancefunctioninfo).

> **Note:**
>
> Parameter order is not guaranteed; use the `index` property of `ParameterInfo` to determine the actual parameter position.

Type: [ReadOnlyList](../../collection/collection_package_api/collection_package_interface.md#interface-readonlylistt)\<[ParameterInfo](reflect_package_classes.md#class-parameterinfo)>

### prop returnType

```cangjie
public prop returnType: TypeInfo
```

Function: Retrieves the type information of the return value type for the corresponding instance member function of this [InstanceFunctionInfo](reflect_package_classes.md#class-instancefunctioninfo).

Type: [TypeInfo](reflect_package_classes.md#class-typeinfo)

### func apply(Any, Array\<Any>)

```cangjie
public func apply(instance: Any, args: Array<Any>): Any
```

Function: Invokes the corresponding instance member function of this [InstanceFunctionInfo](reflect_package_classes.md#class-instancefunctioninfo), specifying the instance and passing the argument list, returning the invocation result.

> **Note:**
>
> The types in `args` must exactly match the function's parameter types.

Parameters:

- instance: [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - The instance.
- args: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Any](../../core/core_package_api/core_package_interfaces.md#interface-any)> - The argument list.

Return Value:

- [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - The invocation result of the instance member function.

Exceptions:

- [InvocationTargetException](../reflect_package_api/reflect_package_exceptions.md#class-invocationtargetexception) - Thrown if a function with generic parameters calls this method.
- [InvocationTargetException](reflect_package_exceptions.md#class-invocationtargetexception) - Thrown if the corresponding instance member function is abstract or has no implementation.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if the number of arguments in `args` does not match the number of parameters in the corresponding instance member function.
- [IllegalTypeException](reflect_package_exceptions.md#class-illegaltypeexception) - Thrown if the runtime type of `instance` does not match the type of the corresponding instance member function.
- [IllegalTypeException](reflect_package_exceptions.md#class-illegaltypeexception) - Thrown if the runtime type of any argument in `args` is not a subtype of the declared type of the corresponding parameter in the instance member function.
- [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception) - If the invoked instance member function throws an exception internally, it will be wrapped as an [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception) and thrown.

### func apply(Any, Array\<TypeInfo>, Array\<Any>)

```cangjie
public func apply(instance: Any, genericTypeArgs: Array<TypeInfo>, args: Array<Any>): Any
```

Function: Invokes the corresponding generic member function of this [InstanceFunctionInfo](reflect_package_classes.md#class-instancefunctioninfo), specifying the instance and passing the type list of generic parameters and the argument list, returning the invocation result.

> **Note:**
>
> The types in `args` must exactly match the function's parameter types.

Parameters:

- instance: [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - The instance.
- genericTypeArgs: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[TypeInfo](./reflect_package_classes.md#class-typeinfo)> - The list of generic parameter type information.
- args: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Any](../../core/core_package_api/core_package_interfaces.md#interface-any)> - The list of generic arguments.

Return Value:

- [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - The invocation result of the generic instance function.

Exceptions:

- [InvocationTargetException](reflect_package_exceptions.md#class-invocationtargetexception) - Thrown if the corresponding member function is `abstract` or has no function body.
- [InvacationTargetException](reflect_package_exceptions.md#class-invocationtargetexception) - Thrown if a non-generic function calls this method.
- [IllegalTypeException](reflect_package_exceptions.md#class-illegaltypeexception) - Thrown if the runtime type of `instance` does not match the type of the corresponding member function.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if the number of arguments in `args` does not match the number of parameters in the corresponding member function.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if the number of parameters in `genericTypeArgs` does not match the number of generic parameters in `genericParams` of the corresponding member function.
- [IllegalTypeException](reflect_package_exceptions.md#class-illegaltypeexception) - Thrown if the runtime type of any argument in `args` is not a subtype of the declared type of the corresponding parameter in the instance member function.
- [IllegalTypeException](reflect_package_exceptions.md#class-illegaltypeexception) - Thrown if the argument list `args` and generic parameter type list `genericTypeArgs` do not satisfy the type constraints of the corresponding member function.
- [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception) - If the invoked instance member function throws an exception internally, it will be wrapped as an [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception) and thrown.

Example:

<!-- verify -->
```cangjie
import std.reflect.*

public class Rectangular {
    public var length = 4
    public var width = 5
    public func area(): Int64 {
        return length * width
    }
}

main(): Unit {
    // Here, ClassTypeInfo is obtained via the qualified name of Rectangular's type, or it can be obtained via an instance
    let ty = ClassTypeInfo.get("default.Rectangular")
    // Get InstanceFunctionInfo
    var gif = ty.getInstanceFunction("area")

    // Invoke the reflected function
    var r = Rectangular()
    var result = gif.apply(r) as Int64
    println(result)
    return
}
```

Execution Result:

```text
Some(20)
```

### func findAnnotation\<T>() where T <: Annotation

```cangjie
public func findAnnotation<T>(): Option<T> where T <: Annotation
```

Function: Attempts to retrieve the annotation with the given qualified name that is applied to the corresponding instance member function of this [InstanceFunctionInfo](reflect_package_classes.md#class-instancefunctioninfo).

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - Returns the annotation if successfully matched, otherwise returns `None`.

### func hashCode()

```cangjie
public func hashCode(): Int64
```

Function: Retrieves the hash value of this instance member function information.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The hash value of this instance member function information.

### func isAbstract()

```cangjie
public func isAbstract(): Bool
```

Function: Determines whether the corresponding instance member function of [InstanceFunctionInfo](reflect_package_classes.md#class-instancefunctioninfo) has `abstract` semantics.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the instance member function has `abstract` semantics, otherwise returns `false`.

### func isOpen()

```cangjie
public func isOpen(): Bool
```

Function: Determines whether the corresponding instance member function of this [InstanceFunctionInfo](reflect_package_classes.md#class-instancefunctioninfo) has `open` semantics.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the instance member function has `open` semantics, otherwise returns `false`.

> **Note:**
>
> Instance member functions in `interface` types inherently have `open` semantics by default.

### func toString()

```cangjie
public func toString(): String
```

Function: Retrieves the string representation of this instance member function information.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string representation of this instance member function information.

### operator func ==(InstanceFunctionInfo)

```cangjie
public operator func ==(that: InstanceFunctionInfo): Bool
```

Function: Determines whether this instance member function information is equal to another given instance member function information.

Parameters:

- that: [InstanceFunctionInfo](reflect_package_classes.md#class-instancefunctioninfo) - The other instance member function information to compare for equality.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if this instance member function information is equal to `that`, otherwise returns `false`.

### operator func !=(InstanceFunctionInfo)

```cangjie
public operator func !=(that: InstanceFunctionInfo): Bool
```

Function: Determines whether this instance member function information is not equal to another given instance member function information.

Parameters:

- that: [InstanceFunctionInfo](reflect_package_classes.md#class-instancefunctioninfo) - The other instance member function information to compare for inequality.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if this instance member function information is not equal to `that`, otherwise returns `false`.

## class InstancePropertyInfo

```cangjie
public class InstancePropertyInfo <: Equatable<InstancePropertyInfo> & Hashable & ToString
```

Function: Describes instance member property information.

Parent Types:

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[InstancePropertyInfo](#class-instancepropertyinfo)>
- [Hashable](../../core/core_package_api/core_package_interfaces.md#interface-hashable)
- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

### prop annotations

```cangjie
public prop annotations: Collection<Annotation>
```

Function: Retrieves all annotations applied to the corresponding instance member property of this [InstancePropertyInfo](reflect_package_classes.md#class-instancepropertyinfo), returning the associated collection.

> **Note:**
>
> - If no annotations are applied to the corresponding instance member property, an empty collection is returned.
> - The collection does not guarantee a consistent iteration order.

Type: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[Annotation](../../ast/ast_package_api/ast_package_classes.md#class-annotation)>

### prop modifiers

```cangjie
public prop modifiers: Collection<ModifierInfo>
```

Function: Retrieves all modifier information for the corresponding instance member property of this [InstancePropertyInfo](reflect_package_classes.md#class-instancepropertyinfo), returning the associated collection.> **Note:**
>
> - If the instance member property has no modifiers, an empty collection is returned.
> - The collection does not guarantee a consistent iteration order.
> - Even if not explicitly modified by a certain modifier, if it possesses the semantics of that modifier, the modifier information will be included in this collection.

Type: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[ModifierInfo](reflect_package_enums.md#enum-modifierinfo)>

### prop name

```cangjie
public prop name: String
```

Function: Gets the name of the instance member property corresponding to this [InstancePropertyInfo](reflect_package_classes.md#class-instancepropertyinfo).

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop typeInfo

```cangjie
public prop typeInfo: TypeInfo
```

Function: Gets the type information of the declared type for the instance member property corresponding to this [InstancePropertyInfo](reflect_package_classes.md#class-instancepropertyinfo).

Type: [TypeInfo](reflect_package_classes.md#class-typeinfo)

### func findAnnotation\<T>() where T <: Annotation

```cangjie
public func findAnnotation<T>(): Option<T> where T <: Annotation
```

Function: Attempts to retrieve an annotation with the given qualified name that is applied to the instance member property corresponding to this [InstancePropertyInfo](reflect_package_classes.md#class-instancepropertyinfo).

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - Returns the annotation if successfully matched, otherwise returns `None`.

### func getValue(Any)

```cangjie
public func getValue(instance: Any): Any
```

Function: Gets the value of the instance member property corresponding to this [InstancePropertyInfo](reflect_package_classes.md#class-instancepropertyinfo) in the given instance.

Parameters:

- instance: [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - The instance.

Return Value:

- [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - The value of the instance member property in the instance `instance`.

Exceptions:

- [IllegalTypeException](reflect_package_exceptions.md#class-illegaltypeexception) - Thrown if the runtime type of the instance `instance` does not strictly match the type to which the instance member property corresponding to this instance member property information belongs.

Example:

<!-- verify -->
```cangjie
import std.reflect.*

public class Rectangular {
    public var length = 4
    public prop width: Int64 {
        get() {
            5
        }
    }
}

main(): Unit {
    // Here, ClassTypeInfo is obtained via the qualified name of Rectangular's type, or it can be obtained via an instance
    let ty = ClassTypeInfo.get("default.Rectangular")
    // Get InstancePropertyInfo
    var gip = ty.getInstanceProperty("width")

    // Get instance value
    var r = Rectangular()
    var result = gip.getValue(r) as Int64
    println(result)
    return
}
```

Execution Result:

```text
Some(5)
```

### func hashCode()

```cangjie
public func hashCode(): Int64
```

Function: Gets the hash value of this instance member property information.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The hash value of this instance member property information.

### func isAbstract()

```cangjie
public func isAbstract(): Bool
```

Function: Determines whether the instance member property corresponding to this [InstancePropertyInfo](reflect_package_classes.md#class-instancepropertyinfo) is abstract.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the instance member property corresponding to this [InstancePropertyInfo](reflect_package_classes.md#class-instancepropertyinfo) is abstract, otherwise returns `false`.

### func isOpen()

```cangjie
public func isOpen(): Bool
```

Function: Determines whether the instance member property corresponding to this [InstancePropertyInfo](reflect_package_classes.md#class-instancepropertyinfo) has `open` semantics.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the instance member property corresponding to this [InstancePropertyInfo](reflect_package_classes.md#class-instancepropertyinfo) has `open` semantics, otherwise returns `false`.

### func isMutable()

```cangjie
public func isMutable(): Bool
```

Function: Determines whether the instance member property corresponding to this [InstancePropertyInfo](reflect_package_classes.md#class-instancepropertyinfo) is mutable.

> **Note:**
>
> - If the instance member property is modified by the `mut` modifier, it can be modified; otherwise, it cannot.
> - Any instance member property of a `struct` type instance cannot be modified.
> - Any instance member property whose type is `struct` cannot be modified.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the instance member property corresponding to this instance member property information can be modified, otherwise returns `false`.

### func setValue(Any, Any)

```cangjie
public func setValue(instance: Any, newValue: Any): Unit
```

Function: Sets the value of the instance member property corresponding to this [InstancePropertyInfo](reflect_package_classes.md#class-instancepropertyinfo) in the given instance.

> **Note:**
>
> Currently, the instance `instance` does not support instances of `struct` type.

Parameters:

- instance: [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - The instance.
- newValue: [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - The new value.

Exceptions:

- [IllegalSetException](reflect_package_exceptions.md#class-illegalsetexception) - Thrown if the instance member property corresponding to this instance member property information cannot be modified.
- [IllegalTypeException](reflect_package_exceptions.md#class-illegaltypeexception) - Thrown if the runtime type of the instance `instance` does not strictly match the type to which the instance member property corresponding to this instance member property information belongs.
- [IllegalTypeException](reflect_package_exceptions.md#class-illegaltypeexception) - Thrown if the runtime type of the new value `newValue` is not a subtype of the declared type of the instance member property corresponding to this instance member property information.

### func toString()

```cangjie
public func toString(): String
```

Function: Gets a string representation of this instance member property information.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string representation of this instance member property information.

### operator func !=(InstancePropertyInfo)

```cangjie
public operator func !=(that: InstancePropertyInfo): Bool
```

Function: Determines whether this instance member property information is not equal to another given instance member property information.

Parameters:

- that: [InstancePropertyInfo](reflect_package_classes.md#class-instancepropertyinfo) - The other instance member property information to compare for equality.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if this instance member property information is not equal to `that`, otherwise returns `false`.

### operator func ==(InstancePropertyInfo)

```cangjie
public operator func ==(that: InstancePropertyInfo): Bool
```

Function: Determines whether this instance member property information is equal to another given instance member property information.

Parameters:

- that: [InstancePropertyInfo](reflect_package_classes.md#class-instancepropertyinfo) - The other instance member property information to compare for equality.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if this instance member property information is equal to `that`, otherwise returns `false`.

## class InstanceVariableInfo

```cangjie
public class InstanceVariableInfo <: Equatable<InstanceVariableInfo> & Hashable & ToString
```

Function: Describes instance member variable information.

Parent Types:

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[InstanceVariableInfo](#class-instancevariableinfo)>
- [Hashable](../../core/core_package_api/core_package_interfaces.md#interface-hashable)
- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

### prop annotations

```cangjie
public prop annotations: Collection<Annotation>
```

Function: Gets all annotations applied to the instance member variable corresponding to this [InstanceVariableInfo](reflect_package_classes.md#class-instancevariableinfo), returning the corresponding collection.

> **Note:**
>
> - If no annotations are applied to the instance member variable corresponding to this instance member variable information, an empty collection is returned.
> - The collection does not guarantee a consistent iteration order.

Type: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[Annotation](../../ast/ast_package_api/ast_package_classes.md#class-annotation)>

### prop modifiers

```cangjie
public prop modifiers: Collection<ModifierInfo>
```

Function: Gets all modifier information for the instance member variable corresponding to this [InstanceVariableInfo](reflect_package_classes.md#class-instancevariableinfo), returning the corresponding collection.

> **Note:**
>
> - If the instance member variable has no modifiers, an empty collection is returned.
> - The collection does not guarantee a consistent iteration order.
> - Even if not explicitly modified by a certain modifier, if it possesses the semantics of that modifier, the modifier information will be included in this collection.

Type: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[ModifierInfo](reflect_package_enums.md#enum-modifierinfo)>

### prop name

```cangjie
public prop name: String
```

Function: Gets the name of the instance member variable corresponding to this [InstanceVariableInfo](reflect_package_classes.md#class-instancevariableinfo).

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop typeInfo

```cangjie
public prop typeInfo: TypeInfo
```

Function: Gets the type information of the declared type for the instance member variable corresponding to this [InstanceVariableInfo](reflect_package_classes.md#class-instancevariableinfo).

Type: [TypeInfo](reflect_package_classes.md#class-typeinfo)

### func findAnnotation\<T>() where T <: Annotation

```cangjie
public func findAnnotation<T>(): Option<T> where T <: Annotation
```

Function: Attempts to retrieve an annotation with the given qualified name that is applied to the instance member variable corresponding to this [InstanceVariableInfo](reflect_package_classes.md#class-instancevariableinfo).

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - Returns the annotation if successfully matched, otherwise returns `None`.

### func getValue(Any)

```cangjie
public func getValue(instance: Any): Any
```

Function: Gets the value of the instance member variable corresponding to this [InstanceVariableInfo](reflect_package_classes.md#class-instancevariableinfo) in the given instance.Parameters:

- instance: [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - The instance.

Return Value:

- [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - The value of this instance member variable in the given `instance`.

Exceptions:

- [IllegalTypeException](reflect_package_exceptions.md#class-illegaltypeexception) - Throws if the runtime type of `instance` does not strictly match the type to which this instance member variable belongs.

Example:

<!-- verify -->
```cangjie
import std.reflect.*

public class Rectangular {
    public var length = 4
    public var width = 5
}

main(): Unit {
    // Here we obtain ClassTypeInfo via the qualified name of Rectangular's type, or alternatively via an instance
    let ty = ClassTypeInfo.get("default.Rectangular")
    // Get InstanceVariableInfo
    var gip = ty.getInstanceVariable("width")
    // Get instance value
    var r = Rectangular()
    let v = gip.getValue(r) as Int64
    println(v)
    return
}
```

Execution Result:

```text
Some(5)
```

### func hashCode()

```cangjie
public func hashCode(): Int64
```

Function: Gets the hash code of this instance member variable information.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The hash code of this instance member variable information.

### func isMutable()

```cangjie
public func isMutable(): Bool
```

Function: Determines whether the instance member variable corresponding to this [InstanceVariableInfo](reflect_package_classes.md#class-instancevariableinfo) is mutable.

> **Note:**
>
> - If the instance member variable is modified by the `var` modifier, it is mutable.
> - If the instance member variable is modified by the `let` modifier, it is immutable.
> - Any instance member variable of a `struct` type instance is immutable.
> - Any instance member variable whose type is `struct` is immutable.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the instance member variable corresponding to this information is mutable, otherwise returns `false`.

### func setValue(Any, Any)

```cangjie
public func setValue(instance: Any, newValue: Any): Unit
```

Function: Sets the value of the instance member variable corresponding to this [InstanceVariableInfo](reflect_package_classes.md#class-instancevariableinfo) in the given instance.

> **Note:**
>
> Currently, the `instance` parameter does not support instances of `struct` type.

Parameters:

- instance: [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - The instance.
- newValue: [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - The new value.

Exceptions:

- [IllegalSetException](reflect_package_exceptions.md#class-illegalsetexception) - Throws if the instance member variable corresponding to this information is immutable.
- [IllegalTypeException](reflect_package_exceptions.md#class-illegaltypeexception) - Throws if the runtime type of `instance` does not strictly match the type to which this instance member variable belongs.
- [IllegalTypeException](reflect_package_exceptions.md#class-illegaltypeexception) - Throws if the runtime type of `newValue` is not a subtype of the declared type of the instance member variable corresponding to this information.

### func toString()

```cangjie
public func toString(): String
```

Function: Gets the string representation of this instance member variable information.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string representation of this instance member variable information.

### operator func ==(InstanceVariableInfo)

```cangjie
public operator func ==(that: InstanceVariableInfo): Bool
```

Function: Determines whether this instance member variable information is equal to another given instance member variable information.

Parameters:

- that: [InstanceVariableInfo](reflect_package_classes.md#class-instancevariableinfo) - Another instance member variable information to compare for equality.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if this instance member variable information equals `that`, otherwise returns `false`.

### operator func !=(InstanceVariableInfo)

```cangjie
public operator func !=(that: InstanceVariableInfo): Bool
```

Function: Determines whether this instance member variable information is not equal to another given instance member variable information.

Parameters:

- that: [InstanceVariableInfo](reflect_package_classes.md#class-instancevariableinfo) - Another instance member variable information to compare for inequality.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if this instance member variable information does not equal `that`, otherwise returns `false`.

## class InterfaceTypeInfo

```cangjie
public class InterfaceTypeInfo <: TypeInfo
```

Function: Type information for `interface` types.

Parent Type:

- [TypeInfo](#class-typeinfo)

### prop sealedSubtypes

```cangjie
public prop sealedSubtypes: Collection<TypeInfo>
```

Function: If the `interface` type corresponding to this [InterfaceTypeInfo](reflect_package_classes.md#class-interfacetypeinfo) has `sealed` semantics, gets the type information of all subtypes within the package of this `interface` type, returning the corresponding collection.

> **Note:**
>
> - If this `interface` type does not have `sealed` semantics, returns an empty collection.
> - If this `interface` type has `sealed` semantics, the obtained collection cannot be empty because the `interface` type itself is a subtype of itself.

Type: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[TypeInfo](reflect_package_classes.md#class-typeinfo)>

### func isSealed()

```cangjie
public func isSealed(): Bool
```

Function: Determines whether the `interface` type corresponding to this [InterfaceTypeInfo](reflect_package_classes.md#class-interfacetypeinfo) has `sealed` semantics.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if this `interface` type has `sealed` semantics, otherwise returns `false`.

### static func get(String)

```cangjie
public redef static func get(qualifiedName: String): InterfaceTypeInfo
```

Function: Gets the [InterfaceTypeInfo](reflect_package_classes.md#class-interfacetypeinfo) corresponding to the type specified by `qualifiedName`.

Parameters:

- qualifiedName: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The qualified name of the type.

Return Value:

- [InterfaceTypeInfo](reflect_package_classes.md#class-interfacetypeinfo) - The type information of the `Interface` type corresponding to the qualified name `qualifiedName`.

Exceptions:

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - Throws if type information matching the given qualified name `qualifiedName` cannot be obtained.
- [IllegalTypeException](./reflect_package_exceptions.md#class-illegaltypeexception) - Throws if the obtained type information is not [InterfaceTypeInfo](reflect_package_classes.md#class-interfacetypeinfo).

Example:

<!-- verify -->
```cangjie
import std.reflect.*

public interface Rectangular {}

main(): Unit {
    let ty = InterfaceTypeInfo.get("default.Rectangular")
    println(ty)
    return
}
```

Execution Result:

```text
default.Rectangular
```

### static func of(Any)

```cangjie
public redef static func of(a: Any): InterfaceTypeInfo
```

Function: Gets the type information corresponding to the runtime type of the given instance.

The runtime type is determined through dynamic binding during program execution and is bound to the instance object. In inheritance scenarios, the runtime type may differ from the static type.

Parameters:

- a: [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - An instance of any type.

Return Value:

- [InterfaceTypeInfo](reflect_package_classes.md#class-interfacetypeinfo) - The type information corresponding to the runtime type of instance `a`.

Exceptions:

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - Throws if type information for the runtime type of instance `a` cannot be obtained.
- [IllegalTypeException](./reflect_package_exceptions.md#class-illegaltypeexception) - Throws if the obtained type information is not [InterfaceTypeInfo](reflect_package_classes.md#class-interfacetypeinfo).

### static func of\<T>()

```cangjie
public redef static func of<T>(): InterfaceTypeInfo
```

Function: Gets the type information corresponding to the given type `T`.

Return Value:

- [InterfaceTypeInfo](reflect_package_classes.md#class-interfacetypeinfo) - The type information corresponding to type `T`.

Exceptions:

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - Throws if type information for type T cannot be obtained.
- [IllegalTypeException](./reflect_package_exceptions.md#class-illegaltypeexception) - Throws if the obtained type information is not [InterfaceTypeInfo](reflect_package_classes.md#class-interfacetypeinfo).

## class PackageInfo

```cangjie
public class PackageInfo <: Equatable<PackageInfo> & Hashable & ToString
```

Function: Describes package information.

Parent Types:

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[PackageInfo](#class-packageinfo)>
- [Hashable](../../core/core_package_api/core_package_interfaces.md#interface-hashable)
- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

### prop functions

```cangjie
public prop functions: Collection<GlobalFunctionInfo>
```

Function: Gets the list of information for all `public` global functions in the package corresponding to this [PackageInfo](reflect_package_classes.md#class-packageinfo).

Type: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[GlobalFunctionInfo](reflect_package_classes.md#class-globalfunctioninfo)>

### prop name

```cangjie
public prop name: String
```

Function: Gets the name of the package corresponding to this package information.

> **Note:**
>
> The package name does not include its module name or parent package name. For example, the name of a package with qualified name `a/b.c.d` is `d`.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)### prop parentPackage

```cangjie
public prop parentPackage: PackageInfo
```

Function: Retrieves the [PackageInfo](reflect_package_classes.md#class-packageinfo) of the parent package corresponding to this [PackageInfo](reflect_package_classes.md#class-packageinfo).

Type: [PackageInfo](reflect_package_classes.md#class-packageinfo)

Exceptions:

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - Thrown if the parent package is not loaded.

### prop qualifiedName

```cangjie
public prop qualifiedName: String
```

Function: Retrieves the qualified name of the package corresponding to this [PackageInfo](reflect_package_classes.md#class-packageinfo).

> **Note:**
>
> The format of a package's qualified name is `(module_name/)?(default|package_name)(.package_name)*`. For example, a package with the qualified name `a/b.c.d` is located in module `a` within package `b`'s subpackage `c`.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop rootPackage

```cangjie
public prop rootPackage: PackageInfo
```

Function: Retrieves the [PackageInfo](reflect_package_classes.md#class-packageinfo) of the `root` package corresponding to this [PackageInfo](reflect_package_classes.md#class-packageinfo).

> **Note:**
>
> If the package itself is the `root` package, its `rootPackage` property returns itself. For example, for a package with qualified name `a.b.c`, `rootPackage` returns `a`; for a package with qualified name `a`, `rootPackage` returns `a`.

Type: [PackageInfo](reflect_package_classes.md#class-packageinfo)

Exceptions:

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - Thrown if the `root` package is not loaded.

### prop subPackages

```cangjie
public prop subPackages: Collection<PackageInfo>
```

Function: Retrieves a collection of [PackageInfo](reflect_package_classes.md#class-packageinfo) for all subpackages corresponding to this [PackageInfo](reflect_package_classes.md#class-packageinfo).

> **Note:**
>
> - This property only returns subpackages that have been loaded.
> - The order of returned results is not guaranteed.

Type: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[PackageInfo](reflect_package_classes.md#class-packageinfo)>

### prop typeInfos

```cangjie
public prop typeInfos: Collection<TypeInfo>
```

Function: Retrieves a collection of type information for all globally defined `public` types in the package corresponding to this [PackageInfo](reflect_package_classes.md#class-packageinfo).

> **Note:**
>
> Currently, this list does not include types not yet supported by reflection.

Type: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[TypeInfo](reflect_package_classes.md#class-typeinfo)>

### prop variables

```cangjie
public prop variables: Collection<GlobalVariableInfo>
```

Function: Retrieves a list of information for all `public` global variables in the package corresponding to this [PackageInfo](reflect_package_classes.md#class-packageinfo).

Type: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[GlobalVariableInfo](reflect_package_classes.md#class-globalvariableinfo)>

### prop version

```cangjie
public prop version: String
```

Function: Retrieves the version number of the package corresponding to this [PackageInfo](reflect_package_classes.md#class-packageinfo).

> **Note:**
>
> Since version information is currently unavailable in dynamic libraries, the returned version number is always an empty string.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### static func get(String)

```cangjie
public static func get(qualifiedName: String): PackageInfo
```

Function: Retrieves the [PackageInfo](./reflect_package_classes.md#class-packageinfo) corresponding to the given `qualifiedName`.

Parameters:

- qualifiedName: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The qualified name of the type.

Return Value:

- [PackageInfo](./reflect_package_classes.md#class-packageinfo) - The package information corresponding to the qualified name `qualifiedName`.

Exceptions:

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - Thrown if the type information corresponding to the given qualified name `qualifiedName` cannot be retrieved.

### static func load(String)

```cangjie
public static func load(path: String): PackageInfo
```

Function: Dynamically loads a Cangjie dynamic library module at runtime from the specified path and retrieves its information.

> **Note:**
>
> - For better compatibility, the shared library filename in the path `path` does not require an extension (e.g., `.so` or `.dll`).
> - If a `package` has already been imported via static loading (e.g., `import`), dynamically loading it will throw an exception.

Parameters:

- path: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The absolute or relative path to the shared library file.

Return Value:

- [PackageInfo](reflect_package_classes.md#class-packageinfo) - The package information of the specified Cangjie dynamic library.

Exceptions:

- [ReflectException](reflect_package_exceptions.md#class-reflectexception) - Thrown if the shared library fails to load.
- [ReflectException](reflect_package_exceptions.md#class-reflectexception) - Thrown if a shared library with the same package name or filename is reloaded.
- [ReflectException](reflect_package_exceptions.md#class-reflectexception) - Thrown if the dynamic library contains multiple Packages internally.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if the path is invalid.

### func getFunction(String, Array\<TypeInfo>)

```cangjie
public func getFunction(name: String, parameterTypes: Array<TypeInfo>): GlobalFunctionInfo
```

Function: Attempts to retrieve information for a `public` global function in the package corresponding to this [PackageInfo](reflect_package_classes.md#class-packageinfo) that matches the given function name and parameter type information list.

Parameters:

- name: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The name of the global function.
- parameterTypes: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[TypeInfo](reflect_package_classes.md#class-typeinfo)> - The list of parameter type information.

Return Value:

- [GlobalFunctionInfo](reflect_package_classes.md#class-globalfunctioninfo) - If a match is found, returns the function information for the globally defined `public` type.

Exceptions:

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - Thrown if no matching globally defined `public` global function is found.

### func getFunctions(String)

```cangjie
public func getFunctions(name: String): Array<GlobalFunctionInfo>
```

Function: Attempts to retrieve information for all `public` global functions in the package corresponding to this [PackageInfo](reflect_package_classes.md#class-packageinfo) that match the given function name.

Parameters:

- name: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The name of the global function.

Return Value:

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[GlobalFunctionInfo](reflect_package_classes.md#class-globalfunctioninfo)> - An array of information for all `public` global functions matching the given function name.

### func getSubPackage(String)

```cangjie
public func getSubPackage(qualifiedName: String): PackageInfo
```

Function: Attempts to retrieve information for the subpackage with the given qualified name `qualifiedName` under this [PackageInfo](reflect_package_classes.md#class-packageinfo).

Parameters:

- qualifiedName: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The qualified name of the subpackage.

Return Value:

- [PackageInfo](reflect_package_classes.md#class-packageinfo) - The package information of the subpackage.

Exceptions:

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - Thrown if the subpackage does not exist or is not loaded.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if `qualifiedName` is invalid.

### func getTypeInfo(String)

```cangjie
public func getTypeInfo(qualifiedTypeName: String): TypeInfo
```

Function: Attempts to retrieve type information for a globally defined `public` type in the package corresponding to this [PackageInfo](reflect_package_classes.md#class-packageinfo) that matches the given type name.

Parameters:

- qualifiedTypeName: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The qualified name of the type.

Return Value:

- [TypeInfo](reflect_package_classes.md#class-typeinfo) - If a match is found, returns the type information for the globally defined `public` type.

Exceptions:

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - Thrown if no matching globally defined `public` type is found.

### func getVariable(String)

```cangjie
public func getVariable(name: String): GlobalVariableInfo
```

Function: Attempts to retrieve information for a `public` global variable in the package corresponding to this [PackageInfo](reflect_package_classes.md#class-packageinfo) that matches the given variable name.

Parameters:

- name: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The name of the global variable.

Return Value:

- [GlobalVariableInfo](reflect_package_classes.md#class-globalvariableinfo) - If a match is found, returns the variable information for the globally defined `public` type.

Exceptions:

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - Thrown if no matching globally defined `public` global variable is found.

### func hashCode()

```cangjie
public func hashCode(): Int64
```

Function: Retrieves the hash value of this package information.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The hash value of this package information.

### func toString()

```cangjie
public func toString(): String
```

Function: Retrieves a string representation of this package information.

> **Note:**
>
> The internal implementation returns the qualified name string of this package information.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string representation of this package information.

### operator func !=(PackageInfo)

```cangjie
public operator func !=(that: PackageInfo): Bool
```

Function: Determines whether this package information is not equal to another given package information.

> **Note:**
>
> The internal implementation compares the qualified names of the two package information objects.

Parameters:

- that: [PackageInfo](reflect_package_classes.md#class-packageinfo) - The other package information to compare for equality.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if this package information is not equal to `that`, otherwise returns `false`.

### operator func ==(PackageInfo)

```cangjie
public operator func ==(that: PackageInfo): Bool
```

Function: Determines whether this package information is equal to another given package information.> **Note:**
>
> The internal implementation compares whether the qualified names of two package information are equal.

Parameters:

- that: [PackageInfo](reflect_package_classes.md#class-packageinfo) - The other package information to compare for equality.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if this package information is equal to `that`, otherwise returns `false`.

## class ParameterInfo

```cangjie
public class ParameterInfo <: Equatable<ParameterInfo> & Hashable & ToString
```

Function: Describes function parameter information.

Parent Types:

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[ParameterInfo](#class-parameterinfo)>
- [Hashable](../../core/core_package_api/core_package_interfaces.md#interface-hashable)
- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

### prop annotations

```cangjie
public prop annotations: Collection<Annotation>
```

Function: Retrieves all annotations applied to the function parameter corresponding to this [ParameterInfo](reflect_package_classes.md#class-parameterinfo), returning the corresponding collection.

> **Note:**
>
> - If no annotations are applied to the function parameter corresponding to this function parameter information, an empty collection is returned.
> - The collection does not guarantee a consistent traversal order.

Type: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[Annotation](../../ast/ast_package_api/ast_package_classes.md#class-annotation)>

### prop index

```cangjie
public prop index: Int64
```

Function: Retrieves the positional index of the parameter corresponding to this [ParameterInfo](reflect_package_classes.md#class-parameterinfo) within its containing function.

> **Note:**
>
> `index` starts counting from 0.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### prop name

```cangjie
public prop name: String
```

Function: Retrieves the name of the parameter corresponding to this [ParameterInfo](reflect_package_classes.md#class-parameterinfo).

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop typeInfo

```cangjie
public prop typeInfo: TypeInfo
```

Function: Retrieves the type information corresponding to the declared type of the function parameter described by this [ParameterInfo](reflect_package_classes.md#class-parameterinfo).

Type: [TypeInfo](reflect_package_classes.md#class-typeinfo)

### func findAnnotation\<T>() where T <: Annotation

```cangjie
public func findAnnotation<T>(): Option<T> where T <: Annotation
```

Function: Attempts to retrieve an annotation applied to the function parameter corresponding to this [ParameterInfo](reflect_package_classes.md#class-parameterinfo) that matches the given qualified name.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - Returns the annotation if successfully matched, otherwise returns `None`.

### func hashCode()

```cangjie
public func hashCode(): Int64
```

Function: Retrieves the hash value of this function parameter information.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The hash value of this function parameter information.

### func toString()

```cangjie
public func toString(): String
```

Function: Retrieves a string representation of this function parameter information.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string representation of this function parameter information.

### operator func !=(ParameterInfo)

```cangjie
public operator func !=(that: ParameterInfo): Bool
```

Function: Determines whether this function parameter information is not equal to another given function parameter information.

Parameters:

- that: [ParameterInfo](reflect_package_classes.md#class-parameterinfo) - The other function parameter information to compare for equality.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if this function parameter information is not equal to `that`, otherwise returns `false`.

### operator func ==(ParameterInfo)

```cangjie
public operator func ==(that: ParameterInfo): Bool
```

Function: Determines whether this function parameter information is equal to another given function parameter information.

Parameters:

- that: [ParameterInfo](reflect_package_classes.md#class-parameterinfo) - The other function parameter information to compare for equality.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if this function parameter information is equal to `that`, otherwise returns `false`.

## class PrimitiveTypeInfo

```cangjie
public class PrimitiveTypeInfo <: TypeInfo
```

Function: Describes type information for primitive data types.

Primitive data types include the untyped (`Nothing`), unit type ([Unit](../../core/core_package_api/core_package_intrinsics.md#unit)), character type ([Rune](../../../std_en/core/core_package_api/core_package_intrinsics.md#rune)), boolean type ([Bool](../../core/core_package_api/core_package_intrinsics.md#bool)), integer types ([Int8](../../core/core_package_api/core_package_intrinsics.md#int8), [Int16](../../core/core_package_api/core_package_intrinsics.md#int16), [Int32](../../core/core_package_api/core_package_intrinsics.md#int32), [Int64](../../core/core_package_api/core_package_intrinsics.md#int64), [IntNative](../../core/core_package_api/core_package_intrinsics.md#intnative), [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8), [UInt16](../../core/core_package_api/core_package_intrinsics.md#uint16), [UInt32](../../core/core_package_api/core_package_intrinsics.md#uint32), [UInt64](../../core/core_package_api/core_package_intrinsics.md#uint64), [UIntNative](../../core/core_package_api/core_package_intrinsics.md#uintnative)), and floating-point types ([Float16](../../core/core_package_api/core_package_intrinsics.md#float16), [Float32](../../core/core_package_api/core_package_intrinsics.md#float32), [Float64](../../core/core_package_api/core_package_intrinsics.md#float64)).

> **Note:**
>
> The `Nothing` primitive data type is currently not supported.

Parent Type:

- [TypeInfo](#class-typeinfo)

### static func get(String)

```cangjie
public static redef func get(qualifiedName: String): PrimitiveTypeInfo
```

Function: Retrieves the [PrimitiveTypeInfo](reflect_package_classes.md#class-primitivetypeinfo) corresponding to the type specified by the given qualified name.

Parameters:

- qualifiedName: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The qualified name of the type.

Return Value:

- [PrimitiveTypeInfo](reflect_package_classes.md#class-primitivetypeinfo) - The type information corresponding to the type specified by the qualified name `qualifiedName`.

Exceptions:

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - Thrown if type information matching the given qualified name `qualifiedName` cannot be retrieved.
- [IllegalTypeException](./reflect_package_exceptions.md#class-illegaltypeexception) - Thrown if the retrieved type information is not a [PrimitiveTypeInfo](reflect_package_classes.md#class-primitivetypeinfo).

Example:

<!-- verify -->
```cangjie
import std.reflect.*

main(): Unit {
    var pti = PrimitiveTypeInfo.get("Int64")
    println(pti)
    return
}
```

Output:

```text
Int64
```

### static func of(Any)

```cangjie
public static redef func of(a: Any): PrimitiveTypeInfo
```

Function: Retrieves the type information corresponding to the runtime type of the given instance of any type.

The runtime type refers to the type determined through dynamic binding during program execution, which is bound to the instance object. In inheritance scenarios, the runtime type may differ from the static type.

Parameters:

- a: [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - An instance of any type.

Return Value:

- [PrimitiveTypeInfo](reflect_package_classes.md#class-primitivetypeinfo) - The type information corresponding to the runtime type of instance `a`.

Exceptions:

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - Thrown if the type information corresponding to the runtime type of instance `a` cannot be retrieved.
- [IllegalTypeException](./reflect_package_exceptions.md#class-illegaltypeexception) - Thrown if the retrieved type information is not a [PrimitiveTypeInfo](reflect_package_classes.md#class-primitivetypeinfo).

Example:

<!-- verify -->
```cangjie
import std.reflect.*

main(): Unit {
    var a = 10
    var pti = PrimitiveTypeInfo.of(a)
    println(pti)
    return
}
```

Output:

```text
Int64
```

### static func of\<T>()

```cangjie
public static redef func of<T>(): PrimitiveTypeInfo
```

Function: Retrieves the type information corresponding to the given type `T`.

Return Value:

- [PrimitiveTypeInfo](reflect_package_classes.md#class-primitivetypeinfo) - The type information corresponding to type `T`.

Exceptions:

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - Thrown if the type information corresponding to type T cannot be retrieved.
- [IllegalTypeException](./reflect_package_exceptions.md#class-illegaltypeexception) - Thrown if the retrieved type information is not a [PrimitiveTypeInfo](reflect_package_classes.md#class-primitivetypeinfo).

Example:

<!-- verify -->
```cangjie
import std.reflect.*

main(): Unit {
    var pti = PrimitiveTypeInfo.of<Int64>()
    println(pti)
    return
}
```

Output:

```text
Int64
```

## class StaticFunctionInfo

```cangjie
public class StaticFunctionInfo <: Equatable<StaticFunctionInfo> & Hashable & ToString
```

Function: Describes static member function information.

Parent Types:

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[StaticFunctionInfo](#class-staticfunctioninfo)>
- [Hashable](../../core/core_package_api/core_package_interfaces.md#interface-hashable)
- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

### prop annotations

```cangjie
public prop annotations: Collection<Annotation>
```

Function: Retrieve all annotations applied to the static member function corresponding to this [StaticFunctionInfo](reflect_package_classes.md#class-staticfunctioninfo), returning the corresponding collection.

> **Note:**
>
> - If no annotations are applied to the static member function corresponding to this [StaticFunctionInfo](reflect_package_classes.md#class-staticfunctioninfo), an empty collection is returned.
> - The collection does not guarantee a consistent iteration order.

Type: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[Annotation](../../ast/ast_package_api/ast_package_classes.md#class-annotation)>

### prop genericParams

```cangjie
public prop genericParams: Collection<GenericTypeInfo>
```

Function: Retrieve the list of generic parameter information for the instance member function corresponding to this [StaticFunctionInfo](reflect_package_classes.md#class-staticfunctioninfo).

Type: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[GenericTypeInfo](reflect_package_classes.md#class-generictypeinfo)>

Exceptions:

- [InfoNotFoundException](./reflect_package_exceptions.md#class-infonotfoundexception) - Thrown when the [GlobalFunctionInfo](reflect_package_classes.md#class-globalfunctioninfo) has no generic parameters.

### prop modifiers

```cangjie
public prop modifiers: Collection<ModifierInfo>
```

Function: Retrieve all modifier information for the static member function corresponding to this [StaticFunctionInfo](reflect_package_classes.md#class-staticfunctioninfo), returning the corresponding collection.

> **Note:**
>
> - If the static member function has no modifiers, an empty collection is returned.
> - The collection does not guarantee a consistent iteration order.
> - Even if not explicitly modified by a certain modifier, if it possesses the semantics of that modifier, the modifier information will still be included in this collection.

Type: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[ModifierInfo](reflect_package_enums.md#enum-modifierinfo)>

### prop name

```cangjie
public prop name: String
```

Function: Retrieve the name of the static member function corresponding to this [StaticFunctionInfo](reflect_package_classes.md#class-staticfunctioninfo).

> **Note:**
>
> All overloaded static member functions will share the same name.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop parameters

```cangjie
public prop parameters: ReadOnlyList<ParameterInfo>
```

Function: Retrieve the parameter information list for the static member function corresponding to this [StaticFunctionInfo](reflect_package_classes.md#class-staticfunctioninfo).

> **Note:**
>
> The parameter order is not guaranteed; the actual position can be determined using the `index` property of `ParameterInfo`.

Type: [ReadOnlyList](../../collection/collection_package_api/collection_package_interface.md#interface-readonlylistt)\<[ParameterInfo](reflect_package_classes.md#class-parameterinfo)>

### prop returnType

```cangjie
public prop returnType: TypeInfo
```

Function: Retrieve the type information of the return value type for the static member function corresponding to this [StaticFunctionInfo](reflect_package_classes.md#class-staticfunctioninfo).

Type: [TypeInfo](reflect_package_classes.md#class-typeinfo)

### func apply(TypeInfo, Array\<Any>)

```cangjie
public func apply(thisType: TypeInfo, args: Array<Any>): Any
```

Function: Invoke the static member function corresponding to this [StaticFunctionInfo](reflect_package_classes.md#class-staticfunctioninfo), passing the type information of the method's owning class and the argument list, then return the invocation result.

> **Note:**
>
> The types of `args` must exactly match the function's parameter types; otherwise, parameter validation will fail.

Parameters:

- thisType: [TypeInfo](./reflect_package_classes.md#class-typeinfo) - The class to which this method belongs.
- args: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Any](../../core/core_package_api/core_package_interfaces.md#interface-any)> - The argument list.

Return Value:

- [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - The invocation result of the static member function.

Exceptions:

- [InvocationTargetException](reflect_package_exceptions.md#class-invocationtargetexception) - Thrown if the static member function corresponding to this function info has generic parameters.
- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - Thrown if the function body of the static member function corresponding to this function info is not implemented.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if the number of arguments in `args` does not match the number of parameters in the static member function's parameter list.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if `thisType` does not match the function signature of the static function.
- [IllegalTypeException](reflect_package_exceptions.md#class-illegaltypeexception) - Thrown if the runtime type of any argument in `args` is not a subtype of the declared type of the corresponding parameter in the static member function.
- [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception) - If the static member function internally throws an exception, it will be wrapped as an [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception) and rethrown.

Example:

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class Rectangular {
    public static func myName(): String {
        "my name is Rectangular"
    }
}

main(): Unit {
    // Here, ClassTypeInfo is obtained via the qualified name of Rectangular's type, or it can be obtained via an instance
    let ty = ClassTypeInfo.get("test.Rectangular")

    // Retrieve the static function
    let sf = ty.getStaticFunction("myName")

    let result = sf.apply(ty) as String
    println(result)
    return
}
```

Execution Result:

```text
Some(my name is Rectangular)
```

### func apply(TypeInfo, Array\<TypeInfo>, Array\<Any>)

```cangjie
public func apply(thisType: TypeInfo, genericTypeArgs: Array<TypeInfo>, args: Array<Any>): Any
```

Function: Invoke the static member function corresponding to this [StaticFunctionInfo](reflect_package_classes.md#class-staticfunctioninfo), passing the type information of the method's owning class, the generic type argument list, and the argument list, then return the invocation result.

> **Note:**
>
> The types of `args` must exactly match the function's parameter types; otherwise, parameter validation will fail.

Parameters:

- thisType: [TypeInfo](./reflect_package_classes.md#class-typeinfo) - The class to which this method belongs.
- genericTypeArgs: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[TypeInfo](./reflect_package_classes.md#class-typeinfo)> - The generic type argument list.
- args: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Any](../../core/core_package_api/core_package_interfaces.md#interface-any)> - The argument list.

Return Value:

- [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - The invocation result of the static member function.

Exceptions:

- [InvocationTargetException](reflect_package_exceptions.md#class-invocationtargetexception) - Thrown if the static member function corresponding to this function info is non-generic.
- [InfoNotFoundException](../reflect_package_api/reflect_package_exceptions.md#class-infonotfoundexception) - Thrown if the function body of the static member function corresponding to this function info is not implemented.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if the number of arguments in `args` does not match the number of parameters in the static member function's parameter list.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if the number of generic type arguments in `genericTypeArgs` does not match the number of generic parameters in the static member function.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if `thisType` does not match the function signature of the static function.
- [IllegalTypeException](reflect_package_exceptions.md#class-illegaltypeexception) - Thrown if the runtime type of any argument in `args` is not a subtype of the declared type of the corresponding parameter in the static member function.
- [IllegalTypeException](reflect_package_exceptions.md#class-illegaltypeexception) - Thrown if the argument list `args` and generic type argument list `genericTypeArgs` do not satisfy the type constraints of the static member function's parameters.
- [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception) - If the static member function internally throws an exception, it will be wrapped as an [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception) and rethrown.

### func findAnnotation\<T>() where T <: Annotation

```cangjie
public func findAnnotation<T>(): Option<T> where T <: Annotation
```

Function: Attempt to retrieve an annotation with the given qualified name applied to the static member function corresponding to this [StaticFunctionInfo](reflect_package_classes.md#class-staticfunctioninfo).

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - Returns the annotation if matched successfully, otherwise returns `None`.

### func hashCode()

```cangjie
public func hashCode(): Int64
```

Function: Retrieve the hash value of this static member function information.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The hash value of this static member function information.

### func toString()

```cangjie
public func toString(): String
```

Function: Retrieve a string representation of this static member function information.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string representation of this static member function information.

### operator func !=(StaticFunctionInfo)

```cangjie
public operator func !=(that: StaticFunctionInfo): Bool
```

Function: Determine whether this static member function information is not equal to another given static member function information.

Parameters:

- that: [StaticFunctionInfo](reflect_package_classes.md#class-staticfunctioninfo) - The other static member function information to compare for equality.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if this static member function information is not equal to `that`, otherwise returns `false`.

### operator func ==(StaticFunctionInfo)

```cangjie
public operator func ==(that: StaticFunctionInfo): Bool
```

Function: Determine whether this static member function information is equal to another given static member function information.

Parameters:

- that: [StaticFunctionInfo](reflect_package_classes.md#class-staticfunctioninfo) - The other static member function information to compare for equality.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if this static member function information is equal to `that`, otherwise returns `false`.

## class StaticPropertyInfo

```cangjie
public class StaticPropertyInfo <: Equatable<StaticPropertyInfo> & Hashable & ToString
```

Function: Describes static member property information.

Parent Types:

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[StaticPropertyInfo](#class-staticpropertyinfo)>
- [Hashable](../../core/core_package_api/core_package_interfaces.md#interface-hashable)
- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

### prop annotations

```cangjie
public prop annotations: Collection<Annotation>
```

Function: Retrieve the collection of all annotations applied to the static member property corresponding to this [StaticPropertyInfo](reflect_package_classes.md#class-staticpropertyinfo).

> **Note:**
>
> - If no annotations are applied to the static member property corresponding to this static member property info, an empty collection is returned.
> - The collection does not guarantee a consistent iteration order.

Type: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[Annotation](../../ast/ast_package_api/ast_package_classes.md#class-annotation)>

### prop modifiers

```cangjie
public prop modifiers: Collection<ModifierInfo>
```

Function: Retrieve all modifier information for the static member property corresponding to this [StaticPropertyInfo](reflect_package_classes.md#class-staticpropertyinfo), returning the corresponding collection.

> **Note:**
>
> - If the static member property has no modifiers, an empty collection is returned.
> - The collection does not guarantee a consistent iteration order.
> - Currently, the retrieved modifier collection content is somewhat chaotic and not yet standardized.

Type: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[ModifierInfo](reflect_package_enums.md#enum-modifierinfo)>

### prop name

```cangjie
public prop name: String
```

Function: Retrieve the name of the static member property corresponding to this [StaticPropertyInfo](reflect_package_classes.md#class-staticpropertyinfo).

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop typeInfo

```cangjie
public prop typeInfo: TypeInfo
```

Function: Gets the type information of the declaration type corresponding to this [StaticPropertyInfo](reflect_package_classes.md#class-staticpropertyinfo) static member property.

Type: [TypeInfo](reflect_package_classes.md#class-typeinfo)

### func findAnnotation\<T>() where T <: Annotation

```cangjie
public func findAnnotation<T>(): Option<T> where T <: Annotation
```

Function: Attempts to retrieve an annotation with the given qualified name that acts on the static member property corresponding to this [StaticPropertyInfo](reflect_package_classes.md#class-staticpropertyinfo).

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - Returns the annotation if successfully matched, otherwise returns `None`.

### func getValue()

```cangjie
public func getValue(): Any
```

Function: Gets the value of the static member property corresponding to this [StaticPropertyInfo](reflect_package_classes.md#class-staticpropertyinfo).

> **Note:**
>
> If the static member property lacks a valid implementation, such as an abstract static member property in an `interface` type, it should throw an [UnsupportedException](../../core/core_package_api/core_package_exceptions.md#class-unsupportedexception). However, this is not yet implemented due to lack of backend support.

Return Value:

- [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - The value of the static member property.

Example:

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class Rectangular {
    public static prop sides: Int64 {
        get() { 4 }
    }
    public static prop angles: Int64 {
        get() { 4 }
    }
}

main(): Unit {
    // Here, ClassTypeInfo is obtained via the qualified name of Rectangular's type, but it can also be obtained via an instance
    let ty = ClassTypeInfo.get("test.Rectangular")

    // Get static property
    let sp = ty.getStaticProperty("sides")

    let result = sp.getValue() as Int64
    println(result)
    return
}
```

Execution Result:

```text
Some(4)
```

### func hashCode()

```cangjie
public func hashCode(): Int64
```

Function: Gets the hash value of this static member property information.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The hash value of this static member property information.

### func isMutable()

```cangjie
public func isMutable(): Bool
```

Function: Determines whether the static member property corresponding to this static member property information can be modified.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the static member property can be modified, otherwise returns `false`.

> **Note:**
>
> - If the static member property is modified by the `mut` modifier, it can be modified; otherwise, it cannot.
> - Any static member property of a `struct` type cannot be modified.
> - Any static member property whose type is `struct` cannot be modified.

### func setValue(Any)

```cangjie
public func setValue(newValue: Any): Unit
```

Function: Sets the value of the static member property corresponding to this [StaticPropertyInfo](reflect_package_classes.md#class-staticpropertyinfo).

> **Note:**
>
> If the static member property lacks a valid implementation, such as an abstract static member property in an `interface` type, it should throw an [UnsupportedException](../../core/core_package_api/core_package_exceptions.md#class-unsupportedexception). However, this is not yet implemented due to lack of backend support.

Parameters:

- newValue: [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - The new value.

Exceptions:

- [IllegalSetException](reflect_package_exceptions.md#class-illegalsetexception) - Thrown if the static member property corresponding to this static member property information cannot be modified.
- [IllegalTypeException](reflect_package_exceptions.md#class-illegaltypeexception) - Thrown if the runtime type of `newValue` is not a subtype of the declaration type of the static member property corresponding to this static member property information.

Example:

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class Rectangular {
    private static var valueArea = 0
    public static mut prop area: Int64 {
        get() { valueArea }
        set(v) { valueArea = v }
    }
}

main(): Unit {
    // Here, ClassTypeInfo is obtained via the qualified name of Rectangular's type, but it can also be obtained via an instance
    let ty = ClassTypeInfo.get("test.Rectangular")

    // Get static property
    let sp = ty.getStaticProperty("area")

    // Set the value of the static member property
    sp.setValue(10)
    let result = sp.getValue() as Int64
    println(result)
    return
}
```

Execution Result:

```text
Some(10)
```

### func toString()

```cangjie
public func toString(): String
```

Function: Gets the string representation of this static member property information.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string representation of this static member property information.

### operator func !=(StaticPropertyInfo)

```cangjie
public operator func !=(that: StaticPropertyInfo): Bool
```

Function: Determines whether this static member property information is not equal to another given static member property information.

Parameters:

- that: [StaticPropertyInfo](reflect_package_classes.md#class-staticpropertyinfo) - Another static member property information to compare for equality.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if this static member property information is not equal to `that`, otherwise returns `false`.

### operator func ==(StaticPropertyInfo)

```cangjie
public operator func ==(that: StaticPropertyInfo): Bool
```

Function: Determines whether this static member property information is equal to another given static member property information.

Parameters:

- that: [StaticPropertyInfo](reflect_package_classes.md#class-staticpropertyinfo) - Another static member property information to compare for equality.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if this static member property information is equal to `that`, otherwise returns `false`.

## class StaticVariableInfo

```cangjie
public class StaticVariableInfo <: Equatable<StaticVariableInfo> & Hashable & ToString
```

Function: Describes static member variable information.

Parent Types:

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[StaticVariableInfo](#class-staticvariableinfo)>
- [Hashable](../../core/core_package_api/core_package_interfaces.md#interface-hashable)
- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

### prop annotations

```cangjie
public prop annotations: Collection<Annotation>
```

Function: Gets all annotations acting on the static member variable corresponding to this [StaticVariableInfo](reflect_package_classes.md#class-staticvariableinfo), returning the corresponding collection.

> **Note:**
>
> - If no annotations act on the static member variable corresponding to this [StaticVariableInfo](reflect_package_classes.md#class-staticvariableinfo), an empty collection is returned.
> - The collection does not guarantee a constant traversal order.

Type: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[Annotation](../../ast/ast_package_api/ast_package_classes.md#class-annotation)>

### prop modifiers

```cangjie
public prop modifiers: Collection<ModifierInfo>
```

Function: Gets all modifier information for the static member variable corresponding to this [StaticVariableInfo](reflect_package_classes.md#class-staticvariableinfo), returning the corresponding collection.

> **Note:**
>
> - If the static member variable has no modifiers, an empty collection is returned.
> - The collection does not guarantee a constant traversal order.
> - Currently, the content of the obtained modifier collection is somewhat chaotic and not yet unified.

Type: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[ModifierInfo](reflect_package_enums.md#enum-modifierinfo)>

### prop name

```cangjie
public prop name: String
```

Function: Gets the name of the static member variable corresponding to this [StaticVariableInfo](reflect_package_classes.md#class-staticvariableinfo).

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop typeInfo

```cangjie
public prop typeInfo: TypeInfo
```

Function: Gets the type information of the declaration type corresponding to this [StaticVariableInfo](reflect_package_classes.md#class-staticvariableinfo) static member variable.

Type: [TypeInfo](reflect_package_classes.md#class-typeinfo)

### func findAnnotation\<T>() where T <: Annotation

```cangjie
public func findAnnotation<T>(): Option<T> where T <: Annotation
```

Function: Attempts to retrieve an annotation with the given qualified name that acts on the static member variable corresponding to this [StaticVariableInfo](reflect_package_classes.md#class-staticvariableinfo).

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - Returns the annotation if successfully matched, otherwise returns `None`.

### func getValue()

```cangjie
public func getValue(): Any
```

Function: Gets the value of the static member variable corresponding to this [StaticVariableInfo](reflect_package_classes.md#class-staticvariableinfo).

Return Value:

- [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - The value of the static member variable.

Example:

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class Rectangular {
    public static var area: Int64 = 10
}

main(): Unit {
    // Here, ClassTypeInfo is obtained through the qualified name of the Rectangular type, or it can also be obtained through an instance
    let ty = ClassTypeInfo.get("test.Rectangular")

    // Get static variable
    let sv = ty.getStaticVariable("area")
    // Get value
    println(sv.getValue() as Int64)
    return
}
```

Execution result:

```text
Some(10)
```

### func hashCode()

```cangjie
public func hashCode(): Int64
```

Function: Get the hash value of this static member variable information.

Return value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The hash value of this static member variable information.

### func isMutable()

```cangjie
public func isMutable(): Bool
```

Function: Determine whether the static member variable corresponding to this [StaticVariableInfo](reflect_package_classes.md#class-staticvariableinfo) can be modified.

> **Note:**
>
> - If the static member variable is modified by the `var` modifier, it can be modified.
> - If the static member variable is modified by the `let` modifier, it cannot be modified.
> - Any static member variable of any `struct` type cannot be modified.
> - Any static member variable whose type is `struct` cannot be modified.

Return value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the static member variable corresponding to this static member variable information can be modified, otherwise returns `false`.

### func setValue(Any)

```cangjie
public func setValue(newValue: Any): Unit
```

Function: Set the value of the static member variable corresponding to this [StaticVariableInfo](reflect_package_classes.md#class-staticvariableinfo).

Parameters:

- newValue: [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - The new value.

Exceptions:

- [IllegalSetException](reflect_package_exceptions.md#class-illegalsetexception) - Thrown if the static member variable corresponding to this [StaticVariableInfo](reflect_package_classes.md#class-staticvariableinfo) cannot be modified.
- [IllegalTypeException](reflect_package_exceptions.md#class-illegaltypeexception) - Thrown if the runtime type of the new value `newValue` is not a subtype of the declared type of the static member variable corresponding to this static member variable information.

Example:

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class Rectangular {
    public static var area: Int64 = 10
}

main(): Unit {
    // Here, ClassTypeInfo is obtained through the qualified name of the Rectangular type, or it can also be obtained through an instance
    let ty = ClassTypeInfo.get("test.Rectangular")

    // Get static variable
    let sv = ty.getStaticVariable("area")

    // Set value
    sv.setValue(20)
    println(sv.getValue() as Int64)
    return
}
```

Execution result:

```text
Some(20)
```

### func toString()

```cangjie
public func toString(): String
```

Function: Get the string representation of this static member variable information.

Return value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string representation of this static member variable information.

### operator func !=(StaticVariableInfo)

```cangjie
public operator func !=(that: StaticVariableInfo): Bool
```

Function: Determine whether this static member variable information is not equal to another given static member variable information.

Parameters:

- that: [StaticVariableInfo](reflect_package_classes.md#class-staticvariableinfo) - Another static member variable information to compare for equality.

Return value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if this static member variable information is not equal to `that`, otherwise returns `false`.

### operator func ==(StaticVariableInfo)

```cangjie
public operator func ==(that: StaticVariableInfo): Bool
```

Function: Determine whether this static member variable information is equal to another given static member variable information.

Parameters:

- that: [StaticVariableInfo](reflect_package_classes.md#class-staticvariableinfo) - Another static member variable information to compare for equality.

Return value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if this static member variable information is equal to `that`, otherwise returns `false`.

## class StructTypeInfo

```cangjie
public class StructTypeInfo <: TypeInfo
```

Function: Describes the type information of a `struct` type.

Parent type:

- [TypeInfo](#class-typeinfo)

### prop constructors

```cangjie
public prop constructors: Collection<ConstructorInfo>
```

Function: Get all `public` constructor information of the `struct` corresponding to this [StructTypeInfo](reflect_package_classes.md#class-structtypeinfo), returning the corresponding collection.

> **Note:**
>
> - If the `struct` type has no `public` constructors, an empty collection is returned.
> - The collection does not guarantee a constant traversal order.

Type: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[ConstructorInfo](reflect_package_classes.md#class-constructorinfo)>

### prop instanceVariables

```cangjie
public prop instanceVariables: Collection<InstanceVariableInfo>
```

Function: Get all `public` instance member variable information of the `struct` corresponding to this [StructTypeInfo](reflect_package_classes.md#class-structtypeinfo), returning the corresponding collection.

> **Note:**
>
> - If the `struct` type has no `public` instance member variables, an empty collection is returned.
> - The collection does not guarantee a constant traversal order.

Type: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[InstanceVariableInfo](reflect_package_classes.md#class-instancevariableinfo)>

### prop staticVariables

```cangjie
public prop staticVariables: Collection<StaticVariableInfo>
```

Function: Get all `public` static member variable information of the `struct` corresponding to this [StructTypeInfo](reflect_package_classes.md#class-structtypeinfo), returning the corresponding collection.

> **Note:**
>
> - If the `struct` type has no `public` static member variables, an empty collection is returned.
> - The collection does not guarantee a constant traversal order.

Type: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[StaticVariableInfo](reflect_package_classes.md#class-staticvariableinfo)>

### func construct(Array\<Any>)

```cangjie
public func construct(args: Array<Any>): Any
```

Function: Search for a matching constructor in the `struct` type corresponding to this [StructTypeInfo](reflect_package_classes.md#class-structtypeinfo) based on the argument list and invoke it, passing the argument list, and return the invocation result.

Parameters:

- args: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Any](../../core/core_package_api/core_package_interfaces.md#interface-any)> - The argument list.

Return value:

- [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - An instance of the `struct` type.

Exceptions:

- [MisMatchException](reflect_package_exceptions.md#class-mismatchexception) - Thrown if `args` fails to match any `public` constructor of the `struct` type.
- [InvocationTargetException](reflect_package_exceptions.md#class-invocationtargetexception) - Any exception thrown inside the invoked constructor will be wrapped as an [InvocationTargetException](reflect_package_exceptions.md#class-invocationtargetexception) and thrown.

Example:

<!-- verify -->
```cangjie
import std.reflect.*

public struct Rectangular {
    public var length = 4
    public var width = 5
    public init() {}
    public init(length: Int64, width: Int64) {
        this.length = length
        this.width = width
    }
}

main(): Unit {
    // Here, StructTypeInfo is obtained through the qualified name of the Rectangular type, or it can also be obtained through an instance
    let ty = StructTypeInfo.get("default.Rectangular")
    // Match and invoke constructor
    let v = ty.construct(2, 3) as Rectangular
    println(v.getOrThrow().length)
    return
}
```

Execution result:

```text
2
```

### func getConstructor(Array\<TypeInfo>)

```cangjie
public func getConstructor(parameterTypes: Array<TypeInfo>): ConstructorInfo
```

Function: Attempt to get the information of a `public` constructor in the `struct` type corresponding to this [StructTypeInfo](reflect_package_classes.md#class-structtypeinfo) that matches the given parameter type information list.

Parameters:

- parameterTypes: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[TypeInfo](reflect_package_classes.md#class-typeinfo)> - The parameter type information list.

Return value:

- [ConstructorInfo](reflect_package_classes.md#class-constructorinfo) - Returns the information of the `public` constructor if successfully matched.

Exceptions:

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - Thrown if no corresponding `public` constructor is found.

### func getInstanceVariable(String)

```cangjie
public func getInstanceVariable(name: String): InstanceVariableInfo
```

Function: Given a variable name, attempt to get the information of the matching instance member variable in the `struct` type corresponding to this [StructTypeInfo](reflect_package_classes.md#class-structtypeinfo).

Parameters:

- name: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The variable name.

Return value:

- [InstanceVariableInfo](reflect_package_classes.md#class-instancevariableinfo) - Returns the information of the instance member variable if successfully matched.

Exceptions:

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - Thrown if no corresponding `public` instance member variable is found.

Example:

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class Rectangular {
    public var length = 4
    public var width = 5
    public var myName = ""
    public init() {}
}

main(): Unit {
    // Here we obtain ClassTypeInfo through the qualified name of the Rectangular type, or alternatively through an instance
    let ty = ClassTypeInfo.get("test.Rectangular")

    // Get instance variable information of the structure
    let ivi = ty.getInstanceVariable("myName")
    println(ivi)
    return
}
```

Execution result:

```text
myName: String
```

### func getStaticVariable(String)

```cangjie
public func getStaticVariable(name: String): StaticVariableInfo
```

Function: Given a variable name, attempts to retrieve information about the matching static member variable in the `struct` type corresponding to this [StructTypeInfo](reflect_package_classes.md#class-structtypeinfo).

Parameters:

- name: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The variable name.

Return value:

- [StaticVariableInfo](reflect_package_classes.md#class-staticvariableinfo) - Returns information about the static member variable if successfully matched.

Exceptions:

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - Throws an exception if no corresponding `public` static member variable is found.

Example:

<!-- verify -->
```cangjie
package test

import std.reflect.*

public struct Rectangular {
    public static var area: Int64 = 10
}

main(): Unit {
    // Here we obtain StructTypeInfo through the qualified name of the Rectangular type, or alternatively through an instance
    let ty = StructTypeInfo.get("test.Rectangular")

    // Get static variable
    let sv = ty.getStaticVariable("area")
    println(sv)
    return
}
```

Execution result:

```text
static area: Int64
```

### static func get(String)

```cangjie
public static redef func get(qualifiedName: String): StructTypeInfo
```

Function: Retrieves the [StructTypeInfo](reflect_package_classes.md#class-structtypeinfo) corresponding to the type specified by `qualifiedName`.

Parameters:

- qualifiedName: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The qualified name of the type.

Return value:

- [StructTypeInfo](reflect_package_classes.md#class-structtypeinfo) - The type information corresponding to the `Struct` type specified by the qualified name `qualifiedName`.

Exceptions:

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - Throws an exception if unable to retrieve type information matching the given qualified name `qualifiedName`.
- [IllegalTypeException](./reflect_package_exceptions.md#class-illegaltypeexception) - Throws an exception if the retrieved type information is not [StructTypeInfo](reflect_package_classes.md#class-structtypeinfo).

Example:

<!-- verify -->
```cangjie
import std.reflect.*
import std.reflect.*

public struct Rectangular {}

main(): Unit {
    let ty = StructTypeInfo.get("default.Rectangular")
    println(ty)
    return
}
```

Execution result:

```text
default.Rectangular
```

### static func of(Any)

```cangjie
public static redef func of(a: Any): StructTypeInfo
```

Function: Retrieves the type information corresponding to the runtime type of the given instance.

The runtime type refers to the type determined through dynamic binding during program execution, which is bound to the instance object. In scenarios like inheritance, the runtime type may differ from the static type.

Parameters:

- a: [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - An instance of any type.

Return value:

- [StructTypeInfo](reflect_package_classes.md#class-structtypeinfo) - The type information corresponding to the runtime type of instance `a`.

Exceptions:

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - Throws an exception if unable to retrieve the runtime type information of instance `a`.
- [IllegalTypeException](./reflect_package_exceptions.md#class-illegaltypeexception) - Throws an exception if the retrieved type information is not [StructTypeInfo](reflect_package_classes.md#class-structtypeinfo).

Example:

<!-- verify -->
```cangjie
package test

import std.reflect.*

public struct Rectangular {}

main(): Unit {
    var r = Rectangular()
    let ty = StructTypeInfo.of(r)
    println(ty)
    return
}
```

Execution result:

```text
test.Rectangular
```

### static func of\<T>()

```cangjie
public static redef func of<T>(): StructTypeInfo
```

Function: Retrieves the type information corresponding to the given type `T`.

Return value:

- [StructTypeInfo](reflect_package_classes.md#class-structtypeinfo) - The type information corresponding to type `T`.

Exceptions:

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - Throws an exception if unable to retrieve type information for type T.
- [IllegalTypeException](./reflect_package_exceptions.md#class-illegaltypeexception) - Throws an exception if the retrieved type information is not [StructTypeInfo](reflect_package_classes.md#class-structtypeinfo).

Example:

<!-- verify -->
```cangjie
import std.reflect.*

public struct Rectangular {}

main(): Unit {
    let ty = StructTypeInfo.of<Rectangular>()
    println(ty)
    return
}
```

Execution result:

```text
default.Rectangular
```

## class TypeInfo

```cangjie
sealed abstract class TypeInfo <: Equatable<TypeInfo> & Hashable & ToString
```

Function: [TypeInfo](reflect_package_classes.md#class-typeinfo) provides a common operation interface for all data types. Developers typically do not need to downcast to more specific data types like [ClassTypeInfo](reflect_package_classes.md#class-classtypeinfo) to perform reflection operations.

Subclasses of [TypeInfo](reflect_package_classes.md#class-typeinfo) include [PrimitiveTypeInfo](reflect_package_classes.md#class-primitivetypeinfo), [StructTypeInfo](reflect_package_classes.md#class-structtypeinfo), [ClassTypeInfo](reflect_package_classes.md#class-classtypeinfo), and [InterfaceTypeInfo](reflect_package_classes.md#class-interfacetypeinfo), corresponding to primitive data types, `struct` data types, `class` data types, and `interface` data types, respectively.

> **Note:**
>
> The qualified name of a type follows the format: `(module_name/)?(default|package_name)(.package_name)*.(type_name)`.

Parent types:

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[TypeInfo](#class-typeinfo)>
- [Hashable](../../core/core_package_api/core_package_interfaces.md#interface-hashable)
- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

### prop annotations

```cangjie
public prop annotations: Collection<Annotation>
```

Function: Retrieves all annotations applied to the type corresponding to this [TypeInfo](reflect_package_classes.md#class-typeinfo), returning the corresponding collection.

> **Note:**
>
> - If no annotations are applied to the type, returns an empty collection.
> - The collection does not guarantee a consistent traversal order.

Type: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[Annotation](../../ast/ast_package_api/ast_package_classes.md#class-annotation)>

### prop instanceFunctions

```cangjie
public prop instanceFunctions: Collection<InstanceFunctionInfo>
```

Function: Retrieves information about all `public` instance member functions of the type corresponding to this [TypeInfo](reflect_package_classes.md#class-typeinfo), returning the corresponding collection.

> **Note:**
>
> - If the type has no `public` instance member functions, returns an empty collection.
> - The collection does not guarantee a consistent traversal order.
> - If the type is a `struct` or `class`, the collection does not include inherited instance member functions.

Type: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[InstanceFunctionInfo](reflect_package_classes.md#class-instancefunctioninfo)>

### prop instanceProperties

```cangjie
public prop instanceProperties: Collection<InstancePropertyInfo>
```

Function: Retrieves information about all `public` instance member properties of the type corresponding to this [TypeInfo](reflect_package_classes.md#class-typeinfo), returning the corresponding collection.

> **Note:**
>
> - If the type has no `public` instance member properties, returns an empty collection.
> - The collection does not guarantee a consistent traversal order.
> - If the type is a `struct` or `class`, the collection does not include inherited instance member properties.

Type: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[InstancePropertyInfo](reflect_package_classes.md#class-instancepropertyinfo)>

### prop modifiers

```cangjie
public prop modifiers: Collection<ModifierInfo>
```

Function: Retrieves information about all modifiers applied to the type corresponding to this [TypeInfo](reflect_package_classes.md#class-typeinfo), returning the corresponding collection.

> **Note:**
>
> - If the type has no modifiers, returns an empty collection.
> - The collection does not guarantee a consistent traversal order.
> - `interface` types inherently have `open` semantics, so the collection always includes the `open` modifier.
> - Reflection operations are limited to types with `public` access control modifiers, so all access control modifiers are ignored.

Type: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[ModifierInfo](reflect_package_enums.md#enum-modifierinfo)>

### prop name

```cangjie
public prop name: String
```

Function: Retrieves the name of the type corresponding to this [TypeInfo](reflect_package_classes.md#class-typeinfo).

> **Note:**
>
> - The name does not include any module or package prefixes.
> - The type information of a type alias is essentially the type information of its underlying actual type. Therefore, this function returns the name of the actual type rather than the type alias itself. For example, the type information name of the type alias [Byte](../../core/core_package_api/core_package_types.md#type-byte) is [UInt8](../../core/core_package_api/core_package_intrinsics.md#uint8), not [Byte](../../core/core_package_api/core_package_types.md#type-byte).

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop qualifiedName

```cangjie
public prop qualifiedName: String
```

Function: Gets the qualified name of the type corresponding to this [TypeInfo](reflect_package_classes.md#class-typeinfo).

> **Note:**
>
> - The qualified name includes module and package name prefixes.
> - Specifically, built-in Cangjie data types and all types under the `core` package in the `std` module have qualified names without any module or package name prefixes.
> - All types defined in contexts without explicit module or package names have no module name prefix but carry the package name prefix "`default`", e.g., "`default.MyType`".

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string)

### prop staticFunctions

```cangjie
public prop staticFunctions: Collection<StaticFunctionInfo>
```

Function: Gets all `public` static member function information of the type corresponding to this [TypeInfo](reflect_package_classes.md#class-typeinfo), returning the corresponding collection.

> **Note:**
>
> - If the type corresponding to this [TypeInfo](reflect_package_classes.md#class-typeinfo) has no `public` static member functions, an empty collection is returned.
> - The collection does not guarantee a consistent iteration order.
> - If the type is a `struct`, `class`, or `interface`, the collection does not include inherited static member function information.

Type: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[StaticFunctionInfo](reflect_package_classes.md#class-staticfunctioninfo)>

### prop staticProperties

```cangjie
public prop staticProperties: Collection<StaticPropertyInfo>
```

Function: Gets all `public` static member property information of the type corresponding to this [TypeInfo](reflect_package_classes.md#class-typeinfo), returning the corresponding collection.

> **Note:**
>
> - If the type corresponding to this [TypeInfo](reflect_package_classes.md#class-typeinfo) has no `public` static member properties, an empty collection is returned.
> - The collection does not guarantee a consistent iteration order.
> - If the type is a `struct`, `class`, or `interface`, the collection does not include inherited static member property information.

Type: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[StaticPropertyInfo](reflect_package_classes.md#class-staticpropertyinfo)>

### prop superInterfaces

```cangjie
public prop superInterfaces: Collection<InterfaceTypeInfo>
```

Function: Gets all directly implemented `interface` type information of the type corresponding to this [TypeInfo](reflect_package_classes.md#class-typeinfo), returning the corresponding collection.

> **Note:**
>
> - All types implicitly implement the interface [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) by default.
> - The collection does not guarantee a consistent iteration order.
> - Currently, `struct` types only support obtaining the interface [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) type.

Type: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<[InterfaceTypeInfo](reflect_package_classes.md#class-interfacetypeinfo)>

### static func get(String)

```cangjie
public static func get(qualifiedName: String): TypeInfo
```

Function: Gets the [TypeInfo](reflect_package_classes.md#class-typeinfo) corresponding to the type specified by the given `qualifiedName`.

> **Note:**
>
> Currently, the qualified name `qualifiedName` does not support the `Nothing` type, function types, tuple types, or `enum` types.

Parameters:

- qualifiedName: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The qualified name of the type.

Returns:

- [TypeInfo](reflect_package_classes.md#class-typeinfo) - The type information corresponding to the qualified name `qualifiedName`.

Throws:

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - Thrown if no type information matching the given qualified name `qualifiedName` can be found.

Example:

<!-- verify -->
```cangjie
import std.reflect.*

public class Rectangular {}

main(): Unit {
    let ty = TypeInfo.get("default.Rectangular")
    println(ty)
    return
}
```

Output:

```text
default.Rectangular
```

### static func of(Any)

```cangjie
public static func of(a: Any): TypeInfo
```

Function: Gets the runtime type information corresponding to the given instance of any type.

The runtime type refers to the dynamically determined type during program execution, bound to the instance object. In inheritance scenarios, the runtime type may differ from the static type.

> **Note:**
>
> Currently, the instance `a` does not support runtime types of function types, tuple types, or `enum` types.

Parameters:

- a: [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - An instance of any type.

Returns:

- [TypeInfo](reflect_package_classes.md#class-typeinfo) - The type information corresponding to the runtime type of instance `a`.

Throws:

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - Thrown if the runtime type information of instance `a` cannot be obtained.

Example:

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class Rectangular {}

main(): Unit {
    var r: Any = Rectangular()
    let ty = TypeInfo.of(r)
    println(ty)
    return
}
```

Output:

```text
test.Rectangular
```

### static func of(Object) <sup>(deprecated)</sup>

```cangjie
public static func of(a: Object): ClassTypeInfo
```

Function: Gets the runtime `class` type information corresponding to the given `class` instance.

> **Note:**
>
> This will be deprecated in future versions. Use [ClassTypeInfo](#class-classtypeinfo)'s [static func of(Object)](#static-func-ofobject) instead.

Parameters:

- a: [Object](../../core/core_package_api/core_package_classes.md#class-object) - An instance of a `class` type.

Returns:

- [ClassTypeInfo](reflect_package_classes.md#class-classtypeinfo) - The `class` type information corresponding to the runtime type of instance `a`.

Throws:

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - Thrown if the runtime `class` type information of instance `a` cannot be obtained.

### static func of\<T>()

```cangjie
public static func of<T>(): TypeInfo
```

Function: Gets the type information corresponding to the given type `T`.

> **Note:**
>
> - Currently, generic `T` does not support the `Nothing` type, function types, tuple types, or `enum` types.
> - `T` supports type aliases, including built-in aliases (e.g., [Int](../../core/core_package_api/core_package_types.md#type-int), [UInt](../../core/core_package_api/core_package_types.md#type-uint), `Rune`) and user-defined type aliases.

Returns:

- [TypeInfo](reflect_package_classes.md#class-typeinfo) - The type information corresponding to type `T`.

Throws:

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - Thrown if the type information for `T` cannot be obtained.

Example:

<!-- verify -->
```cangjie
import std.reflect.*

public class Rectangular {}

main(): Unit {
    let ty = TypeInfo.of<Rectangular>()
    println(ty)
    return
}
```

Output:

```text
default.Rectangular
```

### func findAnnotation\<T>()

```cangjie
public func findAnnotation<T>(): Option<T>
```

Function: Attempts to retrieve an annotation applied to the type corresponding to this [TypeInfo](reflect_package_classes.md#class-typeinfo) with the given qualified name.

Returns:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - Returns the annotation if matched; otherwise, returns `None`.

### func getInstanceFunction(String, Array\<TypeInfo>)

```cangjie
public func getInstanceFunction(name: String, parameterTypes: Array<TypeInfo>): InstanceFunctionInfo
```

Function: Attempts to retrieve the instance member function information matching the given function name and parameter type list.

Parameters:

- name: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The function name.
- parameterTypes: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[TypeInfo](reflect_package_classes.md#class-typeinfo)> - The type information list of the function parameter types.

Returns:

- [InstanceFunctionInfo](reflect_package_classes.md#class-instancefunctioninfo) - The instance member function information if matched.

Throws:

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - Thrown if no matching `public` instance member function is found.

Example:

<!-- verify -->
```cangjie
import std.reflect.*

public class Rectangular {
    public var length = 4
    public var width = 5
    public func area(): Int64 {
        return length * width
    }
}

main(): Unit {
    // Here, TypeInfo is obtained via the qualified name of Rectangular, but it can also be obtained via an instance
    let ty = TypeInfo.get("default.Rectangular")
    // Get InstanceFunctionInfo
    var gif = ty.getInstanceFunction("area")

    println(gif)
    return
}
```

Output:

```text
func area(): Int64
```

### func getInstanceFunctions(String)

```cangjie
public func getInstanceFunctions(name: String): Array<InstanceFunctionInfo>
```

Function: Attempts to retrieve all instance member function information matching the given function name in this type.Parameters:

- name: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The function name.

Return Value:

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[InstanceFunctionInfo](reflect_package_classes.md#class-instancefunctioninfo)> - Returns information of all matched instance member functions if successfully matched.

Example:

<!-- verify -->
```cangjie
import std.reflect.*

public class Rectangular {
    public var length = 4
    public var width = 5
    public func area(): Int64 {
        return length * width
    }
}

main(): Unit {
    // Get TypeInfo through Rectangular's qualified name (can also get through instance)
    let ty = TypeInfo.get("default.Rectangular")
    // Get InstanceFunctionInfo
    var gif = ty.getInstanceFunctions("area")

    println(gif)
    return
}
```

Execution Result:

```text
[func area(): Int64]
```

### func getInstanceProperty(String)

```cangjie
public func getInstanceProperty(name: String): InstancePropertyInfo
```

Function: Attempts to get information about an instance member property matching the given property name in this type.

Parameters:

- name: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The property name.

Return Value:

- [InstancePropertyInfo](reflect_package_classes.md#class-instancepropertyinfo) - Returns information of the instance member property if successfully matched.

Exceptions:

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - Throws if no matching `public` instance member property is found.

Example:

<!-- verify -->
```cangjie
import std.reflect.*

public class Rectangular {
    public var length = 4
    public prop width: Int64 {
        get() {
            5
        }
    }
}

main(): Unit {
    // Get TypeInfo through Rectangular's qualified name (can also get through instance)
    let ty = TypeInfo.get("default.Rectangular")
    // Get InstancePropertyInfo
    var gip = ty.getInstanceProperty("width")

    println(gip)
    return
}
```

Execution Result:

```text
prop width: Int64
```

### func getStaticFunction(String, Array\<TypeInfo>)

```cangjie
public func getStaticFunction(name: String, parameterTypes: Array<TypeInfo>): StaticFunctionInfo
```

Function: Attempts to get information about a static member function matching the given function name and parameter type list in this type.

Parameters:

- name: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The function name.
- parameterTypes: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[TypeInfo](reflect_package_classes.md#class-typeinfo)> - The type information list corresponding to the function parameter types.

Return Value:

- [StaticFunctionInfo](reflect_package_classes.md#class-staticfunctioninfo) - Returns information of the static member function if successfully matched.

Exceptions:

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - Throws if no matching `public` static member function is found.

Example:

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class Rectangular {
    public static func myName(): String { "" }
}

main(): Unit {
    // Get TypeInfo through Rectangular's qualified name (can also get through instance)
    let ty = ClassTypeInfo.get("test.Rectangular")

    // Get static function
    let sf = ty.getStaticFunction("myName")

    println(sf)
    return
}
```

Execution Result:

```text
static func myName(): String
```

### func getStaticFunctions(String)

```cangjie
public func getStaticFunctions(name: String): Array<StaticFunctionInfo>
```

Function: Attempts to get information about all static member functions matching the given function name in this type.

Parameters:

- name: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The function name.

Return Value:

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[StaticFunctionInfo](reflect_package_classes.md#class-staticfunctioninfo)> - Returns information of all matched static member functions if successfully matched.

Example:

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class Rectangular {
    public static func myName(): String { "" }
}

main(): Unit {
    // Get TypeInfo through Rectangular's qualified name (can also get through instance)
    let ty = TypeInfo.get("test.Rectangular")

    // Get static functions
    let sf = ty.getStaticFunctions("myName")

    println(sf)
    return
}
```

Execution Result:

```text
[static func myName(): String]
```

### func getStaticProperty(String)

```cangjie
public func getStaticProperty(name: String): StaticPropertyInfo
```

Function: Attempts to get information about a static member property matching the given property name in this type.

Parameters:

- name: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The property name.

Return Value:

- [StaticPropertyInfo](reflect_package_classes.md#class-staticpropertyinfo) - Returns information of the static member property if successfully matched.

Exceptions:

- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - Throws if no matching `public` static member property is found.

Example:

<!-- verify -->
```cangjie
package test

import std.reflect.*

public class Rectangular {
    private static var valueArea = 0
    public static mut prop area: Int64 {
        get() { valueArea }
        set(v) { valueArea = v }
    }
}

main(): Unit {
    // Get TypeInfo through Rectangular's qualified name (can also get through instance)
    let ty = TypeInfo.get("test.Rectangular")

    // Get static property
    let sp = ty.getStaticProperty("area")

    println(sp)
    return
}
```

Execution Result:

```text
static mut prop area: Int64
```

### func hashCode()

```cangjie
public func hashCode(): Int64
```

Function: Gets the hash code of this type information.

> **Note:**
>
> Internal implementation uses the hash code of the type's qualified name string.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The hash code of this type information.

### func isSubtypeOf(TypeInfo)

```cangjie
public func isSubtypeOf(supertype: TypeInfo): Bool
```

Function: Determines whether the type represented by the current [TypeInfo](reflect_package_classes.md#class-typeinfo) instance is a subtype of the type represented by the parameter's [TypeInfo](reflect_package_classes.md#class-typeinfo) instance.

Parameters:

- supertype: [TypeInfo](reflect_package_classes.md#class-typeinfo) - The target type's type information.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if this [TypeInfo](reflect_package_classes.md#class-typeinfo)'s type is a subtype of `supertype`'s type, otherwise returns `false`.

Example:

<!-- verify -->
```cangjie
package test

import std.reflect.*

public abstract class Rectangular {}

public class Square <: Rectangular {}

main(): Unit {
    // Get TypeInfo through class qualified names (can also get through instances)
    let tyr = ClassTypeInfo.get("test.Rectangular")
    let tys = ClassTypeInfo.get("test.Square")
    println(tys.isSubtypeOf(tyr))
    return
}
```

Execution Result:

```text
true
```

### func toString()

```cangjie
public func toString(): String
```

Function: Retrieves the type information in string format.

> **Note:**
>
> The internal implementation returns the qualified name string of this type information.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The type information in string format.

### operator func !=(TypeInfo)

```cangjie
public operator func !=(that: TypeInfo): Bool
```

Function: Determines whether this type information is not equal to another given type information.

Parameters:

- that: [TypeInfo](reflect_package_classes.md#class-typeinfo) - The other type information to compare for equality.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the qualified name of this type information is not equal to `that`, otherwise returns `false`.

### operator func ==(TypeInfo)

```cangjie
public operator func ==(that: TypeInfo): Bool
```

Function: Determines whether this type information is equal to another given type information.

Parameters:

- that: [TypeInfo](reflect_package_classes.md#class-typeinfo) - The other type information to compare for equality.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the qualified name of this type information is equal to `that`, otherwise returns `false`.