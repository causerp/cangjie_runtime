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

Functionality: Deque (double-ended queue) is a data structure that combines features of both queues and stacks, allowing insertion and deletion of elements from both ends. The main functionalities of the Deque interface include:

- Insertion operations: Elements can be inserted at either the front or rear of the deque. Use `addFirst` to insert at the head, and `addLast` to insert at the tail.
- Access operations: Elements at either end can be accessed without removal. Use `first` to access the head element and `last` to access the tail element.
- Removal operations: Elements can be removed from either end. Use `removeFirst` to remove and return the head element, and `removeLast` to remove and return the tail element.
- Other collection-type supported operations such as element count, emptiness check, and iterator operations.

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

- element: T - The element to check for presence in the collection.

Return value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if the element is present, otherwise false.

### func contains(Collection\<T>)

```cangjie
func contains(all!: Collection<T>): Bool
```

Functionality: Determines whether the collection contains all elements of the specified collection.

Parameter:

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T> - The collection whose elements are to be checked for presence.

Return value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if all elements are present, otherwise false.

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

- element: T - The element to be inserted, of type T.

### func add(Collection\<T>)

```cangjie
func add(all!: Collection<T>): Unit
```

Functionality: Appends all elements from the specified collection to the end of this list.

Parameter:

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T> - The collection of elements to be inserted.

### func add(T, Int64)

```cangjie
func add(element: T, at!: Int64): Unit
```

Functionality: Inserts the specified element at the specified position in this list.

Parameters:

- element: T - The element of type T to be inserted.
- at!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The target index for insertion.

### func add(Collection\<T>, Int64)

```cangjie
func add(all!: Collection<T>, at!: Int64): Unit
```

Functionality: Inserts all elements from the specified collection into this list starting from the specified position.

Parameters:

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T> - The collection of elements of type T to be inserted.
- at!: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The target index for insertion.

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

Functionality: Removes all elements from this list that satisfy the given lambda expression or function.

Parameter:

- predicate: (T) ->[Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The condition predicate for removal.

### operator func \[](Int64, T)

```cangjie
operator func [](index: Int64, value!: T): Unit
```

Functionality: Operator overload - set, replaces the element at the specified position in this list with the specified element using the subscript operator.

Parameters:

- index: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The index value to set.
- value!: T - The value of type T to set.

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

Functionality: The [Map](collection_package_interface.md#interface-mapk-v) interface provides a way to map keys to values. It allows lookup of values using keys, enabling storage and manipulation of key-value pairs.

A [Map](collection_package_interface.md#interface-mapk-v) cannot contain duplicate keys; each key maps to at most one value.

Parent type:

- [ReadOnlyMap](collection_package_interface.md#interface-orderedmapk-v)\<K, V>

### func add(K, V)

```cangjie
func add(key: K, value: V): ?V
```

Functionality: Places the specified key-value pair into this [Map](collection_package_interface.md#interface-mapk-v). For existing keys in the map, their mapped values will be replaced with the new value.

Parameters:

- key: K - The key to place.
- value: V - The value to assign.

Return value:

- ?V - Returns the old value if the key previously existed, otherwise returns None.

### func add(Collection\<(K, V)>)

```cangjie
func add(all!: Collection<(K, V)>): Unit
```

Functionality: Places new key-value pairs into the [Map](collection_package_interface.md#interface-mapk-v). For existing keys in the map, their mapped values will be replaced with new values.

Parameter:

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<(K, V)> - The collection of key-value pairs to be placed into the map.

### func addIfAbsent(K, V)

```cangjie
func addIfAbsent(key: K, value: V): ?V
```

Functionality: Adds the specified key-value pair if the key is not already present in the current [Map](collection_package_interface.md#interface-mapk-v). Otherwise, makes no modifications.

Parameters:

- key: K - The key of the key-value pair to be added.
- value: V - The value of the key-value pair to be added.

Return value:

- ?V - Returns the old value if the key was already present in the map, otherwise returns None.

### func clear()

```cangjie
func clear(): Unit
```

Functionality: Clears all key-value pairs.

### func entryView(K)

```cangjie
func entryView(k: K): MapEntryView<K, V>
```

Functionality: Gets the view corresponding to the specified key k.

Parameter:

- k: K - The key whose view is to be obtained.

Return value:

- [MapEntryView](#interface-mapentryviewk-v)\<K, V> - The view corresponding to key k.

### func remove(K)

```cangjie
func remove(key: K): Option<V>
```

Functionality: Removes the mapping for the specified key from this [Map](collection_package_interface.md#interface-mapk-v) if present.

Parameter:

- key: K - The key whose mapping is to be removed.

Return value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<V> - The value associated with the removed key, wrapped in Option.

### func remove(Collection\<K>)

```cangjie
func remove(all!: Collection<K>): Unit
```

Functionality: Removes mappings for all keys in the specified collection from this map if present.

Parameter:

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<K> - The collection of keys whose mappings are to be removed.

### func removeIf((K, V) -> Bool)

```cangjie
func removeIf(predicate: (K, V) -> Bool): Unit
```

Functionality: Removes all key-value pairs that satisfy the given lambda expression.

Parameter:

- predicate: (K, V) ->[Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The condition predicate for removal.

### func replace(K, V)

```cangjie
func replace(key: K, value: V): ?V
```

Functionality: Replaces the value for the specified key with the new value if the key is present in the current [Map](collection_package_interface.md#interface-mapk-v). Otherwise, makes no modifications.

Parameters:

- key: K - The key of the key-value pair to be modified.
- value: V - The new value for the key-value pair.

Return value:

- ?V - Returns the old value if the key was present in the map, otherwise returns None.

### operator func \[](K, V)

```cangjie
operator func [](key: K, value!: V): Unit
```

Functionality: Operator overload collection. If the key exists, the new value overwrites the old value. If the key doesn't exist, adds this key-value pair.

Parameters:

- key: K - The key to be set.
- value!: V - The value to be set.## interface MapEntryView\<K, V>

```cangjie
public interface MapEntryView<K, V> {
    public prop key: K
    public mut prop value: ?V
}
```

Function: Provides a view of the key-value mapping in a map.

### prop key

```cangjie
public prop key: K
```

Function: Returns the key in the view. If the view's key does not exist in the original map, returns an empty view of that key.

Type: K

### prop value

```cangjie
public mut prop value: ?V
```

Function: Reads or modifies the value corresponding to the view in the original map.  
When setting a non-null value, if the view's value does not exist, a new element will be added to the original map corresponding to this view.  
When set to `None`, the current Entry will be deleted. After deletion, the view can still be used.

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

Function: The [OrderedMap](collection_package_interface.md#interface-orderedmapk-v) interface provides a way to map keys to values. It allows us to use keys to look up values, making it suitable for storing and manipulating key-value pairs.

In instances of the [OrderedMap](collection_package_interface.md#interface-orderedmapk-v) interface, the internal elements are ordered.

Parent Types:

- [Map](collection_package_interface.md#interface-mapk-v)\<K, V>

### prop first

```cangjie
public prop first: ?(K, V)
```

Function: Gets the first element of the [OrderedMap](./collection_package_interface.md#interface-orderedmapk-v).

Type: ?(K, V)

### prop last

```cangjie
public prop last: ?(K, V)
```

Function: Gets the last element of the [OrderedMap](./collection_package_interface.md#interface-orderedmapk-v).

Type: ?(K, V)

### func removeFirst()

```cangjie
public func removeFirst(): ?(K, V)
```

Function: Removes the first element of the [OrderedMap](./collection_package_interface.md#interface-orderedmapk-v).

Return Value:

- ?(K, V) - If the current [OrderedMap](./collection_package_interface.md#interface-orderedmapk-v) is not empty, returns the removed key-value pair encapsulated in [Option](../../core/core_package_api/core_package_enums.md#enum-optiont); otherwise, returns `None`.

### func removeLast()

```cangjie
public func removeLast(): ?(K, V)
```

Function: Removes the last element of the [OrderedMap](./collection_package_interface.md#interface-orderedmapk-v).

Return Value:

- ?(K, V) - If the current [OrderedMap](./collection_package_interface.md#interface-orderedmapk-v) is not empty, returns the removed key-value pair encapsulated in [Option](../../core/core_package_api/core_package_enums.md#enum-optiont); otherwise, returns `None`.

### func backward(K, Bool)

```cangjie
public func backward(mark: K, inclusive!: Bool): Iterator<(K, V)>
```

Function: Gets an iterator that traverses from the first node with a key less than or equal to `mark` in descending order to [first](./collection_package_interface.md#prop-first). If the node's key equals `mark`, the inclusion of that node is determined by `inclusive!`.

Parameters:

- mark: K - The key used to determine the starting point.
- inclusive!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - When `mark` is the key of the first element in the iterator, specifies whether to include `mark` as the starting point.

Return Value:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<(K, V)> - The iterator.

### func forward(K, Bool)

```cangjie
public func forward(mark: K, inclusive!: Bool): Iterator<(K, V)>
```

Function: Gets an iterator that traverses from the first node with a key greater than or equal to `mark` in ascending order to [last](./collection_package_interface.md#prop-last). If the node's key equals `mark`, the inclusion of that node is determined by `inclusive!`.

Parameters:

- mark: K - The key used to determine the starting point.
- inclusive!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - When `mark` is the key of the first element in the iterator, specifies whether to include `mark` as the starting point.

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

Function: The [OrderedSet](collection_package_interface.md#interface-orderedsett) interface provides a set of operations for collections, allowing us to manipulate internal elements in a read-write manner.

In instances of the [OrderedSet](collection_package_interface.md#interface-orderedsett) interface, the internal elements are ordered.

Parent Types:

- [Set](collection_package_interface.md#interface-sett)\<T>

### prop first

```cangjie
public prop first: ?T
```

Function: Gets the first element of the [OrderedSet](collection_package_interface.md#interface-orderedsett).

Type: ?T

### prop last

```cangjie
public prop last: ?T
```

Function: Gets the last element of the [OrderedSet](collection_package_interface.md#interface-orderedsett).

Type: ?T

### func removeFirst()

```cangjie
public func removeFirst(): ?T
```

Function: Removes the first element of the [OrderedSet](collection_package_interface.md#interface-orderedsett).

Return Value:

- ?T - If the current [OrderedSet](collection_package_interface.md#interface-orderedsett) is not empty, returns the removed element encapsulated in [Option](../../core/core_package_api/core_package_enums.md#enum-optiont); otherwise, returns `None`.

### func removeLast()

```cangjie
public func removeLast(): ?T
```

Function: Removes the last element of the [OrderedSet](collection_package_interface.md#interface-orderedsett).

Return Value:

- ?T - If the current [OrderedSet](collection_package_interface.md#interface-orderedsett) is not empty, returns the removed element encapsulated in [Option](../../core/core_package_api/core_package_enums.md#enum-optiont); otherwise, returns `None`.

### func backward(T, Bool)

```cangjie
public func backward(mark: T, inclusive!: Bool): Iterator<T>
```

Function: Gets an iterator that traverses from the first node with an element less than or equal to `mark` in descending order to [first](./collection_package_interface.md#prop-first). If the node's element equals `mark`, the inclusion of that node is determined by `inclusive!`.

Parameters:

- mark: T - The element used to determine the starting point.
- inclusive!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - When `mark` is the first element in the iterator, specifies whether to include `mark` as the starting point.

Return Value:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - The iterator.

### func forward(T, Bool)

```cangjie
public func forward(mark: T, inclusive!: Bool): Iterator<T>
```

Function: Gets an iterator that traverses from the first node with an element greater than or equal to `mark` in ascending order to [last](./collection_package_interface.md#prop-last). If the node's element equals `mark`, the inclusion of that node is determined by `inclusive!`.

Parameters:

- mark: T - The element used to determine the starting point.
- inclusive!: [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - When `mark` is the first element in the iterator, specifies whether to include `mark` as the starting point.

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

Function: A queue data structure that follows the First-In-First-Out (FIFO) principle. The main functionalities of Queue include:

- Adding elements: Appends the specified element to the tail of the queue.
- Access operations: Accesses the front element of the queue without removing it.
- Removal operations: Removes the front element of the queue.
- Other operations supported by collection types, such as element count, emptiness check, and iterator operations.

Parent Types:

- [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T>

### func add(T)

```cangjie
func add(element: T): Unit
```

Function: Inserts the specified element at the tail of the queue.

Parameters:

- element: T - The element to be added to the queue.

### func peek()

```cangjie
func peek(): ?T
```

Function: Accesses the front element of the queue without removing it.

Return Value:

- ?T - The value of the front element encapsulated in Option. If the queue is empty, returns `None`.

### func remove()

```cangjie
func remove(): ?T
```

Function: Removes the front element of the queue and returns its value.

Return Value:

- ?T - The value of the removed element encapsulated in Option. If the queue is empty, returns `None`.

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

Parent Types:

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

Parameters:

- index: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The index of the element to return.

Return Value:

- ?T - The element at the specified position. If the index is less than 0 or greater than or equal to the number of elements in this list, returns None.

### operator func \[](Int64)

```cangjie
operator func [](index: Int64): T
```

Function: Operator overload - get.

Parameters:

- index: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The index for the get operation.

Return Value:

- T - The value of the element at the specified index.

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

A [ReadOnlyMap](collection_package_interface.md#interface-readonlymapk-v) cannot contain duplicate keys; each key can map to at most one value.

Parent Types:

- [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<(K, V)>

### func get(K)

```cangjie
func get(key: K): ?V
```

Function: Gets the value mapped to the key in the [ReadOnlyMap](collection_package_interface.md#interface-readonlymapk-v).

Parameters:

- key: K - The key used to look up the value.

Return Value:

- ?V - The value corresponding to the key in the [ReadOnlyMap](collection_package_interface.md#interface-readonlymapk-v).

### func contains(K)

```cangjie
func contains(key: K): Bool
```

Function: Determines whether a mapping for the specified key exists.

Parameters:

- key: K - The key to check.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if the key exists; otherwise, returns false.

### func contains(Collection\<K>)

```cangjie
func contains(all!: Collection<K>): Bool
```

Function: Determines whether mappings for all keys in the specified collection exist.

Parameters:

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<K> - The collection of keys to check.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if all keys exist; otherwise, returns false.

### func keys()

```cangjie
func keys(): EquatableCollection<K>
```

Function: Returns all keys in the [ReadOnlyMap](collection_package_interface.md#interface-readonlymapk-v), stored in an [EquatableCollection](collection_package_interface.md#interface-equatablecollectiont)\<K> container.

Return Value:

- [EquatableCollection](collection_package_interface.md#interface-equatablecollectiont)\<K> - Contains all returned keys.

### func values()

```cangjie
func values(): Collection<V>
```

Function: Returns all values in the [ReadOnlyMap](collection_package_interface.md#interface-readonlymapk-v), stored in a [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<V> container.

Return Value:

- [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<V> - Contains all returned values.

### operator func \[](K)

```cangjie
operator func [](key: K): V
```

Function: Operator overload for collection access. If the key exists, returns the corresponding value; otherwise, throws an exception.

Parameters:

- key: K - The key to look up.

Return Value:

- V - The value corresponding to the key.```markdown
## interface ReadOnlySet\<T>

```cangjie
public interface ReadOnlySet<T> <: Collection<T> {
    func contains(element: T): Bool
    func contains(all!: Collection<T>): Bool
    func subsetOf(other: ReadOnlySet<T>): Bool
}
```

Description: The [ReadOnlySet](collection_package_interface.md#interface-readonlysett) interface provides a set of collection operations, allowing read-only manipulation of internal elements.

Parent Types:

- [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T>

### func contains(T)

```cangjie
func contains(element: T): Bool
```

Description: Returns true if this set contains the specified element.

Parameters:

- element: T - The element to be checked.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if contained; otherwise, returns false.

### func contains(Collection\<T>)

```cangjie
func contains(all!: Collection<T>): Bool
```

Description: Checks whether this set contains another collection.

Parameters:

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T> - Another collection.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if this set contains the specified collection; otherwise, returns false.

### func subsetOf(ReadOnlySet\<T>)

```cangjie
func subsetOf(other: ReadOnlySet<T>): Bool
```

Description: Checks whether this set is a subset of another set.

Parameters:

- other: [ReadOnlySet](collection_package_interface.md#interface-readonlysett)\<T> - Another set.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if this set is a subset of the specified set; otherwise, returns false.

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

Description: The [Set](collection_package_interface.md#interface-sett) interface provides a set of collection operations, allowing read-write manipulation of internal elements.

The [Set](collection_package_interface.md#interface-sett) interface does not specify internal implementation. In instances of the [Set](collection_package_interface.md#interface-sett) interface, internal elements are typically unordered, cannot be accessed by index, and do not guarantee insertion order.

Parent Types:

- [ReadOnlySet](collection_package_interface.md#interface-readonlysett)\<T>

### func add(T)

```cangjie
func add(element: T): Bool
```

Description: Adds an element. If the element already exists, it will not be added.

Parameters:

- element: T - The element to be added.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if added successfully; otherwise, returns false.

### func add(Collection\<T>)

```cangjie
func add(all!: Collection<T>): Unit
```

Description: Adds all elements from the [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont) to this [Set](collection_package_interface.md#interface-sett). Existing elements will not be added.

Parameters:

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T> - The collection of elements to be added.

### func remove(T)

```cangjie
func remove(element: T): Bool
```

Description: Removes the specified element from this set (if present).

Parameters:

- element: T - The element to be removed.

Return Value:

- Bool - Returns `true` if the element existed and was removed successfully; otherwise, returns `false`.

### func remove(Collection\<T>)

```cangjie
func remove(all!: Collection<T>): Unit
```

Description: Removes all elements from this [Set](collection_package_interface.md#interface-sett) that are also contained in the specified [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont).

Parameters:

- all!: [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T> - The input [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T>.

### func removeIf((T) -> Bool)

```cangjie
func removeIf(predicate: (T) -> Bool): Unit
```

Description: Takes a lambda expression and removes elements that satisfy the `true` condition.

Parameters:

- predicate: (T) ->[Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - A lambda expression for evaluation.

### func clear()

```cangjie
func clear(): Unit
```

Description: Clears all key-value pairs.

### func retain(Set\<T>)

```cangjie
func retain(all!: Set<T>): Unit
```

Description: Retains only the elements in this [Set](collection_package_interface.md#interface-sett) that are also present in the input [Set](collection_package_interface.md#interface-sett).

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

Description: A Stack is a data structure that follows the Last In First Out (LIFO) principle. Insertion and deletion operations are performed at one end (called the top), while the other end (called the bottom) remains inactive.

Basic stack operations include push (add), pop (remove), and peek (view the top element).

Parent Types:

- [Collection](../../core/core_package_api/core_package_interfaces.md#interface-collectiont)\<T>

### func add(T)

```cangjie
func add(element: T): Unit
```

Description: Adds an element to the stack.

Parameters:

- element: T - The element to be placed at the top of the stack.

### func peek()

```cangjie
func peek(): ?T
```

Description: Views the top element without removing it.

Return Value:

- ?T - The top element of the stack. Returns `None` if the stack is empty.

### func remove()

```cangjie
func remove(): ?T
```

Description: Removes and returns the top element of the stack.

Return Value:

- ?T - The removed top element. Returns `None` if the stack is empty.
```