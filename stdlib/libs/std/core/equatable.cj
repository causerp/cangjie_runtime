/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.core

public interface Equal<T> {
    operator func ==(other: T): Bool
}

public interface NotEqual<T> {
    operator func !=(other: T): Bool
}

public interface Equatable<T> <: Equal<T> & NotEqual<T> {
    operator func !=(other: T): Bool {
        !(this == other)
    }
}

extend Bool <: Equatable<Bool> {}

extend Unit <: Equatable<Unit> {}

extend<T> Range<T> <: Equatable<Range<T>> where T <: Countable<T> & Comparable<T> & Equatable<T> {
    public operator func ==(other: Range<T>): Bool {
        this.start == other.start && this.end == other.end && this.step == other.step && this.isClosed == other.isClosed
    }
}
