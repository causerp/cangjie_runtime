# std.reflect

## Functionality Overview

The `reflect` package provides reflection capabilities, enabling programs to obtain type information of various instances at runtime and perform read/write and invocation operations.

This package currently does not support macOS platform.

> **Note:**
>
> - For global information reflection, only globally visible `public` variables and functions can be accessed.
> - For the current package, reflection can access all globally defined types, while for externally imported packages or dynamically loaded modules, only globally defined types with `public` visibility can be accessed.
> - For member information reflection, only members (instance/static member variables/properties/functions) with `public` visibility within a type can be accessed. Members modified with non-`public` modifiers or default modifiers are invisible.
> - Currently, reflection does not support function types, tuple types, or `enum` types.

## API List

### Functions

|              Function Name          |            Functionality           |
| --------------------------- | ------------------------ |
| [parseParameterTypes(String)](./reflect_package_api/reflect_package_funcs.md#func-parseparametertypesstring) | Converts a string into a function signature containing specific type information for use by functions like `getStaticFunction`. |

### Type Aliases

| Type Alias                                                       | Functionality                          |
| ------------------------------------------------------------ | ----------------------------- |
| [Annotation](./reflect_package_api/reflect_package_types.md#type-annotation--object)| Alias for [Object](../core/core_package_api/core_package_classes.md#class-object).|

### Classes

|                 Class Name              | Functionality                                     |
| --------------------------------- |----------------------------------------|
| [ClassTypeInfo](./reflect_package_api/reflect_package_classes.md#class-classtypeinfo) | Describes type information for `class` types.                      |
| [ConstructorInfo](./reflect_package_api/reflect_package_classes.md#class-constructorinfo)| Describes constructor information.           |
| [GenericTypeInfo](./reflect_package_api/reflect_package_classes.md#class-generictypeinfo) | Describes generic type information.|
| [GlobalFunctionInfo](./reflect_package_api/reflect_package_classes.md#class-globalfunctioninfo) | Describes global function information.                              |
| [GlobalVariableInfo](./reflect_package_api/reflect_package_classes.md#class-globalvariableinfo) | Describes global variable information.                              |
| [InstanceFunctionInfo](./reflect_package_api/reflect_package_classes.md#class-instancefunctioninfo) | Describes instance member function information.                            |
| [InstancePropertyInfo](./reflect_package_api/reflect_package_classes.md#class-instancepropertyinfo) | Describes instance member property information.                            |
| [InstanceVariableInfo](./reflect_package_api/reflect_package_classes.md#class-instancevariableinfo) | Describes instance member variable information.                            |
| [InterfaceTypeInfo](./reflect_package_api/reflect_package_classes.md#class-interfacetypeinfo) | Describes type information for `interface` types.                  |
| [PackageInfo](./reflect_package_api/reflect_package_classes.md#class-packageinfo) | Describes package information.                                 |
| [ParameterInfo](./reflect_package_api/reflect_package_classes.md#class-parameterinfo) | Describes function parameter information.                              |
| [PrimitiveTypeInfo](./reflect_package_api/reflect_package_classes.md#class-primitivetypeinfo) | Describes type information for primitive data types.                         |
| [StaticFunctionInfo](./reflect_package_api/reflect_package_classes.md#class-staticfunctioninfo) | Describes static member function information.                            |
| [StaticPropertyInfo](./reflect_package_api/reflect_package_classes.md#class-staticpropertyinfo) | Describes static member property information.                            |
| [StaticVariableInfo](./reflect_package_api/reflect_package_classes.md#class-staticvariableinfo) | Describes static member variable information.                            |
| [StructTypeInfo](./reflect_package_api/reflect_package_classes.md#class-structtypeinfo) | Describes type information for `struct` types.                     |
| [TypeInfo](./reflect_package_api/reflect_package_classes.md#class-typeinfo) | `TypeInfo` provides common operation interfaces for all data types, supporting reflection operations. |

### Enums

| Enum Name                                                                                                                                           |            Functionality           |
|-----------------------------------------------------------------------------------------------------------------------------------------------| ------------------------ |
| [ModifierInfo](./reflect_package_api/reflect_package_enums.md#enum-modifierinfo) | Describes modifier information. |

### Exception Classes

| Exception Class Name                                                                                                                      | Functionality                                                |
|---------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------|
| [IllegalSetException](./reflect_package_api/reflect_package_exceptions.md#class-illegalsetexception)             | Indicates an exception for modifying immutable types.   |
| [IllegalTypeException](./reflect_package_api/reflect_package_exceptions.md#class-illegaltypeexception)           | Indicates a type mismatch exception.       |
| [InfoNotFoundException](./reflect_package_api/reflect_package_exceptions.md#class-infonotfoundexception)         | Indicates an exception when corresponding information cannot be found.                                     |
| [InvocationTargetException](./reflect_package_api/reflect_package_exceptions.md#class-invocationtargetexception) | Indicates a function invocation wrapper exception. |
| [MisMatchException](./reflect_package_api/reflect_package_exceptions.md#class-mismatchexception)                 | Indicates an exception thrown when invoking a corresponding function.       |
| [ReflectException](./reflect_package_api/reflect_package_exceptions.md#class-reflectexception)                   | `ReflectException` is the base exception class for the Reflect package.   |