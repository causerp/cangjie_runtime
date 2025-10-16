# Unittest Quick Start

First, let's write a simple Cangjie function:

<!--compile -unittest -->
```cangjie
func add(left: Int64, right: Int64) {
    return left + right
}
```

Save this function in the `add.cj` file, then start writing test code for it:

<!--compile -unittest -->
```cangjie
@Test
func addTest() {
    @Expect(add(2, 3), 5)
}
```

The test consists of the following components:

- `@Test` macro, configured on the `addTest` function, indicating this is a test function.
- `@Expect` macro, serving as an assertion to check if the two input parameters are equal. In this example, the parameters are the result of the `add` function `add(2, 3)` and the expected value `5`.

Save this test function in the `add_test.cj` file and run it together with the code function in `add.cj`.

```bash
cjc add.cj add_test.cj --test -o add_test
./add_test
```

During test execution, a dynamic progress report will be displayed:

```text
group example                                0% [-------------------------]      (00:00:01)
test TestCase_addTest.addTest                                                    (00:00:01)

passed: 0, failed: 0                            0% [-------------------------]  0/1 (00:00:01)
```

Under normal circumstances, you will receive output similar to the following:

```text
-------------------------------------------------------------------------------------------------
TP: default, time elapsed: 59363 ns, Result:
    TCS: TestCase_addTest, time elapsed: 32231 ns, RESULT:
    [ PASSED ] CASE: addTest (28473 ns)
    Summary: TOTAL: 1
    PASSED: 1, SKIPPED: 0, ERROR: 0
    FAILED: 0
--------------------------------------------------------------------------------------------------
```

At this point, we have completed the construction and execution of the test.
Now let's provide a detailed introduction to the `cjc` command used for building tests.

```shell
#   Code file to be tested
#   ↓
cjc add.cj add_test.cj --test -o add_test
#          ↑           ↑
#          |           --test indicates building the binary file in test mode
#          Test file
```

Note that for complex projects, it is not recommended to directly run the `cjc` compiler.
For large-scale projects with complex structures, it is recommended to use the `cjpm` package manager.
Take the `cjpm` project test as an example.

First, create a simple `cjpm` project containing a package named `example`.
The project's file structure is as follows (borrowing files from the `cjc` example):

```text
- src
  |
  +- example
     |
     +- add.cj
     +- add_test.cj
```

The original files already indicate they belong to the `example` package, so you only need to run the following command to initialize the `cjpm` project:

```bash
cjpm init --name example
```

The `cjpm` package manager has built-in support for running unit tests, so you can directly execute:

```bash
cjpm test
```

This command will run all tests in the project's packages and generate unified output similar to the following:

```text
--------------------------------------------------------------------------------------------------
TP: example/example, time elapsed: 60989 ns, Result:
    TCS: TestCase_addTest, time elapsed: 32804 ns, RESULT:
    [ PASSED ] CASE: addTest (29195 ns)
    Summary: TOTAL: 1
    PASSED: 1, SKIPPED: 0, ERROR: 0
    FAILED: 0
--------------------------------------------------------------------------------------------------
```

Note that there is no need to specify `--test` or any other special options.
By default, `cjpm` uses filenames in the project to determine whether files should be compiled in test mode or normal mode.
In the example package, `add_test.cj` is a test file, as its filename ends with `_test.cj`.
During normal builds, the binary file or library construction does not include these files.

The unit test framework API is already available in the `unittest` package of the `std` module, and the macros are also located in the `unittest.testmacro` package of the `std` module, so there is no need to explicitly import them in test files.

For more information about the basic concepts of the unittest framework, please refer to [Unit Test Basics](./unittest_basics.md#unittest-basic-concepts-and-usage).