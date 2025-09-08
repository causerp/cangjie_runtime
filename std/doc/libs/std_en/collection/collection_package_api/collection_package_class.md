# Class

## class ArrayDeque\<T>

```cangjie
public class ArrayDeque<T> <: Deque<T> {
    public init()
    public init(capacity: Int64)
}
```

Functionality: ArrayDeque is an implementation class of a double-ended queue (deque) that allows insertion and deletion operations at both ends. ArrayDeque is implemented based on a resizable array, whose capacity continuously grows during element insertion, with a default expansion rate of 50% each time. The implementation of ArrayDeque uses a circular queue approach, ensuring that insertion, deletion, and lookup operations have a time complexity of O(1) when no expansion occurs.

Parent Types:

- [Deque](./collection_package_interface.md#interface-dequet)\<T>

### prop capacity

```cangjie
public prop capacity: Int64
```

Functionality: Gets the capacity of this deque.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### prop first

```cangjie
public prop first: ?T
```

Functionality: Gets the first element of the deque. Returns None if the deque is empty.

Type: ?T

### prop last

```cangjie
public prop last: ?T
```

Functionality: Gets the last element of the deque. Returns None if the deque is empty.

Type: ?T

### prop size

```cangjie
public prop size: Int64
```

Functionality: Returns the number of elements in this deque.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### init()

```cangjie
public init()
```

Functionality: Constructs an empty deque with a default capacity of 8.

### init(Int64)

```cangjie
public init(capacity: Int64)
```

Functionality: Constructs a deque with the specified capacity. If the capacity is less than the default capacity of 8, the initial capacity of the [ArrayDeque](#class-arraydequet) will be 8.

Parameters:

- capacity: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The specified initial capacity.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if the parameter value is less than 0.

### func addFirst(T)

```cangjie
public func addFirst(element: T): Unit
```

Functionality: Inserts an element at the front of this deque.

Parameters:

- element: T - The element to be inserted into this deque.

### func addLast(T)

```cangjie
public func addLast(element: T): Unit
```

Functionality: Inserts an element at the end of this deque.

Parameters:

- element: T - The element to be inserted into this deque.

### func clear()

```cangjie
public func clear(): Unit
```

Functionality: Clears all elements from this deque.

### func iterator()

```cangjie
public func iterator(): Iterator<T>
```

Functionality: Gets an iterator over the elements in this deque in front-to-back order.

Return Value:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - An iterator over the elements.

### func isEmpty()

```cangjie
public func isEmpty(): Bool
```

Functionality: Checks whether this deque is empty.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if empty, otherwise `false`.

### func removeFirst()

```cangjie
public func removeFirst(): ?T
```

Functionality: Removes and returns the first element of this deque. Returns `None` if the deque is empty.

Return Value:

- ?T - The removed first element.

### func removeLast()

```cangjie
public func removeLast(): ?T
```

Functionality: Removes and returns the last element of this deque. Returns `None` if the deque is empty.

Return Value:

- ?T - The removed last element.

### func reserve(Int64)

```cangjie
public func reserve(additional: Int64): Unit
```

Functionality: Increases the capacity of this deque.

Expands the deque by the specified additional size. No expansion occurs if additional is less than or equal to zero, or if the remaining capacity of this deque is greater than or equal to additional. If the remaining capacity is less than additional, the expansion size will be the maximum of (original capacity multiplied by 1.5 and rounded down) and (additional + used capacity).

Parameters:

- additional: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The size to expand by.

### func toArray()

```cangjie
public func toArray(): Array<T>
```

Functionality: Returns an array containing all elements of this deque in front-to-back order.

Return Value:

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - An array of type T.

### extend\<T> ArrayDeque\<T> <: ToString where T <: ToString

```cangjie
extend<T> ArrayDeque<T> <: ToString where T <: ToString
```

Functionality: Extends [ArrayDeque](./collection_package_class.md#class-arraydequet)\<T> with the [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring) interface, supporting string conversion operations.

Parent Types:

- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

#### func toString()

```cangjie
public func toString(): String
```

Functionality: Gets the string representation of the current [ArrayDeque](./collection_package_class.md#class-arraydequet)\<T> instance.

The string contains the string representation of each element in the deque in front-to-back order, formatted as: "[elem1, elem2, elem3]".

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The resulting string.

## class ArrayList\<T>

```cangjie
public class ArrayList<T> <: List<T> {
    public init()
    public init(capacity: Int64)
    public init(size: Int64, initElement: (Int64) -> T)
    public init(elements: Collection<T>)
}
```

Functionality: Provides functionality for variable-length arrays.

[ArrayList](collection_package_class.md#class-arraylistt) is a linear dynamic array. Unlike [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt), it can automatically resize as needed and does not require a specified size at creation.

> **Note:**
>
> - When adding elements to a dynamic array, if the array is full, it will reallocate a larger memory space and copy existing elements to the new space.
>
> - The advantage of dynamic arrays is memory efficiency and automatic resizing, making them ideal for scenarios requiring frequent element addition or removal. However, the downside is potential performance degradation during reallocation, which should be considered when using dynamic arrays.

Parent Types:

- [List](./collection_package_interface.md#interface-listt)\<T>

### prop size

```cangjie
public prop size: Int64
```

Functionality: Returns the number of elements in this [ArrayList](collection_package_class.md#class-arraylistt).

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### prop capacity

```cangjie
public prop capacity: Int64
```

Functionality: Returns the capacity of this [ArrayList](collection_package_class.md#class-arraylistt).

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### prop first

```cangjie
public prop first: ?T
```

Functionality: Returns the first element of this [ArrayList](collection_package_class.md#class-arraylistt), or None if empty.

Type: ?T

### prop last

```cangjie
public prop last: ?T
```

Functionality: Returns the last element of this [ArrayList](collection_package_class.md#class-arraylistt), or None if empty.

Type: ?T

### init()

```cangjie
public init()
```

Functionality: Constructs an empty [ArrayList](collection_package_class.md#class-arraylistt) with a default capacity of 16.

### init(Collection\<T>)

```cangjie
public init(elements: Collection<T>)
```

Functionality: Constructs an [ArrayList](collection_package_class.md#class-arraylistt) containing all elements from the specified collection, in the order returned by the collection's iterator.

Parameters:

- elements: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T> - The input collection.

### init(Int64)

```cangjie
public init(capacity: Int64)
```

Functionality: Constructs an [ArrayList](collection_package_class.md#class-arraylistt) with the specified initial capacity.

Parameters:

- capacity: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The specified initial capacity.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if the parameter value is less than 0.

### init(Int64, (Int64) -> T)

```cangjie
public init(size: Int64, initElement: (Int64) -> T)
```

Functionality: Constructs an [ArrayList](collection_package_class.md#class-arraylistt) with the specified initial size and initialization function. The constructor sets the capacity of the [ArrayList](collection_package_class.md#class-arraylistt) based on the size parameter.

Parameters:

- size: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The number of initial elements.
- initElement: ([Int64](../../core/core_package_api/core_package_intrinsics.md#int64)) ->T - The initialization function.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if size is less than 0.

### static func of(Array\<T>)

```cangjie
public static func of(elements: Array<T>): ArrayList<T>
```

Functionality: Constructs an [ArrayList](collection_package_class.md#class-arraylistt) containing all elements from the specified array.

Parameters:

- elements: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - The input array.

Return Value:

- [ArrayList](#class-arraylistt)\<T> - An ArrayList of type T.

### func add(T)

```cangjie
public func add(element: T): Unit
```

Functionality: Appends the specified element to the end of this [ArrayList](collection_package_class.md#class-arraylistt).

Parameters:

- element: T - The element to insert, of type T.

Example:

See [ArrayList's add function](../collection_package_samples/sample_arraylist_add.md) for usage examples.

### func add(Collection\<T>)

```cangjie
public func add(all!: Collection<T>): Unit
```

Functionality: Appends all elements from the specified collection to the end of this [ArrayList](collection_package_class.md#class-arraylistt).

The function traverses the input collection in iterator order and inserts all elements to the end of this [ArrayList](collection_package_class.md#class-arraylistt).

Parameters:

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T> - The collection of elements to insert.

### func add(T, Int64)

```cangjie
public func add(element: T, at!: Int64): Unit
```

Functionality: Inserts the specified element at the specified position in this [ArrayList](collection_package_class.md#class-arraylistt).

Parameters:

- element: T - The element of type T to insert.
- at!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The target index for insertion.

Exceptions:

- [IndexOutOfBoundsException](../../core/core_package_api/core_package_exceptions.md#class-indexoutofboundsexception) - Thrown if the index is out of range.

Example:

See [ArrayList's add function](../collection_package_samples/sample_arraylist_add.md) for usage examples.

### func add(Collection\<T>, Int64)

```cangjie
public func add(all!: Collection<T>, at!: Int64): Unit
```

Functionality: Inserts all elements from the specified collection into this [ArrayList](collection_package_class.md#class-arraylistt), starting at the specified position.

The function traverses the input collection in iterator order and inserts all elements at the specified position, shifting existing elements to the right.

Parameters:

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T> - The collection of elements to insert.
- at!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The target index for insertion.

Exceptions:

- [IndexOutOfBoundsException](../../core/core_package_api/core_package_exceptions.md#class-indexoutofboundsexception) - Thrown if the index is out of range.

Example:

See [ArrayList's add function](../collection_package_samples/sample_arraylist_add.md) for usage examples.### func clear()

```cangjie
public func clear(): Unit
```

Function: Removes all elements from this [ArrayList](collection_package_class.md#class-arraylistt).

Example:

See usage example at [ArrayList's remove/clear/slice functions](../collection_package_samples/sample_arraylist_remove_clear_slice.md).

### func clone()

```cangjie
public func clone(): ArrayList<T>
```

Function: Returns a copy (shallow copy) of this [ArrayList](collection_package_class.md#class-arraylistt) instance.

Return Value:

- [ArrayList](collection_package_class.md#class-arraylistt)\<T> - Returns a new [ArrayList](collection_package_class.md#class-arraylistt)\<T>.

### func get(Int64)

```cangjie
public func get(index: Int64): ?T
```

Function: Returns the element at the specified position in this [ArrayList](collection_package_class.md#class-arraylistt).

Parameters:

- index: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The index of the element to return.

Return Value:

- ?T - Returns the element at the specified position. Returns None if the index is less than 0 or greater than or equal to the number of elements in the [ArrayList](collection_package_class.md#class-arraylistt).

Example:

See usage example at [ArrayList's get/set functions](../collection_package_samples/sample_arraylist_get_set.md).

### func getRawArray()

```cangjie
public unsafe func getRawArray(): Array<T>
```

Function: Returns the raw data of the [ArrayList](collection_package_class.md#class-arraylistt).

> **Note:**
>
> This is an unsafe interface and must be used within an unsafe context.
>
> Raw data refers to the underlying array implementation of [ArrayList](collection_package_class.md#class-arraylistt), whose size is greater than or equal to the number of elements in the [ArrayList](collection_package_class.md#class-arraylistt). Positions with indices greater than or equal to the size of the [ArrayList](collection_package_class.md#class-arraylistt) may contain uninitialized elements, and accessing them may result in undefined behavior.

Return Value:

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - The underlying raw data of the [ArrayList](collection_package_class.md#class-arraylistt).

### func isEmpty()

```cangjie
public func isEmpty(): Bool
```

Function: Determines whether the [ArrayList](collection_package_class.md#class-arraylistt) is empty.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if empty, otherwise returns `false`.

### func iterator()

```cangjie
public func iterator(): Iterator<T>
```

Function: Returns an iterator over the elements in this [ArrayList](collection_package_class.md#class-arraylistt).

Return Value:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - An iterator over the elements in the [ArrayList](collection_package_class.md#class-arraylistt).

### func remove(Int64)

```cangjie
public func remove(at!: Int64): T
```

Function: Removes the element at the specified position in this [ArrayList](collection_package_class.md#class-arraylistt).

Parameters:

- at!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The index of the element to remove.

Return Value:

- T - The removed element.

Exceptions:

- [IndexOutOfBoundsException](../../core/core_package_api/core_package_exceptions.md#class-indexoutofboundsexception) - Thrown when `at` is out of bounds.

Example:

See usage example at [ArrayList's remove/clear/slice functions](../collection_package_samples/sample_arraylist_remove_clear_slice.md).

### func remove(Range\<Int64>)

```cangjie
public func remove(range: Range<Int64>): Unit
```

Function: Removes all elements in this [ArrayList](collection_package_class.md#class-arraylistt) that are included in the specified [Range](../../core/core_package_api/core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet).

> **Note:**
>
> If the parameter `range` is a [Range](../../core/core_package_api/core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet) instance constructed using the [Range](../../core/core_package_api/core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet) constructor, when `hasEnd` is false, the `end` value does not take effect and is not affected by the `isClosed` value passed during construction. The array slice will include all elements up to the last element of the original array.

Parameters:

- range: [Range](../../core/core_package_api/core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet)\<[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)> - The range of elements to remove.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the [step](collection_package_function.md#func-steptint64) of `range` is not equal to 1.
- [IndexOutOfBoundsException](../../core/core_package_api/core_package_exceptions.md#class-indexoutofboundsexception) - Thrown when the `start` or `end` of `range` is less than 0, or when `end` is greater than the length of the [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt).

### func removeIf((T) -> Bool)

```cangjie
public func removeIf(predicate: (T) -> Bool): Unit
```

Function: Removes all elements from this [ArrayList](collection_package_class.md#class-arraylistt) that satisfy the given lambda expression or function.

Parameters:

- predicate: (T) ->[Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The condition to determine which elements to remove.

Exceptions:

- [ConcurrentModificationException](./collection_package_exception.md#class-concurrentmodificationexception) - Thrown when elements are added, removed, or modified within the `predicate` while iterating over the [ArrayList](collection_package_class.md#class-arraylistt).

### func reserve(Int64)

```cangjie
public func reserve(additional: Int64): Unit
```

Function: Increases the capacity of this [ArrayList](collection_package_class.md#class-arraylistt) instance.

Expands the [ArrayList](collection_package_class.md#class-arraylistt) by `additional` size. No expansion occurs if `additional` is less than or equal to zero. If the remaining capacity of the [ArrayList](collection_package_class.md#class-arraylistt) is greater than or equal to `additional`, no expansion occurs. If the remaining capacity is less than `additional`, the expansion size is the maximum of (the original capacity multiplied by 1.5 and rounded down) and (`additional` + used capacity).

Parameters:

- additional: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The additional size to expand.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when `additional` + used capacity exceeds `Int64.Max`.

### func reverse()

```cangjie
public func reverse(): Unit
```

Function: Reverses the order of elements in this [ArrayList](collection_package_class.md#class-arraylistt).

### func slice(Range\<Int64>)

```cangjie
public func slice(range: Range<Int64>): ArrayList<T>
```

Function: Returns an [ArrayList](collection_package_class.md#class-arraylistt)\<T> corresponding to the indices specified by the `range` parameter.

> **Note:**
>
> If the parameter `range` is a [Range](../../core/core_package_api/core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet) instance constructed using the [Range](../../core/core_package_api/core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet) constructor, the following behavior applies:
>
> 1. The value of `start` is exactly the value passed to the constructor, unaffected by the `hasStart` value passed during construction.
> 2. When `hasEnd` is false, the `end` value does not take effect and is not affected by the `isClosed` value passed during construction. The array slice will include all elements up to the last element of the original array.

Parameters:

- range: [Range](../../core/core_package_api/core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet)\<[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)> - The range to slice.

Return Value:

- [ArrayList](collection_package_class.md#class-arraylistt)\<T> - The sliced array.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the [step](collection_package_function.md#func-steptint64) of `range` is not equal to 1.
- [IndexOutOfBoundsException](../../core/core_package_api/core_package_exceptions.md#class-indexoutofboundsexception) - Thrown when `range` is invalid.

Example:

See usage example at [ArrayList's remove/clear/slice functions](../collection_package_samples/sample_arraylist_remove_clear_slice.md).

### func sortBy((T, T) -> Ordering) <sup>(deprecated)</sup>

```cangjie
public func sortBy(comparator!: (T, T) -> Ordering): Unit
```

Function: Performs an unstable sort on the elements in the array.

Using the provided comparison function, the array can be custom-sorted based on the returned [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering) type result. For `comparator: (t1: T, t2: T) -> [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering)`, if the return value is [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).GT, `t1` will appear after `t2` after sorting; if the return value is [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).LT, `t1` will appear before `t2`; if the return value is [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).EQ and the sort is stable, `t1` will appear before `t2`; if the return value is [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).EQ and the sort is unstable, the order of `t1` and `t2` is undefined.

> **Note:**
>
> This function will be deprecated in future versions. Use [sort](../../sort/sort_package_api/sort_package_funcs.md#func-sorttlistt-bool-bool-where-t--comparablet) instead.

Parameters:

- comparator!: (T, T) -> [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering) - A function of type (T, T) -> [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).

### func sortBy(Bool, (T, T) -> Ordering) <sup>(deprecated)</sup>

```cangjie
public func sortBy(stable!: Bool, comparator!: (T, T) -> Ordering): Unit
```

Function: Performs a sort on the elements in the array.

Using the provided comparison function, the array can be custom-sorted based on the returned [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering) type result. For `comparator: (t1: T, t2: T) -> [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering)`, if the return value is [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).GT, `t1` will appear after `t2` after sorting; if the return value is [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).LT, `t1` will appear before `t2`; if the return value is [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).EQ and the sort is stable, `t1` will appear before `t2`; if the return value is [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).EQ and the sort is unstable, the order of `t1` and `t2` is undefined.

> **Note:**
>
> This function will be deprecated in future versions. Use [sort](../../sort/sort_package_api/sort_package_funcs.md#func-sorttlistt-bool-bool-where-t--comparablet) instead.

Parameters:

- stable!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether to use a stable sort.
- comparator!: (T, T) -> [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering) - A function of type (T, T) -> [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).

### func toArray()

```cangjie
public func toArray(): Array<T>
```

Function: Returns an array containing all elements in this list in proper sequence.

Return Value:

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - An array of type T.

### operator func \[](Int64)

```cangjie
public operator func [](index: Int64): T
```

Function: Operator overload - get.

Parameters:

- index: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The index for the get operation.

Return Value:

- T - The value of the element at the specified index.

Exceptions:

- [IndexOutOfBoundsException](../../core/core_package_api/core_package_exceptions.md#class-indexoutofboundsexception) - Thrown when `index` is out of bounds.

### operator func \[](Int64, T)

```cangjie
public operator func [](index: Int64, value!: T): Unit
```

Function: Operator overload - replaces the element at the specified position in this list with the specified element using the subscript operator.

Parameters:

- index: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The index to set.
- value!: T - The value of type T to set.

Exceptions:

- [IndexOutOfBoundsException](../../core/core_package_api/core_package_exceptions.md#class-indexoutofboundsexception) - Thrown when `index` is out of bounds.

### operator func \[](Range\<Int64>)

```cangjie
public operator func [](range: Range<Int64>): ArrayList<T>
```

Function: Operator overload - slice.

> **Note:**
>
> - If the parameter `range` is a [Range](../../core/core_package_api/core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet) instance constructed using the [Range](../../core/core_package_api/core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet) constructor, the following behavior applies:
>     - The value of `start` is exactly the value passed to the constructor, unaffected by the `hasStart` value passed during construction.
>     - When `hasEnd` is false, the `end` value does not take effect and is not affected by the `isClosed` value passed during construction. The array slice will include all elements up to the last element of the original array.
>
> - The [ArrayList](collection_package_class.md#class-arraylistt) returned by the slice operation is a completely new object with no reference relationship to the original [ArrayList](collection_package_class.md#class-arraylistt).

Parameters:

- range: [Range](../../core/core_package_api/core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet)\<[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)> - The range to slice.

Return Value:

- [ArrayList](collection_package_class.md#class-arraylistt)\<T> - The sliced array.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the [step](collection_package_function.md#func-steptint64) of `range` is not equal to 1.
- [IndexOutOfBoundsException](../../core/core_package_api/core_package_exceptions.md#class-indexoutofboundsexception) - Thrown when `range` is invalid.

### extend\<T> ArrayList\<T> <: Equatable\<ArrayList\<T>> where T <: Equatable\<T>

```cangjie
extend<T> ArrayList<T> <: Equatable<ArrayList<T>> where T <: Equatable<T>
```

Function: Extends the [ArrayList](./collection_package_class.md#class-arraylistt)\<T> type with the [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[ArrayList](./collection_package_class.md#class-arraylistt)\<T>> interface, supporting equality comparison.

Parent Types:

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[ArrayList](#class-arraylistt)\<T>>

#### operator func ==(ArrayList\<T>)

```cangjie
public operator func ==(that: ArrayList<T>): Bool
```

Function: Determines whether the current instance```markdown
## class ArrayQueue\<T>

```cangjie
public class ArrayQueue<T> <: Queue<T> {
    public init()
    public init(capacity: Int64)
}
```

Function: A circular queue data structure implemented based on arrays.

Parent Types:

- [Queue](./collection_package_interface.md#interface-queuet)\<T>

### prop capacity

```cangjie
public prop capacity: Int64
```

Function: Gets the capacity of this queue.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### prop size

```cangjie
public prop size: Int64
```

Function: Returns the number of elements in this queue.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### init()

```cangjie
public init()
```

Function: Constructs an empty queue with default capacity of 8.

### init(Int64)

```cangjie
public init(capacity: Int64)
```

Function: Constructs a queue with specified capacity. When capacity is less than the default capacity of 8, the initial capacity of [ArrayQueue](#class-arrayqueuet) will be 8.

Parameters:

- capacity: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Specified initial capacity.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws exception if parameter is less than 0.

### func add(T)

```cangjie
public func add(element: T): Unit
```

Function: Inserts an element at the tail of this queue.

Parameters:

- element: T - The element to be inserted into this deque.

### func clear()

```cangjie
public func clear(): Unit
```

Function: Clears all elements in this queue.

### func iterator()

```cangjie
public func iterator(): Iterator<T>
```

Function: Gets an iterator for elements in this queue, in front-to-back order.

Return Value:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - Element iterator.

### func isEmpty()

```cangjie
public func isEmpty(): Bool
```

Function: Determines whether this queue is empty.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if empty, otherwise `false`.

### func peek()

```cangjie
public func peek():?T
```

Function: Views the head element of this queue without removing it.

Return Value:

- ?T - The head element of the queue, returns `None` if queue is empty.

### func remove()

```cangjie
public func remove(): ?T
```

Function: Removes and returns the head element of this queue, returns `None` if queue is empty.

Return Value:

- ?T - The removed head element.

### func reserve(Int64)

```cangjie
public func reserve(additional: Int64): Unit
```

Function: Increases the capacity of this queue.

Expands the queue by additional size. No expansion occurs when:
1. additional ≤ 0
2. Remaining capacity ≥ additional

When remaining capacity < additional, expansion occurs to the maximum value between:
1. Original capacity × 1.5 (rounded down)
2. additional + used capacity

Parameters:

- additional: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The size to expand.

### func toArray()

```cangjie
public func toArray(): Array<T>
```

Function: Returns an array containing all elements in this queue in front-to-back order.

Return Value:

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - Array of type T.

### extend\<T> ArrayQueue\<T> <: ToString where T <: ToString

```cangjie
extend<T> ArrayQueue<T> <: ToString where T <: ToString
```

Function: Extends [ArrayQueue](./collection_package_class.md#class-arrayqueuet)\<T> with [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring) interface, supporting string conversion.

Parent Types:

- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

#### func toString()

```cangjie
public func toString(): String
```

Function: Gets string representation of current [ArrayQueue](./collection_package_class.md#class-arrayqueuet)\<T> instance.

The string contains string representations of each element in the deque in front-to-back order, formatted as: "[elem1, elem2, elem3]".

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The converted string.

## class ArrayStack\<T>

```cangjie
public class ArrayStack<T> <: Stack<T> {
    public init(capacity: Int64)
    public init()
}
```

Function: [ArrayStack](#class-arraystackt) is a stack [Stack](./collection_package_interface.md#interface-stackt) data structure implemented based on array [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt). It uses an array to store stack elements with a pointer indicating the top position.

[ArrayStack](#class-arraystackt) only supports Last-In-First-Out (LIFO) operations at the head, and automatically expands as needed.

Parent Types:

- [Stack](./collection_package_interface.md#interface-stackt)\<T>

### prop capacity

```cangjie
public prop capacity: Int64
```

Function: The capacity of the stack.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### prop size

```cangjie
public prop size: Int64
```

Function: The number of elements in the stack.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### func init()

```cangjie
public init()
```

Function: Constructs an empty [ArrayStack](#class-arraystackt) with default capacity of 8.

### func init(Int64)

```cangjie
public init(capacity: Int64)
```

Function: Constructs an empty [ArrayStack](#class-arraystackt) with specified capacity. When capacity < 8, initial capacity defaults to 8.

Parameters:

- capacity: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Initial capacity size.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws when input is negative.

### func add(T)

```cangjie
public func add(element: T): Unit
```

Function: Adds an element at the top of the stack.

Parameters:

- element: T - The element to add.

### func clear()

```cangjie
public func clear(): Unit
```

Function: Clears current [ArrayStack](#class-arraystackt).

### func isEmpty()

```cangjie
public func isEmpty(): Bool
```

Function: Determines whether this [ArrayStack](#class-arraystackt) is empty.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if empty, otherwise false.

### func iterator()

```cangjie
public func iterator(): Iterator<T>
```

Function: Returns an iterator for elements in this [ArrayStack](#class-arraystackt) in pop order.

Return Value:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - Iterator for stack elements.

### func peek()

```cangjie
public func peek(): ?T
```

Function: Gets the top element without popping it. Returns `None` if stack is empty.

Return Value:

- ?T - The top element.

### func remove()

```cangjie
public func remove(): ?T
```

Function: Pops and returns the top element. Returns `None` if stack is empty.

Return Value:

- ?T - The removed top element.

### func reserve(Int64)

```cangjie
public func reserve(additional: Int64): Unit
```

Function: Expands current [ArrayStack](#class-arraystackt) capacity. No expansion occurs when:
1. additional ≤ 0
2. Remaining space ≥ additional

Otherwise expands to size + additional.

Parameters:

- additional: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The size to expand.

### func toArray()

```cangjie
public func toArray(): Array<T>
```

Function: Returns an array containing stack elements in pop order.

Return Value:

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - Array of type T.

### extend\<T> ArrayStack\<T> <: ToString where T <: ToString

```cangjie
extend<T> ArrayStack<T> <: ToString where T <: ToString
```

Function: Extends ArrayStack with [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring) interface for string conversion.

Parent Types:

- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

#### func toString()

```cangjie
public func toString(): String
```

Function: Gets string representation of current [ArrayStack](./collection_package_class.md#class-arraystackt)\<T> instance.

The string contains string representations of each element in back-to-front order, formatted as: "[elem1, elem2, elem3]".

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - String representation of current stack.

## class HashMapIterator\<K, V> where K <: Hashable & Equatable\<K>

```cangjie
public class HashMapIterator<K, V> <: Iterator<(K, V)> where K <: Hashable & Equatable<K> {
    public init(map: HashMap<K, V>)
}
```

Function: This class mainly implements iterator functionality for [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek).

Parent Types:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<(K, V)>

### init(HashMap\<K, V>)

```cangjie
public init(map: HashMap<K, V>)
```

Function: Creates [HashMapIterator](collection_package_class.md#class-hashmapiteratork-v-where-k--hashable--equatablek)\<K, V> instance.

Parameters:

- [map](collection_package_function.md#func-mapt-rt---r): [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek)\<K, V> - Input [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek)\<K, V>.

### func next()

```cangjie
public func next(): ?(K, V)
```

Function: Returns the next element in the iterator.

Return Value:

- ?(K, V) - The next element, wrapped in [Option](../../core/core_package_api/core_package_enums.md#enum-optiont).

Exceptions:

- [ConcurrentModificationException](collection_package_exception.md#class-concurrentmodificationexception) - Throws when detecting unsynchronized concurrent modifications.

### func remove()

```cangjie
public func remove(): Option<(K, V)>
```

Function: Removes the element last returned by next(). Can only be called once per next() call.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<(K, V)> - The removed element.

Exceptions:

- [ConcurrentModificationException](collection_package_exception.md#class-concurrentmodificationexception) - Throws when detecting unsynchronized concurrent modifications.
```## class HashMap\<K, V> where K <: Hashable & Equatable\<K>

```cangjie
public class HashMap<K, V> <: Map<K, V> where K <: Hashable & Equatable<K> {
    public init()
    public init(elements: Array<(K, V)>)
    public init(elements: Collection<(K, V)>)
    public init(capacity: Int64)
    public init(size: Int64, initElement: (Int64) -> (K, V))
}
```

Functionality: A hash table implementation of the [Map](collection_package_interface.md#interface-mapk-v) interface.

A hash table is a commonly used data structure that enables fast lookup, insertion, and deletion of data. The basic principle of a hash table is to map data to an array, which is called the hash table. Each data element has a corresponding hash value that determines its position in the hash table.

Hash tables are characterized by fast lookup, insertion, and deletion operations, typically with O(1) time complexity. Since the underlying array size is dynamic, hash tables do not guarantee immutable element ordering.

Parent Types:

- [Map](collection_package_interface.md#interface-mapk-v)\<K, V>

### prop capacity

```cangjie
public prop capacity: Int64
```

Functionality: Returns the capacity of the [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek).

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The capacity of the [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek).

### prop size

```cangjie
public prop size: Int64
```

Functionality: Returns the number of key-value pairs.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### init()

```cangjie
public init()
```

Functionality: Constructs a [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) with a default initial capacity of 16 and an empty default load factor.

### init(Array\<(K, V)>)

```cangjie
public init(elements: Array<(K, V)>)
```

Functionality: Constructs a [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) from the given array of key-value pairs.

This constructor sets the capacity of the [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) based on the size of the input array. Since [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) internally does not allow duplicate keys, if the [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt) contains duplicate keys, the later key-value pairs will overwrite the earlier ones according to the iterator order.

Parameters:

- elements: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<(K, V)> - The array of key-value pairs used to initialize this [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek).

### init(Collection\<(K, V)>)

```cangjie
public init(elements: Collection<(K, V)>)
```

Functionality: Constructs a [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) from the given collection of key-value pairs.

This constructor sets the capacity of the [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) based on the size of the input collection. Since [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) internally does not allow duplicate keys, if the [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt) contains duplicate keys, the later key-value pairs will overwrite the earlier ones according to the iterator order.

Parameters:

- elements: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<(K, V)> - The collection of key-value pairs used to initialize this [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek).

### init(Int64)

```cangjie
public init(capacity: Int64)
```

Functionality: Constructs a [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) with the specified initial capacity.

Parameters:

- capacity: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The initial capacity size.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if capacity is less than 0.

### init(Int64, (Int64) -> (K, V))

```cangjie
public init(size: Int64, initElement: (Int64) -> (K, V))
```

Functionality: Constructs a [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) using the specified size and a function rule.

The capacity of the constructed [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) is influenced by the size parameter. Since [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) internally does not allow duplicate keys, if the initElement function generates duplicate keys, the later key-value pairs will overwrite the earlier ones.

Parameters:

- size: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The function rule used to initialize this [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek).
- initElement: ([Int64](../../core/core_package_api/core_package_intrinsics.md#int64)) -> (K, V) - The function rule used to initialize this [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek).

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if size is less than 0.

### func add(K, V)

```cangjie
public func add(key: K, value: V): Option<V>
```

Functionality: Inserts a key-value pair into the [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek).

For keys already present in the [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek), the value will be replaced with the new value, and the old value will be returned.

Parameters:

- key: K - The key to insert.
- value: V - The value to assign.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<V> - If the key existed before assignment, the old value is wrapped in an [Option](../../core/core_package_api/core_package_enums.md#enum-optiont); otherwise, returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<V>.None.

Example:

See [HashMap's get/add/contains functions](../collection_package_samples/sample_hashmap_get_add_contains.md) for usage examples.

### func add(Collection\<(K, V)>)

```cangjie
public func add(all!: Collection<(K, V)>): Unit
```

Functionality: Inserts a new collection of key-value pairs into the [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) according to the iterator order of elements.

For keys already present in the [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek), the values will be replaced with the new values.

Parameters:

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<(K, V)> - The collection of key-value pairs to add to the [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek).

Example:

See [HashMap's add/remove/clear functions](../collection_package_samples/sample_hashmap_add_remove_clear.md) for usage examples.

### func clear()

```cangjie
public func clear(): Unit
```

Functionality: Clears all key-value pairs.

Example:

See [HashMap's add/remove/clear functions](../collection_package_samples/sample_hashmap_add_remove_clear.md) for usage examples.

### func clone()

```cangjie
public func clone(): HashMap<K, V>
```

Functionality: Clones the [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek).

Return Value:

- [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek)\<K, V> - Returns a [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek).

### func contains(K)

```cangjie
public func contains(key: K): Bool
```

Functionality: Checks whether a mapping exists for the specified key.

Parameters:

- key: K - The key to check.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if the key exists; otherwise, returns false.

Example:

See [HashMap's get/add/contains functions](../collection_package_samples/sample_hashmap_get_add_contains.md) for usage examples.

### func contains(Collection\<K>)

```cangjie
public func contains(all!: Collection<K>): Bool
```

Functionality: Checks whether mappings exist for all keys in the specified collection.

Parameters:

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<K> - The collection of keys to check.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if all keys are contained; otherwise, returns false.

### func entryView(K)

```cangjie
public func entryView(key: K): MapEntryView<K, V>
```

Functionality: Returns an empty reference view if the key does not exist. If the key exists, returns a reference view of the corresponding element.

Parameters:

- key: K - The key of the key-value pair to add.

Return Value:

- [MapEntryView](./collection_package_interface.md#interface-mapentryviewk-v)\<K, V> - A reference view.

### func get(K)

```cangjie
public func get(key: K): ?V
```

Functionality: Returns the value to which the specified key is mapped, or [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<V>.None if the [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) contains no mapping for the key.

Parameters:

- key: K - The input key.

Return Value:

- ?V - The value associated with the key, wrapped in an [Option](../../core/core_package_api/core_package_enums.md#enum-optiont).

Example:

See [HashMap's get/add/contains functions](../collection_package_samples/sample_hashmap_get_add_contains.md) for usage examples.

### func isEmpty()

```cangjie
public func isEmpty(): Bool
```

Functionality: Checks whether the [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) is empty. Returns true if it is; otherwise, returns false.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether the [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) is empty.

### func iterator()

```cangjie
public func iterator(): HashMapIterator<K, V>
```

Functionality: Returns an iterator for the HashMap.

Return Value:

- [HashMapIterator](collection_package_class.md#class-hashmapiteratork-v-where-k--hashable--equatablek)\<K, V> - Returns an iterator for the [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek).

### func keys()

```cangjie
public func keys(): EquatableCollection<K>
```

Functionality: Returns all keys in the [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek), storing them in a Keys container.

Return Value:

- [EquatableCollection](collection_package_interface.md#interface-equatablecollectiont)\<K> - A container holding all returned keys.

### func remove(Collection\<K>)

```cangjie
public func remove(all!: Collection<K>): Unit
```

Functionality: Removes the mappings for the specified keys in the collection from this [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) (if they exist).

Parameters:

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<K> - The collection of keys to remove.

### func remove(K)

```cangjie
public func remove(key: K): Option<V>
```

Functionality: Removes the mapping for the specified key from this [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) (if it exists).

Parameters:

- key: K - The key to remove.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<V> - The value associated with the key removed from the [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek), wrapped in an [Option](../../core/core_package_api/core_package_enums.md#enum-optiont). If the key does not exist in the [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek), returns None.

Example:

See [HashMap's add/remove/clear functions](../collection_package_samples/sample_hashmap_add_remove_clear.md) for usage examples.

### func removeIf((K, V) -> Bool)

```cangjie
public func removeIf(predicate: (K, V) -> Bool): Unit
```

Functionality: Takes a lambda expression and removes key-value pairs that satisfy the condition.

This function traverses the entire [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek), so all key-value pairs where `predicate(K, V) == true` will be removed.

Parameters:

- predicate: (K, V) ->[Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - A lambda expression used for evaluation.

Exceptions:

- [ConcurrentModificationException](./collection_package_exception.md#class-concurrentmodificationexception) - Thrown if `predicate` adds, removes, or modifies key-value pairs within the [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek).

### func reserve(Int64)

```cangjie
public func reserve(additional: Int64): Unit
```

Functionality: Expands the current [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek).

Expands the [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) by the additional size. No expansion occurs if additional is less than or equal to zero. No expansion occurs if the remaining capacity of the [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) is greater than or equal to additional. If the remaining capacity is less than additional, the expansion size is the maximum of (1.5 times the original capacity, rounded down) and (additional + used capacity).

Parameters:

- additional: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The size to expand by.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown if additional + used capacity exceeds Int64.Max.

### func toArray()

```cangjie
public func toArray(): Array<(K, V)>
```

Functionality: Constructs and returns an array containing all key-value pairs in the [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek).

Return Value:

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<(K, V)> - An array containing all key-value pairs in the container.

### func values()

```cangjie
public func values(): Collection<V>
```

Functionality: Returns all values in the [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek), storing them in a Values container.

Return Value:

- [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<V> - A container holding all returned values.

### operator func \[](K, V)

```cangjie
public operator func [](key: K, value!: V): Unit
```

Functionality: Operator overload for the add method. If the key exists, the new value overwrites the old value. If the key does not exist, the key-value pair is added.

Parameters:

- key: K - The key to evaluate.
- value!: V - The value to set.

### operator func \[](K)

```cangjie
public operator func [](key: K): V
```

Functionality: Operator overload for the get method. If the key exists, returns the corresponding value.

Parameters:

- key: K - The key to evaluate.

Return Value:

- V - The value associated with the key.

Exceptions:

- [NoneValueException](../../core/core_package_api/core_package_exceptions.md#class## class HashSet\<T> where T <: Hashable & Equatable\<T>

```cangjie
public class HashSet<T> <: Set<T> where T <: Hashable & Equatable<T> {
    public init()
    public init(elements: Collection<T>)
    public init(elements: Array<T>)
    public init(capacity: Int64)
    public init(size: Int64, initElement: (Int64) -> T)
}
```

Function: An implementation of the [Set](collection_package_interface.md#interface-sett) interface based on [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek).

Elements in [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) are unordered and do not allow duplicates. When adding elements to [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet), their positions in the hash table are determined by their hash values.

> **Note:**
>
> [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) is implemented based on [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek), so its capacity, memory layout, and time performance are identical to [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek).

Parent Types:

- [Set](collection_package_interface.md#interface-sett)\<T>

### prop size

```cangjie
public prop size: Int64
```

Function: Returns the number of elements in this [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet).

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### init(Int64, (Int64) -> T)

```cangjie
public init(size: Int64, initElement: (Int64) -> T)
```

Function: Constructs a [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) using the given size and initialization function. The capacity of the constructed [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) is influenced by the size parameter.

Parameters:

- size: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The number of elements in the initialization function.
- initElement: ([Int64](../../core/core_package_api/core_package_intrinsics.md#int64)) ->T - The initialization function rule.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if size is less than 0.

### init()

```cangjie
public init()
```

Function: Constructs an empty [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) with an initial capacity of 16.

### init(Array\<T>)

```cangjie
public init(elements: Array<T>)
```

Function: Constructs a [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) using the given array. The constructor sets the capacity of the [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) based on the size of the input array.

Parameters:

- elements: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - The array used to initialize the [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet).

### init(Collection\<T>)

```cangjie
public init(elements: Collection<T>)
```

Function: Constructs a [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) using the given collection. The constructor sets the capacity of the [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) based on the size of the input collection.

Parameters:

- elements: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T> - The collection used to initialize the [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet).

### init(Int64)

```cangjie
public init(capacity: Int64)
```

Function: Constructs a [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) with the given capacity.

Parameters:

- capacity: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The initial capacity size.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if capacity is less than 0.

### func add(T)

```cangjie
public func add(element: T): Bool
```

Function: Adds the specified element to the [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet). If the element already exists, the addition fails.

Parameters:

- element: T - The specified element.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if the addition is successful; otherwise, returns false.

Example:

See [HashSet's add/iterator/remove functions](../collection_package_samples/sample_hashset_add_iterator_remove.md) for usage examples.

### func add(Collection\<T>)

```cangjie
public func add(all!: Collection<T>): Unit
```

Function: Adds all elements from the given [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont) to this [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet). Existing elements are not added.

Parameters:

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T> - The collection of elements to be added.

### prop capacity

```cangjie
public prop capacity: Int64
```

Function: Returns the internal array capacity of this [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet).

> **Note:**
>
> The capacity size may not equal the size of the [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet).

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The internal array capacity of this [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet).

### func clear()

```cangjie
public func clear(): Unit
```

Function: Removes all elements from this [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet).

### func clone()

```cangjie
public func clone(): HashSet<T>
```

Function: Clones the [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet).

Return Value:

- [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet)\<T> - The cloned [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet).

### func contains(T)

```cangjie
public func contains(element: T): Bool
```

Function: Checks if the [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) contains the specified element.

Parameters:

- element: T - The specified element.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if the element is contained; otherwise, returns false.

### func contains(Collection\<T>)

```cangjie
public func contains(all!: Collection<T>): Bool
```

Function: Checks if the [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) contains all elements from the specified [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont).

Parameters:

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T> - The specified collection of elements.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if this [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) contains all elements from the [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont); otherwise, returns false.

### func isEmpty()

```cangjie
public func isEmpty(): Bool
```

Function: Checks if the [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) is empty.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if empty; otherwise, returns false.

### func iterator()

```cangjie
public func iterator(): Iterator<T>
```

Function: Returns an iterator for this [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet).

Return Value:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - The iterator for this [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet).

Example:

See [HashSet's add/iterator/remove functions](../collection_package_samples/sample_hashset_add_iterator_remove.md) for usage examples.

### func remove(T)

```cangjie
public func remove(element: T): Bool
```

Function: Removes the specified element from this [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) if it exists.

Parameters:

- element: T - The element to be removed.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if the removal is successful; otherwise, returns false.

Example:

See [HashSet's add/iterator/remove functions](../collection_package_samples/sample_hashset_add_iterator_remove.md) for usage examples.

### func remove(Collection\<T>)

```cangjie
public func remove(all!: Collection<T>): Unit
```

Function: Removes all elements from this [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) that are also contained in the specified [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont).

Parameters:

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T> - The collection of elements to be removed from this [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet).

### func removeIf((T) -> Bool)

```cangjie
public func removeIf(predicate: (T) -> Bool): Unit
```

Function: Takes a lambda expression and removes elements that satisfy the `true` condition.

Parameters:

- predicate: (T) ->[Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The condition for determining whether to remove an element.

Exceptions:

- [ConcurrentModificationException](./collection_package_exception.md#class-concurrentmodificationexception) - Thrown when elements are added, removed, or modified within the `predicate` lambda.

### func reserve(Int64)

```cangjie
public func reserve(additional: Int64): Unit
```

Function: Expands the [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) by the specified additional size. No expansion occurs if additional is less than or equal to zero. If the remaining capacity of the [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) is greater than or equal to additional, no expansion occurs. If the remaining capacity is less than additional, the expansion size is the maximum of (original capacity * 1.5 rounded down) and (additional + used capacity).

Parameters:

- additional: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The size to expand by.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown if additional + used capacity exceeds Int64.Max.

### func retain(Set\<T>)

```cangjie
public func retain(all!: Set<T>): Unit
```

Function: Retains only the elements in this [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) that are also contained in the specified [Set](collection_package_interface.md#interface-sett).

Parameters:

- all!: [Set](collection_package_interface.md#interface-sett)\<T> - The set of elements to retain.

### func subsetOf(ReadOnlySet\<T>)

```cangjie
public func subsetOf(other: ReadOnlySet<T>): Bool
```

Function: Checks if this set is a subset of the specified [ReadOnlySet](collection_package_interface.md#interface-readonlysett).

Parameters:

- other: [ReadOnlySet](collection_package_interface.md#interface-readonlysett)\<T> - The set to check against.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if this [Set](collection_package_interface.md#interface-sett) is a subset of the specified [ReadOnlySet](collection_package_interface.md#interface-readonlysett); otherwise, returns false.

### func toArray()

```cangjie
public func toArray(): Array<T>
```

Function: Returns an array containing all elements in the container.

Return Value:

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - An array of type T.

### operator func &(ReadOnlySet\<T>)

```cangjie
public operator func &(other: ReadOnlySet<T>): HashSet<T>
```

Function: Returns a new set containing the intersection of two sets.

Parameters:

- other: [ReadOnlySet](collection_package_interface.md#interface-readonlysett)\<T> - The input set.

Return Value:

- [HashSet](./collection_package_class.md#class-hashsett-where-t--hashable--equatablet)\<T> - A set of type T.

### operator func |(ReadOnlySet\<T>)

```cangjie
public operator func |(other: ReadOnlySet<T>): HashSet<T>
```

Function: Returns a new set containing the union of two sets.

Parameters:

- other: [ReadOnlySet](collection_package_interface.md#interface-readonlysett)\<T> - The input set.

Return Value:

- [HashSet](./collection_package_class.md#class-hashsett-where-t--hashable--equatablet)\<T> - A set of type T.

### operator func -(ReadOnlySet\<T>)

```cangjie
public operator func -(other: ReadOnlySet<T>): HashSet<T>
```

Function: Returns a new set containing the difference of two sets.

Parameters:

- other: [ReadOnlySet](collection_package_interface.md#interface-readonlysett)\<T> - The input set.

Return Value:

- [HashSet](./collection_package_class.md#class-hashsett-where-t--hashable--equatablet)\<T> - A set of type T.

### extend\<T> HashSet\<T> <: Equatable\<HashSet\<T>>

```cangjie
extend<T> HashSet<T> <: Equatable<HashSet<T>>
```

Function: Extends the [HashSet](./collection_package_class.md#class-hashsett-where-t--hashable--equatablet)\<T> type with the [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[HashSet](./collection_package_class.md#class-hashsett-where-t--hashable--equatablet)\<T>> interface, supporting equality operations.

Parent Types:

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[HashSet](./collection_package_class.md#class-hashsett-where-t--hashable--equatablet)\<T>>

#### operator func ==(HashSet\<T>)

```cangjie
public operator func ==(that: HashSet<T>): Bool
```

Function: Checks if the current instance is equal to the specified [HashSet](./collection_package_class.md#class-hashsett-where-t--hashable--equatablet)\<T> instance.

Two [HashSet](./collection_package_class.md#class-hashsett-where-t--hashable--equatablet)\<T> instances are equal if they contain identical elements.

Parameters:

- that: [HashSet](./collection_package_class.md#class-hashsett-where-t--hashable--equatablet)\<T> - The instance to compare with.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if equal; otherwise, returns false.

#### operator func !=(HashSet\<T>)

```cangjie
public operator func !=(that: HashSet<T>): Bool
```

Function: Checks if the current instance is not equal to the specified [HashSet](./collection_package_class.md#class-hashsett-where-t--hashable--equatablet)\<T> instance.

Parameters:

- that: [HashSet](./collection_package_class.md#class-hashsett-where-t--hashable--equatablet)\<T> - The instance to compare with.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if not equal; otherwise, returns false.

### extend\<T> HashSet\<T> <: ToString where T <: ToString

```cangjie
extend<T> HashSet<T> <: ToString where T## class LinkedListNode\<T>

```cangjie
public class LinkedListNode<T>
```

Function: [LinkedListNode](collection_package_class.md#class-linkedlistnodet) is a node on [LinkedList](collection_package_class.md#class-linkedlistt).

Through [LinkedListNode](collection_package_class.md#class-linkedlistnodet), you can perform forward and backward traversal operations on [LinkedList](collection_package_class.md#class-linkedlistt), as well as access and modify element values.

[LinkedListNode](collection_package_class.md#class-linkedlistnodet) can only be obtained via the corresponding [LinkedList](collection_package_class.md#class-linkedlistt)'s 'nodeAt', 'firstNode', or 'lastNode' methods. When [LinkedList](collection_package_class.md#class-linkedlistt) removes the corresponding node, it results in a dangling node. Any operation on a dangling node will throw an '[IllegalStateException](../../core/core_package_api/core_package_exceptions.md#class-illegalstateexception)' exception.

### prop next

```cangjie
public prop next: Option<LinkedListNode<T>>
```

Function: Gets the next node of the current node, returns None if there isn't one.

Type: [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[LinkedListNode](collection_package_class.md#class-linkedlistnodet)\<T>>

Exceptions:

- [IllegalStateException](../../core/core_package_api/core_package_exceptions.md#class-illegalstateexception) - Thrown if the node does not belong to any linked list instance.

### prop prev

```cangjie
public prop prev: Option<LinkedListNode<T>>
```

Function: Gets the previous node of the current node, returns None if there isn't one.

Type: [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[LinkedListNode](collection_package_class.md#class-linkedlistnodet)\<T>>

Exceptions:

- [IllegalStateException](../../core/core_package_api/core_package_exceptions.md#class-illegalstateexception) - Thrown if the node does not belong to any linked list instance.

### prop value

```cangjie
public mut prop value: T
```

Function: Gets or modifies the element's value.

Type: T

Exceptions:

- [IllegalStateException](../../core/core_package_api/core_package_exceptions.md#class-illegalstateexception) - Thrown if the node does not belong to any linked list instance.

## class LinkedList\<T>

```cangjie
public class LinkedList<T> <: Collection<T> {
    public init()
    public init(elements: Collection<T>)
    public init(elements: Array<T>)
    public init(size: Int64, initElement: (Int64)-> T)
}
```

Function: Implements a doubly linked list data structure.

A doubly linked list is a common data structure consisting of a series of nodes, where each node contains two pointers: one pointing to the previous node and another pointing to the next node. This structure allows bidirectional traversal from any node, either starting from the head node moving forward or from the tail node moving backward.

[LinkedList](collection_package_class.md#class-linkedlistt) does not support concurrent operations, and modifications to elements in the collection will not invalidate iterators. Only adding or removing elements will invalidate iterators.

Parent Types:

- [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T>

### prop first

```cangjie
public prop first: ?T
```

Function: The value of the first element in the linked list, returns None if the list is empty.

Type: ?T

### prop firstNode

```cangjie
public prop firstNode: ?LinkedListNode<T>
```

Function: Gets the node of the first element in the linked list.

Type: ?[LinkedListNode](collection_package_class.md#class-linkedlistnodet)\<T>

### prop last

```cangjie
public prop last: ?T
```

Function: The value of the last element in the linked list, returns None if the list is empty.

Type: ?T

### prop lastNode

```cangjie
public prop lastNode: ?LinkedListNode<T>
```

Function: Gets the node of the last element in the linked list.

Type: ?[LinkedListNode](collection_package_class.md#class-linkedlistnodet)\<T>

### prop size

```cangjie
public prop size: Int64
```

Function: The number of elements in the linked list.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### init()

```cangjie
public init()
```

Function: Constructs an empty linked list.

### init(Array\<T>)

```cangjie
public init(elements: Array<T>)
```

Function: Constructs a [LinkedList](collection_package_class.md#class-linkedlistt) instance containing the specified array elements in traversal order.

Parameters:

- elements: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - The array of elements to be added to this linked list.

### init(Collection\<T>)

```cangjie
public init(elements: Collection<T>)
```

Function: Constructs a linked list containing the specified collection elements in the order returned by the collection's iterator.

Parameters:

- elements: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T> - The collection of elements to be added to this linked list.

### init(Int64, (Int64)-> T)

```cangjie
public init(size: Int64, initElement: (Int64)-> T)
```

Function: Creates a linked list with 'size' elements, where the nth element satisfies the condition ([Int64](../../core/core_package_api/core_package_intrinsics.md#int64))-> T.

Parameters:

- size: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The number of elements to create in the linked list.
- initElement: ([Int64](../../core/core_package_api/core_package_intrinsics.md#int64)) ->T - The initialization parameter for elements.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if the specified linked list length is less than 0.

### func addLast(T)

```cangjie
public func addLast(element: T): LinkedListNode<T>
```

Function: Adds an element at the end of the linked list and returns the node of that element.

Parameters:

- element: T - The element to be added to the linked list.

Return Value:

- [LinkedListNode](collection_package_class.md#class-linkedlistnodet)\<T> - The node pointing to the element.

### func backward(LinkedListNode\<T>)

```cangjie
public func backward(mark: LinkedListNode<T>): Iterator<T>
```

Function: Gets an iterator for all elements starting from the 'mark' node to the head node of the corresponding linked list.

Parameters:

- mark: [LinkedListNode](collection_package_class.md#class-linkedlistnodet)\<T> - The starting node.

Return Value:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - The iterator for corresponding elements.

Exceptions:

- [IllegalStateException](../../core/core_package_api/core_package_exceptions.md#class-illegalstateexception) - Thrown if the node does not belong to any linked list instance.

### func clear()

```cangjie
public func clear(): Unit
```

Function: Removes all elements from the linked list.

### func forward(LinkedListNode\<T>)

```cangjie
public func forward(mark: LinkedListNode<T>): Iterator<T>
```

Function: Gets an iterator for all elements starting from the 'mark' node to the tail node of the corresponding linked list.

Parameters:

- mark: [LinkedListNode](collection_package_class.md#class-linkedlistnodet)\<T> - The starting node.

Return Value:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - The iterator for corresponding elements.

Exceptions:

- [IllegalStateException](../../core/core_package_api/core_package_exceptions.md#class-illegalstateexception) - Thrown if the node does not belong to any linked list instance.

### func addAfter(LinkedListNode\<T>,T)

```cangjie
public func addAfter(node: LinkedListNode<T>, element: T): LinkedListNode<T>
```

Function: Inserts an element after the specified node in the linked list and returns the node of that element.

Parameters:

- node: [LinkedListNode](collection_package_class.md#class-linkedlistnodet)\<T> - The specified node.
- element: T - The element to be added to the linked list.

Return Value:

- [LinkedListNode](collection_package_class.md#class-linkedlistnodet)\<T> - The node pointing to the inserted element.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if the specified node does not belong to this linked list.

### func addBefore(LinkedListNode\<T>,T)

```cangjie
public func addBefore(node: LinkedListNode<T>, element: T): LinkedListNode<T>
```

Function: Inserts an element before the specified node in the linked list and returns the node of that element.

Parameters:

- node: [LinkedListNode](collection_package_class.md#class-linkedlistnodet)\<T> - The specified node.
- element: T - The element to be added to the linked list.

Return Value:

- [LinkedListNode](collection_package_class.md#class-linkedlistnodet)\<T> - The node pointing to the inserted element.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if the specified node does not belong to this linked list.

### func isEmpty()

```cangjie
public func isEmpty(): Bool
```

Function: Returns whether this linked list is empty.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if this linked list contains no elements.

### func iterator()

```cangjie
public func iterator(): Iterator<T>
```

Function: Returns an iterator for the elements in the current collection, in order from the first node to the last node of the linked list.

Return Value:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - The iterator for elements in the current collection.

### func nodeAt(Int64)

```cangjie
public func nodeAt(index: Int64): Option<LinkedListNode<T>>
```

Function: Gets the node of the element at the specified 'index' in the linked list, with numbering starting from 0.

The time complexity of this function is O(n).

Parameters:

- index: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The index of the node to retrieve.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[LinkedListNode](collection_package_class.md#class-linkedlistnodet)\<T>> - The node at the specified index, returns None if it doesn't exist.

### func removeFirst()

```cangjie
public func removeFirst() : ?T
```

Function: Removes the first element of the linked list and returns its value.

Return Value:

- ?T - The value of the removed element, returns None if the list is empty.

### func removeLast()

```cangjie
public func removeLast() : ?T
```

Function: Removes the last element of the linked list and returns its value.

Return Value:

- ?T - The value of the removed element, returns None if the list is empty.

### func addFirst(T)

```cangjie
public func addFirst(element: T): LinkedListNode<T>
```

Function: Inserts an element at the head of the linked list and returns the node of that element.

Parameters:

- element: T - The element to be added to the linked list.

Return Value:

- [LinkedListNode](collection_package_class.md#class-linkedlistnodet)\<T> - The node pointing to the element.

### func remove(LinkedListNode\<T>)

```cangjie
public func remove(node: LinkedListNode<T>): T
```

Function: Removes the specified node from the linked list.

Parameters:

- node: [LinkedListNode](collection_package_class.md#class-linkedlistnodet)\<T> - The node to be removed.

Return Value:

- T - The value of the removed node.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if the specified node does not belong to this linked list.

### func removeIf((T)-> Bool)

```cangjie
public func removeIf(predicate: (T)-> Bool): Unit
```

Function: Removes all elements from this linked list that satisfy the given lambda expression or function.

Parameters:

- predicate: (T) ->[Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true for elements to be removed.

Exceptions:

- [ConcurrentModificationException](./collection_package_exception.md#class-concurrentmodificationexception) - Thrown when `predicate` adds, removes, or modifies nodes within [LinkedList](./collection_package_class.md#class-linkedlistt).

### func reverse()

```cangjie
public func reverse(): Unit
```

Function: Reverses the order of elements in this linked list.

### func splitOff(LinkedListNode\<T>)

```cangjie
public func splitOff(node: LinkedListNode<T>): LinkedList<T>
```

Function: Splits the linked list into two lists starting from the specified 'node'. If successful, 'node' is no longer in the current list but becomes the first node in the new list.

Parameters:

- node: [LinkedListNode](collection_package_class.md#class-linkedlistnodet)\<T> - The split position.

Return Value:

- [LinkedList](collection_package_class.md#class-linkedlistt)\<T> - The newly created linked list after splitting.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if the specified node does not belong to this linked list.

### func toArray()

```cangjie
public func toArray(): Array<T>
```

Function: Returns an array containing all elements of this linked list in the same order.

Return Value:

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - An array of type T.

### extend\<T> LinkedList\<T> <: Equatable\<LinkedList\<T>> where T <: Equatable\<T>

```cangjie
extend<T> LinkedList<T> <: Equatable<LinkedList<T>> where T <: Equatable<T>
```

Function: Extends [LinkedList](./collection_package_class.md#class-linkedlistt)\<T> with the [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[LinkedList](./collection_package_class.md#class-linkedlistt)\<T>> interface, supporting equality comparison.

Parent Types:

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[LinkedList](#class-linkedlistt)\<T>>

#### operator func ==(LinkedList\<T>)

```cangjie
public operator func ==(right: LinkedList<T>): Bool
```

Function: Determines whether the current instance is equal to the [LinkedList](./collection_package_class.md#class-linkedlistt)\<T> instance pointed to by the parameter.

Two [LinkedList](./collection_package_class.md#class-linkedlistt)\<T> instances are equal if they contain exactly the same elements.

Parameters:

- right: [LinkedList](./collection_package_class.md#class-linkedlistt)\<T> - The object to compare.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if equal, otherwise false.

#### operator func !=(LinkedList\<T>)

```cangjie
public operator func !=(right: LinkedList<T>): Bool
```

Function: Determines whether the current instance is not equal to the [LinkedList](./collection_package_class.md#class-linkedlistt)\<T> instance pointed to by the parameter.

Parameters:

- right: [LinkedList](./collection_package_class.md#class-linkedlistt)\<T> - The object to compare.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if not equal, otherwise false.

### extend\<T> LinkedList\<T> <: ToString where T <: ToString

```cangjie
extend<T> LinkedList<T> <: ToString where T <: ToString
```

Function: Extends [LinkedList](./collection_package_class.md#class-linkedlistt)\<T> with the [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring) interface, supporting string conversion.

Parent Types:

- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

#### func toString()

```cangjie
public func toString(): String
```

Function: Converts the current [LinkedList](./collection_package_class.md#class-linkedlistt)\<T> instance to a string.

The string contains the string representation of each element in [LinkedList](./collection_package_class.md#class-linkedlistt)\<T>, formatted as: "[elem1, elem2, elem3]".

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The converted string.## class TreeMap\<K, V> where K <: Comparable\<K>

```cangjie
public class TreeMap<K, V> <: OrderedMap<K, V> where K <: Comparable<K> {
    public init()
    public init(elements: Collection<(K, V)>)
    public init(elements: Array<(K,V)>)
    public init(size: Int64, initElement: (Int64) -> (K, V))
}
```

Functionality: An implementation of the [OrderedMap](collection_package_interface.md#interface-orderedmapk-v) interface based on a balanced binary search tree.

The primary purpose of this class is to provide an ordered key-value storage structure that supports fast insertion, deletion, and lookup operations.

[TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek) can be used in any scenario requiring ordered key-value storage, such as databases, caches, lookup tables, etc.

Parent Types:

- [OrderedMap](collection_package_interface.md#interface-orderedmapk-v)\<K, V>

### prop first

```cangjie
public prop first: ?(K, V)
```

Functionality: Retrieves the first element of the [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek).

Return Value:

- ?(K, V) - If the first element exists, returns the element wrapped in [Option](../../core/core_package_api/core_package_enums.md#enum-optiont); otherwise returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<(K, V)>.None.

### prop last

```cangjie
public prop last: ?(K, V)
```

Functionality: Retrieves the last element of the [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek).

Return Value:

- ?(K, V) - If the last element exists, returns the element wrapped in [Option](../../core/core_package_api/core_package_enums.md#enum-optiont); otherwise returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<(K, V)>.None.

### prop size

```cangjie
public prop size: Int64
```

Functionality: Returns the number of key-value pairs.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### init()

```cangjie
public init()
```

Functionality: Constructs an empty [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek).

### init(Array\<(K,V)>)

```cangjie
public init(elements: Array<(K,V)>)
```

Functionality: Constructs a [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek) from an array of key-value pairs.

Elements are inserted into the [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek) in the order they appear in `elements`. Since duplicate keys are not allowed in [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek), if duplicate keys exist in `elements`, the latter key-value pair will overwrite the former.

Parameters:

- elements: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<(K, V)> - The array of key-value pairs used to initialize this [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek).

### init(Collection\<(K, V)>)

```cangjie
public init(elements: Collection<(K, V)>)
```

Functionality: Constructs a [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek) from a collection of key-value pairs.

Elements are inserted into the [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek) in the order returned by the collection's iterator. Since duplicate keys are not allowed in [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek), if duplicate keys exist in `elements`, the latter key-value pair (in iterator order) will overwrite the former.

Parameters:

- elements: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<(K, V)> - The collection of key-value pairs used to initialize this [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek).

### init(Int64, (Int64) -> (K, V))

```cangjie
public init(size: Int64, initElement: (Int64) -> (K, V))
```

Functionality: Constructs a [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek) using a size parameter and an initialization function.

Parameters:

- size: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The number of elements to initialize.
- initElement: ([Int64](../../core/core_package_api/core_package_intrinsics.md#int64)) -> (K, V) - The initialization function rule for this [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek).

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if size is less than 0.

### func add(K, V)

```cangjie
public func add(key: K, value: V): Option<V>
```

Functionality: Inserts a new key-value pair into the [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek). For existing keys in the [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek), the key's value will be replaced with the new value.

Parameters:

- key: K - The key to insert.
- value: V - The value to assign.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<V> - If the key existed before assignment, returns the old value wrapped in [Option](../../core/core_package_api/core_package_enums.md#enum-optiont); otherwise returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<V>.None.

### func add(Collection\<(K, V)>)

```cangjie
public func add(all!: Collection<(K, V)>): Unit
```

Functionality: Inserts a collection of new key-value pairs into the [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek). For existing keys in the [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek), the keys' values will be replaced with the new values.

Parameters:

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<(K, V)> - The collection of key-value pairs to add to the [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek).

### func backward(K, Bool)

```cangjie
public func backward(mark: K, inclusive!: Bool = true): Iterator<(K, V)>
```

Functionality: Retrieves an iterator that traverses from the first node with a key less than or equal to `mark` in descending order to [first](./collection_package_class.md#prop-first-3). If the node's key equals `mark`, the inclusion of this node is determined by `inclusive!`.

Parameters:

- mark: K - The key used to determine the starting point.
- inclusive!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - When `mark` is the key of the iterator's first element, specifies whether to include `mark` as the starting point (default: `true`).

Return Value:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<(K, V)> - The iterator for corresponding elements.

### func clear()

```cangjie
public func clear(): Unit
```

Functionality: Clears all key-value pairs.

### func clone()

```cangjie
public func clone(): TreeMap<K, V>
```

Functionality: Clones the [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek).

Return Value:

- [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek)\<K, V> - Returns a new [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek) instance.

### func contains(K)

```cangjie
public func contains(key: K): Bool
```

Functionality: Checks whether a mapping exists for the specified key.

Parameters:

- key: K - The key to check.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the key exists; otherwise, returns `false`.

### func contains(Collection\<K>)

```cangjie
public func contains(all!: Collection<K>): Bool
```

Functionality: Checks whether mappings exist for all keys in the specified collection.

Parameters:

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<K> - The collection of keys.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if all keys exist; otherwise, returns `false`.

### func entryView(K)

```cangjie
public func entryView(k: K): MapEntryView<K, V>
```

Functionality: Returns an empty reference view if the key does not exist. If the key exists, returns a reference view of the corresponding element.

Parameters:

- k: K - The key of the key-value pair to add.

Return Value:

- [MapEntryView](./collection_package_interface.md#interface-mapentryviewk-v)\<K, V> - A reference view.

### func forward(K, Bool)

```cangjie
public func forward(mark: K, inclusive!: Bool = true): Iterator<(K, V)>
```

Functionality: Retrieves an iterator that traverses from the first node with a key greater than or equal to `mark` in ascending order to [last](./collection_package_class.md#prop-last-3). If the node's key equals `mark`, the inclusion of this node is determined by `inclusive!`.

Parameters:

- mark: K - The key used to determine the starting point.
- inclusive!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - When `mark` is the key of the iterator's first element, specifies whether to include `mark` as the starting point (default: `true`).

Return Value:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<(K, V)> - The iterator for corresponding elements.

### func get(K)

```cangjie
public func get(key: K): ?V
```

Functionality: Returns the value mapped to the specified key.

Parameters:

- key: K - The specified key.

Return Value:

- ?V - If such a value exists, returns the value wrapped in [Option](../../core/core_package_api/core_package_enums.md#enum-optiont); otherwise returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<V>.None.

### func isEmpty()

```cangjie
public func isEmpty(): Bool
```

Functionality: Checks whether the [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek) is empty.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if empty; otherwise, returns `false`.

### func iterator()

```cangjie
public func iterator(): Iterator<(K, V)>
```

Functionality: Returns an iterator for the [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek), iterating in ascending order of key values.

Return Value:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<(K, V)> - The iterator for the [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek).

### func keys()

```cangjie
public func keys(): EquatableCollection<K>
```

Functionality: Returns all keys in the [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek), stored in a container.

Return Value:

- [EquatableCollection](collection_package_interface.md#interface-equatablecollectiont)\<K> - A collection containing all keys.

### func removeFirst()

```cangjie
public func removeFirst(): ?(K, V)
```

Functionality: Removes the first element of the [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek).

Return Value:

- ?(K, V) - If the first element exists, removes it and returns the element wrapped in [Option](../../core/core_package_api/core_package_enums.md#enum-optiont); otherwise returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<(K, V)>.None.

### func removeLast()

```cangjie
public func removeLast(): ?(K, V)
```

Functionality: Removes the last element of the [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek).

Return Value:

- ?(K, V) - If the last element exists, removes it and returns the element wrapped in [Option](../../core/core_package_api/core_package_enums.md#enum-optiont); otherwise returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<(K, V)>.None.

### func remove(K)

```cangjie
public func remove(key: K): Option<V>
```

Functionality: Removes the mapping for the specified key from this map (if it exists).

Parameters:

- key: K - The key to remove.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<V> - Returns the removed value wrapped in [Option](../../core/core_package_api/core_package_enums.md#enum-optiont). If the key does not exist in the [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek), returns None.

### func remove(Collection\<K>)

```cangjie
public func remove(all!: Collection<K>): Unit
```

Functionality: Removes mappings for all keys in the specified collection from this map (if they exist).

Parameters:

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<K> - The collection of keys to remove.

### func removeIf((K, V) -> Bool)

```cangjie
public func removeIf(predicate: (K, V) -> Bool): Unit
```

Functionality: Takes a lambda expression and removes corresponding key-value pairs if the condition is met.

Parameters:

- predicate: (K, V) ->[Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - A lambda expression used for evaluation.

Exceptions:

- [ConcurrentModificationException](./collection_package_exception.md#class-concurrentmodificationexception) - Thrown when `predicate` adds, removes, or modifies key-value pairs within the [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek).

### func values()

```cangjie
public func values(): Collection<V>
```

Functionality: Returns all values in the [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek), stored in a container.

Return Value:

- [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<V> - A collection containing all values.

### operator func \[](K, V)

```cangjie
public operator func [](key: K, value!: V): Unit
```

Functionality: Operator overload for collections. If the key exists, the new value overwrites the old value; if the key does not exist, the key-value pair is added.

Parameters:

- key: K - The key to evaluate.
- value!: V - The value to set.

### operator func \[](K)

```cangjie
public operator func [](key: K): V
```

Functionality: Operator overload for collections. If the key exists, returns the corresponding value.

Parameters:

- key: K - The key to evaluate.

Return Value:

- V - The value corresponding to the key.

Exceptions:

- [NoneValueException](../../core/core_package_api/core_package_exceptions.md#class-nonevalueexception) - Thrown if the [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) does not contain the specified key.

### extend\<K, V> TreeMap\<K, V> <: Equatable\<TreeMap\<K, V>> where V <: Equatable\<V>

```cangjie
extend<K, V> TreeMap<K, V> <: Equatable<TreeMap<K, V>> where V <: Equatable<V>
```

Functionality: Extends the [TreeMap](./collection_package_class.md#class-treemapk-v-where-k--comparablek)\<K, V> type with the [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[TreeMap](./collection_package_class.md#class-treemapk-v-where-k--comparablek)\<K, V>> interface, supporting equality comparison operations.

Parent Types:

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[TreeMap](./collection_package_class.md#class-treemapk-v-where-k--comparablek)\<K, V>>

#### operator func ==(TreeMap\<## class TreeSet\<T> where T <: Comparable\<T>

```cangjie
public class TreeSet<T> <: OrderedSet<T> where T <: Comparable<T> {
    public init()
    public init(elements: Collection<T>)
    public init(size: Int64, initElement: (Int64) -> T)
}
```

Function: An implementation of the [Set](collection_package_interface.md#interface-sett) interface based on [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek).

The primary purpose of this class is to provide an ordered element storage structure that enables fast insertion, deletion, and lookup of elements.

[TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) can be used in any scenario requiring ordered element storage, such as databases, caches, lookup tables, etc.

Parent Types:

- [OrderedSet](collection_package_interface.md#interface-orderedsett)\<T>

### prop first

```cangjie
public prop first: ?T
```

Function: Gets the first element of the [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet).

Type: ?T - If the first element exists, returns it wrapped in [Option](../../core/core_package_api/core_package_enums.md#enum-optiont); otherwise returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T>.None.

### prop last

```cangjie
public prop last: ?T
```

Function: Gets the last element of the [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet).

Type: ?T - If the last element exists, returns it wrapped in [Option](../../core/core_package_api/core_package_enums.md#enum-optiont); otherwise returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T>.None.

### prop size

```cangjie
public prop size: Int64
```

Function: Returns the number of elements.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### init()

```cangjie
public init()
```

Function: Constructs an empty [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet).

### init(Collection\<T>)

```cangjie
public init(elements: Collection<T>)
```

Function: Constructs a [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) from a given collection of elements.

Elements are inserted into the [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) in the order of the elements' iterator. Since duplicate elements are not allowed in a [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet), if there are multiple identical elements in the input collection, only one will be retained.

Parameters:

- elements: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T> - The collection of elements to initialize this [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet).

### init(Int64, (Int64) -> T)

```cangjie
public init(size: Int64, initElement: (Int64) -> T)
```

Function: Constructs a [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) using a specified size and an initialization function.

Parameters:

- size: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The number of elements.
- initElement: ([Int64](../../core/core_package_api/core_package_intrinsics.md#int64)) -> T - The function rule to initialize this [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet).

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if size is less than 0.

### static func of(Array\<T>)

```cangjie
public static func of(elements: Array<T>): TreeSet<T>
```

Function: Constructs a [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) containing all elements from the specified array.

Elements are inserted into the [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) in the order they appear in the array. Since duplicate elements are not allowed, only one instance of each element will be retained.

Parameters:

- elements: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - The input array.

Return Value:

- [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)\<T> - A [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) of type T.

### func add(T)

```cangjie
public func add(element: T): Bool
```

Function: Adds a new element to the [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet). If the element already exists, the addition fails.

Parameters:

- element: T - The specified element.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if the addition is successful; otherwise, returns false.

### func add(Collection\<T>)

```cangjie
public func add(all!: Collection<T>): Unit
```

Function: Adds all elements from the specified [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont) to this [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet). Existing elements are not added.

Parameters:

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T> - The collection of elements to be added.

### func backward(T, Bool)

```cangjie
public func backward(mark: T, inclusive!: Bool = true): Iterator<T>
```

Function: Gets an iterator that traverses from the first element less than or equal to `mark` in descending order to [first](./collection_package_class.md#prop-first-4). If the element equals `mark`, the inclusion of that element is determined by `inclusive!`.

Parameters:

- mark: T - The element used to determine the starting point.
- inclusive!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Specifies whether to include `mark` as the starting point when it is the first element of the iterator. Defaults to `true`.

Return Value:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - An iterator for the corresponding elements.

### func clear()

```cangjie
public func clear(): Unit
```

Function: Clears all elements.

### func clone()

```cangjie
public func clone(): TreeSet<T>
```

Function: Clones the [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet).

Return Value:

- [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)\<T> - Returns a new [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) instance.

### func contains(T)

```cangjie
public func contains(element: T): Bool
```

Function: Checks whether the specified element is contained.

Parameters:

- element: T - The specified element.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if the element is contained; otherwise, returns false.

### func contains(Collection\<T>)

```cangjie
public func contains(all!: Collection<T>): Bool
```

Function: Checks whether this [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) contains all elements from the specified [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont).

Parameters:

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T> - The specified collection of elements.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if this [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) contains all elements from the collection; otherwise, returns false.

### func forward(T, Bool)

```cangjie
public func forward(mark: T, inclusive!: Bool = true): Iterator<T>
```

Function: Gets an iterator that traverses from the first element greater than or equal to `mark` in ascending order to [last](./collection_package_class.md#prop-last-3). If the element equals `mark`, the inclusion of that element is determined by `inclusive!`.

Parameters:

- mark: T - The element used to determine the starting point.
- inclusive!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Specifies whether to include `mark` as the starting point when it is the first element of the iterator. Defaults to `true`.

Return Value:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - An iterator for the corresponding elements.

### func isEmpty()

```cangjie
public func isEmpty(): Bool
```

Function: Checks whether the [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) is empty.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if empty; otherwise, returns false.

### func iterator()

```cangjie
public func iterator(): Iterator<T>
```

Function: Returns an iterator for the [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet), which iterates elements in ascending order.

Return Value:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - An iterator for the [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet).

### func removeFirst()

```cangjie
public func removeFirst(): ?T
```

Function: Removes the first element of the [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet).

Return Value:

- ?T - If the first element exists, removes it and returns it wrapped in [Option](../../core/core_package_api/core_package_enums.md#enum-optiont); otherwise returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T>.None.

### func removeLast()

```cangjie
public func removeLast(): ?T
```

Function: Removes the last element of the [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet).

Return Value:

- ?T - If the last element exists, removes it and returns it wrapped in [Option](../../core/core_package_api/core_package_enums.md#enum-optiont); otherwise returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T>.None.

### func remove(T)

```cangjie
public func remove(element: T): Bool
```

Function: Removes the specified element from this [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) if it exists.

Parameters:

- element: T - The element to be removed.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if the removal is successful; otherwise, returns false.

### func remove(Collection\<T>)

```cangjie
public func remove(all!: Collection<T>): Unit
```

Function: Removes all elements from this [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) that are also contained in the specified [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont).

Parameters:

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T> - The collection of elements to be removed from this [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet).

### func removeIf((T) -> Bool)

```cangjie
public func removeIf(predicate: (T) -> Bool): Unit
```

Function: Takes a lambda expression and removes elements that satisfy the `true` condition.

Parameters:

- predicate: (T) ->[Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The condition to determine whether to remove an element.

Exceptions:

- [ConcurrentModificationException](./collection_package_exception.md#class-concurrentmodificationexception) - Thrown if elements are added, removed, or modified within `predicate`.

### func retain(Set\<T>)

```cangjie
public func retain(all!: Set<T>): Unit
```

Function: Retains only the elements in this [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) that are contained in the specified [Set](collection_package_interface.md#interface-sett). Other elements will be removed.

Parameters:

- all!: [Set](collection_package_interface.md#interface-sett)\<T> - The [Set](collection_package_interface.md#interface-sett) of elements to retain.

### func subsetOf(ReadOnlySet\<T>)

```cangjie
public func subsetOf(other: ReadOnlySet<T>): Bool
```

Function: Checks whether this set is a subset of another [ReadOnlySet](collection_package_interface.md#interface-readonlysett).

Parameters:

- other: [ReadOnlySet](collection_package_interface.md#interface-readonlysett)\<T> - The input set to compare against.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if this [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) is a subset of the specified [ReadOnlySet](collection_package_interface.md#interface-readonlysett); otherwise, returns false.

### func toArray()

```cangjie
public func toArray(): Array<T>
```

Function: Returns an array containing all elements in the container.

Return Value:

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - An array of type T.

### operator func &(ReadOnlySet\<T>)

```cangjie
public operator func &(other: ReadOnlySet<T>): TreeSet<T>
```

Function: Returns a new set containing the intersection of two sets.

Parameters:

- other: [ReadOnlySet](collection_package_interface.md#interface-readonlysett)\<T> - The input set.

Return Value:

- [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)\<T> - A set of type T.

### operator func |(ReadOnlySet\<T>)

```cangjie
public operator func |(other: ReadOnlySet<T>): TreeSet<T>
```

Function: Returns a new set containing the union of two sets.

Parameters:

- other: [ReadOnlySet](collection_package_interface.md#interface-readonlysett)\<T> - The input set.

Return Value:

- [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)\<T> - A set of type T.

### operator func -(ReadOnlySet\<T>)

```cangjie
public operator func -(other: ReadOnlySet<T>): TreeSet<T>
```

Function: Returns a new set containing the difference of two sets.

Parameters:

- other: [ReadOnlySet](collection_package_interface.md#interface-readonlysett)\<T> - The input set.

Return Value:

- [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)\<T> - A set of type T.### extend\<T> TreeSet\<T> <: Equatable\<TreeSet\<T>>

```cangjie
extend<T> TreeSet<T> <: Equatable<TreeSet<T>>
```

Function: Extends the [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)\<T> type with the [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)\<T>> interface, enabling equality comparison operations.

Parent Types:

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)\<T>>

#### operator func ==(TreeSet\<T>)

```cangjie
public operator func ==(that: TreeSet<T>): Bool
```

Function: Determines whether the current instance is equal to the [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)\<T> instance pointed to by the parameter.

Two [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)\<T> instances are considered equal if they contain exactly the same elements.

Parameters:

- that: [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)\<T> - The object to be compared.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if equal, otherwise returns false.

#### operator func !=(TreeSet\<T>)

```cangjie
public operator func !=(that: TreeSet<T>): Bool
```

Function: Determines whether the current instance is not equal to the [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)\<T> instance pointed to by the parameter.

Parameters:

- that: [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)\<T> - The object to be compared.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if not equal, otherwise returns false.

### extend\<T> TreeSet\<T> <: ToString where T <: ToString

```cangjie
extend<T> TreeSet<T> <: ToString where T <: ToString
```

Function: Extends the [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)\<T> with the [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring) interface, enabling string conversion operations.

Parent Types:

- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

#### func toString()

```cangjie
public func toString(): String
```

Function: Converts the current [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)\<T> instance to a string.

The resulting string contains the string representation of each element in the [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)\<T>, formatted as: "[elem1, elem2, elem3]".

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The converted string.