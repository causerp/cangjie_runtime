/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest.mock

public class NoneMatcher <: ArgumentMatcher {
    NoneMatcher() {}

    public override func matchesAny(arg: Any): Bool {
        match (arg) {
            case optional: UntypedOption =>
                match (optional.value()) {
                    case None => true
                    case _ => false
                }
            case _ => false
        }
    }
}

extend Matchers {
    public static func none(): NoneMatcher {
        NoneMatcher()
    }
}

extend NoneMatcher {
    public func value<T>(): Option<T> {
        return unsafe { zeroValue<T>() }
    }
}
