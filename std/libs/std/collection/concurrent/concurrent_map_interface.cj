/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.collection.concurrent

import std.collection.MapEntryView

/**
 * This interface is a key-value pair that does not guarantee the order of elements.
 * It declares the methods in a concurrent map that need to be atomic.
 */
public interface ConcurrentMap<K, V> {
    /**
     * Returns the value associated with @p key in ConcurrentMap
     *
     * @param key: transfer key to obtain the value
     *
     * @return:
     * - Some(v): if @p key associates with v;
     * - None: if @p key does not exist.
     */
    func get(key: K): ?V

    /**
     * Checks whether the mapping relationship corresponding to the specified key exists in this mapping.
     *
     * @param key: transfer the key to be judged.
     *
     * @return:
     * - true: if exists @p key in ConcurrentMap;
     * - false: if @p key does not exist.
     */
    func contains(key: K): Bool

    /**
     * Add a new key value to the map. If the key already exists,
     * the value will be overwritten and the overwritten value will be returned.
     *
     * @param key: the key to put;
     * @param value: the value to put.
     *
     * @return:
     * - None: if @p key does not exist before putting;
     * - Some(v): if @p key associated with v before putting.
     */
    @Deprecated[message: "Use member function `func add(key: K, value: V): ?V` instead."]
    func put(key: K, value: V): ?V
    func add(key: K, value: V): ?V

    /**
     * Associates the specified @p value with the specified @p key in this concurrent map,
     * if @p key does not in the concurrent map, before calling this method.
     * Otherwise, just returns the value that @p key maps to and does nothing.
     *
     * Such method is atomic (linearizable) in concurrency.
     *
     * @param key: the key to put.
     * @param value: the value to assign.
     *
     * @return:
     * - Some(v): if the pair of @p key and v exists before putting;
     * - None: if @p key does not exist in the concurrent map.
     */
    @Deprecated[message: "Use member function `func addIfAbsent(key: K, value: V): ?V` instead."]
    func putIfAbsent(key: K, value: V): ?V
    func addIfAbsent(key: K, value: V): ?V

    /**
     * Removes the key-value pair corresponding to @p key from this mapping, if one exists.
     *
     * @param key: pass in the key to be deleted.
     *
     * @return:
     * - Some(v): where the pair of @p key and v is the removed element;
     * - None: where @p key does not exist in the concurrent map.
     */
    func remove(key: K): ?V

    /**
     * Removes the pair of @p key and value, where predicate(value) = true holds,
     * from this concurrent map;
     * Otherwise, just returns 'false' and does nothing.
     *
     * @param key: the key of the key-value pair to be deleted.
     * @param predicate: the function justifies whether the pair of @p key and value should be removed.
     *
     * @return:
     * - Some(v): if exists the pair of @p key and v in concurrent map;
     * - None: if @p key does not in this concurrent map.
     */
    @Deprecated[message: "Use member function `func entryView(key: K, fn: (MapEntryView<K, V>)->Unit): ?V` instead."]
    func remove(key: K, predicate: (V) -> Bool): ?V

    /**
     * Replaces the value associated with @p key to @p value,
     * if there exists a pair of @p key and some value v in the concurrent hashmap.
     * Otherwise, just returns 'Option<V>.None' and does nothing.
     *
     * Such method is atomic (linearizable) in concurrency.
     *
     * @param key: the key of the key-value pair, whose value needs to be replaced.
     * @param value: the value to be replaced.
     *
     * @return:
     * - Some(v): if the pair of @p key and v exists in concurrent map before invoking this method.
     * - None: if @p key is not in the concurrent map.
     */
    func replace(key: K, value: V): ?V

    /**
     * Replaces the value associated with @p key to eval(v),
     * if there exists a pair of @p key and v in the concurrent hashmap.
     * Otherwise, just returns 'Option<V>.None' and does nothing.
     *
     * Such method is atomic (linearizable) in concurrency.
     *
     * @param key: the key to put.
     * @param eval: function to evaluate the value to put.
     * @p eval evaluates the value according to the old value v.
     *
     * @return:
     * - Some(v): if the pair of @p key and v exists in concurrent map before invoking this method.
     * - None: if @p key is not in the concurrent map.
     */
    @Deprecated[message: "Use member function `func entryView(key: K, fn: (MapEntryView<K, V>)->Unit): ?V` instead."]
    func replace(key: K, eval: (V) -> V): ?V

    /**
     * Replaces the value associated with @p key to eval(v),
     * if the pair of @p key and v in the concurrent map, and @p predicate(v) holds.
     *
     * Such method is atomic (linearizable) in concurrency.
     *
     * @param key: the key of the key-value pair, whose value needs to be replaced.
     * @param predicate: the function justifies whether @p key-v pair in the concurrent map should be replaced.
     * @param eval: the function evaluates the new value to replace the old value.
     *
     * @return:
     * - Some(v): if the pair of @p key and v exists in concurrent map before replacing;
     * - None: if @p key does not exist in concurrent map.
     */
    @Deprecated[message: "Use member function `func entryView(key: K, fn: (MapEntryView<K, V>)->Unit): ?V` instead."]
    func replace(key: K, predicate: (V) -> Bool, eval: (V) -> V): ?V

    /**
     * Get the entryView according to @p key and process it according to @p fn,
     * return the value associated with @p key after processing.
     *
     * @param key: the key of the key-value pair, whose value needs to be process.
     * @param fn: the process function.
     *
     * @return:
     * - Some(v): v is the value associated with @p key after processing.
     * - None: the @p key does not exist in map after processing.
     */
    func entryView(key: K, fn: (MapEntryView<K, V>) -> Unit): ?V

    /**
     * Returns the value associated with @p key in ConcurrentMap
     *
     * @param key: transfer key to obtain the value
     *
     * @return:
     * - the value associated with @p key
     */
    operator func [](key: K): V

    /**
     * Set the value associated with @p key to value,
     * if the key already exists in map, add the new key-value pair to the map.
     *
     * @param key: the key to put.
     * @param value: the value to put.
     */
    operator func [](key: K, value!: V): Unit
}
