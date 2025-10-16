/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.database.sql

struct Options<T> {
    var maxIdleSize: Int32
    var maxSize: Int32
    var idleTimeout: Duration
    var maxLifeTime: Duration
    var keepaliveTime: Duration
    let constructor: () -> Option<T>
    let destructor: (T) -> Option<Unit>
    init(
        maxIdleSize: Int32,
        maxSize: Int32,
        idleTimeout: Duration,
        maxLifeTime: Duration,
        keepaliveTime: Duration,
        constructor: () -> Option<T>,
        destructor: (T) -> Option<Unit>
    ) {
        this.maxIdleSize = maxIdleSize
        this.maxSize = maxSize
        this.idleTimeout = idleTimeout
        this.maxLifeTime = maxLifeTime
        this.keepaliveTime = keepaliveTime
        this.constructor = constructor
        this.destructor = destructor
    }
}
