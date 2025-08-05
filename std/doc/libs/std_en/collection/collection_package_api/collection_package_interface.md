# Interfaces

## interface Deque\<T>

```cangjie
public interface Deque<T> <: Collection<T> {
    prop first: ?T
    prop last: ?T
    func addFirst(element: T): Unit
    func addLast(element: T): Unit
    func removeFirst(): ?T
    func removeLast(): ?T
}
```

Functionality: Deque (double-ended queue) is a data structure that combines features of both queues and stacks, allowing insertion and removal of elements from both ends. The main functionalities of the Deque interface include:

- Insertion operations: Elements can be inserted at either the front or rear of the deque. Use `addFirst` to insert at the head, and `addLast` to insert at the tail.
- Access operations: Elements at either end can be accessed without removal. Use `first` to access the head element and `last` to access the tail element.
- Removal operations: Elements can be removed from either end. Use `removeFirst` to remove and return the head element, and `removeLast` to remove and return the tail element.
- Other operations supported by collection types, such as element count, emptiness check, and iterator operations.

Parent type:

- [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T>

### prop first

```cangjie
prop first: ?T
```

Functionality: Accesses the head element of the deque without removing it.

Return value:

- ?T - The value of the head element wrapped in Option. Returns None if the deque is empty.

### prop last

```cangjie
prop last: ?T
```

Functionality: Accesses the tail element of the deque without removing it.

Return value:

- ?T - The value of the tail element wrapped in Option. Returns None if the deque is empty.

### func addFirst(T)

```cangjie
func addFirst(element: T): Unit
```

Functionality: Inserts the specified element at the head of the deque.

Parameter:

- element: T - The element to be added to the deque.

### func addLast(T)

```cangjie
func addLast(element: T): Unit
```

Functionality: Inserts the specified element at the tail of the deque.

Parameter:

- element: T - The element to be added to the deque.

### func removeFirst()

```cangjie
func removeFirst(): ?T
```

Functionality: Removes and returns the head element of the deque.

Return value:

- ?T - The value of the removed element wrapped in Option. Returns None if the deque is empty.

### func removeLast()

```cangjie
func removeLast(): ?T
```

Functionality: Removes and returns the tail element of the deque.

Return value:

- ?T - The value of the removed element wrapped in Option. Returns None if the deque is empty.

## interface EquatableCollection\<T>

```cangjie
public interface EquatableCollection<T> <: Collection<T> {
    func contains(element: T): Bool
    func contains(all!: Collection<T>): Bool
}
```

Functionality: Defines collection types that support comparison operations.

Parent type:

- [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T>

### func contains(T)

```cangjie
func contains(element: T): Bool
```

Functionality: Determines whether the collection contains the specified element.

Parameter:

- element: T - The element whose presence in the collection is to be tested.

Return value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if the element is found, otherwise false.

### func contains(Collection\<T>)

```cangjie
func contains(all!: Collection<T>): Bool
```

Functionality: Determines whether the collection contains all elements of the specified collection.

Parameter:

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T> - The collection to be checked for containment.

Return value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if all elements are found, otherwise false.

## interface List\<T>

```cangjie
public interface List<T> <: ReadOnlyList<T> {
    func add(element: T): Unit
    func add(all!: Collection<T>): Unit
    func add(element: T, at!: Int64): Unit
    func add(all!: Collection<T>, at!: Int64): Unit
    func remove(at!: Int64): T
    func remove(range: Range<Int64>): Unit
    func removeIf(predicate: (T) -> Bool): Unit
    func clear(): Unit

    operator func [](index: Int64, value!: T): Unit
}
```

Functionality: Defines a list type that provides index-friendly operations.

Parent type:

- [ReadOnlyList](#interface-readonlylistt)\<T>

### func add(T)

```cangjie
func add(element: T): Unit
```

Functionality: Appends the specified element to the end of this list.

Parameter:

- element: T - The element to be appended, of type T.

### func add(Collection\<T>)

```cangjie
func add(all!: Collection<T>): Unit
```

Functionality: Appends all elements from the specified collection to the end of this list.

Parameter:

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T> - The collection containing elements to be appended.

### func add(T, Int64)

```cangjie
func add(element: T, at!: Int64): Unit
```

Functionality: Inserts the specified element at the specified position in this list.

Parameters:

- element: T - The element of type T to be inserted.
- at!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The index at which the element is to be inserted.

### func add(Collection\<T>, Int64)

```cangjie
func add(all!: Collection<T>, at!: Int64): Unit
```

Functionality: Inserts all elements from the specified collection into this list starting at the specified position.

Parameters:

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T> - The collection of elements of type T to be inserted.
- at!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The index at which the collection is to be inserted.

### func clear()

```cangjie
func clear(): Unit
```

Functionality: Removes all elements from this list.

### func remove(Int64)

```cangjie
func remove(at!: Int64): T
```

Functionality: Removes the element at the specified position in this list.

Parameter:

- at!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The index of the element to be removed.

Return value:

- T - The removed element.

### func remove(Range\<Int64>)

```cangjie
func remove(range: Range<Int64>): Unit
```

Functionality: Removes all elements in this list that fall within the specified [Range](../../core/core_package_api/core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet).

Parameter:

- range: [Range](../../core/core_package_api/core_package_structs.md#struct-ranget-where-t--countablet--comparablet--equatablet)\<[Int64](../../core/core_package_api/core_package_intrinsics.md#int64)> - The range of elements to be removed.

### func removeIf((T) -> Bool)

```cangjie
func removeIf(predicate: (T) -> Bool): Unit
```

Functionality: Removes all elements from this list that satisfy the given predicate.

Parameter:

- predicate: (T) ->[Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The condition that determines which elements to remove.

### operator func []\(Int64, T)

```cangjie
operator func [](index: Int64, value!: T): Unit
```

Functionality: Operator overload - set. Replaces the element at the specified position in this list with the specified element using the subscript operator.

Parameters:

- index: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The index of the element to be set.
- value!: T - The value of type T to be set.

## interface Map\<K, V>

```cangjie
public interface Map<K, V> <: ReadOnlyMap<K, V> {
    func add(key: K, value: V): ?V
    func add(all!: Collection<(K, V)>): Unit
    func addIfAbsent(key: K, value: V): ?V
    func clear(): Unit
    func entryView(k: K): MapEntryView<K, V>
    func remove(key: K): Option<V>
    func remove(all!: Collection<K>): Unit
    func removeIf(predicate: (K, V) -> Bool): Unit
    func replace(key: K, value: V): ?V
    operator func [](key: K, value!: V): Unit
}
```

Functionality: The [Map](collection_package_interface.md#interface-mapk-v) interface provides a way to map keys to values. It allows lookup of values using keys, making it suitable for storing and manipulating key-value pairs.

A [Map](collection_package_interface.md#interface-mapk-v) cannot contain duplicate keys; each key can map to at most one value.Parent Type:

- [ReadOnlyMap](collection_package_interface.md#interface-orderedmapk-v)\<K, V>

### func add(K, V)

```cangjie
func add(key: K, value: V): ?V
```

Function: Inserts the specified key-value pair into this [Map](collection_package_interface.md#interface-mapk-v). For existing keys in the [Map](collection_package_interface.md#interface-mapk-v), the mapped value will be replaced with the new value.

Parameters:

- key: K - The key to be inserted.
- value: V - The value to be assigned.

Return Value:

- ?V - Returns the previous value associated with the key if it existed, otherwise returns None.

### func add(Collection\<(K, V)>)

```cangjie
func add(all!: Collection<(K, V)>): Unit
```

Function: Inserts new key-value pairs into the [Map](collection_package_interface.md#interface-mapk-v). For existing keys in the [Map](collection_package_interface.md#interface-mapk-v), the mapped values will be replaced with the new values.

Parameters:

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<(K, V)> - The collection of key-value pairs to be inserted into the [Map](collection_package_interface.md#interface-mapk-v).

### func addIfAbsent(K, V)

```cangjie
func addIfAbsent(key: K, value: V): ?V
```

Function: Adds the specified key-value pair if the key is not already present in the current [Map](collection_package_interface.md#interface-mapk-v). Otherwise, no modification is made.

Parameters:

- key: K - The key of the key-value pair to be added.
- value: V - The value of the key-value pair to be added.

Return Value:

- ?V - If the specified key already exists in the current [Map](collection_package_interface.md#interface-mapk-v), returns its associated value. Otherwise returns None.

### func clear()

```cangjie
func clear(): Unit
```

Function: Removes all key-value pairs.

### func entryView(K)

```cangjie
func entryView(k: K): MapEntryView<K, V>
```

Function: Retrieves the view corresponding to key k.

Parameters:

- k: K - The key whose view is to be retrieved.

Return Value:

- [MapEntryView](#interface-mapentryviewk-v)\<K, V> - The view corresponding to key k.

### func remove(K)

```cangjie
func remove(key: K): Option<V>
```

Function: Removes the mapping for the specified key from this [Map](collection_package_interface.md#interface-mapk-v) if present.

Parameters:

- key: K - The key to be removed.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<V> - The value associated with the removed key, wrapped in [Option](../../core/core_package_api/core_package_enums.md#enum-optiont).

### func remove(Collection\<K>)

```cangjie
func remove(all!: Collection<K>): Unit
```

Function: Removes mappings for all keys in the specified collection from this map if present.

Parameters:

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<K> - The collection of keys to be removed.

### func removeIf((K, V) -> Bool)

```cangjie
func removeIf(predicate: (K, V) -> Bool): Unit
```

Function: Removes key-value pairs that satisfy the given predicate.

Parameters:

- predicate: (K, V) ->[Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - A lambda expression for condition evaluation.

### func replace(K, V)

```cangjie
func replace(key: K, value: V): ?V
```

Function: Replaces the value for the specified key if it exists in the current [Map](collection_package_interface.md#interface-mapk-v). Otherwise, no modification is made.

Parameters:

- key: K - The key whose value is to be replaced.
- value: V - The new value to be associated with the key.

Return Value:

- ?V - Returns the previous value associated with the key if it existed, otherwise returns None.

### operator func []\(K, V)

```cangjie
operator func [](key: K, value!: V): Unit
```

Function: Operator overload for collection operations. If the key exists, the new value overwrites the old value; if the key doesn't exist, the key-value pair is added.

Parameters:

- key: K - The key to be set.
- value!: V - The value to be assigned.

## interface MapEntryView\<K, V>

```cangjie
public interface MapEntryView<K, V> {
    public prop key: K
    public mut prop value: ?V
}
```

Function: Provides a view of a specific key in the map.

### prop key

```cangjie
public prop key: K
```

Function: Returns the key in the view. If the view's key doesn't exist in the original map, returns an empty view of that key.

Type: K

### prop value

```cangjie
public mut prop value: ?V
```

Function: Reads or modifies the value in the original map corresponding to this view.
When setting a non-null value, if the view's value doesn't exist, a new element is added to the original map.
When set to `None`, the current Entry is deleted, but the view remains usable after deletion.

Type: [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)(V)

## interface OrderedMap\<K, V>

```cangjie
public interface OrderedMap<K, V> <: Map<K, V> {
    public prop first: ?(K, V)
    public prop last: ?(K, V)
    public func removeFirst(): ?(K, V)
    public func removeLast(): ?(K, V)

    public func backward(mark: K, inclusive!: Bool): Iterator<(K, V)>
    public func forward(mark: K, inclusive!: Bool): Iterator<(K, V)>
}
```

Function: The [OrderedMap](collection_package_interface.md#interface-orderedmapk-v) interface provides a way to map keys to values. It allows lookup of values using keys, making it suitable for storing and manipulating key-value pairs.

Instances of the [OrderedMap](collection_package_interface.md#interface-orderedmapk-v) interface maintain their elements in a specific order.

Parent Type:

- [Map](collection_package_interface.md#interface-mapk-v)\<K, V>

### prop first

```cangjie
public prop first: ?(K, V)
```

Function: Retrieves the first element of the [OrderedMap](./collection_package_interface.md#interface-orderedmapk-v).

Type: ?(K, V)

### prop last

```cangjie
public prop last: ?(K, V)
```

Function: Retrieves the last element of the [OrderedMap](./collection_package_interface.md#interface-orderedmapk-v).

Type: ?(K, V)

### func removeFirst()

```cangjie
public func removeFirst(): ?(K, V)
```

Function: Removes the first element from the [OrderedMap](./collection_package_interface.md#interface-orderedmapk-v).

Return Value:

- ?(K, V) - If the [OrderedMap](./collection_package_interface.md#interface-orderedmapk-v) is not empty, returns the removed key-value pair wrapped in [Option](../../core/core_package_api/core_package_enums.md#enum-optiont), otherwise returns `None`.

### func removeLast()

```cangjie
public func removeLast(): ?(K, V)
```

Function: Removes the last element from the [OrderedMap](./collection_package_interface.md#interface-orderedmapk-v).

Return Value:

- ?(K, V) - If the [OrderedMap](./collection_package_interface.md#interface-orderedmapk-v) is not empty, returns the removed key-value pair wrapped in [Option](../../core/core_package_api/core_package_enums.md#enum-optiont), otherwise returns `None`.

### func backward(K, Bool)

```cangjie
public func backward(mark: K, inclusive!: Bool): Iterator<(K, V)>
```

Function: Returns an iterator that traverses from the first node with key less than or equal to mark (in descending order) to [first](./collection_package_interface.md#prop-first). If the node's key equals mark, the `inclusive!` parameter determines whether to include that node.

Parameters:

- mark: K - The key marking the starting point.
- inclusive!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - When mark is the first element's key, specifies whether to include mark as the starting point.

Return Value:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<(K, V)> - The iterator.

### func forward(K, Bool)

```cangjie
public func forward(mark: K, inclusive!: Bool): Iterator<(K, V)>
```

Function: Returns an iterator that traverses from the first node with key greater than or equal to mark (in ascending order) to [last](./collection_package_interface.md#prop-last). If the node's key equals mark, the `inclusive!` parameter determines whether to include that node.

Parameters:

- mark: K - The key marking the starting point.
- inclusive!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - When mark is the first element's key, specifies whether to include mark as the starting point.

Return Value:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<(K, V)> - The iterator.

## interface OrderedSet\<T>

```cangjie
public interface OrderedSet<T> <: Set<T> {
    public prop first: ?T
    public prop last: ?T
    public func removeFirst(): ?T
    public func removeLast(): ?T

    public func backward(mark: T, inclusive!: Bool): Iterator<T>
    public func forward(mark: T, inclusive!: Bool): Iterator<T>
}
```

Function: The [OrderedSet](collection_package_interface.md#interface-orderedsett) interface provides operations for a collection of elements, allowing read-write manipulation of internal elements.

Instances of the [OrderedSet](collection_package_interface.md#interface-orderedsett) interface maintain their elements in a specific order.

Parent Type:

- [Set](collection_package_interface.md#interface-sett)\<T>

### prop first

```cangjie
public prop first: ?T
```

Function: Gets the first element of [OrderedSet](collection_package_interface.md#interface-orderedsett).

Type: ?T

### prop last

```cangjie
public prop last: ?T
```

Function: Gets the last element of [OrderedSet](collection_package_interface.md#interface-orderedsett).

Type: ?T

### func removeFirst()

```cangjie
public func removeFirst(): ?T
```

Function: Removes the first element of [OrderedSet](collection_package_interface.md#interface-orderedsett).

Return Value:

- ?T - If the current [OrderedSet](collection_package_interface.md#interface-orderedsett) is not empty, returns the removed element encapsulated in [Option](../../core/core_package_api/core_package_enums.md#enum-optiont); otherwise, returns `None`.

### func removeLast()

```cangjie
public func removeLast(): ?T
```

Function: Removes the last element of [OrderedSet](collection_package_interface.md#interface-orderedsett).

Return Value:

- ?T - If the current [OrderedSet](collection_package_interface.md#interface-orderedsett) is not empty, returns the removed element encapsulated in [Option](../../core/core_package_api/core_package_enums.md#enum-optiont); otherwise, returns `None`.

### func backward(T, Bool)

```cangjie
public func backward(mark: T, inclusive!: Bool): Iterator<T>
```

Function: Gets an iterator that traverses from the first element less than or equal to `mark` in descending order to [first](./collection_package_interface.md#prop-first). If the element of the node equals `mark`, the inclusion of the corresponding node is determined by `inclusive!`.

Parameters:

- mark: T - The element used to determine the starting point.
- inclusive!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - When `mark` is the first element of the iterator, specifies whether to include `mark` as the starting point.

Return Value:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - The iterator.

### func forward(T, Bool)

```cangjie
public func forward(mark: T, inclusive!: Bool): Iterator<T>
```

Function: Gets an iterator that traverses from the first element greater than or equal to `mark` in ascending order to [last](./collection_package_interface.md#prop-last). If the element of the node equals `mark`, the inclusion of the corresponding node is determined by `inclusive!`.

Parameters:

- mark: T - The element used to determine the starting point.
- inclusive!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - When `mark` is the first element of the iterator, specifies whether to include `mark` as the starting point.

Return Value:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - The iterator.

## interface Queue\<T>

```cangjie
public interface Queue<T> <: Collection<T> {
    func add(element: T): Unit
    func peek(): ?T
    func remove(): ?T
}
```

Function: A queue data structure that follows the First In First Out (FIFO) principle. The main functionalities of Queue include:

- Adding elements: Inserts the specified element at the tail of the queue.
- Access operations: Accesses the front element of the queue without removing it.
- Removal operations: Removes the front element of the queue.
- Other operations supported by collection types, such as element count, emptiness check, and iterator operations.

Parent Type:

- [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T>

### func add(T)

```cangjie
func add(element: T): Unit
```

Function: Inserts the specified element at the tail of the queue.

Parameter:

- element: T - The element to be added to the queue.

### func peek()

```cangjie
func peek(): ?T
```

Function: Accesses the front element of the queue without removing it.

Return Value:

- ?T - The value of the front element encapsulated in Option; returns `None` if the queue is empty.

### func remove()

```cangjie
func remove(): ?T
```

Function: Removes the front element of the queue and returns its value.

Return Value:

- ?T - The value of the removed element encapsulated in Option; returns `None` if the queue is empty.

## interface ReadOnlyList\<T>

```cangjie
public interface ReadOnlyList<T> <: Collection<T> {
    prop first: ?T
    prop last: ?T
    func get(index: Int64): ?T
    operator func [](index: Int64): T
}
```

Function: Defines a read-only list.

Parent Type:

- [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T>

### prop first

```cangjie
prop first: ?T
```

Function: Returns the first element in this list, or None if there is none.

Type: ?T

### prop last

```cangjie
prop last: ?T
```

Function: Returns the last element in this list, or None if there is none.

Type: ?T

### func get(Int64)

```cangjie
func get(index: Int64): ?T
```

Function: Returns the element at the specified position in this list.

Parameter:

- index: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The index of the element to return.

Return Value:

- ?T - The element at the specified position; returns None if the index is less than 0 or greater than or equal to the number of elements in this list.

### operator func []\(Int64)

```cangjie
operator func [](index: Int64): T
```

Function: Operator overload - get.

Parameter:

- index: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The index for the get interface.

Return Value:

- T - The value of the element at the index position.

## interface ReadOnlyMap\<K, V>

```cangjie
public interface ReadOnlyMap<K, V> <: Collection<(K, V)> {
    func get(key: K): ?V
    func contains(key: K): Bool
    func contains(all!: Collection<K>): Bool
    func keys(): EquatableCollection<K>
    func values(): Collection<V>

    operator func [](key: K): V
}
```

Function: The [ReadOnlyMap](collection_package_interface.md#interface-readonlymapk-v) interface provides a way to map keys to values. It allows us to use keys to look up values, making it suitable for storing key-value pairs.

[ReadOnlyMap](collection_package_interface.md#interface-readonlymapk-v) cannot contain duplicate keys; each key can map to at most one value.

Parent Type:

- [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<(K, V)>

### func get(K)

```cangjie
func get(key: K): ?V
```

Function: Gets the value mapped to the key in [ReadOnlyMap](collection_package_interface.md#interface-readonlymapk-v).

Parameter:

- key: K - The key used to retrieve the value.

Return Value:

- ?V - The value corresponding to the key in [ReadOnlyMap](collection_package_interface.md#interface-readonlymapk-v).

### func contains(K)

```cangjie
func contains(key: K): Bool
```

Function: Determines whether a mapping for the specified key exists.

Parameter:

- key: K - The key to check.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if the key exists; otherwise, returns false.

### func contains(Collection\<K>)

```cangjie
func contains(all!: Collection<K>): Bool
```

Function: Determines whether mappings for all keys in the specified collection exist.

Parameter:

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<K> - The collection of keys to check.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if all keys exist; otherwise, returns false.

### func keys()

```cangjie
func keys(): EquatableCollection<K>
```

Function: Returns all keys in [ReadOnlyMap](collection_package_interface.md#interface-readonlymapk-v), stored in an [EquatableCollection](collection_package_interface.md#interface-equatablecollectiont)\<K> container.

Return Value:

- [EquatableCollection](collection_package_interface.md#interface-equatablecollectiont)\<K> - Contains all returned keys.

### func values()

```cangjie
func values(): Collection<V>
```

Function: Returns all values in [ReadOnlyMap](collection_package_interface.md#interface-readonlymapk-v), stored in a [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<V> container.

Return Value:

- [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<V> - Contains all returned values.

### operator func []\(K)

```cangjie
operator func [](key: K): V
```

Function: Operator overload for collections. If the key exists, returns the corresponding value; if not, throws an exception.

Parameters:

- key: K - The key to look up.

Return Value:

- V - The value associated with the key.

## interface ReadOnlySet\<T>

```cangjie
public interface ReadOnlySet<T> <: Collection<T> {
    func contains(element: T): Bool
    func contains(all!: Collection<T>): Bool
    func subsetOf(other: ReadOnlySet<T>): Bool
}
```

Function: The [ReadOnlySet](collection_package_interface.md#interface-readonlysett) interface provides a set of collection operations, allowing read-only manipulation of internal elements.

Parent Type:

- [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T>

### func contains(T)

```cangjie
func contains(element: T): Bool
```

Function: Returns true if the collection contains the specified element.

Parameters:

- element: T - The element to check.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if contained; otherwise, returns false.

### func contains(Collection\<T>)

```cangjie
func contains(all!: Collection<T>): Bool
```

Function: Checks whether this collection contains another collection.

Parameters:

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T> - The other collection.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if this collection contains the specified collection; otherwise, returns false.

### func subsetOf(ReadOnlySet\<T>)

```cangjie
func subsetOf(other: ReadOnlySet<T>): Bool
```

Function: Checks whether this collection is a subset of another collection.

Parameters:

- other: [ReadOnlySet](collection_package_interface.md#interface-readonlysett)\<T> - The other collection.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if this collection is a subset of the specified collection; otherwise, returns false.

## interface Set\<T>

```cangjie
public interface Set<T> <: ReadOnlySet<T> {
    func add(element: T): Bool
    func add(all!: Collection<T>): Unit
    func remove(element: T): Bool
    func remove(all!: Collection<T>): Unit
    func removeIf(predicate: (T) -> Bool): Unit
    func clear(): Unit
    func retain(all!: Set<T>): Unit
}
```

Function: The [Set](collection_package_interface.md#interface-sett) interface provides a set of collection operations, allowing read-write manipulation of internal elements.

The [Set](collection_package_interface.md#interface-sett) interface does not specify internal implementation. In instances of the [Set](collection_package_interface.md#interface-sett) interface, internal elements are typically unordered, cannot be accessed by index, and insertion order is not guaranteed.

Parent Type:

- [ReadOnlySet](collection_package_interface.md#interface-readonlysett)\<T>

### func add(T)

```cangjie
func add(element: T): Bool
```

Function: Adds an element. If the element already exists, it will not be added.

Parameters:

- element: T - The element to add.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if added successfully; otherwise, returns false.

### func add(Collection\<T>)

```cangjie
func add(all!: Collection<T>): Unit
```

Function: Adds all elements from the [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont) to this [Set](collection_package_interface.md#interface-sett). Existing elements will not be added.

Parameters:

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T> - The collection of elements to be added.

### func remove(T)

```cangjie
func remove(element: T): Bool
```

Function: Removes the specified element from this collection (if it exists).

Parameters:

- element: T - The element to remove.

Return Value:

- Bool - Returns `true` if the element existed and was removed successfully; otherwise, returns `false`.

### func remove(Collection\<T>)

```cangjie
func remove(all!: Collection<T>): Unit
```

Function: Removes all elements from this [Set](collection_package_interface.md#interface-sett) that are also contained in the specified [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont).

Parameters:

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T> - The input [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T>.

### func removeIf((T) -> Bool)

```cangjie
func removeIf(predicate: (T) -> Bool): Unit
```

Function: Takes a lambda expression and removes elements that satisfy the `true` condition.

Parameters:

- predicate: (T) ->[Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - A lambda expression for evaluation.

### func clear()

```cangjie
func clear(): Unit
```

Function: Removes elements that satisfy the predicate condition.

### func retain(Set\<T>)

```cangjie
func retain(all!: Set<T>): Unit
```

Function: Retains only the elements in this [Set](collection_package_interface.md#interface-sett) that are also present in the input [Set](collection_package_interface.md#interface-sett).

Parameters:

- all!: [Set](collection_package_interface.md#interface-sett)\<T> - The collection of elements to retain.

## interface Stack\<T>

```cangjie
public interface Stack<T> <: Collection<T> {
    func add(element: T): Unit
    func peek(): ?T
    func remove(): ?T
}
```

Function: A Stack is a data structure that follows the Last In First Out (LIFO) principle. Insertions and deletions are performed at one end (called the top), while the other end (called the bottom) remains inactive.

Basic stack operations include push (add), pop (remove), and peek (view the top element).

Parent Type:

- [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T>

### func add(T)

```cangjie
func add(element: T): Unit
```

Function: Adds an element to the stack.

Parameters:

- element: T - The element to be placed on top of the stack.

### func peek()

```cangjie
func peek(): ?T
```

Function: Views the top element of the stack without removing it.

Return Value:

- ?T - The top element of the stack. Returns `None` if the stack is empty.

### func remove()

```cangjie
func remove(): ?T
```

Function: Removes and returns the top element of the stack.

Return Value:

- ?T - The removed top element. Returns `None` if the stack is empty.