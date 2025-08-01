/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest.prop_test

import std.collection.*
import std.math.*
import std.random.Random

/**
 * Shrink interface: reduce values of type T to a number of "smaller" values
 */
public interface Shrink<T> {
    /**
     * shrink this value to a set of possible "smaller" values
     */
    func shrink(): Iterable<T> { emptyIterable<T>() }
}

extend Unit <: Shrink<Unit> {
}

extend Bool <: Shrink<Bool> {
}

/*****************************************************************
@ForEach[IntType in [Int8, Int16, Int32, Int64, IntNative]]
extend IntType <: Shrink<IntType> {
    public func shrink(): Iterable<IntType> {
        let res = HashSet<IntType>()
        if (this == 0) { return [] }
        if (this == 1) { return [0] }
        res.add(0)
        res.add(1)
        if (this < 0) {
            res.add(-this)
        }
        res.add(this / 2)
        res
    }
}
 ******************************************************************/

/**
 * Shrink instance for signed integer
 */
extend Int8 <: Shrink<Int8> {
    public func shrink(): Iterable<Int8> {
        let res = HashSet<Int8>()
        if (this == 0) {
            return []
        }
        if (this == 1) {
            return [0]
        }
        res.add(0)
        res.add(1)
        if (this < 0 && this != Int8.Min) { // -Int.Min causes overflow
            res.add(-this)
        }
        res.add(this / 2)
        res
    }
}

/**
 * Shrink instance for signed integer
 */
extend Int16 <: Shrink<Int16> {
    public func shrink(): Iterable<Int16> {
        let res = HashSet<Int16>()
        if (this == 0) {
            return []
        }
        if (this == 1) {
            return [0]
        }
        res.add(0)
        res.add(1)
        if (this < 0 && this != Int16.Min) { // -Int.Min causes overflow
            res.add(-this)
        }
        res.add(this / 2)
        res
    }
}

/**
 * Shrink instance for signed integer
 */
extend Int32 <: Shrink<Int32> {
    public func shrink(): Iterable<Int32> {
        let res = HashSet<Int32>()
        if (this == 0) { return [] }
        if (this == 1) { return [0] }
        res.add(0)
        res.add(1)
        if (this < 0&& this != Int32.Min) { // -Int.Min causes overflow
            res.add(-this)
        }
        res.add(this / 2)
        res
    }
}

/**
 * Shrink instance for signed integer
 */
extend Int64 <: Shrink<Int64> {
    public func shrink(): Iterable<Int64> {
        let res = HashSet<Int64>()
        if (this == 0) { return [] }
        if (this == 1) { return [0] }
        res.add(0)
        res.add(1)
        if (this < 0 && this != Int64.Min) { // -Int.Min causes overflow
            res.add(-this)
        }
        res.add(this / 2)
        res
    }
}

/**
 * Shrink instance for signed integer
 */
extend IntNative <: Shrink<IntNative> {
    public func shrink(): Iterable<IntNative> {
        let res = HashSet<IntNative>()
        if (this == 0) { return [] }
        if (this == 1) { return [0] }
        res.add(0)
        res.add(1)
        if (this < 0 && this != IntNative.Min) { // -Int.Min causes overflow
            res.add(-this)
        }
        res.add(this / 2)
        res
    }
}

/********************************************************************
@ForEach[UIntType in [UInt8, UInt16, UInt32, UInt64, UIntNative]]
extend UIntType <: Shrink<UIntType> {
    public func shrink(): Iterable<UIntType> {
        let res = HashSet<UIntType>()
        if (this == 0) { return [] }
        if (this == 1) { return [0] }
        res.add(0)
        res.add(1)
        res.add(this / 2)
        res
    }
}
 *********************************************************************/

/**
 * Shrink instance for unsigned integer
 */
extend UInt8 <: Shrink<UInt8> {
    public func shrink(): Iterable<UInt8> {
        let res = HashSet<UInt8>()
        if (this == 0) { return [] }
        if (this == 1) { return [0] }
        res.add(0)
        res.add(1)
        res.add(this / 2)
        res
    }
}

/**
 * Shrink instance for unsigned integer
 */
extend UInt16 <: Shrink<UInt16> {
    public func shrink(): Iterable<UInt16> {
        let res = HashSet<UInt16>()
        if (this == 0) { return [] }
        if (this == 1) { return [0] }
        res.add(0)
        res.add(1)
        res.add(this / 2)
        res
    }
}

/**
 * Shrink instance for unsigned integer
 */
extend UInt32 <: Shrink<UInt32> {
    public func shrink(): Iterable<UInt32> {
        let res = HashSet<UInt32>()
        if (this == 0) { return [] }
        if (this == 1) { return [0] }
        res.add(0)
        res.add(1)
        res.add(this / 2)
        res
    }
}

/**
 * Shrink instance for unsigned integer
 */
extend UInt64 <: Shrink<UInt64> {
    public func shrink(): Iterable<UInt64> {
        let res = HashSet<UInt64>()
        if (this == 0) { return [] }
        if (this == 1) { return [0] }
        res.add(0)
        res.add(1)
        res.add(this / 2)
        res
    }
}

/**
 * Shrink instance for unsigned integer
 */
extend UIntNative <: Shrink<UIntNative> {
    public func shrink(): Iterable<UIntNative> {
        let res = HashSet<UIntNative>()
        if (this == 0) { return [] }
        if (this == 1) { return [0] }
        res.add(0)
        res.add(1)
        res.add(this / 2)
        res
    }
}

extend Float16 <: Shrink<Float16> {
    private static func appendShrinked(item: Float16, result: HashSet<Float16>) {
        if (!item.isNaN() && !item.isInf()) { result.add(item) }
    }
    private func shrinkTo(result: HashSet<Float16>) {
        if (this < 0.0) {
            appendShrinked(-this, result)
        }
        let rounded = round(this)
        appendShrinked(rounded, result)
        // 1024.0 is the maximum precisely representable number in Float16
        if (this > 1024.0 || rounded == this) {
            appendShrinked(this / 2.0f16, result)
        } else if (this < 2.0) {
            appendShrinked(this * 2.0f16, result)
        }
    }
    public func shrink(): Iterable<Float16> {
        match (this) {
            case 0.0 => return []
            case 1.0 => return [0.0]
            case x where x.isInf() || x.isNaN() => return [0.0, 1.0]
            case _ => ()
        }
        let result = HashSet<Float16>([0.0, 1.0, this])
        shrinkTo(result)
        result.remove(this)
        return result
    }
}

extend Float32 <: Shrink<Float32> {
    private static func appendShrinked(item: Float32, result: HashSet<Float32>) {
        if (!item.isNaN() && !item.isInf()) { result.add(item) }
    }
    private func shrinkFracDigits(result: HashSet<Float32>, multiplier: Float32) {
        for (precision in [1e6f32, 1e5f32, 1e4f32, 1e3f32, 1e2f32, 10.0f32, 1.0f32]) {
            let m = Int64(round(this * precision))
            if (precision != 1.0 && m % 10 == 0) { continue }
            let candidate = Float32(m) / precision
            if (abs(candidate) < abs(this)) {
                appendShrinked(candidate * multiplier, result)
            }
            let half = Float32(m / 2) / precision
            if (abs(half) < abs(this)) {
                appendShrinked(half * multiplier, result)
            }
        }
    }
    private func shrinkTo(result: HashSet<Float32>) {
        if (this < 0.0) {
            appendShrinked(-this, result)
        }
        let powerOf10 = Int32(trunc(log10(abs(this))))
        let powerMultiplier = pow(10.0f32, powerOf10)
        let smallestValue = this / powerMultiplier
        appendShrinked(smallestValue, result)
        appendShrinked(powerMultiplier, result)

        // try to reduce power
        appendShrinked(this / pow(10.0f32, powerOf10 / 2), result)

        smallestValue.shrinkFracDigits(result, powerMultiplier)
    }
    public func shrink(): Iterable<Float32> {
        match (this) {
            case 0.0 => return []
            case 1.0 => return [0.0]
            case x where x.isInf() || x.isNaN() => return [0.0, 1.0]
            case _ => ()
        }
        let result = HashSet<Float32>([0.0, 1.0, this])
        shrinkTo(result)
        result.remove(this)
        return result
    }
}

extend Float64 <: Shrink<Float64> {
    private static func appendShrinked(item: Float64, result: HashSet<Float64>) {
        if (!item.isNaN() && !item.isInf()) { result.add(item) }
    }
    private func shrinkFracDigits(result: HashSet<Float64>, multiplier: Float64) {
        for (precision in [1e6, 1e5, 1e4, 1e3, 1e2, 10.0, 1.0]) {
            let m = Int64(round(this * precision))
            if (precision != 1.0 && m % 10 == 0) { continue }
            let candidate = Float64(m) / precision
            if (abs(candidate) < abs(this)) {
                appendShrinked(candidate * multiplier, result)
            }
            let half = Float64(m / 2) / precision
            if (abs(half) < abs(this)) {
                appendShrinked(half * multiplier, result)
            }
        }
    }
    private func shrinkTo(result: HashSet<Float64>) {
        if (this < 0.0) {
            appendShrinked(-this, result)
        }
        let powerOf10 = Int64(trunc(log10(abs(this))))
        let powerMultiplier = 10.0 ** powerOf10
        let smallestValue = this / powerMultiplier
        appendShrinked(smallestValue, result)
        appendShrinked(powerMultiplier, result)

        // try to reduce power
        appendShrinked(this / (10.0 ** (powerOf10 / 2)), result)

        smallestValue.shrinkFracDigits(result, powerMultiplier)
    }
    public func shrink(): Iterable<Float64> {
        match (this) {
            case 0.0 => return []
            case 1.0 => return [0.0]
            case x where x.isInf() || x.isNaN() => return [0.0, 1.0]
            case _ => ()
        }
        let result = HashSet<Float64>([0.0, 1.0, this])
        shrinkTo(result)
        result.remove(this)
        return result
    }
}

/**
 * Shrink instance for Rune
 */
extend Rune <: Shrink<Rune> {
    public func shrink(): Iterable<Rune> {
        let alnum = shrinkToAlnum(this)
        let ascii = shrinkToAscii(this)

        if (this == alnum) { return [] }
        if (this == ascii || ascii == alnum) { return [alnum] }

        return [alnum, ascii]
    }
}

func arrayReplace<T>(array: Array<T>, index: Int64, element: T) {
    Array<T>(array.size) { ix => if (ix == index) { element } else { array[ix] } }
}

/**
 * CanShrinkElements is an auxilliary private interface used to check whether "elements" of T
 * implement Shrink because logic in this case may be different.
 * Alternatively, we could check each individual element for Shrink implementation, but that is
 * inefficient for collections. Using this private interface allows using only one check for the
 * whole collection. Another alternative is to require Shrink<Element> for each collection, but
 * we want to avoid this due to being inconvenient for users.
 */
private interface CanShrinkElements<T> {
    func shrinkUsingElements(): LazySeq<T>
}

extend<T> Array<T> <: CanShrinkElements<Array<T>> where T <: Shrink<T> {
    public func shrinkUsingElements(): LazySeq<Array<T>> {
        let iterators = Array<Iterator<Array<T>>>(this.size) { index: Int64 =>
            this[index].shrink().iterator().map<Array<T>> { shrunk =>
                let col = this.clone()
                col[index] = shrunk
                col
            }
        }
        return LazySeq.of(MixingIterator<Array<T>>(iterators))
    }
}

extend<T> Array<T> <: Shrink<Array<T>> {
    public func shrink(): Iterable<Array<T>> {
        if (this.size == 0) {
            return LazySeq<Array<T>>()
        }
        var result = LazySeq<Array<T>>()
        result = result.append([])
        if (this.size > 1) {
            result = result.append(this[0..1])
            if (this.size > 3) { // if size is 2 or 3, first half is just one element
                result = result.append(this[0..this.size / 2])
            }
            result = result.append(this[this.size / 2..this.size])
        }
        match (this) {
            case shr: CanShrinkElements<Array<T>> =>
                result = result.concat(shr.shrinkUsingElements())
            case _ => ()
        }
        return result
    }
}

extend<T> ArrayList<T> <: CanShrinkElements<ArrayList<T>> where T <: Shrink<T> {
    public func shrinkUsingElements(): LazySeq<ArrayList<T>> {
        let iterators = Array<Iterator<ArrayList<T>>>(this.size) { index: Int64 =>
            this[index].shrink().iterator().map<ArrayList<T>> { shrunk =>
                let col = this.clone()
                col[index] = shrunk
                col
            }
        }
        return LazySeq.of(MixingIterator<ArrayList<T>>(iterators))
    }
}

extend<T> ArrayList<T> <: Shrink<ArrayList<T>> {
    public func shrink(): Iterable<ArrayList<T>> {
        if (this.size == 0) {
            return LazySeq<ArrayList<T>>()
        }
        var result = LazySeq<ArrayList<T>>()
        result = result.append(ArrayList())
        if (this.size > 1) {
            result = result.append(this[0..1])
            if (this.size > 3) { // if size is 2 or 3, first half is just one element
                result = result.append(this[0..this.size / 2])
            }
            result = result.append(this[this.size / 2..this.size])
        }
        match (this) {
            case shr: CanShrinkElements<ArrayList<T>> =>
                result = result.concat(shr.shrinkUsingElements())
            case _ => ()
        }
        return result
    }
}

extend<T> HashSet<T> <: CanShrinkElements<HashSet<T>> where T <: Shrink<T> {
    public func shrinkUsingElements(): LazySeq<HashSet<T>> {
        let iterators = this.iterator().map<Iterator<HashSet<T>>> { elem: T =>
            elem.shrink().iterator().map<HashSet<T>> { shrunk =>
                let col = this.clone()
                col.remove(elem)
                col.add(shrunk)
                col
            }
        } |> collectArray
        return LazySeq.of(MixingIterator<HashSet<T>>(iterators))
    }
}

extend<T> HashSet<T> <: Shrink<HashSet<T>> {
    public func shrink(): Iterable<HashSet<T>> {
        if (this.size == 0) {
            return LazySeq<HashSet<T>>()
        }
        var result = LazySeq<HashSet<T>>()
        result = result.append(HashSet())
        if (this.size > 1) {
            let firstHalf = HashSet<T>()
            let secondHalf = HashSet<T>()
            for ((ix, e) in enumerate(this)) {
                if (ix < size / 2) {
                    firstHalf.add(e)
                } else {
                    secondHalf.add(e)
                }
            }
            result = result.append(firstHalf).append(secondHalf)
        }
        match (this) {
            case shr: CanShrinkElements<HashSet<T>> =>
                result = result.concat(shr.shrinkUsingElements())
            case _ => ()
        }
        return result
    }
}

/**
 * HashMaps are complicated for Shrink: there are 4 cases
 * 1. K is Shrink<K>, V is Shrink<V>
 * 2. K is Shrink<K>, V is not Shrink<V>
 * 3. K is not Shrink<K>, V is Shrink<V>
 * 4. both K and V are not shrinkable
 * as we want to provide Shrink<HashMap<K, V>> for all 4 cases, use CanShrinkElement trick for V,
 * but for K we need to do an additional trick through an inline structure
 * which conditionally implements CanShrinkElement if K implements Shrink<K>
 */
private struct ShrinkKeyWrapper<K, V> where K <: Equatable<K> & Hashable {
    ShrinkKeyWrapper(let data: HashMap<K, V>) {}
}

/**
 * ShrinkKeyWrapper<K, V> implements CanShrinkElements<HashMap<K, V>> iff K is Shrink<K>
 * and provides shrinking via keys
 */
extend<K, V> ShrinkKeyWrapper<K, V> <: CanShrinkElements<HashMap<K, V>> where K <: Shrink<K> {
    public func shrinkUsingElements(): LazySeq<HashMap<K, V>> {
        let iterators = this.data |> map { kv: (K, V) =>
            let (k, v) = kv
            k.shrink().iterator().map<HashMap<K, V>> { shrunk =>
                let col = this.data.clone()
                col.remove(k)
                col[shrunk] = v
                col
            }
        } |> collectArray
        return LazySeq.of(MixingIterator<HashMap<K, V>>(iterators))
    }
}

/**
 * HashMap<K, V> implements CanShrinkElements<HashMap<K, V>> iff V is Shrink<V>
 * and provides shrinking via values
 */
extend<K, V> HashMap<K, V> <: CanShrinkElements<HashMap<K, V>> where V <: Shrink<V> {
    public func shrinkUsingElements(): LazySeq<HashMap<K, V>> {
        let iterators = this |> map { kv: (K, V) =>
            let (k, v) = kv
            v.shrink().iterator().map<HashMap<K, V>> { shrunk =>
                let col = this.clone()
                col[k] = shrunk
                col
            }
        } |> collectArray
        return LazySeq.of(MixingIterator<HashMap<K, V>>(iterators))
    }
}

extend<K, V> HashMap<K, V> <: Shrink<HashMap<K, V>> {
    public func shrink(): Iterable<HashMap<K, V>> {
        if (this.size == 0) {
            return LazySeq<HashMap<K, V>>()
        }
        var result = LazySeq<HashMap<K, V>>()
        result = result.append(HashMap())
        if (this.size > 1) {
            let firstHalf = HashMap<K, V>()
            let secondHalf = HashMap<K, V>()
            var ix = 0
            for ((k, v) in this) {
                if (ix < size / 2) {
                    firstHalf.add(k, v)
                } else {
                    secondHalf.add(k, v)
                }
                ix++
            }
            result = result.append(firstHalf).append(secondHalf)
        }
        match (this) {
            case shr: CanShrinkElements<HashMap<K, V>> =>
                result = result.concat(shr.shrinkUsingElements())
            case _ => ()
        }
        match (ShrinkKeyWrapper(this)) {
            case shr: CanShrinkElements<HashMap<K, V>> => result = result.concat(shr.shrinkUsingElements())
            case _ => ()
        }
        return result
    }
}

let commonWordsBySize = [
    "",
    "a",
    "of",
    "the",
    "test",
    "hello",
    "access",
    "cangjie",
    "contrast",
    "education",
    "strawberry",
    "commonplace",
    "perseverance"
]

extend String <: Shrink<String> {
    private static func shrinkUsingRunes(runeArr: Array<Rune>): LazySeq<String> {
        let iterators = Array<Iterator<String>>(runeArr.size) { index: Int64 =>
            runeArr[index].shrink().iterator().map<String> { shrunk =>
                let arrCopy = runeArr.clone()
                arrCopy[index] = shrunk
                String(arrCopy)
            }
        }
        return LazySeq.of(MixingIterator<String>(iterators))
    }
    public func shrink(): Iterable<String> {
        if (this.size == 0) { return emptyIterable<String>() }
        let charArr = this.toRuneArray()
        if (charArr.size == 1) {
            let sub = LazySeq.of(charArr[0].shrink())
            return sub.map<String> { ch => String([ch]) }.prepend("")
        }
        var result = LazySeq<String>()
        result = result.append("")
        if (charArr.size < commonWordsBySize.size && this != commonWordsBySize[charArr.size]) {
            result = result.append(commonWordsBySize[charArr.size])
        }
        if (charArr.size > 1) {
            result = result.append(String(charArr[0..1]))
            if (charArr.size > 3) { // if size is 2 or 3, first half is exactly one rune, which we already added
                result = result.append(String(charArr[0..charArr.size / 2]))
            }
            result = result.append(String(charArr[charArr.size / 2..charArr.size]))
        }

        let byRunes = shrinkUsingRunes(charArr)

        result.concat(byRunes)
    }
}

extend<T> Option<T> <: CanShrinkElements<Option<T>> where T <: Shrink<T> {
    public func shrinkUsingElements(): LazySeq<Option<T>> {
        match (this) {
            case None =>
                return LazySeq<?T>()
            case Some(value) =>
                return LazySeq.of(value.shrink()).map<Option<T>> { it => it }
        }
    }
}

extend<T> Option<T> <: Shrink<Option<T>> {
    public func shrink(): Iterable<Option<T>> {
        match (this) {
            case None => return emptyIterable()
            case withElems: CanShrinkElements<Option<T>> =>
                return withElems.shrinkUsingElements().prepend(None)
            case _ => return [None]
        }
    }
}

extend<R> Function0Wrapper<R> <: Shrink<Function0Wrapper<R>> {
}

extend<T0, T1> TupleWrapper2<T0, T1> <: Shrink<TupleWrapper2<T0, T1>>
        where T0 <: Shrink<T0>,
              T1 <: Shrink<T1> {
    public func shrink(): Iterable<TupleWrapper2<T0, T1>> {
        let s0 = LazySeq.of(tuple[0].shrink()).map { t0: T0 => TupleWrapper2((t0,       tuple[1])) }
        let s1 = LazySeq.of(tuple[1].shrink()).map { t1: T1 => TupleWrapper2((tuple[0], t1      )) }

        LazySeq.mix(s0, s1)
    }
}

extend<T0, T1, T2> TupleWrapper3<T0, T1, T2> <: Shrink<TupleWrapper3<T0, T1, T2>>
        where T0 <: Shrink<T0>,
              T1 <: Shrink<T1>,
              T2 <: Shrink<T2> {
    public func shrink(): Iterable<TupleWrapper3<T0, T1, T2>> {
        let s0 = LazySeq.of(tuple[0].shrink()).map { t0: T0 => TupleWrapper3((t0,       tuple[1], tuple[2])) }
        let s1 = LazySeq.of(tuple[1].shrink()).map { t1: T1 => TupleWrapper3((tuple[0], t1,       tuple[2])) }
        let s2 = LazySeq.of(tuple[2].shrink()).map { t2: T2 => TupleWrapper3((tuple[0], tuple[1], t2      )) }

        LazySeq.mix(s0, s1, s2)
    }
}

extend<T0, T1, T2, T3> TupleWrapper4<T0, T1, T2, T3> <: Shrink<TupleWrapper4<T0, T1, T2, T3>>
        where T0 <: Shrink<T0>,
              T1 <: Shrink<T1>,
              T2 <: Shrink<T2>,
              T3 <: Shrink<T3> {
    public func shrink(): Iterable<TupleWrapper4<T0, T1, T2, T3>> {
        let s0 = LazySeq.of(tuple[0].shrink()).map { t0: T0 => TupleWrapper4((t0,       tuple[1], tuple[2], tuple[3])) }
        let s1 = LazySeq.of(tuple[1].shrink()).map { t1: T1 => TupleWrapper4((tuple[0], t1,       tuple[2], tuple[3])) }
        let s2 = LazySeq.of(tuple[2].shrink()).map { t2: T2 => TupleWrapper4((tuple[0], tuple[1], t2,       tuple[3])) }
        let s3 = LazySeq.of(tuple[3].shrink()).map { t3: T3 => TupleWrapper4((tuple[0], tuple[1], tuple[2], t3      )) }

        LazySeq.mix(s0, s1, s2, s3)
    }
}

extend<T0, T1, T2, T3, T4> TupleWrapper5<T0, T1, T2, T3, T4> <: Shrink<TupleWrapper5<T0, T1, T2, T3, T4>>
        where T0 <: Shrink<T0>,
              T1 <: Shrink<T1>,
              T2 <: Shrink<T2>,
              T3 <: Shrink<T3>,
              T4 <: Shrink<T4> {
    public func shrink(): Iterable<TupleWrapper5<T0, T1, T2, T3, T4>> {
        let s0 = LazySeq.of(tuple[0].shrink()).map { t0: T0 => TupleWrapper5((t0 ,      tuple[1], tuple[2], tuple[3], tuple[4])) }
        let s1 = LazySeq.of(tuple[1].shrink()).map { t1: T1 => TupleWrapper5((tuple[0], t1,       tuple[2], tuple[3], tuple[4])) }
        let s2 = LazySeq.of(tuple[2].shrink()).map { t2: T2 => TupleWrapper5((tuple[0], tuple[1], t2,       tuple[3], tuple[4])) }
        let s3 = LazySeq.of(tuple[3].shrink()).map { t3: T3 => TupleWrapper5((tuple[0], tuple[1], tuple[2], t3,       tuple[4])) }
        let s4 = LazySeq.of(tuple[4].shrink()).map { t4: T4 => TupleWrapper5((tuple[0], tuple[1], tuple[2], tuple[3], t4      )) }

        LazySeq.mix(s0, s1, s2, s3, s4)
    }
}

/**
 * Utility class used to help developers write their own implementations of Shrink
 */
public class ShrinkHelpers {
    /**
     * Build a shrinking sequence for tuple (T0, T1) from sequences for T0 and T1
     **/
    public static func shrinkTuple<T0, T1>(
        tuple: (T0, T1),
        t0: Iterable<T0>,
        t1: Iterable<T1>
    ): Iterable<(T0, T1)> {
        let s0 = LazySeq.of(t0).map { t0: T0 => (t0, tuple[1]) }
        let s1 = LazySeq.of(t1).map { t1: T1 => (tuple[0], t1) }

        LazySeq.mix(s0, s1)
    }

    /**
     * Build a shrinking sequence for tuple (T0, T1, T2) from sequences for T0, T1 and T2
     **/
    public static func shrinkTuple<T0, T1, T2>(
        tuple: (T0, T1, T2),
        t0: Iterable<T0>,
        t1: Iterable<T1>,
        t2: Iterable<T2>
    ): Iterable<(T0, T1, T2)> {
        let s0 = LazySeq.of(t0).map { t0: T0 => (t0, tuple[1], tuple[2]) }
        let s1 = LazySeq.of(t1).map { t1: T1 => (tuple[0], t1, tuple[2]) }
        let s2 = LazySeq.of(t2).map { t2: T2 => (tuple[0], tuple[1], t2) }

        LazySeq.mix(s0, s1, s2)
    }

    /**
     * Build a shrinking sequence for tuple (T0, T1, T2, T3) from sequences for T0, T1, T2 and T3
     **/
    public static func shrinkTuple<T0, T1, T2, T3>(
        tuple: (T0, T1, T2, T3),
        t0: Iterable<T0>,
        t1: Iterable<T1>,
        t2: Iterable<T2>,
        t3: Iterable<T3>
    ): Iterable<(T0, T1, T2, T3)> {
        let s0 = LazySeq.of(t0).map { t0: T0 => (t0, tuple[1], tuple[2], tuple[3]) }
        let s1 = LazySeq.of(t1).map { t1: T1 => (tuple[0], t1, tuple[2], tuple[3]) }
        let s2 = LazySeq.of(t2).map { t2: T2 => (tuple[0], tuple[1], t2, tuple[3]) }
        let s3 = LazySeq.of(t3).map { t3: T3 => (tuple[0], tuple[1], tuple[2], t3) }

        LazySeq.mix(s0, s1, s2, s3)
    }

    /**
     * Build a shrinking sequence for tuple (T0, T1, T2, T3, T4) from sequences for T0, T1, T2, T3 and T4
     **/
    public static func shrinkTuple<T0, T1, T2, T3, T4>(
        tuple: (T0, T1, T2, T3, T4),
        t0: Iterable<T0>,
        t1: Iterable<T1>,
        t2: Iterable<T2>,
        t3: Iterable<T3>,
        t4: Iterable<T4>
    ): Iterable<(T0, T1, T2, T3, T4)> {
        let s0 = LazySeq.of(t0).map { t0: T0 => (t0, tuple[1], tuple[2], tuple[3], tuple[4]) }
        let s1 = LazySeq.of(t1).map { t1: T1 => (tuple[0], t1, tuple[2], tuple[3], tuple[4]) }
        let s2 = LazySeq.of(t2).map { t2: T2 => (tuple[0], tuple[1], t2, tuple[3], tuple[4]) }
        let s3 = LazySeq.of(t3).map { t3: T3 => (tuple[0], tuple[1], tuple[2], t3, tuple[4]) }
        let s4 = LazySeq.of(t4).map { t4: T4 => (tuple[0], tuple[1], tuple[2], tuple[3], t4) }

        LazySeq.mix(s0, s1, s2, s3, s4)
    }

    public static func mix<T>(iterables: Array<Iterable<T>>): Iterable<T> {
        let iterators = Array<Iterator<T>>(iterables.size) { i =>
            iterables[i].iterator()
        }
        MixingIterator(iterators)
    }
}

private class MixingIterator<T> <: Iterator<T> {
    private var currentIdx = 0
    private var finishedCount = 0 // contigious sequence of finished iterators

    private let pool = ArrayList<Iterator<T>>()

    MixingIterator(of: Array<Iterator<T>>) {
        for (it in of) {
            match (it) {
                case mixing: MixingIterator<T> => mixing.move(this)
                case _ => pool.add(it)
            }
        }
    }

    public func next(): Option<T> {
        var nxt = None<T>

        while (finishedCount < pool.size) {
            nxt = pool[currentIdx].next()
            currentIdx = (currentIdx + 1) % pool.size
            match (nxt) {
                case Some(_) =>
                    finishedCount = 0
                    break
                case _ => finishedCount++
            }
        }

        return nxt
    }

    private func move(to: MixingIterator<T>) {
        to.pool.add(all: pool)
        this.pool.clear()
    }
}
