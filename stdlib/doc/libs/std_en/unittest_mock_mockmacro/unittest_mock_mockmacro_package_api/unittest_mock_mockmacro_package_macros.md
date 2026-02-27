# Macro

## `@Called` Macro

Function: Creates a [verification statement](../../unittest_mock/unittest_mock_samples/mock_framework_verification.md#verification-statements-and-called-macro).

Example:

<!-- run -->
```cangjie
import std.unittest.mock.*
import std.unittest.mock.mockmacro.*

class Printer {
    public func print(message: String): Bool { return true }
}

@Test
func test() {
    let printer = mock<Printer>()
    @On(printer.print(_)).returns(true)
    @On(printer.print("abc")).returns(false)

    @Expect(printer.print("abc"), false)
    let statementOnce: VerifyStatement = @Called(printer.print("abc")).once()
    Verify.that(statementOnce)

    @Expect(printer.print("xyz"), true)
    @Expect(printer.print("xyz"), true)
    Verify.that(@Called(printer.print("xyz")).times(2))
}
```

## `@On` Macro

Function: Uses the [Configuration API](../../unittest_mock/unittest_mock_samples/mock_framework_basics.md#configuration-api) to define the behavior of mock/spy object members (or redefine spy objects).

Example:

<!-- run -->
```cangjie
import std.unittest.mock.*
import std.unittest.mock.mockmacro.*

class Hasher {
    public func hash(message: String): Int { return -1 }
}

@Test
func test() {
    let hasher = mock<Hasher>()

    @On(hasher.hash("hello")).returns(1)
    @On(hasher.hash("world")).returnsConsecutively(1, 2, 3)
    @On(hasher.hash("")).throws(TimeoutException())
    @On(hasher.hash("answer")).returns({ => 42 })

    @Expect(hasher.hash("hello"), 1)
    @Expect(hasher.hash("hello"), 1)

    @Expect(hasher.hash("world"), 1)
    @Expect(hasher.hash("world"), 2)
    @Expect(hasher.hash("world"), 3)

    @ExpectThrows[TimeoutException](hasher.hash(""))

    @Expect(hasher.hash("answer"), 42)
}
```
