# Functions

## func emptyIterable\<T>()

```cangjie
public func emptyIterable<T>(): Iterable<T>
```

Function: Creates an empty iterator.

Return value:

- [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - An empty iterator.

## func random\<T>() where T <: Arbitrary\<T>

```cangjie
public func random<T>(): RandomDataStrategy<T> where T <: Arbitrary<T>
```

Function: This function generates random data of type T, where T must implement the [Arbitrary](./unittest_prop_test_package_interfaces.md#interface-arbitrary)\<T> interface. The return value serves as a parameter source for parameterized testing.

Return value:

- [RandomDataStrategy](../../unittest/unittest_package_api/unittest_package_classes.md#class-randomdatastrategyt)\<T> - An instance of the RandomDataStrategy interface using random data generation.

## func randomInRange\<T>(Option\<T>, Option\<T>)

```cangjie
public func randomInRange<T>(min!: Option<T> = None, max!: Option<T> = None): RandomDataStrategyRange<T> where T <: ArbitraryRange<T>
```

Function: Creates a [RandomDataStrategyRange\<T>](../unittest_prop_test_package_api/unittest_prop_test_package_classes.md#class-randomdatastrategyranget)

Parameters:

- min: T - The minimum value (inclusive).
- max: T - The maximum value (exclusive).

Return value:

- [RandomDataStrategyRange\<T>](../unittest_prop_test_package_api/unittest_prop_test_package_classes.md#class-randomdatastrategyranget) - A random data strategy generator.