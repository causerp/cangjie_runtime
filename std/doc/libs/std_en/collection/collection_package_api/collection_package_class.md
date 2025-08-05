# Class

## class ArrayDeque\<T>

```cangjie
public class ArrayDeque<T> <: Deque<T> {
    public init()
    public init(capacity: Int64)
}
```

Functionality: ArrayDeque is an implementation class of a double-ended queue (deque) that supports insertion and removal operations at both ends. It is implemented using a resizable array, with its capacity automatically growing during element insertion (default expansion rate is 50%). The implementation employs a circular queue approach, providing O(1) time complexity for insertion, removal, and access operations when no expansion occurs.

Parent Type:

- [Deque](./collection_package_interface.md#interface-dequet)\<T>

### prop capacity

```cangjie
public prop capacity: Int64
```

Functionality: Gets the current capacity of this deque.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### prop first

```cangjie
public prop first: ?T
```

Functionality: Retrieves the head element of the deque. Returns None if the deque is empty.

Type: ?T

### prop last

```cangjie
public prop last: ?T
```

Functionality: Retrieves the tail element of the deque. Returns None if the deque is empty.

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

Functionality: Constructs an empty deque with default capacity of 8.

### init(Int64)

```cangjie
public init(capacity: Int64)
```

Functionality: Constructs a deque with specified capacity. When capacity is less than the default value (8), the initial capacity will be set to 8.

Parameters:

- capacity: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The specified initial capacity.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if the parameter value is negative.

### func addFirst(T)

```cangjie
public func addFirst(element: T): Unit
```

Functionality: Inserts an element at the head of this deque.

Parameters:

- element: T - The element to be inserted.

### func addLast(T)

```cangjie
public func addLast(element: T): Unit
```

Functionality: Inserts an element at the tail of this deque.

Parameters:

- element: T - The element to be inserted.

### func clear()

```cangjie
public func clear(): Unit
```

Functionality: Removes all elements from this deque.

### func iterator()

```cangjie
public func iterator(): Iterator<T>
```

Functionality: Returns an iterator over the elements in this deque in proper sequence (front to back).

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

Functionality: Removes and returns the head element of this deque. Returns `None` if the deque is empty.

Return Value:

- ?T - The removed head element.

### func removeLast()

```cangjie
public func removeLast(): ?T
```

Function: Removes and returns the last element of the deque. Returns `None` if the deque is empty.

Return value:

- ?T - The removed last element.

### func reserve(Int64)

```cangjie
public func reserve(additional: Int64): Unit
```

Function: Increases the capacity of this deque.

Expands the deque's capacity by the specified `additional` size. No expansion occurs if:
- `additional` is less than or equal to zero
- The remaining capacity of the deque is greater than or equal to `additional`

When expansion is needed, the new capacity will be the maximum between:
1. The original capacity multiplied by 1.5 (rounded down)
2. The sum of `additional` and the currently used capacity

Parameters:

- additional: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The additional capacity to reserve.

### func toArray()

```cangjie
public func toArray(): Array<T>
```

Function: Returns an array containing all elements of this deque in front-to-back order.

Return value:

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - An array of type T.

### extend\<T> ArrayDeque\<T> <: ToString where T <: ToString

```cangjie
extend<T> ArrayDeque<T> <: ToString where T <: ToString
```

Function: Extends [ArrayDeque](./collection_package_class.md#class-arraydequet)\<T> with the [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring) interface, enabling string conversion operations.

Parent type:

- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

#### func toString()

```cangjie
public func toString(): String
```

Function: Gets the string representation of the current [ArrayDeque](./collection_package_class.md#class-arraydequet)\<T> instance.

The string contains each element's string representation in front-to-back order, formatted as: "[elem1, elem2, elem3]".

Return value:

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

Function: Provides functionality for variable-length arrays.

[ArrayList](collection_package_class.md#class-arraylistt) is a linear dynamic array that differs from [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt) by automatically resizing as needed and not requiring size specification during creation.

> **Note:**
>
> - When adding elements to a dynamic array, if the array is full, it will reallocate a larger memory space and copy existing elements to the new space.
>
> - Advantages of dynamic arrays include memory efficiency and automatic resizing, making them ideal for scenarios requiring frequent element additions/removals. However, the reallocation process may cause performance overhead, which should be considered when using dynamic arrays.

Parent type:

- [List](./collection_package_interface.md#interface-listt)\<T>

### prop size

```cangjie
public prop size: Int64
```

Function: Returns the number of elements in this [ArrayList](collection_package_class.md#class-arraylistt).

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### prop capacity

```cangjie
public prop capacity: Int64
```

Function: Returns the capacity of this [ArrayList](collection_package_class.md#class-arraylistt).

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### prop first

```cangjie
public prop first: ?T
```

Function: Returns the first element of this [ArrayList](collection_package_class.md#class-arraylistt), or `None` if empty.

Type: ?T

### prop last

```cangjie
public prop last: ?T
```

Function: Returns the last element of this [ArrayList](collection_package_class.md#class-arraylistt), or `None` if empty.

Type: ?T

### init()

```cangjie
public init()
```

Function: Constructs an [ArrayList](collection_package_class.md#class-arraylistt) with default initial capacity of `16`.

### init(Collection\<T>)

```cangjie
public init(elements: Collection<T>)
```

Function: Constructs an [ArrayList](collection_package_class.md#class-arraylistt) containing all elements from the specified collection, maintaining their iteration order.

Parameters:

- elements: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T> - The input collection.

### init(Int64)

```cangjie
public init(capacity: Int64)
```

Function: Constructs an [ArrayList](collection_package_class.md#class-arraylistt) with the specified initial capacity.

Parameters:

- capacity: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The specified initial capacity size.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception if the parameter value is less than 0.

### init(Int64, (Int64) -> T)

```cangjie
public init(size: Int64, initElement: (Int64) -> T)
```

Function: Constructs an [ArrayList](collection_package_class.md#class-arraylistt) with the specified number of initial elements and initialization function. This constructor sets the capacity of [ArrayList](collection_package_class.md#class-arraylistt) based on the size parameter.

Parameters:

- size: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The number of elements for the initialization function.
- initElement: ([Int64](../../core/core_package_api/core_package_intrinsics.md#int64)) ->T - The initialization function.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception if size is less than 0.

### static func of(Array\<T>)

```cangjie
public static func of(elements: Array<T>): ArrayList<T>
```

Function: Constructs an [ArrayList](collection_package_class.md#class-arraylistt) containing all elements from the specified array.

Parameters:

- elements: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - The input array.

Return Value:

- [ArrayList](#class-arraylistt)\<T> - An ArrayList with elements of type T.

### func add(T)

```cangjie
public func add(element: T): Unit
```

Function: Appends the specified element to the end of this [ArrayList](collection_package_class.md#class-arraylistt).

Parameters:

- element: T - The element to be inserted, of type T.

Example:

See usage example at [ArrayList's add function](../collection_package_samples/sample_arraylist_add.md).

### func add(Collection\<T>)

```cangjie
public func add(all!: Collection<T>): Unit
```

Function: Appends all elements from the specified collection to the end of this [ArrayList](collection_package_class.md#class-arraylistt).

The function traverses the input collection in iterator order and inserts all elements to the tail of this [ArrayList](collection_package_class.md#class-arraylistt).

Parameters:

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T> - The collection of elements to be inserted.

### func add(T, Int64)

```cangjie
public func add(element: T, at!: Int64): Unit
```

Function: Inserts the specified element at the specified position in this [ArrayList](collection_package_class.md#class-arraylistt).

Parameters:

- element: T - The element of type T to be inserted.
- at!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The target index for insertion.

Exceptions:

- [IndexOutOfBoundsException](../../core/core_package_api/core_package_exceptions.md#class-indexoutofboundsexception) - Throws an exception when 'at' is out of bounds.

Example:

See usage example at [ArrayList's add function](../collection_package_samples/sample_arraylist_add.md).

### func add(Collection\<T>, Int64)

```cangjie
public func add(all!: Collection<T>, at!: Int64): Unit
```

Function: Inserts all elements from the specified collection into this [ArrayList](collection_package_class.md#class-arraylistt) starting from the specified position.

The function traverses the input collection in iterator order and inserts all elements at the specified position, shifting existing elements at and after that position backward.

Parameters:

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T> - The collection of elements of type T to be inserted.
- at!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The target index for collection insertion.

Exceptions:

- [IndexOutOfBoundsException](../../core/core_package_api/core_package_exceptions.md#class-indexoutofboundsexception) - Throws an exception when 'at' is out of bounds.

Example:

See usage example at [ArrayList's add function](../collection_package_samples/sample_arraylist_add.md).

### func clear()

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

See usage examples in [ArrayList's get/set functions](../collection_package_samples/sample_arraylist_get_set.md).

### func getRawArray()

```cangjie
public unsafe func getRawArray(): Array<T>
```

Function: Returns the raw data of the [ArrayList](collection_package_class.md#class-arraylistt).

> **Note:**
>
> This is an unsafe interface and must be used within an unsafe context.
>
> The raw data refers to the underlying array implementation of [ArrayList](collection_package_class.md#class-arraylistt). Its size is greater than or equal to the number of elements in the [ArrayList](collection_package_class.md#class-arraylistt). Accessing elements at indices greater than or equal to the size of the [ArrayList](collection_package_class.md#class-arraylistt) may contain uninitialized elements, leading to undefined behavior.

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

- at!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The index of the element to be removed.

Return Value:

- T - The removed element.

Exceptions:

- [IndexOutOfBoundsException](../../core/core_package_api/core_package_exceptions.md#class-indexoutofboundsexception) - Thrown when 'at' is out of range.

Example:

See usage examples in [ArrayList's remove/clear/slice functions](../collection_package_samples/sample_arraylist_remove_clear_slice.md).

### func remove(Range\<Int64>)

```cangjie
public func remove(range: Range<Int64>): Unit
```

Function: Removes all elements in the specified [Range](../../core/core_package_api/core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet) from this [ArrayList](collection_package_class.md#class-arraylistt).

> **Note:**
>
> If the parameter 'range' is constructed using the [Range](../../core/core_package_api/core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet) constructor with 'hasEnd' set to false, the 'end' value does not take effect, regardless of the 'isClosed' value passed during construction. The array slice will include elements up to the last element of the original array.

Parameters:

- range: [Range](../../core/core_package_api/core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet)\<[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)> - The range of elements to be removed.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the [step](collection_package_function.md#func-steptint64) of 'range' is not equal to 1.
- [IndexOutOfBoundsException](../../core/core_package_api/core_package_exceptions.md#class-indexoutofboundsexception) - Thrown when the 'start' or 'end' of 'range' is less than 0, or when 'end' exceeds the length of the [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt).

### func removeIf((T) -> Bool)

```cangjie
public func removeIf(predicate: (T) -> Bool): Unit
```

Function: Removes all elements from this [ArrayList](collection_package_class.md#class-arraylistt) that satisfy the given lambda expression or function.

Parameters:

- predicate: (T) ->[Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The condition that determines whether an element should be removed.

Exceptions:

- [ConcurrentModificationException](./collection_package_exception.md#class-concurrentmodificationexception) - Thrown when elements are added, removed, or modified within the 'predicate' function while iterating over the [ArrayList](collection_package_class.md#class-arraylistt).

### func reserve(Int64)

```cangjie
public func reserve(additional: Int64): Unit
```

Function: Increases the capacity of this [ArrayList](collection_package_class.md#class-arraylistt) instance.

Expands the [ArrayList](collection_package_class.md#class-arraylistt) by the 'additional' size. No expansion occurs if 'additional' is less than or equal to zero. If the remaining capacity of the [ArrayList](collection_package_class.md#class-arraylistt) is greater than or equal to 'additional', no expansion occurs. If the remaining capacity is less than 'additional', the expansion size is the maximum of (1.5 times the original capacity, rounded down) and ('additional' + used capacity).

Parameters:

- additional: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The size to expand by.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when 'additional' + used capacity exceeds Int64.Max.

### func reverse()

```cangjie
public func reverse(): Unit
```

Function: Reverses the order of elements in this [ArrayList](collection_package_class.md#class-arraylistt).

### func slice(Range\<Int64>)

```cangjie
public func slice(range: Range<Int64>): ArrayList<T>
```

Function: Returns an [ArrayList](collection_package_class.md#class-arraylistt)\<T> corresponding to the specified range index.

> **Note:**
>
> If the parameter `range` is a [Range](../../core/core_package_api/core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet) instance constructed using the [Range](../../core/core_package_api/core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet) constructor, the following behaviors apply:
>
> 1. The `start` value is exactly the value passed to the constructor, unaffected by the `hasStart` parameter during construction.
> 2. When `hasEnd` is false, the `end` value is ineffective and unaffected by the `isClosed` parameter during construction. The array slice will include elements up to the last element of the original array.

Parameters:

- `range`: [Range](../../core/core_package_api/core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet)\<[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)> - The range specifying the slice.

Return Value:

- [ArrayList](collection_package_class.md#class-arraylistt)\<T> - The sliced array.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when `range.[step](collection_package_function.md#func-steptint64)` is not equal to 1.
- [IndexOutOfBoundsException](../../core/core_package_api/core_package_exceptions.md#class-indexoutofboundsexception) - Thrown when `range` is invalid.

Example:

See [ArrayList's remove/clear/slice functions](../collection_package_samples/sample_arraylist_remove_clear_slice.md) for usage examples.

### func sortBy((T, T) -> Ordering) <sup>(deprecated)</sup>

```cangjie
public func sortBy(comparator!: (T, T) -> Ordering): Unit
```

Function: Performs an unstable sort on the array elements.

The custom sorting is based on the return value of type [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering) from the comparator function. If the comparator returns [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).GT, `t1` will appear after `t2` after sorting; if it returns [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).LT, `t1` will appear before `t2`; if it returns [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).EQ and the sort is stable, `t1` will appear before `t2`; if the sort is unstable, the order of `t1` and `t2` is indeterminate.

> **Note:**
>
> This function will be deprecated in future versions. Use [sort](../../sort/sort_package_api/sort_package_funcs.md#func-sorttlistt-bool-bool-where-t--comparablet) instead.

Parameters:

- `comparator!`: (T, T) -> [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering) - A function of type (T, T) -> [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).

### func sortBy(Bool, (T, T) -> Ordering) <sup>(deprecated)</sup>

```cangjie
public func sortBy(stable!: Bool, comparator!: (T, T) -> Ordering): Unit
```

Function: Performs a sort on the array elements.

The custom sorting is based on the return value of type [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering) from the comparator function. If the comparator returns [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).GT, `t1` will appear after `t2` after sorting; if it returns [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).LT, `t1` will appear before `t2`; if it returns [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).EQ and the sort is stable, `t1` will appear before `t2`; if the sort is unstable, the order of `t1` and `t2` is indeterminate.

> **Note:**
>
> This function will be deprecated in future versions. Use [sort](../../sort/sort_package_api/sort_package_funcs.md#func-sorttlistt-bool-bool-where-t--comparablet) instead.

Parameters:

- `stable!`: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether to use stable sorting.
- `comparator!`: (T, T) -> [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering) - A function of type (T, T) -> [Ordering](../../core/core_package_api/core_package_enums.md#enum-ordering).

### func toArray()

```cangjie
public func toArray(): Array<T>
```

Function: Returns an array containing all elements in this list in proper sequence.

Return Value:

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - An array of type T.

### operator func []\(Int64)

```cangjie
public operator func [](index: Int64): T
```

Function: Operator overload - get.

Parameters:

- `index`: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The index for the get operation.

Return Value:

- `T` - The value of the element at the specified index.

Exceptions:

- [IndexOutOfBoundsException](../../core/core_package_api/core_package_exceptions.md#class-indexoutofboundsexception) - Thrown when `index` is out of bounds.

### operator func []\(Int64, T)

```cangjie
public operator func [](index: Int64, value!: T): Unit
```

Function: Operator overload - replaces the element at the specified position in this list with the specified element.

Parameters:

- `index`: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The index to set.
- `value!`: `T` - The value of type T to set.

Exceptions:

- [IndexOutOfBoundsException](../../core/core_package_api/core_package_exceptions.md#class-indexoutofboundsexception) - Thrown when `index` is out of bounds.

### operator func []\(Range\<Int64>)

```cangjie
public operator func [](range: Range<Int64>): ArrayList<T>
```

Function: Operator overload - slice.

> **Note:**
>
> - If the parameter `range` is a [Range](../../core/core_package_api/core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet) instance constructed using the [Range](../../core/core_package_api/core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet) constructor, the following behaviors apply:
>     - The `start` value is exactly the value passed to the constructor, unaffected by the `hasStart` parameter during construction.
>     - When `hasEnd` is false, the `end` value is ineffective and unaffected by the `isClosed` parameter during construction. The array slice will include elements up to the last element of the original array.
>
> - The returned [ArrayList](collection_package_class.md#class-arraylistt) from the slice operation is a completely new object with no reference relationship to the original [ArrayList](collection_package_class.md#class-arraylistt).

Parameters:

- `range`: [Range](../../core/core_package_api/core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet)\<[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)> - The range specifying the slice.

Return Value:

- [ArrayList](collection_package_class.md#class-arraylistt)\<T> - The sliced array.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when `range.[step](collection_package_function.md#func-steptint64)` is not equal to 1.
- [IndexOutOfBoundsException](../../core/core_package_api/core_package_exceptions.md#class-indexoutofboundsexception) - Thrown when `range` is invalid.

### extend\<T> ArrayList\<T> <: Equatable\<ArrayList\<T>> where T <: Equatable\<T>

```cangjie
extend<T> ArrayList<T> <: Equatable<ArrayList<T>> where T <: Equatable<T>
```

Function: Extends the [ArrayList](./collection_package_class.md#class-arraylistt)\<T> type with the [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[ArrayList](./collection_package_class.md#class-arraylistt)\<T>> interface, supporting equality operations.

Parent Types:- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[ArrayList](#class-arraylistt)\<T>>

#### operator func ==(ArrayList\<T>)

```cangjie
public operator func ==(that: ArrayList<T>): Bool
```

Function: Determines whether the current instance is equal to the specified [ArrayList](./collection_package_class.md#class-arraylistt) instance.

Two arrays are considered equal if their corresponding elements are pairwise equal.

Parameters:

- that: [ArrayList](./collection_package_class.md#class-arraylistt)\<T> - The object to compare with.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if equal, otherwise false.

#### operator func !=(ArrayList\<T>)

```cangjie
public operator func !=(that: ArrayList<T>): Bool
```

Function: Determines whether the current instance is not equal to the specified [ArrayList](./collection_package_class.md#class-arraylistt) instance.

Parameters:

- that: [ArrayList](./collection_package_class.md#class-arraylistt)\<T> - The object to compare with.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if not equal, otherwise false.

#### func contains(T)

```cangjie
public func contains(element: T): Bool
```

Function: Determines whether the current array contains the specified element `element`.

Parameters:

- element: T - The element to search for.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if the array contains the specified element, otherwise false.

### extend\<T> ArrayList\<T> <: SortExtension where T <: Comparable\<T> <sup>(deprecated)</sup>

```cangjie
extend<T> ArrayList<T> where T <: Comparable<T>
```

Function: Extends [ArrayList](./collection_package_class.md#class-arraylistt)\<T> with the [SortExtension](../../sort/sort_package_api/sort_package_interfaces.md#interface-sortextension-deprecated) interface to support array sorting.

> **Note:**
>
> This will be deprecated in future versions.

Parent Types:

- [SortExtension](../../sort/sort_package_api/sort_package_interfaces.md#interface-sortextension-deprecated)

#### func sort() <sup>(deprecated)</sup>

```cangjie
public func sort(): Unit
```

Function: Sorts the elements in the current array in ascending order using an unstable sort.

> **Note:**
>
> This will be deprecated in future versions. Use [sort](../../sort/sort_package_api/sort_package_funcs.md#func-sorttlistt-bool-bool-where-t--comparablet) instead.

#### func sort(Bool) <sup>(deprecated)</sup>

```cangjie
public func sort(stable!: Bool): Unit
```

Function: Sorts the elements in the current array in ascending order.

Parameters:

- stable!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether to use a stable sort.

> **Note:**
>
> This will be deprecated in future versions. Use [sort](../../sort/sort_package_api/sort_package_funcs.md#func-sorttlistt-bool-bool-where-t--comparablet) instead.

#### func sortDescending() <sup>(deprecated)</sup>

```cangjie
public func sortDescending(): Unit
```

Function: Sorts the elements in the current array in descending order using an unstable sort.

> **Note:**
>
> This will be deprecated in future versions. Use [sort](../../sort/sort_package_api/sort_package_funcs.md#func-sorttlistt-bool-bool-where-t--comparablet) instead.

#### func sortDescending(Bool) <sup>(deprecated)</sup>

```cangjie
public func sortDescending(stable!: Bool): Unit
```

Function: Sorts the elements in the current array in descending order.

Parameters:

- stable!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether to use a stable sort.

> **Note:**
>
> This will be deprecated in future versions. Use [sort](../../sort/sort_package_api/sort_package_funcs.md#func-sorttlistt-bool-bool-where-t--comparablet) instead.

### extend\<T> ArrayList\<T> <: ToString where T <: ToString

```cangjie
extend<T> ArrayList<T> <: ToString where T <: ToString
```

Function: Extends [ArrayList](./collection_package_class.md#class-arraylistt)\<T> with the [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring) interface to support string conversion.

Parent Types:

- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

#### func toString()

```cangjie
public func toString(): String
```

Function: Converts the current array to a string.

The resulting string contains the string representation of each element in the array, formatted as: "[elem1, elem2, elem3]".

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The converted string.

## class ArrayQueue\<T>

```cangjie
public class ArrayQueue<T> <: Queue<T> {
    public init()
    public init(capacity: Int64)
}
```

Function: A circular queue data structure implemented based on arrays.

Parent Type:

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

Function: Constructs a queue with specified capacity. When capacity is less than the default capacity of 8, the initial capacity of the constructed [ArrayQueue](#class-arrayqueuet) will be 8.

Parameters:

- capacity: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The specified initial capacity.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws exception if the parameter value is less than 0.

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

Function: Gets an iterator for elements in this queue, with front-to-back order.

Return Value:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - An iterator for the elements.

### func isEmpty()

```cangjie
public func isEmpty(): Bool
```

Function: Determines whether this queue is empty.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if empty, otherwise returns `false`.

### func peek()

```cangjie
public func peek():?T
```

Function: Views the head element of this queue. This operation does not remove the element.

Return Value:

- ?T - The head element of the queue, returns `None` if the queue is empty.

### func remove()

```cangjie
public func remove(): ?T
```

Function: Removes and returns the head element of this queue, returns `None` if the queue is empty.

Return Value:

- ?T - The removed head element.

### func reserve(Int64)

```cangjie
public func reserve(additional: Int64): Unit
```

Function: Increases the capacity of this queue.

Expands the queue capacity by the additional size. No expansion occurs when:
1. additional is less than or equal to zero
2. The remaining capacity of this queue is greater than or equal to additional

When the remaining capacity is less than additional, the new capacity will be the maximum value between:
1. Original capacity multiplied by 1.5 (rounded down)
2. additional + used capacity

Parameters:

- additional: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The size to expand.

### func toArray()

```cangjie
public func toArray(): Array<T>
```

Function: Returns an array containing all elements in this queue, with front-to-back order.

Return Value:- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - An array of type T.

### extend\<T> ArrayQueue\<T> <: ToString where T <: ToString

```cangjie
extend<T> ArrayQueue<T> <: ToString where T <: ToString
```

Function: Extends the [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring) interface for [ArrayQueue](./collection_package_class.md#class-arrayqueuet)\<T>, supporting string conversion operations.

Parent Type:

- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

#### func toString()

```cangjie
public func toString(): String
```

Function: Obtains the string representation of the current [ArrayQueue](./collection_package_class.md#class-arrayqueuet)\<T> instance.

The string contains the string representation of each element in the deque in front-to-back order, formatted as: "[elem1, elem2, elem3]".

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The converted string.

## class ArrayStack\<T>

```cangjie
public class ArrayStack<T> <: Stack<T> {
    public init(capacity: Int64)
    public init()
}
```

Function: [ArrayStack](#class-arraystackt) is a stack [Stack](./collection_package_interface.md#interface-stackt) data structure implemented based on an array [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt). ArrayStack uses an array to store stack elements and a pointer to track the position of the top element.

[ArrayStack](#class-arraystackt) supports Last In First Out (LIFO) operations, allowing insertion and deletion only at the head. Additionally, [ArrayStack](#class-arraystackt) dynamically expands its capacity as needed.

Parent Type:

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

Function: Constructs an empty [ArrayStack](#class-arraystackt) with an initial capacity of 8.

### func init(Int64)

```cangjie
public init(capacity: Int64)
```

Function: Constructs an empty [ArrayStack](#class-arraystackt) with the specified initial capacity. If the provided capacity is less than the default capacity of 8, the constructed [ArrayStack](#class-arraystackt) will have an initial capacity of 8.

Parameters:

- capacity: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The initial capacity size.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when the input parameter is negative.

### func add(T)

```cangjie
public func add(element: T): Unit
```

Function: Adds an element to the top of the stack.

Parameters:

- element: T - The element to be added.

### func clear()

```cangjie
public func clear(): Unit
```

Function: Clears the current [ArrayStack](#class-arraystackt).

### func isEmpty()

```cangjie
public func isEmpty(): Bool
```

Function: Checks whether this [ArrayStack](#class-arraystackt) is empty.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if empty, otherwise false.

### func iterator()

```cangjie
public func iterator(): Iterator<T>
```

Function: Returns an iterator for the elements in this [ArrayStack](#class-arraystackt), following the order of stack popping.

Return Value:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - An iterator for the stack elements.

### func peek()

```cangjie
public func peek(): ?T
```

Function: Retrieves the top element of the stack without removing it. Returns `None` if the stack is empty.

Return Value:

- ?T - The top element of the stack.

### func remove()

```cangjie
public func remove(): ?T
```

Function: Pop operation, removes and returns the top element of the stack. Returns `None` when the stack is empty.

Return Value:

- ?T - The removed top element of the stack.

### func reserve(Int64)

```cangjie
public func reserve(additional: Int64): Unit
```

Function: Expands the capacity of the current [ArrayStack](#class-arraystackt) by the specified amount. No expansion occurs if `additional` is less than or equal to zero. If the remaining space is already greater than or equal to `additional`, no expansion is performed. Otherwise, the [ArrayStack](#class-arraystackt) will expand to a size of `size + additional`.

Parameters:

- additional: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The amount of capacity to expand.

### func toArray()

```cangjie
public func toArray(): Array<T>
```

Function: Returns an array containing the elements of the stack in the order they would be popped.

Return Value:

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - An array of type T.

### extend\<T> ArrayStack\<T> <: ToString where T <: ToString

```cangjie
extend<T> ArrayStack<T> <: ToString where T <: ToString
```

Function: Extends the [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring) interface for ArrayStack, enabling string conversion.

Parent Type:

- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

#### func toString()

```cangjie
public func toString(): String
```

Function: Retrieves the string representation of the current [ArrayStack](./collection_package_class.md#class-arraystackt)\<T> instance.

The string includes the string representation of each element in the stack, ordered from back to front, formatted as: "[elem1, elem2, elem3]".

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string representation of the current stack.

## class HashMapIterator\<K, V> where K <: Hashable & Equatable\<K>

```cangjie
public class HashMapIterator<K, V> <: Iterator<(K, V)> where K <: Hashable & Equatable<K> {
    public init(map: HashMap<K, V>)
}
```

Function: This class primarily implements the iterator functionality for [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek).

Parent Type:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<(K, V)>

### init(HashMap\<K, V>)

```cangjie
public init(map: HashMap<K, V>)
```

Function: Creates an instance of [HashMapIterator](collection_package_class.md#class-hashmapiteratork-v-where-k--hashable--equatablek)\<K, V>.

Parameters:

- [map](collection_package_function.md#func-mapt-rt---r): [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek)\<K, V> - The input [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek)\<K, V>.

### func next()

```cangjie
public func next(): ?(K, V)
```

Function: Returns the next element in the iterator.

Return Value:

- ?(K, V) - The next element in the iterator, encapsulated in [Option](../../core/core_package_api/core_package_enums.md#enum-optiont).

Exceptions:

- [ConcurrentModificationException](collection_package_exception.md#class-concurrentmodificationexception) - Thrown when the function detects unsynchronized concurrent modifications.

### func remove()

```cangjie
public func remove(): Option<(K, V)>
```

Function: Removes the element returned by the `next` function of this [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) iterator. This function can only be called once per call to `next`.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<(K, V)> - The removed element.

Exceptions:

- [ConcurrentModificationException](collection_package_exception.md#class-concurrentmodificationexception) - Thrown when the function detects unsynchronized concurrent modifications.

## class HashMap\<K, V> where K <: Hashable & Equatable\<K>

```cangjie
public class HashMap<K, V> <: Map<K, V> where K <: Hashable & Equatable<K> {
    public init()
    public init(elements: Array<(K, V)>)
    public init(elements: Collection<(K, V)>)
    public init(capacity: Int64)
    public init(size: Int64, initElement: (Int64) -> (K, V))
}
```

Function: A hash table implementation of the [Map](collection_package_interface.md#interface-mapk-v) interface.

A hash table is a commonly used data structure that enables fast lookup, insertion, and deletion of data. The basic principle of a hash table is to map data to an array, known as the hash table. Each data element has a corresponding hash value, which determines its position in the hash table.

Hash tables are characterized by fast lookup, insertion, and deletion operations, typically with O(1) time complexity. Since the underlying array size is dynamic, hash tables do not guarantee immutable element order.

Parent Type:

- [Map](collection_package_interface.md#interface-mapk-v)\<K, V>

### prop capacity

```cangjie
public prop capacity: Int64
```

Function: Returns the capacity of the [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek).

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The capacity of the [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek).

### prop size

```cangjie
public prop size: Int64
```

Function: Returns the number of key-value pairs.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### init()

```cangjie
public init()
```

Function: Constructs a [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) with a default initial capacity of 16 and a default load factor of empty.

### init(Array\<(K, V)>)

```cangjie
public init(elements: Array<(K, V)>)
```

Function: Constructs a [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) using the provided array of key-value pairs.

This constructor sets the capacity of the [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) based on the size of the input array. Since duplicate keys are not allowed internally in [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek), if duplicate keys exist in the [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt), the later key-value pairs will overwrite the earlier ones according to the iterator order.

Parameters:

- elements: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<(K, V)> - The array of key-value pairs used to initialize this [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek).

### init(Collection\<(K, V)>)

```cangjie
public init(elements: Collection<(K, V)>)
```

Function: Constructs a [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) using the provided collection of key-value pairs.

This constructor sets the capacity of the [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) based on the size of the input collection elements. Since duplicate keys are not allowed internally in [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek), if duplicate keys exist in the [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt), the later key-value pairs will overwrite the earlier ones according to the iterator order.

Parameters:

- elements: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<(K, V)> - The collection of key-value pairs used to initialize this [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek).

### init(Int64)

```cangjie
public init(capacity: Int64)
```

Function: Constructs a [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) with the specified initial capacity.

Parameters:

- capacity: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The initial capacity size.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception if capacity is less than 0.

### init(Int64, (Int64) -> (K, V))

```cangjie
public init(size: Int64, initElement: (Int64) -> (K, V))
```

Function: Constructs a [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) using the specified size and initialization function.

The capacity of the constructed [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) is influenced by the size parameter. Since duplicate keys are not allowed internally in [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek), if the initElement function generates duplicate keys, the later key-value pairs will overwrite the earlier ones.

Parameters:

- size: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The number of elements to initialize the [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek).
- initElement: ([Int64](../../core/core_package_api/core_package_intrinsics.md#int64)) -> (K, V) - The function rule used to initialize the [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek).

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Throws an exception if size is less than 0.

### func add(K, V)

```cangjie
public func add(key: K, value: V): Option<V>
```

Function: Inserts a key-value pair into the [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek).

For keys already present in the [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek), the value will be replaced with the new value, and the old value will be returned.

Parameters:

- key: K - The key to insert.
- value: V - The value to assign.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<V> - If the key existed before assignment, the old value is encapsulated in [Option](../../core/core_package_api/core_package_enums.md#enum-optiont); otherwise, returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<V>.None.

Example:

See usage example in [HashMap's get/add/contains functions](../collection_package_samples/sample_hashmap_get_add_contains.md).

### func add(Collection\<(K, V)>)

```cangjie
public func add(all!: Collection<(K, V)>): Unit
```

Function: Inserts a new collection of key-value pairs into the [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) according to the iterator order of elements.

For keys already present in the [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek), the values will be replaced with the new values.

Parameters:

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<(K, V)> - The collection of key-value pairs to add to the [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek).

Example:

See usage example in [HashMap's add/remove/clear functions](../collection_package_samples/sample_hashmap_add_remove_clear.md).

### func addIfAbsent(K, V)

```cangjie
func addIfAbsent(key: K, value: V): ?V
```

Function: Adds the specified key-value pair if the key is not already present in the current [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek). Otherwise, no modification is made.

Parameters:

- key: K - The key of the key-value pair to add.
- value: V - The value of the key-value pair to add.

Return Value:

- ?V - If the specified key already exists in the current [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) when this function is called, returns the old value associated with the key; otherwise, returns None.

### func clear()

```cangjie
public func clear(): Unit
```

Function: Clears all key-value pairs.

Example:

See usage example in [HashMap's add/remove/clear functions](../collection_package_samples/sample_hashmap_add_remove_clear.md).

### func clone()

```cangjie
public func clone(): HashMap<K, V>
```

Function: Clones a [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek).

Return Value:

- [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek)\<K, V> - Returns a cloned [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek).

### func contains(K)

```cangjie
public func contains(key: K): Bool
```

Function: Determines whether a mapping for the specified key exists.

Parameters:

- key: K - The key to check.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if the key exists; otherwise, returns false.

Example:

For usage examples, see [HashMap's get/add/contains functions](../collection_package_samples/sample_hashmap_get_add_contains.md).

### func contains(Collection\<K>)

```cangjie
public func contains(all!: Collection<K>): Bool
```

Function: Determines whether mappings for all keys in the specified collection exist.

Parameters:

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<K> - The collection of keys to check.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if all keys are present; otherwise, returns false.

### func entryView(K)

```cangjie
public func entryView(key: K): MapEntryView<K, V>
```

Function: Returns an empty reference view if the specified key does not exist. If the key exists, returns a reference view of the corresponding element.

Parameters:

- key: K - The key to add or check.

Return Value:

- [MapEntryView](./collection_package_interface.md#interface-mapentryviewk-v)\<K, V> - A reference view.

### func get(K)

```cangjie
public func get(key: K): ?V
```

Function: Returns the value mapped to the specified key. If the [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) does not contain a mapping for the key, returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<V>.None.

Parameters:

- key: K - The key to look up.

Return Value:

- ?V - The value associated with the key, wrapped in [Option](../../core/core_package_api/core_package_enums.md#enum-optiont).

Example:

For usage examples, see [HashMap's get/add/contains functions](../collection_package_samples/sample_hashmap_get_add_contains.md).

### func isEmpty()

```cangjie
public func isEmpty(): Bool
```

Function: Determines whether the [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) is empty. Returns true if empty; otherwise, returns false.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Whether the [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) is empty.

### func iterator()

```cangjie
public func iterator(): HashMapIterator<K, V>
```

Function: Returns an iterator for the HashMap.

Return Value:

- [HashMapIterator](collection_package_class.md#class-hashmapiteratork-v-where-k--hashable--equatablek)\<K, V> - An iterator for the [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek).

### func keys()

```cangjie
public func keys(): EquatableCollection<K>
```

Function: Returns all keys in the [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek), stored in a Keys container.

Return Value:

- [EquatableCollection](collection_package_interface.md#interface-equatablecollectiont)\<K> - A container holding all returned keys.

### func remove(Collection\<K>)

```cangjie
public func remove(all!: Collection<K>): Unit
```

Function: Removes mappings for all keys in the specified collection from this [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) (if they exist).

Parameters:

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<K> - The collection of keys to remove.

### func remove(K)

```cangjie
public func remove(key: K): Option<V>
```

Function: Removes the mapping for the specified key from this [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) (if it exists).

Parameters:

- key: K - The key to remove.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<V> - The value associated with the removed key, wrapped in [Option](../../core/core_package_api/core_package_enums.md#enum-optiont). Returns None if the key does not exist in the [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek).

Example:For usage examples, see [HashMap's add/remove/clear functions](../collection_package_samples/sample_hashmap_add_remove_clear.md).

### func removeIf((K, V) -> Bool)

```cangjie
public func removeIf(predicate: (K, V) -> Bool): Unit
```

Function: Takes a lambda expression and removes key-value pairs that meet the specified condition.

This function traverses the entire [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek), so all key-value pairs satisfying `predicate(K, V) == true` will be removed.

Parameters:

- predicate: (K, V) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - A lambda expression used for evaluation.

Exceptions:

- [ConcurrentModificationException](./collection_package_exception.md#class-concurrentmodificationexception) - Thrown when key-value pairs are added, removed, or modified within the `predicate` in [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek).

### func replace(K, V)

```cangjie
func replace(key: K, value: V): ?V
```

Function: If the specified key exists in the current [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek), updates its value to the given value. Otherwise, no modification is made.

Parameters:

- key: K - The key of the key-value pair to be modified.
- value: V - The new value for the key-value pair.

Return Value:

- ?V - If the specified key exists in the current [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek), returns its old value. Otherwise, returns None.

### func reserve(Int64)

```cangjie
public func reserve(additional: Int64): Unit
```

Function: Expands the current [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek).

Expands the [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) by the specified additional size. No expansion occurs if additional is less than or equal to zero. If the remaining capacity of the [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) is greater than or equal to additional, no expansion occurs. If the remaining capacity is less than additional, the expansion size is determined by the maximum of (1.5 times the original capacity rounded down) and (additional + used capacity).

Parameters:

- additional: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The size to expand by.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when additional + used capacity exceeds Int64.Max.

### func toArray()

```cangjie
public func toArray(): Array<(K, V)>
```

Function: Constructs and returns an array containing all key-value pairs in the [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek).

Return Value:

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<(K, V)> - An array containing all key-value pairs in the container.

### func values()

```cangjie
public func values(): Collection<V>
```

Function: Returns all values in the [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek), stored in a Values container.

Return Value:

- [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<V> - A container holding all returned values.

### operator func []\(K, V)

```cangjie
public operator func [](key: K, value!: V): Unit
```

Function: Operator overload for the add method. If the key exists, the new value overwrites the old value. If the key does not exist, the key-value pair is added.

Parameters:

- key: K - The key for evaluation.
- value!: V - The value to be set.

#### operator func []\(K)

```cangjie
public operator func [](key: K): V
```

Function: Operator overload for the get method. If the key exists, returns the corresponding value.

Parameters:

- key: K - The key for evaluation.

Return Value:

- V - The value corresponding to the key.

Exceptions:

- [NoneValueException](../../core/core_package_api/core_package_exceptions.md#class-nonevalueexception) - Thrown if the key does not exist in the [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek).

### extend\<K, V> HashMap\<K, V> <: Equatable\<HashMap\<K, V>> where V <: Equatable\<V>

```cangjie
extend<K, V> HashMap<K, V> <: Equatable<HashMap<K, V>> where V <: Equatable<V>
```

Function: Extends the [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[HashMap](./collection_package_class.md#class-hashmapk-v)\<K, V>> interface for the [HashMap](./collection_package_class.md#class-hashmapk-v)\<K, V> type, supporting equality operations.

Parent Type:

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[HashMap](./collection_package_class.md#class-hashmapk-v)\<K, V>>

#### operator func ==(HashMap\<K, V>)

```cangjie
public operator func ==(right: HashMap<K, V>): Bool
```

Function: Determines whether the current instance is equal to the specified [HashMap](./collection_package_class.md#class-hashmapk-v)\<K, V> instance.

Two [HashMap](./collection_package_class.md#class-hashmapk-v)\<K, V> instances are considered equal if they contain identical key-value pairs.

Parameters:

- right: [HashMap](./collection_package_class.md#class-hashmapk-v)\<K, V> - The object to compare.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if equal, otherwise false.

#### operator func !=(HashMap\<K, V>)

```cangjie
public operator func !=(right: HashMap<K, V>): Bool
```

Function: Determines whether the current instance is not equal to the specified [HashMap](./collection_package_class.md#class-hashmapk-v)\<K, V> instance.Parameters:

- right: [HashMap](./collection_package_class.md#class-hashmapk-v)\<K, V> - The object to be compared.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if not equal, otherwise returns false.

### extend\<K, V> HashMap\<K, V> <: ToString where V <: ToString, K <: ToString

```cangjie
extend<K, V> HashMap<K, V> <: ToString where V <: ToString, K <: ToString
```

Function: Extends the [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring) interface for [HashMap](./collection_package_class.md#class-hashmapk-v)\<K, V>, enabling string conversion operations.

Parent Type:

- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

#### func toString()

```cangjie
public func toString(): String
```

Function: Converts the current [HashMap](./collection_package_class.md#class-hashmapk-v)\<K, V> instance to a string.

The string includes the string representation of each key-value pair in the [HashMap](./collection_package_class.md#class-hashmapk-v)\<K, V>, formatted as: "[(k1, v1), (k2, v2), (k3, v3)]".

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The converted string.

## class HashSet\<T> where T <: Hashable & Equatable\<T>

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

Elements in [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) are unordered and do not allow duplicates. When adding elements to [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet), the hash value of the element determines its position in the hash table.

> **Note:**
>
> [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) is implemented based on [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek), so its capacity, memory layout, and time performance are identical to [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek).

Parent Type:

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

Function: Constructs a [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) using the specified element count `size` and initialization function. The capacity of the constructed [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) is influenced by `size`.

Parameters:

- size: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The number of elements in the initialization function.
- initElement: ([Int64](../../core/core_package_api/core_package_intrinsics.md#int64)) -> T - The initialization function rule.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if `size` is less than 0.

### init()

```cangjie
public init()
```

Function: Constructs an empty [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) with an initial capacity of 16.

### init(Array\<T>)

```cangjie
public init(elements: Array<T>)
```

Function: Constructs a [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) using the specified array. The constructor sets the capacity of the [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) based on the size of the input array `elements`.

Parameters:

- elements: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - The array used to initialize the [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet).

### init(Collection\<T>)

```cangjie
public init(elements: Collection<T>)
```

Function: Constructs a [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) using the specified collection. The constructor sets the capacity of the [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) based on the size of the input collection `elements`.

Parameters:

- elements: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T> - The collection used to initialize the [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet).

### init(Int64)

```cangjie
public init(capacity: Int64)
```

Function: Constructs a [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) with the specified capacity.

Parameters:

- capacity: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The initial capacity size.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if `capacity` is less than 0.

### func add(T)

```cangjie
public func add(element: T): Bool
```

Function: Adds the specified element to the [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet). If the element already exists, the addition fails.

Parameters:

- element: T - The specified element.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if the addition is successful; otherwise, returns false.For usage examples, refer to [HashSet's add/iterator/remove functions](../collection_package_samples/sample_hashset_add_iterator_remove.md).

### func add(Collection\<T>)

```cangjie
public func add(all!: Collection<T>): Unit
```

Function: Adds all elements from the [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont) to this [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet). If an element already exists, it will not be added.

Parameters:

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T> - The collection of elements to be added.

### prop capacity

```cangjie
public prop capacity: Int64
```

Function: Returns the internal array capacity of this [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet).

> **Note:**
>
> The capacity may not equal the size of the [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet).

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

- [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet)\<T> - Returns the cloned [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet).

### func contains(T)

```cangjie
public func contains(element: T): Bool
```

Function: Determines whether the [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) contains the specified element.

Parameters:

- element: T - The specified element.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if the element is contained; otherwise, returns false.

### func contains(Collection\<T>)

```cangjie
public func contains(all!: Collection<T>): Bool
```

Function: Determines whether the [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) contains all elements from the specified [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont).

Parameters:

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T> - The specified collection of elements.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if this [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) contains all elements from the [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont); otherwise, returns false.

### func isEmpty()

```cangjie
public func isEmpty(): Bool
```

Function: Determines whether the [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) is empty.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if empty; otherwise, returns false.

### func iterator()

```cangjie
public func iterator(): Iterator<T>
```

Function: Returns an iterator for this [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet).

Return Value:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - Returns the iterator for this [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet).

Example:

For usage examples, refer to [HashSet's add/iterator/remove functions](../collection_package_samples/sample_hashset_add_iterator_remove.md).

### func remove(T)

```cangjie
public func remove(element: T): Bool
```

Function: Removes the specified element from this [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) if it exists.

Parameters:

- element: T - The element to be removed.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if removal is successful; otherwise, returns false.

Example:

For usage examples, refer to [HashSet's add/iterator/remove functions](../collection_package_samples/sample_hashset_add_iterator_remove.md).

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

Function: Passes a lambda expression, and removes the corresponding element if the condition evaluates to `true`.

Parameters:

- predicate: (T) ->[Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The condition predicate that determines whether to remove the element.

Exceptions:

- [ConcurrentModificationException](./collection_package_exception.md#class-concurrentmodificationexception) - Thrown when elements are added, removed, or modified within the `predicate` while operating on the [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet).

### func reserve(Int64)

```cangjie
public func reserve(additional: Int64): Unit
```

Function: Expands the capacity of [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) by the specified additional size. No expansion occurs if:
1. `additional` is less than or equal to zero
2. The remaining capacity of [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) is greater than or equal to `additional`

When expansion is required, the new capacity will be the maximum between:
1. The floor value of 1.5 times the original capacity
2. The sum of `additional` and currently used capacity

Parameters:

- additional: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The additional capacity to reserve.

Exceptions:

- [OverflowException](../../core/core_package_api/core_package_exceptions.md#class-overflowexception) - Thrown when the sum of `additional` and currently used capacity exceeds Int64.Max.

### func retain(Set\<T>)

```cangjie
public func retain(all!: Set<T>): Unit
```

Function: Retains only the elements in this [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) that are contained in the specified [Set](collection_package_interface.md#interface-sett).

Parameters:

- all!: [Set](collection_package_interface.md#interface-sett)\<T> - The set of elements to retain.

### func subsetOf(ReadOnlySet\<T>)

```cangjie
public func subsetOf(other: ReadOnlySet<T>): Bool
```

Function: Determines whether this set is a subset of the specified [ReadOnlySet](collection_package_interface.md#interface-readonlysett).

Parameters:

- other: [ReadOnlySet](collection_package_interface.md#interface-readonlysett)\<T> - The set to compare against.

Returns:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if this [Set](collection_package_interface.md#interface-sett) is a subset of the specified [ReadOnlySet](collection_package_interface.md#interface-readonlysett); otherwise, `false`.

### func toArray()

```cangjie
public func toArray(): Array<T>
```

Function: Returns an array containing all elements in this container.

Returns:

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - An array of type T.

### operator func &(ReadOnlySet\<T>)

```cangjie
public operator func &(other: ReadOnlySet<T>): HashSet<T>
```

Function: Returns a new set containing the intersection of elements from both sets.

Parameters:

- other: [ReadOnlySet](collection_package_interface.md#interface-readonlysett)\<T> - The input set.

Returns:

- [HashSet](./collection_package_class.md#class-hashsett-where-t--hashable--equatablet)\<T> - A new set of type T.

### operator func |(ReadOnlySet\<T>)

```cangjie
public operator func |(other: ReadOnlySet<T>): HashSet<T>
```

Function: Returns a new set containing the union of elements from both sets.

Parameters:

- other: [ReadOnlySet](collection_package_interface.md#interface-readonlysett)\<T> - The input set.

Returns:

- [HashSet](./collection_package_class.md#class-hashsett-where-t--hashable--equatablet)\<T> - A new set of type T.

### operator func -(ReadOnlySet\<T>)

```cangjie
public operator func -(other: ReadOnlySet<T>): HashSet<T>
```

Function: Returns a new set containing the difference of elements between sets.

Parameters:

- other: [ReadOnlySet](collection_package_interface.md#interface-readonlysett)\<T> - The input set.

Returns:

- [HashSet](./collection_package_class.md#class-hashsett-where-t--hashable--equatablet)\<T> - A new set of type T.

### extend\<T> HashSet\<T> <: Equatable\<HashSet\<T>>

```cangjie
extend<T> HashSet<T> <: Equatable<HashSet<T>>
```

Function: Extends the [HashSet](./collection_package_class.md#class-hashsett-where-t--hashable--equatablet)\<T> type to implement the [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[HashSet](./collection_package_class.md#class-hashsett-where-t--hashable--equatablet)\<T>> interface, enabling equality comparison operations.

Parent Type:

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[HashSet](./collection_package_class.md#class-hashsett-where-t--hashable--equatablet)\<T>>

#### operator func ==(HashSet\<T>)

```cangjie
public operator func ==(that: HashSet<T>): Bool
```

Function: Determines whether the current instance is equal to the specified [HashSet](./collection_package_class.md#class-hashsett-where-t--hashable--equatablet)\<T> instance.

Two [HashSet](./collection_package_class.md#class-hashsett-where-t--hashable--equatablet)\<T> instances are considered equal if they contain exactly the same elements.

Parameters:

- that: [HashSet](./collection_package_class.md#class-hashsett-where-t--hashable--equatablet)\<T> - The instance to compare.

Returns:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if equal, otherwise `false`.

#### operator func !=(HashSet\<T>)

```cangjie
public operator func !=(that: HashSet<T>): Bool
```

Function: Determines whether the current instance is not equal to the [HashSet](./collection_package_class.md#class-hashsett-where-t--hashable--equatablet)\<T> instance pointed to by the parameter.

Parameters:

- that: [HashSet](./collection_package_class.md#class-hashsett-where-t--hashable--equatablet)\<T> - The object to be compared.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if not equal, otherwise returns false.

### extend\<T> HashSet\<T> <: ToString where T <: ToString

```cangjie
extend<T> HashSet<T> <: ToString where T <: ToString
```

Function: Extends the [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring) interface for [HashSet](./collection_package_class.md#class-hashsett-where-t--hashable--equatablet)\<T>, supporting string conversion operations.

Parent Type:

- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

#### func toString()

```cangjie
public func toString(): String
```

Function: Converts the current [HashSet](./collection_package_class.md#class-hashsett-where-t--hashable--equatablet)\<T> instance to a string.

The string includes the string representation of each element in the [HashSet](./collection_package_class.md#class-hashsett-where-t--hashable--equatablet)\<T>, formatted as: "[elem1, elem2, elem3]".

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The converted string.

## class LinkedListNode\<T>

```cangjie
public class LinkedListNode<T>
```

Function: [LinkedListNode](collection_package_class.md#class-linkedlistnodet) is a node in [LinkedList](collection_package_class.md#class-linkedlistt).

Through [LinkedListNode](collection_package_class.md#class-linkedlistnodet), bidirectional traversal operations can be performed on [LinkedList](collection_package_class.md#class-linkedlistt), and the value of the element can be accessed and modified.

[LinkedListNode](collection_package_class.md#class-linkedlistnodet) can only be obtained via the 'nodeAt', 'firstNode', or 'lastNode' methods of the corresponding [LinkedList](collection_package_class.md#class-linkedlistt). When the corresponding node is removed from [LinkedList](collection_package_class.md#class-linkedlistt), it results in a dangling node. Any operation on a dangling node will throw an '[IllegalStateException](../../core/core_package_api/core_package_exceptions.md#class-illegalstateexception)'.

### prop next

```cangjie
public prop next: Option<LinkedListNode<T>>
```

Function: Gets the next node of the current node. Returns None if there is no next node.

Type: [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[LinkedListNode](collection_package_class.md#class-linkedlistnodet)\<T>>

Exceptions:

- [IllegalStateException](../../core/core_package_api/core_package_exceptions.md#class-illegalstateexception) - Thrown if the node does not belong to any linked list instance.

### prop prev

```cangjie
public prop prev: Option<LinkedListNode<T>>
```

Function: Gets the previous node of the current node. Returns None if there is no previous node.

Type: [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[LinkedListNode](collection_package_class.md#class-linkedlistnodet)\<T>>

Exceptions:

- [IllegalStateException](../../core/core_package_api/core_package_exceptions.md#class-illegalstateexception) - Thrown if the node does not belong to any linked list instance.

### prop value

```cangjie
public mut prop value: T
```

Function: Gets or modifies the value of the element.

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

A doubly linked list is a common data structure composed of a series of nodes, where each node contains two pointers: one pointing to the previous node and another pointing to the next node. This structure allows bidirectional traversal from any node, either starting from the head node and moving forward or starting from the tail node and moving backward.

[LinkedList](collection_package_class.md#class-linkedlistt) does not support concurrent operations, and modifications to elements in the collection do not invalidate iterators. Iterators are only invalidated when elements are added or removed.

Parent Type:

- [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T>

### prop first

```cangjie
public prop first: ?T
```

Function: The value of the first element in the linked list. Returns None if the list is empty.

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

Function: The value of the last element in the linked list. Returns None if the list is empty.

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

### init

```cangjie
public init()
```

Function: Constructs an empty linked list.

### init(Array\<T>)

```cangjie
public init(elements: Array<T>)
```

Function: Constructs a [LinkedList](collection_package_class.md#class-linkedlistt) instance containing elements from the specified array in traversal order.

Parameters:

- elements: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - The array of elements to be placed into this linked list.

### init(Collection\<T>)

```cangjie
public init(elements: Collection<T>)
```

Function: Constructs a linked list containing elements from the specified collection in the order returned by the collection's iterator.

Parameters:

- elements: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T> - The collection of elements to be placed into this linked list.

### init(Int64, (Int64)-> T)

```cangjie
public init(size: Int64, initElement: (Int64)-> T)
```

Function: Creates a linked list with `size` elements, where the nth element satisfies the condition ([Int64](../../core/core_package_api/core_package_intrinsics.md#int64))-> T.

Parameters:

- size: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The number of elements to create in the linked list.
- initElement: ([Int64](../../core/core_package_api/core_package_intrinsics.md#int64)) ->T - The initialization parameter for elements.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if the specified linked list length is less than 0.

### func addLast(T)

```cangjie
public func addLast(element: T): LinkedListNode<T>
```

Function: Adds an element at the tail position of the linked list and returns the node of this element.

Parameters:

- element: T - The element to be added to the linked list.

Return Value:

- [LinkedListNode](collection_package_class.md#class-linkedlistnodet)\<T> - The node pointing to this element.

### func backward(LinkedListNode\<T>)

```cangjie
public func backward(mark: LinkedListNode<T>): Iterator<T>
```

Function: Obtains an iterator for all elements starting from the `mark` node to the head node of the corresponding linked list.

Parameters:

- mark: [LinkedListNode](collection_package_class.md#class-linkedlistnodet)\<T> - The starting element node.

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

Function: Obtains an iterator for all elements starting from the `mark` node to the tail node of the corresponding linked list.

Parameters:

- mark: [LinkedListNode](collection_package_class.md#class-linkedlistnodet)\<T> - The starting element node.

Return Value:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - The iterator for corresponding elements.

Exceptions:

- [IllegalStateException](../../core/core_package_api/core_package_exceptions.md#class-illegalstateexception) - Thrown if the node does not belong to any linked list instance.

### func addAfter(LinkedListNode\<T>,T)

```cangjie
public func addAfter(node: LinkedListNode<T>, element: T): LinkedListNode<T>
```

Function: Inserts an element after the specified node in the linked list and returns the node of this element.

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

Function: Inserts an element before a specified node in the linked list and returns the node of the inserted element.

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

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if this linked list contains no elements.

### func iterator()

```cangjie
public func iterator(): Iterator<T>
```

Function: Returns an iterator over the elements in this collection, in order from the first node to the last node of the linked list.

Return Value:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - An iterator over the elements in this collection.

### func nodeAt(Int64)

```cangjie
public func nodeAt(index: Int64): Option<LinkedListNode<T>>
```

Function: Retrieves the node of the element at the specified `index` (0-based).

The time complexity of this function is O(n).

Parameters:

- index: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The index of the node to retrieve.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<[LinkedListNode](collection_package_class.md#class-linkedlistnodet)\<T>> - The node at the specified index, or `None` if no such node exists.

### func removeFirst()

```cangjie
public func removeFirst() : ?T
```

Function: Removes the first element from the linked list and returns its value.

Return Value:

- ?T - The value of the removed element, or `None` if the list is empty.

### func removeLast()

```cangjie
public func removeLast() : ?T
```

Function: Removes the last element from the linked list and returns its value.

Return Value:

- ?T - The value of the removed element, or `None` if the list is empty.

### func addFirst(T)

```cangjie
public func addFirst(element: T): LinkedListNode<T>
```

Function: Inserts an element at the head of the linked list and returns its node.

Parameters:

- element: T - The element to be added to the linked list.

Return Value:

- [LinkedListNode](collection_package_class.md#class-linkedlistnodet)\<T> - The node pointing to the inserted element.

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

- predicate: (T) ->[Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` for elements to be removed.

Exceptions:

- [ConcurrentModificationException](./collection_package_exception.md#class-concurrentmodificationexception) - Thrown if nodes are added, removed, or modified within the `predicate` function in [LinkedList](./collection_package_class.md#class-linkedlistt).

### func reverse()

```cangjie
public func reverse(): Unit
```

Function: Reverses the order of elements in this linked list.

### func splitOff(LinkedListNode\<T>)

```cangjie
public func splitOff(node: LinkedListNode<T>): LinkedList<T>
```

Function: Splits the linked list into two lists starting from the specified node. If successful, the specified node `node` will no longer be in the current list but will be the first node in the new list.

Parameters:

- node: [LinkedListNode](collection_package_class.md#class-linkedlistnodet)\<T> - The position at which to split.

Return Value:

- [LinkedList](collection_package_class.md#class-linkedlistt)\<T> - The newly created linked list after splitting the original list.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if the specified node does not belong to this linked list.

### func toArray()

```cangjie
public func toArray(): Array<T>
```

Function: Returns an array containing all elements in this linked list, maintaining the same order as the linked list.

Return Value:

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - An array of type T.

### extend\<T> LinkedList\<T> <: Equatable\<LinkedList\<T>> where T <: Equatable\<T>

```cangjie
extend<T> LinkedList<T> <: Equatable<LinkedList<T>> where T <: Equatable<T>
```

Function: Extends the [LinkedList](./collection_package_class.md#class-linkedlistt)\<T> type with the [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[LinkedList](./collection_package_class.md#class-linkedlistt)\<T>> interface, enabling equality comparison operations.

Parent Types:

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[LinkedList](#class-linkedlistt)\<T>>

#### operator func ==(LinkedList\<T>)

```cangjie
public operator func ==(right: LinkedList<T>): Bool
```

Function: Determines whether the current instance is equal to the parameter-specified [LinkedList](./collection_package_class.md#class-linkedlistt)\<T> instance.

Two [LinkedList](./collection_package_class.md#class-linkedlistt)\<T> instances are considered equal if they contain identical elements.

Parameters:

- right: [LinkedList](./collection_package_class.md#class-linkedlistt)\<T> - The object to compare.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if equal, otherwise false.

#### operator func !=(LinkedList\<T>)

```cangjie
public operator func !=(right: LinkedList<T>): Bool
```

Function: Determines whether the current instance is not equal to the parameter-specified [LinkedList](./collection_package_class.md#class-linkedlistt)\<T> instance.

Parameters:

- right: [LinkedList](./collection_package_class.md#class-linkedlistt)\<T> - The object to compare.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if not equal, otherwise false.

### extend\<T> LinkedList\<T> <: ToString where T <: ToString

```cangjie
extend<T> LinkedList<T> <: ToString where T <: ToString
```

Function: Extends [LinkedList](./collection_package_class.md#class-linkedlistt)\<T> with the [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring) interface, enabling string conversion operations.

Parent Types:

- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

#### func toString()

```cangjie
public func toString(): String
```

Function: Converts the current [LinkedList](./collection_package_class.md#class-linkedlistt)\<T> instance to a string.

The resulting string contains the string representation of each element in the [LinkedList](./collection_package_class.md#class-linkedlistt)\<T>, formatted as: "[elem1, elem2, elem3]".

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The converted string.

## class TreeMap\<K, V> where K <: Comparable\<K>

```cangjie
public class TreeMap<K, V> <: OrderedMap<K, V> where K <: Comparable<K> {
    public init()
    public init(elements: Collection<(K, V)>)
    public init(elements: Array<(K,V)>)
    public init(size: Int64, initElement: (Int64) -> (K, V))
}
```

Function: An implementation of the [OrderedMap](collection_package_interface.md#interface-orderedmapk-v) interface based on a balanced binary search tree.

The primary purpose of this class is to provide an ordered key-value storage structure that supports fast insertion, deletion, and lookup operations.

[TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek) can be used in any scenario requiring ordered key-value storage, such as databases, caches, lookup tables, etc.

Parent Types:

- [OrderedMap](collection_package_interface.md#interface-orderedmapk-v)\<K, V>

### prop first

```cangjie
public prop first: ?(K, V)
```

Function: Gets the first element of the [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek).

Return Value:

- ?(K, V) - If the first element exists, returns it wrapped in [Option](../../core/core_package_api/core_package_enums.md#enum-optiont); otherwise returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<(K, V)>.None.

### prop last

```cangjie
public prop last: ?(K, V)
```

Function: Gets the last element of the [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek).

Return Value:

- ?(K, V) - If the last element exists, returns it wrapped in [Option](../../core/core_package_api/core_package_enums.md#enum-optiont); otherwise returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<(K, V)>.None.

### prop size

```cangjie
public prop size: Int64
```

Function: Returns the number of key-value pairs.

Type: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64)

### init()

```cangjie
public init()
```

Function: Constructs an empty [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek).

### init(Array\<(K,V)>)

```cangjie
public init(elements: Array<(K,V)>)
```

Function: Constructs a [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek) from an array of key-value pairs.

Elements are inserted into the [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek) in the order they appear in `elements`. Since duplicate keys are not allowed in [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek), if duplicate keys exist in `elements`, the latter key-value pair will overwrite the former.

Parameters:

- elements: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<(K, V)> - The key-value pair array used to initialize this [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek).

### init(Collection\<(K, V)>)

```cangjie
public init(elements: Collection<(K, V)>)
```

Function: Constructs a [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek) from a collection of key-value pairs.

Elements are inserted into the [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek) in the order of the collection's iterator. Since duplicate keys are not allowed in [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek), if duplicate keys exist in `elements`, the latter key-value pair (in iterator order) will overwrite the former.

Parameters:

- elements: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<(K, V)> - The key-value pair collection used to initialize this [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek).

### init(Int64, (Int64) -> (K, V))

```cangjie
public init(size: Int64, initElement: (Int64) -> (K, V))
```

Function: Constructs a [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek) using a size parameter and an initialization function.

Parameters:

- size: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The number of elements to initialize.
- initElement: ([Int64](../../core/core_package_api/core_package_intrinsics.md#int64)) -> (K, V) - The function rule for initializing this [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek).

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if size is less than 0.

### func add(K, V)

```cangjie
public func add(key: K, value: V): Option<V>
```

Function: Inserts a new key-value pair into the [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek). For existing keys in the [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek), the value will be replaced with the new value.

Parameters:

- key: K - The key to insert.
- value: V - The value to assign.

Returns:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<V> - If the key previously existed, the old value is wrapped in [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) and returned; otherwise, returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<V>.None.

### func add(Collection\<(K, V)>)

```cangjie
public func add(all!: Collection<(K, V)>): Unit
```

Function: Inserts a collection of key-value pairs into the [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek). For existing keys in the [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek), the values will be replaced with the new values.

Parameters:

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<(K, V)> - The collection of key-value pairs to add to the [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek).

### func backward(K, Bool)

```cangjie
public func backward(mark: K, inclusive!: Bool = true): Iterator<(K, V)>
```

Function: Gets an iterator that traverses from the first node with a key less than or equal to `mark` in descending order to [first](./collection_package_class.md#prop-first-3). If the node's key equals `mark`, inclusion of that node is determined by `inclusive!`.

Parameters:

- mark: K - The key used to determine the starting point.
- inclusive!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - When `mark` is the key of the first element in the iterator, specifies whether to include `mark` as the starting point (default: `true`).

Returns:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<(K, V)> - The iterator for the corresponding elements.

### func clear()

```cangjie
public func clear(): Unit
```

Function: Clears all key-value pairs.

### func clone()

```cangjie
public func clone(): TreeMap<K, V>
```

Function: Clones the [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek).

Returns:

- [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek)\<K, V> - Returns a new [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek) instance.

### func contains(K)

```cangjie
public func contains(key: K): Bool
```

Function: Checks whether a mapping exists for the specified key.

Parameters:

- key: K - The key to check.

Returns:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns `true` if the key exists; otherwise, returns `false`.

### func contains(Collection\<K>)

```cangjie
public func contains(all!: Collection<K>): Bool
```

Function: Checks whether mappings exist for all keys in the specified collection.

Parameters:

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<K> - The collection of keys to check.

Returns:- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if it exists; otherwise, returns false.

### func entryView(K)

```cangjie
public func entryView(k: K): MapEntryView<K, V>
```

Function: Returns an empty reference view if the specified key is not contained. If the specified key is contained, returns a reference view of the corresponding element.

Parameters:

- k: K - The key of the key-value pair to be added.

Return Value:

- [MapEntryView](./collection_package_interface.md#interface-mapentryviewk-v)\<K, V> - A reference view.

### func forward(K, Bool)

```cangjie
public func forward(mark: K, inclusive!: Bool = true): Iterator<(K, V)>
```

Function: Obtains an iterator that traverses from the first node with a key greater than or equal to `mark` in ascending order until reaching [last](./collection_package_class.md#prop-last-3). If the node's key equals `mark`, the inclusion of that node is determined by `inclusive!`.

Parameters:

- mark: K - The key used to determine the starting point.
- inclusive!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - When `mark` is the key of the iterator's first element, specifies whether to include `mark` as the starting point. Defaults to `true`.

Return Value:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<(K, V)> - An iterator for the corresponding elements.

### func get(K)

```cangjie
public func get(key: K): ?V
```

Function: Returns the value mapped to the specified key.

Parameters:

- key: K - The specified key.

Return Value:

- ?V - If such a value exists, returns the value encapsulated in [Option](../../core/core_package_api/core_package_enums.md#enum-optiont); otherwise, returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<V>.None.

### func isEmpty()

```cangjie
public func isEmpty(): Bool
```

Function: Determines whether the [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek) is empty.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if empty; otherwise, returns false.

### func iterator()

```cangjie
public func iterator(): Iterator<(K, V)>
```

Function: Returns an iterator for the [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek), iterating in ascending order of Key values.

Return Value:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<(K, V)> - An iterator for the [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek).

### func keys()

```cangjie
public func keys(): EquatableCollection<K>
```

Function: Returns all keys in the [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek), storing them in a container.

Return Value:

- [EquatableCollection](collection_package_interface.md#interface-equatablecollectiont)\<K> - A collection containing all keys.

### func removeFirst()

```cangjie
public func removeFirst(): ?(K, V)
```

Function: Removes the first element of the [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek).

Return Value:

- ?(K, V) - If the first element exists, removes it and returns the element encapsulated in [Option](../../core/core_package_api/core_package_enums.md#enum-optiont); otherwise, returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<(K, V)>.None.

### func removeLast()

```cangjie
public func removeLast(): ?(K, V)
```

Function: Removes the last element of the [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek).

Return Value:

- ?(K, V) - If the last element exists, removes it and returns the element encapsulated in [Option](../../core/core_package_api/core_package_enums.md#enum-optiont); otherwise, returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<(K, V)>.None.

### func remove(K)

```cangjie
public func remove(key: K): Option<V>
```

Function: Removes the mapping for the specified key from this map (if present).

Parameters:

- key: K - The key to be removed.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<V> - The removed value is encapsulated in [Option](../../core/core_package_api/core_package_enums.md#enum-optiont). If the specified key does not exist in the [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek), returns None.

### func remove(Collection\<K>)

```cangjie
public func remove(all!: Collection<K>): Unit
```

Function: Removes the mappings for the specified collection from this map (if present).

Parameters:

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<K> - The collection of keys to be removed.

### func removeIf((K, V) -> Bool)

```cangjie
public func removeIf(predicate: (K, V) -> Bool): Unit
```

Function: Takes a lambda expression and removes the corresponding key-value pair if the condition is met.

Parameters:

- predicate: (K, V) ->[Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - A lambda expression used for evaluation.Exceptions:

- [ConcurrentModificationException](./collection_package_exception.md#class-concurrentmodificationexception) - Throws an exception when keys or values are added, deleted, or modified within the `predicate` of a [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek).

### func values()

```cangjie
public func values(): Collection<V>
```

Function: Returns the values contained in the [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek), storing all values in a container.

Return Value:

- [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<V> - A collection containing all values.

### operator func \[](K, V)

```cangjie
public operator func [](key: K, value!: V): Unit
```

Function: Overloads the collection operator. If the key exists, the new value overwrites the old value; if the key does not exist, adds this key-value pair.

Parameters:

- key: K - The key to evaluate.
- value!: V - The value to be set.

### operator func \[](K)

```cangjie
public operator func [](key: K): V
```

Function: Overloads the collection operator. If the key exists, returns the value corresponding to the key.

Parameters:

- key: K - The key to evaluate.

Return Value:

- V - The value corresponding to the key.

Exceptions:

- [NoneValueException](../../core/core_package_api/core_package_exceptions.md#class-nonevalueexception) - Throws an exception if the key does not exist in the [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek).

### extend\<K, V> TreeMap\<K, V> <: Equatable\<TreeMap\<K, V>> where V <: Equatable\<V>

```cangjie
extend<K, V> TreeMap<K, V> <: Equatable<TreeMap<K, V>> where V <: Equatable<V>
```

Function: Extends the [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[TreeMap](./collection_package_class.md#class-treemapk-v-where-k--comparablek)\<K, V>> interface for the [TreeMap](./collection_package_class.md#class-treemapk-v-where-k--comparablek)\<K, V> type, supporting equality comparison.

Parent Type:

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[TreeMap](./collection_package_class.md#class-treemapk-v-where-k--comparablek)\<K, V>>

#### operator func ==(TreeMap\<K, V>)

```cangjie
public operator func ==(right: TreeMap<K, V>): Bool
```

Function: Determines whether the current instance is equal to the [TreeMap](./collection_package_class.md#class-treemapk-v-where-k--comparablek)\<K, V> instance referenced by the parameter.

Two [TreeMap](./collection_package_class.md#class-treemapk-v-where-k--comparablek)\<K, V> instances are considered equal if they contain identical key-value pairs.

Parameters:

- right: [TreeMap](./collection_package_class.md#class-treemapk-v-where-k--comparablek)\<K, V> - The object to compare.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if equal, otherwise false.

#### operator func !=(TreeMap\<K, V>)

```cangjie
public operator func !=(right: TreeMap<K, V>): Bool
```

Function: Determines whether the current instance is not equal to the [TreeMap](./collection_package_class.md#class-treemapk-v-where-k--comparablek)\<K, V> instance referenced by the parameter.

Parameters:

- right: [TreeMap](./collection_package_class.md#class-treemapk-v-where-k--comparablek)\<K, V> - The object to compare.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if not equal, otherwise false.

### extend\<K, V> TreeMap\<K, V> <: ToString where V <: ToString, K <: ToString & Comparable\<K>

```cangjie
extend<K, V> TreeMap<K, V> <: ToString where V <: ToString, K <: ToString & Comparable<K>
```

Function: Extends the [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring) interface for the [TreeMap](./collection_package_class.md#class-treemapk-v-where-k--comparablek)\<K, V>, supporting string conversion.

Parent Type:

- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

#### func toString()

```cangjie
public func toString(): String
```

Function: Converts the current [TreeMap](./collection_package_class.md#class-treemapk-v-where-k--comparablek)\<K, V> instance to a string.

The string includes the string representation of each key-value pair in the [TreeMap](./collection_package_class.md#class-treemapk-v-where-k--comparablek)\<K, V>, formatted as: "[(k1, v1), (k2, v2), (k3, v3)]".

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The resulting string.

## class TreeSet\<T> where T <: Comparable\<T>

```cangjie
public class TreeSet<T> <: OrderedSet<T> where T <: Comparable<T> {
    public init()
    public init(elements: Collection<T>)
    public init(size: Int64, initElement: (Int64) -> T)
}
```

Function: An implementation of the [Set](collection_package_interface.md#interface-sett) interface based on [TreeMap](collection_package_class.md#class-treemapk-v-where-k--comparablek).

The primary purpose of this class is to provide an ordered storage structure for elements, enabling fast insertion, deletion, and lookup operations.

[TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) can be used in any scenario requiring ordered element storage, such as databases, caches, lookup tables, etc.

Parent Type:

- [OrderedSet](collection_package_interface.md#interface-orderedsett)\<T>

### prop first

```cangjie
public prop first: ?T
```

Function: Retrieves the first element of the [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet).Type: ?T - If the first element exists, wraps it in [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) and returns; otherwise returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T>.None.

### prop last

```cangjie
public prop last: ?T
```

Function: Gets the last element of [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet).

Type: ?T - If the last element exists, wraps it in [Option](../../core/core_package_api/core_package_enums.md#enum-optiont) and returns; otherwise returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T>.None.

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

Elements are inserted into the [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) in the order of the elements' iterator. Since duplicate elements are not allowed in [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet), if there are multiple identical elements in the input collection, only one will be retained.

Parameters:

- elements: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T> - The collection of elements to initialize this [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet).

### init(Int64, (Int64) -> T)

```cangjie
public init(size: Int64, initElement: (Int64) -> T)
```

Function: Constructs a [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) using a specified size and initialization function.

Parameters:

- size: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The number of elements.
- initElement: ([Int64](../../core/core_package_api/core_package_intrinsics.md#int64)) -> T - The initialization function rule for this [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet).

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown if size is less than 0.

### static func of(Array\<T>)

```cangjie
public static func of(elements: Array<T>): TreeSet<T>
```

Function: Constructs a [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) containing all elements from the specified array.

Elements are inserted into the [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) in their original order. Since duplicate elements are not allowed, only one instance of each duplicate element will be retained.

Parameters:

- elements: [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - The input array.

Returns:

- [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)\<T> - A [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) containing elements of type T.

### func add(T)

```cangjie
public func add(element: T): Bool
```

Function: Adds a new element to the [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet). If the element already exists, the addition fails.

Parameters:

- element: T - The specified element.

Returns:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if the addition is successful; otherwise, returns false.

### func add(Collection\<T>)

```cangjie
public func add(all!: Collection<T>): Unit
```

Function: Adds all elements from the [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont) to this [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet). Existing elements will not be added.

Parameters:

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T> - The collection of elements to be added.

### func backward(T, Bool)

```cangjie
public func backward(mark: T, inclusive!: Bool = true): Iterator<T>
```

Function: Gets an iterator that traverses from the first node with a key less than or equal to `mark` in descending order up to [first](./collection_package_class.md#prop-first-4). If the node's key equals `mark`, the inclusion of this node is determined by `inclusive!`.

Parameters:

- mark: T - The element used to determine the starting point.
- inclusive!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - When `mark` is the first element of the iterator, specifies whether to include `mark` as the starting point. Default is `true`.

Returns:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - The iterator for the corresponding elements.

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

Returns:

- [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)\<T> - Returns a new [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) instance.

### func contains(T)

```cangjie
public func contains(element: T): Bool
```

Function: Determines whether a specified element is contained.

Parameters:

- element: T - The specified element.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if the specified element is contained; otherwise, returns false.

### func contains(Collection\<T>)

```cangjie
public func contains(all!: Collection<T>): Bool
```

Function: Determines whether the [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) contains all elements of the specified [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont).

Parameters:

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T> - The specified collection of elements.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if this [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) contains all elements of the [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont); otherwise, returns false.

### func forward(T, Bool)

```cangjie
public func forward(mark: T, inclusive!: Bool = true): Iterator<T>
```

Function: Obtains an iterator that traverses from the first element greater than or equal to `mark` in ascending order until [last](./collection_package_class.md#prop-last-3). If the element of the node equals `mark`, the inclusion of the corresponding node is determined by `inclusive!`.

Parameters:

- mark: T - The element used to determine the starting point.
- inclusive!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - When `mark` is the first element of the iterator, specifies whether to include `mark` as the starting point. Defaults to `true`.

Return Value:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - The iterator for the corresponding elements.

### func isEmpty()

```cangjie
public func isEmpty(): Bool
```

Function: Determines whether the [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) is empty.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if empty; otherwise, returns false.

### func iterator()

```cangjie
public func iterator(): Iterator<T>
```

Function: Returns an iterator for the [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet), which iterates elements in ascending order.

Return Value:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - The iterator for the [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet).

### func removeFirst()

```cangjie
public func removeFirst(): ?T
```

Function: Removes the first element of the [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet).

Return Value:

- ?T - If the first element exists, it is removed and returned wrapped in an [Option](../../core/core_package_api/core_package_enums.md#enum-optiont); otherwise, returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T>.None.

### func removeLast()

```cangjie
public func removeLast(): ?T
```

Function: Removes the last element of the [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet).

Return Value:

- ?T - If the last element exists, it is removed and returned wrapped in an [Option](../../core/core_package_api/core_package_enums.md#enum-optiont); otherwise, returns [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T>.None.

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

Function: Takes a lambda expression and removes the corresponding element if the condition evaluates to `true`.

Parameters:

- predicate: (T) ->[Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The condition to determine whether to remove the element.

Exceptions:

- [ConcurrentModificationException](./collection_package_exception.md#class-concurrentmodificationexception) - Thrown when elements are added, deleted, or modified within the `predicate` in the [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet).

### func retain(Set\<T>)

```cangjie
public func retain(all!: Set<T>): Unit
```

Function: Retains only the elements in this [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) that are contained in the specified [Set](collection_package_interface.md#interface-sett), removing all other elements.

Parameters:

- all!: [Set](collection_package_interface.md#interface-sett)\<T> - The [Set](collection_package_interface.md#interface-sett) whose elements are to be retained.

### func subsetOf(ReadOnlySet\<T>)

```cangjie
public func subsetOf(other: ReadOnlySet<T>): Bool
```

Function: Checks whether this set is a subset of another [ReadOnlySet](collection_package_interface.md#interface-readonlysett).

Parameters:

- other: [ReadOnlySet](collection_package_interface.md#interface-readonlysett)\<T> - The input set against which this function will determine if the current set is a subset.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if this [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet) is a subset of the specified [ReadOnlySet](collection_package_interface.md#interface-readonlysett); otherwise returns false.

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

Function: Returns a new set containing the intersection of elements from both sets.

Parameters:

- other: [ReadOnlySet](collection_package_interface.md#interface-readonlysett)\<T> - The input set.

Return Value:

- [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)\<T> - A set of type T.

### operator func |(ReadOnlySet\<T>)

```cangjie
public operator func |(other: ReadOnlySet<T>): TreeSet<T>
```

Function: Returns a new set containing the union of elements from both sets.

Parameters:

- other: [ReadOnlySet](collection_package_interface.md#interface-readonlysett)\<T> - The input set.

Return Value:

- [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)\<T> - A set of type T.

### operator func -(ReadOnlySet\<T>)

```cangjie
public operator func -(other: ReadOnlySet<T>): TreeSet<T>
```

Function: Returns a new set containing the difference of elements between two sets.

Parameters:

- other: [ReadOnlySet](collection_package_interface.md#interface-readonlysett)\<T> - The input set.

Return Value:

- [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)\<T> - A set of type T.

### extend\<T> TreeSet\<T> <: Equatable\<TreeSet\<T>>

```cangjie
extend<T> TreeSet<T> <: Equatable<TreeSet<T>>
```

Function: Extends the [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)\<T> type with the [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)\<T>> interface, supporting equality operations.

Parent Type:

- [Equatable](../../core/core_package_api/core_package_interfaces.md#interface-equatablet)\<[TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)\<T>>

#### operator func ==(TreeSet\<T>)

```cangjie
public operator func ==(that: TreeSet<T>): Bool
```

Function: Determines whether the current instance is equal to the parameter-specified [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)\<T> instance.

Two [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)\<T> instances are considered equal if they contain exactly the same elements.

Parameters:

- that: [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)\<T> - The object to compare.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if equal, otherwise returns false.

#### operator func !=(TreeSet\<T>)

```cangjie
public operator func !=(that: TreeSet<T>): Bool
```

Function: Determines whether the current instance is not equal to the parameter-specified [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)\<T> instance.

Parameters:

- that: [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)\<T> - The object to compare.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if not equal, otherwise returns false.

### extend\<T> TreeSet\<T> <: ToString where T <: ToString

```cangjie
extend<T> TreeSet<T> <: ToString where T <: ToString
```

Function: Extends the [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)\<T> with the [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring) interface, supporting string conversion operations.

Parent Type:

- [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring)

#### func toString()

```cangjie
public func toString(): String
```

Function: Converts the current [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)\<T> instance to a string.

The resulting string contains the string representation of each element in the [TreeSet](collection_package_class.md#class-treesett-where-t--comparablet)\<T>, formatted as: "[elem1, elem2, elem3]".

Return Value:

- [String](../../core/core_package_api/core_package_structs.md#struct-string) - The converted string.