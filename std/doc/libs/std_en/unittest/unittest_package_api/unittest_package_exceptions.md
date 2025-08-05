# Exception Classes

## class AssertException

```cangjie
public class AssertException <: Exception {
    public init()
    public init(message: String)
}
```

Function: The exception thrown when checks by [@Expect](../../unittest_testmacro/unittest_testmacro_package_api/unittest_testmacro_package_macros.md#expect-macro) / [@Assert](../../unittest_testmacro/unittest_testmacro_package_api/unittest_testmacro_package_macros.md#assert-macro) fail.

Parent Type:

- [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception)

### init()

```cangjie
public init()
```

Function: Constructor.

### init(String)

```cangjie
public init(message: String)
```

Function: Constructor.

Parameters:

- message: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Specified exception message.

## class AssertIntermediateException

```cangjie
public class AssertIntermediateException <: Exception {
    public let expression: String
    public let originalException: Exception
}
```

Function: The exception thrown when checks by [@PowerAssert](../../unittest_testmacro/unittest_testmacro_package_api/unittest_testmacro_package_macros.md#powerassert-macro) fail.

Parent Type:

- [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception)

### let expression

```cangjie
public let expression: String
```

Function: The expression being checked.

Type: [String](../../core/core_package_api/core_package_structs.md#struct-string).

### let originalException

```cangjie
public let originalException: Exception
```

Function: Original type information.

Type: [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception).

### func getOriginalStackTrace

```cangjie
public func getOriginalStackTrace(): String
```

Function: Gets the original stack trace.

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - Stack trace information.

## class UnittestCliOptionsFormatException

```cangjie
public class UnittestCliOptionsFormatException <: UnittestException
```

Function: Exception thrown for console option format errors.

Parent Type:

- [UnittestException](#class-unittestexception)

## class UnittestException

```cangjie
public open class UnittestException <: Exception
```

Function: Framework common exception.

Parent Type:

- [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception)