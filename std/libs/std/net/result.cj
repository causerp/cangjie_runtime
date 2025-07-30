/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.net

enum Result<T> {
    Ok(T) | Err(Exception)

    func isOk(): Bool {
        match (this) {
            case Ok(v) => true
            case Err(v) => false
        }
    }

    func isErr(): Bool {
        return !isOk()
    }

    func unwrap(): T {
        match (this) {
            case Ok(v) => return v
            case Err(v) => throw v
        }
    }

    func unwrapErr(): Exception {
        match (this) {
            case Ok(v) => throw Exception("called `Result.unwrapErr()` on an `Ok` value")
            case Err(v) => v
        }
    }

    func toOption(): Option<T> {
        match (this) {
            case Ok(v) => v
            case Err(v) => None
        }
    }
}

extend<T> Result<T> <: ToString where T <: ToString {
    public func toString(): String {
        match (this) {
            case Ok(v) => return v.toString()
            case Err(v) => return v.message
        }
    }
}
