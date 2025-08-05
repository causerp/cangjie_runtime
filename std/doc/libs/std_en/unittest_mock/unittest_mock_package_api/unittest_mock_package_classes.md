# Classes

## class ActionSelector

```cangjie
public sealed abstract class ActionSelector {}
```

Functionality: This abstract class provides methods for assigning an [Action API](../unittest_mock_samples/mock_framework_basics.md#action-api) to member functions and enables method chaining.

When the `@On` macro call expression takes as input the invocation expression of a member function of a `mock object` or `spy object`, it returns an instance of [ActionSelector](#class-actionselector). That is, APIs in this class or its subclasses can insert stub code for member functions.

### func fails()

```cangjie
func fails(): Unit
```

Functionality: Defines that invoking the stub signature will cause the test to fail, throwing an [AssertionException](../../unittest/unittest_package_api/unittest_package_exceptions.md#class-assertexception) when execution reaches the stub signature.

## class AnyMatcher

```cangjie
public class AnyMatcher <: ArgumentMatcher {}
```

Functionality: A wildcard argument matcher that allows any arguments in the stub signature.

Parent Type:

- [ArgumentMatcher](#class-argumentmatcher)

### func matchesAny(Any)

```cangjie
public func matchesAny(_: Any)
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

Functionality: An abstract class for argument matchers. This class and its subclasses can serve as parameter types for stub signatures.

### func withDescription(String)

```cangjie
public func withDescription(description: String): ArgumentMatcher
```

Functionality: Configures the description information for the argument matcher when it throws an exception.

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

Functionality: This class provides APIs to define the execution count of the most recent behavior of a stub signature. For example: `@On(foo.bar()).returns("Predefined value").atLeastOnce()`. For convenience, the most recent behavior of a stub signature will be referred to as "stub behavior" in subsequent text. The verification capabilities provided by this interface's APIs are as follows:

- If the invocation count of the stub signature exceeds the specified number, an [ExpectationFailedException](./unittest_mock_package_exceptions.md#class-expectationfailedexception) will be thrown immediately.
- If the invocation count of the stub signature is insufficient, the framework will throw an [ExceptionFailedException](./unittest_mock_package_exceptions.md#class-expectationfailedexception) after the test case execution completes.

### func anyTimes()

```cangjie
func anyTimes(): Unit
```

Functionality: Defines that the "stub behavior" can be executed any number of times. This function performs no validation on the invocation count of the stub signature.

### func atLeastOnce()

```cangjie
func atLeastOnce(): Unit
```

Functionality: Defines that the "stub behavior" must be executed at least once. Throws an exception if verified fewer than once.

Exceptions:

- [ExceptionFailedException](./unittest_mock_package_exceptions.md#class-expectationfailedexception) - Thrown when the "stub behavior" is verified to have executed fewer than once.

### func atLeastTimes(Int64)

```cangjie
func atLeastTimes(minTimesExpected: Int64): Unit
```

Functionality: Defines that the "stub behavior" must be executed at least the specified number of times. Throws an exception if the actual execution count is lower than the specified minimum.

Parameters:

- minTimesExpected: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The minimum expected number of times the "stub behavior" should be executed.

Exceptions:

- [ExceptionFailedException](./unittest_mock_package_exceptions.md#class-expectationfailedexception) - Thrown when the "stub behavior" is verified to have executed fewer than the specified number of times.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when a negative number is passed as the `minTimesExpected` parameter.

### func once()

```cangjie
func once(): Continuation<R>
```

Functionality: Defines that the "stub behavior" must be executed exactly once. This function throws an exception if the stub signature is executed more than once.

Return Value:

- [Continuation](#class-continuationa)\<R> - An object instance that can call methods to continue generating [ActionSelector](#class-actionselector) objects.

Exceptions:

- [ExceptionFailedException](./unittest_mock_package_exceptions.md#class-expectationfailedexception) - Thrown immediately if the "stub behavior" is verified to have executed more than once.

### func times(Int64)

```cangjie
func times(expectedTimes: Int64): Continuation<R>
```

Functionality: Defines that the "stub behavior" must be executed the specified number of times. Throws an exception if the execution count does not match.

Parameters:

- expectedTimes: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The expected number of times the "stub behavior" should be executed.

Return Value:

- [Continuation](#class-continuationa)\<R> - An object instance that can call methods to continue generating [ActionSelector](#class-actionselector) objects.

Exceptions:

- [ExceptionFailedException](./unittest_mock_package_exceptions.md#class-expectationfailedexception) - Thrown when the "stub behavior" is verified to have executed a number of times different from the specified count.
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

- [ExceptionFailedException](./unittest_mock_package_exceptions.md#class-expectationfailedexception) - Thrown when the "stub behavior" is verified to have executed a number of times outside the specified range.
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when negative numbers are passed as the `min` or `max` parameters.

## class ConfigureMock

```cangjie
public class ConfigureMock {}
```

Functionality: Configures a `mock object`.

### static func stubGetter\<TObj, TRet>(() -> TRet,TObj,String,String,String,Int64)

```cangjie
public static func stubGetter<TObj, TRet>(
    stubCall: () -> TRet,
    objectReference: TObj,
    objectName: String,
    fieldOrPropertyName: String,
    callDescription: String,
    lineNumber: Int64
): GetterActionSelector<TRet>
```

Functionality: Creates an operator object for inserting stub code for a property's Getter method.

Parameters:

- stubCall: () -> TRet - The invocation expression corresponding to the stub signature.
- objectReference: TObj - A reference to the object being stubbed.
- objectName: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The name of the object being stubbed.
- fieldOrPropertyName: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The name of the field or property being stubbed.
- callDescription: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string representation of the invocation expression corresponding to the stub signature.
- lineNumber: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The line number of the corresponding invocation expression.

Return Value:

- [GetterActionSelector](#class-getteractionselectortret)\<TRet> - An operator object for inserting stub code for a property's Getter method.

### static func stubMethod\<TObj, TRet>(() -> TRet,Array\<ArgumentMatcher>,TObj,String,String,String,Int64)

```cangjie
public static func stubMethod<TObj, TRet>(
    stubCall: () -> TRet,
    matchers: Array<ArgumentMatcher>,
    objectReference: TObj,
    objectName: String,
    methodName: String,
    callDescription: String,
    lineNumber: Int64
): MethodActionSelector<TRet>
```

Functionality: Creates an operator object for inserting stub code for a regular member method.

Parameters:

- stubCall: () -> TRet - The invocation expression corresponding to the stub signature.
- matchers: Array\<[ArgumentMatcher](#class-argumentmatcher)> - The argument matchers for the corresponding input parameters.
- objectReference: TObj - A reference to the object being stubbed.
- objectName: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The name of the object being stubbed.
- methodName: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The name of the method being stubbed.
- callDescription: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string representation of the invocation expression corresponding to the stub signature.
- lineNumber: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The line number of the corresponding invocation expression.

Return Value:

- [MethodActionSelector](#class-methodactionselectortret)\<TRet> - An operator object for inserting stub code for a regular member method.

### static func stubSetter\<TObj, TRet>(() -> Unit, () -> TArg,ArgumentMatcher,TObj,String,String,String,Int64)

```cangjie
public static func stubSetter<TObj, TArg>(
stubCall: () -> Unit,
_: () -> TArg,
matcher: ArgumentMatcher,
objectReference: TObj,
objectName: String,
fieldOrPropertyName: String,
callDescription: String,
lineNumber: Int64
): SetterActionSelector<TArg>
```

Function: Creates an operator object for inserting stub code into property setter methods.

Parameters:

- stubCall: () -> Unit - The invocation expression corresponding to the stub signature.
- _: () -> TArg - Used to capture the type of the property or field.
- matcher: [ArgumentMatcher](#class-argumentmatcher) - The argument matcher for input parameters.
- objectReference: TObj - Reference to the object being stubbed.
- objectName: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Name of the object being stubbed.
- fieldOrPropertyName: [String](../../core/core_package_api/core_package_structs.md#struct-string) - Name of the property or field being stubbed.
- callDescription: [String](../../core/core_package_api/core_package_structs.md#struct-string) - String representation of the invocation expression corresponding to the stub signature.
- lineNumber: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Line number of the corresponding invocation expression.

Return Value:

- [MethodActionSelector](#class-methodactionselectortret)\<TRet> - Operator object for inserting stub code into regular member methods.

## class Continuation\<A>

```cangjie
public class Continuation<A> where A <: ActionSelector {}
```

Function: This class provides an API for continuing to define stub signature behaviors.
The capabilities of methods provided by this class are as follows:

- Allows additional operations to be executed by the stub signature when previous operations are satisfied. A `Continuation` instance is meaningful only when followed by a behavior definition.
- Throws a [MockFrameworkException](./unittest_mock_package_exceptions.md#class-mockframeworkexception) when previous operations are not satisfied. The exact location where this exception is thrown is not guaranteed.

### func then()

```cangjie
func then(): A
```

Function: Returns a subclass object of [ActionSelector](unittest_mock_package_classes.md#class-actionselector) when previous operations in the chain are completed.

Return Value:

- A - Instance of a subclass object of [ActionSelector](unittest_mock_package_classes.md#class-actionselector).

Exceptions:

- [MockFrameworkException](./unittest_mock_package_exceptions.md#class-mockframeworkexception) - Thrown when previous operations are not satisfied.

## class GetterActionSelector\<TRet>

```cangjie
public class GetterActionSelector<TRet> <: ActionSelector {}
```

Function: This class provides methods for specifying an [Operation API](../unittest_mock_samples/mock_framework_basics.md#operation-api) for property `Getter` functions and allows chained calls.
The input parameter is the `@On` macro invocation expression of a member function call expression for a `mock object` or `spy object`, which returns an instance of [ActionSelector](#class-actionselector). That is, the APIs in this class or its subclasses can insert stub code for member functions.

Parent Type:

- [ActionSelector](#class-actionselector)

### func getsField(SyntheticField\<TRet>)

```cangjie
public func getsField(field: SyntheticField<TRet>): CardinalitySelector<GetterActionSelector<TRet>>
```

Function: Reads a [synthetic field](../unittest_mock_samples/mock_framework_stubs.md#setting-properties-and-fields-and-top-level-variables).

Parameters:

- field: [SyntheticField](#class-syntheticfieldt)\<TRet> - Synthetic field for handling mutable properties.

Return Value:

- [CardinalitySelector](#class-cardinalityselectora)\<[GetterActionSelector](#class-getteractionselectortret)\<TRet>> - Operator for expected execution count.

### func getsOriginal()

```cangjie
public func getsOriginal(): CardinalitySelector<GetterActionSelector<TRet>>
```

Function: Reads the original property or obtains the field value from the original instance.

Return Value:

- [CardinalitySelector](#class-cardinalityselectora)\<[GetterActionSelector](#class-getteractionselectortret)\<TRet>> - Operator for expected execution count.

### func returns(TRet)

```cangjie
public func returns(value: TRet): CardinalitySelector<GetterActionSelector<TRet>>
```

Function: Specifies a return value.

Parameters:

- value: TRet - The specified return value.

Return Value:

- [CardinalitySelector](#class-cardinalityselectora)\<[GetterActionSelector](#class-getteractionselectortret)\<TRet>> - Operator for expected execution count.

### func returns(() -> TRet)

```cangjie
public func returns(valueFactory: () -> TRet): CardinalitySelector<GetterActionSelector<TRet>>
```

Function: Specifies a return value.

Parameters:

- valueFactory: () -> TRet - The specified return value generator.

Return Value:

- [CardinalitySelector](#class-cardinalityselectora)\<[GetterActionSelector](#class-getteractionselectortret)\<TRet>> - Operator for expected execution count.

### func returnsConsecutively(Array\<TRet>)

```cangjie
public func returnsConsecutively(values: Array<TRet>)
```

Function: Specifies multiple return values.

Parameters:

- values: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<TRet> - The specified multiple return values.

Return Value:

- [CardinalitySelector](#class-cardinalityselectora)\<[GetterActionSelector](#class-getteractionselectortret)\<TRet>> - Operator for expected execution count.

### func returnsConsecutively(ArrayList\<TRet>)

```cangjie
public func returnsConsecutively(values: ArrayList<TRet>)
```

Function: Specifies multiple return values.

Parameters:

- values: [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<TRet> - The specified multiple return values.

Return Value:

- [CardinalitySelector](#class-cardinalityselectora)\<[GetterActionSelector](#class-getteractionselectortret)\<TRet>> - Operator for expected execution count.

### func throws(Exception)

```cangjie
public func throws(exception: Exception): CardinalitySelector<GetterActionSelector<TRet>>
```

Function: Specifies an exception to be thrown.

Parameters:

- exception: [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception) - The specified exception to be thrown.

Return Value:

- [CardinalitySelector](#class-cardinalityselectora)\<[GetterActionSelector](#class-getteractionselectortret)\<TRet>> - Operator for expected execution count.

### func throws(() -> Exception)

```cangjie
public func throws(exceptionFactory: () -> Exception): CardinalitySelector<GetterActionSelector<TRet>>
```

Function: Specifies an exception to be thrown.

Parameters:

- exceptionFactory: () -> [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception) - The specified exception generator.

Return Value:

- [CardinalitySelector](#class-cardinalityselectora)\<[GetterActionSelector](#class-getteractionselectortret)\<TRet>> - Operator for expected execution count.

### extend MethodActionSelector\<Unit>

```cangjie
extend MethodActionSelector<Unit> {}
```

Function: Extends [MethodActionSelector](#class-methodactionselectortret).

#### func returns()

```cangjie
public func returns(): CardinalitySelector<MethodActionSelector<TRet>>
```

Function: Specifies that the stub function does nothing.

Return Value:

- [CardinalitySelector](#class-cardinalityselectora)\<[GetterActionSelector](#class-getteractionselectortret)\<TRet>> - Operator for expected execution count.

## class Matchers

```cangjie
public class Matchers {}
```

Function: This class provides static functions for generating [matchers](../unittest_mock_samples/mock_framework_basics.md#argument-matchers). Matcher objects can only be generated through the static functions here. Matchers can be used in [stub chains](../unittest_mock_samples/mock_framework_basics.md#stub-chain).

For example: `@On(foo.bar(ofType<Int64>())).returns(1)`

Argument matchers can be used in the input parameters of the `@On` macro invocation expression to describe which parameters are expected to be passed into the [stub signature](../unittest_mock_samples/mock_framework_basics.md#stub-signature). The two most common uses of argument matchers are:

- Specifying different behaviors for different parameters. For example:

    ```cangjie
    // Returns a value when the input parameter of bar is 5
    @On(foo.bar(eq(5))).returns(...)
    // Throws an exception when the input parameter of bar is 6
    @On(foo.bar(eq(6))).throws(...)
    ```

- Ensuring that only certain parameters are passed into certain stub signatures.

    ```cangjie
    let foo = mock<Foo>()
    // The input parameter of bar must be positive; otherwise, an UnhandledCallException will be thrown
    @On(foo.bar(argThat<Int64> { arg => arg > 0 })).returns(...)
    ```

    > **Note:**
    >
    > The above example applies only to `mock object`. The behavior of `spy object` is different.

    ```cangjie
    let foo = spy(Foo())
    // Calls the member function of the Foo() object when the input parameter of bar is not positive
    @On(foo.bar(argThat<Int64> { arg => arg <= 0 })).fails()
    ```

### static func any()

```cangjie
public static func any(): AnyMatcher
```

Function: Allows any value as a parameter.

Return Value:

- [AnyMatcher](#class-anymatcher) - Argument matcher that allows any value.

### static func argThat\<T>(ValueListener\<T>, (T) -> Bool)

```cangjie
public static func argThat<T>(listener: ValueListener<T>, predicate: (T) -> Bool): TypedMatcher<T>
```

Function: Filters input parameter values through the provided predicate closure function, allowing the listener to process input parameter values that meet the conditions.

Parameters:

- listener: [ValueListener](unittest_mock_package_interfaces.md#interface-valuelistenert)\<T> - Value listener.
- predicate: (T) ->[Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Filter used to define matching conditions for parameter values.

Return Value:

- [TypedMatcher](#class-typedmatchert)\<T> - Typed matcher with a value listener and filter.

### static func argThat\<T>((T) -> Bool)

```cangjie
public static func argThat<T>(predicate: (T) -> Bool): TypedMatcher<T>
```

Function: Filters input values based on the provided predicate closure.

Parameters:

- predicate: (T) ->[Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Filter.

Return Value:

- [TypedMatcher](#class-typedmatchert)\<T> - Instance of the parameter filtering typed matcher.

### static func argThatNot\<T>((T) -> Bool)

```cangjie
public static func argThatNot<T>(predicate: (T) -> Bool): TypedMatcher<T>
```

Function: Filters input values based on the provided predicate closure.

Parameters:

- predicate: (T) ->[Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The filter predicate.

Return Value:

- [TypedMatcher](#class-typedmatchert)\<T> - An instance of the parameter-filtering typed matcher.

### static func capture\<T>(ValueListener\<T>)

```cangjie
public static func capture<T>(listener: ValueListener<T>): TypedMatcher<T>
```

Allows a ValueListener to process incoming parameter values of type T. When the type parameter of capture is unspecified, the type parameter value of the ValueListener will be used.

Parameters:

- listener: [ValueListener](unittest_mock_package_interfaces.md#interface-valuelistenert)\<T> - The value listener.

Return Value:

- [TypedMatcher](#class-typedmatchert)\<T> - A typed matcher with the value listener.

Note: Value listeners are not allowed within the parameter scope of @Called.

### static func default\<T>(T)

```cangjie
public static func default<T>(target: T): TypedMatcher<T>
```

Function: Matches values based on structural (higher priority) or referential equality. If the input parameter is neither [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<T> nor a reference type, a runtime exception will be thrown (no compile-time check).

Parameters:

- target: T - The matching object that must satisfy structural or referential equality.

Return Value:

- [TypedMatcher](#class-typedmatchert)\<T> - The default typed matcher.

Exceptions:

- [MockFrameworkException](./unittest_mock_package_exceptions.md#class-mockframeworkexception) - Thrown if the target parameter is neither [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<T> nor a reference type.

### static func eq\<T>(T)

```cangjie
public static func eq<T>(target: T): TypedMatcher<T> where T <: Equatable<T>
```

Function: Filters input values based on structural equality with the provided value.

Parameters:

- target: T - The matching object.

Return Value:

- [TypedMatcher](#class-typedmatchert)\<T> - A parameter matcher that only allows values structurally equal to the given value.

### static func ofType\<T>()

```cangjie
public static func ofType<T>(): TypedMatcher<T>
```

Function: Filters input values based on type.

Return Value:

- [TypedMatcher](#class-typedmatchert)\<T> - A typed matcher that only allows values of the specified type.

### static func same\<T>(T) where T <: Object

```cangjie
public static func same<T>(target: T): TypedMatcher<T> where T <: Object
```

Function: Filters input values based on referential equality with the provided object.

Parameters:

- target: T - The matching object.

Return Value:

- [TypedMatcher](#class-typedmatchert)\<T> - A parameter matcher that only allows values referentially equal to the given object.

### extend Matchers

```cangjie
extend Matchers {}
```

Function: Extends [Matchers](#class-matchers).

#### static func none()

```cangjie
public static func none(): NoneMatcher
```

Function: Filters input values that are `None`.

Return Value:

- [NoneMatcher](#class-nonematcher) - A matcher for `None` values.

## class MethodActionSelector\<TRet>

```cangjie
public class MethodActionSelector<TRet> <: ActionSelector {}
```

Function: This class provides an [Action API](../unittest_mock_samples/mock_framework_basics.md#action-api) for member functions and allows chained calls.  
The input is a `@On` macro call expression for a member function invocation of a `mock object` or `spy object`, which returns an instance of [ActionSelector](#class-actionselector)\<R> (where `R` represents the return type of the configured member function).  
In other words, APIs in this class can insert stub code for member functions.

Parent Type:

- [ActionSelector](#class-actionselector)

### func callsOriginal()

```cangjie
func callsOriginal(): CardinalitySelector<R>
```

Function: Defines the behavior where the stub signature executes the original code logic.

Return Value:

- [CardinalitySelector](unittest_mock_package_classes.md#class-cardinalityselectora)\<R> - An instance of [CardinalitySelector](unittest_mock_package_classes.md#class-cardinalityselectora)\<R> that defines the stub signature's original code execution behavior.

### func returns(() -> R)

```cangjie
func returns(valueFactory: () -> R): CardinalitySelector<R>
```

Function: Defines the behavior where the stub signature returns a value generated by the provided closure.

Parameters:

- valueFactory: () ->R - A closure function (generator) that produces the expected return value.

Return Value:

- [CardinalitySelector](unittest_mock_package_classes.md#class-cardinalityselectora)\<R> - An instance of [CardinalitySelector](unittest_mock_package_classes.md#class-cardinalityselectora)\<R> that defines the stub signature's return behavior.

### func returns(R)

```cangjie
func returns(value: R): CardinalitySelector<R>
```

Function: Defines the behavior where the [stub signature](../unittest_mock_samples/mock_framework_basics.md#stub-signature) returns the specified value.

Parameters:

- value: R - The expected return value of the stub signature.

Return Value:

- [CardinalitySelector](unittest_mock_package_classes.md#class-cardinalityselectora)\<R> - An instance of [CardinalitySelector](unittest_mock_package_classes.md#class-cardinalityselectora)\<R> that defines the stub signature's return behavior.

### func returnsConsecutively(Array\<R>)

```cangjie
func returnsConsecutively(values: Array<R>): Continuation<R>
```

Function: Defines the behavior where the stub signature returns values sequentially from the provided list. The stub signature will be called multiple times, equal to the number of values in the array.

Parameters:

- values: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<R> - A list of return values for the stub signature.

Return Value:

- [Continuation](#class-continuationa)\<R> - An instance of [Continuation](#class-continuationa)\<R> that defines the sequential return behavior of the stub signature.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the parameter list is empty.

### func returnsConsecutively(ArrayList\<R>)

```cangjie
func returnsConsecutively(values: ArrayList<R>): Continuation<R>
```

Function: Defines the behavior where the stub signature returns values sequentially from the provided list. The stub signature will be called consecutively multiple times, equal to the number of values in the array list.

Parameters:

- values: [ArrayList](../../collection/collection_package_api/collection_package_class.md#class-arraylistt)\<R> - A list of return values for the stub signature.

Return Value:

- [Continuation](#class-continuationa)\<R> - An instance of [Continuation](#class-continuationa)\<R> that defines the sequential return behavior of the stub signature.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the parameter list is empty.

### func throws(() -> Exception)

```cangjie
func throws(exceptionFactory: () -> Exception): CardinalitySelector<R>
```

Function: Defines the behavior where the stub signature throws an exception generated by the provided closure.

> **Note:**
>
> throws vs fails
>
> `throws` implies that the behavior after the stub signature throws an exception is the test's objective. For example, whether the system can recover correctly when certain services are unavailable.  
> `fails` implies that invoking the stub signature will cause the test to fail. That is, if the system behaves correctly, this stub signature should never be called.

Parameters:

- exceptionFactory: () ->[Exception](../../core/core_package_api/core_package_exceptions.md#class-exception) - A closure function (generator) that constructs the exception object to be thrown by the stub signature.

Return Value:

- [CardinalitySelector](unittest_mock_package_classes.md#class-cardinalityselectora)\<R> - An instance of [CardinalitySelector](unittest_mock_package_classes.md#class-cardinalityselectora)\<R> that defines the stub signature's exception-throwing behavior.

### func throws(Exception)

```cangjie
func throws(exception: Exception): CardinalitySelector<R>
```

Function: Defines the behavior where the stub signature throws the specified exception.

Parameters:

- exception: [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception) - The exception object to be thrown by the stub signature.

Return Value:

- [CardinalitySelector](unittest_mock_package_classes.md#class-cardinalityselectora)\<R> - An instance of [CardinalitySelector](unittest_mock_package_classes.md#class-cardinalityselectora)\<R> that defines the stub signature's exception-throwing behavior.

## class MockFramework

```cangjie
public class MockFramework {}
```

Function: Provides functions for framework preparation and cleanup during test execution.

### static func openSession

```cangjie
public static func openSession(name: String, sessionKind: MockSessionKind): Unit
```

Function: Opens a new session. Sessions form a stack-like structure.  
Sessions are closed in the reverse order of their creation.  
`Mock objects` created during a given session are only accessible within that session or any of its inner sessions.  
Each session maintains its own call log, so any verification of expectations for calls made within the most recently opened session can only be performed when the session ends.

Parameters:

- name: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The name of the session.
- sessionKind: [MockSessionKind](./unittest_mock_package_enums.md#enum-mocksessionkind) - Specifies the allowed stub types.

### static func closeSession

```cangjie
public static func closeSession(): Unit
```

Function: Opens a new session. Sessions form a stack-like structure.  
Sessions are closed in the reverse order of their creation.  
`Mock objects` created during a given session are only accessible within that session or any of its inner sessions.  
Each session maintains its own call log, so any verification of expectations for calls made within the most recently opened session can only be performed when the session ends.

Exceptions:

- [MockFrameworkException](./unittest_mock_package_exceptions.md#class-mockframeworkexception) - Thrown when incorrect configuration is detected.
- [ExpectationFailedException](./unittest_mock_package_exceptions.md#class-expectationfailedexception) - Thrown when expectations are not met.

## class NoneMatcher

```cangjie
public class NoneMatcher <: ArgumentMatcher {}
```

Function: A matcher for parameter values that are `None`.

Parent Type:

- [ArgumentMatcher](#class-argumentmatcher)

### func matchesAny

```cangjie
public override func matchesAny(arg: Any): Bool
```

Function: Matches any input value, returns `true` when the value is None.

Parameters:

- arg: [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - The input parameter value to be matched.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` when the input is None, otherwise returns `false`.

### extend NoneMatcher

```cangjie
extend NoneMatcher {}
```

Function: Extends [NoneMatcher](#class-nonematcher).

#### func value\<T>()

```cangjie
public func value<T>(): Option<T>
```

Function: The return value of the argument matcher required by the framework.

Return Value:

- Option\<T> - A value matching the type of the actual input parameter.

## class OrderedVerifier

```cangjie
public class OrderedVerifier {}
```

Function: This type is used to collect "verification statements" and can dynamically pass verification behaviors in the `ordered` function.

### func checkThat(VerifyStatement)

```cangjie
public func checkThat(statement: VerifyStatement): OrderedVerifier
```

Function: Adds a "verification statement".

Parameters:

- statement: [VerifyStatement](unittest_mock_package_classes.md#class-verifystatement) - The "verification statement" to be added.

Return Value:

- [OrderedVerifier](unittest_mock_package_classes.md#class-orderedverifier) - Returns the object itself.

## class SetterActionSelector\<TRet>

```cangjie
public class SetterActionSelector<TRet> <: ActionSelector {}
```

Function: This class provides a method to specify an [Operation API](../unittest_mock_samples/mock_framework_basics.md#operation-api) for property `Setter` functions and allows for chained calls. The input is the `@On` macro invocation expression of a member function call expression of a `mock object` or `spy object`, which returns an instance of [ActionSelector](#class-actionselector). That is, the APIs in this class or its subclasses can insert stub code for member functions.

Parent Type:

- [ActionSelector](#class-actionselector)

### func doesNothing()

```cangjie
public func doesNothing(): CardinalitySelector<SetterActionSelector<TArg>>
```

Function: Specifies that the property or field performs no action.

Return Value:

- [CardinalitySelector](#class-cardinalityselectora)\<[GetterActionSelector](#class-getteractionselectortret)\<TRet>> - An operator for the expected execution count.

### func setsOriginal()

```cangjie
public func setsOriginal(): CardinalitySelector<SetterActionSelector<TArg>>
```

Function: Sets the original property or retrieves the field value from the original instance.

Return Value:

- [CardinalitySelector](#class-cardinalityselectora)\<[GetterActionSelector](#class-getteractionselectortret)\<TRet>> - An operator for the expected execution count.

### func setsField(SyntheticField\<TRet>)

```cangjie
public func setsField(field: SyntheticField<TArg>): CardinalitySelector<SetterActionSelector<TArg>>
```

Function: Sets a [synthetic field](../unittest_mock_samples/mock_framework_stubs.md#setting-properties-fields-and-top-level-variables).

Parameters:

- field: [SyntheticField](#class-syntheticfieldt)\<TRet> - A synthetic field for handling mutable properties.

Return Value:

- [CardinalitySelector](#class-cardinalityselectora)\<[GetterActionSelector](#class-getteractionselectortret)\<TRet>> - An operator for the expected execution count.

### func throws(Exception)

```cangjie
public func throws(exception: Exception): CardinalitySelector<GetterActionSelector<TRet>>
```

Function: Specifies throwing an exception.

Parameters:

- exception: [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception) - The specified exception to be thrown.

Return Value:

- [CardinalitySelector](#class-cardinalityselectora)\<[GetterActionSelector](#class-getteractionselectortret)\<TRet>> - An operator for the expected execution count.

### func throws(() -> Exception)

```cangjie
public func throws(exceptionFactory: () -> Exception): CardinalitySelector<GetterActionSelector<TRet>>
```

Function: Specifies throwing an exception.

Parameters:

- exceptionFactory: () -> [Exception](../../core/core_package_api/core_package_exceptions.md#class-exception) - A generator for the specified exception to be thrown.

Return Value:

- [CardinalitySelector](#class-cardinalityselectora)\<[GetterActionSelector](#class-getteractionselectortret)\<TRet>> - An operator for the expected execution count.

## class SyntheticField\<T>

```cangjie
public class SyntheticField<T> {}
```

Function: Synthetic field. Used for handling mutable properties and fields.

### static func create(T)

```cangjie
public static func create(initialValue!: T): SyntheticField<T>
```

Function: Creates a synthetic field.

Parameters:

- initialValue!: T - The initial value.

Return Value:

- [SyntheticField](#class-syntheticfieldt)\<T> - The synthetic field.

## class TypedMatcher\<T>

```cangjie
public abstract class TypedMatcher<T> <: ArgumentMatcher {}
```

Function: Argument type matcher.

Parent Type:

- [ArgumentMatcher](#class-argumentmatcher)

### func matches(T)

```cangjie
public func matches(arg: T): Bool
```

Function: Checks whether the input parameter type matches the expected type.

Parameters:

- arg: T - The input parameter to be checked.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the types match, otherwise returns `false`.

### func matchesAny(Any)

```cangjie
public func matchesAny(arg: Any): Bool
```

Function: Checks whether the input parameter type matches the expected type.

Parameters:

- arg: [Any](../../core/core_package_api/core_package_interfaces.md#interface-any) - The input parameter to be checked.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the types match, otherwise returns `false`.

### extend\<T> TypedMatcher\<T>

```cangjie
extend<T> TypedMatcher<T> {}
```

Function: Extends [TypedMatcher](#class-typedmatchert).

#### func value\<T>()

```cangjie
public func value<T>(): T
```

Function: The return value of the argument matcher required by the framework.

Return Value:

- T - A value matching the type of the actual input parameter.

## class UnorderedVerifier

```cangjie
public class UnorderedVerifier{}
```

Function: This type is used to collect "verification statements" and can dynamically pass verification behaviors in the `unordered` function.

### func checkThat(VerifyStatement)

```cangjie
public func checkThat(statement: VerifyStatement):UnorderedVerifier
```

Function: Adds a "verification statement".

Parameters:

- statement: [VerifyStatement](unittest_mock_package_classes.md#class-verifystatement) - The "verification statement" to be added.

Return Value:

- [UnorderedVerifier](unittest_mock_package_classes.md#class-unorderedverifier) - Returns the object itself.

## class Verify

```cangjie
public class Verify {}
```

Function: [Verify](unittest_mock_package_classes.md#class-verify) provides a series of static methods to support defining required verification actions, such as `that`, `ordered`, and `unorder`.

A verification action can include multiple [verification statements](../unittest_mock_samples/mock_framework_verification.md#verification-statements-and-called-macro) generated by `@Called` to describe the actions to be verified. Typically, the verification scope is the function body of the test case, but [Verify](unittest_mock_package_classes.md#class-verify) provides the `clearInvocationLog` function to clear previous execution records, thereby narrowing the verification scope. Behavior verification refers to verifying whether the "stub signature" operations are executed as defined. If the actual execution does not match the definition, an exception will be thrown.

The specific supported verification behaviors are as follows:

- Whether the specified "stub signature" has been executed.
- Whether the specified "stub signature" has been executed the specified number of times.
- Whether the parameters passed during the execution of the specified "stub signature" meet the requirements.
- Whether the call order of the specified multiple "stub signatures" meets the requirements.

Behavior verification is mainly completed through the following two steps:

- Define a verification action by calling static methods of [Verify](unittest_mock_package_classes.md#class-verify).
- Define the execution actions of the "stub signatures" to be verified using the `@Called` macro invocation expression. For simplicity, this will be referred to as "verification statements" in the following text.

For example:

```cangjie
let foo = mock<Foo>()
// Define the "stub behavior" of the "stub signature"
@On(foo.bar().returns(1))
// Actual execution of the "stub signature" in the test case
foo.bar()
// Verify the execution of the "stub signature": foo.bar() has been executed at least once
Verify.that(@Called(foo.bar()))
```

It is worth noting that [CardinalitySelector](unittest_mock_package_classes.md#class-cardinalityselectora)\<R> provides some APIs that support verifying certain behaviors. Therefore, users can freely choose different methods for behavior verification.

### static func clearInvocationLog()

```cangjie
public static func clearInvocationLog(): Unit
```

Function: Clears the preceding execution records to narrow the verification scope.

### static func noInteractions(Array\<Object>)

```cangjie
public static func noInteractions(mocks: Array<Object>): Unit
```

Function: Verifies that no execution actions have occurred on the objects within the verification scope.

Parameters:

- mocks: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[Object](../../core/core_package_api/core_package_classes.md#class-object)> - The list of objects to be verified.

Exceptions:

- [VerificationFailedException](./unittest_mock_package_exceptions.md#class-verificationfailedexception) - Throws an exception if verification fails.

### static func ordered((OrderedVerifier) -> Unit)

```cangjie
public static func ordered( collectStatements: (OrderedVerifier) -> Unit): Unit
```

Function: This function supports verifying whether "verification statements" have been executed or if their execution count meets the defined criteria, while also validating the execution order. By default, the execution count for a "verification statement" is once.
The "verification statements" in the input list must be mutually exclusive (i.e., if a single call behavior matches multiple "verification statements," an exception will be thrown).
"Verification statements" are dynamically added via the closure in the parameter.
The verification mode is `exhaustive` (full match, where all execution cases within the verification scope should be specified in the verification action).

Parameters:

- collectStatements: ([OrderedVerifier](unittest_mock_package_classes.md#class-orderedverifier)) ->[Unit](../../core/core_package_api/core_package_intrinsics.md#unit) - A closure that supports dynamically adding "verification statements."

Exceptions:

- [VerificationFailedException](./unittest_mock_package_exceptions.md#class-verificationfailedexception) - Throws an exception if verification fails.

### static func ordered(Array\<VerifyStatement>)

```cangjie
public static func ordered(statements: Array<VerifyStatement>): Unit
```

Function: This function supports verifying whether "verification statements" have been executed or if their execution count meets the defined criteria, while also validating the execution order. By default, the execution count for a "verification statement" is once.
The "verification statements" in the input list must be mutually exclusive (i.e., if a single call behavior matches multiple "verification statements," an exception will be thrown).
The verification mode is `exhaustive` (full match, where all execution cases within the verification scope should be specified in the verification action).

Example:

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

// Will throw an exception because there are 4 executions of foo.bar() within the verification scope, but only 2 executions are verified here.
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

Function: Verifies whether the single "verification statement" passed in has been executed correctly.

Parameters:

- statement: [VerifyStatement](unittest_mock_package_classes.md#class-verifystatement) - The "verification statement" to be verified.

Exceptions:

- [VerificationFailedException](./unittest_mock_package_exceptions.md#class-verificationfailedexception) - Throws an exception if verification fails.

### static func unordered((UnorderedVerifier) -> Unit)

```cangjie
public static func unordered(collectStatements: (UnorderedVerifier) -> Unit): Unit
```

Function: This function supports verifying whether "verification statements" have been executed or if their execution count meets the defined criteria, without validating the execution order. By default, the execution count for a "verification statement" is at least once.
The "verification statements" in the input list must be mutually exclusive (i.e., if a single call behavior matches multiple "verification statements," an exception will be thrown).
The verification mode is `exhaustive` (full match, where all execution cases within the verification scope should be specified in the verification action).
"Verification statements" are dynamically added via the closure in the parameter. Example:

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

Function: This function supports verifying whether "verification statements" have been executed or if their execution count meets the defined criteria, without validating the execution order. By default, the execution count for a "verification statement" is at least once.
The "verification statements" in the input list must be mutually exclusive (i.e., if a single call behavior matches multiple "verification statements," an exception will be thrown).
The verification mode is `exhaustive` (full match, where all execution cases within the verification scope should be specified in the verification action).

Example:

```cangjie
let foo = mock<Foo>()
for (i in 0..4) {
    foo.bar(i % 2)
}

// Verifies that bar() has been executed at least once with parameters 0 or 1
Verify.unordered(
    @Called(foo.bar(0)),
    @Called(foo.bar(1))
)

// This verification will throw an exception because `foo.bar(_)` includes `foo.bar(1)`
Verify.unordered(
    @Called(foo.bar(_)).times(2),
    @Called(foo.bar(1)).times(2)
)
// Can be verified as follows:
// Verifies that the call expression with parameter 1 was executed twice
Verify.that(@Called(foo.bar(1)).times(2))
// Verifies that the call expression with any parameter was executed twice
Verify.that(@Called(foo.bar(_)).times(2)) // called four times in total
```

Parameters:

- statements: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[VerifyStatement](unittest_mock_package_classes.md#class-verifystatement)> - The "verification statements" to be verified. Variadic parameter syntax allows omitting `[]`.

Exceptions:

- [VerificationFailedException](./unittest_mock_package_exceptions.md#class-verificationfailedexception) - Throws an exception if verification fails.

### static func unordered(Exhaustiveness, (UnorderedVerifier) -> Unit)

```cangjie
public static func unordered(exhaustive: Exhaustiveness, collectStatements: (UnorderedVerifier) -> Unit): Unit
```

Function: This function supports verifying whether "verification statements" have been executed or if their execution count meets the defined criteria, without validating the execution order. By default, the execution count for a "verification statement" is at least once.
The "verification statements" in the input list must be mutually exclusive (i.e., if a single call behavior matches multiple "verification statements," an exception will be thrown).
"Verification statements" are dynamically added via the closure in the parameter.

Parameters:

- collectStatements: ([UnorderedVerifier](unittest_mock_package_classes.md#class-unorderedverifier)) ->[Unit](../../core/core_package_api/core_package_intrinsics.md#unit) - A closure that supports dynamically adding "verification statements."
- exhaustive: [Exhaustiveness](unittest_mock_package_enums.md#enum-exhaustiveness) - The verification mode.

Exceptions:

- [VerificationFailedException](./unittest_mock_package_exceptions.md#class-verificationfailedexception) - Throws an exception if verification fails.

### static func unordered(Exhaustiveness, Array\<VerifyStatement>)

```cangjie
public static func unordered(exhaustive: Exhaustiveness, statements: Array<VerifyStatement>): Unit
```

Function: This function supports verifying whether "verification statements" have been executed or if their execution count meets the defined criteria, without validating the execution order. By default, the execution count for a "verification statement" is at least once.
The "verification statements" in the input list must be mutually exclusive (i.e., if a single call behavior matches multiple "verification statements," an exception will be thrown).

Parameters:

- statements: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<[VerifyStatement](unittest_mock_package_classes.md#class-verifystatement)> - The "verification statements" to be verified. Variadic parameter syntax allows omitting `[]`.
- exhaustive: [Exhaustiveness](unittest_mock_package_enums.md#enum-exhaustiveness) - The verification mode.

Exceptions:

- [VerificationFailedException](./unittest_mock_package_exceptions.md#class-verificationfailedexception) - Throws an exception if verification fails.

## class VerifyStatement

```cangjie
public class VerifyStatement {}
```

Function: This type represents a single verification statement (i.e., the "verification statement" mentioned above) for a "stub signature" within the verification scope. It provides member functions to specify the execution count of the "stub signature."
Objects of this type can only be created via the `@Called` macro call expression.
Consecutively calling multiple member functions on an object is meaningless and will throw an exception. That is, the execution count can only be specified once.
If no member function is called to specify the execution count, the default execution count verification value will be based on the type of verification action where the statement resides. For example, "verification statements" in [Verify](unittest_mock_package_classes.md#class-verify).ordered() default to verifying execution once.

### func atLeastOnce()

```cangjie
public func atLeastOnce(): VerifyStatement
```

Function: Specifies that this "verification statement" verifies that the "stub signature" has been executed at least once within the verification scope.

Return Value:

- [VerifyStatement](unittest_mock_package_classes.md#class-verifystatement) - Returns the object itself.

Exceptions:

- [MockFrameworkException](./unittest_mock_package_exceptions.md#class-mockframeworkexception) - Throws an exception if the object has already been assigned an execution count or has been passed into a "verification action."

### func atLeastTimes(Int64)

```cangjie
public func atLeastTimes(minTimesExpected: Int64): VerifyStatement
```

Function: Specifies that this "verification statement" verifies that the "stub signature" has been executed at least the specified number of times within the verification scope.

Parameters:

- minTimesExpected: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The minimum expected execution count for verification.

Return Value:

- [VerifyStatement](unittest_mock_package_classes.md#class-verifystatement) - Returns the object itself.

Exceptions:

- [MockFrameworkException](./unittest_mock_package_exceptions.md#class-mockframeworkexception) - Throws an exception if the object has already been assigned an execution count or has been passed into a "verification action."
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception if the number passed as the `minTimesExpected` parameter is negative.

### func once()

```cangjie
public func once(): VerifyStatement
```

Function: Specifies that this "verification statement" verifies that the "stub signature" has been executed exactly once within the verification scope.

Return Value:

- [VerifyStatement](unittest_mock_package_classes.md#class-verifystatement) - Returns the object itself.

Exceptions:

- [MockFrameworkException](./unittest_mock_package_exceptions.md#class-mockframeworkexception) - Throws an exception if the object has already been assigned an execution count or has been passed into a "verification action."

### func times(Int64)

```cangjie
public func times(expectedTimes: Int64): VerifyStatement
```

Function: Specifies that this "verification statement" verifies that the "stub signature" has been executed the specified number of times within the verification scope.

Parameters:

- expectedTimes: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The expected execution count for verification.

Return Value:

- [VerifyStatement](unittest_mock_package_classes.md#class-verifystatement) - Returns the object itself.

Exceptions:

- [MockFrameworkException](./unittest_mock_package_exceptions.md#class-mockframeworkexception) - Throws an exception if the object has already been assigned an execution count or has been passed into a "verification action."
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception if the number passed as the `expectedTimes` parameter is negative.

### func times(Int64, Int64)

```cangjie
public func times(min!: Int64, max!: Int64): VerifyStatement
```

Function: Specifies that this "verification statement" validates that the execution count of the "stub signature" within the verification scope falls within the specified range.

Parameters:

- min!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The minimum expected execution count for verification.
- max!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The maximum expected execution count for verification.

Return Value:

- [VerifyStatement](unittest_mock_package_classes.md#class-verifystatement) - Returns the object itself.

Exceptions:

- [MockFrameworkException](./unittest_mock_package_exceptions.md#class-mockframeworkexception) - Throws an exception when the object has already been assigned an execution count or has been passed into a "verification action".
- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception when the passed `min` or `max` parameters are negative.