/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.core

/**
 * Endianness, also known as byte order.
 *
 */
public enum Endian {
    Big | Little
    /**
     * Get the endianness of the current running platform.
     *
     */
    public static prop Platform: Endian {
        get() {
            let code = unsafe {
                CJ_PlatformEndian()
            }

            match (code) {
                case 1 => Big
                case 2 => Little
                case _ => throw Exception("Platform endian detection failed")
            }
        }
    }
}

foreign func CJ_PlatformEndian(): UInt8
