/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.core

@Intrinsic
func sizeOfType<T>(): UIntNative where T <: CType

@Intrinsic
func alignOfType<T>(): UIntNative where T <: CType

@FastNative
foreign func malloc(size: UIntNative): CPointer<Unit>

@FastNative
foreign func free(p: CPointer<Unit>): Unit

let SECUREC_MEM_MAX_LEN = Int64(Int32.Max)

public func sizeOf<T>(): UIntNative where T <: CType {
    return sizeOfType<T>()
}

public func alignOf<T>(): UIntNative where T <: CType {
    return alignOfType<T>()
}

private unsafe func freeWrapper(p: CPointer<Unit>): Unit {
    free(p)
}

public struct LibC {
    public static func malloc<T>(count!: Int64 = 1): CPointer<T> where T <: CType {
        if (count < 0) {
            throw IllegalArgumentException("The value of count cannot be negative")
        }
        let itemSize = sizeOf<T>()
        if (UIntNative.Max / itemSize < UIntNative(count)) {
            return CPointer<T>()
        }
        let size = UIntNative(count) * sizeOf<T>()
        return CPointer<T>(unsafe { malloc(size) })
    }

    public unsafe static func free<T>(p: CPointer<T>): Unit where T <: CType {
        freeWrapper(CPointer<Unit>(p))
    }

    public unsafe static func mallocCString(str: String): CString {
        let arr: RawArray<UInt8> = str.myData
        var length: Int64 = str.size
        var cp: CPointer<UInt8> = LibC.malloc<UInt8>(count: length + 1)
        if (cp.isNull()) {
            throw IllegalMemoryException("Malloc in mallocCString failed.")
        }
        cp.write(length, 0)
        if (length == 0) {
            return CString(cp)
        }
        let ptrArr: CPointer<UInt8> = str.acquireRaw()
        // If the length of the string is greater than the safe length of the safe function,
        // it needs to be copied multiple times.
        var remain = length
        var offset = 0
        while (remain >= SECUREC_MEM_MAX_LEN) {
            memcpy_s(cp + offset, UIntNative(SECUREC_MEM_MAX_LEN), ptrArr + offset, UIntNative(SECUREC_MEM_MAX_LEN))
            offset += SECUREC_MEM_MAX_LEN
            remain -= SECUREC_MEM_MAX_LEN
        }
        if (remain > 0) {
            memcpy_s(cp + offset, UIntNative(remain), ptrArr + offset, UIntNative(remain))
        }

        str.releaseRaw(ptrArr)
        return CString(cp)
    }

    public unsafe static func free(cstr: CString): Unit {
        var ptr = cstr.getChars()
        freeWrapper(CPointer<Unit>(ptr))
    }
}
