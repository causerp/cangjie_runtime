/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.objectpool

import std.collection.concurrent.*

foreign func CJ_Gettid(): UInt64

const POOL_COUNT: UInt64 = 50 // count of LocalPool in each ObjectPool
const MIN_SIZE: Int64 = 1 << 10
const MAX_SIZE: Int64 = 1 << 31

@Deprecated
@When[backend == "cjnative"]
public class ObjectPool<T> where T <: Object {
    var pool: Array<ConcurrentLinkedQueue<T>>
    let newFunc: () -> T
    let resetFunc: Option<(T) -> T>

    public init(newFunc: () -> T, resetFunc!: Option<(T) -> T> = None) {
        pool = Array(Int64(POOL_COUNT), {_ => ConcurrentLinkedQueue<T>()})
        this.newFunc = newFunc
        this.resetFunc = resetFunc
    }

    public func get(): T {
        if (let Some(object) <- pool[Int64(unsafe { CJ_Gettid() } % POOL_COUNT)].remove()) {
            if (let Some(resetFn) <- resetFunc) {
                return resetFn(object)
            }
            return object
        }

        if (let Some(resetFn) <- resetFunc) {
            return resetFn(newFunc())
        }
        return newFunc()
    }

    public func put(item: T): Unit {
        pool[Int64(unsafe { CJ_Gettid() } % POOL_COUNT)].add(item)
    }
}
