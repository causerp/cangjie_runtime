/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.core

public func exclusiveScope<T>(fn: () -> T): T {
    let cl = ExclusiveScope<T>()
    cl.run(fn)
    match (cl.result) {
        case Val(v) => v
        case Ex(e) => throw ExclusiveScopeException(e)
        case Err(e) => throw e
    }
}

private enum Result<T> {
    | Val(T)
    | Ex(Exception)
    | Err(Error)
}

// CJ_MCC_ExclusiveScope
@Intrinsic func exclusiveScopeImpl<T>(executeClosure: (() -> T) -> T, fn: () -> T): T

private class ExclusiveScope<T> {
    var result: Result<T> = unsafe { zeroValue<Result<T>>() }
    func run(fn: () -> T): Unit {
        exclusiveScopeImpl(Future<Unit>.executeClosure) {
            try {
                result = Val(fn())
            } catch (e: Exception) {
                result = Ex(e)
            } catch (e: Error) {
                result = Err(e)
            }
        }
    }
}

class ExclusiveScopeException <: Exception {
    ExclusiveScopeException(cause: Exception) {
        super(cause)
    }

    /*
    * Returns a string representation of the exception including its stack trace.
    * This method overrides the base toString method to provide detailed information
    * about the wrapped exception.
    *
    * @return A string representation of the exception with its stack trace
    */
    public override func toString(): String {
        "ExclusiveScopeException"
    }
}
