# Functions

## func all\<T>((T) -> Bool)

```cangjie
public func all<T>(predicate: (T) -> Bool): (Iterable<T>) -> Bool
```

Function: Determines whether all elements in the iterator satisfy the given condition.

Parameters:

- predicate: (T) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The specified condition.

Return Value:

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns a function that checks if all elements satisfy the condition.

## func any\<T>((T) -> Bool)

```cangjie
public func any<T>(predicate: (T) -> Bool): (Iterable<T>) -> Bool
```

Function: Determines whether any element in the iterator satisfies the given condition.

Parameters:

- predicate: (T) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The specified condition.

Return Value:

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns a function that checks if any element satisfies the condition.

## func at\<T>(Int64)

```cangjie
public func at<T>(n: Int64): (Iterable<T>) -> Option<T>
```

Function: Retrieves the element at the specified position in the iterator.

Parameters:

- n: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The specified position index.

Return Value:

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - Returns a function to get the element at the specified position. Returns None if the iterator is empty.

## func collectArrayList\<T>(Iterable\<T>)

```cangjie
public func collectArrayList<T>(it: Iterable<T>): ArrayList<T>
```

Function: Converts an iterator to an [ArrayList](collection_package_class.md#class-arraylistt) type.

Parameters:

- it: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - The given iterator.

Return Value:

- [ArrayList](collection_package_class.md#class-arraylistt)\<T> - Returns an [ArrayList](collection_package_class.md#class-arraylistt).

## func collectArray\<T>(Iterable\<T>)

```cangjie
public func collectArray<T>(it: Iterable<T>): Array<T>
```

Function: Converts an iterator to an [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt) type.

Parameters:

- it: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - The given iterator.

Return Value:

- [Array](../../core/core_package_api/core_package_structs.md#struct-arrayt)\<T> - Returns an array.

## func collectHashMap\<K, V>(Iterable\<(K, V)>) where K <: Hashable & Equatable\<K>

```cangjie
public func collectHashMap<K, V>(it: Iterable<(K, V)>): HashMap<K, V> where K <: Hashable & Equatable<K>
```

Function: Converts an iterator to a [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek) type.

Parameters:

- it: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<(K, V)> - The given iterator.

Return Value:

- [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek)\<K, V> - Returns a [HashMap](collection_package_class.md#class-hashmapk-v-where-k--hashable--equatablek).

## func collectHashSet\<T>(Iterable\<T>) where T <: Hashable & Equatable\<T>

```cangjie
public func collectHashSet<T>(it: Iterable<T>): HashSet<T> where T <: Hashable & Equatable<T>
```

Function: Converts an iterator to a [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet) type.

Parameters:

- it: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - The given iterator.

Return Value:

- [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet)\<T> - Returns a [HashSet](collection_package_class.md#class-hashsett-where-t--hashable--equatablet).

## func collectString\<T>(String) where T <: ToString

```cangjie
public func collectString<T>(delimiter!: String = ""): (Iterable<T>) -> String where T <: ToString
```

Function: Converts an iterator (whose elements implement the [ToString](../../core/core_package_api/core_package_interfaces.md#interface-tostring) interface) to a [String](../../core/core_package_api/core_package_structs.md#struct-string) type.

Parameters:

- delimiter!: [String](../../core/core_package_api/core_package_structs.md#struct-string) - The string concatenation delimiter.

Return Value:

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> [String](../../core/core_package_api/core_package_structs.md#struct-string) - Returns a conversion function.

## func concat\<T>(Iterable\<T>)

```cangjie
public func concat<T>(other: Iterable<T>): (Iterable<T>) -> Iterator<T>
```

Function: Concatenates two iterators.

Parameters:

- other: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - The iterator to be concatenated at the end.

Return Value:

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - Returns a concatenation function.

## func contains\<T>(T) where T <: Equatable\<T>

```cangjie
public func contains<T>(element: T): (Iterable<T>) -> Bool where T <: Equatable<T>
```

Function: Obtains a search function for a specific element.

Parameters:

- element: T - The element to search for.

Return Value:

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns a search function.

Example:

<!-- verify -->
```cangjie
import std.collection.*

main() {
    var searchFunc = contains<Int64>(6) // Obtains a function to search for element 6
    let arr = ArrayList.of([1, 2, 3, 4, 5, 6])
    let i = arr.iterator()
    var result = searchFunc(i) // Calls the function
    println(result)
    searchFunc = contains<Int64>(7) // Obtains a function to search for element 7
    result = searchFunc(i) // Calls the function
    println(result)
    return 0
}
```

Execution Result:

```text
true
false
```

## func count\<T>(Iterable\<T>)

```cangjie
public func count<T>(it: Iterable<T>): Int64
```

Function: Counts the number of elements in the iterator.

Parameters:

- it: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - The given iterator.

Return Value:

- [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - Returns the number of elements in the iterator.

## func enumerate\<T>(Iterable\<T>)

```cangjie
public func enumerate<T>(it: Iterable<T>): Iterator<(Int64, T)>
```

Function: Obtains an iterator with indices.

Parameters:

- it: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - The given iterator.

Return Value:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<([Int64](../../core/core_package_api/core_package_intrinsics.md#int64), T)> - Returns an iterator with indices.

## func filter\<T>((T) -> Bool)

```cangjie
public func filter<T>(predicate: (T) -> Bool): (Iterable<T>) -> Iterator<T>
```

Function: Filters elements that satisfy the given condition.

Parameters:

- predicate: (T) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The specified condition.

Return Value:

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - Returns a filtering function.

## func filterMap\<T, R>((T) -> ?R)

```cangjie
public func filterMap<T, R>(transform: (T)-> ?R): (Iterable<T>) ->Iterator<R>
```

Function: Performs both filtering and mapping operations simultaneously, returning a new iterator.

Parameters:

- transform: (T) -> ?R - The specified mapping function. A return value of Some corresponds to predicate=true in filter, while None indicates false.

Return Value:

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<R> - Returns a combined filtering and mapping function.

## func first\<T>(Iterable\<T>)

```cangjie
public func first<T>(it: Iterable<T>): Option<T>
```

Function: Retrieves the first element.

Parameters:

- it: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - The given iterator.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - Returns the first element, or None if empty.

## func flatMap\<T, R>( (T) -> Iterable\<R>)

```cangjie
public func flatMap<T, R>(transform: (T) -> Iterable<R>): (Iterable<T>) -> Iterator<R>
```

Function: Creates a mapping with [flatten](collection_package_function.md#func-flattent-riterablet-where-t--iterabler) functionality.

Parameters:

- transform: (T) -> [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<R> - The specified mapping function.

Return Value:

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<R> - Returns a mapping function with [flatten](collection_package_function.md#func-flattent-riterablet-where-t--iterabler) functionality.

## func flatten\<T, R>(Iterable\<T>) where T <: Iterable\<R>

```cangjie
public func flatten<T, R>(it: Iterable<T>): Iterator<R> where T <: Iterable<R>
```

Function: Flattens a nested iterator by one level.

Parameters:

- it: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - The given iterator.

Return Value:

- [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<R> - Returns the iterator flattened by one level.## func fold\<T, R>(R, (R, T) -> R)

```cangjie
public func fold<T, R>(initial: R, operation: (R, T) -> R): (Iterable<T>) -> R
```

Function: Performs a left-associative fold operation using the specified initial value.

Parameters:

- initial: R - The initial value of type R.
- operation: (R, T) -> R - The computation function to apply.

Return Value:

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> R - Returns a folding function.

## func forEach\<T>((T) -> Unit)

```cangjie
public func forEach<T>(action: (T) -> Unit): (Iterable<T>) -> Unit
```

Function: Iterates through all elements and applies the specified action.

Parameters:

- action: (T) -> [Unit](../../core/core_package_api/core_package_intrinsics.md#unit) - The action function to apply.

Return Value:

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> [Unit](../../core/core_package_api/core_package_intrinsics.md#unit) - Returns a function that performs the iteration operation.

## func inspect\<T>((T) -> Unit)

```cangjie
public func inspect<T>(action: (T)->Unit): (Iterable<T>) ->Iterator<T>
```

Function: Performs an additional operation on the current element each time the iterator's next() is called (without consuming the iterator's elements).

Parameters:

- action: (T) -> [Unit](../../core/core_package_api/core_package_intrinsics.md#unit) - The action function to apply.

Return Value:

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - Returns a function that performs additional operations on each iterator element.

## func isEmpty\<T>(Iterable\<T>)

```cangjie
public func isEmpty<T>(it: Iterable<T>): Bool
```

Function: Checks whether the iterator is empty.

Parameters:

- it: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - The given iterator.

Return Value:

- [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns whether the iterator is empty.

## func last\<T>(Iterable\<T>)

```cangjie
public func last<T>(it: Iterable<T>): Option<T>
```

Function: Retrieves the last element.

Parameters:

- it: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - The given iterator.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - Returns the last element, or None if empty.

## func map\<T, R>((T) -> R)

```cangjie
public func map<T, R>(transform: (T) -> R): (Iterable<T>) -> Iterator<R>
```

Function: Creates a mapping.

Parameters:

- transform: (T) -> R - The mapping function to apply.

Return Value:

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<R> - Returns a mapping function.

## func max\<T>(Iterable\<T>) where T <: Comparable\<T>

```cangjie
public func max<T>(it: Iterable<T>): Option<T> where T <: Comparable<T>
```

Function: Finds the maximum element.

Parameters:

- it: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - The given iterator.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - Returns the maximum element, or None if empty.

## func min\<T>(Iterable\<T>) where T <: Comparable\<T>

```cangjie
public func min<T>(it: Iterable<T>): Option<T> where T <: Comparable<T>
```

Function: Finds the minimum element.

Parameters:

- it: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T> - The given iterator.

Return Value:

- [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - Returns the minimum element, or None if empty.

## func none\<T>((T) -> Bool)

```cangjie
public func none<T>(predicate: (T) -> Bool): (Iterable<T>) -> Bool
```

Function: Checks whether no elements in the iterator satisfy the condition.

Parameters:

- predicate: (T) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - The condition to check.

Return Value:

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> [Bool](../../core/core_package_api/core_package_intrinsics.md#bool) - Returns a function that checks whether no elements satisfy the condition.

## func reduce\<T>((T, T) -> T)

```cangjie
public func reduce<T>(operation: (T, T) -> T): (Iterable<T>) -> Option<T>
```

Function: Performs a left-associative reduction using the first element as the initial value.

Parameters:

- operation: (T, T) -> T - The operation function to apply.

Return Value:

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> [Option](../../core/core_package_api/core_package_enums.md#enum-optiont)\<T> - Returns a reduction function.

## func skip\<T>(Int64)

```cangjie
public func skip<T>(count: Int64): (Iterable<T>) -> Iterator<T>
```

Function: Skips a specified number of elements from the iterator.

Throws an exception when count < 0. When count = 0, returns the original iterator unchanged. When count > 0 and count < iterator size, skips count elements and returns a new iterator with remaining elements. When count ≥ iterator size, skips all elements and returns an empty iterator.

Parameters:

- count: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The number of elements to skip.

Return Value:

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - Returns a function that skips the specified number of elements.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when count < 0.

## func step\<T>(Int64)

```cangjie
public func step<T>(count: Int64): (Iterable<T>) -> Iterator<T>
```

Function: Skips a specified number of elements each time next() is called on the iterator.

Throws an exception when count ≤ 0. When count > 0, each next() call skips count elements until the iterator is empty.

Parameters:

- count: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The number of elements to skip per next() call.

Return Value:

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - Returns a function that modifies the iterator to skip specified elements per next() call.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when count ≤ 0.

## func take\<T>(Int64)

```cangjie
public func take<T>(count: Int64): (Iterable<T>) -> Iterator<T>
```

Function: Takes a specified number of elements from the iterator.

Throws an exception when count < 0. When count = 0, takes no elements and returns an empty iterator. When count > 0 and count < iterator size, takes the first count elements and returns a new iterator. When count ≥ iterator size, takes all elements and returns the original iterator.

Parameters:

- count: [Int64](../../core/core_package_api/core_package_intrinsics.md#int64) - The number of elements to take.

Return Value:

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<T> - Returns a function that takes the specified number of elements.

Exceptions:

- [IllegalArgumentException](../../core/core_package_api/core_package_exceptions.md#class-illegalargumentexception) - Thrown when count < 0.

## func zip\<T, R>(Iterable\<R>)

```cangjie
public func zip<T, R>(other: Iterable<R>): (Iterable<T>) -> Iterator<(T, R)>
```

Function: Merges two iterators into one (length determined by the shorter iterator).

Parameters:

- other: [Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<R> - One of the iterators to merge.

Return Value:

- ([Iterable](../../core/core_package_api/core_package_interfaces.md#interface-iterablee)\<T>) -> [Iterator](../../core/core_package_api/core_package_classes.md#class-iteratort)\<(T, R)> - Returns a merging function.