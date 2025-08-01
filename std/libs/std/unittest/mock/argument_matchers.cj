/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.unittest.mock

/**
 * ArgumentMatcher represent an expression that can be used
 *     instead of an argument inside @On or @Called macro.
 * Instances of this class should be obtained using static methods of Matchers class.
 */
public abstract class ArgumentMatcher {
    private var description: Option<String> = None
    private var parameterName: Option<String> = None

    ArgumentMatcher() {}

    func getDescription(): Option<String> {
        description
    }

    /**
     * @param description to be used in error reports.
     * @returns receiver.
     */
    public func withDescription(description: String): ArgumentMatcher {
        this.description = Some(description)
        return this
    }

    func getParameterName(): Option<String> {
        parameterName
    }

    /**
     * @param name of the parameter that this matcher is for.
     * @returns receiver.
     */
    public func forParameter(name: String): ArgumentMatcher {
        this.parameterName = Some(name)
        return this
    }

    /**
     * @param arg value of the argument.
     * @returns whether argument value should be accpeted or not.
     */
    public func matchesAny(arg: Any): Bool
}

// not visible to the user
// can't be generic because type information cannot be preserved inside framework code
// the only valid implementation for ListenerInternal is ValueListenerImpl<T> which guarantees type safety
// when passed inside capture<T> or similar matcher
interface ListeningMatcher {
    prop valueListener: Option<ListenerInternal>
}

/**
 * Base interface for typed matchers: matchers that only match values of certain types.
 */
public abstract class TypedMatcher<T> <: ArgumentMatcher {
    TypedMatcher(
        private let expectedBooleanValue: Bool
    ) {}

    /**
     * @param arg value of the argument.
     * @returns whether argument value should be accepted or not.
     */
    public func matches(arg: T): Bool

    public override func matchesAny(arg: Any): Bool {
        match (unwrapValue<T>(arg)) {
            case Some(typed) => matches(typed) == expectedBooleanValue
            case None => !expectedBooleanValue
        }
    }
}

class PredicateMatcher<T> <: TypedMatcher<T> & ListeningMatcher {
    PredicateMatcher(
        private let predicate: (T) -> Bool,
        private let expectedBooleanValue!: Bool = true,
        private let listener!: Option<ListenerInternal> = None
    ) {
        super(expectedBooleanValue)
    }

    public override func matches(arg: T): Bool {
        return predicate(arg)
    }

    public prop valueListener: Option<ListenerInternal> {
        get() { listener }
    }
}

/**
 * Matcher that matches any values.
 */
public class AnyMatcher <: ArgumentMatcher {
    public func matchesAny(_: Any) {
        return true
    }
}

/**
 * Contains definitions for argument matchers that can be used as part of '@On(<stub call>)' stubbing chain.
 * Argument matchers must be defined as static functions on Matchers class.
 */
public class Matchers {
    private Matchers() {}

    /**
     * Matches arguments based on provided predicate.
     * @param predicate used to filter values that are accepted by the predicate.
     * @returns argument matcher that accepts values that satisfy 'predicate(value) == true' condition.
     */
    public static func argThat<T>(predicate: (T) -> Bool): TypedMatcher<T> {
        return PredicateMatcher(predicate, expectedBooleanValue: true)
    }

    /**
     * Matches arguments based on provided predicate.
     * @param predicate used to filter out values that are rejected.
     * @returns argument matcher that accepts values that satisfy 'predicate(value) == false' condition.
     */
    public static func argThatNot<T>(predicate: (T) -> Bool): TypedMatcher<T> {
        return PredicateMatcher(predicate, expectedBooleanValue: false)
    }

    /**
     * Matches arguments based on provided predicate.
     * Allows listening to passed in values.
     * Note that only values accepted by the predicate can be listened to.
     *
     * @param listener that will be invoked on each matching (accepted by the predicate) value passed to the stub.
     * @param predicate used to filter values that are accepted.
     * @returns argument matcher that accepts values that satisfy 'predicate(value) == true' condition.
     */
    public static func argThat<T>(listener: ValueListener<T>, predicate: (T) -> Bool): TypedMatcher<T> {
        if (let Some(listener) <- (listener as ListenerInternal)) {
            return PredicateMatcher<T>(predicate, expectedBooleanValue: true, listener: Some(listener))
        } else {
            illegalInput("Invalid value listener instance")
        }
    }

    /**
     * Filters input value based on reference equality to the provided object.
     *
     * @param target that must be matched.
     * @returns argument matcher only allowing references to the given object.
     */
    public static func same<T>(target: T): TypedMatcher<T> where T <: Object {
        return argThat<T> {
            arg: T => refEq(target, arg)
        }
    }

    /**
     * Filters input value based on structural equality to the provided value.
     *
     * @param target that must be matched.
     * @returns argument matcher only allowing values structurally equal to the given value.
     */
    public static func eq<T>(target: T): TypedMatcher<T> where T <: Equatable<T> {
        return argThat<T> {
            arg: T => target == arg
        }
    }

    /**
     * Filters input value based on their type.
     *
     * @returns argument matcher only allowing values of certain type.
     */
    public static func ofType<T>(): TypedMatcher<T> {
        return argThat<T> {
            arg: T => true
        }
    }

    /**
     * Allows any value to be passed in as an argument to the stub.
     *
     * @returns argument matcher allowing any value.
     */
    public static func any(): AnyMatcher {
        return AnyMatcher()
    }

    /**
     * Allows listening to any value of type T passed in as an argument.
     * If the type argument is not specified explicitly then it will be inferred from the type argument of the listener.
     *
     * @param listener that will be invoked on each value passed in as an argument to the stub.
     * @returns argument matcher allowing any value.
     */
    public static func capture<T>(listener: ValueListener<T>): TypedMatcher<T> {
        if (let Some(listener) <- (listener as ListenerInternal)) {
            return PredicateMatcher<T>({any: T => true}, listener: listener)
        } else {
            illegalInput("Invalid value listener instance")
        }
    }

    /**
     * Default matcher will match values based on structural (higher priority) or reference equality.
     * Appicabilty of this matcher is not guaranteed at compile time.
     * If passed in argument is neither Equatable<T> nor a reference type an exception will be thrown at runtime.
     *
     * @param target that must be matched either by structural or reference equality.
     * @returns argument matcher allowing values matching target.
     * @throws MockFrameworkException if target is neither equatable not a reference type.
     */
    public static func default<T>(target: T): TypedMatcher<T> {
        match (target) {
            case equatable: Equatable<T> =>
                argThat<T> {
                    arg: T => equatable == arg
                }
            case targetObj: Object =>
                argThat<T> {
                    arg : T =>
                        match (arg) {
                            case argObj: Object => refEq(targetObj, argObj)
                            case _ => false
                        }
                }
            case _ => illegalInput("Argument of default matcher should be equatable or reference type")
        }
    }
}

/**
 * These methods are used during macro expansion to enforce compiler error on type mismatch.
 * Do not use directly.
 */
extend<T> TypedMatcher<T> {
    public func value(): T {
        return unsafe { zeroValue<T>() }
    }
}

extend AnyMatcher {
    public func value<T>(): T {
        return unsafe { zeroValue<T>() }
    }
}
