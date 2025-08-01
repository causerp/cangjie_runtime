/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest.mock

import std.collection.ArrayList

/**
 * Part of the stub chain. Specifies an action to be performed by the stub.
 */
public sealed abstract class ActionSelector {
    ActionSelector(
        let sc: Scenario
    ) {}

    func mustBeSpy(actionName: String) {
        match (sc.parentChain.objectKind) {
            case Spy => ()
            case Mock => StubMisconfiguration().fail(sc.parentChain, OnlySpyCanCallOriginal(actionName))
        }
    }

    func throwsImpl(exception: Exception) {
        sc.setAction(Action.Throw { exception })
    }

    func throwsFactoryImpl(exceptionFactory: () -> Exception) {
        requireVerifiable("throws(exceptionFactory)")
        sc.setAction(Action.Throw(exceptionFactory))
    }

    func returnsImpl<TRet>(value: TRet) {
        sc.setAction(Action.Return { value })
    }

    func returnsFactoryImpl<TRet>(factory: () -> TRet) {
        requireVerifiable("returns(valueFactory)")
        sc.setAction(Action.Return { factory() })
    }

    func returnsCollectionImpl<TRet>(values: Collection<TRet>) {
        requireVerifiable("returnsConsecutively")
        let copy = values.toArray()
        let iterator = copy.iterator()
        sc.setAction(Action.Return({ =>
            iterator.next().getOrThrow()
        }))
        sc.setCardinality(Cardinality.times(copy.size))
    }

    /**
     * Triggering this stub will fail the test.
     */
    public func fails(): Unit {
        sc.setAction(Action.Fail)
    }

    private func requireVerifiable(actionName: String) {
        if (!sc.parentChain.isVerifiable()) {
            StubModeViolation().statefulStubAction(actionName, sc.parentChain)
        }
    }
}

/**
 * Defines actions available for methods.
 */
public class MethodActionSelector<TRet> <: ActionSelector {
    MethodActionSelector(
        sc: Scenario
    ) {
        super(sc)
    }

    func cardinalitySelector(): CardinalitySelector<MethodActionSelector<TRet>> {
        CardinalitySelector<MethodActionSelector<TRet>>(sc) { newSc =>
            MethodActionSelector<TRet>(newSc)
        }
    }

    func continuation(): Continuation<MethodActionSelector<TRet>> {
        Continuation<MethodActionSelector<TRet>>(sc) { newSc =>
            MethodActionSelector<TRet>(newSc)
        }
    }

    /**
     * Stub will throw an exception.
     * @param exception to be thrown.
     * @return CardinalitySelector for that action.
     */
    public func throws(exception: Exception): CardinalitySelector<MethodActionSelector<TRet>> {
        throwsImpl(exception)
        cardinalitySelector()
    }

    /**
     * Stub will throw an exception produced by the factory.
     * @param exceptionFactory will be called on each invocation to produce an exception to be thrown.
     * @return CardinalitySelector for that action.
     */
    public func throws(exceptionFactory: () -> Exception): CardinalitySelector<MethodActionSelector<TRet>> {
        throwsFactoryImpl(exceptionFactory)
        cardinalitySelector()
    }

    /**
     * Stub will return a given value.
     * @param value to be returned.
     * @return CardinalitySelector for that action.
     */
    public func returns(value: TRet): CardinalitySelector<MethodActionSelector<TRet>> {
        returnsImpl(value)
        cardinalitySelector()
    }

    /**
     * Stub will return a value produced by the factory.
     * @param valueFactory will be called on each invocation to produce return value.
     * @return CardinalitySelector for that action.
     */
    public func returns(valueFactory: () -> TRet): CardinalitySelector<MethodActionSelector<TRet>> {
        returnsFactoryImpl(valueFactory)
        cardinalitySelector()
    }

    /**
     * Stub will return given values consecutively.
     * Stub will be expected to be called exactly values.size times.
     * @param values an array of values to be returned one after another.
     * @return Continuation for that action that will be invoked after all values in the array were returned.
     */
    public func returnsConsecutively(values: Array<TRet>): Continuation<MethodActionSelector<TRet>> {
        returnsCollectionImpl(values)
        continuation()
    }

    /**
     * Stub will return given values consecutively.
     * Stub will be expected to be called exactly values.size times.
     * @param values a list of values to be returned one after another.
     * @return Continuation for that action that will be invoked after all values in the list were returned.
     */
    public func returnsConsecutively(values: ArrayList<TRet>): Continuation<MethodActionSelector<TRet>> {
        returnsCollectionImpl(values)
        continuation()
    }

    /**
     * Stub will invoke method on original object.
     * Only available for spy objects.
     * @return CardinalitySelector for that action.
     * @throws MockFrameworkException if an object being stubbed is not a spy object.
     */
    public func callsOriginal(): CardinalitySelector<MethodActionSelector<TRet>> {
        mustBeSpy("callsOriginal")
        sc.setAction(Action.CallOriginal)
        cardinalitySelector()
    }
}

/**
 * Defines actions available for field read operations or property getters.
 */
public class GetterActionSelector<TRet> <: ActionSelector {
    GetterActionSelector(
        sc: Scenario
    ) {
        super(sc)
    }

    func cardinalitySelector(): CardinalitySelector<GetterActionSelector<TRet>> {
        CardinalitySelector<GetterActionSelector<TRet>>(sc) { newSc =>
            GetterActionSelector<TRet>(newSc)
        }
    }

    func continuation(): Continuation<GetterActionSelector<TRet>> {
        Continuation<GetterActionSelector<TRet>>(sc) { newSc =>
            GetterActionSelector<TRet>(newSc)
        }
    }

    /**
     * Stub will throw an exception.
     * @param exception to be thrown.
     * @return CardinalitySelector for that action.
     */
    public func throws(exception: Exception): CardinalitySelector<GetterActionSelector<TRet>> {
        throwsImpl(exception)
        cardinalitySelector()
    }

    /**
     * Stub will throw an exception produced by the factory.
     * @param exceptionFactory will be called on each invocation to produce an exception to be thrown.
     * @return CardinalitySelector for that action.
     */
    public func throws(exceptionFactory: () -> Exception): CardinalitySelector<GetterActionSelector<TRet>> {
        throwsFactoryImpl(exceptionFactory)
        cardinalitySelector()
    }

    /**
     * Stub will return a given value.
     * @param value to be returned.
     * @return CardinalitySelector for that action.
     */
    public func returns(value: TRet): CardinalitySelector<GetterActionSelector<TRet>> {
        returnsImpl(value)
        cardinalitySelector()
    }

    /**
     * Stub will return a value produced by the factory.
     * @param valueFactory will be called on each invocation to produce return value.
     * @return CardinalitySelector for that action.
     */
    public func returns(valueFactory: () -> TRet): CardinalitySelector<GetterActionSelector<TRet>> {
        returnsFactoryImpl(valueFactory)
        cardinalitySelector()
    }

    /**
     * Stub will return given values consecutively.
     * Stub will be expected to be called exactly values.size times.
     * @param values an array of values to be returned one after another.
     * @return Continuation for that action that will be invoked after all values in the array were returned.
     */
    public func returnsConsecutively(values: Array<TRet>): Continuation<GetterActionSelector<TRet>> {
        returnsCollectionImpl(values)
        continuation()
    }

    /**
     * Stub will return given values consecutively.
     * Stub will be expected to be called exactly values.size times.
     * @param values a list of values to be returned one after another.
     * @return Continuation for that action that will be invoked after all values in the list were returned.
     */
    public func returnsConsecutively(values: ArrayList<TRet>): Continuation<GetterActionSelector<TRet>> {
        returnsCollectionImpl(values)
        continuation()
    }

    /**
     * Stub will get original field or call original property getter.
     * Only available for spy objects.
     * @return CardinalitySelector for that action.
     * @throws MockFrameworkException if an object being stubbed is not a spy object.
     */
    public func getsOriginal(): CardinalitySelector<GetterActionSelector<TRet>> {
        mustBeSpy("getsOriginal")
        sc.setAction(Action.CallOriginal)
        cardinalitySelector()
    }

    /**
     * Stub will get value of synthetic field.
     * @param field synthetic field object managed by the framework.
     * @return CardinalitySelector for that action.
     */
    public func getsField(field: SyntheticField<TRet>): CardinalitySelector<GetterActionSelector<TRet>> {
        sc.setAction(Action.GetField(field.description))
        cardinalitySelector()
    }
}

/**
 * Defines actions available for field write operations or property setters.
 */
public class SetterActionSelector<TArg> <: ActionSelector {
    SetterActionSelector(
        sc: Scenario
    ) {
        super(sc)
    }

    func cardinalitySelector(): CardinalitySelector<SetterActionSelector<TArg>> {
        CardinalitySelector<SetterActionSelector<TArg>>(sc) { newSc =>
            SetterActionSelector<TArg>(newSc)
        }
    }

    /**
     * Stub will throw an exception.
     * @param exception to be thrown.
     * @return CardinalitySelector for that action.
     */
    public func throws(exception: Exception): CardinalitySelector<SetterActionSelector<TArg>> {
        throwsImpl(exception)
        cardinalitySelector()
    }

    /**
     * Stub will throw an exception produced by the factory.
     * @param exceptionFactory will be called on each invocation to produce an exception to be thrown.
     * @return CardinalitySelector for that action.
     */
    public func throws(exceptionFactory: () -> Exception): CardinalitySelector<SetterActionSelector<TArg>> {
        throwsFactoryImpl(exceptionFactory)
        cardinalitySelector()
    }

    /**
     * Stub will do nothing (return () ).
     * @return CardinalitySelector for that action.
     */
    public func doesNothing(): CardinalitySelector<SetterActionSelector<TArg>> {
        sc.setAction(Action.Return { () })
        cardinalitySelector()
    }

    /**
     * Stub will set original field or call original property setter.
     * Only available for spy objects.
     * @return CardinalitySelector for that action.
     * @throws MockFrameworkException if an object being stubbed is not a spy object.
     */
    public func setsOriginal(): CardinalitySelector<SetterActionSelector<TArg>> {
        mustBeSpy("setsOriginal")
        sc.setAction(Action.CallOriginal)
        cardinalitySelector()
    }

    /**
     * Stub will set value of synthetic field.
     * @param field synthetic field object managed by the framework.
     * @return CardinalitySelector for that action.
     */
    public func setsField(field: SyntheticField<TArg>): CardinalitySelector<SetterActionSelector<TArg>> {
        sc.setAction(Action.SetField(field.description))
        cardinalitySelector()
    }
}

extend MethodActionSelector<Unit> {
    /**
     * Stub will do nothing (return () ).
     * @return CardinalitySelector for that action.
     */
    public func returns(): CardinalitySelector<MethodActionSelector<Unit>> {
        returnsImpl(())
        cardinalitySelector()
    }
}
