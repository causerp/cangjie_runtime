# std.unittest.mock

## Feature Overview

The unittest.mock package provides a **mock framework** for unit testing, offering APIs to create and configure **mock objects** (as well as standalone declarations such as top-level/static functions and top-level/static variables) that maintain API signatures consistent with real objects. Mock testing technology supports isolated test code, where test cases use mock objects to eliminate external dependencies.

**Key features of the mock framework**:

* Create mock objects and spy objects: No need to modify production code during testing. This step is unnecessary when configuring standalone declarations (e.g., top-level functions/variables or static functions/variables).
* Simple [Configuration API](./unittest_mock_samples/mock_framework_basics.md#configuration-api): Configure behaviors of mock/spy objects (or standalone declarations).
* Part of the unit testing framework: Seamlessly integrates with other unit testing framework features, with readable error output.
* Automatic behavior verification: Most scenarios require no additional verification code.
* Provides [Verification API](./unittest_mock_samples/mock_framework_verification.md#mock-framework-verification-api): Supports testing complex internal interactions.

**Use cases include**:

* Simplifying test setup and code.
* Testing exception scenarios.
* Replacing *costly* dependencies with lightweight mock objects to improve test performance.
* Verifying complex scenarios such as call order/frequency.

Users can follow the [Quick Start Guide](./unittest_mock_samples/mock_framework_getting_started.md#mock-framework-getting-started) to write their first mock-enabled test program. The documentation also explains [basic concepts and usage](./unittest_mock_samples/mock_framework_basics.md#mock-basic-concepts-and-usage) with sample code, along with advanced usage of the Configuration API ([Stubs](./unittest_mock_samples/mock_framework_stubs.md#stub-usage-guide)).

## API List

### Functions

| Function Name | Description |
| ------------- | ----------- |
| [mock\<T>()](./unittest_mock_package_api/unittest_mock_package_functions.md#func-mockt) | Creates a [`mock object`](./unittest_mock_samples/mock_framework_basics.md#creating-mock-objects) of type T. By default, all member functions, properties, or operator overloads have no concrete implementation. |
| [mock\<T>(Array\<StubMode>)](./unittest_mock_package_api/unittest_mock_package_functions.md#func-mocktarraystubmode) | Creates a [`mock object`](../unittest_mock/unittest_mock_samples/mock_framework_basics.md#creating-mock-objects) of type T, with parameters specifying the [Stub Mode](../unittest_mock/unittest_mock_samples/mock_framework_stubs.md#stub-modes). |
| [spy\<T>(T)](./unittest_mock_package_api/unittest_mock_package_functions.md#func-spytt) | Creates a `spy object` (an extension of `mock object` with default "skeleton" implementations for members) of type T. This object wraps the input instance, and by default, member functions/properties/operator overloads delegate to the corresponding members of the wrapped instance. |

### Interfaces

| Interface Name | Description |
| -------------- | ----------- |
| [ValueListener\<T>](./unittest_mock_package_api/unittest_mock_package_interfaces.md#interface-valuelistenert) | Provides member functions to "listen" to parameters passed to stub signatures. |

### Classes

| Class Name | Description |
| --------- | ----------- |
| [ActionSelector](./unittest_mock_package_api/unittest_mock_package_classes.md#class-actionselector) | Abstract class providing methods to specify an [Action API](../unittest_mock/unittest_mock_samples/mock_framework_basics.md#action-api) for member functions, supporting method chaining. |
| [AnyMatcher](./unittest_mock_package_api/unittest_mock_package_classes.md#class-anymatcher) | Matches any parameter (stub signature accepts arbitrary arguments). |
| [ArgumentMatcher](./unittest_mock_package_api/unittest_mock_package_classes.md#class-argumentmatcher) | Abstract parameter matcher class; this and its subclasses can serve as stub signature parameter types. |
| [CardinalitySelector\<A>](./unittest_mock_package_api/unittest_mock_package_classes.md#class-cardinalityselectora) | Provides APIs to define execution count for the most recent behavior of a stub signature. |
| [ConfigureMock](./unittest_mock_package_api/unittest_mock_package_classes.md#class-configuremock) | Configures `mock objects`. |
| [Continuation\<A>](./unittest_mock_package_api/unittest_mock_package_classes.md#class-continuationa) | Provides APIs to further define stub signature behaviors. |
| [GetterActionSelector\<TRet>](./unittest_mock_package_api/unittest_mock_package_classes.md#class-getteractionselectortret) | Provides methods to specify an [Action API](../unittest_mock/unittest_mock_samples/mock_framework_basics.md#action-api) for property `Getter` functions, supporting method chaining. |
| [Matchers](./unittest_mock_package_api/unittest_mock_package_classes.md#class-matchers) | Provides static functions to generate [matchers](./unittest_mock_samples/mock_framework_basics.md#parameter-matchers). Matcher objects can only be created via these static functions and are usable in [Stub Chains](./unittest_mock_samples/mock_framework_basics.md#stub-chains). |
| [MethodActionSelector\<TRet>](./unittest_mock_package_api/unittest_mock_package_classes.md#class-methodactionselectortret) | Provides methods to specify an [Action API](../unittest_mock/unittest_mock_samples/mock_framework_basics.md#action-api) for member functions, supporting method chaining. |
| [MockFramework](./unittest_mock_package_api/unittest_mock_package_classes.md#class-mockframework) | Provides functions for framework setup and teardown during test execution. |
| [NoneMatcher](./unittest_mock_package_api/unittest_mock_package_classes.md#class-nonematcher) | Matches parameters with value `None`. |
| [OrderedVerifier](./unittest_mock_package_api/unittest_mock_package_classes.md#class-orderedverifier) | Collects "verification statements" for dynamic verification behaviors in `ordered` functions. |
| [SetterActionSelector\<TRet>](./unittest_mock_package_api/unittest_mock_package_classes.md#class-setteractionselectortret) | Provides methods to specify an [Action API](../unittest_mock/unittest_mock_samples/mock_framework_basics.md#action-api) for property `Setter` functions, supporting method chaining. |
| [SyntheticField\<T>](./unittest_mock_package_api/unittest_mock_package_classes.md#class-syntheticfieldt) | Synthetic field. |
| [TypedMatcher\<T>](./unittest_mock_package_api/unittest_mock_package_classes.md#class-typedmatchert) | Matches parameters by type. |
| [UnorderedVerifier](./unittest_mock_package_api/unittest_mock_package_classes.md#class-unorderedverifier) | Collects "verification statements" for dynamic verification behaviors in `unordered` functions. |
| [Verify](./unittest_mock_package_api/unittest_mock_package_classes.md#class-verify) | Provides static methods (e.g., `that`, `ordered`, `unorder`) to define verification actions. |
| [VerifyStatement](./unittest_mock_package_api/unittest_mock_package_classes.md#class-verifystatement) | Represents a single verification statement for a "stub signature" within a verification scope, with member functions to specify execution count. |

### Enums

| Enum Name | Description |
| --------- | ----------- |
| [Exhaustiveness](./unittest_mock_package_api/unittest_mock_package_enums.md#enum-exhaustiveness) | Specifies verification modes for `unordered` functions (two modes available). |
| [MockSessionKind](./unittest_mock_package_api/unittest_mock_package_enums.md#enum-mocksessionkind) | Controls allowed [Stub](../unittest_mock/unittest_mock_samples/mock_framework_basics.md#configuration-api) types in MockSession. |
| [StubMode](./unittest_mock_package_api/unittest_mock_package_enums.md#enum-stubmode) | Controls [Stub Modes](../unittest_mock/unittest_mock_samples/mock_framework_stubs.md#stub-modes). |