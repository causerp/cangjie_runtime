/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest.prop_test

/**
 * Some wrappers over functions and tuples to support Arbitrary for functions/tuples
 * These will be removed when CangJie compiler supports extend for functions/tuples
 */

/**
 * Wrapper struct over function of type `() -> R`
 */
public struct Function0Wrapper<R> {
    public Function0Wrapper(public let function: () -> R) {}

    public operator func () (): R { function() }
}

/**
 * Wrapper struct over tuple
 */
public struct TupleWrapper2<T0, T1> {
    public TupleWrapper2(public let tuple: (T0, T1)) {}

    public func apply<R>(f: (T0, T1) -> R): R {
        f(tuple[0], tuple[1])
    }
}

/**
 * Wrapper struct over tuple
 */
public struct TupleWrapper3<T0, T1, T2> {
    public TupleWrapper3(public let tuple: (T0, T1, T2)) {}

    public func apply<R>(f: (T0, T1, T2) -> R): R {
        f(tuple[0], tuple[1], tuple[2])
    }
}

/**
 * Wrapper struct over tuple
 */
public struct TupleWrapper4<T0, T1, T2, T3> {
    public TupleWrapper4(public let tuple: (T0, T1, T2, T3)) {}

    public func apply<R>(f: (T0, T1, T2, T3) -> R): R {
        f(tuple[0], tuple[1], tuple[2], tuple[3])
    }
}

/**
 * Wrapper struct over tuple
 */
public struct TupleWrapper5<T0, T1, T2, T3, T4> {
    public TupleWrapper5(public let tuple: (T0, T1, T2, T3, T4)) {}

    public func apply<R>(f: (T0, T1, T2, T3, T4) -> R): R {
        f(tuple[0], tuple[1], tuple[2], tuple[3], tuple[4])
    }
}

/**
 * ToString implementations, behave exactly the same as toString() for tuples
 */

extend<T0, T1> TupleWrapper2<T0, T1> <: ToString
        where T0 <: ToString, T1 <: ToString {
    public func toString() { "(${tuple[0]}, ${tuple[1]})" }
}

extend<T0, T1, T2> TupleWrapper3<T0, T1, T2> <: ToString
        where T0 <: ToString, T1 <: ToString, T2 <: ToString {
    public func toString() { "(${tuple[0]}, ${tuple[1]}, ${tuple[2]})" }
}

extend<T0, T1, T2, T3> TupleWrapper4<T0, T1, T2, T3> <: ToString
        where T0 <: ToString, T1 <: ToString, T2 <: ToString, T3 <: ToString {
    public func toString() { "(${tuple[0]}, ${tuple[1]}, ${tuple[2]}, ${tuple[3]})" }
}

extend<T0, T1, T2, T3, T4> TupleWrapper5<T0, T1, T2, T3, T4> <: ToString
        where T0 <: ToString, T1 <: ToString, T2 <: ToString, T3 <: ToString, T4 <: ToString {
    public func toString() { "(${tuple[0]}, ${tuple[1]}, ${tuple[2]}, ${tuple[3]}, ${tuple[4]})" }
}


/**
 * Equatable implementations, behave exactly the same as equals() for tuples
 */
extend<T0, T1> TupleWrapper2<T0, T1> <: Equatable<TupleWrapper2<T0, T1>> where T0 <: Equatable<T0>, T1 <: Equatable<T1> {
    public operator func ==(other: TupleWrapper2<T0, T1>) {
        return this.tuple == other.tuple
    }

    public operator func !=(other: TupleWrapper2<T0, T1>) {
        return this.tuple != other.tuple
    }
}

extend<T0, T1, T2> TupleWrapper3<T0, T1, T2> <: Equatable<TupleWrapper3<T0, T1, T2>>
        where T0 <: Equatable<T0>, T1 <: Equatable<T1>, T2 <: Equatable<T2> {
    public operator func ==(other: TupleWrapper3<T0, T1, T2>) {
        return this.tuple == other.tuple
    }

    public operator func !=(other: TupleWrapper3<T0, T1, T2>) {
        return this.tuple != other.tuple
    }
}

extend<T0, T1, T2, T3> TupleWrapper4<T0, T1, T2, T3> <: Equatable<TupleWrapper4<T0, T1, T2, T3>>
        where T0 <: Equatable<T0>, T1 <: Equatable<T1>, T2 <: Equatable<T2>, T3 <: Equatable<T3> {
    public operator func ==(other: TupleWrapper4<T0, T1, T2, T3>) {
        return this.tuple == other.tuple
    }

    public operator func !=(other: TupleWrapper4<T0, T1, T2, T3>) {
        return this.tuple != other.tuple
    }
}

extend<T0, T1, T2, T3, T4> TupleWrapper5<T0, T1, T2, T3, T4> <: Equatable<TupleWrapper5<T0, T1, T2, T3, T4>>
        where T0 <: Equatable<T0>, T1 <: Equatable<T1>, T2 <: Equatable<T2>, T3 <: Equatable<T3>, T4 <: Equatable<T4> {
    public operator func ==(other: TupleWrapper5<T0, T1, T2, T3, T4>) {
        return this.tuple == other.tuple
    }

    public operator func !=(other: TupleWrapper5<T0, T1, T2, T3, T4>) {
        return this.tuple != other.tuple
    }
}

/**
 * Utility interface to get access to elements of tuples by index
 * This is needed to print values
 */
public interface IndexAccess {
    func getElementAsAny(index: Int64): ?Any
}

extend<T0, T1> TupleWrapper2<T0, T1> <: IndexAccess {
    public func getElementAsAny(index: Int64): ?Any {
        match (index) {
            case 0 => tuple[0]
            case 1 => tuple[1]
            case _ => None
        }
    }
}

extend<T0, T1, T2> TupleWrapper3<T0, T1, T2> <: IndexAccess {
    public func getElementAsAny(index: Int64): ?Any {
        match (index) {
            case 0 => tuple[0]
            case 1 => tuple[1]
            case 2 => tuple[2]
            case _ => None
        }
    }
}

extend<T0, T1, T2, T3> TupleWrapper4<T0, T1, T2, T3> <: IndexAccess {
    public func getElementAsAny(index: Int64): ?Any {
        match (index) {
            case 0 => tuple[0]
            case 1 => tuple[1]
            case 2 => tuple[2]
            case 3 => tuple[3]
            case _ => None
        }
    }
}

extend<T0, T1, T2, T3, T4> TupleWrapper5<T0, T1, T2, T3, T4> <: IndexAccess {
    public func getElementAsAny(index: Int64): ?Any {
        match (index) {
            case 0 => tuple[0]
            case 1 => tuple[1]
            case 2 => tuple[2]
            case 3 => tuple[3]
            case 4 => tuple[4]
            case _ => None
        }
    }
}
