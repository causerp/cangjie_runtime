# std.collection.concurrent

## Feature Overview

The collection.concurrent package provides thread-safe implementations of collection types.

This package implements the following thread-safe collection types:

- [ArrayBlockingQueue](./collection_concurrent_package_api/collection_concurrent_class.md#class-arrayblockingqueuee): A bounded queue with fixed capacity implemented using an array.

- [ConcurrentHashMap](./collection_concurrent_package_api/collection_concurrent_class.md#class-concurrenthashmapk-v-where-k--hashable--equatablek): A thread-safe hash table implementation supporting high-concurrency read/write operations.

- [ConcurrentLinkedQueue](./collection_concurrent_package_api/collection_concurrent_class.md#class-concurrentlinkedqueuee): A thread-safe queue data structure that creates new blocks when the current tail block is full during element insertion, rather than blocking. This ensures queue operations won't cause thread blocking in multi-threaded environments, thereby improving program performance.

- [LinkedBlockingQueue](./collection_concurrent_package_api/collection_concurrent_class.md#class-linkedblockingqueuee): A blocking queue that supports blocking operations when retrieving elements from an empty queue or adding elements to a full queue.

## API List

### Type Aliases

| Type Alias | Description |
| ---------- | ----------- |
| [BlockingQueue\<E> <sup>(deprecated)</sup>](./collection_concurrent_package_api/collection_concurrent_types.md#type-blockingqueuee-deprecated) | Alias for LinkedBlockingQueue. |
| [NonBlockingQueue\<E> <sup>(deprecated)</sup>](./collection_concurrent_package_api/collection_concurrent_types.md#type-nonblockingqueuee-deprecated) | Alias for ConcurrentLinkedQueue. |

### Interfaces

| Interface | Description |
| --------- | ----------- |
| [ConcurrentMap\<K, V>](./collection_concurrent_package_api/collection_concurrent_interface.md#interface-concurrentmapk-v) | Defines thread-safe Map interface with atomic operations guarantee. |

### Classes

| Class | Description |
| ----- | ----------- |
| [ArrayBlockingQueue\<E>](./collection_concurrent_package_api/collection_concurrent_class.md#class-arrayblockingqueuee) | Array-based Blocking Queue data structure and related operations. |
| [ConcurrentHashMapIterator\<K, V> where K <: Hashable & Equatable\<K>](./collection_concurrent_package_api/collection_concurrent_class.md#class-concurrenthashmapiteratork-v-where-k--hashable--equatablek) | Implements iterator functionality for ConcurrentHashMap. |
| [ConcurrentHashMap\<K, V> where K <: Hashable & Equatable\<K>](./collection_concurrent_package_api/collection_concurrent_class.md#class-concurrenthashmapk-v-where-k--hashable--equatablek) | Implements thread-safe ConcurrentHashMap data structure and related operations for concurrent scenarios. |
| [ConcurrentLinkedQueue\<E>](./collection_concurrent_package_api/collection_concurrent_class.md#class-concurrentlinkedqueuee) | Provides a thread-safe queue supporting safe element insertion and removal in multi-threaded environments. |
| [LinkedBlockingQueue\<E>](./collection_concurrent_package_api/collection_concurrent_class.md#class-linkedblockingqueuee) | Implements a concurrent queue with blocking mechanism and user-specified capacity limit. |