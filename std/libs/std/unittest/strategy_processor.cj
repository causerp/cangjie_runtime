/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest

import std.collection.*
import std.unittest.common.toStringOrPlaceholder

public class FlatMapProcessor<T, R> <: DataStrategyProcessor<R> {
    var provider: RememberingDataProvider<R> = RememberingDataProvider("", [])
    FlatMapProcessor(let orig: DataStrategyProcessor<T>, let mapper: (T) -> DataProvider<R>) {}

    protected prop isInfinite: Bool {
        get() { orig.isInfinite }
    }

    protected func provide(configuration: Configuration): Iterable<R> {
        orig.provide(configuration).iterator() |> flatMap{ x: T =>
            let prov = RememberingDataProvider("map", mapper(x))
            this.provider = prov
            prov.provide()
        }
    }

    protected func shrinkLastItem(configuration: Configuration, engine: LazyCyclicNode): Iterable<R> {
        orig.shrinkLastItem(configuration, engine).iterator() |> flatMap{ x: T =>
            let prov = RememberingDataProvider("map", mapper(x))
            this.provider = prov
            prov.provide()
        }
    }

    protected func lastItemInfo(): Array<InputParameter> {
        orig.lastItemInfo().concat([provider.info])
    }

    protected func lastItem(_: Configuration): R {
        provider.current.getOrThrow()
    }
}

public class FlatMapStrategyProcessor<T, R> <: DataStrategyProcessor<R> {
    var provider: RememberingDataProvider<R> = RememberingDataProvider("", [])
    var strategy: DataStrategy<R> = []
    FlatMapStrategyProcessor(let orig: DataStrategyProcessor<T>, let mapper: (T) -> DataStrategy<R>) {}

    protected prop isInfinite: Bool {
        get() { orig.isInfinite || strategy.isInfinite }
    }

    protected func provide(configuration: Configuration): Iterable<R> {
        orig.provide(configuration).iterator() |> flatMap{ x: T =>
            this.strategy = mapper(x)
            let prov = RememberingDataProvider("map", strategy.provider(configuration))
            this.provider = prov
            prov.provide()
        }
    }

    protected func shrinkLastItem(configuration: Configuration, engine: LazyCyclicNode): Iterable<R> {
        let shrinkIter = strategy.shrinker(configuration).shrink(provider.current.getOrThrow()).iterator()
        let it = RememberingLazyIterable(shrinkIter, provider)
        engine.add(it)
        it
    }

    protected func lastItemInfo(): Array<InputParameter> {
        [provider.info]
    }

    protected func lastItem(_: Configuration): R { provider.current.getOrThrow() }
}

public class MapProcessor<T, R> <: DataStrategyProcessor<R> {
    MapProcessor(let orig: DataStrategyProcessor<T>, let mapper: (T, Configuration) -> R) {}

    protected prop isInfinite: Bool {
        get() { orig.isInfinite }
    }

    protected func provide(configuration: Configuration): Iterable<R> {
        orig.provide(configuration) |> map { item => mapper(item, configuration) }
    }

    protected func shrinkLastItem(configuration: Configuration, engine: LazyCyclicNode): Iterable<R> {
        orig.shrinkLastItem(configuration, engine) |> map { item => mapper(item, configuration) }
    }

    protected func lastItemInfo(): Array<InputParameter> {
        orig.lastItemInfo()
    }

    protected func lastItem(configuration: Configuration): R {
        mapper(orig.lastItem(configuration), configuration)
    }
}

public class CartesianProductProcessor<T0, T1> <: DataStrategyProcessor<(T0, T1)> {
    public CartesianProductProcessor(let left: DataStrategyProcessor<T0>, let right: DataStrategyProcessor<T1>) {}

    protected func provide(configuration: Configuration): Iterable<(T0, T1)> {
        cartesianFiniteIterator(configuration)
    }

    protected prop isInfinite: Bool {
        get() { left.isInfinite || right.isInfinite }
    }

    protected func shrinkLastItem(configuration: Configuration, engine: LazyCyclicNode): Iterable<(T0, T1)> {
        let (leftLast, rightLast) = lastItem(configuration)
        IterableMix(
            left.shrinkLastItem(configuration, engine) |> map<T0, (T0, T1)> {x => (x, rightLast)},
            right.shrinkLastItem(configuration, engine) |> map<T1, (T0, T1)> {y => (leftLast, y)}
        )
    }

    protected func lastItemInfo(): Array<InputParameter> {
        left.lastItemInfo()
            .concat(right.lastItemInfo())
    }

    protected func lastItem(configuration: Configuration): (T0, T1) {
        (left.lastItem(configuration), right.lastItem(configuration))
    }

    private func cartesianFiniteIterator(configuration: Configuration): Iterator<(T0, T1)> {
        CartesianProductIterator(left.provide(configuration).iterator(), { => right.provide(configuration).iterator() })
    }
}

class CartesianProductIterator<A, B> <: Iterator<(A, B)> {
    var leftElement: ?A
    var right: Iterator<B>

    CartesianProductIterator(let left: Iterator<A>, let rightGen: () -> Iterator<B>) {
        // it is important to call rightGen() at least once in the constructor
        // due to strategy processor internal logic
        this.right = rightGen()
        this.leftElement = left.next()
    }

    private func nextLeft(): ?A {
        leftElement = left.next()
        return leftElement
    }

    private func nextRight(): ?B {
        let rightElement = right.next()
        if (rightElement.isNone()) {
            nextLeft() ?? return None
            right = rightGen()
            return right.next()
        } else {
            return rightElement
        }
    }

    public override func next(): ?(A, B) {
        // a little clarification: we call nextRight() first, because
        // it internally modifies leftElement
        let b = nextRight() ?? return None
        let a = leftElement ?? return None
        return (a, b)
    }
}

public class SimpleProcessor<T> <: DataStrategyProcessor<T> {
    var dataProvider: RememberingDataProvider<T> = RememberingDataProvider<T>("", [])
    public SimpleProcessor(let buildDelegate: () -> DataStrategy<T>, let name: String) {}

    private var _delegate = Option<DataStrategy<T>>.None
    private prop strategy: DataStrategy<T> {
        get() {
            match (_delegate) {
                case None => let val = buildDelegate(); _delegate = val; val
                case Some(val) => val
            }
        }
    }

    protected prop isInfinite: Bool {
        get() { strategy.isInfinite }
    }

    protected func provide(configuration: Configuration): Iterable<T> {
        let dp = RememberingDataProvider(name, strategy.provider(configuration))
        dataProvider = dp
        return dp.provide().iterator()
    }

    protected func shrinkLastItem(configuration: Configuration, engine: LazyCyclicNode): Iterable<T> {
        let shrinkIter = strategy.shrinker(configuration).shrink(lastItem(configuration)).iterator()
        let it = RememberingLazyIterable(shrinkIter, dataProvider)
        engine.add(it)
        it
    }

    protected func lastItemInfo(): Array<InputParameter> {
        [dataProvider.info]
    }

    protected func lastItem(_: Configuration): T {
        dataProvider.current.getOrThrow()
    }
}

class RememberingDataProvider<T> <: DataProvider<T> {
    var info: InputParameter
    var current: Option<T> = None
    RememberingDataProvider(name: String, let delegate: DataProvider<T>) {
        info = InputParameter(name)
    }
    public func provide(): Iterable<T> {
        RememberingIterable<T>(delegate.provide().iterator(), this)
    }
}

// Iterable that saves last returned item
class RememberingIterable<T> <: Iterator<T> {
    RememberingIterable(let delegate: Iterator<T>, let source: RememberingDataProvider<T>) {}

    public func next(): ?T {
        let current = delegate.next()
        source.current = current
        if (let Some(c) <- current) {
            source.info.update(c)
        }
        current
    }
}

class RememberingLazyIterator<T> <: Iterator<T> {
    RememberingLazyIterator(let delegate: RememberingLazyIterable<T>) {}

    public func next(): ?T {
        let result = delegate.currentItem
        if (let Some(current) <- delegate.currentItem) {
            delegate.storage.current = current
            delegate.storage.info.update(current)
            delegate.currentItem = None
        }
        result
    }
}

// Iterable that is lazily advanced from outside.
// Saves last returned item once and then recovers to original saved item.
class RememberingLazyIterable<T> <: LazyCyclicNode & Iterable<T> {
    var currentItem: ?T = None
    var origLastItem: T

    RememberingLazyIterable(let delegate: Iterator<T>, let storage: RememberingDataProvider<T>) {
        this.origLastItem = storage.current.getOrThrow()
        this.initialize()
    }

    public func recover() {
        // recover original last item so that the next shrinking iteration happen on a correct item
        storage.current = origLastItem
        storage.info.update(origLastItem)
    }

    public func advance(): ?Unit {
        currentItem = delegate.next()
        if (currentItem.isNone()) {
            return None
        }
    }

    public func iterator(): Iterator<T> { RememberingLazyIterator(this) }
}

// Assumes that mixed iterables contain RememberingLazyIterable somewhere inside of them.
class IterableMix<T> <: Iterator<T> {
    IterableMix(let delegate1: Iterator<T>, let delegate2: Iterator<T>) {}

    public func next(): ?T {
        delegate1.next() ?? delegate2.next()
    }
}

// Iterates over lazy iterators added to LazyCyclicNode
class LazyCyclicNodeEngine<T> <: Iterator<T> {
    LazyCyclicNodeEngine(var current: LazyCyclicNode, let iter: Iterator<T>) {}

    public func next(): ?T {
        advance() ?? return None
        iter.next()
    }

    public func advance(): ?Unit {
        current.prev.recover()
        var val = current.advance()

        // remove finished nodes
        while (val.isNone() && !refEq(current, current.next_)) {
            current = current.removeSelf()
            val = current.advance()
        }
        // move forward
        current = current.next_
        val
    }
}

// Intrusive cyclic doubly linked list
// Used to advance type-erased internal lazy iterators one after another in a cycle
//
// Public only due to protected sealed functions being implicitly public
public open class LazyCyclicNode {
    var next_: LazyCyclicNode = unsafe { zeroValue() }
    var prev: LazyCyclicNode = unsafe { zeroValue() }

    func initialize(): LazyCyclicNode {
        this.next_ = this
        this.prev = this
        this
    }

    protected open func advance(): ?Unit { None }

    protected open func recover(): Unit {}

    func add(other: LazyCyclicNode) {
        let prevNext = this.next_
        this.next_ = other
        prevNext.prev = other
        other.next_ = prevNext
        other.prev = this
    }

    // returns next node
    func removeSelf(): LazyCyclicNode {
        let prev = this.prev
        let next = this.next_

        prev.next_ = next
        next.prev = prev
        next
    }
}

// public only due to protected sealed functions being implicitly public
public class InputParameter {
    var position: Int64 = -1
    var repr: String = ""
    InputParameter(let name: String) {}
    func update<T>(param: T) {
        position += 1
        repr = toStringOrPlaceholder(param)
    }
}

type ShrinkResult = (RunStepResult)

/**
 * Base class for all combinators of `DataStategy`es.
 */
sealed abstract class DataStrategyProcessor<T> {
    private var genIterator: Iterator<T> = Array<T>().iterator()
    var currentReduction = 0
    DataStrategyProcessor() {}

    protected prop isInfinite: Bool

    protected func provide(configuration: Configuration): Iterable<T>

    protected func shrinkLastItem(configuration: Configuration, engine: LazyCyclicNode): Iterable<T>

    protected func lastItemInfo(): Array<InputParameter>

    protected func lastItem(configuration: Configuration): T

    func nextIteration(configuration: Configuration) {
        this.genIterator = provide(configuration).iterator()
    }

    func processNextWith(
        configuration: Configuration,
        runSingle: (T, Array<InputParameter>) -> RunStepResult
    ): ProcessorResult {
        try {
            let value = genIterator.next() ?? return NoItems
            let result = runSingle(value, lastItemInfo())
            if (result.hasFailures()) {
                return Failure(lastItemInfo(), result)
            } else {
                return Success(result)
            }
        } catch (e: Exception) {
            return StrategyError(e)
        }
    }

    func shrink(
        configuration: Configuration,
        runSingle: (T, Array<InputParameter>) -> RunStepResult
    ): ?ProcessorResult {
        try {
            this.currentReduction = 0
            let shrunkInfo = doShrinkWith(configuration, runSingle) ?? return None
            Failure(lastItemInfo(), shrunkInfo)
        } catch (e: Exception) {
            StrategyError(e)
        }
    }

    private func doShrinkWith(
        configuration: Configuration,
        runSingle: (T, Array<InputParameter>) -> RunStepResult
    ): ?ShrinkResult {
        var result = None<ShrinkResult>

        let reductionSteps = configuration.reductionSteps
        var fuel = reductionSteps
        while (fuel > 0) {
            let node = LazyCyclicNode().initialize()
            let shrinkIter = shrinkLastItem(configuration, node).iterator()
            let shrink = LazyCyclicNodeEngine(node, shrinkIter)

            var noCandidates = true
            var nextShrinked = shrink.next()
            while (let Some(shrinked) <- nextShrinked) {
                if (fuel <= 0) {
                    break
                }

                fuel--
                currentReduction++

                let info = lastItemInfo()
                let stepResult = runSingle(shrinked, info)
                if (stepResult.hasFailures()) {
                    result = stepResult
                    noCandidates = false
                    break
                }

                nextShrinked = shrink.next()
            }
            // if the current shrinking iteration produced no new candidates, we should stop
            if (noCandidates) {
                break
            }
        }
        return result
    }

    public func intoBenchmark(
        caseName!: String,
        configuration!: Configuration,
        doRun!: (T, Int64, Int64) -> Float64
    ): Benchmark {
        Benchmark.createWithExplicitLoop<T>(caseName, this, configuration, doRun)
    }

    public func intoUnitTestCase(
        caseName!: String,
        configuration!: Configuration,
        doRun!: (T) -> Unit
    ): UnitTestCase {
        UnitTestCase.createParameterized<T>(caseName, this, configuration: configuration, body: doRun)
    }

    /** Starting point for combinding/mapping `DataStategy`es.
     *
     *  @param s DataStrategy to wrap
     *  @param name Name of the corresponding parameter in testing report
     */
    public static func start(s: DataStrategy<T>, name: String): SimpleProcessor<T> {
        SimpleProcessor<T>({ => s }, name)
    }

    // Overload used for type checking and lazy creation inside macro generated code
    public static func start<U>(f: () -> DataStrategy<U>, name: String): DataStrategyProcessor<U>
        where U <: BenchInputProvider<T>
    {
        SimpleProcessor<U>(f, name).mapWithConfig { input, configuration =>
            // for convenience set batch size automatically
            if (input is BatchSizeOneInputProvider<T>) {
                configuration.batchSize(1)
            }
            input
        }
    }

    // Overload used for type checking and lazy creation inside macro generated code
    public static func start(f: () -> DataStrategy<T>, name: String, x!: Int64 = 0): SimpleProcessor<T> {
        let _ = x
        SimpleProcessor<T>(f, name)
    }

    // Overload used for type checking and lazy creation inside macro generated code
    public static func start(f: () -> DataStrategyProcessor<T>, _: String): DataStrategyProcessor<T> {
        f()
    }

    // Overload used for type checking and lazy creation inside macro generated code
    public static func start<U>(f: () -> DataStrategyProcessor<U>, _: String, x!: Int64 = 0): DataStrategyProcessor<U>
        where U <: BenchInputProvider<T>
    {
        let _ = x
        f()
    }
}

extend<T> DataStrategyProcessor<T> {
    /**
     * "map" combinator that simply applies `f` to every item of original data strategy.
     * Shrinking also happens on original input and then mapped.
     */
    public func map<R>(f: (T) -> R): MapProcessor<T, R> {
        MapProcessor<T, R>(this, { x, _ => f(x) })
    }

    /**
     * "map" combinator with access to current `Configuration` that simply applies `f` to every item of original data strategy.
     * Shrinking also happens on original input and then flat mapped.
     */
    public func mapWithConfig<R>(f: (T, Configuration) -> R): MapProcessor<T, R> {
        MapProcessor<T, R>(this, { x, configuration => f(x, configuration)})
    }

    /**
     * "flat map" combinator that simply applies `f` to every item of original data strategy.
     * Shrinking also happens on original input and then flat mapped.
     */
    public func flatMap<R>(f: (T) -> DataProvider<R>): FlatMapProcessor<T, R> {
        FlatMapProcessor<T, R>(this, f)
    }

    /**
     * "flat map" combinator that simply applies `f` to every item of original data strategy.
     * However shrinking is done by returned strategy rather than original input.
     */
    public func flatMapStrategy<R>(f: (T) -> DataStrategy<R>): FlatMapStrategyProcessor<T, R> {
        FlatMapStrategyProcessor<T, R>(this, f)
    }

    /**
     * Cartesian product combinator. Creates data strategy that contains all possible permutations of elements in original strategies.
     * Shrinking happens on each element of the original strategy independently and uniformly.
     */
    public func product<R>(p: DataStrategyProcessor<R>): CartesianProductProcessor<T, R> {
        CartesianProductProcessor<T, R>(this, p)
    }

    /**
     * Convenience adapter for `DataStrategyProcessor.product` when second strategy only does side effects.
     * Intended to be used from code generated by `@Test` macro to help with type inference.
     */
    public func productWithUnit<P>(p: P): MapProcessor<(T, Unit), T> where P <: DataStrategyProcessor<Unit> {
        CartesianProductProcessor<T, Unit>(this, p)
            .map{ x => x[0] }
    }
}

enum ProcessorResult {
    | Success(RunStepResult)
    | Failure(Array<InputParameter>, RunStepResult)
    | NoItems
    | StrategyError(Exception)
}
