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
 * This is a library for ChainedInputStream class.
 */

package std.io

/**
 * A ChainedInputStream obtains a list of InputSteam.
 * ChainedInputStream is meant for reading InputSteams one by one.
 */
public class ChainedInputStream<T> <: InputStream where T <: InputStream {
    private let inputArr: Array<T>
    private var curIndex: Int64

    /**
     * Constructor
     *
     * @throws IllegalArgumentException -If 'input' is empty.
     */
    public init(input: Array<T>) {
        if (input.isEmpty()) {
            throw IllegalArgumentException("The array of input streams cannot be empty!")
        }
        inputArr = input.clone()
        curIndex = 0
    }

    /**
     * Read the current InputSteam into the buffer.
     *
     * @return Size read into the buffer.
     * @throws IllegalArgumentException -If the buffer is empty.
     * @throws IOException -If failed to read InputSteam.
     */
    public func read(buffer: Array<Byte>): Int64 {
        let inputArrSize = inputArr.size
        if (curIndex >= inputArrSize) {
            return 0
        }

        if (buffer.isEmpty()) {
            throw IllegalArgumentException("The buffer cannot be empty!")
        }

        while (curIndex < inputArrSize) {
            let readNum = inputArr[curIndex].read(buffer)
            if (readNum > 0) {
                return readNum
            } else if (readNum < 0) {
                throw IOException("Failed to read data!")
            }

            inputArr[curIndex] = unsafe { zeroValue<T>() }
            curIndex++
        }
        return 0
    }
}
