# std.unittest.testmacro

## Function Overview

unittest.testmacro provides the macros required by users for unit testing frameworks.

## API List

### Macros

|              Macro Name          |           Functionality          |
| -------------------------------- | -------------------------------- |
| [AfterAll](./unittest_testmacro_package_api/unittest_testmacro_package_macros.md#afterall-macro) | Declares a function in a test class as a [test lifecycle](../unittest/unittest_samples/unittest_basics.md#test-lifecycle) function. The decorated function runs once after all test cases. |
| [AfterEach](./unittest_testmacro_package_api/unittest_testmacro_package_macros.md#aftereach-macro) | Declares a function in a test class as a [test lifecycle](../unittest/unittest_samples/unittest_basics.md#test-lifecycle) function. The decorated function runs once after each test case. |
| [Assert](./unittest_testmacro_package_api/unittest_testmacro_package_macros.md#assert-macro) | Declares an Assert assertion for use within test functions. Stops the test case if the assertion fails. |
| [AssertThrows](./unittest_testmacro_package_api/unittest_testmacro_package_macros.md#assertthrows-macro) | Declares an [expected exception assertion](../unittest/unittest_samples/unittest_basics.md#expected-exception-assertions) for use within test functions. Stops the test case if the assertion fails. |
| [BeforeAll](./unittest_testmacro_package_api/unittest_testmacro_package_macros.md#beforeall-macro) | Declares a function in a test class as a [test lifecycle](../unittest/unittest_samples/unittest_basics.md#test-lifecycle) function. The decorated function runs once before all test cases. |
| [BeforeEach](./unittest_testmacro_package_api/unittest_testmacro_package_macros.md#beforeeach-macro) | Declares a function in a test class as a [test lifecycle](../unittest/unittest_samples/unittest_basics.md#test-lifecycle) function. The decorated function runs once before each test case. |
| [Bench](./unittest_testmacro_package_api/unittest_testmacro_package_macros.md#bench-macro) | Marks a function to be executed multiple times and calculates its expected execution time. |
| [Configure](./unittest_testmacro_package_api/unittest_testmacro_package_macros.md#configure-macro) | Provides configuration parameters for test classes or test functions. Can be applied to either test classes or test functions. |
| [CustomAssertion](./unittest_testmacro_package_api/unittest_testmacro_package_macros.md#customassertion-macro) | `@CustomAssertions` designates a function as a user-defined assertion. |
| [Expect](./unittest_testmacro_package_api/unittest_testmacro_package_macros.md#expect-macro) | Declares an Expect assertion for use within test functions. Continues test case execution if the assertion fails. |
| [ExpectThrows](./unittest_testmacro_package_api/unittest_testmacro_package_macros.md#expectthrows-macro) | Declares an [expected exception assertion](../unittest/unittest_samples/unittest_basics.md#expected-exception-assertions) for use within test functions. Continues test case execution if the assertion fails. |
| [Fail](./unittest_testmacro_package_api/unittest_testmacro_package_macros.md#fail-macro) | Declares an [expected failure assertion](../unittest/unittest_samples/unittest_basics.md#failure-assertions) for use within test functions. Stops the test case if the assertion fails. |
| [FailExpect](./unittest_testmacro_package_api/unittest_testmacro_package_macros.md#failexpect-macro) | Declares an [expected failure assertion](../unittest/unittest_samples/unittest_basics.md#failure-assertions) for use within test functions. Continues test case execution if the assertion fails. |
| [Measurement](./unittest_testmacro_package_api/unittest_testmacro_package_macros.md#measure-macro) | Specifies a [Measurement](../unittest/unittest_package_api/unittest_package_interfaces.md#interface-measurement) instance for performance testing. Can only be applied within the scope of classes marked with `@Test` macro or top-level functions. |
| [Parallel](./unittest_testmacro_package_api/unittest_testmacro_package_macros.md#parallel-macro) | Can decorate test classes. Test cases within a test class decorated with `@Parallel` can be executed in parallel. |
| [PowerAssert](./unittest_testmacro_package_api/unittest_testmacro_package_macros.md#powerassert-macro) | Checks whether the passed expression is true and displays a detailed diagram containing intermediate values and exceptions of the passed expression. |
| [Skip](./unittest_testmacro_package_api/unittest_testmacro_package_macros.md#skip-macro) | Decorates functions already marked with `@TestCase` / `@Bench` to skip the test case. |
| [Strategy](./unittest_testmacro_package_api/unittest_testmacro_package_macros.md#strategy-macro) | Used to combine, map, and reuse various data strategies. |
| [Tag](./unittest_testmacro_package_api/unittest_testmacro_package_macros.md#tag-macro) | The `@Tag` macro can be applied to `@Test` classes and `@Test` or `@TestCase` functions to provide metadata for test entities. |
| [Test](./unittest_testmacro_package_api/unittest_testmacro_package_macros.md#test-macro) | Applied to top-level functions or top-level classes to convert them into unit test classes. |
| [TestBuilder](./unittest_testmacro_package_api/unittest_testmacro_package_macros.md#testbuilder-macro) | Declares a [dynamic test](../unittest/unittest_samples/unittest_dynamic_tests.md#dynamic-testing) suite. |
| [TestCase](./unittest_testmacro_package_api/unittest_testmacro_package_macros.md#testcase-macro) | Marks functions within a unit test class to become test cases for unit testing. |
| [Timeout](./unittest_testmacro_package_api/unittest_testmacro_package_macros.md#timeout-macro) | Indicates that a test should terminate after a specified time. Useful for testing complex algorithms that may run for extended periods or enter infinite loops. |
| [Types](./unittest_testmacro_package_api/unittest_testmacro_package_macros.md#types-macro) | Provides type parameters for test classes or test functions. Can be placed on either test classes or test functions. |