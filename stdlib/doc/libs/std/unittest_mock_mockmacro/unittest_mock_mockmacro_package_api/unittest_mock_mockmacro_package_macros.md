# 宏

## `@Called` 宏

功能：创建一个[验证语句](../../unittest_mock/unittest_mock_samples/mock_framework_verification.md#验证语句和-called-宏)。

示例：

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

## `@On` 宏

功能：使用[配置 API](../../unittest_mock/unittest_mock_samples/mock_framework_basics.md#配置-api)定义 mock/spy 对象成员的行为（或重新定义 spy 对象）。

示例：

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
