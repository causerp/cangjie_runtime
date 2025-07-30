/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
package std.ref

// Helper methods to be called from the runtime.

func getEagerWeakRefPolicy(): CleanupPolicy {
    return EAGER
}

func getDeferredWeakRefPolicy(): CleanupPolicy {
    return DEFERRED
}

/**
 * A base non-generic class with all necessary fields to simplify the backend implementation.
 */
sealed abstract class WeakRefBase {

    // This field must be the first reference field in the class.
    // The runtime relies on this fact to process weak references.
    var _value: Option<Object>

    let _cleanupPolicy: CleanupPolicy

    init(value: Option<Object>, cleanupPolicy: CleanupPolicy) {
        _value = value
        _cleanupPolicy = cleanupPolicy
    }
}

/**
 * Specifies behavior of the runtime regarding this weak reference:
 * EAGER    - clear weak reference as soon as possible.
 *            Useful for listeners, canonicalizing mapping, etc.
 * DEFERRED - clear weak reference only on lack of free memory.
 *            Useful for caches.
 */
public enum CleanupPolicy <: Equatable<CleanupPolicy> {
    EAGER | DEFERRED

    public operator func ==(that: CleanupPolicy): Bool {
        match ((this, that)) {
            case (EAGER, EAGER) => true
            case (DEFERRED, DEFERRED) => true
            case _ => false
        }
    }

    public operator func !=(that: CleanupPolicy): Bool {
        !(this == that)
    }
}

/**
 * A weak reference to T. Weak references do not prevent GC from reclaiming their referents.
 * If referent of a weak reference was reclaimed, the WeakRef.value returns None.
 */
public class WeakRef<T> <: WeakRefBase where T <: Object {

    /**
     * Creates a weak reference to the given object with the given cleanup policy.
     */
    public init(value: T, cleanupPolicy: CleanupPolicy) {
        super(Some(value), cleanupPolicy)
    }

    /**
     * Returns the cleanup policy of this weak reference.
     */
    public prop cleanupPolicy: CleanupPolicy {
        get() {
            _cleanupPolicy
        }
    }

    /**
     * The value of this weak reference. If the referent has been reclaimed by GC or this reference has been
     * cleared by calling the clear() method, the `value` is `None`.
     */
    public prop value: Option<T> {
        get() {
            match (_value) {
                case Some(x) => Some((x as T).getOrThrow())
                case None => None
            }
        }
    }

    /**
     * Forcibly clears the weak reference.
     */
    public func clear(): Unit {
        _value = None
    }
}
