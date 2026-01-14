# Functions

## func mock\<T>()

```cangjie
public func mock<T>(): T
```

Function: Creates a [`mock object`](../unittest_mock_samples/mock_framework_basics.md#creating-mock-objects) of type T. By default, all member functions, properties, or operator overload functions of this object have no concrete implementations.  
The behavior of member functions, properties, or operator overload functions can be specified using `@On`.

Returns:

- T - A `mock object` of type T.

Example:

<!-- run -->
```cangjie
import std.unittest.mock.*

class Generator {
    public func generate(): Int { return 0 }
}

@Test
func test() {
    let generator = mock<Generator>()
    // generator.generate() // expected to fail (not stubbed yet)
}
```

## func mock\<T>(Array\<StubMode>)

```cangjie
public func mock<T>(modes: Array<StubMode>): T
```

Function: Creates a [`mock object`](../unittest_mock_samples/mock_framework_basics.md#creating-mock-objects) of type T. The parameter specifies the [stub modes](../unittest_mock_samples/mock_framework_stubs.md#stub-modes).

Parameters:

- modes: Array\<StubMode> - Specifies the stub modes (multiple modes can be provided).

Returns:

- T - A `mock object` of type T.

Example:

<!-- run -->
```cangjie
import std.unittest.mock.*
import std.unittest.mock.mockmacro.*

interface Api {
    func request(s: String): String
}

@Test
func test() {
    let api = mock<Api>(ReturnsDefaults)
    @Expect(api.request("something"), "")

    @On(api.request("cookie")).returns("🍪")
    @On(api.request("pizza")).returns("🍕")
    @On(api.request("salad")).returns("🥗")

    @Expect(api.request("cookie"), "🍪")
    @Expect(api.request("pizza"), "🍕")
    @Expect(api.request("salad"), "🥗")
    // api.request("pasta") // expected to fail
}
```

## func spy\<T>(T)

```cangjie
public func spy<T>(objectToSpyOn: T): T
```

Function: Creates a `spy object` of type T (an extension of `mock object` - a "skeleton" object with default implementations for members). This object wraps the passed-in object, and by default, its member functions, properties, or operator overload functions will call the corresponding implementations of the passed-in instance object.  
The behavior of member functions, properties, or operator overload functions can be overridden using `@On`.

Parameters:

- objectToSpyOn: T - The instance object to spy on (default implementations will use this object's implementations).

Returns:

- T - A `spy object` of type T.

Example:

<!-- run -->
```cangjie
import std.unittest.mock.*
import std.unittest.mock.mockmacro.*

class GreetingBuilder {
    func date(): String { "January 1st" }
    func greet(name: String): String { "Hello, ${name}. Today is ${date()}." }
}

@Test
func test() {
    let originalBuilder = GreetingBuilder()
    let builder = spy(originalBuilder)

    @Expect(builder.date(), "January 1st")
    @Expect(builder.greet("Jack"), "Hello, Jack. Today is January 1st.")

    @On(builder.date()).returns("February 29th")

    @Expect(builder.date(), "February 29th")
    @Expect(builder.greet("Mary"), "Hello, Mary. Today is February 29th.")
}
```
