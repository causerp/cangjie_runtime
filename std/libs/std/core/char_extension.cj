/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.core

extend Rune {
    /**
     * Returns true if this Unicode character is an Ascii letter.
     */
    public func isAsciiLetter(): Bool {
        return (this >= r'A' && this <= r'Z') || (this >= r'a' && this <= r'z')
    }

    /**
     * Returns true if this Unicode character is an Ascii number.
     */
    public func isAsciiNumber(): Bool {
        return this >= r'0' && this <= r'9'
    }

    /**
     * Returns true if this this Rune is an Ascii hexadecimal number.
     */
    public func isAsciiHex(): Bool {
        return this.isAsciiNumber() || (this >= r'a' && this <= r'f') || (this >= r'A' && this <= r'F')
    }

    /**
     * Returns true if this Rune is an ASCII octal number.
     */
    public func isAsciiOct(): Bool {
        return this >= r'0' && this <= r'7'
    }

    /**
     * Return true if this Rune is an ASCII punctuation.
     */
    public func isAsciiPunctuation(): Bool {
        return (this >= r'!' && this <= r'/') || (this >= r':' && this <= r'@') || (this >= r'[' && this <= r'`') || (this >=
            r'{' && this <= r'~')
    }

    /**
     * Return true if this Rune is an ASCII graphic character.
     */
    public func isAsciiGraphic(): Bool {
        return this >= r'!' && this <= r'~'
    }

    /**
     * Return true if this Rune is an ASCII control character.
     */
    public func isAsciiControl(): Bool {
        return (this >= r'\u{0000}' && this <= r'\u{001F}') || this == r'\u{007F}'
    }

    /**
     * Return true if this Rune is an ASCII number or ASCII letter.
     */
    public func isAsciiNumberOrLetter(): Bool {
        return this.isAsciiLetter() || this.isAsciiNumber()
    }

    /** Returns true if this Unicode character is Lowercase. */
    public func isAsciiLowerCase(): Bool {
        return this >= r'a' && this <= r'z'
    }

    /** Returns true if this Unicode character is Uppercase. */
    public func isAsciiUpperCase(): Bool {
        return this >= r'A' && this <= r'Z'
    }

    /** Returns true if this Unicode character is an Ascii code. */
    public func isAscii(): Bool {
        return this >= r'\u{0000}' && this <= r'\u{007F}'
    }

    /** Returns true if this Unicode character is whitespace. */
    public func isAsciiWhiteSpace(): Bool {
        return (this >= r'\u{0009}' && this <= r'\u{000D}') || this == r'\u{0020}'
    }

    /** Returns the uppercase of this Unicode character. */
    public func toAsciiUpperCase(): Rune {
        return if (this.isAsciiLowerCase()) {
            Rune(UInt32(this) - UInt32(ASCII_UPPER_TO_LOWER_DIFF))
        } else {
            this
        }
    }

    /** Returns the lowercase of this Unicode character. */
    public func toAsciiLowerCase(): Rune {
        return if (this.isAsciiUpperCase()) {
            Rune(UInt32(this) + UInt32(ASCII_UPPER_TO_LOWER_DIFF))
        } else {
            this
        }
    }

    /*
     * @throws IllegalArgumentException if `arr[index]` is an invalid utf8 leading code or
     *         there is no valid utf8 code among `arr[0] ~ arr[index - 1]`.
     */
    public static func utf8Size(arr: Array<UInt8>, index: Int64): Int64 {
        if (index >= arr.size) {
            throw IllegalArgumentException("Invalid utf8 byte sequence.")
        }
        let byte = arr[index]
        // fast path for ASCII
        if (byte < HIGH_1_UInt8) {
            return 1
        }
        // 0b_10xx_xxxx is not a Unicode Code Point's boundary, throw exception in this case
        if (byte < HIGH_2_UInt8) {
            var (char, _) = getPreviousFromUtf8(arr, index)
            throw IllegalArgumentException("Byte index ${index} is not a Rune boundary, it is inside '${char}'.")
        }
        // 0b_1111_11xx is invalid UTF-8 sequence
        if (byte >= HIGH_6_UInt8) {
            throw IllegalArgumentException("Invalid UTF-8 character.")
        }
        return utf8SizeUnchecked(byte)
    }

    // Considering the performance，this function do not check the parameters.
    // The parameter should only be the boundary of Unicode Code Point,
    // i.e. the parameter could not start with 0b10.
    static func utf8SizeUnchecked(byte: Byte): Int64 {
        return match {
            case byte < HIGH_1_UInt8 => 1
            case byte < HIGH_3_UInt8 => 2
            case byte < HIGH_4_UInt8 => 3
            case byte < HIGH_5_UInt8 => 4
            case byte < HIGH_6_UInt8 => 5
            case _ => 6
        }
    }

    @OverflowWrapping
    public static func utf8Size(c: Rune): Int64 {
        var ch = UInt32(c)
        match {
            case ch <= UTF8_1_MAX => 1
            case ch <= UTF8_2_MAX => 2
            case ch <= UTF8_3_MAX => 3
            case ch <= UTF8_4_MAX => 4
            case ch <= UTF8_5_MAX => 5
            case _ => 6
        }
    }

    /*
     * @throws IllegalArgumentException if arr[index] is an invalid utf8 code or
     * there is no valid utf8 code among arr[0] ~ arr[index - 1].
     */
    @OverflowWrapping
    public static func fromUtf8(arr: Array<UInt8>, index: Int64): (Rune, Int64) {
        if (index >= arr.size) {
            throw IllegalArgumentException("Invalid utf8 byte sequence.")
        }
        return fromUtf8(arr.rawptr, arr.start + index, arr.start + arr.len)
    }

    static func fromUtf8(arr: RawArray<UInt8>, startIndex: Int64, endIndex: Int64): (Rune, Int64) {
        let byte0: UInt8 = arrayGetUnchecked(arr, startIndex)
        return match {
            case byte0 < HIGH_1_UInt8 => (Rune(byte0), 1)
            case byte0 < HIGH_2_UInt8 => throw IllegalArgumentException("Invalid utf8 byte sequence.")
            case byte0 < HIGH_3_UInt8 => (checkUtf8Of2Bytes(arr, startIndex, endIndex), 2)
            case byte0 < HIGH_4_UInt8 => (checkUtf8Of3Bytes(arr, startIndex, endIndex), 3)
            case byte0 < HIGH_5_UInt8 => (checkUtf8Of4Bytes(arr, startIndex, endIndex), 4)
            case _ => throw IllegalArgumentException("Invalid unicode scalar value.")
        }
    }

    /*
     * @throws IllegalArgumentException if there is no valid utf8 code
     *         among `arr[0] ~ arr[index - 1]`.
     */
    @OverflowWrapping
    public static func getPreviousFromUtf8(arr: Array<UInt8>, index: Int64): (Rune, Int64) {
        var i: Int64 = index - 1
        var nowByte: UInt8
        var res: (Rune, Int64) = (r'\0', -1)
        while (i >= 0) {
            nowByte = arr[i]
            if (nowByte >= HIGH_1_UInt8 && nowByte < HIGH_2_UInt8) {
                i--
                continue
            } else {
                res = fromUtf8(arr, i)
                break
            }
        }
        if (res[0] == r'\0' && res[1] == -1) {
            throw IllegalArgumentException("Invalid utf8 byte sequence.")
        }
        return res
    }

    /*
     * @throws IllegalArgumentException if the character occupies a position beyond the array range
     */
    @OverflowWrapping
    public static func intoUtf8Array(c: Rune, arr: Array<UInt8>, index: Int64): Int64 {
        var ch = UInt32(c)
        checkIndexValid(c, arr, index)
        if (ch <= UTF8_1_MAX) {
            arr[index] = UInt8(ch)
            return 1
        } else if (ch <= UTF8_2_MAX) {
            arr[index] = UInt8(((ch >> SHIFT_6) & LOW_5_MASK) | HIGH_2_MASK)
            arr[index + 1] = UInt8(((ch) & LOW_6_MASK) | HIGH_1_MASK)
            return 2
        } else if (ch <= UTF8_3_MAX) {
            arr[index] = UInt8(((ch >> SHIFT_12) & LOW_4_MASK) | HIGH_3_MASK)
            arr[index + 1] = UInt8(((ch >> SHIFT_6) & LOW_6_MASK) | HIGH_1_MASK)
            arr[index + 2] = UInt8((ch & LOW_6_MASK) | HIGH_1_MASK)
            return 3
        } else if (ch <= UTF8_4_MAX) {
            arr[index] = UInt8(((ch >> SHIFT_18) & LOW_3_MASK) | HIGH_4_MASK)
            arr[index + 1] = UInt8(((ch >> SHIFT_12) & LOW_6_MASK) | HIGH_1_MASK)
            arr[index + 2] = UInt8(((ch >> SHIFT_6) & LOW_6_MASK) | HIGH_1_MASK)
            arr[index + 3] = UInt8((ch & LOW_6_MASK) | HIGH_1_MASK)
            return 4
        } else if (ch <= UTF8_5_MAX) {
            arr[index] = UInt8(((ch >> SHIFT_24) & LOW_2_MASK) | HIGH_5_MASK)
            arr[index + 1] = UInt8(((ch >> SHIFT_18) & LOW_6_MASK) | HIGH_1_MASK)
            arr[index + 2] = UInt8(((ch >> SHIFT_12) & LOW_6_MASK) | HIGH_1_MASK)
            arr[index + 3] = UInt8(((ch >> SHIFT_6) & LOW_6_MASK) | HIGH_1_MASK)
            arr[index + 4] = UInt8((ch & LOW_6_MASK) | HIGH_1_MASK)
            return 5
        } else {
            arr[index] = UInt8(((ch >> SHIFT_30) & LOW_1_MASK) | HIGH_6_MASK)
            arr[index + 1] = UInt8(((ch >> SHIFT_24) & LOW_6_MASK) | HIGH_1_MASK)
            arr[index + 2] = UInt8(((ch >> SHIFT_18) & LOW_6_MASK) | HIGH_1_MASK)
            arr[index + 3] = UInt8(((ch >> SHIFT_12) & LOW_6_MASK) | HIGH_1_MASK)
            arr[index + 4] = UInt8(((ch >> SHIFT_6) & LOW_6_MASK) | HIGH_1_MASK)
            arr[index + 5] = UInt8((ch & LOW_6_MASK) | HIGH_1_MASK)
            return 6
        }
    }

    /*
     * @throws IllegalArgumentException if the character occupies a position beyond the array range
     */
    private static func checkIndexValid(c: Rune, arr: Array<UInt8>, index: Int64): Unit {
        if (index < 0) {
            throw IllegalArgumentException("The index cannot be less than 0.")
        }
        let ch = UInt32(c)
        let arrSize = arr.size
        let lengthOfCharBytes = if (ch <= UTF8_1_MAX) {
            1
        } else if (ch <= UTF8_2_MAX) {
            2
        } else if (ch <= UTF8_3_MAX) {
            3
        } else if (ch <= UTF8_4_MAX) {
            4
        } else if (ch <= UTF8_5_MAX) {
            5
        } else {
            6
        }
        if (lengthOfCharBytes + index > arrSize) {
            throw IllegalArgumentException(
                "The bytecode position occupied by this character is outside the range of the array.")
        }
    }
}

extend Rune <: Comparable<Rune> {
    /**
     * Compare the relationship between two instance of Rune.
     *
     * @param rhs Instance of Rune compared with this.
     * @return Value indicating the relationship between two instance of Rune.
     *
     * @since 0.27.3
     */
    public func compare(rhs: Rune): Ordering {
        match {
            case this < rhs => Ordering.LT
            case this > rhs => Ordering.GT
            case _ => Ordering.EQ
        }
    }
}
