/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest.prop_test

/*
 * Thunk is a unit of lazily computed values
 * This particular implementation can hold a value (Calculated),
 * a function (Uncalculated) and also be empty (EmptyThunk)
 */
enum Thunk<T> {
    | Uncalculated(() -> ?T)
    | Calculated(T)
    | EmptyThunk

    func get(): ?T {
        match (this) {
            case Calculated(value) => value
            case _ => None
        }
    }
    func force(): Thunk<T> {
        match (this) {
            case EmptyThunk | Calculated(_) => this
            case Uncalculated(fun) =>
                match (fun()) {
                    case None => EmptyThunk
                    case Some(x) => Calculated(x)
                }
        }
    }
}

/*
 * A very minimalistic implementation of copy-on-write lazy structure
 * This particular implementation may hold no value in addition to computed/uncomputed value
 */
struct Lazy<T> {
    /*
    The actual storage for the lazily computed value
     */
    private var thunk: Thunk<T>

    /*
    initialize this Lazy as already computed
     */
    init(value: T) {
        thunk = Calculated(value)
    }
    /*
    initialize this Lazy with a lambda: it will be computed later when get() is called
     */
    init(fun: () -> ?T) {
        thunk = Uncalculated(fun)
    }
    /*
    initialize this Lazy with nothing
     */
    init() {
        thunk = EmptyThunk
    }

    /*
    get the value, compute it if not computed

    returns None if there is no value
     */
    public mut func get(): ?T {
        thunk = thunk.force()
        thunk.get()
    }

    /*
    Utilitary function: make Lazy object from function returning other Lazy
     */
    static func flat<T>(body: () -> Lazy<T>): Lazy<T> {
        Lazy<T> {
            var res = body()
            match (res.thunk) {
                case Calculated(v) => v
                case Uncalculated(f) => f()
                case EmptyThunk => None
            }
        }
    }
}
