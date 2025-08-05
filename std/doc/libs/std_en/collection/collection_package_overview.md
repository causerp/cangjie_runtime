# std.collection

## Feature Overview

The collection package provides efficient implementations of common data structures, definitions of related abstract interfaces, and frequently used functions for collection types.

This package implements the following commonly used data structures:

- [ArrayDeque](./collection_package_api/collection_package_class.md#class-arraydequet): A circular double-ended queue implemented using arrays, supporting element insertion and deletion at both ends. Elements can be inserted at the head or tail using the addFirst() and addLast() methods, and removed from the head or tail using removeFirst() and removeLast() methods.

- [ArrayList](./collection_package_api/collection_package_class.md#class-arraylistt): A resizable contiguous array. Use ArrayList when you need to store an indeterminate amount of data or dynamically adjust array size based on runtime conditions. Note that using ArrayList may increase memory allocation and deallocation overhead, so use it judiciously.

- [ArrayQueue](./collection_package_api/collection_package_class.md#class-arrayqueuet): A circular queue implemented using arrays, allowing element insertion only at the tail and deletion only at the head.

- [ArrayStack](./collection_package_api/collection_package_class.md#class-arraystackt): A stack data structure implemented using arrays. It follows the Last-In-First-Out (LIFO) principle, allowing insertion and deletion only at the top.

- [LinkedList](./collection_package_api/collection_package_class.md#class-linkedlistt): A linked list structure. The advantage of LinkedList is that it can dynamically add or remove elements without moving other elements, making it useful for scenarios requiring frequent additions or deletions. It also facilitates easy modification or deletion operations and can store multiple elements in the list. The disadvantage is that it requires additional memory to store references for each element, which may lead to memory waste.

- [HashMap](./collection_package_api/collection_package_class.md#class-hashmapk-v): A hash table that stores key-value pairs and allows quick value access based on keys. Use it when you need mapping relationships and fast lookups.

- [HashSet](./collection_package_api/collection_package_class.md#class-hashsett-where-t--hashable--equatablet): A set data structure implemented using a hash table, enabling fast element retrieval and deletion with efficient insertion, deletion, and lookup operations.

- [TreeMap](./collection_package_api/collection_package_class.md#class-treemapk-v-where-k--comparablek): An ordered map implemented using a red-black tree. Typically used when elements need to be sorted in natural order or a custom order.

- [TreeSet](./collection_package_api/collection_package_class.md#class-treesett-where-t--comparablet): An ordered set implemented using TreeMap. It automatically sorts elements and can be used to store unique data requiring sorting.

The collection types provided by this package do not support concurrency safety. For concurrent-safe collections, refer to the [collection.concurrent package](../collection_concurrent/collection_concurrent_package_overview.md).

## API List

### Functions

| Function Name | Description |
| ------------ | ------------ |
| [all\<T>((T) -> Bool)](./collection_package_api/collection_package_function.md#func-alltt---bool) | Determines if all elements in the iterator satisfy the condition. |
| [any\<T>((T) -> Bool)](./collection_package_api/collection_package_function.md#func-anytt---bool) | Determines if any element in the iterator satisfies the condition. |
| [at\<T>(Int64)](./collection_package_api/collection_package_function.md#func-attint64) | Retrieves the element at the specified position in the iterator. |
| [collectArrayList\<T>(Iterable\<T>)](./collection_package_api/collection_package_function.md#func-collectarraylisttiterablet) | Converts an iterator to an [ArrayList](./collection_package_api/collection_package_class.md#class-arraylistt) type. |
| [collectArray\<T>(Iterable\<T>)](./collection_package_api/collection_package_function.md#func-collectarraytiterablet) | Converts an iterator to an Array type. |
| [collectHashMap\<K, V>(Iterable\<(K, V)>) where K <: Hashable & Equatable\<K>](./collection_package_api/collection_package_function.md#func-collecthashmapk-viterablek-v-where-k--hashable--equatablek) | Converts an iterator to a HashMap type. |
| [collectHashSet\<T>(Iterable\<T>) where T <: Hashable & Equatable\<T>](./collection_package_api/collection_package_function.md#func-collecthashsettiterablet-where-t--hashable--equatablet) | Converts an iterator to a HashSet type. |
| [collectString\<T>(String) where T <: ToString](./collection_package_api/collection_package_function.md#func-collectstringtstring-where-t--tostring) | Converts an iterator whose elements implement the ToString interface to a String type. |
| [concat\<T>(Iterable\<T>)](./collection_package_api/collection_package_function.md#func-concattiterablet) | Concatenates two iterators. |
| [contains\<T>(T) where T <: Equatable\<T>](./collection_package_api/collection_package_function.md#func-containstt-where-t--equatablet) | Traverses all elements to determine if the specified element is present and returns it. |
| [count\<T>(Iterable\<T>)](./collection_package_api/collection_package_function.md#func-counttiterablet) | Counts the number of elements in the iterator. |
| [enumerate\<T>(Iterable\<T>)](./collection_package_api/collection_package_function.md#func-enumeratetiterablet) | Used to obtain an iterator with indices. |
| [filter\<T>((T) -> Bool)](./collection_package_api/collection_package_function.md#func-filtertt---bool) | Filters elements that satisfy the condition. |
| [filterMap\<T, R>((T) -> ?R)](./collection_package_api/collection_package_function.md#func-filtermapt-rt---r) | Performs both filtering and mapping operations, returning a new iterator. |
| [first\<T>(Iterable\<T>)](./collection_package_api/collection_package_function.md#func-firsttiterablet) | Retrieves the head element. |
| [flatMap\<T, R>( (T) -> Iterable\<R>)](./collection_package_api/collection_package_function.md#func-flatmapt-r-t---iterabler) | Creates a mapping with flatten functionality. |
| [flatten\<T, R>(Iterable\<T>) where T <: Iterable\<R>](./collection_package_api/collection_package_function.md#func-flattent-riterablet-where-t--iterabler) | Flattens a nested iterator by one level. |
| [fold\<T, R>(R, (R, T) -> R)](./collection_package_api/collection_package_function.md#func-foldt-rr-r-t---r) | Computes from left to right using the specified initial value. |
| [forEach\<T>((T) -> Unit)](./collection_package_api/collection_package_function.md#func-foreachtt---unit) | Traverses all elements and applies the specified operation. |
| [inspect\<T>((T) -> Unit)](./collection_package_api/collection_package_function.md#func-inspecttt---unit) | Performs an additional operation on the current element each time next() is called (does not consume the element). |
| [isEmpty\<T>(Iterable\<T>)](./collection_package_api/collection_package_function.md#func-isemptytiterablet) | Determines if the iterator is empty. |
| [last\<T>(Iterable\<T>)](./collection_package_api/collection_package_function.md#func-lasttiterablet) | Retrieves the tail element. |
| [map\<T, R>((T) -> R)](./collection_package_api/collection_package_function.md#func-mapt-rt---r) | Creates a mapping. |
| [max\<T>(Iterable\<T>) where T <: Comparable\<T>](./collection_package_api/collection_package_function.md#func-maxtiterablet-where-t--comparablet) | Filters the maximum element. |
| [min\<T>(Iterable\<T>) where T <: Comparable\<T>](./collection_package_api/collection_package_function.md#func-mintiterablet-where-t--comparablet) | Filters the minimum element. |
| [none\<T>((T) -> Bool)](./collection_package_api/collection_package_function.md#func-nonett---bool) | Determines if no elements in the iterator satisfy the condition. |
| [reduce\<T>((T, T) -> T)](./collection_package_api/collection_package_function.md#func-reducett-t---t) | Computes from left to right using the first element as the initial value. |
| [skip\<T>(Int64)](./collection_package_api/collection_package_function.md#func-skiptint64) | Skips a specified number of elements in the iterator. |
| [step\<T>(Int64)](./collection_package_api/collection_package_function.md#func-steptint64) | Skips a specified number of elements each time next() is called. |
| [take\<T>(Int64)](./collection_package_api/collection_package_function.md#func-taketint64) | Takes a specified number of elements from the iterator. |
| [zip\<T, R>(Iterable\<R>)](./collection_package_api/collection_package_function.md#func-zipt-riterabler) | Merges two iterators into one (length determined by the shorter iterator). |

### Interfaces

| Interface Name | Description |
| ------------ | ------------ |
| [Deque\<T>](./collection_package_api/collection_package_interface.md#interface-dequet)| A double-ended queue data structure that combines features of both queues and stacks, allowing insertion and deletion at both ends.|
| [EquatableCollection\<T>](./collection_package_api/collection_package_interface.md#interface-equatablecollectiont) | Defines collection types that can be compared.|
| [List\<T>](./collection_package_api/collection_package_interface.md#interface-listt)  |  Provides index-friendly list operations. |
| [Map\<K, V>](./collection_package_api/collection_package_interface.md#interface-mapk-v)  |  Provides a way to map keys to values. |
| [MapEntryView\<K, V>](./collection_package_api/collection_package_interface.md#interface-mapentryviewk-v) | A view of a specific key in a key-value pair collection. |
| [OrderedMap\<K, V>](./collection_package_api/collection_package_interface.md#interface-orderedmapk-v) | Ordered map. |
| [OrderedSet\<T>](./collection_package_api/collection_package_interface.md#interface-orderedsett) | Ordered set. |
| [Queue\<T>](./collection_package_api/collection_package_interface.md#interface-queuet)| A queue data structure following the First-In-First-Out (FIFO) principle. |
| [ReadOnlyList\<T>](./collection_package_api/collection_package_interface.md#interface-readonlylistt)  |  Defines read-only operations for lists. |
| [ReadOnlyMap\<K, V>](./collection_package_api/collection_package_interface.md#interface-readonlymapk-v) | Read-only map. |
| [ReadOnlySet\<K, V>](./collection_package_api/collection_package_interface.md#interface-readonlysett) | Read-only set. |
| [Set\<T>](./collection_package_api/collection_package_interface.md#interface-sett)   | A collection that does not contain duplicate elements. |
| [Stack\<T>](./collection_package_api/collection_package_interface.md#interface-stackt) | A stack data structure interface with Last-In-First-Out (LIFO) characteristics. |

### Classes

|  Class Name | Description |
| ------------ | ------------ |
| [ArrayDeque\<T>](./collection_package_api/collection_package_class.md#class-arraydequet)| A double-ended queue implemented using a resizable circular array.|
| [ArrayList\<T>](./collection_package_api/collection_package_class.md#class-arraylistt) | Provides functionality for resizable arrays. |
| [ArrayQueue\<T>](./collection_package_api/collection_package_class.md#class-arrayqueuet)| A circular queue data structure implemented using arrays.|
| [ArrayStack\<T>](./collection_package_api/collection_package_class.md#class-arraystackt) | A stack [Stack](./collection_package_api/collection_package_interface.md#interface-stackt) data structure implemented using arrays. |
| [HashMapIterator\<K, V> where K <: Hashable & Equatable\<K>](./collection_package_api/collection_package_class.md#class-hashmapiteratork-v-where-k--hashable--equatablek) | This class primarily implements the iterator functionality for HashMap. |
| [HashMap\<K, V> where K <: Hashable & Equatable\<K>](./collection_package_api/collection_package_class.md#class-hashmapk-v) |  A hash table implementation of the [Map\<K, V>](./collection_package_api/collection_package_interface.md#interface-mapk-v) interface. |
| [HashSet\<T> where T <: Hashable & Equatable\<T>](./collection_package_api/collection_package_class.md#class-hashsett-where-t--hashable--equatablet) | An implementation of the [Set\<T>](./collection_package_api/collection_package_interface.md#interface-sett) interface based on [HashMap\<K, V>](./collection_package_api/collection_package_class.md#class-hashmapk-v). |
| [LinkedListNode\<T>](./collection_package_api/collection_package_class.md#class-linkedlistnodet) | A node in [LinkedList\<T>](./collection_package_api/collection_package_class.md#class-linkedlistt). |
| [LinkedList\<T>](./collection_package_api/collection_package_class.md#class-linkedlistt) | Implements a doubly linked list data structure. |
| [TreeMap\<K, V> where K <: Comparable\<K>](./collection_package_api/collection_package_class.md#class-treemapk-v-where-k--comparablek) | An implementation of the [Map\<K, V>](./collection_package_api/collection_package_interface.md#interface-mapk-v) interface based on a balanced binary search tree. |
| [TreeSet\<T> where T <: Comparable\<T>](./collection_package_api/collection_package_class.md#class-treesett-where-t--comparablet) | An implementation of the [Set\<T>](./collection_package_api/collection_package_interface.md#interface-sett) interface based on [TreeMap\<K, V>](./collection_package_api/collection_package_class.md#class-treemapk-v-where-k--comparablek). |

### Exception Classes

| Exception Class Name | Description |
| ------------ | ------------ |
|[ConcurrentModificationException](./collection_package_api/collection_package_exception.md#class-concurrentmodificationexception)| Concurrent modification exception class.|