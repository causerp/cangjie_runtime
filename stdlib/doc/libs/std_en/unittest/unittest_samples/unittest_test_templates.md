# Test Template

## Getting Started

Test template functionality helps extract some common test and infrastructure code into reusable components. It is particularly useful for testing class hierarchies.

To create a test template, place the `@TestTemplate` macro on an abstract class:

<!-- compile-test1 -->
```cangjie
public class DbConnection {
    func close() {}
}
@TestTemplate
abstract class DbTest {
    public prop dbConnection: DbConnection

    @TestCase
    func testCommonDbApi1() { /* ... */ }

    @TestCase
    func testCommonDbApi2() { /* ... */ }
}
```

This template can be used to create multiple actual test suites, such as testing connections with different specific databases. To use a test template, simply inherit from the corresponding class:

<!-- compile-test1 -->
```cangjie
@Test
class MySqlTest <: DbTest {
    var dbConnection_: ?DbConnection = None

    public override prop dbConnection: DbConnection {
        get() {
            dbConnection_.getOrThrow()
        }
    }

    @BeforeAll
    func initializeConnection() {
        dbConnection_ = Some(DbConnection())
    }

    @AfterAll
    func closeConnection() {
        dbConnection_?.close()
    }

    @TestCase
    func testSpecificlyMySqlFeatures() {
        /* ... */
    }
}
```

Each test case will run as if it were written in the actual test class itself, with results as follows:

```text
------------------------------------------------------------
TP: default, time elapsed: 177679 ns, RESULT:
    TCS: MySqlTest, time elapsed: 157163 ns, RESULT:
    [ PASSED ] CASE: testCommonDbApi1 (34704 ns)
    [ PASSED ] CASE: testCommonDbApi2 (8480 ns)
    [ PASSED ] CASE: testSpecificlyMySqlFeatures (8329 ns)
Summary: TOTAL: 3
    PASSED: 3, SKIPPED: 0, ERROR: 0
    FAILED: 0
------------------------------------------------------------
```

Test templates themselves can be built from other test templates.

## Lifecycle Methods

Test templates can also include some lifecycle methods: `@BeforeAll`, `@AfterAll`, `@BeforeEach`, `@AfterEach`. Lifecycle methods execute in the specified order:

- `@Before_` lifecycle methods run from base class to inherited class.
- `@After_` lifecycle methods run from inherited class to base class.

`@_Each` derived class methods also apply to the base class's test cases.

<!-- run -->
```cangjie
@TestTemplate
abstract class BaseTemplate {
    @BeforeEach
    func baseBeforeEach() {
        println("base before each")
    }

    @AfterEach
    func baseAfterEach() {
        println("base after each")
    }
}

@TestTemplate
abstract class Template <: BaseTemplate {
    @TestCase
    func templateCase() {
        println("template case")
    }
}

@Test
class Test <: Template {
    @BeforeEach
    func beforeEach() {
        println("before each")
    }

    @AfterEach
    func afterEach() {
        println("after each")
    }

    @TestCase
    func testCase() {
        println("case")
    }
}
```

The output will be (when output capture is enabled):

```text
------------------------------------------------------------
TP: default, time elapsed: 456925 ns, RESULT:
    TCS: Test, time elapsed: 456925 ns, RESULT:
    [ PASSED ] CASE: templateCase (38228 ns)
    STDOUT:
    base before each
    before each
    template case
    after each
    base after each
    [ PASSED ] CASE: testCase (16098 ns)
    STDOUT:
    base before each
    before each
    case
    after each
    base after each
Summary: TOTAL: 2
    PASSED: 2, SKIPPED: 0, ERROR: 0
    FAILED: 0
------------------------------------------------------------
```

## Configuration

`@Configure` can be placed on test template classes, but the `@Configure` of inherited classes will override values placed for the base class. All test cases execute under the merged configuration.

## Rules for Interaction with Other Features

- `@Parallel` cannot be used simultaneously with `@TestTemplate`.
- `@Types` cannot be used simultaneously with `@TestTemplate`.
- `@Bench` can be used in templates and will execute when `--bench` is specified, just as if the benchmarks were placed in the inherited class itself.