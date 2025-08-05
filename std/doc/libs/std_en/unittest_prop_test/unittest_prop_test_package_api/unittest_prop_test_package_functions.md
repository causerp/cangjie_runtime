# Functions

## func emptyIterable\<T>()

```cangjie
public func emptyIterable<T>(): Iterable<T>
```

Function: Creates an empty iterator.

Return value:

- [Iterator](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - An empty iterator.

## func random\<T>() where T <: Arbitrary\<T>

```cangjie
public func random<T>(): RandomDataStrategy<T> where T <: Arbitrary<T>
```

Function: This function generates random data of type T, where T must implement the [Arbitrary](./unittest_prop_test_package_interfaces.md#interface-arbitrary)\<T> interface. The return value serves as a parameter source for parameterized testing.

Return value:

- [Arbitrary](./unittest_prop_test_package_interfaces.md#interface-arbitrary)\<T> - An instance of the [RandomDataStrategy](../../unittest/unittest_package_api/unittest_package_classes.md#class-randomdatastrategyt) interface using randomly generated data.