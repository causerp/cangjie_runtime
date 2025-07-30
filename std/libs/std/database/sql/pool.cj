/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.database.sql

import std.random.Random
import std.time.DateTime

interface Pool<T> <: Resource {
    func acquire(timeout: Duration): Option<Entry<T>>

    func release(entry: Entry<T>): Option<Unit>

    func discard(entry: Entry<T>): Option<Unit>
}

class Entry<T> {
    var value_: T
    let pool: Pool<T>

    var creationTime: Duration
    var lastAccessed: Duration = Duration.Zero
    var poolResetCount: Int32 = 0

    init(pool: Pool<T>, value: T) {
        this.pool = pool
        this.value_ = value
        let now = DateTime.now().toUnixTimeStamp()
        let rnd = Random()

        this.creationTime = now + Duration.second * rnd.nextFloat64()
    }

    prop value: T {
        get() {
            return this.value_
        }
    }

    func release() {
        this.lastAccessed = DateTime.now().toUnixTimeStamp()
        pool.release(this)
    }

    func idleDuration(): Duration {
        var now = DateTime.now().toUnixTimeStamp()
        return now - this.lastAccessed
    }
}
