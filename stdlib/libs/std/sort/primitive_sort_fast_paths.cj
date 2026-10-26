/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.sort

func tryPrimitiveUnstableSort<T>(data: Array<T>): Bool where T <: Comparable<T> {
    if (let Some(concreteData) <- (data as Array<Int8>)) {
        primitiveUnstableSortInt8(concreteData)
        return true
    }
    if (let Some(concreteData) <- (data as Array<Int16>)) {
        primitiveUnstableSortInt16(concreteData)
        return true
    }
    if (let Some(concreteData) <- (data as Array<Int32>)) {
        primitiveUnstableSortInt32(concreteData)
        return true
    }
    if (let Some(concreteData) <- (data as Array<Int64>)) {
        primitiveUnstableSortInt64(concreteData)
        return true
    }
    if (let Some(concreteData) <- (data as Array<IntNative>)) {
        primitiveUnstableSortIntNative(concreteData)
        return true
    }
    if (let Some(concreteData) <- (data as Array<UInt8>)) {
        primitiveUnstableSortUInt8(concreteData)
        return true
    }
    if (let Some(concreteData) <- (data as Array<UInt16>)) {
        primitiveUnstableSortUInt16(concreteData)
        return true
    }
    if (let Some(concreteData) <- (data as Array<UInt32>)) {
        primitiveUnstableSortUInt32(concreteData)
        return true
    }
    if (let Some(concreteData) <- (data as Array<UInt64>)) {
        primitiveUnstableSortUInt64(concreteData)
        return true
    }
    if (let Some(concreteData) <- (data as Array<UIntNative>)) {
        primitiveUnstableSortUIntNative(concreteData)
        return true
    }
    if (let Some(concreteData) <- (data as Array<Float16>)) {
        primitiveUnstableSortFloat16(concreteData)
        return true
    }
    if (let Some(concreteData) <- (data as Array<Float32>)) {
        primitiveUnstableSortFloat32(concreteData)
        return true
    }
    if (let Some(concreteData) <- (data as Array<Float64>)) {
        primitiveUnstableSortFloat64(concreteData)
        return true
    }
    if (let Some(concreteData) <- (data as Array<Rune>)) {
        primitiveUnstableSortRune(concreteData)
        return true
    }
    return false
}

func tryPrimitiveStableSort<T>(data: Array<T>): Bool where T <: Comparable<T> {
    if (let Some(concreteData) <- (data as Array<Int8>)) {
        primitiveStableSortInt8(concreteData)
        return true
    }
    if (let Some(concreteData) <- (data as Array<Int16>)) {
        primitiveStableSortInt16(concreteData)
        return true
    }
    if (let Some(concreteData) <- (data as Array<Int32>)) {
        primitiveStableSortInt32(concreteData)
        return true
    }
    if (let Some(concreteData) <- (data as Array<Int64>)) {
        primitiveStableSortInt64(concreteData)
        return true
    }
    if (let Some(concreteData) <- (data as Array<IntNative>)) {
        primitiveStableSortIntNative(concreteData)
        return true
    }
    if (let Some(concreteData) <- (data as Array<UInt8>)) {
        primitiveStableSortUInt8(concreteData)
        return true
    }
    if (let Some(concreteData) <- (data as Array<UInt16>)) {
        primitiveStableSortUInt16(concreteData)
        return true
    }
    if (let Some(concreteData) <- (data as Array<UInt32>)) {
        primitiveStableSortUInt32(concreteData)
        return true
    }
    if (let Some(concreteData) <- (data as Array<UInt64>)) {
        primitiveStableSortUInt64(concreteData)
        return true
    }
    if (let Some(concreteData) <- (data as Array<UIntNative>)) {
        primitiveStableSortUIntNative(concreteData)
        return true
    }
    if (let Some(concreteData) <- (data as Array<Float16>)) {
        primitiveStableSortFloat16(concreteData)
        return true
    }
    if (let Some(concreteData) <- (data as Array<Float32>)) {
        primitiveStableSortFloat32(concreteData)
        return true
    }
    if (let Some(concreteData) <- (data as Array<Float64>)) {
        primitiveStableSortFloat64(concreteData)
        return true
    }
    if (let Some(concreteData) <- (data as Array<Rune>)) {
        primitiveStableSortRune(concreteData)
        return true
    }
    return false
}

private func primitiveUnstableSortInt8(data: Array<Int8>): Unit {
    data.introSort(0, data.size - 1, data.depth())
}

private func primitiveStableSortInt8(data: Array<Int8>): Unit {
    data.timSort()
}

private func primitiveUnstableSortInt16(data: Array<Int16>): Unit {
    data.introSort(0, data.size - 1, data.depth())
}

private func primitiveStableSortInt16(data: Array<Int16>): Unit {
    data.timSort()
}

private func primitiveUnstableSortInt32(data: Array<Int32>): Unit {
    data.introSort(0, data.size - 1, data.depth())
}

private func primitiveStableSortInt32(data: Array<Int32>): Unit {
    data.timSort()
}

private func primitiveUnstableSortInt64(data: Array<Int64>): Unit {
    data.introSort(0, data.size - 1, data.depth())
}

private func primitiveStableSortInt64(data: Array<Int64>): Unit {
    data.timSort()
}

private func primitiveUnstableSortIntNative(data: Array<IntNative>): Unit {
    data.introSort(0, data.size - 1, data.depth())
}

private func primitiveStableSortIntNative(data: Array<IntNative>): Unit {
    data.timSort()
}

private func primitiveUnstableSortUInt8(data: Array<UInt8>): Unit {
    data.introSort(0, data.size - 1, data.depth())
}

private func primitiveStableSortUInt8(data: Array<UInt8>): Unit {
    data.timSort()
}

private func primitiveUnstableSortUInt16(data: Array<UInt16>): Unit {
    data.introSort(0, data.size - 1, data.depth())
}

private func primitiveStableSortUInt16(data: Array<UInt16>): Unit {
    data.timSort()
}

private func primitiveUnstableSortUInt32(data: Array<UInt32>): Unit {
    data.introSort(0, data.size - 1, data.depth())
}

private func primitiveStableSortUInt32(data: Array<UInt32>): Unit {
    data.timSort()
}

private func primitiveUnstableSortUInt64(data: Array<UInt64>): Unit {
    data.introSort(0, data.size - 1, data.depth())
}

private func primitiveStableSortUInt64(data: Array<UInt64>): Unit {
    data.timSort()
}

private func primitiveUnstableSortUIntNative(data: Array<UIntNative>): Unit {
    data.introSort(0, data.size - 1, data.depth())
}

private func primitiveStableSortUIntNative(data: Array<UIntNative>): Unit {
    data.timSort()
}

private func primitiveUnstableSortFloat16(data: Array<Float16>): Unit {
    data.introSort(0, data.size - 1, data.depth())
}

private func primitiveStableSortFloat16(data: Array<Float16>): Unit {
    data.timSort()
}

private func primitiveUnstableSortFloat32(data: Array<Float32>): Unit {
    data.introSort(0, data.size - 1, data.depth())
}

private func primitiveStableSortFloat32(data: Array<Float32>): Unit {
    data.timSort()
}

private func primitiveUnstableSortFloat64(data: Array<Float64>): Unit {
    data.introSort(0, data.size - 1, data.depth())
}

private func primitiveStableSortFloat64(data: Array<Float64>): Unit {
    data.timSort()
}

private func primitiveUnstableSortRune(data: Array<Rune>): Unit {
    data.introSort(0, data.size - 1, data.depth())
}

private func primitiveStableSortRune(data: Array<Rune>): Unit {
    data.timSort()
}
