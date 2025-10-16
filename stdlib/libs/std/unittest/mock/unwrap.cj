/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest.mock

interface UntypedOption {
    func value(): ?Any
}

extend<T> Option<T> <: UntypedOption {
    public func value(): ?Any {
        match (this) {
            case Some(v) => Some(v)
            case None => None
        }
    }
}

// NOTE: there is a potentially confusing behaviour here with T == Any
// When:
// 1. Stubbed API would accept Option<Any>
// 2. Argument matcher value would be of type 'Any', i.e. TypedMatcher<Any>
// We would never try to unwrap the option and apply matcher to its value
func unwrapValue<T>(value: Any): ?T {
    match (value) {
        case ofRequiredType: T => ofRequiredType
        case optional: UntypedOption =>
            match (optional.value()) {
                case Some(innerValue) => unwrapValue<T>(innerValue)
                case None => None
            }
        case _ => None
    }
}
