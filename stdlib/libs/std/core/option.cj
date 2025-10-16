/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.core

public enum Option<T> {
    Some(T)
    | None

    /*
     * @throws NoneValueException if the value of Option is None
     */
    @Frozen
    public func getOrThrow(): T {
        match (this) {
            case Some(v) => v
            case None => throw NoneValueException()
        }
    }

    /*
     * @throws input Exception if the value of Option is None
     */
    @Frozen
    public func getOrThrow(exception: () -> Exception): T {
        match (this) {
            case Some(v) => v
            case None => throw exception()
        }
    }

    @Frozen
    public func getOrDefault(other: () -> T): T {
        match (this) {
            case Some(v) => v
            case None => other()
        }
    }

    @Frozen
    public func isNone(): Bool {
        match (this) {
            case None => true
            case Some(_) => false
        }
    }

    @Frozen
    public func isSome(): Bool {
        match (this) {
            case Some(_) => true
            case None => false
        }
    }

    public func map<R>(transform: (T) -> R): Option<R> {
        match (this) {
            case Some(v) => Some(transform(v))
            case None => None
        }
    }

    public func filter(predicate: (T) -> Bool): Option<T> {
        let v = this ?? return None
        if (predicate(v)) {
            return v
        }
        return None
    }

    public func flatMap<R>(transform: (T) -> Option<R>): Option<R> {
        match (this) {
            case Some(v) => transform(v)
            case None => None
        }
    }
}

public func ifSome<T>(o: Option<T>, action: (T) -> Unit): Unit {
    match (o) {
        case Some(v) => action(v)
        case None => ()
    }
}

public func ifNone<T>(o: Option<T>, action: () -> Unit): Unit {
    match (o) {
        case Some(v) => ()
        case None => action()
    }
}

extend<T> Option<T> <: Equatable<Option<T>> where T <: Equatable<T> {
    @Frozen
    public operator func ==(that: Option<T>): Bool {
        return match ((this, that)) {
            case (Some(v1), Some(v2)) => v1 == v2
            case (None, None) => true
            case _ => false
        }
    }

    @Frozen
    public operator func !=(that: Option<T>): Bool {
        return !(this == that)
    }
}

extend<T> Option<T> <: ToString where T <: ToString {
    public func toString(): String {
        match (this) {
            case Some(s) => "Some(${s})"
            case None => "None"
        }
    }
}

extend<T> Option<T> <: Hashable where T <: Hashable {
    public func hashCode(): Int64 {
        return match (this) {
            case Some(v) => v.hashCode()
            case None => 0
        }
    }
}

extend<T> Option<Option<T>> {
    public func flatten(): Option<T> {
        match (this) {
            case Some(o) => o
            case None => None
        }
    }
}
