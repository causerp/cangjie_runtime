# Parameterized Testing

## Introduction to Parameterized Testing

The Cangjie unittest framework supports parameterized testing using a *Data DSL* format, where the framework automatically injects input parameters during testing.

Take testing the standard library's `sort` interface as an example:

<!-- run -->
```cangjie
import std.sort.*

@Test
func testSort() {
    let arr = [45, 5, -1, 0, 1, 2]
    sort(arr)
    @Expect(arr, [-1, 0, 1, 2, 5, 45])
}
```

The test results show that the function works with a single input case.
Next, let's test whether the sorting function still works when the array contains only equal elements.

<!-- run -->
```cangjie
import std.sort.*

@Test
func testAllEqual() {
    let arr = [0, 0, 0, 0]
    let expected = [0, 0, 0, 0]
    sort(arr)
    @Expect(expected, arr)
}
```

The test results confirm the function works, but we still can't be sure if it handles arrays of all sizes.
Next, let's parameterize the array size for testing.

<!-- run -->
```cangjie
import std.sort.*

@Test[size in [ 0, 1, 50, 100, 1000 ]]
func testAllEqual(size: Int64) {
    let arr = Array(size, repeat: 0)
    let expected = Array(size, repeat: 0)
    sort(arr)
    @Expect(expected, arr)
}
```

At this point, parameterized testing is complete.
This represents the simplest form of parameterized testing - value-driven testing - where test values are explicitly listed in the code.
Parameterized tests can have more than one parameter.
We can specify not only the size for the sorting function but also the elements to be tested.

<!-- run -->
```cangjie
import std.sort.*

@Test[size in [ 0, 1, 50, 100, 1000 ],
 item in(- 1 .. 20)
]
func testAllEqual(size: Int64, item: Int64) {
    let arr = Array(size, repeat: item)
    let expected = Array(size, repeat: item)
    sort(arr)
    @Expect(expected, arr)
}
```

Note that the range of `item` is `-1..20`, not an array.
What happens when we run this test?
The framework will combine all possible values of `size` and `item` for testing and reporting.
Therefore, avoid configuring too many parameters in test functions, as the combinatorial explosion may slow down testing.
In this example, there are 5 possible values for `size` and 21 for `item`, resulting in 21×5=105 combinations.

Note that value-driven testing isn't limited to integers or built-in types.
It can work with any Cangjie type.
Consider this test:

<!-- run -->
```cangjie
@Test[array in [
 [ ],
 [ 1, 2, 3 ],
 [ 1, 2, 3, 4, 5 ],
 [ 5, 4, 3, 2, 1 ],
 [ -1, 0 ],
 [ -20 ]
 ]
]
func testDifferentArrays(array: Array<Int64>) {
    // Test if the array is sorted
    for (i in 0..(array.size - 1)) {
        @Expect(array[i] <= array[i + 1])
    }
}
```

Here, test data is provided directly as parameters.

However, using arrays for testing might be cumbersome.
For generic functions, randomly generating data might be more convenient.
Let's explore a more advanced form of parameterized testing: randomized testing.
By using the `unittest.random<T>()` function to replace value-driven arrays or ranges, we can create randomized tests:

<!-- run -->
```cangjie
@Test[array in random()]
func testRandomArrays(array: Array<Int64>) {
    // Test if the array is sorted
    for (i in 0..(array.size - 1)) {
        @Expect(array[i] <= array[i + 1])
    }
}
```

This test essentially generates a large number of random values (200 by default) to test the code.
The values aren't completely random - they're biased toward edge cases like zeros, maximum/minimum values, empty collections, etc.

Important note: It's generally recommended to combine randomized testing with manually written tests, as they complement each other in practice.

To better illustrate randomized testing, let's temporarily set aside the sorting function and write this test:

<!-- run -->
```cangjie
@Test[array in random()]
func testNonsense(array: Array<Int64>) {
    if (array.size < 2) {
        return
    }
    @Expect(array[0] <= array[1] + 500)
}
```

Running this might produce output like:

```text
[ FAILED ] CASE: testNonsense (1159229 ns)
    REASON: After 4 generation steps and 200 reduction steps:
        array = [0, -453923686263, 0]
    with randomSeed = 1702373121372171563

    Expect Failed: `(array [ 0 ] <= array [ 1 ] + 500 == true)`
       left: false
      right: true
```

The results show the test failed with array `[0, -453923686263, 0]`.
Running it again:

```text
[ FAILED ] CASE: testNonsense (1904718 ns)
    REASON: After 5 generation steps and 200 reduction steps:
        array = [0, -1196768422]
    with randomSeed = 1702373320782980551

    Expect Failed: `(array [ 0 ] <= array [ 1 ] + 500 == true)`
       left: false
      right: true
```

Again the test fails, but with different values.
Why does this happen?
Because randomized testing is inherently random, it generates new values each time.
While testing with varied data is powerful, it means tests might pass sometimes and fail other times, making results harder to share.
Randomized testing is a powerful tool, but these limitations should be understood.

How can we share results with other developers when tests produce different outcomes each time?
The answer lies in the test output:

```text
with randomSeed = 1702373320782980551
```

This provides a *random seed* that can be used as configuration in tests.
Let's modify the test:

<!-- run -->
```cangjie
@Test[array in random()]
@Configure[randomSeed: 1702373320782980551]
func testNonsense(array: Array<Int64>) {
    if (array.size < 2) {
        return
    }
    @Expect(array[0] <= array[1] + 500)
}
```

Running this produces:

```text
[ FAILED ] CASE: testNonsense (1910109 ns)
    REASON: After 5 generation steps and 200 reduction steps:
        array = [0, -1196768422]
    with randomSeed = 1702373320782980551

    Expect Failed: `(array [ 0 ] <= array [ 1 ] + 500 == true)`
       left: false
      right: true
```

Notice this run produces identical values, steps, and random seed as the previous one.
This mechanism makes randomized testing *repeatable*, allowing results to be shared in test suites.
You can also extract data from randomized tests (like the array `[0, -1196768422]` in this case) to write new tests.

Let's quickly examine the output from failed tests.

```text
    REASON: After 5 generation steps and 200 reduction steps:
        array = [0, -1196768422]
    with randomSeed = 1702373320782980551
```

The output contains several important pieces of information:

- Generation steps before failure: The number of iterations run before the test failed.
- Reduction steps: Randomized testing includes a mechanism to minimize failing cases, making them easier to work with and more readable.
- The actual failing data: Lists all parameters (just `array` here) and their values that caused the failure. Parameters must implement ToString, otherwise placeholders are shown.
- The random seed mentioned earlier, for reproducing the test.

Some tests are tricky and require adjusting the number of random generation steps.
This can be controlled via two configuration parameters: `generationSteps` and `reductionSteps`.
A major advantage of randomized testing is that with enough steps, it can run for extended periods, checking millions of values.

To prevent excessive test times, the default maximum for both `generationSteps` and `reductionSteps` is 200.
These configuration parameters allow adjusting these limits.
For our small test, large values might not make sense - previous runs show failures typically occur within 10 steps.

## Type-Parameterized Testing

While our sorting tests currently focus on integer arrays, the function itself can sort any comparable type.

Let's adapt the `testDifferentArrays` example to test another type (strings):

<!-- run -->
```cangjie
import std.sort.*

@Test[array in [
 [ ],
 [ "1","2","3" ],
 [ "1","2","3","4","5" ],
 [ "5","4","3","2","1" ]
 ]
]
func testDifferentArraysString(array: Array<String>) {
    // Test if the array is sorted
    let sorted = array.clone()
    sort(sorted)
    for (i in 0..(sorted.size - 1)) {
        @Expect(sorted[i] <= sorted[i + 1])
    }
}
```

The test runs successfully.
Notice both tests share identical bodies and assertions.
Wouldn't it be more convenient if tests for generic functions could themselves be generic?

Returning to our randomized testing example:

<!-- run -->
```cangjie
import std.sort.*

@Test[array in random()]
func testRandomArrays(array: Array<Int64>) {
    let sorted = array.clone()
    sort(sorted)
    for (i in 0..(sorted.size - 1)) {
        @Expect(sorted[i] <= sorted[i + 1])
    }
}
```

This test is broadly applicable - the element type isn't limited to `Int64` but could be any type `T` that implements `Comparable<T>`.

Let's rewrite this as a generic function:

<!-- compile-error -->
```cangjie
import std.sort.*

@Test[array in random()]
func testRandomArrays<T>(array: Array<T>) where T <: Comparable<T> {
    let sorted = array.clone()
    sort(sorted)
    for (i in 0..(sorted.size - 1)) {
        @Expect(sorted[i] <= sorted[i + 1])
    }
}
```

After compiling and running, we encounter a problem:

```text
An exception has occurred:
MacroException: Generic function testRandomArrays requires a @Types macro to set up generic arguments
```

Of course, to test certain types, those types must first exist.
Use the `@Types` macro to configure the test, enabling it to run on types such as `Int64`, `Float64`, and `String`.

<!-- run -->
```cangjie
import std.sort.*

@Test[array in random()]
@Types[T in<Int64, Float64, String>]
func testRandomArrays<T>(array: Array<T>) where T <: Comparable<T> {
    let sorted = array.clone()
    sort(sorted)
    for (i in 0..(sorted.size - 1)) {
        // Modified check to support NaN
        @Expect(!(sorted[i] > sorted[i + 1]))
    }
}
```

Now, running the test will compile and produce the following output:

```text
    TCS: TestCase_testRandomArrays, time elapsed: 2491737752 ns, RESULT:
    [ PASSED ] CASE: testRandomArrays<Int64> (208846446 ns)
    [ PASSED ] CASE: testRandomArrays<Float64> (172845910 ns)
    [ PASSED ] CASE: testRandomArrays<String> (2110037787 ns)
```

Note that the test runs separately for each type, as their behaviors may differ significantly.
The `@Types` macro can be used for any parameterized test cases, including test functions and test classes.

## Reusing, Combining, and Mapping Parameter Strategies

Let's take `HashSet` as an example. Start by testing the `contains` method.

<!-- run -->
```cangjie
import std.collection.*

@Test[data in random()]
func testHashSetContains(data: Array<Int64>) {
    let hashSet = HashSet<Int64>()
    hashSet.add(all: data)

    for (element in data) {
        @Assert(hashSet.contains(element))
    }
}
```

This works well. Now let's test the `remove` method.

<!-- run -->
```cangjie
import std.collection.*

@Test[data in random()]
func testHashSetRemove(data: Array<Int64>) {
    let hashSet = HashSet<Int64>()
    hashSet.add(all: data)

    for (element in data) {
        @Assert(hashSet.remove(element))
    }
}
```

At first glance, this should work. However, it quickly becomes apparent that it doesn't function correctly because the randomly generated array may contain duplicates, causing the second removal call to fail. What we actually want here is to generate arrays without duplicates.

<!-- run -->
```cangjie
import std.collection.*
import std.random.*

var counter = 0

@OverflowWrapping
func generateUniqArray(len: Int64, start: UInt64) {
    if (len < 1) {
        return Array<Int64>()
    }
    let rng = Random(start)
    let step = Int64.Max / len
    counter = 0
    Array(
        len,
        {
            _ =>
            counter += rng.nextInt64() % step
            counter
        }
    )
}

@Test[start in random<UInt64>()]
func testHashSetRemove(start: UInt64) {
    let len = 1000
    let data = generateUniqArray(len, start)
    let hashSet = HashSet<Int64>()
    hashSet.add(all: data)

    for (element in data) {
        @Assert(hashSet.remove(element))
    }
}
```

Even if we move the data generation to a separate function, there's still considerable duplication if we want to reuse it across multiple tests. Additionally, the boundary between setup code and test code becomes very unclear. To address these issues, the testing framework provides a convenient API in the form of the `@Strategy` macro, allowing for the composition and mapping of existing strategies.

<!-- run -->
```cangjie
import std.collection.*
import std.random.*

var counter = 0

@Strategy[start in random<UInt64>()]
@OverflowWrapping
func generateUniqArray(start: UInt64): ArrayList<Int64> {
    let len = 1000
    let rng = Random(start)
    let step = Int64.Max / len
    counter = 0
    ArrayList(
        len,
        {
            _ =>
            counter += rng.nextInt64() % step
            counter
        }
    )
}

// Now, we can simply use this strategy as input:

@Test[data in generateUniqArray]
func testHashSetRemove(data: ArrayList<Int64>) {
    let hashSet = HashSet<Int64>()
    hashSet.add(all: data)

    for (element in data) {
        @Assert(hashSet.remove(element))
    }
}

@Test[data in generateUniqArray]
func testHashSetToArray(data: ArrayList<Int64>) {
    let hashSet = HashSet<Int64>()
    hashSet.add(all: data)

    let result = ArrayList(hashSet.toArray())
    result.sort()
    data.sort()
    @Assert(result == data)
}
```

While such custom strategies are rarely needed for testing, they remain a crucial part of the framework due to their use in benchmarking, as described in the relevant sections.

## Coverage-Guided Randomized Parameterized Testing

As mentioned earlier, randomized testing is a powerful tool for those who can wield it effectively, but it also has limitations.
For example:

<!-- run -->
```cangjie
import std.random.*

@Test[x in random()]
func testX(x: Int64) {
    @Expect(x != 1234567)
}
```

Although this test appears straightforward, running it may not yield the expected result:

```text
--------------------------------------------------------------------------------------------------
TP: default, time elapsed: 1393856 ns, RESULT:
    TCS: TestCase_testX, time elapsed: 1393856 ns, RESULT:
    [ PASSED ] CASE: testX (1378439 ns)
Summary: TOTAL: 1
    PASSED: 1, SKIPPED: 0, ERROR: 0
    FAILED: 0
--------------------------------------------------------------------------------------------------
```

Even if you increase the number of generation steps to millions, this test might still not fail because randomized tests are, by nature, random, and the probability of generating a very specific number is extremely low.
While this test appears to be auto-generated and not representative of production code, it illustrates the same issues that randomized testing might face in more realistic scenarios, significantly limiting its applicability for advanced uses such as identifying security flaws in code.

To address this, the Cangjie unit testing framework introduces an advanced feature based on security-fuzzing techniques: coverage-guided randomized parameterized unit testing. This feature targets users who want more thorough testing of their code while still enjoying the usability and ease of randomized testing.

To use coverage-guided unit testing, follow these steps:

- The project must be compiled with compiler support for `SanitizerCoverage`, specifically requiring these two options: `--sanitizer-coverage-trace-pc-guard` and `--sanitizer-coverage-trace-compares`.
- The test executable must be configured with the [--coverage-guided](./unittest_basics.md#coverage-guided) option.
- The generation step parameters for the test must be increased based on the code's complexity to allow the coverage-guided algorithm to proceed.

If we compile the above example with the compiler options `--sanitizer-coverage-trace-pc-guard` and `--sanitizer-coverage-trace-compares`, then run it with the `--coverage-guided` option, we get results similar to the following:

```text
--------------------------------------------------------------------------------------------------
TP: default, time elapsed: 2004749 ns, RESULT:
    TCS: TestCase_testX, time elapsed: 2004749 ns, RESULT:
    [ FAILED ] CASE: testX (17380 ns)
    REASON: After 48 generation steps and 3 reduction steps:
        x = 1234567
    with randomSeed = 1721033700363557083
    Expect Failed: `(x != 1234567 == true)`
       left: false
      right: true

Summary: TOTAL: 1
    PASSED: 0, SKIPPED: 0, ERROR: 0
    FAILED: 1, listed below:
            TCS: TestCase_testX, CASE: testX
--------------------------------------------------------------------------------------------------
```

As we can see, the test fails in very few generation steps (48 in this case, though results may vary due to the randomness of testing). However, it's generally recommended to configure the test's generation steps to at least hundreds of thousands, which may result in longer execution times.
