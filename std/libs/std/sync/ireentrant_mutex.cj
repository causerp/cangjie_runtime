/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.sync

// Common interface for reentrant mutual exclusion concurrency primitives.
//  ! It is a responsibility of implementor to guarantee that underlying mutex actually supports nested locking.
//  ! It is a responsibility of implementor to throw ISSE in case of violation of contract.
//  ! `synchronized` keyword is not compatible with this interface for performance reasons
@Deprecated[message: "Use `public interface Lock` instead."]
public interface IReentrantMutex {
    // reentrant lock, blocks until success
    func lock(): Unit

    // returns false on fail, does not block
    func tryLock(): Bool

    // if mutex is locked recursively, this method should be invoked N times to fully unlock mutex
    // throws ISSE("Mutex is not locked by current thread") if current thread does not hold this mutex
    func unlock(): Unit
}

public class IllegalSynchronizationStateException <: Exception {
    public init() {
        super()
    }

    public init(message: String) {
        super(message)
    }
    protected override func getClassName(): String {
        return "IllegalSynchronizationStateException"
    }
}
