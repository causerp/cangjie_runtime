# Interface

## interface ConcurrentMap\<K, V>

```cangjie
public interface ConcurrentMap<K, V> {
    func add(key: K, value: V): ?V
    func addIfAbsent(key: K, value: V): ?V
    func entryView(key: K, fn: (MapEntryView<K, V>) -> Unit): ?V
    func get(key: K): ?V
    func contains(key: K): Bool
    func put(key: K, value: V): ?V
    func putIfAbsent(key: K, value: V): ?V
    func remove(key: K): ?V
    func remove(key: K, predicate: (V) -> Bool): ?V
    func replace(key: K, value: V): ?V
    func replace(key: K, eval: (V) -> V): ?V
    func replace(key: K, predicate: (V) -> Bool, eval: (V) -> V): ?V
    operator func [](key: K): V
    operator func [](key: K, value!: V): Unit
}
```

Functionality: Defines a thread-safe [Map](../../collection/collection_package_api/collection_package_interface.md#interface-mapk-v) interface with guaranteed atomic operations.

The [ConcurrentMap](collection_concurrent_interface.md#interface-concurrentmapk-v) interface declares thread-safe methods that must maintain **atomicity** in concurrent scenarios for [Map](../../collection/collection_package_api/collection_package_interface.md#interface-mapk-v). We expect all thread-safe [Map](../../collection/collection_package_api/collection_package_interface.md#interface-mapk-v) classes to implement the [ConcurrentMap](collection_concurrent_interface.md#interface-concurrentmapk-v) interface. For example, the [ConcurrentHashMap](collection_concurrent_class.md#class-concurrenthashmapk-v-where-k--hashable--equatablek) defined in this package implements the [ConcurrentMap](collection_concurrent_interface.md#interface-concurrentmapk-v) interface and provides atomic implementations for all methods declared in [ConcurrentMap](collection_concurrent_interface.md#interface-concurrentmapk-v).

The [ConcurrentMap](collection_concurrent_interface.md#interface-concurrentmapk-v) interface declares methods that concurrent [Map](../../collection/collection_package_api/collection_package_interface.md#interface-mapk-v) implementations must guarantee atomicity for in concurrent scenarios.

A concurrent [Map](../../collection/collection_package_api/collection_package_interface.md#interface-mapk-v) represents a mapping from "key" to "value", where K is the type of the key and V is the type of the value.

### func add(K, V)

```cangjie
func add(key: K, value: V): ?V
```

Functionality: Associates the specified value with the specified key in this [Map](../../collection/collection_package_api/collection_package_interface.md#interface-mapk-v). If the [Map](../../collection/collection_package_api/collection_package_interface.md#interface-mapk-v) already contains a mapping for the key, the old value is replaced; if the [Map](../../collection/collection_package_api/collection_package_interface.md#interface-mapk-v) does not contain the key, a new key-value association is added.

Parameters:

- key: K - The key to be placed.
- value: V - The value to be associated.

Return value:

- ?V - Returns the old value Some(V) if the key existed before assignment; returns None if the key did not exist before assignment.

### func addIfAbsent(K, V)

```cangjie
func addIfAbsent(key: K, value: V): ?V
```

Functionality: Associates the specified value with the specified key in this [Map](../../collection/collection_package_api/collection_package_interface.md#interface-mapk-v) if the key is not already associated with a value. If the [Map](../../collection/collection_package_api/collection_package_interface.md#interface-mapk-v) already contains the key, no assignment operation is performed.

Parameters:

- key: K - The key to be placed.
- value: V - The value to be assigned.

Return value:

- ?V - Returns the current value Some(V) associated with the key if it existed before assignment (no assignment is performed); returns None if the key did not exist before assignment.

### func contains(K)

```cangjie
func contains(key: K): Bool
```

Functionality: Determines whether this [Map](../../collection/collection_package_api/collection_package_interface.md#interface-mapk-v) contains a mapping for the specified key.

Parameters:

- key: K - The key to be checked.

Return value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns true if the key exists; returns false if the key does not exist.

### func entryView(K, (MapEntryView\<K, V>) -> Unit)

```cangjie
func entryView(key: K, fn: (MapEntryView<K, V>) -> Unit): ?V
```

Functionality: Retrieves the key-value pair view entryView corresponding to the specified key in the current mapping, invokes the function fn to perform add, delete, or modify operations on this key-value pair, and returns the final value associated with the key in the mapping.

If the current mapping does not contain the key, an empty view entryView will be obtained. If its value is set to a non-None value, a new key-value pair will be added to the current mapping.

If the current mapping contains the key, the key-value view will be obtained. Setting the value to None is equivalent to deleting the key-value pair from the current mapping; setting the value to a new non-None value is equivalent to modifying the value associated with the key in the current mapping.

Parameters:

- key: K - The key whose corresponding view is to be obtained.
- fn: ([MapEntryView](../../collection/collection_package_api/collection_package_interface.md#interface-mapentryviewk-v)\<K, V>) -> [Unit](../../core/core_package_api/core_package_intrinsics.md#unit) - Custom operations to be performed on the specified view, which can be used to add, delete, or modify key-value pairs in the mapping.

Return value:

- ?V - The value associated with the key in the current mapping after fn is invoked. Returns None if the key does not exist.

### func get(K)

```cangjie
func get(key: K): ?V
```

Functionality: Returns the value to which the specified key is mapped in this [Map](../../collection/collection_package_api/collection_package_interface.md#interface-mapk-v).

Parameters:

- key: K - The key whose associated value is to be returned.

Return value:

- ?V - Returns the associated value Some(V) if the key exists; returns None if the key does not exist.

### func put(K, V) <sup>(deprecated)</sup>

```cangjie
func put(key: K, value: V): ?V
```

Functionality: Associates the specified value with the specified key in this [Map](../../collection/collection_package_api/collection_package_interface.md#interface-mapk-v). If the [Map](../../collection/collection_package_api/collection_package_interface.md#interface-mapk-v) already contains a mapping for the key, the old value is replaced; if the [Map](../../collection/collection_package_api/collection_package_interface.md#interface-mapk-v) does not contain the key, a new key-value association is added.

> **Note:**
>
> Will be deprecated in future versions. Use [add(K, V)](#func-addk-v) instead.

Parameters:

- key: K - The key to be placed.
- value: V - The value to be associated.

Return value:

- ?V - Returns the old value Some(V) if the key existed before assignment; returns None if the key did not exist before assignment.

### func putIfAbsent(K, V) <sup>(deprecated)</sup>

```cangjie
func putIfAbsent(key: K, value: V): ?V
```

Functionality: Associates the specified value with the specified key in this [Map](../../collection/collection_package_api/collection_package_interface.md#interface-mapk-v) if the key is not already associated with a value. If the [Map](../../collection/collection_package_api/collection_package_interface.md#interface-mapk-v) already contains the key, no assignment operation is performed.

> **Note:**
>
> Will be deprecated in future versions. Use [addIfAbsent(K, V)](#func-addifabsentk-v) instead.

Parameters:

- key: K - The key to be placed.
- value: V - The value to be assigned.

Return value:

- ?V - Returns the current value Some(V) associated with the key if it existed before assignment (no assignment is performed); returns None if the key did not exist before assignment.

### func remove(K)

```cangjie
func remove(key: K): ?V
```

Functionality: Removes the mapping for the specified key from this map if present.

Parameters:

- key: K - The key whose mapping is to be removed.

Return value:

- ?V - Returns the value Some(V) associated with the key if it existed before removal; returns None if the key did not exist when removed.

### func remove(K, (V) -> Bool) <sup>(deprecated)</sup>

```cangjie
func remove(key: K, predicate: (V) -> Bool): ?V
```

Functionality: Removes the mapping for the specified key from this [Map](../../collection/collection_package_api/collection_package_interface.md#interface-mapk-v) if the key exists and its associated value v satisfies the predicate condition.

> **Note:**
>
> Will be deprecated in future versions. Use [entryView(K, (MapEntryView\<K, V>) -> Unit)](#func-entryviewk-mapentryviewk-v---unit) instead.

Parameters:

- key: K - The key whose mapping is to be removed.
- predicate: (V) ->[Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - A lambda expression used for evaluation.

Return value:

- ?V - Returns the old value Some(V) associated with the key if it existed in the [Map](../../collection/collection_package_api/collection_package_interface.md#interface-mapk-v); returns None if the key did not exist in the [Map](../../collection/collection_package_api/collection_package_interface.md#interface-mapk-v) or if its associated value did not satisfy the predicate.

### func replace(K, (V) -> Bool, (V) -> V) <sup>(deprecated)</sup>

```cangjie
func replace(key: K, predicate: (V) -> Bool, eval: (V) -> V): ?V
```

Functionality: If the [Map](../../collection/collection_package_api/collection_package_interface.md#interface-mapk-v) contains the specified key (assuming its associated value is v) and v satisfies the predicate condition, replaces the value associated with the key in the [Map](../../collection/collection_package_api/collection_package_interface.md#interface-mapk-v) with the result of eval(v); if the [Map](../../collection/collection_package_api/collection_package_interface.md#interface-mapk-v) does not contain the key or the associated value does not satisfy the predicate, no modification is made to the [Map](../../collection/collection_package_api/collection_package_interface.md#interface-mapk-v).

> **Note:**
>
> Will be deprecated in future versions. Use [entryView(K, (MapEntryView\<K, V>) -> Unit)](#func-entryviewk-mapentryviewk-v---unit) instead.

Parameters:

- key: K - The key whose associated value is to be replaced.
- predicate: (V) ->[Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - A lambda expression used for evaluation.
- eval: (V) ->V - A function that computes the new replacement value.

Return value:

- ?V - Returns the old value Some(V) associated with the key if it existed; returns None if the key did not exist or its associated value did not satisfy the predicate.

### func replace(K, (V) -> V) <sup>(deprecated)</sup>

```cangjie
func replace(key: K, eval: (V) -> V): ?V
```

Functionality: If the [Map](../../collection/collection_package_api/collection_package_interface.md#interface-mapk-v) contains the specified key (assuming its associated value is v), replaces the value associated with the key in the [Map](../../collection/collection_package_api/collection_package_interface.md#interface-mapk-v) with the result of eval(v); if the [Map](../../collection/collection_package_api/collection_package_interface.md#interface-mapk-v) does not contain the key, no modification is made to the [Map](../../collection/collection_package_api/collection_package_interface.md#interface-mapk-v).

> **Note:**
>
> Will be deprecated in future versions. Use [entryView(K, (MapEntryView\<K, V>) -> Unit)](#func-entryviewk-mapentryviewk-v---unit) instead.

Parameters:

- key: K - The key whose associated value is to be replaced.
- eval: (V) ->V - A function that computes the new replacement value.

Return value:

- ?V - Returns the old value Some(V) associated with the key if it existed; returns None if the key did not exist.

### func replace(K, V)

```cangjie
func replace(key: K, value: V): ?V
```

Functionality: If the [Map](../../collection/collection_package_api/collection_package_interface.md#interface-mapk-v) contains the key, replaces the value associated with the key in the [Map](../../collection/collection_package_api/collection_package_interface.md#interface-mapk-v) with the specified value; if the [Map](../../collection/collection_package_api/collection_package_interface.md#interface-mapk-v) does not contain the key, no modification is made to the [Map](../../collection/collection_package_api/collection_package_interface.md#interface-mapk-v).

Parameters:

- key: K - The key whose associated value is to be replaced.
- value: V - The new replacement value.

Return value:

- ?V - Returns the old value Some(V) associated with the key if it existed; returns None if the key did not exist.

### operator func \[](K)

```cangjie
operator func [](key: K): V
```

Functionality: Retrieves the value associated with the specified key. Throws an exception if the key does not exist.

Parameters:

- key: K - The key whose associated value is to be returned.

Return value:

- V - The value associated with the key.

Exceptions:

- [NoneValueException](../../core/core_package_api/core_package_exceptions.md#class-nonevalueexception) - Thrown when the key does not exist in the current mapping.

### operator func \[](K, V)

```cangjie
operator func [](key: K, value!: V): Unit
```

Functionality: Sets the value associated with the specified key. If the key exists, the new value overwrites the old value; if the key does not exist, adds this key-value pair.

Parameters:

- key: K - The key whose value is to be set.
- value!: V - The value to be set.