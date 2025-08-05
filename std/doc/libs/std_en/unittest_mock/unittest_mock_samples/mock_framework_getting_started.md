# Getting Started with Mock Framework

## Using the Mock Framework

The mock framework is part of the **unit testing** component in the Cangjie standard library. Before using the mock framework, you need to import `unittest.mock.*` and `unittest.mock.mockmacro.*` into your test file.

If you're using the **cjpm** tool, simply run the `cjpm test` command to automatically enable the mock framework.

If you're using **cjc** directly, refer to [Using cjc](./mock_framework_basics.md#using-cjc-compilation).

## Example

Common mock test cases include:

* Calling the [mock constructor](./mock_framework_basics.md#creating-mock-objects) to create mock/spy objects.
* Using the [configuration API](./mock_framework_basics.md#configuration-api) to set up mock behaviors.
* Replacing test code dependencies with mock objects.
* (Optional) Calling the [verification API](./mock_framework_verification.md#mock-framework-verification-api) to verify interactions between test code and mock/spy objects.

Take the following simple API as an example:

<!--compile-test0-->
```cangjie
public interface Repository {
    func requestData(id: UInt64, timeoutMs: Int): String
}

public class Controller {
    public Controller(private let repo: Repository) {}

    public func findData(id: UInt64): ?String {
        try {
            return repo.requestData(id, 100)
        } catch (e: TimeoutException) {
            return None
        }
    }
}
```

If the `Repository` implementation is not ideal—for instance, it may contain complex dependencies, be implemented in other packages, or be too slow for testing—the mock framework can test `Controller` without creating actual dependencies.

Testing the `findData` method:

<!--compile-test0-->
```cangjie
// Import mock framework packages
import std.unittest.mock.*
import std.unittest.mock.mockmacro.*

@Test
class ControllerTest {
    let testId: UInt64 = 100
    let testResponse = "foo"

    @TestCase
    func testFindSuccessfully() {
        // Only need to create a mock, not an actual Repository
        let repository = mock<Repository>()

        // Use @On macro to configure testData behavior
        @On(repository.requestData(testId, _)).returns(testResponse)

        // Create the actual Controller for testing the real implementation
        let controller = Controller(repository)

        // Execute test code
        let result = controller.findData(testId)

        // Run assertions on the result
        @Assert(result == Some(testResponse))
    }

    @TestCase
    func testTimeout() {
        let repository = mock<Repository>()

        // Configure getData to throw an exception
        @On(repository.requestData(testId, _)).throws(TimeoutException())

        let controller = Controller(repository)

        // Test behavior when the underlying implementation throws an exception
        let result = controller.findData(testId)

        // Run assertions on the result
        @Assert(result == None)
    }
}
```