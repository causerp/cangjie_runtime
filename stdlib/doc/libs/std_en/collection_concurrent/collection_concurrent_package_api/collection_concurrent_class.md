# Class

## class ArrayBlockingQueue\<E>

```cangjie
public class ArrayBlockingQueue<E> {
    public let capacity: Int64
    public init(capacity: Int64)
    public init(capacity: Int64, elements: Collection<E>)
}
```

Function: Array-based Blocking Queue data structure and related operations.

[ArrayBlockingQueue](collection_concurrent_class.md#class-arrayblockingqueuee) is a concurrent queue with blocking mechanism that requires user-specified capacity upper bound.

### prop size

```cangjie
public prop size: Int64
```

Function: Returns the number of elements in this [ArrayBlockingQueue](collection_concurrent_class.md#class-arrayblockingqueuee).

> **Note:**
>
> This method does not guarantee atomicity in concurrent scenarios. It is recommended to call when no other threads are concurrently modifying the [ArrayBlockingQueue](collection_concurrent_class.md#class-arrayblockingqueuee).

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### let capacity

```cangjie
public let capacity: Int64
```

Function: The capacity of this [ArrayBlockingQueue](collection_concurrent_class.md#class-arrayblockingqueuee).

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### init(Int64)

```cangjie
public init(capacity: Int64)
```

Function: Constructs an [ArrayBlockingQueue](collection_concurrent_class.md#class-arrayblockingqueuee) with the specified capacity.

Parameters:

- capacity: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Initial capacity size.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws exception if capacity is less than or equal to 0.

### init(Int64, Collection\<E>) <sup>(deprecated)</sup>

```cangjie
public init(capacity: Int64, elements: Collection<E>)
```

Function: Constructs an [ArrayBlockingQueue](collection_concurrent_class.md#class-arrayblockingqueuee) with specified capacity and initial elements from the iterator.

> **Note:**
>
> This will be deprecated in future versions. Equivalent Function can be achieved by creating an empty queue and then sequentially adding elements from the collection.

Parameters:

- capacity: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Initial capacity size.
- elements: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<E> - Initial collection elements.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws exception if capacity is less than or equal to 0 or smaller than the size of elements collection.

### func add(E)

```cangjie
public func add(element: E): Unit
```

Function: Blocking enqueue operation that adds an element to the tail of the queue. Blocks if the queue is full.

Parameters:

- element: E - Element to be added.

Example:

<!-- verify -->
```cangjie
import std.collection.concurrent.*

main() {
    var blockArr: ArrayBlockingQueue<Int64> = ArrayBlockingQueue<Int64>(2)
    blockArr.add(10)
    println(blockArr.peek())
}
```

Output:

```text
Some(10)
```

### func add(E, Duration)

```cangjie
public func add(element: E, timeout: Duration): Bool
```

Function: Blocking enqueue operation that adds an element to the tail of the queue, waiting for specified duration if the queue is full. If timeout is negative, performs immediate enqueue and returns operation result.

Parameters:

- element: E - Element to be added.
- timeout: [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - Waiting duration.

Return value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if element was successfully added, false if timeout was reached.

Example:

<!-- verify -->
```cangjie
import std.collection.concurrent.*
import std.sync.*
import std.time.*

main() {
    let blockArr: ArrayBlockingQueue<Int64> = ArrayBlockingQueue<Int64>(2)

    /* Create new thread to fill blocking queue, sleep 1 second then remove head element */
    spawn {
        =>
        blockArr.add(0)
        blockArr.add(1)
        sleep(1000 * Duration.millisecond)
        println("New thread moves out of blocked queue head element.")
        blockArr.remove()
    }

    /* Main thread yields execution, then performs blocking add after wakeup */
    sleep(-1 * Duration.millisecond)
    println("The main thread is woken up.")
    let isSuccess: Bool = blockArr.add(2, 2000 * Duration.millisecond)
    println(isSuccess)
}
```

Output:

```text
The main thread is woken up.
New thread moves out of blocked queue head element.
true
```

### func dequeue() <sup>(deprecated)</sup>

```cangjie
public func dequeue(): E
```

Function: Blocking dequeue operation that retrieves and removes the head element.

> **Note:**
>
> Will be deprecated in future versions. Use [remove()](#func-remove) instead.

Return value:

- E - The head element.

### func dequeue(Duration) <sup>(deprecated)</sup>

```cangjie
public func dequeue(timeout: Duration): Option<E>
```

Function: Blocking dequeue operation that retrieves and removes the head element, waiting for specified duration if queue is empty. If timeout is negative, performs immediate dequeue and returns operation result.

> **Note:**
>
> Will be deprecated in future versions. Use [remove(Duration)](#func-removeduration) instead.

Parameters:

- timeout: [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - Waiting duration.

Return value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<E> - Returns head element if successful, None if timeout was reached.

### func enqueue(E) <sup>(deprecated)</sup>

```cangjie
public func enqueue(element: E): Unit
```

Function: Blocking enqueue operation that adds an element to the tail of the queue.

> **Note:**
>
> Will be deprecated in future versions. Use [add(E)](#func-adde) instead.

Parameters:

- element: E - Element to be added.

### func enqueue(E, Duration) <sup>(deprecated)</sup>

```cangjie
public func enqueue(element: E, timeout: Duration): Bool
```

Function: Blocking enqueue operation that adds an element to the tail of the queue, waiting for specified duration if queue is full. If timeout is negative, performs immediate enqueue and returns operation result.

> **Note:**
>
> Will be deprecated in future versions. Use [add(E, Duration)](#func-adde-duration) instead.

Parameters:

- element: E - Element to be added.
- timeout: [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - Waiting duration.

Return value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if element was successfully added, false if timeout was reached.

### func head() <sup>(deprecated)</sup>

```cangjie
public func head(): Option<E>
```

Function: Retrieves the head element.

This is a non-blocking operation.

> **Note:**
>
> Will be deprecated in future versions. Use [peek()](#func-peek) instead.

Return value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<E> - Returns head element if present, None if queue is empty.

### func peek()

```cangjie
public func peek(): Option<E>
```

Function: Non-blocking retrieval of the head element.

Return value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<E> - Returns head element if present, None if queue is empty.

Example:

<!-- verify -->
```cangjie
import std.collection.concurrent.*

main() {
    let blockArr: ArrayBlockingQueue<Int64> = ArrayBlockingQueue<Int64>(2)
    blockArr.add(2)
    blockArr.add(3)
    println(blockArr.peek())
}
```

Output:

```text
Some(2)
```

### func remove()

```cangjie
public func remove(): E
```

Function: Blocking dequeue operation that retrieves and removes the head element. Blocks if the queue is empty.

Return value:

- E - The head element.

Example:

<!-- verify -->
```cangjie
import std.collection.concurrent.*

main() {
    let blockArr: ArrayBlockingQueue<Int64> = ArrayBlockingQueue<Int64>(2)
    blockArr.add(2)
    blockArr.add(3)
    println(blockArr.remove())
    println(blockArr.size)
}
```

Execution Result:

```text
2
1
```

### func remove(Duration)

```cangjie
public func remove(timeout: Duration): Option<E>
```

Function: Blocking dequeue operation that retrieves and removes the head element of the queue. If the queue is empty, it waits for the specified duration. If timeout is negative, it performs the dequeue operation immediately and returns the result.

Parameters:

- timeout: [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - The waiting duration.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<E> - Returns the head element. If the operation times out before successfully retrieving the head element, returns None.

Example:

<!-- verify -->
```cangjie
import std.collection.concurrent.*
import std.sync.*
import std.time.*

main() {
    let blockArr: ArrayBlockingQueue<Int64> = ArrayBlockingQueue<Int64>(2)

    /* Create a new thread that sleeps for 1 second before adding an element to the queue */
    spawn {
        =>
        sleep(1000 * Duration.millisecond)
        println("This new thread adds new elements to the queue.")
        blockArr.add(3)
    }

    /* The main thread yields execution immediately, wakes up, and performs a blocking dequeue */
    sleep(-1 * Duration.millisecond)
    println("The main thread is woken up.")
    let num: Option<Int64> = blockArr.remove(2000 * Duration.millisecond)
    println(num)
}
```

Execution Result:

```text
The main thread is woken up.
This new thread adds new elements to the queue.
Some(3)
```

### func tryAdd(E)

```cangjie
public func tryAdd(element: E): Bool
```

Function: Non-blocking enqueue operation that adds an element to the tail of the queue.

Parameters:

- element: E - The element to be added.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if the element was successfully added; returns false if the queue is full.

Example:

<!-- verify -->
```cangjie
import std.collection.concurrent.*

main() {
    let blockArr: ArrayBlockingQueue<Int64> = ArrayBlockingQueue<Int64>(2)
    blockArr.tryAdd(2)
    blockArr.tryAdd(3)
    println(blockArr.size)
}
```

Execution Result:

```text
2
```

### func tryDequeue() <sup>(deprecated)</sup>

```cangjie
public func tryDequeue(): Option<E>
```

Function: Non-blocking dequeue operation that retrieves and removes the head element of the queue.

> **Note:**
>
> This method will be deprecated in future versions. Use [tryRemove()](#func-tryremove) instead.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<E> - Returns the head element, or None if the queue is empty.

### func tryEnqueue(E) <sup>(deprecated)</sup>

```cangjie
public func tryEnqueue(element: E): Bool
```

Function: Non-blocking enqueue operation that adds an element to the tail of the queue.

> **Note:**
>
> This method will be deprecated in future versions. Use [tryAdd(E)](#func-tryadde) instead.

Parameters:

- element: E - The element to be added.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if the element was successfully added; returns false if the queue is full.

### func tryRemove()

```cangjie
public func tryRemove(): Option<E>
```

Function: Non-blocking dequeue operation that retrieves and removes the head element of the queue.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<E> - Returns the head element, or None if the queue is empty.

Example:

<!-- verify -->
```cangjie
import std.collection.concurrent.*

main() {
    let blockArr: ArrayBlockingQueue<Int64> = ArrayBlockingQueue<Int64>(2)
    blockArr.tryAdd(2)
    println(blockArr.tryRemove())
    println(blockArr.tryRemove())
}
```

Execution Result:

```text
Some(2)
None
```

## class LinkedBlockingQueue\<E>

```cangjie
public class LinkedBlockingQueue<E> {
    public let capacity: Int64
    public init()
    public init(capacity: Int64)
    public init(capacity: Int64, elements: Array<E>)
    public init(capacity: Int64, elements: Collection<E>)
}
```

Function: Implements a concurrent queue with blocking mechanism and user-specified capacity limits.

A blocking queue has the characteristic that when the queue is full, threads attempting to add elements will be blocked until space becomes available; when the queue is empty, threads attempting to retrieve elements will be blocked until elements become available.

### let capacity

```cangjie
public let capacity: Int64
```

Function: Returns the capacity of this [LinkedBlockingQueue](collection_concurrent_class.md#class-linkedblockingqueuee).

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### prop size

```cangjie
public prop size: Int64
```

Function: Returns the number of elements in this [LinkedBlockingQueue](collection_concurrent_class.md#class-linkedblockingqueuee).

> **Note:**
>
> This method does not guarantee atomicity in concurrent scenarios. It is recommended to call this method only when no other threads are concurrently modifying the [LinkedBlockingQueue](collection_concurrent_class.md#class-linkedblockingqueuee).

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### init()

```cangjie
public init()
```

Function: Constructs a [LinkedBlockingQueue](collection_concurrent_class.md#class-linkedblockingqueuee) with the default initial capacity ([Int64](../../core/core_package_api/core_package_intrinsics.md#int64).Max).

### init(Int64)

```cangjie
public init(capacity: Int64)
```

Function: Constructs a [LinkedBlockingQueue](collection_concurrent_class.md#class-linkedblockingqueuee) with the specified capacity.

Parameters:

- capacity: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The initial capacity size.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if capacity is less than or equal to 0.

### init(Int64, Array\<E>) <sup>(deprecated)</sup>

```cangjie
public init(capacity: Int64, elements: Array<E>)
```

Function: Constructs a [LinkedBlockingQueue](collection_concurrent_class.md#class-linkedblockingqueuee) with the specified capacity and initial array elements.

> **Note:**
>
> This method will be deprecated in future versions. To achieve equivalent Function, first create an empty queue and then add the array elements to the queue sequentially.

Parameters:

- capacity: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The initial capacity size.
- elements: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<E> - The initial array elements.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if capacity is less than or equal to 0 or less than the size of the array elements.

### init(Int64, Collection\<E>) <sup>(deprecated)</sup>

```cangjie
public init(capacity: Int64, elements: Collection<E>)
```

Function: Constructs a [LinkedBlockingQueue](collection_concurrent_class.md#class-linkedblockingqueuee) with the specified capacity and initial collection elements.

> **Note:**
>
> This method will be deprecated in future versions. To achieve equivalent Function, first create an empty queue and then add the collection elements to the queue sequentially.

Parameters:

- capacity: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The initial capacity size.
- elements: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<E> - The initial collection elements.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if capacity is less than or equal to 0 or less than the size of the collection elements.

### func add(E)

```cangjie
public func add(element: E): Unit
```

Function: Blocking enqueue operation that adds an element to the tail of the queue. If the queue is full, it blocks and waits.

Parameters:

- element: E - The element to be added.

Example:

<!-- verify -->
```cangjie
import std.collection.concurrent.*

main() {
var blockArr: LinkedBlockingQueue<Int64> = LinkedBlockingQueue<Int64>(2)
    blockArr.add(10)
    println(blockArr.peek())
}
```

Execution Result:

```text
Some(10)
```

### func add(E, Duration)

```cangjie
public func add(element: E, timeout: Duration): Bool
```

Function: Blocking enqueue operation that adds an element to the tail of the queue. If the queue is full, it will wait for the specified duration. If timeout is negative, it will immediately perform the enqueue operation and return the result.

Parameters:

- element: E - The element to be added.
- timeout: [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - The waiting duration.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if the element is successfully added. Returns false if the operation times out before successful addition.

Example:

<!-- verify -->
```cangjie
import std.collection.concurrent.*
import std.sync.*
import std.time.*

main() {
    let blockArr: LinkedBlockingQueue<Int64> = LinkedBlockingQueue<Int64>(2)

    /* Create a new thread to fill the blocking queue, then remove the head element after 1 second of sleep */
    spawn {
        =>
        blockArr.add(0)
        blockArr.add(1)
        sleep(1000 * Duration.millisecond)
        println("New thread moves out of blocked queue head element.")
        blockArr.remove()
    }

    /* Main thread yields execution immediately, then performs blocking addition after wake-up */
    sleep(-1 * Duration.millisecond)
    println("The main thread is woken up.")
    let isSuccess: Bool = blockArr.add(2, 2000 * Duration.millisecond)
    println(isSuccess)
}
```

Execution Result:

```text
The main thread is woken up.
New thread moves out of blocked queue head element.
true
```

### func dequeue() <sup>(deprecated)</sup>

```cangjie
public func dequeue(): E
```

Function: Blocking dequeue operation that retrieves and removes the head element.

> **Note:**
>
> This method will be deprecated in future versions. Use [remove()](#func-remove-1) instead.

Return Value:

- E - Returns the head element.

### func dequeue(Duration) <sup>(deprecated)</sup>

```cangjie
public func dequeue(timeout: Duration): Option<E>
```

Function: Blocking dequeue operation that retrieves and removes the head element. If the queue is empty, it will wait for the specified duration. If timeout is negative, it will immediately perform the dequeue operation and return the result.

> **Note:**
>
> This method will be deprecated in future versions. Use [remove(Duration)](#func-removeduration-1) instead.

Parameters:

- timeout: [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - The waiting duration.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<E> - Returns the head element. Returns None if the operation times out before successful retrieval.

### func enqueue(E) <sup>(deprecated)</sup>

```cangjie
public func enqueue(element: E): Unit
```

Function: Blocking enqueue operation that adds an element to the tail of the queue.

> **Note:**
>
> This method will be deprecated in future versions. Use [add(E)](#func-adde-1) instead.

Parameters:

- element: E - The element to be added.

### func enqueue(E, Duration) <sup>(deprecated)</sup>

```cangjie
public func enqueue(element: E, timeout: Duration): Bool
```

Function: Blocking enqueue operation that adds an element to the tail of the queue. If the queue is full, it will wait for the specified duration. If timeout is negative, it will immediately perform the enqueue operation and return the result.

> **Note:**
>
> This method will be deprecated in future versions. Use [add(E, Duration)](#func-adde-duration) instead.

Parameters:

- element: E - The element to be added.
- timeout: [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - The waiting duration.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if the element is successfully added. Returns false if the operation times out before successful addition.

### func head() <sup>(deprecated)</sup>

```cangjie
public func head(): Option<E>
```

Function: Retrieves the head element.

> **Note:**
>
> - This is a non-blocking function.
> - This method will be deprecated in future versions. Use [peek()](#func-peek-1) instead.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<E> - Returns the head element, or None if the queue is empty.

### func peek()

```cangjie
public func peek(): Option<E>
```

Function: Retrieves the head element.

> **Note:**
>
> This is a non-blocking function.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<E> - Returns the head element, or None if the queue is empty.

Example:

<!-- verify -->
```cangjie
import std.collection.concurrent.*

main() {
    let blockArr: LinkedBlockingQueue<Int64> = LinkedBlockingQueue<Int64>(2)
    blockArr.add(2)
    blockArr.add(3)
    println(blockArr.peek())
}
```

Execution Result:

```text
Some(2)
```

### func remove()

```cangjie
public func remove(): E
```

Function: Blocking dequeue operation that retrieves and removes the head element.

Return Value:

- E - Returns the head element.

Example:

<!-- verify -->
```cangjie
import std.collection.concurrent.*

main() {
    let blockArr: LinkedBlockingQueue<Int64> = LinkedBlockingQueue<Int64>(2)
    blockArr.add(2)
    blockArr.add(3)
    println(blockArr.remove())
    println(blockArr.size)
}
```

Execution Result:

```text
2
1
```

### func remove(Duration)

```cangjie
public func remove(timeout: Duration): Option<E>
```

Function: Blocking dequeue operation that retrieves and removes the head element. If the queue is empty, it will wait for the specified duration. If timeout is negative, it will immediately perform the dequeue operation and return the result.

Parameters:

- timeout: [Duration](../../core/core_package_api/core_package_structs.md#struct-duration) - The waiting duration.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<E> - Returns the head element, or None if the operation times out before successful retrieval.

Example:

<!-- verify -->
```cangjie
import std.collection.concurrent.*
import std.sync.*
import std.time.*

main() {
    let blockArr: LinkedBlockingQueue<Int64> = LinkedBlockingQueue<Int64>(2)

    /* Create a new thread that adds an element to the queue after 1 second of sleep */
    spawn {
        =>
        sleep(1000 * Duration.millisecond)
        println("This new thread adds new elements to the queue.")
        blockArr.add(3)
    }

    /* Main thread yields execution immediately, then performs blocking removal after wake-up */
    sleep(-1 * Duration.millisecond)
    println("The main thread is woken up.")
    let num: Option<Int64> = blockArr.remove(2000 * Duration.millisecond)
    println(num)
}
```

Execution Result:

```text
The main thread is woken up.
This new thread adds new elements to the queue.
Some(3)
```

### func tryAdd(E)

```cangjie
public func tryAdd(element: E): Bool
```

Function: Non-blocking enqueue operation that adds an element to the tail of the queue.

Parameters:

- element: E - The element to be added.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if the addition is successful; returns false if the queue is full.

Example:

<!-- verify -->
```cangjie
import std.collection.concurrent.*

main() {
    let blockArr: LinkedBlockingQueue<Int64> = LinkedBlockingQueue<Int64>(2)
    blockArr.tryAdd(2)
    blockArr.tryAdd(3)
    println(blockArr.size)
}
```

Execution Result:

```text
2
```

### func tryDequeue() <sup>(deprecated)</sup>

```cangjie
public func tryDequeue(): Option<E>
```

Function: Non-blocking dequeue operation that retrieves and removes the head element.

> **Note:**
>
> Will be deprecated in future versions. Use [tryRemove()](#func-tryremove-1) instead.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<E> - Returns the head element, or None if the queue is empty.

### func tryEnqueue(E) <sup>(deprecated)</sup>

```cangjie
public func tryEnqueue(element: E): Bool
```

Function: Non-blocking enqueue operation that adds an element to the tail of the queue.

> **Note:**
>
> Will be deprecated in future versions. Use [tryAdd(E)](#func-tryadde-1) instead.

Parameters:

- element: E - The element to be added.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if successfully added; returns false if the queue is full.

### func tryRemove()

```cangjie
public func tryRemove(): Option<E>
```

Function: Non-blocking dequeue operation that retrieves and removes the head element.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<E> - Returns the head element, or None if the queue is empty.

Example:

<!-- verify -->
```cangjie
import std.collection.concurrent.*

main() {
    let blockArr: LinkedBlockingQueue<Int64> = LinkedBlockingQueue<Int64>(2)
    blockArr.tryAdd(3)
    println(blockArr.tryRemove())
    println(blockArr.tryRemove())
}
```

Execution Result:

```text
Some(3)
None
```

## class ConcurrentHashMapIterator\<K, V> where K <: Hashable & Equatable\<K>

```cangjie
public class ConcurrentHashMapIterator<K, V> <: Iterator<(K, V)> where K <: Hashable & Equatable<K> {
    public init(cmap: ConcurrentHashMap<K, V>)
}
```

Function: This class primarily implements the iterator Function for [ConcurrentHashMap](collection_concurrent_class.md#class-concurrenthashmapk-v-where-k--hashable--equatablek).

> **Note:**
>
> The [ConcurrentHashMap](collection_concurrent_class.md#class-concurrenthashmapk-v-where-k--hashable--equatablek) iterator defined here:
>
> 1. Does not guarantee that iteration results are a "snapshot" of the concurrent [HashMap](../../collection/collection_package_api/collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) at any moment. It is recommended to call this when no other threads are concurrently modifying the [ConcurrentHashMap](collection_concurrent_class.md#class-concurrenthashmapk-v-where-k--hashable--equatablek).
> 2. During iteration, the iterator does not guarantee awareness of modifications made to the target [ConcurrentHashMap](collection_concurrent_class.md#class-concurrenthashmapk-v-where-k--hashable--equatablek) by other threads.

Parent Types:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<(K, V)>

### init(ConcurrentHashMap\<K, V>)

```cangjie
public init(cmap: ConcurrentHashMap<K, V>)
```

Function: Creates a [ConcurrentHashMapIterator](collection_concurrent_class.md#class-concurrenthashmapiteratork-v-where-k--hashable--equatablek)\<K, V> instance.

Parameters:

- cmap: [ConcurrentHashMap](collection_concurrent_class.md#class-concurrenthashmapk-v-where-k--hashable--equatablek)\<K, V> - The [ConcurrentHashMap](collection_concurrent_class.md#class-concurrenthashmapk-v-where-k--hashable--equatablek)\<K, V> instance for which to obtain the iterator.

### func next()

```cangjie
public func next(): Option<(K, V)>
```

Function: Returns the next element in the iteration.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<(K, V)> - An [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<(K,V)> type.

Example:

<!-- verify -->
```cangjie
import std.collection.concurrent.*

main() {
    let map: ConcurrentHashMap<Int64, Int64> = ConcurrentHashMap<Int64, Int64>(3, {value => (value, value)})
    let iter = ConcurrentHashMapIterator<Int64, Int64>(map)
    while (true) {
        match (iter.next()) {
            case Some(i) => println("(${i[0]},${i[1]})")
            case None => break
        }
    }
}
```

Execution Result:

```text
(0,0)
(1,1)
(2,2)
```

## class ConcurrentHashMap\<K, V> where K <: Hashable & Equatable\<K>

```cangjie
public class ConcurrentHashMap<K, V> <: ConcurrentMap<K, V> & Collection<(K, V)> where K <: Hashable & Equatable<K> {
    public init(concurrencyLevel!: Int64 = 16)
    public init(capacity: Int64, concurrencyLevel!: Int64 = 16)
    public init(elements: Collection<(K, V)>, concurrencyLevel!: Int64 = 16)
    public init(size: Int64, initElement: (Int64) -> (K, V), concurrencyLevel!: Int64 = 16)
}
```

Function: This class implements a thread-safe hash table [ConcurrentHashMap](collection_concurrent_class.md#class-concurrenthashmapk-v-where-k--hashable--equatablek) data structure and related operations for concurrent scenarios.

> **Tip:**
>
> [ConcurrentHashMap](collection_concurrent_class.md#class-concurrenthashmapk-v-where-k--hashable--equatablek) automatically expands its capacity when insufficient.

The parameter concurrencyLevel in the constructor represents the "concurrency level," i.e., the maximum number of threads allowed to concurrently modify the [ConcurrentHashMap](collection_concurrent_class.md#class-concurrenthashmapk-v-where-k--hashable--equatablek). Key-value pair query operations are non-blocking and are not limited by the specified concurrencyLevel. The parameter concurrencyLevel defaults to 16. It only affects the performance of [ConcurrentHashMap](collection_concurrent_class.md#class-concurrenthashmapk-v-where-k--hashable--equatablek) in concurrent scenarios, not its Function.

> **Note:**
>
> If the user-provided concurrencyLevel is less than 16, the concurrency level will be set to 16.
>
> A higher concurrencyLevel is not always better. Larger concurrencyLevel values may lead to higher memory overhead (potentially causing out-of-memory exceptions). Users must balance memory overhead with runtime efficiency.

Parent Types:

- [ConcurrentMap](collection_concurrent_interface.md#interface-concurrentmapk-v)\<K, V>
- [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<(K, V)>

Example:

See [ConcurrentHashMap Usage Example](../collection_concurrent_samples/sample_concurrenthashmap.md).

### prop size

```cangjie
public prop size: Int64
```

Function: Returns the number of key-value pairs.

> **Note:**
>
> This method does not guarantee atomicity in concurrent scenarios. It is recommended to call this when no other threads are concurrently modifying the [ConcurrentHashMap](#class-concurrenthashmapk-v-where-k--hashable--equatablek).

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### init(Collection\<(K, V)>, Int64)

```cangjie
public init(elements: Collection<(K, V)>, concurrencyLevel!: Int64 = 16)
```

Function: Constructs a [ConcurrentHashMap](collection_concurrent_class.md#class-concurrenthashmapk-v-where-k--hashable--equatablek) with the provided iterator elements and specified concurrency level. This constructor sets the capacity of [ConcurrentHashMap](collection_concurrent_class.md#class-concurrenthashmapk-v-where-k--hashable--equatablek) based on the size of the provided iterator elements.

Parameters:

- elements: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<(K, V)> - Initial iterator elements.
- concurrencyLevel!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - User-specified concurrency level.

### init(Int64)

```cangjie
public init(concurrencyLevel!: Int64 = 16)
```

Function: Constructs a [ConcurrentHashMap](collection_concurrent_class.md#class-concurrenthashmapk-v-where-k--hashable--equatablek) with default initial capacity (16) and specified concurrency level (defaults to 16).

Parameters:

- concurrencyLevel!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - User-specified concurrency level.

### init(Int64, (Int64) -> (K, V), Int64)

```cangjie
public init(size: Int64, initElement: (Int64) -> (K, V), concurrencyLevel!: Int64 = 16)
```

Function: Constructs a [ConcurrentHashMap](collection_concurrent_class.md#class-concurrenthashmapk-v-where-k--hashable--equatablek) with the specified size, initialization function elements, and concurrency level. This constructor sets the capacity of [ConcurrentHashMap](collection_concurrent_class.md#class-concurrenthashmapk-v-where-k--hashable--equatablek) based on the size parameter.

Parameters:

- size: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Size of initialization function elements.
- initElement: ([Int64](../../core/core_package_api/core_package_intrinsics.md#int64)) -> (K, V) - Initialization function elements.
- concurrencyLevel!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - User-specified concurrency level.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if size is less than 0.

### init(Int64, Int64)

```cangjie
public init(capacity: Int64, concurrencyLevel!: Int64 = 16)
```

Function: Constructs a [ConcurrentHashMap](collection_concurrent_class.md#class-concurrenthashmapk-v-where-k--hashable--equatablek) with the specified initial capacity and concurrency level (defaults to 16).

Parameters:

- capacity: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Initial capacity size.
- concurrencyLevel!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - User-specified concurrency level.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if capacity is less than 0.

### func add(K, V)

```cangjie
public func add(key: K, value: V): ?V
```

Function: Associates the specified value with the specified key in this [ConcurrentHashMap](#class-concurrenthashmapk-v-where-k--hashable--equatablek). If the [ConcurrentHashMap](#class-concurrenthashmapk-v-where-k--hashable--equatablek) already contains an association for the key, the old value is replaced. If the [ConcurrentHashMap](#class-concurrenthashmapk-v-where-k--hashable--equatablek) does not contain an association for the key, the key-value association is added.

Parameters:

- key: K - The key to be placed.
- value: V - The value to be associated.

Return Value:

- ?V - Returns the old value Some(V) if the key existed before assignment; returns None if the key did not exist before assignment.

Example:

<!-- verify -->
```cangjie
import std.collection.concurrent.*

main() {
    let map: ConcurrentHashMap<Int64, Int64> = ConcurrentHashMap<Int64, Int64>(3, {value => (value, value)})
    let oldValue = map.add(2, 3)
    println(oldValue)
    let newValue = map.add(3, 3)
    println(newValue)
    let iter = ConcurrentHashMapIterator<Int64, Int64>(map)
    while (true) {
        match (iter.next()) {
            case Some(i) => println("(${i[0]},${i[1]})")
            case None => break
        }
    }
}
```

Execution Result:

```text
Some(2)
None
(0,0)
(1,1)
(2,3)
(3,3)
```

### func addIfAbsent(K, V)

```cangjie
public func addIfAbsent(key: K, value: V): ?V
```

Function: When the key `key` does not exist in this [ConcurrentHashMap](#class-concurrenthashmapk-v-where-k--hashable--equatablek), it associates the specified value `value` with the specified key `key` in the [ConcurrentHashMap](#class-concurrenthashmapk-v-where-k--hashable--equatablek). If the [ConcurrentHashMap](#class-concurrenthashmapk-v-where-k--hashable--equatablek) already contains the key `key`, no assignment operation is performed.

Parameters:

- `key`: K - The key to be placed.
- `value`: V - The value to be assigned.

Return Value:

- `?V` - If the key `key` existed before assignment, returns the current value `Some(V)` associated with the key without performing the assignment; returns `None` if the key did not exist before assignment.

Example:

<!-- verify -->
```cangjie
import std.collection.concurrent.*

main() {
    let map: ConcurrentHashMap<Int64, Int64> = ConcurrentHashMap<Int64, Int64>(3, {value => (value, value)})
    let oldValue = map.addIfAbsent(2, 3)
    println(oldValue)
    let newValue = map.addIfAbsent(3, 3)
    println(newValue)
    let iter = ConcurrentHashMapIterator<Int64, Int64>(map)
    while (true) {
        match (iter.next()) {
            case Some(i) => println("(${i[0]},${i[1]})")
            case None => break
        }
    }
}
```

Execution Result:

```text
Some(2)
None
(0,0)
(1,1)
(2,2)
(3,3)
```

### func contains(K)

```cangjie
public func contains(key: K): Bool
```

Function: Determines whether this map contains a mapping for the specified key `key`.

Parameters:

- `key`: K - The key to be checked.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether the map contains a mapping for the specified key `key`. Returns `true` if it does, otherwise `false`.

Example:

<!-- verify -->
```cangjie
import std.collection.concurrent.*

main() {
    let map: ConcurrentHashMap<Int64, Int64> = ConcurrentHashMap<Int64, Int64>(3, {value => (value, value)})
    map.add(3, 3)
    println(map.contains(3))
    println(map.contains(6))
}
```

Execution Result:

```text
true
false
```

### func entryView(K, (MapEntryView\<K, V>) -> Unit)

```cangjie
public func entryView(key: K, fn: (MapEntryView<K, V>) -> Unit): ?V
```

Function: Retrieves the corresponding key-value pair view `entryView` for the specified key `key` in the current map and invokes the function `fn` to perform add, delete, or modify operations on this key-value pair. Returns the final value associated with the key `key` in the current map after the function `fn` is called.

If the current map does not contain the key `key`, an empty view `entryView` is obtained. If the `value` of this view is set to a non-`None` value, a new key-value pair will be added to the current map.

If the current map contains the key `key`, the key-value view is obtained. If the `value` is set to `None`, it is equivalent to deleting the key-value pair from the current map. If the `value` is set to a new non-`None` value, it is equivalent to modifying the value associated with the key `key` in the current map.

Note: The function `fn` must not concurrently call the functions [entryView](#func-entryviewk-mapentryviewk-v---unit), [remove](#func-remove), or [replace](#func-replacek-v), such as:

```cangjie
map.entryView(1) { _ =>
    let f = spawn {
        map.entryView(17) { _ => () }
    }
    f.get()
}
```

> **Notes:**
>
> - This operation is atomic.
>
> - Modifications to the key-value pair during the callback `fn` are not immediately updated to the current map. The changes are collectively updated to the current map only after the `entryView` function call completes.

Parameters:

- `key`: K - The key for which the corresponding view is to be retrieved.
- `fn`: ([MapEntryView](../../collection/collection_package_api/collection_package_interface.md#interface-mapentryviewk-v)\<K, V>) -> [Unit](../../core/core_package_api/core_package_intrinsics.md#unit) - Custom operations to be performed on the specified view, which can be used to add, delete, or modify key-value pairs in the map.

Return Value:

- `?V` - The value associated with the key `key` in the current map after the function `fn` is called. Returns `None` if the key does not exist.

Example:

<!-- verify -->
```cangjie
import std.collection.concurrent.*

main() {
    let map: ConcurrentHashMap<Int64, Int64> = ConcurrentHashMap<Int64, Int64>(2, {value => (value, value)})
    map.add(2, 2)

    /* The current map does not contain the key-value pair with key 3. Setting entryView.value to 7 is equivalent to adding a new key-value pair (3,7) */
    let num1 = map.entryView(3, {view => view.value = 7})
    println(num1)

    /* The current map contains the key-value pair with key 2. Setting entryView.value to 6 is equivalent to updating the value for key 1 to 6 */
    let num2 = map.entryView(1, {view => view.value = 6})
    println(num2)

    /* The current map contains the key-value pair with key 0. Setting entryView.value to None is equivalent to deleting the key-value pair with key 0 */
    let num3 = map.entryView(0, {view => view.value = None})
    println(num3)

    let iter = ConcurrentHashMapIterator<Int64, Int64>(map)
    while (true) {
        match (iter.next()) {
            case Some(i) => println("(${i[0]},${i[1]})")
            case None => break
        }
    }
}
```

Execution Result:

```text
Some(7)
Some(6)
None
(1,6)
(2,2)
(3,7)
```

### func get(K)

```cangjie
public func get(key: K): ?V
```

Function: Returns the value associated with the key `key` in this map.

Parameters:

- `key`: K - The key whose associated value is to be retrieved.

Return Value:

- `?V` - The value associated with the key `key` in this map.

### func isEmpty()

```cangjie
public func isEmpty(): Bool
```

Function: Determines whether the [ConcurrentHashMap](#class-concurrenthashmapk-v-where-k--hashable--equatablek) is empty.

> **Note:**
>
> This method does not guarantee atomicity in concurrent scenarios. It is recommended to call this method only when no other threads are concurrently modifying the [ConcurrentHashMap](#class-concurrenthashmapk-v-where-k--hashable--equatablek).

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the map is empty, otherwise `false`.

### func iterator()

```cangjie
public func iterator(): ConcurrentHashMapIterator<K, V>
```

Function: Retrieves the iterator for the [ConcurrentHashMap](#class-concurrenthashmapk-v-where-k--hashable--equatablek).

Return Value:

- [ConcurrentHashMapIterator](collection_concurrent_class.md#class-concurrenthashmapiteratork-v-where-k--hashable--equatablek)\<K, V> - The iterator for the [ConcurrentHashMap](#class-concurrenthashmapk-v-where-k--hashable--equatablek).

Example:

<!-- verify -->
```cangjie
import std.collection.concurrent.*

main() {
    let map: ConcurrentHashMap<Int64, Int64> = ConcurrentHashMap<Int64, Int64>(3, {value => (value, value)})
    let iter = map.iterator()
    while (true) {
        match (iter.next()) {
            case Some(i) => println("(${i[0]},${i[1]})")
            case None => break
        }
    }
}
```

Execution Result:

```text
(0,0)
(1,1)
(2,2)
```

### func put(K, V) <sup>(deprecated)</sup>

```cangjie
public func put(key: K, value: V): ?V
```

Function: Associates the specified value `value` with the specified key `key` in this [ConcurrentHashMap](#class-concurrenthashmapk-v-where-k--hashable--equatablek). If the [ConcurrentHashMap](#class-concurrenthashmapk-v-where-k--hashable--equatablek) already contains an association for the key `key`, the old value is replaced. If the [ConcurrentHashMap](#class-concurrenthashmapk-v-where-k--hashable--equatablek) does not contain an association for the key `key`, the key-value association is added.

> **Note:**
>
> This method will be deprecated in future versions. Use [add(K, V)](#func-addk-v) instead.

Parameters:

- `key`: K - The key to be placed.
- `value`: V - The value to be associated.

Return Value:

- `?V` - If the key `key` existed before assignment, returns the old value `Some(V)`; returns `None` if the key did not exist before assignment.

### func putIfAbsent(K, V) <sup>(deprecated)</sup>

```cangjie
public func putIfAbsent(key: K, value: V): ?V
```

Function: When the key `key` does not exist in this [ConcurrentHashMap](#class-concurrenthashmapk-v-where-k--hashable--equatablek), it associates the specified value `value` with the specified key `key` in the [ConcurrentHashMap](#class-concurrenthashmapk-v-where-k--hashable--equatablek). If the [ConcurrentHashMap](#class-concurrenthashmapk-v-where-k--hashable--equatablek) already contains the key `key`, no assignment operation is performed.

> **Note:**
>
> This method will be deprecated in future versions. Use [addIfAbsent(K, V)](#func-addifabsentk-v) instead.

Parameters:

- `key`: K - The key to be placed.
- `value`: V - The value to be assigned.

Return Value:

- `?V` - If the key `key` existed before assignment, returns the current value `Some(V)` associated with the key without performing the assignment; returns `None` if the key did not exist before assignment.

### func remove((K, (V) -> Bool)) <sup>(deprecated)</sup>

```cangjie
public func remove(key: K, predicate: (V) -> Bool): ?V
```

Function: If the key `key` exists in this map and the value `v` mapped to the key satisfies the condition `predicate`, the mapping for the key `key` is removed from this map.

> **Note:**> **Deprecated in future versions**, use [entryView(K, (MapEntryView\<K, V>) -> Unit)](#func-entryviewk-mapentryviewk-v---unit) instead.

Parameters:

- key: K - The key to be removed.
- predicate: (V) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - A lambda expression for evaluation.

Return Value:

- ?V - Returns the old value associated with the key if it exists in the map; returns None when the key does not exist or its associated value fails the predicate.

### func remove(K)

```cangjie
public func remove(key: K): ?V
```

Function: Removes the mapping for the specified key from this map if present.

Parameters:

- key: K - The key to be removed.

Return Value:

- ?V - Returns Some(V) with the value associated with the key before removal if the key existed; returns None if the key was absent during removal.

Example:

<!-- verify -->
```cangjie
import std.collection.concurrent.*

main() {
    let map: ConcurrentHashMap<Int64, Int64> = ConcurrentHashMap<Int64, Int64>(3, {value => (value, value)})
    let num = map.remove(0)
    println(num)
    let iter = map.iterator()
    while (true) {
        match (iter.next()) {
            case Some(i) => println("(${i[0]},${i[1]})")
            case None => break
        }
    }
}
```

Execution Result:

```text
Some(0)
(1,1)
(2,2)
```

### func replace(K, (V) -> Bool, (V) -> V) <sup>(deprecated)</sup>

```cangjie
public func replace(key: K, predicate: (V) -> Bool, eval: (V) -> V): ?V
```

Function: If the key exists in [ConcurrentHashMap](#class-concurrenthashmapk-v-where-k--hashable--equatablek) (assuming its associated value is v) and v satisfies the predicate, replaces the value associated with the key in [ConcurrentHashMap](#class-concurrenthashmapk-v-where-k--hashable--equatablek) with the result of eval(v); if the key does not exist in [ConcurrentHashMap](#class-concurrenthashmapk-v-where-k--hashable--equatablek) or its associated value fails the predicate, no modification is made to [ConcurrentHashMap](#class-concurrenthashmapk-v-where-k--hashable--equatablek).

> **Note:**
>
> **Deprecated in future versions**, use [entryView(K, (MapEntryView\<K, V>) -> Unit)](#func-entryviewk-mapentryviewk-v---unit) instead.

Parameters:

- key: K - The key whose associated value is to be replaced.
- predicate: (V) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - A lambda expression for evaluation.
- eval: (V) -> V - The function to compute the new replacement value.

Return Value:

- ?V - Returns Some(V) with the old value associated with the key if it exists; returns None if the key does not exist or its associated value fails the predicate.

### func replace(K, (V) -> V) <sup>(deprecated)</sup>

```cangjie
public func replace(key: K, eval: (V) -> V): ?V
```

Function: If the key exists in [ConcurrentHashMap](#class-concurrenthashmapk-v-where-k--hashable--equatablek) (assuming its associated value is v), replaces the value associated with the key in [ConcurrentHashMap](#class-concurrenthashmapk-v-where-k--hashable--equatablek) with the result of eval(v); if the key does not exist in [ConcurrentHashMap](#class-concurrenthashmapk-v-where-k--hashable--equatablek), no modification is made.

> **Note:**
>
> **Deprecated in future versions**, use [entryView(K, (MapEntryView\<K, V>) -> Unit)](#func-entryviewk-mapentryviewk-v---unit) instead.

Parameters:

- key: K - The key whose associated value is to be replaced.
- eval: (V) -> V - The function to compute the new replacement value.

Return Value:

- ?V - Returns Some(V) with the old value associated with the key if it exists; returns None if the key does not exist.

### func replace(K, V)

```cangjie
public func replace(key: K, value: V): ?V
```

Function: If the key exists in [ConcurrentHashMap](#class-concurrenthashmapk-v-where-k--hashable--equatablek), replaces its associated value with the given value; if the key does not exist, no modification is made to [ConcurrentHashMap](#class-concurrenthashmapk-v-where-k--hashable--equatablek).

Parameters:

- key: K - The key whose associated value is to be replaced.
- value: V - The new value to replace with.

Return Value:

- ?V - Returns Some(V) with the old value associated with the key if it exists; returns None if the key does not exist.

Example:

<!-- verify -->
```cangjie
import std.collection.concurrent.*

main() {
    let map: ConcurrentHashMap<Int64, Int64> = ConcurrentHashMap<Int64, Int64>(3, {value => (value, value)})
    let num = map.replace(0, 2)
    println(num)
    let iter = map.iterator()
    while (true) {
        match (iter.next()) {
            case Some(i) => println("(${i[0]},${i[1]})")
            case None => break
        }
    }
}
```

Execution Result:

```text
Some(0)
(0,2)
(1,1)
(2,2)
```

### operator func \[](K)

```cangjie
public operator func [](key: K): V
```

Function: Overloaded operator for collection access. Returns the value associated with the key if it exists; throws an exception otherwise.

Parameters:

- key: K - The key to look up.

Return Value:

- V - The value associated with the key.

Exceptions:

- [NoneValueException](../../core/core_package_api/core_package_exceptions.md#class-nonevalueexception) - Thrown when the key does not exist in the mapping.

### operator func \[](K, V)

```cangjie
public operator func [](key: K, value!: V): Unit
```

Function: Overloaded operator for collection modification. If the key exists, overwrites its value; if the key does not exist, adds the key-value pair.

Parameters:

- key: K - The key to be modified or added.
- value!: V - The value to be set.

## class ConcurrentLinkedQueue\<E>

```cangjie
public class ConcurrentLinkedQueue<E> <: Collection<E> {
    public init()
    public init(elements: Collection<E>)
}
```

Function: Provides a thread-safe queue that allows safe element addition and removal operations in multi-threaded environments.

The purpose of non-blocking queues is to address synchronization issues in multi-threaded environments, enabling concurrent queue operations by multiple threads without data conflicts or deadlocks.

Non-blocking queues are widely used in multi-threaded programming for any scenario requiring thread-safe queues, such as producer-consumer models, task scheduling, thread pools, etc.

Parent Types:

- [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<E>

Usage Example:

See [ConcurrentLinkedQueue Usage Example](../collection_concurrent_samples/sample_concurrent_linked_queue.md).

### prop size

```cangjie
public prop size: Int64
```

Function: Gets the number of elements in this [ConcurrentLinkedQueue](collection_concurrent_class.md#class-concurrentlinkedqueuee).

> **Note:**
>
> This method does not guarantee atomicity in concurrent scenarios. It is recommended to call this when no other threads are concurrently modifying [ConcurrentLinkedQueue](collection_concurrent_class.md#class-concurrentlinkedqueuee).

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### init()

```cangjie
public init()
```

Function: Constructs a default [ConcurrentLinkedQueue](collection_concurrent_class.md#class-concurrentlinkedqueuee) instance.

### init(Collection\<E>) <sup>(deprecated)</sup>

```cangjie
public init(elements: Collection<E>)
```

Function: Constructs a [ConcurrentLinkedQueue](collection_concurrent_class.md#class-concurrentlinkedqueuee) instance from a [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<E> instance.

> **Note:**
>
> **Deprecated in future versions**. To achieve equivalent Function, first create an empty queue, then sequentially add elements from the [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont).

Parameters:

- elements: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<E> - The collection whose elements will be added to the newly constructed [ConcurrentLinkedQueue](collection_concurrent_class.md#class-concurrentlinkedqueuee).

### func add(E)

```cangjie
public func add(element: E): Bool
```

Function: Non-blocking enqueue operation that adds an element to the tail of the queue.

> **Note:**
>
> This function will never return false.

Parameters:

- element: E - The element to be added.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true upon successful addition.

### func dequeue() <sup>(deprecated)</sup>

```cangjie
public func dequeue(): Option<E>
```

Function: Retrieves and removes the head element of the queue.

> **Note:**
>
> **Deprecated in future versions**, use [remove()](#func-remove-2) instead.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<E> - Returns Some(E) with the head element if successfully removed; returns None if the queue is empty.

### func enqueue(E) <sup>(deprecated)</sup>

```cangjie
public func enqueue(element: E): Bool
```

Function: Non-blocking enqueue operation that adds an element to the tail of the queue.

> **Note:**
>
> - This function will never return false.
> - **Deprecated in future versions**, use [add(E)](#func-adde-2) instead.

Parameters:

- element: E - The element to be added.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true upon successful addition.

### func head() <sup>(deprecated)</sup>

```cangjie
public func head(): Option<E>
```

Function: Retrieves the head element of the queue without removing it.

> **Note:**
>
> This method will be deprecated in future versions. Use [peek()](#func-peek-2) instead.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<E> - Returns the head element if successfully retrieved, or None if the queue is empty.

### func isEmpty()

```cangjie
public func isEmpty(): Bool
```

Function: Checks whether the current queue is empty.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if the current queue is empty, otherwise returns false.

### func iterator()

```cangjie
public func iterator(): Iterator<E>
```

Function: Retrieves an iterator for the current queue, used for traversing the queue.

> **Note:**
>
> The traversal operation does not remove elements from the queue.
> The traversal operation does not guarantee atomicity. If other threads concurrently modify the current queue, the elements obtained during traversal may not represent a static snapshot of the queue at any given moment.

Return Value:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<E> - The iterator for the current queue.

### func peek()

```cangjie
public func peek(): Option<E>
```

Function: Retrieves the head element of the queue without removing it.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<E> - Returns the head element if successfully retrieved, or None if the queue is empty.

### func remove()

```cangjie
public func remove(): Option<E>
```

Function: Retrieves and removes the head element of the queue.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<E> - Returns the head element if successfully removed, or None if the queue is empty.

### func toArray()

```cangjie
public func toArray(): Array<E>
```

Function: Stores all elements of the current queue into an array in sequential order, with earlier-enqueued elements occupying lower indices in the array.

> **Note:**
>
> This operation does not remove elements from the queue.
> This operation does not guarantee atomicity. If other threads concurrently modify the current queue, the resulting array may not represent a static snapshot of the queue at any given moment.

Return Value:

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<E> - The resulting array containing the elements of the current queue.
