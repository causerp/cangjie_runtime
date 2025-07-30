/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.runtime

@When[backend == "cjnative"]
@Intrinsic
func getThreadNumber(): Int64

@When[backend == "cjnative"]
@Intrinsic
func getBlockingThreadNumber(): Int64

@When[backend == "cjnative"]
@Intrinsic
func getNativeThreadNumber(): Int64

@When[backend == "cjnative"]
@Deprecated[message: "All static Properties are converted to public functions."]
public struct ThreadInfo {
    /**
     * Get current number of threads.
     */
    public static prop threadCount: Int64 {
        get() {
            getThreadCount()
        }
    }
    /**
     * Get the number of blocked threads.
     */
    public static prop blockingThreadCount: Int64 {
        get() {
            getBlockingThreadCount()
        }
    }
    /**
     * Get the actual number of physical threads.
     */
    public static prop nativeThreadCount: Int64 {
        get() {
            getNativeThreadCount()
        }
    }
}

@When[backend == "cjnative"]
public func getThreadCount(): Int64 {
    return getThreadNumber()
}

@When[backend == "cjnative"]
public func getBlockingThreadCount(): Int64 {
    return getBlockingThreadNumber()
}

@When[backend == "cjnative"]
public func getNativeThreadCount(): Int64 {
    return getNativeThreadNumber()
}
