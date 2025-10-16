# Classes

## class ActionSelector

```cangjie
public sealed abstract class ActionSelector {}
```

Functionality: This abstract class provides methods for assigning an [Action API](../unittest_mock_samples/mock_framework_basics.md#action-api) to member functions and enabling method chaining.

When the `@On` macro call expression is passed with a call expression of a member function from a `mock object` or `spy object`, it returns an instance of [ActionSelector](#class-actionselector). That is, APIs in this class or its subclasses can insert stub code for member functions.

### func fails()

```cangjie
func fails(): Unit
```

Functionality: Defines that calling the stub signature will cause the test to fail, throwing an [AssertionException](../../unittest/unittest_package_api/unittest_package_exceptions.md#class-assertexception) when the stub signature is executed.

## class AnyMatcher

```cangjie
public class AnyMatcher <: ArgumentMatcher {}
```

Functionality: A wildcard argument matcher that allows any parameters in stub signatures.

Parent Types:

- [ArgumentMatcher](#class-argumentmatcher)

### func matchesAny(Any)

```cangjie
public func matchesAny(_: Any): Bool
```

Functionality: Matches any value of any type.

Parameters:

- _: [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - The input parameter to be checked. Any value of any type.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Always returns `true`.

### extend AnyMatcher

```cangjie
extend AnyMatcher {}
```

Functionality: Extends [AnyMatcher](#class-anymatcher).

#### func value\<T>()

```cangjie
public func value<T>(): T
```

Functionality: The return value of the argument matcher required by the framework.

Return Value:

- T - A value matching the type of the actual input parameter.

## class ArgumentMatcher

```cangjie
public abstract class ArgumentMatcher {}
```

Functionality: An abstract class for argument matchers. This class and its subclasses can be used as parameter types for stub signatures.

### func withDescription(String)

```cangjie
public func withDescription(description: String): ArgumentMatcher
```

Functionality: Configures the description information for the argument matcher when an exception is thrown.

Parameters:

- description: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The description information.

Return Value:

- ArgumentMatcher - The configured argument matcher.

### func forParameter(String)

```cangjie
public func forParameter(name: String): ArgumentMatcher
```

Functionality: Configures the name of the parameter to be matched.

Parameters:

- name: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The name of the parameter to be matched.

Return Value:

- ArgumentMatcher - The configured argument matcher.

### func matchesAny(Any)

```cangjie
public func matchesAny(arg: Any)
```

Functionality: Matches any value of any type.

Parameters:

- arg: [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - The input parameter to be checked. Any value of any type.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The matching result.

## class CardinalitySelector\<A>

```cangjie
public class CardinalitySelector<A> where A <: ActionSelector {}
```

Functionality: This class provides APIs to define the execution count of the most recent behavior of stub signatures.
For example: `@On(foo.bar()).returns("Predefined value").atLeastOnce()`.
For convenience, the most recent behavior of a stub signature is referred to as "stub behavior" in the following text.
The verification capabilities provided by the APIs in this interface are as follows:

- If the call count of the stub signature exceeds the specified number, an [ExpectationFailedException](./unittest_mock_package_exceptions.md#class-expectationfailedexception) will be thrown immediately.
- If the call count of the stub signature is insufficient, the framework will throw an [ExceptionFailedException](./unittest_mock_package_exceptions.md#class-expectationfailedexception) after the test case execution is completed.

### func anyTimes()

```cangjie
func anyTimes(): Unit
```

Functionality: Defines that the "stub behavior" can be executed any number of times. This function does not perform any validation on the call count of the stub signature.

### func atLeastOnce()

```cangjie
func atLeastOnce(): Unit
```

Functionality: Defines that the "stub behavior" must be executed at least once. Throws an exception if verified less than once.

Exceptions:

- [ExceptionFailedException](./unittest_mock_package_exceptions.md#class-expectationfailedexception) - Thrown when the "stub behavior" is executed less than once.

### func atLeastTimes(Int64)

```cangjie
func atLeastTimes(minTimesExpected: Int64): Unit
```

Functionality: Defines that the "stub behavior" must be executed at least the specified number of times. Throws an exception if the actual execution count is less than the specified minimum.

Parameters:

- minTimesExpected: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The minimum expected number of times the "stub behavior" should be executed.

Exceptions:

- [ExceptionFailedException](./unittest_mock_package_exceptions.md#class-expectationfailedexception) - Thrown when the "stub behavior" is executed fewer times than specified.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when a negative number is passed as the `minTimesExpected` parameter.

### func once()

```cangjie
func once(): Continuation<A>
```

Functionality: Defines that the "stub behavior" should be executed exactly once. Throws an exception if the stub signature is executed more than once.

Return Value:

- [Continuation](#class-continuationa)\<A> - An object instance that can call methods to continue generating [ActionSelector](#class-actionselector) objects.

Exceptions:

- [ExceptionFailedException](./unittest_mock_package_exceptions.md#class-expectationfailedexception) - Thrown immediately if the "stub behavior" is executed more than once.

### func times(Int64)

```cangjie
func times(expectedTimes: Int64): Continuation<A>
```

Functionality: Defines that the "stub behavior" should be executed the specified number of times. Throws an exception if the execution count does not match the specified number.

Parameters:

- expectedTimes: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The expected number of times the "stub behavior" should be executed.

Return Value:

- [Continuation](#class-continuationa)\<A> - An object instance that can call methods to continue generating [ActionSelector](#class-actionselector) objects.

Exceptions:

- [ExceptionFailedException](./unittest_mock_package_exceptions.md#class-expectationfailedexception) - Thrown when the "stub behavior" is not executed the specified number of times.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when a negative number is passed as the `expectedTimes` parameter.

### func times(Int64, Int64)

```cangjie
func times(min!: Int64, max!: Int64): Unit
```

Functionality: Defines a range for the execution count of the "stub behavior". Throws an exception if the execution count falls outside the specified range.

Parameters:

- min!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The minimum expected number of times the "stub behavior" should be executed.
- max!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The maximum expected number of times the "stub behavior" should be executed.

Exceptions:

- [ExceptionFailedException](./unittest_mock_package_exceptions.md#class-expectationfailedexception) - Thrown when the "stub behavior" is not executed within the specified range.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when negative numbers are passed as the `min` or `max` parameters.

## class ConfigureMock

```cangjie
public class ConfigureMock {}
```

Functionality: Configures a `mock object`.

### static func stubGetter\<TRet>(() -> TRet,Option\<String>,String,String,Int64)

```cangjie
public static func stubGetter<TRet>(
    stubCall: () -> TRet,
    prefixRefName: Option<String>,
    fieldOrPropertyName: String,
    callDescription: String,
    lineNumber: Int64
): GetterActionSelector<TRet>
```

Functionality: Creates an operator object for inserting stub code for property Getter methods.

Parameters:

- stubCall: () -> TRet - The call expression corresponding to the stub signature.
- prefixRefName: [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[String](../../core/core_package_api/core_package_structs.md#struct-string)> - The object reference token for simulating class/interface members. For simulating statically declared type reference tokens, it is None for top-level declarations.
- fieldOrPropertyName: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The name of the field or property to be stubbed.
- callDescription: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string representation of the call expression corresponding to the stub signature.
- lineNumber: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The line number of the corresponding call expression.

Return Value:

- [GetterActionSelector](#class-getteractionselectortret)\<TRet> - The operator object for inserting stub code for property Getter methods.

### static func stubFunction\<TRet>(() -> TRet, Array<ArgumentMatcher>, Option<String>, String, String, Int64)

```cangjie
public static func stubFunction<TRet>(
    stubCall: () -> TRet,
    matchers: Array<ArgumentMatcher>,
    prefixRefName: Option<String>,
    methodName: String,
    callDescription: String,
    lineNumber: Int64
): MethodActionSelector<TRet>
```

Functionality: Creates an operator object for inserting stub code for ordinary member methods.

Parameters:

- stubCall: () -> Unit - The call expression corresponding to the stub signature.
- _: () -> TArg - Used to capture the type of a property or field.
- matchers: Array\<[ArgumentMatcher](#class-argumentmatcher)> - The argument matchers for the corresponding input parameters.
- prefixRefName: [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[String](../../core/core_package_api/core_package_structs.md#struct-string)> - The object reference token for simulating class/interface members. For simulating statically declared type reference tokens, it is None for top-level declarations.
- methodName: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The name of the method.
- callDescription: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string representation of the call expression corresponding to the stub signature.
- lineNumber: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The line number of the corresponding call expression.

Return Value:

- [MethodActionSelector](#class-methodactionselectortret)\<TRet> - The operator object for inserting stub code for ordinary member methods.

### static func stubSetter\<TArg>(() -> Unit, () -> TArg,ArgumentMatcher,Option\<String>,String,String,Int64)

```cangjie
public static func stubSetter<TArg>(
    stubCall: () -> Unit,
    _: () -> TArg,
    matcher: ArgumentMatcher,
    prefixRefName: Option<String>,
    fieldOrPropertyName: String,
    callDescription: String,
    lineNumber: Int64
): SetterActionSelector<TArg>
```

Functionality: Creates an operator object for inserting stub code for property Setter methods.

Parameters:

- stubCall: () -> Unit - The call expression corresponding to the stub signature.
- _: () -> TArg - Used to capture the type of a property or field.
- matcher: [ArgumentMatcher](#class-argumentmatcher) - The argument matcher for the input parameter.
- prefixRefName: [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[String](../../core/core_package_api/core_package_structs.md#struct-string)> - The object reference token for simulating class/interface members. For simulating statically declared type reference tokens, it is None for top-level declarations.
- fieldOrPropertyName: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The name of the property or field to be stubbed.
- callDescription: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string representation of the call expression corresponding to the stub signature.
- lineNumber: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The line number of the corresponding call expression.

Return Value:

- [MethodActionSelector](#class-methodactionselectortret)\<TRet> - The operator object for inserting stub code for ordinary member methods.

## class Continuation\<A>

```cangjie
public class Continuation<A> where A <: ActionSelector {}
```

Functionality: This class provides APIs to continue defining the behavior of stub signatures.
The capabilities provided by the methods in this class are as follows:

- Allows the stub signature to perform additional operations when the previous operation is satisfied. A `Continuation` instance is meaningful only when followed by a behavior definition.
- Throws a [MockFrameworkException](./unittest_mock_package_exceptions.md#class-mockframeworkexception) when the previous operation is not satisfied. The exact location where this exception is thrown is not guaranteed.

### func then()

```cangjie
func then(): A
```

Functionality: Returns a subclass object of [ActionSelector](unittest_mock_package_classes.md#class-actionselector) when the previous operation in the chain is completed.

Return Value:

- A - An instance of a subclass object of [ActionSelector](unittest_mock_package_classes.md#class-actionselector).

Exceptions:

- [MockFrameworkException](./unittest_mock_package_exceptions.md#class-mockframeworkexception) - Thrown when the previous operation is not satisfied.

## class GetterActionSelector\<TRet>

```cangjie
public class GetterActionSelector<TRet> <: ActionSelector {}
```

Functionality: This class provides methods for assigning an [Action API](../unittest_mock_samples/mock_framework_basics.md#action-api) to property `Getter` functions and enabling method chaining.
When the `@On` macro call expression is passed with a call expression of a member function from a `mock object` or `spy object`, it returns an instance of [ActionSelector](#class-actionselector). That is, APIs in this class or its subclasses can insert stub code for member functions.

Parent Types:

- [ActionSelector](#class-actionselector)

### func getsField(SyntheticField\<TRet>)

```cangjie
public func getsField(field: SyntheticField<TRet>): CardinalitySelector<GetterActionSelector<TRet>>
```

Functionality: Reads a [synthetic field](../unittest_mock_samples/mock_framework_stubs.md#setting-properties-fields-and-top-level-variables).

Parameters:

- field: [SyntheticField](#class-syntheticfieldt)\<TRet> - The synthetic field for handling mutable properties.

Return Value:

- [CardinalitySelector](#class-cardinalityselectora)\<[GetterActionSelector](#class-getteractionselectortret)\<TRet>> - The operator for expected execution counts.

### func getsOriginal()

```cangjie
public func getsOriginal(): CardinalitySelector<GetterActionSelector<TRet>>
```

Functionality: Reads the original property or field value from the original instance.

Return Value:

- [CardinalitySelector](#class-cardinalityselectora)\<[GetterActionSelector](#class-getteractionselectortret)\<TRet>> - The operator for expected execution counts.

### func returns(TRet)

```cangjie
public func returns(value: TRet): CardinalitySelector<GetterActionSelector<TRet>>
```

Functionality: Specifies the return value.

Parameters:

- value: TRet - The specified return value.

Return Value:

- [CardinalitySelector](#class-cardinalityselectora)\<[GetterActionSelector](#class-getteractionselectortret)\<TRet>> - The operator for expected execution counts.

### func returns(() -> TRet)

```cangjie
public func returns(valueFactory: () -> TRet): CardinalitySelector<GetterActionSelector<TRet>>
```

Functionality: Specifies the return value.

Parameters:

- valueFactory: () -> TRet - The specified return value generator.

Return Value:

- [CardinalitySelector](#class-cardinalityselectora)\<[GetterActionSelector](#class-getteractionselectortret)\<TRet>> - The operator for expected execution counts.

### func returnsConsecutively(Array\<TRet>)

```cangjie
public func returnsConsecutively(values: Array<TRet>): Continuation<GetterActionSelector<TRet>>
```

Functionality: Specifies multiple return values.

Parameters:

- values: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<TRet> - The specified multiple return values.

Return Value:

- [Continuation](#class-continuationa)\<[GetterActionSelector](#class-getteractionselectortret)\<TRet>> - The operator for expected execution counts.

### func returnsConsecutively(ArrayList\<TRet>)

```cangjie
public func returnsConsecutively(values: ArrayList<TRet>): Continuation<GetterActionSelector<TRet>>
```

Functionality: Specifies multiple return values.

Parameters:

- values: [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<TRet> - The specified multiple return values.

Return Value:

- [Continuation](#class-continuationa)\## class Matchers

```cangjie
public class Matchers {}
```

Functionality: This class provides static functions for generating [matchers](../unittest_mock_samples/mock_framework_basics.md#argument-matchers). Matcher objects can only be created through the static functions provided here. Matchers can be used in [stub chains](../unittest_mock_samples/mock_framework_basics.md#stub-chains).

Example: `@On(foo.bar(ofType<Int64>())).returns(1)`

Argument matchers can be used in the parameter expressions of `@On` macro calls to describe which arguments are expected to be passed into [stub signatures](../unittest_mock_samples/mock_framework_basics.md#stub-signatures). Argument matchers have two most common use cases:

- Specifying different behaviors for different arguments. For example:

    ```cangjie
    // When bar's input parameter is 5, return a certain value
    @On(foo.bar(eq(5))).returns(...)
    // When bar's input parameter is 6, throw an exception
    @On(foo.bar(eq(6))).throws(...)
    ```

- Ensuring only certain arguments are passed to specific stub signatures.

    ```cangjie
    let foo = mock<Foo>()
    // bar's input parameter must be positive, otherwise UnhandledCallException will be thrown
    @On(foo.bar(argThat<Int64> { arg => arg > 0 })).returns(...)
    ```

    > **Note:**
    >
    > The above example only applies to `mock object`. `spy object` behaves differently.

    ```cangjie
    let foo = spy(Foo())
    // When bar's input parameter is not positive, the member function of the Foo() object will be called.
    @On(foo.bar(argThat<Int64> { arg => arg <= 0 })).fails()
    ```

### static func any()

```cangjie
public static func any(): AnyMatcher
```

Functionality: Allows any value as an argument.

Return value:

- [AnyMatcher](#class-anymatcher) - An argument matcher that permits any value.

### static func argThat\<T>(ValueListener\<T>, (T) -> Bool)

```cangjie
public static func argThat<T>(listener: ValueListener<T>, predicate: (T) -> Bool): TypedMatcher<T>
```

Functionality: Filters input argument values through the provided predicate closure function, allowing the listener to process the argument values that meet the conditions.

Parameters:

- listener: [ValueListener](unittest_mock_package_interfaces.md#interface-valuelistenert)\<T> - A value listener.
- predicate: (T) ->[Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - A filter that defines the matching conditions for argument values.

Return value:

- [TypedMatcher](#class-typedmatchert)\<T> - A typed matcher with a value listener and filter.

### static func argThat\<T>((T) -> Bool)

```cangjie
public static func argThat<T>(predicate: (T) -> Bool): TypedMatcher<T>
```

Functionality: Filters input values based on the provided predicate closure.

Parameters:

- predicate: (T) ->[Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - A filter.

Return value:

- [TypedMatcher](#class-typedmatchert)\<T> - An instance of a parameter-filtering typed matcher.

### static func argThatNot\<T>((T) -> Bool)

```cangjie
public static func argThatNot<T>(predicate: (T) -> Bool): TypedMatcher<T>
```

Functionality: Filters input values based on the provided predicate closure.

Parameters:

- predicate: (T) ->[Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - A filter.

Return value:

- [TypedMatcher](#class-typedmatchert)\<T> - An instance of a parameter-filtering typed matcher.

### static func capture\<T>(ValueListener\<T>)

```cangjie
public static func capture<T>(listener: ValueListener<T>): TypedMatcher<T>
```

Functionality: Allows the listener to process input argument values of type T. When the type parameter of capture is not specified, the type parameter value of the value listener will be used.

Parameters:

- listener: [ValueListener](unittest_mock_package_interfaces.md#interface-valuelistenert)\<T> - A value listener.

Return value:

- [TypedMatcher](#class-typedmatchert)\<T> - A typed matcher with a value listener.

Note: Value listeners are not allowed to be used within the parameter scope of @Called.

### static func default\<T>(T)

```cangjie
public static func default<T>(target: T): TypedMatcher<T>
```

Functionality: Matches values based on structure (higher priority) or reference equality. If the input argument is neither [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<T> nor a reference type, an exception will be thrown at runtime (no compile-time check).

Parameters:

- target: T - The matching object that must be matched via structure or reference equality.

Return value:

- [TypedMatcher](#class-typedmatchert)\<T> - A default typed matcher.

Exceptions:

- [MockFrameworkException](./unittest_mock_package_exceptions.md#class-mockframeworkexception) - Thrown if the target parameter is neither [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<T> nor a reference type.

### static func eq\<T>(T)

```cangjie
public static func eq<T>(target: T): TypedMatcher<T> where T <: Equatable<T>
```

Functionality: Filters input values based on structural equality with the provided value.

Parameters:

- target: T - The matching object.

Return value:

- [TypedMatcher](#class-typedmatchert)\<T> - An argument matcher that only permits values structurally equal to the given value.

### static func ofType\<T>()

```cangjie
public static func ofType<T>(): TypedMatcher<T>
```

Functionality: Filters input values based on type.

Return value:

- [TypedMatcher](#class-typedmatchert)\<T> - A typed matcher that only permits values of a specific type.

### static func same\<T>(T) where T <: Object

```cangjie
public static func same<T>(target: T): TypedMatcher<T> where T <: Object
```

Functionality: Filters input values based on reference equality with the provided object.

Parameters:

- target: T - The matching object.

Return value:

- [TypedMatcher](#class-typedmatchert)\<T> - An argument matcher that only permits arguments reference-equal to the given object.

### extend Matchers

```cangjie
extend Matchers {}
```

Functionality: Extends [Matchers](#class-matchers).

#### static func none()

```cangjie
public static func none(): NoneMatcher
```

Functionality: Filters input values that are `None`.

Return value:

- [NoneMatcher](#class-nonematcher) - A matcher for `None` values.

## class MethodActionSelector\<TRet>

```cangjie
public class MethodActionSelector<TRet> <: ActionSelector {}
```

Functionality: This class provides an [action API](../unittest_mock_samples/mock_framework_basics.md#action-api) for specifying member functions and allows chained calls. The `@On` macro call expression with a member function call expression of a `mock object` or `spy object` as input returns an instance of [ActionSelector](#class-actionselector)\<TRet> (where `TRet` represents the return type of the member function being configured). That is, the APIs in this class can insert stub code for member functions.

Parent type:

- [ActionSelector](#class-actionselector)

### func callsOriginal()

```cangjie
func callsOriginal(): CardinalitySelector<MethodActionSelector<TRet>>
```

Functionality: Defines the behavior where the stub signature executes the original code logic.

Return value:

- [CardinalitySelector](unittest_mock_package_classes.md#class-cardinalityselectora)\<[MethodActionSelector](#class-methodactionselectortret)\<TRet>> - An instance of [CardinalitySelector](unittest_mock_package_classes.md#class-cardinalityselectora)\<TRet> that defines the behavior of executing original code logic for stub signatures.

### func returns(() -> TRet)

```cangjie
func returns(valueFactory: () -> TRet): CardinalitySelector<MethodActionSelector<TRet>>
```

Functionality: Defines the behavior where the stub signature returns a specified value generated by the provided closure.

Parameters:

- valueFactory: () -> TRet - A closure function (generator) that produces the expected return value.

Return value:

- [CardinalitySelector](unittest_mock_package_classes.md#class-cardinalityselectora)\<[MethodActionSelector](#class-methodactionselectortret)\<TRet>> - An instance of [CardinalitySelector](unittest_mock_package_classes.md#class-cardinalityselectora)\<TRet> that defines the behavior of returning a specified value for stub signatures.

### func returns(TRet)

```cangjie
func returns(value: TRet): CardinalitySelector<MethodActionSelector<TRet>>
```

Functionality: Defines the behavior where the [stub signature](../unittest_mock_samples/mock_framework_basics.md#stub-signature) returns a specified value.

Parameters:

- value: TRet - The expected return value of the stub signature.

Return value:

- [CardinalitySelector](unittest_mock_package_classes.md#class-cardinalityselectora)\<[MethodActionSelector](#class-methodactionselectortret)\<TRet>> - An instance of [CardinalitySelector](unittest_mock_package_classes.md#class-cardinalityselectora)\<TRet> that defines the return behavior of the stub signature.

### func returnsConsecutively(Array\<TRet>)

```cangjie
func returnsConsecutively(values: Array<TRet>): Continuation<MethodActionSelector<TRet>>
```

Functionality: Defines the behavior where the stub signature returns specified values in the order of the list. The stub signature will be called multiple times, equal to the number of values in the array.

Parameters:

- values: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<TRet> - A list of return values for the stub signature.

Return value:

- [Continuation](#class-continuationa)\<[MethodActionSelector](#class-methodactionselectortret)\<TRet>> - An instance of [Continuation](#class-continuationa)\<TRet> that defines the behavior of returning specified values sequentially for stub signatures.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the parameter list is empty.

### func returnsConsecutively(ArrayList\<TRet>)

```cangjie
func returnsConsecutively(values: ArrayList<TRet>): Continuation<MethodActionSelector<TRet>>
```

Functionality: Defines the behavior where the stub signature returns specified values in the order of the list. The stub signature will be called consecutively multiple times, equal to the number of values in the array list.

Parameters:

- values: [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<TRet> - A list of return values for the stub signature.

Return value:

- [Continuation](#class-continuationa)\<[MethodActionSelector](#class-methodactionselectortret)\<TRet>> - An instance of [Continuation](#class-continuationa)\<TRet> that defines the behavior of returning specified values sequentially for stub signatures.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the parameter list is empty.

### func throws(() -> Exception)

```cangjie
func throws(exceptionFactory: () -> Exception): CardinalitySelector<MethodActionSelector<TRet>>
```

Functionality: Defines the behavior where the stub signature throws an exception, with the exception generated by the provided closure function.

> **Explanation:**
>
> throws vs fails
>
> throws means the behavior after the stub signature throws an exception is the purpose of the test. For example, whether the system can recover correctly when certain services are unavailable.
> fails means calling the stub signature will cause the test to fail. That is, if the system behaves correctly, this stub signature should never be called.

Parameters:

- exceptionFactory: () ->[Exception](../../core/core_package_api/core_package_exceptions.md#class-exception) - A closure function (generator) that constructs the exception object expected to be thrown by the stub signature.

Return value:

- [CardinalitySelector](unittest_mock_package_classes.md#class-cardinalityselectora)\<[MethodActionSelector](unittest_mock_package_classes.md#class-methodactionselectortret)<TRet>> - An instance of [CardinalitySelector](unittest_mock_package_classes.md#class-cardinalityselectora)\<R> that defines the behavior of throwing exceptions for stub signatures.

### func throws(Exception)

```cangjie
func throws(exception: Exception): CardinalitySelector<MethodActionSelector<TRet>>
```

Functionality: Defines the behavior where the stub signature throws an exception.

Parameters:

- exception: [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception) - The exception object expected to be thrown by the stub signature.

Return value:

- [CardinalitySelector](unittest_mock_package_classes.md#class-cardinalityselectora)\<[MethodActionSelector](unittest_mock_package_classes.md#class-methodactionselectortret)<TRet>> - An instance of [CardinalitySelector](unittest_mock_package_classes.md#class-cardinalityselectora)\<R> that defines the behavior of throwing exceptions for stub signatures.

## class MockFramework

```cangjie
public class MockFramework {}
```

Functionality: Provides functions for framework preparation and cleanup during test case execution.

### static func openSession(String, MockSessionKind)

```cangjie
public static func openSession(name: String, sessionKind: MockSessionKind): Unit
```

Functionality: Opens a new session. Sessions form a stack-like structure.
Sessions are closed in the reverse order of their creation.
`mock object`s created during a given session can only be accessed within that session or any of its inner sessions.
Each session maintains its own call log, so any verification of calls made within the most recently opened session can only be performed when the session ends.

Parameters:

- name: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The name of the session.
- sessionKind: [MockSessionKind](./unittest_mock_package_enums.md#enum-mocksessionkind) - Specifies the allowed stub types.

### static func closeSession()

```cangjie
public static func closeSession(): Unit
```

Functionality: Opens a new session. Sessions form a stack-like structure.
Sessions are closed in the reverse order of their creation.
`mock object`s created during a given session can only be accessed within that session or any of its inner sessions.
Each session maintains its own call log, so any verification of calls made within the most recently opened session can only be performed when the session ends.

Exceptions:

- [MockFrameworkException](./unittest_mock_package_exceptions.md#class-mockframeworkexception) - Thrown when incorrect configuration is detected.
- [ExpectationFailedException](./unittest_mock_package_exceptions.md#class-expectationfailedexception) - Thrown when expectations are not met.

## class NoneMatcher

```cangjie
public class NoneMatcher <: ArgumentMatcher {}
```

Functionality: A matcher for argument values that are `None`.

Parent type:

- [ArgumentMatcher](#class-argumentmatcher)

### func matchesAny(Any)

```cangjie
public override func matchesAny(arg: Any): Bool
```

Functionality: Matches any input value, returning `true` if the value is None.

Parameters:

- arg: [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - The argument value to be matched.

Return value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the input is None, otherwise returns `false`.

### extend NoneMatcher

```cangjie
extend NoneMatcher {}
```

Functionality: Extends [NoneMatcher](#class-nonematcher).

#### func value\<T>()

```cangjie
public func value<T>(): Option<T>
```

Functionality: The return value of the argument matcher that the framework needs to call.

Return value:

- Option\<T> - A value matching the type of the actual argument.## class OrderedVerifier

```cangjie
public class OrderedVerifier {}
```

Purpose: This type is used to collect "verification statements" that can be dynamically passed into verification behaviors within the `ordered` function.

### func checkThat(VerifyStatement)

```cangjie
public func checkThat(statement: VerifyStatement): OrderedVerifier
```

Purpose: Adds a "verification statement".

Parameters:

- statement: [VerifyStatement](unittest_mock_package_classes.md#class-verifystatement) - The "verification statement" to be added.

Return Value:

- [OrderedVerifier](unittest_mock_package_classes.md#class-orderedverifier) - Returns the object itself.

## class SetterActionSelector\<TRet>

```cangjie
public class SetterActionSelector<TRet> <: ActionSelector {}
```

Purpose: This class provides methods to specify an [Action API](../unittest_mock_samples/mock_framework_basics.md#操作-api) for property `Setter` functions and allows for method chaining.  
When passed an `@On` macro invocation expression of a member function call expression from a `mock object` or `spy object`, it returns an instance of [ActionSelector](#class-actionselector). That is, APIs in this class or its subclasses can insert stub code for member functions.

Parent Type:

- [ActionSelector](#class-actionselector)

### func doesNothing()

```cangjie
public func doesNothing(): CardinalitySelector<SetterActionSelector<TArg>>
```

Purpose: Specifies that the property or field should perform no action.

Return Value:

- [CardinalitySelector](#class-cardinalityselectora)\<[SetterActionSelector](#class-setteractionselectortret)\<TArg>> - An operator for expected execution counts.

### func setsOriginal()

```cangjie
public func setsOriginal(): CardinalitySelector<SetterActionSelector<TArg>>
```

Purpose: Sets the original property or retrieves the field value from the original instance.

Return Value:

- [CardinalitySelector](#class-cardinalityselectora)\<[SetterActionSelector](#class-setteractionselectortret)\<TArg>> - An operator for expected execution counts.

### func setsField(SyntheticField\<TArg>)

```cangjie
public func setsField(field: SyntheticField<TArg>): CardinalitySelector<SetterActionSelector<TArg>>
```

Purpose: Sets a [synthetic field](../unittest_mock_samples/mock_framework_stubs.md#设置属性和字段和顶层变量).

Parameters:

- field: [SyntheticField](#class-syntheticfieldt)\<TArg> - The synthetic field for handling mutable properties.

Return Value:

- [CardinalitySelector](#class-cardinalityselectora)\<[SetterActionSelector](#class-setteractionselectortret)\<TArg>> - An operator for expected execution counts.

### func throws(Exception)

```cangjie
public func throws(exception: Exception): CardinalitySelector<SetterActionSelector<TArg>>
```

Purpose: Specifies an exception to be thrown.

Parameters:

- exception: [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception) - The specified exception to be thrown.

Return Value:

- [CardinalitySelector](#class-cardinalityselectora)\<[SetterActionSelector](#class-setteractionselectortret)\<TArg>> - An operator for expected execution counts.

### func throws(() -> Exception)

```cangjie
public func throws(exceptionFactory: () -> Exception): CardinalitySelector<SetterActionSelector<TArg>>
```

Purpose: Specifies an exception to be thrown.

Parameters:

- exceptionFactory: () -> [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception) - A generator for the specified exception to be thrown.

Return Value:

- [CardinalitySelector](#class-cardinalityselectora)\<[SetterActionSelector](#class-setteractionselectortret)\<TArg>> - An operator for expected execution counts.

## class SyntheticField\<T>

```cangjie
public class SyntheticField<T> {}
```

Purpose: Synthetic field. Used for handling mutable properties and fields.

### static func create(T)

```cangjie
public static func create(initialValue!: T): SyntheticField<T>
```

Purpose: Creates a synthetic field.

Parameters:

- initialValue!: T - The initial value.

Return Value:

- [SyntheticField](#class-syntheticfieldt)\<T> - The synthetic field.

## class TypedMatcher\<T>

```cangjie
public abstract class TypedMatcher<T> <: ArgumentMatcher {}
```

Purpose: Argument type matcher.

Parent Type:

- [ArgumentMatcher](#class-argumentmatcher)

### func matches(T)

```cangjie
public func matches(arg: T): Bool
```

Purpose: Checks whether the input argument type matches the expected type.

Parameters:

- arg: T - The input argument to be checked.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the types match, otherwise `false`.

### func matchesAny(Any)

```cangjie
public func matchesAny(arg: Any): Bool
```

Purpose: Checks whether the input argument type matches the expected type.

Parameters:

- arg: [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - The input argument to be checked.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the types match, otherwise `false`.

### extend\<T> TypedMatcher\<T>

```cangjie
extend<T> TypedMatcher<T> {}
```

Purpose: Extends [TypedMatcher](#class-typedmatchert).

#### func value\<T>()

```cangjie
public func value<T>(): T
```

Purpose: The return value of the argument matcher required by the framework.

Return Value:

- T - A value matching the type of the actual input argument.

## class UnorderedVerifier

```cangjie
public class UnorderedVerifier{}
```

Purpose: This type is used to collect "verification statements" that can be dynamically passed into verification behaviors within the `unordered` function.

### func checkThat(VerifyStatement)

```cangjie
public func checkThat(statement: VerifyStatement):UnorderedVerifier
```

Purpose: Adds a "verification statement".

Parameters:

- statement: [VerifyStatement](unittest_mock_package_classes.md#class-verifystatement) - The "verification statement" to be added.

Return Value:

- [UnorderedVerifier](unittest_mock_package_classes.md#class-unorderedverifier) - Returns the object itself.

## class Verify

```cangjie
public class Verify {}
```

Purpose: [Verify](unittest_mock_package_classes.md#class-verify) provides a series of static methods to support defining verification actions, such as `that`, `ordered`, and `unordered`.

A verification action can include multiple [verification statements](../unittest_mock_samples/mock_framework_verification.md#验证语句和-called-宏) generated by `@Called` to describe the actions to be verified.  
Typically, the verification scope is the function body of the test case, but [Verify](unittest_mock_package_classes.md#class-verify) provides the `clearInvocationLog` function to clear previous execution records, narrowing the verification scope.  
Behavior verification refers to verifying whether the "stub signature" operations are executed as defined. When the actual execution does not match the definition, an exception is thrown.

The specific supported verification behaviors include:

- Whether the specified "stub signature" has been executed.
- Whether the specified "stub signature" has been executed the specified number of times.
- Whether the arguments passed during the execution of the specified "stub signature" meet the requirements.
- Whether the execution order of the specified multiple "stub signatures" meets the requirements.

Behavior verification is primarily completed in the following two steps:

- Define a verification action by calling static methods of [Verify](unittest_mock_package_classes.md#class-verify).
- Define the execution actions of the "stub signatures" to be verified using the `@Called` macro invocation expression. For simplicity, these are referred to as "verification statements" in the following text.

For example:

```cangjie
let foo = mock<Foo>()
// Define "stub behavior" for the "stub signature"
@On(foo.bar().returns(1))
// Actual execution of the "stub signature" in the test case
foo.bar()
// Verify the execution of the "stub signature": foo.bar() was executed at least once
Verify.that(@Called(foo.bar()))
```

Notably, [CardinalitySelector](unittest_mock_package_classes.md#class-cardinalityselectora)\<R> provides some APIs that support verifying certain behaviors. Therefore, users can freely choose different methods for behavior verification.

### static func clearInvocationLog()

```cangjie
public static func clearInvocationLog(): Unit
```

Purpose: Clears previous execution records to narrow the verification scope.

### static func noInteractions(Array\<Object>)

```cangjie
public static func noInteractions(mocks: Array<Object>): Unit
```

Purpose: Verification passes if the objects have no execution actions within the verification scope.

Parameters:

- mocks: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Object](../../core/core_package_api/core_package_classes.md#class-object)> - The list of objects to be verified.

Exceptions:

- [VerificationFailedException](./unittest_mock_package_exceptions.md#class-verificationfailedexception) - Throws an exception if verification fails.

### static func ordered((OrderedVerifier) -> Unit)

```cangjie
public static func ordered( collectStatements: (OrderedVerifier) -> Unit): Unit
```

Purpose: This function supports verifying whether "verification statements" have been executed or whether the execution count meets the definition, while also checking the execution order. By default, the execution count of "verification statements" is once.  
The "verification statements" in the input list must be non-overlapping (i.e., when a single call action can match multiple "verification statements," an exception will be thrown).  
The verification mode is `exhaustive` (full match, all execution cases within the verification scope should be specified in the verification action).

Parameters:

- collectStatements: ([OrderedVerifier](unittest_mock_package_classes.md#class-orderedverifier)) ->[Unit](../../core/core_package_api/core_package_intrinsics.md#unit) - A closure that supports dynamically adding "verification statements."

Exceptions:

- [VerificationFailedException](./unittest_mock_package_exceptions.md#class-verificationfailedexception) - Throws an exception if verification fails.

### static func ordered(Array\<VerifyStatement>)

```cangjie
public static func ordered(statements: Array<VerifyStatement>): Unit
```

Purpose: This function supports verifying whether "verification statements" have been executed or whether the execution count meets the definition, while also checking the execution order. By default, the execution count of "verification statements" is once.  
The "verification statements" in the input list must be non-overlapping (i.e., when a single call action can match multiple "verification statements," an exception will be thrown).  
The verification mode is `exhaustive` (full match, all execution cases within the verification scope should be specified in the verification action).

For example:

```cangjie
for (i in 0..4) {
    foo.bar(i % 2)
}

Verify.ordered(
    @Called(foo.bar(0)),
    @Called(foo.bar(1)),
    @Called(foo.bar(0)),
    @Called(foo.bar(1)),
)

// Will throw an exception because there are 4 executions of foo.bar() in the verification scope, but only 2 executions are verified here.
Verify.ordered(
    @Called(foo.bar(0)),
    @Called(foo.bar(_)),
)
```

Parameters:

- statements: Array\<[VerifyStatement](unittest_mock_package_classes.md#class-verifystatement)> - The "verification statements" to be verified.

Exceptions:

- [VerificationFailedException](./unittest_mock_package_exceptions.md#class-verificationfailedexception) - Throws an exception if verification fails.

### static func that(VerifyStatement)

```cangjie
public static func that(statement: VerifyStatement): Unit
```

Purpose: Verifies whether the single passed "verification statement" has been correctly executed.

Parameters:

- statement: [VerifyStatement](unittest_mock_package_classes.md#class-verifystatement) - The "verification statement" to be verified.

Exceptions:

- [VerificationFailedException](./unittest_mock_package_exceptions.md#class-verificationfailedexception) - Throws an exception if verification fails.

### static func unordered((UnorderedVerifier) -> Unit)

```cangjie
public static func unordered(collectStatements: (UnorderedVerifier) -> Unit): Unit
```

Purpose: This function supports verifying whether "verification statements" have been executed or whether the execution count meets the definition, without checking the execution order. By default, the execution count of "verification statements" is at least once.  
The "verification statements" in the input list must be non-overlapping (i.e., when a single call action can match multiple "verification statements," an exception will be thrown).  
The verification mode is `exhaustive` (full match, all execution cases within the verification scope should be specified in the verification action).  
"Verification statements" are dynamically added through the closure in the parameters. For example:

```cangjie
let totalTimes = getTimes()
for (i in 0..totalTimes) {
    foo.bar(i % 2)
}
// The closure allows the "verification statements" to be determined based on the value of totalTimes
Verify.unordered { v =>
    for (j in 0..totalTimes) {
        v.checkThat(@Called(foo.bar(eq(j % 2))))
    }
}
```

Parameters:

- collectStatements: ([UnorderedVerifier](unittest_mock_package_classes.md#class-unorderedverifier)) ->[Unit](../../core/core_package_api/core_package_intrinsics.md#unit) - A closure that supports dynamically adding "verification statements."

Exceptions:

- [VerificationFailedException](./unittest_mock_package_exceptions.md#class-verificationfailedexception) - Throws an exception if verification fails.

### static func unordered(Array\<VerifyStatement>)

```cangjie
public static func unordered(statements: Array<VerifyStatement>): Unit
```

Purpose: This function supports verifying whether "verification statements" have been executed or whether the execution count meets the definition, without checking the execution order. By default, the execution count of "verification statements" is at least once.  
The "verification statements" in the input list must be non-overlapping (i.e., when a single call action can match multiple "verification statements," an exception will be thrown).  
The verification mode is `exhaustive` (full match, all execution cases within the verification scope should be specified in the verification action).

For example:

```cangjie
let foo = mock<Foo>()
for (i in 0..4) {
    foo.bar(i % 2)
}

// Verifies that bar() was executed at least once with arguments 0 or 1
Verify.unordered(
    @Called(foo.bar(0)),
    @Called(foo.bar(1))
)

// This verification action will throw an exception because `foo.bar(_)` includes `foo.bar(1)`
Verify.unordered(
    @Called(foo.bar(_)).times(2),
    @Called(foo.bar(1)).times(2)
)
// Can be verified as follows:
// Verifies that the call expression with argument 1 was executed twice
Verify.that(@Called(foo.bar(1)).times(2))
// Verifies that the call expression with any argument was executed twice
Verify.that(@Called(foo.bar(_)).times(2)) // called four times in total
```

Parameters:

- statements: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[VerifyStatement](unittest_mock_package_classes.md#class-verifystatement)> - Multiple "verification statements" to be verified. The variadic parameter syntax supports omitting `[]`.

Exceptions:

- [VerificationFailedException](./unittest_mock_package_exceptions.md#class-verificationfailedexception) - Throws an exception if verification fails.

### static func unordered(Exhaustiveness, (UnorderedVerifier) -> Unit)

```cangjie
public static func unordered(exhaustive: Exhaustiveness, collectStatements: (UnorderedVerifier) -> Unit): Unit
```

Purpose: This function supports verifying whether "verification statements" have been executed or whether the execution count meets the definition, without checking the execution order. By default, the execution count of "verification statements" is at least once.  
The "verification statements" in the input list must be non-overlapping (i.e., when a single call action can match multiple "verification statements," an exception will be thrown).  
"Verification statements" are dynamically added through the closure in the parameters.

Parameters:

- collectStatements: ([UnorderedVerifier](unittest_mock_package_classes.md#class-unorderedverifier)) ->[Unit](../../core/core_package_api/core_package_intrinsics.md#unit) - A closure that supports dynamically adding "verification statements."
- exhaustive: [Exhaustiveness](unittest_mock_package_enums.md#enum-exhaustiveness) - The verification mode.

Exceptions:

- [VerificationFailedException](./unittest_mock_package_exceptions.md#class-verificationfailedexception) - Throws an exception if verification fails.

### static func unordered(Exhaustiveness, Array\<VerifyStatement>)

```cangjie
public static func unordered(exhaustive: Exhaustiveness, statements: Array<VerifyStatement>): Unit
```

Purpose: This function supports verifying whether "verification statements" have been executed or whether the execution count meets the definition, without checking the execution order. By default, the execution count of "verification statements" is at least once.  
The "verification statements" in the input list must be non-overlapping (i.e., when a single call action can match multiple "verification statements," an exception will be thrown).

Parameters:

- statements: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[VerifyStatement](unittest_mock_package_classes.md#class-verifystatement)> - Multiple "verification statements" to be verified. The variadic parameter syntax## class VerifyStatement

```cangjie
public class VerifyStatement {}
```

Functionality: This type represents a single verification statement (referred to as "verification statement" above) for a "stub signature" within the verification scope. It provides member functions to specify the execution count of the "stub signature".
Objects of this type can only be created through the `@Called` macro call expression.
Consecutively calling multiple member functions on an object is meaningless and will throw an exception. That is, the execution count can only be specified once.
When no member function is called to specify the execution count, the default verification value for execution count will be based on the type of verification action where the statement resides. For example, a "verification statement" in [Verify](unittest_mock_package_classes.md#class-verify).ordered() defaults to verifying one execution.

### func atLeastOnce()

```cangjie
public func atLeastOnce(): VerifyStatement
```

Functionality: Specifies that this "verification statement" verifies the "stub signature" is executed at least once within the verification scope.

Return value:

- [VerifyStatement](unittest_mock_package_classes.md#class-verifystatement) - Returns the object itself.

Exceptions:

- [MockFrameworkException](./unittest_mock_package_exceptions.md#class-mockframeworkexception) - Thrown when the object has already been assigned an execution count or has been passed into a "verification action".

### func atLeastTimes(Int64)

```cangjie
public func atLeastTimes(minTimesExpected: Int64): VerifyStatement
```

Functionality: Specifies that this "verification statement" verifies the "stub signature" is executed at least the specified number of times within the verification scope.

Parameters:

- minTimesExpected: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The minimum expected number of executions to verify.

Return value:

- [VerifyStatement](unittest_mock_package_classes.md#class-verifystatement) - Returns the object itself.

Exceptions:

- [MockFrameworkException](./unittest_mock_package_exceptions.md#class-mockframeworkexception) - Thrown when the object has already been assigned an execution count or has been passed into a "verification action".
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the number passed as the `minTimesExpected` parameter is negative.

### func once()

```cangjie
public func once(): VerifyStatement
```

Functionality: Specifies that this "verification statement" verifies the "stub signature" is executed exactly once within the verification scope.

Return value:

- [VerifyStatement](unittest_mock_package_classes.md#class-verifystatement) - Returns the object itself.

Exceptions:

- [MockFrameworkException](./unittest_mock_package_exceptions.md#class-mockframeworkexception) - Thrown when the object has already been assigned an execution count or has been passed into a "verification action".

### func times(Int64)

```cangjie
public func times(expectedTimes: Int64): VerifyStatement
```

Functionality: Specifies that this "verification statement" verifies the "stub signature" is executed the specified number of times within the verification scope.

Parameters:

- expectedTimes: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The expected number of executions to verify.

Return value:

- [VerifyStatement](unittest_mock_package_classes.md#class-verifystatement) - Returns the object itself.

Exceptions:

- [MockFrameworkException](./unittest_mock_package_exceptions.md#class-mockframeworkexception) - Thrown when the object has already been assigned an execution count or has been passed into a "verification action".
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the number passed as the `expectedTimes` parameter is negative.

### func times(Int64, Int64)

```cangjie
public func times(min!: Int64, max!: Int64): VerifyStatement
```

Functionality: Specifies that this "verification statement" verifies the execution count of the "stub signature" falls within the specified range within the verification scope.

Parameters:

- min!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The minimum expected number of executions to verify.
- max!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The maximum expected number of executions to verify.

Return value:

- [VerifyStatement](unittest_mock_package_classes.md#class-verifystatement) - Returns the object itself.

Exceptions:

- [MockFrameworkException](./unittest_mock_package_exceptions.md#class-mockframeworkexception) - Thrown when the object has already been assigned an execution count or has been passed into a "verification action".
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the passed `min` or `max` parameter is negative.

### static func fromStub\<R>(() -> R, Array\<ArgumentMatcher>, Option\<String>, String, String, Int64)

```cangjie
public static func fromStub<R>(
    stubCall: () -> R,
    matchers: Array<ArgumentMatcher>,
    objName: Option<String>,
    declarationName: String,
    callDescription: String,
    _: Int64
): VerifyStatement
```

Functionality: Constructs a [VerifyStatement](unittest_mock_package_classes.md#class-verifystatement). For internal framework use, not recommended for direct user invocation.

Parameters:

- stubCall: () -> R - The call expression corresponding to the stub signature.
- matchers: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[ArgumentMatcher](#class-argumentmatcher)> - Parameter matchers for input arguments.
- objName: [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[String](../../core/core_package_api/core_package_structs.md#struct-string)> - The name of the stubbed object.
- declarationName: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The name of the declaration.
- callDescription: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string representation of the call expression corresponding to the stub signature.
- _: Int64 - Line number.

Return value:

- [VerifyStatement](unittest_mock_package_classes.md#class-verifystatement) - Returns the object itself.

### func never()

```cangjie
public func never(): VerifyStatement
```

Functionality: Indicates that this statement will never be executed.

Return value:

- [VerifyStatement](unittest_mock_package_classes.md#class-verifystatement) - Returns the object itself.