/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.core

public interface Equal<T> {
    operator func ==(rhs: T): Bool
}

public interface NotEqual<T> {
    operator func !=(rhs: T): Bool
}

public interface Equatable<T> <: Equal<T> & NotEqual<T> {
    operator func !=(rhs: T): Bool {
        !(this == rhs)
    }
}

extend Bool <: Equatable<Bool> {}

extend Unit <: Equatable<Unit> {}

extend<T> Range<T> <: Equatable<Range<T>> where T <: Countable<T> & Comparable<T> & Equatable<T> {
    public operator func ==(that: Range<T>): Bool {
        this.start == that.start && this.end == that.end && this.step == that.step && this.isClosed == that.isClosed
    }
}
