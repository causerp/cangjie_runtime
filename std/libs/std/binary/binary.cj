/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.binary

/**
 * big-endian order interface
 *
 */
public interface BigEndianOrder<T> {
    /**
     * @brief write a value of type T in big-endian order to the buffer byte array
     * @param buffer, the target byte array
     * @return the number of bytes written if the buffer length is sufficient, otherwise throws an exception
     * @exception throws IndexOutOfBoundsException when the target length is insufficient
     */
    func writeBigEndian(buffer: Array<Byte>): Int64
    /**
     * @brief raead the value of type T in big-endian order from the buffer byte array
     * @param buffer, the source byte array
     * @return the value of type T
     * @exception throws IndexOutOfBoundsException when the target length is insufficient
     */
    static func readBigEndian(buffer: Array<Byte>): T
}
/**
 * little-endian order interface
 *
 */
public interface LittleEndianOrder<T> {
    /**
     * @brief write a value of type T in little-endian order to the buffer byte array
     * @param buffer, the target byte array
     * @return the number of bytes written if the buffer length is sufficient, otherwise throws an exception
     * @exception throws IndexOutOfBoundsException when the target length is insufficient
     */
    func writeLittleEndian(buffer: Array<Byte>): Int64
    /**
     * @brief raead the value of type T in little-endian order from the buffer byte array
     * @param buffer, the source byte array
     * @return the value of type T
     * @exception throws IndexOutOfBoundsException when the target length is insufficient
     */
    static func readLittleEndian(buffer: Array<Byte>): T
}

/**
 * @brief swap endian order interface
 *
 */
public interface SwapEndianOrder<T> {
    /**
     * @brief reverse the byte order of T
     * @return the value of type T
     */
    func swapBytes(): T
}

extend UInt64 <: BigEndianOrder<UInt64> & LittleEndianOrder<UInt64> & SwapEndianOrder<UInt64> {
    @OverflowWrapping
    public func writeLittleEndian(buffer: Array<UInt8>): Int64 {
        if (buffer.size < 8) {
            throw IndexOutOfBoundsException("Buffer size(${buffer.size}) is too small.")
        }
        buffer[0] = UInt8(this)
        buffer[1] = UInt8(this >> 8)
        buffer[2] = UInt8(this >> 16)
        buffer[3] = UInt8(this >> 24)
        buffer[4] = UInt8(this >> 32)
        buffer[5] = UInt8(this >> 40)
        buffer[6] = UInt8(this >> 48)
        buffer[7] = UInt8(this >> 56)
        return 8
    }

    @OverflowWrapping
    public func writeBigEndian(buffer: Array<UInt8>): Int64 {
        if (buffer.size < 8) {
            throw IndexOutOfBoundsException("Buffer size(${buffer.size}) is too small.")
        }
        buffer[0] = UInt8(this >> 56)
        buffer[1] = UInt8(this >> 48)
        buffer[2] = UInt8(this >> 40)
        buffer[3] = UInt8(this >> 32)
        buffer[4] = UInt8(this >> 24)
        buffer[5] = UInt8(this >> 16)
        buffer[6] = UInt8(this >> 8)
        buffer[7] = UInt8(this)
        return 8
    }

    @OverflowWrapping
    public static func readBigEndian(buffer: Array<UInt8>): UInt64 {
        if (buffer.size < 8) {
            throw IndexOutOfBoundsException("Buffer size(${buffer.size}) is too small.")
        }
        return UInt64(buffer[7]) | UInt64(buffer[6]) << 8 | UInt64(buffer[5]) << 16 | UInt64(buffer[4]) << 24 |
            UInt64(buffer[3]) << 32 | UInt64(buffer[2]) << 40 | UInt64(buffer[1]) << 48 | UInt64(buffer[0]) << 56
    }

    @OverflowWrapping
    public static func readLittleEndian(buffer: Array<UInt8>): UInt64 {
        if (buffer.size < 8) {
            throw IndexOutOfBoundsException("Buffer size(${buffer.size}) is too small.")
        }
        return UInt64(buffer[0]) | UInt64(buffer[1]) << 8 | UInt64(buffer[2]) << 16 | UInt64(buffer[3]) << 24 |
            UInt64(buffer[4]) << 32 | UInt64(buffer[5]) << 40 | UInt64(buffer[6]) << 48 | UInt64(buffer[7]) << 56
    }

    public func swapBytes(): UInt64 {
        return unsafe { CJ_Bswap64(this) }
    }
}

extend Int64 <: BigEndianOrder<Int64> & LittleEndianOrder<Int64> & SwapEndianOrder<Int64> {
    @OverflowWrapping
    public func writeLittleEndian(buffer: Array<Byte>): Int64 {
        UInt64(this).writeLittleEndian(buffer)
    }

    @OverflowWrapping
    public func writeBigEndian(buffer: Array<Byte>): Int64 {
        UInt64(this).writeBigEndian(buffer)
    }

    @OverflowWrapping
    public static func readBigEndian(buffer: Array<UInt8>): Int64 {
        if (buffer.size < 8) {
            throw IndexOutOfBoundsException("Buffer size(${buffer.size}) is too small.")
        }
        return Int64(buffer[7]) | Int64(buffer[6]) << 8 | Int64(buffer[5]) << 16 | Int64(buffer[4]) << 24 |
            Int64(buffer[3]) << 32 | Int64(buffer[2]) << 40 | Int64(buffer[1]) << 48 | Int64(buffer[0]) << 56
    }

    @OverflowWrapping
    public static func readLittleEndian(buffer: Array<UInt8>): Int64 {
        if (buffer.size < 8) {
            throw IndexOutOfBoundsException("Buffer size(${buffer.size}) is too small.")
        }
        return Int64(buffer[0]) | Int64(buffer[1]) << 8 | Int64(buffer[2]) << 16 | Int64(buffer[3]) << 24 |
            Int64(buffer[4]) << 32 | Int64(buffer[5]) << 40 | Int64(buffer[6]) << 48 | Int64(buffer[7]) << 56
    }

    @OverflowWrapping
    public func swapBytes(): Int64 {
        var reversed = UInt64(this).swapBytes()
        return Int64(reversed)
    }
}

extend UInt32 <: BigEndianOrder<UInt32> & LittleEndianOrder<UInt32> & SwapEndianOrder<UInt32> {
    @OverflowWrapping
    public func writeLittleEndian(buffer: Array<Byte>): Int64 {
        if (buffer.size < 4) {
            throw IndexOutOfBoundsException("Buffer size(${buffer.size}) is too small.")
        }
        buffer[0] = UInt8(this)
        buffer[1] = UInt8(this >> 8)
        buffer[2] = UInt8(this >> 16)
        buffer[3] = UInt8(this >> 24)
        return 4
    }

    @OverflowWrapping
    public func writeBigEndian(buffer: Array<Byte>): Int64 {
        if (buffer.size < 4) {
            throw IndexOutOfBoundsException("Buffer size(${buffer.size}) is too small.")
        }
        buffer[0] = UInt8(this >> 24)
        buffer[1] = UInt8(this >> 16)
        buffer[2] = UInt8(this >> 8)
        buffer[3] = UInt8(this)
        return 4
    }

    @OverflowWrapping
    public static func readBigEndian(buffer: Array<UInt8>): UInt32 {
        if (buffer.size < 4) {
            throw IndexOutOfBoundsException("Buffer size(${buffer.size}) is too small.")
        }
        return UInt32(buffer[3]) | UInt32(buffer[2]) << 8 | UInt32(buffer[1]) << 16 | UInt32(buffer[0]) << 24
    }

    @OverflowWrapping
    public static func readLittleEndian(buffer: Array<UInt8>): UInt32 {
        if (buffer.size < 4) {
            throw IndexOutOfBoundsException("Buffer size(${buffer.size}) is too small.")
        }
        return UInt32(buffer[0]) | UInt32(buffer[1]) << 8 | UInt32(buffer[2]) << 16 | UInt32(buffer[3]) << 24
    }
    public func swapBytes(): UInt32 {
        return unsafe { CJ_Bswap32(this) }
    }
}

extend Int32 <: BigEndianOrder<Int32> & LittleEndianOrder<Int32> & SwapEndianOrder<Int32> {
    @OverflowWrapping
    public func writeLittleEndian(buffer: Array<Byte>): Int64 {
        UInt32(this).writeLittleEndian(buffer)
    }

    @OverflowWrapping
    public func writeBigEndian(buffer: Array<Byte>): Int64 {
        UInt32(this).writeBigEndian(buffer)
    }

    @OverflowWrapping
    public static func readBigEndian(buffer: Array<UInt8>): Int32 {
        if (buffer.size < 4) {
            throw IndexOutOfBoundsException("Buffer size(${buffer.size}) is too small.")
        }
        return Int32(buffer[3]) | Int32(buffer[2]) << 8 | Int32(buffer[1]) << 16 | Int32(buffer[0]) << 24
    }

    @OverflowWrapping
    public static func readLittleEndian(buffer: Array<UInt8>): Int32 {
        if (buffer.size < 4) {
            throw IndexOutOfBoundsException("Buffer size(${buffer.size}) is too small.")
        }
        return Int32(buffer[0]) | Int32(buffer[1]) << 8 | Int32(buffer[2]) << 16 | Int32(buffer[3]) << 24
    }

    @OverflowWrapping
    public func swapBytes(): Int32 {
        var reversed = UInt32(this).swapBytes()
        return Int32(reversed)
    }
}

extend UInt16 <: BigEndianOrder<UInt16> & LittleEndianOrder<UInt16> & SwapEndianOrder<UInt16> {
    @OverflowWrapping
    public func writeLittleEndian(buffer: Array<Byte>): Int64 {
        if (buffer.size < 2) {
            throw IndexOutOfBoundsException("Buffer size(${buffer.size}) is too small.")
        }
        buffer[0] = UInt8(this)
        buffer[1] = UInt8(this >> 8)
        return 2
    }

    @OverflowWrapping
    public func writeBigEndian(buffer: Array<Byte>): Int64 {
        if (buffer.size < 2) {
            throw IndexOutOfBoundsException("Buffer size(${buffer.size}) is too small.")
        }
        buffer[0] = UInt8(this >> 8)
        buffer[1] = UInt8(this)
        return 2
    }

    @OverflowWrapping
    public static func readBigEndian(buffer: Array<UInt8>): UInt16 {
        if (buffer.size < 2) {
            throw IndexOutOfBoundsException("Buffer size(${buffer.size}) is too small.")
        }
        return UInt16(buffer[1]) | UInt16(buffer[0]) << 8
    }

    @OverflowWrapping
    public static func readLittleEndian(buffer: Array<UInt8>): UInt16 {
        if (buffer.size < 2) {
            throw IndexOutOfBoundsException("Buffer size(${buffer.size}) is too small.")
        }
        return UInt16(buffer[0]) | UInt16(buffer[1]) << 8
    }
    public func swapBytes(): UInt16 {
        return unsafe { CJ_Bswap16(this) }
    }
}

extend Int16 <: BigEndianOrder<Int16> & LittleEndianOrder<Int16> & SwapEndianOrder<Int16> {
    @OverflowWrapping
    public func writeLittleEndian(buffer: Array<Byte>): Int64 {
        UInt16(this).writeLittleEndian(buffer)
    }

    @OverflowWrapping
    public func writeBigEndian(buffer: Array<Byte>): Int64 {
        UInt16(this).writeBigEndian(buffer)
    }

    @OverflowWrapping
    public static func readBigEndian(buffer: Array<UInt8>): Int16 {
        if (buffer.size < 2) {
            throw IndexOutOfBoundsException("Buffer size(${buffer.size}) is too small.")
        }
        return Int16(buffer[1]) | Int16(buffer[0]) << 8
    }

    @OverflowWrapping
    public static func readLittleEndian(buffer: Array<UInt8>): Int16 {
        if (buffer.size < 2) {
            throw IndexOutOfBoundsException("Buffer size(${buffer.size}) is too small.")
        }
        return Int16(buffer[0]) | Int16(buffer[1]) << 8
    }

    @OverflowWrapping
    public func swapBytes(): Int16 {
        var reversed = UInt16(this).swapBytes()
        return Int16(reversed)
    }
}

extend UInt8 <: BigEndianOrder<UInt8> & LittleEndianOrder<UInt8> & SwapEndianOrder<UInt8> {
    public func writeLittleEndian(buffer: Array<Byte>): Int64 {
        buffer[0] = this
        return 1
    }
    public func writeBigEndian(buffer: Array<Byte>): Int64 {
        buffer[0] = this
        return 1
    }
    public static func readBigEndian(buffer: Array<UInt8>): UInt8 {
        buffer[0]
    }
    public static func readLittleEndian(buffer: Array<UInt8>): UInt8 {
        buffer[0]
    }

    public func swapBytes(): UInt8 {
        this
    }
}

extend Int8 <: BigEndianOrder<Int8> & LittleEndianOrder<Int8> & SwapEndianOrder<Int8> {
    @OverflowWrapping
    public func writeLittleEndian(buffer: Array<Byte>): Int64 {
        buffer[0] = UInt8(this)
        return 1
    }

    @OverflowWrapping
    public func writeBigEndian(buffer: Array<Byte>): Int64 {
        buffer[0] = UInt8(this)
        return 1
    }

    @OverflowWrapping
    public static func readBigEndian(buffer: Array<UInt8>): Int8 {
        Int8(buffer[0])
    }

    @OverflowWrapping
    public static func readLittleEndian(buffer: Array<UInt8>): Int8 {
        Int8(buffer[0])
    }

    public func swapBytes(): Int8 {
        this
    }
}

extend Float64 <: BigEndianOrder<Float64> & LittleEndianOrder<Float64> {
    public func writeLittleEndian(buffer: Array<Byte>): Int64 {
        let bits = this.toBits()
        bits.writeLittleEndian(buffer)
    }
    public func writeBigEndian(buffer: Array<Byte>): Int64 {
        let bits = this.toBits()
        bits.writeBigEndian(buffer)
    }

    public static func readBigEndian(buffer: Array<UInt8>): Float64 {
        let bits = UInt64.readBigEndian(buffer)
        return Float64.fromBits(bits)
    }

    public static func readLittleEndian(buffer: Array<UInt8>): Float64 {
        let bits = UInt64.readLittleEndian(buffer)
        return Float64.fromBits(bits)
    }
}

extend Float32 <: BigEndianOrder<Float32> & LittleEndianOrder<Float32> {
    public func writeLittleEndian(buffer: Array<Byte>): Int64 {
        let bits = this.toBits()
        bits.writeLittleEndian(buffer)
    }
    public func writeBigEndian(buffer: Array<Byte>): Int64 {
        let bits = this.toBits()
        bits.writeBigEndian(buffer)
    }

    public static func readBigEndian(buffer: Array<UInt8>): Float32 {
        let bits = UInt32.readBigEndian(buffer)
        return Float32.fromBits(bits)
    }

    public static func readLittleEndian(buffer: Array<UInt8>): Float32 {
        let bits = UInt32.readLittleEndian(buffer)
        return Float32.fromBits(bits)
    }
}

extend Float16 <: BigEndianOrder<Float16> & LittleEndianOrder<Float16> {
    public func writeLittleEndian(buffer: Array<Byte>): Int64 {
        let bits = this.toBits()
        bits.writeLittleEndian(buffer)
    }

    public func writeBigEndian(buffer: Array<Byte>): Int64 {
        let bits = this.toBits()
        bits.writeBigEndian(buffer)
    }

    public static func readBigEndian(buffer: Array<UInt8>): Float16 {
        let bits = UInt16.readBigEndian(buffer)
        return Float16.fromBits(bits)
    }

    public static func readLittleEndian(buffer: Array<UInt8>): Float16 {
        let bits = UInt16.readLittleEndian(buffer)
        return Float16.fromBits(bits)
    }
}

extend Bool <: BigEndianOrder<Bool> & LittleEndianOrder<Bool> {
    public func writeLittleEndian(buffer: Array<Byte>): Int64 {
        buffer[0] = if (this) {
            1
        } else {
            0
        }
        return 1
    }
    public func writeBigEndian(buffer: Array<Byte>): Int64 {
        buffer[0] = if (this) {
            1
        } else {
            0
        }
        return 1
    }
    public static func readBigEndian(buffer: Array<UInt8>): Bool {
        return buffer[0] != 0
    }
    public static func readLittleEndian(buffer: Array<UInt8>): Bool {
        return buffer[0] != 0
    }
}

foreign func CJ_Bswap64(n: UInt64): UInt64

foreign func CJ_Bswap32(n: UInt32): UInt32

foreign func CJ_Bswap16(n: UInt16): UInt16
