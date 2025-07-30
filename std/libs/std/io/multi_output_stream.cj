/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

/**
 * @file
 *
 * This is a library for MultiOutputStream class.
 */

package std.io

public class MultiOutputStream<T> <: OutputStream where T <: OutputStream {
    private var outputArr: Array<T>

    /**
     * @throws IllegalArgumentException if output is empty
     */
    public init(output: Array<T>) {
        if (output.isEmpty()) {
            throw IllegalArgumentException("The array of output streams cannot be empty!")
        }
        outputArr = output.clone()
    }

    public func write(buffer: Array<Byte>): Unit {
        for (outputStream in outputArr) {
            outputStream.write(buffer)
        }
    }

    public func flush(): Unit {
        for (outputStream in outputArr) {
            outputStream.flush()
        }
    }
}
