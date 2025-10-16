# Functions

## func assertCaughtUnexpectedE(String, String, String, ?AssertionCtx)

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

## func assertEqual\<T>(String, String, T, T, ?AssertionCtx)

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

## func assertEqual\<T>(String, String, T, T, Bool, ?AssertionCtx)

```cangjie
public func assertEqual<T>(
    leftStr: String,
    rightStr: String,
    expected: T,
    actual: T,
    isDelta!: Bool = false,
    optParentCtx!: ?AssertionCtx = None
): Unit where T <: Equatable<T>
```

Function: Compares whether `expected` and `actual` values are equal. Throws an exception immediately if unequal.

Parameters:

- leftStr: [String](../../core/core_package_api/core_package_structs.md#struct-string) - String representation of the expected expression.
- rightStr: [String](../../core/core_package_api/core_package_structs.md#struct-string) - String representation of the actual expression.
- expected: T - Expected value.
- actual: T - Actual value.
- isDelta!: Bool - Whether to use approximate equality. Disabled by default.
- optParentCtx!: [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[AssertionCtx](./unittest_package_classes.md#class-assertionctx)> - Context for storing nested assertion failure messages.

## func defaultConfiguration()

```cangjie
public func defaultConfiguration(): Configuration
```

Function: Generates default configuration information.

Return value:

- [Configuration](../../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration) - Configuration information.

## func entryMain(TestPackage)

```cangjie
public func entryMain(testPackage: TestPackage): Int64
```

Function: Entry function for framework test case execution, provided for `cjc --test` usage.

Parameters:

- testPackage: [TestPackage](./unittest_package_classes.md#class-testpackage) - Test package object.

Return value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Execution result.

## func expectCaughtUnexpectedE(String, String, String, ?AssertionCtx)

```cangjie
public func expectCaughtUnexpectedE(
    message: String,
    expectedExceptions: String,
    caughtException: String,
    optParentCtx!: ?AssertionCtx = None
): Unit
```

Function: Records information when the caught exception does not match expectations, without throwing an exception.

Parameters:

- message: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Prompt message when expectations are not met.
- expectedExceptions: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Expected exceptions to be caught.
- caughtException: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Actually caught exception.
- optParentCtx!: [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[AssertionCtx](./unittest_package_classes.md#class-assertionctx)> - Context for storing nested assertion failure messages.

## func expectEqual\<T>(String, String, T, T, ?AssertionCtx)

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

## func expectEqual\<T>(String, String, T, T, Bool, ?AssertionCtx)

```cangjie
public func expectEqual<T>(
    leftStr: String,
    rightStr: String,
    expected: T,
    actual: T,
    isDelta!: Bool = false,
    optParentCtx!: ?AssertionCtx
): Unit where T <: Equatable<T>
```

Function: Compares whether `expected` and `actual` values are equal. Records comparison results without throwing an exception.

Parameters:

- leftStr: [String](../../core/core_package_api/core_package_structs.md#struct-string) - String representation of the expected expression.
- rightStr: [String](../../core/core_package_api/core_package_structs.md#struct-string) - String representation of the actual expression.
- expected: T - Expected value.
- actual: T - Actual value.
- isDelta!: Bool - Whether to use approximate equality. Disabled by default.
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

## func invokeCustomAssert\<T>(Array\<String>, String, (AssertionCtx) -> T, ?AssertionCtx)

```cangjie
public func invokeCustomAssert<T>(
    passerdArgs: Array<String>,
    caller: String,
    assert: (AssertionCtx) -> T,
    optParentCtx!: ?AssertionCtx = None
): T
```

Function: Executes user-defined assertion functions specified by [`@Assert\[caller\](passerArgs)`](../../unittest_testmacro/unittest_testmacro_package_api/unittest_testmacro_package_macros.md#assert-宏) used in [`@Test`](../../unittest_testmacro/unittest_testmacro_package_api/unittest_testmacro_package_macros.md#test-宏), [`@TestCase`](../../unittest_testmacro/unittest_testmacro_package_api/unittest_testmacro_package_macros.md#testcase-宏), or [`@CustomAssertion`](../../unittest_testmacro/unittest_testmacro_package_api/unittest_testmacro_package_macros.md#customassertion-宏) macros.

Parameters:

- passedArgs: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[String](../../core/core_package_api/core_package_structs.md#struct-string)> - Unprocessed passed arguments.
- caller: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Name of the invoked custom assertion.
- assert: ([AssertionCtx](./unittest_package_classes.md#class-assertionctx)) -> T - Captures assertion calls with correct parameters.
- optParentCtx!: [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[AssertionCtx](./unittest_package_classes.md#class-assertionctx)> - Context for storing nested assertion failure messages.

Return value:

- T - Value returned by the user-defined assertion.

## func invokeCustomExpect(Array\<String>, String, (AssertionCtx) -> Any, ?AssertionCtx)

```cangjie
public func invokeCustomExpect(
    passerdArgs: Array<String>,
    caller: String,
    expect: (AssertionCtx) -> Any,
    optParentCtx!: ?AssertionCtx = None
): Unit
```

Function: Executes user-defined assertion functions specified by [`@Expect\[caller\](passerArgs)`](../../unittest_testmacro/unittest_testmacro_package_api/unittest_testmacro_package_macros.md#expect-宏) used in [`@Test`](../../unittest_testmacro/unittest_testmacro_package_api/unittest_testmacro_package_macros.md#test-宏), [`@TestCase`](../../unittest_testmacro/unittest_testmacro_package_api/unittest_testmacro_package_macros.md#testcase-宏), or [`@CustomAssertion`](../../unittest_testmacro/unittest_testmacro_package_api/unittest_testmacro_package_macros.md#customassertion-宏) macros.

Parameters:

- passedArgs: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[String](../../core/core_package_api/core_package_structs.md#struct-string)> - Unprocessed passed arguments.
- caller: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Name of the invoked custom assertion.
- expect: ([AssertionCtx](./unittest_package_classes.md#class-assertionctx)) -> [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - Captures assertion calls with correct parameters.
- optParentCtx!: [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[AssertionCtx](./unittest_package_classes.md#class-assertionctx)> - Context for storing nested assertion failure messages.

## func isNearExpansion\<CT, D>(CT, CT, D, String)

```cangjie
public func isNearExpansion<CT, D>(
    l: CT,
    r: CT,
    delta!: D,
    cmpType!: String
): Bool where CT <: NearEquatable<CT, D> & Comparable<CT>
```

Function: Determines whether two parameters are approximately equal. Used during [PowerAssert](../../unittest_testmacro/unittest_testmacro_package_api/unittest_testmacro_package_macros.md#powerassert-宏) macro expansion. Not intended for user use.

Parameters:

- l: CT - Parameter to be compared for approximate equality.
- r: CT - Parameter to be compared for approximate equality.
- delta!: D - Delta value used for approximate equality comparison.
- cmpType!: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Comparison type.

Return value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether approximately equal.

## func isNearExpansion\<CT, D>(CT, CT, D, String, Bool)

```cangjie
public func isNearExpansion<CT, D>(
    l: CT,
    r: CT,
    delta!: D,
    cmpType!: String,
    overloadHack!: Bool = true
): Bool where CT <: NearEquatable<CT, D>
```

Function: Determines whether two parameters are approximately equal. Used during [PowerAssert](../../unittest_testmacro/unittest_testmacro_package_api/unittest_testmacro_package_macros.md#powerassert-宏) macro expansion. Not intended for user use.

Parameters:

- l: CT - Parameter to be compared for approximate equality.
- r: CT - Parameter to be compared for approximate equality.
- delta!: D - Delta value used for approximate equality comparison.
- cmpType!: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Comparison type.
- overloadHack!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Additional parameter added to enable function overloading, default value is true.

Return value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether approximately equal.