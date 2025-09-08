# std.unittest.prop_test

## Feature Description

unittest.prop_test provides the types and methods required for parameterized testing in the unit testing framework.

## API List

### Functions

| Function Name | Description |
| --------------------------- | ------------------------ |
| [emptyIterable\<T>()](./unittest_prop_test_package_api/unittest_prop_test_package_functions.md#func-emptyiterablet) | Creates an empty iterator. |
| [random\<T>()](./unittest_prop_test_package_api/unittest_prop_test_package_functions.md#func-randomt-where-t--arbitraryt) | This function generates random data of type T, where T must implement the Arbitrary\<T> interface. The return value serves as a parameter source for parameterized testing. |
| [randomInRange\<T>(Option\<T>, Option\<T>)](./unittest_prop_test_package_api/unittest_prop_test_package_functions.md#func-randominrangetoptiont-optiont) | Creates a [RandomDataStrategyRange\<T>](./unittest_prop_test_package_api/unittest_prop_test_package_classes.md#class-randomdatastrategyranget) |

### Interfaces

| Interface Name | Description |
| --------------------------- | ------------------------ |
| [ArbitraryRange\<T>](./unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-arbitraryranget) | Provides methods for generating values within a specified range for different types. |
| [Arbitrary\<T>](./unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-arbitraryt) | Interface for generating random values of type T. |
| [Generator](./unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-generatort) | Generates values of type T. |
| [IndexAccess](./unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-indexaccess) | Utility interface for accessing tuple elements by index. |
| [RandomSource](./unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-randomsource) | Provides the capability to generate primitive random data required by [Arbitrary\<T>](./unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-arbitraryt). |
| [Shrink](./unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-shrinkt) | Reduces a value of type T to multiple "smaller" values. |

### Classes

| Class Name | Description |
| --------------------------- | ------------------------ |
| [Generators](./unittest_prop_test_package_api/unittest_prop_test_package_classes.md#class-generators) | Contains helper functions to assist developers in writing their own generators. |
| [RandomDataProvider\<T>](./unittest_package_api/unittest_package_classes.md#class-randomdataprovidert) | Implementation of the DataProvider interface using random data generation. |
| [RandomDataShrinker\<T>](./unittest_package_api/unittest_package_classes.md#class-randomdatashrinkert) | Implementation of the DataShrinker interface using random data generation. |
| [RandomDataStrategy\<T>](./unittest_package_api/unittest_package_classes.md#class-randomdatastrategyt) | Implementation of the DataStrategy interface using random data generation. |
| [LazySeq\<T>](./unittest_prop_test_package_api/unittest_prop_test_package_classes.md#class-lazyseqt) | Lazily computed sequence of values of type T. Used to compute and memoize values during iteration. |
| [ShrinkHelpers](./unittest_prop_test_package_api/unittest_prop_test_package_classes.md#class-shrinkhelpers) | Provides methods for implementing shrink iterators on tuples. |

### Structs

| Struct Name | Description |
| --------------------------- | ------------------------ |
| [Function0Wrapper](./unittest_prop_test_package_api/unittest_prop_test_package_structs.md#struct-function0wrapperr) | Wraps a closure as a struct. |
| [KeyRandom](./unittest_prop_test_package_api/unittest_prop_test_package_structs.md#struct-keyrandom) | Used for creating key values in [Configuration](../unittest_common/unittest_common_package_api/unittest_common_package_classes.md#class-configuration). |
| [TupleWrapper2](./unittest_prop_test_package_api/unittest_prop_test_package_structs.md#struct-tuplewrapper2t0-t1) | Wraps a closure as a struct. The closure takes two parameters. |
| [TupleWrapper3](./unittest_prop_test_package_api/unittest_prop_test_package_structs.md#struct-tuplewrapper3t0-t1-t2) | Wraps a closure as a struct. The closure takes three parameters. |
| [TupleWrapper4](./unittest_prop_test_package_api/unittest_prop_test_package_structs.md#struct-tuplewrapper4t0-t1-t2-t3) | Wraps a closure as a struct. The closure takes four parameters. |
| [TupleWrapper5](./unittest_prop_test_package_api/unittest_prop_test_package_structs.md#struct-tuplewrapper5t0-t1-t2-t3-t4) | Wraps a closure as a struct. The closure takes five parameters. |