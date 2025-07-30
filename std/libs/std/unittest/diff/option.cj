/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest.diff

import std.unittest.common.PrettyPrinter

extend<T> Option<T> <: AssertPrintable<Option<T>> where T <: Equatable<T> {
    public prop hasNestedDiff: Bool {
        get() { false }
    }

    public func pprintForAssertion(pp: PrettyPrinter, right: Option<T>, leftPrefix: String, rightPrefix: String,
        level: Int64): PrettyPrinter {
        return pp.pprintOptionDiff(this, right, leftPrefix, rightPrefix, level)
    }
}

extend PrettyPrinter {
    func pprintOptionDiff<T>(left: Option<T>, right: Option<T>, leftPrefix: String, rightPrefix: String, level: Int64) {
        match (left) {
            case Some(l) =>
                match (right) {
                    case Some(r) => pprintForAssertionOrSimple(l, r, leftPrefix, rightPrefix, level)
                    case None => pprintLeftRight(l, right, leftPrefix, rightPrefix)
                }
            case None =>
                match (right) {
                    case Some(r) => pprintLeftRight(left, r, leftPrefix, rightPrefix)
                    case None => () // then assertion is passed
                }
        }
        return this
    }
}
