# Functions

## func assertCaughtUnexpectedE(String, String, String, Option\<AssertionCtx>)

```cangjie
public func assertCaughtUnexpectedE(
    message: String,
    expectedExceptions: String,
    caughtException: String,
    optParentCtx!: ?AssertionCtx = None
): Nothing
```

Function: Records information and throws an exception when the caught exception does not match expectations.

Parameters:

- message: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Prompt message when expectations are not met.
- expectedExceptions: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Expected exceptions to be caught.
- caughtException: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Actually caught exception.
- optParentCtx!: [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[AssertionCtx](./unittest_package_classes.md#class-assertionctx)> - Context for storing nested assertion failure messages.

## func assertEqual\<T>(String, String, T, T, Option\<AssertionCtx>): Unit where T <: Equatable\<T>

```cangjie
public func assertEqual<T>(
    leftStr: String,
    rightStr: String,
    expected: T,
    actual: T,
    optParentCtx!: ?AssertionCtx = None
): Unit where T <: Equatable<T>
```

Function: Compares whether `expected` and `actual` values are equal. Throws an exception immediately if unequal.

Parameters:

- leftStr: [String](../../core/core_package_api/core_package_structs.md#struct-string) - String representation of the expected expression.
- rightStr: [String](../../core/core_package_api/core_package_structs.md#struct-string) - String representation of the actual expression.
- expected: T - Expected value.
- actual: T - Actual value.
- optParentCtx!: [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[AssertionCtx](./unittest_package_classes.md#class-assertionctx)> - Context for storing nested assertion failure messages.

## func defaultConfiguration()

```cangjie
public func defaultConfiguration(): Configuration
```

Function: Generates default configuration information.

Return Value:

- [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration) - Configuration information.

## func entryMain(TestPackage)

```cangjie
public func entryMain(testPackage: TestPackage): Int64
```

Function: Entry function for framework test case execution, provided for `cjc --test` usage.

Parameters:

- testPackage: [TestPackage](./unittest_package_classes.md#class-testpackage) - Test package object.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Execution result.

## func expectCaughtUnexpectedE(String, String, String, Option\<AssertionCtx>)

```cangjie
public func expectCaughtUnexpectedE(
    message: String,
    expectedExceptions: String,
    caughtException: String,
    optParentCtx!: ?AssertionCtx = None
): Unit
```

Function: Records information without throwing an exception when the caught exception does not match expectations.

Parameters:

- message: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Prompt message when expectations are not met.
- expectedExceptions: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Expected exceptions to be caught.
- caughtException: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Actually caught exception.
- optParentCtx!: [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[AssertionCtx](./unittest_package_classes.md#class-assertionctx)> - Context for storing nested assertion failure messages.

## func expectEqual\<T>(String, String, T, T, Option\<AssertionCtx>): Unit where T <: Equatable\<T>

```cangjie
public func expectEqual<T>(
    leftStr: String,
    rightStr: String,
    expected: T,
    actual: T,
    optParentCtx!: ?AssertionCtx
): Unit where T <: Equatable<T>
```

Function: Compares whether `expected` and `actual` values are equal. Records comparison results without throwing an exception.

Parameters:

- leftStr: [String](../../core/core_package_api/core_package_structs.md#struct-string) - String representation of the expected expression.
- rightStr: [String](../../core/core_package_api/core_package_structs.md#struct-string) - String representation of the actual expression.
- expected: T - Expected value.
- actual: T - Actual value.
- optParentCtx!: [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[AssertionCtx](./unittest_package_classes.md#class-assertionctx)> - Context for storing nested assertion failure messages.

## func fail(String)

```cangjie
public func fail(message: String): Nothing
```

Function: Fails the test case immediately by throwing an exception.

Parameters:

- message: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Failure message.

## func failExpect(String)

```cangjie
public func failExpect(message: String): Unit
```

Function: Fails the test case by recording information without throwing an exception.

Parameters:

- message: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Failure message.

## func invokeCustomAssert\<T>(Array\<String>, String, (AssertionCtx) -> T, Option\<AssertionCtx>)

```cangjie
public func invokeCustomAssert<T>(
    passerdArgs: Array<String>,
    caller: String,
    assert: (AssertionCtx) -> T,
    optParentCtx!: ?AssertionCtx = None
): T
```

Function: Executes user-defined assertion functions specified by [`@Assert\[caller\](passerArgs)`](../../unittest_testmacro/unittest_testmacro_package_api/unittest_testmacro_package_macros.md#assert-macro) within [`@Test`](../../unittest_testmacro/unittest_testmacro_package_api/unittest_testmacro_package_macros.md#test-macro), [`@TestCase`](../../unittest_testmacro/unittest_testmacro_package_api/unittest_testmacro_package_macros.md#testcase-macro), or [`@CustomAssertion`](../../unittest_testmacro/unittest_testmacro_package_api/unittest_testmacro_package_macros.md#customassertion-macro) macros.

Parameters:

- passedArgs: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[String](../../core/core_package_api/core_package_structs.md#struct-string)> - Unprocessed passed arguments.
- caller: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Name of the invoked custom assertion.
- assert: ([AssertionCtx](./unittest_package_classes.md#class-assertionctx)) -> T - Captures assertion calls with correct parameters.
- optParentCtx!: [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[AssertionCtx](./unittest_package_classes.md#class-assertionctx)> - Context for storing nested assertion failure messages.

Return Value:

- `T` - Value returned by the user-defined assertion.

## func invokeCustomExpect(Array\<String>, String, (AssertionCtx) -> Any, Option\<AssertionCtx>)

```cangjie
public func invokeCustomExpect(
    passerdArgs: Array<String>,
    caller: String,
    expect: (AssertionCtx) -> Any,
    optParentCtx!: ?AssertionCtx = None
): Unit
```

Function: Executes user-defined assertion functions specified by [`@Expect\[caller\](passerArgs)`](../../unittest_testmacro/unittest_testmacro_package_api/unittest_testmacro_package_macros.md#expect-macro) within [`@Test`](../../unittest_testmacro/unittest_testmacro_package_api/unittest_testmacro_package_macros.md#test-macro), [`@TestCase`](../../unittest_testmacro/unittest_testmacro_package_api/unittest_testmacro_package_macros.md#testcase-macro), or [`@CustomAssertion`](../../unittest_testmacro/unittest_testmacro_package_api/unittest_testmacro_package_macros.md#customassertion-macro) macros.

Parameters:

- passedArgs: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[String](../../core/core_package_api/core_package_structs.md#struct-string)> - Unprocessed passed arguments.
- caller: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Name of the invoked custom assertion.
- expect: ([AssertionCtx](./unittest_package_classes.md#class-assertionctx)) -> [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - Captures assertion calls with correct parameters.
- optParentCtx!: [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[AssertionCtx](./unittest_package_classes.md#class-assertionctx)> - Context for storing nested assertion failure messages.