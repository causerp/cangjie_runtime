# std.unittest.prop_test

## Function Overview

unittest.prop_test provides the types and methods required for parameterized testing within the unit testing framework.

## API List

### Functions

|              Function Name          |           Description           |
| ----------------------------------- | ------------------------------- |
| [emptyIterable\<T>()](./unittest_prop_test_package_api/unittest_prop_test_package_functions.md#func-emptyiterablet) | Creates an empty iterator. |
| [random\<T>()](./unittest_prop_test_package_api/unittest_prop_test_package_functions.md#func-randomt-where-t--arbitraryt) | Generates random data of type T, where T must implement the Arbitrary\<T> interface. The return value serves as a parameter source for parameterized testing. |

### Interfaces

|              Interface Name          |           Description           |
| ----------------------------------- | ------------------------------- |
| [Arbitrary\<T>](./unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-arbitraryt) | Interface for generating random values of type T. |
| [IndexAccess](./unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-indexaccess) | Utility interface for accessing tuple elements by index. |
| [RandomSource](./unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-randomsource) | Provides the capability to generate primitive type data required by [Arbitrary\<T>](./unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-arbitraryt). |
| [Shrink\<T>](./unittest_prop_test_package_api/unittest_prop_test_package_interfaces.md#interface-shrinkt) | Reduces a value of type T to multiple "smaller" values. |

### Classes

|              Class Name          |           Description           |
| ----------------------------------- | ------------------------------- |
| [Generators](./unittest_prop_test_package_api/unittest_prop_test_package_classes.md#class-generators) | A class containing helper functions to assist developers in writing their own generators. |
| [LazySeq\<T>](./unittest_prop_test_package_api/unittest_prop_test_package_classes.md#class-lazyseqt) | A lazily computed sequence of values of type T. Used for computing and memoizing values during iteration. |
| [ShrinkHelpers](./unittest_prop_test_package_api/unittest_prop_test_package_classes.md#class-shrinkhelpers) | Provides methods for implementing shrink iterators on tuples. |

### Structs

|              Struct Name          |           Description           |
| ----------------------------------- | ------------------------------- |
| [Function0Wrapper](./unittest_prop_test_package_api/unittest_prop_test_package_structs.md#struct-function0wrapperr) | Encapsulates a closure as a struct. |
| [TupleWrapper2](./unittest_prop_test_package_api/unittest_prop_test_package_structs.md#struct-tuplewrapper2t0-t1) | Encapsulates a closure as a struct. The closure takes two parameters. |
| [TupleWrapper3](./unittest_prop_test_package_api/unittest_prop_test_package_structs.md#struct-tuplewrapper3t0-t1-t2) | Encapsulates a closure as a struct. The closure takes three parameters. |
| [TupleWrapper4](./unittest_prop_test_package_api/unittest_prop_test_package_structs.md#struct-tuplewrapper4t0-t1-t2-t3) | Encapsulates a closure as a struct. The closure takes four parameters. |
| [TupleWrapper5](./unittest_prop_test_package_api/unittest_prop_test_package_structs.md#struct-tuplewrapper5t0-t1-t2-t3-t4) | Encapsulates a closure as a struct. The closure takes five parameters. |