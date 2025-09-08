# Classes

## class ArrayIterator\<T>

```cangjie
public class ArrayIterator<T> <: Iterator<T> {
    public init(data: Array<T>)
}
```

Function: An array iterator. For detailed iteration functionality, refer to [Iterable](core_package_interfaces.md#interface-iterablee) and [Iterator](core_package_classes.md#class-iteratort) documentation.

Parent Types:

- [Iterator](#class-iteratort)\<T>

### init(Array\<T>)

```cangjie
public init(data: Array<T>)
```

Function: Creates an iterator for a given [Array](core_package_structs.md#struct-arrayt) instance to traverse all elements in the array.

Parameters:

- data: [Array](core_package_structs.md#struct-arrayt)\<T> - The array instance.

### func next()

```cangjie
public func next(): Option<T>
```

Function: Returns the next value in the array iterator.

Return Value:

- [Option](core_package_enums.md#enum-optiont)\<T> - The next element in the array iterator, wrapped in [Option](core_package_enums.md#enum-optiont). Returns `None` when reaching the end.

Example:

<!-- verify -->
```cangjie
main() {
    var arr: Array<Int64> = [1, 2, 3, 4]
    var arrIterator: ArrayIterator<Int64> = ArrayIterator(arr)
    var num: Option<Int64>
    while (true) {
        num = arrIterator.next()
        if (num.isNone()) {
            break
        }
        println(num.getOrDefault({=> -1}))
    }
}
```

Output:

```text
1
2
3
4
```

## class Box\<T>

```cangjie
public class Box<T> {
    public var value: T
    public init(v: T)
}
```

Function: The [Box](core_package_classes.md#class-boxt) type provides the ability to add a `class` wrapper layer to other types.

If type `T` itself lacks reference capability (e.g., `struct` types), wrapping it with [Box](core_package_classes.md#class-boxt)\<T> makes it referenceable.

### var value

```cangjie
public var value: T
```

Function: Gets or modifies the wrapped value.

Type: T

### init(T)

```cangjie
public init(v: T)
```

Function: Constructs a [Box](core_package_classes.md#class-boxt)\<T> instance for a given `T` type instance.

Parameters:

- v: T - An instance of any type.

### extend\<T> Box\<T> <: Comparable\<Box\<T>> where T <: Comparable\<T>

```cangjie
extend<T> Box<T> <: Comparable<Box<T>> where T <: Comparable<T>
```

Function: Extends the [Box](core_package_classes.md#class-boxt)\<T> class with the [Comparable](core_package_interfaces.md#interface-comparablet)\<[Box](core_package_classes.md#class-boxt)\<T>> interface, providing comparison capability.

The size relationship of [Box](core_package_classes.md#class-boxt)\<T> instances matches that of their wrapped `T` instances.

Parent Types:

- [Comparable](core_package_interfaces.md#interface-comparablet)\<[Box](#class-boxt)\<T>>

#### func compare(Box\<T>)

```cangjie
public func compare(that: Box<T>): Ordering
```

Function: Determines the size relationship between the current [Box](core_package_classes.md#class-boxt) instance and another [Box](core_package_classes.md#class-boxt) instance.

Parameters:

- that: [Box](core_package_classes.md#class-boxt)\<T> - The other [Box](core_package_classes.md#class-boxt) object to compare.

Return Value:

- [Ordering](core_package_enums.md#enum-ordering) - Returns [Ordering](core_package_enums.md#enum-ordering).GT if the current [Box](core_package_classes.md#class-boxt) instance is greater than `that`, [Ordering](core_package_enums.md#enum-ordering).EQ if equal, and [Ordering](core_package_enums.md#enum-ordering).LT if less.

Example:

<!-- verify -->
```cangjie
struct Data <: Comparable<Data> {
    var a: Int64 = 0
    var b: Int64 = 0

    public init(a: Int64, b: Int64) {
        this.a = a
        this.b = b
    }

    public func compare(d: Data) {
        let tValue: Int64 = this.a + this.b
        let dValue: Int64 = d.a + d.b
        if (tValue > dValue) {
            return Ordering.GT
        } else if (tValue == dValue) {
            return Ordering.EQ
        } else {
            return Ordering.LT
        }
    }
}

main() {
    var data1: Box<Data> = Box<Data>(Data(12, 12))
    var data2: Box<Data> = Box<Data>(Data(7, 12))
    println(data1.compare(data2))
}
```

Output:

```text
Ordering.GT
```

#### operator func !=(Box\<T>)

```cangjie
public operator func !=(that: Box<T>): Bool
```

Function: Compares whether [Box](core_package_classes.md#class-boxt) objects are unequal.

Parameters:

- that: [Box](core_package_classes.md#class-boxt)\<T> - The other [Box](core_package_classes.md#class-boxt) object to compare.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if the current [Box](core_package_classes.md#class-boxt) object is not equal to the parameter [Box](core_package_classes.md#class-boxt) object, otherwise false.

#### operator func <(Box\<T>)

```cangjie
public operator func <(that: Box<T>): Bool
```

Function: Compares the size of [Box](core_package_classes.md#class-boxt) objects.

Parameters:

- that: [Box](core_package_classes.md#class-boxt)\<T> - The other [Box](core_package_classes.md#class-boxt) object to compare.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if the current [Box](core_package_classes.md#class-boxt) object is less than the parameter [Box](core_package_classes.md#class-boxt) object, otherwise false.

#### operator func <=(Box\<T>)

```cangjie
public operator func <=(that: Box<T>): Bool
```

Function: Compares the size of [Box](core_package_classes.md#class-boxt) objects.

Parameters:

- that: [Box](core_package_classes.md#class-boxt)\<T> - The other [Box](core_package_classes.md#class-boxt) object to compare.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if the current [Box](core_package_classes.md#class-boxt) object is less than or equal to the parameter [Box](core_package_classes.md#class-boxt) object, otherwise false.

#### operator func ==(Box\<T>)

```cangjie
public operator func ==(that: Box<T>): Bool
```

Function: Compares whether [Box](core_package_classes.md#class-boxt) objects are equal.

Parameters:

- that: [Box](core_package_classes.md#class-boxt)\<T> - The other [Box](core_package_classes.md#class-boxt) object to compare.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if the current [Box](core_package_classes.md#class-boxt) object equals the parameter [Box](core_package_classes.md#class-boxt) object, otherwise false.

#### operator func >(Box\<T>)

```cangjie
public operator func >(that: Box<T>): Bool
```

Function: Compares the size of [Box](core_package_classes.md#class-boxt) objects.

Parameters:

- that: [Box](core_package_classes.md#class-boxt)\<T> - The other [Box](core_package_classes.md#class-boxt) object to compare.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if the current [Box](core_package_classes.md#class-boxt) object is greater than the parameter [Box](core_package_classes.md#class-boxt) object, otherwise false.

#### operator func >=(Box\<T>)

```cangjie
public operator func >=(that: Box<T>): Bool
```

Function: Compares the size of [Box](core_package_classes.md#class-boxt) objects.

Parameters:

- that: [Box](core_package_classes.md#class-boxt)\<T> - The other [Box](core_package_classes.md#class-boxt) object to compare.

Return Value:

- [Bool](core_package_intrinsics.md#bool) - Returns true if the current [Box](core_package_classes.md#class-boxt) object is greater than or equal to the parameter [Box](core_package_classes.md#class-boxt) object, otherwise false.

### extend\<T> Box\<T> <: Hashable where T <: Hashable

```cangjie
extend<T> Box<T> <: Hashable where T <: Hashable
```

Function: Extends the [Box](core_package_classes.md#class-boxt)\<T> class with the [Hashable](core_package_interfaces.md#interface-hashable) interface, providing hashing capability.

Parent Types:

- [Hashable](core_package_interfaces.md#interface-hashable)

#### func hashCode()

```cangjie
public func hashCode(): Int64
```

Function: Gets the hash value of the [Box](core_package_classes.md#class-boxt) object.

This value is actually the hash value of the wrapped `T` type instance.

Return Value:

- [Int64](core_package_intrinsics.md#int64) - The hash value of the current [Box](core_package_classes.md#class-boxt) object.

### extend\<T> Box\<T> <: ToString where T <: ToString

```cangjie
extend<T> Box<T> <: ToString where T <: ToString
```

Function: Extends the [Box](core_package_classes.md#class-boxt)\<T> type with the [ToString](core_package_interfaces.md#interface-tostring) interface, supporting string conversion.

Parent Types:

- [ToString](core_package_interfaces.md#interface-tostring)

#### func toString()

```cangjie
public func toString(): String
```

Function: Gets the string representation of the [Box](core_package_classes.md#class-boxt) object, which is the string representation of the wrapped `T` type instance.

Return Value:

- [String](core_package_structs.md#struct-string) - The converted string.

## class Future\<T>

```cangjie
public class Future<T>
```

Function: A [Future](core_package_classes.md#class-futuret)\<T> instance represents a Cangjie thread task, used to obtain computation results from Cangjie threads and send cancellation signals.

The return type of `spawn` expressions is [Future](core_package_classes.md#class-futuret)\<T>, where `T` depends on the return type of the closure in the `spawn` expression.

### prop thread

```cangjie
public prop thread: Thread
```

Function: Gets the [Thread](core_package_classes.md#class-thread) instance of the corresponding Cangjie thread.

Type: [Thread](core_package_classes.md#class-thread)

### func cancel()

```cangjie
public func cancel(): Unit
```

Function: Sends a cancellation request to the Cangjie thread corresponding to the current [Future](core_package_classes.md#class-futuret) instance. This method does not immediately stop thread execution but only sends a request. Correspondingly, the `hasPendingCancellation` function of the [Thread](core_package_classes.md#class-thread) class can be used to check if there's a pending cancellation request, allowing developers to decide whether and how to terminate the thread early.

Example:

<!-- verify -->
```cangjie
main(): Unit {
    /* Create thread */
    let future = spawn {
        while (true) {
            if (Thread.currentThread.hasPendingCancellation) {
                return 0
            }
        }
        return 1
    }
    /* Send cancellation request to thread */
    future.cancel()
    let res = future.get()
    println(res)
}
```

Output:

```text
0
```

### func get()

```cangjie
public func get(): T
```

Function: Blocks the current thread, waiting for and obtaining the result of the thread corresponding to the current [Future](core_package_classes.md#class-futuret)\<T> object.

Return Value:

- T - The return value after the thread represented by the current [Future](core_package_classes.md#class-futuret)\<T> instance completes execution.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    let fut: Future<Int64> = spawn {
        =>
        sleep(1000 * Duration.millisecond) /* Sleep for 1 second */
        return 1
    }

    /* Wait for thread completion */
    let result: Int64 = fut.get()
    println(result)
    return 0
}
```

Output:

```text
1
```

### func get(Duration)

```cangjie
public func get(timeout: Duration): T
```

Function: Blocks the current thread, waits for a specified duration, and obtains the return value of the thread corresponding to the current [Future](core_package_classes.md#class-futuret)\<T> object.

A timeout must be specified. If the corresponding thread does not complete execution within the specified time, this function throws a [TimeoutException](./core_package_exceptions.md#class-timeoutexception). If timeout <= Duration.Zero, it behaves the same as get(), meaning no timeout limit. If the thread throws an exception during execution, the same exception will be propagated at the get call site.

Parameters:

- timeout: [Duration](./core_package_structs.md#struct-duration) - The waiting duration.

Return Value:

- T - Returns the execution result of the Cangjie thread after the specified duration.

Exceptions:

- [TimeoutException](./core_package_exceptions.md#class-timeoutexception) - Thrown if the corresponding thread does not complete execution within the specified time.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    let fut: Future<Int64> = spawn {
        =>
        sleep(1000 * Duration.millisecond) /* Sleep for 1 second */
        return 1
    }

    let result: Int64 = fut.get(2000 * Duration.millisecond)
    /* Maximum wait time is 2 seconds, throws TimeoutException if exceeded */

    println(result)
    return 0
}
```

Output:

```text
1
```

### func tryGet()

```cangjie
public func tryGet(): Option<T>
```

Function: Attempts to get the execution result without blocking the current thread. Returns `None` if the corresponding thread hasn't completed.

Return Value:

- [Option](core_package_enums.md#enum-optiont)\<T> - Returns `None` if the Cangjie thread hasn't completed, otherwise returns the execution result.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    let fut: Future<Int64> = spawn {
        =>
        sleep(1000 * Duration.millisecond) /* Sleep for 1 second */
        return 1
    }

    /* Main thread waits 4 seconds to ensure spawned thread completes */
    sleep(4000 * Duration.millisecond)

    /* Attempt to get spawned thread's execution result */
    let result: Option<Int64> = fut.tryGet()
    println(result)
    return 0
}
```

Output:

```text
Some(1)
``````markdown
## class Iterator\<T>

```cangjie
public abstract class Iterator<T> <: Iterable<T>
```

Function: This class represents an iterator, providing the `next` method to support iterative traversal of container elements.

Parent Type:

- [Iterable](core_package_interfaces.md#interface-iterablee)\<T>

### init()

```cangjie
public init()
```

Function: Constructs a default [Iterator](core_package_classes.md#class-iteratort)\<T> object.

### func iterator()

```cangjie
public func iterator() : Iterator<T>
```

Function: Returns the iterator itself.

Return Value:

- [Iterator](core_package_classes.md#class-iteratort)\<T> - The iterator itself.

### func next()

```cangjie
public func next(): Option<T>
```

Function: Retrieves the next element during iteration.

Return Value:

- [Option](core_package_enums.md#enum-optiont)\<T> - The next element during iteration.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    var arr: Array<Int64> = [1, 2, 3, 4, 5]
    var iter = arr.iterator() /* Obtain the iterator object of the container */

    while (true) { /* Traverse using the iterator */
        match (iter.next()) {
            case Some(i) => println(i)
            case None => break
        }
    }
    return 0
}
```

Execution Result:

```text
1
2
3
4
5
```

### extend\<T> Iterator\<T>

```cangjie
extend<T> Iterator<T>
```

Function: Extends the [Iterator](core_package_classes.md#class-iteratort)\<T> type.

Iterator methods primarily include intermediate operations and terminal operations. Intermediate operations (e.g., [skip()](#func-skipint64), [map()](#func-maprt---r)) produce a new iterator. Terminal operations (e.g., [count()](#func-count), [all()](#func-allt---bool)) compute results based on the elements produced by the iterator without generating a new iterator. Each iterator method consumes different numbers of elements from the iterator; see individual method descriptions for details.

#### func all((T) -> Bool)

```cangjie
public func all(predicate: (T)-> Bool): Bool
```

Function: Determines whether all elements in the iterator satisfy the condition. This method repeatedly retrieves and consumes elements from the iterator until an element fails to meet the condition.

Parameters:

- predicate: (T) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The given condition.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether all elements satisfy the condition.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    var arr: Array<Int64> = [1, 2, 3, 4, 5]

    /* Obtain the iterator object of the container */
    var iter = arr.iterator()
    var flag: Bool = iter.all({v: Int64 => v > 0})
    println(flag)
    return 0
}
```

Execution Result:

```text
true
```

#### func any((T) -> Bool)

```cangjie
public func any(predicate: (T)-> Bool): Bool
```

Function: Determines whether any element in the iterator satisfies the condition. This method repeatedly retrieves and consumes elements from the iterator until an element meets the condition.

Parameters:

- predicate: (T) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The given condition.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether any element satisfies the condition.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    var arr: Array<Int64> = [1, 2, 3, 4, 5]

    /* Obtain the iterator object of the container */
    var iter = arr.iterator()
    var flag: Bool = iter.any({v: Int64 => v > 4})
    println(flag)
    return 0
}
```

Execution Result:

```text
true
```

#### func at(Int64)

```cangjie
public func at(n: Int64): Option<T>
```

Function: Retrieves the nth element of the current iterator (indexing starts at 0). This method consumes all elements before the specified element (including the specified element).

Parameters:

- n: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The given element index (starting from 0).

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - The element at the specified position. Returns None if n exceeds the number of remaining elements.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    var arr: Array<Int64> = [1, 2, 3, 4, 5]

    /* Obtain the iterator object of the container */
    var iter = arr.iterator()
    var num: Option<Int64> = iter.at(2)
    println(num)
    return 0
}
```

Execution Result:

```text
Some(3)
```

#### func concat(Iterator\<T>)

```cangjie
public func concat(other: Iterator<T>): Iterator<T>
```

Function: Concatenates two iterators, with the current iterator first and the parameter iterator following.

Parameters:

- other: [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - The iterator to concatenate afterward.

Return Value:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - The concatenated new iterator.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    var arr1: Array<Int64> = [1, 2]
    var arr2: Array<Int64> = [3, 4]

    /* Obtain the iterator objects of the containers */
    var iter1 = arr1.iterator()
    var iter2 = arr2.iterator()

    /* Merge the two iterators */
    var iter = iter1.concat(iter2)

    /* Traverse using the iterator */
    while (true) {
        match (iter.next()) {
            case Some(i) => println(i)
            case None => break
        }
    }
    return 0
}
```

Execution Result:

```text
1
2
3
4
```

#### func count()

```cangjie
public func count(): Int64
```

Function: Counts the number of elements in the current iterator. This method consumes all elements in the iterator to calculate the count.

> **Note:**
>
> This method consumes the iterator, meaning no elements remain in the iterator after its use.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The number of elements in the iterator.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    var arr: Array<Int64> = [1, 2]

    /* Obtain the iterator object of the container */
    var iter = arr.iterator()
    let len: Int64 = iter.count()
    println(len)

    /* Attempt to traverse the iterator, but count() has consumed all elements, so nothing prints */
    while (true) {
        match (iter.next()) {
            case Some(i) => println(i)
            case None => break
        }
    }
    return 0
}
```

Execution Result:

```text
2
```

#### func enumerate()

```cangjie
public func enumerate(): Iterator<(Int64, T)>
```

Function: Creates an iterator with indices.

Return Value:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<([Int64](../../core/core_package_api/core_package_intrinsics.md#int64), T)> - An iterator with indices.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    var arr: Array<Int64> = [1, 2]

    /* Obtain the iterator object of the container */
    var iter = arr.iterator()
    var iter1 = iter.enumerate()

    /* Traverse using the iterator */
    while (true) {
        match (iter1.next()) {
            case Some(i) =>
                print(i[0].toString() + ' ')
                print(i[1])
                println()
            case None => break
        }
    }
    return 0
}
```

Execution Result:

```text
0 1
1 2
```

#### func filter((T) -> Bool)

```cangjie
public func filter(predicate: (T)-> Bool): Iterator<T>
```

Function: Filters elements that satisfy the condition.

Parameters:

- predicate: (T) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The given condition. Elements for which the condition is `true` appear in the returned iterator in order.

Return Value:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - A new iterator.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    var arr: Array<Int64> = [1, 2, 3, 4, 5]

    /* Obtain the filtered iterator object */
    var iter = arr.iterator()
    var iter1 = iter.filter({value: Int64 => value > 2})

    /* Traverse using the iterator */
    while (true) {
        match (iter1.next()) {
            case Some(i) => println(i)
            case None => break
        }
    }
    return 0
}
```

Execution Result:

```text
3
4
5
```

#### func filterMap\<R>((T) -> Option\<R>)

```cangjie
public func filterMap<R>(transform: (T) -> Option<R>): Iterator<R>
```

Function: Performs both filtering and mapping operations, returning a new iterator.

Parameters:

- transform: (T) -> [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - The given mapping function. A return value of Some corresponds to a predicate of true in filter, while None corresponds to false.

Return Value:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<R> - A new iterator.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    var arr: Array<Int64> = [1, 2, 3, 4, 5]

    /* Obtain the filtered iterator object, performing both filtering and mapping (mapping must return Option type) */
    var iter = arr.iterator()
    var iter1 = iter.filterMap({
        value: Int64 => if (value > 2) {
            return Some(value + 1)
        } else {
            return None<Int64>
        }
    })

    /* Traverse using the iterator */
    while (true) {
        match (iter1.next()) {
            case Some(i) => println(i)
            case None => break
        }
    }
    return 0
}
```

Execution Result:

```text
4
5
6
```

#### func first()

```cangjie
public func first(): Option<T>
```

Function: Retrieves the first element of the current iterator. This method retrieves and consumes the first element.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - The first element. Returns None if the iterator is empty.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    var arr: Array<Int64> = [1, 2, 3, 4, 5]

    /* Obtain the iterator object */
    var iter = arr.iterator()
    var head: Option<Int64> = iter.first()
    println(head)

    return 0
}
```

Execution Result:

```text
Some(1)
```

#### func flatMap\<R>((T) -> Iterator\<R>)

```cangjie
public func flatMap<R>(transform: (T) -> Iterator<R>): Iterator<R>
```

Function: Creates a mapping with [flatten](../../collection/collection_package_api/collection_package_function.md#func-flattent-riterablet-where-t--iterabler) functionality.

Parameters:

- transform: (T) -> [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<R> - The given mapping function.

Return Value:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<R> - A mapping with [flatten](../../collection/collection_package_api/collection_package_function.md#func-flattent-riterablet-where-t--iterabler) functionality.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    var arr: Array<Array<Int64>> = [[1], [2], [3], [4, 5]]

    /* Obtain the iterator object with flatten functionality */
    var iter = arr.iterator()
    var iter1 = iter.flatMap({value => value.iterator()})

    /* Traverse using the flattened iterator */
    while (true) {
        match (iter1.next()) {
            case Some(i) => println(i)
            case None => break
        }
    }
    return 0
}
```

Execution Result:

```text
1
2
3
4
5
```

#### func fold\<R>(R, (R, T) -> R)

```cangjie
public func fold<R>(initial: R, operation: (R, T)->R): R
```

Function: Computes from left to right using the specified initial value. This method consumes all elements in the iterator.

Parameters:

- initial: R - The initial value of type R.
- operation: (R, T) -> R - The given computation function.

Return Value:

- R - The final computed value.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    var arr: Array<Int64> = [1, 2, 3, 4, 5]

    /* Obtain the iterator object and compute the sum of array elements */
    var iter = arr.iterator()
    var sum: Int64 = iter.fold(0, {total, value => total + value})

    println(sum)
    return 0
}
```

Execution Result:

```text
15
```

#### func forEach((T) -> Unit)

```cangjie
public func forEach(action: (T)-> Unit): Unit
```

Function: Traverses all elements of the current iterator, executing the given operation for each element. This method consumes all elements in the iterator.

Parameters:

- action: (T) -> [Unit](../../core/core_package_api/core_package_intrinsics.md#unit) - The given operation function.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    var arr: Array<Int64> = [1, 2, 3, 4, 5]

    var iter = arr.iterator()
    iter.forEach({value => println(value)})

    return 0
}
```

Execution Result:

```text
1
2
3
4
5
```

#### func inspect((T) -> Unit)

```cangjie
public func inspect(action: (T) -> Unit): Iterator<T>
```

Function: Executes an additional operation on the current element each time next() is called (does not consume elements from the iterator).

Parameters:

- action: (T) -> [Unit](../../core/core_package_api/core_package_intrinsics.md#unit) - The given operation function.

Return Value:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - A new iterator.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    var arr: Array<Int64> = [1, 2]

    /* Obtain the iterator object and attach an additional operation to the next function */
    var iter = arr.iterator()
    var iter1 = iter.inspect({value => println("Logging: Processing ${value}")})

    /* Traverse using the iterator */
    while (true) {
        match (iter1.next()) {
            case Some(i) => println("Processing ${i} !")
            case None => break
        }
    }
    return 0
}
```

Execution Result:

```text
Logging: Processing 1
Processing 1 !
Logging: Processing 2
Processing 2 !
```

#### func intersperse(T)

```cangjie
public func intersperse(separator: T): Iterator<T>
```

Function: Inserts a given new element between every two elements of the iterator.

Parameters:

- separator: T - The given element.

Return Value:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - A new iterator.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    var arr: Array<Int64> = [1, 2]

    /* Obtain the iterator object, inserting a 0 between every two elements */
    var iter = arr.iterator()
    var iter1 = iter.intersperse(0)

    /* Traverse using the iterator */
    while (true) {
        match (iter1.next()) {
            case Some(i) => println(i)
            case None => break
        }
    }
    return 0
}
```

Execution Result:

```text
1
0
2
```

#### func isEmpty()

```cangjie
public func isEmpty(): Bool
```

Function: Determines whether the current iterator is empty. This method calls [next()](#func-next-1) and checks its return value to determine if the iterator is empty. Thus, if the iterator is not empty, one element is consumed.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether the current iterator is empty.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    var arr: Array<Int64> = [1, 2]

    /* Obtain the iterator object */
    var iter = arr.iterator()

    /* Check if the iterator has elements (consumes one element if true) */
    println(iter.isEmpty())

    /* Traverse using the iterator */
    while (true) {
        match (iter.next()) {
            case Some(i) => println(i)
            case None => break
        }
    }
    println(iter.isEmpty())
    return 0
}
```

Execution Result:

```text
false
2
true
```

#### func last()

```cangjie
public func last(): Option### extend\<T> Iterator\<T> where T <: Comparable\<T>

```cangjie
extend<T> Iterator<T> where T <: Comparable<T>
```

Function: Extends the [Iterator](core_package_classes.md#class-iteratort)\<T> type with the [Comparable](core_package_interfaces.md#interface-comparablet)\<T> interface to support comparison operations.

#### func max()

```cangjie
public func max(): Option<T>
```

Function: Filters the maximum element. This method consumes all elements in the iterator.

Return Value:

- [Option](core_package_enums.md#enum-optiont)\<T> - Returns the maximum element, or None if empty.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    var arr: Array<Int64> = [1, 2, 3, 4]

    /* Get iterator object and use max() to find maximum value */
    var iter = arr.iterator()
    match (iter.max()) {
        case Some(i) => println(i)
        case None => println("None!")
    }
    return 0
}
```

Execution Result:

```text
4
```

#### func min()

```cangjie
public func min(): Option<T>
```

Function: Filters the minimum element. This method consumes all elements in the iterator.

Return Value:

- [Option](core_package_enums.md#enum-optiont)\<T> - Returns the minimum element, or None if empty.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    var arr: Array<Int64> = [1, 2, 3, 4]

    /* Get iterator object and use min() to find minimum value */
    var iter = arr.iterator()
    match (iter.min()) {
        case Some(i) => println(i)
        case None => println("None!")
    }
    return 0
}
```

Execution Result:

```text
1
```

### extend\<T> Iterator\<T> where T <: Equatable\<T>

```cangjie
extend<T> Iterator<T> where T <: Equatable<T>
```

Function: Extends the [Iterator](core_package_classes.md#class-iteratort)\<T> type with the [Equatable](core_package_interfaces.md#interface-equatablet)\<T> interface to support equality comparison operations.

#### func contains(T)

```cangjie
public func contains(element: T): Bool
```

Function: Traverses all elements to determine if the specified element is present. This method repeatedly fetches and consumes elements from the iterator until an element equal to the parameter `element` is found.

Parameters:

- element: T - The element to search for.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether the specified element is contained.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    var arr: Array<Int64> = [1, 2, 3, 4]

    /* Get iterator object and check if it contains element 3 */
    var iter = arr.iterator()
    println(iter.contains(3))

    /* Use iterator to traverse and output remaining elements */
    while (true) {
        match (iter.next()) {
            case Some(i) => println(i)
            case None => break
        }
    }
    return 0
}
```

Execution Result:

```text
true
4
```

## class Object

```cangjie
public open class Object <: Any {
    public const init()
}
```

Function: [Object](core_package_classes.md#class-object) is the parent class of all `class` types, and all `class` types implicitly inherit from it. The [Object](core_package_classes.md#class-object) class contains no members, making it an "empty" class.

Parent Type:

- [Any](core_package_interfaces.md#interface-any)

### init()

```cangjie
public const init()
```

Function: Constructs an `object` instance.

## class RangeIterator\<T> <: Iterator\<T> where T <: Countable\<T> & Comparable\<T> & Equatable\<T>

```cangjie
public class RangeIterator<T> <: Iterator<T> where T <: Countable<T> & Comparable<T> & Equatable<T>
```

Function: Iterator for the [Range](core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet) type. For iteration functionality details, refer to the [Iterable](core_package_interfaces.md#interface-iterablee) and [Iterator](core_package_classes.md#class-iteratort) interface descriptions.

Parent Type:

- [Iterator](#class-iteratort)\<T>

### func next()

```cangjie
public func next(): Option<T>
```

Function: Gets the next value in the [Range](core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet) iterator.

Return Value:

- [Option](core_package_enums.md#enum-optiont)\<T> - The next member in the [Range](core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet) iterator, encapsulated in [Option](core_package_enums.md#enum-optiont). Returns `None` when iteration reaches the end.

## class StackTraceElement

```cangjie
public open class StackTraceElement {
    public let declaringClass: String
    public let methodName: String
    public let fileName: String
    public let lineNumber: Int64
    public init(declaringClass: String, methodName: String, fileName: String, lineNumber: Int64)
}
```

Function: Represents detailed information about an exception stack trace, including the class name, method name, file name, and line number where the exception occurred.

### let declaringClass

```cangjie
public let declaringClass: String
```

Function: Gets the class name where the exception occurred.

Type: [String](core_package_structs.md#struct-string)

### let fileName

```cangjie
public let fileName: String
```

Function: Gets the file name where the exception occurred.

Type: [String](core_package_structs.md#struct-string)

### let lineNumber

```cangjie
public let lineNumber: Int64
```

Function: Gets the line number where the exception occurred.

Type: [Int64](core_package_intrinsics.md#int64)

### let methodName

```cangjie
public let methodName: String
```

Function: Gets the method name where the exception occurred.

Type: [String](core_package_structs.md#struct-string)

### init(String, String, String, Int64)

```cangjie
public init(declaringClass: String, methodName: String, fileName: String, lineNumber: Int64)
```

Function: Constructs a stack trace instance with the specified class name, method name, file name, and line number.

Parameters:

- declaringClass: [String](core_package_structs.md#struct-string) - The class name.
- methodName: [String](core_package_structs.md#struct-string) - The method name.
- fileName: [String](core_package_structs.md#struct-string) - The file name.
- lineNumber: [Int64](core_package_intrinsics.md#int64) - The line number.

## class StringBuilder

```cangjie
public class StringBuilder <: ToString {
    public init()
    public init(str: String)
    public init(r: Rune, n: Int64)
    public init(value: Array<Rune>)
    public init(capacity: Int64)
}
```

Function: This class is primarily used for string construction.

[StringBuilder](core_package_classes.md#class-stringbuilder) is more efficient than [String](core_package_structs.md#struct-string) for string construction:

- Functionally supports input of multiple types, automatically converting them to [String](core_package_structs.md#struct-string) type objects and appending them to the constructed string.
- Performance-wise uses dynamic expansion algorithms to reduce memory allocation frequency, resulting in faster string construction and typically lower memory usage.

> **Note:**
>
> [StringBuilder](core_package_classes.md#class-stringbuilder) only supports UTF-8 encoded character data.

Parent Type:

- [ToString](core_package_interfaces.md#interface-tostring)

### prop capacity

```cangjie
public prop capacity: Int64
```

Function: Gets the current capacity of the [StringBuilder](core_package_classes.md#class-stringbuilder) instance to hold strings. This value increases as expansion occurs.

Type: [Int64](core_package_intrinsics.md#int64)

### prop size

```cangjie
public prop size: Int64
```

Function: Gets the length of the string in the [StringBuilder](core_package_classes.md#class-stringbuilder) instance.

Type: [Int64](core_package_intrinsics.md#int64)

### init()

```cangjie
public init()
```

Function: Constructs an empty [StringBuilder](core_package_classes.md#class-stringbuilder) instance with an initial capacity of 32.

### init(Array\<Rune>)

```cangjie
public init(value: Array<Rune>)
```

Function: Initializes a [StringBuilder](core_package_classes.md#class-stringbuilder) instance using the character array specified by `value`. The initial capacity is the size of `value`, and the initial content is the characters contained in `value`.

Parameters:

- value: [Array](core_package_structs.md#struct-arrayt)\<Rune> - The character array used to initialize the [StringBuilder](core_package_classes.md#class-stringbuilder) instance.

### init(Int64)

```cangjie
public init(capacity: Int64)
```

Function: Initializes an empty [StringBuilder](core_package_classes.md#class-stringbuilder) instance with the capacity specified by `capacity`. The initial capacity is the size of `value`, and the initial content consists of several `\0` characters.

Parameters:

- capacity: [Int64](core_package_intrinsics.md#int64) - The byte capacity for initializing the [StringBuilder](core_package_classes.md#class-stringbuilder), with a valid range of (0, [Int64.Max](./core_package_intrinsics.md#static-prop-max-5)].

Exceptions:

- [IllegalArgumentException](core_package_exceptions.md#class-illegalargumentexception) - Thrown when the `capacity` parameter is less than or equal to 0.

### init(Rune, Int64)

```cangjie
public init(r: Rune, n: Int64)
```

Function: Initializes a [StringBuilder](core_package_classes.md#class-stringbuilder) instance with `n` copies of the character `r`. The initial capacity is `n`, and the initial content consists of `n` copies of `r`.

Parameters:

- r: Rune - The character used to initialize the [StringBuilder](core_package_classes.md#class-stringbuilder) instance.
- n: [Int64](core_package_intrinsics.md#int64) - The number of `r` characters, with a valid range of [0, [Int64.Max](./core_package_intrinsics.md#static-prop-max-5)].

Exceptions:

- [IllegalArgumentException](core_package_exceptions.md#class-illegalargumentexception) - Thrown when the `n` parameter is less than 0.

### init(String)

```cangjie
public init(str: String)
```

Function: Constructs a [StringBuilder](core_package_classes.md#class-stringbuilder) instance with the specified initial string. The initial capacity is the size of the specified string, and the initial content is the specified string.

Parameters:

- str: [String](core_package_structs.md#struct-string) - The string used to initialize the [StringBuilder](core_package_classes.md#class-stringbuilder) instance.

### func append(Array\<Rune>)

```cangjie
public func append(runeArr: Array<Rune>): Unit
```

Function: Appends all characters from the `Rune` array to the end of the [StringBuilder](core_package_classes.md#class-stringbuilder).

Parameters:

- runeArr: [Array](core_package_structs.md#struct-arrayt)\<Rune> - The `Rune` array to append.

### func append\<T>(Array\<T>) where T <: ToString

```cangjie
public func append<T>(val: Array<T>): Unit where T <: ToString
```

Function: Appends the string representation of the [Array](core_package_structs.md#struct-arrayt)\<T> specified by `val` to the end of the [StringBuilder](core_package_classes.md#class-stringbuilder). Type `T` must implement the [ToString](core_package_interfaces.md#interface-tostring) interface.

Parameters:

- val: [Array](core_package_structs.md#struct-arrayt)\<T> - The [Array](core_package_structs.md#struct-arrayt)\<T> instance to append.

### func append(Bool)

```cangjie
public func append(b: Bool): Unit
```

Function: Appends the string representation of the `b` parameter to the end of the [StringBuilder](core_package_classes.md#class-stringbuilder).

Parameters:

- b: [Bool](core_package_intrinsics.md#bool) - The [Bool](core_package_intrinsics.md#bool) value to append.

### func append(CString)

```cangjie
public func append(cstr: CString): Unit
```

Function: Appends the content of the [CString](core_package_intrinsics.md#cstring) specified by `cstr` to the end of the [StringBuilder](core_package_classes.md#class-stringbuilder).

Parameters:

- cstr: [CString](core_package_intrinsics.md#cstring) - The [CString](core_package_intrinsics.md#cstring) to append.

### func append(Float16)

```cangjie
public func append(n: Float16): Unit
```

Function: Appends the string representation of the `n` parameter to the end of the [StringBuilder](core_package_classes.md#class-stringbuilder).

Parameters:

- n: [Float16](core_package_intrinsics.md#float16) - The [Float16](core_package_intrinsics.md#float16) value to append.

### func append(Float32)

```cangjie
public func append(n: Float32): Unit
```

Function: Appends the string representation of the `n` parameter to the end of the [StringBuilder](core_package_classes.md#class-stringbuilder).

Parameters:

- n: [Float32](core_package_intrinsics.md#float32) - The [Float32](core_package_intrinsics.md#float32) value to append.

### func append(Float64)

```cangjie
public func append(n: Float64): Unit
```

Function: Appends the string representation of the `n` parameter to the end of the [StringBuilder](core_package_classes.md#class-stringbuilder).

Parameters:

- n: [Float64](core_package_intrinsics.md#float64) - The [Float64](core_package_intrinsics.md#float64) value to append.

### func append(Int16)

```cangjie
public func append(n: Int16): Unit
```

Function: Appends the string representation of the `n` parameter to the end of the [StringBuilder](core_package_classes.md#class-stringbuilder).

Parameters:

- n: [Int16](core_package_intrinsics.md#int16) - The [Int16](core_package_intrinsics.md#int16) value to append.

### func append(Int32)

```cangjie
public func append(n: Int32): Unit
```

Function: Appends the string representation of the `n` parameter to the end of the [StringBuilder](core_package_classes.md#class-stringbuilder).

Parameters:

- n: [Int32](core_package_intrinsics.md#int32) - The [Int32](core_package_intrinsics.md#int32) value to append.

### func append(Int64)

```cangjie
public func append(n: Int64): Unit
```

Function: Appends the string representation of the `n` parameter to the end of the [StringBuilder](core_package_classes.md#class-stringbuilder).

Parameters:

- n: [Int64](core_package_intrinsics.md#int64) - The [Int64](core_package_intrinsics.md#int64) value to append.

### func append(Int8)

```cangjie
public func append(n: Int8): Unit
```

Function: Appends the string representation of the `n` parameter to the end of the [StringBuilder](core_package_classes.md#class-stringbuilder).

Parameters:

- n: [Int8](core_package_intrinsics.md#int8) - The [Int8](core_package_intrinsics.md#int8) value to append.

### func append(Rune)

```cangjie
public func append(r: Rune): Unit
```

Function: Appends the character specified by `r` to the end of the [StringBuilder](core_package_classes.md#class-stringbuilder).

Parameters:

- r: Rune - The character to append.

### func append(String)

```cangjie
public func append(str: String): Unit
```

Function: Appends the string specified by `str` to the end of the [StringBuilder](core_package_classes.md#class-stringbuilder).

Parameters:

- str: [String](core_package_structs.md#struct-string) - The string to append.

### func append(StringBuilder)

```cangjie
public func append(sb: StringBuilder): Unit
```

Function: Appends the content of the [StringBuilder](core_package_classes.md#class-stringbuilder) specified by `sb` to the end of the [StringBuilder](core_package_classes.md#class-stringbuilder).

Parameters:

- sb: [StringBuilder](core_package_classes.md#class-stringbuilder) - The [StringBuilder](core_package_classes.md#class-stringbuilder) instance to append.

### func append\<T>(T) where T <: ToString

```cangjie
public func append<T>(v: T): Unit where T <: ToString
```

Function: Appends the string representation of the `T` type instance specified by `v` to the end of the [StringBuilder](core_package_classes.md#class-stringbuilder). Type `T` must implement the [ToString](core_package_interfaces.md#interface-tostring) interface.

Parameters## class Thread

```cangjie
public class Thread
```

Function: Obtains thread ID and name, checks for cancellation requests, registers unhandled exception handlers, etc.

Instances of this type cannot be constructed directly. They can only be obtained through the `thread` property of a [Future](core_package_classes.md#class-futuret) object or the `currentThread` static property of the [Thread](core_package_classes.md#class-thread) class.

### static prop currentThread

```cangjie
public static prop currentThread: Thread
```

Function: Gets the [Thread](core_package_classes.md#class-thread) object representing the currently executing thread.

Type: [Thread](core_package_classes.md#class-thread)

### prop hasPendingCancellation

```cangjie
public prop hasPendingCancellation: Bool
```

Function: Indicates whether the thread has a pending cancellation request (i.e., whether a cancellation request was sent via future.cancel()). Common usage: [Thread](core_package_classes.md#class-thread).currentThread.hasPendingCancellation.

Type: [Bool](core_package_intrinsics.md#bool)

### prop id

```cangjie
public prop id: Int64
```

Function: Gets the identifier of the currently executing thread, represented as [Int64](core_package_intrinsics.md#int64). All live threads have unique identifiers, but identifiers may be reused after thread termination.

Type: [Int64](core_package_intrinsics.md#int64)

### prop name

```cangjie
public mut prop name: String
```

Function: Gets or sets the thread's name. Both operations are atomic.

Type: [String](core_package_structs.md#struct-string)

### static func handleUncaughtExceptionBy((Thread, Exception) -> Unit)

```cangjie
public static func handleUncaughtExceptionBy(exHandler: (Thread, Exception) -> Unit): Unit
```

Function: Registers a handler for unhandled thread exceptions.

When a thread terminates prematurely due to an exception, if a global unhandled exception handler is registered, this function will be invoked before thread termination. If an exception is thrown within this handler, a warning message will be printed to the terminal (without stack trace) before thread termination. If no global handler is registered, the exception stack trace will be printed by default.

Subsequent registrations will override previous handler functions.

When multiple threads terminate due to exceptions concurrently, the handler function will be executed concurrently. Developers must ensure thread safety within the handler.

Handler parameters:
- First parameter: [Thread](core_package_classes.md#class-thread) - The thread where the exception occurred
- Second parameter: [Exception](core_package_exceptions.md#class-exception) - The unhandled exception

Parameters:
- exHandler: ([Thread](core_package_classes.md#class-thread), [Exception](core_package_exceptions.md#class-exception)) -> [Unit](core_package_intrinsics.md#unit) - The handler function to register.

## class ThreadLocal\<T>

```cangjie
public class ThreadLocal<T>
```

Function: This class represents Cangjie thread-local variables.

Compared to regular variables, thread-local variables have different access semantics. When multiple threads share the same thread-local variable, each thread maintains its own copy. Threads accessing the variable will read/write their local copy without affecting other threads' values.

### func get()

```cangjie
public func get(): ?T
```

Function: Gets the value of the Cangjie thread-local variable.

Return value:
- ?T - Returns the value if the current thread-local variable is non-null, otherwise returns `None`.

### func set(?T)

```cangjie
public func set(value: ?T): Unit
```

Function: Sets the value of the Cangjie thread-local variable. If `None` is passed, the local value will be removed and become inaccessible in subsequent thread operations.

Parameters:
- value: ?T - The value to set for the thread-local variable.