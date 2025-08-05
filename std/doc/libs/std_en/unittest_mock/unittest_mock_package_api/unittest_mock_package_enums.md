# Enumerations

## enum Exhaustiveness

```cangjie
public enum Exhaustiveness {
    Exhaustive | Partial
}
```

Function: This enumeration type is used to specify the verification mode for the `unordered` function, containing two modes.

The Exhaustive mode requires that all [stub signatures](../unittest_mock_samples/mock_framework_basics.md#stub-signatures) within the verification scope must be defined in the verification actions.

The Partial mode has looser requirements, allowing the execution behavior of "stub signatures" that are not defined by verification actions within the verification scope to be ignored.

For example:

```cangjie
for (i in 0..6) {
    foo.bar(i % 3)
}

// This verification action will throw an exception because foo.bar() was executed 6 times within the verification scope, while this verification action only specifies 4 execution behaviors.
Verify.unordered(
    @Called(foo.bar(1)).times(2),
    @Called(foo.bar(2)).times(2)
)

// This verification action will succeed. After specifying the Partial mode, the 2 execution behaviors not defined in the verification action will be ignored.
Verify.unordered(Partial,
    @Called(foo.bar(1)).times(2),
    @Called(foo.bar(2)).times(2)
)
```

### Exhaustive

```cangjie
Exhaustive
```

Function: Requires that every call to a "stub signature" within the verification scope must be defined in the verification actions.

### Partial

```cangjie
Partial
```

Function: Allows the existence of calls to "stub signatures" within the verification scope that are not defined in the verification actions.

## enum MockSessionKind

```cangjie
public enum MockSessionKind {
    | Forbidden
    | Stateless
    | Verifiable
}
```

Function: Controls the types of [stubs](../unittest_mock_samples/mock_framework_basics.md#configuration-api) allowed to be used in [MockSession](./unittest_mock_package_classes.md#static-func-opensession).  
Only stubs created in `Verifiable` `Session` can have their expectations verified.

### Forbidden

Function: Prohibits the use of [stubs](../unittest_mock_samples/mock_framework_basics.md#configuration-api).

### Stateless

Function: Only allows stateless [stubs](../unittest_mock_samples/mock_framework_basics.md#configuration-api).  
Prohibits inherently stateful operations such as `returnsConsequively` and cardinality specifiers (expressions specifying expected execution counts).

### Verifiable

Function: Allows arbitrary [stubs](../unittest_mock_samples/mock_framework_basics.md#configuration-api).

## enum StubMode

```cangjie
public enum StubMode {
    | ReturnsDefaults
    | SyntheticFields
}
```

Function: Controls the [stub modes](../unittest_mock_samples/mock_framework_stubs.md#stub-modes).

### ReturnsDefaults

Function: The `Mock object` will return default values for primitive types. Used to simplify the configuration steps of `mock objects`.  
These default values are generally null or 0.  
Supported primitive types include: Unit, numeric types (e.g., Int64), option types, Bool, String, Array, ArrayList, HashSet, HashMap.

### SyntheticFields

Function: The `Mock object` will treat its mutable properties and fields as synthetic fields.  
Similar to directly using SyntheticField but more concise.  
Reading uninitialized fields will result in an error.