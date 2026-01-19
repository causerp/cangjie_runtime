/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.core

/**
 * The execution of the input function @param fn occupies the underlying OS thread exclusively.
 * When executing @param fn, a switch from the cangjie thread stack to the OS thread stack will occur,
 * and the underlying OS thread cannot be preempted by other cangjie threads.
 * After @param fn returns, it will switch back to the cangjie thread stack,
 * and the preemption will be permitted.
 * 
 * @param fn The function to be executed exclusively.
 * @return The return value of @param fn.
 * @throws ExclusiveScopeException if an exception occurs during execution.
 */
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

@Intrinsic 
func exclusiveScopeImpl<T>(executeClosure: (() -> T) -> T, fn: () -> T): T

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

/**
 * Custom exception class to wrap exceptions thrown in an exclusive scope.
 * This exception preserves the original exception's stack trace and information.
 * It is thrown when an exception occurs within an exclusive scope execution.
 */
public class ExclusiveScopeException <: Exception {
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
