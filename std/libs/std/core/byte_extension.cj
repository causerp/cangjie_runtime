/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */

package std.core

const ASCII_UPPER_TO_LOWER_DIFF: UInt8 = 0x20

extend Byte {
    /**
     * Returns true if this Byte is in Ascii letter range.
     */
    public func isAsciiLetter(): Bool {
        return (this >= b'A' && this <= b'Z') || (this >= b'a' && this <=
            b'z')
    }

    /**
     * Returns true if this this Byte is in Ascii number range.
     */
    public func isAsciiNumber(): Bool {
        return this >= b'0' && this <= b'9'
    }

    /**
     * Returns true if this this Byte is in Ascii hexadecimal range.
     */
    public func isAsciiHex(): Bool {
        return this.isAsciiNumber() || (this >= b'a' && this <= b'f') || (this >= b'A' &&
            this <= b'F')
    }

    /**
     * Returns true if this Byte is in ASCII octal digit range.
     */
    public func isAsciiOct(): Bool {
        return this >= b'0' && this <= b'7'
    }

    /**
     * Return true if this Byte is in ASCII punctuation range.
     */
    public func isAsciiPunctuation(): Bool {
        return (this >= b'!' && this <= b'/') || (this >= b':' && this <= b'@') ||
               (this >= b'[' && this <= b'`') || (this >= b'{' && this <= b'~')
    }

    /**
     * Return true if this Byte is in ASCII graphic character range.
     */
    public func isAsciiGraphic(): Bool {
        return this >= b'!' && this <= b'~'
    }

    /**
     * Return true if this Byte is in ASCII control character range.
     */
    public func isAsciiControl(): Bool {
        return this <= 0x1F || this == 0x7F
    }

    /**
     * Return true if this Byte is in ASCII number or letter range.
     */
    public func isAsciiNumberOrLetter(): Bool {
        return this.isAsciiLetter() || this.isAsciiNumber()
    }

    /** Returns true if this Byte is in Lowercase Ascii letter range. */
    public func isAsciiLowerCase(): Bool {
        return this >= b'a' && this <= b'z'
    }

    /** Returns true if this Byte is in Uppercase Ascii letter range. */
    public func isAsciiUpperCase(): Bool {
        return this >= b'A' && this <= b'Z'
    }

    /** Returns true if this Byte is in Ascii range. */
    public func isAscii(): Bool {
        return this <= 0x7F
    }

    /** 
     * Returns true if this Byte is whitespace.
     * whitespace include HT, LF, VT, FF, CR, SP
     */
    public func isAsciiWhiteSpace(): Bool {
        return (this >= 0x09 && this <= 0x0D) || this == 0x20
    }

    /** Returns the uppercase of this Byte. */
    public func toAsciiUpperCase(): Byte {
        return if (this.isAsciiLowerCase()) {
            this - ASCII_UPPER_TO_LOWER_DIFF
        } else {
            this
        }
    }

    /** Returns the lowercase of this Byte. */
    public func toAsciiLowerCase(): Byte {
        return if (this.isAsciiUpperCase()) {
            this + ASCII_UPPER_TO_LOWER_DIFF
        } else {
            this
        }
    }
}
