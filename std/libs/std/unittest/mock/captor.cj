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
 * Allows listening to arguments passed in to stubs.
 * Can be used together with *argThat* or *capture* argument matchers.
 */
public interface ValueListener<T> {
    /**
     * @returns last value proccesed by the listener if any.
     */
    func lastValue(): Option<T>

    /**
     * @returns a snapshot of all values processed by the listener so far.
     */
    func allValues(): Array<T>

    /**
     * @param callback to be invoked whenever new value is provided.
     */
    func addCallback(callback: (T) -> Unit): Unit

    /**
     * @returns new ValueListener without any callbacks attached to it.
     */
    static func new(): ValueListener<T> {
        ValueListenerImpl<T>()
    }

    /**
     * @param callback to be attached to the created listener.
     * @returns new ValueListener with the callback already attached.
     */
    static func onEach(callback: (T) -> Unit): ValueListener<T> {
        return ValueListenerImpl<T>(callback)
    }
}

// this is not visible to the user
// can't be generic because type information cannot be preserved inside framework code
interface ListenerInternal {
    func supplyValue(value: Any): Unit
}

class ValueListenerImpl<T> <: ValueListener<T> & ListenerInternal {
    private let callBacks = ArrayList<(T) -> Unit>()
    private let values = ArrayList<T>()

    ValueListenerImpl() {}

    init(callBack: (T) -> Unit) {
        addCallback(callBack)
    }

    public func lastValue(): Option<T> {
        return values.get(values.size - 1)
    }

    public func allValues(): Array<T> {
        return values.toArray()
    }

    public func addCallback(callBack: (T) -> Unit) {
        callBacks.add(callBack)
    }

    public override func supplyValue(value: Any) {
        if (let Some(valueAsT) <- unwrapValue<T>(value)) {
            for (callback in callBacks) {
                callback(valueAsT)
            }
            values.add(valueAsT)
        }
    }
}
