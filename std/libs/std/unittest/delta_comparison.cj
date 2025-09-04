/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest

/**
* Represents entities that are inaccurate in it's nature.
*
* We consider such objects to be equal with some delta. 
* For example float type is inaccurate in it's nature and the best practice to equality comparison is to use delta.
*/
public interface NearEquatable<CT, D> {
    /**
    * Determines wether objects are equal with some delta or not.
    * 
    * @param obj another object for comparison
    * @param delta represents the maximum possible difference between two objects when we consider objects to be equal
    * 
    * @returns true if the difference between objects is less than delta
    */
    func isNear(obj: CT, delta!: D): Bool
} 

/**
* Represents relative delta for numeric (float) types
* |x - y| <= absolute + relative * max(abs(x), abs(y))
*/
public struct RelativeDelta<T> {
    public RelativeDelta(let absolute!: T, let relative!: T) {}
}

// need only for @PowerAssert expansion
public func isNearExpansion<CT, D>(l: CT, r: CT, delta!: D, cmpType!: String): Bool where CT <: NearEquatable<CT, D> & Comparable<CT> {
    match (cmpType) {
        case "LT" => !l.isNear(r, delta: delta) && l < r
        case "GT" => !l.isNear(r, delta: delta) && l > r
        case "LE" => l.isNear(r, delta: delta) || l <= r
        case "GE" => l.isNear(r, delta: delta) || l >= r
        case "NOT_EQ" => !l.isNear(r, delta: delta)
        case "EQ" => l.isNear(r, delta: delta)
        case notSupportedCmpType => throw IllegalArgumentException("Given '${notSupportedCmpType}' is not supported.")
    }
}

// need only for @PowerAssert expansion
public func isNearExpansion<CT, D>(l: CT, r: CT, delta!: D, cmpType!: String, overloadHack!: Bool = true): Bool where CT <: NearEquatable<CT, D> {
    match (cmpType) {
        case "NOT_EQ" => !l.isNear(r, delta: delta)
        case "EQ" => l.isNear(r, delta: delta)
        case _ => throw IllegalArgumentException("Trying to compare incomparable objects.")
    }
}
