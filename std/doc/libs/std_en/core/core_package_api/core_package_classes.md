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

Function: Given an [Array](core_package_structs.md#struct-arrayt) instance, creates its corresponding iterator for traversing all objects in the array instance.

Parameters:

- data: [Array](core_package_structs.md#struct-arrayt)\<T> - The array instance.

### func next()

```cangjie
public func next(): Option<T>
```

Function: Returns the next value in the array iterator.

Return Value:

- [Option](core_package_enums.md#enum-optiont)\<T> - The next member in the array iterator, wrapped in [Option](core_package_enums.md#enum-optiont). Returns `None` when iteration reaches the end.

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

Execution Result:

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

Function: The [Box](core_package_classes.md#class-boxt) type provides the capability to add a `class` wrapper layer to other types.

If type `T` itself lacks reference capability (e.g., `struct` types), the wrapped [Box](core_package_classes.md#class-boxt)\<T> type becomes referenceable.

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

Function: Given a `T` type instance, constructs the corresponding [Box](core_package_classes.md#class-boxt)\<T> instance.

Parameters:

- v: T - An instance of any type.

### extend\<T> Box\<T> <: Comparable\<Box\<T>> where T <: Comparable\<T>

```cangjie
extend<T> Box<T> <: Comparable<Box<T>> where T <: Comparable<T>
```

Function: Extends the [Box](core_package_classes.md#class-boxt)\<T> class with the [Comparable](core_package_interfaces.md#interface-comparablet)\<[Box](core_package_classes.md#class-boxt)\<T>> interface, providing size comparison capability.

The size relationship between [Box](core_package_classes.md#class-boxt)\<T> instances matches that of their wrapped `T` instances.

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

- [Ordering](core_package_enums.md#enum-ordering) - Returns [Ordering](core_package_enums.md#enum-ordering).GT if the current [Box](core_package_classes.md#class-boxt) instance is greater than 'that', [Ordering](core_package_enums.md#enum-ordering).EQ if equal, and [Ordering](core_package_enums.md#enum-ordering).LT if smaller.

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

Execution Result:

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

- [Bool](core_package_intrinsics.md#bool) - Returns true if the current [Box](core_package_classes.md#class-boxt) object is smaller than the parameter [Box](core_package_classes.md#class-boxt) object, otherwise false.

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

Function: Extends the [Box](core_package_classes.md#class-boxt)\<T> class with the [Hashable](core_package_interfaces.md#interface-hashable) interface, providing size comparison capability.

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

Function: Extends the [Box](core_package_classes.md#class-boxt)\<T> type with the [ToString](core_package_interfaces.md#interface-tostring) interface, supporting string conversion operations.

Parent Types:

- [ToString](core_package_interfaces.md#interface-tostring)

#### func toString()

```cangjie
public func toString(): String
```

Function: Obtains the string representation of a [Box](core_package_classes.md#class-boxt) object. The string content is the string representation of the encapsulated `T` type instance within the current object.

Return Value:

- [String](core_package_structs.md#struct-string) - The converted string.

## class Future\<T>

```cangjie
public class Future<T>
```

Function: A [Future](core_package_classes.md#class-futuret)\<T> instance represents a Cangjie thread task, which can be used to obtain computation results from Cangjie threads and send cancellation signals to them.

The return type of a `spawn` expression is [Future](core_package_classes.md#class-futuret)\<T>, where `T` depends on the return type of the closure within the `spawn` expression.

### prop thread

```cangjie
public prop thread: Thread
```

Function: Obtains the [Thread](core_package_classes.md#class-thread) instance corresponding to the Cangjie thread.

Type: [Thread](core_package_classes.md#class-thread)

### func cancel()

```cangjie
public func cancel(): Unit
```

Function: Sends a cancellation request to the Cangjie thread corresponding to the current [Future](core_package_classes.md#class-futuret) instance. This method does not immediately stop thread execution but merely sends the request. Correspondingly, the `hasPendingCancellation` function in the [Thread](core_package_classes.md#class-thread) class can be used to check whether a cancellation request exists for the thread. Developers can use this check to decide whether and how to terminate the thread prematurely.

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

Execution Result:

```text
0
```

### func get()

```cangjie
public func get(): T
```

Function: Blocks the current thread, waits for, and obtains the result of the thread corresponding to the current [Future](core_package_classes.md#class-futuret)\<T> object.

Return Value:

- T - The return value of the thread represented by the current [Future](core_package_classes.md#class-futuret)\<T> instance upon completion.

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

Execution Result:

```text
1
```

### func get(Duration)

```cangjie
public func get(timeout: Duration): T
```

Function: Blocks the current thread, waits for a specified duration, and obtains the return value of the thread corresponding to the current [Future](core_package_classes.md#class-futuret)\<T> object.

A timeout must be specified. If the corresponding thread does not complete execution within the specified time, this function throws a [TimeoutException](./core_package_exceptions.md#class-timeoutexception). If timeout <= Duration.Zero, it behaves the same as get(), i.e., with no waiting limit. If the thread throws an exception during execution, the same exception will be propagated at the get call site.

Parameters:

- timeout: [Duration](./core_package_structs.md#struct-duration) - The waiting duration.

Return Value:

- T - The execution result of the Cangjie thread after the specified duration.

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
    /* Maximum wait time is 2 seconds; TimeoutException is thrown if exceeded */

    println(result)
    return 0
}
```

Execution Result:

```text
1
```

### func tryGet()

```cangjie
public func tryGet(): Option<T>
```

Function: Attempts to obtain the execution result without blocking the current thread. Returns `None` if the corresponding thread has not completed.

Return Value:

- [Option](core_package_enums.md#enum-optiont)\<T> - Returns `None` if the Cangjie thread has not completed; otherwise, returns the execution result.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    let fut: Future<Int64> = spawn {
        =>
        sleep(1000 * Duration.millisecond) /* Sleep for 1 second */
        return 1
    }

    /* Main thread waits for 4 seconds to ensure spawned thread completes */
    sleep(4000 * Duration.millisecond)

    /* Attempt to obtain execution result of spawned thread */
    let result: Option<Int64> = fut.tryGet()
    println(result)
    return 0
}
```

Execution Result:

```text
Some(1)
```

## class Iterator\<T>

```cangjie
public abstract class Iterator<T> <: Iterable<T>
```

Function: This class represents an iterator, providing the `next` method to support iterative traversal of container elements.

Parent Types:

- [Iterable](core_package_interfaces.md#interface-iterablee)\<T>

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

Function: Obtains the next element during iteration.

Return Value:

- [Option](core_package_enums.md#enum-optiont)\<T> - The next element during iteration.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    var arr: Array<Int64> = [1, 2, 3, 4, 5]
    var iter = arr.iterator() /* Obtain iterator object for container */

    while (true) { /* Use iterator for traversal */
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

Iterator methods primarily include intermediate operations and terminal operations. Intermediate operations (e.g., [skip()](#func-skipint64), [map()](#func-maprt---r)) produce a new iterator. Terminal operations (e.g., [count()](#func-count), [all()](#func-allt---bool)) compute results based on elements produced by the iterator without generating a new iterator. Each iterator method consumes different numbers of elements from the iterator; see individual method descriptions for details.

#### func all((T) -> Bool)

```cangjie
public func all(predicate: (T)-> Bool): Bool
```

Function: Determines whether all elements in the iterator satisfy the given condition. This method repeatedly consumes elements from the iterator until an element fails to meet the condition.

Parameters:

- predicate: (T) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The specified condition.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether all elements satisfy the condition.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    var arr: Array<Int64> = [1, 2, 3, 4, 5]

    /* Obtain iterator object for container */
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

Function: Determines whether any element in the iterator satisfies the given condition. This method will repeatedly fetch and consume elements from the iterator until an element meets the condition.

Parameters:

- predicate: (T) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The given condition.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether any element satisfies the condition.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    var arr: Array<Int64> = [1, 2, 3, 4, 5]

    /* Get the iterator object of the container */
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

Function: Retrieves the nth element of the current iterator, with counting starting from 0. This method will consume all elements preceding the specified element (including the specified element).

Parameters:

- n: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The given element index, starting from 0.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - Returns the element at the specified position. If n exceeds the number of remaining elements, returns None.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    var arr: Array<Int64> = [1, 2, 3, 4, 5]

    /* Get the iterator object of the container */
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

Function: Concatenates two iterators, with the current iterator first and the parameter-specified iterator following.

Parameters:

- other: [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - The iterator to be concatenated after.

Return Value:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - Returns the new concatenated iterator.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    var arr1: Array<Int64> = [1, 2]
    var arr2: Array<Int64> = [3, 4]

    /* Get the iterator objects of the containers */
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
> This method consumes the iterator, meaning the iterator will be empty after calling this method.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Returns the number of elements in the iterator.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    var arr: Array<Int64> = [1, 2]

    /* Get the iterator object of the container */
    var iter = arr.iterator()
    let len: Int64 = iter.count()
    println(len)

    /* Attempt to traverse the iterator, but count() has consumed all elements, so nothing will print */
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

Function: Creates an iterator that yields elements along with their indices.

Return Value:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<([Int64](../../core/core_package_api/core_package_intrinsics.md#int64), T)> - Returns an iterator that yields tuples of (index, element).

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    var arr: Array<Int64> = [1, 2]

    /* Get the iterator object of the container */
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

Function: Filters elements that satisfy the given condition.

Parameters:

- predicate: (T) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The given condition. Elements for which the condition evaluates to `true` will appear in the returned iterator in order.

Return Value:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - Returns a new iterator.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    var arr: Array<Int64> = [1, 2, 3, 4, 5]

    /* Get the filtered iterator object */
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

Function: Performs both filtering and mapping operations simultaneously, returning a new iterator.

Parameters:

- transform: (T) -> [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - The given mapping function. A return value of Some corresponds to a predicate of true in filter, while None corresponds to false.

Return Value:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<R> - Returns a new iterator.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    var arr: Array<Int64> = [1, 2, 3, 4, 5]

    /* Get the filtered and mapped iterator object. The mapping must return an Option type */
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

Function: Retrieves the head element of the current iterator. This method consumes the first element.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - Returns the head element, or None if empty.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    var arr: Array<Int64> = [1, 2, 3, 4, 5]

    /* Obtain iterator object */
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

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<R> - Returns a mapping with [flatten](../../collection/collection_package_api/collection_package_function.md#func-flattent-riterablet-where-t--iterabler) functionality.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    var arr: Array<Array<Int64>> = [[1], [2], [3], [4, 5]]

    /* Obtain iterator object with flatten functionality */
    var iter = arr.iterator()
    var iter1 = iter.flatMap({value => value.iterator()})

    /* Perform flattened traversal using the iterator */
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

- initial: R - The given initial value of type R.
- operation: (R, T) -> R - The given computation function.

Return Value:

- R - Returns the final computed value.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    var arr: Array<Int64> = [1, 2, 3, 4, 5]

    /* Obtain iterator object and perform summation on array elements */
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

Function: Traverses all elements of the current iterator and performs the given operation on each element. This method consumes all elements in the iterator.

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

Function: Performs an additional operation on the current element each time the iterator calls next() (does not consume elements in the iterator).

Parameters:

- action: (T) -> [Unit](../../core/core_package_api/core_package_intrinsics.md#unit) - The given operation function.

Return Value:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - Returns a new iterator.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    var arr: Array<Int64> = [1, 2]

    /* Obtain iterator object and attach additional operations to the next function */
    var iter = arr.iterator()
    var iter1 = iter.inspect({value => println("Logging: Processing ${value}")})

    /* Perform traversal using the iterator */
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

Function: Inserts a given new element between every two elements in the iterator.

Parameters:

- separator: T - The given element.

Return Value:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - Returns a new iterator.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    var arr: Array<Int64> = [1, 2]

    /* Obtain iterator object and insert a 0 between every two elements */
    var iter = arr.iterator()
    var iter1 = iter.intersperse(0)

    /* Perform traversal using the iterator */
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

Function: Determines whether the current iterator is empty. This method calls [next()](#func-next-1) and determines if the iterator is empty based on its return value. Therefore, if the iterator is not empty, one element will be consumed.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns whether the current iterator is empty.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    var arr: Array<Int64> = [1, 2]

    /* Obtain iterator object */
    var iter = arr.iterator()

    /* Check if the iterator has elements (consumes one element if not empty) */
    println(iter.isEmpty())

    /* Perform traversal using the iterator */
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
public func last(): Option<T>
```

Function: Retrieves the last element of the current iterator. This method consumes all elements in the iterator and returns the last one.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - Returns the last element, or None if empty.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    var arr: Array<Int64> = [1, 2]

    /* Get the iterator object */
    var iter = arr.iterator()
    println(iter.last())
    return 0
}
```

Execution Result:

```text
Some(2)
```

#### func map\<R>((T) -> R)

```cangjie
public func map<R>(transform: (T)-> R): Iterator<R>
```

Function: Creates a mapping.

Parameters:

- transform: (T) -> R - The given mapping function.

Return Value:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<R> - Returns a mapped iterator.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    var arr: Array<Int64> = [1, 2, 3, 4]

    /* Get the iterator object and map the elements to obtain a new iterator */
    var iter = arr.iterator()
    var iter1 = iter.map({value => value * 2})

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
2
4
6
8
```

#### func none((T) -> Bool)

```cangjie
public func none(predicate: (T)-> Bool): Bool
```

Function: Determines if none of the elements in the current iterator satisfy the condition. This method repeatedly consumes elements until one satisfies the condition.

Parameters:

- predicate: (T) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The given condition.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether none of the elements satisfy the condition.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    var arr: Array<Int64> = [1, 2, 3, 4]

    /* Get the iterator objects */
    var iter1 = arr.iterator()
    var iter2 = arr.iterator()

    /* Elements exist that are greater than 2, returns false */
    var flag1: Bool = iter1.none({value => value > 2})
    println(flag1)

    /* No elements are greater than 5, returns true */
    var flag2: Bool = iter2.none({value => value > 5})
    println(flag2)
    return 0
}
```

Execution Result:

```text
false
true
```

#### func reduce((T, T) -> T)

```cangjie
public func reduce(operation: (T, T) -> T): Option<T>
```

Function: Uses the first element as the initial value and computes from left to right. This method consumes all elements in the iterator.

Parameters:

- operation: (T, T) -> T - The given computation function.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - Returns the computation result.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    var arr: Array<Int64> = [1, 2, 3, 4, 5]

    /* Get the iterator object and sum the array elements */
    var iter = arr.iterator()
    var sum: Option<Int64> = iter.reduce({total, value => total + value})
    println(sum)
    return 0
}
```

Execution Result:

```text
Some(15)
```

#### func skip(Int64)

```cangjie
public func skip(count: Int64): Iterator<T>
```

Function: Skips a specified number of elements from the current iterator.

When count is less than 0, an exception is thrown. When count equals 0, it returns the original iterator. When count is greater than 0 and less than the iterator's size, it skips count elements and returns a new iterator with the remaining elements. When count is greater than or equal to the iterator's size, it skips all elements and returns an empty iterator.

Parameters:

- count: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The number of elements to skip.

Return Value:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - Returns an iterator that skips the specified number of elements.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when count < 0.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    var arr: Array<Int64> = [1, 2, 3, 4, 5]

    /* Get the iterator object and skip the first two elements */
    var iter = arr.iterator()
    var iter1 = iter.skip(2)

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

#### func step(Int64)

```cangjie
public func step(count: Int64): Iterator<T>
```

Function: Skips a specified number of elements each time next() is called on the iterator.

When count is less than or equal to 0, an exception is thrown. When count is greater than 0, each call to next() skips count elements until the iterator is empty.

Parameters:

- count: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The number of elements to skip per next() call.

Return Value:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - Returns a new iterator that skips the specified number of elements per next() call.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when count <= 0.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    var arr: Array<Int64> = [1, 2, 3, 4, 5]

    /* Get the iterator object and skip two elements per next() call */
    var iter = arr.iterator()
    var iter1 = iter.step(2)

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
3
5
```

#### func take(Int64)

```cangjie
public func take(count: Int64): Iterator<T>
```

Function: Takes a specified number of elements from the current iterator.

Takes the first count elements from the iterator. When count is less than 0, an exception is thrown. When count equals 0, it returns an empty iterator. When count is greater than 0 and less than the iterator's size, it returns a new iterator with the first count elements. When count is greater than or equal to the iterator's size, it returns the original iterator.

Parameters:

- count: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The number of elements to take.

Return Value:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - Returns an iterator with the specified number of elements.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when count < 0.

Example:
<!-- verify -->
```cangjie
main(): Int64 {
    var arr: Array<Int64> = [1, 2, 3, 4, 5]

    /* Get iterator object and take the first three elements */
    var iter = arr.iterator()
    var iter1 = iter.take(3)

    /* Traverse using iterator expansion */
    while (true) {
        match (iter1.next()) {
            case Some(i) => println(i)
            case None => break
        }
    }
    return 0
}
```

Execution result:

```text
1
2
3
```

#### func zip\<R>(Iterator\<R>)

```cangjie
public func zip<R>(it: Iterator<R>): Iterator<(T, R)>
```

Function: Combines two iterators into one (length determined by the shorter iterator).

Parameters:

- it: [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<R> - One of the iterators to be combined.

Return value:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<(T, R)> - Returns a new iterator.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    var arr1: Array<Int64> = [1, 2, 3, 4]
    var arr2: Array<Int64> = [4, 5, 6]

    /* Get iterator objects and combine them; elements in the new iterator are tuples of corresponding index positions */
    var iter1 = arr1.iterator()
    var iter2 = arr2.iterator()
    var iter = iter1.zip(iter2)

    /* Traverse using the iterator; length depends on the shorter iterator */
    while (true) {
        match (iter.next()) {
            case Some(i) => println("The current element is (${i[0]}, ${i[1]}) ")
            case None => break
        }
    }
    return 0
}
```

Execution result:

```text
The current element is (1, 4)
The current element is (2, 5)
The current element is (3, 6)
```

### extend\<T> Iterator\<T> where T <: Comparable\<T>

```cangjie
extend<T> Iterator<T> where T <: Comparable<T>
```

Function: Extends the [Iterator](core_package_classes.md#class-iteratort)\<T> type with the [Comparable](core_package_interfaces.md#interface-comparablet)\<T> interface to support comparison operations.

#### func max()

```cangjie
public func max(): Option<T>
```

Function: Filters the maximum element. This method consumes all elements in the iterator.

Return value:

- [Option](core_package_enums.md#enum-optiont)\<T> - Returns the maximum element, or None if empty.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    var arr: Array<Int64> = [1, 2, 3, 4]

    /* Get iterator object and use max() to find the maximum value */
    var iter = arr.iterator()
    match (iter.max()) {
        case Some(i) => println(i)
        case None => println("None!")
    }
    return 0
}
```

Execution result:

```text
4
```

#### func min()

```cangjie
public func min(): Option<T>
```

Function: Filters the minimum element. This method consumes all elements in the iterator.

Return value:

- [Option](core_package_enums.md#enum-optiont)\<T> - Returns the minimum element, or None if empty.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    var arr: Array<Int64> = [1, 2, 3, 4]

    /* Get iterator object and use min() to find the minimum value */
    var iter = arr.iterator()
    match (iter.min()) {
        case Some(i) => println(i)
        case None => println("None!")
    }
    return 0
}
```

Execution result:

```text
1
```

### extend\<T> Iterator\<T> where T <: Equatable\<T>

```cangjie
extend<T> Iterator<T> where T <: Equatable<T>
```

Function: Extends the [Iterator](core_package_classes.md#class-iteratort)\<T> type with the [Equatable](core_package_interfaces.md#interface-equatablet)\<T> interface to support equality operations.

#### func contains(T)

```cangjie
public func contains(element: T): Bool
```

Function: Traverses all elements to determine if the specified element is contained. This method repeatedly fetches and consumes elements from the iterator until an element equal to the parameter `element` is found.

Parameters:

- element: T - The element to search for.

Return value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether the specified element is contained.

Example:

<!-- verify -->
```cangjie
main(): Int64 {
    var arr: Array<Int64> = [1, 2, 3, 4]

    /* Get iterator object and check if it contains element 3 */
    var iter = arr.iterator()
    println(iter.contains(3))

    /* Traverse using the iterator and output remaining elements */
    while (true) {
        match (iter.next()) {
            case Some(i) => println(i)
            case None => break
        }
    }
    return 0
}
```

Execution result:

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

Function: [Object](core_package_classes.md#class-object) is the parent class of all `class` types, which all `class` types inherit by default. The [Object](core_package_classes.md#class-object) class contains no members, meaning it is an "empty" class.

Parent type:

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

Function: Iterator for the [Range](core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet) type. For iteration functionality details, see [Iterable](core_package_interfaces.md#interface-iterablee) and [Iterator](core_package_classes.md#class-iteratort) interface descriptions.

Parent type:

- [Iterator](#class-iteratort)\<T>

### func next()

```cangjie
public func next(): Option<T>
```

Function: Gets the next value in the [Range](core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet) iterator.

Return value:

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

Function: Represents specific information about an exception stack trace, including the class name, method name, file name, and line number where the exception occurred.

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

Function: Retrieves the name of the function where the exception occurred.

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

- Functionally, it supports input values of multiple types, automatically converting them to [String](core_package_structs.md#struct-string) type objects and appending them to the constructed string.
- Performance-wise, it uses a dynamic expansion algorithm to reduce memory allocation frequency, resulting in faster string construction and typically lower memory usage.

> **Note:**
>
> [StringBuilder](core_package_classes.md#class-stringbuilder) only supports UTF-8 encoded character data.

Parent Type:

- [ToString](core_package_interfaces.md#interface-tostring)

### prop capacity

```cangjie
public prop capacity: Int64
```

Function: Retrieves the current capacity of the [StringBuilder](core_package_classes.md#class-stringbuilder) instance to hold strings. This value increases as expansion occurs.

Type: [Int64](core_package_intrinsics.md#int64)

### prop size

```cangjie
public prop size: Int64
```

Function: Retrieves the length of the string in the [StringBuilder](core_package_classes.md#class-stringbuilder) instance.

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

Function: Initializes a [StringBuilder](core_package_classes.md#class-stringbuilder) instance with the character array specified by the `value` parameter. The initial capacity is the size of `value`, and the initial content is the characters contained in `value`.

Parameters:

- value: [Array](core_package_structs.md#struct-arrayt)\<Rune> - The character array used to initialize the [StringBuilder](core_package_classes.md#class-stringbuilder) instance.

### init(Int64)

```cangjie
public init(capacity: Int64)
```

Function: Initializes an empty [StringBuilder](core_package_classes.md#class-stringbuilder) instance with the capacity specified by the `capacity` parameter. The initial capacity is the size of `value`, and the initial content consists of several `\0` characters.

Parameters:

- capacity: [Int64](core_package_intrinsics.md#int64) - The byte capacity for initializing the [StringBuilder](core_package_classes.md#class-stringbuilder) instance. Valid range is (0, [Int64.Max](./core_package_intrinsics.md#static-prop-max-5)].

Exceptions:

- [IllegalArgumentException](core_package_exceptions.md#class-illegalargumentexception) - Thrown when the `capacity` parameter is less than or equal to 0.

### init(Rune, Int64)

```cangjie
public init(r: Rune, n: Int64)
```

Function: Initializes a [StringBuilder](core_package_classes.md#class-stringbuilder) instance with `n` instances of the character `r`. The initial capacity is `n`, and the initial content consists of `n` instances of `r`.

Parameters:

- r: Rune - The character used to initialize the [StringBuilder](core_package_classes.md#class-stringbuilder) instance.
- n: [Int64](core_package_intrinsics.md#int64) - The number of `r` characters. Valid range is [0, [Int64.Max](./core_package_intrinsics.md#static-prop-max-5)].

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

Function: Appends the string representation of the [Array](core_package_structs.md#struct-arrayt)\<T> specified by the `val` parameter to the end of the [StringBuilder](core_package_classes.md#class-stringbuilder). Type `T` must implement the [ToString](core_package_interfaces.md#interface-tostring) interface.

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

Function: Appends the content of the [CString](core_package_intrinsics.md#cstring) specified by the `cstr` parameter to the end of the [StringBuilder](core_package_classes.md#class-stringbuilder).

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

Function: Appends the character specified by the `r` parameter to the end of the [StringBuilder](core_package_classes.md#class-stringbuilder).

Parameters:

- r: Rune - The character to append.

### func append(String)

```cangjie
public func append(str: String): Unit
```

Function: Appends the string specified by the `str` parameter to the end of the [StringBuilder](core_package_classes.md#class-stringbuilder).

Parameters:

- str: [String](core_package_structs.md#struct-string) - The string to append.

### func append(StringBuilder)

```cangjie
public func append(sb: StringBuilder): Unit
```

Function: Appends the content of the [StringBuilder](core_package_classes.md#class-stringbuilder) specified by the `sb` parameter to the end of the [StringBuilder](core_package_classes.md#class-stringbuilder).

Parameters:- sb: [StringBuilder](core_package_classes.md#class-stringbuilder) - The inserted [StringBuilder](core_package_classes.md#class-stringbuilder) instance.

### func append\<T>(T) where T <: ToString

```cangjie
public func append<T>(v: T): Unit where T <: ToString
```

Function: Appends the string representation of parameter `v` of type `T` to the end of [StringBuilder](core_package_classes.md#class-stringbuilder). Type `T` must implement the [ToString](core_package_interfaces.md#interface-tostring) interface.

Parameters:

- v: T - The instance of type `T` to be appended.

### func append(UInt16)

```cangjie
public func append(n: UInt16): Unit
```

Function: Appends the string representation of parameter `n` to the end of [StringBuilder](core_package_classes.md#class-stringbuilder).

Parameters:

- n: [UInt16](core_package_intrinsics.md#uint16) - The value of type [UInt16](core_package_intrinsics.md#uint16) to be appended.

### func append(UInt32)

```cangjie
public func append(n: UInt32): Unit
```

Function: Appends the string representation of parameter `n` to the end of [StringBuilder](core_package_classes.md#class-stringbuilder).

Parameters:

- n: [UInt32](core_package_intrinsics.md#uint32) - The value of type [UInt32](core_package_intrinsics.md#uint32) to be appended.

### func append(UInt64)

```cangjie
public func append(n: UInt64): Unit
```

Function: Appends the string representation of parameter `n` to the end of [StringBuilder](core_package_classes.md#class-stringbuilder).

Parameters:

- n: [UInt64](core_package_intrinsics.md#uint64) - The value of type [UInt64](core_package_intrinsics.md#uint64) to be appended.

### func append(UInt8)

```cangjie
public func append(n: UInt8): Unit
```

Function: Appends the string representation of parameter `n` to the end of [StringBuilder](core_package_classes.md#class-stringbuilder).

Parameters:

- n: [UInt8](core_package_intrinsics.md#uint8) - The value of type [UInt8](core_package_intrinsics.md#uint8) to be appended.

### func appendFromUtf8(Array\<Byte>)

```cangjie
public func appendFromUtf8(arr: Array<Byte>): Unit
```

Function: Appends the byte array pointed to by parameter `arr` to the end of [StringBuilder](core_package_classes.md#class-stringbuilder).

This function requires the byte array `arr` to conform to UTF-8 encoding. If not, an exception will be thrown.

Parameters:

- arr: [Array](core_package_structs.md#struct-arrayt)\<[Byte](core_package_types.md#type-byte)> - The byte array to be appended.

Exceptions:

- [IllegalArgumentException](core_package_exceptions.md#class-illegalargumentexception) - Thrown when the byte array does not conform to UTF-8 encoding rules.

### func appendFromUtf8Unchecked(Array\<Byte>)

```cangjie
public unsafe func appendFromUtf8Unchecked(arr: Array<Byte>): Unit
```

Function: Appends the byte array pointed to by parameter `arr` to the end of [StringBuilder](core_package_classes.md#class-stringbuilder).

Compared to the `appendFromUtf8` function, it does not perform UTF-8 encoding rule checks on the byte array. Therefore, the constructed string is not guaranteed to be valid and may result in unexpected exceptions. Unless performance is critical in specific scenarios, prefer using the safer `appendFromUtf8` function.

Parameters:

- arr: [Array](core_package_structs.md#struct-arrayt)\<[Byte](core_package_types.md#type-byte)> - The byte array to be appended.

### func reserve(Int64)

```cangjie
public func reserve(additional: Int64): Unit
```

Function: Expands the capacity of [StringBuilder](core_package_classes.md#class-stringbuilder) by `additional` size.

No expansion occurs when `additional` is less than or equal to zero, or when the remaining capacity is greater than or equal to `additional`. When the remaining capacity is less than `additional`, the capacity is expanded to the maximum of either 1.5 times the current capacity (rounded down) or `size` + `additional`.

Parameters:

- additional: [Int64](core_package_intrinsics.md#int64) - The size by which to expand the [StringBuilder](core_package_classes.md#class-stringbuilder) capacity.

### func reset(Option\<Int64>)

```cangjie
public func reset(capacity!: Option<Int64> = None): Unit
```

Function: Clears the current [StringBuilder](core_package_classes.md#class-stringbuilder) and resets its capacity to the value specified by `capacity`.

Parameters:

- capacity!: [Option](core_package_enums.md#enum-optiont)\<[Int64](core_package_intrinsics.md#int64)> - The capacity of the [StringBuilder](core_package_classes.md#class-stringbuilder) instance after reset. Valid values are `None` and (`Some(0)`, `Some(Int64.Max)`]. The default value `None` indicates using the default capacity (32).

Exceptions:

- [IllegalArgumentException](core_package_exceptions.md#class-illegalargumentexception) - Thrown when the value of `capacity` is less than or equal to 0.

### func toString()

```cangjie
public func toString(): String
```

Function: Retrieves the string from the [StringBuilder](core_package_classes.md#class-stringbuilder) instance.

> **Note:**
>
> This function does not copy the string data.

Return Value:

- [String](core_package_structs.md#struct-string) - The string within the [StringBuilder](core_package_classes.md#class-stringbuilder) instance.

## class Thread

```cangjie
public class Thread
```

Function: Retrieves thread ID and name, checks for thread cancellation requests, and registers unhandled exception handlers for threads.

Instances of this type cannot be constructed directly. They can only be obtained through the `thread` property of a [Future](core_package_classes.md#class-futuret) object or the `currentThread` static property of the [Thread](core_package_classes.md#class-thread) class.

### static prop currentThread

```cangjie
public static prop currentThread: Thread
```

Function: Retrieves the [Thread](core_package_classes.md#class-thread) object of the currently executing thread.

Type: [Thread](core_package_classes.md#class-thread)

### prop hasPendingCancellation

```cangjie
public prop hasPendingCancellation: Bool
```

Function: Indicates whether the thread has a pending cancellation request, i.e., whether a cancellation request has been sent via future.cancel(). Commonly used as [Thread](core_package_classes.md#class-thread).currentThread.hasPendingCancellation.

Type: [Bool](core_package_intrinsics.md#bool)

### prop id

```cangjie
public prop id: Int64
```

Function: Retrieves the identifier of the currently executing thread, represented as an [Int64](core_package_intrinsics.md#int64). All live threads have unique identifiers, but there is no guarantee that a thread's identifier won't be reused after it terminates.

Type: [Int64](core_package_intrinsics.md#int64)

### prop name

```cangjie
public mut prop name: String
```

Function: Retrieves or sets the thread's name atomically.

Type: [String](core_package_structs.md#struct-string)

### static func handleUncaughtExceptionBy((Thread, Exception) -> Unit)

```cangjie
public static func handleUncaughtExceptionBy(exHandler: (Thread, Exception) -> Unit): Unit
```

Function: Registers a handler for unhandled thread exceptions.

When a thread terminates prematurely due to an exception, if a global unhandled exception handler is registered, it will be called before the thread terminates. If an exception is thrown within this handler, a warning message will be printed to the terminal, and the thread will terminate without printing the exception stack trace. If no global exception handler is registered, the default behavior is to print the exception stack trace to the terminal.

If multiple handlers are registered, subsequent registrations will overwrite previous ones.

When multiple threads terminate due to exceptions concurrently, the handler will be executed concurrently. Therefore, developers must ensure concurrency correctness within the handler.

The handler's first parameter is of type [Thread](core_package_classes.md#class-thread), representing the thread where the exception occurred. The second parameter is of type [Exception](core_package_exceptions.md#class-exception), representing the unhandled exception.

Parameters:

- exHandler: ([Thread](core_package_classes.md#class-thread), [Exception](core_package_exceptions.md#class-exception)) -> [Unit](core_package_intrinsics.md#unit) - The handler function to be registered.

## class ThreadLocal\<T>

```cangjie
public class ThreadLocal<T>
```

Function: This class represents Cangjie thread-local variables.

Compared to regular variables, thread-local variables have different access semantics. When multiple threads share the same thread-local variable, each thread has its own copy of the value. Threads read and write their local copies without affecting the values in other threads.

### func get()

```cangjie
public func get(): ?T
```

Function: Retrieves the value of the Cangjie thread-local variable.

Return Value:

- ?T - If the current thread-local variable is not empty, returns its value. If empty, returns `None`.

### func set(?T)

```cangjie
public func set(value: ?T): Unit
```

Function: Sets the value of the Cangjie thread-local variable via `value`. If `None` is passed, the local variable's value will be deleted and cannot be retrieved in subsequent thread operations.

Parameters:

- value: ?T - The value to set for the local variable.