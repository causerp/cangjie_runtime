/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.core

public class Box<T> {
    public var value: T
    public init(v: T) {
        value = v
    }
}

extend<T> Box<T> <: Hashable where T <: Hashable {
    public func hashCode(): Int64 {
        return this.value.hashCode()
    }
}

extend<T> Box<T> <: Comparable<Box<T>> where T <: Comparable<T> {
    public operator func ==(that: Box<T>): Bool {
        return this.value == that.value
    }
    public operator func !=(that: Box<T>): Bool {
        return this.value != that.value
    }
    public operator func >(that: Box<T>): Bool {
        return this.value > that.value
    }
    public operator func <(that: Box<T>): Bool {
        return this.value < that.value
    }
    public operator func >=(that: Box<T>): Bool {
        return this.value >= that.value
    }
    public operator func <=(that: Box<T>): Bool {
        return this.value <= that.value
    }

    /**
     * Compare the relationship between two instance of Box<T>.
     *
     * @param that Instance of Box<T> compared with this.
     * @return Value indicating the relationship between two instance of Box<T>.
     *
     * @since 0.27.3
     */
    public func compare(that: Box<T>): Ordering {
        match {
            case this.value < that.value => Ordering.LT
            case this.value > that.value => Ordering.GT
            case _ => Ordering.EQ
        }
    }
}

extend<T> Box<T> <: ToString where T <: ToString {
    public func toString(): String {
        return this.value.toString()
    }
}
