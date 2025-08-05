# Exception Classes

## class ExpectationFailedException

```cangjie
public open class ExpectationFailedException <: PrettyException {}
```

Function: Indicates that one or more expectations set during mock configuration were violated during test execution.

Parent Types:

- [PrettyException](#class-prettyexception)

## class MockFrameworkException

```cangjie
public class MockFrameworkException <: PrettyException {}
```

Function: Framework exception information, thrown when API usage does not meet framework requirements.

Parent Types:

- [PrettyException](#class-prettyexception)

## class MockFrameworkInternalError

```cangjie
public class MockFrameworkInternalError <: PrettyException {}
```

Function: Framework exception information, users should not expect this exception to be thrown.

Parent Types:

- [PrettyException](#class-prettyexception)

## class PrettyException

```cangjie
public abstract class PrettyException <: Exception & PrettyPrintable {}
```

Function: An exception type that supports [PrettyPrintable](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-prettyprintable), capable of printing exception information in a well-formatted manner.

Parent Types:

- [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception)
- [PrettyPrintable](../../unittest_common/unittest_common_package_api/unittest_common_package_interfaces.md#interface-prettyprintable)

### func pprint

```cangjie
public func pprint(to: PrettyPrinter): PrettyPrinter
```

Function: Supports colored printing and indented formatting of exception information.

Parameters:

- to: [PrettyPrinter](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-prettyprinter) - A printer that adds color and indentation.

Return Value:

- [PrettyPrinter](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-prettyprinter) - A printer with added color and indentation.

## class UnhandledCallException

```cangjie
public class UnhandledCallException <: PrettyException {}
```

Function: Indicates that none of the provided [stubs](../unittest_mock_samples/mock_framework_basics.md#configuration-api) handled the call.

Parent Types:

- [PrettyException](#class-prettyexception)

## class UnnecessaryStubbingException

```cangjie
public class UnnecessaryStubbingException <: PrettyException {}
```

Function: Indicates that the tested code never triggered the [stub](../unittest_mock_samples/mock_framework_basics.md#configuration-api).

Parent Types:

- [PrettyException](#class-prettyexception)

## class UnstubbedInvocationException

```cangjie
public class UnstubbedInvocationException <: PrettyException {}
```

Function: No matching [stub](../unittest_mock_samples/mock_framework_basics.md#configuration-api) was provided for this invocation.

Parent Types:

- [PrettyException](#class-prettyexception)

## class VerificationFailedException

```cangjie
public class VerificationFailedException <: PrettyException {}
```

Function: Exception thrown by the framework when verification fails.

Parent Types:

- [PrettyException](#class-prettyexception)