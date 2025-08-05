# Functions

## func mock\<T>()

```cangjie
public func mock<T>(): T
```

Function: Creates a [`mock object`](../unittest_mock_samples/mock_framework_basics.md#creating-mock-objects) of type T. By default, all member functions, properties, or operator overload functions of this object have no concrete implementations.  
The behavior of member functions, properties, or operator overload functions can be specified using `@On`.

Return Value:

- T - A `mock object` of type T.

## func mock\<T>(Array\<StubMode>)

```cangjie
public func mock<T>(modes: Array<StubMode>): T
```

Function: Creates a [`mock object`](../unittest_mock_samples/mock_framework_basics.md#creating-mock-objects) of type T. The parameter specifies the [stub modes](../unittest_mock_samples/mock_framework_stubs.md#stub-modes).

Parameters:

- modes: Array\<StubMode> - Specifies the stub modes (multiple modes can be provided).

Return Value:

- T - A `mock object` of type T.

## func spy\<T>(T)

```cangjie
public func spy<T>(objectToSpyOn: T): T
```

Function: Creates a `spy object` of type T (an extension of `mock object` - a "skeleton" object with default implementations for members). This object wraps the passed-in object, and by default, its member functions, properties, or operator overload functions will call the corresponding implementations of the passed-in instance object.  
The behavior of member functions, properties, or operator overload functions can be overridden using `@On`.

Parameters:

- objectToSpyOn: T - The instance object to spy on (default implementations will use this object's implementations).

Return Value:

- T - A `spy object` of type T.