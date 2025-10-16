# Functions

## func parseParameterTypes(String)

```cangjie
public func parseParameterTypes(parameters: String): Array<TypeInfo>
```

Function: Parses parameter types from a string and converts them into a type array for use by functions such as `getStaticFunction`.

The qualified name of function parameter types refers to the parameter type portion of the function type, excluding parameter names, default values, and the outermost `()`.  
Therefore, for the following Cangjie function:

```cangjie
import m1.p1.T1
func f(a: Int64, b: T1, c!: Int64 = 0, d!: Int64 = 0): Int64 { ... }
```

Its qualified name should be `"Int64, p1.T1, Int64, Int64"`. For parameterless functions, the qualified name should be `""`.

Parameters:

- parameters: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The qualified name of function parameter types.

Return Value:

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[TypeInfo](reflect_package_classes.md#class-typeinfo)> - The parameter type information corresponding to the string.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if the string format is incorrect.
- [InfoNotFoundException](reflect_package_exceptions.md#class-infonotfoundexception) - Thrown if the type information in the parameters cannot be obtained.

Example:

<!-- verify -->
```cangjie
import std.reflect.*

class A {}

main(): Unit {
    println(parseParameterTypes("Int64, String, default.A"))
}
```

Execution Result:

```text
[Int64, String, default.A]
```