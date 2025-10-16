/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest.prop_test

/**
 * We have to implement our own custom collections due to
 * Cangjie issues #2725
 *
 * Empty iterator: iterator that returns nothing
 **/
class EmptyIterator<T> <: Iterator<T> {
    public override func next(): ?T { None }
}

/**
 * Empty iterable: iterator that returns nothing
 **/
public func emptyIterable<T>(): Iterable<T> { EmptyIterator<T>() }
